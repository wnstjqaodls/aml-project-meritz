package com.gtone.rba.server.type03.RBA_30.RBA_30_06.RBA_30_06_02;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

public class RBA_30_06_02_01 extends GetResultObject {
	private static RBA_30_06_02_01 instance = null;

	/**
	* getInstance
	* @return RBA_30_06_02_01
	*/
	public static  RBA_30_06_02_01 getInstance() {
		synchronized(RBA_30_06_02_01.class) {  
			if (instance == null) {
				instance = new RBA_30_06_02_01();
			}
		}
		return instance;
	}

	public DataObj getSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_02_01_getSearch", input);
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
	
	public DataObj getSearchDetail(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_02_02_getSearch", input);
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
	
	public DataObj getSearchRslt(DataObj input) {
		DataObj output = new DataObj();
//		DataSet gdRes = null;

		try {
			String query_id = "RBA_30_06_02_02_getSearch2";
			
			System.out.println(">>>>> 쿼리 실행전 YYYY >>>>> " + input.getText("BAS_YYYY"));
			output = MDaoUtilSingle.getData(query_id, input);
			
			String json = output.getText("CHART_JSON");
			output.put("chartDataJson", json);
			
			String fstLt = output.getText("MONITOR_FST_LT");
			String sndLt = output.getText("MONITOR_SND_LT");
			output.put("monitorFstLt",fstLt);
			output.put("monitorSndLt",sndLt);
			output.put("ERRCODE", "00000");
			System.out.println(">>>>> 쿼리 실행 후 YYYY >>>>> " + output);

		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchRslt(Exception)", e.getMessage());
			e.printStackTrace();
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	private DataObj append(String string) {
		// TODO Auto-generated method stub
		return null;
	}

	public DataObj doSave(DataObj input) {
		DataObj output = new DataObj();

		try {
			MDaoUtilSingle.setData("RBA_30_06_02_02_doSave", input);
			output.put("ERRCODE", "00000");
            output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상 처리되었습니다."));
            output.put("WINMSG", MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상 처리되었습니다."));

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
