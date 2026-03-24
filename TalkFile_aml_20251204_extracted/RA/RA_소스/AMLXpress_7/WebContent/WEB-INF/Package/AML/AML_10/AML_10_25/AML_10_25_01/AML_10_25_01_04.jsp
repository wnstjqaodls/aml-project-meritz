<%@page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 신상품 체크리스트 결재 
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 
* Since           : 2025.06
--%>

<%@ page import="java.util.*" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %> 
<%
	String rsncntnt = Util.nvl( request.getParameter("RSN_CNTNT") );
	request.setAttribute("rsncntnt", rsncntnt);
	
	//세션 결재자 정보
	String ROLEID = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLEID", ROLEID);
%>

<script language="JavaScript">
	var ROLEID   = "${ROLEID}"; 
	var rsncntnt = "${rsncntnt}";
	
	$(document).ready(function(){

		form1.COM_CNTNT.value = rsncntnt;
		
		if(ROLEID == '4') {
			$(".condcond").hide();
			$(".condcond2").hide();
		}else if(ROLEID == '104'){
			$(".condcond").show();
			$(".condcond2").show();
		}
	});
	
	function doSave(){  
	   var inputText = $("#RSN_CNTNT").val();
  	   var minLen = inputText.replace(/\s/g , "").length;
	   
  	   //if(ROLEID == '4') {
  		 	if(minLen < 10){
  				showAlert( "${msgel.getMsg('AML_10_25_02_01_015', '결재의견은 최소 10자(공백 제거) 이상 입력해야 합니다.')}", "WARN");
 	     		return;
 	    	}
  	   //}
  	 	
	   parent.window.opener.focus();		
	   parent.window.opener.openerView.doAppr( $("#RSN_CNTNT").val(), "S" );
	   window.close();
    }
	 
	function doClose(){
		window.close();
	}
	
	// 팝업창을 우측상단에 X로 닫았을때 실행되는 펑션 20170324 KEOL 
	function closePage( event ){
	    if( event.clientY < 0 ){
	    	doClose();
	    }
	}
	
	   // F5새로고침, 뒤로가기 막기
	   document.onkeydown = function(e) 
	   {
	    key = (e) ? e.keyCode : event.keyCode;
	    ctrl = (e) ? e.ctrlKey  : event.ctrlKey;
// 	     if( (ctrl == true && (key == 78 || key == 82)) || key==8 || key==116) 
	     if( (ctrl == true && (key == 78 || key == 82)) || key==116) // key==8은 백스페이스도 막는다
	     {
	       if(e) 
	       {
	         e.preventDefault();
	       } 
	       else 
	       {
	              event.keyCode = 0;
	              event.returnValue = false;
	       }
	     }
	   }
	   
	   // 마우스 우클릭금지
	   document.oncontextmenu = function (e) {
	      return false;
	   }
</script>

<body onunload="closePage(event)">

<form name="form1" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">

	<div class="popup-cont-box">
	    <div class="cond-box" id="condBox1" style="margin-top:0px;margin-bottom:0px">
	        
	        <div class="condcond">
	        <div class="cond-row">
	        	<div style="font-size:15px;">담당자 의견</div>
	        	<textarea name="COM_CNTNT" id="COM_CNTNT" rows='4' class="textarea-box"  style='width:100%; margin-top: 8px;' readonly></textarea>
	        </div>
	        </div>
	        
	        <div class="cond-row">
	        <div class="condcond2"><div style="font-size:15px; margin-top: 8px;">결재의견</div></div>
            	<textarea name='RSN_CNTNT' id='RSN_CNTNT' rows='5' class='textarea-box' style='width:100%; margin-top: 8px;'></textarea>  
	        </div>		    
		</div>
	 	<div class="button-area"  style="float:right;text-align:right;">
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36 filled"}')}
		    ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
		</div>
	</div>

</form>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 
