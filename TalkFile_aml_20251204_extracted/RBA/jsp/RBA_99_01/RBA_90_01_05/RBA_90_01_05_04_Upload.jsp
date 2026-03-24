<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_05_04_Upload.jsp
- Author     : SeungRok
- Comment    : file 등록처리                                      
               Resource Registration Treatment
- Version    : 1.0
- history    : 1.0 2016-12-19
--%>

<%@ page import="com.gtone.aml.basic.common.data.DataObj" %>
<%@ page import="com.gtone.aml.server.common.commonUtil"  %>
<%@ page import="com.gtone.aml.basic.common.util.*"  %>
<%@ page import="com.gtone.aml.user.SessionAMLUtil" %>
<%@ page import="jspeed.base.http.MultipartRequest" %>
<%@ page import="jspeed.base.util.StringHelper"  %>
<%@ page import="jspeed.base.property.PropertyService" %>
<%@ page import="com.gtone.express.server.helper.MessageHelper" %>
<%@ page import="com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_05.RBA_90_01_05_04"  %>

<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    DataObj output=null;

	String uploadfile = PropertyService.getInstance().getProperty("aml.config","upload.file");

	String fileChk = "N";
	String fileExt = ""; 
	String fileExt1 = ""; 

	String ERRCODE = "00000"; // 정상처리 인경우 
	String ERRMSG  = MessageHelper.getInstance().getMessage("0002",LANG_CD,"정상 처리되었습니다.");
	String WINMSG  = MessageHelper.getInstance().getMessage("0002",LANG_CD,"정상 처리되었습니다.");
	
	SessionAMLUtil amlUtil = new SessionAMLUtil();

	int uploadFileSize = 50 * 1024 * 1024; // 50M (Max)
	MultipartRequest req = null;
	
	StringBuffer str = new StringBuffer(64);
	
	try {
		req = new MultipartRequest(request, uploadFileSize);
        
		String [] filestr = req.getParameterValues("EXCEL_UPLOAD_FILE");
		
		for (int i = 0; i < filestr.length; i++) {
			fileChk = "N";
			
			if ( filestr[i].equals("") ) {
				//fileExt = filestr[i].substring(filestr[i].length() - 3, filestr[i].length());
				fileChk = "Y";
			} else {
				//fileChk = "Y";
				fileExt = filestr[i].substring(filestr[i].length() - 3, filestr[i].length());
			}
			
			fileExt = fileExt.toLowerCase();

			if ( filestr[i].equals("") ) {
				//fileExt1 = filestr[i].substring(filestr[i].length() - 4, filestr[i].length());
				fileChk = "Y";
			} else {
				//fileChk = "Y";
				fileExt1 = filestr[i].substring(filestr[i].length() - 4, filestr[i].length());
			}
			
			fileExt1 = fileExt1.toLowerCase();
					
			if (amlUtil.check(fileExt,uploadfile)) {
				fileChk =  "Y";
			}
			
			if (amlUtil.check(fileExt1,uploadfile)) {
				fileChk =  "Y";
			} 
			
			if (filestr[i].indexOf("\n")>=0 || filestr[i].indexOf("\r")>=0) {
				ERRCODE = "00099";
				ERRMSG  = MessageHelper.getInstance().getMessage("0053",LANG_CD,"첨부된 파일정보를 확인하십시요.") + uploadfile;
				WINMSG  = MessageHelper.getInstance().getMessage("0053",LANG_CD,"첨부된 파일정보를 확인하십시요.") + uploadfile;
				break;
			}			
			
			if ( !"Y".equals(fileChk)) {
				ERRCODE = "00099";
				ERRMSG  = MessageHelper.getInstance().getMessage("0054",LANG_CD,"업로드 할 수  없는 타입의 파일입니다.") + uploadfile;
				WINMSG  = MessageHelper.getInstance().getMessage("0054",LANG_CD,"업로드 할 수  없는 타입의 파일입니다.") + uploadfile;
				break;
			}
		}	
		
		if ( "00000".equals(ERRCODE)  ) {
			
			output = new DataObj();
		    output = RBA_90_01_05_04.getInstance().doSaveJipyoFile(req); 
			ERRCODE = Util.nvlTrim(output.getText("ERRCODE"),"");
			ERRMSG  = Util.nvlTrim(output.getText("ERRMSG"),"");
			WINMSG  = Util.nvlTrim(output.getText("WINMSG"),"");
			
		}
		
// 	} catch (IOException ioe) {
// 		Log.logAML(Log.ERROR, this, "(IOException)", ioe.toString());
	} catch (RuntimeException re) {
		Log.logAML(Log.ERROR, this, "(RuntimeException)", re.toString()); 
	} catch(Exception e) {
		ERRCODE = "00099";
		ERRMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.");
		WINMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.");	
	}
	
/* 	str.append("alert('");
	str.append(WINMSG);
	str.append("');");
 */	
	str.append("showAlert('");
	str.append(WINMSG);
	str.append("','INFO');");


	out.println("<script>");
// 	out.println(str.toString());	
	//out.println("alert('"+WINMSG+"');");	
	
	if ("00000".equals(ERRCODE)) {
	  out.println("parent.doSave_end();");
	}else{
		out.println("parent.doError_end();");
	}
	
	out.println("</script>");
%>