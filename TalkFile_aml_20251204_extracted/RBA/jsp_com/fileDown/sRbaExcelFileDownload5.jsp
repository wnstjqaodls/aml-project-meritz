<%@ page language="java" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"%>
<%--
- File Name  : rbaExcelFileDownload.jsp
- Author     : LCJ
- Comment    : RBA File Download
- Version    : 1.0
- history    : 1.0 2018-04-27
--%>

<%@ page import = "java.io.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.gtone.aml.basic.common.data.DataObj"%>
<%@ page import = " org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@ page import = " org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import = " org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import = " org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import = " org.apache.poi.xssf.usermodel.XSSFFont"%>
<%@ page import = " org.apache.poi.xssf.streaming.SXSSFWorkbook"%>
<%@ page import = "org.apache.poi.ss.usermodel.Row"%>
<%@ page import = "org.apache.poi.ss.usermodel.Cell"%>
<%@ page import = " com.gtone.aml.dao.common.MDaoUtilSingle"%>
<%@ page import="com.gtone.aml.admin.AMLException"   %>


<% 
	String VALT_YYMM = request.getParameter("VALT_YYMM");
	String VALT_BRNO = request.getParameter("VALT_BRNO");
	String RSK_FAC = request.getParameter("RSK_FAC");
	String RSK_CATG = request.getParameter("RSK_CATG");
	String RSK_INDCT = request.getParameter("RSK_INDCT");
	String PROC_LGDV_C = request.getParameter("PROC_LGDV_C");
	String PROC_MDDV_C = request.getParameter("PROC_MDDV_C");
	String PROC_SMDV_C = request.getParameter("PROC_SMDV_C");
	StringBuffer str = new StringBuffer(64);
	StringBuffer fileStr = new StringBuffer(64);
	DataObj output = new DataObj();
	
	
	try{
    	request.setCharacterEncoding("utf-8");
    	fileStr.append(PROC_SMDV_C);
    	fileStr.append('#');
    	fileStr.append(RSK_INDCT);
    	fileStr.append(" 상세내역");
    	String fileName = fileStr.toString();
    	//String fileName = PROC_SMDV_C+"#"+RSK_INDCT+" 상세내역";
    	String docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
    	response.setContentType("application/octet-stream");
    	str.append("attachment; filename=");
    	str.append(docName);
    	str.append(".xlsx;");
    	response.setHeader("Content-Disposition", str.toString());
    	//response.setHeader("Content-Disposition", "attachment; filename=" + docName + ".xlsx;");
	}
	catch(UnsupportedEncodingException e){
    	output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    }
    

    
    
    
    DataObj input = new DataObj();
    
    input.put("VALT_YYMM", VALT_YYMM);
    input.put("VALT_BRNO", VALT_BRNO);
    input.put("RSK_FAC", RSK_FAC);
    input.put("RSK_CATG", RSK_CATG);
    input.put("RSK_INDCT", RSK_INDCT);
    input.put("PROC_LGDV_C", PROC_LGDV_C);
    input.put("PROC_MDDV_C", PROC_MDDV_C);
    input.put("PROC_SMDV_C", PROC_SMDV_C);
    
    
    SXSSFWorkbook xlsWb = null;
    OutputStream xlsOut = null;
    
    try {
		xlsWb = new SXSSFWorkbook(10000); // Excel 2007 이전 버전
	    StringBuffer excelStr = new StringBuffer(64);
	  	excelStr.append(PROC_SMDV_C);
	  	excelStr.append('#');
	  	excelStr.append(RSK_INDCT);
	    
	    Sheet sheet0 = xlsWb.createSheet(excelStr.toString());
	    sheet0.setColumnWidth(0, 4000);
	    sheet0.setColumnWidth(1, 4000);
	    sheet0.setColumnWidth(2, 4000);
	    sheet0.setColumnWidth(3, 4000);
	    sheet0.setColumnWidth(4, 4000);
	    sheet0.setColumnWidth(7, 5000);
	    sheet0.setColumnWidth(8, 5000);

	    
	    Row row = null;
	    Cell cell = null;
	    String[] cellHeader = { "계좌번호" , "거래일자" ,"실명번호", "상품" , "거래채널" , "거래종류","거래방법","적요명","거래금액","현금금액","수표금액"};
	    row = sheet0.createRow(0);
	    row.setHeight((short)350);  
	    
	    // 헤더 스타일
	    CellStyle cellStyle0 = xlsWb.createCellStyle();
	    
	    XSSFFont font =(XSSFFont)xlsWb.createFont();
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
	    String[] cellData = {"GNL_AC_NO","DL_DT","AML_CUST_ID","GDS_CD_NM","DL_CHNNL_CD_NM","DL_TYP_CD_NM","DL_WY_CD_NM","SMRY_TYP_NM","DL_AMT","CSH_AMT","CHCK_AMT"};
	    
	    DataObj dData = new DataObj();
	    
        dData = MDaoUtilSingle.getData("RBA_50_05_01_02_getSearch2_excel", input);
        int list_size = dData.getCount();
        
        //Sheet sheet1 = xlsWb.createSheet();
        
        
        for (int i = 0; i < list_size; i++) {
            row = sheet0.createRow(i + 1);
            
            for (int j = 0; j < cellData.length; j++) {
                
                cell = row.createCell(j);
                cell.setCellStyle(cellStyle1);
                
                cell.setCellValue(dData.getText(cellData[j], i));
                
                cell.setCellStyle(cellStyle2);
            }
        }
        // 확대/축소 비율
        sheet0.setZoom(9, 10);
        out.clear();
        out = pageContext.pushBody();
        // OutputStream으로 엑셀을 저장한다.
        xlsOut = response.getOutputStream();
        xlsWb.write(xlsOut);
        
    } catch (AMLException e) {
    	//e.printStackTrace();
    	System.err.println("예외 발생");
        output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    } catch (Exception e) {
    	//e.printStackTrace();
    	System.err.println("예외 발생");
        output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    }finally {
		if(xlsWb != null){
            xlsWb.close();    	
        }
        if(xlsOut != null){
	        xlsOut.close();    	
        }		
    }
%>

