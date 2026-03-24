package com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_03;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.basic.common.util.DateUtil;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtil;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.config.ServerConfig;
import com.gtone.express.server.helper.MessageHelper;
import com.itplus.common.server.user.SessionHelper;

import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description RBA 위험평가결과 보고 (KPMG 저축은행 버전)
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     RBA
 * @Java        6.0 이상
 * @Author      정성원
 * @Since       2019. 04. 03.
 ******************************************************************************************************************************************/

public class RBA_50_07_03_02 extends GetResultObject {

	private static RBA_50_07_03_02 instance = null;
	/**
	 * getInstance
	 * @return RBA_50_07_03_01
	 */
	public static  RBA_50_07_03_02 getInstance() {
		synchronized(RBA_50_07_03_02.class) {
		    if (instance == null) {
			    instance = new RBA_50_07_03_02();
		    }
		}
		return instance;
	}

	//엑셀 다운로드
	public DataObj makeExcelFile(DataObj input) {
		DataObj output = null;
		boolean isNull = true;
		String ERR_CTNT ="";

		try {
			String START_DY_TM = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
			String BAS_YYMM = input.getText("BAS_YYMM");
			String BAS_YYMM2 = input.getText("BAS_YYMM2");
			String IMPRV_RSLT_CTNT = input.getText("IMPRV_RSLT_CTNT");

			String path = ServerConfig.getInstance().getProperty("RBA_KPMG_FILE_PATH");
			String initFile = ServerConfig.getInstance().getProperty("RBA_KPMG_INIT_FILE");
			String tempFile = ServerConfig.getInstance().getProperty("RBA_KPMG_TEMP_FILE");
			String compFile = BAS_YYMM2 + "_" + BAS_YYMM + "_" + ServerConfig.getInstance().getProperty("RBA_KPMG_COMP_FILE");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&gt;", ">");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&lt;", "<");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&quot;", "");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&nbsp;", " ");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&amp;", "&");

			String inputPath = path + initFile;
        	String outputPath = path + tempFile;

        	input.put("FILE_POS", path);
        	input.put("FILE_NAME", compFile);

        	System.out.println("####보고파일 생성경로 업데이트 시작####");

        	output = doUpdate(input);
			if ( !"00000".equals(output.get("ERRCODE")) ) {
				return output;
			}

			System.out.println("####보고파일 생성경로 업데이트 끝####");

        	//로그 insert  RBA_RPT_MK_S_C:2 진행중
        	String RBA_RPT_MK_S_C = "2";
        	String SRBA_RPT_MK_DT =com.gtone.express.util.DateUtil.getCurrentTime();

        	input.put("RBA_RPT_MK_S_C", RBA_RPT_MK_S_C);
        	input.put("SRBA_RPT_MK_DT", SRBA_RPT_MK_DT);

        	//MDaoUtilSingle.setData("RBA_50_07_03_01_logStart",input);

        	ExcelMain mc = new ExcelMain(inputPath, outputPath);	//저장된 템플릿파일을 복사해서 새로운 파일생성
        	ExcelMain mc2 = new ExcelMain(outputPath, outputPath);	//위에서 생성된 파일을 수정해서 동일한 파일에 덮어씌우기

        	//새로운 엑셀파일을 만들기전에 기존에 만들어놨던 엑셀파일 삭제
        	mc.fileDelete(outputPath);
        	mc.fileDelete(path + compFile);

        	//init엑셀파일을 temp파일로 복사
        	mc.fileCopy(inputPath, outputPath);

        	// sample
        	output = new DataObj();
        	List<Object> row_arr = null;
        	List<Object> col_arr = null;
        	List<Object> cntnt_arr = null;

    		/*isNull = false;
    		row_arr = mc2.setList(4, 8, 12, null, null, null, null, null, null, null);
    		col_arr = mc2.setList(2, 2, 2, null, null, null, null, null, null, null);
    		cntnt_arr = mc2.setList("est", "tt"
    				, "tttt", null, null, null, null, null, null, null);

    		mc2.setValues(1, row_arr, col_arr, cntnt_arr);
    		output.clear();*/

    		//보고일자 표시//////////////////////////////////////////
    		isNull = false;
    		row_arr = mc2.setList(2, null, null, null, null, null, null, null, null, null);
    		col_arr = mc2.setList(5, null, null, null, null, null, null, null, null, null);
    		cntnt_arr = mc2.setList(BAS_YYMM2, null, null, null, null, null, null, null, null, null);

    		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
    		output.clear();

    		//기준일자 표시//////////////////////////////////////////
    		isNull = false;
    		row_arr = mc2.setList(2, null, null, null, null, null, null, null, null, null);
    		col_arr = mc2.setList(14, null, null, null, null, null, null, null, null, null);
    		cntnt_arr = mc2.setList(BAS_YYMM, null, null, null, null, null, null, null, null, null);

    		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
    		output.clear();

    		//최근회차 표시////////////////////////////////////////// 201904

    		Date dat = new SimpleDateFormat("yyyyMM").parse(BAS_YYMM);
    		Calendar cal = Calendar.getInstance();
    		cal.setTime(dat);
    		cal.add(Calendar.MONTH, -5); //6개월 전
    		Date befor6Mon = cal.getTime();
    		String befor6 = new SimpleDateFormat("yyyyMM").format(befor6Mon);

    		int year1 = Integer.parseInt(befor6.substring(0,4));
    		int month1 = Integer.parseInt(befor6.substring(4,6));

    		int year = Integer.parseInt(BAS_YYMM.substring(0,4));
    		int month = Integer.parseInt(BAS_YYMM.substring(4,6));

    		String baseMonth = "최근회차 ("+year1+"년"+month1+"월 ~"+year+"년"+month+"월"+")";

    		isNull = false;
    		row_arr = mc2.setList(16, null, null, null, null, null, null, null, null, null);
    		col_arr = mc2.setList(3, null, null, null, null, null, null, null, null, null);
    		cntnt_arr = mc2.setList(baseMonth, null, null, null, null, null, null, null, null, null);

    		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
    		output.clear();

    		//직전회차
    		cal.add(Calendar.MONTH, -1);
    		Date befor7Mon = cal.getTime();
    		String befor7 = new SimpleDateFormat("yyyyMM").format(befor7Mon);
    		cal.add(Calendar.MONTH, -5);
    		Date befor12Mon = cal.getTime();
    		String befor12 = new SimpleDateFormat("yyyyMM").format(befor12Mon);

    		int year3 = Integer.parseInt(befor7.substring(0,4));
    		int month3 = Integer.parseInt(befor7.substring(4,6));

    		int year4 = Integer.parseInt(befor12.substring(0,4));
    		int month4 = Integer.parseInt(befor12.substring(4,6));

    		String baseMonth2 = "직전회차 ("+year4+"년"+month4+"월 ~"+year3+"년"+month3+"월"+")";

    		isNull = false;
    		row_arr = mc2.setList(16, null, null, null, null, null, null, null, null, null);
    		col_arr = mc2.setList(15, null, null, null, null, null, null, null, null, null);
    		cntnt_arr = mc2.setList(baseMonth2, null, null, null, null, null, null, null, null, null);

    		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
    		output.clear();


    		//1.RBA 위험평가 수행 내역//////////////////////////////////////////
    		output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch1", input);
    		int idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
	    		isNull = false;
	    		row_arr = mc2.setList(9+idx, 9+idx, 9+idx, 9+idx, 9+idx, 9+idx, 9+idx, 9+idx, 9+idx, null);
	    		col_arr = mc2.setList(3, 6, 10, 13, 16, 19, 21, 23, 26, null);
	    		cntnt_arr = mc2.setList(output.getText("BAS_YYMM", i), output.getText("DUE", i), Double.parseDouble(output.getText("BRNO", i))
	    				, Double.parseDouble(output.getText("RSK_VALT_PNT", i)), Double.parseDouble(output.getText("TONGJE_VALT_PNT", i))
	    				, Double.parseDouble(output.getText("REMDR_RSK_PNT", i)), output.getText("REMDR_RSK_GD_C_NM", i)
	    				, Double.parseDouble(output.getText("BEFORE_REMDR_RSK_PNT", i)), Double.parseDouble(output.getText("DIFFER", i)), null);

	    		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
	    		idx++;
        	}
    		output.clear();

    		//2-1. RBA 위험평가 주요 5개 지점별 상세내역/////////////////////////////
    		output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch2_1", input);
    		idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
	    		isNull = false;
	    		row_arr = mc2.setList(19+idx, 19+idx, 19+idx, 19+idx, 19+idx, null, null, null, null, null);
	    		col_arr = mc2.setList(3, 6, 9, 11, 13, null, null, null, null, null);
	    		cntnt_arr = mc2.setList(output.getText("DPRT_NM", i), Double.parseDouble(output.getText("RSK_VALT_PNT", i)), Double.parseDouble(output.getText("TONGJE_VALT_PNT", i))
	    				, Double.parseDouble(output.getText("REMDR_RSK_PNT", i)), output.getText("REMDR_RSK_GD_C_NM1", i), null, null, null, null, null);

	    		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
	    		idx++;
        	}
    		output.clear();

    		//2-1. RBA 위험평가 주요 5개 지점별 상세내역/////////////////////////////
    		output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch2_2", input);
    		idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
	    		isNull = false;
	    		row_arr = mc2.setList(19+idx, 19+idx, 19+idx, 19+idx, 19+idx, null, null, null, null, null);
	    		col_arr = mc2.setList(15, 18, 21, 24, 26, null, null, null, null, null);
	    		cntnt_arr = mc2.setList(output.getText("DPRT_NM2", i), Double.parseDouble(output.getText("RSK_VALT_PNT2", i)), Double.parseDouble(output.getText("TONGJE_VALT_PNT2", i))
	    				, Double.parseDouble(output.getText("REMDR_RSK_PNT2", i)), output.getText("REMDR_RSK_GD_C_NM2", i), null, null, null, null, null);

	    		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
	    		idx++;
        	}
    		output.clear();


    		//2-2. 전사 자금세탁 위험요소(ML/TF Risk Indicator) 발생 현황/////////
        	output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch3", input);
        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(30+idx, 30+idx, 30+idx, null, null, null, null, null, null, null);
        		col_arr = mc2.setList(13, 18, 23, null, null, null, null, null, null, null);
        		cntnt_arr = mc2.setList(Double.parseDouble(output.getText("CNT", i)), Double.parseDouble(output.getText("CNT2", i))
        				, Double.parseDouble(output.getText("DIFFER", i)), null, null, null, null, null, null, null);

        		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
        		idx++;
        	}

        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(30+idx, 30+idx, null, null, null, null, null, null, null, null);
        		col_arr = mc2.setList(32, 33, null, null, null, null, null, null, null, null);
        		cntnt_arr = mc2.setList(Double.parseDouble(output.getText("CNT", i)), Double.parseDouble(output.getText("CNT2", i))
        				, null, null, null, null, null, null, null, null);

        		mc2.setValues(2, row_arr, col_arr, cntnt_arr);
        		idx++;
        	}

    		//3. 결과 분석 및 개선 방향///////////////////////////////////////////////////////
    		isNull = false;
    		row_arr = mc2.setList(57, null, null, null, null, null, null, null, null, null);
    		col_arr = mc2.setList(2, null, null, null, null, null, null, null, null, null);
    		cntnt_arr = mc2.setList(IMPRV_RSLT_CTNT, null, null, null, null, null, null, null, null, null);

    		mc2.setValues(2, row_arr, col_arr, cntnt_arr);


    		String END_DY_TM = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        	//System.out.println("excel file update.... START_DY_TM ["+START_DY_TM+"] END_DY_TM ["+END_DY_TM+"]");

        	START_DY_TM = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        	mc2.fileCopy(path+tempFile, path+compFile);
        	END_DY_TM = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
        	//System.out.println("file copy complete.... START_DY_TM ["+START_DY_TM+"] END_DY_TM ["+END_DY_TM+"]");

        	if (isNull) {
        		output.put("ERRMSG", "선택한 기준년월에 데이터가 없습니다.");
        		output.put("WINMSG" , "선택한 기준년월에 데이터가 없습니다.");
        	} else {
        		output.put("ERRCODE", "00000");
        	}

		} catch (NumberFormatException e) {
			//e.printStackTrace();
			String RBA_RPT_MK_S_C = "9";
			ERR_CTNT=e.getMessage();
			input.put("ERR_CTNT", ERR_CTNT);
        	input.put("RBA_RPT_MK_S_C", RBA_RPT_MK_S_C);
        	//MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);

			Log.logAML(Log.ERROR, this, "makeExcelFile", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (ParseException e) {
			//e.printStackTrace();
			String RBA_RPT_MK_S_C = "9";
			ERR_CTNT=e.getMessage();
			input.put("ERR_CTNT", ERR_CTNT);
        	input.put("RBA_RPT_MK_S_C", RBA_RPT_MK_S_C);
        	//MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);

			Log.logAML(Log.ERROR, this, "makeExcelFile", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (IOException e) {
			//e.printStackTrace();
			String RBA_RPT_MK_S_C = "9";
			ERR_CTNT=e.getMessage();
			input.put("ERR_CTNT", ERR_CTNT);
			input.put("RBA_RPT_MK_S_C", RBA_RPT_MK_S_C);
			//MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);

			Log.logAML(Log.ERROR, this, "makeExcelFile", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (AMLException e) {
			//e.printStackTrace();
			String RBA_RPT_MK_S_C = "9";
			ERR_CTNT=e.getMessage();
			input.put("ERR_CTNT", ERR_CTNT);
        	input.put("RBA_RPT_MK_S_C", RBA_RPT_MK_S_C);
        	//MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);

			Log.logAML(Log.ERROR, this, "makeExcelFile", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output ;
	}

	public DataObj doSearch1(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch1", input);

			if (output.getCount("BAS_YYMM") > 0) {
				gdRes = Common.setGridData(output);
			}
			//else {
				//output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			//}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch1", ex.getMessage());
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
			output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch2", input);

			if (output.getCount("BAS_YYMM") > 0) {
				gdRes = Common.setGridData(output);
			}
			//else {
				//output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			//}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch2", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	public DataObj doSearch2_2(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch2_2", input);

			if (output.getCount("BAS_YYMM") > 0) {
				gdRes = Common.setGridData(output);
			}
			//else {
				//output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			//}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch2_2", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	public DataObj doSearch3(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;

		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch3", input);

			if (output.getCount("RSK_INDCT") > 0) {
				gdRes = Common.setGridData(output);
			}
			//else {
				//output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			//}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch3", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}

	public DataObj doSearch4(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		String date = DateUtil.getDateString();

		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_02_doSearch4", input);

			if (output.getCount("BAS_YYMM") > 0) {
				String filePath = output.get("FILE_POS").toString();
				String fileName = date + "_" + output.get("USER_FILE_NAME").toString();

				File file = new File(filePath+fileName);
			    if(file.exists()){
			    	output.put("FILE_EXIST", "Y");
			    }else{
			    	output.put("FILE_EXIST", "N");
			    }

				gdRes = Common.setGridData(output);
			}
			//else {
				//output.put("ERRMSG", MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
				//output.put("WINMSG" ,MessageHelper.getInstance().getMessage("0001", input.getText("LANG_CD"), "조회된 정보가 없습니다."));
			//}

			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);

		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "doSearch4", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}


	//개선사항 저장
	public DataObj doSave(DataObj input) {
		DataObj output = new DataObj();

		try {
			input.put("OP_JKW_NO", ((SessionHelper) input.get("SessionHelper")).getLoginId()); // 변경조작자번호

			String IMPRV_RSLT_CTNT = input.getText("IMPRV_RSLT_CTNT");

			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&gt;", ">");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&lt;", "<");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&quot;", "");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&nbsp;", " ");
			IMPRV_RSLT_CTNT = IMPRV_RSLT_CTNT.replaceAll("&amp;", "&");

			input.put("IMPRV_RSLT_CTNT", IMPRV_RSLT_CTNT);
			MDaoUtilSingle.setData("RBA_50_07_03_02_doMerge", input);

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSave", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}

		return output;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public DataObj doUpdate(DataObj input)  {
		DataObj output = new DataObj();
		MDaoUtil mDao = null;
		try {
			mDao = new MDaoUtil();
			mDao.begin();

			mDao.setData("RBA_50_07_03_02_doUpdate", input);

			//DB commit
			mDao.commit();

			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));

		} catch (AMLException ex) {
		    try{
                if ( mDao != null ) {
                    mDao.rollback();
                }
            }catch(AMLException ae){
                Log.logAML(Log.ERROR, this, "Exception", ae.getMessage());
                output = new DataObj();
                output.put("ERRCODE", "00001");
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
            }

			Log.logAML(Log.ERROR, this, "doUpdate", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		} catch (Exception ex) {
		    try{
                if ( mDao != null ) {
                    mDao.rollback();
                }
            }catch(AMLException ae){
                Log.logAML(Log.ERROR, this, "Exception", ae.getMessage());
                output = new DataObj();
                output.put("ERRCODE", "00001");
                output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
            }

			Log.logAML(Log.ERROR, this, "doUpdate", ex.getMessage());
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

}