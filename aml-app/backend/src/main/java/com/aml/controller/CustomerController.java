package com.aml.controller;

import com.aml.common.ApiResponse;
import com.aml.common.PageResult;
import com.aml.domain.Customer;
import com.aml.service.CustomerService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api/customers")
@RequiredArgsConstructor
public class CustomerController {

    private final CustomerService customerService;

    @GetMapping
    public ResponseEntity<ApiResponse<PageResult<Customer>>> searchCustomers(
            @RequestParam(required = false) String custNm,
            @RequestParam(required = false) String custTpCd,
            @RequestParam(required = false) String riskGrd,
            @RequestParam(required = false) String kycStCd,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size) {

        PageResult<Customer> result = customerService.searchCustomers(custNm, custTpCd, riskGrd, kycStCd, page, size);
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Customer>> createCustomer(
            @RequestBody Customer customer,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            Customer created = customerService.createCustomer(customer, userId);
            return ResponseEntity.ok(ApiResponse.ok(created, "고객이 등록되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        }
    }

    @GetMapping("/{custNo}")
    public ResponseEntity<ApiResponse<Customer>> getCustomer(@PathVariable String custNo) {
        try {
            Customer customer = customerService.getCustomer(custNo);
            return ResponseEntity.ok(ApiResponse.ok(customer));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }

    @PutMapping("/{custNo}")
    public ResponseEntity<ApiResponse<Customer>> updateCustomer(
            @PathVariable String custNo,
            @RequestBody Customer customer,
            @RequestHeader(value = "X-User-Id", defaultValue = "system") String userId) {

        try {
            Customer updated = customerService.updateCustomer(custNo, customer, userId);
            return ResponseEntity.ok(ApiResponse.ok(updated, "고객 정보가 수정되었습니다."));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(404).body(ApiResponse.error(e.getMessage()));
        }
    }
}
