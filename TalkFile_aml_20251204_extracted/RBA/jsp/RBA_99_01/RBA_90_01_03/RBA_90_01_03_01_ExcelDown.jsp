<%@page contentType="text/html; charset=utf-8" %>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : FIU 지표등록 download
					
*                   Transaction Info.- Period download
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 서윤경, 김현일
* Since           : 2019.04.01.
********************************************************************************************************************************************
--%>

<%@ page import="com.gtone.aml.basic.common.data.DataObj" %> 
<%@ page import="java.util.*"  %>
<%@ page import="com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_03.RBA_90_01_03_01"  %>
<%@ taglib prefix="fmt" uri="http://www.gtone.co.kr/jstl/fmt" %>
<%@ taglib prefix="c"           uri="http://java.sun.com/jsp/jstl/core"                 %>
<%

	

	String todata  = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String title; title   = "FIU 지표등록 ExcelFile";
	String fileName = "FIU_JipyoReg_" + todata.replaceAll("-", "");
	
	

    String RPT_GJDT     = request.getParameter("RPT_GJDT");
    String RPT_GJDT_TXT =   RPT_GJDT.substring(0, 4) + "년"
    		              + RPT_GJDT.substring(4, 6) + "월"
    		              + RPT_GJDT.substring(6, 8) + "일";
    		
    String JIPYO_IDX    = request.getParameter("JIPYO_IDX");
    String JIPYO_NM     = request.getParameter("JIPYO_NM");
    String JIPYO_C      = request.getParameter("JIPYO_C");
    String JIPYO_C_NM   = request.getParameter("JIPYO_C_NM");
           JIPYO_C_NM = JIPYO_C_NM.replaceAll("::", "");
    String RSK_CATG     = request.getParameter("RSK_CATG");
    String RSK_CATG_NM  = request.getParameter("RSK_CATG_NM");
           RSK_CATG_NM  = RSK_CATG_NM.replaceAll("::", "");
    String RSK_FAC      = request.getParameter("RSK_FAC");
    String RSK_FAC_NM   = request.getParameter("RSK_FAC_NM");
           RSK_FAC_NM   = RSK_FAC_NM.replaceAll("::", "");
    String IN_METH_C    = request.getParameter("IN_METH_C");
    String IN_METH_C_NM = request.getParameter("IN_METH_C_NM");
           IN_METH_C_NM = IN_METH_C_NM.replaceAll("::", "");
    String VALT_G       = request.getParameter("VALT_G");
    String VALT_G_NM    = request.getParameter("VALT_G_NM");
           VALT_G_NM    = VALT_G_NM.replaceAll("::", "");
    String ITEM_S_C     = request.getParameter("ITEM_S_C");
    String ITEM_S_C_NM  = request.getParameter("ITEM_S_C_NM");
           ITEM_S_C_NM  = ITEM_S_C_NM.replaceAll("::", "");
    String MNG_BRNO     = request.getParameter("MNG_BRNO");
    String MNG_BRNO_NM  = request.getParameter("MNG_BRNO_NM");
	
    request.setAttribute("RPT_GJDT", RPT_GJDT);
    request.setAttribute("RPT_GJDT_TXT", RPT_GJDT_TXT);
    
    request.setAttribute("JIPYO_IDX", JIPYO_IDX);
    request.setAttribute("JIPYO_NM", JIPYO_NM);
    request.setAttribute("JIPYO_C_NM", JIPYO_C_NM);
    request.setAttribute("RSK_CATG_NM", RSK_CATG_NM);
    request.setAttribute("RSK_FAC_NM", RSK_FAC_NM);
    request.setAttribute("IN_METH_C_NM", IN_METH_C_NM);
    request.setAttribute("VALT_G_NM", VALT_G_NM);
    request.setAttribute("ITEM_S_C_NM", ITEM_S_C_NM);
    request.setAttribute("MNG_BRNO_NM", MNG_BRNO_NM);
    
    
    response.setHeader("Content-Disposition", "attachment; filename="+ fileName +".xls"); 
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setHeader("Content-Description", "style=mso-number-format:'\\@'"); 
	response.setContentType("application/vnd.ms-excel");
    
    DataObj obj = new DataObj();
	DataObj DataParam = new DataObj(); 
	
	
	DataParam.put("RPT_GJDT", RPT_GJDT);
	DataParam.put("JIPYO_IDX", JIPYO_IDX);
	DataParam.put("JIPYO_NM", JIPYO_NM);
	DataParam.put("JIPYO_C", JIPYO_C);
	DataParam.put("RSK_CATG", RSK_CATG);
	DataParam.put("RSK_FAC", RSK_FAC);
	DataParam.put("IN_METH_C", IN_METH_C);
	DataParam.put("VALT_G", VALT_G);
	DataParam.put("ITEM_S_C", ITEM_S_C);
	DataParam.put("MNG_BRNO", MNG_BRNO);
	
	obj = RBA_90_01_03_01.getInstance().doSearchExcel(DataParam);
	
%>
<html>
<meta http-equiv="Content-Type content=text/html; charset=utf-8"  >
<head>
	<title>FIU 지표등록 ExcelFile</title>
</head>
<body>
	<table border='1'>
		<tr>
			<td bgcolor="#FFFF99">Version</td>
			<td>S-ASTR-V1.0</td>
		</tr>
	</table>
	<table border='1'>
		<tr>
			<td colspan='10' bgcolor="#F2F2F2"><fmt:message key="RBA_90_01_03_01_008" initVal="조회정보"/></td>			
		</tr>
		<tr>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_001" initVal="보고기준일"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_002" initVal="지표번호"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_003" initVal="지표명"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_004" initVal="위험구분"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_005" initVal="카테고리"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_006" initVal="항목"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_024" initVal="입력방식"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_007" initVal="평가구분"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_03_01_001" initVal="항목상태"/></td>   
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_009" initVal="관리지점"/></td>
		</tr>
		<tr>
			<td align='center'>${RPT_GJDT }</td>
			<td style="mso-number-format:\@"  align='center'>${JIPYO_IDX }</td>
			<td style="mso-number-format:\@"  align='left'>${JIPYO_NM }</td>  
			<td style="mso-number-format:\@"  align='left'>${JIPYO_C_NM }</td>  
			<td style="mso-number-format:\@"  align='left'>${RSK_CATG_NM }</td>  
			<td style="mso-number-format:\@"  align='left'>${RSK_FAC_NM }</td>  
			<td style="mso-number-format:\@"  align='left'>${IN_METH_C_NM }</td>  
			<td style="mso-number-format:\@"  align='left'>${VALT_G_NM }</td>  
			<td style="mso-number-format:\@"  align='left'>${ITEM_S_C_NM }</td>  
			<td style="mso-number-format:\@"  align='left'>${MNG_BRNO_NM }</td>
		</tr>
	</table>
	<table border='1'>
		<tr>
			<td colspan='12' bgcolor="#FFFF00">
				${RPT_GJDT_TXT }&nbsp;
				<fmt:message key="RBA_90_01_03_01_009" initVal="보고 자료 내역"/>
			</td>			
		</tr>
		<tr>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_002" initVal="지표번호"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_03_01_002" initVal="위험지표명"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_014" initVal="입력항목"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_007" initVal="평가구분"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_020" initVal="입력단위"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_01_02_016" initVal="배점"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_03_01_003" initVal="직전입력값"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_03_01_004" initVal="입력값"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_03_01_005" initVal="지표점수"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_03_01_007" initVal="메모"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_03_01_006" initVal="증빙파일"/></td>
			<td bgcolor="#F2F2F2" align="center"><fmt:message key="RBA_90_01_03_01_001" initVal="항목상태"/></td>
		</tr>
		<%
			for(int i = 0; i < obj.getCount("JIPYO_IDX"); i++) {
		%>
		<tr>			
			<td style="mso-number-format:\@"  align='center'><c:out value='<%=obj.getText("JIPYO_IDX"		    ,i)%>'/></td>
			<td style="mso-number-format:\@"  align='left'>  <c:out value='<%=obj.getText("JIPYO_NM"			,i)%>'/></td>
			<td style="mso-number-format:\@"  align='left'>  <c:out value='<%=obj.getText("INP_ITEM"		    ,i)%>'/></td>
			<td style="mso-number-format:\@"  align='left'>  <c:out value='<%=obj.getText("VALT_G_NM"			,i)%>'/></td>
			<td style="mso-number-format:\@"  align='left'>  <c:out value='<%=obj.getText("INP_UNIT_C_NM"		,i)%>'/></td>
			<td style="mso-number-format:\@"  align='right'> <c:out value='<%=obj.getText("ALLT_PNT"			,i)%>'/></td>
			<%	if("-".equalsIgnoreCase(obj.getText("LAST_IN_V",i))) { %>
			<td style="mso-number-format:\@"  align='center'><c:out value='<%=obj.getText("LAST_IN_V"			,i)%>'/></td>
			<%	}
				else if(! "N".equalsIgnoreCase(obj.getText("IN_V_TP_C"))){ %>
			<td style="mso-number-format:\@"  align='left'><c:out value='<%=obj.getText("LAST_IN_V"			,i)%>'/></td>
			<%	}
				else { %>
			<td style="mso-number-format:\@"  align='right'><c:out value='<%=obj.getText("LAST_IN_V"			,i)%>'/></td>
			<%	} %>
			<%	if("-".equalsIgnoreCase(obj.getText("A_IN_V",i))) { %>
			<td style="mso-number-format:\@"  align='center'><c:out value='<%=obj.getText("A_IN_V"			,i)%>'/></td>
			<%	}
				else if(! "N".equalsIgnoreCase(obj.getText("IN_V_TP_C"))){ %>
			<td style="mso-number-format:\@"  align='left'><c:out value='<%=obj.getText("A_IN_V"				,i)%>'/></td>
			<%	}
				else { %>
			<td style="mso-number-format:\@"  align='right'><c:out value='<%=obj.getText("A_IN_V"				,i)%>'/></td>
			<%	} %>
			<%	if("-".equalsIgnoreCase(obj.getText("RPT_PNT",i))) { %>
			<td style="mso-number-format:\@"  align='center'><c:out value='<%=obj.getText("RPT_PNT"			,i)%>'/></td>
			<%	}
				else { %>
			<td style="mso-number-format:\@"  align='right'> <c:out value='<%=obj.getText("RPT_PNT"			,i)%>'/></td>
			<%	} %>
				
			<td style="mso-number-format:\@"  align='center'><c:out value='<%=obj.getText("BIGO_CTNT_F"	    ,i)%>'/></td>
			<td style="mso-number-format:\@"  align='center'><c:out value='<%=obj.getText("ATTCH_FILE_YN"		,i)%>'/></td>
			<td style="mso-number-format:\@"  align='center'><c:out value='<%=obj.getText("ITEM_S_C_NM"		,i)%>'/></td>
		</tr>
		<%
			}
		%>
	</table>
</body>


           
               
 
    
     