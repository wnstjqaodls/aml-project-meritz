package com.aml.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class KycRecord {
    private Long kycId;
    private String custNo;
    private String kycTpCd;
    private String kycStCd;
    private String idTpCd;
    private String idNo;
    private String idExpireDt;
    private String purposeCd;
    private String fundSrcCd;
    private String pepYn;
    private String beneficialYn;
    private String kycDt;
    private String nextKycDt;
    private String remark;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
