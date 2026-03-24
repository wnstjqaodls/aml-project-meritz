package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_08;

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
 * AML 통제평가
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-05-14
 */
public class RBA_50_05_08_01 extends GetResultObject {

	private static RBA_50_05_08_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_02_01
	*/
	public static  RBA_50_05_08_01 getInstance() {
		synchronized(RBA_50_05_08_01.class) {  
			if (instance == null) {
				instance = new RBA_50_05_08_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 부점별 현황
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_08_01_getSearch", input);
			// grid data
			if (output.getCount("CNTL_CATG1_C_NM") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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

	public DataObj getSearchChart1(DataObj input) {
		DataObj output = new DataObj();
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_08_01_getChart", input);
			
			// grid data
			if (output.getCount("JSON_RESULT") > 0) {
				gdRes = Common.setGridData(output);
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchRslt(Exception)", e.getMessage());
			e.printStackTrace();
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	
}