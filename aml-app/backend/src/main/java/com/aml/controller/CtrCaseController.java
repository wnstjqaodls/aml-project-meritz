package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.mapper.CtrCaseMapper;
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
@RequestMapping("/api/ctr")
@RequiredArgsConstructor
public class CtrCaseController {

    private final CtrCaseMapper ctrCaseMapper;

    // ─── 목록 조회 ──────────────────────────────────────────────────

    @GetMapping("/cases")
    public ResponseEntity<ApiResponse<PageResult<Map<String, Object>>>> listCases(
            @RequestParam(required = false) String stDate,
            @RequestParam(required = false) String edDate,
            @RequestParam(required = false) String rprPrgrsCcd,
            @RequestParam(defaultValue = "1")  int page,
            @RequestParam(defaultValue = "20") int size) {

        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("stDate",      stDate);
        params.put("edDate",      edDate);
        params.put("rprPrgrsCcd", rprPrgrsCcd);
        params.put("size",        size);
        params.put("offset",      offset);

        List<Map<String, Object>> content = ctrCaseMapper.findCtrCases(params);
        long total = ctrCaseMapper.countCtrCases(params);
        return ResponseEntity.ok(ApiResponse.ok(new PageResult<>(content, page, size, total)));
    }

    // ─── 상세 조회 ──────────────────────────────────────────────────

    @GetMapping("/cases/{sspsDlCrtDt}/{sspsDlId}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getCaseDetail(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId) {

        Map<String, Object> caseInfo = ctrCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            return ResponseEntity.status(404).body(ApiResponse.error("CTR 케이스를 찾을 수 없습니다: " + sspsDlId));
        }

        String dlPRnmcno = Objects.toString(caseInfo.get("DL_P_RNMCNO"),
                Objects.toString(caseInfo.get("dlPRnmcno"), null));
        Map<String, Object> partyInfo = dlPRnmcno != null
                ? ctrCaseMapper.findPartyInfo(sspsDlCrtDt, dlPRnmcno) : null;

        List<Map<String, Object>> transactions = ctrCaseMapper.findTransactions(sspsDlCrtDt, sspsDlId);
        List<Map<String, Object>> amounts      = ctrCaseMapper.findAmounts(sspsDlCrtDt, sspsDlId);
        Map<String, Object>       report       = ctrCaseMapper.findReport(sspsDlCrtDt, sspsDlId);

        Map<String, Object> detail = new LinkedHashMap<>();
        detail.put("caseInfo",     caseInfo);
        detail.put("partyInfo",    partyInfo);
        detail.put("transactions", transactions);
        detail.put("amounts",      amounts);
        detail.put("report",       report);

        return ResponseEntity.ok(ApiResponse.ok(detail));
    }

    // ─── 상태 변경 ──────────────────────────────────────────────────

    @PutMapping("/cases/{sspsDlCrtDt}/{sspsDlId}/status")
    @Transactional
    public ResponseEntity<ApiResponse<Void>> updateStatus(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId,
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        Map<String, Object> caseInfo = ctrCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            return ResponseEntity.status(404).body(ApiResponse.error("CTR 케이스를 찾을 수 없습니다: " + sspsDlId));
        }

        String rprPrgrsCcd = Objects.toString(body.get("rprPrgrsCcd"), "9");
        int updated = ctrCaseMapper.updateCaseStatus(sspsDlCrtDt, sspsDlId, rprPrgrsCcd, userId);
        if (updated == 0) {
            return ResponseEntity.badRequest().body(ApiResponse.error("상태 업데이트 실패"));
        }

        log.info("CTR status updated: {}/{} -> {} by {}", sspsDlCrtDt, sspsDlId, rprPrgrsCcd, userId);
        return ResponseEntity.ok(ApiResponse.ok(null, "상태가 변경되었습니다."));
    }

    // ─── FIU 제출 ───────────────────────────────────────────────────

    @PostMapping("/cases/{sspsDlCrtDt}/{sspsDlId}/submit-fiu")
    @Transactional
    public ResponseEntity<ApiResponse<Map<String, Object>>> submitFiu(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        Map<String, Object> caseInfo = ctrCaseMapper.findCaseInfo(sspsDlCrtDt, sspsDlId);
        if (caseInfo == null) {
            return ResponseEntity.status(404).body(ApiResponse.error("CTR 케이스를 찾을 수 없습니다: " + sspsDlId));
        }

        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        long seq = ctrCaseMapper.countCtrFiuSeq(today) + 1;
        String fiuRptNo = String.format("FIU%s%05d", today, seq);

        ctrCaseMapper.updateCaseFiu(sspsDlCrtDt, sspsDlId, fiuRptNo, today, userId);

        log.info("CTR FIU submitted: {}/{}, fiuRptNo={} by {}", sspsDlCrtDt, sspsDlId, fiuRptNo, userId);

        Map<String, Object> result = new LinkedHashMap<>();
        result.put("fiuRptNo", fiuRptNo);
        result.put("fiuRptDt", today);
        result.put("status",   "10");
        return ResponseEntity.ok(ApiResponse.ok(result, "CTR FIU에 제출되었습니다."));
    }
}
