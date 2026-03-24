/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_08.RBA_50_08_04;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;

import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description 교육계획및 현황관리
 * @FileName    RBA_50_08_04_01.java
 * @Group       GTONE
 * @Project     RBA
 * @Java        6.0 이상
 * @Author      KDO
 * @Since       2018. 5. 8.
 ******************************************************************************************************************************************/

public class RBA_50_08_04_01 extends GetResultObject{

    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/
    
    /** 인스턴스 */
    private static RBA_50_08_04_01 instance = null;
    
    /**************************************************************************************************************************************
     * Methods
     **************************************************************************************************************************************/
    
    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_50_08_04_01</code>
     *              인스턴스
     */
	public static  RBA_50_08_04_01 getInstance() {
		synchronized(RBA_50_08_04_01.class) {  
			if (instance == null) {
				instance = new RBA_50_08_04_01();
			}
		}
		return instance;
	}  

    /**
     * 교육계획및 현황 관리<br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(교육계획및 현황내역 조회리스트 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doSearch(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_08_04_01_doSearch", input);
            
            if (dbOut.getCount("SEQ")>0) {
                gdRes = Common.setGridData(dbOut);
            }
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearch", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }

    
    /**
     * 교육계획및 현황<br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(교육계획및 현황내역 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj getEduInfo(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_08_04_01_GetEduInfo", input);
            
            if (dbOut.getCount("SNO")>0) {
                gdRes = Common.setGridData(dbOut);
            }
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "getEduInfo", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }
    
	/**
	* <pre>
	* 첨부파일정보 조회
	* </pre>
	* @param input
	* @return
	*/
    public DataObj getSearchFileInfo(DataObj input) {
    	DataObj output = new DataObj();
    	DataObj output_file = new DataObj();
		
		try {

			output_file = MDaoUtilSingle.getData("RBA_50_08_04_01_getSearchFileInfo", input);

			if (output_file.getCount("FILE_SER") > 0) {

				for (int i = 0; i < output_file.getCount("FILE_SER"); i++) {
					output.put("ATTCH_FILE_NO", output_file.getText("ATTCH_FILE_NO", i), i);
					output.put("FILE_SER", output_file.getText("FILE_SER", i), i);
					output.put("FILE_POS", output_file.getText("FILE_POS", i), i);
					output.put("LOSC_FILE_NM", output_file.getText("LOSC_FILE_NM", i), i);
					output.put("PHSC_FILE_NM", output_file.getText("PHSC_FILE_NM", i), i);
					output.put("FILE_SIZE", output_file.getText("FILE_SIZE", i), i);
					output.put("DOWNLOAD_CNT", output_file.getText("DOWNLOAD_CNT", i), i);
				}
			}

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", "");

		} catch (RuntimeException re) {
			Log.logAML(Log.ERROR, this.getClass(), "getSearchFileInfo", re.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", re.toString());
		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this.getClass(), "getSearchFileInfo", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
    
}
