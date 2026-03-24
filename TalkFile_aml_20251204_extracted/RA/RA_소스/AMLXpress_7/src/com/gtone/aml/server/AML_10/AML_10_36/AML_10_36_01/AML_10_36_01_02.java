/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.aml.server.AML_10.AML_10_36.AML_10_36_01;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.server.AML_10.AML_10_03.AML_10_03_01.AML_10_03_01_01;
import com.gtone.aml.user.SessionAML;
import com.gtone.aml.watchlist.WatchListHelper;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.util.DateHelper;
import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description 위험평가항목관리
 *              共通コード管理
 *              Common Code Mgt.
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     AML/RBA/FATCA/CRS/WLF
 * @Since       2024. 8. 16.
 ******************************************************************************************************************************************
	/** 인스턴스 */
public class AML_10_36_01_02 extends GetResultObject {
	private static AML_10_36_01_02 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return AML_10_36_01_01
	 */
	public static AML_10_36_01_02 getInstance() {
		return instance == null ? (instance = new AML_10_36_01_02()) : instance;
	}

	/**위험요소관리 상세정보 저장*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave(DataObj input) {

		DataObj output = new DataObj();
		MDaoUtil db = null;

		String ra_sn_ccd = "";
		String ra_ref_snccd = "";
		String Rfact_seq = "";
		String fact_seq = "";
		
		try {

			db = new MDaoUtil();
	    	db.begin();
	    	
	    	DataObj obj1 = new DataObj();
	    	
	    	ra_ref_snccd = input.get("RA_REF_SN_CCD").toString();
			ra_sn_ccd    = input.get("RA_SN_CCD").toString();
			
			if("R".equals(ra_ref_snccd) || "N".equals(ra_sn_ccd)) {
				Rfact_seq = input.get("RA_SEQ").toString();
				obj1.put("FACT_SEQ"		, Rfact_seq);
			}else {
				output = MDaoUtilSingle.getData("AML_10_36_01_02_MODI_APPR_INSERT_SEQ", input);
				fact_seq = output.get("FACT_SEQ").toString();
				obj1.put("FACT_SEQ"		, fact_seq);
			}
	    	
			obj1.put("RISK_ELMT_C"       , StringHelper.evl(input.get("RISK_ELMT_C")  , ""));
			
	    	obj1.put("RISK_CATG1_C"      , StringHelper.evl(input.get("RISK_CATG1_C") , ""));
	    	obj1.put("RISK_CATG2_C"      , StringHelper.evl(input.get("RISK_CATG2_C") , ""));
	    	obj1.put("RISK_ELMT_NM"      , StringHelper.evl(input.get("RISK_ELMT_NM") , ""));
	    	obj1.put("RISK_SCR"          , input.get("RISK_SCR") != null ? input.get("RISK_SCR").toString() : "");
	    	
	    	obj1.put("RISK_INDI"         , StringHelper.evl(input.get("RISK_INDI")     , ""));
	    	obj1.put("RISK_CORP"         , StringHelper.evl(input.get("RISK_CORP")     , ""));
	    	obj1.put("RISK_VAL_ITEM"     , StringHelper.evl(input.get("RISK_VAL_ITEM")     , ""));
	    	obj1.put("RISK_APPL_YN"      , StringHelper.evl(input.get("RISK_APPL_YN")     , ""));
	    	obj1.put("RISK_APPL_MODEL_I" , StringHelper.evl(input.get("RISK_APPL_MODEL_I")     , ""));
	    	obj1.put("RISK_APPL_MODEL_B" , StringHelper.evl(input.get("RISK_APPL_MODEL_B")     , ""));
	    	
	    	obj1.put("RISK_HRSK_YN"      , StringHelper.evl(input.get("RISK_HRSK_YN") , ""));
	    	obj1.put("RISK_RSN_DESC"     , StringHelper.evl(input.get("RISK_RSN_DESC"), ""));
	    	obj1.put("RISK_RMRK"         , StringHelper.evl(input.get("RISK_RMRK")    , ""));
	    	obj1.put("RISK_UPD_ID"       , ((SessionHelper) input.get("SessionHelper")).getUserId());

	    	
	    	db.setData("AML_10_36_01_02_RiskFactor_APPR_merge", obj1);
	    	db.setData("AML_10_36_01_02_updateRAitem", obj1);

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
	public DataObj doSave2(DataObj input) {

		DataObj output = new DataObj();
		MDaoUtil db = null;
		//String fact_seq = "";
		
		try {

			db = new MDaoUtil();
	    	db.begin();
	    	
	    	DataObj obj1 = new DataObj();

			//output = MDaoUtilSingle.getData("AML_10_36_01_02_MODI_APPR_INSERT_SEQ", input);
			//fact_seq = output.get("FACT_SEQ").toString();
			//obj1.put("FACT_SEQ"		, fact_seq);

			obj1.put("RISK_ELMT_C"       , StringHelper.evl(input.get("RISK_ELMT_C")  , ""));
	    	obj1.put("RISK_RSN_DESC"     , StringHelper.evl(input.get("RISK_RSN_DESC"), ""));
	    	obj1.put("RISK_RMRK"         , StringHelper.evl(input.get("RISK_RMRK")    , ""));
	    	obj1.put("RISK_UPD_ID"       , ((SessionHelper) input.get("SessionHelper")).getUserId());

	    	//db.setData("AML_10_36_01_02_RiskFactor_APPR_merge2", obj1);
	    	db.setData("AML_10_36_01_02_updateRAitem2", obj1);
	    	db.setData("AML_10_36_01_02_updateRAitem3", obj1);

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

	/**위험요소관리 결재요청*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj firstAppRequest(DataObj input ) throws AMLException {
        DataObj output  = new DataObj();
        DataObj output2 = new DataObj();
        DataObj output3 = new DataObj();

        String ERRCODE = "";
        String ERRMSG  = "";
        String WINMSG  = "";

        String APP_NO = "";
        String strAPP_NO = "";
        String strGYLJ_LINE_G_C = "";
        String ra_ref_snccd = "";

        int count = 0;
        MDaoUtil db = null;

        try {

        	db = new MDaoUtil();
            db.begin();

			if(input.size() > 0) {
				HashMap amlApprMap = new HashMap();

				amlApprMap.clear();

	        	strAPP_NO        = input.get("APP_NO").toString();
	        	strGYLJ_LINE_G_C = input.get("GYLJ_LINE_G_C").toString();
	        	ra_ref_snccd     = input.get("RA_REF_SN_CCD").toString();

	        	if("R".equals(ra_ref_snccd)) {
	        		amlApprMap.put("APP_NO", input.get("APP_NO"));
	        	} else {
	        		output2 = MDaoUtilSingle.getData("get_APP_NO_SEQ", amlApprMap);
	            	APP_NO = output2.getText("APP_NO");
	            	amlApprMap.put("APP_NO", APP_NO);
	        	}

	        	amlApprMap.put("GYLJ_LINE_G_C", strGYLJ_LINE_G_C);
	        	amlApprMap.put("SNO",           input.get("SNO").toString());
	        	amlApprMap.put("FIRST_SNO",     input.get("FIRST_SNO").toString());
	        	amlApprMap.put("SN_CCD",        input.get("SN_CCD").toString());
	        	amlApprMap.put("PRV_APP_NO",    input.get("PRV_APP_NO").toString());
    			amlApprMap.put("RSN_CNTNT",     input.getText("RSN_CNTNT").toString());
	        	amlApprMap.put("BRN_CD",        ((SessionAML   )input.get("SessionAML")).getsAML_BDPT_CD());
	        	amlApprMap.put("HNDL_P_ENO",    ((SessionHelper)input.get("SessionHelper")).getUserId());
	        	amlApprMap.put("APPR_ROLE_ID",  ((SessionAML   )input.get("SessionAML")).getsAML_ROLE_ID());

	        	output3 = MDaoUtilSingle.getData("AML_10_36_01_02_get_APP_MAKE_PARAM", amlApprMap);
	        	count = db.setData("AML_10_36_01_02_AmlAppr_Merge", output3);
	        	db.setData("AML_10_36_01_02_AmlApprHist_Insert", output3);	//AML_APPR_HIST : 결재이력

	        	//위험요소관리 테이블 이력 관리

	        	output3.put("RA_SEQ"    , input.get("RA_SEQ").toString());	
	        	output3.put("RISK_ELMT_C",   input.get("RISK_ELMT_C").toString());

	        	db.setData("AML_10_36_01_01_updateRA_RISK_FACTOR_APPR", output3);
            	db.setData("AML_10_36_01_01_updateRA_RISK_FACTOR_REQ", output3);
				db.commit();
            }

			if(count > 0) {
                ERRCODE = "00000";
                ERRMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
                WINMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
            } else {
            	ERRMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
                ERRCODE = "00099";
                WINMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
            }

            output.put("ERRCODE" , ERRCODE);
            output.put("ERRMSG"  , ERRMSG);
            output.put("WINMSG"  ,WINMSG);

        }catch(AMLException e) {
        	try {
                if (db != null) {
                    db.rollback();
                }
            } catch(Exception ee) {
                Log.logAML(Log.ERROR, this, "firstAppRequest", ee.getMessage());

                output.put("ERRCODE", "00001");
                output.put("ERRMSG", ee.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
            }

            Log.logAML(Log.ERROR, this, "firstAppRequest", e.getMessage());

            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
            output.put("gdRes", null);
        } catch(Exception e) {
	        try {
	            if (db != null) {
	                db.rollback();
	            }
	        } catch(Exception ee) {
	            Log.logAML(Log.ERROR, this, "firstAppRequest", ee.getMessage());

                output.put("ERRCODE", "00001");
                output.put("ERRMSG", ee.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        }

	        Log.logAML(Log.ERROR, this, "firstAppRequest", e.getMessage());

	        output.put("ERRCODE", "00001");
            output.put("ERRMSG" , e.getMessage());
            output.put("WINMSG" , MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
            output.put("gdRes"  , null);
        } finally {
        	try {
	            if (db != null) {
	                db.close();
	            }
	        } catch(RuntimeException e) {
	            Log.logAML(Log.ERROR, this, "firstAppRequest", e.getMessage());

	            output.put("ERRCODE", "00001");
                output.put("ERRMSG", e.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        } catch(Exception e) {
	            Log.logAML(Log.ERROR, this, "firstAppRequest", e.getMessage());

	            output.put("ERRCODE", "00001");
                output.put("ERRMSG", e.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        }
        }

		return output;
	}

	/**위험요소관리 결재/반려*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doAppr(DataObj input) throws AMLException{
		DataObj output  = new DataObj();
        DataObj output2 = new DataObj();

        String ERRCODE = "";
        String ERRMSG  = "";
        String WINMSG  = "";
        String APP_NO = "";
        String strGYLJ_LINE_G_C = "";
        String gubunSN_CCD = "";
        String riskelmtc = "";
        
        int count = 0;
        MDaoUtil db = null;

        try {
        	db = new MDaoUtil();
            db.begin();

            if(input.size() > 0 ) {
            	HashMap amlApprMap = new HashMap();

    			amlApprMap.clear();

    			APP_NO           = input.get("APP_NO").toString();
    			strGYLJ_LINE_G_C = input.get("GYLJ_LINE_G_C").toString();
    			gubunSN_CCD      = input.get("SN_CCD").toString();
    			riskelmtc        = input.get("RISK_ELMT_C").toString();

    			amlApprMap.put("APP_NO",        APP_NO);
    			amlApprMap.put("GYLJ_LINE_G_C", strGYLJ_LINE_G_C);
    			amlApprMap.put("FIRST_SNO",     "");
    			amlApprMap.put("SN_CCD",        input.get("SN_CCD").toString()); // S:결재요청,R:반려,E:결재완료
    			amlApprMap.put("PRV_APP_NO",    input.get("PRV_APP_NO").toString());
    			amlApprMap.put("RSN_CNTNT",     input.getText("RSN_CNTNT"));

    			amlApprMap.put("APPR_ROLE_ID",  ((SessionAML   )input.get("SessionAML")).getsAML_ROLE_ID());
    			amlApprMap.put("BRN_CD",        ((SessionAML   )input.get("SessionAML")).getsAML_BDPT_CD());
    			amlApprMap.put("HNDL_P_ENO",    ((SessionHelper)input.get("SessionHelper")).getUserId());

    			output2 = MDaoUtilSingle.getData("AML_10_36_01_02_get_APP_MAKE_PARAM", amlApprMap);
    			count = db.setData("AML_10_36_01_02_AmlAppr_Merge", output2);
    			count = db.setData("AML_10_36_01_02_AmlApprHist_Insert", output2);

    			output2.put("RISK_ELMT_C",   input.get("RISK_ELMT_C").toString());
    			output2.put("RISK_ELMT_NM",  input.get("RISK_ELMT_NM").toString());
    			output2.put("RA_SEQ",        input.get("RA_SEQ").toString());
    			output2.put("HNDL_P_ENO", ((SessionHelper)input.get("SessionHelper")).getUserId());
    			
	        	if("E".equals(gubunSN_CCD)) {
	        		db.setData("AML_10_36_01_01_updateRA_RISK_FACTOR_REQ2", output2);
	        		db.setData("AML_10_36_01_01_insertRA_RISK_FACTOR_APPR", output2);
	        		db.setData("AML_10_36_01_01_Merge_RA_RISK_FACTOR_M", output2);
	        		db.setData("AML_10_36_01_01_update_SRBA_DTL_C", output2);
	        		db.commit();
	        		
	        		if("R10601".equals(riskelmtc)) {
	        			db.setData("AML_10_36_01_01_NTN_UPDATE5", output2);
	        		}else if("R10901".equals(riskelmtc)) {
	        			db.setData("AML_10_36_01_01_NTN_UPDATE6", output2);	        		
	        	    }else if("R10701".equals(riskelmtc)) {
	        			db.setData("AML_10_36_01_01_NTN_UPDATE", output2);
	        		}else if("R10702".equals(riskelmtc)) {
	        			db.setData("AML_10_36_01_01_NTN_UPDATE2", output2);
	        		}else if("R10801".equals(riskelmtc)) {
	        			db.setData("AML_10_36_01_01_NTN_UPDATE3", output2);
	        		}else if("R10802".equals(riskelmtc)) {
	        			db.setData("AML_10_36_01_01_NTN_UPDATE4", output2);
	        		}else if("R20701".equals(riskelmtc)) {//법률회계세무관련 
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE1", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE1", output2);
	        		}else if("R20702".equals(riskelmtc)) {//투자자문관련 
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE2", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE2", output2);
	        		}else if("R20703".equals(riskelmtc)) {//부동산관련 
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE3", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE3", output2);
	        		}else if("R21401".equals(riskelmtc)) {//오락,도박,스포츠관련
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE4", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE4", output2);
	        		}else if("R21403".equals(riskelmtc)) {//대부업자,환전상
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE5", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE5", output2);
	        		}else if("R21404".equals(riskelmtc)) {//귀금속, 예술품,골동품판매상
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE6", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE6", output2);
	        		}else if("R21405".equals(riskelmtc)) {//주류도소매업
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE7", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE7", output2);
	        		}else if("R20601".equals(riskelmtc)) {//의료제약 
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE8", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE8", output2);
	        		}else if("R20602".equals(riskelmtc)) {//건설산업 
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE9", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE9", output2);
	        		}else if("R20603".equals(riskelmtc)) {//무기,방위산업
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE10", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE10", output2);
	        		}else if("R20604".equals(riskelmtc)) {//채광,금속
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE11", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE11", output2);
	        		}else if("R20101".equals(riskelmtc)) {//가상자산사업
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE12", output2);
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE12", output2);
	        		}else if("R21001".equals(riskelmtc)) {//무직자
	        			db.setData("AML_10_36_01_01_INDJOB_UPDATE13", output2);
	        		}else if("R21402".equals(riskelmtc)) {//카지노
	        			db.setData("AML_10_36_01_01_CORJOB_UPDATE13", output2);
	        		}
	        	}else {
	        		db.setData("AML_10_36_01_01_updateRA_RISK_FACTOR_REQ", output2);
	        		db.setData("AML_10_36_01_01_insertRA_RISK_FACTOR_APPR", output2);
	        	}

				db.commit();

            }

            if(count > 0) {
                ERRCODE = "00000";
                ERRMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
                WINMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
            } else {
            	ERRMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
                ERRCODE = "00099";
                WINMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
            }

            output.put("ERRCODE" , ERRCODE);
            output.put("ERRMSG"  , ERRMSG);
            output.put("WINMSG"  ,WINMSG);
        }catch(AMLException e) {
        	try {
                if (db != null) {
                    db.rollback();
                    db.close();
                }
            } catch(Exception ee) {
                Log.logAML(Log.ERROR, this, "doAppr", ee.getMessage());

                output.put("ERRCODE", "00001");
                output.put("ERRMSG", ee.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
            }

            Log.logAML(Log.ERROR, this, "doAppr", e.getMessage());

            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
            output.put("gdRes", null);
        } catch(Exception e) {
	        try {
	            if (db != null) {
	                db.rollback();
	                db.close();
	            }
	        } catch(Exception ee) {
	            Log.logAML(Log.ERROR, this, "doAppr", ee.getMessage());

                output.put("ERRCODE", "00001");
                output.put("ERRMSG", ee.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        }

	        Log.logAML(Log.ERROR, this, "doAppr", e.getMessage());

	        output.put("ERRCODE", "00001");
            output.put("ERRMSG" , e.getMessage());
            output.put("WINMSG" , MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
            output.put("gdRes"  , null);
        } finally {
        	try {
	            if (db != null) {
	                db.close();
	            }
	        } catch(RuntimeException e) {
	            Log.logAML(Log.ERROR, this, "doAppr", e.getMessage());

	            output.put("ERRCODE", "00001");
                output.put("ERRMSG", e.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        } catch(Exception e) {
	            Log.logAML(Log.ERROR, this, "doAppr", e.getMessage());

	            output.put("ERRCODE", "00001");
                output.put("ERRMSG", e.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        }
        }
 
		return output;
	}

	public DataObj doApprHist(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			output = MDaoUtilSingle.getData("AML_10_36_01_05_doApprHist", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("SEQ") > 0 ) {
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
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	public DataObj doApprHist2(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			output = MDaoUtilSingle.getData("AML_10_36_01_05_doApprHist2", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("RISK_ELMT_C") > 0 ) {
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
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	public DataObj doApprHist3(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			output = MDaoUtilSingle.getData("AML_10_36_01_05_doApprHist3", (HashMap<Object, Object>) input);
			// grid data
			if ( output.getCount("NUM_SQ") > 0 ) {
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
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
}