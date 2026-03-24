/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_08.RBA_50_08_01;

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
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 외부징계내역관리
 * </pre>
 * @author  HHJ
 * @version 1.0
 * @history 1.0 2018-04-20
 */
public class RBA_50_08_01_01  extends GetResultObject {

    private static RBA_50_08_01_01 instance = null;
    
    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_50_08_01_01</code>
     *              인스턴스
     */
    public static RBA_50_08_01_01 getInstance() { return instance==null?(instance=new RBA_50_08_01_01()):instance; }

    /**
     * <pre>
     * 결재선관리 조회
     * </pre>
	* @param input
	* @return
	*/
   
    public DataObj doSearch(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            @SuppressWarnings("unused")
            String stDate, edDate;
            
            stDate = Util.replace(input.getText("stDate"), "-", "");
            edDate = Util.replace(input.getText("edDate"), "-", "");

            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_08_01_01_doSearch", input);
            
            if (dbOut.getCount("SNO")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
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
     * <pre>
     * 결재선관리 삭제
     * </pre>
	* @param input
	* @return
     * @throws AMLException 
	*/
    @SuppressWarnings("rawtypes")
    public DataObj doDelete(DataObj input) throws AMLException
    {
    	DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;
		String rprmDt = new String();
                    
        try {
			mDao = new MDaoUtil();
			mDao.begin();

			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				rprmDt = Util.replace((String)inputMap.get("RPRM_DT"), "-", "");
				inputMap.put("RPRM_DT", rprmDt);
				mDao.setData("RBA_50_08_01_01_doDelete", inputMap);
			}

			//DB commit
			mDao.commit();
   
        	output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
        	
        } catch(AMLException e) {
        	if(mDao != null) {
        		mDao.rollback();
        	}
        	Log.logAML(Log.ERROR,this,"doDelete",e.getMessage());
        	output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
        }finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
        return output;
    }
    
    public DataObj doMultiDelete(DataObj input) throws AMLException
    {
    	
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
				
				mDao.setData("RBA_50_08_01_02_doDelete", inputMap);
			}	
		
			mDao.commit();
  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
        	
        } catch(AMLException e) {
        	if(mDao != null) {
        		mDao.rollback();
        	}
        	Log.logAML(Log.ERROR,this,"doMultiDelete",e.getMessage());
        	output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
        }finally {
        	if(mDao != null) {
        		mDao.close();
        	}
        }
        return output;
    }

}
