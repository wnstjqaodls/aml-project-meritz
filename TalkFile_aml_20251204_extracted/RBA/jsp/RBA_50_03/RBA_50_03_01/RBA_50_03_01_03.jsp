<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_03_01_03.jsp
* Description     : 자금세탁 사례관리 등록/수정  처리
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-04-23
--%>

<%@ page import="com.gtone.aml.basic.common.data.DataObj"%>
<%@ page import="com.gtone.aml.server.common.commonUtil"%>
<%@ page import="com.gtone.aml.basic.common.util.*"%>
<%@ page import="com.gtone.aml.user.SessionAMLUtil"%>
<%@ page import="jspeed.base.http.MultipartRequest"%>
<%@ page import="jspeed.base.util.StringHelper"%>
<%@ page import="java.io.*"%>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<%@ page import="jspeed.base.property.PropertyService"%>
<%@ page import="com.gtone.express.server.helper.MessageHelper"%>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_03.RBA_50_03_01.RBA_50_03_01_02"%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%
	DataObj output;
	String uploadfile = PropertyService.getInstance().getProperty("aml.config", "upload.file");
	String fileChk = "N";
	String fileExt = "";
	String fileExt1 = "";

	String ERRCODE = "00000"; // 정상처리 인경우 
	String ERRMSG = MessageHelper.getInstance().getMessage("0002", LANG_CD, "정상 처리되었습니다.");
	String WINMSG = MessageHelper.getInstance().getMessage("0002", LANG_CD, "정상 처리되었습니다.");

	SessionAMLUtil amlUtil = new SessionAMLUtil();

	int uploadFileSize = 50 * 1024 * 1024; // 50M (Max)
	MultipartRequest req = null;

	try {
		req = new MultipartRequest(request, uploadFileSize);

		String GUBN;
		GUBN = StringHelper.evl(req.getParameter("GUBN"), "");
		System.out.println(request.getParameter("GUBN"));
		String[] filestr = req.getParameterValues("NOTI_ATTACH");
		System.out.println("filestr length : " + filestr.length);

		for (int i = 0; i < filestr.length; i++) {
			fileChk = "N";
			//if( !filestr[i].equals("") ) {
			if ("".equals(filestr[i]) == false) {
				fileExt = filestr[i].substring(filestr[i].length() - 3, filestr[i].length());
			} else {
				fileChk = "Y";
			}
			fileExt = fileExt.toLowerCase();

			//if( !filestr[i].equals("") ) {
			if ("".equals(filestr[i]) == false) {
				fileExt1 = filestr[i].substring(filestr[i].length() - 4, filestr[i].length());
			} else {
				fileChk = "Y";
			}

			fileExt1 = fileExt1.toLowerCase();

			if (amlUtil.check(fileExt, uploadfile)) {
				fileChk = "Y";
			}
			if (amlUtil.check(fileExt1, uploadfile)) {
				fileChk = "Y";
			}

			if (filestr[i].indexOf("\n") >= 0 || filestr[i].indexOf("\r") >= 0) {
				ERRCODE = "00099";
				ERRMSG = MessageHelper.getInstance().getMessage("0053", LANG_CD, "첨부된 파일정보를 확인하십시요.")
						+ uploadfile;
				WINMSG = MessageHelper.getInstance().getMessage("0053", LANG_CD, "첨부된 파일정보를 확인하십시요.")
						+ uploadfile;
				break;
			}

			if (!"Y".equals(fileChk)) {
				ERRCODE = "00099";
				ERRMSG = MessageHelper.getInstance().getMessage("0054", LANG_CD, "업로드 할 수  없는 타입의 파일입니다.")
						+ uploadfile;
				WINMSG = MessageHelper.getInstance().getMessage("0054", LANG_CD, "업로드 할 수  없는 타입의 파일입니다.")
						+ uploadfile;
				break;
			}

		}

		if ("00000".equals(ERRCODE)) {

			output = new DataObj();

			output = RBA_50_03_01_02.getInstance().updateInfo(req);

			ERRCODE = Util.nvlTrim(output.getText("ERRCODE"), "");
			ERRMSG = Util.nvlTrim(output.getText("ERRMSG"), "");
			WINMSG = Util.nvlTrim(output.getText("WINMSG"), "");
		}

	} catch (IOException ioe) {
		Log.logAML(Log.ERROR, this, "(IOException)", ioe.toString());
	} catch (RuntimeException re) {
		Log.logAML(Log.ERROR, this, "(RuntimeException)", re.toString());
	} catch (AMLException ex) {
		ERRCODE = "00099";
		Log.logAML(Log.ERROR, this, "(AMLException)", ex.toString());
		ERRMSG = MessageHelper.getInstance().getMessage("0005", LANG_CD, "처리중 오류가 발생하였습니다.");
		WINMSG = MessageHelper.getInstance().getMessage("0005", LANG_CD, "처리중 오류가 발생하였습니다.");
	} catch (Exception ex) {
		ERRCODE = "00099";
		Log.logAML(Log.ERROR, this, "(Exception)", ex.toString());
		ERRMSG = MessageHelper.getInstance().getMessage("0005", LANG_CD, "처리중 오류가 발생하였습니다.");
		WINMSG = MessageHelper.getInstance().getMessage("0005", LANG_CD, "처리중 오류가 발생하였습니다.");
	}

	out.println("<script>");

	if ("00000".equals(ERRCODE)) {
		out.println("parent.doDeleteEnd();");
	} else if ("00999".equals(ERRCODE)) {
		out.println("parent.goReload1();");
	}
	out.println("</script>");
%>