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
	function doClose(){
		window.close();
	}

	/**
	 * Search depList
	 */
	function doSearch(){
		if(!$("#searchValue").val()) {
			showAlert('부서명을 입력하세요.','WARN');
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
		eval("opener.<c:out value='${param.afterFunction}'/>");
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
	
	<!-- style="width:calc(100vw - 30px);" -->
<div class="popup-cont-box" >
    <div class="inquiry-table" id="condBox1">
        <div class="table-row">
            <div class="table-cell">
                ${condel.getLabel('RBA_50_08_05_01_004','부서명')}
                <div class="content" style="padding: 6px 5px !important;">
                	<input name="searchValue" id="searchValue" type="text" value="" class="input_text01" onKeyDown="javascript:if(event.keyCode == 13) {doSearch(); return false;}" size="37" style="ime-mode:inactive;" />
            	</div>
            </div>    
        </div>
    </div>
    
    <div class="button-area" style="display: flex; justify-content: flex-end; margin-top: 8px">
    	${btnel.getButton(outputAuth, '{btnID:"btn_search", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
    </div>
	
	<div class="tab-content-bottom" style="margin-bottom: 2px;">
		<h4 class="tab-content-title">${msgel.getMsg('RBA_50_08_05_02_015','부서 목록')}</h4>
	</div>
        <table class="basic-table">
            <tr>
                <th class="title" style="vertical-align:middle; width:25%">${msgel.getMsg('RBA_50_08_05_02_016','조회선택')}</th>
                <td style="padding: 6px 6px !important;">
                    <select name='depInfoList' id='depInfoList'  multiple  ondblClick='javascript:setDepInfo(this);' class="cond-select" style='width:100%; height:269px;'></select>
                </td>
            </tr>
        </table>
    </div>
    <div class="button-area" style="display: flex; justify-content: flex-end; margin-top:8px;">
        ${btnel.getButton(outputAuth, '{btnID:"btn_close", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}<!--PHH 2009.03.01-->
    </div>
</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 
