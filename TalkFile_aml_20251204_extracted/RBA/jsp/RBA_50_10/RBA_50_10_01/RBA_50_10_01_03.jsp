<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2025 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : RBA 결과보고서
********************************************************************************************************************************************
--%>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%  
    String BAS_YYMM = Util.nvl(request.getParameter("BAS_YYMM"));
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    
%>
<script language="JavaScript">
    var dataSource = [];
    var GridObj1 = null;
    var overlay  = new Overlay();
    // [ Initialize ]

    $(document).ready(function(){ 
        
        // iframe 로딩 후 오버레이 제거
        $("#RBA_50_10_01_Report").on("load", function() {
            overlay.hide();
        });
        
		overlay.show(true, true);
        
    	var frm2 = document.form2;
    	frm2.action = "report/RBA_Report";
        frm2.target = "RBA_50_10_01_Report";
        frm2.BAS_YYMM.value =  "<c:out value='<%=BAS_YYMM%>'/>" ;
        frm2.submit();
    });
    
 
    
         
</script>
<form name="form2">
<input type="hidden" name="BAS_YYMM" id ="BAS_YYMM" >
</form>

<form name="form1" style="height:400px;">
<input type="hidden" name="pageID" >
<input type="hidden" name="manualID" >
 

   	<table class="basic-table" >
	<tr><td style="text-align: right; height: 20px; color: blue;">엑셀 타입(XLSX)만 다운로드 가능합니다!</td></tr>
  	</table>

    <div class="tab-content-bottom">
		<div class="cont-area3">
			<iframe id="RBA_50_10_01_Report" name="RBA_50_10_01_Report" src="" width="100%" height="600px" scrolling="yes" frameborder="0"></iframe>
		</div>	
	</div>
	
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />