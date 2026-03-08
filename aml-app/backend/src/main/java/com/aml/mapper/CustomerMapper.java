package com.aml.mapper;

import com.aml.domain.Customer;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface CustomerMapper {

    Customer findById(@Param("custNo") String custNo);

    List<Customer> findByParams(Map<String, Object> params);

    long countByParams(Map<String, Object> params);

    int insert(Customer customer);

    int update(Customer customer);

    int updateRiskInfo(@Param("custNo") String custNo,
                       @Param("riskGrd") String riskGrd,
                       @Param("riskScr") java.math.BigDecimal riskScr,
                       @Param("eddYn") String eddYn,
                       @Param("updId") String updId);

    int updateKycStatus(@Param("custNo") String custNo,
                        @Param("kycStCd") String kycStCd,
                        @Param("updId") String updId);

    List<Customer> findHighRisk();
}
