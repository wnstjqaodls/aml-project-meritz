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

	String RA_ITEM_CD   = Util.nvl(request.getParameter("RA_ITEM_CD"));
	request.setAttribute("RA_ITEM_CD",   RA_ITEM_CD );
	String INTV_VAL_YN   = Util.nvl(request.getParameter("INTV_VAL_YN"));
	request.setAttribute("INTV_VAL_YN",   INTV_VAL_YN );

%>
<script>
	var overlay     = new Overlay();
	var pageID      = "AML_10_37_01_07";
	var classID     = "AML_10_37_01_05";
    var RA_ITEM_CD  = "${RA_ITEM_CD}";
    var INTV_VAL_YN = "${INTV_VAL_YN}";

	$(document).ready(function(){
	    setupGrids1();
	    
	    if(RA_ITEM_CD == "I001") {
	    	setupGrids2();
		}else if(RA_ITEM_CD == "I002") {
			setupGrids3();	
		}else if(RA_ITEM_CD == "I003") {
			setupGrids4();
        }else if(INTV_VAL_YN == "Y" && RA_ITEM_CD !="I001"&& RA_ITEM_CD !="I002"&& RA_ITEM_CD !="I003") {
        	setupGrids5();
        }else {
        	setupGrids6();
		}
	    doSearch();
	});

	function doSearch() {
		var methodID      = "doApprHist";
        var params        = new Object();
        params.pageID     = pageID;
        params.RA_ITEM_CD = RA_ITEM_CD;

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}

	function doSearch_success(gridData, data){
		if(gridData.length>0){
	        var obj = gridData[0];
	        form1.SEQ.value    = obj.SEQ;
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

    function doSearch_fail(){
        overlay.hide();
    }

    function doSearch2(obj) {
		var methodID  = "doApprHist2";
        var SEQ       = form1.SEQ.value;
		var params    = new Object();
        
        
        params.pageID     = pageID;
		params.SEQ        = SEQ;
		params.RA_ITEM_CD = RA_ITEM_CD;

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
			form1.SEQ.value = obj.SEQ;
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
		   	    	visible: true
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
	     		  	{dataField: "RA_ITEM_CD"			,caption: "RA_ITEM_CD"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "RA_ITEM_CODE"			,caption: "상세코드"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	      	{dataField: "RA_ITEM_NM"			,caption: "상세코드 내용"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "ABS_HRSK_YN"			,caption: "당연EDD여부"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_ITEM_SIM_TOTAL"		,caption: ""					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_ITEM_SCR"			,caption: "위험점수"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	
	      	    	{dataField: "RA_ITEM_NTN_CD"		,caption: "국가코드"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	      	
	      	    	{dataField: "FATF_BLACK_LIST_YN"	,caption: "FATF_BLACK_LIST"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "FATF_GREY_LIST_YN"		,caption: "FATF_GREY_LIST"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "FINCEN_LIST_YN"		,caption: "FINCEN제재국가"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "UN_SANTIONS_YN"		,caption: "UN제재국가"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "OFAC_SANTIONS_YN"		,caption: "OFAC제재국가"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "OECD_YN"				,caption: "OECD"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "TICPI_CPI_STA"			,caption: ""					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "TICPI_CPI_IDX"			,caption: ""					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "TICPI_CPI_IDX_SCR"		,caption: "TI"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "INCRS_PROD_STA"		,caption: ""					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "INCRS_PROD_YN"			,caption: "INCRS 마약생산유통국가"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "INCRS_CHEM_STA"		,caption: ""					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "INCRS_CHEM_YN"			,caption: "INCRS 마약밀매수익금거래국가"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "EU_SANTIONS_YN"		,caption: "EU제재국가"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "EU_HRT_YN"				,caption: "EU고위험 제3국"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "BASEL_RIK_STA"			,caption: ""					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "BASEL_RIK_IDX"			,caption: ""					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "BASEL_RIK_IDX_SCR"		,caption: "Basel"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true}
	      	    	
	      	    ]
	  	}).dxDataGrid("instance");
    }
 	
 	// 그리드 초기화 함수 셋업
    function setupGrids3(){
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
		   	    	visible: true
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
	     		  	{dataField: "RA_ITEM_CD"		,caption: "RA_ITEM_CD"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "RA_ITEM_CODE"		,caption: "상세코드"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	      	{dataField: "RA_ITEM_NM"		,caption: "상세코드 내용"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "ABS_HRSK_YN"		,caption: "당연EDD여부"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_ITEM_SCR"		,caption: "위험점수"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	
	      	    	{dataField: "RA_IDJOB_YN1"		,caption: "법률,회계,세무관련"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_IDJOB_YN2"		,caption: "투자자문관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_IDJOB_YN3"		,caption: "부동산관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_IDJOB_YN4"		,caption: "오락,도박,스포츠관련"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_IDJOB_YN5"		,caption: "대부업자,환전상"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_IDJOB_YN6"		,caption: "귀금속,예슬품,골동품판매상"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "RA_IDJOB_STA1"		,caption: "주류도소매업,유흥주점업"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_IDJOB_STA_YN1"	,caption: "주류도소매업,유흥주점업"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_IDJOB_STA2"		,caption: "의료,제약관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_IDJOB_STA_YN2"	,caption: "의료,제약관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_IDJOB_STA3"		,caption: "건설산업"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_IDJOB_STA_YN3"	,caption: "건설산업"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "RA_IDJOB_STA4"		,caption: "무기,방위산업"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_IDJOB_STA_YN4"	,caption: "무기,방위산업"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_IDJOB_STA5"		,caption: "채광,금속,고물상"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_IDJOB_STA_YN5"	,caption: "채광,금속,고물상"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "RA_IDJOB_YN7"		,caption: "가상자산사업의심"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "RA_IDJOB_STA6"		,caption: "무직자"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_IDJOB_STA_YN6"	,caption: "무직자"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true}
	      	    ]
	  	}).dxDataGrid("instance");
    }
 	
 	// 그리드 초기화 함수 셋업
    function setupGrids4(){
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
		   	    	visible: true
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
	     		  	{dataField: "RA_ITEM_CD"		,caption: "RA_ITEM_CD"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "RA_ITEM_CODE"		,caption: "상세코드"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	      	{dataField: "RA_ITEM_NM"		,caption: "상세코드 내용"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "ABS_HRSK_YN"		,caption: "당연EDD여부"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_ITEM_SCR"		,caption: "위험점수"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	
	      	    	{dataField: "RA_CORJOB_YN1"		,caption: "법률,회계,세무관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_YN2"		,caption: "투자자문관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_YN3"		,caption: "부동산관련"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_YN4"		,caption: "오락,도박,스포츠관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_YN5"		,caption: "카지노"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_YN6"		,caption: "대부업자,환전상,소액해외송금업자"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_YN7"		,caption: "귀금속,예슬품,골동품판매상"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "RA_CORJOB_STA1"	,caption: "주류도소매업,유흥주점업"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_CORJOB_STA_YN1"	,caption: "주류도소매업,유흥주점업"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_STA2"	,caption: "의료,제약관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_CORJOB_STA_YN2"	,caption: "의료,제약관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_STA3"	,caption: "건설산업"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_CORJOB_STA_YN3"	,caption: "건설산업"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_STA4"	,caption: "무기,방위산업"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_CORJOB_STA_YN4"	,caption: "무기,방위산업"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_CORJOB_STA5"	,caption: "채광,금속,고물상"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "RA_CORJOB_STA_YN5"	,caption: "채광,금속,고물상"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "RA_CORJOB_YN8"		,caption: "가상자산사업의심"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true}
	      	    	
	      	    ]
	  	}).dxDataGrid("instance");
    }
 	
 	// 그리드 초기화 함수 셋업
    function setupGrids5(){
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
	     		  	{dataField: "RA_ITEM_CD"			,caption: "RA_ITEM_CD"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "RA_ITEM_CODE"			,caption: "상세코드"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	      	{dataField: "RA_ITEM_NM"			,caption: "상세코드 내용"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	        {dataField: "RA_ST_INTV_VAL"		,caption: "변경전 시작 값"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	        {dataField: "GUGAN1"				,caption: "구간1"		        ,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	        {dataField: "RA_ET_INTV_VAL"		,caption: "변경전 종로 값"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	        {dataField: "GUGAN2"				,caption: "구간2"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},	      	    	      	   
	      	        {dataField: "ABS_HRSK_YN"			,caption: "변경전 당연EDD여부"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},	      	    	
	      	        {dataField: "RA_ITEM_SCR"			,caption: "변경전 위험점수"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_RMRK"				,caption: "변경전 비고"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "MODI_RA_ST_INTV_VAL"	,caption: "변경후 시작 값"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	        {dataField: "GUGAN3"				,caption: "구간1"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	        {dataField: "MODI_RA_ET_INTV_VAL"	,caption: "변경후 종로 값"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	        {dataField: "GUGAN4"				,caption: "구간2"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	
	      	    	{dataField: "MODI_ABS_HRSK_YN"		,caption: "변경후 당연EDD여부"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_RA_ITEM_SCR"		,caption: "변경후 위험점수"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_RA_RMRK"			,caption: "변경후 비고"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true}
	      	    ]
	  	}).dxDataGrid("instance");
    }
 
 	// 그리드 초기화 함수 셋업
    function setupGrids6(){
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
	     		  	{dataField: "RA_ITEM_CD"		,caption: "RA_ITEM_CD"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "RA_ITEM_CODE"		,caption: "상세코드"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	      	{dataField: "RA_ITEM_NM"		,caption: "변경전 상세코드 내용"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "ABS_HRSK_YN"		,caption: "변경전 당연EDD여부"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_ITEM_SCR"		,caption: "변경전 위험점수"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "RA_RMRK"			,caption: "변경전 비고"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_RA_ITEM_NM"	,caption: "변경후 상세코드 내용"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_ABS_HRSK_YN"	,caption: "변경후 당연EDD여부"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_RA_ITEM_SCR"	,caption: "변경후 위험점수"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true},
	      	    	{dataField: "MODI_RA_RMRK"		,caption: "변경후 비고"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true}
	      	    ]
	  	}).dxDataGrid("instance");
    }

</script>

<form name=form1 method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	<input type="hidden" name="SEQ" >

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