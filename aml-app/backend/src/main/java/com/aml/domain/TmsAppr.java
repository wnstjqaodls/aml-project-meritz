package com.aml.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TmsAppr {
    private Long apprId;
    private String apprNo;
    private String apprTpCd;
    private String refId;
    private String apprTitle;
    private String apprContent;
    private String apprStCd;
    private String reqId;
    private LocalDateTime reqDt;
    private String apprUsrId;
    private LocalDateTime apprDt;
    private String apprCmnt;
    private String rejectRsn;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
