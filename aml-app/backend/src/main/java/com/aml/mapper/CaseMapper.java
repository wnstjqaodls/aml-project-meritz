package com.aml.mapper;

import com.aml.domain.Case;
import com.aml.domain.CaseComment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface CaseMapper {

    Case findById(@Param("caseId") Long caseId);

    Case findByCaseNo(@Param("caseNo") String caseNo);

    List<Case> findByParams(Map<String, Object> params);

    long countByParams(Map<String, Object> params);

    int insert(Case aCase);

    int update(Case aCase);

    int insertComment(CaseComment comment);

    List<CaseComment> findCommentsByCaseId(@Param("caseId") Long caseId);

    long countByStatusCd(@Param("caseStCd") String caseStCd);
}
