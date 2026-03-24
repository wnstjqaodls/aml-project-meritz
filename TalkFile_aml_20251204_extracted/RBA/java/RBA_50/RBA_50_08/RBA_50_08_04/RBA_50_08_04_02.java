/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_08.RBA_50_08_04;

import java.io.IOException;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.Util;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.DateUtil;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;

/******************************************************************************************************************************************
 * @Description 교육계획및 현황 관리
 * @FileName    RBA_50_08_04_02.java
 * @Group       GTONE
 * @Project     RBA
 * @Java        6.0 이상
 * @Author      KDO
 * @Since       2018. 5. 9.
 ******************************************************************************************************************************************/

public class RBA_50_08_04_02 extends GetResultObject {

    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/
    
    /** 인스턴스 */
    private static RBA_50_08_04_02 instance = null;
    
    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_50_08_04_02</code>
     */
	public static  RBA_50_08_04_02 getInstance() {
		synchronized(RBA_50_08_04_02.class) {  
			if (instance == null) {
				instance = new RBA_50_08_04_02();
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
	* 교육계획및 현황
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings("unused")
	public DataObj updateInfo(MultipartRequest req) {
	    DataObj output = new DataObj();
	    DataObj snoOutput = new DataObj();
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
	      
	      String EDU_DT = (req.getParameter("EDU_DT") == null || "".equals(req.getParameter("EDU_DT"))) ? date : req.getParameter("EDU_DT")   ; //입력일자
	      snoOutput.put("EDU_DT", EDU_DT);
	      int SNO =("0".equals(req.getParameter("GUBN")) ?Integer.parseInt(mDao.getData("RBA_50_08_04_02_doGetSNO", snoOutput).get("SNO").toString()): Integer.parseInt(req.getParameter("SNO"))) ; //순번
	      String EDU_SUBJ_NM = Util.nvl(req.getParameter("EDU_SUBJ_NM")); //교육과목명
	      String EDU_TGT_G_C = Util.nvl(req.getParameter("EDU_TGT_G_C"));     //교육대상
	      String EDU_CHNL_G_C = Util.nvl(req.getParameter("EDU_CHNL_G_C"));     //교육채널
	      String EDU_SDT = Util.nvl(req.getParameter("EDU_SDT"));     //교육시작일
	      String EDU_EDT = Util.nvl(req.getParameter("EDU_EDT"));     //교육종료일
	      String EDU_PGM_C = Util.nvl(req.getParameter("EDU_PGM_C"));     //교육프로그램
	      String EDU_MAIN_BRNO = Util.nvl(req.getParameter("EDU_MAIN_BRNO"));     //교육주관부서
	      String EDU_HOUR = Util.nvl(req.getParameter("EDU_HOUR"));     //교육시간
	      String EDU_JKW_NM = Util.nvl(req.getParameter("EDU_JKW_NM"));     //강사명
	      String EDU_TGT_PCNT = Util.nvl(req.getParameter("EDU_TGT_PCNT"));     //계획(대상)인원
	      String ATTCH_FILE_NO = Util.nvl(req.getParameter("ATTCH_FILE_NO"));     //첨부파일번호
	      String FNSH_PCNT = Util.nvl(req.getParameter("FNSH_PCNT"));     //이수인원
	      String DR_DT = date; //등록일자
	      String DR_TIME = time; //등록시간
	      String DR_OP_JKW_NO = logigId; //등록조작자번호
	      String CHG_DT = date; //변경일자
	      String CHG_TIME = time; //변경시간
	      String CHG_OP_JKW_NO = logigId; //변경조작자번호

	      //GUBN 0 이면 insert
	      if ("0".equals(req.getParameter("GUBN"))) {
	        output = mDao.getData("RBA_50_08_04_02_getRbaAttchFileNo", param);
	        ATTCH_FILE_NO = output.getText("SEQ");
	        Log.logAML(Log.DEBUG, this, "#### ATTCH_FILE_NO!!! [" + ATTCH_FILE_NO+ "]");
	      }
	      
	      param.put("EDU_DT", EDU_DT);
	      param.put("SNO", SNO);
	      param.put("EDU_SUBJ_NM", EDU_SUBJ_NM);
	      param.put("EDU_TGT_G_C", EDU_TGT_G_C);
	      param.put("EDU_CHNL_G_C", EDU_CHNL_G_C);
	      param.put("EDU_SDT", EDU_SDT);
	      param.put("EDU_EDT", EDU_EDT);
	      param.put("EDU_PGM_C", EDU_PGM_C);
	      param.put("EDU_MAIN_BRNO", EDU_MAIN_BRNO);
	      param.put("EDU_HOUR", EDU_HOUR);
	      param.put("EDU_JKW_NM", EDU_JKW_NM);
	      param.put("EDU_TGT_PCNT", EDU_TGT_PCNT);
	      param.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
	      param.put("FNSH_PCNT", FNSH_PCNT);
	      param.put("DR_DT", DR_DT);
	      param.put("DR_TIME", DR_TIME);
	      param.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
	      param.put("CHG_DT", CHG_DT);
	      param.put("CHG_TIME", CHG_TIME);
	      param.put("CHG_OP_JKW_NO", CHG_OP_JKW_NO);
	      
	      
	      DataObj obj1 = new DataObj();
//	      DataObj obj2 = new DataObj();	      
	      
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

	          mDao.setData("RBA_50_08_04_02_insertFile", obj1);

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

	          mDao.setData("RBA_50_08_04_02_insertFile", obj1);
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

	          mDao.setData("RBA_50_08_04_02_insertFile", obj1);
	          count_file++;
	        } else {
	          Log.logAML(Log.DEBUG, this, "####");
	        }

	      }

	      // ==================================================================

	      if("0".equals(req.getParameter("GUBN"))) {
	    	  //등록
	    	  output = mDao.getData("RBA_50_08_04_02_doSave", param);  
	      } else {
	    	  //수정
	    	  output = mDao.getData("RBA_50_08_04_02_doUpdate", param);
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
	    	if (mDao != null) {
	    		try {
	    			mDao.rollback();
	    			mDao.close();
	    		} catch (AMLException ee) {
	    			mDao = null;
	    		}
	    	}
	    	output = new DataObj();
	    	output.put("flag", req.getParameter("flag"));
	    	output.put("ERRCODE", "00001");
	    	output.put("ERRMSG",
	    			getClass().getName() + ".updateInfo \n\r" + ex.toString());
	    } catch (IOException ex) {
	    	Log.logAML(Log.ERROR, this, "updateInfo", ex.getMessage());
	    	if (mDao != null) {
	    		try {
	    			mDao.rollback();
	    			mDao.close();
	    		} catch (AMLException ee) {
	    			mDao = null;
	    		}
	    	}
	    	output = new DataObj();
	    	output.put("flag", req.getParameter("flag"));
	    	output.put("ERRCODE", "00001");
	    	output.put("ERRMSG",
	    			getClass().getName() + ".updateInfo \n\r" + ex.toString());
	    } catch (AMLException ex) {
	    	Log.logAML(Log.ERROR, this, "updateInfo", ex.getMessage());
	    	if (mDao != null) {
	    		try {
	    			mDao.rollback();
	    			mDao.close();
	    		} catch (AMLException ee) {
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
	      if (mDao != null) {
	          try {
	            mDao.rollback();
	            mDao.close();
	          } catch (AMLException ee) {
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
	
    /**
     * 교육계획및 현황 수정<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(교육계획및 현황내역 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doUpdate(DataObj input)
    {
        DataObj output = new DataObj();
                    
        input.put("CHG_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId());
        
        try {
        	MDaoUtilSingle.setData("RBA_50_08_04_02_doUpdate", input);   
        	output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));        	
        } catch(AMLException e) {
        	Log.logAML(Log.ERROR,this,"doUpdate",e.getMessage());
        	output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
        }
        return output;
    }

    /**
     * 교육계획및 현황내역정보 삭제<br>
     * <p>
     * @param   input
     *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  <code>DataObj</code>
     *              GRID_DATA(교육계획및 현황내역정보 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */    
    public DataObj doDelete(DataObj input) throws AMLException
    {
    	DataObj output = new DataObj();
                   
        try {
        	MDaoUtilSingle.setData("RBA_50_08_04_02_doDelete", input);  
        	
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
}
