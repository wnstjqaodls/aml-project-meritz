/*
 * Copyright (c) 2008-2018 GTONE. All rights reserved.
 *
 * This software is the confidential and proprietary information of GTONE. You shall not disclose such Confidential Information and shall
 * use it only in accordance with the terms of the license agreement you entered into with GTONE.
 */
package com.gtone.rba.server.type03.RBA_50.RBA_50_10.RBA_50_10_01;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
//import org.apache.poi.xssf.usermodel.XSSFRow;
//import org.apache.poi.xssf.usermodel.XSSFSheet;

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

/******************************************************************************************************************************************
 * @Description FIU지표보고-업무보고서등록
 * @FileName    RBA_50_10_01_02.java
 * @Group       GTONE
 * @Project     RBA
 * @Java        6.0 이상
 * @Author      KDO
 * @Since       2018. 4. 26.
 ******************************************************************************************************************************************/

public class RBA_50_10_01_02 extends GetResultObject {
	private final static String lang_Cd = PropertyService.getInstance().getProperty("jspeed.properties","default.LangType");

    /**************************************************************************************************************************************
     * Attributes
     **************************************************************************************************************************************/

    /** 인스턴스 */
    private static RBA_50_10_01_02 instance = null;

    /**************************************************************************************************************************************
     * Methods
     **************************************************************************************************************************************/

    /**
     * 인스턴스 반환.
     * <p>
     * @return  <code>RBA_50_10_01_02</code>
     *              인스턴스
     */
    public static  RBA_50_10_01_02 getInstance() {
    	//return instance==null?(instance=new RBA_50_10_01_02()):instance;
    	if (instance == null) {
			instance = new RBA_50_10_01_02();
		}
		return instance;
    }

    /**
     * 업무보고서 리스트 조회<br>
     * <p>
     * @param   input 화면에서 보낸 입력 값,SessionHelper, SessionAML, menuID, pageID ==> input.getText("<키>")을 통해 값을 얻는다.
     * @return  GRID_DATA(업무보고서 조회리스트 DataSet),  PARAM_DATA ( grid param DataSet, STATUS = ‘00000’: 성공, ‘00001’:에러,  MESSAGE =alert 에러메시지, WINMSG= grid 상태 메시지)
     * @throws  <code>Exception</code>
     */
    public DataObj doSearch(DataObj input)
    {
        DataObj output = new DataObj();
        DataSet gdRes  = null;

        try {

            DataObj dbOut = MDaoUtilSingle.getData( "RBA_50_10_01_02_doSearch", input);

            if (dbOut.getCount("BIZ_RPT_ID")>0) {
                gdRes = Common.setGridData(dbOut);
            } else {
                output.put("ERRMSG",MessageHelper.getInstance().getMessage("0001",input.getText("LANG_CD"),"조회된 정보가 없습니다.") );
				output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
            }
            output.put("ERRCODE","00000");
            output.put("gdRes"  , gdRes );
        } catch(AMLException e) {
            Log.logAML(Log.ERROR, this, "doSearch", e.toString());
            output.clear();
            output.put("ERRCODE", "00001");
            output.put("ERRMSG", e.getMessage());
            output.put("WINMSG", e.getMessage());
        }
        return output;
    }

    /**
	 * <pre>
	 * 업무보고서 - 파일저장
	 * </pre>
	 * @param input
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unused", "resource", "rawtypes", "unchecked" })
    public DataObj doSave(MultipartRequest req) throws AMLException {

		DataObj output = new DataObj();
		DataObj obj1 = new DataObj();
		DataObj rObj = new DataObj();
		DataObj fileNoObj = new DataObj();
		MDaoUtil mDao = new MDaoUtil();

		String filePath = PropertyService.getInstance().getProperty("aml.config","uploadPath.rba");

		String fileFullPath = "";
		String realFileName = "";
		String oldFilePathName = "";
		String newFilePathName = "";
		String ATTCH_FILE_NO = "";
		String BIZ_RPT_ID = "";
		int sno = 0;
		String str ="/";
		StringBuffer strBuf = new StringBuffer();
		FileInputStream fis = null;

		try {

			mDao = new MDaoUtil();
			mDao.begin();

			int result = 0;
			String filename = req.getAttachFileName("NOTI_ATTACH");
			String NOTI_ATTACH = req.getParameter("NOTI_ATTACH");

			SessionHelper helper = new SessionHelper(req.getSession());
			String loginId = helper.getLoginId();

			// file path
			strBuf.append(filePath);
			strBuf.append(str);
			strBuf.append("backUp");
			strBuf.append(str);

			//fileFullPath = filePath + "/" + "backUp" + "/";
			fileFullPath = strBuf.toString();
			fileFullPath = fileFullPath.replace("/",System.getProperty("file.separator"));

			AttachFileDataSource[] attachFileDSs = req.getAttachFiles("NOTI_ATTACH");

			int count_file = 0;
		    int count_file_real = 0;

			if (!("").equals(NOTI_ATTACH)) {
				count_file++;
	    	}

			if (req.getAttachFiles("NOTI_ATTACH") != null) {
		        Log.logAML(Log.DEBUG, this, "#### count_file_real_if [0]");
		        count_file_real = attachFileDSs.length;
		    }

			if (count_file_real != count_file) {
		    	mDao.rollback();
		    	output.put("ERRCODE", "00999");
		    	output.put("ERRMSG",MessageHelper.getInstance().getMessage("0053",helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
		    	output.put("WINMSG",MessageHelper.getInstance().getMessage("0053",helper.getLangType(), "첨부된 파일정보를 확인하십시요."));
		    	return output;
		    }

		    // ==================================================================

		    count_file = 0;
		    long fileLen = 0;
		    StringBuffer sb = new StringBuffer(64);

			// 첨부파일 번호 생성
			fileNoObj = mDao.getData("RBA_50_10_01_02_getRbaAttchFileNo", output);
	        ATTCH_FILE_NO = fileNoObj.getText("SEQ");
	        sb.append("#### ATTCH_FILE_NO!!! :");
	        sb.append(ATTCH_FILE_NO);
	        Log.logAML(Log.DEBUG, this, sb);

	        // 첨부파일 저장
	        if (!("").equals(NOTI_ATTACH)) {
		          Log.logAML(Log.DEBUG, this, "#### 첨부파일번호가 없고 첨부파일이 있을때(신규파일 추가)");

		          String PHSC_FILE_NM = ATTCH_FILE_NO + "_0";
		          //req.upload(attachFileDSs[count_file], fileFullPath, PHSC_FILE_NM);
		          req.upload(attachFileDSs[count_file], fileFullPath, filename);
		          fileLen = attachFileDSs[count_file].getSize();
		          if (fileLen > 1) {
		            fileLen = fileLen - 2; // getSize시 원래사이즈보다 2가 큼
		          }

		          obj1.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
		          obj1.put("FILE_SER", 0);
		          obj1.put("DATA_G", "G");
		          obj1.put("FILE_POS", fileFullPath);
		          obj1.put("LOSC_FILE_NM", attachFileDSs[count_file].getName());
		          obj1.put("PHSC_FILE_NM", PHSC_FILE_NM);
		          obj1.put("FILE_SIZE", fileLen);
		          obj1.put("DOWNLOAD_CNT", 0);
		          obj1.put("DR_OP_JKW_NO", loginId);

		          mDao.setData("RBA_50_08_04_02_insertFile", obj1);
		    }

		  if (filename!= null){

			    String now = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

			    int i = -1;
			    i = filename.lastIndexOf(".");

			    realFileName = now + "_50_10" + filename.substring(i, filename.length());
			    oldFilePathName = fileFullPath+"/"+filename;
			    newFilePathName = fileFullPath+"/"+realFileName;
			    oldFilePathName = oldFilePathName.replace("/",System.getProperty("file.separator"));
			    newFilePathName = newFilePathName.replace("/",System.getProperty("file.separator"));

				File file = new File(oldFilePathName);
				file.renameTo(new File(newFilePathName));
			}

			//String query_id = null;
			fis = new FileInputStream(newFilePathName);

			//HSSFWorkbook workbook = new HSSFWorkbook(fis);
			//XSSFWorkbook workbook = new XSSFWorkbook(fis);

			Workbook workbook = WorkbookFactory.create(fis);

			//FormulaEvaluator formulaEval = workbook.getCreationHelper().createFormulaEvaluator();
			// SAMPLE  Excel 97 - 2003 통합문서(*.xls)

		    // 재무상태표(GA023)
			if("Y".equals(req.getParameter("GA023")) && workbook.getSheet("GA023") != null ) {

				BIZ_RPT_ID = "GA023";
				sno = 0;
				//XSSFSheet sheetGA023 = workbook.getSheet("GA023");
				//HSSFSheet sheetGA023 = workbook.getSheet("GA023");
				Sheet sheetGA023 = workbook.getSheet("GA023");

				//XSSFRow rowGA023 = null;
				Row rowGA023 = null;
				Cell GA023cell1 = null;
				Cell GA023cell2 = null;
				String GA023val1nvl = null;
				double GA023val2nvl = 0;   /* 2018.08.10 KDO 수정 */

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 457; i++) { /* 2018.08.10 KDO 수정 */
					rowGA023 = sheetGA023.getRow(i);

					GA023cell1 = rowGA023.getCell(0);
					GA023cell2 = rowGA023.getCell(1);

					if ( GA023cell1 == null ) { GA023val1nvl = ""; } else { GA023val1nvl = GA023cell1.getStringCellValue(); }
					if ( GA023cell2 == null || GA023cell2.getCellType() == CellType.STRING ) { GA023val2nvl = 0; } else { GA023val2nvl = GA023cell2.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();  /* 2018.08.10 KDO 수정 */
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA023val1nvl);  //계정금액
					rtnVal(iObj, GA023val2nvl, "DATA01");
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 금융투자상품의 위탁매매 및 수수료 현황표(GA054)
			if("Y".equals(req.getParameter("GA054")) && workbook.getSheet("GA054") != null ) {

				BIZ_RPT_ID = "GA054";
				sno = 0;
				//XSSFSheet sheetGA054 = workbook.getSheet("GA054");
				Sheet sheetGA054 = workbook.getSheet("GA054");

				//XSSFRow rowGA054 = null;
				Row rowGA054 = null;

				Cell GA054cell1 = null;
				Cell GA054cell2 = null;
				Cell GA054cell3 = null;
				Cell GA054cell4 = null;
				Cell GA054cell5 = null;
				Cell GA054cell6 = null;
				Cell GA054cell7 = null;
				String GA054val1nvl = null;
				String GA054val2nvl = null;
				String GA054val3nvl = null;
				double GA054val4nvl = 0;    /* 2018.08.10 KDO 수정 */
				double GA054val5nvl = 0;	/* 2018.08.10 KDO 수정 */
				double GA054val6nvl = 0;
				double GA054val7nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 62; i++) {  /* 2018.08.10 KDO 수정 */
					rowGA054 = sheetGA054.getRow(i);

					GA054cell1 = rowGA054.getCell(0);
					GA054cell2 = rowGA054.getCell(1);
					GA054cell3 = rowGA054.getCell(2);
					GA054cell4 = rowGA054.getCell(3);
					GA054cell5 = rowGA054.getCell(4);
					GA054cell6 = rowGA054.getCell(5);
					GA054cell7 = rowGA054.getCell(6);

					if ( GA054cell1 == null ) { GA054val1nvl = ""; } else { GA054val1nvl = GA054cell1.getStringCellValue(); }
					if ( GA054cell2 == null ) { GA054val2nvl = ""; } else { GA054val2nvl = GA054cell2.getStringCellValue(); }
					if ( GA054cell3 == null ) { GA054val3nvl = ""; } else { GA054val3nvl = GA054cell3.getStringCellValue(); }
					if ( GA054cell4 == null || GA054cell4.getCellType() == CellType.STRING ) { GA054val4nvl = 0; } else { GA054val4nvl = GA054cell4.getNumericCellValue(); }
					if ( GA054cell5 == null || GA054cell5.getCellType() == CellType.STRING ) { GA054val5nvl = 0; } else { GA054val5nvl = GA054cell5.getNumericCellValue(); }
					if ( GA054cell6 == null || GA054cell6.getCellType() == CellType.STRING ) { GA054val6nvl = 0; } else { GA054val6nvl = GA054cell6.getNumericCellValue(); }
					if ( GA054cell7 == null || GA054cell7.getCellType() == CellType.STRING ) { GA054val7nvl = 0; } else { GA054val7nvl = GA054cell7.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA054val1nvl);
					iObj.put("DATA_TITE02", GA054val2nvl);
					iObj.put("DATA_TITE03", GA054val3nvl);
					rtnVal(iObj, GA054val4nvl, "DATA01");
					rtnVal(iObj, GA054val5nvl, "DATA02");
					rtnVal(iObj, GA054val6nvl, "DATA03");
					rtnVal(iObj, GA054val7nvl, "DATA04");
					iObj.put("DR_OP_JKW_NO", loginId);

					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 주식매매 거래실적(GA058)
			if("Y".equals(req.getParameter("GA058")) && workbook.getSheet("GA058") != null ) {

				BIZ_RPT_ID = "GA058";
				sno = 0;
				//XSSFSheet sheetGA058 = workbook.getSheet("GA058");
				Sheet sheetGA058 = workbook.getSheet("GA058");

				//XSSFRow rowGA058 = null;
				Row rowGA058 = null;

				Cell GA058cell1 = null;
				Cell GA058cell2 = null;
				Cell GA058cell3 = null;
				Cell GA058cell4 = null;
				Cell GA058cell5 = null;
				Cell GA058cell6 = null;
				String GA058val1nvl = null;
				String GA058val2nvl = null;
				double GA058val3nvl = 0;
				double GA058val4nvl = 0;
				double GA058val5nvl = 0;
				double GA058val6nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 18; i++) {
					rowGA058 = sheetGA058.getRow(i);

					GA058cell1 = rowGA058.getCell(0);
					GA058cell2 = rowGA058.getCell(1);
					GA058cell3 = rowGA058.getCell(2);
					GA058cell4 = rowGA058.getCell(3);
					GA058cell5 = rowGA058.getCell(4);
					GA058cell6 = rowGA058.getCell(5);

					if ( GA058cell1 == null ) { GA058val1nvl = ""; } else { GA058val1nvl = GA058cell1.getStringCellValue(); }
					if ( GA058cell2 == null ) { GA058val2nvl = ""; } else { GA058val2nvl = GA058cell2.getStringCellValue(); }
					if ( GA058cell3 == null || GA058cell3.getCellType() == CellType.STRING ) { GA058val3nvl = 0; } else { GA058val3nvl = GA058cell3.getNumericCellValue(); }
					if ( GA058cell4 == null || GA058cell4.getCellType() == CellType.STRING ) { GA058val4nvl = 0; } else { GA058val4nvl = GA058cell4.getNumericCellValue(); }
					if ( GA058cell5 == null || GA058cell5.getCellType() == CellType.STRING ) { GA058val5nvl = 0; } else { GA058val5nvl = GA058cell5.getNumericCellValue(); }
					if ( GA058cell6 == null || GA058cell6.getCellType() == CellType.STRING ) { GA058val6nvl = 0; } else { GA058val6nvl = GA058cell6.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA058val1nvl);
					iObj.put("DATA_TITE02", GA058val2nvl);
					rtnVal(iObj, GA058val3nvl, "DATA01");
					rtnVal(iObj, GA058val4nvl, "DATA02");
					rtnVal(iObj, GA058val5nvl, "DATA03");
					rtnVal(iObj, GA058val6nvl, "DATA04");
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 장내파생상품을 헤지하기 위한 금융투자상품 매매 거래 실적(GA067)
			if("Y".equals(req.getParameter("GA067")) && workbook.getSheet("GA067") != null ) {

				BIZ_RPT_ID = "GA067";
				sno = 0;
				//XSSFSheet sheetGA067 = workbook.getSheet("GA067");
				Sheet sheetGA067 = workbook.getSheet("GA067");

				//XSSFRow rowGA067 = null;
				Row rowGA067 = null;

				Cell GA067cell1 = null;
				Cell GA067cell2 = null;
				Cell GA067cell3 = null;
				Cell GA067cell4 = null;
				Cell GA067cell5 = null;
				Cell GA067cell6 = null;
				Cell GA067cell7 = null;
				Cell GA067cell8 = null;
				Cell GA067cell9 = null;
				String GA067val1nvl = null;
				String GA067val2nvl = null;
				String GA067val3nvl = null;
				String GA067val4nvl = null;
				String GA067val5nvl = null;
				double GA067val6nvl = 0;
				double GA067val7nvl = 0;
				double GA067val8nvl = 0;
				double GA067val9nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 85; i++) {
					rowGA067 = sheetGA067.getRow(i);

					GA067cell1 = rowGA067.getCell(0);
					GA067cell2 = rowGA067.getCell(1);
					GA067cell3 = rowGA067.getCell(2);
					GA067cell4 = rowGA067.getCell(3);
					GA067cell5 = rowGA067.getCell(4);
					GA067cell6 = rowGA067.getCell(5);
					GA067cell7 = rowGA067.getCell(6);
					GA067cell8 = rowGA067.getCell(7);
					GA067cell9 = rowGA067.getCell(8);

					if ( GA067cell1 == null ) { GA067val1nvl = ""; } else { GA067val1nvl = GA067cell1.getStringCellValue(); }
					if ( GA067cell2 == null ) { GA067val2nvl = ""; } else { GA067val2nvl = GA067cell2.getStringCellValue(); }
					if ( GA067cell3 == null ) { GA067val3nvl = ""; } else { GA067val3nvl = GA067cell3.getStringCellValue(); }
					if ( GA067cell4 == null ) { GA067val4nvl = ""; } else { GA067val4nvl = GA067cell4.getStringCellValue(); }
					if ( GA067cell5 == null ) { GA067val5nvl = ""; } else { GA067val5nvl = GA067cell5.getStringCellValue(); }
					if ( GA067cell6 == null || GA067cell6.getCellType() == CellType.STRING ) { GA067val6nvl = 0; } else { GA067val6nvl = GA067cell6.getNumericCellValue(); }
					if ( GA067cell7 == null || GA067cell7.getCellType() == CellType.STRING ) { GA067val7nvl = 0; } else { GA067val7nvl = GA067cell7.getNumericCellValue(); }
					if ( GA067cell8 == null || GA067cell8.getCellType() == CellType.STRING ) { GA067val8nvl = 0; } else { GA067val8nvl = GA067cell8.getNumericCellValue(); }
					if ( GA067cell9 == null || GA067cell9.getCellType() == CellType.STRING ) { GA067val9nvl = 0; } else { GA067val9nvl = GA067cell9.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA067val1nvl);      //구분
					iObj.put("DATA_TITE02", GA067val2nvl);      //구분
					iObj.put("DATA_TITE03", GA067val3nvl);      //구분
					iObj.put("DATA_TITE04", GA067val4nvl);      //구분
					iObj.put("DATA_TITE05", GA067val5nvl);      //구분
					rtnVal(iObj, GA067val6nvl, "DATA01");	    //매수
					rtnVal(iObj, GA067val7nvl, "DATA02");	    //매도
					rtnVal(iObj, GA067val8nvl, "DATA03");	    //합계
					rtnVal(iObj, GA067val9nvl, "DATA04");	    //잔액
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 총괄(GA070)
			if("Y".equals(req.getParameter("GA070")) && workbook.getSheet("GA070") != null ) {

				BIZ_RPT_ID = "GA070";
				sno = 0;
				//XSSFSheet sheetGA070 = workbook.getSheet("GA070");
				Sheet sheetGA070 = workbook.getSheet("GA070");

				//XSSFRow rowGA070 = null;
				Row rowGA070 = null;

				Cell GA070cell1 = null;
				Cell GA070cell2 = null;
				Cell GA070cell3 = null;
				Cell GA070cell4 = null;
				Cell GA070cell5 = null;
				Cell GA070cell6 = null;
				String GA070val1nvl = null;
				String GA070val2nvl = null;
				double GA070val3nvl = 0;
				double GA070val4nvl = 0;
				double GA070val5nvl = 0;
				double GA070val6nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 20; i++) { /* 2018.08.10 KDO 수정 */
					rowGA070 = sheetGA070.getRow(i);

					GA070cell1 = rowGA070.getCell(0);
					GA070cell2 = rowGA070.getCell(1);
					GA070cell3 = rowGA070.getCell(2);
					GA070cell4 = rowGA070.getCell(3);
					GA070cell5 = rowGA070.getCell(4);
					GA070cell6 = rowGA070.getCell(5);

					if ( GA070cell1 == null ) { GA070val1nvl = ""; } else { GA070val1nvl = GA070cell1.getStringCellValue(); }
					if ( GA070cell2 == null ) { GA070val2nvl = ""; } else { GA070val2nvl = GA070cell2.getStringCellValue(); }
					if ( GA070cell3 == null || GA070cell3.getCellType() == CellType.STRING ) { GA070val3nvl = 0; } else { GA070val3nvl = GA070cell3.getNumericCellValue(); }
					if ( GA070cell4 == null || GA070cell4.getCellType() == CellType.STRING ) { GA070val4nvl = 0; } else { GA070val4nvl = GA070cell4.getNumericCellValue(); }
					if ( GA070cell5 == null || GA070cell5.getCellType() == CellType.STRING ) { GA070val5nvl = 0; } else { GA070val5nvl = GA070cell5.getNumericCellValue(); }
					if ( GA070cell6 == null || GA070cell6.getCellType() == CellType.STRING ) { GA070val6nvl = 0; } else { GA070val6nvl = GA070cell6.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA070val1nvl);      //구분
					iObj.put("DATA_TITE02", GA070val2nvl);      //구분
					rtnVal(iObj, GA070val3nvl, "DATA01");	    //매수
					rtnVal(iObj, GA070val4nvl, "DATA02");	    //매도
					rtnVal(iObj, GA070val5nvl, "DATA03");	    //합계
					rtnVal(iObj, GA070val6nvl, "DATA04");	    //잔액
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 거래목적별 장외파생상품 매매실적(GA071)
			if("Y".equals(req.getParameter("GA071")) && workbook.getSheet("GA071") != null ) {

				BIZ_RPT_ID = "GA071";
				sno = 0;
				//XSSFSheet sheetGA071 = workbook.getSheet("GA071");
				Sheet sheetGA071 = workbook.getSheet("GA071");

				//XSSFRow rowGA071 = null;
				Row rowGA071 = null;

				Cell GA071cell1 = null;
				Cell GA071cell2 = null;
				Cell GA071cell3 = null;
				Cell GA071cell4 = null;
				Cell GA071cell5 = null;
				Cell GA071cell6 = null;
				Cell GA071cell7 = null;
				Cell GA071cell8 = null;
				Cell GA071cell9 = null;
				Cell GA071cell10 = null;
				Cell GA071cell11 = null;
				String GA071val1nvl = null;
				String GA071val2nvl = null;
				double GA071val3nvl = 0;
				double GA071val4nvl = 0;
				double GA071val5nvl = 0;
				double GA071val6nvl = 0;
				double GA071val7nvl = 0;
				double GA071val8nvl = 0;
				double GA071val9nvl = 0;
				double GA071val10nvl = 0;
				double GA071val11nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 12; i < 21; i++) {
					rowGA071 = sheetGA071.getRow(i);

					GA071cell1 = rowGA071.getCell(0);
					GA071cell2 = rowGA071.getCell(1);
					GA071cell3 = rowGA071.getCell(2);
					GA071cell4 = rowGA071.getCell(3);
					GA071cell5 = rowGA071.getCell(4);
					GA071cell6 = rowGA071.getCell(5);
					GA071cell7 = rowGA071.getCell(6);
					GA071cell8 = rowGA071.getCell(7);
					GA071cell9 = rowGA071.getCell(8);
					GA071cell10 = rowGA071.getCell(9);
					GA071cell11 = rowGA071.getCell(10);

					if ( GA071cell1 == null ) { GA071val1nvl = ""; } else { GA071val1nvl = GA071cell1.getStringCellValue(); }
					if ( GA071cell2 == null ) { GA071val2nvl = ""; } else { GA071val2nvl = GA071cell2.getStringCellValue(); }
					if ( GA071cell3 == null || GA071cell3.getCellType() == CellType.STRING ) { GA071val3nvl = 0; } else { GA071val3nvl = GA071cell3.getNumericCellValue(); }
					if ( GA071cell4 == null || GA071cell4.getCellType() == CellType.STRING ) { GA071val4nvl = 0; } else { GA071val4nvl = GA071cell4.getNumericCellValue(); }
					if ( GA071cell5 == null || GA071cell5.getCellType() == CellType.STRING ) { GA071val5nvl = 0; } else { GA071val5nvl = GA071cell5.getNumericCellValue(); }
					if ( GA071cell6 == null || GA071cell6.getCellType() == CellType.STRING ) { GA071val6nvl = 0; } else { GA071val6nvl = GA071cell6.getNumericCellValue(); }
					if ( GA071cell7 == null || GA071cell7.getCellType() == CellType.STRING ) { GA071val7nvl = 0; } else { GA071val7nvl = GA071cell7.getNumericCellValue(); }
					if ( GA071cell8 == null || GA071cell8.getCellType() == CellType.STRING ) { GA071val8nvl = 0; } else { GA071val8nvl = GA071cell8.getNumericCellValue(); }
					if ( GA071cell9 == null || GA071cell9.getCellType() == CellType.STRING ) { GA071val9nvl = 0; } else { GA071val9nvl = GA071cell9.getNumericCellValue(); }
					if ( GA071cell10 == null || GA071cell10.getCellType() == CellType.STRING ) { GA071val10nvl = 0; } else { GA071val10nvl = GA071cell10.getNumericCellValue(); }
					if ( GA071cell11 == null || GA071cell11.getCellType() == CellType.STRING ) { GA071val11nvl = 0; } else { GA071val11nvl = GA071cell11.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA071val1nvl);      //구분
					iObj.put("DATA_TITE02", GA071val2nvl);      //구분
					rtnVal(iObj, GA071val3nvl, "DATA01");	    //거래수 투기
					rtnVal(iObj, GA071val4nvl, "DATA02");	    //거래수 헤지
					rtnVal(iObj, GA071val5nvl, "DATA03");	    //거래수 기타
					rtnVal(iObj, GA071val6nvl, "DATA04");	    //거래수 계
					rtnVal(iObj, GA071val7nvl, "DATA05");	    //거래금액 투기
					rtnVal(iObj, GA071val8nvl, "DATA06");	    //거래금액 헤지
					rtnVal(iObj, GA071val9nvl, "DATA07");	    //거래금액 기타
					rtnVal(iObj, GA071val10nvl, "DATA08");	    //거래금액 계
					rtnVal(iObj, GA071val11nvl, "DATA09");	    //평가손익
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 장외파생상품을 헤지하기 위한 매매실적(GA072)
			if("Y".equals(req.getParameter("GA072")) && workbook.getSheet("GA072") != null ) {

				BIZ_RPT_ID = "GA072";
				sno = 0;
				//XSSFSheet sheetGA072 = workbook.getSheet("GA072");
				Sheet sheetGA072 = workbook.getSheet("GA072");

				//XSSFRow rowGA072 = null;
				Row rowGA072 = null;

				Cell GA072cell1 = null;
				Cell GA072cell2 = null;
				Cell GA072cell3 = null;
				Cell GA072cell4 = null;
				Cell GA072cell5 = null;
				Cell GA072cell6 = null;
				Cell GA072cell7 = null;
				Cell GA072cell8 = null;
				Cell GA072cell9 = null;
				String GA072val1nvl = null;
				String GA072val2nvl = null;
				String GA072val3nvl = null;
				String GA072val4nvl = null;
				String GA072val5nvl = null;
				double GA072val6nvl = 0;
				double GA072val7nvl = 0;
				double GA072val8nvl = 0;
				double GA072val9nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 86; i++) {
					rowGA072 = sheetGA072.getRow(i);

					GA072cell1 = rowGA072.getCell(0);
					GA072cell2 = rowGA072.getCell(1);
					GA072cell3 = rowGA072.getCell(2);
					GA072cell4 = rowGA072.getCell(3);
					GA072cell5 = rowGA072.getCell(4);
					GA072cell6 = rowGA072.getCell(5);
					GA072cell7 = rowGA072.getCell(6);
					GA072cell8 = rowGA072.getCell(7);
					GA072cell9 = rowGA072.getCell(8);

					if ( GA072cell1 == null ) { GA072val1nvl = ""; } else { GA072val1nvl = GA072cell1.getStringCellValue(); }
					if ( GA072cell2 == null ) { GA072val2nvl = ""; } else { GA072val2nvl = GA072cell2.getStringCellValue(); }
					if ( GA072cell3 == null ) { GA072val3nvl = ""; } else { GA072val3nvl = GA072cell3.getStringCellValue(); }
					if ( GA072cell4 == null ) { GA072val4nvl = ""; } else { GA072val4nvl = GA072cell4.getStringCellValue(); }
					if ( GA072cell5 == null ) { GA072val5nvl = ""; } else { GA072val5nvl = GA072cell5.getStringCellValue(); }
					if ( GA072cell6 == null || GA072cell6.getCellType() == CellType.STRING ) { GA072val6nvl = 0; } else { GA072val6nvl = GA072cell6.getNumericCellValue(); }
					if ( GA072cell7 == null || GA072cell7.getCellType() == CellType.STRING ) { GA072val7nvl = 0; } else { GA072val7nvl = GA072cell7.getNumericCellValue(); }
					if ( GA072cell8 == null || GA072cell8.getCellType() == CellType.STRING ) { GA072val8nvl = 0; } else { GA072val8nvl = GA072cell8.getNumericCellValue(); }
					if ( GA072cell9 == null || GA072cell9.getCellType() == CellType.STRING ) { GA072val9nvl = 0; } else { GA072val9nvl = GA072cell9.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA072val1nvl);      //구분
					iObj.put("DATA_TITE02", GA072val2nvl);      //구분
					iObj.put("DATA_TITE03", GA072val3nvl);      //구분
					iObj.put("DATA_TITE04", GA072val4nvl);      //구분
					iObj.put("DATA_TITE05", GA072val5nvl);      //구분
					rtnVal(iObj, GA072val6nvl, "DATA01");	    //매수
					rtnVal(iObj, GA072val7nvl, "DATA02");	    //매도
					rtnVal(iObj, GA072val8nvl, "DATA03");	    //합계
					rtnVal(iObj, GA072val9nvl, "DATA04");	    //잔액
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

			// 조직기구현황(GA140)
			if("Y".equals(req.getParameter("GA140")) && workbook.getSheet("GA140") != null ) {

				BIZ_RPT_ID = "GA140";
				sno = 0;
				//XSSFSheet sheetGA140 = workbook.getSheet("GA140");
				Sheet sheetGA140 = workbook.getSheet("GA140");

				//XSSFRow rowGA140 = null;
				Row rowGA140 = null;

				Cell GA140cell1 = null;
				Cell GA140cell2 = null;
				Cell GA140cell3 = null;
				String GA140val1nvl = null;
				double GA140val2nvl = 0; /* 2018.08.10 KDO 수정 */
				double GA140val3nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 17; i++) { /* 2018.08.10 KDO 수정 */
					rowGA140 = sheetGA140.getRow(i);

					GA140cell1 = rowGA140.getCell(0);
					GA140cell2 = rowGA140.getCell(1);
					GA140cell3 = rowGA140.getCell(2);

					if ( GA140cell1 == null ) { GA140val1nvl = ""; } else { GA140val1nvl = GA140cell1.getStringCellValue(); }
					if ( GA140cell2 == null || GA140cell2.getCellType() == CellType.STRING ) { GA140val2nvl = 0; } else { GA140val2nvl = GA140cell2.getNumericCellValue(); }
					if ( GA140cell3 == null || GA140cell3.getCellType() == CellType.STRING ) { GA140val3nvl = 0; } else { GA140val3nvl = GA140cell3.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA140val1nvl);
					rtnVal(iObj, GA140val2nvl, "DATA01");	//본부부서 부서수(점포수)
					rtnVal(iObj, GA140val3nvl, "DATA02");	//본부부서 인원수
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 일반현황(GA142)
			if("Y".equals(req.getParameter("GA142")) && workbook.getSheet("GA142") != null ) {

				BIZ_RPT_ID = "GA142";
				sno = 0;
				//XSSFSheet sheetGA142 = workbook.getSheet("GA142");
				Sheet sheetGA142 = workbook.getSheet("GA142");

				//XSSFRow rowGA142 = null;
				Row rowGA142 = null;

				Cell GA142cell1 = null;
				Cell GA142cell2 = null;
				Cell GA142cell3 = null;
				Cell GA142cell4 = null;
				Cell GA142cell5 = null;
				Cell GA142cell6 = null;
				String GA142val1nvl = null;
				String GA142val2nvl = null;
				double GA142val3nvl = 0; /* 2018.08.10 KDO 수정 */
				double GA142val4nvl = 0;
				double GA142val5nvl = 0;
				double GA142val6nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 12; i < 21; i++) {
					rowGA142 = sheetGA142.getRow(i);

					GA142cell1 = rowGA142.getCell(0);
					GA142cell2 = rowGA142.getCell(1);
					GA142cell3 = rowGA142.getCell(2);
					GA142cell4 = rowGA142.getCell(3);
					GA142cell5 = rowGA142.getCell(4);
					GA142cell6 = rowGA142.getCell(5);

					if ( GA142cell1 == null ) { GA142val1nvl = ""; } else { GA142val1nvl = GA142cell1.getStringCellValue(); }
					if ( GA142cell2 == null ) { GA142val2nvl = ""; } else { GA142val2nvl = GA142cell2.getStringCellValue(); }
					if ( GA142cell3 == null || GA142cell3.getCellType() == CellType.STRING ) { GA142val3nvl = 0; } else { GA142val3nvl = GA142cell3.getNumericCellValue(); }
					if ( GA142cell4 == null || GA142cell4.getCellType() == CellType.STRING ) { GA142val4nvl = 0; } else { GA142val4nvl = GA142cell4.getNumericCellValue(); }
					if ( GA142cell5 == null || GA142cell5.getCellType() == CellType.STRING ) { GA142val5nvl = 0; } else { GA142val5nvl = GA142cell5.getNumericCellValue(); }
					if ( GA142cell6 == null || GA142cell6.getCellType() == CellType.STRING ) { GA142val6nvl = 0; } else { GA142val6nvl = GA142cell6.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA142val1nvl);      //구분
					iObj.put("DATA_TITE02", GA142val2nvl);      //구분
					rtnVal(iObj, GA142val3nvl, "DATA01");	    //국내
					rtnVal(iObj, GA142val4nvl, "DATA02");	    //해외 국내파견
					rtnVal(iObj, GA142val5nvl, "DATA03");	    //해외 현지채용
					rtnVal(iObj, GA142val6nvl, "DATA04");	    //합계
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 기관 및 임직원 제재현황(GA145)
			// 제재일이 숫자형식으로 입력될지, 문자형식으로 입력될지 몰라서 타입 체크하여 처리함.
			if("Y".equals(req.getParameter("GA145")) && workbook.getSheet("GA145") != null ) {

				BIZ_RPT_ID = "GA145";
				sno = 0;
				//XSSFSheet sheetGA145 = workbook.getSheet("GA145");
				Sheet sheetGA145 = workbook.getSheet("GA145");

				//HSSFRow rowGA145 = null;
				//Row rowGA145 = null;

				Cell GA145cell[] = new Cell[3];
				String GA145val[] = new String[3];
				String ChkDataYn = "N";

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				int i = 11;

				/*******************************
				 *  2018.08.10 KDO 수정 start
				 ******************************/
				for ( int j = 0; j < 3; j++) {
					if ((sheetGA145.getRow(i) == null) == false  ) {
						if ( (sheetGA145.getRow(i).getCell(j) == null) == false ) {
							GA145cell[j] = sheetGA145.getRow(i).getCell(j);

							Log.logAML(Log.DEBUG, this, GA145cell[j]);
							if ( GA145cell[j] != null ) {
								if ( GA145cell[j].getCellType() == CellType.BLANK ) {
									GA145val[j] = "";
								} else {
									switch( GA145cell[j].getCellType() ) {
										case NUMERIC:
											GA145val[j] = String.valueOf(new BigDecimal(Double.valueOf(GA145cell[j].getNumericCellValue())));
											break;
										case STRING:
											GA145val[j] = GA145cell[j].getStringCellValue();
											break;
										default :
											GA145val[j] = "";
											break;
									}
								}
							}
						} else {
							GA145val[j] = "";
						}
					} else {
						GA145val[j] = "";
					}
				}

				if ( !StringUtils.isEmpty(GA145val[0]) ) {
					ChkDataYn = "Y";
				}

				while ( "Y".equals(ChkDataYn) ) {

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA145val[0]);      //제재일자
					iObj.put("DATA_TITE02", GA145val[1]);      //원인
					iObj.put("DATA_TITE03", GA145val[2]);      //제재내용
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);

					for ( int h = 0; h < 3; h++ ) {
						GA145val[h] = "";
					}

					i = ++i;

					for ( int k = 0; k < 3; k++) {
						if ( (sheetGA145.getRow(i) == null) == false ) {
							if ( (sheetGA145.getRow(i).getCell(k) == null) == false ) {
								GA145cell[k] = sheetGA145.getRow(i).getCell(k);

								Log.logAML(Log.DEBUG, this, GA145cell[k]);

								if (GA145cell[k] != null) {
									if ( GA145cell[k].getCellType() == CellType.BLANK ) {
										GA145val[k] = "";
									} else {
										switch( GA145cell[k].getCellType() ) {
											case NUMERIC:
												GA145val[k] = String.valueOf(new BigDecimal(Double.valueOf(GA145cell[k].getNumericCellValue())));
												break;
											case STRING:
												GA145val[k] = GA145cell[k].getStringCellValue();
												break;
											default :
												GA145val[k] = "";
												break;
										}
									}
								}
							} else {
								GA145val[k] = "";
							}
						} else {
							GA145val[k] = "";
						}
					}

					if ( StringUtils.isEmpty(GA145val[0]) ) {
						//ChkDataYn = "Y";
						ChkDataYn = "N";
					} else {
						//ChkDataYn = "N";
						ChkDataYn = "Y";
					}
				}
				/*******************************
				 *  2018.08.10 KDO 수정 end
				 ******************************/

				//------------RBA_업무보고서_월별관리------------------------------------------------------
				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 수익자별 판매 현황(GA160)
			if("Y".equals(req.getParameter("GA160")) && workbook.getSheet("GA160") != null ) {

				BIZ_RPT_ID = "GA160";
				sno = 0;
				//XSSFSheet sheetGA160 = workbook.getSheet("GA160");
				Sheet sheetGA160 = workbook.getSheet("GA160");

				//XSSFRow rowGA160 = null;
				Row rowGA160 = null;

				Cell[] GA160cell = new Cell[24];
				String[] GA160valnvlStr = new String[3];
				double[] GA160valnvlDbl = new double[21];

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 12; i < 137; i++) {
					rowGA160 = sheetGA160.getRow(i);

					for ( int j = 0; j < 24; j++) {
						GA160cell[j] = rowGA160.getCell(j);
						if ( j < 3 ) {
							if ( GA160cell[j] == null ) { GA160valnvlStr[j] = ""; } else { GA160valnvlStr[j] = GA160cell[j].getStringCellValue(); }
						} else {
							if ( GA160cell[j] == null || GA160cell[j].getCellType() == CellType.STRING ) {
								GA160valnvlDbl[j-3] = 0;
							} else {
								GA160valnvlDbl[j-3] = GA160cell[j].getNumericCellValue();
							}
						}
					}

					//GA179cell5 = rowGA179.getCell(4);
					//if ( GA179cell1 == null ) { GA179val1nvl = ""; } else { GA179val1nvl = GA179cell1.getStringCellValue(); };

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA160valnvlStr[0]);
					iObj.put("DATA_TITE02", GA160valnvlStr[1]);
					iObj.put("DATA_TITE03", GA160valnvlStr[2]);
					rtnVal(iObj, GA160valnvlDbl[0], "DATA01");	    //공모
					rtnVal(iObj, GA160valnvlDbl[1], "DATA02");	    //사모
					rtnVal(iObj, GA160valnvlDbl[2], "DATA03");	    //계
					rtnVal(iObj, GA160valnvlDbl[3], "DATA04");	    //공모
					rtnVal(iObj, GA160valnvlDbl[4], "DATA05");	    //사모
					rtnVal(iObj, GA160valnvlDbl[5], "DATA06");	    //계
					rtnVal(iObj, GA160valnvlDbl[6], "DATA07");	    //공모
					rtnVal(iObj, GA160valnvlDbl[7], "DATA08");	    //사모
					rtnVal(iObj, GA160valnvlDbl[8], "DATA09");	    //계
					rtnVal(iObj, GA160valnvlDbl[9], "DATA10");	    //공모
					rtnVal(iObj, GA160valnvlDbl[10], "DATA11");	    //사모
					rtnVal(iObj, GA160valnvlDbl[11], "DATA12");	    //계
					rtnVal(iObj, GA160valnvlDbl[12], "DATA13");	    //공모
					rtnVal(iObj, GA160valnvlDbl[13], "DATA14");	    //사모
					rtnVal(iObj, GA160valnvlDbl[14], "DATA15");	    //계
					rtnVal(iObj, GA160valnvlDbl[15], "DATA16");	    //공모
					rtnVal(iObj, GA160valnvlDbl[16], "DATA17");	    //사모
					rtnVal(iObj, GA160valnvlDbl[17], "DATA18");	    //계
					rtnVal(iObj, GA160valnvlDbl[18], "DATA19");	    //공모
					rtnVal(iObj, GA160valnvlDbl[19], "DATA20");	    //사모
					rtnVal(iObj, GA160valnvlDbl[20], "DATA21");	    //계
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 투자자문 계약현황(GA179)
			if("Y".equals(req.getParameter("GA179")) && workbook.getSheet("GA179") != null ) {

				BIZ_RPT_ID = "GA179";
				sno = 0;
				//XSSFSheet sheetGA179 = workbook.getSheet("GA179");
				Sheet sheetGA179 = workbook.getSheet("GA179");

				//XSSFRow rowGA179 = null;
				Row rowGA179 = null;

				Cell GA179cell1 = null;
				Cell GA179cell2 = null;
				Cell GA179cell3 = null;
				Cell GA179cell4 = null;
				Cell GA179cell5 = null;
				String GA179val1nvl = null;
				double GA179val2nvl = 0;
				double GA179val3nvl = 0;
				double GA179val4nvl = 0;
				double GA179val5nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 14; i++) {
					rowGA179 = sheetGA179.getRow(i);

					GA179cell1 = rowGA179.getCell(0);
					GA179cell2 = rowGA179.getCell(1);
					GA179cell3 = rowGA179.getCell(2);
					GA179cell4 = rowGA179.getCell(3);
					GA179cell5 = rowGA179.getCell(4);

					if ( GA179cell1 == null ) { GA179val1nvl = ""; } else { GA179val1nvl = GA179cell1.getStringCellValue(); }
					if ( GA179cell2 == null || GA179cell2.getCellType() == CellType.STRING ) { GA179val2nvl = 0; } else { GA179val2nvl = GA179cell2.getNumericCellValue(); }
					if ( GA179cell3 == null || GA179cell3.getCellType() == CellType.STRING ) { GA179val3nvl = 0; } else { GA179val3nvl = GA179cell3.getNumericCellValue(); }
					if ( GA179cell4 == null || GA179cell4.getCellType() == CellType.STRING ) { GA179val4nvl = 0; } else { GA179val4nvl = GA179cell4.getNumericCellValue(); }
					if ( GA179cell5 == null || GA179cell5.getCellType() == CellType.STRING ) { GA179val5nvl = 0; } else { GA179val5nvl = GA179cell5.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA179val1nvl);      //구분
					rtnVal(iObj, GA179val2nvl, "DATA01");	    //전월말
					rtnVal(iObj, GA179val3nvl, "DATA02");	    //당월말
					rtnVal(iObj, GA179val4nvl, "DATA03");	    //증가
					rtnVal(iObj, GA179val5nvl, "DATA04");	    //감소
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 자문 수수료 수입 현황(GA180)
			if("Y".equals(req.getParameter("GA180")) && workbook.getSheet("GA180") != null ) {

				BIZ_RPT_ID = "GA180";
				sno = 0;
				//XSSFSheet sheetGA180 = workbook.getSheet("GA180");
				Sheet sheetGA180 = workbook.getSheet("GA180");

				//XSSFRow rowGA180 = null;
				Row rowGA180 = null;

				Cell GA180cell1 = null;
				Cell GA180cell2 = null;
				Cell GA180cell3 = null;
				Cell GA180cell4 = null;
				Cell GA180cell5 = null;
				String GA180val1nvl = null;
				String GA180val2nvl = null;
				double GA180val3nvl = 0;
				double GA180val4nvl = 0;
				double GA180val5nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 20; i++) {
					rowGA180 = sheetGA180.getRow(i);

					GA180cell1 = rowGA180.getCell(0);
					GA180cell2 = rowGA180.getCell(1);
					GA180cell3 = rowGA180.getCell(2);
					GA180cell4 = rowGA180.getCell(3);
					GA180cell5 = rowGA180.getCell(4);

					if ( GA180cell1 == null ) { GA180val1nvl = ""; } else { GA180val1nvl = GA180cell1.getStringCellValue(); }
					if ( GA180cell2 == null ) { GA180val2nvl = ""; } else { GA180val2nvl = GA180cell2.getStringCellValue(); }
					if ( GA180cell3 == null || GA180cell3.getCellType() == CellType.STRING ) { GA180val3nvl = 0; } else { GA180val3nvl = GA180cell3.getNumericCellValue(); }
					if ( GA180cell4 == null || GA180cell4.getCellType() == CellType.STRING ) { GA180val4nvl = 0; } else { GA180val4nvl = GA180cell4.getNumericCellValue(); }
					if ( GA180cell5 == null || GA180cell5.getCellType() == CellType.STRING ) { GA180val5nvl = 0; } else { GA180val5nvl = GA180cell5.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA180val1nvl);      //구분
					iObj.put("DATA_TITE02", GA180val2nvl);      //구분
					rtnVal(iObj, GA180val3nvl, "DATA01");	    //전기말
					rtnVal(iObj, GA180val4nvl, "DATA02");	    //당기말
					rtnVal(iObj, GA180val5nvl, "DATA03");	    //증감
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 투자일임계약 현황(GA186)
			if("Y".equals(req.getParameter("GA186")) && workbook.getSheet("GA186") != null ) {

				BIZ_RPT_ID = "GA186";
				sno = 0;
				//XSSFSheet sheetGA186 = workbook.getSheet("GA186");
				Sheet sheetGA186 = workbook.getSheet("GA186");

				//XSSFRow rowGA186 = null;
				Row rowGA186 = null;

				Cell GA186cell1 = null;
				Cell GA186cell2 = null;
				Cell GA186cell3 = null;
				Cell GA186cell4 = null;
				Cell GA186cell5 = null;
				String GA186val1nvl = null;
				double GA186val2nvl = 0;
				double GA186val3nvl = 0;
				double GA186val4nvl = 0;
				double GA186val5nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 15; i++) {
					rowGA186 = sheetGA186.getRow(i);

					GA186cell1 = rowGA186.getCell(0);
					GA186cell2 = rowGA186.getCell(1);
					GA186cell3 = rowGA186.getCell(2);
					GA186cell4 = rowGA186.getCell(3);
					GA186cell5 = rowGA186.getCell(4);

					if ( GA186cell1 == null ) { GA186val1nvl = ""; } else { GA186val1nvl = GA186cell1.getStringCellValue(); }
					if ( GA186cell2 == null || GA186cell2.getCellType() == CellType.STRING ) { GA186val2nvl = 0; } else { GA186val2nvl = GA186cell2.getNumericCellValue(); }
					if ( GA186cell3 == null || GA186cell3.getCellType() == CellType.STRING ) { GA186val3nvl = 0; } else { GA186val3nvl = GA186cell3.getNumericCellValue(); }
					if ( GA186cell4 == null || GA186cell4.getCellType() == CellType.STRING ) { GA186val4nvl = 0; } else { GA186val4nvl = GA186cell4.getNumericCellValue(); }
					if ( GA186cell5 == null || GA186cell5.getCellType() == CellType.STRING ) { GA186val5nvl = 0; } else { GA186val5nvl = GA186cell5.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA186val1nvl);      //구분
					rtnVal(iObj, GA186val2nvl, "DATA01");	    //전월말
					rtnVal(iObj, GA186val3nvl, "DATA02");	    //당월말
					rtnVal(iObj, GA186val4nvl, "DATA03");	    //증가
					rtnVal(iObj, GA186val5nvl, "DATA04");	    //감소

					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------
				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 일임 수수료 수입 현황(GA187)
			if("Y".equals(req.getParameter("GA187")) && workbook.getSheet("GA187") != null ) {

				BIZ_RPT_ID = "GA187";
				sno = 0;
				//XSSFSheet sheetGA187 = workbook.getSheet("GA187");
				Sheet sheetGA187 = workbook.getSheet("GA187");

				//XSSFRow rowGA187 = null;
				Row rowGA187 = null;

				Cell GA187cell1 = null;
				Cell GA187cell2 = null;
				Cell GA187cell3 = null;
				Cell GA187cell4 = null;
				Cell GA187cell5 = null;
				String GA187val1nvl = null;
				String GA187val2nvl = null;
				double GA187val3nvl = 0;
				double GA187val4nvl = 0;
				double GA187val5nvl = 0;

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리관리------------------------------------------------------

				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				for ( int i = 11; i < 20; i++) {
					rowGA187 = sheetGA187.getRow(i);

					GA187cell1 = rowGA187.getCell(0);
					GA187cell2 = rowGA187.getCell(1);
					GA187cell3 = rowGA187.getCell(2);
					GA187cell4 = rowGA187.getCell(3);
					GA187cell5 = rowGA187.getCell(4);

					if ( GA187cell1 == null ) { GA187val1nvl = ""; } else { GA187val1nvl = GA187cell1.getStringCellValue(); }
					if ( GA187cell2 == null ) { GA187val2nvl = ""; } else { GA187val2nvl = GA187cell2.getStringCellValue(); }
					if ( GA187cell3 == null || GA187cell3.getCellType() == CellType.STRING ) { GA187val3nvl = 0; } else { GA187val3nvl = GA187cell3.getNumericCellValue(); }
					if ( GA187cell4 == null || GA187cell4.getCellType() == CellType.STRING ) { GA187val4nvl = 0; } else { GA187val4nvl = GA187cell4.getNumericCellValue(); }
					if ( GA187cell5 == null || GA187cell5.getCellType() == CellType.STRING ) { GA187val5nvl = 0; } else { GA187val5nvl = GA187cell5.getNumericCellValue(); }

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA187val1nvl);      //구분
					iObj.put("DATA_TITE02", GA187val2nvl);      //구분
					rtnVal(iObj, GA187val3nvl, "DATA01");	    //전기말
					rtnVal(iObj, GA187val4nvl, "DATA02");	    //당기말
					rtnVal(iObj, GA187val5nvl, "DATA03");	    //증감
					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);
				}

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

		    // 해외투자 현황(GA237)
			// 최초투자일이 숫자형식으로 입력될지, 문자형식으로 입력될지 몰라서 타입 체크하여 처리함.
			if("Y".equals(req.getParameter("GA237")) && workbook.getSheet("GA237") != null ) {

				BIZ_RPT_ID = "GA237";
				sno = 0;
				//XSSFSheet sheetGA237 = workbook.getSheet("GA237"); // test
				Sheet sheetGA237 = workbook.getSheet("GA237"); // test

				Cell GA237cell[] = new Cell[13];
				String GA237val[] = new String[13];
				String ChkDataYn = "N";

				HashMap iObj = new HashMap();

			    //------------RBA_업무보고서_데이터관리------------------------------------------------------
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete", iObj);

				/***********************************
				 *  2018.08.03 KDO 수정 start
				 ***********************************/
				int i = 12;

				if ((sheetGA237.getRow(i) == null) == false ) {
					for ( int j = 0; j < 13; j++) {
						//if ( sheetGA237.getRow(i).getCell(j) != null ) {
							GA237cell[j] = sheetGA237.getRow(i).getCell(j);
							Log.logAML(Log.DEBUG, this, GA237cell[j]);

							if ( (GA237cell[j] == null) == false ) {
								if ( GA237cell[j].getCellType() == CellType.BLANK ) {
									GA237val[j] = "";
								} else {
									switch( GA237cell[j].getCellType() ) {
										case NUMERIC:
											GA237val[j] = String.valueOf(new BigDecimal(Double.valueOf(GA237cell[j].getNumericCellValue())));
											Log.logAML(Log.DEBUG, this, GA237cell[j].getNumericCellValue());
											Log.logAML(Log.DEBUG, this, Double.valueOf(GA237cell[j].getNumericCellValue()));
											Log.logAML(Log.DEBUG, this, new BigDecimal(Double.valueOf(GA237cell[j].getNumericCellValue())));
											Log.logAML(Log.DEBUG, this, GA237val[j]);
											break;
										case STRING:
											GA237val[j] = GA237cell[j].getStringCellValue();
											break;
										default :
											GA237val[j] = "";
											break;
									}
								}
							} else {
								GA237val[j] = "";
							}
						//}
					}
					ChkDataYn = "Y";
				} else {
					//GA237val[0] = ""; //
					ChkDataYn = "N";
				}

				/* 라인의 처음 셀에 데이타가 있으면 계속 진행, 그렇지 않으면 종료 */
				/*if ( GA237val[0] != "" && GA237val[0] != null ) {
					ChkDataYn = "Y";
				}*/

				while ( "Y".equals(ChkDataYn) ) {

					sno = sno + 1;
					iObj.clear();
					iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
					iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
					iObj.put("SNO", sno);
					iObj.put("DATA_TITE01", GA237val[0]);      //구분
					iObj.put("DATA_TITE02", GA237val[1]);      //투자자
					iObj.put("DATA_TITE03", GA237val[2]);      //투자대상및 상세
					iObj.put("DATA_TITE04", GA237val[3]);      //거래목적
					iObj.put("DATA_TITE05", GA237val[4]);      //계정과목
					iObj.put("DATA01", GA237val[5]);      //취득원가(원화)
					iObj.put("DATA02", GA237val[6]);      //장부가액(원화)
					iObj.put("DATA03", GA237val[7]);      //통화종류
					iObj.put("DATA04", GA237val[8]);      //장부가액(외화)
					iObj.put("DATA05", GA237val[9]);      //관련손익(원화)
					iObj.put("DATA06", GA237val[10]);      //발행자명
					iObj.put("DATA07", GA237val[11]);      //국적
					iObj.put("DATA08", GA237val[12]);      //최초투자일

					iObj.put("DR_OP_JKW_NO", loginId);
					result = mDao.setData("RBA_50_10_01_02_doSaveGA", iObj);

					for ( int h = 0; h < 13; h++ ) {
						GA237val[h] = "";
					}

					i = ++i;

					if ( (sheetGA237.getRow(i) == null) == false ) {
						for ( int k = 0; k < 13; k++) {
							//if ( sheetGA237.getRow(i).getCell(k) != null) {
								GA237cell[k] = sheetGA237.getRow(i).getCell(k);

								Log.logAML(Log.DEBUG, this, GA237cell[k]);

								if ((GA237cell[k] == null) == false) {
									if ( GA237cell[k].getCellType() == CellType.BLANK ) {
										GA237val[k] = "";
									} else {
										switch( GA237cell[k].getCellType() ) {
											case NUMERIC:
												GA237val[k] = String.valueOf(new BigDecimal(Double.valueOf(GA237cell[k].getNumericCellValue())));
												Log.logAML(Log.DEBUG, this, GA237cell[k].getNumericCellValue());
												Log.logAML(Log.DEBUG, this, Double.valueOf(GA237cell[k].getNumericCellValue()));
												Log.logAML(Log.DEBUG, this, new BigDecimal(Double.valueOf(GA237cell[k].getNumericCellValue())));
												Log.logAML(Log.DEBUG, this, GA237val[k]);
												break;
											case STRING:
												GA237val[k] = GA237cell[k].getStringCellValue();
												Log.logAML(Log.DEBUG, this, GA237val[k]);
												break;
											default :
												GA237val[k] = "";
												break;
										}
									}
								} else {
									GA237val[k] = "";
								}
							//}
						}
						ChkDataYn = "Y";
					} else {
						//GA237val[0] = "";
						ChkDataYn = "N";
					}

					/*if ( GA237val[0] != "" && GA237val[0] != null ) {
						ChkDataYn = "Y";
					} else {
						ChkDataYn = "N";
					}*/
				}

				/***********************************
				 *  2018.08.03 KDO 수정 end
				 ***********************************/

				//------------RBA_업무보고서_월별관리------------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				mDao.setData("RBA_50_10_01_02_delete2", iObj);

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("LST_ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_YN", 1);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSave2", iObj);

				//------------RBA_업무보고서_첨부파일관리---------------------------------------------------

				iObj.clear();
				iObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
				iObj.put("BIZ_RPT_ID", BIZ_RPT_ID);
				iObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
				iObj.put("DR_OP_JKW_NO", loginId);
				result = mDao.setData("RBA_50_10_01_02_doSaveRpt", iObj);
			}

			rObj.put("BAS_YYMM", req.getString("RPT_GJDT").replace("-", ""));
			rObj.put("ATTCH_FILE_NO", ATTCH_FILE_NO);
			rObj.put("DR_OP_JKW_NO", loginId);
			result = mDao.setData("RBA_50_10_01_02_doSaveFileNo", rObj);


			mDao.commit();

			//File uploadFile = new File(newFilePathName);
			//uploadFile.delete();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", helper.getLangType(), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", helper.getLangType(), "정상처리되었습니다"));

		} catch (FileNotFoundException ioe) {
			mDao.rollback();
			Log.logAML(Log.ERROR,this,"doSave(FileNotFoundException)",ioe.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ioe.toString());
		} catch (EncryptedDocumentException ioe) {
			mDao.rollback();
			Log.logAML(Log.ERROR,this,"doSave(EncryptedDocumentException)",ioe.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ioe.toString());
		} catch (IOException ioe) {
			mDao.rollback();
			Log.logAML(Log.ERROR,this,"doSave(IOException)",ioe.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ioe.toString());
			
		} catch (AMLException e) {
			mDao.rollback();
			Log.logAML(Log.ERROR, this.getClass(), "doSave(Exception)", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", lang_Cd, "처리중 오류가 발생하였습니다."));
		} finally {
		    if (mDao != null) {
		    	mDao.close();
		    }
		    try {
				if(fis != null) {
				    fis.close();
				}
		    } catch (IOException e) {
		    	Log.logAML(Log.ERROR, this.getClass(), "doSave(Exception)", e.getMessage());
		    }
		}
		return output;
	}

	// 그리드에 수치 표현시
	// 수치가 8자리부터는 double형이 지수로 표현해서 BigDecimal 로 변환 ex) 엑셀 : 1234567890   double : 1.234567E7  BigDecimal : 1234567890
	// 수치가 1미만인 경우, ex)엑셀 : 0.3  double : 0.3  BigDecimal : 0.2999998....
	public void rtnVal(HashMap<Object, Object> rtnObj, double compVal, String valName) {
		if ( compVal >= 1 || compVal <= -1 ) {
			Log.logAML(Log.DEBUG, this, new BigDecimal(Double.toString(compVal)));
			rtnObj.put(valName,      new BigDecimal(Double.toString(compVal)));	 /* 2018.08.03 KDO 수정 */
		} else if ( compVal == 0) {
			rtnObj.put(valName,      "0");
		} else {
			rtnObj.put(valName,      compVal);
		}
	}
}
