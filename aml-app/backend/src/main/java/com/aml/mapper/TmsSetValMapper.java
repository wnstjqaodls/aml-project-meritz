package com.aml.mapper;

import com.aml.domain.TmsSetVal;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TmsSetValMapper {

    List<TmsSetVal> findByScnrId(@Param("scnrId") String scnrId);

    List<TmsSetVal> findAll(
            @Param("scnrId") String scnrId,
            @Param("offset") int offset,
            @Param("limit") int limit);

    int countAll(@Param("scnrId") String scnrId);

    TmsSetVal findById(@Param("setId") Long setId);

    int update(TmsSetVal setVal);

    int insert(TmsSetVal setVal);
}
