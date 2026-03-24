<%@ page language="java" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"%>
<%--
- File Name  : rbaFileDownload.jsp
- Author     : JJH
- Comment    : RBA File Download
- Version    : 1.0
- history    : 1.0 2017-06-09
--%>
<%@ page import = "jspeed.base.util.StringHelper"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.gtone.aml.basic.common.data.DataObj"%>
<%@ page import = "com.gtone.rba.server.type01.RBA_30.RBA_30_04.RBA_30_04_03.RBA_30_04_03_10"%>
<%@page import="com.gtone.aml.admin.AMLException"   %>
<%@page import="java.lang.reflect.InvocationTargetException"   %>

<%

class MyException extends Exception {
	public MyException(String message) {
	    super(message);
  } // MyException 생성자
}

    try {
        request.setCharacterEncoding("utf-8");
        String ATTCH_FILE_NO = StringHelper.evl(request.getParameter("ATTCH_FILE_NO"), "");
        String FILE_SER = StringHelper.evl(request.getParameter("FILE_SER"), "");
        
        com.gtone.aml.user.SessionAML sessionAML = (com.gtone.aml.user.SessionAML) Class.forName(com.gtone.aml.server.common.commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] { request});
        
        if(sessionAML.getSessionHelper().getUserId()==null) {
            throw new MyException("NOT_LOGIN");
        }
        
        DataObj input = new DataObj();
        DataObj output = new DataObj();
        
        input.add("ATTCH_FILE_NO",ATTCH_FILE_NO);
        input.add("FILE_SER",FILE_SER);
        
        output = RBA_30_04_03_10.getInstance().getFilePathName(input);
        
        String fileFullPath = output.getText("FILE_POS") + output.getText("PHSC_FILE_NM");
        fileFullPath.replace("/",System.getProperty("file.separator"));
        fileFullPath = fileFullPath.replace("\\", "/");
        
        String userFileNm = output.getText("LOSC_FILE_NM");
            
        File downFile = new File(fileFullPath);
        
        if( downFile.exists() ) {
            
            request.setAttribute("SRC", downFile);
            request.setAttribute("FILENAME", URLEncoder.encode(userFileNm , "UTF-8").replaceAll("\\+","%20") );
            request.setAttribute("CONTENT-TYPE", "application/octet-stream");
            
            RBA_30_04_03_10.getInstance().updateDownloadCnt(input);
            
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

