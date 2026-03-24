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

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

public class AML_10_37_01_01 extends GetResultObject{
	private static AML_10_37_01_01 instance = null;

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return AML_10_37_01_01
	 */
	public static AML_10_37_01_01 getInstace() {
		return instance == null ? (instance = new AML_10_37_01_01()) : instance;
	}

	/**위험평가항목 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearchMaster(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			output = MDaoUtilSingle.getData("AML_10_37_01_01_doSerch", input);
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
			Log.logAML(Log.ERROR, this, "getSearchGroup", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**위험평가항목상세 검색*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearchDetail(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		String RA_ITEM_CD_GUBUN;
		try {

			RA_ITEM_CD_GUBUN = input.getText("RA_ITEM_CD");

			if("I001".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_doSerch2", input);
			}else if("I002".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_doSerch3", input);
			}else if("I003".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_doSerch4", input);
			}else {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_doSerch5", input);
			}

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
			Log.logAML(Log.ERROR, this, "getSearchDetail", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearch_reCalcul(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		String RA_ITEM_CD_GUBUN;
		try {

			RA_ITEM_CD_GUBUN = input.getText("RA_ITEM_CD");

			if("I001".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_reCalcul_ntn", input);
			}else if("I002".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_reCalcul_idjob", input);
			}else if("I003".equals(RA_ITEM_CD_GUBUN)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_reCalcul_corjob", input);
			}

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
			Log.logAML(Log.ERROR, this, "getSearch_reCalcul", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**참조코드 존재할 때 팝업검색*/
	public DataObj getSearchCodeDetail(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			output = MDaoUtilSingle.getData("AML_10_37_01_01_doSearch_Code_Detail", input);
			// grid data
			if ( output.getCount("CD") > 0 ) {
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
			Log.logAML(Log.ERROR, this, "getSearchCodeDetail", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**위험평가항목상세 삭제*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doDelete(DataObj input) {

		DataObj output = new DataObj();
		MDaoUtil db = null;

		int count = 0;
		try {

			List gdReq = (List) input.get("gdReq");

			db = new MDaoUtil();
			db.begin();
			HashMap map = null;

			for ( int i = 0; i < gdReq.size(); i++ ) {
				map = (HashMap) gdReq.get(i);

				if ( !"I".equals(map.get("IDU")) ) {
					output.put("RA_ITEM_CD", StringHelper.evl(map.get("RA_ITEM_CD"), ""));
					output.put("RA_ITEM_VAL", StringHelper.evl(map.get("RA_ITEM_VAL"), ""));
					output.put("UPD_ID", ((SessionHelper) input.get("SessionHelper")).getUserId() );

					count = db.setData("AML_10_37_01_01_doDelete", output);

					if("E".equals(input.get("SN_CCD"))) {
						db.setData("AML_10_37_01_01_clear_LST_APP_NO", output);
					}
				}

			}

			if(count > 0) {
				db.commit();
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
				Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			try {
				if ( db != null ) {
					db.rollback();
				}
			} catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());

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

	/**위험평가항목상세 저장*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSave(DataObj input) {

		DataObj output = new DataObj();
		MDaoUtil db = null;

		int count = 0;

		try {
			List gdReq = (List) input.get("gdReq");


			db = new MDaoUtil();
			db.begin();

			HashMap map = null;

			if("Y".equals(input.getText("fileUploadFlag"))) {
				db.setData("AML_10_37_01_01_doDeleteAll", input);
			}

			for ( int i = 0; i < gdReq.size(); i++ ) {

				map = (HashMap) gdReq.get(i);

				output.put("RA_ITEM_CD", StringHelper.evl(input.get("RA_ITEM_CD"), ""));
				output.put("REG_ID", ((SessionHelper) input.get("SessionHelper")).getUserId() );
				output.put("UPD_ID", ((SessionHelper) input.get("SessionHelper")).getUserId() );
				output.put("RA_ITEM_VAL", StringHelper.evl(map.get("RA_ITEM_VAL"), ""));
				output.put("RA_ITEM_SCR", StringHelper.evl(map.get("RA_ITEM_SCR"), ""));
				output.put("ABS_HRSK_YN",StringHelper.evl(map.get("ABS_HRSK_YN"), "") );

				if ( "I".equals(map.get("IDU")) ) {
					count = db.setData("AML_10_37_01_01_doInsert", output);
				} else {
					count = db.setData("AML_10_37_01_01_doUpdate", output);
				}

				if("E".equals(input.get("SN_CCD"))) {
					db.setData("AML_10_37_01_01_clear_LST_APP_NO", output);
				}
			}

			if(count > 0) {
				db.commit();
				// GridData gdRes = OperateGridData.cloneResponseGridData(gdReq);
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
				Log.logAML(Log.ERROR, this, "doSaveGroup", e.getMessage());
			}
			Log.logAML(Log.ERROR, this, "doSaveGroup", e.getMessage());

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

	/**위험평가항목 결재요청*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj firstAppRequest(DataObj input) {
		DataObj output = new DataObj();
		DataObj output3 = new DataObj();
//		DataObj chkRAWK_ST = new DataObj();

		DataObj makeParamDobj = new DataObj();

		String ERRCODE = "";
		String ERRMSG = "";
		String WINMSG = "";
		String CUR_APP_NO = "";

		int count = 0;

		MDaoUtil db = null;
		try {
			db = new MDaoUtil();
			db.begin();

			if ( input.size() > 0 ) {
//				//RA배치실행여부 체크
//	        	chkRAWK_ST = MDaoUtilSingle.getData("CNT_SMUL_SNCCD_S", input);
//
//				String countSMUL = chkRAWK_ST.getText("CNT");
//
//				if("0".equals(countSMUL)) {
					DataObj paramDobj = new DataObj();
					paramDobj.put("GYLJ_LINE_G_C", "RA2");
					paramDobj.put("WLR_SQ", "0"); // WATCHLSIT검색결과_순번(FKEY)
					paramDobj.put("APPR_ROLE_ID", ((SessionAML) input.get("SessionAML")).getsAML_ROLE_ID());// ROLE_ID
					paramDobj.put("BRN_CD", ((SessionAML) input.get("SessionAML")).getsAML_BDPT_CD()); // BRN_CD
					paramDobj.put("HNDL_P_ENO", ((SessionHelper) input.get("SessionHelper")).getUserId()); // HNDL_DY_TM
					paramDobj.put("RSN_CNTNT", input.get("RSN_CNTNT")); // 결재사유
					paramDobj.put("SN_CCD", input.get("SN_CCD"));
					paramDobj.put("FIRST_SNO", input.get("FIRST_SNO"));


    				CUR_APP_NO = input.get("APP_NO").toString();	// 현재 결재ID

    				//반려일 경우
    				if ("R".equals(input.get("NOW_SN_CCD").toString()) ) {
    					paramDobj.put("APP_NO", CUR_APP_NO); //결재번호(FKEY)
    				}else {
    					output3 = MDaoUtilSingle.getData("get_APP_NO_SEQ", paramDobj);//결재번호 채번
    					paramDobj.put("APP_NO", output3.get("APP_NO"));
    				}
    				makeParamDobj = MDaoUtilSingle.getData("get_APP_MAKE_PARAM", paramDobj);
    				makeParamDobj.put("RA_ITEM_CD", input.get("RA_ITEM_CD"));

    				count = db.setData("AML_10_17_01_01_AmlAppr_Merge", makeParamDobj); //AML_APPR : 결재
    				db.setData("AML_10_17_01_01_AmlApprHist_Insert", makeParamDobj);	//AML_APPR_HIST : 결재이력
    				db.setData("AML_10_37_01_01_RA_ITEM_Update", makeParamDobj); //RA_ITEM_SCR : 결재번호 UPDATE
    				db.setData("AML_10_37_01_01_RA_ITEM_APPR_Merge", makeParamDobj); //RA_ITEM_APPR : 결재번호 INSERT
    				db.setData("AML_10_37_01_01_RA_ITEM_APPR_DTL_Merge", makeParamDobj); //RA_ITEM_APPR_DTL : 결재번호 INSERT
//				}else {
//					db.rollback();
//					ERRCODE = "00001";
//					ERRMSG = MessageHelper.getInstance().getMessage("0063", input.getText("LANG_CD"), "배치실행중인 RA가 존재합니다. 작업이 완료된 후 진행해주세요.");
//					WINMSG = MessageHelper.getInstance().getMessage("0063", input.getText("LANG_CD"), "배치실행중인 RA가 존재합니다. 작업이 완료된 후 진행해주세요.");
//				}

				if ( count > 0 ) {
					db.commit();
					ERRCODE = "00000";
					ERRMSG = MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다.");
					WINMSG = MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다.");
				}
			} else {
				ERRMSG = MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다.");
				ERRCODE = "00099";
				WINMSG = MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다.");
			}

			output.put("ERRCODE", ERRCODE);
			output.put("ERRMSG", ERRMSG);
			output.put("WINMSG", WINMSG);
//			output.put("gdRes", gdReq);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "insertCode_Body", e.getMessage());

			ERRCODE = "00001";
			ERRMSG = MessageHelper.getInstance().getMessage("0004", input.getText("LANG_CD"), "알수 없는 오류입니다.");
			WINMSG = MessageHelper.getInstance().getMessage("0004", input.getText("LANG_CD"), "알수 없는 오류입니다.");
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "insertCode_Body", e.getMessage());

			ERRCODE = "00001";
			ERRMSG = MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다.");
			WINMSG = MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다.");
		}finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (RuntimeException e) {
			} catch (Exception e) {
			}
		}

		return output;
	}

	/**결재이력 : 위험평가항목 검색*/
	public DataObj getRaAppr(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			if ("".equals(input.getText("SN_CCD"))) { //최종결재 이후 저장된 내역 있는 경우
				output = MDaoUtilSingle.getData("AML_10_37_01_01_getRaAppr_noAppr", input);
			} else {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_getRaAppr", input);
			}
			// grid data
			if ( output.getCount("APP_NO") > 0 ) {
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
			Log.logAML(Log.ERROR, this, "getRaAppr", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**결재이력 : 위험평가항목 검색*/
	public DataObj getRaApprHistory(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			output = MDaoUtilSingle.getData("AML_10_37_01_01_getRaApprHistory", input);
			// grid data
			if ( output.getCount("APP_NO") > 0 ) {
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

	/**결재이력 : 위험평가항목상세 검색*/
	public DataObj getRaApprDtlHistory(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			if("".equals(input.get("REFF_COMN_CD"))) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_getRaApprDtlHistory", input);
			}else {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_getRaApprDtlHistory_REFF", input);
			}

			// grid data
			if ( output.getCount("APP_NO") > 0 ) {
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

	/**위험평가항목 결재요청*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj applyRequest(DataObj input) {
		DataObj output = new DataObj();
		DataObj output3 = new DataObj();
		DataObj chkRAWK_ST = new DataObj();
		DataObj chk_SCR_REQ = new DataObj();
		DataObj makeParamDobj = new DataObj();

		String ERRCODE = "";
		String ERRMSG = "";
		String WINMSG = "";

		int count = 0;

		MDaoUtil db = null;
		try {
			db = new MDaoUtil();
			db.begin();

			if ( input.size() > 0 ) {

				//RA배치실행여부 체크
	        	chkRAWK_ST = MDaoUtilSingle.getData("CNT_SMUL_SNCCD_S", input);

				String countSMUL = chkRAWK_ST.getText("CNT");

				if("0".equals(countSMUL)) {
					DataObj paramDobj = new DataObj();
					paramDobj.put("GYLJ_LINE_G_C", "RA2");
					paramDobj.put("WLR_SQ", "0"); // WATCHLSIT검색결과_순번(FKEY)
					paramDobj.put("APPR_ROLE_ID", ((SessionAML) input.get("SessionAML")).getsAML_ROLE_ID());// ROLE_ID
					paramDobj.put("BRN_CD", ((SessionAML) input.get("SessionAML")).getsAML_BDPT_CD()); // BRN_CD
					paramDobj.put("HNDL_P_ENO", ((SessionHelper) input.get("SessionHelper")).getUserId()); // HNDL_DY_TM
					paramDobj.put("RSN_CNTNT", input.get("RSN_CNTNT")); // 결재사유
					paramDobj.put("SN_CCD", "E");
					paramDobj.put("FIRST_SNO", input.get("FIRST_SNO"));


					output3 = MDaoUtilSingle.getData("get_APP_NO_SEQ", paramDobj);//결재번호 채번
					paramDobj.put("APP_NO", output3.get("APP_NO"));

    				makeParamDobj = MDaoUtilSingle.getData("get_APP_MAKE_PARAM", paramDobj);
    				makeParamDobj.put("RA_ITEM_CD", input.get("RA_ITEM_CD"));

    				makeParamDobj.put("TARGET_ROLE_ID", "0");
    				count = db.setData("AML_10_17_01_01_AmlAppr_Merge", makeParamDobj); //AML_APPR : 결재
    				db.setData("AML_10_17_01_01_AmlApprHist_Insert", makeParamDobj);	//AML_APPR_HIST : 결재이력
    				db.setData("AML_10_37_01_01_RA_ITEM_Update", makeParamDobj); //RA_ITEM_SCR : 결재번호 UPDATE
    				db.setData("AML_10_37_01_01_RA_ITEM_APPR_Merge", makeParamDobj); //RA_ITEM_APPR : 결재번호 INSERT
    				db.setData("AML_10_37_01_01_RA_ITEM_APPR_DTL_Merge", makeParamDobj); //RA_ITEM_APPR_DTL : 결재번호 INSERT

    				db.setData("AML_10_37_01_01_delete_RA_ITEM_SCR", makeParamDobj);

    				chk_SCR_REQ = MDaoUtilSingle.getData("CHK_RA_ITEM_SCR_REQ", input);

    				String countREQ = chk_SCR_REQ.getText("CNT");

    				if(!"0".equals(countREQ)) {
    					db.setData("AML_10_37_01_01_insert_RA_ITEM_SCR", makeParamDobj);
    				}

				}else {
					db.rollback();
					ERRCODE = "00001";
					ERRMSG = MessageHelper.getInstance().getMessage("0063", input.getText("LANG_CD"), "배치실행중인 RA가 존재합니다. 작업이 완료된 후 진행해주세요.");
					WINMSG = MessageHelper.getInstance().getMessage("0063", input.getText("LANG_CD"), "배치실행중인 RA가 존재합니다. 작업이 완료된 후 진행해주세요.");
				}

				if ( count > 0 ) {
					db.commit();
					ERRCODE = "00000";
					ERRMSG = MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다.");
					WINMSG = MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다.");
				}

			} else {
				ERRMSG = MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다.");
				ERRCODE = "00099";
				WINMSG = MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다.");
			}

//			output.put("gdRes", gdReq);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "insertCode_Body", e.getMessage());

			ERRCODE = "00001";
			ERRMSG = MessageHelper.getInstance().getMessage("0004", input.getText("LANG_CD"), "알수 없는 오류입니다.");
			WINMSG = MessageHelper.getInstance().getMessage("0004", input.getText("LANG_CD"), "알수 없는 오류입니다.");
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "insertCode_Body", e.getMessage());

			ERRCODE = "00001";
			ERRMSG = MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다.");
			WINMSG = MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다.");
		}finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (RuntimeException e) {
			} catch (Exception e) {
			}
		}
		output.put("ERRCODE", ERRCODE);
		output.put("ERRMSG", ERRMSG);
		output.put("WINMSG", WINMSG);
		return output;
	}

	/**결재이력 : 위험평가항목 검색*/
	public DataObj getRaApplyHistory(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		try {
			if ("".equals(input.getText("SN_CCD"))) { //최종적용 이후 저장 (=미적용)된 내역 있는 경우
				output = MDaoUtilSingle.getData("AML_10_37_01_01_getRaApplyHistory_noApply", input);
			} else {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_getRaApplyHistory", input);
			}
			// grid data
			if ( output.getCount("APP_NO") > 0 ) {
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
	
	public DataObj getCodeSearch(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;
		String ntngubun;

		try {

			ntngubun = input.get("NTNGUBUN").toString();
			
			if("YN".equals(ntngubun)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_common_getComboDataNTN1", input);	
			}else if("NN".equals(ntngubun)) {
				output = MDaoUtilSingle.getData("AML_10_37_01_01_common_getComboDataNTN2", input);	
			}else if("YY".equals(ntngubun)){
				output = MDaoUtilSingle.getData("AML_10_37_01_01_common_getComboDataNTN", input);	
			}

			gdRes = Common.setGridData(output);
			
			HashMap returnMap = new HashMap();
			returnMap.put("RISK_ELMT_CD2", input.get("RISK_ELMT_CD2"));
			output.put("gdParam", returnMap);
			
			output.put("gdRes", gdRes);
			output.put("ERRCODE", "00000");
			
		} catch (AMLException e) {
			
			Log.logAML(1, this, "getCodeSearch(AMLException)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}

}
