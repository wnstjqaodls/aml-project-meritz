package com.gtone.aml.server.AML_10.AML_10_37.AML_10_37_01;

import java.util.HashMap;
import java.util.List;

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

import jspeed.base.property.PropertyService;
import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

public class AML_10_37_01_06 extends GetResultObject{
	private static AML_10_37_01_06 instance = null;
	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return AML_10_37_01_01
	 */
	public static AML_10_37_01_06 getInstace() {
		return instance == null ? (instance = new AML_10_37_01_06()) : instance;
	}

	/**위험평가항목원천테이블 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		String RA_ITEM_CD_GUBUN;
		try {

			RA_ITEM_CD_GUBUN = input.getText("RA_ITEM_CD");

			if("I001".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_06_doSerch", input);
			}else if("I002".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_06_doSerch2", input);
			}else if("I003".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_06_doSerch3", input);
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
			Log.logAML(Log.ERROR, this, "getSearchDetail", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave(DataObj input) throws AMLException {
		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		MDaoUtil db = null;
		String ra_item_cd = "";
		
		String RISK_SCR_1  = "";
		String RISK_SCR_2  = "";
		String RISK_SCR_3  = "";
		String RISK_SCR_4  = "";
		String RISK_SCR_5  = "";
		String RISK_SCR_6  = "";
		String RISK_SCR_7  = "";
		String RISK_SCR_8  = "";
		String RISK_SCR_9  = "";
		String RISK_SCR_10 = "";
		String RISK_SCR_11 = "";
		String RISK_SCR_12 = "";
		
		try {

			List gdReq = (List) input.get("gdReq");

			db = new MDaoUtil();
			db.begin();

			ra_item_cd   = input.get("RA_ITEM_CD").toString();
			
			db.setData("AML_10_37_01_06_delete", input);
			db.commit();
			
			output2 = MDaoUtilSingle.getData("AML_10_37_01_06_doSerch4", input);
			RISK_SCR_1  = output2.get("RISK_SCR_NM1").toString();
			RISK_SCR_2  = output2.get("RISK_SCR_NM2").toString();
			RISK_SCR_3  = output2.get("RISK_SCR_NM3").toString();
			RISK_SCR_4  = output2.get("RISK_SCR_NM4").toString();
			RISK_SCR_5  = output2.get("RISK_SCR_NM5").toString();
			RISK_SCR_6  = output2.get("RISK_SCR_NM6").toString();
			RISK_SCR_7  = output2.get("RISK_SCR_NM7").toString();
			RISK_SCR_8  = output2.get("RISK_SCR_NM8").toString();
			RISK_SCR_9  = output2.get("RISK_SCR_NM9").toString();
			RISK_SCR_10 = output2.get("RISK_SCR_NM10").toString();
			RISK_SCR_11 = output2.get("RISK_SCR_NM11").toString();
			RISK_SCR_12 = output2.get("RISK_SCR_NM12").toString();
			
			HashMap map = null;
			for ( int i = 0; i < gdReq.size(); i++ ) {

				map = (HashMap) gdReq.get(i);

				output.put("RA_ITEM_CD"		    , ra_item_cd);
				output.put("RA_ITEM_CODE"	    , StringHelper.evl(map.get("RA_ITEM_CODE")      , ""));
				output.put("RA_ITEM_NM"		    , StringHelper.evl(map.get("RA_ITEM_NM")	    , ""));
				
				output.put("FATF_BLACK_LIST_YN"	, StringHelper.evl(map.get("FATF_BLACK_LIST_YN"), ""));
				output.put("RISK_SCR_1"		    , RISK_SCR_1);
				output.put("FATF_GREY_LIST_YN"  , StringHelper.evl(map.get("FATF_GREY_LIST_YN") , ""));
				output.put("RISK_SCR_2"		    , RISK_SCR_2);
				output.put("FINCEN_LIST_YN"	    , StringHelper.evl(map.get("FINCEN_LIST_YN")	, ""));
				output.put("RISK_SCR_3"		    , RISK_SCR_3);
				output.put("UN_SANTIONS_YN"	    , StringHelper.evl(map.get("UN_SANTIONS_YN")	, ""));
				output.put("RISK_SCR_4"		    , RISK_SCR_4);
				output.put("OFAC_SANTIONS_YN"   , StringHelper.evl(map.get("OFAC_SANTIONS_YN")	, ""));
				output.put("RISK_SCR_5"		    , RISK_SCR_5);
				output.put("OECD_YN"		    , StringHelper.evl(map.get("OECD_YN")		    , ""));
				output.put("RISK_SCR_6"		    , RISK_SCR_6);
				output.put("TICPI_CPI_IDX"	    , StringHelper.evl(map.get("TICPI_CPI_IDX")		, ""));
				output.put("RISK_SCR_7"		    , RISK_SCR_7);
				output.put("INCRS_PROD_YN"	    , StringHelper.evl(map.get("INCRS_PROD_YN")		, ""));
				output.put("RISK_SCR_8"		    , RISK_SCR_8);
				output.put("INCRS_CHEM_YN"	    , StringHelper.evl(map.get("INCRS_CHEM_YN")		, ""));
				output.put("RISK_SCR_9"		    , RISK_SCR_9);
				output.put("EU_SANTIONS_YN"	    , StringHelper.evl(map.get("EU_SANTIONS_YN")	, ""));
				output.put("RISK_SCR_10"	    , RISK_SCR_10);
				output.put("EU_HRT_YN"		    , StringHelper.evl(map.get("EU_HRT_YN")		    , ""));
				output.put("RISK_SCR_11"	    , RISK_SCR_11);
				output.put("BASEL_RIK_IDX"	    , StringHelper.evl(map.get("BASEL_RIK_IDX")		, ""));
				output.put("RISK_SCR_12"	    , RISK_SCR_12);
				
				output.put("HNDL_P_ENO", ((SessionHelper) input.get("SessionHelper")).getUserId() );

				MDaoUtilSingle.setData("AML_10_37_01_06_MERGE_NTN", output); 
				MDaoUtilSingle.setData("AML_10_37_01_06_MERGE_NTN2", output); 
			}
			

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Wise Grid Data

		} catch (RuntimeException e) {
			try {
				 
				 if ( db != null ) { db.rollback(); } 
				 
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				 if ( db != null ) { db.rollback(); } 
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				 if ( db != null ) { db.rollback(); } 
			} catch (Exception ee) {
			}
		}
		return output;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave2(DataObj input) throws AMLException {
		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		MDaoUtil db = null;
		String ra_item_cd = "";
		
		String RISK_SCR_1  = "";
		String RISK_SCR_2  = "";
		String RISK_SCR_3  = "";
		String RISK_SCR_4  = "";
		String RISK_SCR_5  = "";
		String RISK_SCR_6  = "";
		String RISK_SCR_7  = "";
		String RISK_SCR_8  = "";
		String RISK_SCR_9  = "";
		String RISK_SCR_10 = "";
		String RISK_SCR_11 = "";
		String RISK_SCR_12 = "";
		String RISK_SCR_13 = "";
		 
		try {

			List gdReq = (List) input.get("gdReq");

			db = new MDaoUtil();
			db.begin();

			ra_item_cd   = input.get("RA_ITEM_CD").toString();
			
			db.setData("AML_10_37_01_06_delete2", input);
			db.commit();

			output2 = MDaoUtilSingle.getData("AML_10_37_01_06_doSerch_IDJOB", input);
			RISK_SCR_1  = output2.get("RISK_SCR_NM1").toString();
			RISK_SCR_2  = output2.get("RISK_SCR_NM2").toString();
			RISK_SCR_3  = output2.get("RISK_SCR_NM3").toString();
			RISK_SCR_4  = output2.get("RISK_SCR_NM4").toString();
			RISK_SCR_5  = output2.get("RISK_SCR_NM5").toString();
			RISK_SCR_6  = output2.get("RISK_SCR_NM6").toString();
			RISK_SCR_7  = output2.get("RISK_SCR_NM7").toString();
			RISK_SCR_8  = output2.get("RISK_SCR_NM8").toString();
			RISK_SCR_9  = output2.get("RISK_SCR_NM9").toString();
			RISK_SCR_10 = output2.get("RISK_SCR_NM10").toString();
			RISK_SCR_11 = output2.get("RISK_SCR_NM11").toString();
			RISK_SCR_12 = output2.get("RISK_SCR_NM12").toString();
			RISK_SCR_13 = output2.get("RISK_SCR_NM13").toString();
			
			HashMap map = null;
			for ( int i = 0; i < gdReq.size(); i++ ) {

				map = (HashMap) gdReq.get(i);

				output.put("RA_ITEM_CD"		    , ra_item_cd);
				output.put("RA_ITEM_CODE"	    , StringHelper.evl(map.get("RA_ITEM_CODE")      , ""));
				output.put("RA_ITEM_NM"		    , StringHelper.evl(map.get("RA_ITEM_NM")	    , ""));
				
				output.put("RA_IDJOB_YN1"		, StringHelper.evl(map.get("RA_IDJOB_YN1")		, ""));
				output.put("RISK_SCR_1"			, RISK_SCR_1);
				output.put("RA_IDJOB_YN2"  		, StringHelper.evl(map.get("RA_IDJOB_YN2") 		, ""));
				output.put("RISK_SCR_2"			, RISK_SCR_2);
				output.put("RA_IDJOB_YN3"	    , StringHelper.evl(map.get("RA_IDJOB_YN3")		, ""));
				output.put("RISK_SCR_3"			, RISK_SCR_3);
				output.put("RA_IDJOB_YN4"	    , StringHelper.evl(map.get("RA_IDJOB_YN4")	    , ""));
				output.put("RISK_SCR_4"			, RISK_SCR_4);
				output.put("RA_IDJOB_YN5"   	, StringHelper.evl(map.get("RA_IDJOB_YN5")	    , ""));
				output.put("RISK_SCR_5"			, RISK_SCR_5);
				output.put("RA_IDJOB_YN6"		, StringHelper.evl(map.get("RA_IDJOB_YN6")		, ""));
				output.put("RISK_SCR_6"			, RISK_SCR_6);
				output.put("RA_IDJOB_YN7"	    , StringHelper.evl(map.get("RA_IDJOB_YN7")		, ""));
				output.put("RISK_SCR_12"		, RISK_SCR_12);
				output.put("RA_IDJOB_STA_YN1"	, StringHelper.evl(map.get("RA_IDJOB_STA_YN1")  , ""));
				output.put("RISK_SCR_7"			, RISK_SCR_7);
				output.put("RA_IDJOB_STA_YN2"	, StringHelper.evl(map.get("RA_IDJOB_STA_YN2")	, ""));
				output.put("RISK_SCR_8"			, RISK_SCR_8);
				output.put("RA_IDJOB_STA_YN3"	, StringHelper.evl(map.get("RA_IDJOB_STA_YN3")	, ""));
				output.put("RISK_SCR_9"	    	, RISK_SCR_9);
				output.put("RA_IDJOB_STA_YN4"	, StringHelper.evl(map.get("RA_IDJOB_STA_YN4")	, ""));
				output.put("RISK_SCR_10"	    , RISK_SCR_10);
				output.put("RA_IDJOB_STA_YN5"	, StringHelper.evl(map.get("RA_IDJOB_STA_YN5")	, ""));
				output.put("RISK_SCR_11"	    , RISK_SCR_11);
				output.put("RA_IDJOB_STA_YN6"	, StringHelper.evl(map.get("RA_IDJOB_STA_YN6")	, ""));
				output.put("RISK_SCR_13"	    , RISK_SCR_13);
				
				output.put("HNDL_P_ENO", ((SessionHelper) input.get("SessionHelper")).getUserId() );

				MDaoUtilSingle.setData("AML_10_37_01_06_MERGE_IDJOB", output); 
				MDaoUtilSingle.setData("AML_10_37_01_06_MERGE_IDJOB2", output); 
			}

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
					db.rollback();
				}
			} catch (Exception ee) {
			}
		}
		return output;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave3(DataObj input) throws AMLException {
		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		MDaoUtil db = null;
		String ra_item_cd = "";
		
		String RISK_SCR_1  = "";
		String RISK_SCR_2  = "";
		String RISK_SCR_3  = "";
		String RISK_SCR_4  = "";
		String RISK_SCR_5  = "";
		String RISK_SCR_6  = "";
		String RISK_SCR_7  = "";
		String RISK_SCR_8  = "";
		String RISK_SCR_9  = "";
		String RISK_SCR_10 = "";
		String RISK_SCR_11 = "";
		String RISK_SCR_12 = "";
		String RISK_SCR_13 = "";
		
		try {

			List gdReq = (List) input.get("gdReq");

			db = new MDaoUtil();
			db.begin();

			ra_item_cd   = input.get("RA_ITEM_CD").toString();
			
			db.setData("AML_10_37_01_06_delete3", input);
			db.commit();

			output2 = MDaoUtilSingle.getData("AML_10_37_01_06_doSerch_CORJOB", input);
			RISK_SCR_1  = output2.get("RISK_SCR_NM1").toString(); // 법률, 회계, 세무 관련 산업/직종
			RISK_SCR_2  = output2.get("RISK_SCR_NM2").toString(); // 투자자문 관련 산업/직종
			RISK_SCR_3  = output2.get("RISK_SCR_NM3").toString(); // 부동산 관련 산업/직종
			RISK_SCR_4  = output2.get("RISK_SCR_NM4").toString(); // 오락, 도박, 스포츠 관련 산업/직종
			RISK_SCR_5  = output2.get("RISK_SCR_NM5").toString(); // 카지노
			RISK_SCR_6  = output2.get("RISK_SCR_NM6").toString(); // 대부업자, 환전상, 소액해외송급업자
			RISK_SCR_7  = output2.get("RISK_SCR_NM7").toString(); // 귀금속, 예술품, 골동품 판매상
			RISK_SCR_8  = output2.get("RISK_SCR_NM8").toString(); // 주류 도소매업, 유흥주점업
			RISK_SCR_9  = output2.get("RISK_SCR_NM9").toString(); // 의료, 제약 관련 산업/직종
			RISK_SCR_10 = output2.get("RISK_SCR_NM10").toString(); // 건설 산업
			RISK_SCR_11 = output2.get("RISK_SCR_NM11").toString(); // 무기, 방위산업
			RISK_SCR_12 = output2.get("RISK_SCR_NM12").toString(); // 채광, 금속, 고물상
			RISK_SCR_13 = output2.get("RISK_SCR_NM13").toString(); // 가상자산사업 의심업종
			
			HashMap map = null;
			System.out.println("gdReq.size : " + gdReq.size());
			
			for ( int i = 0; i < gdReq.size(); i++ ) {

				map = (HashMap) gdReq.get(i);

				output.put("RA_ITEM_CD"		    , ra_item_cd);
				output.put("RA_ITEM_CODE"	    , StringHelper.evl(map.get("RA_ITEM_CODE")      , ""));
				output.put("RA_ITEM_NM"		    , StringHelper.evl(map.get("RA_ITEM_NM")	    , ""));
				
				output.put("RA_CORJOB_YN1"		, StringHelper.evl(map.get("RA_CORJOB_YN1")		, ""));
				output.put("RISK_SCR_1"			, RISK_SCR_1);
				output.put("RA_CORJOB_YN2"  	, StringHelper.evl(map.get("RA_CORJOB_YN2") 		, ""));
				output.put("RISK_SCR_2"			, RISK_SCR_2);
				output.put("RA_CORJOB_YN3"	    , StringHelper.evl(map.get("RA_CORJOB_YN3")		, ""));
				output.put("RISK_SCR_3"			, RISK_SCR_3);
				output.put("RA_CORJOB_YN4"	    , StringHelper.evl(map.get("RA_CORJOB_YN4")	    , ""));
				output.put("RISK_SCR_4"			, RISK_SCR_4);
				output.put("RA_CORJOB_YN5"   	, StringHelper.evl(map.get("RA_CORJOB_YN5")	    , ""));
				output.put("RISK_SCR_5"			, RISK_SCR_5);
				output.put("RA_CORJOB_YN6"		, StringHelper.evl(map.get("RA_CORJOB_YN6")		, ""));
				output.put("RISK_SCR_6"			, RISK_SCR_6);
				output.put("RA_CORJOB_YN7"	    , StringHelper.evl(map.get("RA_CORJOB_YN7")		, ""));
				output.put("RISK_SCR_7"		    , RISK_SCR_7);
				output.put("RA_CORJOB_YN8"	    , StringHelper.evl(map.get("RA_CORJOB_YN8")		, ""));
				output.put("RISK_SCR_13"		, RISK_SCR_13);
				
				output.put("RA_CORJOB_STA_YN1"	, StringHelper.evl(map.get("RA_CORJOB_STA_YN1")  , ""));
				output.put("RISK_SCR_8"			, RISK_SCR_8);
				output.put("RA_CORJOB_STA_YN2"	, StringHelper.evl(map.get("RA_CORJOB_STA_YN2")	, ""));
				output.put("RISK_SCR_9"			, RISK_SCR_9);
				output.put("RA_CORJOB_STA_YN3"	, StringHelper.evl(map.get("RA_CORJOB_STA_YN3")	, ""));
				output.put("RISK_SCR_10"	    , RISK_SCR_10);
				output.put("RA_CORJOB_STA_YN4"	, StringHelper.evl(map.get("RA_CORJOB_STA_YN4")	, ""));
				output.put("RISK_SCR_11"	    , RISK_SCR_11);
				output.put("RA_CORJOB_STA_YN5"	, StringHelper.evl(map.get("RA_CORJOB_STA_YN5")	, ""));
				output.put("RISK_SCR_12"	    , RISK_SCR_12);
				
				output.put("HNDL_P_ENO", ((SessionHelper) input.get("SessionHelper")).getUserId() );

				MDaoUtilSingle.setData("AML_10_37_01_06_MERGE_CORJOB", output); 
				MDaoUtilSingle.setData("AML_10_37_01_06_MERGE_CORJOB2", output);
			}

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
					db.close();
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
					db.rollback();
					db.close();
				}
			} catch (Exception ee) {
			}
		}
		return output;
	}
}
