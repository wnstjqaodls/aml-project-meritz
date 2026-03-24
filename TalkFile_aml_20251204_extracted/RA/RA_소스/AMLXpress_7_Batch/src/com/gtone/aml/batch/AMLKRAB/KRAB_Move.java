/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLKRAB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.gtone.aml.batch.AMLKRAB.KRAB_MoveAbstract;
import com.gtone.aml.batch.common.Config;
import com.gtone.aml.batch.common.util.AML_Log;
import com.gtone.aml.batch.common.util.DBUtil;
import com.gtone.aml.batch.common.util.Timer;

/**
*
*<pre>
* KYC RA의 결과를 DB에 insert하는 class
* KYC RAの結果をDBにInsertするクラス
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public class KRAB_Move extends KRAB_MoveAbstract {
    private final static String KYC_TMS_CCD = "K";
    private long m_nCounter = 0;
    private long m_TotalCount = 0;

    private ArrayList<PreparedStatement> m_pstmtList = null;
    private PreparedStatement pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001 = null;
    private PreparedStatement pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_001 = null;
    //private PreparedStatement pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_002 = null;

    private PreparedStatement pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001 = null;
    //private PreparedStatement pstmt_KRAB_INSERT_RA_SMUL_RSLT_001 = null;
    PreparedStatement pstmt_KRAB_UPDATE_NIC35B = null;

    KRAB_Sql KRAB_Sql = null;
    @SuppressWarnings("static-access")
	public KRAB_Move() {
    	KRAB_Sql = KRAB_Sql.getInstance();
	}

    /**
     * <pre>
     * 초기화, 주요  Statement를 생성함.
     * 初期化、主要Statementを生成する。
     * @en
     * </pre>
     *@param ruleUtil
     *@param connection
     *@throws Exception
     */
    public void initialize(Connection connection) throws SQLException {
        conn = connection;
        m_pstmtList = new ArrayList<PreparedStatement>();

        pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001 = conn.prepareStatement(getQuery_INSERT_RA_CS_RA_RSLT_DTL_001());
        m_pstmtList.add(pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001);

    }

    protected String getQuery_INSERT_RA_CS_RA_RSLT_DTL_001() {
    	return KRAB_Sql.KRAB_INSERT_RA_CS_RA_RSLT_DTL_001();
    }

    protected String getQuery_SELECT_RA_CS_RA_RSLT_DTL_001() {
    	return KRAB_Sql.KRAB_SELECT_RA_CS_RA_RSLT_DTL_001();
    }

    protected String getQuery_SELECT_RA_CS_RA_RSLT_DTL_002() {
    	return KRAB_Sql.KRAB_SELECT_RA_CS_RA_RSLT_DTL_002();
    }

    protected String getQuery_INSERT_RA_CS_RA_RSLT_001() {
    	return KRAB_Sql.KRAB_INSERT_RA_CS_RA_RSLT_001();
    }
 
    protected String getQuery_INSERT_RA_SMUL_RSLT_001() {
    	return KRAB_Sql.KRAB_INSERT_RA_SMUL_RSLT_001();
    }
    protected String getQuery_UPDATE_NIC35B()
    {
        return KRAB_Sql.KRAB_UPDATE_NIC35B_001();
    }

    /**
     * <pre>
     * 아직 execute하지 않은 Batch를 execute하고 Statement를 close함.
     * まだ実行していないバッチを実行し、Statementをクローズする。
     * @en
     * </pre>
     *@throws Exception
     */
    public void close() throws SQLException {
        execBatch();

        for (int i = 0; i < m_pstmtList.size(); i++)
            DBUtil.close(m_pstmtList.get(i));
    }

    
    public String getMainAllQuery(String flag) throws NullPointerException {
    	String rtnString;
        String allQuery;
        String modelGubn;
        //String sTrgtRnmcnoSql = "";
        final String forOracle =
        	  "SELECT RNMCNO\r\n"
    		+ "     , CS_TYP_CD\r\n"
    		+ "     , RA_ITEM_CD\r\n"
    		+ "     , RA_ITEM_NM\r\n"
    		+ "     , RA_MDL_GBN_CD\r\n"
    		+ "     , MISS_VAL_SCR\r\n"
    		+ "     , RA_ID\r\n"
    		+ "     , NEW_OLD_GBN_CD\r\n"
    		+ "     , ABS_HRSK_YN\r\n"
    		+ "     , RA_ITEM_VAL\r\n"
    		+ "     , RA_ITEM_WGHT\r\n"
    		+ "     , RA_ITEM_SCR\r\n"
    		+ "     , RA_ITEM_SCR * RA_ITEM_WGHT AS RA_ITEM_LST_SCR\r\n"
    		+ "  FROM (																																		\r\n"
    		+ "         WITH T_RA_ITEM_WGHT AS (																											\r\n"
    		+ "             SELECT A.RA_ITEM_CD																												\r\n"
    		+ "                  , A.RA_ITEM_NM																												\r\n"
    		+ "                  , A.RA_MDL_GBN_CD																											\r\n"
    		+ "                  , A.INTV_VAL_YN																											\r\n"
    		+ "                  , A.MISS_VAL_SCR																											\r\n"
    		+ "                  , ? AS RA_ID																												\r\n"
    		+ "                  , B.CS_TYP_CD																												\r\n"
    		+ "                  , B.NEW_OLD_GBN_CD																											\r\n"
    		+ "                  , B.RA_ITEM_WGHT																											\r\n"
    		+ "               FROM RA_ITEM A																												\r\n"
    		+ "               LEFT JOIN RA_ITEM_WGHT B																										\r\n"
    		+ "                 ON A.RA_ITEM_CD = B.RA_ITEM_CD																								\r\n"
    		+ "              WHERE A.USE_YN = 'Y'																											\r\n"
    		+ "                AND A.RA_MDL_GBN_CD IN (?, ?) -- PARAM2 모델구분 I, B																			\r\n"
    		+ "                AND A.RA_ITEM_CD NOT IN ('I009','I011','I012','I013','I014','I018')															\r\n"
    		+ "              UNION ALL																														\r\n"
    		+ "             SELECT RA_ITEM_CD																												\r\n"
    		+ "                  , RA_ITEM_NM																												\r\n"
    		+ "                  , RA_MDL_GBN_CD																											\r\n"
    		+ "                  , INTV_VAL_YN																												\r\n"
    		+ "                  , MISS_VAL_SCR																												\r\n"
    		+ "                  , ? AS RA_ID																												\r\n"
    		+ "                  , '01' AS CS_TYP_CD																										\r\n"
    		+ "                  , 'B' AS NEW_OLD_GBN_CD																									\r\n"
    		+ "                  , 1 AS RA_ITEM_WGHT																										\r\n"
    		+ "               FROM RA_ITEM																													\r\n"
    		+ "              WHERE RA_ITEM_CD IN ('I009','I011','I012','I013','I014','I018')																\r\n"
    		+ "              UNION ALL																														\r\n"
    		+ "             SELECT RA_ITEM_CD																												\r\n"
    		+ "                  , RA_ITEM_NM																												\r\n"
    		+ "                  , RA_MDL_GBN_CD																											\r\n"
    		+ "                  , INTV_VAL_YN																												\r\n"
    		+ "                  , MISS_VAL_SCR																												\r\n"
    		+ "                  , ? AS RA_ID																												\r\n"
    		+ "                  , '02' AS CS_TYP_CD																										\r\n"
    		+ "                  , 'B' AS NEW_OLD_GBN_CD																									\r\n"
    		+ "                  , 1 AS RA_ITEM_WGHT																										\r\n"
    		+ "               FROM RA_ITEM																													\r\n"
    		+ "              WHERE RA_ITEM_CD IN ('I009','I011','I012','I013','I014','I018')																\r\n"
    		+ "         )																																	\r\n"
    		+ "       , TRGT_D_BASE AS 																														\r\n"
    		+ "       ( SELECT /*+ MATERIALIZE */ TO_DATE(SUBSTR(?, 1, 6) || '01', 'YYYYMMDD') AS CUR_DT FROM DUAL )										\r\n"
    		+ "       , TRGT_RNMCNO AS 																														\r\n"
    		+ "       ( /* 전체고객 */ SELECT DISTINCT NIC35.RNMCNO, NIC01.INDV_CORP_CCD, NIC01.NTN_CD, NIC01.CS_NO FROM NIC35B NIC35, NIC01B NIC01, NIC17B NIC17 WHERE NIC35.RNMCNO = NIC01.RNMCNO AND NIC01.RNMCNO = NIC17.RNMCNO AND NIC01.CS_ST_CD = '0' AND NIC17.AC_ST_CCD = '1') \r\n"
    		+ "       , TRGT_HNWI AS 																														\r\n"
    		+ "       ( /* 고액자산가 여:'02' 부:'01' */                                                                                                        \r\n"
    		+ "          SELECT TR.RNMCNO                                                                                                                   \r\n"
    		+ "               , TR.INDV_CORP_CCD                                                                                                            \r\n"
    		+ "               , TR.NTN_CD                                                                                                                   \r\n"
    		+ "               , NVL2(NIC40.RNMCNO,'02','01') AS HNWI_YN                                                                                     \r\n"
    		+ "            FROM TRGT_RNMCNO TR                                                                                                              \r\n"
    		+ "            LEFT JOIN (SELECT RNMCNO, MAX(EXTRACT_DT) FROM NIC40B GROUP BY RNMCNO) NIC40                                                     \r\n"
    		+ "              ON NIC40.RNMCNO = TR.RNMCNO                                                                                                    \r\n"
    		+ "       )																																		\r\n"
    		+ "       , TRGT_BLLS AS																														\r\n"
    		+ "       ( /* 당사지정 요주의인물 */																													\r\n"
    		+ "         SELECT TR.RNMCNO																													\r\n"
    		+ "              , TR.INDV_CORP_CCD																												\r\n"
    		+ "              , TR.NTN_CD																													\r\n"
    		+ "              , NVL2(B.RNMCNO,'02','01') AS BLLS_YN																							\r\n"
    		+ "           FROM TRGT_RNMCNO TR																												\r\n"
    		+ "           LEFT JOIN (																														\r\n"
    		+ "                       SELECT CLNT_ENTY_ID AS RNMCNO																							\r\n"
    		+ "                         FROM SID.IDO_A_MAH_BLLS_PRS_IFMN																					\r\n"
    		+ "                        WHERE 1 = 1																											\r\n"
    		+ "                          AND DEL_YN <> 'Y' /* 삭제여부 */   																					\r\n"
    		+ "                     ) B																														\r\n"
    		+ "                  ON B.RNMCNO = TR.RNMCNO																									\r\n"
    		+ "       )																																		\r\n"
    		+ "       , TRGT_POITSP AS 																														\r\n"
    		+ "       ( /* 요주의인물 동일인 */  																												\r\n"
    		+ "          SELECT TR.RNMCNO                                                                                                                   \r\n"
    		+ "                , TR.INDV_CORP_CCD                                                                                                           \r\n"
    		+ "                , TR.NTN_CD                                                                                                                  \r\n"
    		+ "                , NVL2(B.RNMCNO,'02','01') AS POITSP_YN                                                                                      \r\n"
    		+ "             FROM TRGT_RNMCNO TR																												\r\n"
    		+ "             LEFT JOIN (																														\r\n"
    		+ "                        SELECT RNMCNO, MAX(CDD_FLFL_SQNO)																					\r\n"
    		+ "                          FROM (																												\r\n"
    		+ "                					SELECT A.CDD_FLFL_SQNO																						\r\n"
    		+ "                     				 , A.CDD_TAGT_ENTY_ID AS RNMCNO																			\r\n"
    		+ "                  				  FROM SID.IDO_A_MAH_CRFL_FLTG_FLFL_DT A /* 요주의필터링수행내역 */ 												\r\n"
    		+ "                     				 , SID.IDO_A_MAH_CRFL_FLTG_APRV_DT B /* 요주의필터링결재내역 */  												\r\n"
    		+ "                 				 WHERE A.APRV_RGSN_DATE    = B.APRV_RGSN_DATE																\r\n"
    		+ "                   				   AND A.APRV_RGSN_SQNO    = B.APRV_RGSN_SQNO																\r\n"
    		+ "                   				   AND A.FLFL_EMPY_NO     != 'AMLBAT'    /* 수행사원번호 */														\r\n"
    		+ "                   				   AND B.CRFL_FLTG_APRV_STAS_CODE = '21' /* 요주의필터링결재상태코드 (21:준법감시인 승인) */							\r\n"
    		+ "                 				 UNION ALL																									\r\n"
    		+ "                					SELECT A.CDD_FLFL_SQNO																						\r\n"
    		+ "                     				 , A.CDD_TAGT_ENTY_ID AS RNMCNO																			\r\n"
    		+ "                  				 FROM SID.IDO_A_MAH_CRFL_FLTG_FLFL_DT A /* 요주의필터링수행내역 */ 												\r\n"
    		+ "                     			    , SID.IDO_A_MAH_CRFL_FLTG_APRV_DT B /* 요주의필터링결재내역 */ 												\r\n"
    		+ "                 				WHERE A.APRV_RGSN_DATE    = B.APRV_RGSN_DATE																\r\n"
    		+ "                   				  AND A.APRV_RGSN_SQNO    = B.APRV_RGSN_SQNO																\r\n"
    		+ "                   				  AND A.FLFL_EMPY_NO      = 'AMLBAT'    /* 수행사원번호 */														\r\n"
    		+ "                   				  AND B.CRFL_FLTG_APRV_STAS_CODE = '21' /* 요주의필터링결재상태코드 (21:준법감시인 승인) */							\r\n"
    		+ "               				  )																												\r\n"
    		+ "         				GROUP BY RNMCNO																										\r\n"
    		+ "                       )B																													\r\n"
    		+ "                    ON B.RNMCNO = TR.RNMCNO																									\r\n"
    		+ "       )																																		\r\n"
    		+ "       , TRGT_STR AS 																														\r\n"
    		+ "       (/* 당사자 또는 관련인으로써 STR 보고 이력 여:'02' 부:'01' */                                                                             		\r\n"
    		+ "          SELECT TR.RNMCNO                                                                                                                   \r\n"
    		+ "               , TR.INDV_CORP_CCD                                                                                                            \r\n"
    		+ "               , TR.NTN_CD                                                                                                                   \r\n"
    		+ "               , NVL2(B.RNMCNO,'02','01') AS STR_YN                                                                                          \r\n"
    		+ "            FROM TRGT_RNMCNO TR                                                                                                              \r\n"
    		+ "            LEFT JOIN (                                                                                                                      \r\n"
    		+ "                       SELECT NIC66.DL_P_RNMCNO AS RNMCNO, COUNT(*) AS CNT                                                           		\r\n"
    		+ "                         FROM NIC66B NIC66, NIC70B NIC70, TRGT_D_BASE TDB                                                                  	\r\n"
    		+ "                        WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                              			\r\n"
    		+ "                          AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                    					\r\n"
    		+ "                          AND NIC66.SSPS_DL_CRT_CCD IN ('STR','KYC')                                                                         \r\n"
    		+ "                          AND NIC66.RPR_PRGRS_CCD IN ('99','10')                                                                             \r\n"
    		+ "                          AND NIC66.SSPS_DL_CRT_DT = NIC70.SSPS_DL_CRT_DT                                                                 	\r\n"
    		+ "                          AND NIC66.DL_P_RNMCNO = NIC70.DL_P_RNMCNO                                                                     		\r\n"
    		+ "                        GROUP BY NIC66.DL_P_RNMCNO                                                                                           \r\n"
    		+ "                       HAVING COUNT(*) >= 3                                                                                                  \r\n"
    		+ "                        UNION ALL                                                                                                            \r\n"
    		+ "                       SELECT NIC102.AFPR_RNMCNO AS RNMCNO, COUNT(*) AS CNT                                                         			\r\n"
    		+ "                         FROM NIC66B NIC66, NIC102B NIC102, TRGT_D_BASE TDB                                                               	\r\n"
    		+ "                        WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                              			\r\n"
    		+ "                          AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                    					\r\n"
    		+ "                          AND NIC66.SSPS_DL_CRT_CCD IN ('STR','KYC')                                                                         \r\n"
    		+ "                          AND NIC66.RPR_PRGRS_CCD IN ('99','10')                                                                             \r\n"
    		+ "                          AND NIC66.SSPS_DL_CRT_DT = NIC102.SSPS_DL_CRT_DT                                                                	\r\n"
    		+ "                          AND NIC66.SSPS_DL_ID = NIC102.SSPS_DL_ID                                                                           \r\n"
    		+ "                        GROUP BY NIC102.AFPR_RNMCNO                                                                                          \r\n"
    		+ "                       HAVING COUNT(*) >= 3                                                                                                  \r\n"
    		+ "                      )B                                                                                                                     \r\n"
    		+ "                   ON B.RNMCNO = TR.RNMCNO                                                                                                   \r\n"
    		+ "       )                                                                                                                                     \r\n"
    		+ "       , TRGT_VAP AS                                                                                                                         \r\n"
    		+ "       (/* 가상자산사업자 여:'02' 부:'01' */                                                                                                      \r\n"
    		+ "          SELECT TR.RNMCNO                                                                                                                   \r\n"
    		+ "               , TR.INDV_CORP_CCD                                                                                                            \r\n"
    		+ "               , TR.NTN_CD                                                                                                                   \r\n"
    		+ "               , NVL2(B.RNMCNO,'02','01') AS VAP_YN                                                                                          \r\n"
    		+ "            FROM TRGT_RNMCNO TR                                                                                                              \r\n"
    		+ "            LEFT JOIN (                                                                                                                      \r\n"
    		+ "                        SELECT CDD_TAGT_ENTY_ID AS RNMCNO                                                                                    \r\n"
    		+ "                          FROM SID.IDO_A_MAH_VRAC_TRS_BSNS_IF CU                                                                            	\r\n"
    		+ "                             , SID.IDO_A_MAH_CDD_FLFL_DTLD B                                                                                 \r\n"
    		+ "                         WHERE 1 = 1                                                                                                         \r\n"
    		+ "                           AND CU.BZNO_CRYP = B.CDD_ORIG_CLNT_NO_CRYP                                                                    	\r\n"
    		+ "                           AND CU.DEL_YN <> 'Y'                                                                                              \r\n"
    		+ "                      )B                                                                                                                     \r\n"
    		+ "                   ON B.RNMCNO = TR.RNMCNO                                                                                                   \r\n"
    		+ "       )																																		\r\n"
    		+ "       , TRGT_PRCE AS																														\r\n"
    		+ "       ( /* 금융범죄 연루 고객 */																													\r\n"
    		+ "          SELECT TR.RNMCNO																													\r\n"
    		+ "                , TR.INDV_CORP_CCD																											\r\n"
    		+ "                , TR.NTN_CD																													\r\n"
    		+ "                , NVL2(B.RNMCNO,'02','01') AS PRCE_YN																						\r\n"
    		+ "             FROM TRGT_RNMCNO TR																												\r\n"
    		+ "             LEFT JOIN (																														\r\n"
    		+ "                         SELECT CLNT_ENTY_ID AS RNMCNO 																						\r\n"
    		+ "                           FROM SID.IDO_A_MAH_DBT_NOMN_PRCE  																				\r\n"
    		+ "                          UNION ALL																											\r\n"
    		+ "                         SELECT B.ENTY_ID AS RNMCNO																							\r\n"
    		+ "                           FROM SID.IDO_A_MAH_DBT_NOMN A																						\r\n"
    		+ "                              , SID.IDO_A_UUE_CLIENT_ENTY_ALIAS B																			\r\n"
    		+ "                          WHERE TRIM(A.CLNT_NO_CRYP) = TRIM(B.ENTY_ALIS_CRYP)																\r\n"
    		+ "                            AND A.RGSN_YN = 'Y'																								\r\n"
    		+ "                       )B																													\r\n"
    		+ "                    ON B.RNMCNO = TR.RNMCNO																									\r\n"
    		+ "       )																																		\r\n"
    		+ "       , TRGT_GDS_POINT AS                                                                                                                   \r\n"
    		+ "       ( /* BM위험요소_거래종목 점수 */                                                                                                            \r\n"
    		+ "          SELECT /*+ MATERIALIZE */ RA_ITEM_CODE, LPAD(SRT_NO, 10, '0')||'_'||RA_ITEM_CODE AS SRT_RA_ITEM_CODE            					\r\n"
    		+ "               , RA_ITEM_SCR                                                                                                                 \r\n"
    		+ "            FROM (                                                                                                                           \r\n"
    		+ "                   SELECT RA_ITEM_CODE                                                                                                       \r\n"
    		+ "                        , RA_ITEM_SCR                                                                                                        \r\n"
    		+ "                        , TO_CHAR(RANK() OVER (ORDER BY TO_NUMBER(RA_ITEM_SCR))) AS SRT_NO                                        			\r\n"
    		+ "                     FROM RA_ITEM_COMMON                                                                                                     \r\n"
    		+ "                    WHERE RA_ITEM_CD = 'B020'                                                                                                \r\n"
    		+ "                  )                                                                                                                          \r\n"
    		+ "       )                                                                                                                                     \r\n"
    		+ "       , TRGT_NIC61B_TMP AS                                                                                                                  \r\n"
    		+ "       ( /* 최근 6개월 거래고객 중 상대계좌ID, 표준상품분류 정보 */                                                                             			\r\n"
    		+ "          SELECT /*+ MATERIALIZE PARALLEL(NIC61 4) FULL(NIC61) USE_HASH(NIC61 TGP) */ NIC61.RNMCNO                         					\r\n"
    		+ "               , COUNT(DISTINCT CASE WHEN NIC61.RLTV_ACNT_ID != 0 AND NIC61.RLTV_ACNT_ID IS NOT NULL                      					\r\n"
    		+ "                                     THEN NIC61.RLTV_ACNT_ID END) AS RLTV_ACNT_ID_CNT                                                    	\r\n"
    		+ "               , SUBSTR(MAX(TGP.SRT_RA_ITEM_CODE), 12) AS GDS_NO                                                                          	\r\n"
    		+ "            FROM TRGT_D_BASE    TDB                                                                                                          \r\n"
    		+ "               , NIC61B         NIC61                                                                                                        \r\n"
    		+ "               , TRGT_GDS_POINT TGP                                                                                                          \r\n"
    		+ "           WHERE 1 = 1                                                                                                                       \r\n"
    		+ "             AND NIC61.DL_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                                                         		\r\n"
    		+ "             AND NIC61.DL_DT > = TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -6), 'YYYYMMDD')                                               				\r\n"
    		+ "             AND TGP.RA_ITEM_CODE(+) = SUBSTR(NIC61.GDS_NO, 1, 3)                                                                         	\r\n"
    		+ "           GROUP BY NIC61.RNMCNO                                                                                                             \r\n"
    		+ "       )                                                                                                                                     \r\n"
    		+ "       , TRGT_NIC61B AS                                                                                                                      \r\n"
    		+ "       ( /* 최근 3개월 거래고객 중 6개월 위험점수가 높은 표준상품분류 정보 */                                                               				\r\n"
    		+ "          SELECT /*+ MATERIALIZE */ TR.RNMCNO, TR.INDV_CORP_CCD, TNT.RLTV_ACNT_ID_CNT, TNT.GDS_NO, TR.NTN_CD                                 \r\n"
    		+ "            FROM TRGT_RNMCNO     TR                                                                                                          \r\n"
    		+ "               , TRGT_NIC61B_TMP TNT                                                                                                         \r\n"
    		+ "           WHERE 1 = 1                                                                                                                       \r\n"
    		+ "             AND TNT.RNMCNO = TR.RNMCNO          																							\r\n"
    		
    				 
//+"  and rownum < 10 "
	;
	allQuery = forOracle;

	rtnString = allQuery; 
	
    rtnString  = rtnString +
    		"	)	\n" +
	getRAModelQuery(); // RA모델 쿼리
    return rtnString;
    }
    
    /**
     * <pre>
     * RA를 실행할 고객과 RA요소가 될 고객정보를 select하는 쿼리
     * RAを実行する顧客とRA要素になる顧客情報をSelectするクエリ
     * @en
     * </pre>
     *@param flag 'ALL' 모든 고객, 'ONE' 특정 한 고객, '' 특정일에 정보가 변경된 고객
     *            'ALL' すべての顧客, 'ONE' 一人の特定顧客, '' 特定日に情報変更があった顧客
     *            @en
     *@return    select query
     *@throws Exception
     */
    public String getMainQuery(String flag) throws NullPointerException {
        String rtnString;
        String allQuery;
        String modelGubn;
        //String sTrgtRnmcnoSql = "";
        final String forOracle =
        		"SELECT RNMCNO\r\n"
        		+ "     , CS_TYP_CD\r\n"
        		+ "     , RA_ITEM_CD\r\n"
        		+ "     , RA_ITEM_NM\r\n"
        		+ "     , RA_MDL_GBN_CD\r\n"
        		+ "     , MISS_VAL_SCR\r\n"
        		+ "     , RA_ID\r\n"
        		+ "     , NEW_OLD_GBN_CD\r\n"
        		+ "     , ABS_HRSK_YN\r\n"
        		+ "     , RA_ITEM_VAL\r\n"
        		+ "     , RA_ITEM_WGHT\r\n"
        		+ "     , RA_ITEM_SCR\r\n"
        		+ "     , RA_ITEM_SCR * RA_ITEM_WGHT AS RA_ITEM_LST_SCR\r\n"
        		+ "  FROM (																																		\r\n"
        		+ "         WITH T_RA_ITEM_WGHT AS (																											\r\n"
        		+ "             SELECT A.RA_ITEM_CD																												\r\n"
        		+ "                  , A.RA_ITEM_NM																												\r\n"
        		+ "                  , A.RA_MDL_GBN_CD																											\r\n"
        		+ "                  , A.INTV_VAL_YN																											\r\n"
        		+ "                  , A.MISS_VAL_SCR																											\r\n"
        		+ "                  , ? AS RA_ID																												\r\n"
        		+ "                  , B.CS_TYP_CD																												\r\n"
        		+ "                  , B.NEW_OLD_GBN_CD																											\r\n"
        		+ "                  , B.RA_ITEM_WGHT																											\r\n"
        		+ "               FROM RA_ITEM A																												\r\n"
        		+ "               LEFT JOIN RA_ITEM_WGHT B																										\r\n"
        		+ "                 ON A.RA_ITEM_CD = B.RA_ITEM_CD																								\r\n"
        		+ "              WHERE A.USE_YN = 'Y'																											\r\n"
        		+ "                AND A.RA_MDL_GBN_CD IN (?, ?) -- PARAM2 모델구분 I, B																			\r\n"
        		+ "                AND A.RA_ITEM_CD NOT IN ('I009','I011','I012','I013','I014','I018')															\r\n"
        		+ "              UNION ALL																														\r\n"
        		+ "             SELECT RA_ITEM_CD																												\r\n"
        		+ "                  , RA_ITEM_NM																												\r\n"
        		+ "                  , RA_MDL_GBN_CD																											\r\n"
        		+ "                  , INTV_VAL_YN																												\r\n"
        		+ "                  , MISS_VAL_SCR																												\r\n"
        		+ "                  , ? AS RA_ID																												\r\n"
        		+ "                  , '01' AS CS_TYP_CD																										\r\n"
        		+ "                  , 'B' AS NEW_OLD_GBN_CD																									\r\n"
        		+ "                  , 1 AS RA_ITEM_WGHT																										\r\n"
        		+ "               FROM RA_ITEM																													\r\n"
        		+ "              WHERE RA_ITEM_CD IN ('I009','I011','I012','I013','I014','I018')																\r\n"
        		+ "              UNION ALL																														\r\n"
        		+ "             SELECT RA_ITEM_CD																												\r\n"
        		+ "                  , RA_ITEM_NM																												\r\n"
        		+ "                  , RA_MDL_GBN_CD																											\r\n"
        		+ "                  , INTV_VAL_YN																												\r\n"
        		+ "                  , MISS_VAL_SCR																												\r\n"
        		+ "                  , ? AS RA_ID																												\r\n"
        		+ "                  , '02' AS CS_TYP_CD																										\r\n"
        		+ "                  , 'B' AS NEW_OLD_GBN_CD																									\r\n"
        		+ "                  , 1 AS RA_ITEM_WGHT																										\r\n"
        		+ "               FROM RA_ITEM																													\r\n"
        		+ "              WHERE RA_ITEM_CD IN ('I009','I011','I012','I013','I014','I018')																\r\n"
        		+ "         )																																	\r\n"
        		+ "       , TRGT_D_BASE AS 																														\r\n"
        		+ "       ( SELECT /*+ MATERIALIZE */ TO_DATE(SUBSTR(?, 1, 6) || '01', 'YYYYMMDD') AS CUR_DT FROM DUAL )										\r\n"
        		+ "       , TRGT_RNMCNO AS 																														\r\n"
        		+ "       ( /* 최근 3개월 거래고객 +FATF,고액자산가,당사지정,요주의동일인,STR보고 + */                                                                        \r\n"
        		+ "          SELECT /*+ MATERIALIZE PARALLEL(NIC61 4) FULL(NIC61) USE_HASH(NIC61 NIC01)  */                                           			\r\n"
        		+ "                 DISTINCT NIC01.RNMCNO, NIC01.INDV_CORP_CCD, NIC01.NTN_CD, NIC01.CS_NO                                          				\r\n"
        		+ "            FROM TRGT_D_BASE   TDB                                                                                                           \r\n"
        		+ "               , NIC61B        NIC61                                                                                                         \r\n"
        		+ "               , NIC01B        NIC01                                                                                                         \r\n"
        		+ "           WHERE 1 = 1                                                                                                                       \r\n"
        		+ "             AND NIC61.DL_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                                                         		\r\n"
        		+ "             AND NIC61.DL_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -3), 'YYYYMMDD')                                                				\r\n"
        		+ "             AND NIC01.RNMCNO = NIC61.RNMCNO                                                                                                	\r\n"
        		+ "             /* 삼성증권에서 제공한 거래제외코드 */                                                                                                  	\r\n"
        		+ "             AND NIC61.TRDG_CODE NOT IN                                                                                                      \r\n"
        		+ "             ( '301180','301189','301420','301429','301430','301439','301440','301449','301450','301459','301460'                        	\r\n"
        		+ "              ,'301469','301890','301899','301900','301909','301910','301919','301920','301929','302230','302239'                         	\r\n"
        		+ "              ,'302240','302249','303910','303919','A99010','Q00400','Q00800','T00030','U00080','U00200','U00500')      		 				\r\n"
        		+ "           UNION 																															\r\n"
        		+ "          /* FATF Black list, FATC Grey list */																								\r\n"
        		+ "          SELECT DISTINCT NIC01.RNMCNO, NIC01.INDV_CORP_CCD, NIC01.NTN_CD, NIC01.CS_NO														\r\n"
        		+ "            FROM NIC01B NIC01, SID.IDO_A_UUE_COUNTRY AUUE																					\r\n"
        		+ "               , ( SELECT RA_ITEM_CODE FROM RA_ITEM_NTN  WHERE  FATF_BLACK_LIST_YN ='Y'  OR FATF_GREY_LIST_YN ='Y' )  FATF					\r\n"
        		+ "           WHERE NIC01.NTN_CD = AUUE.CNTY_CODE 																								\r\n"
        		+ "             AND AUUE.CNTY_NO_CODE = FATF.RA_ITEM_CODE  																						\r\n"
        		+ "           UNION																																\r\n"
        		+ "          /* 고액자산가 */																														\r\n"
        		+ "          SELECT DISTINCT NIC01.RNMCNO, NIC01.INDV_CORP_CCD, NIC01.NTN_CD, NIC01.CS_NO                                                       \r\n"
        		+ "            FROM NIC01B NIC01                                                                                                                \r\n"
        		+ "               , ( SELECT RNMCNO, MAX(EXTRACT_DT) FROM NIC40B GROUP BY RNMCNO ) NIC40                                                        \r\n"
        		+ "           WHERE NIC40.RNMCNO = NIC01.RNMCNO																									\r\n"
        		+ "          /* 당사지정요주의인물 */																													\r\n"
        		+ "           UNION																																\r\n"
        		+ "          SELECT NIC01.RNMCNO, NIC01.INDV_CORP_CCD, NIC01.NTN_CD, NIC01.CS_NO																\r\n"
        		+ " 		   FROM NIC01B NIC01																												\r\n"
        		+ "               , (																															\r\n"
        		+ "                  SELECT CLNT_ENTY_ID AS RNMCNO																								\r\n"
        		+ "                    FROM SID.IDO_A_MAH_BLLS_PRS_IFMN																							\r\n"
        		+ "                   WHERE 1 = 1																												\r\n"
        		+ "                     AND DEL_YN <> 'Y' /* 삭제여부 */ 																							\r\n"
        		+ "                 ) B																															\r\n"
        		+ "           WHERE NIC01.RNMCNO = B.RNMCNO																										\r\n"
        		+ "          /* 요주의인물 동일인 */																													\r\n"
        		+ "           UNION																																\r\n"
        		+ "          SELECT NIC01.RNMCNO, NIC01.INDV_CORP_CCD, NIC01.NTN_CD, NIC01.CS_NO 																\r\n"
        		+ "            FROM NIC01B NIC01																												\r\n"
        		+ "               , (																															\r\n"
        		+ "                   SELECT RNMCNO, MAX(CDD_FLFL_SQNO)																							\r\n"
        		+ "                     FROM (																													\r\n"
        		+ "                           SELECT A.CDD_FLFL_SQNO																							\r\n"
        		+ "                                , A.CDD_TAGT_ENTY_ID AS RNMCNO																				\r\n"
        		+ "                             FROM SID.IDO_A_MAH_CRFL_FLTG_FLFL_DT A /* 요주의필터링수행내역 */ 													\r\n"
        		+ "                                , SID.IDO_A_MAH_CRFL_FLTG_APRV_DT B /* 요주의필터링결재내역 */ 													\r\n"
        		+ "                            WHERE A.APRV_RGSN_DATE    = B.APRV_RGSN_DATE																		\r\n"
        		+ "                              AND A.APRV_RGSN_SQNO    = B.APRV_RGSN_SQNO																		\r\n"
        		+ "                              AND A.FLFL_EMPY_NO     != 'AMLBAT'    /* 수행사원번호 */															\r\n"
        		+ "                              AND B.CRFL_FLTG_APRV_STAS_CODE = '21' /* 요주의필터링결재상태코드 (21:준법감시인 승인) */									\r\n"
        		+ "                            UNION ALL																										\r\n"
        		+ "                           SELECT A.CDD_FLFL_SQNO																							\r\n"
        		+ "                                , A.CDD_TAGT_ENTY_ID AS RNMCNO																				\r\n"
        		+ "                             FROM SID.IDO_A_MAH_CRFL_FLTG_FLFL_DT A /* 요주의필터링수행내역 */  													\r\n"
                + "                                , SID.IDO_A_MAH_CRFL_FLTG_APRV_DT B /* 요주의필터링결재내역 */   													\r\n"
                + "                            WHERE A.APRV_RGSN_DATE    = B.APRV_RGSN_DATE  																	\r\n"
                + "                              AND A.APRV_RGSN_SQNO    = B.APRV_RGSN_SQNO  																	\r\n"
                + "                              AND A.FLFL_EMPY_NO      = 'AMLBAT'    /* 수행사원번호 */  															\r\n"
                + "                              AND B.CRFL_FLTG_APRV_STAS_CODE = '21' /* 요주의필터링결재상태코드 (21:준법감시인 승인) */  								\r\n"
                + "                          ) GROUP BY RNMCNO  																								\r\n"
        		+ "                 ) B																															\r\n"
        		+ "           WHERE B.RNMCNO = NIC01.RNMCNO																										\r\n"
        		+ "          /* 최근1년 이내에 당사자 또는 관련인으로 3회이상 STR 보고된 고객 */																				\r\n"
        		+ "           UNION																																\r\n"
        		+ "          SELECT NIC01.RNMCNO, NIC01.INDV_CORP_CCD, NIC01.NTN_CD, NIC01.CS_NO                                                                \r\n"
        		+ "            FROM NIC01B NIC01																												\r\n"
        		+ "               , (                                                                                                                           \r\n"
        		+ "                   SELECT NIC66.DL_P_RNMCNO AS RNMCNO, COUNT(*) AS CNT                                                           			\r\n"
        		+ "                     FROM NIC66B NIC66, NIC70B NIC70, TRGT_D_BASE TDB                                                                  		\r\n"
        		+ "                    WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                              				\r\n"
        		+ "                      AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                    						\r\n"
        		+ "                      AND NIC66.SSPS_DL_CRT_CCD IN ('STR','KYC')                                                                             \r\n"
        		+ "                      AND NIC66.RPR_PRGRS_CCD IN ('99','10')                                                                                 \r\n"
        		+ "                      AND NIC66.SSPS_DL_CRT_DT = NIC70.SSPS_DL_CRT_DT                                                                 		\r\n"
        		+ "                      AND NIC66.DL_P_RNMCNO = NIC70.DL_P_RNMCNO                                                                     			\r\n"
        		+ "                    GROUP BY NIC66.DL_P_RNMCNO                                                                                               \r\n"
        		+ "                   HAVING COUNT(*) >= 3                                                                                                      \r\n"
        		+ "                    UNION ALL                                                                                                                \r\n"
        		+ "                   SELECT NIC102.AFPR_RNMCNO AS RNMCNO, COUNT(*) AS CNT                                                         				\r\n"
        		+ "                     FROM NIC66B NIC66, NIC102B NIC102, TRGT_D_BASE TDB                                                               		\r\n"
        		+ "                    WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                              				\r\n"
        		+ "                      AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                    						\r\n"
        		+ "                      AND NIC66.SSPS_DL_CRT_CCD IN ('STR','KYC')                                                                             \r\n"
        		+ "                      AND NIC66.RPR_PRGRS_CCD IN ('99','10')                                                                                 \r\n"
        		+ "                      AND NIC66.SSPS_DL_CRT_DT = NIC102.SSPS_DL_CRT_DT                                                                		\r\n"
        		+ "                      AND NIC66.SSPS_DL_ID = NIC102.SSPS_DL_ID                                                                              	\r\n"
        		+ "                    GROUP BY NIC102.AFPR_RNMCNO                                                                                             	\r\n"
        		+ "                   HAVING COUNT(*) >= 3                                                                                                      \r\n"
        		+ "                 ) B                                                                                                                         \r\n"
        		+ "           WHERE NIC01.RNMCNO = B.RNMCNO																										\r\n"
        		+ "          /* 가상자산사업자 */																													\r\n"
        		+ "           UNION																																\r\n"
        		+ "          SELECT NIC01.RNMCNO, NIC01.INDV_CORP_CCD, NIC01.NTN_CD, NIC01.CS_NO                                                                \r\n"
        		+ "            FROM NIC01B NIC01																												\r\n"
        		+ "               , (																															\r\n"
        		+ "                   SELECT CDD_TAGT_ENTY_ID AS RNMCNO																							\r\n"
        		+ "                     FROM SID.IDO_A_MAH_VRAC_TRS_BSNS_IF CU																					\r\n"
        		+ "                        , SID.IDO_A_MAH_CDD_FLFL_DTLD B																						\r\n"
        		+ "                    WHERE 1 = 1																												\r\n"
        		+ "                      AND CU.BZNO_CRYP = B.CDD_ORIG_CLNT_NO_CRYP																				\r\n"
        		+ "                      AND CU.DEL_YN <> 'Y'																									\r\n"
        		+ "                 ) B																															\r\n"
        		+ "           WHERE NIC01.RNMCNO = B.RNMCNO                     																				\r\n"
        		+ "       )                                                                                                                                     \r\n"
        		+ "       , TRGT_HNWI AS 																														\r\n"
        		+ "       ( /* 고액자산가 여:'02' 부:'01' */                                                                                                        \r\n"
        		+ "          SELECT TR.RNMCNO                                                                                                                   \r\n"
        		+ "               , TR.INDV_CORP_CCD                                                                                                            \r\n"
        		+ "               , TR.NTN_CD                                                                                                                   \r\n"
        		+ "               , NVL2(NIC40.RNMCNO,'02','01') AS HNWI_YN                                                                                     \r\n"
        		+ "            FROM TRGT_RNMCNO TR                                                                                                              \r\n"
        		+ "            LEFT JOIN (SELECT RNMCNO, MAX(EXTRACT_DT) FROM NIC40B GROUP BY RNMCNO) NIC40                                                     \r\n"
        		+ "              ON NIC40.RNMCNO = TR.RNMCNO                                                                                                    \r\n"
        		+ "       )																																		\r\n"
        		+ "       , TRGT_BLLS AS																														\r\n"
        		+ "       ( /* 당사지정 요주의인물 */																													\r\n"
        		+ "         SELECT TR.RNMCNO																													\r\n"
        		+ "              , TR.INDV_CORP_CCD																												\r\n"
        		+ "              , TR.NTN_CD																													\r\n"
        		+ "              , NVL2(B.RNMCNO,'02','01') AS BLLS_YN																							\r\n"
        		+ "           FROM TRGT_RNMCNO TR																												\r\n"
        		+ "           LEFT JOIN (																														\r\n"
        		+ "                       SELECT CLNT_ENTY_ID AS RNMCNO																							\r\n"
        		+ "                         FROM SID.IDO_A_MAH_BLLS_PRS_IFMN																					\r\n"
        		+ "                        WHERE 1 = 1																											\r\n"
        		+ "                          AND DEL_YN <> 'Y' /* 삭제여부 */   																					\r\n"
        		+ "                     ) B																														\r\n"
        		+ "                  ON B.RNMCNO = TR.RNMCNO																									\r\n"
        		+ "       )																																		\r\n"
        		+ "       , TRGT_POITSP AS 																														\r\n"
        		+ "       ( /* 요주의인물 동일인 */  																												\r\n"
        		+ "           SELECT TR.RNMCNO                                                                                                                  \r\n"
        		+ "                , TR.INDV_CORP_CCD                                                                                                           \r\n"
        		+ "                , TR.NTN_CD                                                                                                                  \r\n"
        		+ "                , NVL2(B.RNMCNO,'02','01') AS POITSP_YN                                                                                      \r\n"
        		+ "             FROM TRGT_RNMCNO TR																												\r\n"
        		+ "             LEFT JOIN (																														\r\n"
        		+ "                         SELECT DISTINCT A.CDD_TAGT_ENTY_ID AS RNMCNO																		\r\n"
        		+ "                           FROM SID.IDO_A_MAH_CRFL_FLTG_FLFL_DT   A    /* 요주의필터링수행내역 */													\r\n"
        		+ "                              , SID.IDO_A_MAH_CRFL_FLTG_APRV_DT   B    /* 요주의필터링결재내역 */ 													\r\n"
        		+ "                          WHERE A.APRV_RGSN_DATE    = B.APRV_RGSN_DATE																		\r\n"
        		+ "                            AND A.APRV_RGSN_SQNO    = B.APRV_RGSN_SQNO																		\r\n"
        		+ "                            AND B.CRFL_FLTG_APRV_STAS_CODE NOT IN ('21')  -- 요주의필터링결재상태코드 (21:준법감시인 승인)								\r\n"
        		+ "                          UNION ALL																											\r\n"
        		+ "                         SELECT DISTINCT A.CDD_TAGT_ENTY_ID AS RNMCNO																		\r\n"
        		+ "                           FROM SID.IDO_A_MAH_CRFL_FLTG_FLFL_DT   A    /* 요주의필터링수행내역 */													\r\n"
        		+ "                              , SID.IDO_A_MAH_CRFL_FLTG_APRV_DT   B    /* 요주의필터링결재내역 */													\r\n"
        		+ "                          WHERE A.APRV_RGSN_DATE    = B.APRV_RGSN_DATE																		\r\n"
        		+ "                            AND A.APRV_RGSN_SQNO    = B.APRV_RGSN_SQNO																		\r\n"
        		+ "                            AND A.FLFL_EMPY_NO      = 'AMLBAT'              -- 수행사원번호														\r\n"
        		+ "                            AND B.CRFL_FLTG_APRV_STAS_CODE NOT IN ('30', '22')  -- 요주의필터링결재상태코드 (30:준법감시팀 담당자 전결, 22:준법감시인 반려) 	\r\n"
        		+ "                       )B																													\r\n"
        		+ "                    ON B.RNMCNO = TR.RNMCNO																									\r\n"
        		+ "       )																																		\r\n"
        		+ "       , TRGT_STR AS 																														\r\n"
        		+ "       (/* 당사자 또는 관련인으로써 STR 보고 이력 여:'02' 부:'01' */                                                                             		\r\n"
        		+ "          SELECT TR.RNMCNO                                                                                                                   \r\n"
        		+ "               , TR.INDV_CORP_CCD                                                                                                            \r\n"
        		+ "               , TR.NTN_CD                                                                                                                   \r\n"
        		+ "               , NVL2(B.RNMCNO,'02','01') AS STR_YN                                                                                          \r\n"
        		+ "            FROM TRGT_RNMCNO TR                                                                                                              \r\n"
        		+ "            LEFT JOIN (                                                                                                                      \r\n"
        		+ "                       SELECT NIC66.DL_P_RNMCNO AS RNMCNO, COUNT(*) AS CNT                                                           		\r\n"
        		+ "                         FROM NIC66B NIC66, NIC70B NIC70, TRGT_D_BASE TDB                                                                  	\r\n"
        		+ "                        WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                              			\r\n"
        		+ "                          AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                    					\r\n"
        		+ "                          AND NIC66.SSPS_DL_CRT_CCD IN ('STR','KYC')                                                                         \r\n"
        		+ "                          AND NIC66.RPR_PRGRS_CCD IN ('99','10')                                                                             \r\n"
        		+ "                          AND NIC66.SSPS_DL_CRT_DT = NIC70.SSPS_DL_CRT_DT                                                                 	\r\n"
        		+ "                          AND NIC66.DL_P_RNMCNO = NIC70.DL_P_RNMCNO                                                                     		\r\n"
        		+ "                        GROUP BY NIC66.DL_P_RNMCNO                                                                                           \r\n"
        		+ "                       HAVING COUNT(*) >= 3                                                                                                  \r\n"
        		+ "                        UNION ALL                                                                                                            \r\n"
        		+ "                       SELECT NIC102.AFPR_RNMCNO AS RNMCNO, COUNT(*) AS CNT                                                         			\r\n"
        		+ "                         FROM NIC66B NIC66, NIC102B NIC102, TRGT_D_BASE TDB                                                               	\r\n"
        		+ "                        WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                              			\r\n"
        		+ "                          AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                    					\r\n"
        		+ "                          AND NIC66.SSPS_DL_CRT_CCD IN ('STR','KYC')                                                                         \r\n"
        		+ "                          AND NIC66.RPR_PRGRS_CCD IN ('99','10')                                                                             \r\n"
        		+ "                          AND NIC66.SSPS_DL_CRT_DT = NIC102.SSPS_DL_CRT_DT                                                                	\r\n"
        		+ "                          AND NIC66.SSPS_DL_ID = NIC102.SSPS_DL_ID                                                                           \r\n"
        		+ "                        GROUP BY NIC102.AFPR_RNMCNO                                                                                          \r\n"
        		+ "                       HAVING COUNT(*) >= 3                                                                                                  \r\n"
        		+ "                      )B                                                                                                                     \r\n"
        		+ "                   ON B.RNMCNO = TR.RNMCNO                                                                                                   \r\n"
        		+ "       )                                                                                                                                     \r\n"
        		+ "       , TRGT_VAP AS                                                                                                                         \r\n"
        		+ "       (/* 가상자산사업자 여:'02' 부:'01' */                                                                                                      \r\n"
        		+ "          SELECT TR.RNMCNO                                                                                                                   \r\n"
        		+ "               , TR.INDV_CORP_CCD                                                                                                            \r\n"
        		+ "               , TR.NTN_CD                                                                                                                   \r\n"
        		+ "               , NVL2(B.RNMCNO,'02','01') AS VAP_YN                                                                                          \r\n"
        		+ "            FROM TRGT_RNMCNO TR                                                                                                              \r\n"
        		+ "            LEFT JOIN (                                                                                                                      \r\n"
        		+ "                        SELECT CDD_TAGT_ENTY_ID AS RNMCNO                                                                                    \r\n"
        		+ "                          FROM SID.IDO_A_MAH_VRAC_TRS_BSNS_IF CU                                                                            	\r\n"
        		+ "                             , SID.IDO_A_MAH_CDD_FLFL_DTLD B                                                                                 \r\n"
        		+ "                         WHERE 1 = 1                                                                                                         \r\n"
        		+ "                           AND CU.BZNO_CRYP = B.CDD_ORIG_CLNT_NO_CRYP                                                                    	\r\n"
        		+ "                           AND CU.DEL_YN <> 'Y'                                                                                              \r\n"
        		+ "                      )B                                                                                                                     \r\n"
        		+ "                   ON B.RNMCNO = TR.RNMCNO                                                                                                   \r\n"
        		+ "       )																																		\r\n"
        		+ "       , TRGT_PRCE AS																														\r\n"
        		+ "       ( /* 금융범죄 연루 고객 */																													\r\n"
        		+ "          SELECT TR.RNMCNO																													\r\n"
        		+ "                , TR.INDV_CORP_CCD																											\r\n"
        		+ "                , TR.NTN_CD																													\r\n"
        		+ "                , NVL2(B.RNMCNO,'02','01') AS PRCE_YN																						\r\n"
        		+ "             FROM TRGT_RNMCNO TR																												\r\n"
        		+ "             LEFT JOIN (																														\r\n"
        		+ "                         SELECT CLNT_ENTY_ID AS RNMCNO 																						\r\n"
        		+ "                           FROM SID.IDO_A_MAH_DBT_NOMN_PRCE  																				\r\n"
        		+ "                          UNION ALL																											\r\n"
        		+ "                         SELECT B.ENTY_ID AS RNMCNO																							\r\n"
        		+ "                           FROM SID.IDO_A_MAH_DBT_NOMN A																						\r\n"
        		+ "                              , SID.IDO_A_UUE_CLIENT_ENTY_ALIAS B																			\r\n"
        		+ "                          WHERE TRIM(A.CLNT_NO_CRYP) = TRIM(B.ENTY_ALIS_CRYP)																\r\n"
        		+ "                            AND A.RGSN_YN = 'Y'																								\r\n"
        		+ "                       ) B																													\r\n"
        		+ "                    ON B.RNMCNO = TR.RNMCNO																									\r\n"
        		+ "       )																																		\r\n"
        		+ "       , TRGT_GDS_POINT AS                                                                                                                   \r\n"
        		+ "       ( /* BM위험요소_거래종목 점수 */                                                                                                            \r\n"
        		+ "          SELECT /*+ MATERIALIZE */ RA_ITEM_CODE, LPAD(SRT_NO, 10, '0')||'_'||RA_ITEM_CODE AS SRT_RA_ITEM_CODE            					\r\n"
        		+ "               , RA_ITEM_SCR                                                                                                                 \r\n"
        		+ "            FROM (                                                                                                                           \r\n"
        		+ "                   SELECT RA_ITEM_CODE                                                                                                       \r\n"
        		+ "                        , RA_ITEM_SCR                                                                                                        \r\n"
        		+ "                        , TO_CHAR(RANK() OVER (ORDER BY TO_NUMBER(RA_ITEM_SCR))) AS SRT_NO                                        			\r\n"
        		+ "                     FROM RA_ITEM_COMMON                                                                                                     \r\n"
        		+ "                    WHERE RA_ITEM_CD = 'B020'                                                                                                \r\n"
        		+ "                  )                                                                                                                          \r\n"
        		+ "       )                                                                                                                                     \r\n"
        		+ "       , TRGT_NIC61B_TMP AS                                                                                                                  \r\n"
        		+ "       ( /* 최근 6개월 거래고객 중 상대계좌ID, 표준상품분류 정보 */                                                                             			\r\n"
        		+ "          SELECT /*+ MATERIALIZE PARALLEL(NIC61 4) FULL(NIC61) USE_HASH(NIC61 TGP) */ NIC61.RNMCNO                         					\r\n"
        		+ "               , COUNT(DISTINCT CASE WHEN NIC61.RLTV_ACNT_ID != 0 AND NIC61.RLTV_ACNT_ID IS NOT NULL                      					\r\n"
        		+ "                                     THEN NIC61.RLTV_ACNT_ID END) AS RLTV_ACNT_ID_CNT                                                    	\r\n"
        		+ "               , SUBSTR(MAX(TGP.SRT_RA_ITEM_CODE), 12) AS GDS_NO                                                                          	\r\n"
        		+ "            FROM TRGT_D_BASE    TDB                                                                                                          \r\n"
        		+ "               , NIC61B         NIC61                                                                                                        \r\n"
        		+ "               , TRGT_GDS_POINT TGP                                                                                                          \r\n"
        		+ "           WHERE 1 = 1                                                                                                                       \r\n"
        		+ "             AND NIC61.DL_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                                                         		\r\n"
        		+ "             AND NIC61.DL_DT > = TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -6), 'YYYYMMDD')                                               				\r\n"
        		+ "             AND TGP.RA_ITEM_CODE(+) = SUBSTR(NIC61.GDS_NO, 1, 3)                                                                         	\r\n"
        		+ "           GROUP BY NIC61.RNMCNO                                                                                                             \r\n"
        		+ "       )                                                                                                                                     \r\n"
        		+ "       , TRGT_NIC61B AS                                                                                                                      \r\n"
        		+ "       ( /* 최근 3개월 거래고객 중 6개월 위험점수가 높은 표준상품분류 정보 */                                                               				\r\n"
        		+ "          SELECT /*+ MATERIALIZE */ TR.RNMCNO, TR.INDV_CORP_CCD, TNT.RLTV_ACNT_ID_CNT, TNT.GDS_NO, TR.NTN_CD                                 \r\n"
        		+ "            FROM TRGT_RNMCNO     TR                                                                                                          \r\n"
        		+ "               , TRGT_NIC61B_TMP TNT                                                                                                         \r\n"
        		+ "           WHERE 1 = 1                                                                                                                       \r\n"
        		+ "             AND TNT.RNMCNO = TR.RNMCNO          																							\r\n"
        		
        				 
	//+"  and rownum < 10 "
		;
    	allQuery = forOracle;

    	rtnString = allQuery; 
    	
        rtnString  = rtnString +
        		"	)	\n" +
		getRAModelQuery(); // RA모델 쿼리
        return rtnString;
    }


	public String getRAModelQuery() throws NullPointerException {
		String rtnString;
		final String forOracle =
				"SELECT X1.RNMCNO                                                                                                                                                                                                                                                           \r\n"
				+ "      , X1.CS_TYP_CD                                                                                                                                                                                                                                                            \r\n"
				+ "      , X1.RA_ITEM_CD                                                                                                                                                                                                                                                          \r\n"
				+ "      , X1.RA_ITEM_NM                                                                                                                                                                                                                                                         \r\n"
				+ "      , X1.RA_MDL_GBN_CD                                                                                                                                                                                                                                                    \r\n"
				+ "      , X1.MISS_VAL_SCR                                                                                                                                                                                                                                                       \r\n"
				+ "      , X1.RA_ID                                                                                                                                                                                                                                                                  \r\n"
				+ "      , X1.NEW_OLD_GBN_CD                                                                                                                                                                                                                                                  \r\n"
				+ "      , X1.RA_ITEM_VAL                                                                                                                                                                                                                                                         \r\n"
				+ "      , X1.RA_ITEM_WGHT                                                                                                                                                                                                                                                      \r\n"
				+ "      --, NVL(SCR.RA_ITEM_VAL, X1.RA_ITEM_VAL) AS RA_ITEM_VAL                                                                                                                                                                                                  \r\n"
				+ "      , CASE WHEN X1.RA_ITEM_CD IN ('B004','B006','B011','B012','B013','B014','B015','B016','B008','B010') THEN ROUND(TO_NUMBER(X1.RA_ITEM_VAL)*10.0)                                                                                    \r\n"
				+ "        ELSE NVL(SCR.RA_ITEM_SCR, X1.MISS_VAL_SCR) END AS RA_ITEM_SCR                                                                                                                                                                                      \r\n"
				+ "      , NVL(SCR.ABS_HRSK_YN, 'N') AS ABS_HRSK_YN                                                                                                                                                                                                                    \r\n"
				+ "   FROM (                                                                                                                                                                                                                                                                         \r\n"
				+ "                                                                                                                                                                                                                                                                                     \r\n"
				+ " SELECT J1.RNMCNO                                                                                                                                                                                                                                                           \r\n"
				+ "      , J1.CS_TYP_CD                                                                                                                                                                                                                                                             \r\n"
				+ "      , J1.RA_ITEM_CD                                                                                                                                                                                                                                                           \r\n"
				+ "      , J1.RA_ITEM_NM                                                                                                                                                                                                                                                          \r\n"
				+ "      , J1.RA_MDL_GBN_CD                                                                                                                                                                                                                                                     \r\n"
				+ "      , J1.MISS_VAL_SCR                                                                                                                                                                                                                                                        \r\n"
				+ "      , J1.RA_ID                                                                                                                                                                                                                                                                   \r\n"
				+ "      , J1.NEW_OLD_GBN_CD                                                                                                                                                                                                                                                   \r\n"
				+ "      , J1.RA_ITEM_WGHT                                                                                                                                                                                                                                                      \r\n"
				+ "      , J1.CASE_RA_ITEM_VAL AS RA_ITEM_VAL                                                                                                                                                                                                                            \r\n"
				+ "      , CASE WHEN J1.INTV_VAL_YN = 'Y' THEN NVL(                                                                                                                                                                                                                    \r\n"
				+ "         ( SELECT RA_ITEM_VAL                                                                                                                                                                                                                                                \r\n"
				+ "             FROM RA_ITEM_SCR                                                                                                                                                                                                                                               \r\n"
				+ "            WHERE RA_ITEM_CD = J1.RA_ITEM_CD                                                                                                                                                                                                                         \r\n"
				+ "              AND TO_NUMBER(RA_ITEM_VAL) = (                                                                                                                                                                                                                          \r\n"
				+ "                 SELECT MIN(TO_NUMBER(RA_ITEM_VAL))                                                                                                                                                                                                                  \r\n"
				+ "                   FROM RA_ITEM_SCR                                                                                                                                                                                                                                         \r\n"
				+ "                  WHERE RA_ITEM_CD = J1.RA_ITEM_CD                                                                                                                                                                                                                   \r\n"
				+ "                    AND J1.CASE_RA_ITEM_VAL < TO_NUMBER(RA_ITEM_VAL)                                                                                                                                                                                         \r\n"
				+ "                 )                                                                                                                                                                                                                                                                   \r\n"
				+ "         )                                                                                                                                                                                                                                                                           \r\n"
				+ "        ,(                                                                                                                                                                                                                                                                           \r\n"
				+ "          SELECT RA_ITEM_VAL                                                                                                                                                                                                                                                 \r\n"
				+ "            FROM RA_ITEM_SCR X1                                                                                                                                                                                                                                            \r\n"
				+ "           WHERE RA_ITEM_CD = J1.RA_ITEM_CD                                                                                                                                                                                                                          \r\n"
				+ "             AND RA_ITEM_VAL = (SELECT MAX(RA_ITEM_VAL) FROM RA_ITEM_SCR WHERE X1.RA_ITEM_CD = RA_ITEM_CD)                                                                                                                              \r\n"
				+ "         )                                                                                                                                                                                                                                                                           \r\n"
				+ "        )                                                                                                                                                                                                                                                                            \r\n"
				+ "        ELSE CASE_RA_ITEM_VAL  END  AS JOIN_RA_ITEM_VAL                                                                                                                                                                                                         \r\n"
				+ "   FROM (                                                                                                                                                                                                                                                                         \r\n"
				+ " SELECT A.RNMCNO                                                                                                                                                                                                                                                            \r\n"
				+ "      , A.CS_TYP_CD                                                                                                                                                                                                                                                             \r\n"
				+ "      , WGHT.INTV_VAL_YN                                                                                                                                                                                                                                                    \r\n"
				+ "      , WGHT.RA_ITEM_CD                                                                                                                                                                                                                                                     \r\n"
				+ "      , WGHT.RA_ITEM_NM                                                                                                                                                                                                                                                    \r\n"
				+ "      , WGHT.RA_MDL_GBN_CD                                                                                                                                                                                                                                               \r\n"
				+ "      , WGHT.MISS_VAL_SCR                                                                                                                                                                                                                                                   \r\n"
				+ "      , WGHT.RA_ID                                                                                                                                                                                                                                                              \r\n"
				+ "      , WGHT.NEW_OLD_GBN_CD                                                                                                                                                                                                                                             \r\n"
				+ "      , WGHT.RA_ITEM_WGHT                                                                                                                                                                                                                                                 \r\n"
				+ "      , (CASE WHEN WGHT.RA_ITEM_CD = 'I001' THEN A.NTN_CD          /*국가*/                                                                                                                                                                                 \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'I009' THEN TO_CHAR(A.B17)    /*고액자산가*/                                                                                                                                                                         \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'I011' THEN TO_CHAR(A.B18)    /*당사지정 요주의인물*/                                                                                                                                                           \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'I012' THEN TO_CHAR(A.B19)    /*요주의 인물*/                                                                                                                                                                      \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'I013' THEN TO_CHAR(A.B20)    /*혐의거래 보고자*/                                                                                                                                                                   \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'I014' THEN TO_CHAR(A.B21)    /*가상자산사업자*/                                                                                                                                                                    \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'I018' THEN TO_CHAR(A.B22)    /*금융범죄 연류 고객*/                                                                                                                                                             \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B001' THEN TO_CHAR(A.B01)    /* Alert 발생 건수 */                                                                                                                                                                 \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B002' THEN TO_CHAR(A.B02)    /*Alter발생 룰수*/                                                                                                                                                                    \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B003' THEN TO_CHAR(A.B03)    /*STR보고 건수*/                                                                                                                                                                     \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B004' THEN TO_CHAR(A.B04)    /*STR보고 평균금액*/                                                                                                                                                                \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B005' THEN TO_CHAR(A.B05)    /*CTR보고 건수*/                                                                                                                                                                     \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B006' THEN TO_CHAR(A.B06)    /*CTR보고 평균금액*/                                                                                                                                                                \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B007' THEN TO_CHAR(A.B23)    /*관련인 STR보고 건수*/                                                                                                                                                            \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B008' THEN TO_CHAR(A.B25)    /*관련인STR보고평균액*/                                                                                                                                                           \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B009' THEN TO_CHAR(A.B24)    /*관련인 CTR보고 건수*/                                                                                                                                                            \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B010' THEN TO_CHAR(A.B26)    /*관련인CTR보고평균액*/                                                                                                                                                           \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B011' THEN TO_CHAR(A.B07)    /*입금금액 규모*/                                                                                                                                                                    \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B012' THEN TO_CHAR(A.B08)    /*출금금액 규모*/                                                                                                                                                                    \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B013' THEN TO_CHAR(A.B09)    /*담보대출 규모*/                                                                                                                                                                    \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B014' THEN TO_CHAR(A.B10)    /*입출고 횟수*/                                                                                                                                                                       \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B015' THEN TO_CHAR(A.B11)    /*연관계좌의입출금규모*/                                                                                                                                                           \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B016' THEN TO_CHAR(A.B12)    /*현금거래 비중*/                                                                                                                                                                    \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B017' THEN TO_CHAR(A.B13)    /*신규카드 개설 건수*/                                                                                                                                                              \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B018' THEN TO_CHAR(A.B14)    /*거래상대 계좌수*/                                                                                                                                                                  \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B019' THEN TO_CHAR(A.B15)    /*선물옵션 거래여부*/                                                                                                                                                               \r\n"
				+ "              WHEN WGHT.RA_ITEM_CD = 'B020' THEN TO_CHAR(A.B16)    /*거래종목*/                                                                                                                                                                           \r\n"
				+ "         END) AS CASE_RA_ITEM_VAL                                                                                                                                                                                                                                        \r\n"
				+ "   FROM (                                                                                                                                                                                                                                                                         \r\n"
				+ "         SELECT RNMCNO /*고객엔티티ID*/                                                                                                                                                                                                                                 \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1' THEN '01' ELSE '02' END CS_TYP_CD /*개인법인구분*/                                                                                                                                                       \r\n"
				+ "              , 'B' AS NEW_OLD_GBN_CD                                                                                                                                                                                                                                      \r\n"
				+ "              , (SELECT CNTY_NO_CODE FROM SID.IDO_A_UUE_COUNTRY WHERE CNTY_CODE = NTN_CD) AS NTN_CD /*국가*/                                                                                                                           \r\n"
				+ "              , B01 /* Alert 발생 건수 */                                                                                                                                                                                                                                       \r\n"
				+ "              , B02 /* Alert 발생 룰수 */                                                                                                                                                                                                                                       \r\n"
				+ "              , B03 /* STR보고건수 */                                                                                                                                                                                                                                          \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                          \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B04 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B04, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B04 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B04 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B04 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B04, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B04 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B04 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B04 /* STR보고금액 */                                                                                                                                                   \r\n"
				+ "              , B05 /* CTR보고건수 */                                                                                                                                                                                                                                          \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                          \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B06 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B06, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B06 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B06 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B06 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B06, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B06 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B06 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B06 /* CTR보고금액 */                                                                                                                                                   \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                          \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B07 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B07, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B07 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B07 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B07 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B07, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B07 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B07 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B07 /* 입금금액 규모 */                                                                                                                                                 \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                          \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B08 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B08, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B08 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B08 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B08 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B08, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B08 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B08 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B08 /* 출금금액 규모 */                                                                                                                                                 \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                          \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B09 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B09, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B09 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B09 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B09 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B09, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B09 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B09 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B09 /* 담보대출 규모 */                                                                                                                                                 \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                          \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B10 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B10, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B10 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B10 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B10 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B10, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B10 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B10 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B10 /* 입출고 횟수 */                                                                                                                                                    \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                          \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B11 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B11, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B11 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B11 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B11 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B11, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B11 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B11 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B11 /* 연관계좌의 입출금규모 */                                                                                                                                       \r\n"
				+ "              , B12 /* 현금거래 비중 */                                                                                                                                                                                                                                        \r\n"
				+ "              , B13 /* 신규카드 개설 건수 */                                                                                                                                                                                                                                  \r\n"
				+ "              , B14 /* 거래상대 계좌수 */                                                                                                                                                                                                                                      \r\n"
				+ "              , B15 /* 선물옵션 거래여부 */                                                                                                                                                                                                                                   \r\n"
				+ "              , B16 /* 거래종목 */\r\n"
				+ "              , IMG /* 고객별 I모델 점수 */                                                                                                                                                                                                                                    \r\n"
				+ "              , B17 /* 고액자산가여부 */\r\n"
				+ "              , B18 /* 당사지정 요주의인물 */\r\n"
				+ "              , B19 /* 요주의인물 동일인 */\r\n"
				+ "              , B20 /* 당사자, 관련인 STR보고 3회이상 */                                                                                                                                                                                                                  \r\n"
				+ "              , B21 /* 가산자산사업자 여부 */\r\n"
				+ "              , B22 /* 금융범죄 연루 고객 */\r\n"
				+ "              , B23 /* 관련인 STR보고건수 */                                                                                                                                                                                                                                 \r\n"
				+ "              , B24 /* 관련인 CTR보고건수 */                                                                                                                                                                                                                                 \r\n"
				+ "              , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                          \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B25 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B25, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B25 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B25 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B25 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B25, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B25 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B25 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B25 /* 관련인 STR보고금액 */                                                                                                                                          \r\n"
				+ "               , CASE WHEN INDV_CORP_CCD = '1'                                                                                                                                                                                                                         \r\n"
				+ "                          THEN CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B26 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                  \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B26, AVG(CASE WHEN INDV_CORP_CCD = '1' THEN B26 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '1' THEN B26 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END                                                                                                                                                                                          \r\n"
				+ "                          ELSE CASE WHEN AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B26 ELSE NULL END) OVER () = 0 THEN 0 /* 디폴트 값 */                                                                                                   \r\n"
				+ "                               ELSE ROUND(PCK_GET_NORMDIST.NORMDIST(B26, AVG(CASE WHEN INDV_CORP_CCD = '2' THEN B26 ELSE NULL END) OVER ()                                                                                        \r\n"
				+ "                                                                       , STDDEV_POP(CASE WHEN INDV_CORP_CCD = '2' THEN B26 ELSE NULL END) OVER ()                                                                                                    \r\n"
				+ "                                                                       , 1) * 10, 2) END END AS B26 /* 관련인 CTR보고금액 */                                                                                                                                          \r\n"
				+ "           FROM (                                                                                                                                                                                                                                                                 \r\n"
				+ "                 SELECT RNMCNO                                                                 AS RNMCNO                                                                                                                                                             \r\n"
				+ "                      , MAX(INDV_CORP_CCD)                                                     AS INDV_CORP_CCD                                                                                                                                                   \r\n"
				+ "                      , MAX(NTN_CD)                                                            AS NTN_CD                                                                                                                                                                 \r\n"
				+ "                      , NVL(SUM(B01), 0)                                                       AS B01                                                                                                                                                                        \r\n"
				+ "                      , COUNT(DISTINCT B02)                                                    AS B02                                                                                                                                                                     \r\n"
				+ "                      , NVL(SUM(B03), 0)                                                       AS B03                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B04), 0)                                                       AS B04                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B05), 0)                                                       AS B05                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B06), 0)                                                       AS B06                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B07), 0)                                                       AS B07                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B08), 0)                                                       AS B08                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B09), 0)                                                       AS B09                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B10), 0)                                                       AS B10                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B11), 0)                                                       AS B11                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B12), 0)                                                       AS B12                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B13), 0)                                                       AS B13                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B14), 0)                                                       AS B14                                                                                                                                                                        \r\n"
				+ "                      , NVL(MAX(B15), '02')                                                    AS B15                                                                                                                                                                        \r\n"
				+ "                      , NVL(MAX(B16), 'NON')                                                   AS B16                                                                                                                                                                      \r\n"
				+ "                      , NVL(SUM(IMG), 0)                                                       AS IMG                                                                                                                                                                       \r\n"
				+ "                      , NVL(MAX(B17),'01')                                                     AS B17\r\n"
				+ "                      , NVL(MAX(B18),'01')                                                     AS B18\r\n"
				+ "                      , NVL(MAX(B19),'01')                                                     AS B19\r\n"
				+ "                      , NVL(MAX(B20),'01')                                                     AS B20                                                                                                                                                                        \r\n"
				+ "                      , NVL(MAX(B21),'01')                                                     AS B21\r\n"
				+ "                      , NVL(MAX(B22),'01')                                                     AS B22\r\n"
				+ "                      , NVL(SUM(B23), 0)                                                       AS B23                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B24), 0)                                                       AS B24                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B25), 0)                                                       AS B25                                                                                                                                                                        \r\n"
				+ "                      , NVL(SUM(B26), 0)                                                       AS B26                                                                                                                                                                        \r\n"
				+ "                   FROM (/* 고객별 I모델 점수 */                                                                                                                                                                                                                             \r\n"
				+ "                         SELECT TR.RNMCNO                                                                                                                                                                                                                                   \r\n"
				+ "                              , TR.INDV_CORP_CCD                                                                                                                                                                                                                             \r\n"
				+ "                              , TR.NTN_CD                                                                                                                                                                                                                                       \r\n"
				+ "                              , 0                                                              AS B01                                                                                                                                                                             \r\n"
				+ "                              , NULL                                                           AS B02                                                                                                                                                                           \r\n"
				+ "                              , 0                                                              AS B03                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B04                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B05                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B06                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B07                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B08                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B09                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B10                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B11                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B12                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B13                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B14                                                                                                                                                                             \r\n"
				+ "                              , '02'                                                           AS B15                                                                                                                                                                             \r\n"
				+ "                              , NULL                                                           AS B16                                                                                                                                                                           \r\n"
				+ "                              , NVL(CASE WHEN NIC35.I_RSK_GRD_MRK IS NULL THEN NULL                                                                                                                                                                         \r\n"
				+ "                                    ELSE (NIC35.I_RSK_GRD_MRK/10) END, 99)                     AS IMG                                                                                                                                                               \r\n"
				+ "                              , '01'                                                           AS B17\r\n"
				+ "                              , '01'                                                           AS B18\r\n"
				+ "                              , '01'                                                           AS B19\r\n"
				+ "                              , '01'                                                           AS B20                                                                                                                                                                             \r\n"
				+ "                              , '01'                                                           AS B21\r\n"
				+ "                              , '01'                                                           AS B22\r\n"
				+ "                              , 0                                                              AS B23                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B24                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B25                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B26                                                                                                                                                                             \r\n"
				+ "                           FROM TRGT_RNMCNO TR                                                                                                                                                                                                                          \r\n"
				+ "                              , NIC35B      NIC35                                                                                                                                                                                                                               \r\n"
				+ "                          WHERE NIC35.RNMCNO(+) = TR.RNMCNO                                                                                                                                                                                                      \r\n"
				+ "                          UNION ALL                                                                                                                                                                                                                                             \r\n"
				+ "                         /* 범위: 12개월, STR/CTR 보고건수 */                                                                                                                                                                                                              \r\n"
				+ "                         SELECT TR.RNMCNO                                                                                                                                                                                                                                   \r\n"
				+ "                              , TR.INDV_CORP_CCD                                                                                                                                                                                                                             \r\n"
				+ "                              , TR.NTN_CD                                                                                                                                                                                                                                       \r\n"
				+ "                              , 1                                                              AS B01 /* Alert 발생 건수: 완료 */                                                                                                                                            \r\n"
				+ "                              , CASE WHEN NIC66.SSPS_DL_CRT_CCD IN ('CTR')                                                                                                                                                                                          \r\n"
				+ "                                     THEN NULL ELSE NIC66.SSPS_TYP_CD END                      AS B02 /* Alert 발생 룰수: 완료 */                                                                                                                            \r\n"
				+ "                              , CASE WHEN NIC66.SSPS_DL_CRT_CCD IN ('STR', 'KYC')                                                                                                                                                                                  \r\n"
				+ "                                     AND NIC66.RPR_PRGRS_CCD IN ('99', '10')                                                                                                                                                                                            \r\n"
				+ "                                     THEN 1 ELSE 0 END                                         AS B03 /* STR보고건수    : 완료 */                                                                                                                                    \r\n"
				+ "                              , 0                                                              AS B04                                                                                                                                                                             \r\n"
				+ "                              , CASE WHEN NIC66.SSPS_DL_CRT_CCD IN ('CTR', 'CAC')                                                                                                                                                                                  \r\n"
				+ "                                     AND NIC66.RPR_PRGRS_CCD IN ('99', '10')                                                                                                                                                                                            \r\n"
				+ "                                     THEN 1 ELSE 0 END                                         AS B05 /* CTR보고건수    : 완료 */                                                                                                                                    \r\n"
				+ "                              , 0                                                              AS B06                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B07                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B08                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B09                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B10                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B11                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B12                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B13                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B14                                                                                                                                                                             \r\n"
				+ "                              , '02'                                                           AS B15                                                                                                                                                                             \r\n"
				+ "                              , NULL                                                           AS B16                                                                                                                                                                           \r\n"
				+ "                              , 0                                                              AS IMG                                                                                                                                                                            \r\n"
				+ "                              , '01'                                                           AS B17\r\n"
				+ "                              , '01'                                                           AS B18\r\n"
				+ "                              , '01'                                                           AS B19\r\n"
				+ "                              , '01'                                                           AS B20                                                                                                                                                                             \r\n"
				+ "                              , '01'                                                           AS B21\r\n"
				+ "                              , '01'                                                           AS B22\r\n"
				+ "                              , 0                                                              AS B23                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B24                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B25                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B26                                                                                                                                                                             \r\n"
				+ "                           FROM TRGT_D_BASE TDB                                                                                                                                                                                                                           \r\n"
				+ "                              , TRGT_RNMCNO TR                                                                                                                                                                                                                              \r\n"
				+ "                              , NIC66B      NIC66                                                                                                                                                                                                                               \r\n"
				+ "                          WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                                                                                                                                                 \r\n"
				+ "                            AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                                                                                                                                        \r\n"
				+ "                            AND NIC66.SSPS_DL_CRT_CCD IN ('STR', 'KYC', 'CTR', 'CAC')                                                                                                                                                                                \r\n"
				+ "                            AND TR.RNMCNO = NIC66.DL_P_RNMCNO                                                                                                                                                                                                    \r\n"
				+ "                          UNION ALL                                                                                                                                                                                                                                             \r\n"
				+ "                         SELECT TR.RNMCNO                                                                                                                                                                                                                                   \r\n"
				+ "                              , TR.INDV_CORP_CCD                                                                                                                                                                                                                             \r\n"
				+ "                              , TR.NTN_CD                                                                                                                                                                                                                                       \r\n"
				+ "                              , 0                                                              AS B01                                                                                                                                                                             \r\n"
				+ "                              , NULL                                                           AS B02                                                                                                                                                                           \r\n"
				+ "                              , 0                                                              AS B03                                                                                                                                                                             \r\n"
				+ "                              , NIC75.DL_AMT                                                   AS B04 /* STR보고금액    : 완료 */                                                                                                                                      \r\n"
				+ "                              , 0                                                              AS B05                                                                                                                                                                             \r\n"
				+ "                              , NIC75.CSH                                                      AS B06 /* CTR보고금액    : 완료 */                                                                                                                                       \r\n"
				+ "                              , 0                                                              AS B07                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B08                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B09                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B10                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B11                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B12                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B13                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B14                                                                                                                                                                             \r\n"
				+ "                              , '02'                                                           AS B15                                                                                                                                                                             \r\n"
				+ "                              , NULL                                                           AS B16                                                                                                                                                                           \r\n"
				+ "                              , 0                                                              AS IMG                                                                                                                                                                            \r\n"
				+ "                              , '01'                                                           AS B17\r\n"
				+ "                              , '01'                                                           AS B18\r\n"
				+ "                              , '01'                                                           AS B19\r\n"
				+ "                              , '01'                                                           AS B20                                                                                                                                                                             \r\n"
				+ "                              , '01'                                                           AS B21\r\n"
				+ "                              , '01'                                                           AS B22\r\n"
				+ "                              , 0                                                              AS B23                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B24                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B25                                                                                                                                                                             \r\n"
				+ "                              , 0                                                              AS B26                                                                                                                                                                             \r\n"
				+ "                           FROM TRGT_D_BASE   TDB                                                                                                                                                                                                                         \r\n"
				+ "                              , TRGT_RNMCNO   TR                                                                                                                                                                                                                            \r\n"
				+ "                              , NIC66B        NIC66                                                                                                                                                                                                                             \r\n"
				+ "                              , NIC75B        NIC75                                                                                                                                                                                                                             \r\n"
				+ "                          WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                                                                                                                                                 \r\n"
				+ "                            AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                                                                                                                                        \r\n"
				+ "                            AND ((     NIC66.SSPS_DL_CRT_CCD IN ('STR', 'KYC')                                                                                                                                                                                         \r\n"
				+ "                                   AND NIC66.RPR_PRGRS_CCD IN ('99', '10'))                                                                                                                                                                                             \r\n"
				+ "                             OR (      NIC66.SSPS_DL_CRT_CCD IN ('CTR', 'CAC')                                                                                                                                                                                         \r\n"
				+ "                                   AND NIC66.RPR_PRGRS_CCD IN ('99', '10')))                                                                                                                                                                                            \r\n"
				+ "                            AND TR.RNMCNO = NIC66.DL_P_RNMCNO                                                                                                                                                                                                    \r\n"
				+ "                            AND NIC75.SSPS_DL_CRT_DT = NIC66.SSPS_DL_CRT_DT                                                                                                                                                                                     \r\n"
				+ "                            AND NIC75.SSPS_DL_ID = NIC66.SSPS_DL_ID                                                                                                                                                                                                  \r\n"
				+ "                            AND NIC75.RNMCNO = NIC66.DL_P_RNMCNO                                                                                                                                                                                                \r\n"
				+ "                          UNION ALL                                                                                                                                                                                                                                             \r\n"
				+ "                         /* 범위: 6개월, 거래활동위험 */                                                                                                                                                                                                                      \r\n"
				+ "                         SELECT TR.RNMCNO                                                                                                                                                                                                                                   \r\n"
				+ "                              , TR.INDV_CORP_CCD                                                                                                                                                                                                                             \r\n"
				+ "                              , TR.NTN_CD                                                                                                                                                                                                                                       \r\n"
				+ "                              , 0                                                               AS B01                                                                                                                                                                            \r\n"
				+ "                              , NULL                                                            AS B02                                                                                                                                                                          \r\n"
				+ "                              , 0                                                               AS B03                                                                                                                                                                            \r\n"
				+ "                              , 0                                                               AS B04                                                                                                                                                                            \r\n"
				+ "                              , 0                                                               AS B05                                                                                                                                                                            \r\n"
				+ "                              , 0                                                               AS B06                                                                                                                                                                            \r\n"
				+ "                              , NIC32.MM_ITRN_AMT                                               AS B07 /* 입금금액 규모       : 완료 */                                                                                                                            \r\n"
				+ "                              , NIC32.MM_OTRN_AMT                                               AS B08 /* 출금금액 규모       : 완료 */                                                                                                                           \r\n"
				+ "                              , NIC32.MM_BOND_AMT                                               AS B09 /* 담보대출 규모       : 완료 */                                                                                                                           \r\n"
				+ "                              , (NIC32.MM_WAHO_CNT + NIC32.MM_RELE_CNT)                         AS B10 /* 입출고 횟수         : 완료 */                                                                                                                 \r\n"
				+ "                              , (NIC32.MM_REAC_ITRN_AMT + NIC32.MM_REAC_OTRN_AMT)               AS B11 /* 연관계좌의 입출금규모: 완료 */                                                                                                       \r\n"
				+ "                              , TRUNC( CASE WHEN (NIC32.MM_ITRN_CNT + NIC32.MM_OTRN_CNT) = 0                                                                                                                                                          \r\n"
				+ "                                            THEN 0.00                                                                                                                                                                                                                            \r\n"
				+ "                                       ELSE (((NIC32.MM_CASH_ITRN_CNT + NIC32.MM_CASH_OTRN_CNT)/(NIC32.MM_ITRN_CNT + NIC32.MM_OTRN_CNT)) * 10) END, 2) AS B12 /* 현금거래 비중       : 완료 */                           \r\n"
				+ "                               , NIC32.MM_CARD_NEW_CNT              AS B13 /* 신규카드 개설 건수  : 완료 */                                                                                                                                                   \r\n"
				+ "                               , 0                                  AS B14                                                                                                                                                                                                        \r\n"
				+ "                               , CASE WHEN NIC32.MM_TUOP_TRN_CNT > 0 THEN '01' ELSE '02' END      AS B15 /* 선물옵션 거래여부    : 완료 */                                                                                                      \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17\r\n"
				+ "                               , '01'                                                           AS B18\r\n"
				+ "                               , '01'                                                           AS B19\r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B21\r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_D_BASE   TDB                                                                                                                                                                                                                        \r\n"
				+ "                               , TRGT_RNMCNO   TR                                                                                                                                                                                                                           \r\n"
				+ "                               , NIC32B        NIC32                                                                                                                                                                                                                            \r\n"
				+ "                           WHERE NIC32.BAS_YYMM <  TO_CHAR(TDB.CUR_DT, 'YYYYMM')                                                                                                                                                                           \r\n"
				+ "                             AND NIC32.BAS_YYMM >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -6), 'YYYYMM')                                                                                                                                                   \r\n"
				+ "                             AND NIC32.RNMCNO = TR.RNMCNO                                                                                                                                                                                                          \r\n"
				+ "                           UNION ALL                                                                                                                                                                                                                                            \r\n"
				+ "                          SELECT TN.RNMCNO                                                                                                                                                                                                                                 \r\n"
				+ "                               , TN.INDV_CORP_CCD                                                                                                                                                                                                                            \r\n"
				+ "                               , TN.NTN_CD                                                                                                                                                                                                                                      \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , TN.RLTV_ACNT_ID_CNT                                            AS B14 /* 거래상대 계좌수     : 완료 */                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , TN.GDS_NO                                                      AS B16 /* 거래종목            : 완료 */                                                                                                                                  \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17\r\n"
				+ "                               , '01'                                                           AS B18\r\n"
				+ "                               , '01'                                                           AS B19\r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B21\r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_NIC61B TN                                                                                                                                                                                                                           \r\n"
				+ "                           WHERE 1 = 1                                                                                                                                                                                                                                         \r\n"
				+ "                           UNION ALL                                                                                                                                                                                                                                            \r\n"
				+ "                          SELECT HNWI.RNMCNO                                                                                                                                                                                                                              \r\n"
				+ "                               , HNWI.INDV_CORP_CCD                                                                                                                                                                                                                        \r\n"
				+ "                               , HNWI.NTN_CD                                                                                                                                                                                                                                  \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B14                                                                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , HNWI.HNWI_YN                                                   AS B17 /* 고액자산가여부 */                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B18\r\n"
				+ "                               , '01'                                                           AS B19\r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B21\r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_HNWI HNWI                                                                                                                                                                                                                         \r\n"
				+ "                           WHERE 1 = 1                                                                                                                                                                                                                                         \r\n"
				+ "                           UNION ALL                                                                                                                                                                                                                                            \r\n"
				+ "                          SELECT BLLS.RNMCNO                                                                                                                                                                                                                              \r\n"
				+ "                               , BLLS.INDV_CORP_CCD                                                                                                                                                                                                                        \r\n"
				+ "                               , BLLS.NTN_CD                                                                                                                                                                                                                                  \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B14                                                                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17 \r\n"
				+ "                               , BLLS.BLLS_YN                                                   AS B18 /* 당사지정 요주의인물 */\r\n"
				+ "                               , '01'                                                           AS B19                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B21\r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_BLLS BLLS                                                                                                                                                                                                                         \r\n"
				+ "                           WHERE 1 = 1                                                                      \r\n"
				+ "                           UNION ALL                                                                                                                                                                                                                                            \r\n"
				+ "                          SELECT POITSP.RNMCNO                                                                                                                                                                                                                              \r\n"
				+ "                               , POITSP.INDV_CORP_CCD                                                                                                                                                                                                                        \r\n"
				+ "                               , POITSP.NTN_CD                                                                                                                                                                                                                                  \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B14                                                                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17 \r\n"
				+ "                               , '01'                                                           AS B18 \r\n"
				+ "                               , POITSP.POITSP_YN                                               AS B19 /* 요주의인물 동일인 */\r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B21\r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_POITSP POITSP                                                                                                                                                                                                                         \r\n"
				+ "                           WHERE 1 = 1                                                                  \r\n"
				+ "                           UNION ALL                                                                                                                                                                                                                                            \r\n"
				+ "                          SELECT TRGTSTR.RNMCNO                                                                                                                                                                                                                          \r\n"
				+ "                               , TRGTSTR.INDV_CORP_CCD                                                                                                                                                                                                                    \r\n"
				+ "                               , TRGTSTR.NTN_CD                                                                                                                                                                                                                              \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B14                                                                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17\r\n"
				+ "                               , '01'                                                           AS B18\r\n"
				+ "                               , '01'                                                           AS B19\r\n"
				+ "                               , TRGTSTR.STR_YN                                                 AS B20 /* 당사자,관련인 STR 보고 3회이상 */                                                                                                                       \r\n"
				+ "                               , '01'                                                           AS B21\r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_STR TRGTSTR                                                                                                                                                                                                                        \r\n"
				+ "                           WHERE 1 = 1                                                                                                                                                                                                                                         \r\n"
				+ "                           UNION ALL                                                                                                                                                                                                                                            \r\n"
				+ "                          SELECT TRGTVAP.RNMCNO                                                                                                                                                                                                                         \r\n"
				+ "                               , TRGTVAP.INDV_CORP_CCD                                                                                                                                                                                                                    \r\n"
				+ "                               , TRGTVAP.NTN_CD                                                                                                                                                                                                                              \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B14                                                                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17\r\n"
				+ "                               , '01'                                                           AS B18\r\n"
				+ "                               , '01'                                                           AS B19\r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , TRGTVAP.VAP_YN                                                 AS B21 /* 가상자산사업자여부 */                                                                                                                                     \r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_VAP TRGTVAP                                                                                                                                                                                                                       \r\n"
				+ "                           WHERE 1 = 1\r\n"
				+ "                           UNION ALL\r\n"
				+ "                           SELECT PRCE.RNMCNO                                                                                                                                                                                                                         \r\n"
				+ "                               , PRCE.INDV_CORP_CCD                                                                                                                                                                                                                    \r\n"
				+ "                               , PRCE.NTN_CD                                                                                                                                                                                                                              \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B14                                                                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17\r\n"
				+ "                               , '01'                                                           AS B18\r\n"
				+ "                               , '01'                                                           AS B19\r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B21 \r\n"
				+ "                               , PRCE.PRCE_YN                                                   AS B22 /* 금융범죄연류고객 */\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_PRCE PRCE\r\n"
				+ "                           WHERE 1 = 1                                                                                     \r\n"
				+ "                           UNION ALL                                                                                                                                                                                                                                            \r\n"
				+ "                          /* 범위: 12개월, STR/CTR 보고건수 */                                                                                                                                                                                                             \r\n"
				+ "                          SELECT TR.RNMCNO                                                                                                                                                                                                                                  \r\n"
				+ "                               , TR.INDV_CORP_CCD                                                                                                                                                                                                                            \r\n"
				+ "                               , TR.NTN_CD                                                                                                                                                                                                                                      \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B14                                                                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17\r\n"
				+ "                               , '01'                                                           AS B18\r\n"
				+ "                               , '01'                                                           AS B19\r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B21\r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , CASE WHEN NIC66.SSPS_DL_CRT_CCD IN ('STR', 'KYC')                                                                                                                                                                                 \r\n"
				+ "                                      AND NIC66.RPR_PRGRS_CCD IN ('99', '10') THEN 1 ELSE 0 END AS B23 /* 관련인 STR보고건수    : 완료 */                                                                                                             \r\n"
				+ "                               , CASE WHEN NIC66.SSPS_DL_CRT_CCD IN ('CTR', 'CAC')                                                                                                                                                                                 \r\n"
				+ "                                      AND NIC66.RPR_PRGRS_CCD IN ('99', '10') THEN 1 ELSE 0 END AS B24 /* 관련인 CTR보고건수    : 완료 */                                                                                                             \r\n"
				+ "                               , 0                                                              AS B25                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B26                                                                                                                                                                            \r\n"
				+ "                            FROM TRGT_D_BASE TDB                                                                                                                                                                                                                          \r\n"
				+ "                               , TRGT_RNMCNO TR                                                                                                                                                                                                                             \r\n"
				+ "                               , NIC66B      NIC66                                                                                                                                                                                                                              \r\n"
				+ "                               , NIC102B     NIC102                                                                                                                                                                                                                            \r\n"
				+ "                           WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                                                                                                                                                \r\n"
				+ "                             AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                                                                                                                                       \r\n"
				+ "                             AND NIC66.SSPS_DL_CRT_CCD IN ('STR', 'KYC', 'CTR', 'CAC')                                                                                                                                                                               \r\n"
				+ "                             AND NIC66.SSPS_DL_CRT_DT = NIC102.SSPS_DL_CRT_DT                                                                                                                                                                                  \r\n"
				+ "                             AND NIC66.SSPS_DL_ID     = NIC102.SSPS_DL_ID                                                                                                                                                                                            \r\n"
				+ "                             AND TR.RNMCNO            = NIC66.DL_P_RNMCNO                                                                                                                                                                                        \r\n"
				+ "                           UNION ALL                                                                                                                                                                                                                                            \r\n"
				+ "                          SELECT TR.RNMCNO                                                                                                                                                                                                                                  \r\n"
				+ "                               , TR.INDV_CORP_CCD                                                                                                                                                                                                                            \r\n"
				+ "                               , TR.NTN_CD                                                                                                                                                                                                                                      \r\n"
				+ "                               , 0                                                              AS B01                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B02                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS B03                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B04                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B05                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B06                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B07                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B08                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B09                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B10                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B11                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B12                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B13                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B14                                                                                                                                                                            \r\n"
				+ "                               , '02'                                                           AS B15                                                                                                                                                                            \r\n"
				+ "                               , NULL                                                           AS B16                                                                                                                                                                          \r\n"
				+ "                               , 0                                                              AS IMG                                                                                                                                                                           \r\n"
				+ "                               , '01'                                                           AS B17\r\n"
				+ "                               , '01'                                                           AS B18\r\n"
				+ "                               , '01'                                                           AS B19\r\n"
				+ "                               , '01'                                                           AS B20                                                                                                                                                                            \r\n"
				+ "                               , '01'                                                           AS B21\r\n"
				+ "                               , '01'                                                           AS B22\r\n"
				+ "                               , 0                                                              AS B23                                                                                                                                                                            \r\n"
				+ "                               , 0                                                              AS B24                                                                                                                                                                            \r\n"
				+ "                               , NIC75.DL_AMT                                                   AS B25 /* 관련인 STR보고금액    : 완료 */                                                                                                                            \r\n"
				+ "                               , NIC75.CSH                                                      AS B26 /* 관련인 CTR보고금액    : 완료 */                                                                                                                             \r\n"
				+ "                            FROM TRGT_D_BASE   TDB                                                                                                                                                                                                                        \r\n"
				+ "                               , TRGT_RNMCNO   TR                                                                                                                                                                                                                           \r\n"
				+ "                               , NIC66B        NIC66                                                                                                                                                                                                                            \r\n"
				+ "                               , NIC75B        NIC75                                                                                                                                                                                                                            \r\n"
				+ "                               , NIC102B       NIC102                                                                                                                                                                                                                          \r\n"
				+ "                           WHERE NIC66.SSPS_DL_CRT_DT <  TO_CHAR(TDB.CUR_DT, 'YYYYMMDD')                                                                                                                                                                \r\n"
				+ "                             AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(TDB.CUR_DT, -12), 'YYYYMMDD')                                                                                                                                       \r\n"
				+ "                             AND ((     NIC66.SSPS_DL_CRT_CCD IN ('STR', 'KYC')                                                                                                                                                                                        \r\n"
				+ "                                    AND NIC66.RPR_PRGRS_CCD IN ('99', '10'))                                                                                                                                                                                            \r\n"
				+ "                              OR (      NIC66.SSPS_DL_CRT_CCD IN ('CTR', 'CAC')                                                                                                                                                                                        \r\n"
				+ "                                    AND NIC66.RPR_PRGRS_CCD IN ('99', '10')))                                                                                                                                                                                           \r\n"
				+ "                             AND TR.RNMCNO = NIC66.DL_P_RNMCNO                                                                                                                                                                                                   \r\n"
				+ "                             AND NIC75.RNMCNO = NIC66.DL_P_RNMCNO                                                                                                                                                                                               \r\n"
				+ "                             AND NIC75.SSPS_DL_CRT_DT = NIC66.SSPS_DL_CRT_DT                                                                                                                                                                                    \r\n"
				+ "                             AND NIC75.SSPS_DL_ID = NIC66.SSPS_DL_ID                                                                                                                                                                                                 \r\n"
				+ "                             AND NIC66.SSPS_DL_CRT_DT = NIC102.SSPS_DL_CRT_DT                                                                                                                                                                                  \r\n"
				+ "                             AND NIC66.SSPS_DL_CRT_DT = NIC102.SSPS_DL_CRT_DT                                                                                                                                                                                  \r\n"
				+ "                        )GROUP BY RNMCNO                                                                                                                                                                                                                                  \r\n"
				+ "             )                                                                                                                                                                                                                                                                     \r\n"
				+ "                                                                                                                                                                                                                                                                                     \r\n"
				+ " )A                                                                                                                                                                                                                                                                                 \r\n"
				+ " INNER JOIN T_RA_ITEM_WGHT WGHT                                                                                                                                                                                                                                     \r\n"
				+ "         ON WGHT.CS_TYP_CD = A.CS_TYP_CD                                                                                                                                                                                                                             \r\n"
				+ "        AND WGHT.NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD                                                                                                                                                                                                         \r\n"
				+ "        )J1                                                                                                                                                                                                                                                                          \r\n"
				+ "                                                                                                                                                                                                                                                                                     \r\n"
				+ "  )X1                                                                                                                                                                                                                                                                               \r\n"
				+ "  LEFT JOIN RA_ITEM_SCR SCR                                                                                                                                                                                                                                               \r\n"
				+ "      ON X1.RA_ITEM_CD = SCR.RA_ITEM_CD                                                                                                                                                                                                                              \r\n"
				+ "     AND X1.JOIN_RA_ITEM_VAL = SCR.RA_ITEM_VAL	                                                                                                                                                                                                                  \r\n"
				+ " )  "
		;
    	rtnString = forOracle;
    	
		return rtnString;
	}



    /**
     * <pre>
     * RA결과를 DB에 insert. 1. update NIC35B 2. insert NIC06B 3. insert NIC06B_1 4. insert NIC06B_2
     * RA結果をDBにインサート。1. update NIC35B 2. insert NIC06B 3. insert NIC06B_1 4. insert NIC06B_2
     * @en
     * </pre>
     *@param obj Scoring result object
     *
     *@throws Exception
     */
    public void setKRA_Info(ResultSet rs) throws SQLException {

        try {
	    	initStartTime();
	    	insertRA_CS_RA_RSLT_DTL(rs);
	        checkExec();
        }catch (Exception e) {
        	_log.error(e);
        	throw e;
        }finally{
        }
    }

    protected void insertRA_CS_RA_RSLT_DTL(ResultSet rs) throws SQLException {
    	int i = 0;
    	System.out.println(getInputParam().getRaID());
    	System.out.println(rs.getObject("RNMCNO"));
    	System.out.println(rs.getObject("RA_ITEM_CD"));
    	System.out.println(rs.getObject("CS_TYP_CD"));
    	System.out.println(rs.getObject("NEW_OLD_GBN_CD"));
    	System.out.println(rs.getObject("RA_ITEM_VAL"));
    	System.out.println(rs.getObject("RA_ITEM_SCR"));
    	System.out.println(rs.getObject("RA_ITEM_WGHT"));
    	System.out.println(rs.getObject("RA_ITEM_LST_SCR"));
    	System.out.println(getInputParam().getUserId());
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, getInputParam().getRaID());
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, rs.getObject("RNMCNO"));
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, rs.getObject("RA_ITEM_CD"));
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, rs.getObject("CS_TYP_CD"));
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, rs.getObject("NEW_OLD_GBN_CD"));
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, rs.getObject("RA_ITEM_VAL"));
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, rs.getObject("RA_ITEM_SCR"));
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, rs.getObject("RA_ITEM_WGHT"));
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, rs.getObject("RA_ITEM_LST_SCR"));
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, getInputParam().getUserId());
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.setObject(++i, getInputParam().getUserId());
    	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_DTL_001.addBatch();

    	_log.debug("insertRA_CS_RA_RSLT_DTL completed");
    }

    private long startTime = -1;
    private void initStartTime() {
        if(startTime < 0) startTime = Timer.getInstance().start();
    }

    /**
     * <pre>
     * 모든 statement의  batch 실행
     * すべてのstatementのバッチを実行
     * @en
     * </pre>
     *@throws Exception
     */
    private void execBatch() throws SQLException {
        if(m_nCounter > 0) {
            @SuppressWarnings("unused")
            long start = Timer.getInstance().start();
            _log.debug(AML_Log.LINE_SEPARATOR_STRING);
            //_log.debug("execBatch start.");
            PreparedStatement pstmt = null;
            for (int i = 0; i < m_pstmtList.size(); i++) {
                pstmt = m_pstmtList.get(i);
                pstmt.executeBatch();
                pstmt.clearBatch();
                //start = Timer.getInstance().stopAndPrintDebug(_log,(i+1) + "'st PreparedStatement execute & clear Elapsed Time", start);
            }
            if(Config.getInstance().getKRSCommitEachDataBlockCompleted()) {
                conn.commit();
                _log.debug("commit");
            }
            m_nCounter = 0;

            //_log.debug("execBatch completed");
            Timer.getInstance().stopAndPrintInfo(_log,"total " + m_TotalCount + " row(s) completed - Data block elapsed time", startTime);
        }
    }

    /**
     * <pre>
     * AMLBATCH.ini의 KRA_DATA_BLOCK_SIZE 만큼 addBatch를 하였다면 execBatch method 호출
     * AMLBATCH.iniのKRA_DATA_BLOCK_SIZE分addBatchをした場合はexecBatch methodを呼び出す。
     * @en
     * </pre>
     *@throws Exception
     */
    private void checkExec() throws SQLException {
        m_TotalCount++;
        if(++m_nCounter >= BATCH_BLOCK_SIZE)
        {

            execBatch();
        }
    }

    /**
     * <pre>
     * 스코어링을 실시한 고객수
     * スコアリングを行った顧客数
     * @en
     * </pre>
     *@return
     */
    public long getTotalCount() {
        return m_TotalCount;
    }



    /**
     * <pre>
     * 스코어링 실행 전 process, 기본은 아무것도 안 함.
     * スコアリング実行前のプロセス。基本は何もしない。
     * @en
     * </pre>
     *@throws Exception
     */
    public void preProcess() throws SQLException {
    	//DBUtil.executeUpdate(conn, "DELETE FROM RA_CS_RA_RSLT_DTL WHERE RA_ID = '" + '1' + "'");
    	//DBUtil.executeUpdate(conn, "DELETE FROM RA_CS_RA_RSLT WHERE RA_ID = '" + '1' + "'");
    	
    	DBUtil.executeUpdate(conn, "DELETE FROM RA_CS_RA_RSLT_DTL WHERE RA_ID = '" + getInputParam().getRaID()+ "'");
    	DBUtil.executeUpdate(conn, "DELETE FROM RA_CS_RA_RSLT WHERE RA_ID = '" + getInputParam().getRaID()+ "'");
    	//DBUtil.executeUpdate(conn, "DELETE FROM RA_SMUL_RSLT WHERE RA_ID = '" + getInputParam().getRaID()+ "'");
    }



    /**
     * <pre>
     * 스코어링 실행 후 process, 기본은 아무것도 안 함.
     * スコアリング実行後のプロセス。基本は何もしない。
     * @en
     * </pre>
     *@throws Exception
     */
    public void postProcess() throws SQLException {
        ResultSet rs = null;
        ResultSet rs2 = null;
        PreparedStatement STRCTRCnt = null;
    	PreparedStatement STRCTRCnt1 = null;
        try {
        	m_pstmtList = new ArrayList<PreparedStatement>();

        	pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_001 = conn.prepareStatement(getQuery_SELECT_RA_CS_RA_RSLT_DTL_001());
        	//pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_002 = conn.prepareStatement(getQuery_SELECT_RA_CS_RA_RSLT_DTL_002());
        	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001 	= conn.prepareStatement(getQuery_INSERT_RA_CS_RA_RSLT_001());
        	//pstmt_KRAB_INSERT_RA_SMUL_RSLT_001 		= conn.prepareStatement(getQuery_INSERT_RA_SMUL_RSLT_001());
        	pstmt_KRAB_UPDATE_NIC35B 		= conn.prepareStatement(getQuery_UPDATE_NIC35B());

        	m_pstmtList.add(pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_001);
        	//m_pstmtList.add(pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_002);
        	m_pstmtList.add(pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001);
        	//m_pstmtList.add(pstmt_KRAB_INSERT_RA_SMUL_RSLT_001);
        	m_pstmtList.add(pstmt_KRAB_UPDATE_NIC35B);


            pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_001.setString(1, getInputParam().getRaID());
            rs = pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_001.executeQuery();

            int batchSize = 1000;
            int count = 0;
            
            while (rs.next()) {

            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(1, rs.getObject("RA_ID"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(2, rs.getObject("RNMCNO"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(3, rs.getObject("CS_TYP_CD"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(4, rs.getObject("NEW_OLD_GBN_CD"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(5, rs.getObject("RA_GRD_SCR2"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(6, rs.getObject("RA_GRD_CD"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(7, rs.getObject("LST_RA_GRD_CD"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(8, rs.getObject("EDD_YN1"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(9, rs.getObject("EDD_YN2"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(10, rs.getObject("EDD_YN3"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(11, rs.getObject("EDD_YN4"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(12, rs.getObject("EDD_YN5"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(13, rs.getObject("EDD_YN6"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(14, rs.getObject("EDD_YN7"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(15, rs.getObject("EDD_YN16"));
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(16, rs.getObject("EDD_YN17"));
            	
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(17, getInputParam().getUserId());
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.setObject(18, getInputParam().getUserId());
            	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.addBatch();

                pstmt_KRAB_UPDATE_NIC35B.setObject(1, rs.getObject("LST_RA_GRD_CD"));  	//위험등급
                pstmt_KRAB_UPDATE_NIC35B.setObject(2, rs.getObject("RA_GRD_SCR2"));  //위험점수
                pstmt_KRAB_UPDATE_NIC35B.setObject(3, getInputParam().getUserId());
                pstmt_KRAB_UPDATE_NIC35B.setObject(4, rs.getObject("RNMCNO"));
                pstmt_KRAB_UPDATE_NIC35B.addBatch();
            	
                count++;
                
                if(count % batchSize == 0) {
                	
                	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.executeBatch();
                	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.clearBatch();
                	
                	pstmt_KRAB_UPDATE_NIC35B.executeBatch();
                	pstmt_KRAB_UPDATE_NIC35B.clearBatch();
                	
                	conn.commit();
                }
            	
            }
            pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.executeBatch();
        	pstmt_KRAB_INSERT_RA_CS_RA_RSLT_001.clearBatch();
        	
        	pstmt_KRAB_UPDATE_NIC35B.executeBatch();
        	pstmt_KRAB_UPDATE_NIC35B.clearBatch();
        	
        	conn.commit();
        	
            checkExec();
            
            //pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_002.setString(1, getInputParam().getRaID());
            //rs2 = pstmt_KRAB_SELECT_RA_CS_RA_RSLT_DTL_002.executeQuery();

            //while (rs2.next()) {
        	//	pstmt_KRAB_INSERT_RA_SMUL_RSLT_001.setObject(1, rs2.getObject("RA_ID"));
        	//	pstmt_KRAB_INSERT_RA_SMUL_RSLT_001.setObject(2, rs2.getObject("CS_TYP_CD"));
        	//	pstmt_KRAB_INSERT_RA_SMUL_RSLT_001.setObject(3, rs2.getObject("NEW_OLD_GBN_CD"));
        	//	pstmt_KRAB_INSERT_RA_SMUL_RSLT_001.setObject(4, rs2.getObject("LST_RA_GRD_CD"));
        	//	pstmt_KRAB_INSERT_RA_SMUL_RSLT_001.setObject(5, rs2.getObject("CS_CNT"));
        	//	pstmt_KRAB_INSERT_RA_SMUL_RSLT_001.setObject(6, getInputParam().getUserId());
        	//	pstmt_KRAB_INSERT_RA_SMUL_RSLT_001.addBatch();
            //}
            

            //_log.debug("===========================STRAT");
   		 	//_log.debug(KRAB_Sql.KRAB_UPDATE_STRCTR_NIC35B);
            //STRCTRCnt = conn.prepareStatement(KRAB_Sql.KRAB_UPDATE_STRCTR_NIC35B);
    		//STRCTRCnt.executeUpdate();
            
    		//_log.debug("===========================STRAT");
    		//_log.debug(KRAB_Sql.KRAB_UPDATE_STRCTR_NIC06B);
    		//STRCTRCnt1 = conn.prepareStatement(KRAB_Sql.KRAB_UPDATE_STRCTR_NIC06B);
    		//STRCTRCnt1.executeUpdate();
    		
    		//_log.debug("===========================END");
    		
    		//checkExec();
        } catch (Exception e) {
            _log.error(e.getMessage(),e);
        } finally {
            DBUtil.close(rs);
            DBUtil.close(rs2);
        }
    }

}
