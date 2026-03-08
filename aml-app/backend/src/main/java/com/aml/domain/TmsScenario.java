package com.aml.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TmsScenario {
    private String scnrId;
    private String scnrNm;
    private String scnrNmEn;
    private String scnrTpCd;
    private String scnrCatCd;
    private Integer periodDay;
    private BigDecimal thresholdAmt;
    private Integer thresholdCnt;
    private String alertYn;
    private String useYn;
    private Long lstAppNo;
    private String remark;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
