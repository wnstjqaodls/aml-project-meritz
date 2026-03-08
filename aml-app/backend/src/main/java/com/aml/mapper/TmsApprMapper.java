package com.aml.mapper;

import com.aml.domain.TmsAppr;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TmsApprMapper {

    List<TmsAppr> findAll(
            @Param("apprStCd") String apprStCd,
            @Param("apprTpCd") String apprTpCd,
            @Param("offset") int offset,
            @Param("limit") int limit);

    int countAll(
            @Param("apprStCd") String apprStCd,
            @Param("apprTpCd") String apprTpCd);

    TmsAppr findById(@Param("apprId") Long apprId);

    int insert(TmsAppr appr);

    int update(TmsAppr appr);
}
