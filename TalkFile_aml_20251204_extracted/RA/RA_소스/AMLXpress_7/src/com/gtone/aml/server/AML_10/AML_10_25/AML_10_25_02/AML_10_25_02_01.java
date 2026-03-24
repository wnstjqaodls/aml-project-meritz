package com.gtone.aml.server.AML_10.AML_10_25.AML_10_25_02;

import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
*<pre>
* 신상품 위험평가 등록/조회/삭제
*</pre>
*@author  
*@version 1.0
*@history 1.0 2025-06 삼성증권 컨설팅 자료   
*/
public class AML_10_25_02_01 extends GetResultObject {

	private static AML_10_25_02_01 instance = null;

	/**
	 * getInstance
	 * @return AML_10_25_02_01
	 */
	
	public static AML_10_25_02_01 getInstance() {
		if ( instance == null ) {
			instance = new AML_10_25_02_01();
		}
		return instance;
	}

	/**
	 * <pre>
	 * 위험평가 상품 구분 코드 조회
	 */
	public DataObj getCodeSearch(DataObj input) {
		
		DataObj output = null; 
		DataSet gdRes = null;
		String searchgubun;

		try {

			searchgubun = input.getText("searchgubun");
			
			if("Y".equals(searchgubun)) {
				/* 2차때 변경해야함*/
				output = MDaoUtilSingle.getData("AML_10_25_02_01_getCdSearch2", input);
			}else {
				output = MDaoUtilSingle.getData("AML_10_25_02_01_getCdSearch", input);	
			}
			
			gdRes = Common.setGridData(output);
			
			HashMap returnMap = new HashMap();
			returnMap.put("PRD_TP_CD", input.get("PRD_TP_CD"));
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
	
	/**
	 * <pre>
	 * 위험평가 조회
	 */
	public DataObj getSearch(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;

		try {

			output = MDaoUtilSingle.getData("AML_10_25_02_01_getSearch", input);

			gdRes = Common.setGridData(output);

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
			output.put("gdRes", gdRes);
			
		} catch (AMLException e) {
			
			Log.logAML(1, this, "getSearch(AMLException)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	/**
	 * <pre>
	 * 위험평가 조회
	 */
	public DataObj getSearch2(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;

		try {

			output = MDaoUtilSingle.getData("AML_10_25_02_01_getSearch2", input);

			gdRes = Common.setGridData(output);

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
			output.put("gdRes", gdRes);
			
		} catch (AMLException e) {
			
			Log.logAML(1, this, "getSearch(AMLException)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	/**
	 * <pre>
	 * 위험평가 임시저장건 삭제 
	 */
	
	public DataObj doDelete(DataObj input) {

		DataObj output = null;
		MDaoUtil mDao = null;
		
		try {

			output = new DataObj();
			mDao = new MDaoUtil();
			mDao.begin();

			List gdReq = (List) input.get("gdReq");

			for ( int i = 0; i < gdReq.size(); i++ ) {

				HashMap gridMap = (HashMap) gdReq.get(i);

				mDao.setData("AML_10_25_02_01_PRD_Evltn_Delete", gridMap);
				mDao.setData("AML_10_25_02_01_PRD_Evltn_RSLT_Delete", gridMap);
				mDao.setData("AML_10_25_02_01_PRD_Evltn_ATTACH_Delete", gridMap);
				mDao.setData("AML_10_25_02_01_PRD_Aml_Appr_Delete", gridMap);
				mDao.setData("AML_10_25_02_01_PRD_Aml_Appr_Hist_Delete", gridMap);
			}
			
			mDao.commit();
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));

		} catch (AMLException e) {

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doDelete", ee.getMessage());
			}

			Log.logAML(1, this, "doDelete(AMLException)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
 
		}catch(Exception e){
			
			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doDelete", ee.getMessage());
			}

			Log.logAML(Log.ERROR,this,"doDelete",e.toString()); 
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		}finally {

			try{

				if( mDao != null ) {
					mDao.close();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doDelete", ee.getMessage());
			}
		}

		return output;
	}
	
	
	/**
	 * <pre>
	 * 위험평가 결재이력 조회
	 */
	public DataObj getApprHstSearch(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;

		try {

			output = MDaoUtilSingle.getData("AML_10_25_02_01_PRD_Evltn_getApprHst", input);

			gdRes = Common.setGridData(output);

			output.put("gdRes", gdRes);
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
			
		} catch (AMLException e) {
			
			Log.logAML(1, this, "getApprHstSearch(AMLException)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
}
