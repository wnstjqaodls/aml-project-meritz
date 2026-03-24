package com.gtone.rba.server.type03.RBA_50.RBA_50_06.RBA_50_06_02;

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
 * KRI등급 모니터링
 * </pre>
 * @author LCJ
 * @version 1.0
 * @history 1.0 2018-05-15
 */
public class RBA_50_06_02_01 extends GetResultObject {

	private static RBA_50_06_02_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_06_02_01
	*/
	public static  RBA_50_06_02_01 getInstance() {
		synchronized(RBA_50_06_02_01.class) {  
			if (instance == null) {
				instance = new RBA_50_06_02_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* KRI지표 모니터링 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {  
			output = MDaoUtilSingle.getData("RBA_50_06_02_01_doSearch1", input);
			// grid data
			if (output.getCount("KRI_NO") > 0) {
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
	
 

	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBAS_common_getComboData_ValtYear", input);
			
			// grid data
			if (output.getCount("CODE") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch2", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	} 
	
}