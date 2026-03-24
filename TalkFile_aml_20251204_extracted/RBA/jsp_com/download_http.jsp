<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : download_http.jsp
- Author     : ksy
- Comment    : RBA Download
- Version    : 1.0
- history    : 1.0 2017-01-04
--%>

<%@ page import="java.io.*" %>
<%@ page import="com.gtone.express.server.config.ServerConfig"  %>

<%
	String file_name = request.getParameter("REPORT_FILE_NAME");
	String dt = request.getParameter("REPORT_CRE_DT");
	String Path = ServerConfig.getInstance().getProperty("RBA_REPORT_EXCEL_FILE");
	String Full = Path + "/JIPYO/" + dt + "/" + file_name;
	
	class MyException extends Exception {
		  public MyException(String message) {
		    super(message);
		  } // MyException 생성자
		}
	
	if (file_name.indexOf("/") >= 0 || file_name.indexOf("\\") >= 0) {
		throw new MyException("FILE NAME ERROR");
	}

	if (file_name.indexOf("\n") >= 0 || file_name.indexOf("\r") >= 0) {
		throw new MyException("FILE NAME ERROR");
	}

	File file = new File(Full);
	response.setContentType("application/octer-stream");

	String Agent = request.getHeader("USER-AGENT");

	if (Agent.indexOf("MSIE") >= 0) {
		int i = Agent.indexOf('M', 2);
		String IEV = Agent.substring(i + 5, i + 8);
		if (IEV.equalsIgnoreCase("5.5")) {
			response.setHeader("Content-Disposition", "filename="+ file_name);
		} else {
			response.setHeader("Content-Disposition", "attachment;filename=" + file_name);
		}
	} else {
		response.setHeader("Content-Disposition", "attachment;filename=" + file_name);
	}
	
	out.clear();
	pageContext.pushBody();
	
	BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());

	byte b[] = new byte[5 * 1024 * 1024]; //max=5M byte 
	if (file.isFile()) {
		try {
			int read = 0;
			read = fin.read(b);
			while (read != -1) {
				outs.write(b, 0, read);
			}
			outs.flush();
			outs.close();
			fin.close();
		} catch (RuntimeException e) {
			response.reset();
			response.setContentType("text/html;charset=utf-8");
			out.println("<script language='javascript'>");
			out.println("alert('No Data File...');");
			out.println("</script>");
		} catch (Exception e) {
			response.reset();
			response.setContentType("text/html;charset=utf-8");
			out.println("<script language='javascript'>");
			out.println("alert('No Data File...');");
			out.println("</script>");
		} finally {
			
			if (outs != null) {
				outs.close();
			}

			if (fin != null) {
				fin.close();
			}

		}
	}
%>