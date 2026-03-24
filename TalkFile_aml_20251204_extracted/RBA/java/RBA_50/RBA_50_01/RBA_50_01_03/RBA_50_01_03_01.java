/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_01.RBA_50_01_03;

import java.io.IOException;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.DateUtil;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 사용자 관리
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-04-27
 */
public class RBA_50_01_03_01 extends GetResultObject {

	private static RBA_50_01_03_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_01_03_01
	*/
	public static  RBA_50_01_03_01 getInstance() {
		synchronized(RBA_50_01_03_01.class) {  
			if (instance == null) {
				instance = new RBA_50_01_03_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 사용자 관리 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_01_03_01_getSearch", input);
		
			if (output.getCount("BRNO") > 0) {
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

	
	@SuppressWarnings("unused")
	public DataObj updateInfo(MultipartRequest req) throws AMLException {
	    DataObj output = new DataObj();
	    MDaoUtil mDao = null;

	    try {
	    	
	      mDao = new MDaoUtil();
	      mDao.begin();

	      SessionHelper helper = new SessionHelper(req.getSession());
	      String logigId = helper.getLoginId();

	      String date = DateUtil.getCurrentTime("yyyyMMdd");
		  String time = DateUtil.getCurrentTime("HHmmss");
	     // String VALT_G="";
	      
	      
	      DataObj param = new DataObj();
	      
	      String IN_DT = (req.getParameter("IN_DT") == null || "".equals(req.getParameter("IN_DT"))) ? date : req.getParameter("IN_DT")   ; //입력일자
	      int SNO =("0".equals(req.getParameter("GUBN")) ?Integer.parseInt(mDao.getData("RBA_50_01_03_01_getMaxSno", output).get("SNO").toString()): Integer.parseInt(req.getParameter("SNO"))) ; //순번
	      String NEWS_TITE = Util.nvl(req.getParameter("NEWS_TITE")); //기사제목
	      String NEWS_DT = Util.nvl(req.getParameter("NEWS_DT"));     //기사일자
	      String SRC_INFO_C = Util.nvl(req.getParameter("SRC_INFO_C"));     //출처정보코드
	      String URL = Util.nvl(req.getParameter("URL"));     //URL
	      String NEWS_CTNT = Util.nvl(req.getParameter("NEWS_CTNT"));     //기사내용
	      String INDV_CORP_NM = Util.nvl(req.getParameter("INDV_CORP_NM"));     //개인법인명
	      String DR_RSN = Util.nvl(req.getParameter("DR_RSN"));     //등록사유
	      String CUST_G_C = Util.nvl(req.getParameter("CUST_G_C"));     //고객구분코드
	      String REL_P_CNT = Util.nvl(req.getParameter("REL_P_CNT"));     //관련자수
	      String STR_RPT_DT = Util.nvl(req.getParameter("STR_RPT_DT"));     //STR보고일자
	      String STR_RPT_NO = Util.nvl(req.getParameter("STR_RPT_NO"));     //STR보고번호
	      String ATTCH_FILE_NO = Util.nvl(req.getParameter("ATTCH_FILE_NO"));     //첨부파일번호
	      String DR_DT = date; //등록일자
	      String DR_TIME = time; //등록시간
	      String DR_OP_JKW_NO = logigId; //등록조작자번호
	      String CHG_DT = date; //변경일자
	      String CHG_TIME = time; //변경시간
	      String CHG_OP_JKW_NO = logigId; //변경조작자번호

	      //GUBN 0 이명 insert
	      if ("0".equals(req.getParameter("GUBN"))) {
	        output = mDao.getData("RBA_50_01_03_01_getRbaAttchFileNo", param);
	        ATTCH_FILE_NO = output.getText("SEQ");
	        Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO!!! [" + ATTCH_FILE_NO+ "]");
	      }
	      
	      param.put("IN_DT", IN_DT);
	      param.put("SNO", SNO);
	      param.put("NEWS_TITE", NEWS_TITE);
	      param.put("NEWS_DT", NEWS_DT);
	      param.put("SRC_INFO_C", SRC_INFO_C);
	      param.put("URL", URL);
	      param.put("NEWS_CTNT", NEWS_CTNT);
	      param.put("INDV_CORP_NM", INDV_CORP_NM);
	      param.put("DR_RSN", DR_RSN);
	      param.put("CUST_G_C", CUST_G_C);
	      param.put("REL_P_CNT", REL_P_CNT);
	      param.put("STR_RPT_DT", STR_RPT_DT);
	      param.put("STR_RPT_NO", STR_RPT_NO);
	      param.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	      param.put("DR_DT", DR_DT);
	      param.put("DR_TIME", DR_TIME);
	      param.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
	      param.put("CHG_DT", CHG_DT);
	      param.put("CHG_TIME", CHG_TIME);
	      param.put("CHG_OP_JKW_NO", CHG_OP_JKW_NO);
	      
	      
	      DataObj obj1 = new DataObj();

	      // delete
	      mDao.setData("RBA_10_02_01_01_deleteFile", param);
	      //서버 물리적 파일경로 
		  String filePath = PropertyService.getInstance().getProperty("aml.config","uploadPath.rba");
		  String fileFullPath = "";
	      // file path
	      fileFullPath = filePath + "/" + "EXP" + "/" + SNO + "/";
	      fileFullPath = fileFullPath.replace("/",System.getProperty("file.separator"));

	      String[] FILE_SER = req.getParameterValues("FILE_SER");
	      String[] FILE_POS_temp = req.getParameterValues("FILE_POS_temp");
	      String[] LOSC_FILE_NM_temp = req.getParameterValues("LOSC_FILE_NM_temp");
	      String[] PHSC_FILE_NM_temp = req.getParameterValues("PHSC_FILE_NM_temp");
	      String[] FILE_SIZE_temp = req.getParameterValues("FILE_SIZE_temp");
	      String[] DOWNLOAD_CNT_temp = req.getParameterValues("DOWNLOAD_CNT_temp");
	      String[] NOTI_ATTACH = req.getParameterValues("NOTI_ATTACH");

	      Log.logAML(Log.DEBUG, this, "#### FILE_SER [" + FILE_SER + "]");
	      Log.logAML(Log.DEBUG, this, "#### FILE_POS_temp [" + FILE_POS_temp + "]");
	      Log.logAML(Log.DEBUG, this, "#### LOSC_FILE_NM_temp ["+ LOSC_FILE_NM_temp + "]");
	      Log.logAML(Log.DEBUG, this, "#### PHSC_FILE_NM_temp ["+ PHSC_FILE_NM_temp + "]");
	      Log.logAML(Log.DEBUG, this, "#### FILE_SIZE_temp [" + FILE_SIZE_temp+ "]");
	      Log.logAML(Log.DEBUG, this, "#### DOWNLOAD_CNT_temp ["+ DOWNLOAD_CNT_temp + "]");
	      Log.logAML(Log.DEBUG, this, "#### NOTI_ATTACH [" + NOTI_ATTACH + "]");

	      AttachFileDataSource[] attachFileDSs = req.getAttachFiles("NOTI_ATTACH");

	      int count_file = 0;
	      int count_file_real = 0;

	      Log.logAML(Log.DEBUG, this, "#### FILE_SER.length [" + FILE_SER.length+ "]");

	      for (int i = 0; i < FILE_SER.length; i++) {
	    	  Log.logAML(Log.DEBUG, this, "#### for~~~~~~~~~~~~[ " + i + " ]");
	    	  Log.logAML(Log.DEBUG, this, "#### FILE_SER[i] [" + FILE_SER[i] + "]");
	    	  Log.logAML(Log.DEBUG, this, "#### NOTI_ATTACH[i] [" + NOTI_ATTACH[i]+ "]");

	    	  if (!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	    		  count_file++;
	    	  } else if (FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	    		  count_file++;
	    	  }
	      }

	      Log.logAML(Log.DEBUG, this, "#### count_file [" + count_file + "]");

	      if (req.getAttachFiles("NOTI_ATTACH") != null) {
	        Log.logAML(Log.DEBUG, this, "#### count_file_real_if ["+ count_file_real + "]");
	        count_file_real = attachFileDSs.length;
	      }
	      Log.logAML(Log.DEBUG, this, "#### count_file_real [" + count_file_real+ "]");


	      if (count_file_real != count_file) {
	    	  mDao.rollback();
	    	  output.put("ERRCODE", "00999");
	    	  output.put("ERRMSG",MessageHelper.getInstance().getMessage("0053",helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
	    	  output.put("WINMSG",MessageHelper.getInstance().getMessage("0053",helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
	    	  return output;
	      }

	      // ==================================================================

	      count_file = 0;
	      int FILE_SEQ_max = 0;
	      long fileLen = 0;

	      FILE_SEQ_max = 0;// output.getInt("FILE_SER");

	      for (int i = 0; i < FILE_SER.length; i++) {

	        if (!FILE_SER[i].equals("0") && NOTI_ATTACH[i].equals("")) {
	          Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 있고 첨부파일이 없을때(기존파일 고정)");
	          // 첨부정보 저장처리
	          FILE_SEQ_max++;

	          obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	          obj1.put("FILE_SER", FILE_SEQ_max);
	          obj1.put("DATA_G", "G");
	          obj1.put("FILE_POS", FILE_POS_temp[i]);
	          obj1.put("LOSC_FILE_NM", LOSC_FILE_NM_temp[i]);
	          obj1.put("PHSC_FILE_NM", PHSC_FILE_NM_temp[i]);
	          obj1.put("FILE_SIZE", FILE_SIZE_temp[i]);
	          obj1.put("DOWNLOAD_CNT", DOWNLOAD_CNT_temp[i]);
	          obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);

	          mDao.setData("RBA_50_01_03_01_insertFile", obj1);

	        } else if (!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	          FILE_SEQ_max++;
	          Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 있고 첨부파일이 있을때(기존파일을 변경");

	          // if(attachFileDSs[i]) {

	          obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	          obj1.put("FILE_SER", FILE_SEQ_max);
	          obj1.put("DATA_G", "G");
	          obj1.put("FILE_POS", FILE_POS_temp[i]);
	          obj1.put("LOSC_FILE_NM", attachFileDSs[count_file].getName());
	          obj1.put("PHSC_FILE_NM", PHSC_FILE_NM_temp[i]);
	          obj1.put("FILE_SIZE", FILE_SIZE_temp[i]);
	          obj1.put("DOWNLOAD_CNT", DOWNLOAD_CNT_temp[i]);
	          obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);

	          mDao.setData("RBA_50_01_03_01_insertFile", obj1);
	          req.upload(attachFileDSs[count_file], fileFullPath,
	              PHSC_FILE_NM_temp[i]);
	          count_file++;
	        } else if (FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
	          Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 없고 첨부파일이 있을때(신규파일 추가)");
	          FILE_SEQ_max++;

	          String PHSC_FILE_NM = ATTCH_FILE_NO + "_" + (FILE_SEQ_max);
	          req.upload(attachFileDSs[count_file], fileFullPath, PHSC_FILE_NM);
	          fileLen = attachFileDSs[count_file].getSize();
	          if (fileLen > 1) {
	            fileLen = fileLen - 2; // getSize시 원래사이즈보다 2가 큼
	          }

	          obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	          obj1.put("FILE_SER", FILE_SEQ_max);
	          obj1.put("DATA_G", "G");
	          obj1.put("FILE_POS", fileFullPath);
	          obj1.put("LOSC_FILE_NM", attachFileDSs[count_file].getName());
	          obj1.put("PHSC_FILE_NM", PHSC_FILE_NM);
	          obj1.put("FILE_SIZE", fileLen);
	          obj1.put("DOWNLOAD_CNT", 0);
	          obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);

	          mDao.setData("RBA_50_01_03_01_insertFile", obj1);
	          count_file++;
	        } else {
	          Log.logAML(Log.DEBUG, this, "#### 넌뭔데");
	        }

	      }
	     
	      if("0".equals(req.getParameter("GUBN"))) {
	    	  //등록
	    	  output = mDao.getData("RBA_50_01_03_01_INSERT_ML_EXP_I", param);  
	      } else {
	    	  //수정
	    	  output = mDao.getData("RBA_50_01_03_01_UPDATE_ML_EXP_I", param);
	      }
	      
	      
	      output.put("flag", req.getParameter("flag"));
	      output.put("afterFunction", req.getParameter("afterFunction"));
	      output.put("WINMSG",MessageHelper.getInstance().getMessage("0002",req.getParameter("LANG_CD"), "정상처리되었습니다."));
	      output.put("afterClose", req.getParameter("afterClose"));
	      output.put("PARAM_DATA", req);
	      output.put("ERRCODE", "00000");
	      mDao.commit();
	    } catch (NumberFormatException ex) {
	    	Log.logAML(Log.ERROR, this, "updateInfo", ex.getMessage());
	    	//ex.printStackTrace();
	    	if (mDao != null) {
	    		mDao.rollback();
	    		mDao.close();
	    	}
	    	output = new DataObj();
	    	output.put("flag", req.getParameter("flag"));
	    	output.put("ERRCODE", "00001");
	    	output.put("ERRMSG",
	    			getClass().getName() + ".updateInfo \n\r" + ex.toString());
	    } catch (IOException ex) {
	      Log.logAML(Log.ERROR, this, "updateInfo", ex.getMessage());
	      //ex.printStackTrace();
	      if (mDao != null) {
	    	  mDao.rollback();
	    	  mDao.close();
	        }
	      output = new DataObj();
	      output.put("flag", req.getParameter("flag"));
	      output.put("ERRCODE", "00001");
	      output.put("ERRMSG",
	          getClass().getName() + ".updateInfo \n\r" + ex.toString());
	    } catch (AMLException ex) {
	    	Log.logAML(Log.ERROR, this, "updateInfo", ex.getMessage());
	    	//ex.printStackTrace();
	    	if (mDao != null) {
	    		mDao.rollback();
	    		mDao.close();
	    	}
	    	output = new DataObj();
	    	output.put("flag", req.getParameter("flag"));
	    	output.put("ERRCODE", "00001");
	    	output.put("ERRMSG",
	    			getClass().getName() + ".updateInfo \n\r" + ex.toString());
	    } finally {
	      if (mDao != null) {
	        mDao.close();
	      }
	    }
	    return output;
	  }
	
	

	

	
	/**
	* <pre>
	* 자금세탁 사례관리 삭제
	* </pre>
	* @param input
	* @return
	*/
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doDeleteOne(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			mDao.setData("RBA_50_01_03_01_doDelete", input);
			
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDeleteOne", ex.getMessage());
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