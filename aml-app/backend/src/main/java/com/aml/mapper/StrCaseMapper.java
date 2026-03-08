package com.aml.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface StrCaseMapper {

    List<Map<String, Object>> findStrCases(Map<String, Object> params);

    long countStrCases(Map<String, Object> params);

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

    List<Map<String, Object>> findApprovals(@Param("appNo") String appNo);

    // UPSERT report (NIC67B)
    int upsertReport(Map<String, Object> params);

    // Update NIC66B status/fields
    int updateCaseStatus(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId,
            @Param("rprPrgrsCcd") String rprPrgrsCcd,
            @Param("updId") String updId);

    int updateCaseInstId(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId,
            @Param("instId") String instId,
            @Param("updId") String updId);

    int updateCaseFiu(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId,
            @Param("fiuRptNo") String fiuRptNo,
            @Param("fiuRptDt") String fiuRptDt,
            @Param("updId") String updId);

    // AML_APPR insert
    int insertAppr(Map<String, Object> params);

    // AML_APPR update (approve/reject)
    int updateAppr(Map<String, Object> params);

    // AML_APPR_HIST insert
    int insertApprHist(Map<String, Object> params);

    // TMS_SET_VAL_APP insert
    int insertSetValApp(Map<String, Object> params);

    // INST_ID(결재번호)로 NIC66B 상태 업데이트
    int updateStatusByInstId(
            @Param("instId") String instId,
            @Param("rprPrgrsCcd") String rprPrgrsCcd,
            @Param("updId") String updId);

    // Sequence helpers
    Integer maxApprSeq(@Param("appNo") String appNo);

    long countStrAppNo(@Param("dateStr") String dateStr);
}
