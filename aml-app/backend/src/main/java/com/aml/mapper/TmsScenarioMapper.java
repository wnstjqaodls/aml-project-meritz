package com.aml.mapper;

import com.aml.domain.TmsScenario;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TmsScenarioMapper {

    List<TmsScenario> findAll(
            @Param("scnrTpCd") String scnrTpCd,
            @Param("useYn") String useYn,
            @Param("offset") int offset,
            @Param("limit") int limit);

    int countAll(
            @Param("scnrTpCd") String scnrTpCd,
            @Param("useYn") String useYn);

    TmsScenario findById(@Param("scnrId") String scnrId);

    int insert(TmsScenario scenario);

    int update(TmsScenario scenario);
}
