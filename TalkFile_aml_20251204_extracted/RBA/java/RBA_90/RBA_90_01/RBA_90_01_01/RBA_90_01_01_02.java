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
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

/******************************************************************************************************************************************
 * @Description 보고기준일등록
 * @Group       GTONE, R&D센터
 * @Project     RBA
 * @Java        7.0 이상
 * @Author      이혁준
 * @Since       2018. 12. 04.
 ******************************************************************************************************************************************/

public class RBA_90_01_01_02 extends GetResultObject {

	/**************************************************************************************************************************************
	 * Attributes
	 **************************************************************************************************************************************/

	/** 인스턴스 */
	private static RBA_90_01_01_02 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return RBA_90_01_01_02
	 */
	public static  RBA_90_01_01_02 getInstance() {
		synchronized(RBA_90_01_01_02.class) {  
			if (instance == null) {
				instance = new RBA_90_01_01_02();
			}
		}
		return instance;
	}

	/**
	 * RBA보고지표 관련 테이블 복사처리(JRBA_RPT_BAS_M, JRBA_GRP_C, JRBA_DTL_C, JRBA_JIPYO_M, JRBA_JIPYO_BAS_I, JRBA_RPT_RST_M) <br>
	 * <p>
	 * @param   input
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(저장처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 */
	public DataObj saveTable(DataObj input) throws AMLException {

		DataObj output = null;
		MDaoUtil db = null;

		int CHK_BAS_CD = 0;
		int CHK_JIPYO = 0;

		try {
			CHK_BAS_CD = input.getInt("CHK_BAS_CD");
			CHK_JIPYO = input.getInt("CHK_JIPYO");

			// 이미 등록된 보고기준일인지 중복체크  20181211
			String query_id = "RBA_90_01_01_02_saveCon";
			output = MDaoUtilSingle.getData(query_id, input);
			boolean isExist = "0".equals(output.getText("CNT")) ? false : true;
			if ( isExist ) {
				Log.logAML(Log.ERROR, this, "saveTable", "보고기준일이 이미 등록되어 있습니다.");
				output = new DataObj();
				output.put("ERRCODE", "00001");
				output.put("ERRMSG", "보고기준일이 이미 등록되어 있습니다.");
				output.put("WINMSG", "보고기준일이 이미 등록되어 있습니다.");

				return output;
			}

			// ////////// DR_DT, CHG_OP_JKW_NO, DR_OP_JKW_NO 받아오기
			//			@SuppressWarnings("unused")
			//			SessionAML sess = (SessionAML) input.get("SessionAML");

			db = new MDaoUtil();

			db.begin();

			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
			input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 등록조작자번호
			// ///////////////////////////////////////////////////////////////////////////////////////

			String COPY_RPT_GJDT = (String) input.getText("COPY_RPT_GJDT");
			if ( COPY_RPT_GJDT == null || "".equals(COPY_RPT_GJDT) ) {
				COPY_RPT_GJDT = "99991231";
				input.set("COPY_RPT_GJDT", COPY_RPT_GJDT);

			}

			// RBA보고기본
			db.setData("RBA_90_01_01_02_delete_jrba_rpt_bas_m", input); // delete JRBA_RPT_BAS_M
			db.setData("RBA_90_01_01_02_insert_jrba_rpt_bas_m", input); // insert JRBA_RPT_BAS_M		        

			// 지표기준코드정보
			if ( CHK_BAS_CD == 1 ) {

				// RBA보고그룹코드
				db.setData("RBA_90_01_01_02_delete_jrba_grp_c", input); // delete JRBA_GRP_C
				db.setData("RBA_90_01_01_02_insert_jrba_grp_c", input); // insert JRBA_GRP_C	        

				// RBA상세코드정보
				db.setData("RBA_90_01_01_02_delete_jrba_dtl_c", input); // delete JRBA_DTL_C
				db.setData("RBA_90_01_01_02_insert_jrba_dtl_c", input); // insert JRBA_DTL_C	        

			}

			// //////////////////////// 보고지표코드 ///////////////////////////////////////
			if ( CHK_JIPYO == 1 ) {

				// RBA보고지표
				db.setData("RBA_90_01_01_02_delete_jrba_jipyo_m", input); // delete JRBA_JIPYO_M
				db.setData("RBA_90_01_01_02_insert_jrba_jipyo_m", input); // insert JRBA_JIPYO_M

				// RBA보고지표 기준관리
				db.setData("RBA_90_01_01_02_delete_jrba_jipyo_bas_i", input); // delete JRBA_JIPYO_BAS_I
				db.setData("RBA_90_01_01_02_insert_jrba_jipyo_bas_i", input); // insert JRBA_JIPYO_BAS_I

				// RBA보고결과 관리
				db.setData("RBA_90_01_01_02_delete_jrba_rpt_rst_m", input); // delete JRBA_RPT_RST_M
				db.setData("RBA_90_01_01_02_insert_jrba_rpt_rst_m", input); // insert JRBA_RPT_RST_M		        
			}

			////////////////////////	배치기준일 ///////////////////////////////////////////
			//배치기준일 등록
			//db.setData("RBA_10_05_01_02_update_BT_BAS_DT", input);

			db.commit();

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
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
			Log.logAML(Log.ERROR, this, "saveTable", re.getMessage());
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
			Log.logAML(Log.ERROR, this, "saveTable", re.getMessage());
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
			Log.logAML(Log.ERROR, this, "saveTable", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		} finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (RuntimeException ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
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
