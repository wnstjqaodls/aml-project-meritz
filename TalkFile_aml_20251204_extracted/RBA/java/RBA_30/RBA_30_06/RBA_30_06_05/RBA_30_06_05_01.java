package com.gtone.rba.server.type03.RBA_30.RBA_30_06.RBA_30_06_05;

import java.text.SimpleDateFormat;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.user.SessionAML;
import com.gtone.express.server.helper.MessageHelper;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

public class RBA_30_06_05_01 extends GetResultObject {
	private static RBA_30_06_05_01 instance = null;

	/**
	* getInstance
	* @return RBA_30_06_05_01
	*/
	public static  RBA_30_06_05_01 getInstance() {
		synchronized(RBA_30_06_05_01.class) {  
			if (instance == null) {
				instance = new RBA_30_06_05_01();
			}
		}
		return instance;
	}

	public DataObj getSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_05_01_getSearch", input);
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

			output = MDaoUtilSingle.getData("RBA_30_06_05_02_getSearch", input);

			// grid data
			if ( output.getCount("RSK_CATG1_C_NM") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
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
	
	// 차트 구성
	public DataObj getSearchRslt(DataObj input) {
		DataObj output = new DataObj();
//		DataSet gdRes = null;

		try {
			String query_id = "RBA_30_06_05_02_getSearch2";
			
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
	
	public DataObj getSearchGYLJ(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_05_02_getSearchGYLJ", input);
			
			// grid data
			if ( output.getCount("GYLJ_S_C") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGYLJ(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}
	
	public DataObj doSave(DataObj input) {
		DataObj output = new DataObj();

		try {
			MDaoUtilSingle.setData("RBA_30_06_05_02_doSave", input);
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
	
	public DataObj doSearchGYLJ(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		String query_id = null; // 부서별 업무프로세스  결재 조회

		try {
			// 통제활동 운영평가 결재 조회
			query_id = "RBA_30_06_05_03_doSearchGYLJ";
			output = MDaoUtilSingle.getData(query_id, input);

			if (output.getCount("GYLJ_ID") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	
	public DataObj doSearchHist(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_05_04_getSearchHist", input);
			if ( output.getCount("GYLJ_JKW_NM") > 0 ) {
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
