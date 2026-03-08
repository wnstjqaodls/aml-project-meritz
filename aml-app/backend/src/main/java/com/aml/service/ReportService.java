package com.aml.service;

import com.aml.common.PageResult;
import com.aml.domain.CtrReport;
import com.aml.domain.StrReport;
import com.aml.mapper.CtrReportMapper;
import com.aml.mapper.StrReportMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReportService {

    private final StrReportMapper strReportMapper;
    private final CtrReportMapper ctrReportMapper;

    // ─── STR ───────────────────────────────────────────────────────

    @Transactional(readOnly = true)
    public PageResult<StrReport> searchStr(String strStCd, String custNo, Long caseId,
                                            String strDtFrom, String strDtTo,
                                            int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("strStCd", strStCd);
        params.put("custNo", custNo);
        params.put("caseId", caseId);
        params.put("strDtFrom", strDtFrom);
        params.put("strDtTo", strDtTo);
        params.put("size", size);
        params.put("offset", offset);

        List<StrReport> content = strReportMapper.findByParams(params);
        long total = strReportMapper.countByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public StrReport getStr(Long strId) {
        StrReport report = strReportMapper.findById(strId);
        if (report == null) {
            throw new IllegalArgumentException("STR 보고서를 찾을 수 없습니다: " + strId);
        }
        return report;
    }

    @Transactional
    public StrReport createStr(StrReport strReport, String userId) {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        if (strReport.getStrNo() == null || strReport.getStrNo().isBlank()) {
            long seq = System.currentTimeMillis() % 100000;
            strReport.setStrNo(String.format("STR-%s-%05d", today, seq));
        }
        if (strReport.getStrDt() == null) {
            strReport.setStrDt(today);
        }
        if (strReport.getStrStCd() == null) {
            strReport.setStrStCd("DRAFT");
        }
        strReport.setRegId(userId);
        strReportMapper.insert(strReport);
        log.info("STR created: {}", strReport.getStrNo());
        return strReportMapper.findById(strReport.getStrId());
    }

    @Transactional
    public StrReport updateStr(Long strId, StrReport update, String userId) {
        StrReport existing = strReportMapper.findById(strId);
        if (existing == null) {
            throw new IllegalArgumentException("STR 보고서를 찾을 수 없습니다: " + strId);
        }
        if (update.getStrStCd() != null) {
            existing.setStrStCd(update.getStrStCd());
        }
        if (update.getSuspAmt() != null) {
            existing.setSuspAmt(update.getSuspAmt());
        }
        if (update.getSuspDtFrom() != null) {
            existing.setSuspDtFrom(update.getSuspDtFrom());
        }
        if (update.getSuspDtTo() != null) {
            existing.setSuspDtTo(update.getSuspDtTo());
        }
        if (update.getSuspRsn() != null) {
            existing.setSuspRsn(update.getSuspRsn());
        }
        if (update.getFiuRptNo() != null) {
            existing.setFiuRptNo(update.getFiuRptNo());
        }
        if (update.getFiuRptDt() != null) {
            existing.setFiuRptDt(update.getFiuRptDt());
        }
        existing.setUpdId(userId);
        strReportMapper.update(existing);
        log.info("STR updated: {}", strId);
        return strReportMapper.findById(strId);
    }

    // ─── CTR ───────────────────────────────────────────────────────

    @Transactional(readOnly = true)
    public PageResult<CtrReport> searchCtr(String ctrStCd, String custNo,
                                            String trxnDtFrom, String trxnDtTo,
                                            int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("ctrStCd", ctrStCd);
        params.put("custNo", custNo);
        params.put("trxnDtFrom", trxnDtFrom);
        params.put("trxnDtTo", trxnDtTo);
        params.put("size", size);
        params.put("offset", offset);

        List<CtrReport> content = ctrReportMapper.findByParams(params);
        long total = ctrReportMapper.countByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public CtrReport getCtr(Long ctrId) {
        CtrReport report = ctrReportMapper.findById(ctrId);
        if (report == null) {
            throw new IllegalArgumentException("CTR 보고서를 찾을 수 없습니다: " + ctrId);
        }
        return report;
    }

    @Transactional
    public CtrReport createCtr(CtrReport ctrReport, String userId) {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        if (ctrReport.getCtrNo() == null || ctrReport.getCtrNo().isBlank()) {
            long seq = System.currentTimeMillis() % 100000;
            ctrReport.setCtrNo(String.format("CTR-%s-%05d", today, seq));
        }
        if (ctrReport.getCtrStCd() == null) {
            ctrReport.setCtrStCd("PENDING");
        }
        if (ctrReport.getCtrCcy() == null) {
            ctrReport.setCtrCcy("KRW");
        }
        ctrReport.setRegId(userId);
        ctrReportMapper.insert(ctrReport);
        log.info("CTR created: {}", ctrReport.getCtrNo());
        return ctrReportMapper.findById(ctrReport.getCtrId());
    }

    @Transactional
    public CtrReport updateCtr(Long ctrId, CtrReport update, String userId) {
        CtrReport existing = ctrReportMapper.findById(ctrId);
        if (existing == null) {
            throw new IllegalArgumentException("CTR 보고서를 찾을 수 없습니다: " + ctrId);
        }
        if (update.getCtrStCd() != null) {
            existing.setCtrStCd(update.getCtrStCd());
        }
        if (update.getFiuRptNo() != null) {
            existing.setFiuRptNo(update.getFiuRptNo());
        }
        if (update.getFiuRptDt() != null) {
            existing.setFiuRptDt(update.getFiuRptDt());
        }
        existing.setUpdId(userId);
        ctrReportMapper.update(existing);
        log.info("CTR updated: {}", ctrId);
        return ctrReportMapper.findById(ctrId);
    }
}
