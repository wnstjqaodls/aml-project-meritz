package com.aml.mapper;

import com.aml.domain.Transaction;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface TransactionMapper {

    Transaction findById(@Param("trxnId") Long trxnId);

    List<Transaction> findByParams(Map<String, Object> params);

    long countByParams(Map<String, Object> params);

    List<Transaction> findByCustNo(@Param("custNo") String custNo);

    int insert(Transaction transaction);

    List<Transaction> search(
            @Param("custNo") String custNo,
            @Param("acctNo") String acctNo,
            @Param("trxnTpCd") String trxnTpCd,
            @Param("dtFrom") String dtFrom,
            @Param("dtTo") String dtTo,
            @Param("amtMin") Long amtMin,
            @Param("amtMax") Long amtMax,
            @Param("offset") int offset,
            @Param("limit") int limit);

    int searchCount(
            @Param("custNo") String custNo,
            @Param("acctNo") String acctNo,
            @Param("trxnTpCd") String trxnTpCd,
            @Param("dtFrom") String dtFrom,
            @Param("dtTo") String dtTo,
            @Param("amtMin") Long amtMin,
            @Param("amtMax") Long amtMax);
}
