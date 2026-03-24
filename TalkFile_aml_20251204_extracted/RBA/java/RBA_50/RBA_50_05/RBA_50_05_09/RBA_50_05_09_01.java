/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_09;

import java.util.HashMap;

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
 * 자금세탁 사례관리
 * </pre>
 * @author hikim
 * @version 1.0
 * @history 1.0 2017-06-12
 */
public class RBA_50_05_09_01 extends GetResultObject {

	private static RBA_50_05_09_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_09_01
	*/
	public static  RBA_50_05_09_01 getInstance() {
		synchronized(RBA_50_05_09_01.class) {  
			if (instance == null) {
				instance = new RBA_50_05_09_01();
			}
		}
		return instance;
	}
	/**
	* <pre>
	* 자금세탁 사례관리 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_09_01_getSearch", input);
			// grid data
			if (output.getCount("BAS_YYYY") > 0) {
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
	
	/**
	* <pre>
	* 자금세탁 사례관리 확정여부 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch2(DataObj input) {
		
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
		output = MDaoUtilSingle.getData("RBA_50_05_09_01_getSearch2", input);
			// grid data
			if (output.getCount("BAS_YYYY") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
	
	/**
	* <pre>
	*자금세탁 사례관리 확정 및 취소처리
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doConfirm(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		
		DataObj output1 = new DataObj(); // 노출정량평가기준 추출
		DataObj output4 = new DataObj(); // 노출사례횟수 및 등급 추출
		
		String query_id1 = null; // 노출정량평가기준 추출
		String query_id2 = null; // 노출정량평가기준 삭제
		String query_id3 = null; // 노출정량평가기준 등록
		String query_id4 = null; // 노출사례횟수 및 등급 추출
		String query_id5 = null; // 노출사례횟수 등급 반영
		
		HashMap input1 = new HashMap(); // 노출정량평가기준 등록 INPUT
		
		int cnt = 0; // 노출사례횟수

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			input.put("SCHD_FIX_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
			mDao.setData("RBA_50_05_09_01_setConfirm", input); //KRBA_VALT_SCHD_M 업데이트
			
			String schdFixYn = input.get("SCHD_FIX_YN").toString();
			
			if("1".equals(schdFixYn)){
				// 1.노출정량평가기준 추출
				query_id1 = "RBA_50_05_09_01_selectExpsi";
				output1 = mDao.getData(query_id1, input);
				// 2.노출정량평가기준 삭제
				query_id2 = "RBA_50_05_09_01_deleteExpsi";
				mDao.setData(query_id2, input);
				// 3.노출정량평가기준 등록
				input1.put("BAS_YYYY", input.get("BAS_YYYY"));
				input1.put("M_RSK_CNT", output1.get("M_RSK_CNT", 0));
				input1.put("H_RSK_CNT", output1.get("H_RSK_CNT", 0));
				query_id3 = "RBA_50_05_09_01_insertExpsi";
				mDao.setData(query_id3, input1);
				
				// 4.노출정량평가기준 추출
				query_id4 = "RBA_50_05_09_01_selectRskEventExpsi";
				output4 = mDao.getData(query_id4, input);
				
				cnt = output4.getCount();
				
				if(cnt > 0){
					query_id5 = "RBA_50_05_09_01_updateRskEvtM";
					for(int i = 0; i < cnt; i++){
						
						HashMap input5 = new HashMap();
						
						input5.put("BAS_YYYY", output4.get("BAS_YYYY", i));
						input5.put("RSK_CATG", output4.get("RSK_CATG", i));
						input5.put("RSK_FAC", output4.get("RSK_FAC", i));
						input5.put("RSK_EVT", output4.get("RSK_EVT", i));
						input5.put("EXPS_CNT", output4.get("EXPS_CNT", i));
						input5.put("EXPS_GD_C", output4.get("EXPS_GD_C", i));
						input5.put("RSK_LVL_C", output4.get("RSK_LVL_C", i));
						input5.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
						// 5.노출사례횟수 등급 반영
						mDao.setData(query_id5, input5);
					}
				}
			}
			
			//DB commit
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if ( mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doConfirm", ex.getMessage());
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
	 * 자금세탁 사례관리 상세 저장
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		
		try {
			mDao = new MDaoUtil();
			mDao.begin();
			
			if("0".equals(input.get("GUBN"))){
				mDao.setData("RBA_50_05_09_01_doSave", input);
			}else{
				mDao.setData("RBA_50_05_09_01_doSave1", input);
			}
			
			//DB commit
			mDao.commit();
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (AMLException ex) {
			if ( mDao != null) {
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
	
	/**
	 * <pre>
	 * 자금세탁 사례관리 상세 저장
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();

			mDao.setData("RBA_50_05_09_01_doDelete", input);
			
			//DB commit
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if ( mDao != null) {
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
}