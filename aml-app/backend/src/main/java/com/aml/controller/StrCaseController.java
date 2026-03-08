package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.mapper.StrCaseMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Slf4j
@RestController
@RequestMapping("/api/str")
@RequiredArgsConstructor
public class StrCaseController {

    private final StrCaseMapper strCaseMapper;

    // ─── 목록 조회 ──────────────────────────────────────────────────

    @GetMapping("/cases")
    public ResponseEntity<ApiResponse<PageResult<Map<String, Object>>>> listCases(
            @RequestParam(required = false) String stDate,
            @RequestParam(required = false) String edDate,
            @RequestParam(required = false) String scnrId,
            @RequestParam(required = false) String rprPrgrsCcd,
            @RequestParam(defaultValue = "1")  int page,
            @RequestParam(defaultValue = "20") int size) {

        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("stDate",       stDate);
        params.put("edDate",       edDate);
        params.put("scnrId",       scnrId);
        params.put("rprPrgrsCcd",  rprPrgrsCcd);
        params.put("size",         size);
        params.put("offset",       offset);

        List<Map<String, Object>> content = strCaseMapper.findStrCases(params);
        long total = strCaseMapper.countStrCases(params);
        return ResponseEntity.ok(ApiResponse.ok(new PageResult<>(content, page, size, total)));
    }

    // ─── 상세 조회 ──────────────────────────────────────────────────

    @GetMapping("/cases/{sspsDlCrtDt}/{sspsDlId}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getCaseDetail(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId) {

        Map<String, Object> caseInfo = strCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            return ResponseEntity.status(404).body(ApiResponse.error("케이스를 찾을 수 없습니다: " + sspsDlId));
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

        return ResponseEntity.ok(ApiResponse.ok(detail));
    }

    // ─── 보고서 저장 (UPSERT) ───────────────────────────────────────

    @PutMapping("/cases/{sspsDlCrtDt}/{sspsDlId}/report")
    @Transactional
    public ResponseEntity<ApiResponse<Void>> saveReport(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId,
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        Map<String, Object> caseInfo = strCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            return ResponseEntity.status(404).body(ApiResponse.error("케이스를 찾을 수 없습니다: " + sspsDlId));
        }

        Map<String, Object> params = new HashMap<>();
        params.put("sspsDlCrtDt",  sspsDlCrtDt);
        params.put("sspsDlId",     sspsDlId);
        params.put("rprRsnCntnt",  body.get("rprRsnCntnt"));
        params.put("itemCntnt1",   body.get("itemCntnt1"));
        params.put("itemCntnt2",   body.get("itemCntnt2"));
        params.put("itemCntnt3",   body.get("itemCntnt3"));
        params.put("itemCntnt4",   body.get("itemCntnt4"));
        params.put("itemCntnt5",   body.get("itemCntnt5"));
        params.put("itemCntnt6",   body.get("itemCntnt6"));
        params.put("dobtDlGrdCd",  body.get("dobtDlGrdCd"));
        params.put("updId",        userId);
        strCaseMapper.upsertReport(params);

        // 상태를 '97' (검토중) 으로 전환
        strCaseMapper.updateCaseStatus(sspsDlCrtDt, sspsDlId, "97", userId);

        log.info("STR report saved: {}/{} by {}", sspsDlCrtDt, sspsDlId, userId);
        return ResponseEntity.ok(ApiResponse.ok(null, "보고서가 저장되었습니다."));
    }

    // ─── 결재 상신 ──────────────────────────────────────────────────

    @PostMapping("/cases/{sspsDlCrtDt}/{sspsDlId}/submit-approval")
    @Transactional
    public ResponseEntity<ApiResponse<Map<String, Object>>> submitApproval(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId,
            @RequestBody(required = false) Map<String, Object> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        Map<String, Object> caseInfo = strCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            return ResponseEntity.status(404).body(ApiResponse.error("케이스를 찾을 수 없습니다: " + sspsDlId));
        }

        // 결재번호 생성: STR + yyyyMMdd + 3자리 seq
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
        setValParams.put("appNo",      appNo);
        setValParams.put("scnrId",     scnrId);
        setValParams.put("appStsCcd",  "N");
        setValParams.put("reqDt",      today);
        setValParams.put("reqId",      userId);
        strCaseMapper.insertSetValApp(setValParams);

        // NIC66B.INST_ID = APP_NO 로 업데이트
        strCaseMapper.updateCaseInstId(sspsDlCrtDt, sspsDlId, appNo, userId);
        // 상태 = '97' (검토중)
        strCaseMapper.updateCaseStatus(sspsDlCrtDt, sspsDlId, "97", userId);

        log.info("STR approval submitted: {}/{}, appNo={} by {}", sspsDlCrtDt, sspsDlId, appNo, userId);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("appNo",     appNo);
        result.put("sspsDlId",  sspsDlId);
        result.put("status",    "97");
        return ResponseEntity.ok(ApiResponse.ok(result, "결재가 상신되었습니다."));
    }

    // ─── 결재 처리 (승인/반려) ──────────────────────────────────────

    @PutMapping("/approvals/{appNo}/approve")
    @Transactional
    public ResponseEntity<ApiResponse<Void>> processApproval(
            @PathVariable String appNo,
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        String snCcd      = Objects.toString(body.get("snCcd"), "E");  // E=승인, R=반려
        String rsnCntnt   = Objects.toString(body.get("rsnCntnt"), "");
        String apprUsrId  = Objects.toString(body.get("apprUsrId"), userId);
        String today      = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

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
        String msg = "E".equals(snCcd) ? "결재가 승인되었습니다." : "결재가 반려되었습니다.";
        return ResponseEntity.ok(ApiResponse.ok(null, msg));
    }

    // ─── FIU 제출 ───────────────────────────────────────────────────

    @PostMapping("/cases/{sspsDlCrtDt}/{sspsDlId}/submit-fiu")
    @Transactional
    public ResponseEntity<ApiResponse<Map<String, Object>>> submitFiu(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        Map<String, Object> caseInfo = strCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            return ResponseEntity.status(404).body(ApiResponse.error("케이스를 찾을 수 없습니다: " + sspsDlId));
        }

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        // FIU 가짜 접수번호 생성
        String fiuRptNo = String.format("FIU%s%05d",
                today, System.currentTimeMillis() % 100000);

        strCaseMapper.updateCaseFiu(sspsDlCrtDt, sspsDlId, fiuRptNo, today, userId);

        log.info("STR FIU submitted: {}/{}, fiuRptNo={} by {}", sspsDlCrtDt, sspsDlId, fiuRptNo, userId);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("fiuRptNo", fiuRptNo);
        result.put("fiuRptDt", today);
        result.put("status",   "10");
        return ResponseEntity.ok(ApiResponse.ok(result, "FIU에 제출되었습니다."));
    }

}
