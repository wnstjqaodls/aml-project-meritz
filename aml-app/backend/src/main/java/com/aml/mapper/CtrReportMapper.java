package com.aml.mapper;

import com.aml.domain.CtrReport;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface CtrReportMapper {

    CtrReport findById(@Param("ctrId") Long ctrId);

    List<CtrReport> findByParams(Map<String, Object> params);

    long countByParams(Map<String, Object> params);

    int insert(CtrReport ctrReport);

    int update(CtrReport ctrReport);
}
