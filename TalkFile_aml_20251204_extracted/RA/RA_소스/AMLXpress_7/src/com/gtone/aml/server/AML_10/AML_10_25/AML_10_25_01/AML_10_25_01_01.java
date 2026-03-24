package com.gtone.aml.server.AML_10.AML_10_25.AML_10_25_01;

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

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
*<pre>
* 상픔 체크리스트 관리
*</pre>
*@author  
*@version 1.0
*@history 1.0 2025-05-02
*             2025-06 삼성증권 컨설팅 자료로 고도화   
*/
public class AML_10_25_01_01 extends GetResultObject {

	private static AML_10_25_01_01 instance = null;

	/**
	 * getInstance
	 * @return AML_10_25_01_01
	 */
	
	public static AML_10_25_01_01 getInstance() {
		if ( instance == null ) {
			instance = new AML_10_25_01_01();
		}
		return instance;
	}

	/**
	 * <pre>
	 * 체크리스트 조회
	 */
	public DataObj getSearch(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;

		try {

			output = MDaoUtilSingle.getData("AML_10_25_01_01_getSearch", input);

			gdRes = Common.setGridData(output);

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));

			output.put("ERRCODE", "00000");
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
	 * 체크리스트 삭제
	 */
	public DataObj doDelete(DataObj input) {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		int count = 0;

		try {

			mDao = new MDaoUtil();
			mDao.begin();

			List gdReq = (List) input.get("gdReq");

			for ( int i = 0; i < gdReq.size(); i++ ) {

				HashMap gridMap = (HashMap) gdReq.get(i);

				if( "N".equals( gridMap.get("SN_CCD") ) ) {

					mDao.setData("AML_10_25_01_01_PRD_CK_Delete", gridMap);
					mDao.setData("AML_10_25_01_02_PRD_CK_LST_Delete", gridMap);
					count++;
				}
			}

			if( count > 0 ) {

				mDao.commit();

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
				Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
			}

			Log.logAML(1, this, "doDelete(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		}finally{

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
	 * 체크리스트 결재이력 조회
	 */
	public DataObj getApprHstSearch(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;

		try {

			output = MDaoUtilSingle.getData("AML_10_25_01_01_PRD_CK_getApprHst", input);

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
