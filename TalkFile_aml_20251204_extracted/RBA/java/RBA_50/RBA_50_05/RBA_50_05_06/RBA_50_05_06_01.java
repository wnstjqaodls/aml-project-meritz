package com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_06;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.omg.CORBA.UserException;
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
import com.gtone.express.common.ParamUtil;
import com.gtone.express.domain.FileVO;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 * <pre>
 * ML/TF 위험평가
 * </pre>
 * @author CSH
 * @version 1.0
 * @history 1.0 2018-04-30
 */
public class RBA_50_05_06_01 extends GetResultObject {

	private static RBA_50_05_06_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_05_01_01
	*/
	public static  RBA_50_05_06_01 getInstance() {
		synchronized(RBA_50_05_06_01.class) {  
			if (instance == null) {
				instance = new RBA_50_05_06_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* ML/TF위험평가 빈도조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_06_01_getSearch", input);
			if ( output.getCount("BAS_YYMM") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	public DataObj doSearch2(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_05_61_01_getSearch", input);
			if ( output.getCount("BAS_YYMM") > 0 ) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
			
		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	
	/**
	* <pre>
	* 개선 현황 삭제
	* </pre>
	* @param input
	* @return
	*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doDelete(DataObj input) throws AMLException {

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
				
				mDao.setData("RBA_50_05_06_01_doDelete", inputMap);
			}
			
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {mDao.rollback();
			
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
	
	
	
	/**
	* <pre>
	* 개선 조치 요청 저장
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSaveReq(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = new DataObj();
		    SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String loginId = helper.getLoginId();

		    input.put("DR_OP_JKW_NO", loginId);
		    input.put("CHG_OP_JKW_NO", loginId);
		    
		    // 개선 요청시 코드값 : 미조치(N)
		    input.put("IMPRV_S_C", "N");
		    
		    String sqlId = "RBA_50_05_06_02_doSaveReq";
		    
			MDaoUtilSingle.setData(sqlId, input);
			
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
	* 개선 조치 요청 저장
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSaveDetail(DataObj input) throws UserException {

		DataObj output = null;
		DataSet gdRes = null;
		MDaoUtil mDao = null;
		
		try {
			mDao = new MDaoUtil();
			mDao.begin();
			output = new DataObj();
		    SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String logigId = helper.getLoginId();

		    input.put("CHG_OP_JKW_NO", logigId);
		    
		    // 개선 이행시 코드값 : 조치중(S)
		    input.put("IMPRV_S_C", "S");
		    
		    String sqlId = "RBA_50_05_06_03_doSaveDetail";
		    
			MDaoUtilSingle.setData(sqlId, input);
			
			mDao.commit();
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
	
	// 개선현황 파일조회
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj getSearchF(DataObj input) {
	      DataObj output = null;
	      DataSet gdRes = null;

	      try {

	        // 구분 조회
	        output = MDaoUtilSingle.getData("RBA_50_05_06_03_newgetAttachFile",(HashMap) input);
	        // grid data
	        if (output.getCount("CNT") > 0) {
	          gdRes = Common.setGridData(output);
	        } else {
	          output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));
	        }

	        output.put("ERRCODE", "00000");
	        output.put("gdRes", gdRes);


	      } catch (AMLException e) {
	        Log.logAML(Log.ERROR, this, "getSearchF(Exception)", e.getMessage());
	        output = new DataObj();
	        output.put("ERRCODE", "00001");
	        output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
	      }
	      return output;
	 }

	@RequestMapping(value="/rba/50_05_06_01_doSaveFile.do", method=RequestMethod.POST)
	public DataObj doSaveFile(MultipartRequest req) {
		System.out.println("====================== DO FILE SAVE ========================");
	  	DataObj output = new DataObj();
	  	DataObj obj1 = new DataObj();
		MDaoUtil mDao = null;

		String filePath = PropertyService.getInstance().getProperty("aml.config", "uploadPath.rba");
		String fileFullPath = "";

		try {
			mDao = new MDaoUtil();
			SessionHelper helper = new SessionHelper(req.getSession());

			String BAS_YYMM 		= Util.replace(Util.nvl(req.getParameter("BAS_YYMM")), "-", "");
//			String JIPYO_IDX 		= Util.nvl(req.getParameter("JIPYO_IDX"));
			String DR_OP_JKW_NO 	= Util.nvl(helper.getLoginId());
			String ATTCH_FILE_NO	= Util.nvl(req.getParameter("ATTCH_FILE_NO"));
			String FILE_SER			= Util.nvl(req.getParameter("FILE_SER"));
			String LOSC_FILE_NM		= Util.nvl(req.getParameter("LOSC_FILE_NM"));
			String NOTI_ATTACH		= Util.nvl(req.getParameter("NOTI_ATTACH"));
			String PHSC_FILE_NM = "";
			long fileLen = 0;

			fileFullPath = filePath + "/" + "RBA_IMPRV" + "/" + BAS_YYMM + "/";
			fileFullPath = fileFullPath.replace("/", System.getProperty("file.separator"));
			
			AttachFileDataSource[] attachFileDSs = req.getAttachFiles("NOTI_ATTACH");
			int attachFileSize = attachFileDSs.length-1;
			
			//기존파일이 존재할 경우 덮어쓰기전에 파일을 삭제하기위해 변수를 셋팅해둔다.
			obj1.put("BAS_YYMM", BAS_YYMM);
//			obj1.put("JIPYO_IDX", JIPYO_IDX);
			obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
			obj1.put("FILE_SER", FILE_SER);
			obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
			
			if (!"".equals(NOTI_ATTACH)) {	//팝업에서 새롭게 추가한 파일존재
				if ("".equals(LOSC_FILE_NM)) {	//기존파일 없음(신규)
					output = mDao.getData("RBA_90_01_04_02_getSearch_ATTCH_FILE_NO", new DataObj());
					ATTCH_FILE_NO = output.getText("MAX_FILE_NO");
					
				} else {	//기존파일 존재(덮어쓰기)	-> 기존파일을 삭제
					doDeleteAttachFile(obj1);
					
					//신규파일 저장시 ATTCH_FILE_NO를 쿼리에서 10자리로 만들어주는 로직이 있어서 똑같이 구현 
					int strlength = ATTCH_FILE_NO.length();
					StringBuilder sb = new StringBuilder(); 
					if (strlength < 10) {
						strlength = 10 - strlength;
						for (int i = 0; i < strlength; i++) {
							sb.append("0");
						}
					}
					ATTCH_FILE_NO = sb.append(ATTCH_FILE_NO).toString();
				}
				
				PHSC_FILE_NM = ATTCH_FILE_NO + "_" + (FILE_SER);
				req.upload(attachFileDSs[attachFileSize], fileFullPath, PHSC_FILE_NM);
				fileLen = attachFileDSs[attachFileSize].getSize();
				
				if (fileLen > 1) {
					fileLen = fileLen - 2; // getSize시 원래사이즈보다 2가 큼
				}
				
				obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				obj1.put("DATA_G", "G");
				obj1.put("FILE_POS", fileFullPath);
				obj1.put("LOSC_FILE_NM", attachFileDSs[attachFileSize].getName());
				obj1.put("PHSC_FILE_NM", PHSC_FILE_NM);
				obj1.put("FILE_SIZE", fileLen);
				obj1.put("DOWNLOAD_CNT", 0);		//신규거나 덮어쓰기때문에 항상 '0'
//				obj1.put("ITEM_S_C", ITEM_S_C_1);	//항목상태 HIDDEN ('A010', 0:미확정, 1:저장, 2:확정)
				
				mDao.setData("RBA_90_01_04_03_INSERT_ATTCH_FILE", obj1);
			}

//			mDao.setData("RBA_90_01_03_04_UPDATE_ATTCH_FILE", obj1);
			mDao.setData("RBA_90_01_03_04_UPDATE_ATTCH_FILE2", obj1);

			output.put("flag", req.getParameter("flag"));
			output.put("afterFunction", req.getParameter("afterFunction"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", req.getParameter("LANG_CD"), "정상처리되었습니다."));
			output.put("afterClose", req.getParameter("afterClose"));
			output.put("PARAM_DATA", req);
			output.put("ERRCODE", "00000");

			mDao.commit();
			
		} catch (IOException e) {
			Log.logAML(Log.ERROR, this, "doSaveFile", e.getMessage());
			output = new DataObj();
			output.put("flag", req.getParameter("flag"));
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", getClass().getName() + ".updateInfo \n\r" + e.toString());
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSaveFile", e.getMessage());
			output = new DataObj();
			output.put("flag", req.getParameter("flag"));
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", getClass().getName() + ".updateInfo \n\r" + e.toString());
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "doSaveFile", e.getMessage());
			output = new DataObj();
			output.put("flag", req.getParameter("flag"));
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", getClass().getName() + ".updateInfo \n\r" + e.toString());
		} finally {
			if (mDao != null) {
				mDao.close();
			}
		}
		
		return output;
  }
@RequestMapping(value="/rba/90_01_03_03_doSaveFile.do", method=RequestMethod.POST)
  public String doFileSave(HttpServletRequest request, ModelMap model ,FileVO paramVO )throws Exception 
  {
		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		SessionHelper helper = new SessionHelper(request.getSession());
		
		HashMap hm = ParamUtil.getReqParamHashMap(request);
		System.out.println("hm ::::::::"+hm.toString());
		try
		{
			mDao = new MDaoUtil();

	        @SuppressWarnings("unused")
	        int result = 0;

	       
	        //기존 파일목록 
			DataObj fdo = MDaoUtilSingle.getData("RBA_90_01_03_03_newgetAttachFile",hm);
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
							File	realFile	= FileUtil.renameTo(tempFile, Constants._UPLOAD_JIPYO_DIR);
							
							String[]	filePath	= paramVO.getFilePaths();
							filePath[i]				= StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"),Constants._UPLOAD_JIPYO_DIR,"");
							
							paramVO.setFilePath(filePath[i]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
						}
						else
						{
							String[]	filePath	= paramVO.getFilePaths();
							filePath[i]				= StringUtils.replace(filePath[i].replaceAll("\\\\", "/"), Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_JIPYO_DIR);
							
							paramVO.setFilePath(filePath[0]);
						}
					}else {							
						String[]	filePath	= paramVO.getFilePaths();
						filePath[i]				= StringUtils.replace(filePath[i].replaceAll("\\\\", "/"), Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_JIPYO_DIR);
						
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
						String filePath = Constants._UPLOAD_JIPYO_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath);
					}
				}					
				

				//db 파일 삭제
				mDao.setData("RBA_90_01_03_03_1N_deleteFile", hm);					
				
				
			  //  String RPT_GJDT = Util.replace(Util.nvl(hm.get("RPT_GJDT")), "-", "");
		      //  String FIU_RPT_GJDT = Util.replace(Util.nvl(hm.get("FIU_RPT_GJDT")), "-", "");
		        String DR_OP_JKW_NO = Util.nvl(helper.getLoginId());
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
		            obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
		          
		            result = mDao.setData("RBA_10_02_01_01_insertFile", obj1);
					
				}
				hm.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				hm.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
				mDao.setData("RBA_90_01_03_04_UPDATE_ATTCH_FILE", hm);
				mDao.setData("RBA_90_01_03_04_UPDATE_ATTCH_FILE2", hm);
			}
			else
			{
				for(int i=0; i < fileList.size(); i++)
				{
					//기존 파일 삭제
					String filePath = Constants._UPLOAD_JIPYO_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
					FileUtil.deleteFile(filePath);
				}	
				
				//db 파일 삭제
				mDao.setData("RBA_90_01_03_03_1N_deleteFile", hm);
				mDao.setData("RBA_90_01_03_03_doUpdate_JRBA_JIPYO_V", hm);	//지표테이블에 등록된 첨부파일정보 리셋
				mDao.setData("RBA_90_01_03_03_doUpdate_JRBA_JIPYO_V2", hm);
			}
			mDao.commit();
			model.addAttribute("status", "success");
		    model.addAttribute("serviceMessage", "정상 처리되었습니다.");
		}
		catch(IOException ioe)
		{
			Log.logAML(Log.ERROR,this,"doSave",ioe.toString()); 
			model.addAttribute("status", "fail");
			model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
		}
		catch(AMLException e)
		{
			Log.logAML(Log.ERROR,this,"doSave",e.toString()); 
			model.addAttribute("status", "fail");
			model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
		}
		catch(Exception e)
		{
			Log.logAML(Log.ERROR,this,"doSave",e.toString()); 
			model.addAttribute("status", "fail");
		    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
		}
		return "jsonView";
  }


	public DataObj doDeleteAttachFile(DataObj input) {
		DataObj output = new DataObj();
    
    try {
    	
    	//화면에서 호출할때와 doSaveFile()에서 호출할때 상황에 따라 SessionHelper객체가 없을수도있다
    	if (input.getCount("SessionHelper") > 0) {
    		input.put("DR_OP_JKW_NO", ((SessionHelper)input.get("SessionHelper")).getUserId().intValue());
    	}
    	output = MDaoUtilSingle.getData("RBA_90_01_03_03_getFileInfo", input);
    	
    	File file = new File(output.getText("FULL_FILE_PATH").replace("\\", "/"));
    	if (file.exists()) {
    		file.delete();	//물리경로파일 삭제
    	}
    	
	    MDaoUtilSingle.setData("RBA_90_01_03_03_doDelete_RBA_ATTCH_FILE", input);	//첨부파일테이블 데이터 삭제
//	    MDaoUtilSingle.setData("RBA_90_01_03_03_doUpdate_JRBA_JIPYO_V", input);	//지표테이블에 등록된 첨부파일정보 리셋
//	    MDaoUtilSingle.setData("RBA_90_01_03_03_doUpdate_JRBA_JIPYO_V2", input);
	    
	    output.put("ERRCODE", "00000");
		output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다."));
		output.put("gdRes", null); // Grid Data
      
    } catch (AMLException e) {
      Log.logAML(Log.ERROR, this, "doDeleteAttachFile", e.getMessage());
      output.put("ERRCODE", "00001");
      output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
    }
    
    return output;
  }
	
	
  // 개선현황관리 결재요청 팝업내 결재이력 그리드 조회
  public DataObj doSearchGJImpv(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_05_61_02_doSearchGJImpv", input);
		
			if (output.getCount("GYLJ_SER") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			Log.logAML(Log.ERROR, this, "doSearchGJImpv", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
  
   
	
}