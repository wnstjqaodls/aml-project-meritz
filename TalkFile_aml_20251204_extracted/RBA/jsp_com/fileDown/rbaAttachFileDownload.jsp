<%--
- File Name  : rbaAttachFileDownload.jsp
- Author     : nhm
- Comment    : Resource Center File Download
- Version    : 1.0
- history    : 1.0 2018-12-12
--%>
<%@ page language="java" import="jspeed.base.util.StringHelper, java.io.* ,com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_04.RBA_90_01_04_04, com.gtone.aml.basic.common.data.DataObj" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"  %>
<%@page import = "java.net.URLEncoder"%>
<%@page import="com.gtone.aml.admin.AMLException"   %>
<%@page import="java.lang.reflect.InvocationTargetException"   %>

<%
try {	
	request.setCharacterEncoding("utf-8");
	
	String ATTCH_FILE_NO; ATTCH_FILE_NO = StringHelper.evl(request.getParameter("ATTCH_FILE_NO"),"");
	String FILE_SER;      FILE_SER = StringHelper.evl(request.getParameter("FILE_SER"),"");
	String FILE_TYPE;     FILE_TYPE = StringHelper.evl(request.getParameter("FILE_TYPE"),"");
	
	com.gtone.aml.user.SessionAML sessionAML = (com.gtone.aml.user.SessionAML) Class.forName(com.gtone.aml.server.common.commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] { request});
	 
	if (sessionAML.getSessionHelper().getUserId()==null) {
		%>         
	    <script language="javascript">
       		alert('NOT_LOGIN');
    	</script>
	    <%  
		//throw new Exception("NOT_LOGIN");
	}
	
	DataObj 	input	= new DataObj();
	
	input.add("ATTCH_FILE_NO",ATTCH_FILE_NO.replaceAll(" ",""));
	input.add("FILE_SER",FILE_SER);
	
	DataObj output_file = new DataObj();
	DataObj output_file2 = new DataObj();
	
	output_file = RBA_90_01_04_04.getInstance().doSearch(input);
	
	output_file2 = RBA_90_01_04_04.getInstance().doUpdateCount(input);
	
	System.out.println("####################################################################################");
	System.out.println("####################################################################################");
	System.out.println("####################################################################################");
	System.out.println("####################################################################################");
	System.out.println("##### rbaAttachFileDownload.jsp = 1 ");
	
	System.out.println("##### rbaAttachFileDownload.jsp = FILE_POS = " + output_file.getText("FILE_POS",0));
	

	File downFile = new File(output_file.getText("FILE_POS",0) + output_file.getText("PHSC_FILE_NM",0));
	String USER_FILE_NM = "";
	
	if (output_file.getCount("FILE_SEQ") > 0) {
		USER_FILE_NM = output_file.getText("USER_FILE_NM",0);
	} else {
		%>         
	    <script language="javascript">
       		alert('FILE NOT FOUND');
    	</script>
	    <%  
	}

	downFile = new File(output_file.getText("FILE_POS",0)+output_file.getText("PHSC_FILE_NM",0)); // 수정, 2014-04-13 
	
	if ( downFile.exists() ) {
		
		request.setAttribute("SRC", downFile);
		request.setAttribute("FILENAME", URLEncoder.encode(USER_FILE_NM , "UTF-8").replaceAll("\\+","%20") );	//수정, 2017-06-26 한글깨짐으로 인하여 소스 수정
		
		request.setAttribute("CONTENT-TYPE", "application/octet-stream");
		out.clear();
		out = pageContext.pushBody();
		pageContext.forward("/DownLoadServlet");
	} else {
		out.println("<script language='javascript'>alert('File does not exist.'); history.back();</script>");
		return;
	}
	  
	
} catch(UnsupportedEncodingException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(ClassNotFoundException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(NoSuchMethodException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(SecurityException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(InstantiationException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(IllegalAccessException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(IllegalArgumentException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(InvocationTargetException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(AMLException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(Exception e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} 
%>

