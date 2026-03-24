/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.batch.AMLDATAB;

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


public class DATAB_Main  extends  AbstractBatchJobNode{
    public static final String DATAB_ID      = "DATAB";
    
    private static Log _log = LogFactory.getLog(DATAB_Main.class);
    
    public static void main(String[] args) {
        try {
            
            DATAB_Main main = new DATAB_Main( );
            
            main.setProcFlag(InputUtil.getArgumentValue(args, 0));
            main.setTradeDate(InputUtil.getArgumentValue(args, 1));
            main.setReportDate(InputUtil.getArgumentValue(args, 1));
            main.setUserId(InputUtil.getArgumentValue(args, 2));
                        
            main.execute(args);
        } catch (Exception e) {
            _log.error(e.getMessage(), e);
        }
    }
    
    public DATAB_Main() { 
    	DATAB_Input input = new DATAB_Input();
    	super.setInputUtil(input);
    }
    
    /**
     *<pre>
     * 운영초기데이터 적재
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
            totalCount =  statDATA(startTime);
        } catch (Exception e) {
            _log.error("Exception : " + e.getMessage());
            throw e;
        } finally {
            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            Timer.getInstance().stopAndPrintInfo(_log,"DATAB Total Elapsed Time", startTime);
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
        AML_Log.writeln(_log,"AMLDATAB Pgm Start (" + DateUtil.getTimeStampString() + ")");
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
        AML_Log.writeln(_log,"## TradeDate       : [" + inputObj.getTradeDate() 	+ "]");
        AML_Log.writeln(_log,"## UserId   		 : [" + inputObj.getUserId() 		+ "]");
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
    private long statDATA(long startTime) throws Exception {
        Config config = Config.getInstance();
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sSqlCont = "";
        try {
            Timer.getInstance().stopAndPrint(_log,"AMLDATAB Total Elapsed Time", startTime);
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            AML_Log.writeBlock(_log);
            AML_Log.writeLine(_log);
            
            Timer.getInstance().stopAndPrint(_log,"AMLDATAB Total Elapsed Time", startTime);
            
            PreparedStatement psmt = null;
            
            DATAB_Sql.insertDATA();
            
            AML_Log.writeBlock(_log);
            
        } catch (Exception e) {
            _log.error(e);
            AML_Log.writeBlock(_log);
            throw e;
        } finally {
        	DBUtil.close(rs);
            DBUtil.close(stmt);
            DBUtil.close(conn);
        }
		return startTime;
    }
    
    
}
