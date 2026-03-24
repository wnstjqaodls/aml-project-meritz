package com.gtone.rba.server.type03.RBA_30.RBA_30_06.RBA_30_06_01;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

public class RBA_30_06_01_02 extends GetResultObject {
	private static RBA_30_06_01_02 instance = null;

	/**
	* getInstance
	* @return RBA_30_06_01_02
	*/
	public static  RBA_30_06_01_02 getInstance() {
		synchronized(RBA_30_06_01_02.class) {  
			if (instance == null) {
				instance = new RBA_30_06_01_02();
			}
		}
		return instance;
	}

	public DataObj doSave(DataObj input) {
		DataObj output = new DataObj();

		try {
			MDaoUtilSingle.setData("RBA_30_06_01_02_doSave", input);
			output.put("ERRCODE", "00000");

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
}
