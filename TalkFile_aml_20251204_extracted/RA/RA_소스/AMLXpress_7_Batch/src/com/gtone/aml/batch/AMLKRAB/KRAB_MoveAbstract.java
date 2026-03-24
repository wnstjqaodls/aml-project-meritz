/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLKRAB;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gtone.aml.batch.common.util.RuleUtil;

/**
* 
*<pre>
* KYC RA의 결과를 DB에 insert하는 abstract class
*  KYC RAの結果をDBにインサートするabstract class
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public abstract class KRAB_MoveAbstract {
    protected final static int BATCH_BLOCK_SIZE = KRAB_Main.DATA_BLOCK_SIZE;
    
    protected static Log _log = LogFactory.getLog(KRAB_Main.class);
    public final static String FLAG_ALL="ALL";
    public final static String FLAG_CHANGE="CHANGE";
    public final static String FLAG_ONE="ONE";
    public final static String FLAG_MTH="MTH";
    
    /**
     * <pre>
     * 초기화
     * 初期化
     * @en
     * </pre>
     *@param ruleUtil
     *@param connection db object
     *@throws Exception
     */
    public abstract void initialize(Connection connection) throws SQLException;
    
    /**
     * <pre>
     * db 관련 object를 close한다.
     * DB関連のオブジェクトをクローズする。
     * @en
     * <pre>
     *@throws Exception
     */
    public abstract void close() throws SQLException;

    
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
    public abstract String getMainQuery(String flag) throws NullPointerException;
    
    public abstract String getMainAllQuery(String flag) throws NullPointerException;
    
    /**
     * <pre>
     * RA 모델을 가져오는 쿼리
     * </pre>
     *@return    select query
     *@throws Exception
     */
    public abstract String getRAModelQuery() throws NullPointerException;
    
    /**
     * <pre>
     * RA결과를 DB에 insert
     * RA結果をDBにインサート
     * @en
     * </pre>
     *@param obj Scoring result object
     *           
     *@throws Exception
     */

    public abstract void setKRA_Info(ResultSet rs) throws SQLException;
    
    /**
     *  <pre>
     * 스코어링 실행 전 process 
     * スコアリング実行前のプロセス
     * @en
     * </pre>
     *@throws Exception     
     */
    public abstract void preProcess() throws SQLException;
    
    /**
     *  <pre>
     * 스코어링 실행 후 process 
     * スコアリング実行後のプロセス
     * @en
     * </pre>
     *@throws Exception     
     */
    public abstract void postProcess() throws SQLException;

    /**
     * <pre>
     * 스코어링을 실시한 고객수
     * スコアリングを行った顧客数
     * @en
     * </pre>
     *@return
     */
    public abstract long getTotalCount();
     
    protected Connection conn = null;
    
    
      

    KRAB_Input input;
    
    /**
     * <pre>
     * 배치 외부 parameter object를 지정한다.
     * バッチ外部パラメータオブジェクトを指定する。
     * @en
     * </pre>
     *@param input
     */
    public void setInputParam(KRAB_Input input) 
    {
        this.input=input;
          
    }
    
    /**
     * <pre>
     * 배치 외부 parameter object를 반환한다.
     * バッチ外部パラメータオブジェクトを返す。
     * @en
     * </pre>
     *@return
     */
    public KRAB_Input getInputParam()
    {
        return input;
    }
    
    /**
     * <pre>
     * 룰 호출 시 필요한 parameter를 반환한다.
     * ルール呼び出し時に必要なパラメータを返す。
     * @en
     * </pre>
     *@param con    db connection
     *@param custId    customer's id
     *@param rs    고객정보, getMainQuery()의 실행 결과
     *          顧客情報、getMainQuery()の実行結果
     *          @en
     *@return
     *@throws Exception
     */
    public Object[] getRuleParam(java.sql.Connection con, String custId,ResultSet rs) throws SQLException
    {
    	Object[] parms = new Object[rs.getMetaData().getColumnCount()-7];  //RA 모델 파라메타 수만큼 설정
        for(int i = 0; i < parms.length; i++)
            parms[i] = rs.getObject(i+1);
        return parms;
    }
    
}
