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
<%-- <%@ page import = "com.gtone.rba.server.type03.RBA_50.RBA_50_03.RBA_50_03_03.RBA_50_03_03_01"%> --%>

<%@ page import = " org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@ page import = " org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import = " org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import = " org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@ page import = " org.apache.poi.xssf.usermodel.XSSFFont"%>
<%@ page import = " org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@ page import = " org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@ page import = " org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
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
	DataObj output = new DataObj();
	StringBuffer str = new StringBuffer(64);
	StringBuffer fileStr = new StringBuffer(64);
	
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
     
    
  	
    XSSFWorkbook xlsWb = null;
    OutputStream xlsOut = null;
    try {
		xlsWb = new XSSFWorkbook(); // Excel 2007 이전 버전
	  	StringBuffer excelStr = new StringBuffer(64);
	  	excelStr.append(PROC_SMDV_C);
	  	excelStr.append('#');
	  	excelStr.append(RSK_INDCT);
	    
	    XSSFSheet sheet0 = xlsWb.createSheet(excelStr.toString());
	    sheet0.setColumnWidth(0, 4000);
	    sheet0.setColumnWidth(1, 6000);
	    sheet0.setColumnWidth(2, 4000);
	    sheet0.setColumnWidth(3, 4000);
	    sheet0.setColumnWidth(4, 4000);
	    sheet0.setColumnWidth(5, 6000);
	    sheet0.setColumnWidth(6, 4000);
	    sheet0.setColumnWidth(7, 4000);
	    sheet0.setColumnWidth(8, 4000);
	    sheet0.setColumnWidth(9, 4000);
	    sheet0.setColumnWidth(10, 4000);
	    sheet0.setColumnWidth(11, 4000);
	    sheet0.setColumnWidth(12, 4000);
	    sheet0.setColumnWidth(13, 4000);
	    sheet0.setColumnWidth(14, 5000);
	    sheet0.setColumnWidth(15, 5000);
	    
	    
	    XSSFRow row = null;
	    XSSFCell cell = null;
	    
	    String[] cellHeader = { "실명번호", "고객명", "미성년자여부", "국가명", "개인법인구분", "업종명", "직업명", "PEP여부","고액자산가여부","비영리단체여부","상장여부","내외국인여부","거주여부","신규고객여부","불공정거래적발여뷰","의심거래보고이력여부"};
	    
	    row = sheet0.createRow(0);
	    
	    row.setHeight((short)350);  
	    
	    // 헤더 스타일
	    CellStyle cellStyle0 = xlsWb.createCellStyle();
	    
	    XSSFFont font =xlsWb.createFont();
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
	    String[] cellData = {"AML_CUST_ID","CS_NM","UNAGE_YN","NTN_CD_NM","INDV_CORP_CCD_NM","INDST_RSK_DVD_CD_NM","JOB_C_NM","PEP_YN","LG_AMT_ASTS_YN","NPRFT_GROUP_YN","LSTNG_YN","NFR_DIT_YN","RSDNC_YN","NEW_CUST_YN","UN_TRN_YN","STR_YN"};
	    
	    DataObj dData = new DataObj();
        dData = MDaoUtilSingle.getData("RBA_50_05_01_02_getSearch3", input);
        int list_size = dData.getCount();
        
       // XSSFSheet sheet1 = xlsWb.createSheet();
        
        
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
    }catch (Exception e) {
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

