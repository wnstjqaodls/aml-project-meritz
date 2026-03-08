package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class RaItem {
    private String raItemCd;
    private String raItemNm;
    private String raItemTp;
    private BigDecimal maxScr;
    private BigDecimal wght;
    private String useYn;
    private Integer ordNo;
    private LocalDateTime regDt;
}
