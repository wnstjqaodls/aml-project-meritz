package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_04;

import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.dao.MCommonDAOSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.DBUtil;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * FIU보고서 보고기준일 조회
 * </pre>
 *
 * @author SeungRok
 * @version 1.0
 * @hisory 16.12.13
 **/

public class RBA_90_01_04_01 extends GetResultObject {

	private static RBA_90_01_04_01 instance = null;

	/**
	 * getInstance
	 *
	 * @return RBA_90_01_04_01
	 */

	public static  RBA_90_01_04_01 getInstance() {
		synchronized(RBA_90_01_04_01.class) {
			if (instance == null) {
				instance = new RBA_90_01_04_01();
			}
		}
		return instance;
	}

	/**
	 * FIU 지표결과 조회
	 * @param input
	 * @return
	 */
	public DataObj doSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_90_01_04_01_getSearch1", input);

			// grid data
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

	/**
	 * FIU 보고파일 조회
	 * @param input
	 * @return
	 */
	public DataObj getSearchF(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_90_01_04_01_getSearch2", input);

			// grid data
			if ( output.getCount("ATTCH_FILE_NO") > 0 ) {
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
			Log.logAML(Log.ERROR, this, "getSearchF(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}

	/**
	 * FIU 보고파일 조회
	 * @param input
	 * @return
	 */
	public DataObj getSearchFList(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		String ATTCH_FILE_NO = "";

		try {

			output = MDaoUtilSingle.getData("RBA_90_01_04_01_getSearch2", input);
			List FileDetails = DBUtil.cacheResultSet2List(new MCommonDAOSingle().executeQuery("RBA_90_01_04_01_getSearch2", input)); //평가기준데이터

			// grid data
			if ( output.getCount("ATTCH_FILE_NO") > 0 ) {
				ATTCH_FILE_NO = Util.nvl(output.get("ATTCH_FILE_NO", 0), "");
				gdRes = Common.setGridData(output);
			} else {
				ATTCH_FILE_NO = "0";
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}

			output.put("FileDetails", FileDetails); //평가기준데이터
			output.put("ATTCH_FILE_NO", ATTCH_FILE_NO); //평가기준데이터

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (NumberFormatException e) {
			Log.logAML(Log.ERROR, this, "getSearchFList(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchFList(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "getSearchFList(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}

	public DataObj getSearchGYLJ(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_90_01_04_01_getSearch3", input);

			// grid data
			if ( output.getCount("GYLJ_S_C") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "getSearchGYLJ(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}

	public DataObj doDelete(DataObj input) throws AMLException {
		DataObj output = null;
		MDaoUtil db = null;

		try {
			List gdReq = (List) input.get("gdReq");
			db = new MDaoUtil();

			// 삭제 시작
			db.begin();
			int gdReq_size = gdReq.size();

			String ATTCH_FILE_NO = "";

			for ( int i = 0; i < gdReq_size; i++ ) {
				HashMap inputMap = (HashMap) gdReq.get(i);

				ATTCH_FILE_NO = inputMap.get("ATTCH_FILE_NO").toString();
				db.setData("RBA_90_01_04_01_DELETE_RBA_ATTCH_FILE", inputMap);
			}

			db.commit();

			if ( !"".equals(ATTCH_FILE_NO) ) {

				input.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				output = MDaoUtilSingle.getData("RBA_90_01_04_01_COUNT_ATTACH_FILE", input);

				if ( output.getInt("CNT") == 0 ) {
					db.setData("RBA_90_01_04_01_UPDATE_JRBA_RPT_RST_M", (HashMap) gdReq.get(0));
				}
				db.commit();
			}

			output = new DataObj();
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다..."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
			output.put("gdRes", null); // Wise Grid Data
		} catch (NumberFormatException e) {
			if ( db != null ) {
				db.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDeleteD", e.getMessage());
			if ( output != null ) {
				output.close();
			}
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (AMLException e) {
			if ( db != null ) {
				db.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDeleteD", e.getMessage());
			if ( output != null ) {
				output.close();
			}
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			try {
				if ( db != null ) {
					db.close();
				}
			} catch (Exception ee) {
				if ( output != null ) {
					try {
						output.close();
					} catch (Exception e1) {
						output = null;
					}
				}
			}
		}

		return output;
	}

}
