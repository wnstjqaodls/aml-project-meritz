package com.aml.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface CtrCaseMapper {

    List<Map<String, Object>> findCtrCases(Map<String, Object> params);

    long countCtrCases(Map<String, Object> params);

    Map<String, Object> findCaseInfo(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId);

    Map<String, Object> findPartyInfo(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("dlPRnmcno") String dlPRnmcno);

    List<Map<String, Object>> findTransactions(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId);

    List<Map<String, Object>> findAmounts(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId);

    Map<String, Object> findReport(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId);

    int updateCaseStatus(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId,
            @Param("rprPrgrsCcd") String rprPrgrsCcd,
            @Param("updId") String updId);

    int updateCaseFiu(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId,
            @Param("fiuRptNo") String fiuRptNo,
            @Param("fiuRptDt") String fiuRptDt,
            @Param("updId") String updId);

    long countCtrFiuSeq(@Param("dateStr") String dateStr);
}
