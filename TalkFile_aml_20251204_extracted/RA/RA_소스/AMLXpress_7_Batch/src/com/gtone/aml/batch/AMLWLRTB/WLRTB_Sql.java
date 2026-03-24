package com.gtone.aml.batch.AMLWLRTB;

/**
 *<pre>
 * WATCHLIST(요주의 인물) 결과 추출 배치 쿼리 클래스
 * @en
 *</pre>
 *@author 
 *@version 1.0
 *@history 1.0
 */
public class WLRTB_Sql {
    
    /**
     * <pre>
     * 고객별 Watchlist 목록이 이전 전송 Watchlist 목록과 동일(전체)하면 전송하지 않음
     * 고객별 Watchlist 목록이 존재하지 않을 경우에도 전송하지 않음
     * 이외의 고객은 모두 전송한다.
     * 
     * 테이블: 
     *         WATCH목록검색결과(NIC21B)
     *         WATCH목록관련검색결과(NIC22B)
     * @en
     * </pre>
     */
    public static final String WLRTB_SELECT_NIC2XB_001
    		= "WITH TRGT_D_BASE                                                                                                 			"
    		+ "AS ( SELECT TO_DATE(?, 'YYYYMMDD') AS CUR_DT                                                                     			"
    		+ "       FROM DUAL)                                                                                                			"
    		+ ",    TRGT_NIC21B_DT                                                                                              			"
    		+ "AS (                                                                                                             			"
    		+ "    SELECT TO_CHAR(TDB.CUR_DT, 'YYYYMMDD') AS SEND_TRGT_DT                                                       			"
    		+ "         , MAX(NIC21.SRCH_RSLT_DT) AS SRCH_RSLT_DT                                                               			"
    		+ "      FROM TRGT_D_BASE TDB                                                                                       			"
    		+ "         , NIC21B      NIC21                                                                                     			"
    		+ "     WHERE 1 = 1                                                                                                 			"
    		+ "       AND NIC21.SRCH_RSLT_DT(+) <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                              			"
    		+ "       AND NIC21.SRCH_RSLT_DT(+) >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -2), 'YYYYMM') || '01'                        			"
    		+ "     GROUP BY  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD') )                      														"
    		+ ",    TRGT_T_WLST                                                                                                 			"
    		+ "AS (                                                                                                             			"
    		+ "    SELECT DISTINCT                                                                                              			"
    		+ "           SEND_TRGT_DT, RNMCNO                                                                                  			"
    		+ "      FROM (                                                                                                     			"
    		+ "            SELECT /* 전송대상 목록 */                                                                           				"
    		+ "                   TND.SEND_TRGT_DT                                                                              			"
    		+ "                 , NIC21.RNMCNO, NIC22.MNG_SNO, NIC22.CS_NM                                                      			"
    		+ "              FROM TRGT_NIC21B_DT TND                                                                            			"
    		+ "                 , NIC21B         NIC21                                                                          			"
    		+ "                 , NIC01B         NIC01                                                                          			"
    		+ "                 , NIC22B         NIC22                                                                          			"
    		+ "             WHERE 1 = 1                                                                                         			"
    		+ "               AND NIC21.SRCH_RSLT_DT = TND.SEND_TRGT_DT                                                         			"
    		+ "               AND NIC01.RNMCNO = NIC21.RNMCNO                                                                   			"
    		+ "               AND NIC22.SRCH_RSLT_DT = NIC21.SRCH_RSLT_DT                                                       			"
    		+ "               AND NIC22.SQ = NIC21.SQ                                                                           			"
    		+ "            MINUS                                                                                                			"
    		+ "            SELECT /* 이전 전송대상 목록 */                                                                      					"
    		+ "                   TND.SEND_TRGT_DT                                                                              			"
    		+ "                 , NIC21.RNMCNO, NIC22.MNG_SNO, NIC22.CS_NM                                                      			"
    		+ "              FROM TRGT_NIC21B_DT TND                                                                            			"
    		+ "                 , NIC21B         NIC21                                                                          			"
    		+ "                 , NIC01B         NIC01                                                                          			"
    		+ "                 , NIC22B         NIC22                                                                          			"
    		+ "             WHERE 1 = 1                                                                                         			"
    		+ "               AND NIC21.SRCH_RSLT_DT = TND.SRCH_RSLT_DT                                                         			"
    		+ "               AND NIC01.RNMCNO = NIC21.RNMCNO                                                                   			"
    		+ "               AND NIC22.SRCH_RSLT_DT = NIC21.SRCH_RSLT_DT                                                       			"
    		+ "               AND NIC22.SQ = NIC21.SQ))                                                                         			"
    		+ ",    TRGT_R_WLST                                                                                                 			"
    		+ "AS (                                                                                                             			"
    		+ "    SELECT NIC21.SRCH_RSLT_DT, NIC21.SQ, NIC01.RNMCNO, NIC01.CS_MANAG_BRN_CD                                    				"
    		+ "      FROM TRGT_T_WLST TTW                                                                                       			"
    		+ "         , NIC21B      NIC21                                                                                     			"
    		+ "         , NIC01B      NIC01                                                                                     			"
    		+ "     WHERE 1 = 1                                                                                                 			"
    		+ "       AND NIC21.SRCH_RSLT_DT = TTW.SEND_TRGT_DT                                                                 			"
    		+ "       AND NIC21.RNMCNO = TTW.RNMCNO                                                                             			"
    		+ "       AND NIC01.RNMCNO = NIC21.RNMCNO)                                                                          			"
    		+ "SELECT NIC21.DATA_FG                                                                          								"
    		+ "     , NIC21.RNMCNO|| '||' ||NIC21.SRCH_RSLT_DT|| '||' ||NIC21.SQ|| '||' ||NIC21.SRCH_RQS_CCD                                "
    		+ "       || '||' ||NIC21.NTV_FGNR_CCD|| '||' ||NIC21.RNM_CCD                                                       			"
    		+ "       || '||' ||NIC21.NTN_CD|| '||' ||NIC21.CS_NM|| '||' ||NIC21.BSC_ADDR|| '||' ||NIC21.DNG_FLWG_ADDR          			"
    		+ "       || '||' ||NIC21.CS_NO|| '||' ||NIC21.WC_LIST_CCD|| '||' ||NIC21.RSLT_BRN_CD                               			"
    		+ "       || '||' ||NIC21.DCSN_YN|| '||' ||NIC21.PSBL_YN|| '||' ||NIC21.RSN_CNTNT|| '||' ||NIC21.MNG_SNO \r\n"
    		+ "     , NIC21.SRCH_RSLT_DT                                                                                        				"
    		+ "     , NIC21.SQ 																													"
    		+ "  FROM (																															"
    		+ "        SELECT DISTINCT NIC21.RNMCNO																								"
    		+ "            , 'NIC21' AS DATA_FG                                                                                        			"
    		+ "            , NIC21.SRCH_RSLT_DT																									"
    		+ "            , NIC21.SQ																											"
    		+ "            , NIC21.SRCH_RQS_CCD                    																				"
    		+ "            , NIC21.NTV_FGNR_CCD																									"
    		+ "            , NIC21.RNM_CCD                                                       												"
    		+ "            , NIC21.NTN_CD																										"
    		+ "            , NIC21.CS_NM																										"
    		+ "            , NIC21.BSC_ADDR																										"
    		+ "            , NIC21.DNG_FLWG_ADDR          																						"
    		+ "            , NIC21.CS_NO																										"
    		+ "            , NIC21.WC_LIST_CCD																									"
    		+ "            , NIC21.RSLT_BRN_CD                               																	"
    		+ "            , NIC21.DCSN_YN 																										"
    		+ "            , NIC21.PSBL_YN "
    		+ "            , NIC21.RSN_CNTNT																								\r\n"
    		+ "            , NIC22.MNG_SNO						\r\n"    		
    		+ "        FROM TRGT_R_WLST TRW                                                                                           			\r\n"
    		+ "            , NIC21B NIC21, NIC22B NIC22                                                                                            \r\n"
    		+ "       WHERE 1 = 1                                                                                                     			\r\n"
    		+ "         AND NIC21.SRCH_RSLT_DT = TRW.SRCH_RSLT_DT                                                                     			\r\n"
    		+ "         AND NIC21.SQ = TRW.SQ                                                                                         			\r\n"
    		+ "         AND NIC21.RNMCNO = TRW.RNMCNO                                                                                         	\r\n"
    		+ "         AND NIC21.SQ = NIC22.SQ                                                                     								\r\n"
    		+ "         AND NIC21.RNMCNO = NIC22.RNMCNO                                                                                        	\r\n"
    		+ "         AND NIC21.SRCH_RSLT_DT = NIC22.SRCH_RSLT_DT                                                                               \r\n"
    		+ "         AND NIC21.WC_LIST_CCD NOT IN ('W130')                                                                                        "
    		+ ") NIC21              "
    		+ "UNION ALL                                                                                                        			"
    		+ "SELECT 'NIC22' AS DATA_FG                                                                                        			"
    		+ "     , NIC22.SRCH_RSLT_DT|| '||' ||NIC22.SQ|| '||' ||NIC22.MNG_SNO|| '||' ||NIC22.WC_LIST_CCD                    			"
    		+ "       || '||' ||NIC22.CS_NM|| '||' ||NIC22.CHC_YN|| '||' ||NIC22.HIT_R                                          			"
    		+ "       || '||' ||NIC22.INDV_CORP_CCD|| '||' ||TRW.RNMCNO|| '||' ||NIC22.NTNLT_CD                               				"
    		+ "       || '||' ||NIC22.ADDR|| '||' ||NIC22.WL_BIRTHDAY                                                                       "
    		+ "     , NIC22.SRCH_RSLT_DT                                                                                        			"
    		+ "     , NIC22.SQ                                                                                                  			"
    		+ "  FROM TRGT_R_WLST TRW                                                                                           			"
    		+ "     , NIC22B NIC22                                                                                              			"
    		+ " WHERE 1 = 1                                                                                                     			"
    		+ "   AND NIC22.SRCH_RSLT_DT = TRW.SRCH_RSLT_DT                                                                     			"
    		+ "   AND NIC22.SQ = TRW.SQ                                                                                         			"
    		+ "   AND NIC22.RNMCNO = TRW.RNMCNO                                                                                         			"
    		+"    AND NIC22.WC_LIST_CCD NOT IN ('W130')                                                                                       "
    		;
    
    
    public static final String WLRTB_UPDATE_NIC21B_001
    		= " UPDATE NIC21B                                                                                                   			"
    		+ "    SET ETC1 = 'Y'   /* 비고1-전송여부 */                                                                        				"
    		+ "      , ETC2 = ?     /* 비고2-전송처리일자 */                                                                    					"
    		+ "  WHERE 1 = 1                                                                                                    			"
    		+ "    AND SRCH_RSLT_DT = ?                                                                                         			"
    		+ "    AND SQ = ?                                                                                                   			";
    

}