package com.aml.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class WatchlistEntry {
    private Long wlId;
    private String wlSrcCd;
    private String wlTpCd;
    private String wlNm;
    private String wlNmAlias;
    private String birthDt;
    private String natCd;
    private String sanctionTp;
    private String listDt;
    private String useYn;
    private Long updSeq;
    private LocalDateTime regDt;
}
