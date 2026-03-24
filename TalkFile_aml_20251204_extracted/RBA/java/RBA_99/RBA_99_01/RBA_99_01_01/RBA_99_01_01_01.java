package com.gtone.rba.server.common.RBA_99.RBA_99_01.RBA_99_01_01;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.DateUtil;
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

import kr.co.itplus.jwizard.dataformat.DataSet;




@Controller
public class RBA_99_01_01_01 extends GetResultObject {
	
	public static final String ERRCODE_00000				= "00000";
	public static final String ERRCODE_00090				= "00090";
	public static final String ERRCODE_00091				= "00091";
	public static final String ERRCODE_00092				= "00092";
	public static final String ERRCODE_00093				= "00093";
	public static final String ERRCODE_00094				= "00094";
	public static final String ERRCODE_00095				= "00095";
	public static final String ERRCODE_00096				= "00096";
	public static final String ERRCODE_00097				= "00097";
	public static final String ERRCODE_00098				= "00098";

	public static String WINMSG_00090						= "00090";
	public static String WINMSG_00091						= "업로드한 파일의 데이터가 없습니다.";
	public static String WINMSG_00092						= "보고기준일 의 지표를 확정해 주시기 바랍니다.";
	public static String WINMSG_00093						= "업로드한 파일의 인덱스값을 다시 확인하여 주시기 바랍니다.";
	public static String WINMSG_00094						= "지표정보가 없습니다.";
	public static String WINMSG_00095						= "지표정보와 엑셀에 지표번호가 불일치...";
	public static String WINMSG_00096						= "지표번호 결과값을 확인 하여 주시기 바랍니다.";
	public static String WINMSG_00097						= "결과값은 숫자만 가능 합니다.";
	public static String WINMSG_00098						= "00098";
	
	
	private static RBA_99_01_01_01 instance = null;
	
	public static RBA_99_01_01_01 getInstance() {
		if ( instance == null ) {
			instance = new RBA_99_01_01_01();
		}
		return instance;
	}
			
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSearch(DataObj input)
    
    {	
        DataObj output = new DataObj(); 
        DataSet gdRes = null;
        try {
        	
        	output = MDaoUtilSingle.getData("RBA_99_01_01_01_doSearch", (HashMap) input);
	    	// grid data
	    	if (output.getCount("EDU_NM") > 0) {
	    		gdRes = Common.setGridData(output);
	    	} else {
	    		output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));	    		

	    	}	    	
	    	output.put("ERRCODE", "00000");	    	
	    	output.put("gdRes", gdRes);	    	
	    	
        }catch(AMLException e){        	
            Log.logAML(
                     Log.ERROR
                    ,this.getClass()
                    ,"getSearch"
                    ,e.getMessage()
            );
            output = new DataObj();
            
            output.put("ERRCODE"    ,"00001");
            output.put("ERRMSG"        ,e.toString());            
        }
        
        return output;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj getSearch(DataObj input)
    
    {	
        DataObj output = new DataObj(); 
        DataSet gdRes = null;
        try {
        	
        	output = MDaoUtilSingle.getData("RBA_99_01_01_02_getSearch", (HashMap) input);
	    	// grid data
	    	if (output.getCount("EDU_NM") > 0) {
	    		gdRes = Common.setGridData(output);
	    	} else {
	    		output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));	    		

	    	}	    	
	    	output.put("ERRCODE", "00000");	    	
	    	output.put("gdRes", gdRes);	    	
	    	
        }catch(AMLException e){        	
            Log.logAML(
                     Log.ERROR
                    ,this.getClass()
                    ,"getSearch"
                    ,e.getMessage()
            );
            output = new DataObj();
            
            output.put("ERRCODE"    ,"00001");
            output.put("ERRMSG"        ,e.toString());            
        }
        
        return output;
    }
	
	public DataObj getSearchFile(DataObj input) {
	      DataObj output = null;
	      DataSet gdRes = null;

	      try {

	        // 구분 조회
	        output = MDaoUtilSingle.getData("RBA_99_01_01_02_getRbaAttchInfo",(HashMap) input);
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
	
	public DataObj getSearchTGT(DataObj input) {
	      DataObj output = null;
	      DataSet gdRes = null;

	      try {

	        // 구분 조회
	        output = MDaoUtilSingle.getData("RBA_99_01_01_02_getTGTSearch",(HashMap) input);
	        // grid data
	        if (output.getCount("EDU_TGT_CCD") > 0) {
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
	
	@SuppressWarnings({ "rawtypes" })
    public DataObj doEduDelete(DataObj input) {	
		
        DataObj output = new DataObj(); 
        MDaoUtil mDao = null;
        
        int result = 0;
        int result2 = 0;
        int totcount = 0;
               
        try {
        	mDao = new MDaoUtil();
        	List gdReq = (List) input.get("gdReq");
        	        	
            totcount = gdReq.size();
    		if ( totcount > 0 ) {
    			
    			HashMap inputMap = null;
    			
    			for ( int i = 0; i < totcount; i++ ) {
    				inputMap = (HashMap) gdReq.get(i);
    				
    	        	output.put("EDU_ID", inputMap.get("EDU_ID"));
    	            
    				DataObj fdo = MDaoUtilSingle.getData("RBA_99_01_01_02_getRbaAttchInfo", output);			
    				List<HashMap> fileList = fdo.getRowsToMap();
    				System.out.println("fileList ::::::::"+fileList.toString());	
    				StringBuffer strPath = new StringBuffer(256);
    				
    				for(int j=0; j < fileList.size(); j++)
    				{
    					strPath.setLength(0);
    					strPath.append(Constants._UPLOAD_EDU_DIR);
    					strPath.append(fileList.get(j).get("FILE_POS"));
    					strPath.append('/');
    					strPath.append(fileList.get(j).get("PHSC_FILE_NM"));
    					String filePath = strPath.toString();
    					//String filePath = Constants._UPLOAD_NOTICE_DIR+fileList.get(i).get("FILE_POS")+"/"+fileList.get(i).get("PHSC_FILE_NM");
    					FileUtil.deleteFile(filePath);
    				}	
    				
    				//파일정보 삭제 먼저
    				mDao.setData("RBA_99_01_01_01_doEduDelete_ATTCH_FILE", output);
    				result = mDao.setData("RBA_99_01_01_01_doEduDelete", output);
    				result2 = mDao.setData("RBA_99_01_01_01_doEduDelete_TGT", output);
    				mDao.setData("RBA_99_01_01_01_doEduDelete_TGT_JKW_ALL", output);
    				
    				mDao.commit();
    				
    				if(result > 0 && result2 > 0) {
    					output.put("ERRCODE", "00000");
    					output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상 처리되었습니다."));// PHH 2009.03.02 다국어
    					output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상 처리되었습니다."));// PHH 2009.03.02 다국어 // 화면 popUp 메세지 출력시 정의함.
    				}

    			}
    		}
            
	    	
        } catch (AMLException e) {
        	if (mDao != null) {
				try {
					mDao.rollback();
				} catch (AMLException e1) {
					Log.logAML(Log.ERROR, this, "doEduDelete", e.getMessage());
					output.put("ERRCODE", "00001");
					output.put("ERRMSG", e.getMessage());
					output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));// PHH 2009.03.02 다국어
				}
			}
			Log.logAML(Log.ERROR, this, "doEduDelete", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", e.getMessage());
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));// PHH 2009.03.02 다국어
		} catch (IOException e) {
			if (mDao != null) {
				try {
					mDao.rollback();
				} catch (AMLException e1) {
					Log.logAML(Log.ERROR, this, "doEduDelete", e.getMessage());
					output.put("ERRCODE", "00001");
					output.put("ERRMSG", e.getMessage());
					output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));// PHH 2009.03.02 다국어
				}
			}
			Log.logAML(Log.ERROR, this, "doEduDelete", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", e.getMessage());
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));// PHH 2009.03.02 다국어
		} catch (Exception e) {
			if (mDao != null) {
				try {
					mDao.rollback();
				} catch (AMLException e1) {
					Log.logAML(Log.ERROR, this, "doEduDelete", e.getMessage());
					output.put("ERRCODE", "00001");
					output.put("ERRMSG", e.getMessage());
					output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));// PHH 2009.03.02 다국어
				}
			}
			Log.logAML(Log.ERROR, this, "doEduDelete", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", e.getMessage());
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));// PHH 2009.03.02 다국어
		} finally {
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
    }
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doSaveEmp(DataObj input) throws AMLException {

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

				inputMap.put("DR_OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호
				inputMap.put("CON_YN", "0" ); // 변경조작자번호
				inputMap.put("EDU_ID", input.get("EDU_ID"));
			
				mDao.setData("RBA_99_01_01_02_doUpdateEmp_NEW", inputMap);	
			}
			
			//DB commit
			mDao.commit();
	  
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}finally{
			//DB Close
			if (mDao != null) {
				mDao.close();
			}
		}
		return output;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSearchUser(DataObj input)
    
    {	
        DataObj output = new DataObj(); 
        DataSet gdRes = null;
        try {
        	
        	output = MDaoUtilSingle.getData("RBA_99_01_01_03_GetJKWInfo", (HashMap) input);
	    	// grid data
	    	if (output.getCount("JKW_NO") > 0) {
	    		gdRes = Common.setGridData(output);
	    	} else {
	    		output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));	    		

	    	}	    	
	    	output.put("ERRCODE", "00000");	    	
	    	output.put("gdRes", gdRes);	    	
	    	
        }catch(AMLException e){        	
            Log.logAML(
                     Log.ERROR
                    ,this.getClass()
                    ,"getSearch"
                    ,e.getMessage()
            );
            output = new DataObj();
            
            output.put("ERRCODE"    ,"00001");
            output.put("ERRMSG"        ,e.toString());            
        }
        
        return output;
    }
	
		
	
	// 교육이수자 명세 -> 사용자 조회
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj doSearchJKW(DataObj input)
    
    {	
        DataObj output = new DataObj(); 
        DataSet gdRes = null;
        try {
        	
        	output = MDaoUtilSingle.getData("RBA_99_01_01_02_doSearchJKW", (HashMap) input);
	    	// grid data
	    	if (output.getCount("USER_ID") > 0) {
	    		gdRes = Common.setGridData(output);
	    	} else {
	    		output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"), "조회된 정보가 없습니다."));	    		

	    	}	    	
	    	output.put("ERRCODE", "00000");	    	
	    	output.put("gdRes", gdRes);	    	
	    	
        }catch(AMLException e){        	
            Log.logAML(
                     Log.ERROR
                    ,this.getClass()
                    ,"getSearch"
                    ,e.getMessage()
            );
            output = new DataObj();
            
            output.put("ERRCODE"    ,"00001");
            output.put("ERRMSG"        ,e.toString());            
        }
        
        return output;
    }
	
	
//	@RequestMapping("/rba/99_01_01_02_doSaveFile.do")
//	public String doFileSave(HttpServletRequest request, ModelMap model,FileVO paramVO)throws Exception
//	{
//			HashMap hm = ParamUtil.getReqParamHashMap(request);
//			String filePath = Constants.COMMON_TEMP_FILE_UPLOAD_DIR; //PropertyService.getInstance().getProperty("aml.config", "upload.file.wl");
//			String filename = String.valueOf(hm.get("storedFileNms"));
////			boolean JipyoCheck = true;
//			HSSFWorkbook workbook = null;
////			FileInputStream fis = null;
//			HSSFSheet sheet= null;
////			DataObj output  = null;
////			DataObj output2 = null;
////			DataObj output3 = null;
//			String newFilePathName ="";
//			String ERRCODE = ERRCODE_00000;
//
//			
//			try(FileInputStream fis = new FileInputStream(newFilePathName);
//					
//				HSSFWorkbook wb = (HSSFWorkbook) WorkbookFactory.create(fis)){
//				workbook = wb;
//				sheet = workbook.getSheetAt(0);
//				
//				DataFormatter fmt = new DataFormatter();		// 문자열
//				int last = sheet.getLastRowNum();
//				
//				for(int i=1; i<=last; i++) {
//					HSSFRow row = sheet.getRow(i);
//					if(row == null) continue;		// 행이 비어있으면 스킵
//					
//					String NUM = fmt.formatCellValue(row.getCell(0));
//					String JKW_NO = fmt.formatCellValue(row.getCell(1));
//					String USER_NM = fmt.formatCellValue(row.getCell(2));
//					String POSITION_NM = fmt.formatCellValue(row.getCell(3));
//					String DEP_NM = fmt.formatCellValue(row.getCell(4));
//					String ING_YN = fmt.formatCellValue(row.getCell(5));
//					String ING_DT = fmt.formatCellValue(row.getCell(6));
//					
////					String ING_DT = "";
////					HSSFCell c = row.getCell(6);
////					
////					if(c != null) {
////						if(c.getCellType() == CellType.NUMERIC) {
////							double n = c.getNumericCellValue();
////							
////							if(!Double.isNaN(n) && n > 0 && n < 2958465) {
////								java.util.Date d = DateUtil.g
////							}
////						}
////					}
//				}
//			
//			} catch(RuntimeException e) {
//				Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
//				model.addAttribute("status", "fail");
//				model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
//			} catch(Exception e) {
//				Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
//				model.addAttribute("status", "fail");
//			    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
//			} finally {
//				if((newFilePathName == null)== false) {
//					newFilePathName = newFilePathName.replace("\\", "/");
//				}
//				File uploadFile = new File(newFilePathName);
//	
//				if(uploadFile != null){
//					uploadFile.delete();
//				}
//	
//				if (workbook != null) {
//	               try {
//					    workbook.close();
//	               }catch (IOException e) {
//	            	   Log.logAML(Log.ERROR, this, "doFileSave(IOException)", e.toString());
//					   }
//				}
//	
//			}
//		return "jsonView";
//			
//			
//	}
			
	
	
	@RequestMapping("/rba/99_01_01_02_doSaveFile.do")
	public String doFileSave(HttpServletRequest request, ModelMap model,FileVO paramVO)throws Exception
	{
			HashMap hm = ParamUtil.getReqParamHashMap(request);
			String filePath = Constants.COMMON_TEMP_FILE_UPLOAD_DIR; //PropertyService.getInstance().getProperty("aml.config", "upload.file.wl");
			HSSFWorkbook workbook = null;
			FileInputStream fis = null;
			HSSFSheet sheet= null;
			DataObj output  = null;
			DataObj output2 = null;
			DataObj output3 = null;
			String newFilePathName ="";
			String ERRCODE = ERRCODE_00000;
			try
			{
				output = new DataObj();
				output2 = new DataObj();
				output3 = new DataObj();
				
				List<Map<String, Object>> val = new ArrayList<Map<String , Object>>() ;
				SessionHelper helper = new SessionHelper(request.getSession());
				BigDecimal userId = helper.getUserId();
				
				String filename = hm.get("storedFileNms").toString();
				String fileFullInfo = filePath + "/" + filename;
				newFilePathName = fileFullInfo.replace("/", System.getProperty("file.separator"));
				newFilePathName = newFilePathName.replace("\\", "/");
				
				fis = new FileInputStream(newFilePathName);
				workbook = new HSSFWorkbook(fis);
				sheet = workbook.getSheetAt(0);
				System.out.println("Sheet :::::: " + sheet);
				int rows = sheet.getPhysicalNumberOfRows();
				
				DataFormatter fmt = new DataFormatter();		// 문자열
				int last = sheet.getLastRowNum();
				
				if(!(rows >1)){ //업로드 엑셀 데이터가 없는 경우
					ERRCODE = ERRCODE_00091;
					model.addAttribute("status", "fail");
				    model.addAttribute("serviceMessage", WINMSG_00091);
				    return "jsonView";
				}else {
					
					for(int i=1; i<=last; i++) {
						HSSFRow row = sheet.getRow(i);
						
						if(row != null) {
							
							String JKW_NO = fmt.formatCellValue(row.getCell(0));
							String USER_NM = fmt.formatCellValue(row.getCell(1));
							String POSITION_NM = fmt.formatCellValue(row.getCell(2));
							String DEP_NM = fmt.formatCellValue(row.getCell(3));
							String ING_YN = fmt.formatCellValue(row.getCell(4));
							String ING_DT = fmt.formatCellValue(row.getCell(5));
							
							if(ING_DT != null) ING_DT = ING_DT.replaceAll("\\D", "");
							
							Map<String,Object> map = new HashMap<>();
							map.put("JKW_NO", JKW_NO);
							map.put("USER_NM", USER_NM);
							map.put("POSITION_NM", POSITION_NM);
							map.put("DEP_NM", DEP_NM);
							map.put("ING_YN", ING_YN);
							map.put("ING_DT", ING_DT);
							
							val.add(map);
						}
						
//						if(row == null) continue;		// 행이 비어있으면 스킵
						
//						String NUM = fmt.formatCellValue(row.getCell(0));
//						String JKW_NO = fmt.formatCellValue(row.getCell(1));
//						String USER_NM = fmt.formatCellValue(row.getCell(2));
//						String POSITION_NM = fmt.formatCellValue(row.getCell(3));
//						String DEP_NM = fmt.formatCellValue(row.getCell(4));
//						String ING_YN = fmt.formatCellValue(row.getCell(5));
//						String ING_DT = fmt.formatCellValue(row.getCell(6));
						
						
						
						ERRCODE = ERRCODE_00000;
						break;
					}
					
				}
				
				if(ERRCODE_00000.equals(ERRCODE)){
					
//					DataObj output = new DataObj();
					output.put("status","success");
					output.put("gridData",val);
//					output = doFileSave(val);
					model.addAttribute("status", "success");
				    model.addAttribute("serviceMessage", "정상 처리되었습니다.");
				}
				
			} catch(RuntimeException e) {
				Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
				model.addAttribute("status", "fail");
				model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			} catch(Exception e) {
				Log.logAML(Log.ERROR,this,"doFileSave",e.toString());
				model.addAttribute("status", "fail");
			    model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");
			} finally {
				if((newFilePathName == null)== false) {
					newFilePathName = newFilePathName.replace("\\", "/");
				}
				File uploadFile = new File(newFilePathName);

				if(uploadFile != null){
					uploadFile.delete();
				}

				if (workbook != null) {
                   try {
					    workbook.close();
                   }catch (IOException e) {
                	   Log.logAML(Log.ERROR, this, "doFileSave(IOException)", e.toString());
   				   }
				}
				if (fis != null) {
                    try {
					fis.close();
                    }catch (IOException e) {
                    	Log.logAML(Log.ERROR, this, "doFileSave(IOException)", e.toString());
   				   }
				}

			}
			return "jsonView";
	}
	
	
		
}
