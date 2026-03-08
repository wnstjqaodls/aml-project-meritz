package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class RaResult {
    private Long raId;
    private String custNo;
    private String evalDt;
    private String raGrd;
    private BigDecimal raScr;
    private String eddYn;
    private String nextEvalDt;
    private String remark;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
