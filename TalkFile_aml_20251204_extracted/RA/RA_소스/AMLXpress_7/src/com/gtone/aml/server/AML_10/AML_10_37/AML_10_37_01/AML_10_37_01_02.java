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

public class AML_10_37_01_02 extends GetResultObject{
	private static AML_10_37_01_02 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return AML_10_37_01_01
	 */
	public static AML_10_37_01_02 getInstace() {
		return instance == null ? (instance = new AML_10_37_01_02()) : instance;
	}

	/**위험평가항목 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {

			if("Y".equals(input.get("CalSave"))) {
				output = MDaoUtilSingle.getData("AML_10_37_01_02_doSerch2_1", input);
			}else {
				output = MDaoUtilSingle.getData("AML_10_37_01_02_doSerch", input);
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

			output = MDaoUtilSingle.getData("AML_10_37_01_02_doSerch2", input);

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

		String RISK_SCR_1;
		String RISK_SCR_2;
		String RISK_SCR_3;
		String RISK_SCR_4;
		String RISK_SCR_5;
		String RISK_SCR_6;
		String RISK_SCR_7;
		String RISK_SCR_8;
		String RISK_SCR_9;
		String RISK_SCR_10;
		String RISK_SCR_11;
		String RISK_SCR_12;
		
		try {

			db = new MDaoUtil();
	    	db.begin();

	    	DataObj obj1 = new DataObj();
	    	
	    	output = MDaoUtilSingle.getData("AML_10_37_01_06_doSerch4", input);
            
	    	RISK_SCR_1  = output.get("RISK_SCR_NM1").toString();
	    	RISK_SCR_2  = output.get("RISK_SCR_NM2").toString();
	    	RISK_SCR_3  = output.get("RISK_SCR_NM3").toString();
	    	RISK_SCR_4  = output.get("RISK_SCR_NM4").toString();
	    	RISK_SCR_5  = output.get("RISK_SCR_NM5").toString();
	    	RISK_SCR_6  = output.get("RISK_SCR_NM6").toString();
	    	RISK_SCR_7  = output.get("RISK_SCR_NM7").toString();
	    	RISK_SCR_8  = output.get("RISK_SCR_NM8").toString();
	    	RISK_SCR_9  = output.get("RISK_SCR_NM9").toString();
	    	RISK_SCR_10 = output.get("RISK_SCR_NM10").toString();
	    	RISK_SCR_11 = output.get("RISK_SCR_NM11").toString();
	    	RISK_SCR_12 = output.get("RISK_SCR_NM12").toString();
	    	

	    	obj1.put("RA_ITEM_CD"         , StringHelper.evl(input.get("RA_ITEM_CD")        , ""));
	    	obj1.put("RA_ITEM_CODE"       , StringHelper.evl(input.get("RA_ITEM_CODE")      , ""));
	    	obj1.put("RA_ITEM_NM"         , StringHelper.evl(input.get("RA_ITEM_NM")        , ""));
	    	obj1.put("FATF_BLACK_LIST_YN" , StringHelper.evl(input.get("FATF_BLACK_LIST_YN"), ""));
	    	obj1.put("FATF_GREY_LIST_YN"  , StringHelper.evl(input.get("FATF_GREY_LIST_YN") , ""));
	    	obj1.put("FINCEN_LIST_YN"     , StringHelper.evl(input.get("FINCEN_LIST_YN")    , ""));
	    	obj1.put("UN_SANTIONS_YN"     , StringHelper.evl(input.get("UN_SANTIONS_YN")    , ""));
	    	obj1.put("OFAC_SANTIONS_YN"   , StringHelper.evl(input.get("OFAC_SANTIONS_YN")  , ""));
	    	obj1.put("OECD_YN"            , StringHelper.evl(input.get("OECD_YN")           , ""));
	    	obj1.put("TICPI_CPI_IDX"      , StringHelper.evl(input.get("TICPI_CPI_IDX")     , ""));
	    	obj1.put("INCRS_PROD_YN"      , StringHelper.evl(input.get("INCRS_PROD_YN")     , ""));
	    	obj1.put("INCRS_CHEM_YN"      , StringHelper.evl(input.get("INCRS_CHEM_YN")     , ""));
	    	obj1.put("EU_SANTIONS_YN"     , StringHelper.evl(input.get("EU_SANTIONS_YN")    , ""));
	    	obj1.put("EU_HRT_YN"          , StringHelper.evl(input.get("EU_HRT_YN")         , ""));
	    	obj1.put("BASEL_RIK_IDX"      , StringHelper.evl(input.get("BASEL_RIK_IDX")     , ""));
	    	obj1.put("HNDL_P_ENO"         , ((SessionHelper) input.get("SessionHelper")).getUserId());
	    	
	    	obj1.put("RISK_SCR_1"         , RISK_SCR_1);
	    	obj1.put("RISK_SCR_2"         , RISK_SCR_2);
	    	obj1.put("RISK_SCR_3"         , RISK_SCR_3);
	    	obj1.put("RISK_SCR_4"         , RISK_SCR_4);
	    	obj1.put("RISK_SCR_5"         , RISK_SCR_5);
	    	obj1.put("RISK_SCR_6"         , RISK_SCR_6);
	    	obj1.put("RISK_SCR_7"         , RISK_SCR_7);
	    	obj1.put("RISK_SCR_8"         , RISK_SCR_8);
	    	obj1.put("RISK_SCR_9"         , RISK_SCR_9);
	    	obj1.put("RISK_SCR_10"        , RISK_SCR_10);
	    	obj1.put("RISK_SCR_11"        , RISK_SCR_11);
	    	obj1.put("RISK_SCR_12"        , RISK_SCR_12);
	    	

	    	db.setData("AML_10_37_01_02_MergeRECAL", obj1);
	    	db.setData("AML_10_37_01_02_MergeRECAL2", obj1);
	    	
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
		DataObj output4 = null;
		
		List gdReq = null;

		MDaoUtil db = null;
		MDaoUtil db2 = null;
		MDaoUtil db3 = null;

		String ra_ref_snccd = "";
		String ra_sn_ccd = "";
		String Rntnjob_seq = "";
		String ntnjob_seq = "";
		String ra_item_code = "";
		String upload_gubun = "";
		
	    int count1   = 0;
		int count2   = 0;

		try {
			db = new MDaoUtil();
            db.begin();

            db2 = new MDaoUtil();
            db2.begin();

            db3 = new MDaoUtil();
            db3.begin();

            output4 = MDaoUtilSingle.getData("AML_10_37_01_02_APPR_ONE_SELECT", input);
            
            ra_item_code = output4.get("RA_ITEM_CODE").toString();
            
            output = MDaoUtilSingle.getData("AML_10_37_01_02_RECALCUL1", input);

            gdReq = (List)output.getRowsToMap();
            int rowcount = gdReq.size();
            for( int i=0 ; i < rowcount ; i++ ) {
            	HashMap inputMap = 	(HashMap)gdReq.get(i);
            	count1 = db.setData("AML_10_37_01_02_updateReCal_RA_ITEM_NTN_SCR_RE_CAL", inputMap);
            }
            db.commit();

            output2 = MDaoUtilSingle.getData("AML_10_37_01_02_RECALCUL2", input);
            gdReq = (List)output2.getRowsToMap();
            int rowcount2 = gdReq.size();
            for( int i=0 ; i < rowcount2 ; i++ ) {
            	HashMap inputMap = 	(HashMap)gdReq.get(i);
            	inputMap.put("HNDL_P_ENO" , ((SessionHelper) input.get("SessionHelper")).getUserId());
            	count2 = db2.setData("AML_10_37_01_02_updateReCal_RA_ITEM_NTN_SCR_RE_CAL2", inputMap);
            }
            db2.commit();
            
            ra_ref_snccd = input.get("RA_REF_SN_CCD").toString();
			ra_sn_ccd    = input.get("RA_SN_CCD").toString();
			upload_gubun = input.get("UPLOAD_GUBUN").toString();

            if("R".equals(ra_ref_snccd) || "N".equals(ra_sn_ccd)) {
            	Rntnjob_seq = input.get("RA_SEQ").toString();
            	output.put("NTN_SEQ"		, Rntnjob_seq);
            	output.put("HNDL_P_ENO", ((SessionHelper) input.get("SessionHelper")).getUserId() );
            	output.put("RA_ITEM_CODE", ra_item_code);
            	if("Z".equals(upload_gubun)) {
            		db3.setData("AML_10_37_01_02_MODI_APPR_UPDATE_ONE2", output);	
            	}else {
            		db3.setData("AML_10_37_01_02_MODI_APPR_UPDATE_ONE", output);
            	}
            	
            	db3.setData("AML_10_37_01_02_MODI_APPR_UPDATE", output);
            	db3.setData("AML_10_37_01_02_RA_ITEM_NTN_SCR_REQ_MODI_SEQ", output);
            }else {
            	output3 = MDaoUtilSingle.getData("AML_10_37_01_02_MODI_APPR_INSERT_SEQ", input);
            	ntnjob_seq = output3.get("NTN_SEQ").toString();
            	output3.put("NTN_SEQ" , ntnjob_seq);
            	output3.put("RA_ITEM_CODE", ra_item_code);
            	
            	if("Z".equals(upload_gubun)) {
            		db3.setData("AML_10_37_01_02_MODI_APPR_ONE_INSERT2", output3);
            	}else {
            		db3.setData("AML_10_37_01_02_MODI_APPR_ONE_INSERT", output3);	
            	}
            	db3.setData("AML_10_37_01_02_MODI_APPR_INSERT", output3);
            	db3.setData("AML_10_37_01_02_RA_ITEM_NTN_SCR_REQ_MODI_SEQ", output3);
            }
        	db3.commit();

			if( count1 > 0 ) {
				if(count2 > 0) {
				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다.")); output.put("gdRes", null); // Wise Grid Data
				}
			}
		} catch (RuntimeException e) {
			try {
				if ( db != null ) {
					db.rollback();
				}
				if ( db2 != null ) {
					db2.rollback();
				}
				if ( db3 != null ) {
					db3.rollback();
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
				}
				if ( db2 != null ) {
					db2.rollback();
				}
				if ( db3 != null ) {
					db3.rollback();
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
				if ( db3 != null ) {
					db3.close();
				}
			} catch (Exception ee) {
			}
		}
		return output;
	}
}
