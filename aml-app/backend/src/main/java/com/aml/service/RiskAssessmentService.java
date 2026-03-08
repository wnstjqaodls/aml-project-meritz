package com.aml.service;

import com.aml.domain.Customer;
import com.aml.domain.KycRecord;
import com.aml.domain.RaItem;
import com.aml.domain.RaResult;
import com.aml.domain.RaResultDetail;
import com.aml.mapper.CustomerMapper;
import com.aml.mapper.KycMapper;
import com.aml.mapper.RaMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aml.common.PageResult;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class RiskAssessmentService {

    private final RaMapper raMapper;
    private final CustomerMapper customerMapper;
    private final KycMapper kycMapper;

    @Transactional(readOnly = true)
    public List<RaItem> getItems() {
        return raMapper.findAllItems();
    }

    @Transactional(readOnly = true)
    public PageResult<RaResult> searchResults(String custNo, String raGrd, String eddYn,
                                               int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("custNo", custNo);
        params.put("raGrd", raGrd);
        params.put("eddYn", eddYn);
        params.put("size", size);
        params.put("offset", offset);

        List<RaResult> content = raMapper.findResultByParams(params);
        long total = raMapper.countResultByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public RaResult getLatestResult(String custNo) {
        return raMapper.findLatestResultByCustNo(custNo);
    }

    @Transactional(readOnly = true)
    public List<RaResultDetail> getResultDetails(Long raId) {
        return raMapper.findDetailsByRaId(raId);
    }

    /**
     * Evaluate risk for a customer.
     *
     * Scoring rules per item type:
     *   I001 (COUNTRY): nat_cd != 'KR' → 30 (max); 'KR' → 5
     *   I002 (OCCUPATION): determined from KYC fund_src_cd; OTHER/INHERIT → 20; BUSINESS → 10; SALARY → 5
     *   I003 (TRANSACTION): based on customer's transaction history (approximated via risk_scr if set)
     *   I004 (PEP): pep_yn='Y' from latest KYC → 30; else 0
     *   I005 (BENEFICIAL): beneficial_yn='Y' from latest KYC → 20; else 0
     *   I006 (CUST_TYPE): CORP → 15; FORE → 20; INDV → 5
     *
     * If edd_yn='Y' on customer → force grade to 'H' and add a note.
     * Weighted sum: sum(item_scr * wght) for all items.
     * Grade lookup from ra_grd_std.
     */
    @Transactional
    public RaResult evaluate(String custNo, String userId) {
        Customer customer = customerMapper.findById(custNo);
        if (customer == null) {
            throw new IllegalArgumentException("고객을 찾을 수 없습니다: " + custNo);
        }

        List<RaItem> items = raMapper.findActiveItems();
        List<KycRecord> kycRecords = kycMapper.findByCustNo(custNo);
        KycRecord latestKyc = kycRecords.isEmpty() ? null : kycRecords.get(0);

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String nextEvalDt = LocalDate.now().plusYears(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        RaResult result = new RaResult();
        result.setCustNo(custNo);
        result.setEvalDt(today);
        result.setNextEvalDt(nextEvalDt);
        result.setRegId(userId);

        // Calculate weighted score
        BigDecimal totalWeightedScore = BigDecimal.ZERO;
        boolean forceHigh = "Y".equals(customer.getEddYn());

        raMapper.insertResult(result);

        for (RaItem item : items) {
            BigDecimal rawScore = scoreItem(item, customer, latestKyc);
            BigDecimal weight = item.getWght();
            BigDecimal weightedScore = rawScore.multiply(weight).setScale(2, RoundingMode.HALF_UP);

            totalWeightedScore = totalWeightedScore.add(weightedScore);

            RaResultDetail detail = new RaResultDetail();
            detail.setRaId(result.getRaId());
            detail.setRaItemCd(item.getRaItemCd());
            detail.setItemVal(getItemValue(item, customer, latestKyc));
            detail.setItemScr(rawScore);
            detail.setItemWght(weight);
            detail.setItemLstScr(weightedScore);
            raMapper.insertResultDetail(detail);
        }

        // Determine grade
        String grade;
        String eddYn;
        String remark;

        if (forceHigh) {
            grade = "H";
            eddYn = "Y";
            remark = "EDD 대상 고객으로 고위험 강제 부여";
        } else {
            grade = raMapper.findGradeByScore(totalWeightedScore);
            if (grade == null) {
                grade = "L"; // fallback
            }
            eddYn = "H".equals(grade) ? "Y" : "N";
            remark = String.format("자동 평가 완료. 총점: %.2f", totalWeightedScore.doubleValue());
        }

        result.setRaScr(totalWeightedScore);
        result.setRaGrd(grade);
        result.setEddYn(eddYn);
        result.setRemark(remark);

        // Update the result record with scores and grade (re-insert with correct values)
        // Since the record was inserted first for FK, we update the fields now
        updateRaResultScores(result);

        // Update customer risk info
        customerMapper.updateRiskInfo(custNo, grade, totalWeightedScore, eddYn, userId);

        log.info("RA evaluation completed for {}: grade={}, score={}", custNo, grade, totalWeightedScore);
        return raMapper.findResultById(result.getRaId());
    }

    /**
     * Score a single RA item for the given customer and KYC record.
     */
    private BigDecimal scoreItem(RaItem item, Customer customer, KycRecord kyc) {
        switch (item.getRaItemCd()) {
            case "I001": // Country risk
                if (!"KR".equals(customer.getNatCd())) {
                    // High-risk countries
                    String natCd = customer.getNatCd();
                    if ("IR".equals(natCd) || "KP".equals(natCd) || "SY".equals(natCd) || "CU".equals(natCd)) {
                        return item.getMaxScr(); // 30
                    }
                    // Other foreign nationals
                    return item.getMaxScr().multiply(BigDecimal.valueOf(0.6)).setScale(2, RoundingMode.HALF_UP);
                }
                return BigDecimal.valueOf(5);

            case "I002": // Occupation/fund source
                if (kyc != null && kyc.getFundSrcCd() != null) {
                    switch (kyc.getFundSrcCd()) {
                        case "OTHER":
                        case "INHERIT":
                            return item.getMaxScr(); // 20
                        case "BUSINESS":
                            return item.getMaxScr().multiply(BigDecimal.valueOf(0.5)).setScale(2, RoundingMode.HALF_UP);
                        case "INVEST":
                            return BigDecimal.valueOf(8);
                        default:
                            return BigDecimal.valueOf(3);
                    }
                }
                return BigDecimal.valueOf(10); // Unknown = medium

            case "I003": // Transaction amount risk
                // Use existing risk score as proxy, or default medium
                if (customer.getRiskScr() != null && customer.getRiskScr().compareTo(BigDecimal.valueOf(70)) >= 0) {
                    return item.getMaxScr(); // 25
                } else if (customer.getRiskScr() != null && customer.getRiskScr().compareTo(BigDecimal.valueOf(40)) >= 0) {
                    return item.getMaxScr().multiply(BigDecimal.valueOf(0.5)).setScale(2, RoundingMode.HALF_UP);
                }
                return BigDecimal.valueOf(5);

            case "I004": // PEP
                if (kyc != null && "Y".equals(kyc.getPepYn())) {
                    return item.getMaxScr(); // 30
                }
                return BigDecimal.ZERO;

            case "I005": // Beneficial owner
                if (kyc != null && "Y".equals(kyc.getBeneficialYn())) {
                    return item.getMaxScr(); // 20
                }
                return BigDecimal.ZERO;

            case "I006": // Customer type
                if ("FORE".equals(customer.getCustTpCd())) {
                    return item.getMaxScr(); // 20
                } else if ("CORP".equals(customer.getCustTpCd())) {
                    return item.getMaxScr().multiply(BigDecimal.valueOf(0.75)).setScale(2, RoundingMode.HALF_UP);
                }
                return BigDecimal.valueOf(5); // Individual

            default:
                return BigDecimal.ZERO;
        }
    }

    private String getItemValue(RaItem item, Customer customer, KycRecord kyc) {
        switch (item.getRaItemCd()) {
            case "I001":
                return customer.getNatCd() != null ? customer.getNatCd() : "KR";
            case "I002":
                return kyc != null && kyc.getFundSrcCd() != null ? kyc.getFundSrcCd() : "UNKNOWN";
            case "I003":
                return customer.getRiskScr() != null ? customer.getRiskScr().toPlainString() : "0";
            case "I004":
                return kyc != null ? kyc.getPepYn() : "N";
            case "I005":
                return kyc != null ? kyc.getBeneficialYn() : "N";
            case "I006":
                return customer.getCustTpCd() != null ? customer.getCustTpCd() : "INDV";
            default:
                return "";
        }
    }

    /**
     * Update the ra_result row with the computed score and grade after detail rows are inserted.
     */
    private void updateRaResultScores(RaResult result) {
        raMapper.updateResultScores(result);
    }
}
