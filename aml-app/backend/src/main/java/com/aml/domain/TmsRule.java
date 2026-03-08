package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class TmsRule {
    private Long ruleId;
    private String ruleCd;
    private String ruleNm;
    private String ruleTpCd;
    private BigDecimal thresholdAmt;
    private Integer thresholdCnt;
    private Integer periodDay;
    private String useYn;
    private String remark;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
