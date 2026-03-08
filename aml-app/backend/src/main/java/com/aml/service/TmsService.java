package com.aml.service;

import com.aml.common.PageResult;
import com.aml.domain.TmsAlert;
import com.aml.domain.TmsRule;
import com.aml.domain.Transaction;
import com.aml.mapper.TmsAlertMapper;
import com.aml.mapper.TmsRuleMapper;
import com.aml.mapper.TransactionMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class TmsService {

    private final TmsAlertMapper tmsAlertMapper;
    private final TmsRuleMapper tmsRuleMapper;
    private final TransactionMapper transactionMapper;

    @Transactional(readOnly = true)
    public PageResult<TmsAlert> searchAlerts(String alertStCd, String custNo,
                                              String alertDtFrom, String alertDtTo,
                                              int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("alertStCd", alertStCd);
        params.put("custNo", custNo);
        params.put("alertDtFrom", alertDtFrom);
        params.put("alertDtTo", alertDtTo);
        params.put("size", size);
        params.put("offset", offset);

        List<TmsAlert> content = tmsAlertMapper.findByParams(params);
        long total = tmsAlertMapper.countByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public TmsAlert getAlert(Long alertId) {
        TmsAlert alert = tmsAlertMapper.findById(alertId);
        if (alert == null) {
            throw new IllegalArgumentException("알람을 찾을 수 없습니다: " + alertId);
        }
        return alert;
    }

    @Transactional
    public TmsAlert updateAlert(Long alertId, TmsAlert update, String userId) {
        TmsAlert existing = tmsAlertMapper.findById(alertId);
        if (existing == null) {
            throw new IllegalArgumentException("알람을 찾을 수 없습니다: " + alertId);
        }
        if (update.getAlertStCd() != null) {
            existing.setAlertStCd(update.getAlertStCd());
        }
        if (update.getAssignId() != null) {
            existing.setAssignId(update.getAssignId());
        }
        if (update.getCloseDt() != null) {
            existing.setCloseDt(update.getCloseDt());
        }
        if (update.getCloseRsnCd() != null) {
            existing.setCloseRsnCd(update.getCloseRsnCd());
        }
        if (update.getRemark() != null) {
            existing.setRemark(update.getRemark());
        }
        if (update.getCaseId() != null) {
            existing.setCaseId(update.getCaseId());
        }
        existing.setUpdId(userId);
        tmsAlertMapper.update(existing);
        log.info("Alert updated: {}", alertId);
        return tmsAlertMapper.findById(alertId);
    }

    @Transactional(readOnly = true)
    public List<TmsRule> getRules() {
        return tmsRuleMapper.findAll();
    }

    @Transactional(readOnly = true)
    public List<TmsRule> getActiveRules() {
        return tmsRuleMapper.findAllActive();
    }

    @Transactional
    public TmsRule createRule(TmsRule rule, String userId) {
        if (rule.getUseYn() == null) {
            rule.setUseYn("Y");
        }
        rule.setRegId(userId);
        tmsRuleMapper.insert(rule);
        log.info("TMS Rule created: {}", rule.getRuleCd());
        return tmsRuleMapper.findById(rule.getRuleId());
    }

    @Transactional(readOnly = true)
    public PageResult<Transaction> getTransactions(String custNo, String trxnTpCd,
                                                    String trxnDtFrom, String trxnDtTo,
                                                    int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("custNo", custNo);
        params.put("trxnTpCd", trxnTpCd);
        params.put("trxnDtFrom", trxnDtFrom);
        params.put("trxnDtTo", trxnDtTo);
        params.put("size", size);
        params.put("offset", offset);

        List<Transaction> content = transactionMapper.findByParams(params);
        long total = transactionMapper.countByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public List<Transaction> getTransactionsByCust(String custNo) {
        return transactionMapper.findByCustNo(custNo);
    }

    /**
     * Generate an alert from a specific rule for a customer.
     * The alert number is auto-generated as ALT-{yyyyMMdd}-{seq}.
     */
    @Transactional
    public TmsAlert generateAlert(Long ruleId, String custNo, BigDecimal detectAmt,
                                   Integer detectCnt, BigDecimal riskScr, String remark, String userId) {
        TmsRule rule = tmsRuleMapper.findById(ruleId);
        if (rule == null) {
            throw new IllegalArgumentException("규칙을 찾을 수 없습니다: " + ruleId);
        }

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long seq = tmsAlertMapper.countByStatusCd("NEW") + tmsAlertMapper.countByStatusCd("REVIEW")
                 + tmsAlertMapper.countByStatusCd("CLOSED") + tmsAlertMapper.countByStatusCd("ESCALATED") + 1;
        String alertNo = String.format("ALT-%s-%04d", today, seq);

        TmsAlert alert = new TmsAlert();
        alert.setAlertNo(alertNo);
        alert.setRuleId(ruleId);
        alert.setCustNo(custNo);
        alert.setAlertDt(today);
        alert.setAlertStCd("NEW");
        alert.setDetectAmt(detectAmt);
        alert.setDetectCnt(detectCnt);
        alert.setRiskScr(riskScr);
        alert.setRemark(remark);
        alert.setRegId(userId);
        tmsAlertMapper.insert(alert);
        log.info("Alert generated: {} for customer {}", alertNo, custNo);
        return tmsAlertMapper.findById(alert.getAlertId());
    }

    @Transactional(readOnly = true)
    public Map<String, Long> getAlertCountsByStatus() {
        Map<String, Long> counts = new HashMap<>();
        counts.put("NEW", tmsAlertMapper.countByStatusCd("NEW"));
        counts.put("REVIEW", tmsAlertMapper.countByStatusCd("REVIEW"));
        counts.put("CLOSED", tmsAlertMapper.countByStatusCd("CLOSED"));
        counts.put("ESCALATED", tmsAlertMapper.countByStatusCd("ESCALATED"));
        return counts;
    }

    @Transactional(readOnly = true)
    public PageResult<Transaction> searchTransactions(
            String custNo, String acctNo, String trxnTpCd,
            String dtFrom, String dtTo,
            Long amtMin, Long amtMax,
            int page, int size) {
        int offset = (page - 1) * size;
        List<Transaction> content = transactionMapper.search(
                custNo, acctNo, trxnTpCd, dtFrom, dtTo, amtMin, amtMax, offset, size);
        int total = transactionMapper.searchCount(
                custNo, acctNo, trxnTpCd, dtFrom, dtTo, amtMin, amtMax);
        return new PageResult<>(content, page, size, total);
    }
}
