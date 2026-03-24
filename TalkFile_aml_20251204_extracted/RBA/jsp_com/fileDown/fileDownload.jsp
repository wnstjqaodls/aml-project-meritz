<%--
- File Name  : fileDownload.jsp
- Author     : syk, hikim
- Comment    : Resource Center File Download
- Version    : 1.0
- history    : 1.0 2010-09-30
--%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.gtone.aml.dao.common.MDaoUtil"%>
<%@page import="com.gtone.aml.dao.common.MDaoUtilSingle" %>
<%@page language="java" import="jspeed.base.util.StringHelper, java.io.* ,com.gtone.aml.basic.common.data.DataObj" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"  %><%

class MyException extends Exception {
	public MyException(String message) {
	    super(message);
  } // MyException 생성자
}

try {	
	request.setCharacterEncoding("utf-8");
	//String FILE_POS 	= StringHelper.evl(request.getParameter("FILE_POS"),"");
    //String PHSC_FILE_NM = StringHelper.evl(request.getParameter("PHSC_FILE_NM"),"");    // 추가, 2014-04-13
	//String USER_FILE_NM = StringHelper.evl(request.getParameter("USER_FILE_NM"),"");
	String ATTCH_FILE_NO; ATTCH_FILE_NO = StringHelper.evl(request.getParameter("ATTCH_FILE_NO"),"");
	String FILE_SER;      FILE_SER = StringHelper.evl(request.getParameter("FILE_SER"),"");
	String FILE_TYPE;     FILE_TYPE = StringHelper.evl(request.getParameter("FILE_TYPE"),"");
	String RBATYPE;		  RBATYPE=StringHelper.evl(request.getParameter("RBATYPE"),"");
	
	
	//System.out.println("download================>" + BOARD_ID + ", " + BOARD_SEQ + ", " + FILE_SEQ + ", " + FILE_TYPE );
	com.gtone.aml.user.SessionAML sessionAML = (com.gtone.aml.user.SessionAML) Class.forName(com.gtone.aml.server.common.commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] { request});
	 
	if(sessionAML.getSessionHelper().getUserId()==null)
	{
		throw new MyException("NOT_LOGIN");
	}
	//File downFile = new File(FILE_POS+PHSC_FILE_NM);   // 수정, 2014-04-13
	//System.out.println(downFile.getAbsolutePath());
		MDaoUtil mDao; mDao = null;
		DataObj 	input	= new DataObj();
		input.add("ATTCH_FILE_NO",ATTCH_FILE_NO);
		input.add("FILE_SER",FILE_SER);
	//	if ("AML_01".equals(BOARD_ID)) //AML_90_01_03_02.getInstance().doDownUpdate(input);
		
		DataObj output_file = new DataObj();
		
		if("04".equals(RBATYPE)) {
			output_file = MDaoUtilSingle.getData("RBA_04_01_01_01_getSearchFileOne", input);
		} else {
			output_file = MDaoUtilSingle.getData("RBA_10_02_01_01_getSearchFileOne", input);
		}
		
		//System.out.println("=====================>" + output_file);
		File downFile = new File(output_file.getText("FILE_POS",0).replace("\\", "/") + output_file.getText("PHSC_FILE_NM",0).replace("\\", "/"));
		String LOSC_FILE_NM = "";
		if(output_file.getCount("FILE_SER") > 0) {
		    LOSC_FILE_NM = output_file.getText("LOSC_FILE_NM",0);
		}
		else
		{
			throw new MyException("FILE NOT FOUND");
		}
		downFile = new File(output_file.getText("FILE_POS",0).replace("\\", "/")+"/"+output_file.getText("PHSC_FILE_NM",0).replace("\\", "/")); // 수정, 2014-04-13
		if( downFile.exists() ) 
		{
			request.setAttribute("SRC", downFile);
			request.setAttribute("FILENAME", URLEncoder.encode(LOSC_FILE_NM , "UTF-8").replaceAll("\\+","%20") );	//수정, 2017-06-26 한글깨짐으로 인하여 소스 수정
//			request.setAttribute("FILENAME", new String(LOSC_FILE_NM.getBytes(),"8859_1") );
	
			//request.setAttribute("FILENAME", USER_FILE_NM);  // 수정, 2014-04-13
			request.setAttribute("CONTENT-TYPE", "application/octet-stream");
			
			out.clear();
			out = pageContext.pushBody();
			pageContext.forward("/DownLoadServlet");
		}
		else 
		{
			out.println("<script language='javascript'>alert('File does not exist.'); history.back();</script>");
			return;
		}
	  
	
} catch(RuntimeException e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
} catch(Exception e) {
	out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
}
%>

