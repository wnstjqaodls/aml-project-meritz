package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class Customer {
    private String custNo;
    private String custNm;
    private String custTpCd;
    private String birthDt;
    private String regNo;
    private String natCd;
    private String addr;
    private String tel;
    private String email;
    private String acctOpenDt;
    private String kycStCd;
    private String eddYn;
    private String riskGrd;
    private BigDecimal riskScr;
    private String useYn;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
