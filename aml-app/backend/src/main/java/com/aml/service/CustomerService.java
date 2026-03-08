package com.aml.service;

import com.aml.common.PageResult;
import com.aml.domain.Customer;
import com.aml.mapper.CustomerMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomerService {

    private final CustomerMapper customerMapper;

    @Transactional(readOnly = true)
    public PageResult<Customer> searchCustomers(String custNm, String custTpCd, String riskGrd,
                                                String kycStCd, int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("custNm", custNm);
        params.put("custTpCd", custTpCd);
        params.put("riskGrd", riskGrd);
        params.put("kycStCd", kycStCd);
        params.put("size", size);
        params.put("offset", offset);

        List<Customer> content = customerMapper.findByParams(params);
        long total = customerMapper.countByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public Customer getCustomer(String custNo) {
        Customer customer = customerMapper.findById(custNo);
        if (customer == null) {
            throw new IllegalArgumentException("고객을 찾을 수 없습니다: " + custNo);
        }
        return customer;
    }

    @Transactional
    public Customer createCustomer(Customer customer, String userId) {
        if (customerMapper.findById(customer.getCustNo()) != null) {
            throw new IllegalArgumentException("이미 존재하는 고객번호입니다: " + customer.getCustNo());
        }
        if (customer.getUseYn() == null) {
            customer.setUseYn("Y");
        }
        if (customer.getKycStCd() == null) {
            customer.setKycStCd("PENDING");
        }
        if (customer.getEddYn() == null) {
            customer.setEddYn("N");
        }
        customer.setRegId(userId);
        customerMapper.insert(customer);
        log.info("Customer created: {}", customer.getCustNo());
        return customerMapper.findById(customer.getCustNo());
    }

    @Transactional
    public Customer updateCustomer(String custNo, Customer customer, String userId) {
        Customer existing = customerMapper.findById(custNo);
        if (existing == null) {
            throw new IllegalArgumentException("고객을 찾을 수 없습니다: " + custNo);
        }
        customer.setCustNo(custNo);
        customer.setUpdId(userId);
        customerMapper.update(customer);
        log.info("Customer updated: {}", custNo);
        return customerMapper.findById(custNo);
    }

    @Transactional(readOnly = true)
    public List<Customer> getHighRiskCustomers() {
        return customerMapper.findHighRisk();
    }

    @Transactional
    public void updateKycStatus(String custNo, String kycStCd, String userId) {
        customerMapper.updateKycStatus(custNo, kycStCd, userId);
    }
}
