<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%@ page import="com.gtone.aml.basic.common.data.DataObj"  %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://www.gtone.co.kr/jstl/fmt" %>

<%--
- File Name  : RBA_10_10_01_02.jsp
- Author     : SeungRok
- Comment    : 점수변동추이
- Version    : 1.0
- history    : 1.0 2017-01-11
--%>

<%@ include file="/AML/common/common.jsp" %>
<%@ include file="/express/header.jsp" %>

<%
	
	String scr1 = Util.nvl(request.getParameter("score1")			, "");
	String scr2 = Util.nvl(request.getParameter("score2")			, "");
	String scr3 = Util.nvl(request.getParameter("score3")			, "");
	
	if (scr1 == null) {
		return;
	} else {
		scr1 = scr1.replaceAll("<","&lt;");
		scr1 = scr1.replaceAll(">","&gt;");
	}
	
	if (scr2 == null) {		
		return;
	} else {	  	
		scr2 = scr2.replaceAll("<","&lt;");
		scr2 = scr2.replaceAll(">","&gt;");
	}
	
	if (scr3 == null) {
		return;

	} else {
		scr3 = scr3.replaceAll("<","&lt;");
		scr3 = scr3.replaceAll(">","&gt;");	  
	}
	
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script src="/AML/AML_00/AML_00_02/AML_00_02_01/AC_OETags.js" language="javascript"></script>

<!--  BEGIN Browser History required section -->
<!--<script src="history/history.js" language="javascript"></script>-->
<!--  END Browser History required section -->

<style>
body { margin: 0px; overflow:hidden }
</style>
<script language="JavaScript" type="text/javascript">
<!--
// -----------------------------------------------------------------------------
// Globals
// Major version of Flash required
var requiredMajorVersion = 9;
// Minor version of Flash required
var requiredMinorVersion = 0;
// Minor version of Flash required
var requiredRevision = 124;
// -----------------------------------------------------------------------------
// -->
</script>
</head>

<body scroll="no">
<script language="JavaScript" type="text/javascript">
	function CreateFlexObject() {
		var strObject =				"<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' ";
		strObject = strObject +		"id='GTONEChart' width='100%' height='100%' ";
		strObject = strObject +		"codebase='http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab' >";
		strObject = strObject +		"<param name='src' value='/AML/AML_00/AML_00_02/AML_00_02_01/GTONEChart.swf'/> ";
		strObject = strObject +		"<param name='flashVars' value='XMLData=" + oObj.xml + "'/> ";
		strObject = strObject +		"<embed name='GTONEChart' src='/AML/AML_00/AML_00_02/AML_00_02_01/GTONEChart.swf' height='100%' width='100%'/>";
		strObject = strObject +		"</object>";

		document.write(strObject);
	}
</script>
<XML language=javascript id=oObj type="text/xml" !src="xmlSrcUrl">
<root type='line' legend='true'>
			<data base='전전회차'>
				<series name='지표 값' value='<%=scr3%>' color1='0xE37000'/>
			</data>
			<data base='직전회차'>
				<series name='지표 값' value='<%=scr2%>' color1='0xE37000'/>
			</data>
			<data base='최근회차'>
				<series name='지표 값' value='<%=scr1%>' color1='0xE37000'/>
			</data>
	</root>
</XML>
<script>
CreateFlexObject();
</script>
</body>
</html>
