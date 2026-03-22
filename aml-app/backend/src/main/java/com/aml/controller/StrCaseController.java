package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.service.StrCaseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.NoSuchElementException;

@Slf4j
@RestController
@RequestMapping("/api/str")
@RequiredArgsConstructor
public class StrCaseController {

    private final StrCaseService strCaseService;

    // ─── 목록 조회 ──────────────────────────────────────────────────

    @GetMapping("/cases")
    public ResponseEntity<ApiResponse<PageResult<Map<String, Object>>>> listCases(
            @RequestParam(required = false) String stDate,
            @RequestParam(required = false) String edDate,
            @RequestParam(required = false) String scnrId,
            @RequestParam(required = false) String rprPrgrsCcd,
            @RequestParam(defaultValue = "1")  int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<Map<String, Object>> result =
                strCaseService.getCases(stDate, edDate, scnrId, rprPrgrsCcd, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    // ─── 상세 조회 ──────────────────────────────────────────────────

    @GetMapping("/cases/{sspsDlCrtDt}/{sspsDlId}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getCaseDetail(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId) {

        Map<String, Object> detail = strCaseService.getCaseDetail(sspsDlCrtDt, sspsDlId);
        if (detail == null) {
            return ResponseEntity.status(404)
                    .body(ApiResponse.error("케이스를 찾을 수 없습니다: " + sspsDlId));
        }
        return ResponseEntity.ok(ApiResponse.ok(detail));
    }

    // ─── 보고서 저장 (UPSERT) ───────────────────────────────────────

    @PutMapping("/cases/{sspsDlCrtDt}/{sspsDlId}/report")
    public ResponseEntity<ApiResponse<Void>> saveReport(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId,
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            strCaseService.saveReport(sspsDlCrtDt, sspsDlId, body, userId);
            return ResponseEntity.ok(ApiResponse.ok(null, "보고서가 저장되었습니다."));
        } catch (NoSuchElementException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    // ─── 결재 상신 ──────────────────────────────────────────────────

    @PostMapping("/cases/{sspsDlCrtDt}/{sspsDlId}/submit-approval")
    public ResponseEntity<ApiResponse<Map<String, Object>>> submitApproval(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId,
            @RequestBody(required = false) Map<String, Object> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            Map<String, Object> result =
                    strCaseService.submitApproval(sspsDlCrtDt, sspsDlId, body, userId);
            return ResponseEntity.ok(ApiResponse.ok(result, "결재가 상신되었습니다."));
        } catch (NoSuchElementException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    // ─── 결재 처리 (승인/반려) ──────────────────────────────────────

    @PutMapping("/approvals/{appNo}/approve")
    public ResponseEntity<ApiResponse<Void>> processApproval(
            @PathVariable String appNo,
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        String msg = strCaseService.processApproval(appNo, body, userId);
        return ResponseEntity.ok(ApiResponse.ok(null, msg));
    }

    // ─── FIU 제출 ───────────────────────────────────────────────────

    @PostMapping("/cases/{sspsDlCrtDt}/{sspsDlId}/submit-fiu")
    public ResponseEntity<ApiResponse<Map<String, Object>>> submitFiu(
            @PathVariable String sspsDlCrtDt,
            @PathVariable String sspsDlId,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            Map<String, Object> result = strCaseService.submitFiu(sspsDlCrtDt, sspsDlId, userId);
            return ResponseEntity.ok(ApiResponse.ok(result, "FIU에 제출되었습니다."));
        } catch (NoSuchElementException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }
}
