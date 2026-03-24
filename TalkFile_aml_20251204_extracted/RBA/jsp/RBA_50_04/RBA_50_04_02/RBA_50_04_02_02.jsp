<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_04_02_02.jsp
* Description     : 통제평가 배점 관리 파일 업로드
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-02
--%>
<%@ page import="com.gtone.aml.basic.common.data.DataObj" %>
<%@ page import="com.gtone.aml.basic.common.util.*" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>

<%
String BAS_YYMM  = Util.nvl(request.getParameter("BAS_YYMM"));
request.setAttribute("BAS_YYMM", BAS_YYMM);
%>
<script language="JavaScript">
    
    var GridObj1 = null;
    var classID  = "RBA_50_03_03_01";
    
    // Initialize
    $(document).ready(function(){
        setupGrids();
    });
    
    // Initial function
    function init() { initPage(); }

    // 그리드 초기화 함수 셋업
    function setupGrids() {

    }
    
    // file save
    function doSave() {
        if(form.EXCEL_UPLOAD_FILE.value == ""){
        	alert("${msgel.getMsg('AML_90_01_03_06_001','첨부된 파일이 없습니다.')}");
            return;
        }
        if(!confirm("${msgel.getMsg('doSave','저장하시겠습니까?')}")) {
            return;
        }
    
        form.pageID.value   = 'RBA_50_04_02_03';
        form.BAS_YYMM.value = "${BAS_YYMM}";
        form.methodID.value = 'doSave';
        form.target         = "submitFrame";
        form.action         = "<c:url value='/'/>0001.do";
        form.encoding       = "multipart/form-data";
        form.submit();
    
    }
    
    // file save end
    function doSave_end() {
    	alert("${msgel.getMsg('AML_90_01_03_05_001','정상처리되었습니다')}");
        opener.doSearch();
        window.close();
    }
    
    // file error end
    function error_end(errMsgCode) {
        if(errMsgCode == "0053"){
        	alert("${msgel.getMsg('RBA_30_04_03_11_026','첨부된 파일정보를 확인하십시요.')}");
        }else if(errMsgCode == "0054"){
        	alert("${msgel.getMsg('RBA_30_04_03_11_027','업로드 할 수 없는 타입의 파일입니다.')}");
        }else{
        	alert("${msgel.getMsg('RBA_30_04_03_11_028','처리중 오류가 발생하였습니다.')}");
        }
        opener.doSearch();
        window.close();
    }
    
    // 창닫기
    function doClose() {
        //opener.doSearch();
        self.close();
    }
    
    // 파일 실제 경로
    function getRealPath(obj) {
        obj.select();
        form.REAL_PATH.value = document.selection.createRangeCollection()[0].text.toString();
    }
    
</script>

<form name="form" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="BAS_YYMM">
    <div class="cond-box" id="condBox1">
        <div class="cond-row">
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;파&nbsp;&nbsp;일&nbsp;</span>
                <span style="vertical-align:middle"><input type="file" name="EXCEL_UPLOAD_FILE" id="EXCEL_UPLOAD_FILE" onchange="javascript:getRealPath(this);" style='width: "100%";' /></span>
                <input type="hidden" id="REAL_PATH" name="REAL_PATH" value="" />
            </div>
        </div>
        <div class="cond-line"></div>
        <div class="cond-btn-row" style="text-align:right">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
        </div>
    </div>
    <div class="panel panel-primary">
        <div align="left">
            <font color="blue">
                ※ 업로드 기능은 등록된 통제항목 정보를 변경시 활용합니다.<br>&nbsp;&nbsp;&nbsp;&nbsp;(추가는 안됨)
            </font>
        </div>
    </div>
</form>
<!------------------------------------------------------------------------------>
<iframe id='submitFrame' name="submitFrame" height='0' width='0'></iframe>
<!------------------------------------------------------------------------------>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />