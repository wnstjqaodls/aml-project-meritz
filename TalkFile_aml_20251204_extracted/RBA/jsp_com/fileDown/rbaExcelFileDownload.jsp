<%@ page language="java" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"%>
<%--
- File Name  : rbaExcelFileDownload.jsp
- Author     : JJH
- Comment    : RBA File Download
- Version    : 1.0
- history    : 1.0 2017-06-20
--%>
<%@ page import = "jspeed.base.util.StringHelper"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.gtone.aml.basic.common.data.DataObj"%>
<%@ page import = "com.gtone.rba.server.type01.RBA_30.RBA_30_04.RBA_30_04_01.RBA_30_04_01_01"%>
<%@ page import = "org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@ page import = "org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@ page import = "org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import = "org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import = "org.apache.poi.ss.usermodel.Cell"%>
<%@ page import = "org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import = "org.apache.poi.ss.usermodel.Row"%>
<%@ page import = "org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import = "org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import = "org.apache.poi.ss.util.CellRangeAddress"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "java.util.HashMap"%>
<%@ page import = "java.util.List"%>
<%@ page import = "org.apache.poi.ss.formula.FormulaParseException"%>


<%

	DataObj input = new DataObj();
	DataObj output = new DataObj();
	StringBuffer str = new StringBuffer(64);
	

    try{
    	request.setCharacterEncoding("utf-8");
    	String fileName = "통제활동관리";
    	String docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
    	response.setContentType("application/octet-stream");
    	str.append("attachment; filename=");
    	str.append(docName);
    	str.append(".xls;");
    	//response.setHeader("Content-Disposition", "attachment; filename=" + docName + ".xls;");
    	response.setHeader("Content-Disposition", str.toString());
    }catch(UnsupportedEncodingException e){
    	output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    }
     
    String BAS_YYYY = StringHelper.evl(request.getParameter("BAS_YYYY"), "");
    String DSGN_VALT_BRNO = StringHelper.evl(request.getParameter("DSGN_VALT_BRNO"), "");
    String TONGJE_FLD_C = StringHelper.evl(request.getParameter("TONGJE_FLD_C"), "");
    String TONGJE_PROC_C = StringHelper.evl(request.getParameter("TONGJE_PROC_C"), "");
    String TONGJE_SUB_PROC_C = StringHelper.evl(request.getParameter("TONGJE_SUB_PROC_C"), "");
    String TO_DO_CHECK = StringHelper.evl(request.getParameter("TO_DO_CHECK"), "");
    
    input.add("BAS_YYYY",BAS_YYYY);
    input.add("DSGN_VALT_BRNO",DSGN_VALT_BRNO);
    input.add("TONGJE_FLD_C",TONGJE_FLD_C);
    input.add("TONGJE_PROC_C",TONGJE_PROC_C);
    input.add("TONGJE_SUB_PROC_C",TONGJE_SUB_PROC_C);
    input.add("TO_DO_CHECK",TO_DO_CHECK);
    
    // Workbook 생성
    Workbook xlsWb = null;
    OutputStream xlsOut = null;
    
    try {
		xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전 
	    Sheet sheet0 = xlsWb.createSheet("통제활동내역");
	    
	    sheet0.setColumnWidth(1, 1000);
	    sheet0.setColumnWidth(2, 5000);
	    sheet0.setColumnWidth(3, 1000);
	    sheet0.setColumnWidth(4, 7000);
	    sheet0.setColumnWidth(5, 1500);
	    sheet0.setColumnWidth(6, 7000);
	    sheet0.setColumnWidth(7, 3200);
	    sheet0.setColumnWidth(8, 2500);
	    sheet0.setColumnWidth(9, 7000);
	    sheet0.setColumnWidth(10, 7000);
	    sheet0.setColumnWidth(11, 7000);
	    sheet0.setColumnWidth(12, 7000);
	    sheet0.setColumnWidth(14, 2000);
	    sheet0.setColumnWidth(16, 5000);
	    sheet0.setColumnWidth(18, 2500);
	    sheet0.setColumnWidth(19, 3000);
	    sheet0.setColumnWidth(20, 3000);
	    sheet0.setColumnWidth(21, 3000);
	    
	    sheet0.setColumnHidden(13, true);
	    sheet0.setColumnHidden(15, true);
	    sheet0.setColumnHidden(17, true);
	    sheet0.setColumnHidden(22, true);
	    // 틀고정
	    sheet0.createFreezePane(9, 1);
	    
	    Row row = null;
	    Cell cell = null;
	    
	    String[] cellHeader = { "기준연도", "No.", "영역", "No.", "Process"
	                        , "No.", "Sub Process", "통제활동ID", "취약점ID", "통제활동제목", "통제활동상세"
	                        , "업무규정관련항목", "관련자료내용", "통제적용범위코드", "적용범위", "통제유형코드"
	                        , "통제유형", "설계평가부점번호", "평가지점", "목적적합성", "운영가능성"
	                        , "설계유효성", "사용여부", "사용여부" };
	    
	    row = sheet0.createRow(0);
	    
	    row.setHeight((short)350);  
	    
	    // 헤더 스타일
	    CellStyle cellStyle0 = xlsWb.createCellStyle();
	    
	    HSSFFont font = (HSSFFont) xlsWb.createFont();
	    font.setBold(true);
	    
	    cellStyle0.setAlignment(HSSFCellStyle.ALIGN_CENTER);
	    cellStyle0.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
	    cellStyle0.setFillForegroundColor(HSSFColor.YELLOW.index);
	    cellStyle0.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	    cellStyle0.setFont(font);
	    cellStyle0.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    cellStyle0.setBottomBorderColor(HSSFColor.BLACK.index);
	    cellStyle0.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    cellStyle0.setLeftBorderColor(HSSFColor.BLACK.index);
	    cellStyle0.setBorderRight(HSSFCellStyle.BORDER_THIN);
	    cellStyle0.setRightBorderColor(HSSFColor.BLACK.index);
	    cellStyle0.setBorderTop(HSSFCellStyle.BORDER_THIN);
	    cellStyle0.setTopBorderColor(HSSFColor.BLACK.index);
	    
	    // 셀 Lock 스타일
	    CellStyle cellStyle1 = xlsWb.createCellStyle();
	    cellStyle1.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    cellStyle1.setBottomBorderColor(HSSFColor.BLACK.index);
	    cellStyle1.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    cellStyle1.setLeftBorderColor(HSSFColor.BLACK.index);
	    cellStyle1.setBorderRight(HSSFCellStyle.BORDER_THIN);
	    cellStyle1.setRightBorderColor(HSSFColor.BLACK.index);
	    cellStyle1.setBorderTop(HSSFCellStyle.BORDER_THIN);
	    cellStyle1.setTopBorderColor(HSSFColor.BLACK.index);  
	    
	    // 셀 중앙정렬 스타일
	    CellStyle cellStyle2 = xlsWb.createCellStyle();
	    cellStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
	    cellStyle2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
	    cellStyle2.setBottomBorderColor(HSSFColor.BLACK.index);
	    cellStyle2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
	    cellStyle2.setLeftBorderColor(HSSFColor.BLACK.index);
	    cellStyle2.setBorderRight(HSSFCellStyle.BORDER_THIN);
	    cellStyle2.setRightBorderColor(HSSFColor.BLACK.index);
	    cellStyle2.setBorderTop(HSSFCellStyle.BORDER_THIN);
	    cellStyle2.setTopBorderColor(HSSFColor.BLACK.index);  
	    
	    for (int i = 0; i < cellHeader.length; i++) {
	        cell = row.createCell(i);
	        cell.setCellValue(cellHeader[i]);
	        cell.setCellStyle(cellStyle0);
	    }
	    
	    String[] cellData = { "BAS_YYYY", "TONGJE_FLD_C", "TONGJE_FLD_C_NM", "TONGJE_PROC_C", "TONGJE_PROC_C_NM"
	                        , "TONGJE_SUB_PROC_C", "TONGJE_SUB_PROC_C_NM", "TONGJE_ACT_ID", "CH_ID", "TONGJE_ACT_TITE", "TONGJE_ACT_DTL"
	                        , "BIZ_RULE_REL_ITEM", "REL_DATA_CTNT", "TONGJE_APPL_SCOP_C", "TONGJE_APPL_SCOP_C_NM", "TONGJE_TP_C"
	                        , "TONGJE_TP_C_NM", "DSGN_VALT_BRNO", "DSGN_VALT_BR_NM", "AIM_STTP_RT", "OPR_POSS_RT"
	                        , "DSGN_VALD_RT", "USYN", "USYN_NM" };
	    DataObj dData = new DataObj();
        System.out.println("!!!test!!!");
        dData = RBA_30_04_01_01.getInstance().doSearchDownloadInfo(input);
        System.out.println("!!!test!!!2");
        
        int list_size = dData.getCount();
        
        String[] strFormula = new String[] { "Y", "N"};
        
        // 드롭다운(combo)
        RBA_30_04_01_01.getInstance().makeExcelDropdown(sheet0, strFormula, list_size, 23);
        
        String[] cCellData = { "DTL_C_NM", "DTL_C" };
        
        Sheet sheet1 = xlsWb.createSheet();
        
        Row cRow1 = null;
        Cell cCell1 = null;
        //String query_id1 = "RBA_30_04_01_XX_KRBA_DTL_C";
        
        DataObj rbaCd1 = new DataObj();
        HashMap gCd1 = new HashMap();
        gCd1.put("GRP_C", "R324");
        
        rbaCd1 = RBA_30_04_01_01.getInstance().doSearchCodeInfo(gCd1);
        
        int rbaCd1_size = rbaCd1.getCount();
        List<String> list1 = new ArrayList<String>();
        
        for (int iCd1 = 0; iCd1 < rbaCd1_size; iCd1++) {
            cRow1 = sheet1.createRow(iCd1);
            
            for (int j = 0; j < cCellData.length; j++) {
                cCell1 = cRow1.createCell(j);
                String cData1 = rbaCd1.getText(cCellData[j], iCd1);
                if(j == 0){
                    list1.add(cData1);
                }
                cCell1.setCellValue(cData1);
            }
        }
        
        String[] cList1 = new String[list1.size()];
        list1.toArray(cList1);
        
        // 드롭다운(combo)
        RBA_30_04_01_01.getInstance().makeExcelDropdown(sheet0, cList1, list_size, 14);
        
        Sheet sheet2 = xlsWb.createSheet();
        
        Row cRow2 = null;
        Cell cCell2 = null;
        
        DataObj rbaCd2 = new DataObj();
        HashMap gCd2 = new HashMap();
        gCd2.put("GRP_C", "R325");
        
        rbaCd2 = RBA_30_04_01_01.getInstance().doSearchCodeInfo(gCd2);
        
        int rbaCd2_size = rbaCd2.getCount();
        List<String> list2 = new ArrayList<String>();
        
        for (int iRowCd2 = 0; iRowCd2 < rbaCd2_size; iRowCd2++) {
            cRow2 = sheet2.createRow(iRowCd2);
            
            for (int j = 0; j < cCellData.length; j++) {
                cCell2 = cRow2.createCell(j);
                String cData2 = rbaCd2.getText(cCellData[j], iRowCd2);
                if(j == 0){
                    list2.add(cData2);
                }
                cCell2.setCellValue(rbaCd2.getText(cCellData[j], iRowCd2));
            }
        }
        
        String[] cList2 = new String[list2.size()];
        list2.toArray(cList2);
        
        // 드롭다운(combo)
        RBA_30_04_01_01.getInstance().makeExcelDropdown(sheet0, cList2, list_size, 16);
        
        Sheet sheet3 = xlsWb.createSheet();
        
        Row cRow3 = null;
        Cell cCell3 = null;
        
        DataObj brCd = new DataObj();
        
        brCd = RBA_30_04_01_01.getInstance().doSearchBrnoInfo(input);
        
        int brCd_size = brCd.getCount();
        
        String[] brCellData = { "DPRT_NM", "DPRT_CD" };
        List<String> list3 = new ArrayList<String>();
        
        for (int i = 0; i < brCd_size; i++) {
            cRow3 = sheet3.createRow(i);
            
            for (int j = 0; j < brCellData.length; j++) {
                cCell3 = cRow3.createCell(j);
                String cData3 = brCd.getText(brCellData[j], i);
                if(j == 0){
                    list3.add(cData3);
                }
                cCell3.setCellValue(cData3);
            }
        }
        
        String[] brList = new String[list3.size()];
        StringBuffer strData = new StringBuffer(128);
        list3.toArray(brList);
        
        // 드롭다운(combo)
        RBA_30_04_01_01.getInstance().makeExcelDropdown(sheet0, brList, list_size, 18);
        
        for (int i = 0; i < list_size; i++) {
            row = sheet0.createRow(i + 1);
            
            for (int j = 0; j < cellData.length; j++) {
                
                cell = row.createCell(j);
                cell.setCellStyle(cellStyle1);
                strData.setLength(0);
                
                if(j >= 19 && j < 23){
                    cell.setCellValue(dData.getInt(cellData[j], i));
                } else {
                    cell.setCellValue(dData.getText(cellData[j], i));
                }
                
                int iRow = i + 2;
                if(j == 0 || j == 1 || j == 3 || j == 5 || j == 7 || j == 8 || j == 14 || j == 16 || j == 18 || j == 23){
                    cell.setCellStyle(cellStyle2);
                }
                if(j == 13){
                	strData.append("VLOOKUP(O");
                	strData.append(iRow);
                	strData.append(",Sheet1!A:B,2,FALSE)");
                	cell.setCellFormula(strData.toString());
                   // cell.setCellFormula("VLOOKUP(O"+iRow+",Sheet1!A:B,2,FALSE)");
                    
                }
                if(j == 15){
                	strData.append("VLOOKUP(Q");
                	strData.append(iRow);
                	strData.append(",Sheet2!A:B,2,FALSE)");
                	cell.setCellFormula(strData.toString());
                   // cell.setCellFormula("VLOOKUP(Q"+iRow+",Sheet2!A:B,2,FALSE)");
                }
                if(j == 17){
                	strData.append("VLOOKUP(S");
                	strData.append(iRow);
                	strData.append(",Sheet3!A:B,2,FALSE)");
                	cell.setCellFormula(strData.toString());
                    //cell.setCellFormula("VLOOKUP(S"+iRow+",Sheet3!A:B,2,FALSE)");
                }
                if(j == 21){
                	strData.append("ROUND(AVERAGE(T");
                	strData.append(iRow);
                	strData.append(":U");
                	strData.append(iRow);
                	strData.append("), 0)");
                	cell.setCellFormula(strData.toString());
                   // cell.setCellFormula("ROUND(AVERAGE(T"+iRow+":U"+iRow+"), 0)");
                }
                if(j == 22){
                	strData.append("IF(X");
                	strData.append(iRow);
                	strData.append("=\"Y\", 1, 0)");
                	cell.setCellFormula(strData.toString());
                    //cell.setCellFormula("IF(X"+iRow+"=\"Y\", 1, 0)");
                }
            }
        }
        // 필터
        sheet0.setAutoFilter(new CellRangeAddress(0, list_size, 0, 23));
        // 확대/축소 비율
        sheet0.setZoom(9, 10);
        
        out.clear();
        out = pageContext.pushBody();
        // OutputStream으로 엑셀을 저장한다.
        xlsOut = response.getOutputStream();
        xlsWb.write(xlsOut);
    
    } catch (NumberFormatException e) {
        output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    } catch (FormulaParseException e) {
        output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    } catch (Exception e) {
        output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    } finally {
		    try {
				if (xlsWb != null) {
			    	xlsWb.close();
				}
				if (xlsOut != null) {
				    xlsOut.close();
				}
		    }catch(IOException e){
		    	output = new DataObj();
		        output.put("ERRCODE", "00001");
		        output.put("ERRMSG", e.toString());
		    }
		}
    }
%>

