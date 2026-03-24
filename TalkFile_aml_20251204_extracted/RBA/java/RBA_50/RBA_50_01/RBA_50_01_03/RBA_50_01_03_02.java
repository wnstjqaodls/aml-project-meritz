/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_01.RBA_50_01_03;

import org.omg.CORBA.UserException;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.user.SessionAML;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 사용자 관리
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-04-27
 */
public class RBA_50_01_03_02 extends GetResultObject {

	private static RBA_50_01_03_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_01_03_02
	*/
	public static  RBA_50_01_03_02 getInstance() {
		synchronized(RBA_50_01_03_02.class) {  
			if (instance == null) {
				instance = new RBA_50_01_03_02();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 사용자 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_01_03_02_getSearch", input);
		
			if (output.getCount("USER_ID") > 0) {
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
	* 사용자 권한 변경
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSaveAuth(DataObj input) throws UserException {
	    DataObj output = null;
	    MDaoUtil mDao = null;
	    try {
	      String authVal = input.getText("authVal");
	      if(!"".equals(authVal)) {
	          String[] authVal_TEMP = authVal.split(",");
	          System.out.println("authVal_TEMP  0 ==="+authVal_TEMP[0]);
	          System.out.println("authVal_TEMP  1 ==="+authVal_TEMP[1]);
	          System.out.println("authVal_TEMP  2 ==="+authVal_TEMP[2]);
	          System.out.println("authVal_TEMP  3 ==="+authVal_TEMP[3]);
	          
		      SessionAML sess = (SessionAML) input.get("SessionAML");
		      SessionHelper sessHelper = sess.getSessionHelper();
		      mDao = new MDaoUtil();
		      mDao.begin();
		      mDao.setData("RBA_50_01_03_02_doDeleteAuth", input);
		      
	          for (int i = 0; i < authVal_TEMP.length; i++) {
	        	  
	        	  if(!"0".equals(authVal_TEMP[i])) {
	        		  
	    	    	  input.put("ROLE_ID", authVal_TEMP[i]);
			    	  input.put("DR_OP_JKW_NO", Util.nvl(sessHelper.getUserId()));
			          mDao.setData("RBA_50_01_03_02_doSaveAuth", input);
	        	  }
	        	  
	          }
		      mDao.commit();
	      }
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

	    } catch (AMLException ex) {
	      if (mDao != null) {
	        try {
	          mDao.rollback();
	          mDao.close();
	        } catch (AMLException ee) {
	          mDao = null;
	        }
	      }

	      Log.logAML(Log.ERROR, this, "doDeleteG", ex.getMessage());

	      output = new DataObj();
	      output.put("ERRCODE", "00001");
	      output.put("ERRMSG", ex.toString());
	    } finally {
	      try {
	        if (mDao != null) {
	          mDao.close();
	        }
	      } catch (Exception ee) {
	      }
	    }
	    return output;
	  }

}