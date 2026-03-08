package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class Transaction {
    private Long trxnId;
    private String custNo;
    private String acctNo;
    private String trxnDt;
    private String trxnTm;
    private String trxnTpCd;
    private BigDecimal trxnAmt;
    private String trxnCcy;
    private String cntrpAcctNo;
    private String cntrpNm;
    private String cntrpBankCd;
    private String chnlCd;
    private String branchCd;
    private LocalDateTime regDt;
}
