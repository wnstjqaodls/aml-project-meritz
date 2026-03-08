package com.aml.mapper;

import com.aml.domain.TmsStatsDaily;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TmsStatsDailyMapper {

    List<TmsStatsDaily> findRecentDays(@Param("days") int days);

    TmsStatsDaily findByDate(@Param("statsDt") String statsDt);
}
