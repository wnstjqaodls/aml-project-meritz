package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class CtrReport {
    private Long ctrId;
    private String ctrNo;
    private String custNo;
    private String trxnDt;
    private BigDecimal ctrAmt;
    private String ctrCcy;
    private String trxnTpCd;
    private String branchCd;
    private String ctrStCd;
    private String fiuRptNo;
    private String fiuRptDt;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
