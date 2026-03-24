package com.gtone.rba.server.type03.RBA_50.RBA_50_02.RBA_50_02_01;

import org.omg.CORBA.UserException;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 프로세스 등록/수정
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-24
 */
public class RBA_50_02_01_02 extends GetResultObject {

	private static RBA_50_02_01_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_02_01_02
	*/
	public static  RBA_50_02_01_02 getInstance() {
		synchronized(RBA_50_02_01_02.class) {  
			if (instance == null) {
				instance = new RBA_50_02_01_02();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 프로세스 저장
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSave(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = new DataObj();
		    SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String logigId = helper.getLoginId();

		    input.put("DR_OP_JKW_NO", logigId);
		    input.put("CHG_OP_JKW_NO", logigId);
		  
		    //구분이 0: 등록  , 1: 수정
		    String GUBN = input.get("GUBN").toString();
		    String sqlId = ("0".equals(GUBN)) ? "RBA_50_02_01_02_doSave_insert" : "RBA_50_02_01_02_doSave_update";
		    
			MDaoUtilSingle.setData(sqlId, input);
			
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

}