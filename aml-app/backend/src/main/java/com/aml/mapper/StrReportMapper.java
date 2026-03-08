package com.aml.mapper;

import com.aml.domain.StrReport;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface StrReportMapper {

    StrReport findById(@Param("strId") Long strId);

    List<StrReport> findByParams(Map<String, Object> params);

    long countByParams(Map<String, Object> params);

    int insert(StrReport strReport);

    int update(StrReport strReport);
}
