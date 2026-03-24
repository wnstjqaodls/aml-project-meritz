/*
 * Copyright (c) 2008-2017 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_04.RBA_50_04_02;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;

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
 * 통제항목 배점관리
 * </pre>
 * @author lcj
 * @version 1.0
 * @history 1.0 2018-04-25
 */
public class RBA_50_04_02_01 extends GetResultObject {
	private final static String lang_Cd = PropertyService.getInstance().getProperty("jspeed.properties","default.LangType");
	private static RBA_50_04_02_01 instance = null;
	/**
	* getInstance
	* @return RBA_50_04_02_01
	*/
	public static  RBA_50_04_02_01 getInstance() {
		synchronized(RBA_50_04_02_01.class) {
			if (instance == null) {
				instance = new RBA_50_04_02_01();
			}
		}
		return instance;
	}

	/**
	* <pre>
	* 통제항목 배점관리 조회
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSearch(DataObj input) {

		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_04_02_01_getSearch", input);
			if (output.getCount("TONGJE_FLD_C") > 0) {
				DataObj sumData = MDaoUtilSingle.getData("RBA_50_04_02_01_getSearch2", input);
				String TONGJE_ALLT_SUM = sumData.get("TONGJE_ALLT_SUM").toString();
				output.put("TONGJE_ALLT_SUM", TONGJE_ALLT_SUM,output.getCount()-1);

				if (output.getCount("TONGJE_FLD_C") > 0) {
					gdRes = Common.setGridData(output);
					gdRes.addColumn("TONGJE_ALLT_SUM");
					gdRes.setValue(0, "TONGJE_ALLT_SUM", TONGJE_ALLT_SUM);
				} else {
					output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
					output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				}
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

	/**
	* <pre>
	* 통제항목 배점 저장
	* </pre>
	* @param input
	* @return
	*/
	public DataObj doSave(DataObj input) throws AMLException {

		DataObj output = null;
		DataObj param = null;
		DataSet gdRes = null;
		MDaoUtil mDao = null;

		try {
			output= new DataObj();
			mDao = new MDaoUtil();
			mDao.begin();

			SessionHelper helper = (SessionHelper)input.get("SessionHelper");
		    String logigId = helper.getLoginId();
		    String[] arr = null;

		    String BAS_YYMM = input.get("BAS_YYMM").toString();
		    String TONGJE_FLD_C ="";
		    String TONGJE_LGDV_C ="";
		    String TONGJE_MDDV_C ="";
		    String TONGJE_ALLT ="";

		    param = new DataObj();
		    param.put("BAS_YYMM", BAS_YYMM);
		    param.put("DR_OP_JKW_NO", logigId);
		    param.put("CHG_OP_JKW_NO", logigId);


		    String dataArr[] = input.get("dataArr").toString().split(",");

		    for(int i=0; i< dataArr.length; i++) {
		    	arr = dataArr[i].split("&&");
		    	TONGJE_FLD_C   = arr[0].trim();
		    	TONGJE_MDDV_C  =  arr[1].trim();
		    	TONGJE_LGDV_C    = TONGJE_MDDV_C.substring(0, TONGJE_MDDV_C.length()-2);
		    	TONGJE_ALLT =  arr[2].trim();

		    	param.put("TONGJE_FLD_C", TONGJE_FLD_C);
		    	param.put("TONGJE_MDDV_C", TONGJE_MDDV_C);
		    	param.put("TONGJE_LGDV_C", TONGJE_LGDV_C);
		    	param.put("TONGJE_ALLT", TONGJE_ALLT);

		    	mDao.setData("RBA_50_04_02_01_doSave", param);

		    }

		    mDao.commit();

			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this, "doSave", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} finally {
			if(mDao != null ) {
				mDao.close();
			}
		}
		return output;
	}

	/**
	 * <pre>
	 * 통제점검항목 배점 관리 - 파일저장
	 * </pre>
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "resource", "rawtypes", "unchecked" })
    public DataObj doSave(MultipartRequest req) throws AMLException {

		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		String filePath = PropertyService.getInstance().getProperty("aml.config","uploadPath.rba");
		String fileFullPath = "";
		String realFileName = "";
		String oldFilePathName = "";
		String newFilePathName = "";
		HSSFWorkbook workbook = null;
		try {

			String BAS_YYMM = req.getParameter("BAS_YYMM");
			String filename = req.getAttachFileName("EXCEL_UPLOAD_FILE");

			SessionHelper helper = new SessionHelper(req.getSession());
			String loginId = helper.getLoginId();

			// file path
			fileFullPath = filePath + "/" + "backUp" + "/";
			fileFullPath = fileFullPath.replace("/",System.getProperty("file.separator"));

			AttachFileDataSource[] attachFileDSs = req.getAttachFiles("EXCEL_UPLOAD_FILE");

			req.upload(attachFileDSs[0], fileFullPath, filename);

			if (req.getAttachFileName("EXCEL_UPLOAD_FILE")!= null){
				//String filename = req.getAttachFileName("EXCEL_UPLOAD_FILE");
				//String org_filename = filename;
				String now = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				int i = -1;
				i = filename.lastIndexOf(".");
				realFileName = now + "_30_04" + filename.substring(i, filename.length());
				oldFilePathName = fileFullPath+"/"+filename;
				newFilePathName = fileFullPath+"/"+realFileName;
				oldFilePathName = oldFilePathName.replace("/",System.getProperty("file.separator"));
				newFilePathName = newFilePathName.replace("/",System.getProperty("file.separator"));
				File file = new File(oldFilePathName);
				file.renameTo(new File(newFilePathName));
			}

			//String query_id = null;
			FileInputStream fis = new FileInputStream(newFilePathName);

			// Group Code List
			mDao = new MDaoUtil();
			mDao.begin();

			workbook = new HSSFWorkbook(fis);
			HSSFSheet sheet = workbook.getSheetAt(0);

			int rows=sheet.getPhysicalNumberOfRows();


			//FormulaEvaluator formulaEval = workbook.getCreationHelper().createFormulaEvaluator();

			for(int i = 1; i < rows; i++){
				HSSFRow row = sheet.getRow(i);

				if(row != null) {

					HashMap iObj = new HashMap();
					int cells = row.getPhysicalNumberOfCells();
					for(int j = 0; j < cells; j++){
						Cell cell = row.getCell(j);
						if(j == 0){
							iObj.put("TONGJE_FLD_C", cell.toString());
						}
						if(j == 3){
							iObj.put("TONGJE_LGDV_C", cell.toString());
						}
						if(j == 6){
							iObj.put("TONGJE_MDDV_C", cell.toString());
						}
						if(j == 8){
							String value="";
                                switch (cell.getCellType()) {
                                	case NUMERIC:
                                		//Cell.CELL_TYPE_NUMERIC;
                                		double dValue = cell.getNumericCellValue();
                                		dValue = Math.round(dValue * Math.pow(10, 4)) / Math.pow(10, 4);
                                		//value = Double.toString(dValue*100);
                                		value = Double.toString(dValue);
                                		break;
                                	case STRING:
                                		//Cell.CELL_TYPE_STRING
                                		value = "" + cell.getStringCellValue().replaceAll("%", "");
                                		break;
                                	case FORMULA:
                                		//Cell.CELL_TYPE_FORMULA;
                                		value = cell.getCellFormula();
                                		break;
                                	case BLANK:
                                		//Cell.CELL_TYPE_BLANK;
                                		value = "[null 아닌 공백]";
                                		break;
                                	case ERROR:
                                		//Cell.CELL_TYPE_ERROR;
                                		value = "" + cell.getErrorCellValue();
                                		break;
                                	default:
                                		break;
                                }

							iObj.put("TONGJE_ALLT", value);
						}

					}

					iObj.put("DR_OP_JKW_NO", loginId);
					iObj.put("CHG_OP_JKW_NO", loginId);
					iObj.put("BAS_YYMM", BAS_YYMM);


					mDao.setData("RBA_50_04_02_01_doSave", iObj);
				}
			}

			mDao.commit();

			File uploadFile = new File(newFilePathName);
			uploadFile.delete();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", helper.getLangType(), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", helper.getLangType(), "정상처리되었습니다"));

		} catch (FileNotFoundException ioe) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR,this,"doSave(IOException)",ioe.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ioe.toString());
		} catch (IOException ioe) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR,this,"doSave(IOException)",ioe.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ioe.toString());
		} catch (AMLException e) {
			if(mDao != null) {
				mDao.rollback();
			}
			Log.logAML(Log.ERROR, this.getClass(), "doSave(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", lang_Cd, "처리중 오류가 발생하였습니다."));
		} finally {
		    if (mDao != null) {
			mDao.close();
		    }
		    try {
			if (workbook != null) {
			    workbook.close();
			}
		    } catch (IOException e) {
			Log.logAML(Log.ERROR, this.getClass(), "doSave(Exception)", e.getMessage());
		    }
		}
		return output;
	}

}