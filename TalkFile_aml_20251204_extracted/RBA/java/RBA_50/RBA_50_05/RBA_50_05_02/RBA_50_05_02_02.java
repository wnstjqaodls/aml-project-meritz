package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_02;

import java.io.IOException;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * ML/TF 위험평가 상세
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-05-10
 */
public class RBA_50_05_02_02 extends GetResultObject {

	private static RBA_50_05_02_02 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_02_02
	*/
	public static  RBA_50_05_02_02 getInstance() {
		if (instance == null) {
			instance = new RBA_50_05_02_02();
		}
		return instance;
	}

	/**
	* <pre>
	* ML/TF위험평가 상세조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
		output = MDaoUtilSingle.getData("RBA_50_05_02_02_getSearch", input);
			// grid data
			if (output.getCount("BAS_YYMM") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		      } catch (AMLException e) {
		        Log.logAML(Log.ERROR, this, "doSearch(Exception)", e.getMessage());
		        output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		      }
		return output;
	}

	/**
	* <pre>
	* 통제점검항목 저장
	* </pre>
	* @param input
	* @return
	 * @throws AMLException 
	*/
	public DataObj doSave(MultipartRequest req) throws AMLException {

		DataObj output = null;
		DataSet gdRes = null;
		MDaoUtil mDao = null; 

		try {
			mDao = new MDaoUtil();
			mDao.begin();
			output = new DataObj();
			SessionHelper helper = new SessionHelper(req.getSession());
		    String logigId = helper.getLoginId();

		    DataObj input = new DataObj();
		    
		    input.put("DR_OP_JKW_NO", logigId);
		    input.put("CHG_OP_JKW_NO", logigId);
		    
		    input.put("BAS_YYMM", req.getParameter("BAS_YYMM"));
		    input.put("TONGJE_SMDV_C", req.getParameter("PROC_SMDV_C"));
		    input.put("TONGJE_NO", req.getParameter("S_TONGJE_NO"));
		    input.put("VALT_BRNO", req.getParameter("VALT_BRNO"));
		    
		    input.put("JIPYO_OFFR_C", req.getParameter("JIPYO_OFFR_C"));
		    input.put("VALD_VALT_METH_C", req.getParameter("S_VALD_VALT_METH_C"));
		    input.put("VALT_METH_C", req.getParameter("S_VALT_METH_C"));
		    input.put("OPR_TP_C_V", req.getParameter("S_OPR_TP_C_V"));
		    input.put("TONGJE_VALD_PNT", req.getParameter("TONGJE_VALD_PNT"));
		    input.put("DSGN_VALT_TP_C", req.getParameter("S_DSGN_VALT_TP_C"));
		    input.put("DSGN_TP_C_V", req.getParameter("S_DSGN_TP_C_V"));
		    input.put("DSGN_VALT_PNT", req.getParameter("DSGN_VALT_PNT"));  
		   
		    //Attach File Start
		    String ATTCH_FILE_NO  = "".equals(req.getParameter("ATTCH_FILE_NO_R"))?"0": req.getParameter("ATTCH_FILE_NO_R");
		    input.put("ATTCH_FILE_NO",  ATTCH_FILE_NO);
		    
		    // delete File
		    mDao.setData("RBA_10_02_01_01_deleteFile", input);
		    //서버 물리적 파일경로 
			String filePath = PropertyService.getInstance().getProperty("aml.config","uploadPath.rba");
			String fileFullPath = "";
		    // file pathfilePath 
			fileFullPath = filePath + "/" + "RBA" + "/" + "TONGJE" + "/"+ req.getParameter("BAS_YYMM") + "/"+ req.getParameter("PROC_LGDV_C") + "_"+ req.getParameter("S_TONGJE_NO") + "/"+ req.getParameter("VALT_BRNO") + "/";
		    fileFullPath = fileFullPath.replace("/",System.getProperty("file.separator"));
		    
		    String[] FILE_SER = req.getParameterValues("FILE_SER_R");
	        String[] FILE_POS_temp = req.getParameterValues("FILE_POS_temp_R");
	        String[] LOSC_FILE_NM_temp = req.getParameterValues("LOSC_FILE_NM_temp_R");
	        String[] PHSC_FILE_NM_temp = req.getParameterValues("PHSC_FILE_NM_temp_R");
	        String[] FILE_SIZE_temp = req.getParameterValues("FILE_SIZE_temp_R");
	        String[] DOWNLOAD_CNT_temp = req.getParameterValues("DOWNLOAD_CNT_temp_R");
	        String[] NOTI_ATTACH = req.getParameterValues("NOTI_ATTACH_R");
	        
	        Log.logAML(Log.DEBUG, this, "#### FILE_SER :" + FILE_SER );
		    Log.logAML(Log.DEBUG, this, "#### FILE_POS_temp :" + FILE_POS_temp );
		    Log.logAML(Log.DEBUG, this, "#### LOSC_FILE_NM_temp :"+ LOSC_FILE_NM_temp );
		    Log.logAML(Log.DEBUG, this, "#### PHSC_FILE_NM_temp :"+ PHSC_FILE_NM_temp );
		    Log.logAML(Log.DEBUG, this, "#### FILE_SIZE_temp :" + FILE_SIZE_temp);
		    Log.logAML(Log.DEBUG, this, "#### DOWNLOAD_CNT_temp :"+ DOWNLOAD_CNT_temp );
		    Log.logAML(Log.DEBUG, this, "#### NOTI_ATTACH :" + NOTI_ATTACH );
		    
		    AttachFileDataSource[] attachFileDSs = req.getAttachFiles("NOTI_ATTACH_R");
		    
		    int count_file = 0;
		    int count_file_real = 0;
		    
		    Log.logAML(Log.DEBUG, this, "#### FILE_SER.length [" + FILE_SER.length+ "]");

		      for (int i = 0; i < FILE_SER.length; i++) {
		    	  Log.logAML(Log.DEBUG, this, "#### for~~~~~~~~~~~~: " + i);
		    	  Log.logAML(Log.DEBUG, this, "#### FILE_SER[i] :" + FILE_SER[i]);
		    	  Log.logAML(Log.DEBUG, this, "#### NOTI_ATTACH[i] :" + NOTI_ATTACH[i]);

		    	  if (!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
		    		  count_file++;
		    	  } else if (FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
		    		  count_file++;
		    	  }
		      }
		      
		    Log.logAML(Log.DEBUG, this, "#### count_file :" + count_file);

		      if (req.getAttachFiles("NOTI_ATTACH_R") != null) {
		        Log.logAML(Log.DEBUG, this, "#### count_file_real_if :"+ count_file_real );
		        count_file_real = attachFileDSs.length;
		      }
		      Log.logAML(Log.DEBUG, this, "#### count_file_real :" + count_file_real);


		      if (count_file_real != count_file) {
		    	  mDao.rollback();
		    	  output.put("ERRCODE", "00999");
		    	  output.put("ERRMSG",MessageHelper.getInstance().getMessage("0053",helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
		    	  output.put("WINMSG",MessageHelper.getInstance().getMessage("0053",helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
		    	  return output;
		      }
		      
		    count_file = 0;
	        int FILE_SEQ_max = 0;
	        long fileLen = 0;
	        FILE_SEQ_max = 0; 
	        
	        if ("0".equals(ATTCH_FILE_NO)) {
				output = MDaoUtilSingle.getData("RBA_90_01_04_02_getSearch_ATTCH_FILE_NO", new DataObj());
				ATTCH_FILE_NO = output.getText("MAX_FILE_NO");
			}
			
	        for (int i = 0; i < FILE_SER.length; i++) {

		        if (!FILE_SER[i].equals("0") && NOTI_ATTACH[i].equals("")) {
		          Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 있고 첨부파일이 없을때(기존파일 고정)");
		          // 첨부정보 저장처리
		          FILE_SEQ_max++;

		          input.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
		          input.put("FILE_SER", FILE_SEQ_max);
		          input.put("DATA_G", "G");
		          input.put("FILE_POS", FILE_POS_temp[i]);
		          input.put("LOSC_FILE_NM", LOSC_FILE_NM_temp[i]);
		          input.put("PHSC_FILE_NM", PHSC_FILE_NM_temp[i]);
		          input.put("FILE_SIZE", FILE_SIZE_temp[i]);
		          input.put("DOWNLOAD_CNT", DOWNLOAD_CNT_temp[i]);
		          input.put("DR_OP_JKW_NO", logigId);

		          mDao.setData("RBA_50_03_01_01_insertFile", input);

		        } else if (!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {
		          FILE_SEQ_max++;
		          Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 있고 첨부파일이 있을때(기존파일을 변경");

		          // if(attachFileDSs[i]) {

		          input.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
		          input.put("FILE_SER", FILE_SEQ_max);
		          input.put("DATA_G", "G");
		          input.put("FILE_POS", FILE_POS_temp[i]);
		          input.put("LOSC_FILE_NM", attachFileDSs[count_file].getName());
		          input.put("PHSC_FILE_NM", PHSC_FILE_NM_temp[i]);
		          input.put("FILE_SIZE", FILE_SIZE_temp[i]);
		          input.put("DOWNLOAD_CNT", DOWNLOAD_CNT_temp[i]);
		          input.put("DR_OP_JKW_NO", logigId);

		          mDao.setData("RBA_50_03_01_01_insertFile", input);
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

		          input.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
		          input.put("FILE_SER", FILE_SEQ_max);
		          input.put("DATA_G", "G");
		          input.put("FILE_POS", fileFullPath);
		          input.put("LOSC_FILE_NM", attachFileDSs[count_file].getName());
		          input.put("PHSC_FILE_NM", PHSC_FILE_NM);
		          input.put("FILE_SIZE", fileLen);
		          input.put("DOWNLOAD_CNT", 0);
		          input.put("DR_OP_JKW_NO", logigId);

		          mDao.setData("RBA_50_03_01_01_insertFile", input);
		          count_file++;
		        } else {
		          Log.logAML(Log.DEBUG, this, "#### 넌뭔데");
		        }

		      } 
		    //Attach File End 
	        
		    //구분이 0: 등록  , 1: 수정  
		    mDao.setData("RBA_50_05_02_02_doSave", input); 
		    
		    mDao.commit();
			
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		}catch (IOException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally {
			if(mDao != null) {
				mDao.close();
			}
				
		}
		return output;
	}
	
	
}