package com.aml.mapper;

import com.aml.domain.KycRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface KycMapper {

    KycRecord findById(@Param("kycId") Long kycId);

    List<KycRecord> findByCustNo(@Param("custNo") String custNo);

    List<KycRecord> findByParams(Map<String, Object> params);

    long countByParams(Map<String, Object> params);

    int insert(KycRecord kycRecord);

    int update(KycRecord kycRecord);

    long countPending();
}
