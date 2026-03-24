package com.gtone.aml.server.AML_10.AML_10_39.AML_10_39_01;

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
public class AML_10_39_01_02 extends GetResultObject {
	private static AML_10_39_01_02 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return AML_10_36_01_01
	 */
	public static AML_10_39_01_02 getInstance() {
		return instance == null ? (instance = new AML_10_39_01_02()) : instance;
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

        String cs_typ_cd = "";
        String new_old_gbncd = "";
        String ra_ref_snccd = "";
        String firstsno = "";
        
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
	        	cs_typ_cd        = input.get("CS_TYP_CD").toString();
	        	new_old_gbncd    = input.get("NEW_OLD_GBN_CD").toString();
	        	ra_ref_snccd     = input.get("RA_REF_SN_CCD").toString();
	        	firstsno         = input.get("FIRST_SNO").toString();
	            
	        	if("R".equals(ra_ref_snccd) || "2".equals(firstsno)) {
	            	amlApprMap.put("APP_NO", input.get("APP_NO"));
	            }else {
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

	        	//위험가중치 테이블 이력 관리

	        	output3.put("CS_TYP_CD", cs_typ_cd);
	        	output3.put("NEW_OLD_GBN_CD", new_old_gbncd);
	        	output3.put("RA_SEQ"    , input.get("RA_SEQ").toString());

	        	db.setData("AML_10_39_01_02_update_RA_ITEM_WGHT_APPR", output3);
	            db.setData("AML_10_39_01_02_update_RA_ITEM_WGHT_REQ", output3);

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
        String cs_typ_cd = "";
        String new_old_gbncd = "";

        int count = 0;
        MDaoUtil db = null;
        MDaoUtil db2 = null;

        try {
        	db = new MDaoUtil();
            db.begin();

            db2 = new MDaoUtil();
            db2.begin();

            if(input.size() > 0 ) {
            	HashMap amlApprMap = new HashMap();

    			amlApprMap.clear();

    			APP_NO           = input.get("APP_NO").toString();
    			strGYLJ_LINE_G_C = input.get("GYLJ_LINE_G_C").toString();
    			gubunSN_CCD      = input.get("SN_CCD").toString();
    			cs_typ_cd       = input.get("CS_TYP_CD").toString();
	        	new_old_gbncd    = input.get("NEW_OLD_GBN_CD").toString();

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

    			output2.put("CS_TYP_CD", cs_typ_cd);
    			output2.put("NEW_OLD_GBN_CD", new_old_gbncd);
    			output2.put("RA_SEQ"    , input.get("RA_SEQ").toString());

	        	if("E".equals(gubunSN_CCD)) {
		        	db.setData("AML_10_39_01_02_update_RA_ITEM_WGHT_APPR2", output2);
		        	db.setData("AML_10_39_01_02_update_RA_ITEM_WGHT_REQ2", output2);
		        	db.setData("AML_10_39_01_01_update_RA_ITEM_WGHT_REQ2", output2);
	        	}else {
		        	db.setData("AML_10_39_01_02_update_RA_ITEM_WGHT_APPR3", output2);
		        	db.setData("AML_10_39_01_02_update_RA_ITEM_WGHT_REQ4", output2);
	        	}
				db.commit();

				if("E".equals(gubunSN_CCD)) {
					db2.setData("AML_10_39_01_02_update_RA_ITEM_WGHT", output2);
				}
				db2.commit();
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
                if (db2 != null) {
                    db2.rollback();
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
	            }
	            if (db2 != null) {
	                db2.rollback();
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
	            if (db2 != null) {
	                db2.close();
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

		String ra_item_cd = "";

		try {
				output = MDaoUtilSingle.getData("AML_10_39_01_02_RA_ITEM_WGHT_doApprHist", input);

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

		String ra_item_cd = "";

		try {
			
			output = MDaoUtilSingle.getData("AML_10_39_01_02_RA_ITEM_WGHT_doApprHist2", input);
			// grid data
			if ( output.getCount("WGHT_SEQ") > 0 ) {
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

		String ra_item_cd = "";

		try {

			output = MDaoUtilSingle.getData("AML_10_39_01_02_RA_ITEM_WGHT_doApprHist3", input);

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