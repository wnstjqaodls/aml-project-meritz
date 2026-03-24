<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : searchUserPopup.jsp
- Author     : kbj
- Comment    : 사용자검색
- Version    : 1.0
- history    : 1.0 2015-07-15
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %> 
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 

<script language="JavaScript">
	var GridObj ;
	var classID = "AML_80_10_01_01";
	
	/* Initial function */
	function init() {
		initPage();
	}
	
	function doClose(){
		window.close();	
	}

	/**
	 * Search userList
	 */
	function doSearch(){
		if(jQuery("#searchValue").val()=='') {
			alert('사용자를 입력하세요.');
			return;
		}
	    var param = new Object();
		param.SEARCH_VALUE = jQuery("#searchValue").val();
		goAjaxWidthReturn("com.gtone.rba.common.action.GetKRBAUserInfoList", param, "onAfterDoSearch");
	}
	
	function onAfterDoSearch(jsonObj, paramdata){
		var cnt = jsonObj.RESULT.length;
		var html = "";
		var name = '';
		for(var i=0; i<cnt; i++){
			name = jsonObj.RESULT[i].DEP_ID_NM + ' | '+ jsonObj.RESULT[i].USER_NM ;
			html += "<option value='" + jsonObj.RESULT[i].USER_ID + "' loginId = '" + jsonObj.RESULT[i].LOGIN_ID + "' userName = '" + jsonObj.RESULT[i].USER_NM + "'>" + name + "</option>";
		}
		jQuery("#userInfoList").html(html);
	}
	
	function setUserInfo(obj){
		var searchName; searchName = "<c:out value='${param.searchName}'/>";
		var searchInfo = new Object();
		searchInfo.searchValue = jQuery(obj).children("option:selected").attr("loginId");
		searchInfo.text1Value  = jQuery(obj).children("option:selected").val();
		searchInfo.text2Value  = jQuery(obj).children("option:selected").attr("userName");
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
<!--
<table width="100%" border="0" >
	<tr>
		<td valign="top" style="padding:0 1 0 0;">
			<table width="100%" border="0"  style="margin-bottom:5px;">
				<tr>
					<td width="7" height="7" background="${path}/Package/ext/images/co_bg01.gif"></td>
					<td background="${path}/Package/ext/images/co_bg02.gif"></td>
					<td width="7" background="${path}/Package/ext/images/co_bg03.gif"></td>
				</tr>
				<tr>
					<td valign="bottom" background="${path}/Package/ext/images/co_bg09.gif"><img src="${path}/Package/ext/images/co_bg10.gif"></td>
					<td align="center" valign="middle" class="com_bg01">
						<table width="100%" border="0" >
							<tr>
								<td>
									<table border="0" >
										<tr>
											<td><img src="${path}/Package/ext/images/icon/icon02.gif" hspace="4"></td>
											<td class="sear_h">사용자</td>
											<td class="sear_b"><input name="searchValue" id="searchValue" type="text" value="" class="input_text01" onKeyDown="javascript:if(event.keyCode == 13) {doSearch(); return false;}" size="20"/></td>
										</tr>
									</table>
								</td>
							    <td align="right">
									<table border="0"  class="btn_area">
										<tr>
											<td>
												<AMLTag:buttonAuth pageID="${param.pageID}" id="btn_search" titleId="queryBtn" name="조회" mode="R" function="doSearch();" dataObj="${outputAuth}"/>											 
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<td valign="bottom" background="${path}/Package/ext/images/co_bg04.gif"><img src="${path}/Package/ext/images/co_bg05.gif"></td>
				</tr>
				<tr>
					<td height="7" background="${path}/Package/ext/images/co_bg08.gif"></td>
					<td background="${path}/Package/ext/images/co_bg07.gif"></td>
					<td background="${path}/Package/ext/images/co_bg06.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td valign="top" style="padding:0 1 0 0;">
			<table width="100%"	border="0"  style="margin-bottom:10px;">
				<tr>
					<td	width="7" height="7" background="${path}/Package/ext/images/co_bg01.gif"></td>
					<td	background="${path}/Package/ext/images/co_bg02.gif"></td>
					<td	width="7" background="${path}/Package/ext/images/co_bg03.gif"></td>
				</tr>
				<tr>
					<td	valign="bottom"	background="${path}/Package/ext/images/co_bg09.gif"><img src="${path}/Package/ext/images/co_bg10.gif"></td>
					<td	align="center" valign="top"	class="com_bg01">
						<table width="100%" border="0" >
							<tr>
								<td height="30">
									<table border="0"  class="btn_area">
										<tr>
											<td class="btn3"><span>사용자 목록</span></td>
										</tr>
									</table>
								</td>
								<td align="right">
								</td>
							</tr>
							<tr>
								<td height="250" valign="top" class="base_box" colspan="2" id="GTDataGrid_Area">
									<table border="0"  class="tbl_info" style="width: 100%;">
										<tr>
											<td class="tbl_Top" style="width: 30%;">조회선택</td>
											<td class="tbl_info_w">
												<select name='userInfoList' id='userInfoList'  multiple  ondblClick='javascript:setUserInfo(this);' style='width:100%;height:269px;color:#494949;text-align:center;border:solid;border-collapse:collapse;'>
												</select>
											</td>
										</tr>			
									</table>
								</td>											
							</tr>
						</table>
					</td>
					<td	valign="bottom"	background="${path}/Package/ext/images/co_bg04.gif"><img src="${path}/Package/ext/images/co_bg05.gif"></td>
				</tr>
				<tr>
					<td	height="7" background="${path}/Package/ext/images/co_bg08.gif"></td>
					<td	background="${path}/Package/ext/images/co_bg07.gif"></td>
					<td	background="${path}/Package/ext/images/co_bg06.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" align="right" cellpadding="2"  class="btn_area">
	<tr>
		<td>
			<table border="0" align="right" >
				<tr>
					<td><AMLTag:buttonAuth pageID="${param.pageID}" id="btn_close" titleId="closeBtn" name="닫기" mode="R" function="doClose()" dataObj="${outputAuth}"/></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
-->
	<div class="cond-box" id='condBox1'>
		<div class="cond-row">
			<div class="cond-item">
			<span><i class="fa fa-chevron-circle-right" ></i>&nbsp;사용자&nbsp;</span>
				<input name="searchValue" id="searchValue" type="text" value="" class="cond-input-text" onKeyDown="javascript:if(event.keyCode == 13) {doSearch(); return false;}" size="20"/>
			</div>
			<div style="display: inline-block; float:right; margin-top : 5px;">
                ${btnel.getButton(outputAuth, '{btnID:"btn_search", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')}
            </div>
		</div>
	</div>
	<div class="panel panel-primary">
		<div class="table-box" >
			<table width="100%" class="hover">
				<tr>
					<th style="vertical-align:middle;width:25%">조회선택</th>
					<td>
						<select name='userInfoList' id='userInfoList' multiple  ondblClick='javascript:setUserInfo(this);' class='cond-select' style='width:100%; height:305px;text-align:left;'></select>
					</td>
				</tr>
			</table>
		</div>
		<div align="right" style="margin-top: 5px">
			<span align="right">
				${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
			</span>
		<div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 