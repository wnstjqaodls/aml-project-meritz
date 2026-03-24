package com.gtone.aml.server.AML_10.AML_10_25.AML_10_25_02;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.aml.server.common.commonUtil;
import com.gtone.aml.user.SessionAML;
import com.gtone.aml.watchlist.core.utils.StringUtil;
import com.gtone.express.Constants;
import com.gtone.express.common.ParamUtil;
import com.gtone.express.domain.FileVO;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.express.util.FileUtil;
import com.itplus.common.server.user.SessionHelper;

import jspeed.base.util.DateHelper;
import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/**
 *<pre>
 * 상픔 위험평가  등록/결재
 *</pre>
 *@author  
 *@version 1.0
 *@history 1.0 2025-06 삼성증권 컨설팅 자료로 고도화   
 */

@Controller
public class AML_10_25_02_02 extends GetResultObject {

	private static AML_10_25_02_02 instance = null;

	/**
	 * getInstance
	 * @return AML_10_25_02_02
	 */
	public static AML_10_25_02_02 getInstance() {
		if ( instance == null ) {
			instance = new AML_10_25_02_02();
		}
		return instance;
	}

	/**
	 * <pre>
	 * 기본 정보 조회 
	 */
	public DataObj getSearch(DataObj input) {

		DataObj output = new DataObj();
		DataSet gdRes = null;

		String WINMSG = "";
		String ERRMSG = "";

		try {

			String prdEvltnId = StringHelper.evl( input.get("PRD_EVLTN_ID"), "" );


			if( StringHelper.isNull(prdEvltnId)  ){

				output = MDaoUtilSingle.getData("AML_10_25_02_02_getSearch_Evltn_PreInfo", input);

			}else {

				output = MDaoUtilSingle.getData("AML_10_25_02_02_getSearch_Evltn_ExstInfo", input);	
			}

			gdRes = Common.setGridData(output);

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", ERRMSG);
			output.put("WINMSG", WINMSG);
			output.put("gdRes", gdRes);

		} catch (Exception e) {

			Log.logAML(1, this, "getSearch(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}

	/**
	 * <pre>
	 * 위험평가 상세 정보 조회 
	 */
	public DataObj getSearchView(DataObj input) {

		DataObj output = new DataObj();
		DataSet gdRes = null;

		String WINMSG = "";
		String ERRMSG = "";

		try {

			output = MDaoUtilSingle.getData("AML_10_25_02_02_getSearch_View", input);	

			gdRes = Common.setGridData(output);

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", ERRMSG);
			output.put("WINMSG", WINMSG);
			output.put("gdRes", gdRes);

		} catch (Exception e) {

			Log.logAML(1, this, "getSearch(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}

	/**
	 * <pre>
	 * 기본 파일 정보 조회 
	 */
	public DataObj getSearchFiles(DataObj input) {

		DataObj output = new DataObj();
		DataSet gdRes = null;

		String WINMSG = "";
		String ERRMSG = "";

		try {

			output = MDaoUtilSingle.getData("AML_10_25_02_02_getSearch_Evltn_Attach", input);

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", ERRMSG);
			output.put("WINMSG", WINMSG);
			output.put("gdRes", gdRes);

		} catch (Exception e) {

			Log.logAML(1, this, "getSearchFiles(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}


	/**
	 * <pre>
	 * 상품 정보 저장
	 */
	@RequestMapping(value ="/prd/doPrdSave.do" , method = RequestMethod.POST)
	public String doSave(HttpServletRequest request, ModelMap model ,FileVO paramVO ) throws Exception {

		MDaoUtil mDao = null;
		int count = 0;
		String SPRD_CTGR_CD;
		String SPRD_TP_CD;
		HashMap input = new HashMap();

		try {

			SessionHelper helper = new SessionHelper(request.getSession());
			SessionAML sessionAML = (SessionAML) Class.forName(commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] {request});

			input = ParamUtil.getReqParamHashMap(request);

			mDao = new MDaoUtil();
			mDao.begin();
			
			String prdEvltnId = StringHelper.evl( input.get("PRD_EVLTN_ID"), "" );

			HashMap saveMap = new HashMap();
			saveMap.put("PRD_EVLTN_ID", prdEvltnId);
			saveMap.put("PRD_CK_ID", StringHelper.evl( input.get("PRD_CK_ID"), "" ) );
			saveMap.put("PRD_CTGR_CD", StringHelper.evl( input.get("PRD_CTGR_CD"), "" ) );
			saveMap.put("PRD_TP_CD", StringHelper.evl( input.get("PRD_TP_CD"), "" ) );
			saveMap.put("PRD_NM", StringHelper.trim(StringHelper.evl( input.get("PRD_NM"), "" ) ));
			saveMap.put("EVLTN_DEPT_ID", StringHelper.evl( input.get("EVLTN_DEPT_ID"), "" ) );
			saveMap.put("EVLTN_USER_ID", StringHelper.evl( input.get("EVLTN_USER_ID"), "" ) );
			saveMap.put("RLS_EXPCT_DT", StringHelper.evl( input.get("RLS_EXPCT_DT"), "" ) );
			saveMap.put("EVLTN_PRF_DT", StringHelper.evl( input.get("EVLTN_PRF_DT"), "" ) );
			saveMap.put("PRD_RMRK", StringHelper.trim(StringHelper.evl( input.get("PRD_RMRK"), "" )) );
			saveMap.put("SMRY_OPNN", StringHelper.trim(StringHelper.evl( input.get("SMRY_OPNN"), "" )) );
			saveMap.put("PRD_CD", StringHelper.evl( input.get("PRD_CD"), "" ) );
			saveMap.put("RSK_GRD", StringHelper.evl( input.get("RSK_GRD"), "" ) );
			saveMap.put("CNTRL_RVW_YN", StringHelper.evl( input.get("CNTRL_RVW_YN"), "" ) );
			saveMap.put("RSNB_EDD_YN", StringHelper.evl( input.get("RSNB_EDD_YN"), "" ) );
			saveMap.put("EVLTN_STATE", StringHelper.evl( input.get("EVLTN_STATE"), "" ) );
			saveMap.put("APP_NO", StringHelper.evl( input.get("APP_NO"), "" ) );
			saveMap.put("REG_ID", helper.getLoginId() );
			saveMap.put("UPD_ID", helper.getLoginId() );
			saveMap.put("RSK_SCR", StringHelper.evl( input.get("RSK_SCR"), "" ) );
			
			SPRD_CTGR_CD = StringHelper.evl( input.get("PRD_CTGR_CD"), "" );
			SPRD_TP_CD = StringHelper.evl( input.get("PRD_TP_CD"), "" );
			
			char firstPRD_CTGR_CD = SPRD_CTGR_CD.charAt(0);
			char firstPRD_TP_CD = SPRD_TP_CD.charAt(0);
			
			input.put("PRD_CTGR_CD", SPRD_CTGR_CD);
			input.put("PRD_TP_CD", SPRD_TP_CD);
			
			if( StringHelper.isNull(prdEvltnId)) {

				DataObj seqObj = MDaoUtilSingle.getData("AML_10_25_01_02_getNextPrdEvltnIdSeq", input );
				
				prdEvltnId = seqObj.getText("PRD_EVLTN_ID");
				
				//prdEvltnId = Character.toString(firstPRD_CTGR_CD) + Character.toString(firstPRD_TP_CD) + prdEvltnId;

				saveMap.put("PRD_EVLTN_ID", prdEvltnId);

				mDao.setData("AML_10_25_02_02_PRD_Evltn_Insert", saveMap);
			}else {
				mDao.setData("AML_10_25_02_02_PRD_Evltn_Update", saveMap);
				mDao.setData("AML_10_25_02_02_PRD_Evltn_LST_Delete", saveMap);
				
			}

			// 그리드 데이터 
			ObjectMapper objectMapper = new ObjectMapper();
			List<Map<String, Object>> gridList = objectMapper.readValue( StringUtil.evl(input.get("GRID_DATA"),""),new TypeReference<List<Map<String, Object>>>() {});

			for ( int i = 0; i < gridList.size(); i++ ) {

				HashMap gridMap = (HashMap) gridList.get(i);
				gridMap.put("PRD_EVLTN_ID", saveMap.get("PRD_EVLTN_ID"));
				gridMap.put("EVLTN_RSLT_RMRK", StringHelper.trim( StringHelper.evl(gridMap.get("EVLTN_RSLT_RMRK"),"")) );     

				count = mDao.setData("AML_10_25_02_02_PRD_Evltn_LST_Insert", gridMap);
			}

			// 파일처리 
			@SuppressWarnings("unused")
			int result = 0;

			input.put("PRD_EVLTN_ID", prdEvltnId);

			//기존 파일목록 
			DataObj fdo = MDaoUtilSingle.getData("AML_10_25_02_02_getSearch_Evltn_Attach",input);
			List<HashMap> fileList = fdo.getRowsToMap();

			// 파일 이동 및 처리
			if((null == paramVO.getFilePaths()) == false) {

				for(int i = 0; i < paramVO.getFilePaths().length; i++){

					if(paramVO.getFilePaths()[i].indexOf(Constants.COMMON_TEMP_FILE_UPLOAD_DIR) > -1){

						File tempDir = new File(paramVO.getFilePaths()[i]);				
						File tempFile = new File(tempDir, paramVO.getStoredFileNms()[i]);

						if(tempFile.isFile()){

							File realFile = FileUtil.renameTo(tempFile, Constants._UPLOAD_PRD_DIR);
							String[] filePath = paramVO.getFilePaths();
							filePath[i]	= StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"),Constants._UPLOAD_PRD_DIR,"");

							paramVO.setFilePath(filePath[i]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));

						}else{

							String[] filePath = paramVO.getFilePaths();
							filePath[i] = StringUtils.replace(filePath[i].replaceAll("\\\\", "/"), Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_PRD_DIR);

							paramVO.setFilePath(filePath[0]);
						}

					}else {							

						String[] filePath = paramVO.getFilePaths();
						filePath[i]	 = StringUtils.replace(filePath[i].replaceAll("\\\\", "/"), Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_PRD_DIR);

						paramVO.setFilePath(filePath[i]);
						paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
					}
				}

				//기존파일 목록 비교 후 삭제처리						
				for(int i=0; i < fileList.size(); i++){

					boolean btn = false;

					for(int k = 0; k < paramVO.getFilePaths().length; k++){

						String r = paramVO.getStoredFileNms()[k];			

						if(r.equals(fileList.get(i).get("PHSC_FILE_NM"))){

							btn = false;						
							break;

						}else{

							btn = true;
						}
					}

					//넘어온 값과 기존파일목에 존재하지 않으면 삭제
					if(btn){

						String filePath = Constants._UPLOAD_PRD_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath);
					}
				}					

				//db 파일 삭제
				mDao.setData("AML_10_25_02_02_delete_Evltn_Attach", input);					

				//파일일괄 인서트
				for(int i = 0; i < paramVO.getFilePaths().length; i++){

					DataObj obj1 = new DataObj();
					obj1.put("PRD_EVLTN_ID", prdEvltnId);
					obj1.put("ATTACH_SEQ", i+1);
					obj1.put("ATTACH_PATH", paramVO.getFilePath());
					obj1.put("ATTACH_NAME", paramVO.getOrigFileNms()[i]);
					obj1.put("ATTACH_TEMP_NAME", paramVO.getStoredFileNms()[i]);
					obj1.put("ATTACH_SIZE", paramVO.getFileSizes()[i]);

					result = mDao.setData("AML_10_25_02_02_insert_Evltn_Attach", obj1);
				}

			}else{

				for(int i=0; i < fileList.size(); i++){

					//기존 파일 삭제
					String filePath = Constants._UPLOAD_PRD_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
					FileUtil.deleteFile(filePath);
				}	

				//db 파일 삭제
				mDao.setData("AML_10_25_02_02_delete_Evltn_Attach", input);
			}

			if( count > 0 ) {

				mDao.commit();

			}else{

				mDao.rollback();
			}

			model.addAttribute("SAVE", saveMap);
			model.addAttribute("PRD_EVLTN_ID", prdEvltnId);
			model.addAttribute("status", "success");
			model.addAttribute("serviceMessage", "정상 처리되었습니다.");

		}catch(IOException ioe){

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", ee.getMessage());
			}

			Log.logAML(Log.ERROR,this,"doSave",ioe.toString()); 
			model.addAttribute("status", "fail");
			model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");

		}catch(AMLException e){

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", ee.getMessage());
			}

			Log.logAML(Log.ERROR,this,"doSave",e.toString()); 
			model.addAttribute("status", "fail");
			model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");

		}catch(Exception e){

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", ee.getMessage());
			}

			Log.logAML(Log.ERROR,this,"doSave",e.toString()); 
			model.addAttribute("status", "fail");
			model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");

		}finally {

			try{

				if( mDao != null ) {
					mDao.close();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doSave", ee.getMessage());
			}
		}

		return "jsonView";
	}

	// 위험평가 결재요청
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping(value ="/prd/doPrdApprReq.do" , method = RequestMethod.POST)
	public String doPrdApprReq(HttpServletRequest request, ModelMap model ,FileVO paramVO ) throws Exception {

		HashMap input = new HashMap();
		DataObj output = new DataObj();
		DataObj makeParamDobj = new DataObj();

		MDaoUtil mDao = null;

		int count = 0;
		String CUR_APP_NO = null;
		String CUR_SN_CCD = null;
		String CUR_SN_CCD2 = null;

		try {

			SessionHelper helper = new SessionHelper(request.getSession());
			SessionAML sessionAML = (SessionAML) Class.forName(commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] {request});

			input = ParamUtil.getReqParamHashMap(request);

			mDao = new MDaoUtil();
			mDao.begin();

			// save start ====================================================================== 
			String prdEvltnId = StringHelper.evl( input.get("PRD_EVLTN_ID"), "" );
			CUR_APP_NO = StringHelper.evl(input.get("APP_NO"), "");
			CUR_SN_CCD = StringHelper.evl(input.get("SN_CCD"), "");
			CUR_SN_CCD2 = StringHelper.evl(input.get("SN_CCD2"), "");

			HashMap saveMap = new HashMap();
			saveMap.put("PRD_EVLTN_ID", prdEvltnId);
			saveMap.put("PRD_CK_ID", StringHelper.evl( input.get("PRD_CK_ID"), "" ) );
			saveMap.put("PRD_CTGR_CD", StringHelper.evl( input.get("PRD_CTGR_CD"), "" ) );
			saveMap.put("PRD_TP_CD", StringHelper.evl( input.get("PRD_TP_CD"), "" ) );
			saveMap.put("PRD_NM", StringHelper.evl( input.get("PRD_NM"), "" ) );
			saveMap.put("EVLTN_DEPT_ID", StringHelper.evl( input.get("EVLTN_DEPT_ID"), "" ) );
			saveMap.put("EVLTN_USER_ID", StringHelper.evl( input.get("EVLTN_USER_ID"), "" ) );
			saveMap.put("RLS_EXPCT_DT", StringHelper.evl( input.get("RLS_EXPCT_DT"), "" ) );
			saveMap.put("EVLTN_PRF_DT", StringHelper.evl( input.get("EVLTN_PRF_DT"), "" ) );
			saveMap.put("PRD_RMRK", StringHelper.evl( input.get("PRD_RMRK"), "" ) );
			saveMap.put("SMRY_OPNN", StringHelper.evl( input.get("SMRY_OPNN"), "" ) );
			saveMap.put("PRD_CD", StringHelper.evl( input.get("PRD_CD"), "" ) );
			saveMap.put("RSK_GRD", StringHelper.evl( input.get("RSK_GRD"), "" ) );
			saveMap.put("CNTRL_RVW_YN", StringHelper.evl( input.get("CNTRL_RVW_YN"), "" ) );
			saveMap.put("RSNB_EDD_YN", StringHelper.evl( input.get("RSNB_EDD_YN"), "" ) );
			saveMap.put("EVLTN_STATE", StringHelper.evl( input.get("EVLTN_STATE"), "" ) );
			saveMap.put("APP_NO", StringHelper.evl( input.get("APP_NO"), "" ) );
			saveMap.put("REG_ID", helper.getLoginId() );
			saveMap.put("UPD_ID", helper.getLoginId() );
			saveMap.put("RSK_SCR", StringHelper.evl( input.get("RSK_SCR"), "" ) );

			if( StringHelper.isNull(prdEvltnId) ) {

				DataObj seqObj = MDaoUtilSingle.getData("AML_10_25_01_02_getNextPrdEvltnIdSeq", input );
				prdEvltnId = seqObj.getText("PRD_EVLTN_ID");

				saveMap.put("PRD_EVLTN_ID", prdEvltnId);

				mDao.setData("AML_10_25_02_02_PRD_Evltn_Insert", saveMap);

			}else {

				mDao.setData("AML_10_25_02_02_PRD_Evltn_Update", saveMap);
				mDao.setData("AML_10_25_02_02_PRD_Evltn_LST_Delete", saveMap);
			}

			// 그리드 데이터 
			ObjectMapper objectMapper = new ObjectMapper();
			List<Map<String, Object>> gridList = objectMapper.readValue( StringUtil.evl(input.get("GRID_DATA"),""),new TypeReference<List<Map<String, Object>>>() {});

			for ( int i = 0; i < gridList.size(); i++ ) {

				HashMap gridMap = (HashMap) gridList.get(i);
				gridMap.put("PRD_EVLTN_ID", saveMap.get("PRD_EVLTN_ID"));

				count = mDao.setData("AML_10_25_02_02_PRD_Evltn_LST_Insert", gridMap);
			}

			// 파일처리 
			@SuppressWarnings("unused")
			int result = 0;

			input.put("PRD_EVLTN_ID", prdEvltnId);

			//기존 파일목록 
			DataObj fdo = MDaoUtilSingle.getData("AML_10_25_02_02_getSearch_Evltn_Attach",input);
			List<HashMap> fileList = fdo.getRowsToMap();

			// 파일 이동 및 처리
			if((null == paramVO.getFilePaths()) == false) {

				for(int i = 0; i < paramVO.getFilePaths().length; i++){

					if(paramVO.getFilePaths()[i].indexOf(Constants.COMMON_TEMP_FILE_UPLOAD_DIR) > -1){

						File tempDir = new File(paramVO.getFilePaths()[i]);				
						File tempFile = new File(tempDir, paramVO.getStoredFileNms()[i]);

						if(tempFile.isFile()){

							File realFile = FileUtil.renameTo(tempFile, Constants._UPLOAD_PRD_DIR);
							String[] filePath = paramVO.getFilePaths();
							filePath[i]	= StringUtils.replace(realFile.getParent().replaceAll("\\\\", "/"),Constants._UPLOAD_PRD_DIR,"");

							paramVO.setFilePath(filePath[i]);
							paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));

						}else{

							String[] filePath = paramVO.getFilePaths();
							filePath[i] = StringUtils.replace(filePath[i].replaceAll("\\\\", "/"), Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_PRD_DIR);

							paramVO.setFilePath(filePath[0]);
						}

					}else {							

						String[] filePath = paramVO.getFilePaths();
						filePath[i]	 = StringUtils.replace(filePath[i].replaceAll("\\\\", "/"), Constants.COMMON_TEMP_FILE_UPLOAD_DIR, Constants._UPLOAD_PRD_DIR);

						paramVO.setFilePath(filePath[i]);
						paramVO.setFilePath(paramVO.getFilePath().replaceAll("\\\\", "/"));
					}
				}

				//기존파일 목록 비교 후 삭제처리						
				for(int i=0; i < fileList.size(); i++){

					boolean btn = false;

					for(int k = 0; k < paramVO.getFilePaths().length; k++){

						String r = paramVO.getStoredFileNms()[k];			

						if(r.equals(fileList.get(i).get("PHSC_FILE_NM"))){

							btn = false;						
							break;

						}else{

							btn = true;
						}
					}

					//넘어온 값과 기존파일목에 존재하지 않으면 삭제
					if(btn){

						String filePath = Constants._UPLOAD_PRD_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
						FileUtil.deleteFile(filePath);
					}
				}					

				//db 파일 삭제
				mDao.setData("AML_10_25_02_02_delete_Evltn_Attach", input);					

				//파일일괄 인서트
				for(int i = 0; i < paramVO.getFilePaths().length; i++){

					DataObj obj1 = new DataObj();
					obj1.put("PRD_EVLTN_ID", prdEvltnId);
					obj1.put("ATTACH_SEQ", i+1);
					obj1.put("ATTACH_PATH", paramVO.getFilePath());
					obj1.put("ATTACH_NAME", paramVO.getOrigFileNms()[i]);
					obj1.put("ATTACH_TEMP_NAME", paramVO.getStoredFileNms()[i]);
					obj1.put("ATTACH_SIZE", paramVO.getFileSizes()[i]);

					result = mDao.setData("AML_10_25_02_02_insert_Evltn_Attach", obj1);
				}

			}else{

				for(int i=0; i < fileList.size(); i++){

					//기존 파일 삭제
					String filePath = Constants._UPLOAD_PRD_DIR+fileList.get(i).get("FILE_POS")+File.separator+fileList.get(i).get("PHSC_FILE_NM");
					FileUtil.deleteFile(filePath);
				}	

				//db 파일 삭제
				mDao.setData("AML_10_25_02_02_delete_Evltn_Attach", input);
			}

			// save end ====================================================================== 


			// appr start ====================================================================== 

			String gylj_linegc;
			gylj_linegc = StringHelper.evl(input.get("gylj_linegc"), "");
			
			DataObj paramDobj = new DataObj();
			paramDobj.put("GYLJ_LINE_G_C", gylj_linegc);
			paramDobj.put("WLR_SQ", 0); 
			paramDobj.put("APPR_ROLE_ID", sessionAML.getsAML_ROLE_ID() );
			paramDobj.put("BRN_CD", sessionAML.getsAML_BDPT_CD() );
			paramDobj.put("HNDL_P_ENO", helper.getUserId() );
			paramDobj.put("FIRST_SNO", StringHelper.evl(input.get("FIRST_SNO"), "") );
			paramDobj.put("RSN_CNTNT", StringHelper.evl(input.get("RSN_CNTNT"), "") );
			paramDobj.put("SN_CCD", StringHelper.evl(input.get("SN_CCD"), "") );
			
			if ("R".equals(CUR_SN_CCD2) || !StringHelper.isNull(CUR_APP_NO)) {  
				paramDobj.put("APP_NO", CUR_APP_NO );
			}else{

				output = MDaoUtilSingle.getData("AML_10_25_01_02_get_PRD_APP_NO", paramDobj );
				paramDobj.put( "APP_NO", StringHelper.evl(output.get("APP_NO"), "") );
			}

			makeParamDobj = MDaoUtilSingle.getData("get_APP_MAKE_PARAM", paramDobj);
			mDao.setData("AML_10_17_01_01_AmlAppr_Merge", makeParamDobj);  // AML_APPR : 결재
			mDao.setData("AML_10_17_01_01_AmlApprHist_Insert", makeParamDobj);	//AML_APPR_HIST : 결재이력

			saveMap.put("APP_NO", paramDobj.get("APP_NO") );
			count = mDao.setData("AML_10_25_02_02_PRD_Evltn_Appr_Update", saveMap);

			// appr end  ====================================================================== 

			if( count > 0 ) {

				mDao.commit();

			}else{

				mDao.rollback();
			}

			model.addAttribute("PRD_EVLTN_ID", prdEvltnId);
			model.addAttribute("status", "success");
			model.addAttribute("serviceMessage", "정상 처리되었습니다.");

		}catch(IOException ioe){

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doPrdApprReq", ee.getMessage());
			}

			Log.logAML(Log.ERROR,this,"doPrdApprReq",ioe.toString()); 
			model.addAttribute("status", "fail");
			model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");

		}catch(AMLException e){

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doPrdApprReq", ee.getMessage());
			}

			Log.logAML(Log.ERROR,this,"doPrdApprReq",e.toString()); 
			model.addAttribute("status", "fail");
			model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");

		}catch(Exception e){

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doPrdApprReq", ee.getMessage());
			}

			Log.logAML(Log.ERROR,this,"doPrdApprReq",e.toString()); 
			model.addAttribute("status", "fail");
			model.addAttribute("serviceMessage", "처리 중 오류가 발생되었습니다.");

		}finally {

			try{

				if( mDao != null ) {
					mDao.close();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "doPrdApprReq", ee.getMessage());
			}
		}

		return "jsonView";
	}


	// 위험평가 결재/반려 
	@SuppressWarnings({"rawtypes", "unchecked"})
	public DataObj ddPrdAppr(DataObj input) {

		DataObj output = new DataObj();
		DataObj makeParamDobj = new DataObj();

		MDaoUtil mDao = null;

		int count = 0;
		
		try {
			
			SessionAML sessAML = (SessionAML)input.get("SessionAML");

			mDao = new MDaoUtil();
			mDao.begin();

			String gylj_linegc;
			gylj_linegc = StringHelper.evl(input.get("gylj_linegc"), "");
			DataObj paramDobj = new DataObj();
			paramDobj.put("GYLJ_LINE_G_C", gylj_linegc);
			paramDobj.put("WLR_SQ", 0); 
			paramDobj.put("APP_NO", StringHelper.evl(input.get("APP_NO"), "") );
			paramDobj.put("APPR_ROLE_ID", ((SessionAML)input.get("SessionAML")).getsAML_ROLE_ID() );
			paramDobj.put("BRN_CD", ((SessionAML)input.get("SessionAML")).getsAML_BDPT_CD() );
			paramDobj.put("HNDL_P_ENO", ((SessionHelper)input.get("SessionHelper")).getUserId() );
			paramDobj.put("SN_CCD", StringHelper.evl(input.get("SN_CCD"), "") );
			paramDobj.put("FIRST_SNO", StringHelper.evl(input.get("FIRST_SNO"), "") );
			paramDobj.put("RSN_CNTNT", StringHelper.evl(input.get("RSN_CNTNT"), "") );

			makeParamDobj = MDaoUtilSingle.getData("get_APP_MAKE_PARAM", paramDobj);
			count = mDao.setData("AML_10_17_01_01_AmlAppr_Merge", makeParamDobj);  // AML_APPR : 결재
			mDao.setData("AML_10_17_01_01_AmlApprHist_Insert", makeParamDobj);	//AML_APPR_HIST : 결재이력

			paramDobj.put("PRD_EVLTN_ID", StringHelper.evl(input.get("PRD_EVLTN_ID"), "") );
			paramDobj.put("EVLTN_STATE", StringHelper.evl(input.get("EVLTN_STATE"), "") );
			paramDobj.put("UPD_ID", sessAML.getsAML_LOGIN_ID() );
			mDao.setData("AML_10_25_02_02_PRD_Evltn_Appr_Update", paramDobj);

			// 최종 승인 시 처리
			if( "E".equals( StringHelper.evl(input.get("SN_CCD"), "") ) ) {   
				
				
				
			}

			if( count > 0 ) {

				mDao.commit();

				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));

			}else{

				mDao.rollback();

				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다."));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0003", input.getText("LANG_CD"), "처리할 데이터가 없습니다."));
			}

		}catch(Exception e) {

			try{

				if( mDao != null ) {
					mDao.rollback();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "ddPrdAppr", e.getMessage());
			}

			Log.logAML(1, this, "ddPrdAppr(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));

		}finally{

			try{

				if( mDao != null ) {
					mDao.close();
				}

			}catch (Exception ee) {
				Log.logAML(Log.ERROR, this, "ddPrdAppr", ee.getMessage());
			}
		}

		return output;
	}

	public DataObj doExportPrdEvltn(DataObj input) {

		DataObj output = new DataObj();
		DataObj attachList = new DataObj();
		DataSet gdRes = null;
		String resultFileName = "";

		try {

			output = MDaoUtilSingle.getData("AML_10_25_02_02_getSearch_View", input);	
			attachList = MDaoUtilSingle.getData("AML_10_25_02_02_getSearch_Evltn_Attach", input);
			
			List<HashMap> prdEvltn = output.getRowsToMap();
			List<HashMap> prdAttach = attachList.getRowsToMap();
			
			resultFileName = doExportExcel(prdEvltn, prdAttach);

			HashMap resultMap = new HashMap();
			resultMap.put("fileName", resultFileName);

			output.put("gdParam", resultMap);
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리 되었습니다."));

		} catch (Exception e) {

			Log.logAML(1, this, "getSearch(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
			output.put("gdParam", null);
		}

		return output;
	}

	@SuppressWarnings({ "rawtypes", "deprecation" })
	public String doExportExcel(List<HashMap> dataSource, List<HashMap> prdAttach) throws Exception {

		FileOutputStream fos = null;
		String result = null;

		Workbook xworkbook = null; //엑셀파일 객체 생성
		SXSSFSheet xSheet = null; //시트 객체 생성
		Row xRow = null; //행 객체 생성
		Cell xCell = null; //열 객체 생성

		try {

			String file_name = "위험평가_" + DateHelper.currentTime("yyyyMMddHHmmss");
			String file_path = Constants.COMMON_TEMP_FILE_UPLOAD_DIR;

			if(file_path.contains("\\")) {
				file_path = file_path.replace("\\", "/");
			}

			String path = file_path.replace("/", System.getProperty("file.separator"));

			StringBuffer FullBuf = new StringBuffer(path.length() + file_name.length() + 7);
			FullBuf.append(path);
			FullBuf.append(file_name);
			FullBuf.append(".xlsx");

			String Full = FullBuf.toString();
			if(Full.contains("\\")) {
				Full = Full.replace("\\", "/");
			}

			File existfile = new File(Full);
			if(existfile.exists()) { //기생성 파일 존재시 삭제
				existfile.delete();
				existfile = null;
			}

			File emptyfile = new File(Full); //새로운 빈파일객체 재생성
			fos = new FileOutputStream(emptyfile); //파일 outputstream 생성

			//============================================================================================

			int rowCnt = 0;
			HashMap rowMap = new HashMap();

			int ckCnt01 = 0; // 당연고위험상품 배점
			int ckCnt02 = 0; // 고객위험 배점
			int ckCnt03 = 0; // 상품위험 배점
			int ckCnt04 = 0; // 채널위험 배점
			int ckCnt05 = 0; // 업무절차 배점
			int ckCnt06 = 0; // 전상통제 배점

			int ckScore01 = 0; // 당연고위험상품 위험점수
			int ckScore02 = 0; // 고객위험 위험점수
			int ckScore03 = 0; // 상품위험 위험점수
			int ckScore04 = 0; // 채널위험 위험점수
			int ckScore05 = 0; // 업무절차 위험점수
			int ckScore06 = 0; // 전상통제 위험점수

			boolean rsnbHrskRlvnYn = false;


			xworkbook = new SXSSFWorkbook();  //엑셀파일 생성
			xSheet = (SXSSFSheet) xworkbook.createSheet(file_name); //시트 생성
			xRow = xSheet.createRow(rowCnt);

			// 타이틀 ============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 700);
			xCell = xRow.createCell(0);

			// 타이틀 폰트
			Font titleFont = xworkbook.createFont();
			titleFont.setFontHeightInPoints((short) 26);
			titleFont.setBold(true);
			titleFont.setUnderline(Font.U_SINGLE);

			// 타이틀 스타일
			CellStyle  titleStyle = xworkbook.createCellStyle();
			titleStyle.setAlignment(HorizontalAlignment.CENTER);
			titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
			titleStyle.setFont(titleFont);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(titleStyle);
				xCell.setCellValue("신상품·서비스 AML 위험평가 체크리스트 ");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			// 타이틀 ============================================================================================

			rowCnt++;
			xRow = xSheet.createRow(rowCnt);

			// 1. 신상품·서비스 개요  ============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 700);
			xCell = xRow.createCell(0);

			// 1. 신상품·서비스 개요 라벨  폰트
			Font title01Font = xworkbook.createFont();
			title01Font.setFontHeightInPoints((short) 14);
			title01Font.setBold(true);

			// 1. 신상품·서비스 개요 라벨 스타일
			XSSFCellStyle  title01Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title01Style.setFont(title01Font);
			title01Style.setAlignment(HorizontalAlignment.LEFT);
			title01Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title01Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(242, 220, 219), null));
			title01Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title01Style.setBorderTop(BorderStyle.THIN);
			title01Style.setBorderBottom(BorderStyle.THIN);
			title01Style.setBorderLeft(BorderStyle.THIN);
			title01Style.setBorderRight(BorderStyle.THIN);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title01Style);
				xCell.setCellValue("1. 신상품·서비스 개요");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			// 1-1. 기본정보 라벨 폰트
			Font title0101Font = xworkbook.createFont();
			title0101Font.setFontHeightInPoints((short) 11);
			title0101Font.setBold(true);

			// 1-1. 기본정보 라벨 스타일
			XSSFCellStyle  title0101Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title0101Style.setFont(title0101Font);
			title0101Style.setAlignment(HorizontalAlignment.LEFT);
			title0101Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title0101Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(217, 217, 217), null));
			title0101Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title0101Style.setBorderTop(BorderStyle.THIN);
			title0101Style.setBorderBottom(BorderStyle.THIN);
			title0101Style.setBorderLeft(BorderStyle.THIN);
			title0101Style.setBorderRight(BorderStyle.THIN);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("1-1. 기본정보");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 500);
			xCell = xRow.createCell(0);

			// 상품·서비스명 라벨
			// 상품·서비스명 라벨 스타일
			XSSFCellStyle  title010101Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title010101Style.setFont(title0101Font);
			title010101Style.setAlignment(HorizontalAlignment.CENTER);
			title010101Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title010101Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(242, 242, 242), null));
			title010101Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title010101Style.setBorderTop(BorderStyle.THIN);
			title010101Style.setBorderBottom(BorderStyle.THIN);
			title010101Style.setBorderLeft(BorderStyle.THIN);
			title010101Style.setBorderRight(BorderStyle.THIN);
			title010101Style.setWrapText(true);

			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("상품·서비스명");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,2));

			//============================================================================================
			// 상품·서비스명 값
			// 상품·서비스명 값 폰트
			Font title010101Font = xworkbook.createFont();
			title010101Font.setFontHeightInPoints((short) 11);
			title010101Font.setFontName("맑은 고딕");

			// 상품·서비스명 값 스타일
			XSSFCellStyle  title010101_val_Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title010101_val_Style.setFont(title010101Font);
			title010101_val_Style.setAlignment(HorizontalAlignment.CENTER);
			title010101_val_Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title010101_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 255, 255), null));
			title010101_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title010101_val_Style.setBorderTop(BorderStyle.THIN);
			title010101_val_Style.setBorderBottom(BorderStyle.THIN);
			title010101_val_Style.setBorderLeft(BorderStyle.THIN);
			title010101_val_Style.setBorderRight(BorderStyle.THIN);


			for(int i = 3; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue( StringHelper.evl( dataSource.get(0).get("PRD_NM"), "")  );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,8));

			//============================================================================================
			// 상품코드 라벨
			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("상품코드");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,9,10));

			//============================================================================================
			// 상품코드  값
			// 상품코드  값 폰트
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue( StringHelper.evl( dataSource.get(0).get("PRD_CD"), "") );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,11,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 500);
			xCell = xRow.createCell(0);

			// 상품·서비스 기획부서명 라벨
			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("상품·서비스  기획부서명");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,2));

			//============================================================================================
			// 상품·서비스 기획부서명  값
			for(int i = 3; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue( StringHelper.evl( dataSource.get(0).get("EVLTN_DEPT_NM"), "") );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,8));

			//============================================================================================
			// 담당자 라벨
			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("담당자");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,9,10));

			//============================================================================================
			// 담당자  값
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue( StringHelper.evl( dataSource.get(0).get("EVLTN_USER_NM"), "") );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,11,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 500);
			xCell = xRow.createCell(0);

			// 출시예정일자라벨
			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("출시예정일자");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,2));

			//============================================================================================
			// 출시예정일자  값
			for(int i = 3; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue( StringHelper.evl( dataSource.get(0).get("RLS_EXPCT_DT"), "") );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,8));

			//============================================================================================
			// 위험평가 수행일자 라벨
			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("위험평가 수행일자");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,9,10));

			//============================================================================================
			// 위험평가 수행일자  값
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue( StringHelper.evl( dataSource.get(0).get("EVLTN_PRF_DT"), "") );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,11,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 500);
			xCell = xRow.createCell(0);

			// 상품·서비스 개요 라벨
			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("상품·서비스 개요");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,2));
			
			//============================================================================================
			// 상품·서비스 개요  값
			for(int i = 3; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue( StringHelper.evl( dataSource.get(0).get("PRD_RMRK"), "") );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,17));
			
			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 900);
			xCell = xRow.createCell(0);

			// 상품·서비스 관련  증빙 자료 첨부 라벨
			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("상품·서비스 관련  증빙 자료 첨부");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,2));

			//============================================================================================
			
            String attchList = "";
			for(int i = 0; i < prdAttach.size() ; i++) {

				rowMap = (HashMap)prdAttach.get(i);

				attchList +=  StringHelper.evl( rowMap.get("LOSC_FILE_NM"), "" ) + "\r\n";
			}
			
			// 상품·서비스 관련  증빙 자료 첨부  값
			for(int i = 3; i <= 13; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue(attchList);
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,13));

			//============================================================================================
			// 첨부여부 라벨
			for(int i = 14; i <= 15; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("첨부여부");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));

			//============================================================================================
			// 첨부여부  값
			String attchYn = "N";
			if( prdAttach.size() > 0 ) {
				attchYn = "Y";
			}
			
			for(int i = 16; i <= 17; i++) {

				xCell = xRow.createCell(i);
				title010101_val_Style.setAlignment(HorizontalAlignment.CENTER);
				xCell.setCellStyle(title010101_val_Style);
				xCell.setCellValue(attchYn);
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			// 1-2. 절차/시스템의 변경여부  라벨
			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("1-2. 절차/시스템의 변경여부");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			xCell = xRow.createCell(1);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("구분");

			xCell = xRow.createCell(2);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("No.");

			for(int i = 3; i <= 9; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가항목");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));

			for(int i = 10; i <= 13; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가기준");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));

			for(int i = 14; i <= 15; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("답변");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));

			for(int i = 16; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("비고");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));

			//============================================================================================

			XSSFCellStyle  title010102_val_Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title010102_val_Style.setFont(title010101Font);
			title010102_val_Style.setAlignment(HorizontalAlignment.LEFT);
			title010102_val_Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title010102_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 255, 255), null));
			title010102_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title010102_val_Style.setBorderTop(BorderStyle.THIN);
			title010102_val_Style.setBorderBottom(BorderStyle.THIN);
			title010102_val_Style.setBorderLeft(BorderStyle.THIN);
			title010102_val_Style.setBorderRight(BorderStyle.THIN);
			title010102_val_Style.setWrapText(true);

			XSSFCellStyle  title010103_val_Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title010103_val_Style.setFont(title010101Font);
			title010103_val_Style.setAlignment(HorizontalAlignment.CENTER);
			title010103_val_Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title010103_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(242, 242, 242), null));
			title010103_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title010103_val_Style.setBorderTop(BorderStyle.THIN);
			title010103_val_Style.setBorderBottom(BorderStyle.THIN);
			title010103_val_Style.setBorderLeft(BorderStyle.THIN);
			title010103_val_Style.setBorderRight(BorderStyle.THIN);

			for(int i = 0; i < dataSource.size() ; i++) {

				rowMap = (HashMap)dataSource.get(i);

				if( "1".equals( rowMap.get("GR")) ) {

					rowCnt++;
					xRow = xSheet.createRow(rowCnt);
					xRow.setHeight((short) 800);
					xCell = xRow.createCell(0);

					for( int j = 1;  j <= 17 ; j++) {

						xCell = xRow.createCell(j);

						if( j == 1 || j == 2 ) {

							xCell.setCellStyle(title010101Style);

							if( j == 1 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("RISK_TP_CD_NM"), "" ) );

							}else if( j == 2 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("LV3"), "" ) );
							}

						}else{

							xCell.setCellStyle(title010102_val_Style);

							if( j >= 3 && j <= 9 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_ITEM"), "" ) );

							}else if( j >= 10 && j <= 13 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_STND"), "" ) );

							}else if( j >= 14 && j <= 15 ) {

								xCell.setCellStyle(title010103_val_Style);
								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ) );

							}else if( j >= 16 && j<= 17 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RMRK"), "" ) );
							}

						}
					}

					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));	
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));
				}
			}

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);

			// 2. 상품 고유위험평가 - 상품·서비스 개발부서 작성  ============================================================================================

			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 700);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title01Style);
				xCell.setCellValue("2. 상품 고유위험평가 - 상품·서비스 개발부서 작성");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("2-1. 당연고위험 상품 해당여부");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));


			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			xCell = xRow.createCell(1);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("위험구분");

			xCell = xRow.createCell(2);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("No.");

			for(int i = 3; i <= 9; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가항목");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));

			for(int i = 10; i <= 13; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가기준");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));

			for(int i = 14; i <= 15; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("답변");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));

			for(int i = 16; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("비고");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));

			//============================================================================================

			for(int i = 0; i < dataSource.size() ; i++) {

				rowMap = (HashMap)dataSource.get(i);

				if( "2".equals( rowMap.get("GR")) ) {

					ckCnt01++;
					rowCnt++;
					xRow = xSheet.createRow(rowCnt);
					xRow.setHeight((short) 800);
					xCell = xRow.createCell(0);

					if( "Y".equals(StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ))  ) {

						ckScore01++;
						rsnbHrskRlvnYn = true;
					}
					
					for( int j = 1;  j <= 17 ; j++) {

						xCell = xRow.createCell(j);

						if( j == 1 || j == 2 ) {

							xCell.setCellStyle(title010101Style);

							if( j == 1 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("RISK_TP_CD_NM"), "" ) );

							}else if( j == 2 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("LV3"), "" ) );
							}

						}else{

							xCell.setCellStyle(title010102_val_Style);

							if( j >= 3 && j <= 9 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_ITEM"), "" ) );

							}else if( j >= 10 && j <= 13 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_STND"), "" ) );

							}else if( j >= 14 && j <= 15 ) {

								xCell.setCellStyle(title010103_val_Style);
								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ) );

							}else if( j >= 16 && j<= 17 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RMRK"), "" ) );
							}

						}
					}

					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));	
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));
				}
			}

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("2-2. 고객위험 (상품을 이용할 고객에 대한 위험평가)");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));


			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			xCell = xRow.createCell(1);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("위험구분");

			xCell = xRow.createCell(2);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("No.");

			for(int i = 3; i <= 9; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가항목");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));

			for(int i = 10; i <= 13; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가기준");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));

			for(int i = 14; i <= 15; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("답변");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));

			for(int i = 16; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("비고");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));

			//============================================================================================

			for(int i = 0; i < dataSource.size() ; i++) {

				rowMap = (HashMap)dataSource.get(i);

				if( "3".equals( rowMap.get("GR")) ) {

					ckCnt02++;
					rowCnt++;
					xRow = xSheet.createRow(rowCnt);
					xRow.setHeight((short) 800);
					xCell = xRow.createCell(0);

					if( "Y".equals(StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ))  ) {

						ckScore02++;
					}
					
					for( int j = 1;  j <= 17 ; j++) {

						xCell = xRow.createCell(j);

						if( j == 1 || j == 2 ) {

							xCell.setCellStyle(title010101Style);

							if( j == 1 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("RISK_TP_CD_NM"), "" ) );

							}else if( j == 2 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("LV3"), "" ) );
							}

						}else{

							xCell.setCellStyle(title010102_val_Style);

							if( j >= 3 && j <= 9 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_ITEM"), "" ) );

							}else if( j >= 10 && j <= 13 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_STND"), "" ) );

							}else if( j >= 14 && j <= 15 ) {

								xCell.setCellStyle(title010103_val_Style);
								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ) );

							}else if( j >= 16 && j<= 17 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RMRK"), "" ) );
							}

						}
					}

					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));	
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));
				}
			}

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("2-3. 상품위험 (상품 특성에 내재된 자금세탁위험에 대한 위험평가)");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));


			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			xCell = xRow.createCell(1);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("위험구분");

			xCell = xRow.createCell(2);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("No.");

			for(int i = 3; i <= 9; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가항목");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));

			for(int i = 10; i <= 13; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가기준");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));

			for(int i = 14; i <= 15; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("답변");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));

			for(int i = 16; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("비고");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));

			//============================================================================================

			for(int i = 0; i < dataSource.size() ; i++) {

				rowMap = (HashMap)dataSource.get(i);

				if( "4".equals( rowMap.get("GR")) ) {

					ckCnt03++;
					rowCnt++;
					xRow = xSheet.createRow(rowCnt);
					xRow.setHeight((short) 800);
					xCell = xRow.createCell(0);

					if( "Y".equals(StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ))  ) {

						ckScore03++;
					}
					
					for( int j = 1;  j <= 17 ; j++) {

						xCell = xRow.createCell(j);

						if( j == 1 || j == 2 ) {

							xCell.setCellStyle(title010101Style);

							if( j == 1 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("RISK_TP_CD_NM"), "" ) );

							}else if( j == 2 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("LV3"), "" ) );
							}

						}else{

							xCell.setCellStyle(title010102_val_Style);

							if( j >= 3 && j <= 9 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_ITEM"), "" ) );

							}else if( j >= 10 && j <= 13 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_STND"), "" ) );

							}else if( j >= 14 && j <= 15 ) {

								xCell.setCellStyle(title010103_val_Style);
								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ) );

							}else if( j >= 16 && j<= 17 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RMRK"), "" ) );
							}

						}
					}

					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));	
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));
				}
			}

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("2-4. 채널위험 (채널 특성에 내재된 자금세탁위험에 대한 위험평가)");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));


			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			xCell = xRow.createCell(1);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("위험구분");

			xCell = xRow.createCell(2);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("No.");

			for(int i = 3; i <= 9; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가항목");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));

			for(int i = 10; i <= 13; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가기준");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));

			for(int i = 14; i <= 15; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("답변");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));

			for(int i = 16; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("비고");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));

			//============================================================================================

			for(int i = 0; i < dataSource.size() ; i++) {

				rowMap = (HashMap)dataSource.get(i);

				if( "5".equals( rowMap.get("GR")) ) {

					ckCnt04++;
					rowCnt++;
					xRow = xSheet.createRow(rowCnt);
					xRow.setHeight((short) 800);
					xCell = xRow.createCell(0);

					if( "Y".equals(StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ))  ) {

						ckScore04++;
					}
					
					for( int j = 1;  j <= 17 ; j++) {

						xCell = xRow.createCell(j);

						if( j == 1 || j == 2 ) {

							xCell.setCellStyle(title010101Style);

							if( j == 1 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("RISK_TP_CD_NM"), "" ) );

							}else if( j == 2 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("LV3"), "" ) );
							}

						}else{

							xCell.setCellStyle(title010102_val_Style);

							if( j >= 3 && j <= 9 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_ITEM"), "" ) );

							}else if( j >= 10 && j <= 13 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_STND"), "" ) );

							}else if( j >= 14 && j <= 15 ) {

								xCell.setCellStyle(title010103_val_Style);
								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ) );

							}else if( j >= 16 && j<= 17 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RMRK"), "" ) );
							}

						}
					}

					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));	
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));
				}
			}


			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);

			// 3. 통제위험평가 - 컴플라이언스운영팀 작성  ============================================================================================

			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 700);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title01Style);
				xCell.setCellValue("3. 통제위험평가 - 컴플라이언스운영팀 작성");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("3-1 업무절차 및 전산통제의 적정성");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			xCell = xRow.createCell(1);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("위험구분");

			xCell = xRow.createCell(2);
			xCell.setCellStyle(title010101Style);
			xCell.setCellValue("No.");

			for(int i = 3; i <= 9; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가항목");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,9));

			for(int i = 10; i <= 13; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가기준");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,10,13));

			for(int i = 14; i <= 15; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("답변");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));

			for(int i = 16; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("비고");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));

			//============================================================================================

			for(int i = 0; i < dataSource.size() ; i++) {

				rowMap = (HashMap)dataSource.get(i);

				if( "6".equals( rowMap.get("GR")) ) {

					if( "10601".equals( StringHelper.evl( rowMap.get("RISK_TP_CD"), "" ) ) ) {

						ckCnt05++;

					}else if( "10602".equals( StringHelper.evl( rowMap.get("RISK_TP_CD"), "" ) ) ) {

						ckCnt06++;
					}

					rowCnt++;
					xRow = xSheet.createRow(rowCnt);
					xRow.setHeight((short) 800);
					xCell = xRow.createCell(0);

					if( "Y".equals(StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" )) ) {

						if( "10601".equals( StringHelper.evl( rowMap.get("RISK_TP_CD"), "" ) ) ) {

							ckScore05++;

						}else if( "10602".equals( StringHelper.evl( rowMap.get("RISK_TP_CD"), "" ) ) ) {

							ckScore06++;
						}
					}
					
					for( int j = 1;  j <= 17 ; j++) {

						xCell = xRow.createCell(j);

						if( j == 1 || j == 2 ) {

							xCell.setCellStyle(title010101Style);

							if( j == 1 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("RISK_TP_CD_NM"), "" ) );

							}else if( j == 2 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("LV3"), "" ) );
							}

						}else{

							xCell.setCellStyle(title010102_val_Style);

							if( j >= 3 && j <= 13 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_ITEM"), "" ) );

							}else if( j >= 14 && j <= 15 ) {

								xCell.setCellStyle(title010103_val_Style);
								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RSLT"), "" ) );
								
							}else if( j >= 16 && j<= 17 ) {

								xCell.setCellValue( StringHelper.evl( rowMap.get("EVLTN_RMRK"), "" ) );
							}

						}
					}

					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,13));
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,14,15));	
					xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,16,17));
				}
			}

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);

			// 4. 위험평가 결과 및 종합의견  ============================================================================================

			XSSFCellStyle  title010104_val_Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title010104_val_Style.setFont(title010101Font);
			title010104_val_Style.setAlignment(HorizontalAlignment.CENTER);
			title010104_val_Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title010104_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 255, 255), null));
			title010104_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title010104_val_Style.setBorderTop(BorderStyle.THIN);
			title010104_val_Style.setBorderBottom(BorderStyle.THIN);
			title010104_val_Style.setBorderLeft(BorderStyle.THIN);
			title010104_val_Style.setBorderRight(BorderStyle.THIN);
			title010104_val_Style.setWrapText(true);

			XSSFCellStyle  title010105_val_Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title010105_val_Style.setFont(title010101Font);
			title010105_val_Style.setAlignment(HorizontalAlignment.CENTER);
			title010105_val_Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title010105_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 255, 255), null));
			title010105_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title010105_val_Style.setBorderTop(BorderStyle.THIN);
			title010105_val_Style.setBorderBottom(BorderStyle.THIN);
			title010105_val_Style.setBorderLeft(BorderStyle.THIN);
			title010105_val_Style.setBorderRight(BorderStyle.THIN);
			title010105_val_Style.setWrapText(true);

			XSSFCellStyle  title010106_val_Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title010106_val_Style.setFont(title010101Font);
			title010106_val_Style.setAlignment(HorizontalAlignment.CENTER);
			title010106_val_Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title010106_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 255, 255), null));
			title010106_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title010106_val_Style.setBorderTop(BorderStyle.THIN);
			title010106_val_Style.setBorderBottom(BorderStyle.THIN);
			title010106_val_Style.setBorderLeft(BorderStyle.THIN);
			title010106_val_Style.setBorderRight(BorderStyle.THIN);
			title010106_val_Style.setWrapText(true);
			
			XSSFCellStyle  title010107_val_Style = (XSSFCellStyle) xworkbook.createCellStyle();
			title010107_val_Style.setFont(title010101Font);
			title010107_val_Style.setAlignment(HorizontalAlignment.CENTER);
			title010107_val_Style.setVerticalAlignment(VerticalAlignment.CENTER);
			title010107_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(239, 191, 191), null));
			title010107_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			title010107_val_Style.setBorderTop(BorderStyle.THIN);
			title010107_val_Style.setBorderBottom(BorderStyle.THIN);
			title010107_val_Style.setBorderLeft(BorderStyle.THIN);
			title010107_val_Style.setBorderRight(BorderStyle.THIN);
			title010107_val_Style.setWrapText(true);
			
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 700);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title01Style);
				xCell.setCellValue("4. 위험평가 결과 및 종합의견");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("4-1 위험평가 결과");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가구분");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,2));

			for(int i = 3; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("평가영역");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("배점");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("위험점수");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("위험평가 결과");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,9,10));

			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("위험수준 평가기준");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,11,17));

			//============================================================================================

			rowCnt++;

			int mergeCell01 = rowCnt;

			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("고유위험평가");
			}

			for(int i = 3; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("당연고위험상품");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckCnt01 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckScore01 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			int ckCntTotal = (ckCnt01 + ckCnt02 + ckCnt03 + ckCnt04);
			int ckScoreTotal = (ckScore01 + ckScore02 + ckScore03 + ckScore04);
			float rsltTotal = ((float)ckScoreTotal/ckCntTotal)*100;
			
			for(int i = 9; i <= 10; i++) {
				
				xCell = xRow.createCell(i);
				
				if( rsltTotal < 30 ){
					
					title010106_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(116, 200, 249), null));
					title010106_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
					xCell.setCellStyle(title010106_val_Style);
					xCell.setCellValue("저위험");
					
				}else if( rsltTotal >= 30 && rsltTotal < 60 ){
					
					title010106_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 193, 74), null));
					title010106_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
					xCell.setCellStyle(title010106_val_Style);
					xCell.setCellValue("중위험");
					
				}else{	
					
					title010106_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 115, 66), null));
					title010106_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
					xCell.setCellStyle(title010106_val_Style);
					xCell.setCellValue("고위험");
				}
				
				if( rsnbHrskRlvnYn ){
					
					title010106_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 115, 66), null));
					title010106_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
					xCell.setCellStyle(title010106_val_Style);
					xCell.setCellValue("고위험");
				}
			}

			String tempVal = "당연고위험 : 업무규정 등에서 정하는 고위험 상품에 해당하는 경우\n" + 
					"고위험 : 총점 대비 60% 이상\n" + 
					"중위험 : 총점 대비 30% 이상 ~ 60% 미만\n" + 
					"저위험 : 총점 대비 30% 미만";

			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				title010105_val_Style.setAlignment(HorizontalAlignment.LEFT);
				title010105_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 255, 255), null));
				title010105_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				xCell.setCellStyle(title010105_val_Style);
				xCell.setCellValue(tempVal);
			}

			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
			}
			
			for(int i = 3; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("고객위험");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckCnt02 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckScore02 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
			}
			
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010105_val_Style);
			}
			
			//============================================================================================

			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
			}
			
			for(int i = 3; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("상품위험");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckCnt03 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckScore03 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
			}
			
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010105_val_Style);
			}
			
			//============================================================================================

			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
			}
			
			for(int i = 3; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("채널위험");
				xCell.setCellStyle(title010101Style);
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckCnt04 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckScore04 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
			}
			
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010105_val_Style);
			}
			
			xSheet.addMergedRegion(new CellRangeAddress(mergeCell01,rowCnt,1,2));

			//============================================================================================

			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("합계");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckCnt01 + ckCnt02 + ckCnt03 + ckCnt04 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckScore01 + ckScore02 + ckScore03 + ckScore04 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
			}
			
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010105_val_Style);
			}
			
			xSheet.addMergedRegion(new CellRangeAddress(mergeCell01,rowCnt,9,10));
			xSheet.addMergedRegion(new CellRangeAddress(mergeCell01,rowCnt,11,17));

			
			//============================================================================================
			rowCnt++;

			int mergeCell02 = rowCnt;

			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("통제위험평가");
			}

			for(int i = 3; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("업무절차");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckCnt05 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckScore05 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
				
			    if( (ckScore05 + ckScore06) > 0 ) {

			    	xCell.setCellStyle(title010107_val_Style);
			    	xCell.setCellValue("통제 보완/추가 조치 필요");

			    	
			    }else {
			    	
			    	xCell.setCellStyle(title010105_val_Style);
			    	xCell.setCellValue("통제위험평가를 완료하세요.");
			    }
				
			}

			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				title010105_val_Style.setAlignment(HorizontalAlignment.LEFT);
				title010105_val_Style.setFillForegroundColor(new XSSFColor(new java.awt.Color(255, 255, 255), null));
				title010105_val_Style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
				xCell.setCellStyle(title010105_val_Style);
				xCell.setCellValue("미비사항 1개 이상 존재 시, 통제 보완/추가 조치 필요");
			}
			
			//============================================================================================

			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 2; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("");
			}
			
			for(int i = 3; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("전산통계");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,3,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckCnt06 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckScore06 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( "" );
			}
			
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010105_val_Style);
				xCell.setCellValue("");
			}
			
			xSheet.addMergedRegion(new CellRangeAddress(mergeCell02,rowCnt,1,2));
			
			//============================================================================================

			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("합계");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,4));

			for(int i = 5; i <= 6; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckCnt05 + ckCnt06 );
			}
			
			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,6));

			for(int i = 7; i <= 8; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( ckScore05 + ckScore06 );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,7,8));

			for(int i = 9; i <= 10; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010104_val_Style);
				xCell.setCellValue( "" );
			}
			
			for(int i = 11; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010105_val_Style);
				xCell.setCellValue("");
			}
			
			xSheet.addMergedRegion(new CellRangeAddress(mergeCell02,rowCnt,9,10));
			xSheet.addMergedRegion(new CellRangeAddress(mergeCell02,rowCnt,11,17));
			
			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 350);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 17; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title0101Style);
				xCell.setCellValue("4-2. 종합의견");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,17));
			
			//============================================================================================
			rowCnt++;
			xRow = xSheet.createRow(rowCnt);
			xRow.setHeight((short) 1400);
			xCell = xRow.createCell(0);

			for(int i = 1; i <= 4; i++) {

				xCell = xRow.createCell(i);
				xCell.setCellStyle(title010101Style);
				xCell.setCellValue("컴플라이언스운영팀 종합의견");
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,1,4));
			
			for(int i = 5; i <= 17; i++) {

				xCell = xRow.createCell(i);
				title010101_val_Style.setAlignment(HorizontalAlignment.LEFT);
				xCell.setCellStyle(title010105_val_Style);
				xCell.setCellValue( StringHelper.evl( dataSource.get(0).get("SMRY_OPNN"), "") );
			}

			xSheet.addMergedRegion(new CellRangeAddress(rowCnt,rowCnt,5,17));

			// 파일 쓰기
			xworkbook.write(fos);

			result =  file_name;

		} catch(Exception e1) {

			throw e1;

		} finally {

			try {

				if(fos != null) { fos.close();}
				if(xworkbook != null) { xworkbook.close();}

			} catch(Exception e) {
			}
		}

		return result;
	}
	
	/**위험요소관리 결재요청*/
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public DataObj AppRequest(DataObj input ) throws AMLException {
        DataObj output  = new DataObj();
        DataObj output2 = new DataObj();
        DataObj output3 = new DataObj();

        String ERRCODE = "";
        String ERRMSG  = "";
        String WINMSG  = "";

        String APP_NO = "";
        String evltnstate = "";
        String gyljlinegc = "";
        String prdevltnid = "";
        
        int count = 0;
        MDaoUtil db = null;

        try {

        	db = new MDaoUtil();
            db.begin();

			if(input.size() > 0) {
				HashMap amlApprMap = new HashMap();

				amlApprMap.clear();

	            evltnstate       = input.get("EVLTN_STATE").toString();
	            gyljlinegc       = input.get("GYLJ_LINE_G_C").toString();
	            prdevltnid       = input.get("PRD_EVLTN_ID").toString();
	        	
	        	amlApprMap.put("APP_NO", input.get("APP_NO"));
	        	amlApprMap.put("GYLJ_LINE_G_C", gyljlinegc);
	        	amlApprMap.put("WLR_SQ", 0); 
	        	amlApprMap.put("SNO",           input.get("SNO").toString());
	        	amlApprMap.put("FIRST_SNO",     input.get("FIRST_SNO").toString());
	        	amlApprMap.put("SN_CCD",        input.get("SN_CCD").toString());
    			amlApprMap.put("RSN_CNTNT",     input.getText("RSN_CNTNT").toString());
	        	amlApprMap.put("BRN_CD",        ((SessionAML   )input.get("SessionAML")).getsAML_BDPT_CD());
	        	amlApprMap.put("HNDL_P_ENO",    ((SessionHelper)input.get("SessionHelper")).getUserId());
	        	amlApprMap.put("APPR_ROLE_ID",  ((SessionAML   )input.get("SessionAML")).getsAML_ROLE_ID());

	        	output3 = MDaoUtilSingle.getData("get_APP_MAKE_PARAM", amlApprMap);
	        	count = db.setData("AML_10_17_01_01_AmlAppr_Merge", output3);
	        	db.setData("AML_10_17_01_01_AmlApprHist_Insert", output3);	//AML_APPR_HIST : 결재이력
	        	
	        	output3.put("UPD_ID", ((SessionHelper)input.get("SessionHelper")).getUserId());
	        	output3.put("EVLTN_STATE", evltnstate);
	        	output3.put("PRD_EVLTN_ID", prdevltnid);
	        	
	        	db.setData("AML_10_25_02_02_PRD_Evltn_Appr_Update", output3);
				db.commit();
            }

			if(count > 0) {
                ERRCODE = "00000";
                ERRMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
                WINMSG  = MessageHelper.getInstance().getMessage("0002",input.getText("LANG_CD"),"정상처리 되었습니다.");
            } else {
            	ERRMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
                ERRCODE = "00099";
                WINMSG  = MessageHelper.getInstance().getMessage("0003",input.getText("LANG_CD"),"처리할 데이터가 없습니다.");
            }

            output.put("ERRCODE" , ERRCODE);
            output.put("ERRMSG"  , ERRMSG);
            output.put("WINMSG"  ,WINMSG);

        }catch(AMLException e) {
        	try {
                if (db != null) {
                    db.rollback();
                }
            } catch(Exception ee) {
                Log.logAML(Log.ERROR, this, "firstAppRequest", ee.getMessage());

                output.put("ERRCODE", "00001");
                output.put("ERRMSG", ee.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
            }

            Log.logAML(Log.ERROR, this, "firstAppRequest", e.getMessage());

            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
            output.put("gdRes", null);
        } catch(Exception e) {
	        try {
	            if (db != null) {
	                db.rollback();
	            }
	        } catch(Exception ee) {
	            Log.logAML(Log.ERROR, this, "firstAppRequest", ee.getMessage());

                output.put("ERRCODE", "00001");
                output.put("ERRMSG", ee.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        }

	        Log.logAML(Log.ERROR, this, "firstAppRequest", e.getMessage());

	        output.put("ERRCODE", "00001");
            output.put("ERRMSG" , e.getMessage());
            output.put("WINMSG" , MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
            output.put("gdRes"  , null);
        } finally {
        	try {
	            if (db != null) {
	                db.close();
	            }
	        } catch(RuntimeException e) {
	            Log.logAML(Log.ERROR, this, "firstAppRequest", e.getMessage());

	            output.put("ERRCODE", "00001");
                output.put("ERRMSG", e.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        } catch(Exception e) {
	            Log.logAML(Log.ERROR, this, "firstAppRequest", e.getMessage());

	            output.put("ERRCODE", "00001");
                output.put("ERRMSG", e.getMessage());
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
                output.put("gdRes", null);
	        }
        }

		return output;
	}

}
