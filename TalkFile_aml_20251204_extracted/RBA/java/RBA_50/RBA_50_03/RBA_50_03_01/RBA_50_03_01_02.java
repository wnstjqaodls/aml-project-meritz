/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_03.RBA_50_03_01;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.Constants;
import com.gtone.express.domain.FileVO;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.DateUtil;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import com.gtone.express.common.ParamUtil;
import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * 자금세탁 사례관리
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-24
 */
@Controller
public class RBA_50_03_01_02 extends GetResultObject {

	private static RBA_50_03_01_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_03_01_02
	*/
	public static  RBA_50_03_01_02 getInstance() {
		synchronized(RBA_50_03_01_02.class) {
			if (instance == null) {
				instance = new RBA_50_03_01_02();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 자금세탁 사례관리 저장
	* </pre>
	* @param input
	* @return
	*/
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
//	      String VALT_G="";


	      DataObj param = new DataObj();

	      String IN_DT = (req.getParameter("IN_DT") == null || "".equals(req.getParameter("IN_DT"))) ? date : req.getParameter("IN_DT")   ; //입력일자
	      int SNO =("0".equals(req.getParameter("GUBN")) ?Integer.parseInt(mDao.getData("RBA_50_03_01_01_getMaxSno", output).get("SNO").toString()): Integer.parseInt(req.getParameter("SNO"))) ; //순번
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
	        output = mDao.getData("RBA_50_03_01_01_getRbaAttchFileNo", param);
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

	          mDao.setData("RBA_50_03_01_01_insertFile", obj1);

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

	          mDao.setData("RBA_50_03_01_01_insertFile", obj1);
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

	          mDao.setData("RBA_50_03_01_01_insertFile", obj1);
	          count_file++;
	        } else {
	          Log.logAML(Log.DEBUG, this, "#### 넌뭔데");
	        }

	      }

	      if("0".equals(req.getParameter("GUBN"))) {
	    	  //등록
	    	  output = mDao.getData("RBA_50_03_01_01_INSERT_ML_EXP_I", param);
	      } else {
	    	  //수정
	    	  output = mDao.getData("RBA_50_03_01_01_UPDATE_ML_EXP_I", param);
	      }


	      output.put("flag", req.getParameter("flag"));
	      output.put("afterFunction", req.getParameter("afterFunction"));
	      output.put("WINMSG",MessageHelper.getInstance().getMessage("0002",req.getParameter("LANG_CD"), "정상처리되었습니다."));
	      output.put("afterClose", req.getParameter("afterClose"));
	      output.put("PARAM_DATA", req);
	      output.put("ERRCODE", "00000");
	      mDao.commit();
	    } catch (IOException ioe) {
	    	Log.logAML(Log.ERROR, this, "updateInfo", ioe.getMessage());
	    	//ex.printStackTrace();
	    	if (mDao != null) {
	    		try {
	    			mDao.rollback();
	    			mDao.close();
	    		} catch (Exception ee) {
	    			mDao = null;
	    		}
	    	}
	    	output = new DataObj();
	    	output.put("flag", req.getParameter("flag"));
	    	output.put("ERRCODE", "00001");
	    	output.put("ERRMSG",
	    			getClass().getName() + ".updateInfo \n\r" + ioe.toString());
	    } catch (NumberFormatException ex) {
	    	Log.logAML(Log.ERROR, this, "updateInfo", ex.getMessage());
	    	//ex.printStackTrace();
	    	if (mDao != null) {
	    		try {
	    			mDao.rollback();
	    			mDao.close();
	    		} catch (Exception ee) {
	    			mDao = null;
	    		}
	    	}
	    	output = new DataObj();
	    	output.put("flag", req.getParameter("flag"));
	    	output.put("ERRCODE", "00001");
	    	output.put("ERRMSG",
	    			getClass().getName() + ".updateInfo \n\r" + ex.toString());
	    } catch (Exception ex) {
	      Log.logAML(Log.ERROR, this, "updateInfo", ex.getMessage());
	      //ex.printStackTrace();
	      if (mDao != null) {
	          try {
	            mDao.rollback();
	            mDao.close();
	          } catch (Exception ee) {
	            mDao = null;
	          }
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
	public DataObj doSearch2(DataObj input) {

		DataObj output_file = null;
		DataSet gdRes = null;

		try {
		output_file = MDaoUtilSingle.getData("RBA_50_03_01_01_getFileSearch",(HashMap) input);

        if (output_file.getCount("FILE_SER") > 0) {
          gdRes = Common.setGridData(output_file);
        } else {
        	output_file.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));
        }
        output_file.put("ERRCODE", "00000");
        output_file.put("gdRes", gdRes);

	} catch (AMLException e) {

		Log.logAML(Log.ERROR, this.getClass(), "doSearch2(Exception)", e.getMessage());
		output_file = new DataObj();

		output_file.put("ERRCODE", "00001");
		output_file.put("ERRMSG", e.toString());
	} catch (Exception e) {

		Log.logAML(Log.ERROR, this.getClass(), "doSearch2(Exception)", e.getMessage());
		output_file = new DataObj();

		output_file.put("ERRCODE", "00001");
		output_file.put("ERRMSG", e.toString());
	}
	return output_file;
}
	@RequestMapping(value="/rba/AMLdoSave.do", method=RequestMethod.POST)
	public String doSave(HttpServletRequest request, ModelMap model ,FileVO paramVO )	  {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
			try
			{
				String date = DateUtil.getCurrentTime("yyyyMMdd");
//				String time = DateUtil.getCurrentTime("HHmmss");
				SessionHelper helper = new SessionHelper(request.getSession());
				String logigId = helper.getLoginId();
				String DR_OP_JKW_NO = logigId; //등록조작자번호
				String CHG_OP_JKW_NO = logigId; //변경조작자번호

				mDao = new MDaoUtil();
				mDao.begin();
				String IN_DT = (request.getParameter("IN_DT") == null || "".equals(request.getParameter("IN_DT"))) ? date : request.getParameter("IN_DT")   ; //입력일자
				int GUBN_SNO =("0".equals(request.getParameter("GUBN")) ?Integer.parseInt(mDao.getData("RBA_50_03_01_01_getMaxSno", output).get("SNO").toString()): Integer.parseInt(request.getParameter("SNO"))) ; //순번
				HashMap hm = ParamUtil.getReqParamHashMap(request);
				hm.put("IN_DT", IN_DT);
				hm.put("SNO", GUBN_SNO);
				hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
				hm.put("CHG_OP_JKW_NO", CHG_OP_JKW_NO);
//				String DR_DT = date; //등록일자
				System.out.println("hm ::::::::"+hm.toString());

//				DataObj SNO = mDao.getData("RBA_50_03_01_01_getMaxSno", hm);
//				DataSet ds = Common.setGridData(SNO);
//				hm.put("SNO", ds.getString(0, "SNO"));


				@SuppressWarnings("unused")
				int result = 0;


				//기존 파일목록
				DataObj fdo = MDaoUtilSingle.getData("RBA_50_03_01_01_getFileSearch",hm);
				List<HashMap> fileList = fdo.getRowsToMap();

		        // 파일 이동 및 처리
				if((null == paramVO.getFilePaths()) == false)
				{
					for(int i = 0; i < paramVO.getFilePaths().length; i++)
					{
						if(paramVO.getFilePaths()[i].indexOf(Constants.COMMON_TEMP_FILE_UPLOAD_DIR) > -1)
						{
							File	tempDir		= new File(paramVO.getFilePaths()[i]);
							File	tempFile	= new File(tempDir, paramVO.getStoredFileNms()[i]);

							if(tempFile.isFile())
							{
								File	realFile	= FileUtil.renameTo(tempFile, Constants._UPLOAD_RBA_DIR);

								String[]	filePath	= paramVO.getFilePaths();
								filePath[i]				= StringUtils.replace(realFile.getParent(),Constants._UPLOAD_RBA_DIR,"");

								paramVO.setFilePath(filePath[i]);
								paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
							}
							else
							{
								String[]	filePath	= paramVO.getFilePaths();
								filePath[i]				= StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_RBA_DIR);

								paramVO.setFilePath(filePath[0]);
							}
						}
						else {
							String[]	filePath	= paramVO.getFilePaths();
							filePath[i]				= StringUtils.replace(filePath[i], Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_RBA_DIR);

							paramVO.setFilePath(filePath[0]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						}
					}

					//기존파일 목록 비교 후 삭제처리
					for(int i=0; i < fileList.size(); i++)
					{
						boolean btn = false;

						for(int k = 0; k < paramVO.getFilePaths().length; k++)
						{
							String r = paramVO.getStoredFileNms()[k];

							if(r.equals(fileList.get(i).get("PHSC_FILE_NM")))
							{
								//btn = true;
								btn = false;
								break;
							}
							else
							{
								//btn = false;
								//break;
								btn = true;
							}
						}

						//넘어온 값과 기존파일목에 존재하지 않으면 삭제
						if(btn)
						{
							String filePath = Constants._UPLOAD_RBA_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
							FileUtil.deleteFile(filePath);
						}
					}


					//db 파일 삭제
					mDao.setData("RBA_30_04_03_1N_deleteFile", hm);


  				  //  String RPT_GJDT = Util.replace(Util.nvl(hm.get("RPT_GJDT")), "-", "");
			      //  String FIU_RPT_GJDT = Util.replace(Util.nvl(hm.get("FIU_RPT_GJDT")), "-", "");
			        String DR_OP_JKW_NO2 = Util.nvl(helper.getLoginId());
			        String ATTCH_FILE_NO = Util.nvl(hm.get("ATTCH_FILE_NO"));
			      //  String BAS_YYMM = Util.replace(Util.nvl(hm.get("BAS_YYMM")), "-", "");

			        if("".equals(ATTCH_FILE_NO))
			        {
			        	 output = mDao.getData("comm.RBA_10_02_01_01_getRbaAttchFileSeq", hm);
				         ATTCH_FILE_NO = output.getText("SEQ");
			        }

		            Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO!!! :" + ATTCH_FILE_NO);


					//파일일괄 인서트
					for(int i = 0; i < paramVO.getFilePaths().length; i++)
					{
						DataObj obj1 = new DataObj();
						obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
			            obj1.put("FILE_SER", i+1);
			            obj1.put("DATA_G", "G");
			            obj1.put("FILE_POS", paramVO.getFilePath());
			            obj1.put("LOSC_FILE_NM", paramVO.getOrigFileNms()[i]);
			            obj1.put("PHSC_FILE_NM", paramVO.getStoredFileNms()[i]);
			            obj1.put("FILE_SIZE", paramVO.getFileSizes()[i]);
			            obj1.put("DOWNLOAD_CNT", 0);
			            obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO2);

			            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);

					}
					hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
					hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO2);
					mDao.setData("RBA_50_03_01_01_UPDATE_SRBA_ML_EXP_I", hm);
				}
				else
				{
					for(int i=0; i < fileList.size(); i++)
					{
						//기존 파일 삭제
						String filePath = Constants._UPLOAD_RBA_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath);
					}

					//db 파일 삭제
					mDao.setData("RBA_30_04_03_1N_deleteFile", hm);
					mDao.commit();
				}
				if(hm.get("ATTCH_FILE_NO") == null) {
					hm.put("ATTCH_FILE_NO", 0);
				}
				if("0".equals(request.getParameter("GUBN"))) {
					//등록
					mDao.setData("RBA_50_03_01_01_INSERT_ML_EXP_I", hm);
				} else {
					//수정
					mDao.setData("RBA_50_03_01_01_UPDATE_ML_EXP_I", hm);
				}
				mDao.commit();
				model.addAttribute("status", "success");
			    model.addAttribute("serviceMessage", "정상 처리되었습니다.");
			} catch(IndexOutOfBoundsException e) {
				try {
					if (mDao != null) {
						mDao.rollback();
					}
				} catch (AMLException e1) {
					Log.logAML(Log.ERROR,this,"doSave",e.toString());
					model.addAttribute("status", "fail");
					model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				}
				Log.logAML(Log.ERROR,this,"doSave",e.toString());
				model.addAttribute("status", "fail");
				model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			} catch(IOException e) {
				try {
					if (mDao != null) {
						mDao.rollback();
					}
				} catch (AMLException e1) {
					Log.logAML(Log.ERROR,this,"doSave",e.toString());
					model.addAttribute("status", "fail");
					model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				}
				Log.logAML(Log.ERROR,this,"doSave",e.toString());
				model.addAttribute("status", "fail");
				model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			} catch(AMLException e) {

				try {
					if (mDao != null) {
						mDao.rollback();
					}
				} catch (AMLException e1) {
					Log.logAML(Log.ERROR,this,"doSave",e.toString());
					model.addAttribute("status", "fail");
					model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				}
				Log.logAML(Log.ERROR,this,"doSave",e.toString());
				model.addAttribute("status", "fail");
				model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			} catch(Exception e) {

				try {
					if (mDao != null) {
						mDao.rollback();
					}
				} catch (AMLException e1) {
					Log.logAML(Log.ERROR,this,"doSave",e.toString());
					model.addAttribute("status", "fail");
				    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
				}
				Log.logAML(Log.ERROR,this,"doSave",e.toString());
				model.addAttribute("status", "fail");
			    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			} finally {
				if (mDao != null) {
					mDao.close();
				}
			}

			return "jsonView";
	  }

	/**
	* <pre>
	* 자금세탁 사례관리 삭제
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doDeleteOne(DataObj input) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;

		@SuppressWarnings("unused")
		int result = 0;

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			mDao.setData("RBA_50_03_01_01_doDelete", input);
			//파일삭제
			HashMap hm = new HashMap();
			hm.put("SNO", input.get("SNO"));

			DataObj fdo = MDaoUtilSingle.getData("RBA_50_03_01_01_getFileSearch", hm);
			List<HashMap> fileList = fdo.getRowsToMap();
			System.out.println("fileList ::::::::"+fileList.toString());
			StringBuffer strPath = new StringBuffer(256);
			for(int i=0; i < fileList.size(); i++)
			{
				strPath.setLength(0);
				strPath.append(Constants._UPLOAD_RBA_DIR);
				strPath.append(fileList.get(i).get("FILE_POS"));
				strPath.append('/');
				strPath.append(fileList.get(i).get("PHSC_FILE_NM"));
				String filePath = strPath.toString();
				//String filePath = Constants._UPLOAD_NOTICE_DIR+fileList.get(i).get("FILE_POS")+"/"+fileList.get(i).get("PHSC_FILE_NM");
				FileUtil.deleteFile(filePath);
			}

			result = MDaoUtilSingle.setData("RBA_50_03_01_01_doFileDelete", fdo);



			mDao.commit();


			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (IOException io) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doDeleteOne", io.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", io.toString());
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