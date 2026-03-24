package com.gtone.rba.server.type03.RBA_30.RBA_30_06.RBA_30_06_01;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

public class RBA_30_06_01_01 extends GetResultObject {
	private static RBA_30_06_01_01 instance = null;

	/**
	* getInstance
	* @return RBA_30_06_01_01
	*/
	public static  RBA_30_06_01_01 getInstance() {
		synchronized(RBA_30_06_01_01.class) {  
			if (instance == null) {
				instance = new RBA_30_06_01_01();
			}
		}
		return instance;
	}

	public DataObj getSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_01_01_getSearch", input);
			// grid data
			if ( output.getCount("RSK_CATG1_C_NM") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "getSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
}
