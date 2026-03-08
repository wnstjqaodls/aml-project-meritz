package com.aml.mapper;

import com.aml.domain.TmsAlert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface TmsAlertMapper {

    TmsAlert findById(@Param("alertId") Long alertId);

    List<TmsAlert> findByParams(Map<String, Object> params);

    long countByParams(Map<String, Object> params);

    int insert(TmsAlert alert);

    int update(TmsAlert alert);

    Map<String, Long> countByStatus();

    long countByStatusCd(@Param("alertStCd") String alertStCd);
}
