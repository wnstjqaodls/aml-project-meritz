/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_04;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 잔여위험 등급 임계치 관리
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-05-15
 */
public class RBA_50_05_04_01 extends GetResultObject {

	private static RBA_50_05_04_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_04_01
	*/
	public static  RBA_50_05_04_01 getInstance() {
		synchronized(RBA_50_05_04_01.class) {  
			if (instance == null) {
				instance = new RBA_50_05_04_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 잔여위험 등급 임계치 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_04_01_getSearch", input);
		
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


	
	/**
	* <pre>
	* 잔여위험 등급 임계치 저장
	* </pre>
	* @param input
	* @return
	*/
	
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
		try {
			mDao = new MDaoUtil();
			mDao.begin();
			
			for(int i=0; 3>i; i++) {
				if( i == 0) {
					input.set("GD_S_SECT", input.getText("GD_S_SECT1"));
					String SGD_G_C1 = input.getText("SGD_G_C1");
					SGD_G_C1 = SGD_G_C1.replaceAll("&gt;", ">");
					SGD_G_C1 = SGD_G_C1.replaceAll("&lt;", "<");
					input.set("SGD_G_C", SGD_G_C1);
					
					input.set("GD_E_SECT", "100");
					input.set("EGD_G_C", "<=");
					input.set("SNO", "1");
				}
				if( i == 1) {
					input.set("GD_S_SECT", input.getText("GD_S_SECT2"));
					String SGD_G_C2 = input.getText("SGD_G_C2");
					SGD_G_C2 = SGD_G_C2.replaceAll("&gt;", ">");
					SGD_G_C2 = SGD_G_C2.replaceAll("&lt;", "<");
					input.set("SGD_G_C", SGD_G_C2);
					input.set("GD_E_SECT", input.getText("GD_E_SECT1"));
					String EGD_G_C1 = input.getText("EGD_G_C1");
					EGD_G_C1 = EGD_G_C1.replaceAll("&gt;", ">");
					EGD_G_C1 = EGD_G_C1.replaceAll("&lt;", "<");
					input.set("EGD_G_C", EGD_G_C1);
					input.set("SNO", "2");
				}
				if( i == 2) {
					input.put("GD_S_SECT", "0");
					input.set("SGD_G_C", ">=");
					input.set("GD_E_SECT", input.getText("GD_E_SECT2"));
					String EGD_G_C2 = input.getText("EGD_G_C2");
					EGD_G_C2 = EGD_G_C2.replaceAll("&gt;", ">");
					EGD_G_C2 = EGD_G_C2.replaceAll("&lt;", "<");
					input.set("EGD_G_C", EGD_G_C2);
					input.set("SNO", "3");
				}
				mDao.setData("RBA_50_05_04_01_doSave", input);
			}
			
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}

}