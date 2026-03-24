/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_04;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

public class RBA_90_01_04_07 extends GetResultObject {

	private static RBA_90_01_04_07 instance = null;

	/**
	 * getInstance
	 * 
	 * @return RBA_90_01_04_07
	 */
	public static RBA_90_01_04_07 getInstance() {
		if (instance == null) {
			instance = new RBA_90_01_04_07();
		}
		return instance;
	}

	public DataObj getSearchRslt(DataObj input) {
		DataObj output = new DataObj();
		DataSet gdRes = null;

		try {
			String query_id = "RBA_90_01_04_07_dosearch";
			output = MDaoUtilSingle.getData(query_id, input);

			if (output.getCount("RPT_GJDT1") > 0) {
				gdRes = Common.setGridData(output);
				output.put("ERRCODE", "00000");
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchRslt(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

}