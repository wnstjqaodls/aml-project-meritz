package com.gtone.rba.server.type03.RBA_50.RBA_50_02.RBA_50_02_01;

import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 프로세스 관리
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-24
 */
public class RBA_50_02_01_01 extends GetResultObject {

	private static RBA_50_02_01_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_02_01_01
	*/
	public static  RBA_50_02_01_01 getInstance() {
		synchronized(RBA_50_02_01_01.class) {  
			if (instance == null) {
				instance = new RBA_50_02_01_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 프로세스 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			 
			output = MDaoUtilSingle.getData("RBA_50_02_01_01_getSearch", input); 
		
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
		}
		return output;
	}
	
	/**
	* <pre>
	* 프로세스 다중 삭제
	* </pre>
	* @param input
	* @return
	*/
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				
				mDao.setData("RBA_50_02_01_01_doDelete", inputMap);
			}
			
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {mDao.rollback();
			
			}
			Log.logAML(Log.ERROR, this, "doDelete", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}

}