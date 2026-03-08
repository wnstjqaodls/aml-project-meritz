package com.aml.service;

import com.aml.common.PageResult;
import com.aml.domain.KycRecord;
import com.aml.mapper.CustomerMapper;
import com.aml.mapper.KycMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class KycService {

    private final KycMapper kycMapper;
    private final CustomerMapper customerMapper;

    @Transactional(readOnly = true)
    public PageResult<KycRecord> searchKyc(String custNo, String kycStCd, String kycTpCd,
                                            int page, int size) {
        int offset = (page - 1) * size;
        Map<String, Object> params = new HashMap<>();
        params.put("custNo", custNo);
        params.put("kycStCd", kycStCd);
        params.put("kycTpCd", kycTpCd);
        params.put("size", size);
        params.put("offset", offset);

        List<KycRecord> content = kycMapper.findByParams(params);
        long total = kycMapper.countByParams(params);
        return new PageResult<>(content, page, size, total);
    }

    @Transactional(readOnly = true)
    public KycRecord getKyc(Long kycId) {
        KycRecord record = kycMapper.findById(kycId);
        if (record == null) {
            throw new IllegalArgumentException("KYC 기록을 찾을 수 없습니다: " + kycId);
        }
        return record;
    }

    @Transactional(readOnly = true)
    public List<KycRecord> getKycByCustNo(String custNo) {
        return kycMapper.findByCustNo(custNo);
    }

    @Transactional
    public KycRecord createKyc(KycRecord kycRecord, String userId) {
        if (customerMapper.findById(kycRecord.getCustNo()) == null) {
            throw new IllegalArgumentException("고객을 찾을 수 없습니다: " + kycRecord.getCustNo());
        }
        if (kycRecord.getKycStCd() == null) {
            kycRecord.setKycStCd("IN_PROGRESS");
        }
        if (kycRecord.getPepYn() == null) {
            kycRecord.setPepYn("N");
        }
        if (kycRecord.getBeneficialYn() == null) {
            kycRecord.setBeneficialYn("N");
        }
        kycRecord.setRegId(userId);
        kycMapper.insert(kycRecord);
        log.info("KYC created for customer: {}", kycRecord.getCustNo());
        return kycMapper.findById(kycRecord.getKycId());
    }

    @Transactional
    public KycRecord updateKyc(Long kycId, KycRecord kycRecord, String userId) {
        KycRecord existing = kycMapper.findById(kycId);
        if (existing == null) {
            throw new IllegalArgumentException("KYC 기록을 찾을 수 없습니다: " + kycId);
        }
        kycRecord.setKycId(kycId);
        kycRecord.setCustNo(existing.getCustNo());
        kycRecord.setUpdId(userId);
        kycMapper.update(kycRecord);

        // When KYC is completed, update customer KYC status
        if ("COMPLETE".equals(kycRecord.getKycStCd())) {
            customerMapper.updateKycStatus(existing.getCustNo(), "COMPLETE", userId);
        }
        log.info("KYC updated: {}", kycId);
        return kycMapper.findById(kycId);
    }

    @Transactional(readOnly = true)
    public long countPendingKyc() {
        return kycMapper.countPending();
    }
}
