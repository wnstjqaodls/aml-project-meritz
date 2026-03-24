/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.server.AML_10.AML_10_39.AML_10_39_01;

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
 * @Description 위험분류/평가 항목별 가중치관리
 *              共通コード管理
 *              Common Code Mgt.
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     AML/RBA/FATCA/CRS/WLF
 * @Since       2024. 8. 16.
 ******************************************************************************************************************************************
	/** 인스턴스 */
public class AML_10_39_01_01 extends GetResultObject {
	private static AML_10_39_01_01 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return AML_10_39_01_01
	 */
	public static AML_10_39_01_01 getInstance() {
		return instance == null ? (instance = new AML_10_39_01_01()) : instance;
	}

	public DataObj getSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {

			output = MDaoUtilSingle.getData("AML_10_39_01_01_doSearch_RAGRDSTD_Master", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("CS_TYP_CD") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearch", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	public DataObj getSearch2(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {

			output = MDaoUtilSingle.getData("AML_10_39_01_01_doSearch_RAGRDSTD_Master2", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("RA_GRD_SEQ") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearch", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	public DataObj getSearch3(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {

			output = MDaoUtilSingle.getData("AML_10_39_01_01_doSearch_RAGRDSTD_Master3", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("CS_TYP_CD") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearch3", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearch4(DataObj input) {
		DataObj output = null;
		
		MDaoUtil db = null;
		int count1   = 0;
		List gdReq = null;
		try {

			db = new MDaoUtil();
            db.begin();
			
			output = MDaoUtilSingle.getData("AML_10_39_01_01_doSearch_RAGRDSTD_Master4", (HashMap<Object, Object>) input);
			
			gdReq = (List)output.getRowsToMap();
			int rowcount = gdReq.size();
			for( int i=0 ; i < rowcount ; i++ ) {
				HashMap inputMap = 	(HashMap)gdReq.get(i);
				inputMap.put("CS_TYP_CD", input.get("CS_TYP_CD").toString());
            	count1 = db.setData("AML_10_39_01_01_update_RAGRDSTD", inputMap);
            }
            db.commit();
			
			// grid data
			if ( count1 > 0 ) {
				output.put("ERRCODE", "00000");
				//output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
				//output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다.")); output.put("gdRes", null); // Wise Grid Data
			}
		} catch (RuntimeException e) {
			try {
				if ( db != null ) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "getSearch4", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "getSearch4", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				if ( db != null ) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "getSearch4", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "getSearch4", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (Exception ee) {
			}
		}
		return output;
	}

	public DataObj doSearchDetail(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			output = MDaoUtilSingle.getData("AML_10_39_01_01_doSearch_RAGRDSTD_Detail", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("RA_GRD_SCR_MAX") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	public static boolean hasDuplicates(String[] array) {
        Set<String> set = new HashSet<>();
        return Arrays.stream(array).anyMatch(e -> !set.add(e));
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave(DataObj input) throws AMLException {
		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		MDaoUtil db = null;
		MDaoUtil db2 = null;

		String Rwght_seq = "";
		String wght_seq = "";
		String ra_item_cd = "";
		String cs_typ_cd = "";
		String new_old_gbncd = "";
		String ra_ref_snccd = "";
		String ra_sn_ccd = "";

		try {

			List gdReq = (List) input.get("gdReq");

			db = new MDaoUtil();
			db.begin();

			db2 = new MDaoUtil();
			db2.begin();

			ra_ref_snccd  = input.get("RA_REF_SN_CCD").toString();
			ra_item_cd    = input.get("RA_ITEM_CD").toString();
			cs_typ_cd     = input.get("CS_TYP_CD").toString();
			new_old_gbncd = input.get("NEW_OLD_GBN_CD").toString();
			ra_sn_ccd     = input.get("RA_SN_CCD").toString();

			if("R".equals(ra_ref_snccd) || "N".equals(ra_sn_ccd)) {
				Rwght_seq = input.get("RA_SEQ").toString();
				output.put("WGHT_SEQ"		, Rwght_seq);
			}else {
				output2 = MDaoUtilSingle.getData("AML_10_39_01_01_MODI_APPR_INSERT_SEQ", input);
				wght_seq = output2.get("WGHT_SEQ").toString();
				output2.put("WGHT_SEQ"       , wght_seq);
				output.put("WGHT_SEQ"        , wght_seq);
				output2.put("CS_TYP_CD"      , cs_typ_cd);
				output2.put("NEW_OLD_GBN_CD" , new_old_gbncd);
				db2.setData("AML_10_39_01_01_RA_ITEM_WGHT_REQ_PRE", output2);
				db2.commit();
			}

			HashMap map = null;
			for ( int i = 0; i < gdReq.size(); i++ ) {
				map = (HashMap) gdReq.get(i);

				output.put("RA_ITEM_A_WGHT", StringHelper.evl(map.get("RA_ITEM_A_WGHT"), ""));
				output.put("RA_ITEM_B_WGHT", StringHelper.evl(map.get("RA_ITEM_B_WGHT"), ""));
				output.put("CS_TYP_CD", StringHelper.evl(map.get("CS_TYP_CD"), ""));
				output.put("NEW_OLD_GBN_CD", StringHelper.evl(map.get("NEW_OLD_GBN_CD"), ""));
				output.put("RA_ITEM_CD", StringHelper.evl(map.get("RA_ITEM_CD"), ""));

				output.put("UPD_ID", ((SessionHelper) input.get("SessionHelper")).getUserId() );

				db.setData("AML_10_39_01_01_update_RA_ITEM_WGHT_APPR", output);
				db.setData("AML_10_39_01_01_update_RA_ITEM_WGHT_REQ", output);
				db.setData("AML_10_39_01_01_update_RA_ITEM_WGHT_REQ2", output);

			}
			db.commit();

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Wise Grid Data

		} catch (RuntimeException e) {
			try {
				if ( db != null ) {
					db.rollback();
				}
				if ( db2 != null ) {
					db2.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				if ( db != null ) {
					db.rollback();
				}
				if ( db2 != null ) {
					db2.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
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
				if ( db2 != null ) {
					db2.close();
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
			
			db.setData("AML_10_39_01_01_doSearch_RAITEM_WGHT_INITIAL", output);
			db.setData("AML_10_39_01_01_doSearch_RAITEM_WGHT_INITIAL2", output);
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
			db.setData("AML_10_39_01_01_doSearch_RAITEM_WGHT_SIMUL", output);
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
	
	public DataObj getSearch5(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {

			output = MDaoUtilSingle.getData("AML_10_39_01_01_doSearch_RAGRDSTD_Master5", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("RA_GRD_SEQ") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearch5", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

}