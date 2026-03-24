<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 부서 검색
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : kbj
* Since           : 2015. 07. 15.
********************************************************************************************************************************************
* Modifier        : 송지윤
* Update          : 2017. 11. 28.
* Alteration      : 1. 코드 정리
*                   2. HTML5, devextreme, Any Browser 적용
********************************************************************************************************************************************
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %> 
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 

<script language="JavaScript">


	$(document).ready( function() {
		$("title[id=pageTitle]").text('부서검색');
		$("span[id=pageTitle]").text('부서검색');
		$('#condBox1').find('span .cond-label').text('교육주관부서');
	});
	
	function doClose(){
		window.close();
	}

	/**
	 * Search depList
	 */
	function doSearch(){
		if(!$("#searchValue").val()) {
			alert('부서명을 입력하세요.');
			return;
		}
		
		var param = new Object();
		param.SEARCH_VALUE = $("#searchValue").val();
		goAjaxWidthReturn("com.gtone.rba.common.action.GetKRBADepInfoListByNm", param, "onAfterDoSearch");
	}
	
	function onAfterDoSearch(jsonObj, paramdata){
		var cnt = jsonObj.RESULT.length;
		var html = "";
		var name = "";
		for(var i=0; i<cnt; i++){
			name = jsonObj.RESULT[i].DPRT_CD+' | '+jsonObj.RESULT[i].DPRT_NM;
			html += "<option value='" + jsonObj.RESULT[i].DPRT_CD + "' depTitle = '" + jsonObj.RESULT[i].DPRT_NM + "'>" + name + "</option>";
		}
		
		$("#depInfoList").html(html);
	}
	
	function setDepInfo(obj){
		var searchName; searchName = "<c:out value='${param.searchName}'/>";
		var searchInfo = new Object();
		searchInfo.searchValue=jQuery(obj).children("option:selected").val();
		searchInfo.text1Value=jQuery(obj).children("option:selected").val();
		searchInfo.text2Value=jQuery(obj).children("option:selected").attr("depTitle");
		eval("<c:out value='opener.${param.afterFunction}'/>")
		doClose();
	}
</script>
<form name="form" method="post">
	<input type="hidden" id="flag" name="flag">
	<input type="hidden" id="pageID" name="pageID">
	<input type="hidden" id="classID" name="classID">
	<input type="hidden" id="methodID" name="methodID">
	<input type="hidden" id="afterFunction" name="afterFunction">
	<input type="hidden" id="afterClose" name="afterClose">
	
<div class="popup-cont-box" style="width:calc(100vw - 30px);">
    <div class="cond-box" id="condBox1">
        <div class="cond-row">
            <div class="cond-item">
                ${condel.getLabel('AML_00_03_01_01_004','부서명')}
                <input name="searchValue" id="searchValue" type="text" value="" class="input_text01" onKeyDown="javascript:if(event.keyCode == 13) {doSearch(); return false;}" size="20"/>
            </div>
            <div style="display: inline-block; float:right; margin-top : 5px;">
                ${btnel.getButton(outputAuth, '{btnID:"btn_search", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-search"}')}
            </div>
        </div>
    </div>
    <div class="table-title" style="padding-left:20px">
        ${msgel.getMsg('RBA_10_01_01_177','부서 목록')}
    </div>
    <div class="table-box">
        <table class="hover">
            <tr>
                <th style="vertical-align:middle">조회선택</th>
                <td>
                    <select name='depInfoList' id='depInfoList'  multiple  ondblClick='javascript:setDepInfo(this);' class="cond-select" style='width:100%; height:269px;'></select>
                </td>
            </tr>
        </table>
    </div>
    <div class="cond-btn-row" style="text-align:right;margin-top:10px;">
        ${btnel.getButton(outputAuth, '{btnID:"btn_close", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-power-off"}')}<!--PHH 2009.03.01-->
    </div>
</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 
