package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_02;

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
 * 보고지표 관리
 * </pre>
 * @author 김홍진
 * @version 1.0
 * @history 1.0 2016-12-20
 */
public class RBA_90_01_02_04 extends GetResultObject {

	private static RBA_90_01_02_04 instance = null;

	/**
	 * getInstance
	 * @return RBA_90_01_02_04
	 */
	public static  RBA_90_01_02_04 getInstance() {
		synchronized(RBA_90_01_02_04.class) {
			if (instance == null) {
				instance = new RBA_90_01_02_04();
			}
		}
		return instance;
	}

	/**
	 * <pre>
	 * 보고지표 조회
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;
		try {

			String query_id = "RBA_90_01_02_01_getSearch";
			output = MDaoUtilSingle.getData(query_id, input);

			if ( output.getCount("JIPYO_IDX") > 0 ) {
				gdRes = Common.setGridData(output);
			}
			/*
			else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			*/
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

	public DataObj doSave(DataObj input) {

		DataObj output = null;
		MDaoUtil db = null;
		try {

			//SessionAML sess = (SessionAML) input.get("SessionAML");

			input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
			input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

			db = new MDaoUtil();
			db.begin();
			db.setData("RBA_90_01_02_02_merge_jrba_jipyo_m", input);
			db.commit();
			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "\uC815\uC0C1\uCC98\uB9AC\uB418\uC5C8\uC2B5\uB2C8\uB2E4..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "\uC815\uC0C1\uCC98\uB9AC\uB418\uC5C8\uC2B5\uB2C8\uB2E4."));
			output.put("gdRes", null);

		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	public DataObj doCheckJipyoIdx(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {

			DataObj resultDataobj = new DataObj();
			String query_id = "RBA_90_01_02_01_getSearch";
			output = MDaoUtilSingle.getData(query_id, input);

			if ( output.getCount("JIPYO_IDX") > 0 ) {
				resultDataobj.put("RESULT", "false");
			} else {
				resultDataobj.put("RESULT", "true");
			}

			gdRes = Common.setGridData(resultDataobj);

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException e) {

			Log.logAML(1, this, "doCheckJipyoIdx", e.getMessage());

			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		}
		return output;

	}

}