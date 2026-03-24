package com.gtone.rba.server.type03.RBA_50.RBA_50_02.RBA_50_02_01;

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
 * 프로세스 관리
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-08-14
 */
public class RBA_50_02_01_03 extends GetResultObject {

	private static RBA_50_02_01_03 instance = null;
	/**
	* getInstance
	* @return RBA_50_03_01_01
	*/
	public static  RBA_50_02_01_03 getInstance() {
		synchronized(RBA_50_02_01_03.class) {  
		if (instance == null) {
			instance = new RBA_50_02_01_03();
		}
		}
		return instance;
	}

	/**
	* <pre>
	* 프로세스 사용부서 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			if(("1").equals(input.get("PROC_FLD_C"))){
				output = MDaoUtilSingle.getData("RBA_50_02_01_03_doSearch", input);
			}else {
				output = MDaoUtilSingle.getData("RBA_50_02_01_03_doSearch2", input);
			}
		
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
		} catch (Exception ex) {
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
}