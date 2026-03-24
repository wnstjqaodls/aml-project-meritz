package com.gtone.rba.server.common.RBA_99.RBA_99_01.RBA_99_01_01;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.CellType;
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

public class uploadJKW extends ExpressAction {
	private final static String lang_Cd = PropertyService.getInstance().getProperty("jspeed.properties","default.LangType");
	/**************************************************************************************************************************************
	 * Attributes
	 **************************************************************************************************************************************/

	/** 인스턴스 */
	private static uploadJKW instance = null;

	// [ get ]

	/**
	 * 인스턴스 반환.
	 * <p>
	 * @return  <code>uploadJKW</code>
	 */
	public static uploadJKW getInstance() {
		return (instance == null) ? (instance = new uploadJKW()) : instance;
	}


	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj execute(HashMap param) {
		DataObj output = new DataObj();
		String filePath = Constants.COMMON_TEMP_FILE_UPLOAD_DIR;
		String fileName = param.get("fileName").toString();
		String fileFullInfo = filePath + "/" + fileName;
		fileFullInfo = fileFullInfo.replace("/", System.getProperty("file.separator"));
		try {
			// FileInputStream fis = new FileInputStream(fileFullInfo);

			String extention = fileName.substring(fileName.lastIndexOf('.') + 1);
			if ( "xls".equals(extention)) {
				output.add("GRID_DATA", readXls(fileFullInfo, param.get("captionName").toString()));
			} else {
				output.add("GRID_DATA", readXlsx(fileFullInfo, param.get("captionName").toString()));
			}
			output.put("ERRCODE", "00000");

			/* AML Page Log 등록 처리 모듈  **********************************************/
        	AMLCommonLogAction amlCommonLogAction =  new AMLCommonLogAction();
        	param.put("classID", "RBA_99_01_01_03");
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
			HSSFWorkbook workbook = new HSSFWorkbook(fileSystem);
			ArrayList<Object> dataFieldName = new ArrayList<Object>();
			HSSFSheet sheet = workbook.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();
			ArrayList<Integer> excludeColumnIdx = new ArrayList<>();
			try {
				for ( int rowIndex = 0; rowIndex < rows - 1; rowIndex++ ) {
					JSONObject excelData = new JSONObject();
					HSSFRow row = sheet.getRow(rowIndex); // 각 행을 읽어온다
					if ( row != null ) {
						int cells = row.getPhysicalNumberOfCells();
						for ( int columnIndex = 0; columnIndex <= cells; columnIndex++ ) {
							if (rowIndex == 0) {
								cells = row.getPhysicalNumberOfCells();
							}
							HSSFCell cell = row.getCell(columnIndex); // 셀에 담겨있는 값을 읽는다.
							String value = "";
							if ( cell == null ) {
								continue;
							} else {
								switch (cell.getCellType()) { // 각 셀에 담겨있는 데이터의 타입을 체크하고 해당 타입에 맞게 가져온다.
								case NUMERIC:
									cell.setCellType( CellType.STRING );
									value = cell.getStringCellValue() + "";
									break;
								case STRING:
									value = cell.getStringCellValue() + "";
									break;
								case BLANK:
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
								String dataField = captionMatching(value, caption);
								if(dataField == null) {
									excludeColumnIdx.add(columnIndex);
								}
								dataFieldName.add(columnIndex, dataField);
							} else {
								excelData.put((String) dataFieldName.get(columnIndex), value);
							}
						}
					}
					if ( rowIndex > 0 ) {
						dataArray.put(excelData);
					}
				}
			}catch(JSONException e) {
				Log.logAML(Log.ERROR, e);
			}catch(Exception e) {
				Log.logAML(Log.ERROR, e);
			}finally {
				workbook.close();
			}

		} catch (FileNotFoundException e) {
			Log.logAML(Log.ERROR, e);
		} catch (IOException e) {
			Log.logAML(Log.ERROR, e);
		} catch(Exception e) {
			Log.logAML(Log.ERROR, e);
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					Log.logAML(Log.ERROR, e.getMessage());
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
			int cells = 0;
			XSSFSheet sheet = workbook.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();
			ArrayList<Integer> excludeColumnIdx = new ArrayList<>();
			try {
				for ( rowindex = 0; rowindex < rows; rowindex++ ) {
					JSONObject excelData = new JSONObject();
					// 행을읽는다
					XSSFRow row = sheet.getRow(rowindex);
					if ( row != null ) {
						// 셀의 수
						if (rowindex == 0) {
							cells = row.getPhysicalNumberOfCells();
						}
						for ( columnindex = 0; columnindex < cells; columnindex++ ) {
							if(excludeColumnIdx.contains(columnindex)) {
								continue;
							}
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
									cell.setCellType(CellType.STRING);
									value = cell.getStringCellValue() + "";
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
								String dataField = captionMatching(value, caption);
								if(dataField == null) {
									excludeColumnIdx.add(columnindex);
								}
								dataFieldName.add(columnindex, dataField);
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
}
