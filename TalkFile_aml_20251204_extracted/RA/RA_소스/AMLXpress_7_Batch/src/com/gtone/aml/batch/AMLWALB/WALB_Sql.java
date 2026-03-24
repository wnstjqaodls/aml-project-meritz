package com.gtone.aml.batch.AMLWALB;

import com.gtone.aml.batch.common.Config;

/**
 *
*<pre>
* WL Filtering Query
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public abstract class WALB_Sql {

	private static WALB_Sql instance = null;
	public static WALB_Sql getInstance() {
		//if (instance == null) {
			String dbDriver = Config.getInstance().getDB_DRIVER();
	    	//if (dbDriver.contains("mysql")) {
	    	//	instance = new WALB_Sql_MySQL();
	    	//} else if (dbDriver.contains("postgresql")) {
	    	//	instance = new WALB_Sql_Postgre();
	    	//} else {
	    		instance = new WALB_Sql_Oracle();
	    	//}
		//}
		return instance;
	}

	public abstract String getDBType();

    /**
     * <pre>
     * WATCH목록검색의뢰_NIC20B delete 쿼리
     * WL照会依頼_NIC20B delete クエリ
     * @en
     * </pre>
     */
    public abstract String WLB_DELETE_NIC20B_001();

    /**
     * <pre>
     * WATCH목록검색결과_NIC21B delete 쿼리
     * WL照会結果_NIC21B delete クエリ
     * @en
     * </pre>
     */
    public abstract String WLB_DELETE_NIC21B_001();


    /**
     * <pre>
     * WATCH목록관련검색결과_NIC22B delete 쿼리
     * WL関連検索結果_NIC22B delete クエリ
     * @en
     * </pre>
     */
    public abstract String WLB_DELETE_NIC22B_001();

    public abstract String WLB_DELETE_NIC21B_APPR_001();


    /**
     * <pre>
     * NIC01B에서 필터링할 고객정보 select 쿼리
     * NIC01Bからフィルタリングする顧客情報をSelectするクエリ
     * @en
     * </pre>
     */
    public abstract String WLB_SELECT_NIC01B_001();

    /**
     * <pre>
     * 고객ID로 NIC19B에서 Select하는 쿼리
     * 顧客IDでNIC19BからSelectするクエリ
     * @en
     * </pre>
     */
    public abstract String WLB_SELECT_NIC19B_001();

    /**
     * <pre>
     *  NIC20B에서 다음 순번을  Select하는 쿼리
     * NIC20Bから次の順番をSelectするクエリ
     * @en
     * </pre>
     */
    public abstract String WLB_SELECT_NIC20B_001();

    /**
     * <pre>
     *  WATCH목록검색의뢰_NIC20B에 NIC01B에서 Select해서 Insert하는 쿼리
     * NIC01BからSelectしてWL照会依頼_NIC20BにInsertするクエリ
     * @en
     * </pre>
     */
    public abstract String WLB_INSERT_NIC20B_001();

    /**
     * <pre>
     *  WATCH목록검색결과_NIC21B에 NIC01B에서 Select해서 Insert하는 쿼리
     * NIC01BSelectしてWL照会結果_NIC21BにInsertするクエリ
     * @en
     * </pre>
     */
    public abstract String WLB_INSERT_NIC21B_001();

    /**
     * <pre>
     *  WATCH목록관련검색결과_NIC22B에 Insert하는 쿼리
     * WL関連照会結果_NIC22BにInsertするクエリ
     * @en
     * </pre>
     */
    public abstract String WLB_INSERT_NIC22B_001();

    /**
     * <pre>
     *  NIC35B에 대표 WL구분 코드(WC_LIST_CCD)를 update하는 쿼리
     * NIC35Bに代表WL区分コード(WC_LIST_CCD)をupdateするクエリ
     * @en
     * </pre>
     */
    public abstract String WLB_UPDATE_NIC35B_001();


    //WatchList 정확도 추출 20191203
    public abstract String WLB_SELECT_NIC92B_STD_VAL_001();
    
    public abstract String WLB_FICTIVA_BATCH_EXCUTE_YN();

}