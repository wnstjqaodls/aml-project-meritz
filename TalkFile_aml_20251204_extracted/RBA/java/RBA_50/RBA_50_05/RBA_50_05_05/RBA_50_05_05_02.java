/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_05;

import java.util.HashMap;
import java.util.List;

import org.omg.CORBA.UserException;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 부서별 위험평가 현황 관리 메일전송화면
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-07-31
 */
public class RBA_50_05_05_02 extends GetResultObject {

	private static RBA_50_05_05_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_05_01
	*/
	public static  RBA_50_05_05_02 getInstance() {
		synchronized(RBA_50_05_05_02.class) {  
			if (instance == null) {
				instance = new RBA_50_05_05_02();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 부서 지점담당자 , 지점책임자 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_05_02_doSearch", input);
		
			if (output.getCount("USER_ID") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	/**
	* <pre>
	* 평가 마감처리
	* </pre>
	* @param input
	* @return
	*/
	public DataObj mailSend(DataObj input) throws UserException {

		DataObj output = new DataObj();
//		DataObj output2 = new DataObj();

		try {
			
			String MAIL_CNTNT ="";
			String MAIL_SBJ ="";
			String EMAIL="";
			
			
			int totCnt = 0; 
			int failCnt = 0;
			String returnMsg ="";
			String failList="";
			
			//MailService ms = new MailService();
			
			if(input.get("MAIL_CNTNT") != null) {
				MAIL_CNTNT = input.get("MAIL_CNTNT").toString();	
			}
			
			if(input.get("MAIL_SBJ") != null) {
				MAIL_SBJ = input.get("MAIL_SBJ").toString();	
			}
			
            List gdReq = (List)input.get("gdReq");
            
            totCnt = gdReq.size();
            String brTag = "&lt;br/&gt;";
            MAIL_CNTNT =MAIL_CNTNT.replaceAll(System.getProperty("line.separator"), brTag);
            MAIL_CNTNT = MAIL_CNTNT.replaceAll("\n", brTag);
            MAIL_CNTNT = MAIL_CNTNT.replaceAll("\r\n", brTag);
            
            
            for(int i=0; i<totCnt; i++){
                HashMap map = (HashMap)gdReq.get(i);
                EMAIL = map.get("EMAIL").toString();
               // String RESULT = ms.SendRequest_RBA("[AML/RBA시스템]", "AML/RBA@meritz.co.kr", EMAIL, "", MAIL_CNTNT, MAIL_SBJ, "");
                /*if("Fail".equals(RESULT) ) {
                	failCnt += 1;
                	failList = failList+map.get("USER_NM")+"("+map.get("LOGIN_ID")+") "+map.get("EMAIL")+",";
                }*/
            }
            returnMsg = "총 "+totCnt+"건 메일발송 중 "+failCnt+"건 실패하였습니다.  "; 
            if(!"".equals(failList)) {
            	returnMsg = returnMsg + "실패건:" +failList.substring(0,failList.length()-1);
            }
                
			output.put("ERRMSG", returnMsg);
			output.put("WINMSG", returnMsg);
			output.put("ERRCODE", "00000");

		} catch (RuntimeException ex) {
			Log.logAML(Log.ERROR, this, "mailSend", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} catch (Exception ex) {
			Log.logAML(Log.ERROR, this, "mailSend", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

}