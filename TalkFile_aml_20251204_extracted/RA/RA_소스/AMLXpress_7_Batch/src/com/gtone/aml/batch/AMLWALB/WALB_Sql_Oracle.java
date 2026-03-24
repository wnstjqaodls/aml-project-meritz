package com.gtone.aml.batch.AMLWALB;

/**
 *
 * <pre>
 * WL Filtering Query (for Oracle)
 * </pre>
 *
 * @author ekwon
 * @version 1.0
 * @history 1.0 2019-06-04
 */
public class WALB_Sql_Oracle extends WALB_Sql {

	public final String DBType = "oracle";

	public String getDBType() {
		return DBType;
	}

	/**
	 * <pre>
	 * WATCH목록검색의뢰_NIC20B delete 쿼리
	 * WL照会依頼_NIC20B delete クエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_DELETE_NIC20B_001() {
		return "DELETE FROM NIC20B    \n" + "WHERE SRCH_RQS_DT = ? \n" + "  AND SRCH_RQS_CCD = ?\n";
	}

	/**
	 * <pre>
	 * WATCH목록검색결과_NIC21B delete 쿼리
	 * WL照会結果_NIC21B delete クエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_DELETE_NIC21B_001() {
		return "DELETE FROM NIC21B    \n" + "WHERE SRCH_RSLT_DT = ?\n" + "  AND SRCH_RQS_CCD = ?\n";
	}

	/**
	 * <pre>
	 * WATCH목록관련검색결과_NIC22B delete 쿼리
	 * WL関連検索結果_NIC22B delete クエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_DELETE_NIC22B_001() {
		return "DELETE FROM NIC22B A                              \n"
				+ "WHERE A.SRCH_RSLT_DT = ?                          \n"
				+ "  AND A.SQ IN (SELECT SQ FROM NIC21B              \n"
				+ "               WHERE SRCH_RSLT_DT = A.SRCH_RSLT_DT\n"
				+ "                 AND SRCH_RQS_CCD = ?             \n"
				+ "               )                                  \n";
	}

	/**
	 * <pre>
	 * WATCH목록관련검색결과결재_NIC21B_APPR delete 쿼리
	 * WL関連検索結果_NIC21B_APPR delete クエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_DELETE_NIC21B_APPR_001() {
		return "DELETE FROM NIC21B_APPR    \n" + "WHERE SRCH_RSLT_DT = ?\n" + "  AND SRCH_RQS_CCD = ?\n";
	}

	/**
	 * <pre>
	 * NIC01B에서 필터링할 고객정보 select 쿼리
	 * NIC01Bからフィルタリングする顧客情報をSelectするクエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_SELECT_NIC01B_001() {
		return "SELECT A.NFR_DIT_CD    NTV_FGNR_CCD \n" + "     , A.RNM_CNFR_CCD  RNM_CCD      \n"
				+ "     , A.AML_CUST_ID                     \n" + "     , A.CS_NM                      \n"
				+ "     , A.RNMCNO                      \n" + "     , B.PSPT_NO                    \n"
				+ "     , A.NTN_CD                     \n" + "     , A.INDV_CORP_CCD              \n"
				+ "FROM NIC01B A                       \n" + "     LEFT OUTER JOIN NIC02B B       \n"
				+ "     ON A.AML_CUST_ID = B.AML_CUST_ID         \n";
	}

	/**
	 * <pre>
	 * 고객ID로 NIC19B에서 Select하는 쿼리
	 * 顧客IDでNIC19BからSelectするクエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_SELECT_NIC19B_001() {
		return "SELECT * FROM NIC19B A	\n" + " WHERE   AML_CUST_ID =? 		\n";
	}

	/**
	 * <pre>
	 *  NIC20B에서 다음 순번을  Select하는 쿼리
	 * NIC20Bから次の順番をSelectするクエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_SELECT_NIC20B_001() {
		return "SELECT NVL(MAX(SQ),0)+1 FROM NIC20B WHERE SRCH_RQS_DT = ? \n";
	}

	public String WLB_SELECT_NIC21B_APPR_001() {
		return "SELECT NIC21B_APPR_SEQ.nextval AS SRCH_RQS_REG_NO, ? FROM DUAL";
	}

	/**
	 * <pre>
	 *  WATCH목록검색의뢰_NIC20B에 NIC01B에서 Select해서 Insert하는 쿼리
	 * NIC01BからSelectしてWL照会依頼_NIC20BにInsertするクエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_INSERT_NIC20B_001() {
		return    "INSERT INTO NIC20B							\n"
				+ " (											\n"
				+ "   SRCH_RQS_DT            \n" //01 SRCH_RQS_DT(검색요청일자)
				+ " , SQ                     \n" //02 SQ(일련번호)
				+ " , SRCH_RQS_CCD           \n" //03 SRCH_RQS_CCD(검색요청구분코드)
				+ " , NTV_FGNR_CCD           \n" //04 NTV_FGNR_CCD(내외국인구분코드_A008)
				+ " , RNM_CCD                \n" //05 RNM_CCD(실명구분코드)
				+ " , RNMCNO                 \n" //06 RNMCNO(고겍엔티티ID)
				+ " , CS_NM                  \n" //07 CS_NM(고객명)
				+ " , CS_NO                  \n" //08 CS_NO(실명번호 암호화)
				+ " , PSPT_NO                \n" //09 PSPT_NO(여권번호)
				+ " , HNDL_DY_TM             \n" //10 HNDL_DY_TM(처리일시)
				+ " , HNDL_P_ENO             \n" //11 HNDL_P_ENO(처리자ID)
				+ " , NTNLT_CD               \n" //12 NTNLT_CD(국적코드_M004)
				+ " , WL_RELATED_PER_CODE    \n" //13 WL_RELATED_PER_CODE
				+ ")											\n"
				+ "SELECT										\n"
				+ "       ?            			 	\n" //01 SRCH_RQS_DT(검색요청일자)
				+ "     , ?	                     	\n" //02 SQ(일련번호)
				+ "     , ?				         	\n" //03 SRCH_RQS_CCD(검색요청구분코드)
				+ "     , ?           	            \n" //04 NTV_FGNR_CCD(내외국인구분코드_A008)
				+ "     , A.RNM_CNFR_CCD            \n" //05 RNM_CCD(실명구분코드)
				+ "     , A.RNMCNO                 	\n" //06 RNMCNO(고겍엔티티ID)
				+ "     , ?                  		\n" //07 CS_NM(고객명)
				+ "     , A.CS_NO                  	\n" //08 CS_NO(실명번호 암호화)
				+ "     , B.PSPT_NO		            \n" //09 PSPT_NO(여권번호)
                + "     , SYSDATE		            \n" //10 HNDL_DY_TM(처리일시)
				+ "     , ?				            \n" //11 HNDL_P_ENO(처리자ID)
				+ "     , ?							\n" //12 NTNLT_CD(국적코드_M004)
				+ "     , ?							\n" //13 WL_RELATED_PER_CODE
				+ "  FROM NIC01B A				\n" // NIC01B 고객통합기본
                + "  LEFT OUTER JOIN NIC02B B	\n" // 
                + "    ON B.RNMCNO = ?			\n" // 
                + " WHERE A.RNMCNO = ?			\n" // 
				;
	}

	/**
     * <pre>
     *  WATCH목록검색결과_NIC21B에 NIC01B에서 Select해서 Insert하는 쿼리
     * NIC01BSelectしてWL照会結果_NIC21BにInsertするクエリ
     * @en
     * </pre>
           CUST_G_C :M012- 고객구분(01.개인,02.개인사업자 ,03.법인,04.비영리법인 )
           RLT_CD: A915-WLF고객구분코드(01.본인,02.대리인,03.대표자,04.실제소유자)
     */

    public String WLB_INSERT_NIC21B_001() {
    	return    "INSERT INTO NIC21B           					\n"
		        + " (												\n"
		        + "   SRCH_RSLT_DT		\r\n"	//01 SRCH_RSLT_DT(검색결과일자)
		        + " , SQ				\r\n"	//02 SQ(일련번호)
		        + " , SRCH_RQS_CCD		\r\n"	//03 SRCH_RQS_CCD(검색요청구분코드)
		        + " , NTV_FGNR_CCD		\r\n"	//04 NTV_FGNR_CCD(내외국인구분코드_A008)
		        + " , RNM_CCD			\r\n"	//05 RNM_CCD(실명구분코드)
		        + " , RNMCNO			\r\n"	//06 RNMCNO(고객엔티티ID)
		        + " , NTN_CD			\r\n"	//07 NTN_CD(국가코드_M004)
		        + " , CS_NM				\r\n"	//08 CS_NM(고객명)		        
		        + " , BSC_ADDR			\r\n"	//09 BSC_ADDR(주소)
		        + " , DNG_FLWG_ADDR		\r\n"	//10 DNG_FLWG_ADDR(주소)
		        + " , CS_NO				\r\n"	//11 CS_NO(고객번호)
		        + " , HNDL_DY_TM		\r\n"	//12 HNDL_DY_TM(처리일시)
		        + " , HNDL_P_ENO		\r\n"	//13 HNDL_P_ENO(처리자ID)
		        + " , ETC1,ETC2,ETC3,ETC4,ETC5	\r\n" //14
		        + " , CUST_G_C	\r\n"				  //15
		        + " , WC_LIST_CCD		\r\n"	      //16 WC_LIST_CCD(WATCH목록구분코드_A003)
		        + " , WL_RELATED_PER_CODE \r\n"       //17 WL_RELATED_PER_CODE
		        + ")                            \r\n"
		        + "SELECT                       \r\n"
				+ "      ?						\r\n"	//01 SRCH_RSLT_DT(검색결과일자)
				+ "    , ?						\r\n"	//02 SQ(일련번호)
				+ "    , ?						\r\n"	//03 SRCH_RQS_CCD(검색요청구분코드)
				+ "    , ?						\r\n"	//04 NTV_FGNR_CCD(내외국인구분코드_A008)
				+ "    , A.RNM_CNFR_CCD		    \r\n"	//05 RNM_CNFR_CCD(실명구분코드)
				+ "    , A.RNMCNO				\r\n"	//06 RNMCNO(고객엔티티ID)
				+ "    , ?						\r\n"	//07 NTN_CD(국가코드_M004)
				+ "    , ?						\r\n"	//08 CS_NM(고객명)
				+ "    , B.BSC_ADDR				\r\n"	//09 ADDR(주소)
				+ "    , B.DNG_FLWG_ADDR		\r\n"	//10 ADDR(주소)
				+ "    , A.CS_NO				\r\n"	//11 CS_NO(실명확인번호 암호화)
				+ "    , SYSDATE				\r\n"	//12 HNDL_DY_TM(처리일시)
				+ "    , ?						\r\n"	//13 HNDL_P_ENO(처리자ID)
				+ "    , ?,?,?,?,?				\r\n"	//14 ETC1,ETC2,ETC3,ETC4,ETC5
				+ "    , ?						\r\n"	//15 CUST_G_C
				+ "    , ?						\r\n"	//16 WC_LIST_CCD
				+ "    , ?						\r\n"	//17 WL_RELATED_PER_CODE
		        + " FROM NIC01B A               \r\n"	// NIC01B	고객통합기본
		        + " LEFT OUTER JOIN NIC05B B    \r\n"	// NIC01B	고객통합기본
		        + "   ON B.RNMCNO = ?           \r\n"	// NIC01B	고객통합기본
		        + "  AND B.ADDR_TYP_CD = '1'    \r\n"	// NIC01B	고객통합기본
		        + "WHERE A.RNMCNO = ?           \r\n"	// NIC01B	고객통합기본
		        ;
    }

	/**
	 * <pre>
	 *  WATCH목록관련검색결과_NIC22B에 Insert하는 쿼리
	 * WL関連照会結果_NIC22BにInsertするクエリ
	 * &#64;en
	 * </pre>
	 */
//	public String WLB_INSERT_NIC22B_001() {
//		return "INSERT INTO NIC22B( \n" + "   SRCH_RSLT_DT     \n" + " , SQ               \n" + " , MNG_SNO          \n" +" , RLT_SRCH_SQ          \n"
//				+ " , WC_LIST_CCD      \n" + " , CS_NM            \n" + " , HIT_R            \n"
//				+ " , HNDL_DY_TM       \n" + " , HNDL_P_ENO       \n" + " , INDV_CORP_CCD    \n"
//				+ " , AML_CUST_ID           \n" + " , NTNLT_CD         \n" + " , ADDR             \n"
//				+ " , WL_BIRTHDAY      \n" + ") VALUES (          \n" + "   ?                \n"
//				+ " , ?                \n" + " , ?                \n" + " , ?                \n"
//				+ " , ?                \n" + " , ?                \n" + " , SYSDATE          \n"
//				+ " , ?                \n" + " , ?                \n" + " , ?                \n"
//				+ " , ?                \n" + " , ?                \n" + " , ?                \n"
//				+ ")                   \n";
//	}
	public String WLB_INSERT_NIC22B_001() {
    	return    "INSERT INTO NIC22B           					\n"
		        + " (												\n"
		        + "   SRCH_RSLT_DT	\n"	//01 SRCH_RSLT_DT(검색결과일자)
		        + " , SQ			\n"	//02 SQ(일련번호)
		        + " , MNG_SNO		\n"	//03 MNG_SNO(관리번호)
		        //+ " , RLT_SRCH_SQ	\n"	//04 RLT_SRCH_SQ(순번)
		        + " , WC_LIST_CCD	\n"	//05 WC_LIST_CCD(WATCH목록구분코드_A003)
		        + " , CS_NM			\n"	//06 CS_NM(고객명)
//		        + " , CHC_YN		\n"	//07 CHC_YN(선택여부)
		        + " , HIT_R			\n"	//08 HIT_R(적중율)
		        + " , HNDL_DY_TM	\n"	//14 HNDL_DY_TM(처리일시)
		        + " , HNDL_P_ENO	\n"	//15 HNDL_P_ENO(처리자ID)
		        + " , INDV_CORP_CCD	\n"	//09 INDV_CORP_CCD(개인법인구분코드_M006)
		        + " , RNMCNO		\n"	//10 RNMCNO(고겍엔티티ID)
		        + " , NTNLT_CD		\n"	//11 NTNLT_CD(국적코드_M004)
		        + " , ADDR			\n"	//12 ADDR(주소)
		        + " , WL_BIRTHDAY	\n"	//13 WL_BIRTHDAY(WL생년월일)
		        
//		        + " , CHC_YN_TM		\n"	//16 CHC_YN_TM(선택여부 처리일시)
		        + " , SEX			\n"	//17 WC_UID(팩티바iD -WLF_DB_ID)
		        //+ " , WC_UID		\n"	//18 SEX(WL성별)
		        //+ " , WL_NM_FIRST	\n"	//19 WL_NM_FIRST(WL영문첫번쨰명)
		        //+ " , WL_NM_MIDDLE	\n"	//20 WL_NM_MIDDLE(WL영문중간명)
		        //+ " , WL_NM_LAST	\n"	//21 WL_NM_LAST(WL영문성)
		        + ")                            					\n"
		        + "VALUES (                             					\n"
		        + "   ?				\n"	//01 SRCH_RSLT_DT(검색결과일자)
		        + " , ?				\n"	//02 SQ(일련번호)
		        + " , ?				\n"	//03 MNG_SNO(관리번호)
		        //+ " , ?				\n"	//04 RLT_SRCH_SQ(순번)
		        + " , ?				\n"	//05 WC_LIST_CCD(WATCH목록구분코드_A003)
		        + " , ?				\n"	//06 CS_NM(고객명)
//		        + " , CHC_YN		\n"	//07 CHC_YN(선택여부)
		        + " , ?				\n"	//08 HIT_R(적중율)
		        + " , SYSDATE		\n"	//14 HNDL_DY_TM(처리일시)
		        + " , ?				\n"	//15 HNDL_P_ENO(처리자ID)
		        + " , ?				\n"	//09 INDV_CORP_CCD(개인법인구분코드_M006)
		        + " , ?				\n"	//10 RNMCNO(고겍엔티티ID)
		        + " , ?				\n"	//11 NTNLT_CD(국적코드_M004)
		        + " , CASE WHEN LENGTHB(?) > 100				            \n"	//12 ADDR(주소)
		        + "        THEN CASE WHEN INSTR(?, SUBSTRB(?, 1, 100)) > 0	\n"	//12 ADDR(주소)
		        + "        THEN SUBSTRB(?, 1, 100)				            \n"	//12 ADDR(주소)
		        + "        ELSE SUBSTRB(?, 1, 99)				            \n"	//12 ADDR(주소)
		        + "        END ELSE ? END				                    \n"	//12 ADDR(주소)
		        
		        + " , ?				\n"	//13 WL_BIRTHDAY(WL생년월일)
		        + " , ?				\n"	//17 SEX(WL성별)


		        + ")												\n"
		        ;
	}

	public String WLB_INSERT_NIC21B_APPR_001 () {
		return
				   "INSERT INTO NIC21B_APPR                                                              \n"
				 + "	(                                                                                \n"
				 + "		SRCH_RQS_REG_NO,                                                             \n"
				 + "		SRCH_RSLT_DT,                                                                \n"
				 + "		SRCH_RQS_CCD,                                                                \n"
//				 + "		APP_NO,                                                                      \n"
				 + "		RNM_CCD,                                                                     \n"
				 + "		AML_CUST_ID,                                                                      \n"
				 + "		RNMCNO,                                                                       \n"
				 + "		INDV_CORP_CCD,                                                               \n"
				 + "		NTV_FGNR_CCD,                                                                \n"
				 + "		CS_NM,                                                                       \n"
				 + "		ENG_CS_NM,                                                                   \n"
				 + "		NTN_CD,                                                                      \n"
				 + "		NTN_NM,                                                                      \n"
				 + "		DOB,                                                                         \n"
				 + "		WC_LIST_GRP_CD,                                                              \n"
//				 + "		DCSN_F,                                                                      \n"
//				 + "		PSBL_F,                                                                      \n"
//				 + "		RSLT_BRN_CD,                                                                 \n"
//				 + "		WLF_DCD,                                                                     \n"
//				 + "		RSN_CNTNT,                                                                   \n"
				 + "		WL_OPEN_DATA_YN,                                                              \n"
				 + "		HNDL_DY_TM,                                                                  \n"
				 + "		HNDL_P_ENO                                                                   \n"
				 + "	)                            	                                                 \n"
				 + "SELECT                        	                                                     \n"
				 + "	  	? AS SRCH_RQS_REG_NO,                                                        \n"
				 + "		? AS SRCH_RSLT_DT,                                                           \n"
				 + "		? AS SRCH_RQS_CCD,                                                           \n"
//				 + "		'' AS APP_NO,                                                                \n"
				 + "		A.RNM_CNFR_CCD AS RNM_CCD,                                                   \n"
				 + "		A.AML_CUST_ID,                                                                    \n"
				 + "		A.RNMCNO,                                                                     \n"
				 + "		? AS INDV_CORP_CCD,                                                          \n"
				 + "		A.NTV_FGNR_CCD,                                                              \n"
				 + "		? AS CS_NM,                                                                  \n"
				 + "		? AS ENG_CS_NM,                                                              \n"
				 + "		? AS NTN_CD,                                                                 \n"
				 + "		? AS NTN_NM,		                                                         \n"
				 + "		? AS DOB,																	 \n"
				 + "		? AS WC_LIST_GRP_CD,                                                         \n"
//				 + "		'' AS DCSN_F,                                                                \n"
//				 + "		'' AS PSBL_F,                                                                \n"
//				 + "		'' AS RSLT_BRN_CD,                                                           \n"
//				 + "		'' AS WLF_DCD,                                                               \n"
//				 + "		'' AS RSN_CNTNT,	                                                         \n"
				 + "		?  AS WL_OPEN_DATA_YN,														 \n"
				 + "		SYSDATE,                                                                     \n"
				 + "		? AS HNDL_P_ENO                                                              \n"
				 + "  FROM NIC01B A                                                                      \n"
				 + "	   LEFT OUTER JOIN NIC02B B                                                      \n"
				 + "	   ON (A.AML_CUST_ID = B.AML_CUST_ID)                                                      \n"
				 + "	   LEFT OUTER JOIN NIC03B C                                                      \n"
				 + "	   ON (A.AML_CUST_ID = C.AML_CUST_ID)                                                      \n"
				 + "  	   LEFT OUTER JOIN                                                               \n"
				 + "	   (SELECT CNTNT, CD_NM                                                          \n"
				 + "          FROM NIC92B                                                                \n"
				 + "         WHERE CD = 'M004' ) D                                                       \n"
				 + "       ON ( A.NTN_CD = D.CNTNT)                                                      \n"
				 + " WHERE 1 = 1                                                                         \n"
				 + "   AND A.AML_CUST_ID = ?                                                                  \n"
				;
	}

	/**
	 * <pre>
	 *  NIC35B에 대표 WL구분 코드(WC_LIST_CCD)를 update하는 쿼리
	 * NIC35Bに代表WL区分コード(WC_LIST_CCD)をupdateするクエリ
	 * &#64;en
	 * </pre>
	 */
	public String WLB_UPDATE_NIC35B_001() {
		return "UPDATE NIC35B                                         \n"
				+ "SET WC_LIST_CCD = ?                                   \n"
				+ "  , WC_LIST_CD_RNWL_DT = TO_CHAR(SYSDATE, 'YYYYMMDD') \n"
				+ "  , HNDL_DY_TM = SYSDATE                              \n"
				+ "  , HNDL_P_ENO = ?                                    \n"
				+ "WHERE AML_CUST_ID = ?                                      \n";
	}

	/**
	 * <pre>
	 *  NIC92B_STD_VAL의 WATCHLIST 최소 정확도 (STD_VAL)을 가져오는 쿼리
	 * </pre>
	 */
	public String WLB_SELECT_NIC92B_STD_VAL_001() {
		return "SELECT STD_VAL FROM NIC92B_STD_VAL WHERE STD_ID = ?";
	}
	
	 public String WLB_FICTIVA_BATCH_EXCUTE_YN() {
		return " SELECT NVL(MAX(EXCUTE_BATCH_YN), 'N') AS EXCUTE_BATCH_YN                                                                                                            \n"
		+ "     FROM (                                                                                                                                                          \n"
		+ "    SELECT CASE WHEN NIC93.JOB_ST_CD = '1'                                                                                                                           \n"
		+ "             THEN CASE WHEN NVL(TO_CHAR(NIC93.END_DY_TM, 'YYYYMMDDhh24miss'), '00001231000000')                                                                      \n"
		+ "                             < (select NVL(TO_CHAR(END_DY_TM, 'YYYYMMDDhh24miss'), '00001231000000') From ssq.nic93b where job_id = 'B50001' AND USE_YN = 'Y')       \n"
		+ "                            THEN 'Y'                                                                                                                                 \n"
		+ "                       WHEN NVL(TO_CHAR(NIC93.END_DY_TM, 'YYYYMMDD'), '00001231')                                                                      				\n"
		+ "                             = '00001231'                                                                                                                            \n"
		+ "                            THEN 'Y'                                                                                                                                 \n"
		+ "                       ELSE 'N'                                                                                                                                      \n"
		+ "                   END                                                                                                                                               \n"
		+ "         	ELSE 'Y'                                                                                                                                                \n"
		+ "     	 END             AS EXCUTE_BATCH_YN                                                                                                                         \n"
		+ " 	FROM ssq.NIC93B NIC93                                                                                                                                           \n"
		+ "    WHERE 1 = 1                                                                                                                                                      \n"
		+ " 	 AND NIC93.JOB_ID = ?                                                                                                                                   		\n"
		+ " 	 AND NIC93.USE_YN = 'Y' )                                                                                                                                       \n"
		;
	 }
}