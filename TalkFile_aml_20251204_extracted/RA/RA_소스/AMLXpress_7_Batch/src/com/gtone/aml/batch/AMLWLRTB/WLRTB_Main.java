/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLWLRTB;

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

import com.gtone.aml.batch.AMLKYEB.KYEB_Input;
import com.gtone.aml.batch.AMLKYEB.KYEB_MoveAbstract;
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
 * WATCHLIST(요주의 인물) 결과 추출 배치 메인 클래스
 * @en
 *</pre>
 *@author 
 *@version 1.0
 *@history 1.0
 */
public class WLRTB_Main  extends  AbstractBatchJobNode{
    public static final String WLRTB_ID      = "WLRTB"; 
    public static final String FILE_EXT      = "dat";
    public static final String TEMP_FILE_EXT = "tmp";
    
    private static Log _log = LogFactory.getLog(WLRTB_Main.class);
    
    String logInsertSql = null;
    String logUpdateSql = null;
    String logUpdateSqlNIC93B = null;
    String logInsertSqlNIC93B = null;
    
    public static void main(String[] args) {
        try {
        	//호출 시 필수 args의 개수
            int nArgsLength = 3;
            
            WLRTB_Main main = new WLRTB_Main( );
            
            main.setProcFlag(InputUtil.getArgumentValue(args, 0));
            main.setTradeDate(InputUtil.getArgumentValue(args, 1));
            //main.setReportDate(InputUtil.getArgumentValue(args, 1));
            main.setReportDate(DateUtil.addDays(InputUtil.getArgumentValue(args, 1),-1));
            main.setUserId(InputUtil.getArgumentValue(args, 2));
                        
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
    
    public WLRTB_Main() { 
    	WLRTB_Input input = new WLRTB_Input();
    	super.setInputUtil(input);
    }
    
    /**
     *<pre>
     * WATCHLIST(요주의 인물) 결과 추출 배치 실행
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
            totalCount = statWLRT(startTime);
        } catch (Exception e) {
        	AML_Log.writeln(_log,"Exception : " + e.getMessage());
            throw e;
        } finally {
            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            Timer.getInstance().stopAndPrintInfo(_log,"AMLWLRTB Total Elapsed Time", startTime);
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
        AML_Log.writeln(_log,"AMLWLRTB Pgm Start (" + DateUtil.getTimeStampString() + ")");
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
        AML_Log.writeln(_log,"## TradeDate 		 : [" + inputObj.getTradeDate() 	+ "]");
        AML_Log.writeln(_log,"## ReportDate      : [" + inputObj.getReportDate() 	+ "]");
        AML_Log.writeln(_log,"## UserId   		 : [" + inputObj.getUserId() 		+ "]");
        AML_Log.writeln(_log,"## ExtraArgs[1] 	 : [" + inputObj.getExtraArgs()[0]  + "]");
        AML_Log.writeln(_log,"## ExtraArgs[2]    : [" + inputObj.getExtraArgs()[1]  + "]");
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
    private long statWLRT(long startTime) throws Exception {
        Config config = Config.getInstance();
        
        int nDataFetchSize = 0;
        
        Connection conn = null;
        PreparedStatement psmt = null, upPsmt = null;
        ResultSet rs = null;

        //배치로그 NIC93B,NIC93B_LOG 추가
        String jobId = "B40011"; // Watchlist 검색결과
        String runDatelog = DateUtil.getShortTimeStampString();
        int userId = inputObj.getUserId();
        String tradeDate = inputObj.getTradeDate();
        String reportDate = inputObj.getReportDate();
        String flag = "ALL";
        
        int JOB_FINISH = 1; //정상코드
        int JOB_ERROR = 9;  //오류코드
        String errorName = null;
        
        
        
        String sDataFg = "";
        String sFileRec = ""; 
        String sFilePath = config.getProperty("ACCNT_SEND_FILE_PATH");
               sFilePath = sFilePath.replace("/", (String)System.getProperty("file.separator"));
        String sFileNameNic21 = inputObj.getExtraArgs()[0] + "_" + inputObj.getTradeDate();
        String sFileNameNic22 = inputObj.getExtraArgs()[1] + "_" + inputObj.getTradeDate();
        String sFileExt = "";
        
        String sTmpFilePathNic21 = "", sTmpFilePathNic22 = "";
        String sSqlCont = "";
        
        //폴더
        File fFile = new File(sFilePath);
        if(!fFile.isDirectory()) {
        	fFile.mkdirs();
        }
        
        //임시 파일생성(NIC21B, NIC22B)
        sFileExt = "";
        sFileExt = sFileExt.concat(".").concat(TEMP_FILE_EXT);
        File fFileNic21 = File.createTempFile(sFileNameNic21, sFileExt, fFile);
        File fFileNic22 = File.createTempFile(sFileNameNic22, sFileExt, fFile);
        //임시 파일 삭제여부 확인을 위해
        sTmpFilePathNic21 = fFileNic21.getPath();
        sTmpFilePathNic22 = fFileNic22.getPath();
        
        FileWriter fwNic21 = new FileWriter(fFileNic21);
        FileWriter fwNic22 = new FileWriter(fFileNic22);
        
        try {
            AML_Log.writeLine(_log);
            Timer.getInstance().stopAndPrint(_log,"AMLWLRTB Total Elapsed Time", startTime);
            AML_Log.writeLine(_log);
            AML_Log.writeBlock(_log);
            
            //배치 시작 전 NIC93B, NIC93B_LOG INSERT

            nDataFetchSize = 0;

            conn = DBUtil.getConnection();
            logStart(jobId, runDatelog, 1, userId,  tradeDate,   reportDate,   flag, conn );
            conn.commit();
            
            
            //추출대상
            sSqlCont = WLRTB_Sql.WLRTB_SELECT_NIC2XB_001;
            psmt = conn.prepareStatement(sSqlCont);
            psmt.setObject(1, inputObj.getReportDate());
            
            _log.info(sSqlCont);
            AML_Log.writeBlock(_log);
            
            //추출대상여부 설정
            sSqlCont = WLRTB_Sql.WLRTB_UPDATE_NIC21B_001;
            upPsmt = conn.prepareStatement(sSqlCont);

            _log.info(sSqlCont);
            AML_Log.writeLine(_log);
            
            rs = psmt.executeQuery();
            if(rs != null) {
            	sDataFg = "";
            	sFileRec = "";
            	
	            while (rs.next()) {
	            	sDataFg = rs.getString(1);     /* 자료구분 */
	            	sFileRec = rs.getString(2);    /* 작성할 자료 */
	            	
	            	if("NIC21".equalsIgnoreCase(sDataFg)) {
	            		fwNic21.append(sFileRec).append("\r\n");
	            		fwNic21.flush();
	            		
	            		// 작성한 자료에 대하여 전송정보를 설정
	            		// 3: 검색결과일자, 4: 일련번호
	            		upPsmt.setObject(1, getInputObj().getReportDate());
	            		upPsmt.setObject(2, rs.getString(3)             );
	            		upPsmt.setObject(3, rs.getString(4)             );
	            		
	            		AML_Log.writeLine(_log);
	            		_log.info("처리 대상: ETC2=[" + getInputObj().getReportDate() + "], SRCH_RSLT_DT=[" + rs.getString(3) + "], SQ=["+ rs.getString(4) + "]");
	                    AML_Log.writeBlock(_log);
	            		AML_Log.writeLine(_log);
	            		
	            		upPsmt.executeQuery();
	            		
	            		nDataFetchSize++;
	            	}
	            	else if("NIC22".equalsIgnoreCase(sDataFg)) {
	            		fwNic22.append(sFileRec).append("\r\n");
	            		fwNic22.flush();
	            	}
	            }
	            fwNic21.close();
	            fwNic22.close();
	            
	            //작성파일명으로 변경
	            if(nDataFetchSize >= 0) {
		            sFileExt = "";
		            sFileExt = sFileExt.concat(".").concat(FILE_EXT);
		            fFileNic21.renameTo(new File(sFilePath, sFileNameNic21.concat(sFileExt)));
		            fFileNic22.renameTo(new File(sFilePath, sFileNameNic22.concat(sFileExt)));
	            }
            }
            logFinish(JOB_FINISH, jobId, runDatelog, 1,  "건수 : " + nDataFetchSize, conn);
            conn.commit();
            //Watchlist Result 전송결과 적용
            return nDataFetchSize;
        } catch (Exception e) {
        	_log.error(e.getMessage(),e);
        	conn.rollback();
        	logFinish(JOB_ERROR, jobId, runDatelog, 1, e.getClass().getName() + ":"+ e.getMessage(), conn);
            throw e;
        } finally {        	
        	if(fwNic21 != null) { fwNic21.close(); }
        	if(fwNic22 != null) { fwNic22.close(); }
        	
        	//임시 파일이 있을 경우(NIC21B, NIC22B)
        	fFile = new File(sTmpFilePathNic21);
        	if(fFile.exists()) { fFile.delete(); }
        	fFile = new File(sTmpFilePathNic22);
        	if(fFile.exists()) { fFile.delete(); }
        	conn.commit();
        	DBUtil.close(rs);
        	DBUtil.close(psmt);
        	DBUtil.close(upPsmt);
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
