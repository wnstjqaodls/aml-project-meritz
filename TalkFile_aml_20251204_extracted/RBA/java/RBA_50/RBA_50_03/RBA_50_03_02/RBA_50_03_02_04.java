package com.gtone.rba.server.type03.RBA_50.RBA_50_03.RBA_50_03_02;

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
 * 위험평가지표 결재 상세
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-05-02
 */
public class RBA_50_03_02_04 extends GetResultObject {

	private static RBA_50_03_02_04 instance = null;

	/**
	 * getInstance
	 * @return RBA_50_03_02_04
	 */
	public static  RBA_50_03_02_04 getInstance() {
		synchronized(RBA_50_03_02_04.class) {  
			if (instance == null) {
				instance = new RBA_50_03_02_04();
			}
		}
		return instance;
	}
	
	/**
	 * <pre>
	 * 위험평가지표관리 결재상세 조회
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;
		
		String query_id = null; // 통제활동 운영평가 결재 조회
		
		try {
			// 통제활동 운영평가 결재 조회
			query_id = "RBA_50_03_02_04_doSearch";
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
	
}