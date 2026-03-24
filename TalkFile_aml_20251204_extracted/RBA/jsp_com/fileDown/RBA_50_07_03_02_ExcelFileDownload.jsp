<%@ page language="java" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"%>
<%--
- File Name  : RBA_50_07_03_02_ExcelFileDownload.jap
- Author     : 정성원(저축은행 KPMG 버전)
- Comment    : RBA 위험평가결과보고 Excel File Download
- Version    : 1.0
- history    : 1.0 2019-04-04
--%>
<%@ page import = "jspeed.base.util.StringHelper"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.gtone.express.server.config.ServerConfig"%>
<%@page import="java.lang.reflect.InvocationTargetException"   %>

<%
class MyException extends Exception {
	public MyException(String message) {
	    super(message);
  } // MyException 생성자
}    

try {
        request.setCharacterEncoding("utf-8");
        
        String BAS_YYMM2 	= StringHelper.evl(request.getParameter("BAS_YYMM2"), "");
        String BAS_YYMM 	= StringHelper.evl(request.getParameter("BAS_YYMM"), "");
        com.gtone.aml.user.SessionAML sessionAML = (com.gtone.aml.user.SessionAML) Class.forName(com.gtone.aml.server.common.commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] { request});
        
        if(sessionAML.getSessionHelper().getUserId()==null) {
            throw new MyException("NOT_LOGIN");
        }
        
        String path = ServerConfig.getInstance().getProperty("RBA_KPMG_FILE_PATH");
        String down_file = BAS_YYMM2 + "_" + BAS_YYMM + "_" + ServerConfig.getInstance().getProperty("RBA_KPMG_COMP_FILE");
         
        String fileFullPath = path + down_file;
        fileFullPath.replace("/",System.getProperty("file.separator"));
        fileFullPath = fileFullPath.replace("\\", "/");
        
        File downFile = new File(fileFullPath);
        if( downFile.exists() ) {
            
            request.setAttribute("SRC", downFile);
            request.setAttribute("FILENAME", URLEncoder.encode(down_file , "UTF-8").replaceAll("\\+","%20") );
            request.setAttribute("CONTENT-TYPE", "application/octet-stream");
            
            out.clear();
            out = pageContext.pushBody();
            pageContext.forward("/DownLoadServlet");
            
        } else {
            out.println("<script language='javascript'>alert('엑셀 파일생성 중입니다.'); history.back();</script>");
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
    } catch(Exception e) {
        out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
    }
%>

