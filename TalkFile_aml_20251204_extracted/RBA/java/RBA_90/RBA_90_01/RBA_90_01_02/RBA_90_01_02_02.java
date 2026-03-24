/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_02;

import java.util.HashMap;

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

/******************************************************************************************************************************************
 * @Description FIU지표등록
 * @Group       GTONE, R&D센터
 * @Project     RBA
 * @Java        7.0 이상
 * @Author      이혁준
 * @Since       2018. 12. 04.
 ******************************************************************************************************************************************/

public class RBA_90_01_02_02 extends GetResultObject {

	/**************************************************************************************************************************************
	 * Attributes
	 **************************************************************************************************************************************/

	/** 인스턴스 */
	private static RBA_90_01_02_02 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return RBA_90_01_02_02
	 */
	public static  RBA_90_01_02_02 getInstance() {
		synchronized(RBA_90_01_02_02.class) {
			if (instance == null) {
				instance = new RBA_90_01_02_02();
			}
		}
		return instance;
	}

	/**
	 * FIU지표(JRBA_JIPYO_M 테이블)의 상세정보 조회 - 보고기준일,지표인덱스로 단건 조회<br>
	 * <p>
	 * @param   input
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(FIU지표상세정보 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 */
	@SuppressWarnings("unchecked")
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;
		try {

			String query_id = "RBA_90_01_02_01_getSearch";
			output = MDaoUtilSingle.getData(query_id, input);
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
			Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;

	}

	/**
	 * <pre>
	 * 보고지표 조회
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doDetail(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;
		try {

			String query_id = "RBA_90_01_02_01_doDetail";
			output = MDaoUtilSingle.getData(query_id, input);

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
			Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;

	}

	/**
	 * 보고지표 저장<br>
	 * <p>
	 * @param   input
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(저장처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 */
	@SuppressWarnings({ "unchecked", "deprecation" })
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = null;
		MDaoUtil db = null;

		try {

			//	    	@SuppressWarnings("unused")
			//	    	SessionAML sess = (SessionAML) input.get("SessionAML");

			input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			db = new MDaoUtil();
			db.begin();

			db.setData("RBA_90_01_02_02_merge_jrba_jipyo_m", input);

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

			Log.logAML(Log.ERROR, this, "doSave", re.getMessage());

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

			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

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
	 * 보고지표 삭제<br>
	 * <p>
	 * @param   input
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(삭제처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 */
	@SuppressWarnings({ "unchecked", "deprecation" })
	public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = null;
		DataObj outputcheck = null;
		MDaoUtil db = null;

		try {

			//	    	@SuppressWarnings("unused")
			//	    	SessionAML sess = (SessionAML) input.get("SessionAML");

			input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			outputcheck = MDaoUtilSingle.getData("RBA_90_01_02_02_select_jrba_jipyo_v", (HashMap) input);

			if ( outputcheck.getCount("JIPYO_IDX") > 0 ) {

				output = new DataObj();

				output.put("ERRCODE", "00001");
				output.put("ERRMSG", "지표값이 등록되어있어 삭제할 수 없습니다.");
				output.put("WINMSG", "지표값이 등록되어있어 삭제할 수 없습니다.");
				output.put("gdRes", null); // Grid Data

			} else {

				db = new MDaoUtil();
				db.begin();

				db.setData("RBA_90_01_02_02_delete_jrba_jipyo_m", input);

				db.commit();

				output = new DataObj();

				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
				output.put("gdRes", null); // Grid Data

			}
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

			Log.logAML(Log.ERROR, this, "doDelete", re.getMessage());

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

			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

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

}
