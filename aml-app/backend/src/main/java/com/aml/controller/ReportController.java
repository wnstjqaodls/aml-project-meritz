package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.domain.CtrReport;
import com.aml.domain.StrReport;
import com.aml.service.ReportService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/reports")
@RequiredArgsConstructor
public class ReportController {

    private final ReportService reportService;

    // ─── STR ─────────────────────────────────────────────────────

    @GetMapping("/str")
    public ResponseEntity<ApiResponse<PageResult<StrReport>>> searchStr(
            @RequestParam(required = false) String strStCd,
            @RequestParam(required = false) String custNo,
            @RequestParam(required = false) Long caseId,
            @RequestParam(required = false) String strDtFrom,
            @RequestParam(required = false) String strDtTo,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<StrReport> result = reportService.searchStr(strStCd, custNo, caseId, strDtFrom, strDtTo, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @PostMapping("/str")
    public ResponseEntity<ApiResponse<StrReport>> createStr(
            @RequestBody StrReport strReport,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            StrReport created = reportService.createStr(strReport, userId);
            return ResponseEntity.ok(ApiResponse.ok(created, "STR 보고서가 등록되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/str/{strId}")
    public ResponseEntity<ApiResponse<StrReport>> getStr(@PathVariable Long strId) {
        try {
            StrReport report = reportService.getStr(strId);
            return ResponseEntity.ok(ApiResponse.ok(report));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/str/{strId}")
    public ResponseEntity<ApiResponse<StrReport>> updateStr(
            @PathVariable Long strId,
            @RequestBody StrReport update,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            StrReport updated = reportService.updateStr(strId, update, userId);
            return ResponseEntity.ok(ApiResponse.ok(updated, "STR 보고서가 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    // ─── CTR ─────────────────────────────────────────────────────

    @GetMapping("/ctr")
    public ResponseEntity<ApiResponse<PageResult<CtrReport>>> searchCtr(
            @RequestParam(required = false) String ctrStCd,
            @RequestParam(required = false) String custNo,
            @RequestParam(required = false) String trxnDtFrom,
            @RequestParam(required = false) String trxnDtTo,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<CtrReport> result = reportService.searchCtr(ctrStCd, custNo, trxnDtFrom, trxnDtTo, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @PostMapping("/ctr")
    public ResponseEntity<ApiResponse<CtrReport>> createCtr(
            @RequestBody CtrReport ctrReport,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            CtrReport created = reportService.createCtr(ctrReport, userId);
            return ResponseEntity.ok(ApiResponse.ok(created, "CTR 보고서가 등록되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/ctr/{ctrId}")
    public ResponseEntity<ApiResponse<CtrReport>> getCtr(@PathVariable Long ctrId) {
        try {
            CtrReport report = reportService.getCtr(ctrId);
            return ResponseEntity.ok(ApiResponse.ok(report));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/ctr/{ctrId}")
    public ResponseEntity<ApiResponse<CtrReport>> updateCtr(
            @PathVariable Long ctrId,
            @RequestBody CtrReport update,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            CtrReport updated = reportService.updateCtr(ctrId, update, userId);
            return ResponseEntity.ok(ApiResponse.ok(updated, "CTR 보고서가 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }
}
