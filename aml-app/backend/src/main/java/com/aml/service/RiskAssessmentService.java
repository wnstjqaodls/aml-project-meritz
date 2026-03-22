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
        params.put("custNo",  custNo);
        params.put("raGrd",   raGrd);
        params.put("eddYn",   eddYn);
        params.put("size",    size);
        params.put("offset",  offset);

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
     * 고객 위험평가 실행.
     *
     * - 활성 RA 항목: raMapper.findActiveItems() (USE_YN='Y', SRT_SQ 정렬)
     * - 가중치: raMapper.findItemWeights(raMdlGbnCd) — RA_ITEM_WGHT 테이블 별도 관리
     * - 결측값 처리: KYC/고객 정보가 없을 때 item.getMissValScr() 사용
     * - 점수 계산: rawScore × (wght/100)
     * - EDD 강제 고위험: customer.eddYn='Y' 이면 등급 강제 'H'
     *
     * 항목별 채점 기준 (REFF_COMN_CD 연계):
     *   I001 (국가위험): 제재국 → maxScr, 외국인 → maxScr×0.6, 내국인 → 5
     *   I002 (직업/자금원): OTHER/INHERIT → maxScr, BUSINESS → maxScr×0.5, INVEST → 8, 기타 → 3
     *   I003 (거래위험): 기존 riskScr 기반 프록시
     *   I004 (PEP): pepYn='Y' → maxScr, 아니면 → missValScr(=0)
     *   I005 (실소유자): beneficialYn='Y' → maxScr, 아니면 → missValScr(=0)
     *   I006 (고객유형): FORE → maxScr, CORP → maxScr×0.75, 기타 → 5
     */
    @Transactional
    public RaResult evaluate(String custNo, String userId) {
        Customer customer = customerMapper.findById(custNo);
        if (customer == null) {
            throw new IllegalArgumentException("고객을 찾을 수 없습니다: " + custNo);
        }

        // 활성 항목 로드 (USE_YN='Y', SRT_SQ 정렬)
        List<RaItem> items = raMapper.findActiveItems();

        // 가중치 로드 — 고객유형에 따른 모델 구분 코드 결정
        // CORP=법인, FORE=외국인, INDV=개인 → 모델코드로 매핑
        String raMdlGbnCd = resolveModelCode(customer.getCustTpCd());
        List<Map<String, Object>> weightRows = raMapper.findItemWeights(raMdlGbnCd);
        Map<String, BigDecimal[]> weightMap = buildWeightMap(weightRows);

        List<KycRecord> kycRecords = kycMapper.findByCustNo(custNo);
        KycRecord latestKyc = kycRecords.isEmpty() ? null : kycRecords.get(0);

        String today      = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String nextEvalDt = LocalDate.now().plusYears(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        RaResult result = new RaResult();
        result.setCustNo(custNo);
        result.setEvalDt(today);
        result.setNextEvalDt(nextEvalDt);
        result.setRegId(userId);

        // 레코드 선행 INSERT (FK 참조를 위해 raId 확보)
        raMapper.insertResult(result);

        BigDecimal totalWeightedScore = BigDecimal.ZERO;
        boolean forceHigh = "Y".equals(customer.getEddYn());

        for (RaItem item : items) {
            // 가중치/maxScr: RA_ITEM_WGHT 우선, 없으면 missValScr로 폴백
            BigDecimal[] wm = weightMap.get(item.getRaItemCd());
            BigDecimal wght   = (wm != null) ? wm[0] : BigDecimal.ZERO;
            BigDecimal maxScr = (wm != null) ? wm[1] : BigDecimal.ZERO;

            BigDecimal rawScore = scoreItem(item, maxScr, customer, latestKyc);
            // 점수 계산: rawScore × (wght/100)
            BigDecimal weightedScore = rawScore
                    .multiply(wght)
                    .divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

            totalWeightedScore = totalWeightedScore.add(weightedScore);

            RaResultDetail detail = new RaResultDetail();
            detail.setRaId(result.getRaId());
            detail.setRaItemCd(item.getRaItemCd());
            detail.setItemVal(getItemValue(item, customer, latestKyc));
            detail.setItemScr(rawScore);
            detail.setItemWght(wght);
            detail.setItemLstScr(weightedScore);
            raMapper.insertResultDetail(detail);
        }

        // 등급 결정
        String grade;
        String eddYn;
        String remark;

        if (forceHigh) {
            grade  = "H";
            eddYn  = "Y";
            remark = "EDD 대상 고객으로 고위험 강제 부여";
        } else {
            grade = raMapper.findGradeByScore(totalWeightedScore);
            if (grade == null) {
                grade = "L"; // fallback
            }
            eddYn  = "H".equals(grade) ? "Y" : "N";
            remark = String.format("자동 평가 완료. 총점: %.2f", totalWeightedScore.doubleValue());
        }

        result.setRaScr(totalWeightedScore);
        result.setRaGrd(grade);
        result.setEddYn(eddYn);
        result.setRemark(remark);

        // RA_RESULT 점수/등급 업데이트
        raMapper.updateResultScores(result);

        // 고객 위험정보 업데이트
        customerMapper.updateRiskInfo(custNo, grade, totalWeightedScore, eddYn, userId);

        log.info("RA evaluation completed for {}: grade={}, score={}, model={}",
                custNo, grade, totalWeightedScore, raMdlGbnCd);
        return raMapper.findResultById(result.getRaId());
    }

    /**
     * 고객유형 코드 → RA 위험평가모델 구분코드 변환.
     * 실제 코드체계가 확정되면 NIC92B 공통코드 연동으로 교체 가능.
     */
    private String resolveModelCode(String custTpCd) {
        if ("CORP".equals(custTpCd)) {
            return "CORP";
        } else if ("FORE".equals(custTpCd)) {
            return "FORE";
        }
        return "INDV"; // 개인 기본
    }

    /**
     * RA_ITEM_WGHT 조회 결과 → Map<raItemCd, [wght, maxScr]> 변환.
     */
    private Map<String, BigDecimal[]> buildWeightMap(List<Map<String, Object>> weightRows) {
        Map<String, BigDecimal[]> map = new HashMap<>();
        for (Map<String, Object> row : weightRows) {
            String itemCd = (String) row.get("RA_ITEM_CD");
            BigDecimal wght   = toBigDecimal(row.get("WGHT"));
            BigDecimal maxScr = toBigDecimal(row.get("MAX_SCR"));
            map.put(itemCd, new BigDecimal[]{ wght, maxScr });
        }
        return map;
    }

    private BigDecimal toBigDecimal(Object val) {
        if (val == null) return BigDecimal.ZERO;
        if (val instanceof BigDecimal) return (BigDecimal) val;
        if (val instanceof Number) return BigDecimal.valueOf(((Number) val).doubleValue());
        try {
            return new BigDecimal(val.toString());
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }

    /**
     * 단일 RA 항목 채점.
     * KYC/고객 정보가 없을 때(결측) item.getMissValScr() 반환.
     */
    private BigDecimal scoreItem(RaItem item, BigDecimal maxScr,
                                 Customer customer, KycRecord kyc) {
        BigDecimal missVal = item.getMissValScr() != null
                ? item.getMissValScr() : BigDecimal.ZERO;

        switch (item.getRaItemCd()) {
            case "I001": { // 국가위험
                String natCd = customer.getNatCd();
                if (natCd == null) return missVal;
                if ("IR".equals(natCd) || "KP".equals(natCd)
                        || "SY".equals(natCd) || "CU".equals(natCd)) {
                    return maxScr; // 제재국 최고위험
                }
                if (!"KR".equals(natCd)) {
                    return maxScr.multiply(BigDecimal.valueOf(0.6))
                            .setScale(2, RoundingMode.HALF_UP);
                }
                return BigDecimal.valueOf(5); // 내국인
            }

            case "I002": { // 직업/자금원
                if (kyc == null || kyc.getFundSrcCd() == null) return missVal;
                switch (kyc.getFundSrcCd()) {
                    case "OTHER":
                    case "INHERIT":
                        return maxScr;
                    case "BUSINESS":
                        return maxScr.multiply(BigDecimal.valueOf(0.5))
                                .setScale(2, RoundingMode.HALF_UP);
                    case "INVEST":
                        return BigDecimal.valueOf(8);
                    default:
                        return BigDecimal.valueOf(3);
                }
            }

            case "I003": { // 거래위험
                if (customer.getRiskScr() == null) return missVal;
                if (customer.getRiskScr().compareTo(BigDecimal.valueOf(70)) >= 0) {
                    return maxScr;
                } else if (customer.getRiskScr().compareTo(BigDecimal.valueOf(40)) >= 0) {
                    return maxScr.multiply(BigDecimal.valueOf(0.5))
                            .setScale(2, RoundingMode.HALF_UP);
                }
                return BigDecimal.valueOf(5);
            }

            case "I004": { // PEP
                if (kyc == null) return missVal;
                return "Y".equals(kyc.getPepYn()) ? maxScr : missVal;
            }

            case "I005": { // 실소유자
                if (kyc == null) return missVal;
                return "Y".equals(kyc.getBeneficialYn()) ? maxScr : missVal;
            }

            case "I006": { // 고객유형
                String custTpCd = customer.getCustTpCd();
                if (custTpCd == null) return missVal;
                if ("FORE".equals(custTpCd)) return maxScr;
                if ("CORP".equals(custTpCd)) {
                    return maxScr.multiply(BigDecimal.valueOf(0.75))
                            .setScale(2, RoundingMode.HALF_UP);
                }
                return BigDecimal.valueOf(5); // 개인
            }

            default:
                return missVal;
        }
    }

    private String getItemValue(RaItem item, Customer customer, KycRecord kyc) {
        switch (item.getRaItemCd()) {
            case "I001":
                return customer.getNatCd() != null ? customer.getNatCd() : "KR";
            case "I002":
                return (kyc != null && kyc.getFundSrcCd() != null)
                        ? kyc.getFundSrcCd() : "UNKNOWN";
            case "I003":
                return customer.getRiskScr() != null
                        ? customer.getRiskScr().toPlainString() : "0";
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
}
