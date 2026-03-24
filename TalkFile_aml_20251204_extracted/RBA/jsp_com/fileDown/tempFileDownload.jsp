<%@ page language="java" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"  %>
<%--
- File Name  : tempFileDownload.jsp
- Author     : JJH
- Comment    : RBA TEMPLATE File Download
- Version    : 1.0
- history    : 1.0 2017-06-07
--%>
<%@ page import = "jspeed.base.util.StringHelper"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.gtone.aml.basic.common.data.DataObj"%>
<%@ page import = "com.gtone.express.server.config.ServerConfig"%>
<%@ page import = "com.gtone.rba.server.type01.RBA_30.RBA_30_04.RBA_30_04_03.RBA_30_04_03_10"%>
<%@page import="java.lang.reflect.InvocationTargetException"   %>

<%
	class MyException extends Exception {
		public MyException(String message) {
		    super(message);
	  } // MyException 생성자
	}

    try {
        request.setCharacterEncoding("utf-8");
        String basYyyy         = StringHelper.evl(request.getParameter("SEND_2_BAS_YYYY"), "");
        String tongjeOprValtId = StringHelper.evl(request.getParameter("SEND_2_TONGJE_OPR_VALT_ID"), "");
        com.gtone.aml.user.SessionAML sessionAML = (com.gtone.aml.user.SessionAML) Class.forName(com.gtone.aml.server.common.commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] { request});
        
        if(sessionAML.getSessionHelper().getUserId()==null) {
            throw new MyException("NOT_LOGIN");
        }
        
        DataObj input = new DataObj();
        DataObj output = new DataObj();
        
        input.add("BAS_YYYY",basYyyy);
        input.add("TONGJE_OPR_VALT_ID",tongjeOprValtId);
        
        output = RBA_30_04_03_10.getInstance().getTempFileName(input);
        String testTmpFileNm = output.getText("TEST_TMP_FILE_NM");
        
        StringBuffer strPath = new StringBuffer(128);
        StringBuffer strMsg = new StringBuffer(128);
        strPath.append(ServerConfig.getInstance().getProperty("RBA_TEMPLATE_EXCEL_FILE"));
        strPath.append('/');
        strPath.append(output.getText("TEST_TMP_FILE_NM"));
        
        String fileFullPath = strPath.toString(); 
        //String fileFullPath = ServerConfig.getInstance().getProperty("RBA_TEMPLATE_EXCEL_FILE") + "/" + output.getText("TEST_TMP_FILE_NM");
        fileFullPath.replace("/",System.getProperty("file.separator"));
        fileFullPath = fileFullPath.replace("\\", "/");
        
        strMsg.append("<script language='javascript'>alert('");
        strMsg.append(fileFullPath);
        strMsg.append("'); history.back();</script>");
        
//         out.println(strMsg.toString());
        //out.println("<script language='javascript'>alert('" + fileFullPath + "'); history.back();</script>");
        File downFile = new File(fileFullPath); 
            
        if( downFile.exists() ) {
            request.setAttribute("SRC", downFile);
            request.setAttribute("FILENAME", URLEncoder.encode(testTmpFileNm , "UTF-8").replaceAll("\\+","%20") );
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
    }catch(Exception e) {
        out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
    }
%>

