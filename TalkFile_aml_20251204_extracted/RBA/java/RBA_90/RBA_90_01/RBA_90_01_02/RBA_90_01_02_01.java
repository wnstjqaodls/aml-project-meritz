/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_02;

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
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description FIU지표관리
 * @Group       GTONE, R&D센터
 * @Project     RBA
 * @Java        7.0 이상
 * @Author      이혁준
 * @Since       2018. 12. 04.
 ******************************************************************************************************************************************/

public class RBA_90_01_02_01 extends GetResultObject {

	/**************************************************************************************************************************************
	 * Attributes
	 **************************************************************************************************************************************/

	/** 인스턴스 */
	private static RBA_90_01_02_01 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return RBA_90_01_02_01
	 */
	public static  RBA_90_01_02_01 getInstance() {
		synchronized(RBA_90_01_02_01.class) {
			if (instance == null) {
				instance = new RBA_90_01_02_01();
			}
		}
		return instance;
	}

	/**
	 * FIU지표(JRBA_JIPYO_M 테이블)목록의 데이터 조회<br>
	 * <p>
	 * @param   input
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(FIU지표목록 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 */
	@SuppressWarnings("rawtypes")
	public DataObj getSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;
		try {

			// 그룹코드 조회
			output = MDaoUtilSingle.getData("RBA_90_01_02_01_getSearch", (HashMap) input);

			// grid data
			if ( output.getCount("JIPYO_IDX") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));

			}
			*/

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearch(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**
	 * 지표확정여부상태 조회<br>
	 * <p>
	 * @param   input
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(지표확정여부 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 */
	@SuppressWarnings("rawtypes")
	public DataObj getConfirmStatus(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;
		try {

			// 그룹코드 조회
			output = MDaoUtilSingle.getData("RBA_90_01_02_01_select_confirm_status", (HashMap) input);

			// grid data
			if ( output.getCount("JIPYO_FIX_YN") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getConfirmStatus(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**
	 * 관리지점 변경<br>
	 * <p>
	 * @param   input
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(변경처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 */
	@SuppressWarnings({ "unchecked", "deprecation" })
	public DataObj doSaveBranch(DataObj input) throws AMLException {

		DataObj output = null;
		MDaoUtil db = null;

		try {

			@SuppressWarnings("rawtypes")
			List gdReq = (List) input.get("gdReq");

			db = new MDaoUtil();
			db.begin();

			int gdReq_size = gdReq.size();
			for ( int i = 0; i < gdReq_size; i++ ) {

				@SuppressWarnings("rawtypes")
				HashMap inputRow = (HashMap) gdReq.get(i);

				inputRow.put("RPT_GJDT", (StringHelper.evl(input.get("RPT_GJDT"), "")));
				inputRow.put("MNG_BRNO", (StringHelper.evl(input.get("MNG_BRNO_SAVE"), "")));

				db.setData("RBA_90_01_02_01_MNG_BRNO_SAVE", inputRow);
			}

			db.commit();
			output = new DataObj();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Grid Data

		} catch (RuntimeException re) {

			try {
				if ( db != null ) {
					db.rollback();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}

			Log.logAML(Log.ERROR, this, "doSaveBranch", re.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());

		} catch (Exception e) {
			try {
				if ( db != null ) {
					db.rollback();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}

			Log.logAML(Log.ERROR, this, "brnoSave", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {

			try {
				if ( db != null ) {
					db.close();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
		}
		return output;
	}

	/**
	 * 지표확정/취소처리-지표를 확정처리하면 등록/수정/삭제 처리 불가<br>
	 * <p>
	 * @param   input
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(확정/취소처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 */
	@SuppressWarnings({ "unchecked", "deprecation" })
	public DataObj doConfirm(DataObj input) throws AMLException {

		DataObj output = null;
		DataObj outputcheck = null;
		MDaoUtil db = null;

		try {

			//String status = "";
			String outputMsg = "";

			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			outputcheck = MDaoUtilSingle.getData("RBA_90_01_02_01_select_confirm_status", (HashMap) input);

			int status = outputcheck.getInt("JIPYO_FIX_YN");

			db = new MDaoUtil();
			db.begin();

			if ( status == 1 ) {
				db.setData("RBA_90_01_02_01_confirm_cancel", input);

				//기존에는 지표입력값을 저장만해도 일괄취소가 안됐었는데, 지금은 저장상태일때도 취소가 가능하기 때문에 취소하면서 JRBA_JIPYO_V의 데이터를 삭제해준다 20190516
	    		db.setData("RBA_90_01_01_02_delete_jrba_jipyo_v", input);
				outputMsg = "일괄확정 취소 처리되었습니다.";
			} else {
				db.setData("RBA_90_01_02_01_confirm", input);
				outputMsg = "일괄확정 처리되었습니다.";
			}
			db.commit();
			output = new DataObj();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", outputMsg);
			output.put("WINMSG", outputMsg);
			output.put("gdRes", null); // Grid Data

		} catch (NumberFormatException re) {

			try {
				if ( db != null ) {
					db.rollback();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}

			Log.logAML(Log.ERROR, this, "brnoSave", re.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());

		} catch (RuntimeException re) {

			try {
				if ( db != null ) {
					db.rollback();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}

			Log.logAML(Log.ERROR, this, "brnoSave", re.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());

		} catch (AMLException e) {
			try {
				if ( db != null ) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "brnoSave", e.getMessage());
			}

			Log.logAML(Log.ERROR, this, "brnoSave", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {

			try {
				if ( db != null ) {
					db.close();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
		}
		return output;
	}

	public DataObj doCheckJipyoV(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {

			DataObj resultDataobj = new DataObj();
			String query_id = "RBA_90_01_02_01_doCheckJipyoV";
			output = MDaoUtilSingle.getData(query_id, input);

			if ( output != null ) {

				if ( Integer.parseInt(output.getText("CNT")) > 0 ) {

					resultDataobj.put("RESULT", "false");
				} else {
					resultDataobj.put("RESULT", "true");
				}
			}

			gdRes = Common.setGridData(resultDataobj);

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (NumberFormatException e) {

			Log.logAML(1, this, "doCheckJipyoIdx", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		} catch (AMLException e) {

			Log.logAML(1, this, "doCheckJipyoIdx", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		}
		return output;

	}
}
