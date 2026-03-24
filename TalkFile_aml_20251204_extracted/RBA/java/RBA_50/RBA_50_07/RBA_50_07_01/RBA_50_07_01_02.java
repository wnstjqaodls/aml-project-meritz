package com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_01;

import org.omg.CORBA.UserException;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 개선대응방안 상세
 * </pre>
 * @author  bjson
 * @version 1.0
 * @history 1.0 2018-04-24
 */
public class RBA_50_07_01_02 extends GetResultObject {
	private static RBA_50_07_01_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_07_01_02
	*/
	public static  RBA_50_07_01_02 getInstance() {
		synchronized(RBA_50_07_01_02.class) {  
			if (instance == null) {
				instance = new RBA_50_07_01_02();
			}
		}
		return instance;
	}
	
	/**
	 * <pre>
	 * Risk Event상세 조회
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			
			output = MDaoUtilSingle.getData("RBA_50_07_01_02_doSearch", input);
			
			// grid data
			if (output.getCount("POOL_SNO") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	/**
	 * <pre>
	 * 개선대응방안  수정
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSave(DataObj input) throws UserException {
		
		
		DataObj output = new DataObj();
		input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호

		Log.logAML(Log.INFO, this, "doSave", "개선목록 POOL관리 저장");
		
		try {
			
			if("0".equals(input.get("GUBN"))){
				MDaoUtilSingle.setData("RBA_50_07_01_02_doSave", input);
			}else{
				MDaoUtilSingle.setData("RBA_50_07_01_02_doSave1", input);
			}
			
			
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
