/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_04;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.JDaoUtil;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;

public class RBA_90_01_04_04 extends GetResultObject {

    private static RBA_90_01_04_04 instance = null;
    
    /**
     * getInstance
     * @return RBA_90_01_04_04
     */
    public static RBA_90_01_04_04 getInstance() {
        if(instance == null) {
            instance = new RBA_90_01_04_04();
        }
        return instance;
    }
        
    public DataObj doSearch ( DataObj input ) {
    	DataObj output = new DataObj();    
        DataObj output_file = new DataObj();    

        JDaoUtil db = null;
        
        try {
            String ATTCH_FILE_NO	= input.getText("ATTCH_FILE_NO");
            String FILE_SER  		= input.getText("FILE_SER");
            
            input.add("ATTCH_FILE_NO",	ATTCH_FILE_NO);
            input.add("FILE_SER", 		FILE_SER);
            
            //Attachments ==========================================================
            output_file = MDaoUtilSingle.getData("RBA_90_01_04_04_ATTACH_FILE", input);
            
            if (output_file.getCount("FILE_SEQ") > 0) {
            	for ( int i = 0 ; i < output_file.getCount("FILE_SEQ") ; i ++ ) {
                    output.put("FILE_SEQ", 			output_file.getText("FILE_SEQ",i), i);
                    output.put("FILE_POS", 			output_file.getText("FILE_POS",i), i);
                    output.put("USER_FILE_NM", 		output_file.getText("USER_FILE_NM",i), i);
                    output.put("PHSC_FILE_NM", 		output_file.getText("PHSC_FILE_NM",i), i);
                    output.put("FILE_SIZE", 		output_file.getText("FILE_SIZE",i), i);
                    output.put("DOWNLOAD_COUNT",	output_file.getText("DOWNLOAD_COUNT",i), i);
                }    
            }

            output.put("ERRCODE"    ,"00000");
            output.put("ERRMSG"        ,"");
        } catch(AMLException e){
            Log.logAML(Log.ERROR,this.getClass(),"doSearch",e.getMessage());
            output = new DataObj();
            
            output.put("ERRCODE"    ,"00001");
            output.put("ERRMSG"        ,e.toString());            
        } finally {
            if (db != null ) {
            	db.close();
            }
        }
        
        return output;
    }    
    
 
	public DataObj doUpdateCount(DataObj input) throws AMLException {
		DataObj output	= new DataObj();
		MDaoUtil mDao 	= new MDaoUtil();
		
		try {
			mDao.setData("RBA_90_01_04_04_UPDATE_DOWNLOAD_CNT", input);
			
			mDao.commit();
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
		} catch (AMLException e) {
			mDao.rollback();
			Log.logAML(Log.ERROR, this, "doUpdateCount(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} finally {
			if (mDao != null) {
				mDao.close();
			}
		}
		
		return output;
	}
    
}
