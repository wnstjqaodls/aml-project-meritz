package com.aml.domain;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class RaItem {
    /** RA 항목 코드 (PK) */
    private String raItemCd;
    /** RA 항목 명 */
    private String raItemNm;
    /** 위험평가모델 구분코드 (RA_MDL_GBN_CD) */
    private String raMdlGbnCd;
    /** 참조 공통코드 (REFF_COMN_CD) */
    private String reffComnCd;
    /** 결측값 점수 - KYC/고객 정보가 없을 때 사용하는 기본 점수 (MISS_VAL_SCR) */
    private BigDecimal missValScr;
    /** 구간값 여부 (INTV_VAL_YN): Y=구간기준, N=코드기준 */
    private String intvValYn;
    /** 사용여부 (USE_YN) */
    private String useYn;
    /** 정렬순서 (SRT_SQ) */
    private Integer srtSq;
    /** 최종결재번호 (LST_APP_NO) */
    private String lstAppNo;
    /** 등록일시 */
    private LocalDateTime regDt;
}
