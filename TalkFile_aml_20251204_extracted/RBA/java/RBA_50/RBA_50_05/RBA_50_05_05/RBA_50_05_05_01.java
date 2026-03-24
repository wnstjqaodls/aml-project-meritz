/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_05;

import java.text.SimpleDateFormat;
import java.util.Date;

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
 * 부서별 위험평가 현황 관리
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-05-17
 */
public class RBA_50_05_05_01 extends GetResultObject {

	private static RBA_50_05_05_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_05_01
	*/
	public static  RBA_50_05_05_01 getInstance() {
		if (instance == null) {
			instance = new RBA_50_05_05_01();
		}
		return instance;
	}

	/**
	* <pre>
	* 부서별 위험평가 현황  조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_05_01_getSearch", input);
		
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
	* 평가 마감처리
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doEnd(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		MDaoUtil mDao = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			String wIngStep = input.getText("ING_STEP");
			String REAL_EDT = input.getText("REAL_EDT");
			int dIngStep = 0;
			
			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
			input.put("RBA_VALT_LGDV_C", "E");
			if("20".equals(wIngStep)) {
				input.put("RBA_VALT_SMDV_C", "E01");
			}else if("30".equals(wIngStep)) {
				input.put("RBA_VALT_SMDV_C", "E02");
			}
			
			if("Y".equals(REAL_EDT)) {
		        Date todate = new Date();
		        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		        String tradate =sdf.format(todate);
				REAL_EDT = tradate;
				input.put("REAL_EDT", REAL_EDT);
			}
			
			if("".equals(wIngStep)==false) {
				mDao.setData("RBA_50_01_01_01_setEnd", input); //종료일자 저장
				//마감처리
				output2 = MDaoUtilSingle.getData("RBA_50_01_01_01_getIngStep_M", input);
				dIngStep = Integer.parseInt(output2.getText("ING_STEP"));
				
				    if("20".equals(input.getText("ING_STEP")) || "21".equals(input.getText("ING_STEP"))) {
						//종료일  업을시 
						if("".equals(REAL_EDT)) {
							input.put("ING_STEP","11");
						}
						mDao.setData("RBA_50_01_01_01_setIngStep_M", input); //마감시 ING_STEP  변경
						//DB commit
						mDao.commit();
				  
						output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
						output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
						output.put("ERRCODE", "00000");
					}else if("30".equals(input.getText("ING_STEP")) || "31".equals(input.getText("ING_STEP"))) {
						//종료일  업을시 
						if("".equals(REAL_EDT)) {
							input.put("ING_STEP","21");
						}
						mDao.setData("RBA_50_01_01_01_setIngStep_M", input); //마감시 ING_STEP  변경
						//DB commit
						mDao.commit();
				  
						output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
						output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
						output.put("ERRCODE", "00000");
					}else {
						//DB commit
						mDao.commit();
					}
			}else {
				//DB commit
				mDao.commit();
		  
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("ERRCODE", "00000");
			}

		} catch (NumberFormatException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doConfirm", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doConfirm", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}

}