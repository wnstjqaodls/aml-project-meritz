/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_04.RBA_50_04_01;


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
 * 통제점검항목관리
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-25
 */
public class RBA_50_04_01_01 extends GetResultObject {

	private static RBA_50_04_01_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_04_01_01
	*/
	public static  RBA_50_04_01_01 getInstance() {
		synchronized(RBA_50_04_01_01.class) {
			if (instance == null) {
				instance = new RBA_50_04_01_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 통제점검항목 영역
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_04_01_01_getSearch", input);

			if (output.getCount("CNTL_ELMN_C") > 0) {
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
	* 통제점검항목 요소 및 점검항목 조회
	* </pre>
	* @param input
	* @return
	*/

	public DataObj doSearch2(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_04_01_02_doSearch", input);

			if (output.getCount("TONGJE_LGDV_C") > 0) {
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



}