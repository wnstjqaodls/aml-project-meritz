package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class StrReport {
    private Long strId;
    private String strNo;
    private Long caseId;
    private String custNo;
    private String strDt;
    private String strStCd;
    private BigDecimal suspAmt;
    private String suspDtFrom;
    private String suspDtTo;
    private String suspRsn;
    private String fiuRptNo;
    private String fiuRptDt;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
