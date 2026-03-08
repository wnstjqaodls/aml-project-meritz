package com.aml.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface BatchSimulatorMapper {

    List<String> findRandomCustomers(@Param("limit") int limit);

    List<String> findRandomScenarios(@Param("limit") int limit);

    int insertNic66b(Map<String, Object> params);

    int insertNic70b(Map<String, Object> params);

    int insertNic73b(Map<String, Object> params);

    int insertNic75b(Map<String, Object> params);

    int insertNic67bDraft(Map<String, Object> params);

    int countExistingCase(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("sspsDlId") String sspsDlId);

    int countExistingNic70b(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("dlPRnmcno") String dlPRnmcno);

    // Count existing cases for today to determine sequence
    long countCasesForDate(
            @Param("sspsDlCrtDt") String sspsDlCrtDt,
            @Param("prefix") String prefix);
}
