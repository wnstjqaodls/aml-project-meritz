package com.aml.mapper;

import com.aml.domain.RaItem;
import com.aml.domain.RaResult;
import com.aml.domain.RaResultDetail;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface RaMapper {

    List<RaItem> findAllItems();

    List<RaItem> findActiveItems();

    RaItem findItemById(@Param("raItemCd") String raItemCd);

    String findGradeByScore(@Param("raScr") java.math.BigDecimal raScr);

    int insertResult(RaResult result);

    int insertResultDetail(RaResultDetail detail);

    RaResult findResultById(@Param("raId") Long raId);

    List<RaResult> findResultByParams(Map<String, Object> params);

    long countResultByParams(Map<String, Object> params);

    List<RaResultDetail> findDetailsByRaId(@Param("raId") Long raId);

    RaResult findLatestResultByCustNo(@Param("custNo") String custNo);

    int updateResultScores(RaResult result);
}
