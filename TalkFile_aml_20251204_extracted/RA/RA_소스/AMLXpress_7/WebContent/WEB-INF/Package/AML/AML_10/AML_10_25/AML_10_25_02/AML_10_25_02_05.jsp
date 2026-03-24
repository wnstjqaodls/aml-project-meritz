<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 신상품 위험평가 반려
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 
* Since           : 2025.06
--%>

<%@ page import="java.util.*" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %> 

<script language="JavaScript">

	function doSave(){  
		
	   parent.window.opener.focus();		
	   parent.window.opener.openerView.doAppr( $("#RSN_CNTNT").val(), "R" );
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
	        <div class="cond-row">  	               
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
