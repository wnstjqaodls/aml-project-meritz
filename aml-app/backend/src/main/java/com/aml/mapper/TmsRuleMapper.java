package com.aml.mapper;

import com.aml.domain.TmsRule;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TmsRuleMapper {

    TmsRule findById(@Param("ruleId") Long ruleId);

    TmsRule findByRuleCd(@Param("ruleCd") String ruleCd);

    List<TmsRule> findAll();

    List<TmsRule> findAllActive();

    int insert(TmsRule rule);

    int update(TmsRule rule);
}
