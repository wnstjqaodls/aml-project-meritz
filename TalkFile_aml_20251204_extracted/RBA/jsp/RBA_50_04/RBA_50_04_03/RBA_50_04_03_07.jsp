<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 일괄결재실행
* Group           : GTONE, R&D센터/개발2본부
* Project         : 결재실행
* Author          : JJH
* Since           : 2025. 06. 25.
********************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<%
	String stDate = jspeed.base.util.DateHelper.currentTime(PropertyService.getInstance().getProperty("aml.config","dateFormat"));
	request.setAttribute("stDate",stDate);

 	String ROLE_ID2            = Util.nvl(request.getParameter("ROLE_ID"));
	String GYLJ_ID             = Util.nvl(request.getParameter("GYLJ_ID"));        // 결재ID
	String TABLE_NM            = Util.nvl(request.getParameter("TABLE_NM"));        // 
	
	String GYLJ_ROLE_ID        = Util.nvl(request.getParameter("GYLJ_ROLE_ID"));
	String GYLJ_S_C            = Util.nvl(request.getParameter("GYLJ_S_C"));
	String NEXT_GYLJ_ROLE_ID   = Util.nvl(request.getParameter("NEXT_GYLJ_ROLE_ID"));
	String FIRST_GYLJ          = Util.nvl(request.getParameter("FIRST_GYLJ"));
	String END_GYLJ            = Util.nvl(request.getParameter("END_GYLJ"));
	String FLAG                = Util.nvl(request.getParameter("FLAG"));
	String BRNO                = Util.nvl(request.getParameter("BRNO"));
	String LV3                 = Util.nvl(request.getParameter("LV3"));
	String ADD_CD              = Util.nvl(request.getParameter("ADD_CD"));
	
	request.setAttribute("GYLJ_ID"          , GYLJ_ID    );
	request.setAttribute("TABLE_NM"         , TABLE_NM   );
	request.setAttribute("GYLJ_ROLE_ID"     , GYLJ_ROLE_ID  );
	request.setAttribute("GYLJ_S_C"         , GYLJ_S_C      );
	request.setAttribute("NEXT_GYLJ_ROLE_ID", NEXT_GYLJ_ROLE_ID   );
	request.setAttribute("FIRST_GYLJ"       , FIRST_GYLJ );
	request.setAttribute("END_GYLJ"         , END_GYLJ );
	request.setAttribute("FLAG"             , FLAG );
	request.setAttribute("ROLE_ID2"         , ROLE_ID2 );
	request.setAttribute("BRNO"             , BRNO );
	request.setAttribute("LV3"             , LV3 );
	request.setAttribute("ADD_CD"          , ADD_CD );
	
	

    String USERNAME   = sessionAML.getsAML_USER_NAME();
    String BDPTCDNAME = sessionAML.getsAML_BDPT_CD_NAME();
    String BDPTCD     = sessionAML.getsAML_BDPT_CD();
    String ROLEID     = sessionAML.getsAML_ROLE_ID();
    String ROLENAME   = sessionAML.getsAML_ROLE_NAME();
   //String POSITION_NAME = Util.nvl(request.getParameter("POSITION_NAME"));

    request.setAttribute("USERNAME",USERNAME);
    request.setAttribute("BDPTCDNAME",BDPTCDNAME);
    request.setAttribute("BDPTCD",BDPTCD);
    request.setAttribute("ROLEID",ROLEID);
    request.setAttribute("ROLENAME",ROLENAME);
    //request.setAttribute("POSITION_NAME",POSITION_NAME);


%>
<script>
	var overlay       = new Overlay();
	var pageID        = "RBA_50_04_03_07";
	var classID       = "RBA_50_03_02_02";
	var USERNAME      = "${USERNAME}";
    var BDPTCDNAME    = "${BDPTCDNAME}";
    var BDPTCD        = "${BDPTCD}";
    var ROLEID        = "${ROLEID}";
    var ROLENAME      = "${ROLENAME}";
    var stDate        = "${stDate}";
    //var POSITION_NAME = "${POSITION_NAME}";
    
    
    var GYLJ_ID       = "${GYLJ_ID}";
    var BAS_YYMM      = "${BAS_YYMM}";
    var TABLE_NM      = "${TABLE_NM}";
    var FLAG          = "${FLAG}";
    var ROLE_ID2      = "${ROLE_ID2}";
    
    
    var GYLJ_ROLE_ID        = "${GYLJ_ROLE_ID}";
    var GYLJ_S_C            = "${GYLJ_S_C}";
    var NEXT_GYLJ_ROLE_ID   = "${NEXT_GYLJ_ROLE_ID}";
    var FIRST_GYLJ          = "${FIRST_GYLJ}";
    var END_GYLJ            = "${END_GYLJ}";
    var BRNO                = "${BRNO}";
    var LV3                 = "${LV3}";
    var ADD_CD              = "${ADD_CD}";
	
    
	$(document).ready(function(){
	    form1.USERNAME.value      = USERNAME;
	    form1.BDPTCDNAME.value    = BDPTCDNAME;
	    form1.stDate.value        = stDate;
	    //form1.POSITION_NAME.value = POSITION_NAME;
	    
	    //alert( "FLAG : " + FLAG );
	    
        if( FLAG == "1" ) {
        	$("#btn_07").hide();
	    	$("#btn_03").hide();
	    } else if( FLAG == "2" ) {
	    	$("#btn_07").hide();
	     	$("#btn_04").hide();
	    } else if( FLAG == "0" ) {
	    	$("#btn_03").hide();
	     	$("#btn_04").hide();
	    } else if( BRNO == "20500" && ROLE_ID2 == "4" ) {
	     	$("#btn_04").hide();
	    }
        
        doSearch2();
	    
	});
	
	
	
	function doSearch2() {
		var methodID = "doSearch2";
        var params = new Object();
        params.pageID      = pageID;

        sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
	}
    
    
    function doSearch2_success(dataSource){
    	try {
    		var cnt = dataSource.length;
        	
        	if( cnt > 0 ) {
        		form1.POSITION_NAME.value		=	dataSource[0].POSITION_NAME;
        	}
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }

    function doSearch2_fail(){
        overlay.hide();
    }

	

    
  //결재요청
    function doApproval_end() {
    	$("#btn_03").hide();
    	$("#btn_04").hide();
    	$("#btn_07").hide();
    	doSearch();

    	opener.doSearch();
    	
    }
    
    function doApproval_fail() {
    }
	
	function doApproval(FLAG) {

		if ($("#RSN_CNTNT").val() == "") {
            showAlert("${msgel.getMsg('AML_10_01_01_01_040','결재의견을 입력하세요.')}",'WARN');
            return;
        }
		
		var mesg = '${msgel.getMsg("AML_10_17_01_01_015","결재 하시겠습니까?")}';
        var mesg2 ='${msgel.getMsg("AML_10_17_01_01_017","결재")}';
		
        //결재 FLAG (0:결재요청, 1:반려, 2:승인)
		if( FLAG == "0") {
			mesg = "결재요청 하시겠습니까?";
	        mesg2 ="결재요청";
		} else if( FLAG == "1") {
			mesg = "반려 하시겠습니까?";
	        mesg2 ="반려";
		} 

        showConfirm(mesg,mesg2,function(){
            //overlay.show(true, true);
        	var params = new Object();
            var methodID 	= "doApproval";
    		var classID  = "RBA_50_03_02_01";
           
    		params.pageID 	  = "RBA_50_04_03_05";
    		params.BAS_YYMM   = BAS_YYMM ;//기준연도
    		params.TABLE_NM   = TABLE_NM;
    		
    		
    		if( BRNO == "20500" ) {
    			params.GYLJ_G_C   = "RBA01";  //결재구분코드
    			if( ROLE_ID2 == "4" ) {
    				params.GYLJ_FLAG  = "0"; // 결재FLAG (0:승인요청,1:반려,2:승인)
    			} else {
    				params.GYLJ_FLAG  = FLAG; // 결재FLAG (0:승인요청,1:반려,2:승인)
    			}
    				
    		} else {
    			params.GYLJ_G_C   = "RBA02";  //결재구분코드
    			params.GYLJ_FLAG  = FLAG; // 결재FLAG (0:승인요청,1:반려,2:승인)
    		}
    		
    		self.close();
            opener.doApproval2( $("#RSN_CNTNT").val() );
    		
/*     		params.GYLJ_S_C   = GYLJ_S_C;  //결재상태코드
    		params.GYLJ_ID    = GYLJ_ID; //결재ID
    		
    		params.ROLE_IDS   = ROLE_ID2;
    		params.NOTE_CTNT  = $("#RSN_CNTNT").val();
    		
    		params.BRNO  = BRNO == "" ? " " : BRNO; //
    		params.LV3   = LV3 	== "" ? " " : LV3; //
    		params.ADD_CD  = ADD_CD	== "" ? " " : ADD_CD;  //
    			
    		sendService(classID, methodID, params, doApproval_end, doApproval_fail); */
        });
	}
	
	function doClose() {
		self.close();
        opener.doClose();
	}
</script>

<form name=form1 method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
    <input type="hidden" name="APP_NO" value="${APP_NO}">
    <input type="hidden" name="NOW_SN_CCD" value="${SN_CCD}">

<div class="tab-content">
	<div class="row" style="padding-top: 8px">
		<h4 class="tab-content-title">결재 실행</h4>
	</div>

    	<table class="basic-table">
        	<tr>
            	<th class="title" style="text-align: center">결재자</th>
            	<td> <input type=text  name="USERNAME" id="USERNAME" style="text-align: center" readonly></td>
            	<th class="title" style="text-align: center">소속부점</th>
            	<td> <input type=text  name="BDPTCDNAME" id="BDPTCDNAME" style="text-align: center" readonly></td>
        	</tr>
        	<tr>
        		<th class="title" style="text-align: center">직위</th>
            	<td> <input type=text  name="POSITION_NAME" id="POSITION_NAME" style="text-align: center" readonly></td>
            	<th class="title" style="text-align: center">결재일자</th>
            	<td> <input type=text  name="stDate" id="stDate" style="text-align: center" readonly></td>
        	</tr>
        	<tr>
        		<th class="title" style="text-align: center">결재의견</th>
            	<td colspan="3"><textarea class="textarea-box" name="RSN_CNTNT" id="RSN_CNTNT" style="width:100%;height:150px"></textarea></td>
        	</tr>
    	</table>
</div>
<br>
<div class="button-area" style="float:right">

    <% if ( "105".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
       	${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
    <% } %>
	<% if ( "4".equals(ROLEID) || "104".equals(ROLEID) || "6".equals(ROLEID) ) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
       	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"okBtn", defaultValue:"결재", mode:"U", function:"doApproval(2)", cssClass:"btn-36"}')}
       	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"refuseBtn", defaultValue:"반려", mode:"U", function:"doApproval(1)", cssClass:"btn-36"}')}
    <% } %>
    <% if ( "7".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
        ${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
       	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"okBtn", defaultValue:"결재", mode:"U", function:"doApproval(2)", cssClass:"btn-36"}')}
       	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"refuseBtn", defaultValue:"반려", mode:"U", function:"doApproval(1)", cssClass:"btn-36"}')}
    <% } %>
		        
		        
    ${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />