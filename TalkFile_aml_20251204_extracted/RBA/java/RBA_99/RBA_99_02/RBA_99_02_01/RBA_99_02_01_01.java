/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.common.RBA_99.RBA_99_02.RBA_99_02_01;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
* @Description 임직원별 교육/연수 실적 관리
* @Group       
* @Project     
* @Java        
* @Author      KMJ2
* @Since       2024. 2. 16.
******************************************************************************************************************************************/

public class RBA_99_02_01_01 extends GetResultObject {

	private static RBA_99_02_01_01 instance = null;
	
	/*
	* 인스턴스 반환.
	* <p>
	* @return  <code>RBA_99_02_01_01</code>
	*              인스턴스
	*/
	public static RBA_99_02_01_01 getInstance() {
	return instance == null ? (instance = new RBA_99_02_01_01()) : instance;
	}
	
	/**
	* 
	* @param input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	* 			소속 부점, 날짜, 교육대상
	* @return
	*/
	
	public DataObj doSearch(DataObj input) {
	DataObj output = new DataObj();
	DataSet gdRes = null;
	
	try {
		@SuppressWarnings("unused")
		String branchCode, stDate, edDate, EDU_TGT_CCD;
		int branchCodeYN, EDU_TGT_CCD_YN, ING_ALL_YN;
	
		//input 세팅
		//부점
		branchCode = input.getText("branchCode");
		branchCodeYN = "999".equals(Util.nvl(branchCode, "999")) ? 1 : 0;
	
		//날짜
		stDate = Util.replace(input.getText("stDate"), "-", "");
		edDate = Util.replace(input.getText("edDate"), "-", "");
		
		//교육대상
		EDU_TGT_CCD = input.getText("EDU_TGT_CCD");
		EDU_TGT_CCD_YN = "ALL".equals(Util.nvl(EDU_TGT_CCD, "ALL")) ? 1 : 0;
		
		//이수여부
		ING_ALL_YN= "ALL".equals(Util.nvl(input.getText("ING_YN"), "ALL")) ? 1 : 0;
	
	
		input.add("branchCodeYN", branchCodeYN);
		input.add("EDU_TGT_CCD_YN", EDU_TGT_CCD_YN);
		input.add("ING_ALL_YN", ING_ALL_YN);
		
		//db조회
		DataObj dbOut = MDaoUtilSingle.getData("RBA_99_02_01_01_doSearch", input);
	
		if (dbOut.getCount("CNT") > 0) {
			gdRes = Common.setGridData(dbOut);
		} else {
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
		}
		output.put("ERRCODE", "00000");
		output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSearch", e.toString());
			output.clear();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", e.getMessage());
			output.put("WINMSG", e.getMessage());
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "doSearch", e.toString());
			output.clear();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", e.getMessage());
			output.put("WINMSG", e.getMessage());
		}
		return output;
	}

}

