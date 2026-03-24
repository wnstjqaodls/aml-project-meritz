/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.common.RBA_99.RBA_99_01.RBA_99_01_01;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.action.AMLCommonLogAction;
import com.gtone.express.Constants;
import com.gtone.express.server.actions.ExpressAction;
import com.gtone.express.server.helper.MessageHelper;

import jspeed.base.property.PropertyService;
import com.gtone.express.util.DateUtil;

/******************************************************************************************************************************************
 * @Description 내부통제 교육수료자 등록 (파일 Upload 등록)
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     AML/RBA/FATCA/CRS/WLF
 * @Java        6.0 이상
 * @Author      송지윤
 * @Since       2018. 6. 29.
 ******************************************************************************************************************************************/

public class RBA_99_01_01_01_Action extends ExpressAction {
	private final static String lang_Cd = PropertyService.getInstance().getProperty("jspeed.properties","default.LangType");
	/**************************************************************************************************************************************
	 * Attributes
	 **************************************************************************************************************************************/

	/** 인스턴스 */
	private static RBA_99_01_01_01_Action instance = null;

	// [ get ]

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return  <code>AML_10_03_01_01_Action</code>
	 */
	public static RBA_99_01_01_01_Action getInstance() {
		return (instance == null) ? (instance = new RBA_99_01_01_01_Action()) : instance;
	}

	/**
	 * 와치리스트 파일 등록<br>
	 * <p>
	 * @param   param
	 *              화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
	 *              インプット画面からの入力値,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<Key>")を通じて取得します。
	 *              Input values from web page,SessionHelper, SessionAML, menuID, pageID ==>  input.getText("<key>")
	 * @return  <code>DataObj</code>
	 *              GRID_DATA(와치리스트 등록 조회 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
	 *              GRID_DATA(ウォッチリストの登録照会 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 成功, ‘00001’: エラー,  MESSAGE =alert エラーメッセージ, WINMSG= grid 状態メッセージ)
	 *              GRID_DATA(@en DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: sucess, ‘00001’:error,  MESSAGE =alert error message , WINMSG= grid status bar message  )
	 * @throws  <code>Exception</code>
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj execute(HashMap param) {
		DataObj output = new DataObj();
		String filePath = Constants.COMMON_TEMP_FILE_UPLOAD_DIR; //PropertyService.getInstance().getProperty("aml.config", "upload.file.wl");
		String fileName = param.get("fileName").toString();
		String fileFullInfo = filePath + "/" + fileName;
		fileFullInfo = fileFullInfo.replace("/", System.getProperty("file.separator"));
		try {
			// FileInputStream fis = new FileInputStream(fileFullInfo);

			String extention = fileName.substring(fileName.lastIndexOf('.') + 1);
			if ( "xls".equals(extention) ) {
				output.add("GRID_DATA", readXls(fileFullInfo, param.get("captionName").toString()));
			} else {
				output.add("GRID_DATA", readXlsx(fileFullInfo, param.get("captionName").toString()));
			}
			output.put("ERRCODE", "00000");

			/* AML Page Log 등록 처리 모듈  **********************************************/
        	AMLCommonLogAction amlCommonLogAction =  new AMLCommonLogAction();
        	param.put("classNm", "com.gtone.aml.server.AML_10.AML_10_37.AML_10_37_01.AML_10_37_01_01_Action");
        	param.remove("captionName");
        	amlCommonLogAction.amlLogInsert(getRequest(), param);
            /* ***************************************************************************/

		} catch (RuntimeException e) {
			Log.logAML(Log.ERROR, this, "execute", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", lang_Cd, "처리중 오류가 발생하였습니다."));
		} catch (Exception e) {
			Log.logAML(Log.ERROR, this, "execute", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", lang_Cd, "처리중 오류가 발생하였습니다."));
		}
		return output;
	}

	/**
	 * Xls 형식 파일 데이터 변환<br>
	 * <p>
	 * @param   fileFullInfo
	 *              Xls 형식 파일 경로
	 * @param   caption
	 *              화면 그리드 caption 컬럼명 값
	 * @return  <code>JSONArray</code>
	 *              Xls 형식 파일 데이터를 JSONArray 타입으로 변환
	 * @throws  <code>Exception</code>
	 */
	public static JSONArray readXls(String fileFullInfo, String caption) {
		POIFSFileSystem fileSystem;
		JSONArray dataArray = new JSONArray();
		FileInputStream fis = null;
		try {
			fileFullInfo = fileFullInfo.replace("\\", "/");
			fis = new FileInputStream(new File(fileFullInfo));
			fileSystem = new POIFSFileSystem(fis);
			@SuppressWarnings("resource")
			HSSFWorkbook workbook = new HSSFWorkbook(fileSystem);
			ArrayList<Object> dataFieldName = new ArrayList<Object>();
			HSSFSheet sheet = workbook.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();
			JSONObject excelData = null;
			try {
				for ( int rowIndex = 0; rowIndex < rows - 1; rowIndex++ ) {
					//JSONObject excelData = new JSONObject();
					 excelData = getJSON();
					HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
					if ( row != null ) {
						int cells = row.getPhysicalNumberOfCells();
						for ( int columnIndex = 0; columnIndex <= cells; columnIndex++ ) {
							HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
							String value = "";
							if ( cell == null ) {
								continue;
							} else {
								switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
								case NUMERIC:
									value = cell.getNumericCellValue() + "";
									break;
								case STRING:
									value = cell.getStringCellValue() + "";
									break;
								case  BLANK:
									// value = cell.getBooleanCellValue() + "";
									value = "";
									break;
								case ERROR:
									value = cell.getErrorCellValue() + "";
									break;
								default:
									break;
								}
							}
							if ( rowIndex == 0 ) {
								dataFieldName.add(columnIndex, captionMatching(value, caption));
							} else {
								excelData.put((String) dataFieldName.get(columnIndex), value);
							}
						}
					}
					if ( rowIndex > 0 ) {
						dataArray.put(excelData);
					}
				}
			}catch (JSONException e) {
				Log.logAML(Log.ERROR, e);
			}finally {
				workbook.close();
				fis.close();
			}
		} catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, e);
		} catch (IOException e) {
			Log.logAML(Log.ERROR, e);
		} catch (Exception e) {
			Log.logAML(Log.ERROR, e);
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					Log.logAML(Log.ERROR, e);
				}
			}
		}
		return dataArray;
	}

	/**
	 * Xlsx 형식 파일 데이터 변환<br>
	 * <p>
	 * @param   fileFullInfo
	 *              Xlsx 형식 파일 경로
	 * @param   caption
	 *              화면 그리드 caption 컬럼명 값
	 * @return  <code>JSONArray</code>
	 *              Xlsx 형식 파일 데이터를 JSONArray 타입으로 변환
	 * @throws  <code>Exception</code>
	 */
	public static JSONArray readXlsx(String fileFullInfo, String caption) {

		JSONArray dataArray = new JSONArray();
		try {
			fileFullInfo = fileFullInfo.replace("\\", "/");
			FileInputStream fileSystem = new FileInputStream(fileFullInfo);
			XSSFWorkbook workbook = new XSSFWorkbook(fileSystem);
			ArrayList<Object> dataFieldName = new ArrayList<Object>();
			int rowindex = 0;
			int columnindex = 0;
			XSSFSheet sheet = workbook.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();
			JSONObject excelData = null;
			try {
				for ( rowindex = 0; rowindex < rows; rowindex++ ) {
					 excelData = getJSON();
					// 행을읽는다
					XSSFRow row = sheet.getRow(rowindex);
					if ( row != null ) {
						// 셀의 수
						int cells = row.getPhysicalNumberOfCells();
						String strNumberOne = "";
						String strNumberTwo = "";
						
						for ( columnindex = 0; columnindex < cells; columnindex++ ) {
							// 셀값을 읽는다
							XSSFCell cell = row.getCell(columnindex);
							String value = "";
							// 셀이 빈값일경우를 위한 널체크
							if ( cell == null ) {
								continue;
							} else {
								// 타입별로 내용 읽기
								switch (cell.getCellType()) {
								case FORMULA:
									value = cell.getCellFormula();
									break;
								case NUMERIC:
//									strNumberOne = cell.getNumericCellValue() + "";
//									strNumberTwo = strNumberOne.substring(0, strNumberOne.indexOf("."));
//									value = strNumberTwo;
									String fmt = cell.getCellStyle().getDataFormatString();
									
									if(fmt != null && (
											fmt.contains("yy") || fmt.contains("mm") || fmt.contains("dd") || fmt.contains("m/d") 
									)) {
										Date date = cell.getDateCellValue();
										strNumberTwo = new java.text.SimpleDateFormat("yyyyMMdd").format(date);
										
									}else {
										strNumberTwo = new java.math.BigDecimal(cell.getNumericCellValue()).toPlainString();
									}
									value = strNumberTwo;
									break;
								case STRING:
									value = cell.getStringCellValue() + "";
									break;
								case BLANK:
									value = cell.getBooleanCellValue() + "";
									value = "";
									break;
								case ERROR:
									value = cell.getErrorCellValue() + "";
									break;
								default:
									break;
								}
							}
							if ( rowindex == 0 ) {
								dataFieldName.add(columnindex, captionMatching(value, caption));
							} else {
								excelData.put((String) dataFieldName.get(columnindex), value);
							}
						}
					}
					if ( rowindex > 0 ) {
						dataArray.put(excelData);
					}
				}
			}catch (JSONException e) {
				Log.logAML(Log.ERROR, e);
			}finally{
				workbook.close();
			}
		} catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, e);
		} catch (IOException e) {
			Log.logAML(Log.ERROR, e);
		} catch (Exception e) {
			Log.logAML(Log.ERROR, e);
		}
		return dataArray;
	}

	/**
	 * Xls, Xlsx 형식의 파일 데이터를 읽어들어 한글 컬럼을 영문 dataField와 매핑 작업<br>
	 * <p>
	 * @param   value
	 *              Xlsx, Xls 형식 파일 한글 컬럼명 데이터
	 * @param   caption
	 *              화면 그리드 영문 컬럼명
	 * @return  <code>String</code>
	 *              JSON 형식의 그리드 영문 컬럼에 매핑된 데이터 return
	 * @throws  <code>Exception</code>
	 */
	public static String captionMatching(String value, String caption) {
		JSONArray jArray;
		try {
			jArray = new JSONArray(caption);
			for ( int i = 0; i < jArray.length(); i++ ) {
				JSONObject jsonObj = jArray.getJSONObject(i);
				if ( true == (jsonObj.getString("caption")).equals(value) ) {
					return jsonObj.getString("dataField");
				}
			}
		} catch (JSONException e) {
			Log.logAML(Log.ERROR, e);
		}
		return null;
	}


	public static JSONObject getJSON() {
		return new JSONObject();
	}

}
