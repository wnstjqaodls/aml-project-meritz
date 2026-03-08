package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class TmsAlert {
    private Long alertId;
    private String alertNo;
    private Long ruleId;
    private String custNo;
    private String alertDt;
    private String alertStCd;
    private BigDecimal detectAmt;
    private Integer detectCnt;
    private BigDecimal riskScr;
    private String assignId;
    private String closeDt;
    private String closeRsnCd;
    private String remark;
    private Long caseId;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
