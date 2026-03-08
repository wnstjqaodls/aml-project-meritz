package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.domain.WatchlistEntry;
import com.aml.domain.WatchlistScreen;
import com.aml.service.WatchlistService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/watchlist")
@RequiredArgsConstructor
public class WatchlistController {

    private final WatchlistService watchlistService;

    @GetMapping
    public ResponseEntity<ApiResponse<PageResult<WatchlistEntry>>> searchEntries(
            @RequestParam(required = false) String wlNm,
            @RequestParam(required = false) String wlSrcCd,
            @RequestParam(required = false) String wlTpCd,
            @RequestParam(required = false) String useYn,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<WatchlistEntry> result = watchlistService.searchEntries(wlNm, wlSrcCd, wlTpCd, useYn, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<WatchlistEntry>> createEntry(
            @RequestBody WatchlistEntry entry,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            WatchlistEntry created = watchlistService.createEntry(entry);
            return ResponseEntity.ok(ApiResponse.ok(created, "워치리스트 항목이 등록되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/{wlId}")
    public ResponseEntity<ApiResponse<WatchlistEntry>> updateEntry(
            @PathVariable Long wlId,
            @RequestBody WatchlistEntry entry,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            WatchlistEntry updated = watchlistService.updateEntry(wlId, entry);
            return ResponseEntity.ok(ApiResponse.ok(updated, "워치리스트 항목이 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/screen")
    public ResponseEntity<ApiResponse<List<WatchlistScreen>>> screen(
            @RequestBody Map<String, String> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        String custNo = body.get("custNo");
        if (custNo == null || custNo.isBlank()) {
            return ResponseEntity.badRequest().body(ApiResponse.error("custNo가 필요합니다."));
        }

        try {
            List<WatchlistScreen> results = watchlistService.screen(custNo, userId);
            String msg = results.isEmpty()
                    ? "스크리닝 완료: 일치 항목 없음"
                    : String.format("스크리닝 완료: %d건 일치 발견", results.size());
            return ResponseEntity.ok(ApiResponse.ok(results, msg));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/screen-results")
    public ResponseEntity<ApiResponse<PageResult<WatchlistScreen>>> getScreenResults(
            @RequestParam(required = false) String custNo,
            @RequestParam(required = false) String matchStCd,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<WatchlistScreen> result = watchlistService.getScreenResults(custNo, matchStCd, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @PutMapping("/screen-results/{screenId}")
    public ResponseEntity<ApiResponse<WatchlistScreen>> updateScreenResult(
            @PathVariable Long screenId,
            @RequestBody Map<String, String> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        String matchStCd = body.get("matchStCd");
        String remark = body.get("remark");

        try {
            WatchlistScreen updated = watchlistService.updateScreenResult(screenId, matchStCd, remark, userId);
            return ResponseEntity.ok(ApiResponse.ok(updated, "스크리닝 결과가 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }
}
