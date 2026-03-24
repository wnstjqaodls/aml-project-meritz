package com.gtone.aml.server.AML_10.AML_10_37.AML_10_37_01;

import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

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

public class AML_10_37_01_04 extends GetResultObject{
	private static AML_10_37_01_04 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return AML_10_37_01_01
	 */
	public static AML_10_37_01_04 getInstace() {
		return instance == null ? (instance = new AML_10_37_01_04()) : instance;
	}

	/**위험평가항목 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {

			if("Y".equals(input.get("CalSave"))) {
				output = MDaoUtilSingle.getData("AML_10_37_01_04_doSerch2_1", input);
			}else {
				output = MDaoUtilSingle.getData("AML_10_37_01_04_doSerch", input);
			}

			// grid data
			if ( output.getCount("RA_ITEM_CD") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
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

	/**위험평가항목상세 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearchGubun(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("AML_10_37_01_04_doSerch2", input);
			// grid data
			if ( output.getCount("RISK_ELMT_NM1") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGubun", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave(DataObj input) {

		DataObj output = null;
		MDaoUtil db = null;

		String RISK_SCR_NM1 = "";
		String RISK_SCR_NM2 = "";
		String RISK_SCR_NM3 = "";
		String RISK_SCR_NM4 = "";
		String RISK_SCR_NM5 = "";
		String RISK_SCR_NM6 = "";
		String RISK_SCR_NM7 = "";
		String RISK_SCR_NM13 = "";

		try {

			db = new MDaoUtil();
	    	db.begin();

	    	DataObj obj1 = new DataObj();

	    	obj1.put("RA_ITEM_CD"         , StringHelper.evl(input.get("RA_ITEM_CD")       , ""));
	    	obj1.put("RA_ITEM_CODE"       , StringHelper.evl(input.get("RA_ITEM_CODE")     , ""));
	    	obj1.put("RA_ITEM_NM"         , StringHelper.evl(input.get("RA_ITEM_NM")       , ""));

	    	obj1.put("RA_CORJOB_YN1"     , StringHelper.evl(input.get("RA_CORJOB_YN1")     , ""));
	    	obj1.put("RA_CORJOB_YN2"     , StringHelper.evl(input.get("RA_CORJOB_YN2")     , ""));
	    	obj1.put("RA_CORJOB_YN3"     , StringHelper.evl(input.get("RA_CORJOB_YN3")     , ""));
	    	obj1.put("RA_CORJOB_YN4"     , StringHelper.evl(input.get("RA_CORJOB_YN4")     , ""));
	    	obj1.put("RA_CORJOB_YN5"     , StringHelper.evl(input.get("RA_CORJOB_YN5")     , ""));
	    	obj1.put("RA_CORJOB_YN6"     , StringHelper.evl(input.get("RA_CORJOB_YN6")     , ""));
	    	obj1.put("RA_CORJOB_YN7"     , StringHelper.evl(input.get("RA_CORJOB_YN7")     , ""));
	    	obj1.put("RA_CORJOB_YN8"     , StringHelper.evl(input.get("RA_CORJOB_YN8")     , ""));
	    	obj1.put("RA_CORJOB_STA_YN1" , StringHelper.evl(input.get("RA_CORJOB_STA_YN1") , ""));
	    	obj1.put("RA_CORJOB_STA_YN2" , StringHelper.evl(input.get("RA_CORJOB_STA_YN2") , ""));
	    	obj1.put("RA_CORJOB_STA_YN3" , StringHelper.evl(input.get("RA_CORJOB_STA_YN3") , ""));
	    	obj1.put("RA_CORJOB_STA_YN4" , StringHelper.evl(input.get("RA_CORJOB_STA_YN4") , ""));
	    	obj1.put("RA_CORJOB_STA_YN5" , StringHelper.evl(input.get("RA_CORJOB_STA_YN5") , ""));
	    	obj1.put("HNDL_P_ENO"       , ((SessionHelper) input.get("SessionHelper")).getUserId());

	    	obj1.put("ABS_HRSK_YN"      , StringHelper.evl(input.get("ABS_HRSK_YN")        , ""));

	    	RISK_SCR_NM1  = StringHelper.evl(input.get("RISK_SCR_NM1"),"");
			RISK_SCR_NM2  = StringHelper.evl(input.get("RISK_SCR_NM2"),"");
			RISK_SCR_NM3  = StringHelper.evl(input.get("RISK_SCR_NM3"),"");
			RISK_SCR_NM4  = StringHelper.evl(input.get("RISK_SCR_NM4"),"");
			RISK_SCR_NM5  = StringHelper.evl(input.get("RISK_SCR_NM5"),"");
			RISK_SCR_NM6  = StringHelper.evl(input.get("RISK_SCR_NM6"),"");
			RISK_SCR_NM7  = StringHelper.evl(input.get("RISK_SCR_NM7"),"");
			RISK_SCR_NM13 = StringHelper.evl(input.get("RISK_SCR_NM13"),"");

			if("당연EDD".equals(RISK_SCR_NM1)) { RISK_SCR_NM1 = "Y"; }else { RISK_SCR_NM1 = "N"; }
			if("당연EDD".equals(RISK_SCR_NM2)) { RISK_SCR_NM2 = "Y"; }else { RISK_SCR_NM2 = "N"; }
			if("당연EDD".equals(RISK_SCR_NM3)) { RISK_SCR_NM3 = "Y"; }else { RISK_SCR_NM3 = "N"; }
			if("당연EDD".equals(RISK_SCR_NM4)) { RISK_SCR_NM4 = "Y"; }else { RISK_SCR_NM4 = "N"; }
			if("당연EDD".equals(RISK_SCR_NM5)) { RISK_SCR_NM5 = "Y"; }else { RISK_SCR_NM5 = "N"; }
			if("당연EDD".equals(RISK_SCR_NM6)) { RISK_SCR_NM6 = "Y"; }else { RISK_SCR_NM6 = "N"; }
			if("당연EDD".equals(RISK_SCR_NM7)) { RISK_SCR_NM7 = "Y"; }else { RISK_SCR_NM7 = "N"; }
			if("당연EDD".equals(RISK_SCR_NM13)) { RISK_SCR_NM13 = "Y"; }else { RISK_SCR_NM13 = "N"; }

	    	obj1.put("RA_CORJOB_EDD_YN1" , RISK_SCR_NM1);
	    	obj1.put("RA_CORJOB_EDD_YN2" , RISK_SCR_NM2);
	    	obj1.put("RA_CORJOB_EDD_YN3" , RISK_SCR_NM3);
	    	obj1.put("RA_CORJOB_EDD_YN4" , RISK_SCR_NM4);
	    	obj1.put("RA_CORJOB_EDD_YN5" , RISK_SCR_NM5);
	    	obj1.put("RA_CORJOB_EDD_YN6" , RISK_SCR_NM6);
	    	obj1.put("RA_CORJOB_EDD_YN7" , RISK_SCR_NM7);
	    	obj1.put("RA_CORJOB_EDD_YN8" , RISK_SCR_NM13);
	    	obj1.put("RA_CORJOB_STA1"    , StringHelper.evl(input.get("RISK_SCR_NM8")      , ""));
	    	obj1.put("RA_CORJOB_STA2"    , StringHelper.evl(input.get("RISK_SCR_NM9")      , ""));
	    	obj1.put("RA_CORJOB_STA3"    , StringHelper.evl(input.get("RISK_SCR_NM10")     , ""));
	    	obj1.put("RA_CORJOB_STA4"    , StringHelper.evl(input.get("RISK_SCR_NM11")     , ""));
	    	obj1.put("RA_CORJOB_STA5"    , StringHelper.evl(input.get("RISK_SCR_NM12")     , ""));

	    	db.setData("AML_10_37_01_04_MergeRECAL", obj1);
	    	db.setData("AML_10_37_01_04_MergeRECAL2", obj1);

	    	db.commit();
			if( obj1.size() > 0 ) {
				output = new DataObj();
				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
				output.put("gdRes", null); // Wise Grid Data
			}

		} catch (RuntimeException e) {
			try {
				if ( db != null ) {
					db.rollback();
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
			} catch (Exception ee) {
			}
		}
		return output;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj reCalcul(DataObj input) {
		DataObj output = null;
		DataObj output2 = null;
		DataObj output3 = null;
		
		List gdReq = null;

		MDaoUtil db = null;
		MDaoUtil db2 = null;
		String ra_ref_snccd = "";
		String ra_sn_ccd = "";
		String Rcorjob_seq = "";
		String corjob_seq = "";
		String ra_item_code = "";
		String upload_gubun = "";
	    int count1   = 0;

		try {
			db = new MDaoUtil();
            db.begin();

            db2 = new MDaoUtil();
            db2.begin();

            output3 = MDaoUtilSingle.getData("AML_10_37_01_04_APPR_ONE_SELECT", input);
            
            ra_item_code = output3.get("RA_ITEM_CODE").toString();
            
            output = MDaoUtilSingle.getData("AML_10_37_01_04_RECALCUL1", input);

            gdReq = (List)output.getRowsToMap();
            int rowcount = gdReq.size();
            for( int i=0 ; i < rowcount ; i++ ) {
            	HashMap inputMap = 	(HashMap)gdReq.get(i);
            	inputMap.put("HNDL_P_ENO" , ((SessionHelper) input.get("SessionHelper")).getUserId());
            	count1 = db.setData("AML_10_37_01_04_updateReCal_RA_ITEM_CORJOB_SCR_RE_CAL", inputMap);
            	db.commit();
            }

            ra_ref_snccd = input.get("RA_REF_SN_CCD").toString();
			ra_sn_ccd    = input.get("RA_SN_CCD").toString();
			upload_gubun = input.get("UPLOAD_GUBUN").toString();

            if("R".equals(ra_ref_snccd) || "N".equals(ra_sn_ccd)) {
            	Rcorjob_seq   = input.get("RA_SEQ").toString();
            	output.put("CORJOB_SEQ"		, Rcorjob_seq);
            	output.put("HNDL_P_ENO", ((SessionHelper) input.get("SessionHelper")).getUserId() );
            	output.put("RA_ITEM_CODE", ra_item_code);
            	
            	if("Z".equals(upload_gubun)) {
            		db2.setData("AML_10_37_01_04_MODI_APPR_ONE_MERGE_UPDATE2", output);
            	}else {
            		db2.setData("AML_10_37_01_04_MODI_APPR_ONE_MERGE_UPDATE", output);
            	}
            	db2.setData("AML_10_37_01_04_MODI_APPR_MERGE_UPDATE", output);
            	db2.setData("AML_10_37_01_04_RA_ITEM_CORJOB_SCR_REQ_MODI_SEQ", output);
            }else {
            	output2 = MDaoUtilSingle.getData("AML_10_37_01_04_MODI_APPR_INSERT_SEQ", input);
            	corjob_seq = output2.get("CORJOB_SEQ").toString();

            	output2.put("CORJOB_SEQ" , corjob_seq);
            	output2.put("RA_ITEM_CODE", ra_item_code);
            	if("Z".equals(upload_gubun)) {
            		db2.setData("AML_10_37_01_04_MODI_APPR_ONE_INSERT2", output2);
            	}else {
            		db2.setData("AML_10_37_01_04_MODI_APPR_ONE_INSERT", output2);
            	}
            	db2.setData("AML_10_37_01_04_MODI_APPR_INSERT", output2);
            	db2.setData("AML_10_37_01_04_RA_ITEM_CORJOB_SCR_REQ_MODI_SEQ", output2);
            }
        	db2.commit();

			if( count1 > 0 ) {
				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다.")); output.put("gdRes", null); // Wise Grid Data
			}
		} catch (RuntimeException e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
				if ( db2 != null ) {
					db2.rollback();
					db2.close();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "reCalcul", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "reCalcul", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				if ( db != null ) {
					db.rollback();
					db.close();
				}
				if ( db2 != null ) {
					db2.rollback();
					db2.close();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "reCalcul", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "reCalcul", e.getMessage());

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

	/**위험평가항목상세 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearch3(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {

			output = MDaoUtilSingle.getData("AML_10_37_01_02_doSerch3", input);

			// grid data
			if ( output.getCount("RA_ITEM_CD") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
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
}
