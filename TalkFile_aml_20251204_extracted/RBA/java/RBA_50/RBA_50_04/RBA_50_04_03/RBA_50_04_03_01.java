package com.gtone.rba.server.type03.RBA_50.RBA_50_04.RBA_50_04_03;

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
 * 프로세스별 통제활동 관리
 * </pre>
 * @author LCJ
 * @version 1.0
 * @history 1.0 2018-04-30
 */
public class RBA_50_04_03_01 extends GetResultObject {

	private static RBA_50_04_03_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_01_01
	*/
	public static  RBA_50_04_03_01 getInstance() {
		if (instance == null) {
			instance = new RBA_50_04_03_01();
		}
		return instance;
	}

	/**
	* <pre>
	* 프로세스 리스트 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_04_03_01_doSearch", input);
			// grid data
			if (output.getCount("CNTL_ELMN_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}


	/**
	* <pre>
	* 통제리스트조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {

		output = MDaoUtilSingle.getData("RBA_50_04_03_01_doSearch2", input);
			// grid data
			if (output.getCount("PROC_LGDV_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch2(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}
	
	
	
	/**
	* <pre>
	* 통제활동통계 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch3(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {

		output = MDaoUtilSingle.getData("RBA_50_04_03_09_doSearch", input);
			// grid data
			if (output.getCount("BRNO_NM") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch3(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}


	/**
	* <pre>
	* 통제,프로세스 맵핑 데이터 저장
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
        List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			output = new DataObj();

			String loginId = ((SessionHelper) input.get("SessionHelper")).getLoginId();

			mDao.setData("RBA_50_04_03_01_doSave_DELETE", input);

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("DR_OP_JKW_NO", loginId );
				inputMap.put("PROC_FLD_C", "1");
				inputMap.put("TONGJE_FLD_C", input.get("TONGJE_FLD_C"));
				inputMap.put("TONGJE_LGDV_C", input.get("TONGJE_LGDV_C"));
				inputMap.put("TONGJE_MDDV_C", input.get("TONGJE_MDDV_C"));
				inputMap.put("TONGJE_SMDV_C", input.get("TONGJE_SMDV_C"));

				if(input.get("USE_KBN") != null &&  !"".equals(input.get("USE_KBN"))&&  !"N".equals(input.get("USE_KBN"))) {
					if("Y".equals(input.get("USE_KBN"))) {
						mDao.setData("RBA_50_04_03_01_doSave_INSERT", inputMap);
					}
				}


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