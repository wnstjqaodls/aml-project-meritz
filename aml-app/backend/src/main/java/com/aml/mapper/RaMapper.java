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

    /** RA_ITEM 전체 조회 (관리 화면용) */
    List<RaItem> findAllItems();

    /** USE_YN='Y' 인 활성 항목 조회 (평가 엔진용) */
    List<RaItem> findActiveItems();

    /** 단건 조회 */
    RaItem findItemById(@Param("raItemCd") String raItemCd);

    /**
     * 위험평가모델별 가중치 조회 (RA_ITEM_WGHT JOIN RA_ITEM).
     * 반환 컬럼: RA_ITEM_CD, RA_MDL_GBN_CD, WGHT, MAX_SCR, USE_YN, RA_ITEM_NM
     */
    List<Map<String, Object>> findItemWeights(@Param("raMdlGbnCd") String raMdlGbnCd);

    /** 점수 → 등급 변환 (RA_GRD_STD) */
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
