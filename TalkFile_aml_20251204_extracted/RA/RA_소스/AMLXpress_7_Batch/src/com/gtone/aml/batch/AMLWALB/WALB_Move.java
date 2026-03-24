package com.gtone.aml.batch.AMLWALB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.gtone.aml.batch.common.Config;
import com.gtone.aml.batch.common.util.DBUtil;
import com.gtone.aml.batch.common.util.Timer;

/**
 *
*<pre>
* WL 실행 후 결과를 DB에 insert하는 class
* WL実行後結果をDBにインサートするクラス
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public class WALB_Move extends WALB_MoveAbstract {
    private long m_nCounter = 0;
    private long m_TotalCount = 0;

    private ArrayList<PreparedStatement> m_pstmtList = null;
    private ArrayList<PreparedStatement> m_pstmtBatchList = null;

    protected PreparedStatement pstmt_WLB_SELECT_NIC20B_001 = null;
    protected PreparedStatement pstmt_WLB_INSERT_NIC20B_001 = null;
    protected PreparedStatement pstmt_WLB_INSERT_NIC21B_001 = null;
    protected PreparedStatement pstmt_WLB_INSERT_NIC22B_001 = null;
    protected PreparedStatement pstmt_WLB_UPDATE_NIC35B_001 = null;

    private WALB_Sql WALB_Sql = null;
    @SuppressWarnings("static-access")
	public WALB_Move() { WALB_Sql = WALB_Sql.getInstance(); }

    /**
     * <pre>
     * NIC22B에 insert하는 쿼리를 반환한다.
     * NIC22Bにインサートするクエリを返す。
     * @en
     *</pre>
     *@return
     */
    public String getINSERTNIC22BQuery()
    { return WALB_Sql.WLB_INSERT_NIC22B_001(); }

    /**
     * <pre>
     * NIC20B를 select하는 쿼리를 반환한다.
     * NIC20BをSelectするクエリを返す。
     * @en
     *</pre>
     *@return
     */
    public String getSELECT_NIC20BQuery()
    { return WALB_Sql.WLB_SELECT_NIC20B_001(); }

    /**
     * <pre>
     * NIC20B에 insert하는 쿼리를 반환한다.
     * NIC20Bにインサートするクエリを返す。
     * @en
     *</pre>
     *@return
     */
    public String getINSERTNIC20BQuery()
    { return WALB_Sql.WLB_INSERT_NIC20B_001(); }

    /**
     * <pre>
     * NIC21B에 insert하는 쿼리를 반환한다.
     * NIC21Bにインサートするクエリを返す。
     * @en
     *</pre>
     *@return
     */
    public String getINSERTNIC21BQuery()
    { return WALB_Sql.WLB_INSERT_NIC21B_001(); }

    /**
     * <pre>
    * NIC35B update하는 쿼리를 반환한다.
    * NIC35BをUpedateするクエリを返す。
    * @en
    *</pre>
     *@return
     */
    public String getNIC35BUpdateQuery()
    { return WALB_Sql.WLB_UPDATE_NIC35B_001(); }
    
    public String getFicTivaBatchExcuteYnQuery()
    {
        return WALB_Sql.WLB_FICTIVA_BATCH_EXCUTE_YN();
    }
    
    /**
     * <pre>
     * Statement를 초기화한다.
     * Statementを初期化する。
     * @en
     *</pre>
     *@param connection
     *@throws SQLException
     */
    public void initialize(Connection connection) throws SQLException {
        conn = connection;
        m_pstmtList = new ArrayList<PreparedStatement>();
        m_pstmtBatchList = new ArrayList<PreparedStatement>();

        pstmt_WLB_SELECT_NIC20B_001 = conn.prepareStatement(getSELECT_NIC20BQuery());
        pstmt_WLB_INSERT_NIC20B_001 = conn.prepareStatement(getINSERTNIC20BQuery());
        pstmt_WLB_INSERT_NIC21B_001 = conn.prepareStatement(getINSERTNIC21BQuery());
        pstmt_WLB_INSERT_NIC22B_001 = conn.prepareStatement(getINSERTNIC22BQuery());
        pstmt_WLB_UPDATE_NIC35B_001 = conn.prepareStatement(getNIC35BUpdateQuery());

        m_pstmtList.add(pstmt_WLB_SELECT_NIC20B_001);
        m_pstmtList.add(pstmt_WLB_INSERT_NIC20B_001);
        m_pstmtList.add(pstmt_WLB_INSERT_NIC21B_001);
        m_pstmtList.add(pstmt_WLB_INSERT_NIC22B_001);
        m_pstmtList.add(pstmt_WLB_UPDATE_NIC35B_001);

        m_pstmtBatchList.add(pstmt_WLB_INSERT_NIC20B_001);	//NIC20B를 적재방법 변경 executeUpadte -> addBatch 20191219
        m_pstmtBatchList.add(pstmt_WLB_INSERT_NIC21B_001);
        m_pstmtBatchList.add(pstmt_WLB_INSERT_NIC22B_001);
        m_pstmtBatchList.add(pstmt_WLB_UPDATE_NIC35B_001);
        initStartTime();
    }

    /**
     * <pre>
     * Statement를 close한다.
     * Statementをクローズする。
     * @en
     *</pre>
     *@throws SQLException
     */
    public void close() throws SQLException {
        execBatch();

        for (int i = 0; i < m_pstmtList.size(); i++)
            DBUtil.close(m_pstmtList.get(i));
    }

    
    /**
     * <pre>
     * 배치를 실행할 고객의 실제소유자 필터링하기 위한 실제소유자 정보를 select하는 쿼리
     * バッチを実行する顧客とフィルタリングするための顧客情報をSelectするクエリ
     * @en
     *</pre>
     *@return
     *@throws Exception
     */
    public String getOwnerQuery(String sRnmCno) throws SQLException {

        final String allQuery
            = " SELECT TRIM(Owner.CDD_TAGT_ENTY_ID) AS RNMCNO                               \r\n"
            + "      , TRIM(Owner.REL_OWNR_NAME) AS CS_NM                                   \r\n"
            + "      , CASE WHEN TRIM(Country.CNTY_CODE) = 'KR' THEN 'A'                    \r\n"
            + "             ELSE 'B' END AS NTV_FGNR_CCD                                    \r\n"
            + "      , TRIM(Country.CNTY_CODE) AS NTN_CD                                    \r\n"
            + "      , TRIM(Owner.REL_OWNR_BRDT) AS DOB                                     \r\n"
            + "      , '3'                     AS WL_RELATED_PER_CODE                       \r\n"
            + "   FROM SID.IDO_A_MAH_CDD_REL_OWNR_IFMN  Owner                               \r\n"
            + "      , SID.IDO_A_UUE_COUNTRY            Country                             \r\n"
            + "  WHERE 1 = 1                                                                \r\n"
            + "    AND Owner.CDD_TAGT_ENTY_ID = '" + sRnmCno + "'                           \r\n"
            + "    AND TRIM(Owner.REL_OWNR_NAME) IS NOT NULL                                \r\n"
            + "    AND Owner.REL_OWNR_NTNY_ID =  Country.CNTY_ID                            \r\n"
            //+ "    AND TRIM(Country.CNTY_CODE) <> 'KR'                                      \r\n"
            + "  ORDER BY Owner.REL_OWNR_SQNO                                               \r\n";
        
        return allQuery;
    }
    
    /**
     * <pre>
     * 배치를 실행할 고객의 대표자필터링하기 위한 대표자 정보를 select하는 쿼리
     * バッチを実行する顧客とフィルタリングするための顧客情報をSelectするクエリ
     * @en
     *</pre>
     *@return
     *@throws Exception
     */
    public String getDelegateQuery(String sRnmCno) throws SQLException {

        final String allQuery
            = " SELECT TRIM(NIC03.RNMCNO) AS RNMCNO                                         \r\n"
            + "      , TRIM(NIC03.RPRST_P_NM1) AS CS_NM                                     \r\n"
            + "      , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT1) = 'KR' THEN 'A'                 \r\n"
            + "             ELSE 'B'                               END AS NTV_FGNR_CCD      \r\n"
            + "      , TRIM(NIC03.RPRST_P_NTNLT1) AS NTN_CD                                 \r\n"
            + "      , TRIM(NIC03.RPRST_P_BRDY1)  AS DOB                                    \r\n"
            + "      , '2'                     AS WL_RELATED_PER_CODE                       \r\n"
            + "   FROM NIC03B  NIC03                                                        \r\n"
            + "  WHERE 1 = 1                                                                \r\n"
            + "    AND NIC03.RNMCNO = '" + sRnmCno + "'                                     \r\n"
          	+ "    AND TRIM(NIC03.RPRST_P_NM1) IS NOT NULL                                  \r\n"
          	//+ "    AND TRIM(NIC03.RPRST_P_NTNLT1) <> 'KR'                                   \r\n"
            + " UNION ALL                                                                   \r\n"
            + " SELECT TRIM(NIC03.RNMCNO) AS RNMCNO                                         \r\n"
            + "      , TRIM(NIC03.RPRST_P_NM2) AS CS_NM                                     \r\n"
            + "      , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT2) = 'KR' THEN 'A'                 \r\n"
            + "             ELSE 'B'                               END AS NTV_FGNR_CCD      \r\n"
            + "      , TRIM(NIC03.RPRST_P_NTNLT2) AS NTN_CD                                 \r\n"
            + "      , TRIM(NIC03.RPRST_P_BRDY2) AS DOB                                     \r\n"
            + "      , '2'                     AS WL_RELATED_PER_CODE                       \r\n"
            + "   FROM NIC03B  NIC03                                                        \r\n"
            + "  WHERE 1 = 1                                                                \r\n"
            + "    AND NIC03.RNMCNO = '" + sRnmCno + "'                                     \r\n"
           	+ "    AND TRIM(NIC03.RPRST_P_NM2) IS NOT NULL                                  \r\n"      
           	//+ "    AND TRIM(NIC03.RPRST_P_NTNLT2) <> 'KR'                                   \r\n"
            + " UNION ALL                                                                   \r\n"
            + " SELECT TRIM(NIC03.RNMCNO) AS RNMCNO                                         \r\n"
            + "      , TRIM(NIC03.RPRST_P_NM3) AS CS_NM                                     \r\n"
            + "      , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT3) = 'KR' THEN 'A'                 \r\n"
            + "             ELSE 'B'                               END AS NTV_FGNR_CCD      \r\n"
            + "      , TRIM(NIC03.RPRST_P_NTNLT3) AS NTN_CD                                 \r\n"
            + "      , TRIM(NIC03.RPRST_P_BRDY3) AS DOB                                     \r\n"
            + "      , '2'                     AS WL_RELATED_PER_CODE                       \r\n"
            + "   FROM NIC03B  NIC03                                                        \r\n"
            + "  WHERE 1 = 1                                                                \r\n"
            + "    AND NIC03.RNMCNO = '" + sRnmCno + "'                                     \r\n"
            + "    AND TRIM(NIC03.RPRST_P_NM3) IS NOT NULL                                  \r\n";
            //+ "    AND TRIM(NIC03.RPRST_P_NTNLT3) <> 'KR'                                   \r\n";
        
        return allQuery;
    }
    
    /**
     * <pre>
     * 배치를 실행할 고객과 필터링하기 위한 고객 정보를 select하는 쿼리
     * バッチを実行する顧客とフィルタリングするための顧客情報をSelectするクエリ
     * @en
     *</pre>
     *@return
     *@throws SQLException
     */
    /* 2023.07.17 : 고객 중 국가가 고위험국가에 해당하는 건은 WLF 필터링 추가(NIC20B, NIC21B, NIC22B)
     * W060 고위험국가 (FATF이행취약국가, FATF비협조국가) 필터링 추가
     * */
    public String getMainQuery() throws SQLException {
        String rtnString;
        
        final String allQuery
        = "  SELECT WL_RELATED_PER_CODE									                                                 \r\n"
		+ "       , RNMCNO									                                                             \r\n"
		+ "       , CS_NM													                                             \r\n"
		+ "       , NTV_FGNR_CCD											                                             \r\n"
		+ "       , NTN_CD													                                             \r\n"
		+ "       , DOB														                                             \r\n"
		+ "       , INDV_CORP_CCD											                                             \r\n"
		+ "    FROM (                                                                                                    \r\n"
		+ "          SELECT WL_RELATED_PER_CODE									                                         \r\n"
		+ "               , RNMCNO									                                                     \r\n"
		+ "               , CS_NM													                                     \r\n"
		+ "               , NTV_FGNR_CCD											                                     \r\n"
		+ "               , NTN_CD													                                     \r\n"
		+ "               , DOB														                                     \r\n"
		+ "               , INDV_CORP_CCD											                                     \r\n"
		+ "            FROM (														                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.CS_NM                 AS CS_NM			                                     \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY      			AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD                                         \r\n"
		+ "                       , '1' AS WL_RELATED_PER_CODE                                                           \r\n"
		+ "                    FROM NIC01B NIC01, NIC19B_FACTIVA FACTIVA			                                     \r\n"
		+ "                   WHERE TRIM(NIC01.CS_NM) = FACTIVA.CS_NM				                                     \r\n"
		+ "                     AND NIC01.NTN_CD = FACTIVA.NTN_CD					                                     \r\n"
		+ "                     AND NIC01.INDV_CORP_CCD = '1'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.BRTDY) IS NOT NULL					                                     \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL					                                     \r\n"
        + "                     AND FACTIVA.REG_DT = '"+getInputParam().getTradeDate()+"'                                \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.CS_NM                 AS CS_NM			                                     \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD  	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY			        AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD                                         \r\n"
		+ "                       , '1' AS WL_RELATED_PER_CODE                                                           \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL					                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.ENG_CS_NM             AS CS_NM			                                     \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY			        AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD                                         \r\n"
		+ "                       , '1' AS WL_RELATED_PER_CODE                                                           \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '1'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL				                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.ENG_CS_NM             AS CS_NM			                                     \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY       			AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD                                         \r\n"
		+ "                       , '1' AS WL_RELATED_PER_CODE                                                           \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL				                                     \r\n"
		+ "                  )                                                                                           \r\n"
		+ "          UNION ALL                                                                                           \r\n"
		+ "          SELECT B.WL_RELATED_PER_CODE                                                                        \r\n"
		+ "               , B.RNMCNO                                                                                     \r\n"
		+ "               , B.CS_NM                                                                                      \r\n"
		+ "               , B.NTV_FGNR_CCD                                                                               \r\n"
		+ "               , B.NTN_CD                                                                                     \r\n"
		+ "               , B.DOB                                                                                        \r\n"
		+ "               , '' AS INDV_CORP_CCD                                                                          \r\n"
		+ "            FROM (														                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.CS_NM                AS CS_NM			                                         \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY      			AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD	                                     \r\n"
		+ "                    FROM NIC01B NIC01, NIC19B_FACTIVA FACTIVA			                                     \r\n"
		+ "                   WHERE TRIM(NIC01.CS_NM) = FACTIVA.CS_NM				                                     \r\n"
		+ "                     AND NIC01.NTN_CD = FACTIVA.NTN_CD					                                     \r\n"
		+ "                     AND NIC01.INDV_CORP_CCD = '1'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.BRTDY) IS NOT NULL					                                     \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL					                                     \r\n"
        + "                     AND FACTIVA.REG_DT = '"+getInputParam().getTradeDate()+"'                                \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.CS_NM                AS CS_NM			                                         \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD		                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY			    AS DOB				                                         \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD	                                     \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL					                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.ENG_CS_NM            AS CS_NM			                                         \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY			    AS DOB			 	                                         \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD	                                     \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '1'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL				                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.ENG_CS_NM            AS CS_NM			                                         \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY       			AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD	                                     \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL				                                     \r\n"
		+ "                  )A                                                                                          \r\n"
		+ "               , (                                                                                            \r\n"
		+ "                  SELECT TRIM(NIC03.RNMCNO)         AS RNMCNO                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NM1)    AS CS_NM                                                  \r\n"
		+ "                       , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT1) = 'KR' THEN 'A'                                 \r\n"
		+ "                         ELSE 'B' END               AS NTV_FGNR_CCD                                           \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NTNLT1) AS NTN_CD                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_BRDY1)  AS DOB                                                    \r\n"
		+ "                       , '2'                        AS WL_RELATED_PER_CODE                                    \r\n"
		+ "                    FROM NIC03B NIC03                                                                         \r\n"
		+ "                   WHERE TRIM(NIC03.RPRST_P_NM1) IS NOT NULL                                                  \r\n"
		+ "                   UNION ALL                                                                                  \r\n"
		+ "                  SELECT TRIM(NIC03.RNMCNO)         AS RNMCNO                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NM2)    AS CS_NM                                                  \r\n"
		+ "                       , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT2) = 'KR' THEN 'A'                                 \r\n"
		+ "                         ELSE 'B' END               AS NTV_FGNR_CCD                                           \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NTNLT2) AS NTN_CD                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_BRDY2)  AS DOB                                                    \r\n"
		+ "                       , '2'                        AS WL_RELATED_PER_CODE                                    \r\n"
		+ "                    FROM NIC03B NIC03                                                                         \r\n"
		+ "                   WHERE TRIM(NIC03.RPRST_P_NM2) IS NOT NULL                                                  \r\n"
		+ "                   UNION ALL                                                                                  \r\n"
		+ "                  SELECT TRIM(NIC03.RNMCNO)         AS RNMCNO                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NM3)    AS CS_NM                                                  \r\n"
		+ "                       , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT3) = 'KR' THEN 'A'                                 \r\n"
		+ "                         ELSE 'B' END               AS NTV_FGNR_CCD                                           \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NTNLT3) AS NTN_CD                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_BRDY3)  AS DOB                                                    \r\n"
		+ "                       , '2'                        AS WL_RELATED_PER_CODE                                    \r\n"
		+ "                    FROM NIC03B  NIC03                                                                        \r\n"
		+ "                   WHERE TRIM(NIC03.RPRST_P_NM3) IS NOT NULL                                                  \r\n"
		+ "                  )B                                                                                          \r\n"
		+ "           WHERE B.RNMCNO = A.RNMCNO                                                                          \r\n"
		+ "          UNION ALL                                                                                           \r\n"
		+ "          SELECT B.WL_RELATED_PER_CODE                                                                        \r\n"
		+ "               , B.RNMCNO                                                                                     \r\n"
		+ "               , B.CS_NM                                                                                      \r\n"
		+ "               , B.NTV_FGNR_CCD                                                                               \r\n"
		+ "               , B.NTN_CD                                                                                     \r\n"
		+ "               , B.DOB                                                                                        \r\n"
		+ "               , '' AS INDV_CORP_CCD                                                                          \r\n"
		+ "            FROM (															                                 \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO				                                 \r\n"
		+ "                       , NIC01.CS_NM                  AS CS_NM				                                 \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)		AS NTV_FGNR_CCD		                                 \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD				                                 \r\n"
		+ "                       , NIC01.BRTDY      			AS DOB					                                 \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD		                                 \r\n"
		+ "                    FROM NIC01B NIC01, NIC19B_FACTIVA FACTIVA				                                 \r\n"
		+ "                   WHERE TRIM(NIC01.CS_NM) = FACTIVA.CS_NM					                                 \r\n"
		+ "                     AND NIC01.NTN_CD = FACTIVA.NTN_CD						                                 \r\n"
		+ "                     AND NIC01.INDV_CORP_CCD = '1'							                                 \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'							                                 \r\n"
		+ "                     AND TRIM(NIC01.BRTDY) IS NOT NULL						                                 \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL						                                 \r\n"
        + "                     AND FACTIVA.REG_DT = '"+getInputParam().getTradeDate()+"'                                \r\n"
		+ "                   UNION ALL													                                 \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO				                                 \r\n"
		+ "                       , NIC01.CS_NM                  AS CS_NM				                                 \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)		AS NTV_FGNR_CCD		                                 \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD				                                 \r\n"
		+ "                       , NIC01.BRTDY			        AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD		                                 \r\n"
		+ "                    FROM NIC01B NIC01										                                 \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'							                                 \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'							                                 \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL						                                 \r\n"
		+ "                   UNION ALL													                                 \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO				                                 \r\n"
		+ "                       , NIC01.ENG_CS_NM              AS CS_NM				                                 \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)		AS NTV_FGNR_CCD		                                 \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD				                                 \r\n"
		+ "                       , NIC01.BRTDY			        AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD		                                 \r\n"
		+ "                    FROM NIC01B NIC01										                                 \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '1'							                                 \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'							                                 \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL					                                 \r\n"
		+ "                   UNION ALL													                                 \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO				                                 \r\n"
		+ "                       , NIC01.ENG_CS_NM              AS CS_NM				                                 \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)		AS NTV_FGNR_CCD		                                 \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD				                                 \r\n"
		+ "                       , NIC01.BRTDY       			AS DOB					                                 \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD		                                 \r\n"
		+ "                    FROM NIC01B NIC01										                                 \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'							                                 \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'							                                 \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL					                                 \r\n"
		+ "                  )A                                                                                          \r\n"
		+ "               , (                                                                                            \r\n"
		+ "                  SELECT TRIM(Owner.CDD_TAGT_ENTY_ID) AS RNMCNO                                               \r\n"
		+ "                       , TRIM(Owner.REL_OWNR_NAME)    AS CS_NM                                                \r\n"
		+ "                       , CASE WHEN TRIM(Country.CNTY_CODE) = 'KR' THEN 'A'                                    \r\n"
		+ "                              ELSE 'B' END            AS NTV_FGNR_CCD                                         \r\n"
		+ "                       , TRIM(Country.CNTY_CODE)      AS NTN_CD                                               \r\n"
		+ "                       , TRIM(Owner.REL_OWNR_BRDT)    AS DOB                                                  \r\n"
		+ "                       , '3'                          AS WL_RELATED_PER_CODE                                  \r\n"
		+ "                    FROM SID.IDO_A_MAH_CDD_REL_OWNR_IFMN Owner                                                \r\n"
		+ "                       , SID.IDO_A_UUE_COUNTRY           Country                                              \r\n"
		+ "                   WHERE 1 = 1                                                                                \r\n"
		+ "                     AND TRIM(Owner.REL_OWNR_NAME) IS NOT NULL                                                \r\n"
		+ "                     AND Owner.REL_OWNR_NTNY_ID = Country.CNTY_ID                                             \r\n"
		+ "                   ORDER BY Owner.REL_OWNR_SQNO                                                               \r\n"
		+ "                  )B                                                                                          \r\n"
		+ "           WHERE B.RNMCNO = A.RNMCNO                                                                          \r\n"
		+ "          ) A                                                                                                 \r\n"
		+ "   WHERE NOT EXISTS (SELECT 1 FROM SID.IDO_A_MAH_WLF_ETRA_PRS_DTLD WLF WHERE A.RNMCNO = WLF.CDD_TAGT_ENTY_ID) \r\n"
			;                       
        
        rtnString = allQuery;
        return rtnString;
    }

    public String getMainAllQuery() throws SQLException {
        String rtnString;
        
        final String allQuery
        = "  SELECT WL_RELATED_PER_CODE									                                                 \r\n"
		+ "       , RNMCNO									                                                             \r\n"
		+ "       , CS_NM													                                             \r\n"
		+ "       , NTV_FGNR_CCD											                                             \r\n"
		+ "       , NTN_CD													                                             \r\n"
		+ "       , DOB														                                             \r\n"
		+ "       , INDV_CORP_CCD											                                             \r\n"
		+ "    FROM (                                                                                                    \r\n"
		+ "          SELECT WL_RELATED_PER_CODE									                                         \r\n"
		+ "               , RNMCNO									                                                     \r\n"
		+ "               , CS_NM													                                     \r\n"
		+ "               , NTV_FGNR_CCD											                                     \r\n"
		+ "               , NTN_CD													                                     \r\n"
		+ "               , DOB														                                     \r\n"
		+ "               , INDV_CORP_CCD											                                     \r\n"
		+ "            FROM (														                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.CS_NM                 AS CS_NM			                                     \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY      			AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD                                         \r\n"
		+ "                       , '1' AS WL_RELATED_PER_CODE                                                           \r\n"
		+ "                    FROM NIC01B NIC01, NIC19B_FACTIVA FACTIVA			                                     \r\n"
		+ "                   WHERE TRIM(NIC01.CS_NM) = FACTIVA.CS_NM				                                     \r\n"
		+ "                     AND NIC01.NTN_CD = FACTIVA.NTN_CD					                                     \r\n"
		+ "                     AND NIC01.INDV_CORP_CCD = '1'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.BRTDY) IS NOT NULL					                                     \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL					                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.CS_NM                 AS CS_NM			                                     \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD  	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY			        AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD                                         \r\n"
		+ "                       , '1' AS WL_RELATED_PER_CODE                                                           \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL					                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.ENG_CS_NM             AS CS_NM			                                     \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY			        AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD                                         \r\n"
		+ "                       , '1' AS WL_RELATED_PER_CODE                                                           \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '1'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL				                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.ENG_CS_NM             AS CS_NM			                                     \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY       			AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD                                         \r\n"
		+ "                       , '1' AS WL_RELATED_PER_CODE                                                           \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL				                                     \r\n"
		+ "                  )                                                                                           \r\n"
		+ "          UNION ALL                                                                                           \r\n"
		+ "          SELECT B.WL_RELATED_PER_CODE                                                                        \r\n"
		+ "               , B.RNMCNO                                                                                     \r\n"
		+ "               , B.CS_NM                                                                                      \r\n"
		+ "               , B.NTV_FGNR_CCD                                                                               \r\n"
		+ "               , B.NTN_CD                                                                                     \r\n"
		+ "               , B.DOB                                                                                        \r\n"
		+ "               , '' AS INDV_CORP_CCD                                                                          \r\n"
		+ "            FROM (														                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.CS_NM                AS CS_NM			                                         \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY      			AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD	                                     \r\n"
		+ "                    FROM NIC01B NIC01, NIC19B_FACTIVA FACTIVA			                                     \r\n"
		+ "                   WHERE TRIM(NIC01.CS_NM) = FACTIVA.CS_NM				                                     \r\n"
		+ "                     AND NIC01.NTN_CD = FACTIVA.NTN_CD					                                     \r\n"
		+ "                     AND NIC01.INDV_CORP_CCD = '1'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.BRTDY) IS NOT NULL					                                     \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL					                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.CS_NM                AS CS_NM			                                         \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD		                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY			    AS DOB				                                         \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD	                                     \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL					                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.ENG_CS_NM            AS CS_NM			                                         \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY			    AS DOB			 	                                         \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD	                                     \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '1'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL				                                     \r\n"
		+ "                   UNION ALL												                                     \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO			                                     \r\n"
		+ "                       , NIC01.ENG_CS_NM            AS CS_NM			                                         \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)	AS NTV_FGNR_CCD	 	                                     \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD			                                     \r\n"
		+ "                       , NIC01.BRTDY       			AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD	                                     \r\n"
		+ "                    FROM NIC01B NIC01									                                     \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'						                                     \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'						                                     \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL				                                     \r\n"
		+ "                  )A                                                                                          \r\n"
		+ "               , (                                                                                            \r\n"
		+ "                  SELECT TRIM(NIC03.RNMCNO)         AS RNMCNO                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NM1)    AS CS_NM                                                  \r\n"
		+ "                       , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT1) = 'KR' THEN 'A'                                 \r\n"
		+ "                         ELSE 'B' END               AS NTV_FGNR_CCD                                           \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NTNLT1) AS NTN_CD                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_BRDY1)  AS DOB                                                    \r\n"
		+ "                       , '2'                        AS WL_RELATED_PER_CODE                                    \r\n"
		+ "                    FROM NIC03B NIC03                                                                         \r\n"
		+ "                   WHERE TRIM(NIC03.RPRST_P_NM1) IS NOT NULL                                                  \r\n"
		+ "                   UNION ALL                                                                                  \r\n"
		+ "                  SELECT TRIM(NIC03.RNMCNO)         AS RNMCNO                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NM2)    AS CS_NM                                                  \r\n"
		+ "                       , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT2) = 'KR' THEN 'A'                                 \r\n"
		+ "                         ELSE 'B' END               AS NTV_FGNR_CCD                                           \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NTNLT2) AS NTN_CD                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_BRDY2)  AS DOB                                                    \r\n"
		+ "                       , '2'                        AS WL_RELATED_PER_CODE                                    \r\n"
		+ "                    FROM NIC03B NIC03                                                                         \r\n"
		+ "                   WHERE TRIM(NIC03.RPRST_P_NM2) IS NOT NULL                                                  \r\n"
		+ "                   UNION ALL                                                                                  \r\n"
		+ "                  SELECT TRIM(NIC03.RNMCNO)         AS RNMCNO                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NM3)    AS CS_NM                                                  \r\n"
		+ "                       , CASE WHEN TRIM(NIC03.RPRST_P_NTNLT3) = 'KR' THEN 'A'                                 \r\n"
		+ "                         ELSE 'B' END               AS NTV_FGNR_CCD                                           \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_NTNLT3) AS NTN_CD                                                 \r\n"
		+ "                       , TRIM(NIC03.RPRST_P_BRDY3)  AS DOB                                                    \r\n"
		+ "                       , '2'                        AS WL_RELATED_PER_CODE                                    \r\n"
		+ "                    FROM NIC03B  NIC03                                                                        \r\n"
		+ "                   WHERE TRIM(NIC03.RPRST_P_NM3) IS NOT NULL                                                  \r\n"
		+ "                  )B                                                                                          \r\n"
		+ "           WHERE B.RNMCNO = A.RNMCNO                                                                          \r\n"
		+ "          UNION ALL                                                                                           \r\n"
		+ "          SELECT B.WL_RELATED_PER_CODE                                                                        \r\n"
		+ "               , B.RNMCNO                                                                                     \r\n"
		+ "               , B.CS_NM                                                                                      \r\n"
		+ "               , B.NTV_FGNR_CCD                                                                               \r\n"
		+ "               , B.NTN_CD                                                                                     \r\n"
		+ "               , B.DOB                                                                                        \r\n"
		+ "               , '' AS INDV_CORP_CCD                                                                          \r\n"
		+ "            FROM (															                                 \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO				                                 \r\n"
		+ "                       , NIC01.CS_NM                  AS CS_NM				                                 \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)		AS NTV_FGNR_CCD		                                 \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD				                                 \r\n"
		+ "                       , NIC01.BRTDY      			AS DOB					                                 \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD		                                 \r\n"
		+ "                    FROM NIC01B NIC01, NIC19B_FACTIVA FACTIVA				                                 \r\n"
		+ "                   WHERE TRIM(NIC01.CS_NM) = FACTIVA.CS_NM					                                 \r\n"
		+ "                     AND NIC01.NTN_CD = FACTIVA.NTN_CD						                                 \r\n"
		+ "                     AND NIC01.INDV_CORP_CCD = '1'							                                 \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'							                                 \r\n"
		+ "                     AND TRIM(NIC01.BRTDY) IS NOT NULL						                                 \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL						                                 \r\n"
		+ "                   UNION ALL													                                 \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO				                                 \r\n"
		+ "                       , NIC01.CS_NM                  AS CS_NM				                                 \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)		AS NTV_FGNR_CCD		                                 \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD				                                 \r\n"
		+ "                       , NIC01.BRTDY			        AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD		                                 \r\n"
		+ "                    FROM NIC01B NIC01										                                 \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'							                                 \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) = 'KR'							                                 \r\n"
		+ "                     AND TRIM(NIC01.CS_NM) IS NOT NULL						                                 \r\n"
		+ "                   UNION ALL													                                 \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO				                                 \r\n"
		+ "                       , NIC01.ENG_CS_NM              AS CS_NM				                                 \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)		AS NTV_FGNR_CCD		                                 \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD				                                 \r\n"
		+ "                       , NIC01.BRTDY			        AS DOB				                                     \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD		                                 \r\n"
		+ "                    FROM NIC01B NIC01										                                 \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '1'							                                 \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'							                                 \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL					                                 \r\n"
		+ "                   UNION ALL													                                 \r\n"
		+ "                  SELECT TRIM(NIC01.RNMCNO)			AS RNMCNO				                                 \r\n"
		+ "                       , NIC01.ENG_CS_NM              AS CS_NM				                                 \r\n"
		+ "                       , TRIM(NIC01.NTV_FGNR_CCD)		AS NTV_FGNR_CCD		                                 \r\n"
		+ "                       , TRIM(NIC01.NTN_CD)			AS NTN_CD				                                 \r\n"
		+ "                       , NIC01.BRTDY       			AS DOB					                                 \r\n"
		+ "                       , TRIM(NIC01.INDV_CORP_CCD)	AS INDV_CORP_CCD		                                 \r\n"
		+ "                    FROM NIC01B NIC01										                                 \r\n"
		+ "                   WHERE NIC01.INDV_CORP_CCD = '2'							                                 \r\n"
		+ "                     AND TRIM(NIC01.NTN_CD) != 'KR'							                                 \r\n"
		+ "                     AND TRIM(NIC01.ENG_CS_NM) IS NOT NULL					                                 \r\n"
		+ "                  )A                                                                                          \r\n"
		+ "               , (                                                                                            \r\n"
		+ "                  SELECT TRIM(Owner.CDD_TAGT_ENTY_ID) AS RNMCNO                                               \r\n"
		+ "                       , TRIM(Owner.REL_OWNR_NAME)    AS CS_NM                                                \r\n"
		+ "                       , CASE WHEN TRIM(Country.CNTY_CODE) = 'KR' THEN 'A'                                    \r\n"
		+ "                              ELSE 'B' END            AS NTV_FGNR_CCD                                         \r\n"
		+ "                       , TRIM(Country.CNTY_CODE)      AS NTN_CD                                               \r\n"
		+ "                       , TRIM(Owner.REL_OWNR_BRDT)    AS DOB                                                  \r\n"
		+ "                       , '3'                          AS WL_RELATED_PER_CODE                                  \r\n"
		+ "                    FROM SID.IDO_A_MAH_CDD_REL_OWNR_IFMN Owner                                                \r\n"
		+ "                       , SID.IDO_A_UUE_COUNTRY           Country                                              \r\n"
		+ "                   WHERE 1 = 1                                                                                \r\n"
		+ "                     AND TRIM(Owner.REL_OWNR_NAME) IS NOT NULL                                                \r\n"
		+ "                     AND Owner.REL_OWNR_NTNY_ID = Country.CNTY_ID                                             \r\n"
		+ "                   ORDER BY Owner.REL_OWNR_SQNO                                                               \r\n"
		+ "                  )B                                                                                          \r\n"
		+ "           WHERE B.RNMCNO = A.RNMCNO                                                                          \r\n"
		+ "          ) A                                                                                                 \r\n"
		+ "   WHERE NOT EXISTS (SELECT 1 FROM SID.IDO_A_MAH_WLF_ETRA_PRS_DTLD WLF WHERE A.RNMCNO = WLF.CDD_TAGT_ENTY_ID) \r\n"
		//+ "     AND ROWNUM <= 1000 \r\n"
		;                       
        
        rtnString = allQuery;
        return rtnString;
    }
    
    /**
     * <pre>
     * 필터링 결과를 DB에 저장 1.insert NIC20B 2.insert NIC21B 3.insert NIC22B 4.update NIC35B
     * フィルタリング結果をDBに保存。1.insert NIC20B 2.insert NIC21B 3.insert NIC22B 4.update NIC35B
     * @en
     *</pre>
     *@param obj
     *@throws SQLException
     */
    public void setWALInfo(WLE_IO_Object obj,ResultSet rs) throws SQLException {
    	long sq = getNIC20BSq(obj);
    	//검색엔진 결과 NIC22B에 INSERT
        if(obj.getOutputData().getSize() > 0 ) {
        	mvNIC20B(obj,rs,sq);
        	mvNIC21B(obj,rs,sq);
        	mvNIC22B(obj,rs,sq);
        	
        }
        
        //고위험국가일 경우 NIC22B에 INSERT
        //if(rs.getObject("FATF_NTN_CD") != null) {
        //	if(sq == 0) {
        //		sq = getSeqByName("NIC20B");
        //	}
        //	mvNIC22B(rs, sq);
        //	cnt++;
        //}

        //mvNIC35B(obj);
        checkExec();
    }


    /**
     * <pre>
     * NIC20B에 들어가 다음 순번 값을 구한다.
     * NIC20Bから次の順番を取得する。
     * @en
     *</pre>
     *@param obj    다음  순번 값
     *@return
     *@throws Exception
     */
    private long getNIC20BSq(WLE_IO_Object obj) throws SQLException {
        ResultSet rs = null;
        long sq = 0;
        try {
            
            pstmt_WLB_SELECT_NIC20B_001.setObject(1, getInputParam().getReportDate());
            rs = pstmt_WLB_SELECT_NIC20B_001.executeQuery();
            
            if(rs.next())
                sq = rs.getLong(1);
            else
                throw new SQLException("NIC20B get SQ error");
                
            debug("getNIC20BSq : " + sq);
            
        }
        catch(SQLException e) {
           
        	throw e;
        }
        finally {
            DBUtil.close(rs);
        }
        return sq;
    }
    
    /**
     * <pre>
     * WATCH목록검색의뢰_NIC20B에 insert
     * WL照会依頼_NIC20Bにインサート
     * @en
     *</pre>
     *@param obj    filtering result
     *@param sq        요청 순번
     *               依頼順番
     *               @en
     *@throws SQLException
     */
    protected void mvNIC20B(WLE_IO_Object obj, ResultSet rs, long sq) throws SQLException {
		int i = 0;

		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, getInputParam().getReportDate());
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, sq);
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, RQS_CCD);
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, obj.getInputData().getNTV_FGNR_CCD());
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, obj.getInputData().getCS_NM());
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, getInputParam().getUserId());
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, obj.getInputData().getNTN_CD());
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, obj.getInputData().getWL_RELATED_PER_CODE());
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, obj.getInputData().getRNMCNO());
		pstmt_WLB_INSERT_NIC20B_001.setObject(++i, obj.getInputData().getRNMCNO());
		pstmt_WLB_INSERT_NIC20B_001.addBatch();
		debug("mvNIC20B completed ==> " + sq + ":" + obj.getInputData().getRNMCNO());
    }

    /**
     * <pre>
     * WATCH목록검색결과_NIC21B에 insert
     * WL照会結果_NIC21Bにインサート
     * @en
     *</pre>
     *@param obj    filtering result
     *@param sq        요청 순번
     *               依頼順番
     *               @en
     *@throws SQLException
     */
    protected void mvNIC21B(WLE_IO_Object obj, ResultSet rs, long sq) throws SQLException {
		//debug("mvNIC21B completed==>" +  sq);
		//int i = 0;
		pstmt_WLB_INSERT_NIC21B_001.setObject(1, getInputParam().getReportDate());
		pstmt_WLB_INSERT_NIC21B_001.setObject(2, sq);
		pstmt_WLB_INSERT_NIC21B_001.setObject(3, RQS_CCD);
		pstmt_WLB_INSERT_NIC21B_001.setObject(4, obj.getInputData().getNTV_FGNR_CCD());
		pstmt_WLB_INSERT_NIC21B_001.setObject(5, obj.getInputData().getNTN_CD());
		pstmt_WLB_INSERT_NIC21B_001.setObject(6, obj.getInputData().getCS_NM());
		pstmt_WLB_INSERT_NIC21B_001.setObject(7, getInputParam().getUserId());
		
		pstmt_WLB_INSERT_NIC21B_001.setObject(8,  obj.getInputData().getEtcParmVal(0));
        pstmt_WLB_INSERT_NIC21B_001.setObject(9,  obj.getInputData().getEtcParmVal(1));
        pstmt_WLB_INSERT_NIC21B_001.setObject(10,  obj.getInputData().getEtcParmVal(2));
        pstmt_WLB_INSERT_NIC21B_001.setObject(11,  obj.getInputData().getEtcParmVal(3));
        pstmt_WLB_INSERT_NIC21B_001.setObject(12,  obj.getInputData().getEtcParmVal(4));
        // 고객 구분 코드 추가 20180702 [ 
        pstmt_WLB_INSERT_NIC21B_001.setObject(13,  getInputParam().getCust_G_C());
        // ] 고객 구분 코드 추가 20180702
        // WATCH목록구분코드 추가 20190125 [
        if( obj.getOutputData().getSize() > 0) {
        	pstmt_WLB_INSERT_NIC21B_001.setObject(14, obj.getOutputData().getWLE_Output_RecValue(0, "WC_LIST_CCD"));
        }else {
        	pstmt_WLB_INSERT_NIC21B_001.setObject(14, "");
        }
        
        pstmt_WLB_INSERT_NIC21B_001.setObject(15, obj.getInputData().getWL_RELATED_PER_CODE());
        pstmt_WLB_INSERT_NIC21B_001.setObject(16, obj.getInputData().getRNMCNO());
        pstmt_WLB_INSERT_NIC21B_001.setObject(17, obj.getInputData().getRNMCNO());
        
        
        
		//pstmt_WLB_INSERT_NIC21B_001.setObject(++i, getInputParam().getWC_GRP_LIST_CCD());
		//pstmt_WLB_INSERT_NIC21B_001.setObject(++i, WALB_Main.SDWL);
		//pstmt_WLB_INSERT_NIC21B_001.setObject(++i, WALB_Main.WL_OPEN_DATA_YN);
		

		pstmt_WLB_INSERT_NIC21B_001.addBatch();
//        pstmt_WLB_INSERT_NIC21B_001.executeBatch();
		debug("mvNIC21B completed ==>" + obj.getInputData().getRNMCNO() + ":" + obj.getInputData().getEtcParmVal(0));
    }

    //protected void mvNIC21B(ResultSet rs, long sq) throws SQLException {
	//	debug("mvNIC21B completed W060==>" +  sq);
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(1, getInputParam().getReportDate());
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(2, sq);
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(3, RQS_CCD);
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(4, rs.getString("CS_NM"));
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(5, getInputParam().getUserId());

	//	pstmt_WLB_INSERT_NIC21B_001.setObject(6, "");
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(7, "");
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(8,  "");
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(9,  "");
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(10, "");

	//	pstmt_WLB_INSERT_NIC21B_001.setObject(11, getInputParam().getCust_G_C());
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(12, rs.getString("AML_CUST_ID"));
	//	pstmt_WLB_INSERT_NIC21B_001.setObject(13, rs.getString("AML_CUST_ID"));

	//	pstmt_WLB_INSERT_NIC21B_001.addBatch();
	//	debug("mvNIC21B completed W060==>" +  rs.getString("AML_CUST_ID"));
    //}

    /**
     * <pre>
     * WATCH목록관련검색결과_NIC22B에 insert
     * WL関連照会結果_NIC22Bにインサート
     * @en
     *</pre>
     *@param obj    filtering result
     *@param sq        요청 순번
     *               依頼順番
     *               @en
     *@throws SQLException
     */
    protected void mvNIC22B(WLE_IO_Object obj,ResultSet rs, long sq) throws SQLException {
		for(int j = 0; j < obj.getOutputData().getSize(); j++) {
			int i = 0;
			debug("mvNIC22B " + obj.getOutputData().getWLE_Output_RecValue(j,"ID"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, getInputParam().getReportDate());
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, sq);
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"WC_UID"));
			//pstmt_WLB_INSERT_NIC22B_001.setObject(++i, j+1);
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"WC_LIST_CCD"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"CS_NM"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"SCORE"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, getInputParam().getUserId());
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"INDV_CORP_CCD"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getInputData().getRNMCNO());
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"NTN_CD_N"));
			
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"ADDR"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"ADDR"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"ADDR"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"ADDR"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"ADDR"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"ADDR"));
			
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"DOB_N"));
			pstmt_WLB_INSERT_NIC22B_001.setObject(++i, obj.getOutputData().getWLE_Output_RecValue(j,"SEX"));

			pstmt_WLB_INSERT_NIC22B_001.addBatch();
		}
		debug("mvNIC22B completed");
    }


    //protected void mvNIC22B(ResultSet rs, long sq) throws SQLException {
	//	int i = 0;
	//	debug("mvNIC22B = W060");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, getInputParam().getReportDate());
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, sq);
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "W0600000000");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, 1);
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "W060");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "100");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, rs.getObject("FATF_NTN_CD"));
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, getInputParam().getUserId());
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "W0600000000");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "");
	//	pstmt_WLB_INSERT_NIC22B_001.setObject(++i, "");
	//	pstmt_WLB_INSERT_NIC22B_001.addBatch();
	//	debug("mvNIC22B completed W060");
    //}

    /**
     * <pre>
     * update NIC35B
     *</pre>
     *@param obj filtering result
     *@throws SQLException
     */
    //protected void mvNIC35B(WLE_IO_Object obj) throws SQLException {
		//코드 A003(공개) => W020(FACTIVA)
	//	pstmt_WLB_UPDATE_NIC35B_001.setObject(1, getWC_LIST_CCD(obj));
	//	pstmt_WLB_UPDATE_NIC35B_001.setObject(2, getInputParam().getUserId());
	//	pstmt_WLB_UPDATE_NIC35B_001.setObject(3, obj.getInputData().getAML_CUST_ID());
	//	pstmt_WLB_UPDATE_NIC35B_001.addBatch();

	//	debug("mvNIC35B completed ==>" + obj.getInputData().getAML_CUST_ID()  );
    //}

    //protected void mvNIC35B(ResultSet rs) throws SQLException {
	//	pstmt_WLB_UPDATE_NIC35B_001.setObject(1, "W060");
	//	pstmt_WLB_UPDATE_NIC35B_001.setObject(2, getInputParam().getUserId());
	//	pstmt_WLB_UPDATE_NIC35B_001.setObject(3, rs.getString("AML_CUST_ID"));
	//	pstmt_WLB_UPDATE_NIC35B_001.addBatch();

	//	debug("mvNIC35B completed ==>" +  rs.getString("AML_CUST_ID"));
    //}

    /**
    * <pre>
    * WatchList구분 코드 중 대표 코드을 반환한다.
    * WatchList区分コードの中から代表コードを返す。
    * @en
    *</pre>
    * @param obj WatchList call한 input과 결과 output
    *            WatchListを呼び出したinputと結果output
    *            @en
    * @return 대표 WatchList구분 코드
    *            代表WatchList区分コード
    *            @en
    *
    */
    protected String getWC_LIST_CCD(WLE_IO_Object obj) throws SQLException {
        String rtn = "";
        for(int i = 0; i < obj.getOutputData().getSize(); i++) {
            if(rtn.length() < 1
            || rtn.compareTo(obj.getOutputData().getWLE_Output_RecValue(i, "WC_LIST_CCD")) > 0) {
                rtn = obj.getOutputData().getWLE_Output_RecValue(i, "WC_LIST_CCD");
            }
        }
        return rtn;
    }
    private long startTime = -1;
    private void initStartTime() {
        if(startTime < 0) startTime = Timer.getInstance().start();
    }
    private void execBatch() throws SQLException {
    	PreparedStatement pstmt = null;
		for (int i = 0; i < m_pstmtBatchList.size(); i++) {
			pstmt =  m_pstmtBatchList.get(i);
			pstmt.executeBatch();
			pstmt.clearBatch();
		}
		if(Config.getInstance().getWALCommitEachDataBlockCompleted()) {
			conn.commit();
			debug("commit");
		}
		m_nCounter = 0;

		Timer.getInstance().stopAndPrintInfo(_log,"total " + m_TotalCount + " row(s) completed - Data block elapsed time", startTime);
    }

    private void checkExec() throws SQLException {
        m_TotalCount++;
        if(++m_nCounter >= BATCH_BLOCK_SIZE)
            execBatch();
    }

    /**
     * <pre>
    * WatchList filtering한 고객 수
    * WatchListをフィルタリングした顧客数
    * @en
    *</pre>
     *@return
     */
    public long getTotalCount() {
        return m_TotalCount;
    }

    /**
     * <pre>
    * 필터링 전 process, 같은 날짜에 돌린 것이 있다면 지운다.
    * フィルタリング前のプロセス。同じ日に実行したものがあれば削除する。
    * @en
    *</pre>
     *@throws SQLException
     */
    public void preProcess() throws SQLException {
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        try {
            if(this.getInputParam().getProcFlag().equals("ALL") || this.getInputParam().getProcFlag().equals("MBN"))
            {
                debug(WALB_Sql.WLB_DELETE_NIC22B_001() + ":" + getInputParam().getReportDate() + ":" + RQS_CCD);
                pstmt1 = conn.prepareStatement(WALB_Sql.WLB_DELETE_NIC22B_001());
                pstmt1.setObject(1, getInputParam().getReportDate());
                pstmt1.setObject(2, RQS_CCD);
                pstmt1.executeUpdate();

                debug(WALB_Sql.WLB_DELETE_NIC21B_001() + ":" + getInputParam().getReportDate() + ":" + RQS_CCD);
                pstmt2 = conn.prepareStatement(WALB_Sql.WLB_DELETE_NIC21B_001());
                pstmt2.setObject(1, getInputParam().getReportDate());
                pstmt2.setObject(2, RQS_CCD);
                pstmt2.executeUpdate();

                debug(WALB_Sql.WLB_DELETE_NIC20B_001() + ":" + getInputParam().getReportDate() + ":" + RQS_CCD);
                pstmt3 = conn.prepareStatement(WALB_Sql.WLB_DELETE_NIC20B_001());
                pstmt3.setObject(1, getInputParam().getReportDate());
                pstmt3.setObject(2, RQS_CCD);
                pstmt3.executeUpdate();

                if(Config.getInstance().getWALCommitEachDataBlockCompleted())
                    conn.commit();

                log("DELETE NIC20B, NIC21B, NIC22B completed");
            }
        }
        catch(SQLException e) {
            throw e;
        }
        finally {
            DBUtil.close(pstmt1);
            DBUtil.close(pstmt2);
            DBUtil.close(pstmt3);
        }
    }

    /**
     * <pre>
    * 필터링 후 process, 아무 것도 안 한다.
    * フィルタリング後のプロセス。何もしない。
    * @en
    *</pre>
     *@throws SQLException
     */
    public void postProcess() throws SQLException {
        log("do nothing...");
    }
}
