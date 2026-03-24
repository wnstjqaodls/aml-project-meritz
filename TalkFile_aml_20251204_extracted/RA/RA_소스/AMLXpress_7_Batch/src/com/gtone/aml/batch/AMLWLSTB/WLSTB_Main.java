/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLWLSTB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.io.File;
import java.io.FileWriter;
import java.math.BigDecimal;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.gtone.aml.batch.common.AbstractBatchJobNode;
import com.gtone.aml.batch.common.Config;
import com.gtone.aml.batch.common.util.AML_Log;
import com.gtone.aml.batch.common.util.DBUtil;
import com.gtone.aml.batch.common.util.DateUtil;
import com.gtone.aml.batch.common.util.InputUtil;
import com.gtone.aml.batch.common.util.StatementHandler;
import com.gtone.aml.batch.common.util.Timer; 

/**
 *<pre>
 * WATCHLIST(요주의 인물) 추출 배치 메인 클래스
 * @en
 *</pre>
 *@author 
 *@version 1.0
 *@history 1.0
 */
/*
 * /rba/AMLExpress/AMLExpress_5_1_Batch/dist/AMLWLSTB.sh ALL $(date -d "-1 days" +%Y%m%d) BATCH NIC19B
 * 파라메터
 * 0 : 처리구분( O,ONE: 온라인, D: 일배치, M: 월(기본)배치, A: 전체대상, B: 기간배치 )
 * 1 : 배치 실행일
 * 2 : 배치 실행자 ID
 * 3 : 파일명
 * 4 : 기간배치 - 시작일
 * 5 : 기간배치 - 종료일
 * */
public class WLSTB_Main  extends  AbstractBatchJobNode{
    public static final String WLSTB_ID      = "WLSTB";
    public static final String FILE_EXT      = "dat";
    public static final String TEMP_FILE_EXT = "tmp";
    
    private static Log _log = LogFactory.getLog(WLSTB_Main.class);
    
    String logInsertSql = null;
    String logUpdateSql = null;
    String logUpdateSqlNIC93B = null;
    String logInsertSqlNIC93B = null;
    
    public static void main(String[] args) {
        try {
        	//호출 시 필수 args의 개수
            int nArgsLength = 3;
            
            WLSTB_Main main = new WLSTB_Main( );
            
            String strProcFlag = InputUtil.getArgumentValue(args, 0);
            //처리구분( O,ONE: 온라인, D: 일배치, M: 월(기본)배치, A: 전체대상, B: 기간배치 )
            if("A".equalsIgnoreCase(strProcFlag.substring(0, 1))) {
            	main.setProcFlag("ALL");
            } else {
            	main.setProcFlag(strProcFlag.substring(0, 1));
            }
            
            main.setTradeDate(InputUtil.getArgumentValue(args, 1));
            main.setReportDate(InputUtil.getArgumentValue(args, 1));
            main.setUserId(InputUtil.getArgumentValue(args, 2));
                        
            //기간배치 - 시작, 종료일 추가 20220419
            if("B".equalsIgnoreCase(strProcFlag.substring(0, 1))){
            	nArgsLength+=2;
                main.setTradeDate(InputUtil.getArgumentValue(args, 3));
                main.setTradeEndDate(InputUtil.getArgumentValue(args, 4));
            } 
            
            String[] extraArgs = null;
            if(args.length > nArgsLength)
            {
                extraArgs = new String[(args.length - nArgsLength)];
                System.arraycopy(args, nArgsLength, extraArgs, 0, (args.length - nArgsLength));
            }
            
            main.execute( extraArgs );
            
        } catch (Exception e) {
            _log.error(e.getMessage(), e);
        }
    }
    
    public WLSTB_Main() { 
    	WLSTB_Input input = new WLSTB_Input();
    	super.setInputUtil(input);
    }
    
    /**
     *<pre>
     * WATCHLIST(요주의 인물) 추출 배치 실행
     * @en
     *</pre>
     *@param args
     *@return    추출건수
     *           抽出件数
     *@en
     *@throws Exception
     */
    public long execute(String[] args) throws Exception {
        long startTime = Timer.getInstance().start();
        long totalCount = 0;
        try {
            Timer.getInstance().start();
            inputObj.initializeInput(args);
            
            displaySetting();
            totalCount =  statWLST(startTime);
        } catch (Exception e) {
            _log.error("Exception : " + e.getMessage());
            throw e;
        } finally {
            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            Timer.getInstance().stopAndPrintInfo(_log,"AMLWLSTB Total Elapsed Time", startTime);
            AML_Log.writeLine(_log);
        }
        return totalCount;
    }
 
    /**
     * display current setting
     *@throws Exception
     */
    @SuppressWarnings("deprecation")
    private void displaySetting() throws Exception {
        Config config = Config.getInstance();
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log,"AMLWLSTB Pgm Start (" + DateUtil.getTimeStampString() + ")");
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log,"## DB_DRIVER 		 : [" + config.getDB_DRIVER() 		+ "]");
        AML_Log.writeln(_log,"## DB_URL    		 : [" + config.getDB_URL() 			+ "]");
        AML_Log.writeln(_log,"## DB_ID     		 : [" + config.getDB_ID() 			+ "]");
        AML_Log.writeln(_log,"## DB_PW       	 : [" + (config.isLOG_DEBUG() ? config.getDB_PW() : "**********") + "]");
        AML_Log.writeln(_log,"");
        AML_Log.writeln(_log,"## LOG_Path        : [" + config.getLOG_Path() 		+ "]");
        AML_Log.writeln(_log,"## LOG_MODE_DEBUG  : [" + config.isLOG_DEBUG()		+ "]");
        AML_Log.writeln(_log,"## LOG_To_File     : [" + config.isLOG_2_FILE() 		+ "]");
        AML_Log.writeln(_log,"");
        AML_Log.writeln(_log,"## AML_WAS_IP      : [" + config.getAMLWasIP() 		+ "]");
        AML_Log.writeln(_log,"## AML_WAS_PORT    : [" + config.getAMLWasPort() 		+ "]");
        AML_Log.writeln(_log,"## AML_WAS_CONTEXT : [" + config.getAMLWasContext()	+ "]");
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log,"## ProcFlag 		 : [" + inputObj.getProcFlag() 		+ "]");
        AML_Log.writeln(_log,"## WorkDate 		 : [" + inputObj.getReportDate() 	+ "]");
        AML_Log.writeln(_log,"## FacStartDate    : [" + inputObj.getTradeDate() 	+ "]");
        AML_Log.writeln(_log,"## FacEndDate 	 : [" + inputObj.getTradeEndDate() 	+ "]");
        AML_Log.writeln(_log,"## UserId   		 : [" + inputObj.getUserId() 		+ "]");
        AML_Log.writeln(_log,"## ExtraArgs[1] 	 : [" + inputObj.getExtraArgs()[0]  + "]");
        AML_Log.writeLine(_log);
    }
    
    
    /**
     * <pre>
     * @en
     * </pre>
     *@param startTime
     *@return
     *@throws Exception
     */
    private long statWLST(long startTime) throws Exception {
        Config config = Config.getInstance();
        
        int nDataFetchSize = 0;
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        //배치로그 NIC93B,NIC93B_LOG 추가
        String jobId = "B40012"; // Watchlist 검색결과
        String runDatelog = DateUtil.getShortTimeStampString();
        int userId = inputObj.getUserId();
        String tradeDate = inputObj.getTradeDate();
        String reportDate = inputObj.getReportDate();
        String flag = "ALL";
        
        int JOB_FINISH = 1; //정상코드
        int JOB_ERROR = 9;  //오류코드
        
        String sFileRec = null; 
        String sFilePath = config.getProperty("ACCNT_SEND_FILE_PATH");
               sFilePath = sFilePath.replace("/", (String)System.getProperty("file.separator"));
        String sFileName = inputObj.getExtraArgs()[0] + "_" + inputObj.getTradeDate();
        String sFileExt = "";
        
        String sTmpFilePath = "";
        String sSqlCont = "";
        
        //폴더
        File fFile = new File(sFilePath);
        if(!fFile.isDirectory()) {
        	fFile.mkdirs();
        }
        
        //임시 파일생성
        sFileExt = "";
        sFileExt = sFileExt.concat(".").concat(TEMP_FILE_EXT);
        fFile = File.createTempFile(sFileName, sFileExt, fFile);
        //임시 파일 삭제여부 확인을 위해
        sTmpFilePath = fFile.getPath();
        
        FileWriter fw = new FileWriter(fFile);
        
        try {
            Timer.getInstance().stopAndPrint(_log,"AMLWLSTB Total Elapsed Time", startTime);
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            
            nDataFetchSize = 0;
            
            logStart(jobId, runDatelog, 1, userId,  tradeDate,   reportDate,   flag, conn );
            conn.commit();
            
            Timer.getInstance().stopAndPrint(_log,"AMLWLSTB Total Elapsed Time", startTime);
            
            PreparedStatement psmt = null;
            if("M".equalsIgnoreCase(inputObj.getProcFlag())){ // 일배치
				sSqlCont = WLSTB_Sql.WLSTB_SELECT_NIC19B_M;
				psmt = conn.prepareStatement(sSqlCont);
			    psmt.setObject(1, inputObj.getTradeDate());
			    psmt.setObject(2, inputObj.getTradeDate());			    
			} else if("B".equalsIgnoreCase(inputObj.getProcFlag())) { // 기간배치
				sSqlCont = WLSTB_Sql.WLSTB_SELECT_NIC19B_B;
				psmt = conn.prepareStatement(sSqlCont);
			    psmt.setObject(1, inputObj.getTradeDate());
			    psmt.setObject(2, inputObj.getTradeEndDate());
			    psmt.setObject(3, inputObj.getTradeDate());
			    psmt.setObject(4, inputObj.getTradeEndDate());
			} else{
				sSqlCont = WLSTB_Sql.WLSTB_SELECT_NIC19B_ALL;
				psmt = conn.prepareStatement(sSqlCont);
			}
            
            _log.info(sSqlCont);
            AML_Log.writeBlock(_log);
            
            rs = psmt.executeQuery();
            if( rs != null
            		&& rs.getFetchSize() > 0) {
            	sFileRec = null;
            	
	            while (rs.next()) {
	            	sFileRec = rs.getString(1);
	            	fw.append(sFileRec).append("\r\n");
	            	fw.flush();
	            	
	            	nDataFetchSize++;
	            	if(nDataFetchSize%1000 == 0){
	            		_log.debug("nDataFetchSize = " + nDataFetchSize);
	            	}
	            }
	            fw.close();
	            
	            //작성파일명으로 변경
	            if(nDataFetchSize > 0) {
		            sFileExt = "";
		            sFileExt = sFileExt.concat(".").concat(FILE_EXT);
		            fFile.renameTo(new File(sFilePath, sFileName.concat(sFileExt)));
	            }
            }
            logFinish(JOB_FINISH, jobId, runDatelog, 1,  "건수 : " + nDataFetchSize, conn);
            conn.commit();
            return nDataFetchSize;
        } catch (Exception e) {
            _log.error(e);
            AML_Log.writeBlock(_log);
            logFinish(JOB_ERROR, jobId, runDatelog, 1, e.getClass().getName() + ":"+ e.getMessage(), conn);
            throw e;
        } finally {
        	if(fw != null) { fw.close(); }
        	
        	//임시 파일이 있을 경우
        	fFile = new File(sTmpFilePath);
        	if(fFile.exists()) { fFile.delete(); }
        	
        	DBUtil.close(rs);
            DBUtil.close(stmt);
            DBUtil.close(conn);
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
