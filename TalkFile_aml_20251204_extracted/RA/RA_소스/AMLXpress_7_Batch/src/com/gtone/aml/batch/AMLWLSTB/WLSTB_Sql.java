package com.gtone.aml.batch.AMLWLSTB;

/**
 *<pre>
 * WATCHLIST(요주의 인물) 추출 배치 쿼리 클래스
 * @en
 *</pre>
 *@author 
 *@version 1.0
 *@history 1.0
 */
public class WLSTB_Sql {
    
    /**
     * <pre>
     * WATCHLIST 테이블(NIC19B)에서 계정계로 전달할 WATCHLIST(요주의 인물)를 Select하는 쿼리
     * 변경 분만 전송하던 것을 전체 전송으로 변경 
     * @en
     * </pre>
     */
    public static final String WLSTB_SELECT_NIC19B_001
	    = " SELECT CASE WHEN NIC19.WL_DEL_DT IS NOT NULL THEN 'D'                                             "
	    + "                                              ELSE 'I'                                             "
	    + "        END                                                                                        "
	    + "        || '||' ||NIC19.MNG_SNO|| '||' ||NIC19.WC_LIST_CCD|| '||' ||NIC19.NTV_FGNR_CCD             "
	    + "        || '||' ||NIC19.RNM_CNFR_CCD|| '||' ||NIC19.INDV_CORP_CCD|| '||' ||NIC19.RNMCNO            "
	    + "        || '||' ||NIC19.CS_NM|| '||' ||NIC19.NTN_CD|| '||' ||NIC19.NTN_NM|| '||' ||NIC19.ADDR      "
	    + "        || '||' ||NIC19.HNGL_NM|| '||' ||NIC19.PSPT_NO|| '||' ||NIC19.WL_BIRTHDAY                  "
	    + "        || '||' ||NIC19.ORG_NM                                                                     "
	    + "        || '||' ||NIC19.WL_DEL_DT|| '||' ||NIC19.APPL_DT                                           "
	    + "   FROM (SELECT 'Y' AS APPL_YN                                                                     "
	    + "           FROM NIC19B NIC19                                                                       "
	    + "          WHERE NIC19.NORM_YN = 'Y'                                                                "
	    + "            AND NIC19.APPL_YN = 'Y'                                                                "
	    + "            AND NIC19.APPL_DT = ?                                                                  "
	    + "            AND ROWNUM = 1) NIC19_M                                                                "
	    + "        LEFT OUTER JOIN NIC19B NIC19                                                               "
	    + "                     ON (1 = 1)                                                                    ";

    
    public static final String WLSTB_SELECT_NIC19B_ALL
		= " SELECT  																																	\n"
		+ " 	GUBUN || '||' || MNG_SNO || '||' || WC_LIST_CCD || '||' || NTV_FGNR_CCD || '||' || RNM_CNFR_CCD || '||' || INDV_CORP_CCD 				\n"
		+ " 		  || '||' || RNMCNO || '||' || CS_NM || '||' || NTN_CD || '||' || NTN_NM || '||' || ADDR || '||' || HNGL_NM || '||' || PSPT_NO || '||' || WL_BIRTHDAY	\n" 
		+ " 		  || '||' || ORG_NM || '||' || WL_DEL_DT || '||' || APPL_DT || '||' || SEX      \n"
		+ " FROM (   SELECT 'I'      AS GUBUN                                                    \n" 
	    + "          , A.MNG_SNO     AS MNG_SNO                                                  \n" 
	    + "          , WC_LIST_CCD   AS WC_LIST_CCD                                              \n" 
	    + "          , (CASE WHEN NTN_CD <> 'KR' THEN 'B' ELSE 'A' END) AS NTV_FGNR_CCD          \n" 
	    + "          , ''            AS RNM_CNFR_CCD                                             \n" 
	    + "          , A.INDV_CORP_CCD AS INDV_CORP_CCD                                          \n" 
	    + "          , ''            AS RNMCNO                                                   \n" 
	    + "          , A.CS_NM       AS CS_NM                                                    \n" 
	    + "          , A.NTN_CD      AS NTN_CD                                                   \n" 
	    + "          , A.NTN_NM      AS NTN_NM                                                   \n" 
	    + "          , A.ADDR        AS ADDR                                                     \n" 
	    + "          , ''            AS HNGL_NM                                                  \n" 
	    + "          , B.ID_VALUE    AS PSPT_NO                                                  \n" 
	    + "          , A.WL_BIRTHDAY AS WL_BIRTHDAY                                              \n" 
	    + "          , ''            AS ORG_NM                                                   \n" 
	    + "          , ''            AS WL_DEL_DT                                                \n" 
	    + "          , B.FAC_REG_DT  AS APPL_DT                                                  \n"
	    + "          , A.SEX  AS SEX                                                             \n"
	    + "      FROM NIC19B_FACTIVA A                                                         	 \n"
	    + "         , WAL_ID B                                                                 	 \n"
	    + "     WHERE A.MNG_SNO = B.DJ_UID(+)                                                    \n" 
	    + "       AND A.WC_LIST_CCD NOT IN ('W130')                      						\n"
	    + "       AND B.ID_TYPE(+) = 'Passport No.'                                              \n" 
	    + "       AND B.SEQ(+) = 1                                                               \n" 
    	+ " ) 						                                                             \n"; 
                                                                                                 
    // 초기 한번은 NIC19B_FACTIVA  다 가져가야 함                              
    // 변동분 관련                                                             
    // 1) 변동 시 오늘 날짜로 변경된건  관련 계정계에서  관련 MNG_SNO 키로 삭제
    // "    // 1) 변동 시 오늘 날짜로 추가 및 변경된건 계정계 추가                              
    public static final String WLSTB_SELECT_NIC19B_M
	= " SELECT  																																	\n"
	+ " 	GUBUN || '||' || MNG_SNO || '||' || WC_LIST_CCD || '||' || NTV_FGNR_CCD || '||' || RNM_CNFR_CCD || '||' || INDV_CORP_CCD 				\n"
	+ " 		  || '||' || RNMCNO || '||' || CS_NM || '||' || NTN_CD || '||' || NTN_NM || '||' || ADDR || '||' || HNGL_NM || '||' || PSPT_NO || '||' || WL_BIRTHDAY	\n" 
	+ " 		  || '||' || ORG_NM || '||' || WL_DEL_DT || '||' || APPL_DT || '||' || SEX	       \n"
	
	+ " FROM (   SELECT 'D'      AS GUBUN                                                      \n" 
    + "          , DJ_UID AS MNG_SNO                                                           \n"
    + "          , '' AS WC_LIST_CCD                                                           \n"
    + "          , '' AS NTV_FGNR_CCD                                                          \n"
    + "          , '' AS RNM_CNFR_CCD                                                          \n"
    + "          , '' AS INDV_CORP_CCD                                                         \n"
    + "          , '' AS RNMCNO                                                                \n"
    + "          , '' AS CS_NM                                                                 \n"
    + "          , '' AS NTN_CD                                                                \n"
    + "          , '' AS NTN_NM                                                                \n"
    + "          , '' AS ADDR                                                                  \n"
    + "          , '' AS HNGL_NM                                                               \n"
    + "          , '' AS PSPT_NO                                                               \n"
    + "          , '' AS WL_BIRTHDAY                                                           \n"
    + "          , '' AS ORG_NM                                                                \n"
    + "          , FAC_REG_DT AS WL_DEL_DT                                   				   \n"
    + "          , '' AS APPL_DT                                                               \n"
    + "          , '' AS SEX                                                                   \n"
    + "      FROM WAL_BAS                                                                      \n"
    + "     WHERE TO_CHAR(HNDL_DY_TM,'YYYYMMDD') = ? 		                                   \n"
    + "    UNION                                                                               \n"
    + "                                                                                        \n"
    + "    SELECT 'I'            AS GUBUN                                                      \n"
    + "          , A.MNG_SNO     AS MNG_SNO                                                    \n"
    + "          , WC_LIST_CCD   AS WC_LIST_CCD                                                \n"
    + "          , (CASE WHEN NTN_CD <> 'KR' THEN 'B' ELSE 'A' END) AS NTV_FGNR_CCD            \n"
    + "          , ''            AS RNM_CNFR_CCD                                               \n"
    + "          , A.INDV_CORP_CCD AS INDV_CORP_CCD                                            \n"
    + "          , ''            AS RNMCNO                                                     \n"
    + "          , A.CS_NM       AS CS_NM                                                      \n"
    + "          , A.NTN_CD      AS NTN_CD                                                     \n"
    + "          , A.NTN_NM      AS NTN_NM                                                     \n"
    + "          , A.ADDR        AS ADDR                                                       \n"
    + "          , ''            AS HNGL_NM                                                    \n"
    + "          , B.ID_VALUE    AS PSPT_NO                                                    \n"
    + "          , A.WL_BIRTHDAY AS WL_BIRTHDAY                                                \n"
    + "          , ''            AS ORG_NM                                                     \n"
    + "          , ''            AS WL_DEL_DT                                                  \n"
    + "          , B.FAC_REG_DT  AS APPL_DT                                                    \n"
    + "          , A.SEX         AS SEX                                                        \n"
    + "      FROM NIC19B_FACTIVA A                                                             \n"
    + "         , WAL_ID B                                                                     \n"
    + "     WHERE A.MNG_SNO = B.DJ_UID(+)                                                      \n"
    + "       AND B.ID_TYPE(+) = 'Passport No.'                                                \n"
    + "       AND A.WC_LIST_CCD NOT IN ('W130')                        							\n"
    + "       AND B.SEQ(+) = 1                                                                 \n"
    + "       AND TO_CHAR(A.HNDL_DY_TM,'YYYYMMDD') = ?                               		   \n"
    + "       )										                                		   \n";
    
    public static final String WLSTB_SELECT_NIC19B_B
	= " SELECT  																																	\n"
	+ " 	GUBUN || '||' || MNG_SNO || '||' || WC_LIST_CCD || '||' || NTV_FGNR_CCD || '||' || RNM_CNFR_CCD || '||' || INDV_CORP_CCD 				\n"
	+ " 		  || '||' || RNMCNO || '||' || CS_NM || '||' || NTN_CD || '||' || NTN_NM || '||' || ADDR || '||' || HNGL_NM || '||' || PSPT_NO || '||' || WL_BIRTHDAY	\n" 
	+ " 		  || '||' || ORG_NM || '||' || WL_DEL_DT || '||' || APPL_DT || '||' || SEX	       \n"
	+ " FROM (   SELECT 'D'      AS GUBUN                                                      \n" 
    + "          , DJ_UID AS MNG_SNO                                                           \n"
    + "          , '' AS WC_LIST_CCD                                                           \n"
    + "          , '' AS NTV_FGNR_CCD                                                          \n"
    + "          , '' AS RNM_CNFR_CCD                                                          \n"
    + "          , '' AS INDV_CORP_CCD                                                         \n"
    + "          , '' AS RNMCNO                                                                \n"
    + "          , '' AS CS_NM                                                                 \n"
    + "          , '' AS NTN_CD                                                                \n"
    + "          , '' AS NTN_NM                                                                \n"
    + "          , '' AS ADDR                                                                  \n"
    + "          , '' AS HNGL_NM                                                               \n"
    + "          , '' AS PSPT_NO                                                               \n"
    + "          , '' AS WL_BIRTHDAY                                                           \n"
    + "          , '' AS ORG_NM                                                                \n"
    + "          , FAC_REG_DT AS WL_DEL_DT                                   				   \n"
    + "          , '' AS APPL_DT                                                               \n"
    + "          , '' AS SEX                                                                   \n"
    + "      FROM WAL_BAS                                                                      \n"
    + "     WHERE TO_CHAR(HNDL_DY_TM,'YYYYMMDD') BETWEEN ? AND ?                               \n"
    + "                                                                                        \n"
    + "    UNION                                                                               \n"
    + "                                                                                        \n"
    + "    SELECT 'I'            AS GUBUN                                                      \n"
    + "          , A.MNG_SNO     AS MNG_SNO                                                    \n"
    + "          , WC_LIST_CCD   AS WC_LIST_CCD                                                \n"
    + "          , (CASE WHEN NTN_CD <> 'KR' THEN 'B' ELSE 'A' END) AS NTV_FGNR_CCD            \n"
    + "          , ''            AS RNM_CNFR_CCD                                               \n"
    + "          , A.INDV_CORP_CCD AS INDV_CORP_CCD                                            \n"
    + "          , ''            AS RNMCNO                                                     \n"
    + "          , A.CS_NM       AS CS_NM                                                      \n"
    + "          , A.NTN_CD      AS NTN_CD                                                     \n"
    + "          , A.NTN_NM      AS NTN_NM                                                     \n"
    + "          , A.ADDR        AS ADDR                                                       \n"
    + "          , ''            AS HNGL_NM                                                    \n"
    + "          , B.ID_VALUE    AS PSPT_NO                                                    \n"
    + "          , A.WL_BIRTHDAY AS WL_BIRTHDAY                                                \n"
    + "          , ''            AS ORG_NM                                                     \n"
    + "          , ''            AS WL_DEL_DT                                                  \n"
    + "          , A.FAC_REG_DT  AS APPL_DT                                                    \n"
    + "          , A.SEX  AS SEX                                                               \n"
    + "      FROM NIC19B_FACTIVA A                                                             \n"
    + "         , WAL_ID B                                                                     \n"
    + "     WHERE A.MNG_SNO = B.DJ_UID(+)                                                      \n"
    + "       AND B.ID_TYPE(+) = 'Passport No.'                                                \n"
    + "       AND B.SEQ(+) = 1                                                                 \n"
    + "       AND A.WC_LIST_CCD NOT IN ('W130')                        							\n"
    + "       AND TO_CHAR(A.HNDL_DY_TM,'YYYYMMDD') BETWEEN ? AND ?                             \n"
    + "       )										                                		   \n";
    
    
}