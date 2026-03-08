package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class WatchlistScreen {
    private Long screenId;
    private String custNo;
    private Long wlId;
    private BigDecimal matchScr;
    private String matchStCd;
    private LocalDateTime screenDt;
    private String reviewId;
    private LocalDateTime reviewDt;
    private String remark;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
