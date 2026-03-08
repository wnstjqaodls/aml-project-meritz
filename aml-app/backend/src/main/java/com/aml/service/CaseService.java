package com.aml.service;

import com.aml.common.PageResult;
import com.aml.domain.Case;
import com.aml.domain.CaseComment;
import com.aml.domain.StrReport;
import com.aml.mapper.CaseMapper;
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
public class CaseService {

    private final CaseMapper caseMapper;
    private final StrReportMapper strReportMapper;

    @Transactional(readOnly = true)
    public PageResult<Case> searchCases(String caseStCd, String caseTpCd, String custNo,
                                         String assignId, int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("caseStCd", caseStCd);
        params.put("caseTpCd", caseTpCd);
        params.put("custNo", custNo);
        params.put("assignId", assignId);
        params.put("size", size);
        params.put("offset", offset);

        List<Case> content = caseMapper.findByParams(params);
        long total = caseMapper.countByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public Case getCase(Long caseId) {
        Case aCase = caseMapper.findById(caseId);
        if (aCase == null) {
            throw new IllegalArgumentException("케이스를 찾을 수 없습니다: " + caseId);
        }
        return aCase;
    }

    @Transactional
    public Case createCase(Case aCase, String userId) {
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long seq = caseMapper.countByParams(new HashMap<>()) + 1;
        String caseNo = String.format("CASE-%s-%04d", today, seq);

        if (aCase.getCaseStCd() == null) {
            aCase.setCaseStCd("OPEN");
        }
        if (aCase.getPriorityCd() == null) {
            aCase.setPriorityCd("NORMAL");
        }
        if (aCase.getStrYn() == null) {
            aCase.setStrYn("N");
        }
        if (aCase.getCtrYn() == null) {
            aCase.setCtrYn("N");
        }
        aCase.setCaseNo(caseNo);
        aCase.setOpenDt(today);
        aCase.setRegId(userId);
        caseMapper.insert(aCase);
        log.info("Case created: {}", caseNo);
        return caseMapper.findById(aCase.getCaseId());
    }

    @Transactional
    public Case updateCase(Long caseId, Case update, String userId) {
        Case existing = caseMapper.findById(caseId);
        if (existing == null) {
            throw new IllegalArgumentException("케이스를 찾을 수 없습니다: " + caseId);
        }
        if (update.getCaseStCd() != null) {
            existing.setCaseStCd(update.getCaseStCd());
        }
        if (update.getCaseTpCd() != null) {
            existing.setCaseTpCd(update.getCaseTpCd());
        }
        if (update.getPriorityCd() != null) {
            existing.setPriorityCd(update.getPriorityCd());
        }
        if (update.getAssignId() != null) {
            existing.setAssignId(update.getAssignId());
        }
        if (update.getCloseDt() != null) {
            existing.setCloseDt(update.getCloseDt());
        }
        if (update.getStrYn() != null) {
            existing.setStrYn(update.getStrYn());
        }
        if (update.getCtrYn() != null) {
            existing.setCtrYn(update.getCtrYn());
        }
        if (update.getRemark() != null) {
            existing.setRemark(update.getRemark());
        }
        existing.setUpdId(userId);
        caseMapper.update(existing);
        log.info("Case updated: {}", caseId);
        return caseMapper.findById(caseId);
    }

    @Transactional
    public CaseComment addComment(Long caseId, String cmtText, String userId) {
        Case existing = caseMapper.findById(caseId);
        if (existing == null) {
            throw new IllegalArgumentException("케이스를 찾을 수 없습니다: " + caseId);
        }
        CaseComment comment = new CaseComment();
        comment.setCaseId(caseId);
        comment.setCmtText(cmtText);
        comment.setRegId(userId);
        caseMapper.insertComment(comment);
        return comment;
    }

    @Transactional(readOnly = true)
    public List<CaseComment> getComments(Long caseId) {
        if (caseMapper.findById(caseId) == null) {
            throw new IllegalArgumentException("케이스를 찾을 수 없습니다: " + caseId);
        }
        return caseMapper.findCommentsByCaseId(caseId);
    }

    /**
     * Escalate a case to STR: marks the case with strYn=Y and creates an STR draft report.
     */
    @Transactional
    public StrReport escalateToStr(Long caseId, String suspRsn, java.math.BigDecimal suspAmt,
                                    String suspDtFrom, String suspDtTo, String userId) {
        Case aCase = caseMapper.findById(caseId);
        if (aCase == null) {
            throw new IllegalArgumentException("케이스를 찾을 수 없습니다: " + caseId);
        }

        aCase.setStrYn("Y");
        aCase.setUpdId(userId);
        caseMapper.update(aCase);

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long seq = System.currentTimeMillis() % 10000;
        String strNo = String.format("STR-%s-%04d", today, seq);

        StrReport strReport = new StrReport();
        strReport.setStrNo(strNo);
        strReport.setCaseId(caseId);
        strReport.setCustNo(aCase.getCustNo());
        strReport.setStrDt(today);
        strReport.setStrStCd("DRAFT");
        strReport.setSuspAmt(suspAmt);
        strReport.setSuspDtFrom(suspDtFrom);
        strReport.setSuspDtTo(suspDtTo);
        strReport.setSuspRsn(suspRsn);
        strReport.setRegId(userId);
        strReportMapper.insert(strReport);

        log.info("STR escalated from case {}: {}", caseId, strNo);

        // Add a comment to the case
        CaseComment comment = new CaseComment();
        comment.setCaseId(caseId);
        comment.setCmtText("STR 보고서 생성됨: " + strNo);
        comment.setRegId(userId);
        caseMapper.insertComment(comment);

        return strReport;
    }

    @Transactional(readOnly = true)
    public long countOpenCases() {
        return caseMapper.countByStatusCd("OPEN");
    }
}
