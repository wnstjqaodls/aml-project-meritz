/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_08.RBA_50_08_02;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description RBA 포상및 징계내역관리
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     AML/RBA/FATCA/CRS/WLF
 * @Java        6.0 이상
 * @Author      KDO
 * @Since       2018. 4. 23.
 ******************************************************************************************************************************************/

public class RBA_50_08_02_02 extends GetResultObject
{
    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/
    
    /** 인스턴스 */
    private static RBA_50_08_02_02 instance = null;
    
    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_50_08_02_02</code>
     */
	public static  RBA_50_08_02_02 getInstance() {
		synchronized(RBA_50_08_02_02.class) {  
			if (instance == null) {
				instance = new RBA_50_08_02_02();
			}
		}
		return instance;
	}   

    /**************************************************************************************************************************************
     * Methods
     **************************************************************************************************************************************/
    // [ do ]

	/**
	 * <pre>
	 * koFiu 제공 코드 MAX일자 조회
	 * </pre>
	 * @param input
	 * @return
	 */
	public DataObj getRptGjdt(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_08_02_02_getRptGjdt", input);
			// grid data
			if (output.getCount("RPT_GJDT") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "getRptGjdt", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
    /**
     * RBA 포상및 징계내역정보 저장<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(RBA 포상및 징계내역정보 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
	
	// 유안타증권 - BSL 수정
    public DataObj doSave(DataObj input)
    {
    	DataObj output = new DataObj();
    	DataObj snoOutput = null;
    	
    	DataObj obj1 = null;
    	int insert_YN=0;
    	
		input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
        input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
                    
        try {
        	
        	obj1 = MDaoUtilSingle.getData( "RBA_50_08_02_02_insert_YN", input);
        	insert_YN = obj1.getInt("COUNT");
        	
        	if(insert_YN == 0){
        		
        		// 순번 생성
        		snoOutput = MDaoUtilSingle.getData( "RBA_50_08_02_02_doGetSNO", input);
        		input.put("SNO",snoOutput.getInt("SNO"));
            	
            	MDaoUtilSingle.setData("RBA_50_08_02_02_doSave", input);
            	output.put("ERRCODE", "00000");
    			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
    			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
        	} else{
        		output.put("WINMSG", "이미 등록된 데이터 입니다.\n임직원평가구분과 직원명을 확인해 주십시오.");
        	}	
        	
        } catch(NumberFormatException e) {
        	Log.logAML(Log.ERROR,this,"doSave",e.getMessage());
        	output = new DataObj();
        	output.put("ERRCODE", "00001");
        	output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
        } catch(AMLException e) {
        	Log.logAML(Log.ERROR,this,"doSave",e.getMessage());
        	output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
        }
        return output;
    }

    /**
     * RBA 포상및 징계내역정보 수정<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(RBA 포상및 징계내역정보 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doUpdate(DataObj input)
    {
        DataObj output = new DataObj();
                    
        input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
        
        //MDaoUtilSingle.setData("RBA_50_08_02_02_doUpdate", input);
        
        input.put("PRIZE_DT", input.get("PRIZE_DT_ORG"));
        doDelete(input);
        
        input.put("PRIZE_DT", input.get("PRIZE_DT_NEW"));
        output = doSave(input);
        
        output.put("ERRCODE", "00000");
        output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
        output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
        
        return output;
    }

    /**
     * RBA 포상및 징계내역정보 삭제<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              PARAM_DATA ( STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doDelete(DataObj input)
    {
    	DataObj output = new DataObj();
                   
        try {
        	MDaoUtilSingle.setData("RBA_50_08_02_02_doDelete", input);  
        	
        	output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));        	
        } catch(AMLException e) {
        	Log.logAML(Log.ERROR,this,"doDelete",e.getMessage());
        	output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
        }
        return output;
    }
    
    // [ get ]
    
    /**
     * RBA 포상및 징계내역정보 조회<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(RBA 포상및 징계내역 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj getPrizeInfo(DataObj input)
    {
    	DataObj output = new DataObj();
    	DataSet gdRes = null;
    	
    	try {
    		output = MDaoUtilSingle.getData("RBA_50_08_02_02_GetPrizeInfo", input);

			if (output.getCount("SNO") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
    	} catch(AMLException e) {
    		Log.logAML(Log.ERROR, this, "getPrizeInfo", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    	}
    	
    	return output;
    }
    
}
