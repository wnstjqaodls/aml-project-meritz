package com.aml.service;

import com.aml.common.PageResult;
import com.aml.mapper.StrCaseMapper;
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
public class StrCaseService {

    private final StrCaseMapper strCaseMapper;

    // ─── 목록 조회 ──────────────────────────────────────────────────

    @Transactional(readOnly = true)
    public PageResult<Map<String, Object>> getCases(String stDate, String edDate,
                                                    String scnrId, String rprPrgrsCcd,
                                                    int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("stDate",      stDate);
        params.put("edDate",      edDate);
        params.put("scnrId",      scnrId);
        params.put("rprPrgrsCcd", rprPrgrsCcd);
        params.put("size",        size);
        params.put("offset",      offset);

        List<Map<String, Object>> content = strCaseMapper.findStrCases(params);
        long total = strCaseMapper.countStrCases(params);
        return new PageResult<>(content, page, size, total);
    }

    // ─── 상세 조회 ──────────────────────────────────────────────────

    @Transactional(readOnly = true)
    public Map<String, Object> getCaseDetail(String sspsDlCrtDt, String sspsDlId) {
        Map<String, Object> caseInfo = strCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            return null;
        }

        String dlPRnmcno = Objects.toString(caseInfo.get("DL_P_RNMCNO"),
                Objects.toString(caseInfo.get("dlPRnmcno"), null));
        Map<String, Object> partyInfo = dlPRnmcno != null
                ? strCaseMapper.findPartyInfo(sspsDlCrtDt, dlPRnmcno) : null;

        List<Map<String, Object>> transactions = strCaseMapper.findTransactions(sspsDlCrtDt, sspsDlId);
        List<Map<String, Object>> amounts      = strCaseMapper.findAmounts(sspsDlCrtDt, sspsDlId);
        Map<String, Object>       report       = strCaseMapper.findReport(sspsDlCrtDt, sspsDlId);

        // INST_ID = 결재번호(APP_NO)로 AML_APPR 조회
        String instId = Objects.toString(caseInfo.get("INST_ID"),
                Objects.toString(caseInfo.get("instId"), null));
        List<Map<String, Object>> approvals = (instId != null && !instId.isBlank())
                ? strCaseMapper.findApprovals(instId) : Collections.emptyList();

        Map<String, Object> detail = new LinkedHashMap<>();
        detail.put("caseInfo",    caseInfo);
        detail.put("partyInfo",   partyInfo);
        detail.put("transactions", transactions);
        detail.put("amounts",     amounts);
        detail.put("report",      report);
        detail.put("approvals",   approvals);
        return detail;
    }

    // ─── 보고서 저장 (UPSERT) ───────────────────────────────────────

    @Transactional
    public void saveReport(String sspsDlCrtDt, String sspsDlId,
                           Map<String, Object> body, String userId) {
        Map<String, Object> caseInfo = strCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            throw new NoSuchElementException("케이스를 찾을 수 없습니다: " + sspsDlId);
        }

        Map<String, Object> params = new HashMap<>();
        params.put("sspsDlCrtDt", sspsDlCrtDt);
        params.put("sspsDlId",    sspsDlId);
        params.put("rprRsnCntnt", body.get("rprRsnCntnt"));
        params.put("itemCntnt1",  body.get("itemCntnt1"));
        params.put("itemCntnt2",  body.get("itemCntnt2"));
        params.put("itemCntnt3",  body.get("itemCntnt3"));
        params.put("itemCntnt4",  body.get("itemCntnt4"));
        params.put("itemCntnt5",  body.get("itemCntnt5"));
        params.put("itemCntnt6",  body.get("itemCntnt6"));
        params.put("dobtDlGrdCd", body.get("dobtDlGrdCd"));
        params.put("updId",       userId);
        strCaseMapper.upsertReport(params);

        // 상태를 '97' (검토중) 으로 전환
        strCaseMapper.updateCaseStatus(sspsDlCrtDt, sspsDlId, "97", userId);

        log.info("STR report saved: {}/{} by {}", sspsDlCrtDt, sspsDlId, userId);
    }

    // ─── 결재 상신 ──────────────────────────────────────────────────

    @Transactional
    public Map<String, Object> submitApproval(String sspsDlCrtDt, String sspsDlId,
                                              Map<String, Object> body, String userId) {
        Map<String, Object> caseInfo = strCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            throw new NoSuchElementException("케이스를 찾을 수 없습니다: " + sspsDlId);
        }

        // 결재번호 생성: STR + yyyyMMdd + 4자리 seq
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long seq = strCaseMapper.countStrAppNo(today) + 1;
        String appNo = String.format("STR%s%04d", today, seq);

        String rsnCntnt = (body != null && body.containsKey("rsnCntnt"))
                ? Objects.toString(body.get("rsnCntnt"), "") : "";

        // AML_APPR INSERT (GYLJ_LINE_G_C='TMS1', SN_CCD='N' = 대기)
        Map<String, Object> apprParams = new HashMap<>();
        apprParams.put("appNo",        appNo);
        apprParams.put("gyljLineGC",   "TMS1");
        apprParams.put("numSq",        1);
        apprParams.put("appDt",        today);
        apprParams.put("sno",          1);
        apprParams.put("snCcd",        "N");
        apprParams.put("apprRoleId",   "ANALYST");
        apprParams.put("targetRoleId", "MANAGER");
        apprParams.put("rsnCntnt",     rsnCntnt);
        apprParams.put("hndlPEno",     userId);
        strCaseMapper.insertAppr(apprParams);

        // TMS_SET_VAL_APP INSERT (연동)
        String scnrId = Objects.toString(caseInfo.get("SSPS_TYP_CD"),
                Objects.toString(caseInfo.get("sspsTYpCd"), "STR001"));
        Map<String, Object> setValParams = new HashMap<>();
        setValParams.put("appNo",     appNo);
        setValParams.put("scnrId",    scnrId);
        setValParams.put("appStsCcd", "N");
        setValParams.put("reqDt",     today);
        setValParams.put("reqId",     userId);
        strCaseMapper.insertSetValApp(setValParams);

        // NIC66B.INST_ID = APP_NO 로 업데이트
        strCaseMapper.updateCaseInstId(sspsDlCrtDt, sspsDlId, appNo, userId);
        // 상태 = '97' (검토중)
        strCaseMapper.updateCaseStatus(sspsDlCrtDt, sspsDlId, "97", userId);

        log.info("STR approval submitted: {}/{}, appNo={} by {}", sspsDlCrtDt, sspsDlId, appNo, userId);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("appNo",    appNo);
        result.put("sspsDlId", sspsDlId);
        result.put("status",   "97");
        return result;
    }

    // ─── 결재 처리 (승인/반려) ──────────────────────────────────────

    @Transactional
    public String processApproval(String appNo, Map<String, Object> body, String userId) {
        String snCcd     = Objects.toString(body.get("snCcd"), "E");  // E=승인, R=반려
        String rsnCntnt  = Objects.toString(body.get("rsnCntnt"), "");
        String apprUsrId = Objects.toString(body.get("apprUsrId"), userId);
        String today     = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

        // AML_APPR UPDATE
        Map<String, Object> apprParams = new HashMap<>();
        apprParams.put("appNo",      appNo);
        apprParams.put("gyljLineGC", "TMS1");
        apprParams.put("snCcd",      snCcd);
        apprParams.put("rsnCntnt",   rsnCntnt);
        apprParams.put("hndlPEno",   apprUsrId);
        strCaseMapper.updateAppr(apprParams);

        // AML_APPR_HIST INSERT
        Integer maxSeq = strCaseMapper.maxApprSeq(appNo);
        Map<String, Object> histParams = new HashMap<>();
        histParams.put("appNo",      appNo);
        histParams.put("gyljLineGC", "TMS1");
        histParams.put("numSq",      (maxSeq == null ? 0 : maxSeq) + 1);
        histParams.put("appDt",      today);
        histParams.put("sno",        1);
        histParams.put("snCcd",      snCcd);
        histParams.put("apprRoleId", "MANAGER");
        histParams.put("rsnCntnt",   rsnCntnt);
        histParams.put("hndlPEno",   apprUsrId);
        strCaseMapper.insertApprHist(histParams);

        // NIC66B 상태 업데이트 (INST_ID = appNo 기준)
        String newStatus = "E".equals(snCcd) ? "98" : "9";  // 승인=98, 반려=9(대기)
        strCaseMapper.updateStatusByInstId(appNo, newStatus, userId);

        log.info("STR approval processed: appNo={}, snCcd={} by {}", appNo, snCcd, userId);
        return "E".equals(snCcd) ? "결재가 승인되었습니다." : "결재가 반려되었습니다.";
    }

    // ─── FIU 제출 ───────────────────────────────────────────────────

    @Transactional
    public Map<String, Object> submitFiu(String sspsDlCrtDt, String sspsDlId, String userId) {
        Map<String, Object> caseInfo = strCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            throw new NoSuchElementException("케이스를 찾을 수 없습니다: " + sspsDlId);
        }

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        // FIU 접수번호 생성: FIU + yyyyMMdd + 5자리 seq
        String fiuRptNo = String.format("FIU%s%05d",
                today, System.currentTimeMillis() % 100000);

        strCaseMapper.updateCaseFiu(sspsDlCrtDt, sspsDlId, fiuRptNo, today, userId);

        log.info("STR FIU submitted: {}/{}, fiuRptNo={} by {}", sspsDlCrtDt, sspsDlId, fiuRptNo, userId);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("fiuRptNo", fiuRptNo);
        result.put("fiuRptDt", today);
        result.put("status",   "10");
        return result;
    }
}
