package com.aml.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Case {
    private Long caseId;
    private String caseNo;
    private String caseTpCd;
    private String caseStCd;
    private String custNo;
    private String openDt;
    private String closeDt;
    private String priorityCd;
    private String assignId;
    private String strYn;
    private String ctrYn;
    private String remark;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
