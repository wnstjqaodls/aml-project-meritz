package com.gtone.rba.server.type03.RBA_50.RBA_50_04.RBA_50_04_01;

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
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 통제 부서정보 조회
 * </pre>
 * @author LCJ
 * @version 1.0
 * @history 1.0 2018-05-09
 */
public class RBA_50_04_01_03 extends GetResultObject {

	private static RBA_50_04_01_03 instance = null;
	/**
	* getInstance
	* @return RBA_50_04_01_03
	*/
	public static  RBA_50_04_01_03 getInstance() {
		synchronized(RBA_50_04_01_03.class) {
			if (instance == null) {
				instance = new RBA_50_04_01_03();
			}
		}
		return instance;
	}

	/**
	   * <pre>
	   * 평가 등록지점조회
	   * </pre>
	   * @param input
	   * @return
	   */
	public DataObj doSearchBrno(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_04_01_03_getSearchBrno", input);
			// grid data
			if (output.getCount("BRNO") > 0) {
				gdRes = Common.setGridData(output);
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearchBrno(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}

	  /**
	   * <pre>
	   * 평가 미등록지점조회
	   * </pre>
	   * @param input
	   * @return
	   */
	public DataObj doSearchBrno2(DataObj input) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_04_01_03_getSearchBrno2", input);
			// grid data
			if (output.getCount("BRNO") > 0) {
				gdRes = Common.setGridData(output);
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearchBrno2(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}


	public DataObj doSave2(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
        List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();



			mDao.setData("RBA_50_04_01_03_doSave_DELETE", input);
			mDao.commit();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			output = new DataObj();

			String loginId = ((SessionHelper) input.get("SessionHelper")).getLoginId();


			for (int i = 0; i < gdReq_size; i++) {

				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("BAS_YYMM", input.get("BAS_YYMM") );
				inputMap.put("CNTL_ELMN_C", input.get("CNTL_ELMN_C") );
				inputMap.put("TGT_YN", "1" );
				inputMap.put("DR_OP_JKW_NO", loginId );
				mDao.setData("RBA_50_04_01_03_doSave_INSERT", inputMap);
				/*
				 * if(input.get("USE_KBN") != null && !"".equals(input.get("USE_KBN"))&&
				 * !"N".equals(input.get("USE_KBN"))) { if("Y".equals(input.get("USE_KBN"))) {
				 * mDao.setData("RBA_50_04_03_01_doSave_INSERT", inputMap); } }
				 */
			}
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}



}