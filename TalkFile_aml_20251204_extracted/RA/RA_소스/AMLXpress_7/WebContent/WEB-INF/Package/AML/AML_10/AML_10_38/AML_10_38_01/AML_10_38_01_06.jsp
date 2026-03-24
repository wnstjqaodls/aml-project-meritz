<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 결재이력
* Group           : GTONE, R&D센터/개발2본부
* Project         : 결재이력
* Author          : JJH
* Since           : 2025. 06. 25.
********************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<%
	String CS_TYP_CD   = Util.nvl(request.getParameter("CS_TYP_CD"     ));
	request.setAttribute("CS_TYP_CD",  CS_TYP_CD     );
	String NEW_OLD_GBN_CD   = Util.nvl(request.getParameter("NEW_OLD_GBN_CD"     ));
	request.setAttribute("NEW_OLD_GBN_CD",  NEW_OLD_GBN_CD     );

%>
<script>
	var overlay        = new Overlay();
	var pageID         = "AML_10_38_01_06";
	var classID        = "AML_10_38_01_02";
	var CS_TYP_CD      = "${CS_TYP_CD}";
	var NEW_OLD_GBN_CD = "${NEW_OLD_GBN_CD}";

	$(document).ready(function(){
	    setupGrids1();
	    doSearch();
	});

	function doSearch() {
		var methodID = "doApprHist3";
        var params        = new Object();
        params.pageID     = pageID;
        params.CS_TYP_CD = CS_TYP_CD;
        params.NEW_OLD_GBN_CD = NEW_OLD_GBN_CD;

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}

	function doSearch_success(gridData, data){
    	try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }

    function doSearch_fail(){
        overlay.hide();
    }


	// 그리드 초기화 함수 셋업
    function setupGrids1(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(100vh - 150px)",
			 hoverStateEnabled      : true
	     	   ,wordWrapEnabled        : false
	     	   ,allowColumnResizing     : true
	     	   ,columnAutoWidth        : true
	     	   ,allowColumnReordering : true
	     	   ,columnResizingMode    : "widget"
	     	   ,cacheEnabled             : false
	     	   ,cellHintEnabled           : true
	     	   ,showBorders              : true
	     	   ,showColumnLines        : true
	     	   ,showRowLines            : true
	     	   ,loadPanel                  : { enabled: false }
    		   ,editing: {mode : "batch", allowUpdating: false, allowAdding  : false, allowDeleting: false }
        	   ,export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
	     	   ,onExporting: function (e) {
					var workbook = new ExcelJS.Workbook();
					var worksheet = workbook.addWorksheet("Sheet1");
				    DevExpress.excelExporter.exportDataGrid({
				        component: e.component,
				        worksheet : worksheet,
				        autoFilterEnabled: true,
				    }).then(function() {
				        workbook.xlsx.writeBuffer().then(function(buffer) {
				            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "ra_item.xlsx");
				        });
				    });
				    e.cancel = true;
	            }
	     	   ,filterRow: { visible: false }
	     	   ,hoverStateEnabled: true
	     	   ,loadPanel: { enabled: false }
	     	   ,pager: {
		   	    	visible: false
		   	    	,showNavigationButtons: true
		   	    	,showInfo: true
		   	    }
		   	   ,paging: {
		   	    	enabled : true
		   	    	,pageSize : 20
		   	    }
	     	   ,remoteOperations : {filtering: false,grouping: false,paging: false,sorting: true,summary: false}
	     	   ,rowAlternationEnabled : true
	     	   ,scrolling : {mode: "standard",preloadEnabled: false}
	     	   ,searchPanel : {visible : false,width: 250}
	     	   ,selection: {
	     	        allowSelectAll: true
	     	       ,deferred: false
	     	       ,mode: 'none'  /* none, single, multiple                       */
	     	       ,selectAllMode: 'allPages'      /* 'page' | 'allPages'                          */
	     	       ,showCheckBoxesMode: 'none'    /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
	     	    }
	     	   ,showBorders     : true
	     	   ,showColumnLines : true
	     	   ,showRowLines    : true
	     	   ,sorting         : { mode: "single"}
	     	   ,wordWrapEnabled : false
	     	   ,columns: [
	     	      {dataField: "HNDL_P_ENO"		,caption: "결재자"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	     	      {dataField: "HNDL_P_NM"		,caption: "결재자"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	      {dataField: "BRN_CD"			,caption: "소속부점"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	      {dataField: "BRN_NM"			,caption: "소속부점"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	      {dataField: "POSITION_CODE"	,caption: "직위"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	      {dataField: "POSITION_NAME"	,caption: "직위"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 80},
	      	      {dataField: "HNDL_DY_TM"		,caption: "결재일시"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 150},
	      	      {dataField: "SN_CCD"			,caption: "반려여부"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	      {dataField: "SN_CCD_YN"		,caption: "반려여부"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 80},
	      	      {dataField: "RSN_CNTNT"		,caption: "결재/반려의견"	,alignment: "left"	,allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	      {dataField: "NUM_SQ"			,caption: "NUM_SQ"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false}
	      	    ]
	      	    // events
		       ,"onRowInserting" : function(e) {

	     	    }
	  	}).dxDataGrid("instance");
    }

</script>

<form name=form1 method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >

<div class="tab-content-bottom" style="margin-top:10px;">
	<div class="panel-footer" >
        <div id = "GTDataGrid1_Area"></div>
    </div>
</div>
<br>
<div class="button-area" style="float:right">
    ${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />