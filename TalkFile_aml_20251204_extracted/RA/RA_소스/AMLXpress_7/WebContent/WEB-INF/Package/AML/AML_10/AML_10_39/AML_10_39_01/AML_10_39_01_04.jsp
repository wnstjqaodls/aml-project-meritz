<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 변경이력
* Group           : GTONE, R&D센터/개발2본부
* Project         : 변경이력
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

	String CS_TYP_CD   = Util.nvl(request.getParameter("CS_TYP_CD"     ));
	request.setAttribute("CS_TYP_CD",  CS_TYP_CD     );
	String NEW_OLD_GBN_CD   = Util.nvl(request.getParameter("NEW_OLD_GBN_CD"     ));
	request.setAttribute("NEW_OLD_GBN_CD",  NEW_OLD_GBN_CD     );

%>
<script>
	var overlay        = new Overlay();
	var pageID         = "AML_10_39_01_04";
	var classID        = "AML_10_39_01_02";
	var CS_TYP_CD      = "${CS_TYP_CD}";
	var NEW_OLD_GBN_CD = "${NEW_OLD_GBN_CD}";

	$(document).ready(function(){
	    setupGrids1();
	    setupGrids2();
	    doSearch();
	});

	function doSearch() {
		var methodID          = "doApprHist";
        var params            = new Object();
        params.pageID         = pageID;
        params.CS_TYP_CD      = CS_TYP_CD;
        params.NEW_OLD_GBN_CD = NEW_OLD_GBN_CD;

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}

	function doSearch_success(gridData, data){
		if(gridData.length>0){
	        var obj = gridData[0];
	        form1.WGHT_SEQ.value    = obj.SEQ;
    	}
		
		try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	     	doSearch2();
   	    }
    }

    function doSearch_fail(){ overlay.hide(); }

    function doSearch2(obj) {
		var methodID    = "doApprHist2";
        var params      = new Object();
        var WGHT_SEQ    = form1.WGHT_SEQ.value;
        params.pageID   = pageID;
		params.WGHT_SEQ = WGHT_SEQ;

        sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
	}

    function doSearch2_success(gridData, data){
		try {
        	GridObj2.refresh();
        	GridObj2.option("dataSource",gridData);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }

	// 변경 이력
    function setupGrids1(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(40vh - 65px)",
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
	     		  	{dataField: "SEQ"		    ,caption: "변경시퀀스"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "HNDL_REG_ID"	,caption: "변경자(최초결재자)"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	      	{dataField: "HNDL_P_NM"		,caption: "변경자(최초결재자)"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true },
	      	    	{dataField: "HNDL_DY_TM"	,caption: "변경일시(결재완료일시)"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true },
	      	    	{dataField: "RSN_CNTNT"		,caption: "변경 사유(최초 결재 의견)"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true },
	      	    	{dataField: "SN_CCD"		,caption: "결재상태코드"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "SN_CCD_NM"		,caption: "결재상태"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true }
	      	    ]
	     	   ,onCellClick: function(e){
	     		   if(e.rowType != "header" && e.rowType != "filter"){
	     			  Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
	     		   }

                }
	  	}).dxDataGrid("instance");
    }
	
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){
    	clickedRowIndex = rowIdx;
    	if(obj && obj.SEQ){
			form1.WGHT_SEQ.value = obj.SEQ;
			doSearch2();

       }
    }
 	// 그리드 초기화 함수 셋업
    function setupGrids2(){
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(40vh - 65px)",
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
	     		  	{dataField: "WGHT_SEQ"		    	,caption: "WGHT_SEQ"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "CS_TYP_CD"				,caption: "CS_TYP_CD"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "NEW_OLD_GBN_CD"		,caption: "NEW_OLD_GBN_CD"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "RA_ITEM_CD"			,caption: "RA_ITEM_CD"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "RA_RISK_CATG"			,caption: "위험분류"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	        {dataField: "RA_ITEM_A_WGHT"		,caption: "변경전 가중치(A)"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_RISK_VAL_ITEM"		,caption: "평가항목"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_ITEM_B_WGHT"		,caption: "변경전 가중치(B)"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_ITEM_A_B_WGHT"		,caption: "변경전 최종가중치(AxB)"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_RA_ITEM_A_WGHT"	,caption: "변경후 가중치(A)"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_RA_ITEM_B_WGHT"	,caption: "변경후 가중치(B)"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_RA_ITEM_A_B_WGHT"	,caption: "변경후 최종가중치(AxB)"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_SQ"					,caption: "변경후 구간값"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false}
	      	    	
	      	    ]
	  	}).dxDataGrid("instance");
    }
</script>

<form name=form1 method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	<input type="hidden" name="WGHT_SEQ" >

<div class="tab-content">
		<div class="row" style="padding-top: 8px">
			<h4 class="tab-content-title">변경 이력</h4>
		</div>
		<div class="panel-footer">
			<div id="GTDataGrid1_Area"></div>
		</div>

		<div class="row" style="padding-top: 8px">
			<h4 class="tab-content-title">변경 사항 명세</h4>
		</div>

		<div class="panel-footer">
			<div id="GTDataGrid2_Area"></div>
		</div>

		<br>
	<div class="button-area" style="float:right; margin-bottom:30px;" >
    	${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
	</div>

</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />