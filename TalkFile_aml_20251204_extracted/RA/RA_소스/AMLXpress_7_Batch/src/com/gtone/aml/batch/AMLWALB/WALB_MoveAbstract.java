package com.gtone.aml.batch.AMLWALB;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
*<pre>
* WL 실행 후 결과를 DB에 insert하는 class
* WL実行後の結果をDBにインサートするクラス
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public abstract class WALB_MoveAbstract {
	/*
	A	ONLINE
	A01	실시간 고객 WL필터링 (WL전체)
	B	BATCH
	B01	고객 WL필터링 배치 (WL변경분)
	B02	고객 WL필터링 배치 (WL전체)
	B03	임직원 WL필터링 배치 (WLF전체)
	B04	수입신용장개설 WL필터링 배치 [51201]
	B05	수입무신용장등록 WL필터링 배치 [51211]
	B06	수입LG발급 WL필터링 배치 [51301]
	B07	수입선적서류접수 WL필터링 배치 [51405]
	B08	수출신용장통지 WL필터링 배치 [52101]
	B09	수출신용장양도등록 WL필터링 배치 [52121]
	B10	수출환어음 매입/추심 WL필터링 배치 [52301]
	B11	수출환어음 커버링 작성 및 발송등록 WL필터링 배치 [52303]
	C	ONLINE(ADD)
	*/
    protected static String RQS_CCD = "B";
    protected final static int BATCH_BLOCK_SIZE = WALB_Main.DATA_BLOCK_SIZE;

    protected static Log _log = LogFactory.getLog(WALB_Main.class);
    /**
     * <pre>
     * 초기화한다.
     * 初期化
     * @en
     *</pre>
     *@param connection
     *@throws SQLException
     */
    public abstract void initialize(Connection connection) throws SQLException;

    /**
     * <pre>
     * Statement를 close한다.
     * Statementをクローズする。
     * @en
     *</pre>
     *@throws SQLException
     */
    public abstract void close() throws SQLException;

    /**
     * <pre>
     * 배치를 실행할 고객과 필터링하기 위한 고객 정보를 select하는 쿼리
     * バッチを実行する顧客とフィルタリングするための顧客情報をSelectするクエリ
     * @en
     *</pre>
     *@return
     *@throws SQLException
     */
    public abstract String getMainQuery() throws SQLException;
    
    public abstract String getMainAllQuery() throws SQLException;

    public abstract String getOwnerQuery(String sRnmCno)  throws SQLException;

	public abstract String getDelegateQuery(String sRnmCno) throws SQLException;
    
    /**
     * <pre>
     * 필터링 결과를 DB에 저장
     * フィルタリング結果をDBに保存
     * @en
     *</pre>
     *@param obj
     *@throws SQLException
     */
    public abstract void setWALInfo(WLE_IO_Object obj, ResultSet rs) throws SQLException;


    /**
     * <pre>
    * 필터링 전 process
    * フィルタリング前のプロセス
    * @en
    *</pre>
     *@throws SQLException
     */
    public abstract void preProcess() throws SQLException;


    /**
     * <pre>
    * 필터링 후 process
    * フィルタリング後のプロセス
    * @en
    *</pre>
     *@throws SQLException
     */
    public abstract void postProcess() throws SQLException;

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
    protected abstract String getWC_LIST_CCD(WLE_IO_Object obj) throws SQLException ;

    /**
     * <pre>
    * WatchList filtering한 고객 수
    * WatchListをフィルタリングした顧客数
    * @en
    *</pre>
     *@return
     */
    public abstract long getTotalCount();

    protected Connection conn = null;


    // log
    protected void log(String message) {
        _log.info(message);
    }
    protected void debug(String message) {
        _log.debug(message);
    }

    WALB_Input input;

    /**
     * <pre>
    * 배치 실행 parameter object를 지정한다.
    * バッチ実行parameter objectを指定する。
    * @en
    *</pre>
     *@param input
     */
    public void setInputParam(WALB_Input input)
    {
           this.input=input;

    }

    /**
     * <pre>
    * 배치 실행 parameter object를 반환한다.
    * バッチ実行parameter objectを返す。
    * @en
    *</pre>
     *@return
     */
    public WALB_Input getInputParam()
    {
        return input;
    }

    public abstract String getFicTivaBatchExcuteYnQuery() throws SQLException;
    
    
    
}
