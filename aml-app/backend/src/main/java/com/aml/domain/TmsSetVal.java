package com.aml.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TmsSetVal {
    private Long setId;
    private String scnrId;
    private String setKey;
    private String setNm;
    private String setVal;
    private String prevVal;
    private String valTpCd;
    private String useYn;
    private String regId;
    private LocalDateTime regDt;
    private String updId;
    private LocalDateTime updDt;
}
