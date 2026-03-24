/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_03.RBA_50_03_01;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.Constants;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.FileUtil;

import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 자금세탁 사례관리
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-24
 */
public class RBA_50_03_01_01 extends GetResultObject {

	private static RBA_50_03_01_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_03_01_01
	*/
	public static  RBA_50_03_01_01 getInstance() {
		synchronized(RBA_50_03_01_01.class) {  
			if (instance == null) {
				instance = new RBA_50_03_01_01();
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
			output = MDaoUtilSingle.getData("RBA_50_03_01_01_getSearch", input);
		
			if (output.getCount("SNO") > 0) {
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
	* 첨부파일정보 조회
	* </pre>
	* @param input
	* @return
	*/
    public DataObj getSearchInfo(DataObj input) {
		DataObj output = new DataObj();
		DataObj output_file = new DataObj();

		try {

			output_file = MDaoUtilSingle.getData("RBA_50_03_01_01_getRbaAttchInfo", input);

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

		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this.getClass(), "getSearchInfo", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} 
		//finally {}
		return output;
	}
	
	/**
	* <pre>
	* 자금세탁 사례관리 다중 삭제
	* </pre>
	* @param input
	* @return
	*/
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doDelete(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		List gdReq = null;
		int result = 0;
		

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			gdReq = (List) input.get("gdReq");
			int gdReq_size = gdReq.size();

			for (int i = 0; i < gdReq_size; i++) {
				HashMap inputMap = (HashMap) gdReq.get(i);
				
				HashMap hm = new HashMap();
				hm.put("SNO", inputMap.get("SNO"));
				
				DataObj fdo = MDaoUtilSingle.getData("RBA_50_03_01_01_getFileSearch", hm);			
				List<HashMap> fileList = fdo.getRowsToMap();
				System.out.println("fileList ::::::::"+fileList.toString());	
				StringBuffer strPath = new StringBuffer(256);
				for(int j=0; j < fileList.size(); j++)
				{
					strPath.setLength(0);
					strPath.append(Constants._UPLOAD_RBA_DIR);
					strPath.append(fileList.get(j).get("FILE_POS"));
					strPath.append('/');
					strPath.append(fileList.get(j).get("PHSC_FILE_NM"));
					String filePath = strPath.toString();
					//String filePath = Constants._UPLOAD_NOTICE_DIR+fileList.get(i).get("FILE_POS")+"/"+fileList.get(i).get("PHSC_FILE_NM");
					FileUtil.deleteFile(filePath);
				}	
				mDao.setData("RBA_50_03_01_01_doDelete", inputMap);
				result = MDaoUtilSingle.setData("RBA_50_03_01_01_doFileDelete", fdo);
			}
			
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (IOException io) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete", io.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", io.toString());
		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDelete", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}

}