package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_01;

import java.util.HashMap;

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
 * ML/TF 지표목록 상세 팝업
 * </pre>
 * @author JSW
 * @version 1.0
 * @history 1.0 2019-01-28
 */
public class RBA_50_05_01_07 extends GetResultObject {

	private static RBA_50_05_01_07 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_01_07
	*/
	public static  RBA_50_05_01_07 getInstance() {
		synchronized(RBA_50_05_01_07.class) {  
			if (instance == null) {
				instance = new RBA_50_05_01_07();
			}
		}
		return instance;
	}
	 
	/**
	* <pre>
	* 위험평가 일정관리 첨부파일
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSearch(DataObj input) {
	      DataObj output = null;
	      DataSet gdRes = null;

	      try {

	        // 구분 조회
	        output = MDaoUtilSingle.getData("RBA_50_05_01_07_getSearch", (HashMap) input);

	        // grid data
	        if (output.getCount("VALT_YYMM") > 0) {
	          gdRes = Common.setGridData(output);
	        } else {
	          output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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