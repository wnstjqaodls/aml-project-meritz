/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.server.AML_10.AML_10_38.AML_10_38_01;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.user.SessionAML;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description 위험평가구간관리 共通コード管理 Common Code Mgt.
 * @Group GTONE, R&D센터/개발2본부
 * @Project AML/RBA/FATCA/CRS/WLF
 * @Since 2024. 8. 16.
 ******************************************************************************************************************************************
 *        /** 인스턴스
 */
public class AML_10_38_01_01 extends GetResultObject {
	private static AML_10_38_01_01 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 *
	 * @return AML_10_38_01_01
	 */
	public static AML_10_38_01_01 getInstance() {
		return instance == null ? (instance = new AML_10_38_01_01()) : instance;
	}

	public DataObj doSearch(DataObj input) {
		DataObj output = null;
		DataObj output2 = null;
		DataObj output3 = null;
		DataSet gdRes = null;

		String cs_typ_cd = "";
		String new_old_gbncd = "";
		String rankid        = "";
		try {

			cs_typ_cd     = input.get("CS_TYP_CD").toString();
			new_old_gbncd = input.get("NEW_OLD_GBN_CD").toString();
			rankid        = input.get("RANKID").toString();


			output2 = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD", input);

			output2.put("CS_TYP_CD"		 , cs_typ_cd);
			output2.put("NEW_OLD_GBN_CD" , new_old_gbncd);
			output2.put("RANKID" , rankid);

			output = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD2", output2);
			
			// grid data
			if (output.getCount("RA_GRD_NM") > 0) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG",
						MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				// output.put("WINMSG", MessageHelper.getInstance().getMessage("0001",
				// input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	public DataObj doSearch3(DataObj input) {
		DataObj output = null;
		DataObj output2 = null;
		DataSet gdRes = null;

		String cs_typ_cd = "";
		String new_old_gbncd = "";
		try {

			cs_typ_cd     = input.get("CS_TYP_CD").toString();
			new_old_gbncd = input.get("NEW_OLD_GBN_CD").toString();



			output2 = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD", input);

			output2.put("CS_TYP_CD"		 , cs_typ_cd);
			output2.put("NEW_OLD_GBN_CD" , new_old_gbncd);
			
			output = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD3", output2);
			// grid data
			if (output.getCount("JSON_RESULT") > 0) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG",
						MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				// output.put("WINMSG", MessageHelper.getInstance().getMessage("0001",
				// input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	public DataObj doSearch2(DataObj input) {
		DataObj output = null;
		DataObj output2 = null;
		DataSet gdRes = null;
		
		String cs_typ_cd = "";
		String new_old_gbncd = "";
		String rankid        = "";

		try {
			cs_typ_cd     = input.get("CS_TYP_CD").toString();
			new_old_gbncd = input.get("NEW_OLD_GBN_CD").toString();
			rankid        = input.get("RANKID").toString();

			output2 = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD_REQ", input);

			output2.put("CS_TYP_CD"		 , cs_typ_cd);
			output2.put("NEW_OLD_GBN_CD" , new_old_gbncd);
			output2.put("RANKID" , rankid);
			
			output = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD_REQ2", output2);
			
			// grid data
			if (output.getCount("RA_GRD_NM") > 0) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG",
						MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				// output.put("WINMSG", MessageHelper.getInstance().getMessage("0001",
				// input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	public DataObj doSearch4(DataObj input) {
		DataObj output = null;
		DataObj output2 = null;
		DataSet gdRes = null;

		String cs_typ_cd = "";
		String new_old_gbncd = "";
		try {

			cs_typ_cd     = input.get("CS_TYP_CD").toString();
			new_old_gbncd = input.get("NEW_OLD_GBN_CD").toString();



			output2 = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD_REQ", input);

			output2.put("CS_TYP_CD"		 , cs_typ_cd);
			output2.put("NEW_OLD_GBN_CD" , new_old_gbncd);
			
			output = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD_REQ3", output2);
			// grid data
			if (output.getCount("JSON_RESULT") > 0) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG",
						MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				// output.put("WINMSG", MessageHelper.getInstance().getMessage("0001",
				// input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	public DataObj getSearch(DataObj input) {
		DataObj output = null;
		DataObj output2 = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("AML_10_38_01_01_doSearch_RAITEM_STD_REQ_DETAIL", input);
			// grid data
			if (output.getCount("RA_GRD_NM") > 0) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG",
						MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				// output.put("WINMSG", MessageHelper.getInstance().getMessage("0001",
				// input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
			MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	@SuppressWarnings("rawtypes")
	public DataObj doSave(DataObj input) {
		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		MDaoUtil db = null;
		MDaoUtil db2 = null;
		String cs_typ_cd = "";
		String new_old_gbncd = "";
		String ra_ref_snccd = "";
		String ra_sn_ccd = "";
		String std_seq = "";
		String Rstd_seq = "";


		try {
			List gdReq = (List) input.get("gdReq");

			db = new MDaoUtil();
			db.begin();

			db2 = new MDaoUtil();
			db2.begin();

			cs_typ_cd     = input.get("CS_TYP_CD").toString();
			new_old_gbncd = input.get("NEW_OLD_GBN_CD").toString();
			ra_ref_snccd  = input.get("RA_REF_SN_CCD").toString();
			ra_sn_ccd     = input.get("RA_SN_CCD").toString();

			if("R".equals(ra_ref_snccd) || "N".equals(ra_sn_ccd)) {
				Rstd_seq = input.get("RA_SEQ").toString();
				output.put("STD_SEQ"		, Rstd_seq);
			}else {
				output2 = MDaoUtilSingle.getData("AML_10_38_01_01_MODI_APPR_INSERT_SEQ", input);
				std_seq = output2.get("STD_SEQ").toString();
				output2.put("STD_SEQ"       , std_seq);
				output.put("STD_SEQ"        , std_seq);
				output2.put("CS_TYP_CD"      , cs_typ_cd);
				output2.put("NEW_OLD_GBN_CD" , new_old_gbncd);
				db2.setData("AML_10_38_01_01_RA_ITEM_STD_REQ_PRE", output2);
				db2.commit();
			}

			HashMap map = null;
			for (int i = 0; i < gdReq.size(); i++) {

				map = (HashMap) gdReq.get(i);

				output.put("RA_GRD_SCR_MIN", StringHelper.evl(map.get("RA_GRD_SCR_MIN"), ""));
				output.put("RA_GRD_SCR_MAX", StringHelper.evl(map.get("RA_GRD_SCR_MAX"), ""));
				output.put("CS_TYP_CD", StringHelper.evl(map.get("CS_TYP_CD"), ""));
				output.put("NEW_OLD_GBN_CD", StringHelper.evl(map.get("NEW_OLD_GBN_CD"), ""));
				output.put("RA_GRD_CD", StringHelper.evl(map.get("RA_GRD_CD"), ""));

				output.put("UPD_ID", ((SessionHelper) input.get("SessionHelper")).getUserId() );

				db.setData("AML_10_38_01_01_update_RA_ITEM_STD_APPR", output);
				db.setData("AML_10_38_01_01_update_RA_ITEM_STD_REQ", output);


			}

				db.commit();
				output = new DataObj();
				output.put("ERRCODE", "00000");
				output.put("ERRMSG",
						MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
				output.put("WINMSG",
						MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
				output.put("gdRes", null); // Wise Grid Data


		} catch (RuntimeException e) {
			try {
				if (db != null) {
					db.rollback();
				}
				if (db2 != null) {
					db2.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				if (db != null) {
					db.rollback();
				}
				if (db2 != null) {
					db2.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if (db != null) {
					db.close();
				}
				if (db2 != null) {
					db2.close();
				}
			} catch (Exception ee) {
			}
		}
		return output;
	}
	
	@SuppressWarnings("rawtypes")
	public DataObj doSave2(DataObj input) {
		DataObj output = new DataObj();
		MDaoUtil db = null;

		String cs_typ_cd = "";
		String new_old_gbncd = "";

		try {
			db = new MDaoUtil();
			db.begin();

			cs_typ_cd     = input.get("CS_TYP_CD").toString();
			new_old_gbncd = input.get("NEW_OLD_GBN_CD").toString();

			output.put("CS_TYP_CD"      , cs_typ_cd);
			output.put("NEW_OLD_GBN_CD" , new_old_gbncd);
			db.setData("AML_10_38_01_01_doSearch_RAITEM_STD_SIMUL", output);
			db.commit();
			
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG",
					MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Wise Grid Data


		} catch (RuntimeException e) {
			try {
				if (db != null) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				if (db != null) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if (db != null) {
					db.close();
				}
			} catch (Exception ee) {
			}
		}
		return output;
	}

	@SuppressWarnings("rawtypes")
	public DataObj doInitial(DataObj input) {
		DataObj output = new DataObj();
		MDaoUtil db = null;

		String cs_typ_cd = "";
		String new_old_gbncd = "";
		String rs_seq = "";

		try {
			db = new MDaoUtil();
			db.begin();

			cs_typ_cd     = input.get("CS_TYP_CD").toString();
			new_old_gbncd = input.get("NEW_OLD_GBN_CD").toString();
			rs_seq        = input.get("RA_SEQ").toString();

			output.put("CS_TYP_CD"      , cs_typ_cd);
			output.put("NEW_OLD_GBN_CD" , new_old_gbncd);
			output.put("RA_SEQ" , rs_seq);
			
			db.setData("AML_10_38_01_01_doSearch_RAITEM_STD_INITIAL", output);
			db.setData("AML_10_38_01_01_doSearch_RAITEM_STD_INITIAL2", output);
			db.commit();
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG",
					MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Wise Grid Data


		} catch (RuntimeException e) {
			try {
				if (db != null) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				if (db != null) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if (db != null) {
					db.close();
				}
			} catch (Exception ee) {
			}
		}
		return output;
	}
	
	
	/**
	 * 위험평가 항목 가중치 삭제
	 */
	@SuppressWarnings({ "rawtypes", "deprecation" })
	public DataObj doDelete(DataObj input) {
		DataObj output = null;
		MDaoUtil db = null;
		try {
			// [1] INPUT
			List gdReq = (List) input.get("gdReq");

			// [3] DB Access
			db = new MDaoUtil();
			db.begin();
			output = new DataObj();

			for (int i = 0; i < gdReq.size(); i++) {

				HashMap map = (HashMap) gdReq.get(i);

				if (!"I".equals(map.get("IDU"))) {

					map.put("CS_TYP_CD", StringHelper.evl(map.get("CS_TYP_CD"), ""));
					map.put("NEW_OLD_GBN_CD", StringHelper.evl(map.get("NEW_OLD_GBN_CD"), ""));
					map.put("RA_ITEM_CD", StringHelper.evl(map.get("RA_ITEM_CD"), ""));
					map.put("UPD_ID", ((SessionHelper) input.get("SessionHelper")).getUserId() );

					db.setData("AML_10_38_01_01_delete", map);

					if ("E".equals(input.getText("app_status"))) {
						db.setData("AML_10_38_01_01_updateRA_CS_TYP_MNG", map);
					}
				}
			}
			db.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG",
					MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Wise Grid Data
		} catch (RuntimeException e) {
			try {
				if (db != null) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				if (db != null) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG",
					MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if (db != null) {
					db.close();
				}
			} catch (Exception ee) {
			}
		}
		return output;
	}

	/**
	 * RA위험평가 가중치 결재 요청( 최초결재요청 )
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj firstAppRequest(DataObj input ) throws AMLException {
        DataObj     output     = new DataObj();

        String     ERRCODE = "";
        String     ERRMSG  = "";
        String     WINMSG  = "";
        DataObj output2 = new DataObj();
        DataObj output3 = new DataObj();
        String APP_NO = "";
        int count = 0;
        String strAPP_NO = "";
        MDaoUtil db = null;
        Date date = new Date();
        try {

        	db = new MDaoUtil();
            db.begin();

			String curDay = new SimpleDateFormat("yyyyMMdd").format(date);
			if(input.size() > 0) {
			HashMap amlApprMap = new HashMap();

			amlApprMap.clear();

        	//amlApprMap.put("APP_NO",    0);
        	strAPP_NO = input.get("APP_NO").toString();

        	amlApprMap.put("GYLJ_LINE_G_C", "RA3");
        	amlApprMap.put("APP_DT", curDay);
        	amlApprMap.put("REG_DT", curDay);
        	amlApprMap.put("WLR_SQ", 0);

        	if( strAPP_NO.isEmpty() || "0".equals(strAPP_NO)) {
            	output2 = MDaoUtilSingle.getData("get_APP_NO_SEQ", amlApprMap);
            	APP_NO = output2.getText("APP_NO");
            	amlApprMap.put("APP_NO", APP_NO);
        	} else {
        		amlApprMap.put("APP_NO", input.get("APP_NO"));
        	}

        	//REG_DT
        	amlApprMap.put("SNO",           input.get("SNO"));
        	amlApprMap.put("SN_CCD",      input.get("SN_CCD"));

        	//그리드 내 결재상태가 반려이면
			if ("R".equals(input.get("SN_CCD")) ) {
				amlApprMap.put("APP_NO", input.get("APP_NO")); //결재번호(FKEY)
				amlApprMap.put("SN_CCD", "S");
				// 반려건 재결재일때 SNO 1로 셋팅하도록 변경. 20220602
				//saveApp.put("SNO", inputMap.get("SNO"));
				amlApprMap.put("SNO", "1");

			}

        	amlApprMap.put("BRN_CD",        ((SessionAML)input.get("SessionAML")).getsAML_BDPT_CD());
        	//HNDL_DY_TM
        	amlApprMap.put("HNDL_P_ENO",    ((SessionHelper)input.get("SessionHelper")).getUserId());

        	amlApprMap.put("APPR_ROLE_ID",  ((SessionAML)input.get("SessionAML")).getsAML_ROLE_ID());


        	/* 테이블: RA_GRD_APPR 변경 시 사용됨 */
        	amlApprMap.put("CS_TYP_CD", input.get("CS_TYP_CD"));
        	amlApprMap.put("NEW_OLD_GBN_CD", input.get("NEW_OLD_GBN_CD"));

        	output3 = MDaoUtilSingle.getData("getAMLApprParam", amlApprMap);
        	//TARGET_ROLE_ID
        	amlApprMap.put("TARGET_ROLE_ID",  output3.get("TARGET_ROLE_ID"));
        	amlApprMap.put("NUM_SQ", output3.getInt("NUM_SQ"));
        	//amlApprMap.put("SNO", output3.get("SNO"));
        	amlApprMap.put("TARGET_ROLE_ID", output3.get("TARGET_ROLE_ID"));
        	amlApprMap.put("PRV_APP_NO", "");
        	amlApprMap.put("RSN_CNTNT", input.getText("SN_CMNT"));

        	//거절(반려)
			if ("R".equals(input.get("SN_CCD")) ) {
				count = db.setData("AML_10_17_01_01_AmlAppr_Merge", amlApprMap);   //AML_10_39_01_01_AmlAppr_ReNewInsert
				db.setData("AML_10_39_01_01_AmlApprHist_Insert", amlApprMap);	//AML_APPR_HIST : 결재이력
			}
			//승인
			else if ("S".equals(amlApprMap.get("SN_CCD")) )
			{
            	//결재정보 저장
				count = db.setData("AML_10_39_01_01_AmlAppr_Insert", amlApprMap); //AML_APPR : 결재

				if(count > 0) {
					db.setData("AML_10_39_01_01_AmlApprHist_Insert", amlApprMap);	//AML_APPR_HIST : 결재이력
					//위험평가항목 가중치 결재 요청 정보 저장
					db.setData("AML_10_38_01_01_insertRA_ITEM_WGHT_APPR", amlApprMap);
                	//위험평가항목 가중치 기준결재상세
                	db.setData("AML_10_38_01_01_insertRA_ITEM_WGHT_APPR_DTL", amlApprMap);
                	//위험평가항목 가중치 결재 시 결재ID 업데이트
                	db.setData("AML_10_38_01_01_updateRA_CS_TYP_MNG_APPNO", amlApprMap);
				}
			}

                db.commit();

                ERRCODE = "00000";
                ERRMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
                WINMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
            }
            else {
                ERRMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
                ERRCODE = "00099";
                WINMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
            }
        } catch(AMLException e) {
			if (db != null) {
				db.rollback();
			}
			Log.logAML(Log.ERROR, this, "insertCode_Body", e.getMessage());

			ERRCODE = "00001";
			ERRMSG = MessageHelper.getInstance().getMessage("0004", input.getText("LANG_CD"), "알수 없는 오류입니다.");
			WINMSG = MessageHelper.getInstance().getMessage("0004", input.getText("LANG_CD"), "알수 없는 오류입니다.");
        } finally {
			try {
				if (db != null) {
					db.close();
				}
			} catch (Exception e) {
			}
        }

		output.put("ERRCODE",ERRCODE);
		output.put("ERRMSG",ERRMSG);
		output.put("WINMSG",WINMSG);

		return output;
	}

	/**
	 * RA위험평가 가중치,등급 적용처리
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj applySave(DataObj input ) throws AMLException {

        int count = 0;
        String ERRCODE = "";
        String ERRMSG  = "";
        String WINMSG  = "";
        String ORDERNO = "";
        String curDay = "";
        Date date = new Date();
        DataObj output     = new DataObj();
        DataObj output2 = new DataObj();
        DataObj output3 = new DataObj();
        DataObj chkRAWK_ST = new DataObj();
        DataObj chk_WGT_GRD_REQ = new DataObj();
        MDaoUtil db = null;
        HashMap amlApprMap = null;
        try {

        	db = new MDaoUtil();
            db.begin();

			if(input.size() > 0) {
				//RA배치실행여부 체크
	        	chkRAWK_ST = MDaoUtilSingle.getData("CNT_SMUL_SNCCD_S", input);

				String countSMUL = chkRAWK_ST.getText("CNT");

				if("0".equals(countSMUL)) {
					curDay = new SimpleDateFormat("yyyyMMdd").format(date);
					ORDERNO = input.getText("ORDERNO");  /* 1: 가중치, 2 : 등급*/
					amlApprMap = new HashMap();
					amlApprMap.clear();

					output2 = MDaoUtilSingle.getData("get_APP_NO_SEQ", amlApprMap);
					amlApprMap.put("APP_NO", output2.getText("APP_NO"));


		        	amlApprMap.put("GYLJ_LINE_G_C", input.getText("GYLJ_LINE_G_C"));
		        	amlApprMap.put("APP_DT", curDay);
		        	amlApprMap.put("REG_DT", curDay);
		        	amlApprMap.put("WLR_SQ", 0);
		        	amlApprMap.put("SNO", input.getText("SNO"));
		        	amlApprMap.put("SN_CCD", input.get("SN_CCD"));
		        	amlApprMap.put("BRN_CD", ((SessionAML)input.get("SessionAML")).getsAML_BDPT_CD());
		        	amlApprMap.put("HNDL_P_ENO", ((SessionHelper)input.get("SessionHelper")).getUserId());
		        	amlApprMap.put("APPR_ROLE_ID", ((SessionAML)input.get("SessionAML")).getsAML_ROLE_ID());
		        	amlApprMap.put("RSN_CNTNT", input.getText("SN_CMNT"));
		        	amlApprMap.put("TARGET_ROLE_ID",  "0");
		        	amlApprMap.put("PRV_APP_NO", "");

		        	output3 = MDaoUtilSingle.getData("getAMLApprParam", amlApprMap);
		        	amlApprMap.put("NUM_SQ", output3.getInt("NUM_SQ"));

		        	/* 테이블: RA_GRD_APPR 변경 시 사용됨 */
		        	amlApprMap.put("CS_TYP_CD", input.get("CS_TYP_CD"));
		        	amlApprMap.put("NEW_OLD_GBN_CD", input.get("NEW_OLD_GBN_CD"));

	            	//결재정보 저장
					count = db.setData("AML_10_39_01_01_AmlAppr_Insert", amlApprMap); //AML_APPR : 결재

					if(count > 0) {
						db.setData("AML_10_39_01_01_AmlApprHist_Insert", amlApprMap);	//AML_APPR_HIST : 결재이력
					}

					if("1".equals(ORDERNO)) {
						//위험평가항목 가중치 결재 요청 정보 저장
						db.setData("AML_10_38_01_01_insertRA_ITEM_WGHT_APPR", amlApprMap);
	                	//위험평가항목 가중치 기준결재상세
	                	db.setData("AML_10_38_01_01_insertRA_ITEM_WGHT_APPR_DTL", amlApprMap);
	                	//위험평가항목 가중치 결재 시 결재ID 업데이트
	                	db.setData("AML_10_38_01_01_updateRA_CS_TYP_MNG_APPNO", amlApprMap);
	                	//기존 WGHT 삭제
	                	db.setData("AML_10_38_01_01_delete_RA_ITEM_WGHT", amlApprMap);

	                	chk_WGT_GRD_REQ = MDaoUtilSingle.getData("CHK_CS_WGT_REQ", input);

        				String countREQ = chk_WGT_GRD_REQ.getText("CNT");

        				if(!"0".equals(countREQ)) {
        					//WGHT_REQ을 WGHT에 INSERT
        					db.setData("AML_10_38_01_01_insert_RA_ITEM_WGHT", amlApprMap);
        				}
					}
					if("2".equals(ORDERNO)) {
						//위험평가등급 결재 요청 정보 저장
						db.setData("AML_10_39_01_01_insertRA_GRD_APPR", amlApprMap);
		            	//위험평가등급 기준결재상세
		            	db.setData("AML_10_39_01_01_insertRA_GRD_APPR_DTL", amlApprMap);
		            	//위험평가등급 결재 시 결재ID 업데이트
		            	db.setData("AML_10_39_01_01_updateRA_CS_TYP_MNG_APPNO", amlApprMap);
		            	// 기존GRD 삭제
		            	db.setData("AML_10_39_01_01_delete_RA_GRD_STD", amlApprMap);

		            	chk_WGT_GRD_REQ = MDaoUtilSingle.getData("CHK_CS_GRD_REQ", input);

        				String countREQ = chk_WGT_GRD_REQ.getText("CNT");

        				if(!"0".equals(countREQ)) {
        					//GRD_REQ을 GRD에 INSERT
        					db.setData("AML_10_39_01_01_insert_RA_GRD_STD", amlApprMap);
        				}
					}
				}else {
					db.rollback();
					ERRCODE = "00001";
					ERRMSG = MessageHelper.getInstance().getMessage("0063", input.getText("LANG_CD"), "배치실행중인 RA가 존재합니다. 작업이 완료된 후 진행해주세요.");
					WINMSG = MessageHelper.getInstance().getMessage("0063", input.getText("LANG_CD"), "배치실행중인 RA가 존재합니다. 작업이 완료된 후 진행해주세요.");
				}

                db.commit();

                ERRCODE = "00000";
                ERRMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
                WINMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
            }
            else {
                ERRMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
                ERRCODE = "00099";
                WINMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
            }
        }catch(AMLException e){
			if (db != null) {
				db.rollback();
			}
			Log.logAML(Log.ERROR, this, "applySave", e.getMessage());

			ERRCODE = "00001";
			ERRMSG = MessageHelper.getInstance().getMessage("0004", input.getText("LANG_CD"), "알수 없는 오류입니다.");
			WINMSG = MessageHelper.getInstance().getMessage("0004", input.getText("LANG_CD"), "알수 없는 오류입니다.");
        }finally{
			try {
				if (db != null) {
					db.close();
				}
			} catch (Exception e) {}
        }

        output.put("ERRCODE",ERRCODE);
        output.put("ERRMSG",ERRMSG);
        output.put("WINMSG",WINMSG);

        return output;
	}
}