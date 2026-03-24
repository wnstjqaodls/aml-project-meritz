<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_01_05.jsp
* Description     : file 등록처리 
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-25
--%>
<%@ page import="com.gtone.aml.basic.common.data.DataObj" %>
<%@ page import="com.gtone.aml.server.common.commonUtil"  %>
<%@ page import="com.gtone.aml.basic.common.util.*"  %>
<%@ page import="com.gtone.aml.user.SessionAMLUtil" %>
<%@ page import="jspeed.base.http.MultipartRequest" %>
<%@ page import="jspeed.base.util.StringHelper"  %>
<%@ page import="jspeed.base.property.PropertyService" %>
<%@ page import="com.gtone.express.server.helper.MessageHelper" %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_01.RBA_50_05_01_03"  %>

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
	
	try {
		req = new MultipartRequest(request, uploadFileSize);
        
		String [] filestr = req.getParameterValues("NOTI_ATTACH");
		for(int i = 0; i < filestr.length; i++) {
			fileChk = "N";
			//if( !filestr[i].equals("") ) {
			if( "".equals(filestr[i]) == false ) {
				fileExt = filestr[i].substring(filestr[i].length() - 3, filestr[i].length());
			} else {
				fileChk = "Y";
			}
			fileExt = fileExt.toLowerCase();

			//if( !filestr[i].equals("") ) {
			if( "".equals(filestr[i]) == false ) {
				fileExt1 = filestr[i].substring(filestr[i].length() - 4, filestr[i].length());
			} else {
				fileChk = "Y";
			}
			
			fileExt1 = fileExt1.toLowerCase();
			
					
			if(amlUtil.check(fileExt,uploadfile)) {fileChk =  "Y";}
			if(amlUtil.check(fileExt1,uploadfile)) {fileChk =  "Y";}
			
			
			if(filestr[i].indexOf("\n")>=0 || filestr[i].indexOf("\r")>=0)
			{
				ERRCODE = "00099";
				ERRMSG  = MessageHelper.getInstance().getMessage("0053",LANG_CD,"첨부된 파일정보를 확인하십시요.") + uploadfile;
				WINMSG  = MessageHelper.getInstance().getMessage("0053",LANG_CD,"첨부된 파일정보를 확인하십시요.") + uploadfile;
				break;
			}			
			
			if(	!"Y".equals(fileChk)) 
			{
				ERRCODE = "00099";
				ERRMSG  = MessageHelper.getInstance().getMessage("0054",LANG_CD,"업로드 할 수  없는 타입의 파일입니다.") + uploadfile;
				WINMSG  = MessageHelper.getInstance().getMessage("0054",LANG_CD,"업로드 할 수  없는 타입의 파일입니다.") + uploadfile;
				break;
			}
						
		}	
		
		if( "00000".equals(ERRCODE)  ) {
			
			output = new DataObj();
		    output = RBA_50_05_01_03.getInstance().doSaveF(req); 
			
			ERRCODE = Util.nvlTrim(output.getText("ERRCODE"),"");
			ERRMSG  = Util.nvlTrim(output.getText("ERRMSG"),"");
			WINMSG  = Util.nvlTrim(output.getText("WINMSG"),"");
		}		
		
	} catch(RuntimeException e){
		ERRCODE = "00099";
		//ERRMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.") + "["+e.getMessage()+"]";
		//WINMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.") + "["+e.getMessage()+"]";
		//20141030 hikim
		ERRMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.");
		WINMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.");	
	} catch(Exception e){
		ERRCODE = "00099";
		//ERRMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.") + "["+e.getMessage()+"]";
		//WINMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.") + "["+e.getMessage()+"]";
		//20141030 hikim
		ERRMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.");
		WINMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.");	
	}

	out.println("<script>");
	
// 	out.println("alert('"+WINMSG+"');");	
	if("00000".equals(ERRCODE)) {
	  out.println("parent.doSave_end();");
	} else if ("00999".equals(ERRCODE) ) {
	  out.println("parent.goReload1();");
	}
	
	out.println("</script>");
%>