<%@ page language="java" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"%>
<%--
- File Name  : CSVTempFileDownload.jap
- Author     : lyj
- Comment    : RBA TEMPLATE File Download
- Version    : 1.0
- history    : 1.0 2018-01-09
--%>
<%@ page import = "jspeed.base.util.StringHelper"%>
<%@ page import = "java.io.*"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.gtone.aml.basic.common.data.DataObj"%>
<%@ page import = "com.gtone.express.server.config.ServerConfig"%>
<%@page import="java.lang.reflect.InvocationTargetException"   %>

<%
    try {
        request.setCharacterEncoding("utf-8");
        String pageID;   pageID = StringHelper.evl(request.getParameter("pageID"), "");
        String SAMPLE;   SAMPLE = StringHelper.evl(request.getParameter("SAMPLE"), "");
        String RPT_GJDT; RPT_GJDT = StringHelper.evl(request.getParameter("RPT_GJDT"), "");
        
        com.gtone.aml.user.SessionAML sessionAML = (com.gtone.aml.user.SessionAML) Class.forName(com.gtone.aml.server.common.commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] { request});
        
        class MyException extends Exception {
  		  public MyException(String message) {
  		    super(message);
  		  } // MyException 생성자
  		}
        
        if(sessionAML.getSessionHelper().getUserId()==null) {
            throw new MyException("NOT_LOGIN");
        }
        
        DataObj input;  input = new DataObj();
        DataObj output; output = new DataObj();
        
        input.add("pageID",pageID);
        input.add("SAMPLE",SAMPLE);
        String testTmpFileNm = "";
        if("RBA_10_05_02_03".equals(pageID)){
            System.out.println("RBA_10_05_02_03");
        	testTmpFileNm = "KoFIU_Item_Template.csv";
        }else if("RBA_10_05_08_03".equals(pageID)){
            System.out.println("RBA_10_05_08_03");
        	testTmpFileNm = "KoFIU_Data_Template.csv";
	    }else{
            System.out.println("else");
            testTmpFileNm = "KoFIU_Excel Upload_template.xls";
        }
        //String fileFullPath = ServerConfig.getInstance().getProperty("RBA_TEMPLATE_CSV_FILE") + "/" + testTmpFileNm;
        String fileFullPath = ServerConfig.getInstance().getProperty("RBA_TEMPLATE_EXCEL_FILE") + "/" + testTmpFileNm;
        fileFullPath.replace("/",System.getProperty("file.separator"));
        fileFullPath = fileFullPath.replace("\\", "/");
        
        
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
    } catch(Exception e) {
       out.println("<script language='javascript'>alert('File Error..[Download]');</script>");
    }
%>

