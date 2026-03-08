package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.domain.RaItem;
import com.aml.domain.RaResult;
import com.aml.domain.RaResultDetail;
import com.aml.service.RiskAssessmentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/ra")
@RequiredArgsConstructor
public class RaController {

    private final RiskAssessmentService raService;

    @GetMapping("/items")
    public ResponseEntity<ApiResponse<List<RaItem>>> getItems() {
        List<RaItem> items = raService.getItems();
        return ResponseEntity.ok(ApiResponse.ok(items));
    }

    @PostMapping("/evaluate")
    public ResponseEntity<ApiResponse<RaResult>> evaluate(
            @RequestBody Map<String, String> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        String custNo = body.get("custNo");
        if (custNo == null || custNo.isBlank()) {
            return ResponseEntity.badRequest().body(ApiResponse.error("custNo가 필요합니다."));
        }

        try {
            RaResult result = raService.evaluate(custNo, userId);
            return ResponseEntity.ok(ApiResponse.ok(result, "위험 평가가 완료되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/results")
    public ResponseEntity<ApiResponse<PageResult<RaResult>>> getResults(
            @RequestParam(required = false) String custNo,
            @RequestParam(required = false) String raGrd,
            @RequestParam(required = false) String eddYn,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<RaResult> result = raService.searchResults(custNo, raGrd, eddYn, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/results/{raId}/details")
    public ResponseEntity<ApiResponse<List<RaResultDetail>>> getResultDetails(@PathVariable Long raId) {
        List<RaResultDetail> details = raService.getResultDetails(raId);
        return ResponseEntity.ok(ApiResponse.ok(details));
    }

    @GetMapping("/results/latest/{custNo}")
    public ResponseEntity<ApiResponse<RaResult>> getLatestResult(@PathVariable String custNo) {
        RaResult result = raService.getLatestResult(custNo);
        if (result == null) {
            return ResponseEntity.status(404).body(ApiResponse.error("평가 결과를 찾을 수 없습니다: " + custNo));
        }
        return ResponseEntity.ok(ApiResponse.ok(result));
    }
}
