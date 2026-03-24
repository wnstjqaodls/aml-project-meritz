/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_30.RBA_30_06.RBA_30_06_07;

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

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 프로세스기준관리
 * </pre>
 * @author  HHJ
 * @version 1.0
 * @history 1.0 2018-04-20
 */
public class RBA_30_06_07_01 extends GetResultObject {

	private static RBA_30_06_07_01 instance = null;
	/**
	* getInstance
	* @return RBA_30_06_07_01
	*/
	public static  RBA_30_06_07_01 getInstance() {
		synchronized(RBA_30_06_07_01.class) {
			if (instance == null) {
				instance = new RBA_30_06_07_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 통제기준관리 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_07_01_getSearch", input);
			// grid data
			if (output.getCount("GRP_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	public DataObj doSearch_RBA_30_06_07_01(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_07_01_getSearch", input);
			// grid data
			if (output.getCount("GRP_C") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch_RBA_30_06_07_01", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	/**
	* <pre>
	* 통제기준관리 대분류 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_07_01_getSearch2", input);
			// grid data
			if (output.getCount("GRP_C") > 0) {
				gdRes = Common.setGridData(output);
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch2", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	public DataObj doSearch2_RBA_30_06_07_01(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_07_01_getSearch2", input);
			// grid data
			if (output.getCount("GRP_C") > 0) {
				gdRes = Common.setGridData(output);
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch2_RBA_30_06_07_01", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

    /**
	* <pre>
	* 통제기준관리 중분류 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch3(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_07_01_getSearch3", input);
			// grid data
			if (output.getCount("GRP_C") > 0) {
				gdRes = Common.setGridData(output);
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch3", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	public DataObj doSearch3_RBA_30_06_07_01(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_30_06_07_01_getSearch3", input);
			// grid data
			if (output.getCount("GRP_C") > 0) {
				gdRes = Common.setGridData(output);
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearch3_RBA_30_06_07_01", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}


	/**
	* <pre>
	* 통제기준관리 영역코드 저장
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
        List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				inputMap.put("CON_YN", "0" ); // 변경조작자번호

				mDao.setData("RBA_30_06_07_01_mergeSRBA_GRP_C", inputMap);
			}

			//DB commit
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

	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSave_RBA_30_06_07_01(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
        List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				inputMap.put("CON_YN", "0" ); // 변경조작자번호

				mDao.setData("RBA_30_06_07_01_mergeSRBA_GRP_C", inputMap);
			}

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doSave_RBA_30_06_07_01", ex.getMessage());
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


	/**
	* <pre>
	* 통제기준관리 대분류 저장
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSave2(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				inputMap.put("HGRK_GRP_C",(StringHelper.evl(input.get("HGRK_GRP_C"), "")));
				inputMap.put("HGRK_DTL_C",(StringHelper.evl(input.get("HGRK_DTL_C"), "")));

				mDao.setData("RBA_30_06_07_01_mergeSRBA_DTL_C", inputMap);
			}

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doSave2", ex.getMessage());
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

	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSave2_RBA_30_06_07_01(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				inputMap.put("HGRK_GRP_C",(StringHelper.evl(input.get("HGRK_GRP_C"), "")));
				inputMap.put("HGRK_DTL_C",(StringHelper.evl(input.get("HGRK_DTL_C"), "")));

				mDao.setData("RBA_30_06_07_01_mergeSRBA_DTL_C", inputMap);
			}

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doSave2_RBA_30_06_07_01", ex.getMessage());
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

	/**
	* <pre>
	* 통제기준관리 중분류 저장
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSave3(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				inputMap.put("HGRK_GRP_C",(StringHelper.evl(input.get("HGRK_GRP_C"), "")));
				inputMap.put("HGRK_DTL_C",(StringHelper.evl(input.get("HGRK_DTL_C"), "")));

				mDao.setData("RBA_30_06_07_01_mergeSRBA_DTL_C2", inputMap);
			}

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave3", ex.getMessage());
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

	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSave3_RBA_30_06_07_01(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				inputMap.put("OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				inputMap.put("HGRK_GRP_C",(StringHelper.evl(input.get("HGRK_GRP_C"), "")));
				inputMap.put("HGRK_DTL_C",(StringHelper.evl(input.get("HGRK_DTL_C"), "")));

				mDao.setData("RBA_30_06_07_01_mergeSRBA_DTL_C2", inputMap);
			}

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave3_RBA_30_06_07_01", ex.getMessage());
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

	/**
	* <pre>
	* 통제기준관리 영역코드 삭제
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings("rawtypes")
    public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

            output = MDaoUtilSingle.getData("RBA_30_06_07_01_getCount", input);

            if (output.getInt("COUNT") == 0 ){

            	gdReq = (List) input.get("gdReq");
     			int gdReq_size = gdReq.size();

     			for (int i = 0; i < gdReq_size; i++) {
     				HashMap inputMap = (HashMap) gdReq.get(i);
     				mDao.setData("RBA_30_06_07_01_Delete", inputMap);
     			}

     			//DB commit
     			mDao.commit();

     			output.put("ERRCODE", "00000");
     			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
     			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

            }else{

            	output.put("ERRCODE", "00000");
     			output.put("ERRMSG", "중분류 코드가 있는 경우 삭제 불가능합니다.");
     			output.put("WINMSG", "중분류 코드가 있는 경우 삭제 불가능합니다.");
            }


		} catch (NumberFormatException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete", ex.getMessage());
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

	@SuppressWarnings("rawtypes")
    public DataObj doDelete_RBA_30_06_07_01(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

            output = MDaoUtilSingle.getData("RBA_30_06_07_01_getCount", input);

            if (output.getInt("COUNT") == 0 ){

            	gdReq = (List) input.get("gdReq");
     			int gdReq_size = gdReq.size();

     			for (int i = 0; i < gdReq_size; i++) {
     				HashMap inputMap = (HashMap) gdReq.get(i);
     				mDao.setData("RBA_30_06_07_01_Delete", inputMap);
     			}

     			//DB commit
     			mDao.commit();

     			output.put("ERRCODE", "00000");
     			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
     			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

            }else{

            	output.put("ERRCODE", "00000");
     			output.put("ERRMSG", "중분류 코드가 있는 경우 삭제 불가능합니다.");
     			output.put("WINMSG", "중분류 코드가 있는 경우 삭제 불가능합니다.");
            }


		} catch (NumberFormatException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete_RBA_30_06_07_01", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete_RBA_30_06_07_01", ex.getMessage());
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

	/**
	* <pre>
	* 통제기준관리 대분류 삭제
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings("rawtypes")
    public DataObj doDelete2(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			output = MDaoUtilSingle.getData("RBA_30_06_07_01_getCount2", input);

	        if (output.getInt("COUNT") == 0 ){
				gdReq = (List) input.get("gdReq");
				int gdReq_size = gdReq.size();

				for (int i = 0; i < gdReq_size; i++) {
					HashMap inputMap = (HashMap) gdReq.get(i);
					mDao.setData("RBA_30_06_07_01_Delete2", inputMap);
				}

				//DB commit
				mDao.commit();

				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
	        }else{
	        	output.put("ERRCODE", "00000");
				output.put("ERRMSG", "소분류 코드가 있는 경우 삭제 불가능합니다.");
				output.put("WINMSG", "소분류 코드가 있는 경우 삭제 불가능합니다.");
	        }
		} catch (NumberFormatException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doDelete2", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doDelete2", ex.getMessage());
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

	@SuppressWarnings("rawtypes")
    public DataObj doDelete2_RBA_30_06_07_01(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			output = MDaoUtilSingle.getData("RBA_30_06_07_01_getCount2", input);

	        if (output.getInt("COUNT") == 0 ){
				gdReq = (List) input.get("gdReq");
				int gdReq_size = gdReq.size();

				for (int i = 0; i < gdReq_size; i++) {
					HashMap inputMap = (HashMap) gdReq.get(i);
					mDao.setData("RBA_30_06_07_01_Delete2", inputMap);
				}

				//DB commit
				mDao.commit();

				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
	        }else{
	        	output.put("ERRCODE", "00000");
				output.put("ERRMSG", "소분류 코드가 있는 경우 삭제 불가능합니다.");
				output.put("WINMSG", "소분류 코드가 있는 경우 삭제 불가능합니다.");
	        }
		} catch (NumberFormatException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doDelete2_RBA_30_06_07_01", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doDelete2_RBA_30_06_07_01", ex.getMessage());
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

	/**
	* <pre>
	* 통제기준관리 대분류 삭제
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings("rawtypes")
    public DataObj doDelete3(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();


			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				mDao.setData("RBA_30_06_07_01_Delete3", inputMap);
			}

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doDelete3", ex.getMessage());
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

	@SuppressWarnings("rawtypes")
    public DataObj doDelete3_RBA_30_06_07_01(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();


			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				mDao.setData("RBA_30_06_07_01_Delete3", inputMap);
			}

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}

			Log.logAML(Log.ERROR, this, "doDelete3_RBA_30_06_07_01", ex.getMessage());
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