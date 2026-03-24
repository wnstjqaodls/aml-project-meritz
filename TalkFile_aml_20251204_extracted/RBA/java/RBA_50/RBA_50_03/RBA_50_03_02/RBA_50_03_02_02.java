/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_03.RBA_50_03_02;


import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.user.SessionAML;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 위험평가지표관리 팝업
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-24
 */
public class RBA_50_03_02_02 extends GetResultObject {

	private static RBA_50_03_02_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_03_02_02
	*/
	public static  RBA_50_03_02_02 getInstance() {
		synchronized(RBA_50_03_02_02.class) {  
			if (instance == null) {
				instance = new RBA_50_03_02_02();
			}
		}
		return instance;
	}

	
	/**
	* <pre>
	* 위험평가지표 팩터조회
	* </pre>
	* @param input
	* @return
	*/
	
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_03_02_02_doSearch", input);
		
			if (output.getCount("BAS_YYMM") > 0) {
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
	
	
	public DataObj doSearchGJ(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_03_02_02_doSearchGJ", input);
		
			if (output.getCount("GYLJ_SER") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				/*
				 * output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001",
				 * input.getText("LANG_CD"), "조회된 정보가 없습니다.")); output.put("WINMSG"
				 * ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"),
				 * "조회된 정보가 없습니다."));
				 */
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
	
	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;
		SessionAML sess = (SessionAML) input.get("SessionAML");
		String loginId	= sess.getSessionHelper().getLoginId();
		input.put("LOGIN_ID", loginId);

		try {
			output = MDaoUtilSingle.getData("RBA_50_03_02_02_doSearch2", input);
		
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
	* 위험평가지표 저장
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;
		MDaoUtil mDao =null;
		try {
			mDao = new MDaoUtil();
			mDao.begin();
			output = new DataObj();
			DataObj output_s = null;
		    SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String logigId = helper.getLoginId();
		    String sqlId = "RBA_50_03_02_02_doSave2";
		    
			/*
			 * System.out.println("RA_ITEM_CODE1============="+input.getText("RA_ITEM_CODE")
			 * );
			 * System.out.println("RA_ITEM_CODE2============="+input.get("RA_ITEM_CODE"));
			 */
		    
		    input.put("CHG_OP_JKW_NO", logigId);
		    
		    if( input.get("RA_ITEM_CODE").equals("")  ) {
		    	// SRBA_RISK_ELMT_M UPDATE
		    	sqlId = "RBA_50_03_02_02_doSave";
		    	mDao.setData(sqlId, input);
		    	
		    } else {
		    	// 고유위험 "거래" 대해서는 점수는 SRBA_ETC_I , 그위는 SRBA_RISK_ELMT_M UPDATE
		    	sqlId = "RBA_50_03_02_02_doSave2";
		    	mDao.setData(sqlId, input);
		    	
		    	
		    	sqlId = "RBA_50_03_02_02_doSave3";
		    	mDao.setData(sqlId, input);
		    }
		    
		    mDao.commit();
			output.put("ERRCODE", "00000"); 
            output.put("ERRMSG" , MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상 처리되었습니다."));
            output.put("WINMSG" , MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상 처리되었습니다."));
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00005");
			output.put("ERRMSG",  ex.toString());
			output.put("WINMSG",  ex.toString()); 
		} finally {
			if(mDao != null ) {
				mDao.close();
			} 
		}
		return output;
	}
	
	/**
	* <pre>
	* 위험평가지표 삭제
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;
		MDaoUtil mDao =null;
		try {
			mDao = new MDaoUtil();
			mDao.begin();
			output = new DataObj();
			
		    String sqlId = "RBA_50_03_02_02_doDelete";
		    
		    mDao.setData(sqlId, input);

		    mDao.commit();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG" , MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상 처리되었습니다."));
            output.put("WINMSG" , MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상 처리되었습니다."));
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			if( mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} finally {
			if(mDao != null ) {
				mDao.close();
			}
		}
		return output;
	}	
}