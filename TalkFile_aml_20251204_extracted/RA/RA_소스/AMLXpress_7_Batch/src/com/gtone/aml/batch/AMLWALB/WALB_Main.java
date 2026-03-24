/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLWALB;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.batch.common.AbstractBatchJobNode;
import com.gtone.aml.batch.common.Config;
import com.gtone.aml.batch.common.util.AML_Log;
import com.gtone.aml.batch.common.util.DBUtil;
import com.gtone.aml.batch.common.util.DateUtil;
import com.gtone.aml.batch.common.util.InputUtil;
import com.gtone.aml.batch.common.util.StatementHandler;
import com.gtone.aml.batch.common.util.Timer;
import com.gtone.wlf.core.data.SData;

/**
 *
*<pre>
* WatchList 필터링 배치 메인 class
* WatchListフィルタリングバッチのメインクラス
* @en
*</pre>
*@author syk, hikim
*@version 1.0
*@history 1.0 2010-09-30
 */
public class WALB_Main extends AbstractBatchJobNode{
	protected static Log _log = LogFactory.getLog(WALB_Main.class);
    public static final String WALB_ID = "WALB";
    public static final int DATA_BLOCK_SIZE = Config.getInstance().getWALDataBlockSize();
    public static String SDWL = "97";

    public static String WL_OPEN_DATA_YN = "N"; // Y: 기관 공개데이터, N:상용데이터
    public static final boolean checkNTN = true; //true: 국가 일치 체크 안함, false: 국가 일치 체크함

    String logInsertSql = null;
    String logUpdateSql = null;
    String logUpdateSqlNIC93B = null;
    String logInsertSqlNIC93B = null;

    public static void main(String[] args) {
        try {
        	
        	//호출 시 필수 args의 개수
            int nArgsLength = 4;
            WALB_Main main = new WALB_Main();
            
            main.setProcFlag(InputUtil.getArgumentValue(args, 0));
            //main.setTradeDate(DateUtil.addDays(InputUtil.getArgumentValue(args, 1),-1));
            main.setTradeDate(InputUtil.getArgumentValue(args, 1));
            main.setReportDate(InputUtil.getArgumentValue(args, 1));
            main.setUserId(InputUtil.getArgumentValue(args, 2));        
            main.setCust_G_C(InputUtil.getArgumentValue(args, 3)); //공통코드: A915
            
            String[] extraArgs = null;
            if(args.length > nArgsLength)
            {
                extraArgs = new String[(args.length - nArgsLength)];
                System.arraycopy(args, nArgsLength, extraArgs, 0, (args.length - nArgsLength));
            }
             
            main.execute(extraArgs);
        } catch (Exception e) {
            _log.error(e.getMessage(),e);
        }
    }

    public WALB_Main()
    {
        WALB_Input input = new WALB_Input();
        //input.setbChkNtn(false);              //국가일치 여부(true: 일치, false: 불일치)
        //input.setsNtvFgnrCcd("B");            //내외국인 구분(N: 내외국인 구분 안함, A: 내국인, B: 외국인)
        super.setInputUtil(input);
        isNewCon = true;
    }

    /**
     * <pre>
     * WatchList 필터링 배치 실행
     * WatchListフィルタリングバッチを実行
     * @en
     * </pre>
     *@param args     추가 parameter , flag가 ONE일 때 고객ID
     *              追加パラメータ。flagがONEであれば顧客ID
     *              @en
     *@return    배치 실행한 고객 건수
     *          バッチを実行した顧客件数
     *          @en
     *@throws SQLException
     */
    public long execute(String[] args) throws AMLException {
        long startTime = Timer.getInstance().start();
        long result = 0;
        try {
            Timer.getInstance().start();
            inputObj.initializeInput(args);

            if("MBN".equalsIgnoreCase(inputObj.getProcFlag())) {
            	WALB_MoveAbstract.RQS_CCD="B";	
            }else if("ALL".equalsIgnoreCase(inputObj.getProcFlag())) {
            	WALB_MoveAbstract.RQS_CCD="C";
            } 

            displaySetting();
            result = statWatchList();
        } catch (Exception e) {
            AML_Log.writeln(_log,"Exception : " + e.getMessage());
        } finally {
            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            Timer.getInstance().stopAndPrintInfo(_log,"AMLWALB Total Elapsed Time", startTime);
            AML_Log.writeLine(_log);
        }
        return result;
    }

    @SuppressWarnings("deprecation")
    private void displaySetting() throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, NoSuchProviderException {
        Config config = Config.getInstance();
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log,"AMLWALB Pgm Start (" + DateUtil.getTimeStampString() + ")");
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log,"## DB_DRIVER         : [" + config.getDB_DRIVER() + "]");
        AML_Log.writeln(_log,"## DB_URL            : [" + config.getDB_URL() + "]");
        AML_Log.writeln(_log,"## DB_ID             : [" + config.getDB_ID() + "]");
        AML_Log.writeln(_log,"## DB_PW             : [" + (config.isLOG_DEBUG() ? config.getDB_PW() : "**********") + "]");
        AML_Log.writeln(_log,"");
        AML_Log.writeln(_log,"## LOG_Path          : [" + config.getLOG_Path() + "]");
        AML_Log.writeln(_log,"## LOG_MODE_DEBUG    : [" + config.isLOG_DEBUG() + "]");
        AML_Log.writeln(_log,"## LOG_To_File       : [" + config.isLOG_2_FILE() + "]");
        AML_Log.writeln(_log,"");
        AML_Log.writeln(_log,"## AML_WAS_IP        : [" + config.getAMLWasIP() + "]");
        AML_Log.writeln(_log,"## AML_WAS_PORT      : [" + config.getAMLWasPort() + "]");
        AML_Log.writeln(_log,"## AML_WAS_CONTEXT   : [" + config.getAMLWasContext() + "]");
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log,"## ProcFlag 		   : [" + inputObj.getProcFlag() + "]");
        AML_Log.writeln(_log,"## TradeDate 		   : [" + inputObj.getTradeDate() + "]");
        AML_Log.writeln(_log,"## WorkDate 		   : [" + inputObj.getReportDate() + "]");
        AML_Log.writeln(_log,"## UserId   		   : [" + inputObj.getUserId() + "]");
        AML_Log.writeln(_log,"## Cust_G_C   	   : [" + inputObj.getCust_G_C() + "]");
        AML_Log.writeln(_log,"## ExtraArgs         : [" + inputObj.getExtraArgs()[0] + "]");
        //AML_Log.writeln(_log,"## ExtraArgs2         : [" + inputObj.getExtraArgs()[1] + "]");
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log,"## DATA_BLOCK_SIZE                  : [" + DATA_BLOCK_SIZE + "]");
        AML_Log.writeln(_log,"## COMMIT_EACH_DATA_BLOCK_COMPLETED : [" + Config.getInstance().getWALCommitEachDataBlockCompleted() + "]");
        AML_Log.writeLine(_log);
    }

    protected WLE_IO_Object getWLEResult(Connection conn, ResultSet rs, String SDWL, String wc_grp_list_ccd, String indexPath, String maxRow) throws Exception {

    	String[] parms = null;
    	parms = new String[rs.getMetaData().getColumnCount()];
    	int length = parms.length;
    	for(int i = 0; i < length; i++)
    		parms[i] = rs.getString(i+1);
    	WLE_Caller caller = new WLE_Caller();
    	return caller.execute(conn,parms,SDWL,wc_grp_list_ccd,indexPath,maxRow);
    }

    private WALB_MoveAbstract m_MoveClass = null;

    private WALB_MoveAbstract getMoveClass() throws InstantiationException, IllegalAccessException, ClassNotFoundException {
        if(m_MoveClass == null)
        {
            m_MoveClass = (WALB_MoveAbstract)Class.forName(Config.getInstance().getWALMoveClassName()).newInstance();
            m_MoveClass.setInputParam((WALB_Input)inputObj);
        }
        return m_MoveClass;
    }
    public WALB_Main(java.sql.Connection conn)
    {
        this();
        this.con = conn;
        isNewCon=false;

    }
    private long statWatchList() throws Exception {
        Connection conn = null;
        
        Statement stmt = null;
        Statement stmt_owner    = null;
        Statement stmt_delegate = null;
        
        ResultSet rs = null;
        ResultSet rs_owner    = null;
        ResultSet rs_delegate = null;
        
        PreparedStatement ps = null;
        
        WLE_IO_Object obj_1R = null;
        WLE_IO_Object obj_1R_owner    = null;
        WLE_IO_Object obj_1R_delegate = null;
        
        String sRnmCno = null;
        //long rs_proc_cnt = 0;
        //long rs_owner_proc_cnt = 0;
        //long rs_delegate_proc_cnt = 0;
        
        
        String maxRow = "";
        String dataGubn = "";
        String wc_grp_list_ccd = "";

        String sql = "";
        String STD_ID = "51";	//MMA040TB WatchList 정확도 추출 조건 ==> 동일한구조의 NIC92B_STR_VAL로 변경

        String jobId = "B40001";
        String runDatelog = DateUtil.getShortTimeStampString();
        int userId = inputObj.getUserId();

        String tradeDate = inputObj.getTradeDate();
        String reportDate = inputObj.getReportDate();
        String flag = "D";
        int JOB_FINISH = 1; //정상코드
        int JOB_ERROR = 9;  //오류코드

        try {
        	//watchlist index파일 20191203
        	maxRow = Util.nvl(Config.getInstance().getProperty("MAXROWS"), "100");
        	//dataGubn = inputObj.getData_G_C();
        	dataGubn = inputObj.getProcFlag();
        	
        	if("".equals(inputObj.getWC_GRP_LIST_CCD())) {
        		wc_grp_list_ccd = "C";
        		inputObj.setWC_GRP_LIST_CCD("C");
        	}
        	WL_OPEN_DATA_YN = Config.getInstance().getProperty("WL_OPEN_DATA_YN", "Y").trim();
        	String indexPath = Config.getInstance().getProperty("WATCHLIST_INDEX_DIR").trim();

        	//WL_OPEN_DATA_YN Y:기관 공개데이터, N:상용데이터
        	//indexpath 설정 전체  : F , Daily : D
//        	[START]20250228 변경분추가
        	
        	if("Y".equals(WL_OPEN_DATA_YN)) {
    //    		if("D".equals(dataGubn) ) {
    //    			indexPath = indexPath + Config.getInstance().getProperty("DAILYIDXPATH").trim();
	//        		String targetDay = DateUtil.addDays(DateUtil.getShortDateString(), -2);
	//        		indexPath = indexPath + "/" + targetDay;
    //    	}
        	}else {
        		if ("ALL".equals(dataGubn)) {
        			indexPath = indexPath;
        		}else if ("MBN".equals(dataGubn)) {
        			String targetDay = inputObj.getTradeDate();
        			_log.debug("## Daily index date::"+targetDay);
        			indexPath = indexPath + Config.getInstance().getProperty("DAILYIDXPATH").trim();
        			indexPath = indexPath + "/" + targetDay;
        		}
        	}
//        	[END]20250228 변경분추가

         	_log.debug("index path==>"+indexPath);

            super.inputObj.chkLicense("WL");

            conn = getDBConnection(Config.getInstance().getWALCommitEachDataBlockCompleted());
            conn.setAutoCommit(false);

            logStart(jobId, runDatelog, 1, userId,  tradeDate,   reportDate,   flag, conn );
            conn.commit();

            stmt = conn.createStatement();
            stmt.executeQuery("ALTER SESSION SET DB_FILE_MULTIBLOCK_READ_COUNT= 256");
            
            //stmt_owner = conn.createStatement();
            //stmt_owner.executeQuery("ALTER SESSION SET DB_FILE_MULTIBLOCK_READ_COUNT= 256");
            
            //stmt_delegate = conn.createStatement();
            //stmt_delegate.executeQuery("ALTER SESSION SET DB_FILE_MULTIBLOCK_READ_COUNT= 256");
            
            getMoveClass().initialize(conn);
            
            /* 배치실행여부 확인 */
            String sBatchExcuteYn = "Y";
            
            if("MBN".equalsIgnoreCase(inputObj.getProcFlag()) || "ALL".equalsIgnoreCase(inputObj.getProcFlag())) {
            	sBatchExcuteYn = "N";
            	
	            ps = conn.prepareStatement(getMoveClass().getFicTivaBatchExcuteYnQuery());
	            ps.setObject(1, inputObj.getExtraArgs()[0]);
	            rs = ps.executeQuery();
	            while (rs.next()) {
	            	sBatchExcuteYn = rs.getString("EXCUTE_BATCH_YN");
	            	break;
	            }
	            DBUtil.close(rs);
	            DBUtil.close(ps);
            }
            
            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            AML_Log.writeln(_log,"Batch Excute ===> " + sBatchExcuteYn);
            AML_Log.writeLine(_log);
            
            if("Y".equalsIgnoreCase(sBatchExcuteYn)) {

            getMoveClass().preProcess();
            sql = WALB_Sql.getInstance().WLB_SELECT_NIC92B_STD_VAL_001();
            SDWL = String.valueOf(getQueryResult(conn, sql, STD_ID));	//[공통기준값 관리   ] default 96
            
           
            if("MBN".equalsIgnoreCase(inputObj.getProcFlag())) {
            	AML_Log.writeBlock(_log);
                AML_Log.writeLine(_log);
                AML_Log.writeln(_log,getMoveClass().getMainQuery());
                AML_Log.writeLine(_log);
            	
                rs = stmt.executeQuery(getMoveClass().getMainQuery());	
            }else {
            	AML_Log.writeBlock(_log);
                AML_Log.writeLine(_log);
                AML_Log.writeln(_log,getMoveClass().getMainAllQuery());
                AML_Log.writeLine(_log);
            	 
                rs = stmt.executeQuery(getMoveClass().getMainAllQuery());
            }
            
        	boolean bFirst = true;
        	//boolean bFirst_owner    = true;
        	//boolean bFirst_delegate = true;
        	long cnt = 0;
        	long startTime = System.currentTimeMillis();
        	long startTime2 = System.currentTimeMillis();
        	
        	while(rs.next()){
        		if(bFirst) {
        			bFirst = false;
        			WLE_IO_Object.setINDEXS(rs);
        		}     		
        		//rs_proc_cnt++;
          		obj_1R = getWLEResult(conn, rs, SDWL, wc_grp_list_ccd, indexPath,maxRow);
//
          		getMoveClass().setWALInfo(obj_1R, rs);
          		
//          		// 법인고객에 대한 소유자 처리
//          		sRnmCno = rs.getString("RNMCNO");
//          		rs_owner     = null;
//	            bFirst_owner = true;
//          		
////	            AML_Log.writeln(_log,getMoveClass().getOwnerQuery(sRnmCno));
//	            rs_owner = stmt_owner.executeQuery(getMoveClass().getOwnerQuery(sRnmCno));
//          		
//	            while (rs_owner.next())
//	            {
//	                if(bFirst_owner) { bFirst_owner = false; WLE_IO_Object.setINDEXS(rs_owner); }
//	                
//	                obj_1R_owner = getWLEResult(conn, rs_owner, SDWL, wc_grp_list_ccd, indexPath,maxRow);
//
//	                getMoveClass().setWALInfo(obj_1R_owner, rs_owner); 
//	                rs_owner_proc_cnt++;
//	                
//	            }
//          		
//	            // 법인고객에 대한 대표자 처리
//	            rs_delegate     = null;
//	            bFirst_delegate = true;
//          		
//	            //AML_Log.writeln(_log,getMoveClass().getDelegateQuery(sRnmCno));
//	            rs_delegate = stmt_delegate.executeQuery(getMoveClass().getDelegateQuery(sRnmCno));
//          		
//	            while (rs_delegate.next())
//	            {
//	                if(bFirst_delegate) { bFirst_delegate = false; WLE_IO_Object.setINDEXS(rs_delegate); }
//	                
//	                obj_1R_delegate = getWLEResult(conn, rs_delegate, SDWL, wc_grp_list_ccd, indexPath,maxRow);
//	                
//	                getMoveClass().setWALInfo(obj_1R_delegate, rs_delegate);
//		            rs_delegate_proc_cnt++;
//	            }
          		
          		//if(cnt % 1000 == 0) {
          		//	long now = System.currentTimeMillis();
          		//	long elapsed = now - startTime;
          		//	long min = elapsed / 60000;
          		//	long seconds = (elapsed % 60000) / 1000;
          		//	long millis = elapsed % 1000;
//        			_log.debug("@@@@@@@@@@@@@@@ 1000 건당 소요시간 : " + millis + "초");
        			//_log.debug("@666666@@@@@@@@@@@@@@ 1000 건당 소요시간 : " + min + "분"+ seconds + "초"+ millis + "ms");

          			
//          			System.out.println("1000 건당 소요시간 : %d분 %d초 %dms", min, seconds, millis);
//          			System.out.println("@@@@@@@@@@@@@@@ 1000 건당 소요시간 : " + millis + "초");
          		//	startTime = now;
          		//}
          		//if(cnt % 10000 == 0) {
          		//	long now = System.currentTimeMillis();
          		//	long elapsed = now - startTime2;
          		//	long min = elapsed / 60000;
          		//	long seconds = (elapsed % 60000) / 1000;
          		//	long millis = elapsed % 1000;
//        			_log.debug("@@@@@@@@@@@@@@@ 1000 건당 소요시간 : " + millis + "초");
        			//_log.debug("@66666@@@@@@@@@@@@@@ 10000 건당 소요시간 : " + min + "분"+ seconds + "초"+ millis + "ms");

          			
//          			System.out.println("1000 건당 소요시간 : %d분 %d초 %dms", min, seconds, millis);
//          			System.out.println("@@@@@@@@@@@@@@@ 1000 건당 소요시간 : " + millis + "초");
        		//	startTime2 = now;
          		//}
          		//cnt++;
        	
        	}
        	stmt.close();
    		WLE_Caller.wlfSearch.close();
    		//WLE_Caller.wlfLocalSearch.close();

            AML_Log.writeLine(_log);
            AML_Log.writeln(_log, "appr info setting...");
            AML_Log.writeLine(_log);

            getMoveClass().close();

            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            AML_Log.writeln(_log,"call post process...");
            //AML_Log.writeln(_log," 고객 process 건수 : " + rs_proc_cnt);
            //AML_Log.writeln(_log,"소유자 process 건수 : " + rs_owner_proc_cnt);
            //AML_Log.writeln(_log,"대표자 process 건수 : " + rs_delegate_proc_cnt);
            AML_Log.writeLine(_log);
            getMoveClass().postProcess();
            StatementHandler.getInstance().executeAllBatch(conn,"WALB");

            logFinish(JOB_FINISH, jobId, runDatelog, 1,  "", conn);
            conn.commit();
        	
            return getMoveClass().getTotalCount();
        }else {
        	return 0;
        }

        } catch (Exception e) {
        	_log.error(e.getMessage(),e);
        	conn.rollback();
            logFinish(JOB_ERROR, jobId, runDatelog, 1,  e.getClass().getName() + ":"+ e.getMessage(), conn);
        	conn.commit();
            throw e;
        } finally {
            StatementHandler.getInstance().closeAllStatement(conn,"WALB");
            DBUtil.close(stmt);
            DBUtil.close(rs);
    		WLE_Caller.wlfSearch.close();
    		//WLE_Caller.wlfLocalSearch.close();
            if(isNewCon ) DBUtil.close(conn);
        }
    }

    public Object getQueryResult(Connection conn, String sql, String param) throws SQLException {
    	ResultSet rs = null;
    	PreparedStatement pstmt = null;
    	Object result = "";

    	try {
    		_log.debug(sql);
            _log.debug("1st param : " + param);
            pstmt = conn.prepareStatement(sql);
            pstmt.setObject(1, param);
            rs = pstmt.executeQuery();

            while (rs.next()) {
            	result = rs.getObject(1);
            }
            _log.debug("query result : " + result);

    		return result;

		} catch (Exception e) {
			_log.error(e.getMessage(),e);
            throw e;

		} finally {
			DBUtil.close(rs);
			DBUtil.close(pstmt);
		}
    }

    private void logStart(String jobId, String jobDate, int seq, int userId ,String tradeDate, String reportDate, String flag, java.sql.Connection conn) throws SQLException{
        if(logInsertSql == null)
        {
        	//JOB_ST_CD = 2 는 진행중
            logInsertSql = "INSERT INTO NIC93B_LOG ( JOB_DT,JOB_SEQ,JOB_ID, STRT_DY_TM,JOB_ST_CD,PARENT_JOBID,JOB_NM,DEPTH,DISPLAY_ORDER,LAST_YN,USE_YN,PROGRAM_NM,HNDL_DY_TM,HNDL_P_ENO,PROC_FLAG,TRADE_DT,REPORT_DT) "
             + " SELECT ?, ?, ?, GET_SYSDATE() , 2, PARENT_JOBID,JOB_NM,DEPTH,DISPLAY_ORDER,LAST_YN,USE_YN,PROGRAM_NM,HNDL_DY_TM, ?, ?, ?, ? FROM NIC93B WHERE JOB_ID=?";
        }
        StatementHandler.getInstance().executeUpdate("ALL_LOG_START", conn, logInsertSql, new Object[] { jobDate, new BigDecimal(seq), jobId, userId, flag, tradeDate, reportDate, jobId } );
        if(logInsertSqlNIC93B == null)
        {
        	//JOB_ST_CD = 2 는 진행중
            logInsertSqlNIC93B = "UPDATE NIC93B  SET  JOB_ST_CD=2,STRT_DY_TM=GET_SYSDATE(),END_DY_TM=null   WHERE JOB_ID=?";
        }
        StatementHandler.getInstance().executeUpdate("ALL_LOG_START_NIC93B", conn, logInsertSqlNIC93B, new Object[] {   jobId } );

    }

    private void logFinish(int status, String jobId, String jobDate, int seq, String msg, java.sql.Connection conn) throws SQLException{
      if(logUpdateSql == null)
      {
          logUpdateSql = "UPDATE NIC93B_LOG SET JOB_ST_CD=?,END_DY_TM=GET_SYSDATE(), DESC1=?  WHERE JOB_DT=? AND JOB_SEQ =?  ";
      }
      StatementHandler.getInstance().executeUpdate("ALL_LOG_FINISH", conn, logUpdateSql, new Object[] { new BigDecimal(status),msg, jobDate, new BigDecimal(seq) } );
      if(logUpdateSqlNIC93B == null)
      {
          logUpdateSqlNIC93B = "UPDATE NIC93B  SET  JOB_ST_CD=?,END_DY_TM=GET_SYSDATE(), DESC1=?   WHERE JOB_ID=?   ";
      }
      StatementHandler.getInstance().executeUpdate("ALL_LOG_FINISH_NIC93B", conn, logUpdateSqlNIC93B, new Object[] { new BigDecimal(status),msg,  jobId } );

  }
}
