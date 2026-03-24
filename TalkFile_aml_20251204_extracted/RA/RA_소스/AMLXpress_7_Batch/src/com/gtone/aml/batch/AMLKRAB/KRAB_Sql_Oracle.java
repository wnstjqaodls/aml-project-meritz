package com.gtone.aml.batch.AMLKRAB;

/**
 * 
 *<pre>
 * 고객 위험평가 배치 쿼리 (for Oracle)
 *</pre>
 *@author ekwon
 *@version 1.0
 *@history 1.0 2019-06-04
 */
public class KRAB_Sql_Oracle extends KRAB_Sql {
	
	public final String DBType = "oracle";
	public String getDBType() {
		return DBType;
	}
    
	public String KRAB_SELECT_RUN_DATE() {
		return "SELECT CASE WHEN TAGT_DATE = 'N' THEN 'N' ELSE 'Y' END KRCNT \r\n"+
			   "  FROM ( \r\n" +
			   "        SELECT CASE WHEN NVL(MAX(TAGT_DATE), '00001231') = '00001231' THEN 'N' ELSE 'Y' END AS TAGT_DATE FROM ( \r\n" +
			   "               SELECT CASE WHEN NIC93.END_DY_TM IS NULL                                         \r\n" +
			   "                      THEN IAUIC.TAGT_DATE                                                		\r\n" +
			   "                      WHEN SUBSTR(IAUIC.TAGT_DATE, 1, 6) > TO_CHAR(NIC93.END_DY_TM, 'YYYYMM')  	\r\n" +
			   "                      THEN IAUIC.TAGT_DATE                                                		\r\n" +
			   "                      ELSE '00001231'                                                     		\r\n" +
			   "                      END AS TAGT_DATE                                                          \r\n" +
			   "                 FROM SID.IDO_A_UUE_INSN_CALENDAR IAUIC                                         \r\n" +
			   "                    , SSQ.NIC93B NIC93                                                          \r\n" +
			   "                WHERE IAUIC.ENTY_ID = 1                                                         \r\n" +
			   "                  AND IAUIC.HDAY_YN = 'N'                                                       \r\n" +
			   "                  AND IAUIC.TAGT_DATE = ?                                                       \r\n" +
			   "                  AND NIC93.JOB_ID = 'B40002'))                                                 " ;
				
	}
	
	public String KRAB_SELECT_RA_WORK_INFO_001() {
		return //"SELECT RA_WORK_INFO_SEQ.nextval FROM dual"
				"SELECT NVL(MAX(RA_ID),0) + 1 AS SEQ FROM RA_CS_RA_RSLT_DTL"
				;
	}
	
    public String KRAB_INSERT_RA_CS_RA_RSLT_DTL_001() {
    	return "INSERT INTO RA_CS_RA_RSLT_DTL \r\n" + 
    			"	(RA_ID, RNMCNO, RA_ITEM_CD, CS_TYP_CD, NEW_OLD_GBN_CD, RA_ITEM_VAL, RA_ITEM_SCR, RA_ITEM_WGHT, RA_ITEM_LST_SCR, REG_ID, REG_DT, UPD_ID, UPD_DT) \r\n" + 
    			"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?, SYSDATE)"
    			;
    }

	public String KRAB_SELECT_RA_CS_RA_RSLT_DTL_001() {
		return "SELECT A.RA_ID\r\n"
				+ "     , A.RNMCNO\r\n"
				+ "     , A.CS_TYP_CD\r\n"
				+ "     , A.NEW_OLD_GBN_CD\r\n"
				+ "     , A.RA_GRD_SCR\r\n"
				+ "     , A.RA_GRD_SCR2\r\n"
				+ "     , NVL (  \r\n"
				+ "            (SELECT RA_GRD_CD  \r\n"
				+ "               FROM RA_GRD_STD \r\n"
				+ "              WHERE CS_TYP_CD  = A.CS_TYP_CD \r\n"
				+ "                AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD \r\n"
				+ "                AND RA_GRD_SCR_MAX = ( \r\n"
				+ "                                      SELECT MIN(RA_GRD_SCR_MAX) \r\n"
				+ "                                        FROM RA_GRD_STD \r\n"
				+ "                                       WHERE CS_TYP_CD  = A.CS_TYP_CD \r\n"
				+ "                                         AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD  \r\n"
				+ "                                         AND A.RA_GRD_SCR < RA_GRD_SCR_MAX \r\n"
				+ "                 )  \r\n"
				+ "            ) \r\n"
				+ "           ,( \r\n"
				+ "                SELECT RA_GRD_CD  \r\n"
				+ "                 FROM  RA_GRD_STD \r\n"
				+ "                 WHERE CS_TYP_CD  = A.CS_TYP_CD \r\n"
				+ "                   AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD  \r\n"
				+ "                   AND RA_GRD_SCR_MAX = (SELECT MAX(RA_GRD_SCR_MAX) FROM RA_GRD_STD WHERE CS_TYP_CD  = A.CS_TYP_CD AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD ))-- CD가 'B003'인 경우의 최대 RA_ITEM_SCR \r\n"
				+ "           ) AS RA_GRD_CD \r\n"
				+ "     , CASE WHEN EDD_YN1  = 'Y' THEN 'H' \r\n"
				+ "            WHEN EDD_YN2  = 'Y' THEN 'H' \r\n"
				+ "            WHEN EDD_YN3  = 'Y' THEN 'H' \r\n"
				+ "            WHEN EDD_YN4  = 'Y' THEN 'H' \r\n"
				+ "            WHEN EDD_YN5  = 'Y' THEN 'H' \r\n"
				+ "            WHEN EDD_YN6  = 'Y' THEN 'H' \r\n"
				+ "            WHEN EDD_YN7  = 'Y' THEN 'H' \r\n"
				+ "            WHEN EDD_YN16 = 'Y' THEN 'H' \r\n"
				+ "            WHEN EDD_YN17 = 'Y' THEN 'H' \r\n"
				+ "       ELSE NVL(  \r\n"
				+ "                (SELECT RA_GRD_CD  \r\n"
				+ "                   FROM RA_GRD_STD \r\n"
				+ "                  WHERE CS_TYP_CD  = A.CS_TYP_CD \r\n"
				+ "                    AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD \r\n"
				+ "                    AND RA_GRD_SCR_MAX = ( \r\n"
				+ "                                          SELECT MIN(RA_GRD_SCR_MAX) \r\n"
				+ "                                            FROM RA_GRD_STD \r\n"
				+ "                                           WHERE CS_TYP_CD  = A.CS_TYP_CD \r\n"
				+ "                                             AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD  \r\n"
				+ "                                             AND A.RA_GRD_SCR < RA_GRD_SCR_MAX \r\n"
				+ "                       )  \r\n"
				+ "                ) \r\n"
				+ "               ,( \r\n"
				+ "                 SELECT RA_GRD_CD  \r\n"
				+ "                   FROM  RA_GRD_STD \r\n"
				+ "                  WHERE CS_TYP_CD  = A.CS_TYP_CD \r\n"
				+ "                    AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD  \r\n"
				+ "                    AND RA_GRD_SCR_MAX = (SELECT MAX(RA_GRD_SCR_MAX) FROM RA_GRD_STD WHERE CS_TYP_CD  = A.CS_TYP_CD AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD ))-- CD가 'B003'인 경우의 최대 RA_ITEM_SCR \r\n"
				+ "               )  \r\n"
				+ "       END AS LST_RA_GRD_CD\r\n"
				+ "     , EDD_YN1\r\n"
				+ "     , EDD_YN2\r\n"
				+ "     , EDD_YN3\r\n"
				+ "     , EDD_YN4\r\n"
				+ "     , EDD_YN5\r\n"
				+ "     , EDD_YN6\r\n"
				+ "     , EDD_YN7\r\n"
				+ "     , EDD_YN16\r\n"
				+ "     , EDD_YN17\r\n"
				+ "  FROM ( \r\n"
				+ "        SELECT RA_ID\r\n"
				+ "             , RNMCNO \r\n"
				+ "             , CS_TYP_CD\r\n"
				+ "             , NEW_OLD_GBN_CD\r\n"
				+ "             , TRUNC(SUM(RA_GRD_SCR2),0) AS RA_GRD_SCR2\r\n"
				+ "             , (TRUNC(SUM(RA_GRD_SCR),0) /10)  AS RA_GRD_SCR \r\n"
				+ "             , DECODE(SUM(EDD_YN1),1,'Y','N')  AS EDD_YN1   /*국가*/\r\n"
				+ "             , DECODE(SUM(EDD_YN2),1,'Y','N')  AS EDD_YN2   /*고액자산가*/\r\n"
				+ "             , DECODE(SUM(EDD_YN3),1,'Y','N')  AS EDD_YN3   /*당사지정 요주의인물*/\r\n"
				+ "             , DECODE(SUM(EDD_YN4),1,'Y','N')  AS EDD_YN4   /*요주의 인물*/\r\n"
				+ "             , DECODE(SUM(EDD_YN5),1,'Y','N')  AS EDD_YN5   /*혐의거래 보고자*/\r\n"
				+ "             , DECODE(SUM(EDD_YN6),1,'Y','N')  AS EDD_YN6   /*가상자산사업자*/\r\n"
				+ "             , DECODE(SUM(EDD_YN7),1,'Y','N')  AS EDD_YN7   /*금융범죄 연류 고객*/\r\n"
				+ "             , DECODE(SUM(EDD_YN16),1,'Y','N') AS EDD_YN16  /*선물옵션 거래여부*/\r\n"
				+ "             , DECODE(SUM(EDD_YN17),1,'Y','N') AS EDD_YN17  /*거래종목*/\r\n"
				+ "         FROM (\r\n"
				+ "                SELECT /*+ FULL(A) PARALLEL(8) */ A.RA_ID \r\n"
				+ "                     , A.RNMCNO\r\n"
				+ "                     , A.CS_TYP_CD\r\n"
				+ "                     , A.NEW_OLD_GBN_CD\r\n"
				+ "                     , SUM(RA_ITEM_LST_SCR) AS RA_GRD_SCR2\r\n"
				+ "                     , SUM(RA_ITEM_LST_SCR) AS RA_GRD_SCR\r\n"
				+ "                     , CASE WHEN (CASE WHEN RA_ITEM_CD = 'I001' AND RA_ITEM_VAL = (SELECT RA_ITEM_VAL FROM RA_ITEM_SCR B WHERE A.RA_ITEM_VAL = B.RA_ITEM_VAL AND RA_ITEM_CD = 'I001') THEN (SELECT ABS_HRSK_YN FROM RA_ITEM_SCR B WHERE A.RA_ITEM_VAL = B.RA_ITEM_VAL AND RA_ITEM_CD = 'I001') END) IN ('Y','H') THEN 1 ELSE 0 END AS EDD_YN1\r\n"
				+ "                     , CASE WHEN RA_ITEM_CD = 'I009' AND RA_ITEM_VAL = '02' THEN 1 ELSE 0 END AS EDD_YN2 \r\n"
				+ "                     , CASE WHEN RA_ITEM_CD = 'I011' AND RA_ITEM_VAL = '02' THEN 1 ELSE 0 END AS EDD_YN3 \r\n"
				+ "                     , CASE WHEN RA_ITEM_CD = 'I012' AND RA_ITEM_VAL = '02' THEN 1 ELSE 0 END AS EDD_YN4 \r\n"
				+ "                     , CASE WHEN RA_ITEM_CD = 'I013' AND RA_ITEM_VAL = '02' THEN 1 ELSE 0 END AS EDD_YN5 \r\n"
				+ "                     , CASE WHEN RA_ITEM_CD = 'I014' AND RA_ITEM_VAL = '02' THEN 1 ELSE 0 END AS EDD_YN6 \r\n"
				+ "                     , CASE WHEN RA_ITEM_CD = 'I018' AND RA_ITEM_VAL = '02' THEN 1 ELSE 0 END AS EDD_YN7 \r\n"
				+ "                     , CASE WHEN RA_ITEM_CD = 'B019' AND RA_ITEM_VAL = '01' THEN 1 ELSE 0 END AS EDD_YN16 \r\n"
				+ "                     , CASE WHEN (CASE WHEN RA_ITEM_CD = 'B020' AND RA_ITEM_VAL = (SELECT RA_ITEM_VAL FROM RA_ITEM_SCR B WHERE A.RA_ITEM_VAL = B.RA_ITEM_VAL AND RA_ITEM_CD = 'B020') THEN (SELECT ABS_HRSK_YN FROM RA_ITEM_SCR B WHERE A.RA_ITEM_VAL = B.RA_ITEM_VAL AND RA_ITEM_CD = 'B020') END) = 'Y' THEN 1 ELSE 0 END AS EDD_YN17\r\n"
				+ "                  FROM RA_CS_RA_RSLT_DTL A\r\n"
				+ "                 WHERE RA_ID = ?  \r\n"
				+ "                 GROUP BY RA_ID,RNMCNO,CS_TYP_CD,NEW_OLD_GBN_CD, RA_ITEM_CD, RA_ITEM_VAL\r\n"
				+ "              )\r\n"
				+ "        GROUP BY RA_ID, RNMCNO, CS_TYP_CD, NEW_OLD_GBN_CD\r\n"
				+ "       ) A " 
				;
		
	}

	public String KRAB_SELECT_RA_CS_RA_RSLT_DTL_002() {
		return "SELECT RA_ID, CS_TYP_CD, NEW_OLD_GBN_CD, LST_RA_GRD_CD, COUNT(*) AS CS_CNT FROM (\r\n" + 
				"SELECT \r\n" + 
				"A.RA_ID,\r\n" + 
				"A.AML_CUST_ID,\r\n" + 
				"A.CS_TYP_CD,\r\n" + 
				"A.NEW_OLD_GBN_CD,\r\n" + 
				"A.RA_GRD_SCR,\r\n" + 
				"NVL( \r\n" + 
				"			( SELECT RA_GRD_CD \r\n" + 
				"			    FROM RA_GRD_STD\r\n" + 
				"			   WHERE CS_TYP_CD  = A.CS_TYP_CD\r\n" + 
				"			     AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD\r\n" + 
				"			     AND RA_GRD_SCR_MAX = (\r\n" + 
				"        				SELECT MIN(RA_GRD_SCR_MAX)\r\n" + 
				"				          FROM RA_GRD_STD\r\n" + 
				"				         WHERE CS_TYP_CD  = A.CS_TYP_CD\r\n" + 
				"						   AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD \r\n" + 
				"		            	   AND A.RA_GRD_SCR < RA_GRD_SCR_MAX\r\n" + 
				"    			 ) \r\n" + 
				"    		)\r\n" + 
				"	         ,(\r\n" + 
				"	        SELECT RA_GRD_CD \r\n" + 
				"	         FROM  RA_GRD_STD\r\n" + 
				"	         WHERE CS_TYP_CD  = A.CS_TYP_CD\r\n" + 
				"			   AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD \r\n" + 
				"	           AND RA_GRD_SCR_MAX = (SELECT MAX(RA_GRD_SCR_MAX) FROM RA_GRD_STD WHERE CS_TYP_CD  = A.CS_TYP_CD AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD ))-- CD가 'B003'인 경우의 최대 RA_ITEM_SCR\r\n" + 
				"    ) AS RA_GRD_CD,\r\n" + 
				"CASE WHEN MINOR_YN = 'Y' THEN 'H'\r\n" + 
				"	 WHEN NRES_YN = 'Y' THEN 'H'\r\n" + 
				"	 WHEN NFTC_YN = 'Y' THEN 'H'\r\n" + 
				"	 WHEN NPRFT_GRP_YN = 'Y' THEN 'H'\r\n" + 
				"	 WHEN HNW_YN = 'Y' THEN 'H'\r\n" + 
				"	 WHEN HRSK_NTN_YN = 'Y' THEN 'H'\r\n" + 
				"	 ELSE NVL( \r\n" + 
				"			( SELECT RA_GRD_CD \r\n" + 
				"			    FROM RA_GRD_STD\r\n" + 
				"			   WHERE CS_TYP_CD  = A.CS_TYP_CD\r\n" + 
				"			     AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD\r\n" + 
				"			     AND RA_GRD_SCR_MAX = (\r\n" + 
				"        				SELECT MIN(RA_GRD_SCR_MAX)\r\n" + 
				"				          FROM RA_GRD_STD\r\n" + 
				"				         WHERE CS_TYP_CD  = A.CS_TYP_CD\r\n" + 
				"						   AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD \r\n" + 
				"		            	   AND A.RA_GRD_SCR < RA_GRD_SCR_MAX\r\n" + 
				"    			 ) \r\n" + 
				"    		)\r\n" + 
				"	         ,(\r\n" + 
				"	        SELECT RA_GRD_CD \r\n" + 
				"	         FROM  RA_GRD_STD\r\n" + 
				"	         WHERE CS_TYP_CD  = A.CS_TYP_CD\r\n" + 
				"			   AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD \r\n" + 
				"	           AND RA_GRD_SCR_MAX = (SELECT MAX(RA_GRD_SCR_MAX) FROM RA_GRD_STD WHERE CS_TYP_CD  = A.CS_TYP_CD AND NEW_OLD_GBN_CD = A.NEW_OLD_GBN_CD ))-- CD가 'B003'인 경우의 최대 RA_ITEM_SCR\r\n" + 
				"    ) \r\n" + 
				"END AS LST_RA_GRD_CD,\r\n" + 
				"MINOR_YN,\r\n" + 
				"NRES_YN,\r\n" + 
				"NFTC_YN,\r\n" + 
				"NPRFT_GRP_YN,\r\n" + 
				"HNW_YN,\r\n" + 
				"HRSK_NTN_YN\r\n" + 
				"FROM (\r\n" + 
				"	SELECT \r\n" + 
				"	RA_ID,\r\n" + 
				"	AML_CUST_ID,\r\n" + 
				"	CS_TYP_CD,\r\n" + 
				"	NEW_OLD_GBN_CD,\r\n" + 
				"	SUM(RA_ITEM_LST_SCR) AS RA_GRD_SCR\r\n" + 
				"	FROM RA_CS_RA_RSLT_DTL A \r\n" + 
				"	WHERE RA_ID = ? \r\n" + 
				"	GROUP BY RA_ID,AML_CUST_ID,CS_TYP_CD,NEW_OLD_GBN_CD\r\n" + 
				") A\r\n" + 
				"INNER JOIN NIC01B_1 B\r\n" + 
				"ON A.AML_CUST_ID = B.AML_CUST_ID \r\n" + 
				"AND A.CS_TYP_CD = B.CS_TYP_CD \r\n" + 
				"AND A.NEW_OLD_GBN_CD = B.NEW_OLD_GBN_CD \r\n" + 
				")\r\n" + 
				"GROUP BY RA_ID, cs_typ_cd, new_old_gbn_cd, lst_ra_grd_cd"
				;
	}

	public String KRAB_INSERT_RA_CS_RA_RSLT_001() {
		return "INSERT INTO RA_CS_RA_RSLT (RA_ID, RNMCNO, CS_TYP_CD, NEW_OLD_GBN_CD, RA_GRD_SCR, RA_GRD_CD, LST_RA_GRD_CD, EDD_YN1, EDD_YN2, EDD_YN3, EDD_YN4, EDD_YN5, EDD_YN6, EDD_YN7, EDD_YN16, EDD_YN17, REG_ID, REG_DT, UPD_ID, UPD_DT)\r\n"
				+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?, SYSDATE)"
				;
	}

	public String KRAB_INSERT_RA_SMUL_RSLT_001() {
		return "INSERT INTO RA_SMUL_RSLT (RA_ID, CS_TYP_CD, NEW_OLD_GBN_CD, LST_RA_GRD_CD, CS_CNT, REG_ID, REG_DT) \r\n" + 
				"VALUES(?, ?, ?, ?, ?, ?, TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS'))";
	}
	
	public String KRAB_UPDATE_NIC35B_001() {
    	return 	  "UPDATE NIC35B										\n"
		        //+ "   SET PRV_RSK_GRD_CD = CASE WHEN AML_CRT_DT = ? 	\n"
		        //+ "							    THEN PRV_RSK_GRD_CD 	\n"
		        //+ "						   ELSE RSK_GRD_CD END 			\n"
		        + "   SET B_CHECK_DAT = TO_CHAR(SYSDATE, 'YYYYMMDD')	\n"
		        + "   	, B_RSK_GRD_CD = ?								\n"
		        + "   	, B_RSK_GRD_MRK = ?								\n"
		        + "   	, AML_CRT_DT = TO_CHAR(SYSDATE, 'YYYYMMDD')		\n"
		        + "   	, HNDL_DY_TM = SYSDATE							\n"
		        + "   	, HNDL_P_ENO = ?								\n"
		        + " WHERE RNMCNO = ?									\n";
    }
	
	 public String KRAB_UPDATE_STRCTR_NIC35B() {
	    return " MERGE INTO NIC35B A USING                                                                  \n"         
	    		 +"       		(                                                                              \n"
	    		 	// STR 보고건수                                                                
	    		 +"       		 SELECT DL_P_RNMCNO AS RNMCNO FROM(                                            \n"
	    		 +"                   SELECT NIC66.DL_P_RNMCNO                                                 \n"                                                                          
	    		 +"				      ,SSPS_DL_CRT_DT                                                          \n"                                                                                                                                                                                                                                                                                                   
	    		 +"				   FROM  NIC66B  NIC66                                                         \n"
	    		 +"				  WHERE 1 = 1                                                                  \n"                                                             
	    		 +"				    AND NIC66.SSPS_DL_CRT_DT <=  TO_CHAR(SYSDATE, 'YYYYMMDD')                  \n"                                                           
	    		 +"				    AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(SYSDATE, -12), 'YYYYMMDD')  \n"                                                          
	    		 +"				    AND NIC66.SSPS_DL_CRT_CCD IN ('STR', 'KYC')                                \n"
	    		 +"                   AND NIC66.RPR_PRGRS_CCD = '99'                                           \n"
	    		 +"                   GROUP BY  DL_P_RNMCNO ,SSPS_DL_CRT_DT                                    \n"
	    		 +"                   )                                                                        \n"
	    		 +"                  GROUP BY DL_P_RNMCNO                                                      \n"
	    		 +"                  HAVING COUNT(*) >=2                                                       \n"
	    		 +"               UNION                                                                        \n"
	    		 	// CTR 보고건수                                                              
	    		 +"                SELECT DL_P_RNMCNO AS RNMCNO FROM(                                          \n"
	    		 +"                   SELECT NIC66.DL_P_RNMCNO                                                 \n"                                                                          
	    		 +"				      ,SSPS_DL_CRT_DT                                                          \n"                                                                                                                                                                                                                                                                                                   
	    		 +"				   FROM  NIC66B  NIC66                                                         \n"
	    		 +"				  WHERE 1 = 1                                                                  \n"                                                             
	    		 +"				    AND NIC66.SSPS_DL_CRT_DT <=  TO_CHAR(SYSDATE, 'YYYYMMDD')                  \n"                                                           
	    		 +"				    AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(SYSDATE, -12), 'YYYYMMDD')  \n"                                                          
	    		 +"				    AND NIC66.SSPS_DL_CRT_CCD IN ('CTR')                                       \n"
	    		 +"                   AND NIC66.CTR_FWRD_TP_CODE = '1'                                         \n"
	    		 +"                   GROUP BY  DL_P_RNMCNO ,SSPS_DL_CRT_DT                                    \n"
	    		 +"                   )                                                                        \n"
	    		 +"                  GROUP BY DL_P_RNMCNO                                                      \n"
	    		 +"                  HAVING COUNT(*) >=4                                                       \n"
	    		 +"       		) B                                                                            \n"
	    		 +"       		ON ( A.RNMCNO = B.RNMCNO)                                                      \n"
	    		 +"       		WHEN Matched THEN                                                              \n"
	    		 +"       		     UPDATE SET B_RSK_GRD_CD = 'H'                     		                   \n"
	    		 +"  						      , B_CHECK_DAT = TO_CHAR(SYSDATE, 'YYYYMMDD')  			   \n"
	    		 +"  							  , AML_CRT_DT = TO_CHAR(SYSDATE, 'YYYYMMDD')				   \n"
	             +"  							  , HNDL_DY_TM = SYSDATE									   \n"
	             +"  							  , HNDL_P_ENO = 999999                						   \n"
	    		 +"       		  WHEN NOT MATCHED THEN                                                        \n"
	    		 +"       		      INSERT ( RNMCNO                                                          \n"
	    		 +"       		              , B_CHECK_DAT                                                    \n"
	    		 +"       		              , B_RSK_GRD_CD                                                   \n"
	    		 +"       		              , B_RSK_GRD_MRK                                                  \n"
	    		 +"       		              , AML_CRT_DT                                                     \n"
	    		 +"                           , HNDL_DY_TM                                                     \n"
	    		 +"                           , HNDL_P_ENO                                                     \n"
	    		 +"       		              ) VALUES ( B.RNMCNO                                              \n"
	    		 +"       		                        , TO_CHAR(SYSDATE, 'YYYYMMDD')                         \n"
	    		 +"       		                        , 'H'                                                  \n"
	    		 +"       		                        , 0                                                    \n"
	    		 +"       		                        , TO_CHAR(SYSDATE, 'YYYYMMDD')                         \n"
	    		 +"                                       , SYSDATE                                            \n"
	    		 +"                                       ,999999                                              \n"
	    		 +"       		                        )                                                      \n"

		;
	 }
	    
	    
	    /**
	     * <pre>
	     *  NIC06B에 B모델 당연고위험 반영
	     *  STR 최근 1년 2회이상 보고자(동일인제외)
	     *  CTR 최근 1년 4회이상 보고자(동일인제외)
	     * @en
	     * </pre>
	     */
	    public String KRAB_UPDATE_STRCTR_NIC06B() {
	    return " MERGE INTO NIC06B A USING                                                                    \n"
		+"        		(                                                                               \n"
		+"             -- STR 보고건수                                                                  \n"
		+"        		 SELECT DL_P_RNMCNO AS RNMCNO FROM(                                             \n"
		+"                    SELECT NIC66.DL_P_RNMCNO                                                  \n"                                                                         
		+"				      ,SSPS_DL_CRT_DT                                                           \n"                                                                                                                                                                                                                                                                                                  
		+"				   FROM  NIC66B  NIC66                                                          \n"
		+"				  WHERE 1 = 1                                                                   \n"                                                            
		+"				    AND NIC66.SSPS_DL_CRT_DT <=  TO_CHAR(SYSDATE, 'YYYYMMDD')                   \n"                                                          
		+"				    AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(SYSDATE, -12), 'YYYYMMDD')   \n"                                                         
		+"				    AND NIC66.SSPS_DL_CRT_CCD IN ('STR', 'KYC')                                 \n"
		+"                    AND NIC66.RPR_PRGRS_CCD = '99'                                            \n"
		+"                    GROUP BY  DL_P_RNMCNO ,SSPS_DL_CRT_DT                                     \n"
		+"                    )                                                                         \n"
		+"                   GROUP BY DL_P_RNMCNO                                                       \n"
		+"                   HAVING COUNT(*) >=2                                                        \n"
		+"                UNION                                                                         \n"
		+"                -- CTR 보고건수                                                                 \n"
		+"                 SELECT DL_P_RNMCNO AS RNMCNO FROM(                                           \n"
		+"                    SELECT NIC66.DL_P_RNMCNO                                                  \n"                                                                         
		+"				      ,SSPS_DL_CRT_DT                                                           \n"                                                                                                                                                                                                                                                                                                  
		+"				   FROM  NIC66B  NIC66                                                          \n"
		+"				  WHERE 1 = 1                                                                   \n"                                                            
		+"				    AND NIC66.SSPS_DL_CRT_DT <=  TO_CHAR(SYSDATE, 'YYYYMMDD')                   \n"                                                          
		+"				    AND NIC66.SSPS_DL_CRT_DT >= TO_CHAR(ADD_MONTHS(SYSDATE, -12), 'YYYYMMDD')   \n"                                                         
		+"				    AND NIC66.SSPS_DL_CRT_CCD IN ('CTR')                                        \n"
		+"                    AND NIC66.CTR_FWRD_TP_CODE = '1'                                          \n"
		+"                    GROUP BY  DL_P_RNMCNO ,SSPS_DL_CRT_DT                                     \n"
		+"                    )                                                                         \n"
		+"                   GROUP BY DL_P_RNMCNO                                                       \n"
		+"                   HAVING COUNT(*) >=4                                                        \n"
		+"        		) B                                                                             \n"
		+"        		ON ( A.RNMCNO = B.RNMCNO                                                        \n"
		+"                 AND A.KYC_TMS_CCD = 'K'                                                      \n"
		+"                 AND AML_CRT_DT Like TO_CHAR(SYSDATE, 'YYYYMMDD') || '%'                      \n"
		+"                )                                                                             \n"
		+"        		WHEN Matched THEN                                                               \n"
		+"        		     UPDATE SET RSK_GRD_CD = 'H'                                                \n"
		+"        		  WHEN NOT MATCHED THEN                                                         \n"
		+"        		      INSERT ( RNMCNO                                                           \n"
		+"        		              , KYC_TMS_CCD                                                     \n"
		+"        		              , AML_CRT_DT                                                      \n"
		+"        		              , RSK_GRD_MRK                                                     \n"
		+"        		              , RSK_GRD_CD                                                      \n"
		+"        		              ) VALUES ( B.RNMCNO                                               \n"
		+"                                      ,'K'                                                    \n"
		+"        		                        , TO_CHAR(SYSDATE,'YYYYMMDDhh24MISS')                   \n"
		+"        		                        , 0                                                     \n"
		+"        		                        , 'H'                                                   \n"
		+"        		                        )                                                       \n"					
		;
	    }
}