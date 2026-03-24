<%@ page language="java" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"%>
<%--
- File Name  : rbaFIURepoerExcelFileDownload.jsp
- Author     : NHM
- Comment    : RBA File Download
- Version    : 1.0
- history    : 1.0 2018-12-12
--%>
<%@ page import = "jspeed.base.util.StringHelper"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.gtone.aml.basic.common.log.Log" %>
<%@ page import = "com.gtone.aml.basic.common.data.DataObj"%>
<%@ page import = "com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_04.RBA_90_01_04_01"%>

<%@ page import = "org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@ page import = "org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import = "org.apache.poi.ss.usermodel.BorderStyle"%>
<%@ page import = "org.apache.poi.ss.usermodel.Cell"%>
<%@ page import = "org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import = "org.apache.poi.ss.usermodel.FillPatternType"%>
<%@ page import = "org.apache.poi.ss.usermodel.HorizontalAlignment"%>
<%@ page import = "org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import = "org.apache.poi.ss.usermodel.Row"%>
<%@ page import = "org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import = "org.apache.poi.ss.usermodel.VerticalAlignment"%>
<%@ page import = "org.apache.poi.ss.usermodel.Workbook"%>

<%
	String fileName = "FIU_Report";
	StringBuffer strHead = new StringBuffer(128);
    try{
	request.setCharacterEncoding("utf-8");
	String docName; docName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
	response.setContentType("application/octet-stream");
	strHead.append("attachment; filename=");
	strHead.append(docName);
	strHead.append(".xls;");
	response.setHeader("Content-Disposition" , strHead.toString());
	//response.setHeader("Content-Disposition", "attachment; filename=" + docName + ".xls;");
    }catch(UnsupportedEncodingException e){
    	Log.logAML(Log.ERROR, e);
    }

	DataObj input = new DataObj();
	DataObj output = new DataObj();

	String RPT_GJDT = StringHelper.evl(request.getParameter("RPT_GJDT"), "");
	String ROLE_ID = StringHelper.evl(request.getParameter("ROLE_ID"), "");

    input.add("RPT_GJDT", RPT_GJDT);
    input.add("JIPYO_IDX", "");
    input.add("JIPYO_NM", "");
    input.add("JIPYO_C", "");
    input.add("RSK_CATG", "");
    input.add("RSK_FAC", "");
    input.add("ROLE_ID", ROLE_ID);

    Workbook xlsWb = null;
    OutputStream xlsOut = null;
    try {
	// Workbook 생성
	    xlsWb = new HSSFWorkbook(); // Excel 2007 이전 버전

	    Sheet sheet0 = xlsWb.createSheet("보고파일");

	    sheet0.setColumnWidth(0, 1500);
	    sheet0.setColumnWidth(1, 4000);
	    sheet0.setColumnWidth(2, 13000);
	    sheet0.setColumnWidth(3, 10000);
	    sheet0.setColumnWidth(4, 3000);
	    sheet0.setColumnWidth(5, 30000);
	    sheet0.setColumnWidth(6, 3000);

	    Row row = null;
	    Cell cell = null;

	    String[] cellHeader = { "NO"
	    		              , "인덱스"
	                          , "위험평가 지표명"
	                          , "입력항목명"
	                          , "입력단위"
	                          , "결과값"
	                          , "지표코드"
	                          };

	    row = sheet0.createRow(0);

	    row.setHeight((short)350);

	    // 헤더 스타일
	    CellStyle cellStyle0 = xlsWb.createCellStyle();

	    HSSFFont font = (HSSFFont) xlsWb.createFont();
	    font.setBold(true);

	    cellStyle0.setAlignment(HorizontalAlignment.CENTER);
	    cellStyle0.setVerticalAlignment(VerticalAlignment.CENTER);
	    cellStyle0.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
	    cellStyle0.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    cellStyle0.setFont(font);
	    cellStyle0.setBorderBottom(BorderStyle.THIN);
	    cellStyle0.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle0.setBorderLeft(BorderStyle.THIN);
	    cellStyle0.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle0.setBorderRight(BorderStyle.THIN);
	    cellStyle0.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle0.setBorderTop(BorderStyle.THIN);
	    cellStyle0.setTopBorderColor(IndexedColors.BLACK.getIndex());

	    // 셀 Lock 스타일
	    CellStyle cellStyle1 = xlsWb.createCellStyle();
	    cellStyle1.setBorderBottom(BorderStyle.THIN);
	    cellStyle1.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle1.setBorderLeft(BorderStyle.THIN);
	    cellStyle1.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle1.setBorderRight(BorderStyle.THIN);
	    cellStyle1.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle1.setBorderTop(BorderStyle.THIN);
	    cellStyle1.setTopBorderColor(IndexedColors.BLACK.getIndex());

	    // 셀 중앙정렬 스타일
	    CellStyle cellStyle2 = xlsWb.createCellStyle();
	    cellStyle2.setAlignment(HorizontalAlignment.CENTER);
	    cellStyle2.setBorderBottom(BorderStyle.THIN);
	    cellStyle2.setBottomBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle2.setBorderLeft(BorderStyle.THIN);
	    cellStyle2.setLeftBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle2.setBorderRight(BorderStyle.THIN);
	    cellStyle2.setRightBorderColor(IndexedColors.BLACK.getIndex());
	    cellStyle2.setBorderTop(BorderStyle.THIN);
	    cellStyle2.setTopBorderColor(IndexedColors.BLACK.getIndex());

	    for (int i = 0; i < cellHeader.length; i++) {
	        cell = row.createCell(i);
	        cell.setCellValue(cellHeader[i]);
	        cell.setCellStyle(cellStyle0);
	    }

	    String[] cellData = { "ITEM_S_C"		// 입력
	    		            , "JIPYO_IDX_EXCEL"		// 인덱스
	    		            , "JIPYO_NM"		// 위험평가 지표명
	    		            , "INP_ITEM"		// 입력항목명
	    		            , "INP_UNIT_C_NM"	// 입력단위
	    		            , "IN_V_EXCEL"		// 결과값
	    		            , "JIPYO_ID"		// 지표코드
	                        };

	    DataObj dData = new DataObj();

        dData = RBA_90_01_04_01.getInstance().doSearch(input);

        int list_size = dData.getCount();

        for (int i = 0; i < list_size; i++) {
            row = sheet0.createRow(i + 1);

            for (int j = 0; j < cellData.length; j++) {
                cell = row.createCell(j);
                cell.setCellStyle(cellStyle1);

                // 입력, 인덱스, 지표코드는 가운데 정렬
                if ( j == 0 || j == 1 || j == 6 ) {
                    cell.setCellStyle(cellStyle2);
                }

                if ( j == 0 ) {
                	//if ( dData.getText(cellData[j], i).equals("2") ) {	// 지표상태코드 = 2:확정
//                 	if ( "2".equals(dData.getText(cellData[j], i)) == true ) { // 지표상태코드 = 2:확정
//                 		cell.setCellValue("◎");
//                 	}
                	cell.setCellValue(i+1);
                } else {
                    cell.setCellValue(dData.getText(cellData[j], i));
                }
            }
        }

        // 필터
        // 확대/축소 비율
        sheet0.setZoom(90);

        out.clear();
        out = pageContext.pushBody();
        // OutputStream으로 엑셀을 저장한다.
        xlsOut = response.getOutputStream();
        xlsWb.write(xlsOut);

        // 파일 필수로 닫아줘야 함
        //xlsOut.close();
    } catch (RuntimeException e) {
        output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    } catch (Exception e) {
        output = new DataObj();
        output.put("ERRCODE", "00001");
        output.put("ERRMSG", e.toString());
    } finally {
        // 파일 필수로 닫아줘야 함
        if(xlsOut != null){
	        xlsOut.close();
        }
        if(xlsWb != null){
            xlsWb.close();
        }
    }
%>

