/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_10.RBA_50_10_01;


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

/******************************************************************************************************************************************
 * @Description FIU지표보고-업무보고서등록
 * @FileName    RBA_50_10_01_01.java
 * @Group       GTONE
 * @Project     RBA
 * @Java        6.0 이상
 * @Author      KDO
 * @Since       2018. 4. 26.
 ******************************************************************************************************************************************/

public class RBA_50_10_01_01 extends GetResultObject {

    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/
    
    /** 인스턴스 */
    private static RBA_50_10_01_01 instance = null;
    
    /**************************************************************************************************************************************
     * Methods
     **************************************************************************************************************************************/
    
    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_50_10_01_01</code>
     *              인스턴스
     */
	public static  RBA_50_10_01_01 getInstance() {
		synchronized(RBA_50_10_01_01.class) {  
			if (instance == null) {
				instance = new RBA_50_10_01_01();
			}
		}
		return instance;
	}

    /**
     * 업무보고서등록-목록조회<br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(업무보고서등록 조회리스트 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doSearch(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_10_01_01_doSearch", input);
            
            if (dbOut.getCount("BAS_YYMM")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
    
   
    public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = null;
		//DataObj param = null;
		DataSet gdRes = null;
		MDaoUtil mDao = null;

		try {
			output= new DataObj();
			mDao = new MDaoUtil();
			mDao.begin();

			//SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    //String logigId = helper.getLoginId();
			/*
			 * String[] arr = null;
			 * 
			 * String BAS_YYMM = input.get("BAS_YYMM").toString(); String RSK_VALT_ITEM ="";
			 * String RBA_FIN_WEIGHT ="";
			 * 
			 * param = new DataObj(); param.put("BAS_YYMM", BAS_YYMM);
			 * param.put("DR_OP_JKW_NO", logigId); param.put("CHG_OP_JKW_NO", logigId);
			 * 
			 * String dataArr[] = input.get("dataArr").toString().split(",");
			 * 
			 * for(int i=0; i< dataArr.length; i++) { arr = dataArr[i].split("#");
			 * RSK_VALT_ITEM = arr[0].trim(); RBA_FIN_WEIGHT = arr[1].trim();
			 * 
			 * param.put("RSK_VALT_ITEM", RSK_VALT_ITEM); param.put("RBA_FIN_WEIGHT",
			 * RBA_FIN_WEIGHT);
			 * 
			 * mDao.setData("RBA_50_03_03_01_doSave", param);
			 * 
			 * }
			 */
		    
		    //input.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
		    mDao.setData("RBA_50_10_01_01_doSave", input);
		    mDao.commit();

			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} finally {
			if(mDao != null ) {
				mDao.close();
			}
		}
		return output;
	}
    
    public DataObj doSearch_REC_DATA(DataObj input){
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            DataObj dbOut = MDaoUtilSingle.getData("RBA_50_10_01_03_doSearch", input);
            
            if (dbOut.getCount("BAS_YYMM")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
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
    
}
