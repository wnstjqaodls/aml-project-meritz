package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.domain.Case;
import com.aml.domain.CaseComment;
import com.aml.domain.StrReport;
import com.aml.service.CaseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api/cases")
@RequiredArgsConstructor
public class CaseController {

    private final CaseService caseService;

    @GetMapping
    public ResponseEntity<ApiResponse<PageResult<Case>>> searchCases(
            @RequestParam(required = false) String caseStCd,
            @RequestParam(required = false) String caseTpCd,
            @RequestParam(required = false) String custNo,
            @RequestParam(required = false) String assignId,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<Case> result = caseService.searchCases(caseStCd, caseTpCd, custNo, assignId, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Case>> createCase(
            @RequestBody Case aCase,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            Case created = caseService.createCase(aCase, userId);
            return ResponseEntity.ok(ApiResponse.ok(created, "케이스가 등록되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/{caseId}")
    public ResponseEntity<ApiResponse<Case>> getCase(@PathVariable Long caseId) {
        try {
            Case aCase = caseService.getCase(caseId);
            return ResponseEntity.ok(ApiResponse.ok(aCase));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/{caseId}")
    public ResponseEntity<ApiResponse<Case>> updateCase(
            @PathVariable Long caseId,
            @RequestBody Case update,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            Case updated = caseService.updateCase(caseId, update, userId);
            return ResponseEntity.ok(ApiResponse.ok(updated, "케이스가 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/{caseId}/comments")
    public ResponseEntity<ApiResponse<CaseComment>> addComment(
            @PathVariable Long caseId,
            @RequestBody Map<String, String> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        String cmtText = body.get("cmtText");
        if (cmtText == null || cmtText.isBlank()) {
            return ResponseEntity.badRequest().body(ApiResponse.error("코멘트 내용을 입력하세요."));
        }

        try {
            CaseComment comment = caseService.addComment(caseId, cmtText, userId);
            return ResponseEntity.ok(ApiResponse.ok(comment, "코멘트가 등록되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/{caseId}/comments")
    public ResponseEntity<ApiResponse<List<CaseComment>>> getComments(@PathVariable Long caseId) {
        try {
            List<CaseComment> comments = caseService.getComments(caseId);
            return ResponseEntity.ok(ApiResponse.ok(comments));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PostMapping("/{caseId}/escalate-str")
    public ResponseEntity<ApiResponse<StrReport>> escalateToStr(
            @PathVariable Long caseId,
            @RequestBody Map<String, Object> body,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            String suspRsn = (String) body.get("suspRsn");
            BigDecimal suspAmt = body.get("suspAmt") != null
                    ? new BigDecimal(body.get("suspAmt").toString()) : null;
            String suspDtFrom = (String) body.get("suspDtFrom");
            String suspDtTo = (String) body.get("suspDtTo");

            StrReport strReport = caseService.escalateToStr(caseId, suspRsn, suspAmt, suspDtFrom, suspDtTo, userId);
            return ResponseEntity.ok(ApiResponse.ok(strReport, "STR 보고서가 생성되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }
}
