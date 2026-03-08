package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.domain.TmsAlert;
import com.aml.domain.TmsAppr;
import com.aml.domain.TmsRule;
import com.aml.domain.TmsScenario;
import com.aml.domain.TmsSetVal;
import com.aml.domain.TmsStatsDaily;
import com.aml.domain.Transaction;
import com.aml.service.BatchSimulatorService;
import com.aml.service.TmsApprService;
import com.aml.service.TmsScenarioService;
import com.aml.service.TmsService;
import com.aml.service.TmsStatsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/tms")
@RequiredArgsConstructor
public class TmsController {

    private final TmsService tmsService;
    private final TmsScenarioService tmsScenarioService;
    private final TmsApprService tmsApprService;
    private final TmsStatsService tmsStatsService;
    private final BatchSimulatorService batchSimulatorService;

    // ─── Batch Simulator ─────────────────────────────────────────

    @PostMapping("/batch/simulate")
    public ResponseEntity<ApiResponse<Map<String, Object>>> simulateBatch(
            @RequestParam(defaultValue = "10") int count) {
        try {
            Map<String, Object> result = batchSimulatorService.simulate(count);
            return ResponseEntity.ok(ApiResponse.ok(result, "배치 시뮬레이션이 완료되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error("배치 시뮬레이션 실패: " + e.getMessage()));
        }
    }

    // ─── Alerts ──────────────────────────────────────────────────

    @GetMapping("/alerts")
    public ResponseEntity<ApiResponse<PageResult<TmsAlert>>> searchAlerts(
            @RequestParam(required = false) String alertStCd,
            @RequestParam(required = false) String custNo,
            @RequestParam(required = false) String alertDtFrom,
            @RequestParam(required = false) String alertDtTo,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<TmsAlert> result = tmsService.searchAlerts(alertStCd, custNo, alertDtFrom, alertDtTo, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/alerts/{alertId}")
    public ResponseEntity<ApiResponse<TmsAlert>> getAlert(@PathVariable Long alertId) {
        try {
            TmsAlert alert = tmsService.getAlert(alertId);
            return ResponseEntity.ok(ApiResponse.ok(alert));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/alerts/{alertId}")
    public ResponseEntity<ApiResponse<TmsAlert>> updateAlert(
            @PathVariable Long alertId,
            @RequestBody TmsAlert update,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            TmsAlert updated = tmsService.updateAlert(alertId, update, userId);
            return ResponseEntity.ok(ApiResponse.ok(updated, "알람이 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    // ─── Rules ───────────────────────────────────────────────────

    @GetMapping("/rules")
    public ResponseEntity<ApiResponse<List<TmsRule>>> getRules(
            @RequestParam(defaultValue = "false") boolean activeOnly) {

        List<TmsRule> rules = activeOnly ? tmsService.getActiveRules() : tmsService.getRules();
        return ResponseEntity.ok(ApiResponse.ok(rules));
    }

    @PostMapping("/rules")
    public ResponseEntity<ApiResponse<TmsRule>> createRule(
            @RequestBody TmsRule rule,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            TmsRule created = tmsService.createRule(rule, userId);
            return ResponseEntity.ok(ApiResponse.ok(created, "TMS 규칙이 등록되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    // ─── Transactions ─────────────────────────────────────────────

    @GetMapping("/transactions")
    public ResponseEntity<ApiResponse<PageResult<Transaction>>> getTransactions(
            @RequestParam(required = false) String custNo,
            @RequestParam(required = false) String acctNo,
            @RequestParam(required = false) String trxnTpCd,
            @RequestParam(required = false) String dtFrom,
            @RequestParam(required = false) String dtTo,
            @RequestParam(required = false) Long amtMin,
            @RequestParam(required = false) Long amtMax,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<Transaction> result = tmsService.searchTransactions(
                custNo, acctNo, trxnTpCd, dtFrom, dtTo, amtMin, amtMax, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    // ─── Scenarios ────────────────────────────────────────────────

    @GetMapping("/scenarios")
    public ResponseEntity<ApiResponse<PageResult<TmsScenario>>> getScenarios(
            @RequestParam(required = false) String scnrTpCd,
            @RequestParam(required = false) String useYn,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<TmsScenario> result = tmsScenarioService.getScenarios(scnrTpCd, useYn, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/scenarios/{scnrId}")
    public ResponseEntity<ApiResponse<TmsScenario>> getScenario(@PathVariable String scnrId) {
        try {
            TmsScenario scenario = tmsScenarioService.getScenario(scnrId);
            return ResponseEntity.ok(ApiResponse.ok(scenario));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/scenarios")
    public ResponseEntity<ApiResponse<TmsScenario>> createScenario(
            @RequestBody TmsScenario scenario,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            tmsScenarioService.createScenario(scenario, userId);
            TmsScenario created = tmsScenarioService.getScenario(scenario.getScnrId());
            return ResponseEntity.ok(ApiResponse.ok(created, "시나리오가 등록되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/scenarios/{scnrId}")
    public ResponseEntity<ApiResponse<TmsScenario>> updateScenario(
            @PathVariable String scnrId,
            @RequestBody TmsScenario scenario,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            scenario.setScnrId(scnrId);
            tmsScenarioService.updateScenario(scenario, userId);
            TmsScenario updated = tmsScenarioService.getScenario(scnrId);
            return ResponseEntity.ok(ApiResponse.ok(updated, "시나리오가 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    // ─── Set Values ───────────────────────────────────────────────

    @GetMapping("/setvals")
    public ResponseEntity<ApiResponse<PageResult<TmsSetVal>>> getAllSetVals(
            @RequestParam(required = false) String scnrId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<TmsSetVal> result = tmsScenarioService.getAllSetVals(scnrId, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/setvals/{scnrId}")
    public ResponseEntity<ApiResponse<List<TmsSetVal>>> getSetValsByScenario(
            @PathVariable String scnrId) {

        List<TmsSetVal> setVals = tmsScenarioService.getSetVals(scnrId);
        return ResponseEntity.ok(ApiResponse.ok(setVals));
    }

    @PutMapping("/setvals/{setId}")
    public ResponseEntity<ApiResponse<Void>> updateSetVal(
            @PathVariable Long setId,
            @RequestBody TmsSetVal setVal,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            setVal.setSetId(setId);
            tmsScenarioService.updateSetVal(setVal, userId);
            return ResponseEntity.ok(ApiResponse.ok(null, "설정값이 수정되었습니다. 결재가 생성되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    // ─── Approvals ────────────────────────────────────────────────

    @GetMapping("/approvals")
    public ResponseEntity<ApiResponse<PageResult<TmsAppr>>> getApprovals(
            @RequestParam(required = false) String apprStCd,
            @RequestParam(required = false) String apprTpCd,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<TmsAppr> result = tmsApprService.getApprovals(apprStCd, apprTpCd, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/approvals/{apprId}")
    public ResponseEntity<ApiResponse<TmsAppr>> getApproval(@PathVariable Long apprId) {
        try {
            TmsAppr appr = tmsApprService.getApproval(apprId);
            return ResponseEntity.ok(ApiResponse.ok(appr));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/approvals/{apprId}/approve")
    public ResponseEntity<ApiResponse<Void>> approveApproval(
            @PathVariable Long apprId,
            @RequestBody(required = false) Map<String, String> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            String comment = (body != null) ? body.get("comment") : null;
            tmsApprService.approve(apprId, comment, userId);
            return ResponseEntity.ok(ApiResponse.ok(null, "결재가 승인되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        } catch (IllegalStateException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/approvals/{apprId}/reject")
    public ResponseEntity<ApiResponse<Void>> rejectApproval(
            @PathVariable Long apprId,
            @RequestBody(required = false) Map<String, String> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            String reason = (body != null) ? body.get("reason") : null;
            tmsApprService.reject(apprId, reason, userId);
            return ResponseEntity.ok(ApiResponse.ok(null, "결재가 반려되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        } catch (IllegalStateException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    // ─── Stats ────────────────────────────────────────────────────

    @GetMapping("/stats/dashboard")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getDashboard() {
        Map<String, Object> dashboard = tmsStatsService.getDashboard();
        return ResponseEntity.ok(ApiResponse.ok(dashboard));
    }

    @GetMapping("/stats/weekly")
    public ResponseEntity<ApiResponse<List<TmsStatsDaily>>> getWeeklyTrend() {
        List<TmsStatsDaily> trend = tmsStatsService.getWeeklyTrend();
        return ResponseEntity.ok(ApiResponse.ok(trend));
    }

    @GetMapping("/stats/breakdown")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getBreakdown(
            @RequestParam(required = false, defaultValue = "all") String type) {

        Map<String, Object> breakdown;
        if ("alert".equalsIgnoreCase(type)) {
            breakdown = tmsStatsService.getAlertBreakdown();
        } else if ("report".equalsIgnoreCase(type)) {
            breakdown = tmsStatsService.getReportBreakdown();
        } else {
            // Return combined breakdown
            breakdown = new java.util.HashMap<>();
            breakdown.putAll(tmsStatsService.getAlertBreakdown());
            breakdown.putAll(tmsStatsService.getReportBreakdown());
        }
        return ResponseEntity.ok(ApiResponse.ok(breakdown));
    }
}
