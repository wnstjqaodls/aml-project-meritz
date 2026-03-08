package com.aml.service;

import com.aml.mapper.BatchSimulatorMapper;
import com.aml.mapper.CustomerMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class BatchSimulatorService {

    private final BatchSimulatorMapper batchSimulatorMapper;
    private final CustomerMapper customerMapper;

    private static final String[] BRANCHES = {
            "BR001|Seoul Branch", "BR002|Gangnam Branch",
            "BR003|Gangbuk Branch", "BR004|Seocho Branch",
            "BR005|Mapo Branch",   "BR006|Itaewon Branch"
    };

    private static final String[] CHANNELS = {"BRANCH", "ONLINE", "MOBILE", "ATM"};
    private static final String[] TXN_TYPES = {"W", "T", "P"};

    private static final String[] ACCOUNT_SUFFIXES = {
            "1001-001-123456", "1001-002-234567", "1001-003-345678",
            "1001-004-456789", "1001-005-567890", "2002-001-456789",
            "2002-002-567890"
    };

    private final Random rng = new Random();

    @Transactional
    public Map<String, Object> simulate(int count) {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        List<String> customers = batchSimulatorMapper.findRandomCustomers(20);
        List<String> scenarios = batchSimulatorMapper.findRandomScenarios(10);

        if (customers.isEmpty()) {
            throw new IllegalStateException("NIC01B에 고객 데이터가 없습니다.");
        }
        if (scenarios.isEmpty()) {
            throw new IllegalStateException("TMS_APPL에 시나리오 데이터가 없습니다.");
        }

        int strCreated = 0;
        int ctrCreated = 0;
        int skipped = 0;

        // 현재 오늘 날짜 기준 STR/CTR 시퀀스 시작값 계산
        long strBaseSeq = batchSimulatorMapper.countCasesForDate(today, "STR") + 1;
        long ctrBaseSeq = batchSimulatorMapper.countCasesForDate(today, "CTR") + 1;

        for (int i = 0; i < count; i++) {
            boolean isStr = (i % 3 != 2); // 2:1 비율로 STR:CTR
            String caseType = isStr ? "STR" : "CTR";
            String rnmcno = customers.get(rng.nextInt(customers.size()));
            String scnrId = scenarios.get(rng.nextInt(scenarios.size()));

            long seq = isStr ? strBaseSeq++ : ctrBaseSeq++;
            String sspsDlId = String.format("%s%s%03d", caseType, today, seq);

            // 중복 케이스 체크
            if (batchSimulatorMapper.countExistingCase(today, sspsDlId) > 0) {
                log.warn("Duplicate case skipped: {}/{}", today, sspsDlId);
                skipped++;
                continue;
            }

            // 리스크 등급 랜덤
            String[] grades = {"H", "H", "M", "M", "L"};
            String rskGrdCd = grades[rng.nextInt(grades.length)];
            double rskMrk = switch (rskGrdCd) {
                case "H" -> 70 + rng.nextDouble() * 30;
                case "M" -> 40 + rng.nextDouble() * 30;
                default  -> 10 + rng.nextDouble() * 30;
            };
            double scnrMrk = Math.min(100.0, rskMrk + rng.nextDouble() * 10);

            // NIC66B 삽입
            Map<String, Object> caseParams = new HashMap<>();
            caseParams.put("sspsDlCrtDt",  today);
            caseParams.put("sspsDlId",     sspsDlId);
            caseParams.put("sspsTYpCd",    scnrId);
            caseParams.put("sspsDlCrtCcd", caseType);
            caseParams.put("dlPRnmcno",    rnmcno);
            caseParams.put("rskMrk",       Math.round(rskMrk * 10.0) / 10.0);
            caseParams.put("rskGrdCd",     rskGrdCd);
            caseParams.put("scnrMrk",      Math.round(scnrMrk * 10.0) / 10.0);
            caseParams.put("aiResult",     "BATCH_SIM");
            caseParams.put("regId",        "batch");
            batchSimulatorMapper.insertNic66b(caseParams);

            // NIC70B 삽입 (당사자 — 없으면 삽입)
            if (batchSimulatorMapper.countExistingNic70b(today, rnmcno) == 0) {
                String custNm = resolveCustomerName(rnmcno);
                String indvCorpCcd = rnmcno.length() <= 10 ? "2" : "1";
                Map<String, Object> partyParams = new HashMap<>();
                partyParams.put("sspsDlCrtDt",   today);
                partyParams.put("dlPRnmcno",      rnmcno);
                partyParams.put("dlPNm",          custNm);
                partyParams.put("dlPRnmNoCcd",    indvCorpCcd.equals("1") ? "1" : "2");
                partyParams.put("indvCorpCcd",    indvCorpCcd);
                batchSimulatorMapper.insertNic70b(partyParams);
            }

            // NIC73B 거래내역 1~3건 삽입
            int txnCount = 1 + rng.nextInt(3);
            long totalAmt = 0;
            String branch = BRANCHES[rng.nextInt(BRANCHES.length)];
            String[] branchParts = branch.split("\\|");
            String acctNo = ACCOUNT_SUFFIXES[rng.nextInt(ACCOUNT_SUFFIXES.length)];

            for (int t = 1; t <= txnCount; t++) {
                long amt = (8_000_000L + (long)(rng.nextDouble() * 12_000_000L));
                // CTR은 무조건 10M 이상
                if ("CTR".equals(caseType)) {
                    amt = 10_000_000L + (long)(rng.nextDouble() * 15_000_000L);
                }
                totalAmt += amt;

                Map<String, Object> txnParams = new HashMap<>();
                txnParams.put("sspsDlCrtDt", today);
                txnParams.put("sspsDlId",    sspsDlId);
                txnParams.put("seqNo",       t);
                txnParams.put("mnDlBrnCd",   branchParts[0]);
                txnParams.put("mnDlBrnNm",   branchParts[1]);
                txnParams.put("dlDt",        today);
                txnParams.put("dlTm",        String.format("%02d%02d%02d",
                        8 + rng.nextInt(10), rng.nextInt(60), rng.nextInt(60)));
                txnParams.put("dlAmt",       amt);
                txnParams.put("dlTypCcd",    TXN_TYPES[rng.nextInt(TXN_TYPES.length)]);
                txnParams.put("chnlCcd",     CHANNELS[rng.nextInt(CHANNELS.length)]);
                batchSimulatorMapper.insertNic73b(txnParams);
            }

            // NIC75B 계좌별 총액 삽입
            Map<String, Object> amtParams = new HashMap<>();
            amtParams.put("sspsDlCrtDt", today);
            amtParams.put("sspsDlId",    sspsDlId);
            amtParams.put("gnlAcNo",     acctNo);
            amtParams.put("dlAmt",       totalAmt);
            batchSimulatorMapper.insertNic75b(amtParams);

            // NIC67B 빈 초안 보고서 삽입
            Map<String, Object> rptParams = new HashMap<>();
            rptParams.put("sspsDlCrtDt", today);
            rptParams.put("sspsDlId",    sspsDlId);
            rptParams.put("regId",       "batch");
            batchSimulatorMapper.insertNic67bDraft(rptParams);

            if (isStr) {
                strCreated++;
            } else {
                ctrCreated++;
            }
            log.info("Batch simulated case: type={}, id={}, rnmcno={}, totalAmt={}",
                    caseType, sspsDlId, rnmcno, totalAmt);
        }

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("date",       today);
        result.put("requested",  count);
        result.put("strCreated", strCreated);
        result.put("ctrCreated", ctrCreated);
        result.put("skipped",    skipped);
        result.put("total",      strCreated + ctrCreated);
        return result;
    }

    private String resolveCustomerName(String rnmcno) {
        try {
            var cust = customerMapper.findById(rnmcno);
            if (cust != null && cust.getCustNm() != null) {
                return cust.getCustNm();
            }
        } catch (Exception e) {
            log.debug("Customer lookup failed for {}: {}", rnmcno, e.getMessage());
        }
        return "CUST_" + rnmcno.substring(Math.max(0, rnmcno.length() - 4));
    }
}
