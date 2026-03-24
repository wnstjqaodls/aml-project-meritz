/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLKRAB;

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
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

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
 * <pre>
 * KYC RA  배치의 메인 class
 * KYC RAバッチのメインクラス
 * @en
 * </pre>
 *
 * @author syk, hikim
 * @version 1.0
 * @history 1.0 2010-09-30
 */
public class KRAB_Main extends AbstractBatchJobNode {
    public String KRAB_ID = "KRAB";
    public static final int DATA_BLOCK_SIZE = Config.getInstance().getKRADataBlockSize();

    private static Log _log = LogFactory.getLog(KRAB_Main.class);

    private static String BASE_DT = "";
    
    String logInsertSql = null;
    String logUpdateSql = null;
    String logUpdateSqlNIC93B = null;
    String logInsertSqlNIC93B = null;

    String logRaStartSql = null;
    String logRaFinishSql = null;
    String logRaUpdateSqlNIC93B = null;

    public static void main(String[] args) {
    	Connection conn = null;
    	PreparedStatement pstmtDate = null;
    	ResultSet rsDate = null;
    	
    	//PreparedStatement pstmtPrev = null;
        //ResultSet rsPrev = null;
        //int waitCount = 0;
        //boolean bExistDateList = false;
    	
    	try {
    		//호출 시 필수 args의 개수
            int nArgsLength = 3;
    		
            KRAB_Main main = new KRAB_Main();
            
            BASE_DT = InputUtil.getArgumentValue(args, 0)==null?DateUtil.getShortTimeStampString().substring(0,8):InputUtil.getArgumentValue(args, 1);	/* Control_M 등록시 주석 풀어야 */
            conn = DBUtil.getConnection();
            pstmtDate = conn.prepareStatement(KRAB_Sql.getInstance().KRAB_SELECT_RUN_DATE());
            pstmtDate.setString(1, BASE_DT);
            rsDate = pstmtDate.executeQuery();	
            
            
			
            while( rsDate.next()) {
            	String KRCNT = rsDate.getString("KRCNT");
            	
            	if(KRCNT.equals("Y")){
            		//처리구분( ONE: 개인, ALL: 전체, MTH: 최근3개월 )
                    main.setProcFlag  (InputUtil.getArgumentValue(args, 0)); // Flag
                    main.setReportDate(InputUtil.getArgumentValue(args, 1)); // 기준일
                    main.setTradeDate (InputUtil.getArgumentValue(args, 1)); // 보고일
                    main.setUserId    (InputUtil.getArgumentValue(args, 2)); // USER_ID
                    
                    String[] extraArgs = null;
        			if(args.length > nArgsLength)
        			{
        				extraArgs = new String[(args.length - nArgsLength)];
        				System.arraycopy(args, nArgsLength, extraArgs, 0, (args.length - nArgsLength));
        			}
        			main.execute(extraArgs);
            	}else {
            		AML_Log.writeln(_log,"오늘 ["+BASE_DT+"] 영업일대응일이 아닙니다.");
            	}
            }
        } catch (Exception e) {
            _log.error(e.getMessage(),e);
        }
    }

    public KRAB_Main(java.sql.Connection conn) {
        this();
        this.con = conn;
        isNewCon = false;

    }

    public KRAB_Main() {
        KRAB_Input input = new KRAB_Input();
        String runDate = DateUtil.getDate();
        input.setRunDate(runDate);
        super.setInputUtil(input);
        isNewCon = true;
    }

	/**
     * <pre>
     * KYC RA 배치 실행
     * KYC RAバッチを実行
     * @en
     * </pre>
     *
     * @param args
     *            추가 parameter , flag가 ONE일 때 고객ID 追加パラメータ、flagがONEの場合顧客ID
     * @en
     * @return 배치 실행한 고객 건수 バッチを実行した顧客件数
     * @en
     * @throws Exception
     */
    public long execute(String[] args) throws Exception {
        long startTime = Timer.getInstance().start();
        long totalCount = 0;
        try {

            KRAB_ID = "KRAB";
            Timer.getInstance().start();
            inputObj.initializeInput(args);
            displaySetting();
            totalCount = statScoring();
        } catch (Exception e) {
            _log.error(e);
            throw e;
        } finally {
            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            @SuppressWarnings("unused")
            long endTime = Timer.getInstance().stopAndPrintInfo(_log, "AMLKRAB Total Elapsed Time", startTime);

            AML_Log.writeLine(_log);
        }
        return totalCount;
    }

    @SuppressWarnings("deprecation")
    private void displaySetting() throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException, NoSuchProviderException {
        Config config = Config.getInstance();
        AML_Log.writeLine(_log);
        AML_Log.writelnInfo(_log, "AMLKRAB Pgm Start (" + DateUtil.getTimeStampString() + ")");
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log, "## DB_DRIVER                          : [" + config.getDB_DRIVER() + "]");
        AML_Log.writeln(_log, "## DB_URL                             : [" + config.getDB_URL() + "]");
        AML_Log.writeln(_log, "## DB_ID                              : [" + config.getDB_ID() + "]");
        AML_Log.writeln(_log, "## DB_PW                              : [" + (config.isLOG_DEBUG() ? config.getDB_PW() : "**********") + "]");
        AML_Log.writeln(_log, "");
        AML_Log.writeln(_log, "## LOG_Path                           : [" + config.getLOG_Path() + "]");
        AML_Log.writeln(_log, "## LOG_MODE_DEBUG                     : [" + config.isLOG_DEBUG() + "]");
        AML_Log.writeln(_log, "## LOG_To_File                        : [" + config.isLOG_2_FILE() + "]");
        AML_Log.writeln(_log, "");
        AML_Log.writeln(_log, "## ProcFlag                           : [" + inputObj.getProcFlag() + "]");
        AML_Log.writeln(_log, "## WorkDate                           : [" + inputObj.getReportDate() + "]");
        AML_Log.writeln(_log, "## UserId                             : [" + inputObj.getUserId() + "]");
        AML_Log.writeLine(_log);
        AML_Log.writeln(_log, "## DATA_BLOCK_SIZE                    : [" + DATA_BLOCK_SIZE + "]");
        AML_Log.writeln(_log, "## COMMIT_EACH_DATA_BLOCK_COMPLETED   : [" + Config.getInstance().getKRACommitEachDataBlockCompleted() + "]");
        AML_Log.writeLine(_log);
    }

    private KRAB_MoveAbstract m_MoveClass = null;

    /**
     * <pre>
     * KRA2B_MoveAbstract를 상속받은 class instance, AMLBATCH.ini의 KRA_MOVE_CLASS의 값
     * KRA2B_MoveAbstractを承継したclass instance、AMLBATCH.iniのKRA_MOVE_CLASSの値
     * @en
     * </pre>
     *
     * @return
     * @throws ClassNotFoundException
     * @throws IllegalAccessException
     * @throws InstantiationException
     */
    public KRAB_MoveAbstract getMoveClass() throws InstantiationException, IllegalAccessException, ClassNotFoundException {
        if (m_MoveClass == null) {
            m_MoveClass = (KRAB_MoveAbstract) Class.forName(
                    Config.getInstance().getKRAMoveClassName()).newInstance();
            m_MoveClass.setInputParam((KRAB_Input) inputObj);
        }
        return m_MoveClass;
    }

    /**
     * scoring
     *
     * @return 배치 실행 고객 수 バッチ実行顧客数
     * @en
     * @throws Exception
     */
    private long statScoring() throws Exception {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        long totalCount = 0;

        //String jobId = "A10R20";
        String jobId = "B40002";
        String runDatelog = DateUtil.getShortTimeStampString();
        int userId = inputObj.getUserId();

        String tradeDate = inputObj.getTradeDate();
        String reportDate = inputObj.getReportDate();
        String flag = "";

        int JOB_FINISH = 1; //정상코드
        int JOB_ERROR = 9;  //오류코드

        String SEQ = "0";	//RA_ID

        try {
            super.inputObj.chkLicense("KYC");
            conn = getDBConnection(Config.getInstance().getKRACommitEachDataBlockCompleted());

            stmt = conn.createStatement();
            stmt.executeQuery("ALTER SESSION SET DB_FILE_MULTIBLOCK_READ_COUNT= 256");
            logStart(jobId, runDatelog, 1, userId,  tradeDate,   reportDate, flag, conn );
            conn.commit();
            
            getMoveClass().initialize(conn);

            String sql = KRAB_Sql.getInstance().KRAB_SELECT_RA_WORK_INFO_001();
            SEQ = getQueryResult(conn, sql).toString();

            inputObj.setRaID(SEQ);

            //logStart(jobId, runDatelog, 1, userId,  tradeDate,   reportDate, flag, conn );
            //conn.commit(); 

            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            AML_Log.writeln(_log, "call pre process...");
            AML_Log.writeLine(_log);
            getMoveClass().preProcess();

            
            if("MTH".equals(inputObj.getProcFlag())) {
            	// select customer's info
                AML_Log.writeBlock(_log);
                AML_Log.writeLine(_log);
                AML_Log.writeln(_log, getMoveClass().getMainQuery(inputObj.getProcFlag()));
                AML_Log.writeLine(_log);
                Timer.getInstance().start();

            	pstmt = conn.prepareStatement(getMoveClass().getMainQuery(inputObj.getProcFlag()));
            	pstmt.setString(1, inputObj.getRaID());
            	pstmt.setString(2, "I");  // I : I모델
            	pstmt.setString(3, "B"); // B : B모델
            	pstmt.setString(4, inputObj.getRaID());
            	pstmt.setString(5, inputObj.getRaID());
            	pstmt.setString(6, inputObj.getReportDate());
                rs = pstmt.executeQuery();

                Timer.getInstance().stopAndPrint(_log, "\t>> MainQuery Open Elapsed Time");
            }else if("ALL".equals(inputObj.getProcFlag())){
            	// select customer's info
                AML_Log.writeBlock(_log);
                AML_Log.writeLine(_log);
                AML_Log.writeln(_log, getMoveClass().getMainAllQuery(inputObj.getProcFlag()));
                AML_Log.writeLine(_log);
                Timer.getInstance().start();
                
                pstmt = conn.prepareStatement(getMoveClass().getMainAllQuery(inputObj.getProcFlag()));
            	pstmt.setString(1, inputObj.getRaID());
            	pstmt.setString(2, "I");  // I : I모델
            	pstmt.setString(3, "B"); // B : B모델
            	pstmt.setString(4, inputObj.getRaID());
            	pstmt.setString(5, inputObj.getRaID());
            	pstmt.setString(6, inputObj.getReportDate());
                rs = pstmt.executeQuery();
                
                Timer.getInstance().stopAndPrint(_log, "\t>> MainQuery Open Elapsed Time");
            }
            
     		while (rs.next()) {
                AML_Log.writeBlock(_log);
                getMoveClass().setKRA_Info(rs);
            }

            DBUtil.close(rs);
            getMoveClass().close();

            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            AML_Log.writeln(_log, "call post process...");
            AML_Log.writeLine(_log);
            
            
            getMoveClass().postProcess();
            getMoveClass().close();
            StatementHandler.getInstance().executeAllBatch(conn, KRAB_ID);

            logFinish(JOB_FINISH, jobId, runDatelog, 1,  "", conn);
            conn.commit();

            totalCount = getMoveClass().getTotalCount();
            getMoveClass().getTotalCount();
        }catch (Exception e) {
        	_log.error(e);
        	conn.rollback();
        	logFinish(JOB_ERROR, jobId, runDatelog, 1,  e.getClass().getName() + ":"+ e.getMessage(), conn);
        	conn.commit();
        }finally {
            closeCommStmt(conn);
            DBUtil.close(rs);
            DBUtil.close(stmt);
            DBUtil.close(pstmt);
            if (isNewCon)
                DBUtil.close(conn);
        }
        return totalCount;
    }

    /**
     * <pre>
     * StatementHandler를 통해 open한 Statement를 close함.
     * StatementHandlerでオープンしたStatementをクローズする。
     * @en
     * </pre>
     */
    public void closeCommStmt(java.sql.Connection conn) {
        StatementHandler.getInstance().closeAllStatement(conn, KRAB_ID);
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

    public Object getQueryResult(Connection conn, String sql) throws SQLException {
    	ResultSet rs = null;
    	PreparedStatement pstmt = null;
    	Object result = "";

    	try {
    		_log.debug(sql);
            pstmt = conn.prepareStatement(sql);
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

}
