package com.gtone.rba.server.type03.RBA_50.RBA_50_02.RBA_50_02_02;


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
 * 부서별 업무프로세스관리
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-25
 */
public class RBA_50_02_02_01 extends GetResultObject {

	private static RBA_50_02_02_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_02_02_01
	*/
	public static  RBA_50_02_02_01 getInstance() {
		synchronized(RBA_50_02_02_01.class) {  
			if (instance == null) {
				instance = new RBA_50_02_02_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 부서별 업무프로세스관리   부서조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_02_02_01_doSearch", input);
		
			if (output.getCount("BAS_YYMM") > 0) {
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
	* 부서별 업무프로세스관리   프로세스조회
	* </pre>
	* @param input
	* @return
	*/
	
	public DataObj doSearch2(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_02_02_01_doSearch2", input);
		
			if (output.getCount("BAS_YYMM") > 0) {
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
	* 프로세스 운영여부 저장
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
			String loginId = ((SessionHelper) input.get("SessionHelper")).getLoginId();
			
			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				
				inputMap.put("CHG_OP_JKW_NO", loginId );
				inputMap.put("DR_OP_JKW_NO", loginId ); 
				
				mDao.setData("RBA_50_02_02_01_doSave", inputMap);	
				
			}
			input.put("CHG_OP_JKW_NO", loginId );
			input.put("DR_OP_JKW_NO", loginId );
			
			// SRBA_V_PROC_GYLJ 테이블 update
			int reaultNum = mDao.setData("RBA_50_02_02_01_doSave_updateSRBA_V_PROC_GYLJ", input);
			
			//SRBA_V_PROC_GYLJ 테이블의 update가 한건이상 될때   즉 결재 진행 후 다시 저장할때
			if(reaultNum > 0) {
				// 재승인요청 or 반려 or 승인 시 결재일련번호 채번
				DataObj gyljSerObj = mDao.getData("RBA_50_03_02_03_doSave_getGyljSer", input);
				// 채번내역 세팅
				String gyljSer = gyljSerObj.get("MAX_GYLJ_SER").toString();
				input.put("GYLJ_SER", gyljSer); // 결재일련번호
				input.put("GYLJ_S_C", "11");  //결재 상태 구분 코드 11:저장
				input.put("GYLJ_JKW_NO", loginId);  //결재 상태 구분 코드 11:저장
				// 결재이력등록 - 결재진행내역등록
				mDao.setData("RBA_50_03_02_03_doSave_insertAddKRBA_GYLJ_H", input);
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