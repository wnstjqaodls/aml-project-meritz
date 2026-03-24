<%--
- File Name  : fileDownload.jsp
- Author     : syk, hikim
- Comment    : Resource Center File Download
- Version    : 1.0
- history    : 1.0 2010-09-30
--%>
<%@page import="net.sf.jazzlib.ZipEntry"                        %>
<%@page import="java.lang.reflect.InvocationTargetException"    %>
<%@page import="java.sql.SQLException"                          %>
<%@page import="net.sf.jazzlib.ZipOutputStream"                 %> 
<%@page import="com.gtone.express.server.dao.MCommonDAOSingle"  %>
<%@page import="com.gtone.aml.basic.common.util.DateUtil"       %>
<%@page import="com.gtone.aml.basic.common.log.Log"             %>
<%@page import="java.util.*"                                    %>
<%@page import="jspeed.base.jdbc.*"                             %>
<%@ page language="java" import="jspeed.base.util.StringHelper,java.io.*" contentType="text/html;charset=utf-8" errorPage="/jspeed/common/error.jsp"  %>
<%
    com.gtone.aml.user.SessionAML sessionAML = null;
    String RPT_GJDT = StringHelper.evl(request.getParameter("RPT_GJDT"),"");
try{
	request.setCharacterEncoding("utf-8");
	sessionAML = (com.gtone.aml.user.SessionAML) Class.forName(com.gtone.aml.server.common.commonUtil.getAMLSessionClassName()).getConstructor(new Class[] {HttpServletRequest.class}).newInstance(new Object[] { request});
}catch(UnsupportedEncodingException e){
	Log.logAML(Log.ERROR, this, "attchFileDownload", e);
}catch(SecurityException e){
	Log.logAML(Log.ERROR, this, "attchFileDownload", e);
}catch(ClassNotFoundException e){
	Log.logAML(Log.ERROR, this, "attchFileDownload", e);
}
catch(NoSuchMethodException e){
	Log.logAML(Log.ERROR, this, "attchFileDownload", e);
}
catch(InstantiationException e){
	Log.logAML(Log.ERROR, this, "attchFileDownload", e);
}
catch(IllegalAccessException e){
	Log.logAML(Log.ERROR, this, "attchFileDownload", e);
}
catch(IllegalArgumentException e){
	Log.logAML(Log.ERROR, this, "attchFileDownload", e);
}
catch(InvocationTargetException e){
	Log.logAML(Log.ERROR, this, "attchFileDownload", e);
}
 
	class MyException extends Exception {
		  public MyException(String message) {
		    super(message);
		  } // MyException 생성자
		}

	if(sessionAML.getSessionHelper().getUserId()==null)
	{
		throw new MyException("NOT_LOGIN");
	}
	//File downFile = new File(FILE_POS+PHSC_FILE_NM);   // ����, 2014-04-13
	//System.out.println(downFile.getAbsolutePath());
	
	HashMap output; output = new HashMap();
	String today;   today = DateUtil.getDateString();
	String filelistPHSC[];
	String filelistLOSC[];
	int    fileIndex=0;
	CacheResultSet rs=null;
	MCommonDAOSingle mDaos = null;
	File downFile = null;
	ZipOutputStream zout=null;
	FileInputStream in = null;
	FileOutputStream fos = null;
	try{
		downFile = File.createTempFile(RPT_GJDT.replace("\\", "/")+"_AttchFile", ".zip");
		mDaos = new MCommonDAOSingle();
		HashMap inHash=new HashMap();
		inHash.put("RPT_GJDT",RPT_GJDT);
		rs = mDaos.executeQuery("RBA_attchFile_Export", inHash);
		int rc = rs.getRowCount();
		
		if(rc == 0){
			out.println("<script language='javascript'>alert('다운로드 할 첨부 파일이 존재하지 않습니다.'); history.back();</script>");
			return;
		}
		if( rc > 0 || rc < 2147483647){
			try{	
				fos = new FileOutputStream(downFile);
				zout = new ZipOutputStream (fos);
				
				filelistPHSC=new String[rc];
				filelistLOSC=new String[rc]; 
				while(rs.next()){
					filelistPHSC[fileIndex]=rs.getString("FILE_PATH")+rs.getString("PHSC_FILE_NM"); 
					filelistLOSC[fileIndex]=rs.getString("ID")+File.separator+rs.getString("NAME"); 
					fileIndex++;
				}
				rs.close();
				for( int i=0; i< filelistPHSC.length; i++){
					zout.putNextEntry(new ZipEntry(filelistLOSC[i]));
					in = new FileInputStream(filelistPHSC[i].replace("\\", "/"));
					byte[] buf = new byte[1024];
			        int len;
			        len = in.read(buf);
				    while (len > 0) {
				    	zout.write(buf, 0, len);
				    }   
				    zout.closeEntry();
				    in.close();
				}
			}catch(FileNotFoundException e){
				Log.logAML(Log.ERROR, this, "attchFileDownload", e);
			}catch(SQLException e){
				Log.logAML(Log.ERROR, this, "attchFileDownload", e);
			}finally{
				if(fos != null){
					fos.close();	
				}
				if(zout != null){
					zout.close();	
				}
				if(in != null){
					in.close();	
				}
			}
			
		}
	//	System.out.println("=====================>" + downFile.getAbsolutePath());
	 
		if( downFile.exists() ) 
		{
			request.setAttribute("SRC", downFile);
			request.setAttribute("FILENAME", RPT_GJDT+"_AttchFile.ZIP");  // ����, 2014-04-13
			request.setAttribute("CONTENT-TYPE", "application/octet-stream");
			out.clear();
			out = pageContext.pushBody();
			pageContext.forward("/DownLoadServlet");
			if ( downFile.canWrite() ){
				downFile.delete();
			}
		}
		else 
		{
			out.println("<script language='javascript'>alert('File does not exist.'); history.back();</script>");
			return;
		}
	} catch(RuntimeException e) {
		Log.logAML(Log.ERROR, e);
		//out.println("<script language='javascript'>alert('File Error....["+e.getMessage()+"]');</script>");
		//20140826
		out.println("<script language='javascript'>alert('File Error..[Download]'); history.back();</script>");
	} catch(Exception e) {
		Log.logAML(Log.ERROR, e);
		//out.println("<script language='javascript'>alert('File Error....["+e.getMessage()+"]');</script>");
		//20140826
		out.println("<script language='javascript'>alert('File Error..[Download]'); history.back();</script>");
	}/*  finally{
		if(zout!=null)
			zout.close(); 
	} */
%>