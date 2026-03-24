package com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_04;

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
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.Constants;
import com.gtone.express.domain.FileVO;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import com.gtone.express.common.ParamUtil;
import jspeed.base.http.AttachFileDataSource;
import jspeed.base.http.MultipartRequest;
import jspeed.base.property.PropertyService;

/**
 * <pre>
 * FIU보고서 업로드
 * </pre>
 * 
 * @author SeungRok
 * @version 1.0
 * @hisory 16.12.13
 **/
@Controller
public class RBA_90_01_04_03 extends GetResultObject {

	private static RBA_90_01_04_03 instance 			= null;
	public static final String ERRCODE_00999			= "00999";
	public static String ATTCH_FILE_NO  				= "";
	public static String FILE_FULL_PATH  				= PropertyService.getInstance().getProperty("aml.config", "uploadPath.rba") + "/" + "JIPYO" + "/";
	public static AttachFileDataSource[] attachFileDSs	= null;
	
	/**
	 * getInstance
	 * 
	 * @return RBA_90_01_04_02
	 */

	public static   RBA_90_01_04_03 getInstance() {
//		if (instance == null) {
//			instance = new RBA_90_01_04_03();
//		}
//		return instance;
		synchronized(RBA_90_01_04_03.class) {  
	    	if (instance == null) {
			    instance = new RBA_90_01_04_03();
		    }
		}
		return instance;
	}
	
	
	public DataObj doSaveFile(MultipartRequest req) {
		DataObj output = new DataObj();
		
		try {
			
			ATTCH_FILE_NO 				= Util.nvl(req.getParameter("ATTCH_FILE_NO") , "0");
			attachFileDSs 				= req.getAttachFiles("NOTI_ATTACH");
			
			DataObj errorCode =  doFileCountCheck(req);
			if(ERRCODE_00999.equals(errorCode.get("ERRCODE"))) {
				return errorCode;
			}
			doInsertFile(req);
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", req.getParameter("LANG_CD"), "정상처리되었습니다."));
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", req.getParameter("LANG_CD"), "정상처리되었습니다."));
			output.put("ERRCODE", "00000");
			
		} catch (RuntimeException re) {
			Log.logAML(Log.ERROR, this, "doSaveFile(RuntimeException)", re.toString());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", getClass().getName() + ".doSaveFile \n\r" + re.toString());
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "doSaveFile(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", getClass().getName() + ".doSaveFile \n\r" + e.toString());
		}
		return output;
	}
	
	
	public DataObj doFileCountCheck(MultipartRequest req) {
		DataObj output = new DataObj();
		
		try {
			SessionHelper helper = new SessionHelper(req.getSession());

			String[] FILE_SER 			= req.getParameterValues("FILE_SER");
			String[] NOTI_ATTACH 		= req.getParameterValues("NOTI_ATTACH");

			int count_file = 0;
			int count_file_real = 0;

			for (int i = 0; i < FILE_SER.length; i++) {

				if (!FILE_SER[i].equals("0") && NOTI_ATTACH[i].equals("")) {			//그대로 넘어간것
					//아예삭제 했을때
					System.out.println("경우의 수1");
				} else if (!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {	//기존파일말고 새로 추가한것
					System.out.println("경우의 수2");
					count_file++;
				} else if (FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals("")) {		//새로 추가한 파일
					System.out.println("경우의 수3");
					count_file++;
				}
			}

			if (req.getAttach("NOTI_ATTACH") != null) {
				count_file_real = attachFileDSs.length;
			}

			if (count_file_real == count_file) {
				//output.put("ERRCODE", "00999");
				//output.put("ERRMSG", MessageHelper.getInstance().getMessage("0053", helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
				//output.put("WINMSG", MessageHelper.getInstance().getMessage("0053", helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
				//return output;
				output.put("ERRCODE", "00000");
			}else {
				//output.put("ERRCODE", "00000");
				output.put("ERRCODE", "00999");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0053", helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0053", helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
				return output;
				
			}
			
			
		} catch (RuntimeException e) {
			Log.logAML(Log.ERROR, this, "doFileCountCheck(Exception)", e.getMessage());
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "doFileCountCheck(Exception)", e.getMessage());
		}
		
		return output;
	}
	
	public void doInsertFile(MultipartRequest req) {
		
		try {
			
			DataObj output = new DataObj();
			SessionHelper helper = new SessionHelper(req.getSession());
			
			String RPT_GJDT 		= Util.replace(Util.nvl(req.getParameter("RPT_GJDT")), "-", "");
			String FIU_RPT_GJDT 	= Util.replace(Util.nvl(req.getParameter("FIU_RPT_GJDT")), "-", "");
			String DR_OP_JKW_NO 	= Util.nvl(helper.getLoginId());
			String PHSC_FILE_NM		= "";
			String[] FILE_SER 		= req.getParameterValues("FILE_SER");
			String[] NOTI_ATTACH 	= req.getParameterValues("NOTI_ATTACH");
			
			
			long fileLen = 0;
			int count_file = 0;
			int FILE_SER_MAX = 0;
			
			//최초 첨부파일 등록상태
			if ("0".equals(ATTCH_FILE_NO)) {
				
				output = MDaoUtilSingle.getData("RBA_90_01_04_02_getSearch_ATTCH_FILE_NO", new DataObj());
				ATTCH_FILE_NO = output.getText("MAX_FILE_NO");
			}
			
			@SuppressWarnings("unused")
			DataObj memory = new DataObj();
			DataObj mparam = new DataObj();
			mparam.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
			memory = MDaoUtilSingle.getData("RBA_90_01_04_04_ATTACH_FILE", mparam);
			doDeleteFile();
			
			DataObj param = new DataObj();
			
			if(FILE_SER != null && NOTI_ATTACH != null) {
				
				for (int i = 0; i < FILE_SER.length; i++) {
					
					//DataObj param = new DataObj();
					
					if (!FILE_SER[i].equals("0") && NOTI_ATTACH[i].equals("")) {	//첨부파일번호가 있고 첨부파일이 없을때(기존꺼 그대로 올렷을때)
						
						System.out.println("첨부파일번호가 있고 첨부파일이 없을때");
						String FILE_POS = "";
						String LOSC_FILE_NM = "";
						String FILE_SIZE = "";
						String FILE_SEQ = "";
						
						if(memory.getCount("ATTCH_FILE_NO") > 0) {
							
							for (int j = 0; j < memory.getCount(); j++) {
								
								FILE_SEQ = memory.get("FILE_SEQ", j).toString();
								
								if(FILE_SER[i].equals(FILE_SEQ)) {
									
									FILE_POS = memory.get("FILE_POS", j).toString();
									LOSC_FILE_NM = memory.get("USER_FILE_NM", j).toString();
									PHSC_FILE_NM = memory.get("PHSC_FILE_NM", j).toString();
									FILE_SIZE = memory.get("FILE_SIZE", j).toString();
								}
							}
						}
						
						FILE_SER_MAX = Integer.parseInt(FILE_SER[i]);
						param.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
						param.put("FILE_SER", FILE_SER_MAX);
						param.put("DATA_G", "G");
						param.put("FILE_POS", FILE_POS);
						param.put("LOSC_FILE_NM",LOSC_FILE_NM);
						param.put("PHSC_FILE_NM",PHSC_FILE_NM);
						param.put("FILE_SIZE", FILE_SIZE);
						param.put("DOWNLOAD_CNT", "0");
						param.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
						MDaoUtilSingle.setData("RBA_90_01_04_03_INSERT_ATTCH_FILE", param);
						param.clear();
						
					} else if ((!FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals(""))		// 첨부파일번호가 있고 첨부파일이 있을때(기존파일을 변경) 
							   || (FILE_SER[i].equals("0") && !NOTI_ATTACH[i].equals(""))	// 첨부파일번호가 없고 첨부파일이 있을때(신규파일 추가)
								) {	
						
						FILE_SER_MAX++;
						PHSC_FILE_NM = padZero(Integer.parseInt(ATTCH_FILE_NO) , 10) + "_" + (FILE_SER_MAX);
						
						req.upload(attachFileDSs[count_file], FILE_FULL_PATH+ RPT_GJDT + "/", PHSC_FILE_NM);
						fileLen = attachFileDSs[count_file].getSize();
						
						if (fileLen > 1) {
							fileLen = fileLen - 2; // getSize시 원래사이즈보다 2가 큼
						}
						
						System.out.println("첨부파일번호가 있고 첨부파일이 있을때(기존파일을 변경)");
						System.out.println("첨부파일번호가 없고 첨부파일이 있을때(신규파일 추가)");
						
						param.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
						param.put("FILE_SER", FILE_SER_MAX);
						param.put("DATA_G", "G");
						param.put("FILE_POS", FILE_FULL_PATH+ RPT_GJDT + "/");
						param.put("LOSC_FILE_NM", attachFileDSs[count_file].getName());
						param.put("PHSC_FILE_NM", PHSC_FILE_NM);
						param.put("FILE_SIZE", fileLen);
						param.put("DOWNLOAD_CNT", "0");
						param.put("DR_OP_JKW_NO", DR_OP_JKW_NO);

						MDaoUtilSingle.setData("RBA_90_01_04_03_INSERT_ATTCH_FILE", param);
						param.clear();
						count_file++;
						
						//물리적경로 삭제
						/*if(!"".equals(memory.get("FILE_POS" , 0).toString())) {
							File uploadFile = new File(memory.get("FILE_POS" , 0).toString()+memory.get("PHSC_FILE_NM" , 0).toString());
							if(uploadFile != null){
								uploadFile.delete();
							}
						}*/
						
					} 
				}
				
				DataObj obj1 = new DataObj();

				obj1.put("RPT_GJDT", RPT_GJDT);
				obj1.put("FIU_RPT_GJDT", FIU_RPT_GJDT);
				obj1.put("DR_OP_JKW_NO", DR_OP_JKW_NO);
				obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				
				String query_id = "RBA_90_01_04_03_UPDATE_JRBA_RPT_RST_M";
				MDaoUtilSingle.setData(query_id, obj1);
			}
			
			
			
		} catch (IOException e) {
			Log.logAML(Log.ERROR, this, "doInsertFile(Exception)", e.getMessage());
		} catch (NumberFormatException e) {
			Log.logAML(Log.ERROR, this, "doInsertFile(Exception)", e.getMessage());
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doInsertFile(Exception)", e.getMessage());
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "doInsertFile(Exception)", e.getMessage());
			
		}
	}
	
	public void doDeleteFile() {
		
		try {
			
			DataObj param = new DataObj();
			DataObj output = new DataObj();
			String FILE_POS ="";
			String PHSC_FILE_NM = "";
			String FILE_SEQ = "";
			
			param.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
			
			output = MDaoUtilSingle.getData("RBA_90_01_04_04_ATTACH_FILE", param);
			
			DataObj delParam = new DataObj();
			
			if(output.getCount("ATTCH_FILE_NO") > 0) {
				
				for (int i = 0; i < output.getCount(); i++) {
					FILE_POS = Util.nvl(output.get("FILE_POS" ,i) , "");
					PHSC_FILE_NM = Util.nvl(output.get("PHSC_FILE_NM" ,i) , "");
					FILE_SEQ = Util.nvl(output.get("FILE_SEQ" ,i) , "");
					
					//if(!"".equals(FILE_POS)) {
						/*File uploadFile = new File(FILE_POS+PHSC_FILE_NM);
						if(uploadFile != null){
							uploadFile.delete();
						}*/
					//}
					
					 
					 delParam.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
					 delParam.put("FILE_SER"	 , FILE_SEQ);
					 
					//삭제
					MDaoUtilSingle.setData("RBA_90_01_03_03_doDelete_RBA_ATTCH_FILE", delParam);	
					delParam.clear();
					
				}
				
			}
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doDeleteFile(Exception)", e.getMessage());
		}
	}
	
	@RequestMapping(value="/rba/90_01_04_03doFileSave.do", method = RequestMethod.POST)
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
				DataObj fdo = MDaoUtilSingle.getData("RBA_90_01_04_01_getSearch2",hm);
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
								filePath[i]				= StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"),Constants._UPLOAD_JIPYO_DIR,"").replaceAll("\\\\", "/");
								
								paramVO.setFilePath(filePath[i]);
								paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
							}
							else
							{
								String[]	filePath	= paramVO.getFilePaths();
								filePath[i]				= StringUtils.replace(filePath[i].replaceAll("\\\\", "/"), Constants.COMMON_TEMP_FILE_UPLOAD_DIR.replaceAll("\\\\", "/"), Constants._UPLOAD_JIPYO_DIR.replaceAll("\\\\", "/"));
								
								paramVO.setFilePath(filePath[0]);
							}
						}else {							
							String[]	filePath	= paramVO.getFilePaths();
							filePath[i]				= StringUtils.replace(filePath[i].replaceAll("\\\\", "/"), Constants.COMMON_TEMP_FILE_UPLOAD_DIR.replaceAll("\\\\", "/"), Constants._UPLOAD_JIPYO_DIR.replaceAll("\\\\", "/"));
							
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
					mDao.setData("RBA_90_01_04_03_UPDATE_JRBA_RPT_RST_M", hm);
					mDao.commit();
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
					mDao.commit();
				}
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
	
    public static String padZero(int v , int cnt) {
		String nos = "000000000000000000000000000000000000000000000000000000000"+v;
		return nos.substring(nos.length()-cnt);
	}
    
    
	
}