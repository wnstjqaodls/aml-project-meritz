<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_04_04.jsp
- Author     : syk, hikim
- Comment    : 자료실 download
                                       資料室 download                                     
               Resource download
- Version    : 1.0
- history    : 1.0 2010-09-30
--%>
<%@ page import="jspeed.base.util.StringHelper"  %>
<%@ page import="com.gtone.aml.basic.common.data.DataObj"  %>

<%
	String path 	 = request.getContextPath();
	String basePath  = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	String ATTCH_FILE_NO	= StringHelper.evl(request.getParameter("ATTCH_FILE_NO"),""); 
	String FILE_SER			= StringHelper.evl(request.getParameter("FILE_SER"),""); 
	
	DataObj output = (DataObj)request.getAttribute("output");
	
	request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);		
	request.setAttribute("FILE_SER",FILE_SER);		
	request.setAttribute("basePath",basePath);	


%>

<html>
<head>
	<base href="${basePath}">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link rel=stylesheet type=text/css href="Package/ext/css/main.css"/>
	<script language="JavaScript" src="Package/ext/js/common.js"></script>

	<script language="JavaScript" >
		function init(){
			parent.document.all["notice"].style.display="block";
		}
	
		function notice_close(id){
			parent.document.all[id].style.display="none"
		}
	
		function notice_open(id){
			parent.document.all[id].style.display="block"
		}

		function downloadFile ( FILE_SEQ ) {
			$("FILE_SER").value = FILE_SEQ;
			
			$("form1").target = "_self";
			$("form1").action = "Package/RBA/common/fileDown/rbaAttachFileDownload.jsp"
			$("form1").submit();
		}			
	</script>

</head>
<body onload="init();">

	<form name="form1" method="post">

	<input type="hidden" name="FILE_POS">
	<input type="hidden" name="USER_FILE_NM">

	<input type="hidden" name="ATTCH_FILE_NO"	value="${ATTCH_FILE_NO}">
	<input type="hidden" name="FILE_SER" 		value="${FILE_SER}">

		<table width="350" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="pop_noti01"><img src="Package/ext/images/popup/RBA_90/pop01_bg01.gif"></td>
				<td class="pop_noti02">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id=popWindowHead>
						<tr>
							<td width="20" height="30" valign="top"><img src="Package/ext/images/popup/RBA_90/pop01_ico01.gif"></td>
							<td class="noti_tit01"><c:out value='${BOARD_NM}'/><fmt:message key="AML_90_01_03_02_005" initVal="첨부파일"/></td>
							<td width="20" align="center" class="noti_tit01">
								<a href="javascript:notice_close('notice');">
									<img src="Package/ext/images/popup/RBA_90/pop01_bt01.gif" border="0">
								</a>
							</td>
						</tr>
					</table>
				</td>
				<td class="pop_noti03"><img src="Package/ext/images/popup/RBA_90/pop01_bg03.gif"></td>
			</tr>
			<tr>
				<td bgcolor="#63AAD6">&nbsp;</td>
				<td valign="top" bgcolor="#FFFFFF" style="padding:3 3 3 3;">
					<div style="height:80px;overflow:auto;border:0 solid;">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
<%
					//if (output.getCount("FILE_SEQ") != 0) {
					if (output.getCount("FILE_SEQ") == 0) {
%>
						<tr>
							<td width="*" valign="top" style="padding:0 5 0 5;">
		                		<fmt:message key="AML_90_01_03_06_001" initVal="첨부된 파일이 없습니다."/>
							<td>
						</tr>
					
<%						
					}else{
						//------------------------------------------------------------
						String FILE_SEQ = "";
						String FILE_POS = "";
						String USER_FILE_NM = "";
						String PHSC_FILE_NM = "";
						
						for(int i = 0 ; i < output.getCount("FILE_SEQ") ; i++) {
							FILE_SEQ = output.getText("FILE_SEQ",i);
							FILE_POS = output.getText("FILE_POS",i);
							USER_FILE_NM = output.getText("USER_FILE_NM",i);
							PHSC_FILE_NM = output.getText("PHSC_FILE_NM",i);
							
							request.setAttribute("FILE_SEQ",FILE_SEQ);							
							request.setAttribute("FILE_POS",FILE_POS);							
							request.setAttribute("USER_FILE_NM",USER_FILE_NM);							
							request.setAttribute("PHSC_FILE_NM",PHSC_FILE_NM);							
							request.setAttribute("i_1",i+1);							
							
%>	
							<tr>
								<td width="20px"><b>${i_1}.</b></td>
								<td width="18"><img src="Package/ext/images/icon/ico_save.gif" width="13" height="13" align="absmiddle"></td>
								<td width="*" valign="top" style="padding:0 5 0 5;">
									<a class="file" href='javascript:downloadFile("${FILE_SEQ}");'>
									${USER_FILE_NM}
									</a>
									<input type="hidden" name="FILE_POS${FILE_SEQ}" value="${FILE_POS}${PHSC_FILE_NM}">
									<input type="hidden" name="USER_FILE_NM${FILE_SEQ}" value="${USER_FILE_NM}"> 
									<input type="hidden" name="FILE_SEQ" value="${FILE_SEQ}"> 
								<td>
							</tr>												
<%						
					}
				}
%>
						</table>
					</div>
				</td>
				<td bgcolor="#63AAD6">&nbsp;</td>
			</tr>

			<tr>
				<td class="pop_noti05"><img src="Package/ext/images/popup/RBA_90/pop01_bg05.gif"></td>
				<td bgcolor="#63AAD6"></td>
				<td class="pop_noti04"><img src="Package/ext/images/popup/RBA_90/pop01_bg04.gif"></td>
			</tr>
		</table>
		
	</form>
</body>
</html>		