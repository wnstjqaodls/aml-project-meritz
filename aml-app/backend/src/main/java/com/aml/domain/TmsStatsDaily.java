package com.aml.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TmsStatsDaily {
    private String statsDt;
    private Integer totalAlerts;
    private Integer newAlerts;
    private Integer reviewAlerts;
    private Integer closedAlerts;
    private Integer strCount;
    private Integer ctrCount;
    private Integer highRiskCount;
    private BigDecimal totalDetectAmt;
}
