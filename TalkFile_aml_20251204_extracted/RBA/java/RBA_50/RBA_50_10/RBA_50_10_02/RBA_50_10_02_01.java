/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_10.RBA_50_10_02;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description 고유위험데이터
 * @FileName    RBA_50_10_02_01.java
 * @Project     RBA
 * @Author     	BSL
 * @Since       2018. 7. 26
 ******************************************************************************************************************************************/

public class RBA_50_10_02_01 extends GetResultObject {

    private static RBA_50_10_02_01 instance = null;
    
	public static  RBA_50_10_02_01 getInstance() {
		synchronized(RBA_50_10_02_01.class) {  
			if (instance == null) {
				instance = new RBA_50_10_02_01();
			}
		}
		return instance;
	}

    /**
     * 회사특성 조회
     */    
    public DataObj doSearch1(DataObj input) {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            output = MDaoUtilSingle.getData( "RBA_50_10_02_01_doSearch1", input);
            
            if (output.getCount("HM_CD")>0) {
                gdRes = Common.setGridData(output);
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
    
    public DataObj doSearch2(DataObj input) {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            output = MDaoUtilSingle.getData( "RBA_50_10_02_01_doSearch2", input);
            
            if (output.getCount("HM_CD")>0) {
                gdRes = Common.setGridData(output);
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
    
    public DataObj doSearch3(DataObj input) {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            output = MDaoUtilSingle.getData( "RBA_50_10_02_01_doSearch3", input);
            
            if (output.getCount("HM_CD")>0) {
                gdRes = Common.setGridData(output);
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
    
    public DataObj doSearch4(DataObj input) {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            output = MDaoUtilSingle.getData( "RBA_50_10_02_01_doSearch4", input);
            
            if (output.getCount("HM_CD")>0) {
                gdRes = Common.setGridData(output);
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
    
    public DataObj doSearch5(DataObj input) {
        DataObj output = new DataObj();
        DataSet gdRes  = null;
        
        try {
            output = MDaoUtilSingle.getData( "RBA_50_10_02_01_doSearch5", input);
            
            if (output.getCount("HM_CD")>0) {
                gdRes = Common.setGridData(output);
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
