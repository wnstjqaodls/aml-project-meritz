/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_01;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description FIU보고서 관리
 * @Group       GTONE, R&D센터
 * @Project     RBA
 * @Java        7.0 이상
 * @Author      이혁준
 * @Since       2018. 12. 04.
 ******************************************************************************************************************************************/

public class RBA_90_01_01_01 extends GetResultObject {

    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/

    /** 인스턴스 */
	private static RBA_90_01_01_01 instance = null;

    /**
     * 인스턴스 반환.
     * <p>
     * @return RBA_90_01_01_01
     */
	public static  RBA_90_01_01_01 getInstance() {
		synchronized(RBA_90_01_01_01.class) {
			if (instance == null) {
				instance = new RBA_90_01_01_01();
			}
		}
		return instance;
	}

    /**
     * FIU보고기본(JRBA_RPT_BAS_M 테이블)의 데이터 조회<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(FIU보고기본 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     */
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {

			// FIU보고서 조회
			output = MDaoUtilSingle.getData("RBA_90_01_01_01_getSearch", input);

			// grid data
			if (output.getCount("CNT") > 0) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG", MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다."));
			}
			*/

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException e) {
		      Log.logAML(Log.ERROR, this, "doSearch", e.getMessage());
		      output = new DataObj();
		      output.put("ERRCODE", "00001");
		      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		    }
		return output;
    }

    /**
     * RBA보고지표 관련 테이블 삭제처리(JRBA_RPT_BAS_M, JRBA_GRP_C, JRBA_DTL_C, JRBA_JIPYO_M, JRBA_JIPYO_BAS_I, JRBA_RPT_RST_M) <br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(삭제처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     */
	public DataObj doDelete(DataObj input) {

		DataObj output = null;
	    MDaoUtil db = null;

	    try {

	    	//삭제하려는 데이터의 배치실행여부 확인 20181211
		    String existBatchResult = MDaoUtilSingle.getData("RBA_90_01_01_02_deleteCon", input).getText("CNT");
		    boolean isExistBatchResult = "0".equals(existBatchResult) ? false : true;
			if (isExistBatchResult) {
			   Log.logAML(Log.ERROR, this, "doDelete", "이미 배치가 실행되었거나 보고된 정보는 삭제할수 없습니다.");
			    output = new DataObj();
			    output.put("ERRCODE", "00000");
			    output.put("WINMSG", "이미 배치가 실행되었거나 보고된 정보는 삭제할수 없습니다.");

			    return output;
			}

			//삭제하려는 데이터에서 확정된 건이 존재하는지 확인 -> 하나라도 존재하면 삭제를 막아야함 20190516
			String confirmCnt = MDaoUtilSingle.getData("RBA_90_01_01_02_deleteCon2", input).getText("CNT2");
			boolean isExistConfirmResult = "0".equals(confirmCnt) ? false : true;
			if (isExistConfirmResult) {
			   Log.logAML(Log.ERROR, this, "doDelete", "이미 확정된 지표데이터가 존재하여 삭제할 수 없습니다.");
			   output = new DataObj();
			   output.put("ERRCODE", "00000");
			   output.put("WINMSG", "이미 확정된 지표데이터가 존재하여 삭제할 수 없습니다.");

			   return output;
			}

	    	db = new MDaoUtil();
	        db.begin();

	        // RBA보고기본
	        db.setData("RBA_90_01_01_02_delete_jrba_rpt_bas_m", input); // delete JRBA_RPT_BAS_M

        	// RBA보고그룹코드
	        db.setData("RBA_90_01_01_02_delete_jrba_grp_c", input); // delete JRBA_GRP_C

	        // RBA상세코드정보
	        db.setData("RBA_90_01_01_02_delete_jrba_dtl_c", input); // delete JRBA_DTL_C

	        // RBA보고지표
	        db.setData("RBA_90_01_01_02_delete_jrba_jipyo_m", input); // delete JRBA_JIPYO_M

	        // RBA보고지표 기준관리
	        db.setData("RBA_90_01_01_02_delete_jrba_jipyo_bas_i", input); // delete JRBA_JIPYO_BAS_I

	        // RBA보고결과 관리
	        db.setData("RBA_90_01_01_02_delete_jrba_rpt_rst_m", input); // delete JRBA_RPT_RST_M

	        // RBA보고지표값 관리, 지표입력값을 확정하지않고, 저장만 한 상태에서 삭제하려고 할수도있기 때문에 JRBA_JIPYO_V의 관리도 필요함 20190516
		    db.setData("RBA_90_01_01_02_delete_jrba_jipyo_v", input); // delete JRBA_JIPYO_V

	        db.commit();

	        output = new DataObj();
	 		output.put("ERRCODE", "00000");
	 	    output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
	 	    output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
	 	    output.put("gdRes", null); // Grid Data

	    } catch (AMLException e) {
		  	  Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
		      output = new DataObj();
		      output.put("ERRCODE", "00001");
		      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		} catch (Exception e) {
		  	  Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
		      output = new DataObj();
		      output.put("ERRCODE", "00001");
		      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		} finally {
			if (db != null) {
				db.close();
			}
		}

	    return output;
	}

    /**
     * 데이터기준일 update <br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(변경처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     */
	public DataObj doSave(DataObj input) {

		DataObj output = new DataObj();

		try {

		  MDaoUtilSingle.setData("RBA_90_01_01_01_doUpdate_JRBA_RPT_BAS_M", input);

		  output.put("ERRCODE", "00000");
		  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("gdRes", null); // Grid Data

		} catch (AMLException e) {
			  Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
		    output.put("ERRCODE", "00001");
		    output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}
	
	/**
     * 자동지표 수행일자 doReset <br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(변경처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     */
	public DataObj doReset(DataObj input) {

		DataObj output = new DataObj();

		try {

		  MDaoUtilSingle.setData("RBA_90_01_01_01_doReset_JRBA_RPT_BAS_M", input);

		  output.put("ERRCODE", "00000");
		  output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		  output.put("gdRes", null); // Grid Data

		} catch (AMLException e) {
			  Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
		    output.put("ERRCODE", "00001");
		    output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}


}
