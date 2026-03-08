package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class RaResultDetail {
    private Long raDtlId;
    private Long raId;
    private String raItemCd;
    private String itemVal;
    private BigDecimal itemScr;
    private BigDecimal itemWght;
    private BigDecimal itemLstScr;
    private LocalDateTime regDt;
}
