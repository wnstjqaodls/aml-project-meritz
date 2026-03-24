/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_06;

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

/******************************************************************************************************************************************
 * @Description FIU지표기준정보
 * @Group       GTONE, R&D센터
 * @Project     RBA
 * @Java        7.0 이상
 * @Author      이혁준
 * @Since       2018. 12. 04.
 ******************************************************************************************************************************************/

public class RBA_90_01_06_01 extends GetResultObject {

    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/
    
    /** 인스턴스 */
	private static RBA_90_01_06_01 instance = null;
	
    /**
     * 인스턴스 반환.
     * <p>
     * @return RBA_90_01_06_01
     */ 
	public static  RBA_90_01_06_01 getInstance() {
		synchronized(RBA_90_01_06_01.class) {  
			if (instance == null) {
				instance = new RBA_90_01_06_01();
			}
		}
		return instance;
	}
	
    /**
     * RBA보고그룹코드(JRBA_GRP_C 테이블)목록의 데이터 조회<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(RBA보고그룹코드목록 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     */ 
	@SuppressWarnings("rawtypes")
	public DataObj getSearchG(DataObj input) {
	    
		DataObj output = null;
	    DataSet gdRes = null;
	    try {

	    	// 그룹코드 조회
	    	output = MDaoUtilSingle.getData("RBA_90_01_06_01_getSearchG", (HashMap) input);

	    	// grid data
	    	if (output.getCount("GRP_CD") > 0) {
	    		gdRes = Common.setGridData(output);
	    	} else {
	    		output.put(
	    			"ERRMSG",
	                MessageHelper.getInstance().getMessage("0001",
	                input.getText("LANG_CD"), "조회된 정보가 없습니다."));

	    	}

	    	output.put("ERRCODE", "00000");
	    	output.put("gdRes", gdRes);

	    } catch (AMLException e) {
	    	Log.logAML(Log.ERROR, this, "getSearchG(Exception)", e.getMessage());
	    	output = new DataObj();
	    	output.put("ERRCODE", "00001");
	    	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    }
	    return output;
	  
	}

    /**
     * RBA보고그룹코드저장<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(저장처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws AMLException 
     */	
	@SuppressWarnings("unchecked")
	public DataObj doSaveG(DataObj input) throws AMLException {
	    
		DataObj output = null;
	    MDaoUtil db = null;
	    try {

	    	@SuppressWarnings("rawtypes")
	    	List gdReq = (List) input.get("gdReq");

	    	db = new MDaoUtil();
	    	db.begin();

	    	int gdReq_size = gdReq.size();
	    	for (int i = 0; i < gdReq_size ; i++) {
	    		@SuppressWarnings("rawtypes")
	    		HashMap inputRow = (HashMap) gdReq.get(i);

		        inputRow.put("RPT_GJDT", (StringHelper.evl(input.get("RPT_GJDT"), "")));
	
		        inputRow.put("GRP_NM", (StringHelper.evl(inputRow.get("GRP_NM"), "")));
		        inputRow.put("BIGO_CTNT", (StringHelper.evl(inputRow.get("BIGO_CTNT"), "")));
		        inputRow.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
		        inputRow.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());

		        db.setData("RBA_90_01_06_01_merge_jrba_grp_c", inputRow);
	    	}
	      
	    	db.commit();

	    	output = new DataObj();
	    	output.put("ERRCODE", "00000");
	    	output.put(
	          "ERRMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다..."));
	    	output.put(
	          "WINMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다."));
	    	output.put("gdRes", null); // Grid Data

	    }  catch (AMLException e) {
	      
	    	if (db != null) {
	    		db.rollback();
	    	}
	      
	    	Log.logAML(Log.ERROR, this, "doSaveG", e.getMessage());

	    	output = new DataObj();
	    	output.put("ERRCODE", "00001");
	    	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    
	    } finally {
	    	if (db != null) {
	    		db.close();
	    	}
	    }
	    return output;	 
	}

    /**
     * RBA보고그룹코드삭제<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(삭제처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws AMLException 
     */
	@SuppressWarnings("unchecked")
	public DataObj doDeleteG(DataObj input) throws AMLException {
	    
		DataObj output = null;
		DataObj outputcheck = null;
	    MDaoUtil db = null;
	    boolean retValue = true; 
	    String chkGrpCd = "";

	    try {

	    	@SuppressWarnings("rawtypes")
	    	List gdReq = (List) input.get("gdReq");

	    	db = new MDaoUtil();

	    	// 삭제 시작
	    	db.begin();

	    	int gdReq_size = gdReq.size();
	    	for (int i = 0; i < gdReq_size ; i++) {
	    		@SuppressWarnings("rawtypes")
	    		HashMap inputMap = (HashMap) gdReq.get(i);
	    		inputMap.put("RPT_GJDT", (StringHelper.evl(input.get("RPT_GJDT"), "")));
	    		inputMap.put("GRP_CD", (StringHelper.evl(inputMap.get("GRP_CD"), "")));

	    		outputcheck = MDaoUtilSingle.getData("RBA_90_01_06_01_getSearchD", (HashMap) inputMap);	 
	    		
	    		if (outputcheck.getCount("GRP_CD") > 0) {
	    	    	retValue = false;
	    	    	chkGrpCd = (String)inputMap.get("GRP_CD");
	    	    	break;
	    		} else {	    		
	    			db.setData("RBA_90_01_06_01_delete_jrba_grp_c", inputMap);
	    		}
	    	}

	    	if (retValue) {
		    	db.commit();
	
		    	output = new DataObj();
		    	output.put("ERRCODE", "00000");
		    	output.put(
		          "ERRMSG",
		          MessageHelper.getInstance().getMessage("0002",
		              input.getText("LANG_CD"), "정상처리되었습니다."));
		    	output.put(
		          "WINMSG",
		          MessageHelper.getInstance().getMessage("0002",
		              input.getText("LANG_CD"), "정상처리되었습니다."));
		    	output.put("gdRes", null); // Wise Grid Data
	    	} else {
	    		db.rollback();
    	    	output = new DataObj();
    	    	output.put("ERRCODE", "00000");
    	    	output.put(
    	          "ERRMSG",
    	          "그룹코드 " + chkGrpCd + " 하위에 상세코드정보가 존재하여 삭제할 수 없습니다.");
    	    	output.put(
    	          "WINMSG",
    	          "그룹코드 " + chkGrpCd + " 하위에 상세코드정보가 존재하여 삭제할 수 없습니다.");
    	    	output.put("gdRes", null); // Wise Grid Data	    		
	    	}
	    }  catch (AMLException e) {
	    	if (db != null) {
	    		db.rollback();
	    	}
	      
	    	Log.logAML(Log.ERROR, this, "doDeleteG", e.getMessage());

	    	output = new DataObj();
	    	output.put("ERRCODE", "00001");
	    	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    } finally {
	    	if (db != null) {
	    		db.close();
	    	}
	    }
	    return output;  
	}	
	
    /**
     * RBA상세코드(JRBA_DTL_C 테이블)목록의 데이터 조회<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(RBA상세코드목록 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     */ 
	@SuppressWarnings("rawtypes")
	public DataObj getSearchD(DataObj input) {
	    
		DataObj output = null;
	    DataSet gdRes = null;
	    try {

	    	// 상세코드 조회
	    	output = MDaoUtilSingle.getData("RBA_90_01_06_01_getSearchD",
	    			(HashMap) input);

	    	// grid data
	    	if (output.getCount("GRP_CD") > 0) {
	    		gdRes = Common.setGridData(output);
	    	} else {
	    		output.put(
	    			"ERRMSG",
	    			MessageHelper.getInstance().getMessage("0001",
	                input.getText("LANG_CD"), "조회된 정보가 없습니다."));
	    	}

	    	output.put("ERRCODE", "00000");
	    	output.put("gdRes", gdRes);

	    } catch (AMLException e) {
	    	Log.logAML(Log.ERROR, this, "getSearchD(Exception)", e.getMessage());
	    	output = new DataObj();
	    	output.put("ERRCODE", "00001");
	    	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    }
	    return output;
	  
	}	
	
    /**
     * RBA상세코드저장<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(저장처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     */
	@SuppressWarnings("unchecked")
	public DataObj doSaveD(DataObj input) {
	    
		DataObj output = null;
	    MDaoUtil db = null;
	    try {

	    	@SuppressWarnings("rawtypes")
	    	List gdReq = (List) input.get("gdReq");

	    	db = new MDaoUtil();
	    	db.begin();

	    	int gdReq_size = gdReq.size();
	    	for (int i = 0; i < gdReq_size ; i++) {
		        @SuppressWarnings("rawtypes")
		        HashMap inputRow = (HashMap) gdReq.get(i);
	
		        inputRow.put("RPT_GJDT", (StringHelper.evl(input.get("RPT_GJDT"), "")));
	
		        inputRow.put("DTL_CD", (StringHelper.evl(inputRow.get("DTL_CD"), "")));
		        inputRow.put("DTL_NM", (StringHelper.evl(inputRow.get("DTL_NM"), "")));
		        inputRow.put("HRNK_RBA_RSK_C", (StringHelper.evl(inputRow.get("HRNK_RBA_RSK_C"), "")));
		        inputRow.put("HRNK_RBA_RSK_C_V",(StringHelper.evl(inputRow.get("HRNK_RBA_RSK_C_V"), "")));
		        inputRow.put("DR_OP_JKW_NO",((SessionHelper) input.get("SessionHelper")).getLoginId());
		        inputRow.put("CHG_OP_JKW_NO",((SessionHelper) input.get("SessionHelper")).getLoginId());
	        
		        db.setData("RBA_90_01_06_01_merge_jrba_dtl_c", inputRow);
	    	}
	    	
	    	db.commit();

	    	output = new DataObj();
	    	output.put("ERRCODE", "00000");
	    	output.put(
	          "ERRMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다..."));
	    	output.put(
	          "WINMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다."));
	    	output.put("gdRes", null); // Grid Data

	    } catch (AMLException re) {
	      
	    	try {
	    		if (db != null) {
	    			db.rollback();
	    		}
	    	} catch (AMLException ee) {
	    		Log.logAML(Log.ERROR, this, "doSaveD",ee.getMessage());
	    	}
	    	
	    	Log.logAML(Log.ERROR, this, "doSaveD",re.getMessage());

	    	output = new DataObj();
	    	output.put("ERRCODE", "00001");
	    	output.put("ERRMSG",re.toString());    
	    
	    }  catch (Exception e) {
	    	try {
	    		if (db != null) {
	    			db.rollback();
	    		}
	    	} catch (AMLException ee) {
	    		if (output != null) {
	    			try {
	    				output.close();
	    			} catch (Exception e1) {
	    				output = null;
	    			}
	    		}
	    	}
	      
	    	Log.logAML(Log.ERROR, this, "doSaveD", e.getMessage());

	    	output = new DataObj();
	    	output.put("ERRCODE", "00001");
	    	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    
	    } finally {
	      
	    	try {
	    		if (db != null) {
	    			db.close();
	    		}
	    	} catch (Exception ee) {
	    		if (output != null) {
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

    /**
     * RBA상세코드삭제<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(삭제처리결과 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     */
	@SuppressWarnings("unchecked")
	public DataObj doDeleteD(DataObj input) {
	    
		DataObj output = null;
	    MDaoUtil db = null;

	    try {

	    	@SuppressWarnings("rawtypes")
	    	List gdReq = (List) input.get("gdReq");

	    	db = new MDaoUtil();

	    	// 삭제 시작
	    	db.begin();

	    	int gdReq_size = gdReq.size();
	    	for (int i = 0; i < gdReq_size ; i++) {
		        @SuppressWarnings("rawtypes")
		        HashMap inputMap = (HashMap) gdReq.get(i);
		        inputMap.put("RPT_GJDT", (StringHelper.evl(input.get("RPT_GJDT"), "")));
	
		        inputMap.put("DTL_CD", (StringHelper.evl(inputMap.get("DTL_CD"), "")));
		        inputMap.put("GRP_CD", (StringHelper.evl(inputMap.get("GRP_CD"), "")));
		        db.setData("RBA_90_01_06_01_delete_jrba_dtl_c", inputMap);

	    	}

	    	db.commit();

	    	output = new DataObj();
	    	output.put("ERRCODE", "00000");
	    	output.put(
	          "ERRMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다..."));
	    	output.put(
	          "WINMSG",
	          MessageHelper.getInstance().getMessage("0002",
	              input.getText("LANG_CD"), "정상처리되었습니다."));
	    	output.put("gdRes", null); // Wise Grid Data

	    } catch (AMLException re) {
		      
	    	try {
	    		if (db != null) {
	    			db.rollback();
	    		}
	    	} catch (AMLException ee) {
	    		Log.logAML(Log.ERROR, this, "doDeleteD",ee.getMessage());
	    	}
	    	Log.logAML(Log.ERROR, this, "doDeleteD", re.getMessage());

	    	output = new DataObj();
	    	output.put("ERRCODE", "00001");
	    	output.put("ERRMSG",re.toString());     
	    }  catch (Exception e) {
	      
	    	try {
	    		if (db != null) {
	    			db.rollback();
	    		}
	    	} catch (AMLException ee) {
	    		if (output != null) {
	    			try {
	    				output.close();
	    			} catch (Exception e1) {
	    				output = null;
	    			}
	    		}
	    	}
	      
	    	Log.logAML(Log.ERROR, this, "doDeleteD", e.getMessage());

	    	output = new DataObj();
	    	output.put("ERRCODE", "00001");
	    	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	    
	    } finally {
	      
	    	try {
	    		if (db != null) {
	    			db.close();
	    		}
	    	} catch (Exception ee) {
	    		if (output != null) {
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
