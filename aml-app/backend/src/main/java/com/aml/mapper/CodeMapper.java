package com.aml.mapper;

import com.aml.domain.Code;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CodeMapper {

    List<Code> findByGroup(@Param("codeGrp") String codeGrp);

    List<Code> findAll();

    int insert(Code code);
}
