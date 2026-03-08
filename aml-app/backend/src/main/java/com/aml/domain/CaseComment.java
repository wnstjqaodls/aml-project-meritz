package com.aml.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class CaseComment {
    private Long cmtId;
    private Long caseId;
    private String cmtText;
    private String regId;
    private LocalDateTime regDt;
}
