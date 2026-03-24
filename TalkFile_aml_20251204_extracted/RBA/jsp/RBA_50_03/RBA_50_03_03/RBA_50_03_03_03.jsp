<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_50_03_03_03.jsp
- Author     : LCJ
- Comment    : 위험평가배점관리 upload
- Version    : 1.0
- history    : 1.0 2018-05-02
--%>
<%@ page import="com.gtone.aml.basic.common.data.DataObj" %>
<%@ page import="com.gtone.aml.server.common.commonUtil"  %>
<%@ page import="com.gtone.aml.basic.common.util.*"  %>
<%@ page import="java.io.*"%>
<%@ page import="com.gtone.aml.admin.AMLException"%>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>    
<%@ page import="com.gtone.aml.user.SessionAMLUtil" %>
<%@ page import="jspeed.base.http.MultipartRequest" %>
<%@ page import="jspeed.base.util.StringHelper"  %>
<%@ page import="jspeed.base.property.PropertyService" %>
<%@ page import="com.gtone.express.server.helper.MessageHelper" %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_03.RBA_50_03_03.RBA_50_03_03_01"%>

<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    DataObj output = null;
    
    String uploadfile = PropertyService.getInstance().getProperty("aml.config","upload.file.xls");
    String fileChk = "N";
    String fileExt = "";
    String fileExt1 = "";
    //String loginId = "";
    
    String ERRCODE = "00000"; // 정상처리 인경우
    String ERRMSG = MessageHelper.getInstance().getMessage("0002",LANG_CD,"정상 처리되었습니다.");
    String WINMSG = MessageHelper.getInstance().getMessage("0002",LANG_CD,"정상 처리되었습니다.");
    
    String errDatail = "";
    
    SessionAMLUtil amlUtil = new SessionAMLUtil();
    int uploadFileSize = 50 * 1024 * 1024; // 50M (Max)
    MultipartRequest req = null;
    
    try {
        req = new MultipartRequest(request, uploadFileSize);
        
        String [] filestr = req.getParameterValues("EXCEL_UPLOAD_FILE");
        
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
            
            if(filestr[i].indexOf("\n")>=0 || filestr[i].indexOf("\r")>=0){
                ERRCODE = "00099";
                ERRMSG  = MessageHelper.getInstance().getMessage("0053",LANG_CD,"첨부된 파일정보를 확인하십시요.") + uploadfile;
                WINMSG  = MessageHelper.getInstance().getMessage("0053",LANG_CD,"첨부된 파일정보를 확인하십시요.") + uploadfile;
                errDatail = "0053";
                break;
            }
            
            if(	!"Y".equals(fileChk)){
                ERRCODE = "00099";
                ERRMSG  = MessageHelper.getInstance().getMessage("0054",LANG_CD,"업로드 할 수  없는 타입의 파일입니다.") + uploadfile;
                WINMSG  = MessageHelper.getInstance().getMessage("0054",LANG_CD,"업로드 할 수  없는 타입의 파일입니다.") + uploadfile;
                errDatail = "0054";
                
                break;
            }
        }
        
        if( "00000".equals(ERRCODE)  ) {
            output = RBA_50_03_03_01.getInstance().doSave(req);
            ERRCODE = Util.nvlTrim(output.getText("ERRCODE"),"");
            ERRMSG  = Util.nvlTrim(output.getText("ERRMSG"),"");
            WINMSG  = Util.nvlTrim(output.getText("WINMSG"),"");
        }
        if(output != null){
        output.put("ERRCODE", "00000");
        output.put("ERRMSG", MessageHelper.getInstance().getMessage("0002", LANG_CD, "정상처리되었습니다"));
        output.put("WINMSG", MessageHelper.getInstance().getMessage("0002", LANG_CD, "정상처리되었습니다"));
        }
    
    } catch (IOException ex) {
        Log.logAML(Log.ERROR,this,"(IOException)",ex.toString());
    } catch (RuntimeException ex) {
        Log.logAML(Log.ERROR,this,"(RuntimeException)",ex.toString());
    } catch (AMLException ex) {
        Log.logAML(Log.ERROR,this,"(AMLException)",ex.toString());
    } catch(Exception ex){
        ERRCODE = "00099";
        Log.logAML(Log.ERROR,this,"(Exception)",ex.toString());
        ERRMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.");
        WINMSG  = MessageHelper.getInstance().getMessage("0005",LANG_CD,"처리중 오류가 발생하였습니다.");
        errDatail = "0005";
    } finally {
    	
    	StringBuffer strMsg = new StringBuffer(64);
    	strMsg.append("parent.error_end('");
    	strMsg.append(errDatail);
    	strMsg.append("');");
    	
        out.println("<script>");
        
        if("00000".equals(ERRCODE)){
            out.println("parent.doSave_end();");
        } else if ("00999".equals(ERRCODE) ) {
        	out.println(strMsg.toString());
            //out.println("parent.error_end('"+ errDatail +"');");
        } else {
        	out.println(strMsg.toString());
            //out.println("parent.error_end('"+ errDatail +"');");
        }
        out.println("</script>");
    }
    
%>