package com.gtone.aml.server.AML_10.AML_10_25.AML_10_25_01;

import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.DateUtil;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.user.SessionAML;
import com.gtone.aml.watchlist.core.utils.StringUtil;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 *<pre>
 * 상픔 체크리스트 등록/결재
 *</pre>
 *@author  
 *@version 1.0
 *@history 1.0 2025-05-02
 *             2025-06 삼성증권 컨설팅 자료로 고도화   
 */
public class AML_10_25_01_02 extends GetResultObject {

	private static AML_10_25_01_02 instance = null;

	/**
	 * getInstance
	 * @return AML_10_25_01_02
	 */
	public static AML_10_25_01_02 getInstance() {
		if ( instance == null ) {
			instance = new AML_10_25_01_02();
		}
		return instance;
	}

	/**
	 * <pre>
	 * 상품 정보 조회
	 */
	public DataObj getSearch(DataObj input) {

		DataObj output = new DataObj();
		DataSet gdRes = null;

		String WINMSG = "";
		String ERRMSG = "";

		try {

			String prdCkId = StringHelper.evl( input.get("PRD_CK_ID"), "" );

			if( StringHelper.isNull(prdCkId)  ){

				output = MDaoUtilSingle.getData("AML_10_25_01_02_getSearch_PreCkLst", input);

			}else {

				output = MDaoUtilSingle.getData("AML_10_25_01_02_getSearch_ExstCkLst", input);	
			}

			gdRes = Common.setGridData(output);

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", ERRMSG);
			output.put("WINMSG", WINMSG);
			output.put("gdRes", gdRes);

		} catch (Exception e) {

			Log.logAML(1, this, "getSearch(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}


	/**
	 * <pre>
	 * 상품 정보 저장
	 */
	public DataObj doSave(DataObj input) {

		DataObj output = new DataObj();
		DataSet gdRes = null;
		MDaoUtil mDao = null;
		int count = 0;

		try {

			mDao = new MDaoUtil();
			mDao.begin();

			SessionAML sessAML = (SessionAML)input.get("SessionAML");

			String prdCkId = StringHelper.evl( input.get("PRD_CK_ID"), "" );

			HashMap saveMap = new HashMap();

			if( StringHelper.isNull(prdCkId) ) {

				DataObj seqObj = MDaoUtilSingle.getData("AML_10_25_01_02_getNextPrdCkIdSeq", input );
				prdCkId = seqObj.getText("PRD_CK_SEQ");

				saveMap.put("PRD_CK_ID", prdCkId);
				saveMap.put("TITLE", StringHelper.evl( input.get("TITLE"), "" ) );
				saveMap.put("REG_ID", sessAML.getsAML_LOGIN_ID() );
				saveMap.put("UPD_ID", sessAML.getsAML_LOGIN_ID() );

				mDao.setData("AML_10_25_01_02_PRD_CK_Insert", saveMap);

			}else {

				saveMap.put("PRD_CK_ID", prdCkId);
				saveMap.put("TITLE", StringHelper.evl( input.get("TITLE"), "" ) );
				saveMap.put("UPD_ID", sessAML.getsAML_LOGIN_ID() );

				mDao.setData("AML_10_25_01_02_PRD_CK_Update", saveMap);
				mDao.setData("AML_10_25_01_02_PRD_CK_LST_Delete", saveMap);
			}

			List gdReq = (List) input.get("gdReq");

			for ( int i = 0; i < gdReq.size(); i++ ) {

				HashMap gridMap = (HashMap) gdReq.get(i);
				gridMap.put("PRD_CK_ID", prdCkId);

				count = mDao.setData("AML_10_25_01_02_PRD_CK_LST_Insert", gridMap);
			}

			if( count > 0 ) {

				mDao.commit();

				output.put("PRD_CK_ID", prdCkId ); 
				gdRes = Common.setGridData(output);

				output.put("gdRes", gdRes);
				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));

			}else{

				mDao.rollback();

				output.put("ERRCODE", "00001");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다."));
			}


		}catch(Exception e) {

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			}

			Log.logAML(1, this, "doSave(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		}finally{

			try{

				if( mDao != null ) {
					mDao.close();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSaveGroup", ee.getMessage());
			}
		}

		return output; 
	}

	// 위험평가 상품 체크리스트 ( 결재요청 )
	@SuppressWarnings({"rawtypes", "unchecked"})
	public DataObj doApprReq(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		DataObj makeParamDobj = new DataObj();
		DataSet gdRes = null;

		MDaoUtil mDao = null;

		int count = 0;
		String CUR_APP_NO = null;
		String CUR_SN_CCD = null;

		try {

			mDao = new MDaoUtil();
			mDao.begin();

			SessionAML sessAML = (SessionAML)input.get("SessionAML");

			// save start ======================================================================
			String prdCkId = StringHelper.evl( input.get("PRD_CK_ID"), "" );
			CUR_APP_NO = StringHelper.evl(input.get("APP_NO"), "");
			CUR_SN_CCD = StringHelper.evl(input.get("SN_CCD"), "");

			HashMap saveMap = new HashMap();

			if( StringHelper.isNull(prdCkId) ) {

				DataObj seqObj = MDaoUtilSingle.getData("AML_10_25_01_02_getNextPrdCkIdSeq", input );
				prdCkId = seqObj.getText("PRD_CK_SEQ");

				saveMap.put("PRD_CK_ID", prdCkId);
				saveMap.put("TITLE", StringHelper.evl( input.get("TITLE"), "" ) );
				saveMap.put("REG_ID", sessAML.getsAML_LOGIN_ID() );
				saveMap.put("UPD_ID", sessAML.getsAML_LOGIN_ID() );

				mDao.setData("AML_10_25_01_02_PRD_CK_Insert", saveMap);

			}else {

				saveMap.put("PRD_CK_ID", prdCkId);
				saveMap.put("TITLE", StringHelper.evl( input.get("TITLE"), "" ) );
				saveMap.put("UPD_ID", sessAML.getsAML_LOGIN_ID() );

				mDao.setData("AML_10_25_01_02_PRD_CK_Update", saveMap);
				mDao.setData("AML_10_25_01_02_PRD_CK_LST_Delete", saveMap);
			}

			List gdReq = (List) input.get("gdReq");

			for ( int i = 0; i < gdReq.size(); i++ ) {

				HashMap gridMap = (HashMap) gdReq.get(i);
				gridMap.put("PRD_CK_ID", prdCkId);

				mDao.setData("AML_10_25_01_02_PRD_CK_LST_Insert", gridMap);
			}
			// save end ======================================================================


			// appr start ====================================================================== 

			DataObj paramDobj = new DataObj();
			paramDobj.put("GYLJ_LINE_G_C", "PRD01");
			paramDobj.put("WLR_SQ", 0); 
			paramDobj.put("APPR_ROLE_ID", ((SessionAML)input.get("SessionAML")).getsAML_ROLE_ID() );
			paramDobj.put("BRN_CD", ((SessionAML)input.get("SessionAML")).getsAML_BDPT_CD() );
			paramDobj.put("HNDL_P_ENO", ((SessionHelper)input.get("SessionHelper")).getUserId() );
			paramDobj.put("FIRST_SNO", StringHelper.evl(input.get("FIRST_SNO"), "") );
			paramDobj.put("RSN_CNTNT", StringHelper.evl(input.get("RSN_CNTNT"), "") );
			paramDobj.put("SN_CCD", "S" );
			paramDobj.put( "PRV_APP_NO", StringHelper.evl(input.get("PRV_APP_NO"), "") );
			
			if ("R".equals( CUR_SN_CCD ) ) {

				paramDobj.put("APP_NO", CUR_APP_NO );

			}else {

				output2 = MDaoUtilSingle.getData("AML_10_25_01_02_get_PRD_APP_NO", paramDobj );
				paramDobj.put( "APP_NO", StringHelper.evl(output2.get("APP_NO"), "") );
				
			}

			makeParamDobj = MDaoUtilSingle.getData("get_APP_MAKE_PARAM", paramDobj);
			count = mDao.setData("AML_10_17_01_01_AmlAppr_Merge", makeParamDobj);  // AML_APPR : 결재
			mDao.setData("AML_10_17_01_01_AmlApprHist_Insert", makeParamDobj);	//AML_APPR_HIST : 결재이력

			saveMap.put("APP_NO", paramDobj.get("APP_NO") );
			count = mDao.setData("AML_10_25_01_02_PRD_CK_Appr_Update", saveMap);

			// appr end  ====================================================================== 

			if( count > 0 ) {

				mDao.commit();

				output.put("PRD_CK_ID", prdCkId ); 
				gdRes = Common.setGridData(output);

				output.put("gdRes", gdRes);
				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));

			}else{

				mDao.rollback();

				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다."));
			}

		}catch(Exception e) {

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doApprReq", e.getMessage());
			}

			Log.logAML(1, this, "doApprReq(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		}finally{

			try{

				if( mDao != null ) {
					mDao.close();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doApprReq", ee.getMessage());
			}
		}

		return output;
	}


	// 위험평가 상품 체크리스트 ( 결재/반려  )
	@SuppressWarnings({"rawtypes", "unchecked"})
	public DataObj doAppr(DataObj input) {

		DataObj output = new DataObj();
		DataObj output2 = new DataObj();
		DataObj makeParamDobj = new DataObj();

		MDaoUtil mDao = null;

		int count = 0;
		String SNCCD = "";
		String CUR_APP_NO = "";

		try {

			mDao = new MDaoUtil();
			mDao.begin();

			DataObj paramDobj = new DataObj();
			paramDobj.put("GYLJ_LINE_G_C", "PRD01");
			paramDobj.put("WLR_SQ", 0); 
			paramDobj.put("APP_NO", StringHelper.evl(input.get("APP_NO"), "") );
			paramDobj.put("APPR_ROLE_ID", ((SessionAML)input.get("SessionAML")).getsAML_ROLE_ID() );
			paramDobj.put("BRN_CD", ((SessionAML)input.get("SessionAML")).getsAML_BDPT_CD() );
			paramDobj.put("HNDL_P_ENO", ((SessionHelper)input.get("SessionHelper")).getUserId() );
			paramDobj.put("SN_CCD", StringHelper.evl(input.get("SN_CCD"), "") );
			paramDobj.put("FIRST_SNO", StringHelper.evl(input.get("FIRST_SNO"), "") );
			paramDobj.put("RSN_CNTNT", StringHelper.evl(input.get("RSN_CNTNT"), "") );
			paramDobj.put( "PRV_APP_NO", StringHelper.evl(input.get("PRV_APP_NO"), "") );
			
			makeParamDobj = MDaoUtilSingle.getData("get_APP_MAKE_PARAM", paramDobj);
			count = mDao.setData("AML_10_17_01_01_AmlAppr_Merge", makeParamDobj);  // AML_APPR : 결재
			mDao.setData("AML_10_17_01_01_AmlApprHist_Insert", makeParamDobj);	//AML_APPR_HIST : 결재이력

			if( "S".equals( StringHelper.evl(input.get("SN_CCD"), "") ) ) {

				// 일련번호 생성
				SessionAML sessAML = (SessionAML)input.get("SessionAML");
				String prdCkId = StringHelper.evl( input.get("PRD_CK_ID"), "" );
				HashMap saveMap = new HashMap();
				saveMap.put("PRD_CK_ID", prdCkId );
				saveMap.put("VERSION_ID", "PRDCK"+ DateUtil.getShortDateString() + StringUtil.lpad( prdCkId, 3, '0' ) );
				saveMap.put("UPD_ID", sessAML.getsAML_LOGIN_ID() );
				count = mDao.setData("AML_10_25_01_02_PRD_CK_VsId_Update", saveMap);
			}

			if( count > 0 ) {

				mDao.commit();

				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));

			}else{

				mDao.rollback();

				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다."));
			}

		}catch(Exception e) {

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doAppr", e.getMessage());
			}

			Log.logAML(1, this, "doAppr(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		}finally{

			try{

				if( mDao != null ) {
					mDao.close();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doAppr", ee.getMessage());
			}
		}

		return output;
	}

}
