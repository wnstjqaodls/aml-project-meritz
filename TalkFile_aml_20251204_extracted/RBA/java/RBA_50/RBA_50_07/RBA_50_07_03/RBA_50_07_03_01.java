package com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_03;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.gtone.aml.admin.AMLException;
import com.gtone.aml.basic.common.data.DataObj;
import com.gtone.aml.basic.common.log.Log;
import com.gtone.aml.common.Common;
import com.gtone.aml.common.action.GetResultObject;
import com.gtone.aml.dao.common.MDaoUtilSingle;
import com.gtone.express.server.config.ServerConfig;
import com.gtone.express.server.helper.MessageHelper;
import com.gtone.rba.server.type03.RBA_50.RBA_50_01.RBA_50_01_01.RBA_50_01_01_01;

import jspeed.base.util.StringHelper;
import kr.co.itplus.jwizard.dataformat.DataSet;

/******************************************************************************************************************************************
 * @Description RBA 위험평가결과 보고
 * @Group       GTONE, R&D센터/개발2본부
 * @Project     RBA
 * @Java        6.0 이상
 * @Author      권얼
 * @Since       2018. 5. 03.
 ******************************************************************************************************************************************/

public class RBA_50_07_03_01 extends GetResultObject {
	
	private static RBA_50_07_03_01 instance = null;
	/**
	 * getInstance
	 * @return RBA_50_07_03_01
	 */
	public static  RBA_50_07_03_01 getInstance() {
		synchronized(RBA_50_01_01_01.class) {  
	    	if (instance == null) {
			    instance = new RBA_50_07_03_01();
		    }
		}
		return instance;
	}
	
	//엑셀 다운로드
	public DataObj makeExcelFile(DataObj input) throws AMLException {
		DataObj output = null;
		boolean isNull = true;
		String ERR_CTNT ="";
		
		try {
			String START_DY_TM = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());
			String BAS_YYMM = input.getText("BAS_YYMM");
			
			String path = ServerConfig.getInstance().getProperty("RBA_KPMG_FILE_PATH");
			String initFile = ServerConfig.getInstance().getProperty("RBA_KPMG_INIT_FILE");
			String tempFile = ServerConfig.getInstance().getProperty("RBA_KPMG_TEMP_FILE");
			String compFile = BAS_YYMM + "_" + ServerConfig.getInstance().getProperty("RBA_KPMG_COMP_FILE");
			
			String inputPath = path + initFile;
        	String outputPath = path + tempFile;
        	
        	//로그 insert  RBA_RPT_MK_S_C:2 진행중
        	String RBA_RPT_MK_S_C = "2";
        	String SRBA_RPT_MK_DT =com.gtone.express.util.DateUtil.getCurrentTime();
        	
        	input.put("RBA_RPT_MK_S_C", RBA_RPT_MK_S_C);
        	input.put("SRBA_RPT_MK_DT", SRBA_RPT_MK_DT);
        	
        	MDaoUtilSingle.setData("RBA_50_07_03_01_logStart",input);
        	
        	ExcelMain mc = new ExcelMain(inputPath, outputPath);	//저장된 템플릿파일을 복사해서 새로운 파일생성
        	ExcelMain mc2 = new ExcelMain(outputPath, outputPath);	//위에서 생성된 파일을 수정해서 동일한 파일에 덮어씌우기
    		
        	//새로운 엑셀파일을 만들기전에 기존에 만들어놨던 엑셀파일 삭제
        	mc.fileDelete(outputPath);
        	mc.fileDelete(path + compFile);
        	
        	//init엑셀파일을 temp파일로 복사
        	mc.fileCopy(inputPath, outputPath);
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch", input);
        	
        	List<Object> row_arr = null;
        	List<Object> col_arr = null;
        	List<Object> cntnt_arr = null;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
//--------------------------  1. Executive Summary 시트 -----------------------------------        		
        		row_arr = mc2.setList(4, 8, 12, null, null, null, null, null, null, null);
        		col_arr = mc2.setList(2, 2, 2, null, null, null, null, null, null, null);
        		cntnt_arr = mc2.setList(output.getText("R1_AIM", i), output.getText("R1_VALT_RSLT", i)
        				, output.getText("R1_IMPRV_PLAN", i), null, null, null, null, null, null, null);
        		
        		mc2.setValues(3, row_arr, col_arr, cntnt_arr);
        		
//--------------------------  2. 자금세탁 위험평가 개요 시트 -----------------------------------
        		row_arr = mc2.setList(4, null, null, null, null, null, null, null, null, null);
        		col_arr = mc2.setList(2, null, null, null, null, null, null, null, null, null);
        		cntnt_arr = mc2.setList(output.getText("R2_AIM", i), null, null, null, null, null, null, null, null, null);
        		
        		mc2.setValues(4, row_arr, col_arr, cntnt_arr);
			}
        	output.clear();
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch3", input);
        	if (output.getCount("SNO") == 0) {
        		output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch3_1", input);
			}
        	
        	int idx = 0;
        	List<Object> lst = null;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		lst = mc2.setList(output.getText("SNO", i), output.getText("R2_BIZ_STEP", i), output.getText("R2_EXEC_CTNT", i)
        				, output.getText("R2_AML_BRNM", i), output.getText("R2_EXEC_DT", i), null, null, null, null, null);
        		
        		mc2.addRow(4, 11+idx, 2, lst);
        		idx++;
        	}
        	output.clear();
        	
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch2", input);
        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		lst = mc2.setList(output.getText("SNO", i), output.getText("R2_RULE", i), output.getText("R2_MAIN_CTNT", i)
        				, output.getText("R2_SRC", i), output.getText("R2_REVIS_DT", i), null, null, null, null, null);
        		
        		mc2.addRow(4, 8+idx, 2, lst);
        		idx++;
        	}
        	output.clear();
        	
//--------------------------  3. 회사 현황 시트 -----------------------------------
        	System.out.println("3. 회사 현황 시트");
			
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch4", input);
        	
        	String sysdate = new SimpleDateFormat("yyyy.MM.dd").format(new Date());
        	int FY = Integer.parseInt(BAS_YYMM.substring(0, 4));
        	row_arr = mc2.setList(6, 6, 6, null, null, null, null, null, null, null);
        	col_arr = mc2.setList(5, 8, 11, null, null, null, null, null, null, null);
        	cntnt_arr = mc2.setList("FY"+String.valueOf(FY-1), "FY"+String.valueOf(FY-2), "FY"+String.valueOf(FY-3), null, null, null, null, null, null, null);
        	mc2.setValues(5, row_arr, col_arr, cntnt_arr);
        	
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(4,7,7,7,8,8,8,9,9,9);
        		col_arr = mc2.setList(2,5,8,11,5,8,11,5,8,11);
        		cntnt_arr = mc2.setList(output.getText("R3_HIST", i), output.getText("R3_TOTAS1", i), output.getText("R3_TOTAS2", i)
        				, output.getText("R3_TOTAS3", i), output.getText("R3_EQCT1", i), output.getText("R3_EQCT2", i), output.getText("R3_EQCT3", i)
        				, output.getText("R3_FLLBT1", i), output.getText("R3_FLLBT2", i), output.getText("R3_FLLBT3", i));
        		
        		row_arr.addAll(mc2.setList(10,10,10,11,11,11,12,12,12,14));
        		col_arr.addAll(mc2.setList(5,8,11,5,8,11,5,8,11,5));
        		cntnt_arr.addAll(mc2.setList(output.getText("R3_FIX_LLBT1", i), output.getText("R3_FIX_LLBT2", i), output.getText("R3_FIX_LLBT3", i)
        				, output.getText("R3_FLAST1", i), output.getText("R3_FLAST2", i), output.getText("R3_FLAST3", i), output.getText("R3_NPRFIT1", i)
        				, output.getText("R3_NPRFIT2", i), output.getText("R3_NPRFIT3", i), output.getText("R3_TSLAMT1", i)));
				
        		row_arr.addAll(mc2.setList(14,14,15,15,15,16,16,16,17,17));
        		col_arr.addAll(mc2.setList(8,11,5,8,11,5,8,11,5,8));
        		cntnt_arr.addAll(mc2.setList(output.getText("R3_TSLAMT2", i), output.getText("R3_TSLAMT3", i), output.getText("R3_ECPRT1", i)
        				, output.getText("R3_ECPRT3", i), output.getText("R3_ECPRT2", i), output.getText("R3_DBTRT1", i), output.getText("R3_DBTRT2", i)
        				, output.getText("R3_DBTRT3", i), output.getText("R3_FLRT1", i), output.getText("R3_FLRT2", i)));
				
        		row_arr.addAll(mc2.setList(17,19,20,21,22,19,20,21,22,19));
        		col_arr.addAll(mc2.setList(11,4,4,4,4,7,7,7,7,10));
        		cntnt_arr.addAll(mc2.setList(output.getText("R3_FLRT3", i), output.getText("R3_PSON1", i), output.getText("R3_PSON2", i)
        				, output.getText("R3_PSON3", i), output.getText("R3_PSON4", i), output.getText("R3_PSON5", i), output.getText("R3_PSON6", i)
        				, output.getText("R3_PSON7", i), output.getText("R3_PSON8", i), output.getText("R3_PSON9", i)));
				
        		row_arr.addAll(mc2.setList(20,21,22,19,28,28,28,34,34,34));
        		col_arr.addAll(mc2.setList(10,10,10,13,2,5,8,2,5,8));
        		cntnt_arr.addAll(mc2.setList(output.getText("R3_PSON10", i), output.getText("R3_PSON11", i), output.getText("R3_PSON12", i)
        				, output.getText("R3_PSON13", i), output.getText("R3_AML_PSCN011", i), output.getText("R3_AML_PSCN012", i), output.getText("R3_AML_PSCN013", i)
        				, output.getText("R3_AML_PSCN021", i), output.getText("R3_AML_PSCN022", i), output.getText("R3_AML_PSCN023", i)));
				
        		row_arr.addAll(mc2.setList(40,40,46,46,46,52,52,58,58,58));
        		col_arr.addAll(mc2.setList(2,5,2,5,8,2,5,2,5,8));
        		cntnt_arr.addAll(mc2.setList(output.getText("R3_AML_PSCN031", i), output.getText("R3_AML_PSCN032", i), output.getText("R3_AML_PSCN041", i)
        				, output.getText("R3_AML_PSCN042", i), output.getText("R3_AML_PSCN043", i), output.getText("R3_AML_PSCN051", i), output.getText("R3_AML_PSCN052", i)
        				, output.getText("R3_AML_PSCN061", i), output.getText("R3_AML_PSCN062", i), output.getText("R3_AML_PSCN063", i)));
				
        		row_arr.addAll(mc2.setList(58,64,64,64,64,70,70,70,70,76));
        		col_arr.addAll(mc2.setList(11,2,5,8,11,2,5,8,11,2));
        		cntnt_arr.addAll(mc2.setList(output.getText("R3_AML_PSCN064", i), output.getText("R3_AML_PSCN071", i), output.getText("R3_AML_PSCN072", i)
        				, output.getText("R3_AML_PSCN073", i), output.getText("R3_AML_PSCN074", i), output.getText("R3_AML_PSCN081", i)
        				, output.getText("R3_AML_PSCN082", i), output.getText("R3_AML_PSCN083", i), output.getText("R3_AML_PSCN084", i), output.getText("R3_AML_PSCN091", i)));
				
        		row_arr.addAll(mc2.setList(76,76,82,82,87,92,92,96,null,null));
        		col_arr.addAll(mc2.setList(5,8,2,5,2,2,5,2,null,null));
        		cntnt_arr.addAll(mc2.setList(output.getText("R3_AML_PSCN092", i), output.getText("R3_AML_PSCN093", i), output.getText("R3_AML_PSCN101", i)
        				, output.getText("R3_AML_PSCN102", i), output.getText("R3_AML_PSCN111", i), output.getText("R3_AML_PSCN121", i)
        				, output.getText("R3_AML_PSCN122", i), output.getText("R3_AML_PSCN131", i), null, null));
        		
        		row_arr.addAll(mc2.setList(13,13,13,24,null,null,null,null,null,null));	// 엑셀 템플릿에서 매출원가의 DB테이블 컬럼 누락으로 개발이후 추가
        		col_arr.addAll(mc2.setList(5,8,11,13,null,null,null,null,null,null));
        		cntnt_arr.addAll(mc2.setList(output.getText("R3_COS1", i), output.getText("R3_COS2", i), output.getText("R3_COS3", i)
        				, sysdate, null, null, null, null, null, null));
        		
        		mc2.setValues(5, row_arr, col_arr, cntnt_arr);
			}
        	output.clear();
        	
//--------------------------  4. 자금세탁 위험평가 방법론 시트 ----------------------------------- 
        	System.out.println("4. 자금세탁 위험평가 방법론 시트");
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch5", input);
        	mc2.setGridCnt1(output.getCount());
        	List<Object> mergeSizeList = mc2.setList(0, 0, 0, 1, 0, 1, 3, null, null, null);
        	int addRow = 0;
        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		lst = mc2.setList(output.getText("PROC_LGDV_C", i), output.getText("PROC_LGDV_NM", i), output.getText("PROC_MDDV_C", i)
        				, output.getText("PROC_MDDV_NM", i), output.getText("PROC_SMDV_C", i), output.getText("PROC_SMDV_NM", i)
        				, output.getText("RSK_CAUS_CTNT", i), null, null, null);
        		
        		mc2.addRow(6, 41+idx, 2, lst, "col", mergeSizeList);
        		idx++;
        	}
        	addRow = idx;
        	output.clear();
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch6", input);
        	mc2.setGridCnt2(output.getCount());
        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		lst = mc2.setList(output.getText("RSK_CATG", i), output.getText("RSK_CATG_NM", i), output.getText("RSK_FAC", i)
        				, output.getText("RSK_FAC_NM", i), output.getText("RSK_INDCT", i), output.getText("RSK_INDCT_NM", i)
        				, output.getText("DEDU_RSN", i), null, null, null);
        		
        		mc2.addRow(6, addRow+46+idx, 2, lst, "col", mergeSizeList);
        		idx++;
        	}
        	addRow += idx;
        	output.clear();
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch7", input);
        	mc2.setGridCnt3(output.getCount());
        	mergeSizeList = mc2.setList(0, 0, 0, 1, 0, 1, 1, 1, null, null);
        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		lst = mc2.setList(output.getText("TONGJE_FLD_C", i), output.getText("TONGJE_FLD_C_NM", i), output.getText("TONGJE_LGDV_C", i)
        				, output.getText("TONGJE_LGDV_C_NM", i), output.getText("TONGJE_MDDV_C", i), output.getText("TONGJE_MDDV_C_NM", i)
        				, output.getText("CNT", i), output.getText("N_CNT", i), null, null);
        		
        		mc2.addRow(6, addRow+51+idx, 2, lst, "col", mergeSizeList);
        		idx++;
        	}
        	output.clear();
        	
//--------------------------  5. 자금세탁 위험평가 -----------------------------------
        	System.out.println("5. 자금세탁 위험평가");
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch8", input);
        	idx = 0;
        	// 1. RBA 위험평가 수행 내역 개요 그리드의 로우가 2줄이면 상관없지만 계속 늘어나는 리스트형데이터라면 수정필요함 ==> 2건으로 고정.
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(6+idx, 6+idx, 6+idx, 6+idx, 6+idx, 6+idx, 6+idx, 6+idx, 6+idx, 6+idx);
        		row_arr.addAll(mc2.setList(6+idx, null, null, null, null, null, null, null, null, null));
        		col_arr = mc2.setList(2, 3, 5, 7, 9, 11, 13, 15, 17, 19);
        		col_arr.addAll(mc2.setList(20, null, null, null, null, null, null, null, null, null));
        		cntnt_arr = mc2.setList(output.getText("SEQ", i), output.getText("VALT_YYMM", i), output.getText("BRNO_CNT", i)
        				, output.getText("R5_RSK_R", i), output.getText("R5_RSK_Y", i), output.getText("R5_RSK_G", i), output.getText("R5_TONGJE_R", i)
        				, output.getText("R5_TONGJE_Y", i), output.getText("R5_TONGJE_G", i), output.getText("TRG_BRNO", i));
        		cntnt_arr.addAll(mc2.setList(output.getText("CMP_CNT", i), null, null, null, null, null, null, null, null, null));
        		
        		mc2.setValues(7, row_arr, col_arr, cntnt_arr);
        		idx++;
        		
        		if (idx == 2) {
        			break;
        		}
        	}
        	output.clear();
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch9", input);
        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(27+idx, 27+idx, 27+idx, 27+idx, 27+idx, 27+idx, 27+idx, null, null, null);
        		col_arr = mc2.setList(3, 4, 5, 7, 9, 10, 11, null, null, null);
        		cntnt_arr = mc2.setList(output.getText("RANK", i), output.getText("PROC_LGDV_NM", i), output.getText("PROC_MDDV_C_NM", i)
        				, output.getText("PROC_SMDV_NM", i), output.getDouble("RSK_VALT_PNT", i), output.getDouble("TONGJE_VALT_PNT", i)
        				, output.getDouble("REMDR_RSK_PNT", i), null, null, null);
        		
        		mc2.setValues(7, row_arr, col_arr, cntnt_arr);
        		idx++;
        	}
        	output.clear();
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch10", input);
        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(27+idx, 27+idx, 27+idx, 27+idx, 27+idx, 27+idx, null, null, null, null);
        		col_arr = mc2.setList(13, 14, 15, 16, 17, 18, null, null, null, null);
        		cntnt_arr = mc2.setList(output.getText("BRNO_NM", i), output.getDouble("RSK_VALT_PNT", i), output.getDouble("TONGJE_VALT_PNT", i)
        				, output.getDouble("REMDR_RSK_PNT", i), output.getText("VALT_BRNO", i), output.getText("CHG_VAL", i), null, null, null, null);
        		
        		mc2.setValues(7, row_arr, col_arr, cntnt_arr);
        		idx++;
        	}
        	output.clear();
        	
//--------------------------  6. 결과 -----------------------------------
        	System.out.println("6. 결과");
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch11", input);
        	idx = 0;
        	// 1. AML 업무 프로세스 別 상위 Top10 RBA 총 위험평가 내역
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(7+idx, 7+idx, 7+idx, 7+idx, 7+idx, 7+idx, 7+idx, 7+idx, 7+idx, 7+idx);
        		col_arr = mc2.setList(2, 3, 7, 10, 16, 18, 20, 22, 24, 26);
        		cntnt_arr = mc2.setList(output.getText("NUM", i), output.getText("PROC_LGDV_NM", i), output.getText("PROC_MDDV_NM", i)
        				, output.getText("PROC_SMDV_NM", i), output.getText("PNT3", i), output.getText("GD3", i), output.getText("PNT2", i)
        				, output.getText("GD2", i), output.getText("PNT1", i), output.getText("GD1", i));
        		
        		mc2.setValues(8, row_arr, col_arr, cntnt_arr);
        		idx++;
        	}
        	// 1. AML 업무 프로세스 別 상위 Top10 RBA 총 위험평가 내역 - 그리드 날짜컬럼(변경값) 
        	row_arr = mc2.setList(5, 5, 5, null, null, null, null, null, null, null);
        	col_arr = mc2.setList(16, 20, 24, null, null, null, null, null, null, null);
        	if (output.getCount() > 0) {
        		isNull = false;
        		cntnt_arr = mc2.setList(output.getText("BAS_YYMM3", 0)+"월", output.getText("BAS_YYMM2", 0)+"월", output.getText("BAS_YYMM1", 0)+"월(금년)"
        				, null, null, null, null, null, null, null);
        	} else {
        		cntnt_arr = mc2.setList("NO-DATA", "NO-DATA", "NO-DATA", null, null, null, null, null, null, null);
        	}
        	mc2.setValues(8, row_arr, col_arr, cntnt_arr);
        	output.clear();
        	
        	
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch12", input);
        	idx = 0;
        	// 2 AML 업무 프로세스 別 상위 Top10 RBA 통제 유효성 평가 결과
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(22+idx, 22+idx, 22+idx, 22+idx, 22+idx, 22+idx, 22+idx, 22+idx, 22+idx, 22+idx);
        		col_arr = mc2.setList(2, 3, 7, 10, 16, 18, 20, 22, 24, 26);
        		cntnt_arr = mc2.setList(output.getText("NUM", i), output.getText("PROC_LGDV_NM", i), output.getText("PROC_MDDV_NM", i)
        				, output.getText("PROC_SMDV_NM", i), output.getText("PNT3", i), output.getText("GD3", i), output.getText("PNT2", i)
        				, output.getText("GD2", i), output.getText("PNT1", i), output.getText("GD1", i));
        		
        		mc2.setValues(8, row_arr, col_arr, cntnt_arr);
        		idx++;
        	}
        	// 2 AML 업무 프로세스 別 상위 Top10 RBA 통제 유효성 평가 결과 - 그리드 날짜컬럼(변경값)
        	row_arr = mc2.setList(20, 20, 20, null, null, null, null, null, null, null);
        	col_arr = mc2.setList(16, 20, 24, null, null, null, null, null, null, null);
        	if (output.getCount() > 0) {
        		cntnt_arr = mc2.setList(output.getText("BAS_YYMM3", 0)+"월", output.getText("BAS_YYMM2", 0)+"월", output.getText("BAS_YYMM1", 0)+"월(금년)"
        				, null, null, null, null, null, null, null);
        	} else {
        		cntnt_arr = mc2.setList("NO-DATA", "NO-DATA", "NO-DATA", null, null, null, null, null, null, null);
        	}
        	mc2.setValues(8, row_arr, col_arr, cntnt_arr);
        	output.clear();
        	
        	
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch13", input);
        	idx = 0;
        	// 3. 잔여위험 평가 및 등급 상위 Top 10 부서 (위험도)
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(37+idx, 37+idx, 37+idx, 37+idx, 37+idx, 37+idx, 37+idx, 37+idx, 37+idx, 37+idx);
        		row_arr.addAll(mc2.setList(37+idx, 37+idx, 37+idx, null, null, null, null, null, null, null));
        		col_arr = mc2.setList(2, 3, 6, 8, 10, 12, 14, 16, 18, 20);
        		col_arr.addAll(mc2.setList(22, 24, 26, null, null, null, null, null, null, null));
        		cntnt_arr = mc2.setList(output.getText("NUM", i), output.getText("VALT_BRNO_NM", i), output.getText("RSK_PNT3", i)
        				, output.getText("TONGJE_PNT3", i), output.getText("REMDR_PNT3", i), output.getText("REMDR_GD3", i), output.getText("RSK_PNT2", i)
        				, output.getText("TONGJE_PNT2", i), output.getText("REMDR_PNT2", i), output.getText("REMDR_GD2", i));
        		cntnt_arr.addAll(mc2.setList(output.getText("REMDR_PNT1", i), output.getText("REMDR_GD1", i), output.getText("CHG_PNT", i)
        				, null, null, null, null, null, null, null));
        		
        		mc2.setValues(8, row_arr, col_arr, cntnt_arr);
        		idx++;
        	}
        	// 3. 잔여위험 평가 및 등급 상위 Top 10 부서 (위험도) - 그리드 날짜컬럼(변경값)
        	row_arr = mc2.setList(35, 35, 35, null, null, null, null, null, null, null);
        	col_arr = mc2.setList(6, 14, 22, null, null, null, null, null, null, null);
        	if (output.getCount() > 0) {
        		cntnt_arr = mc2.setList(output.getText("BAS_YYMM3", 0)+"월", output.getText("BAS_YYMM2", 0)+"월", output.getText("BAS_YYMM1", 0)+"월(금년)"
        				, null, null, null, null, null, null, null);
        	} else {
        		cntnt_arr = mc2.setList("NO-DATA", "NO-DATA", "NO-DATA", null, null, null, null, null, null, null);
        	}
        	mc2.setValues(8, row_arr, col_arr, cntnt_arr);
        	output.clear();
        	
        	
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch14", input);
        	idx = 0;
        	// 4. 주요 위험지표 (KRI : Key Risk Indicator) 상위 Top5 위험 모니터링 결과
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(52+idx, 52+idx, 52+idx, 52+idx, 52+idx, 52+idx, 52+idx, 52+idx, 52+idx, 52+idx);
        		row_arr.addAll(mc2.setList(52+idx, 52+idx, 52+idx, 52+idx, 52+idx, 52+idx, null, null, null, null));
        		col_arr = mc2.setList(2, 3, 7, 10, 16, 17, 18, 19, 20, 21);
        		col_arr.addAll(mc2.setList(22, 23, 24, 25, 26, 27, null, null, null, null));
        		cntnt_arr = mc2.setList(output.getText("SEQ", i), output.getText("RSK_CATG_NM", i), output.getText("RSK_FAC_NM", i)
        				, output.getText("RSK_INDCT_NM", i), output.getInt("TAB1", i), output.getInt("TAB2", i), output.getInt("TAB3", i)
        				, output.getInt("TAB4", i), output.getInt("TAB5", i), output.getInt("TAB6", i));
        		cntnt_arr.addAll(mc2.setList(output.getInt("TAB7", i), output.getInt("TAB8", i), output.getInt("TAB9", i)
        				, output.getInt("TAB10", i), output.getInt("TAB11", i), output.getInt("TAB12", i), null, null, null, null));
        		
        		mc2.setValues(8, row_arr, col_arr, cntnt_arr);
        		idx++;
        	}
        	// 4. 주요 위험지표 (KRI : Key Risk Indicator) 상위 Top5 위험 모니터링 결과 - 그리드 날짜컬럼(변경값)
        	row_arr = mc2.setList(51, 51, 51, 51, 51, 51, 51, 51, 51, 51);
        	row_arr.addAll(mc2.setList(51, 51, null, null, null, null, null, null, null, null));
        	col_arr = mc2.setList(16, 17, 18, 19, 20, 21, 22, 23, 24, 25);
        	col_arr.addAll(mc2.setList(26, 27, null, null, null, null, null, null, null, null));
        	if (output.getCount() > 0) {
        		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
            	Date date = sdf.parse(BAS_YYMM); 
            	
            	Calendar cal = Calendar.getInstance();
                cal.setTime(date);
                cal.add(Calendar.MONTH, -1);
                Date date2 = cal.getTime();
            	String BAS_YYMM2 = sdf.format(date2);	// 기준년월 -1개월
            	
            	String year1 = BAS_YYMM2.substring(0, 4);
            	String year2 = String.valueOf(Integer.parseInt(BAS_YYMM2.substring(0, 4))-1);
            	String month = BAS_YYMM2.substring(4, 6);
            	
            	String[] months = {"01","02","03","04","05","06","07","08","09","10","11","12"};
            	String[] temp = new String[12];
            	int index = 0;
    			for (int i = 0; i < months.length; i++) {
    				if (month.equals(months[i])) {
    					index = i;
    					break;
    				}
    			}
    			// 선택한 평가기준월에 따라 그리드에 보여지는 컬럼값 셋팅
    			int index2 = 0;
    			for (int i = index; i >= 0; i--) {
    				if (i == index) {
    					temp[index2] = year1+"年 "+Integer.parseInt(months[i]);
    				} else {
    					temp[index2] = String.valueOf(Integer.parseInt(months[i]));
    				}
    				index2++;
    			}
    			for (int i = months.length-1; i > index; i--) {
    				if (i == months.length-1) {
    					temp[index2] = year2+"年 "+Integer.parseInt(months[i]);
    				} else {
    					temp[index2] = String.valueOf(Integer.parseInt(months[i]));
    				}
    				index2++;
    			}
        		
        		cntnt_arr = mc2.setList(temp[0]+"月", temp[1]+"月", temp[2]+"月", temp[3]+"月", temp[4]+"月", temp[5]+"月", temp[6]+"月", temp[7]+"月", temp[8]+"月", temp[9]+"月");
        		cntnt_arr.addAll(mc2.setList(temp[10]+"月", temp[11]+"月", null, null, null, null, null, null, null, null));
        		
        	} else {
        		cntnt_arr = mc2.setList("1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月");
        		cntnt_arr.addAll(mc2.setList("11月", "12月", null, null, null, null, null, null, null, null));
        	}
        	mc2.setValues(8, row_arr, col_arr, cntnt_arr);
        	output.clear();
        	
        	
//--------------------------  7. 주요 발견사항 및 개선사항 -----------------------------------
        	System.out.println("7. 주요 발견사항 및 개선사항");
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch16", input);
        	//2. 향후 추진과제 및 발전방향
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(10, 12, 14, 16, null, null, null, null, null, null);
        		col_arr = mc2.setList(2, 2, 2, 2, null, null, null, null, null, null);
        		cntnt_arr = mc2.setList(output.getText("R3_SUMMY", i), output.getText("R7_TASK", i), output.getText("R7_PLAN", i)
        				, output.getText("R7_DIREC", i), null, null, null, null, null, null);
        		
        		mc2.setValues(9, row_arr, col_arr, cntnt_arr);
        	}
        	output.clear();
        	
        	//1. AML 업무 프로세스 別 개선사항 수립 내역
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch15", input);
        	mergeSizeList = mc2.setList(0, 3, 2, 5, 1, 7, 1, null, null, null);
        	idx = 0;
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		lst = mc2.setList(output.getText("SEQ", i), output.getText("PROC_LGDV_NM", i), output.getText("PROC_MDDV_NM", i)
        				, output.getText("PROC_SMDV_NM", i), output.getText("BRNO_NM", i), output.getText("IMPRV_RSLT_CTNT", i)
        				, output.getText("DR_DT", i), null, null, null);
        		
        		mc2.addRow(9, 7+idx, 2, lst, "col", mergeSizeList);
        		idx++;
        	}
        	output.clear();
            
        	RBA_RPT_MK_S_C = "1";
        	input.put("RBA_RPT_MK_S_C", RBA_RPT_MK_S_C);
        	
        	MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);        	
//--------------------------  8. 별첨 -----------------------------------
        	System.out.println("8. 별첨");
        	
        	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch17", input);
        	
        	for (int i = 0; i < output.getCount(); i++) {
        		isNull = false;
        		row_arr = mc2.setList(7, null, null, null, null, null, null, null, null, null);
        		col_arr = mc2.setList(2, null, null, null, null, null, null, null, null, null);
        		cntnt_arr = mc2.setList(output.getText("R8_ETC_LIST", i), null, null, null, null, null, null, null, null, null);
        		
        		mc2.setValues(10, row_arr, col_arr, cntnt_arr);
        	}
        	output.clear();
        	
//----------------- # 4.자금세탁 위험평가 방법론 인쇄영역 셋팅 ----------------
        	/*
        	mc2.setStartColIdx1(mc2.getValue(6, 2, "[별첨 1] AML 업무 프로세스 목록"));
        	mc2.setStartColIdx2(mc2.getValue(6, 2, "[별첨 2] 자금세탁 위험요소 목록"));
        	mc2.setStartColIdx3(mc2.getValue(6, 2, "[별첨 3] 내부통제 점검항목 목록"));
        	mc2.setExcelPrintArea();
        	*/
        	
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
        	MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);
			
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
        	MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);
			
			Log.logAML(Log.ERROR, this, "makeExcelFile", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}catch (IOException e) {
			//e.printStackTrace();
			String RBA_RPT_MK_S_C = "9";
			ERR_CTNT=e.getMessage();
			input.put("ERR_CTNT", ERR_CTNT);
        	input.put("RBA_RPT_MK_S_C", RBA_RPT_MK_S_C);
        	MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);
			
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
        	MDaoUtilSingle.setData("RBA_50_07_03_01_logEnd",input);
			
			Log.logAML(Log.ERROR, this, "makeExcelFile", e.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		return output;
	}
	
	//1.Executive Summary, 2.자금세탁위험평가개요
	public DataObj getSearch(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch", input);
		
			if (output.getCount("R1_AIM") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//1. Executive Summary 저장
	public DataObj doSave(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			MDaoUtilSingle.setData("RBA_50_07_03_01_doMerge", input);
			
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
	
	//2. 자금세탁위험평가개요 저장
	public DataObj doSave2(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			MDaoUtilSingle.setData("RBA_50_07_03_01_doMerge2", input);
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSave2", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	//2. 자금세탁위험평가개요 첫번째 그리드 저장
	@SuppressWarnings("rawtypes")
	public DataObj gridSave(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			List gdReq = (List)input.get("gdReq");
			
			for(int i=0; i<gdReq.size(); i++){
                HashMap map = (HashMap)gdReq.get(i);
                
                int SNO = Integer.parseInt(StringHelper.evl(map.get("SNO"),"-1"));
                if (SNO == -1) {
                	output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSNO", input);
                	input.put("SNO", output.getText("SNO"));
                } else {
                	input.put("SNO", SNO);
                }
                
                input.put("R2_RULE"		, StringHelper.evl(map.get("R2_RULE"),""));
                input.put("R2_MAIN_CTNT", StringHelper.evl(map.get("R2_MAIN_CTNT"),""));
                input.put("R2_SRC"		, StringHelper.evl(map.get("R2_SRC"),""));
                input.put("R2_REVIS_DT"	, StringHelper.evl(map.get("R2_REVIS_DT"),""));
                
                MDaoUtilSingle.setData("RBA_50_07_03_01_doGridSave", input);
			}
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (NumberFormatException e) {
			Log.logAML(Log.ERROR, this, "gridSave", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "gridSave", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	//2. 자금세탁위험평가개요 첫번째 그리드 삭제
	@SuppressWarnings("rawtypes")
	public DataObj doDelete(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			List gdReq = (List)input.get("gdReq");
			
			for(int i=0; i<gdReq.size(); i++){
                HashMap map = (HashMap)gdReq.get(i);
                input.put("SNO", Integer.parseInt(StringHelper.evl(map.get("SNO"),"-1")));
                MDaoUtilSingle.setData("RBA_50_07_03_01_doGridDelete", input);
			}
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (NumberFormatException e) {
			Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doDelete", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	//2. 자금세탁위험평가개요 두번째 그리드 삭제
	@SuppressWarnings("rawtypes")
	public DataObj doDelete2(DataObj input) {
		DataObj output = new DataObj();
		String cnt = "";
		boolean isDel = false;
		
		try {
			List gdReq = (List)input.get("gdReq");
			
			
			for(int i=0; i<gdReq.size(); i++){
				HashMap map = (HashMap)gdReq.get(i);
				input.put("SNO", Integer.parseInt(StringHelper.evl(map.get("SNO"),"-1")));
				
				//그리드에는 값이 조회되지만 실제레포트 테이블에는 값이 빈 경우 디비에러방지
				cnt = MDaoUtilSingle.getData("RBA_50_07_03_01_getRPT2_1", input).getText("CNT");
				if (!"0".equals(cnt)) {
					MDaoUtilSingle.setData("RBA_50_07_03_01_doGridDelete2", input);
					isDel = true;
				} 
			}
			
			if (isDel) {
				output.put("ERRCODE", "00000");
				output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
				output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			} else {
				output.put("ERRCODE", "00000");
				output.put("ERRMSG", "아직 저장되지 않은 데이터입니다. 저장을 먼저 진행하십시오.");
				output.put("WINMSG", "아직 저장되지 않은 데이터입니다. 저장을 먼저 진행하십시오.");
			}
			
		} catch (NumberFormatException e) {
			Log.logAML(Log.ERROR, this, "doDelete2", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doDelete2", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	//2. 자금세탁위험평가개요 두번째 그리드 저장
	@SuppressWarnings("rawtypes")
	public DataObj gridSave2(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			List gdReq = (List)input.get("gdReq");
			
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getRPT2", input);
			int cnt = Integer.parseInt(output.getText("CNT"));
			
			if (cnt > 0) {
				for(int i=0; i<gdReq.size(); i++){
					HashMap map = (HashMap)gdReq.get(i);
					input.put("SNO"			, Integer.parseInt(StringHelper.evl(map.get("SNO"),"-1")));
					input.put("R2_EXEC_DT"	, StringHelper.evl(map.get("R2_EXEC_DT"),""));
					input.put("R2_EXEC_CTNT", StringHelper.evl(map.get("R2_EXEC_CTNT"),""));
					MDaoUtilSingle.setData("RBA_50_07_03_01_doGridSave2", input);
				}
			} else {
				for(int i=0; i<gdReq.size(); i++){
					HashMap map = (HashMap)gdReq.get(i);
					input.put("SNO"			, Integer.parseInt(StringHelper.evl(map.get("SNO"),"-1")));
					input.put("R2_BIZ_STEP"	, StringHelper.evl(map.get("R2_BIZ_STEP"),""));
					input.put("R2_EXEC_CTNT", StringHelper.evl(map.get("R2_EXEC_CTNT"),""));
					input.put("R2_AML_BRNM"	, StringHelper.evl(map.get("R2_AML_BRNM"),""));
					input.put("R2_EXEC_DT"	, StringHelper.evl(map.get("R2_EXEC_DT"),""));
					MDaoUtilSingle.setData("RBA_50_07_03_01_doGridSave2_1", input);
				}
			}
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (NumberFormatException e) {
			Log.logAML(Log.ERROR, this, "gridSave2", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "gridSave2", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	//3. 회사현황 저장
	public DataObj doSave3(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			MDaoUtilSingle.setData("RBA_50_07_03_01_doMerge3", input);
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSave3", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	//7. 주요 발견사항 및 개선사항
	public DataObj doSave4(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			MDaoUtilSingle.setData("RBA_50_07_03_01_doMerge4", input);
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSave4", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	//8.별첨
	public DataObj doSave5(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			MDaoUtilSingle.setData("RBA_50_07_03_01_doMerge5", input);
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "doSave5", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	//7. 주요 발견사항 및 개선사항 첫번째 그리드 저장
	@SuppressWarnings("rawtypes")
	public DataObj gridSave3(DataObj input) {
		DataObj output = new DataObj();
		
		try {
			List gdReq = (List)input.get("gdReq");
			
			for(int i=0; i<gdReq.size(); i++){
				HashMap map = (HashMap)gdReq.get(i);
				input.put("PROC_FLD_C"	, StringHelper.evl(map.get("PROC_FLD_C"),""));
				input.put("PROC_LGDV_C"	, StringHelper.evl(map.get("PROC_LGDV_C"),""));
				input.put("PROC_MDDV_C"	, StringHelper.evl(map.get("PROC_MDDV_C"),""));
				input.put("PROC_SMDV_C"	, StringHelper.evl(map.get("PROC_SMDV_C"),""));
				input.put("VALT_BRNO"	, StringHelper.evl(map.get("VALT_BRNO"),""));
				input.put("IMPRV_RSLT_CTNT"	, StringHelper.evl(map.get("IMPRV_RSLT_CTNT"),""));
				MDaoUtilSingle.setData("RBA_50_07_03_01_doGridSave3", input);
			}
			
			output.put("ERRCODE", "00000");
			output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", input.getText("LANG_CD"), "정상처리되었습니다"));
			
		} catch (AMLException e) {
			Log.logAML(Log.ERROR, this, "gridSave3", e.getMessage());
			output.put("ERRCODE", "00001");
			output.put("WINMSG", MessageHelper.getInstance().getMessage("0005", input.getText("LANG_CD"), "처리중 오류가 발생하였습니다."));
		}
		
		return output;
	}
	
	//2.자금세탁위험평가개요 - 자금세탁위험평가 수행을 위한 FATF 및 국내규정
	public DataObj getSearch2(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch2", input);
		
			if (output.getCount("SNO") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch2", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//2.자금세탁위험평가개요 - 자금세탁 위험평가 대상 및 수행절차, 일정정리
	public DataObj getSearch3(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch3", input);
			
			if (output.getCount("SNO") > 0) {
				gdRes = Common.setGridData(output);
			} else {
				output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch3_1", input);
				if (output.getCount("SNO") > 0) {
					gdRes = Common.setGridData(output);
				}
			}
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
			
		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "getSearch3", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//3.회사현황
	public DataObj getSearch4(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch4", input);
			
			if (output.getCount("R3_HIST") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch4", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//4.자금세탁위험평가방법론
	public DataObj getSearch5(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch5", input);
		
			if (output.getCount("PROC_LGDV_C") > 0) {
				gdRes = Common.setGridData(output);
			}  
			output.put("ERRCODE", "00000");
			output.put("gdRes", gdRes);
		
		} catch (AMLException ex) {
			//ex.printStackTrace();
			Log.logAML(Log.ERROR, this, "getSearch5", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	
	//4.자금세탁위험평가방법론 
	public DataObj getSearch6(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch6", input);
		
			if (output.getCount("RSK_CATG") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch6", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//4.자금세탁위험평가방법론  
	public DataObj getSearch7(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch7", input);
		
			if (output.getCount("TONGJE_FLD_C") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch7", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//5.자금세탁위험평가 
	public DataObj getSearch8(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch8", input);
		
			if (output.getCount("SEQ") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch8", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//5.자금세탁위험평가
	public DataObj getSearch9(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch9", input);
		
			if (output.getCount("RANK") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch9", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//5.자금세탁위험평가  
	public DataObj getSearch10(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch10", input);
			
			if (output.getCount("RANK") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch10", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//6.결과
	public DataObj getSearch11(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch11", input);
			
			if (output.getCount("NUM") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch11", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//6.결과
	public DataObj getSearch12(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch12", input);
			
			if (output.getCount("NUM") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch12", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//6.결과
	public DataObj getSearch13(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch13", input);
			
			if (output.getCount("NUM") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch13", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//6.결과
	public DataObj getSearch14(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch14", input);
			
			if (output.getCount("RSK_CATG") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch14", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//7.주요발견사항 및 개선사항
	public DataObj getSearch15(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch15", input);
			
			if (output.getCount("PROC_LGDV_C") > 0) {
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
			Log.logAML(Log.ERROR, this, "getSearch15", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//7.주요발견사항 및 개선사항
	public DataObj getSearch16(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch16", input);
			
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
			Log.logAML(Log.ERROR, this, "getSearch16", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	//8.별첨
	public DataObj getSearch17(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_getSearch17", input);
			
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
			Log.logAML(Log.ERROR, this, "getSearch17", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
	
	public DataObj doSearchSC(DataObj input) {
		DataObj output = null;
		DataSet gdRes = null;
		
		try {
			output = MDaoUtilSingle.getData("RBA_50_07_03_01_doSearchSC", input);
			
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
			Log.logAML(Log.ERROR, this, "doSearchSC", ex.getMessage());
			output = new DataObj();
			output.put("ERRCODE", "00001");
			output.put("ERRMSG", ex.toString());
		}
		return output;
	}
}