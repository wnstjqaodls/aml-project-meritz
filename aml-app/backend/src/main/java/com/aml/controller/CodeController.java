package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.domain.Code;
import com.aml.service.CodeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/codes")
@RequiredArgsConstructor
public class CodeController {

    private final CodeService codeService;

    @GetMapping("/{group}")
    public ResponseEntity<ApiResponse<List<Code>>> getCodesByGroup(@PathVariable("group") String group) {
        List<Code> codes = codeService.getCodesByGroup(group);
        return ResponseEntity.ok(ApiResponse.ok(codes));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<Code>>> getAllCodes() {
        List<Code> codes = codeService.getAllCodes();
        return ResponseEntity.ok(ApiResponse.ok(codes));
    }
}
