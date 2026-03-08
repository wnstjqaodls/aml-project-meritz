package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.domain.KycRecord;
import com.aml.service.KycService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/kyc")
@RequiredArgsConstructor
public class KycController {

    private final KycService kycService;

    @GetMapping
    public ResponseEntity<ApiResponse<PageResult<KycRecord>>> searchKyc(
            @RequestParam(required = false) String custNo,
            @RequestParam(required = false) String kycStCd,
            @RequestParam(required = false) String kycTpCd,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<KycRecord> result = kycService.searchKyc(custNo, kycStCd, kycTpCd, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<KycRecord>> createKyc(
            @RequestBody KycRecord kycRecord,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            KycRecord created = kycService.createKyc(kycRecord, userId);
            return ResponseEntity.ok(ApiResponse.ok(created, "KYC가 등록되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/{kycId}")
    public ResponseEntity<ApiResponse<KycRecord>> getKyc(@PathVariable Long kycId) {
        try {
            KycRecord record = kycService.getKyc(kycId);
            return ResponseEntity.ok(ApiResponse.ok(record));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/{kycId}")
    public ResponseEntity<ApiResponse<KycRecord>> updateKyc(
            @PathVariable Long kycId,
            @RequestBody KycRecord kycRecord,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            KycRecord updated = kycService.updateKyc(kycId, kycRecord, userId);
            return ResponseEntity.ok(ApiResponse.ok(updated, "KYC가 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }
}
