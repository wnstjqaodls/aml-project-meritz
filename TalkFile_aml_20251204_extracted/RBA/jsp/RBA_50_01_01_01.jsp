<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_01_01.jsp
* Description     : 위험평가 일정관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-20
--%>
<%
%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>

<%
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    String LOGIN_IDS = sessionAML.getsAML_LOGIN_ID();
    
	request.setAttribute("ROLE_IDS",ROLE_IDS);
	request.setAttribute("LOGIN_IDS",LOGIN_IDS);
%>



<script language="JavaScript">

    var GridObj1;
    var GridObj2;
    var GridObj3;
    var classID = "RBA_50_01_01_01";
    var pageID  = "RBA_50_01_01_01";
    var overlay = new Overlay();
    var ingStep = "0";
    
    var ROLE_IDS = "${ROLE_IDS}" ;
    var LOGIN_IDS = "${LOGIN_IDS}" ;

    // Initialize
    $(document).ready(function(){
        setupGrids();
        doSearch();
        if(form.BAS_YYMM.value != ''){
              doSearch2();
        }
        
        if( "7"  == "${ROLE_IDS}" ) {
        	$("#btn_02").attr("disabled",false);
	    } else {
	    	$("#btn_02").attr("disabled",true);
	    }
        


        setupFilter("init");
    });

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridObj.title = '${msgel.getMsg("RBA_50_01_01_01_101","위험평가 일정관리")}';
    	gridArrs[0] = gridObj;
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridObj.title = '${msgel.getMsg("RBA_50_08_03_02_001","첨부파일")}';
    	gridArrs[1] = gridObj;
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid3_Area";
    	gridObj.title = '${msgel.getMsg("RBA_50_01_01_01_102","마감체크")}';
    	gridArrs[2] = gridObj;

    	setupGridFilter2(gridArrs, FLAG);
    }

 // 그리드 초기화 함수 셋업
    function setupGrids(){

        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        			elementAttr: { class: "grid-table-type" },
        			width: "100%",
			 		height	:"calc(90vh - 110px)",
				 	hoverStateEnabled    : true,
				    wordWrapEnabled      : false,
				    allowColumnResizing  : true,
			        columnResizingMode 		: 'widget',
				    columnAutoWidth      : true,
				    allowColumnReordering: true,
				    cacheEnabled         : false,
				    cellHintEnabled      : true,
					onToolbarPreparing	 : makeToolbarButtonGrids,
				    showBorders          : true,
				    showColumnLines      : true,
				    showRowLines         : true,
				    export 					: {allowExportSelectedData : true ,enabled : true ,excelFilterEnabled : true},
				    onExporting: function (e) {
				    	var workbook = new ExcelJS.Workbook();
				    	var worksheet = workbook.addWorksheet("Sheet1");
					    DevExpress.excelExporter.exportDataGrid({
					        component: e.component,
					        worksheet: worksheet,
					        autoFilterEnabled: true,
					    }).then(function(){
					        workbook.xlsx.writeBuffer().then(function(buffer){
					            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}.xlsx");
					        });
					    });
					    e.cancel = true;
			        },
				    sorting              : {mode: "multiple"},
				    loadPanel            : {enabled: false},
				    remoteOperations     : {
				        filtering: false,
				        grouping : false,
				        paging   : false,
				        sorting  : false,
				        summary  : false
				    },
				    editing: { mode: 'batch', allowUpdating: true, allowAdding: false, allowDeleting: false, selectTextOnEditStart: true},
				    filterRow            : {visible: false},
				    pager: {
				        visible: false,
				        showNavigationButtons: true,
				        showInfo: true
				    },
				    paging: {
				        enabled: false,
				        pageSize: 20
				    },
				    scrolling: {
				        mode: "virtual"
				    },
				    rowAlternationEnabled: false,
				    onCellPrepared       : function(e){
				        var columnName         = e.column.dataField;
				        var dataGrid           = e.component;
				        var rowIndex           = dataGrid.getRowIndexByKey(e.key);
				        var realEdt            = dataGrid.cellValue(rowIndex, 'REAL_EDT');
				        var valtEdt            = dataGrid.cellValue(rowIndex, 'VALT_EDT');
				        var rba_valt_smdv_c_nm = dataGrid.cellValue(rowIndex, 'RBA_VALT_SMDV_C_NM');
				        if(rowIndex != -1){
				            if(realEdt == ''){
				                if((valtEdt !='')
				                && (columnName == 'RBA_VALT_LGDV_C_NM'
				                 || columnName == 'RBA_VALT_SMDV_C_NM'
				                 || columnName == 'VALT_SDT'
				                 || columnName == 'VALT_EDT'
				                 || columnName == 'REAL_EDT'
				                 || columnName == 'ROWNUM'
				                 || columnName == 'EXP_TRM')){
				                    e.cellElement.css('background-color', '#CEFBC9');
				                }
				            }
				            if((rba_valt_smdv_c_nm == '▶부점별 AML 업무 프로세스 관리 (TodoList 실행)') && (columnName == 'RBA_VALT_SMDV_C_NM')) {
				            	e.cellElement.css('color', '#FF4848');
				            }
				            if((rba_valt_smdv_c_nm == '▶전사 AML 내부통제 점검항목 관리 (배치 STEP1)(매월)')  && (columnName == 'RBA_VALT_SMDV_C_NM')) {
				            	//e.cellElement.css('color', '#FF4848');
				            }
				            if((rba_valt_smdv_c_nm == '▶ML/TF 총위험평가 (배치 STEP2)(반기or분기)') && (columnName == 'RBA_VALT_SMDV_C_NM')) {
				            	e.cellElement.css('color', '#FF4848');
				            }
				            if((rba_valt_smdv_c_nm == '▶AML 통제평가 (배치 STEP3)(반기or분기)') && (columnName == 'RBA_VALT_SMDV_C_NM')) {
				            	e.cellElement.css('color', '#FF4848');
				            }
				        }
				    },
				    searchPanel: {
				        visible: false,
				        width  : 250
				    },

				    selection: {
				        allowSelectAll    : true,
				        deferred          : false,
				        mode              : "multiple",
				        selectAllMode     : "allPages",
				        showCheckBoxesMode: "always"
				    },
				    columns: [
				        {
				            dataField    : "ROWNUM",
				            caption      : '${msgel.getMsg("RBA_50_05_04_007","순번")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width        : "55px",
				            allowEditing : false
				           // fixed        : true
				        }, {
				            dataField    : "RBA_VALT_LGDV_C",
				            caption      : '${msgel.getMsg("RBA_50_04_01_001","대분류")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        }, {
				            dataField    : "RBA_VALT_LGDV_C_NM",
				            caption      : '${msgel.getMsg("RBA_50_04_01_001","대분류")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width        : "150px",
				            allowEditing : false
				           // width        : "160px",
				           // fixed        : true
				        }, {
				            dataField    : "RBA_VALT_SMDV_C",
				            caption      : '${msgel.getMsg("RBA_50_01_01_011","구분")}',
				            alignment    : "left",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        }, {
				            dataField    : "RBA_VALT_SMDV_C_NM",
				            caption      : '${msgel.getMsg("RBA_50_01_01_051","일정명")}',
				            alignment    : "left",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width        : "200px",
				            allowEditing : false
				            //fixed        : true
				        },
				        {
				            dataField    : "MUST_YN",
				            caption      : '${msgel.getMsg("RBA_50_01_01_053","필수여부")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : true,
				            width        : "60px",
				            lookup : { dataSource  : [{"KEY":"1","VALUE":"Y"},{"KEY":"0","VALUE":"N"}]
                                                      ,displayExpr : "VALUE",valueExpr   : "KEY"}
				        },
				        {
				            dataField    : "FIX_YN",
				            caption      : '${msgel.getMsg("RBA_50_01_01_001","확정여부")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            visible      : true,
				            allowEditing : false,
				            width        : "60px",
				            lookup : { dataSource  : [{"KEY":"1","VALUE":"Y"},{"KEY":"0","VALUE":"N"},{"KEY":"2","VALUE":""}]
                                                     ,displayExpr : "VALUE",valueExpr   : "KEY"}
				        },
				        {
				            dataField    : "FIX_YN_M",
				            caption      : '${msgel.getMsg("RBA_50_01_01_001","마감여부")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            visible      : false,
				            allowEditing : false,
				            width        : "60px",
				            lookup : { dataSource  : [{"KEY":"1","VALUE":"Y"},{"KEY":"0","VALUE":"N"},{"KEY":"2","VALUE":""}]
                                                     ,displayExpr : "VALUE",valueExpr   : "KEY"}
				        },
				        {
				            dataField    : "EXP_TRM",
				            caption      : '${msgel.getMsg("RBA_50_05_01_100","예상소요시간(주)")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        },
				        {
				            dataField    : "VALT_SDT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_016","업무시작일자")}',
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width        : "100px",
				            allowEditing : false
				            //width        : "80px"
				        },
				        {
				            dataField    : "VALT_EDT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_017","업무종료일자")}',
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width        : "100px",
				            allowEditing : false
				          //  width        : "80px"
				        },
				        {
				            dataField    : "REAL_EDT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_015","배치처리일자")}',
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width        : "100px",
				            allowEditing : false
				          //  width        : "80px"
				        },
				        {
				            caption      : '${msgel.getMsg("RBA_50_05_01_101","대상거래")}',
				            alignment    : "center",
				            columns      : [
				            	{
						            dataField    : "TGT_TRN_SDT",
						            caption      : '${msgel.getMsg("RBA_50_05_01_102","시작일자")}',
						            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
						            alignment    : "center",
						            allowResizing: true,
						            allowSearch  : true,
						            allowSorting : true,
						            width        : "100px",
						            allowEditing : false
						        }, {
						            dataField    : "TGT_TRN_EDT",
						            caption      : '${msgel.getMsg("RBA_50_05_01_103","종료일자")}',
						            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
						            alignment    : "center",
						            allowResizing: true,
						            allowSearch  : true,
						            allowSorting : true,
						            width        : "100px",
						            allowEditing : false
						        }
						    ]
					    }, {
				            dataField    : "EXEC_B_BRNO_YN",
				            caption      : '${msgel.getMsg("RBA_50_05_01_104","AML주관부서")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        }, {
				            dataField    : "EXEC_B_BRNO_YN_NM",
				            caption      : '${msgel.getMsg("RBA_50_05_01_104","AML주관부서")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        }, {
				            dataField    : "EXEC_S_BRNO_YN",
				            caption      : '${msgel.getMsg("RBA_50_05_01_105","현업부서")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        }, {
				            dataField    : "EXEC_S_BRNO_YN_NM",
				            caption      : '${msgel.getMsg("RBA_50_05_01_105","현업부서")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        }, {
				            dataField    : "CHG_DT",
				            caption      : '${msgel.getMsg("RBA_50_05_01_106","변경일자")}',
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				           // width        : "80px"
				        }, {
				            dataField    : "CHG_OP_JKW_NO",
				            caption      : '${msgel.getMsg("RBA_50_05_01_107","변경자")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				          //  width        : "7%"
				        }, {
				            dataField    : "ING_STEP",
				            caption      : '${msgel.getMsg("RBA_50_01_01_002","배치여부")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        },{
				            dataField    : "ING_STEP_NM",
				            caption      : '${msgel.getMsg("RBA_50_01_01_044","배치상태")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        },{
				            dataField    : "ATTCH_FILE_NO",
				            caption      : '${msgel.getMsg("RBA_50_05_01_108","첨부파일번호")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        },{
				            dataField    : "BAT_STATE",
				            caption      : '${msgel.getMsg("RBA_50_01_01_044","배치상태")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        },{
				            dataField    : "BAT_ING_STEP",
				            caption      : '${msgel.getMsg("RBA_50_05_01_109","배치")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : false
				        }, {
				            dataField    : "VALT_METH_CTNT",
				            caption      : '${msgel.getMsg("RBA_50_03_02_012","비고")}',
				            alignment    : "left",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            allowEditing : false,
				            visible      : true
				        }, {
				            dataField    : "ING_STEP",
				            caption      : '${msgel.getMsg("RBA_50_01_01_044","진행상태")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            visible      : false
				        }, {
				            dataField    : "ING_STEP_NM",
				            caption      : '${msgel.getMsg("RBA_50_01_01_044","진행상태")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            visible      : false
				        },
				    ],
				    onCellPrepared : function(e){
				          if(e.rowType === 'data' && ( e.column.dataField === 'MUST_YN' ) ){
				        	   if(e.data.MUST_YN == '1'){
				        		   e.cellElement.css("color", "red");
				        	   }
				          }
				    },
				    onCellClick: function(e){
				        if(e.data){
				            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
				        }
				    }
				    ,"summary" :{totalItems: [{column: 'ROWNUM', summaryType: 'count', valueFormat: "fixedPoint"}],
    					texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
        }).dxDataGrid("instance");

        GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
			 height	:"110px",
			 "hoverStateEnabled"                : true,
		     "wordWrapEnabled"                  : false,
		     "allowColumnResizing"              : true,
		     "columnAutoWidth"                  : true,
		     "allowColumnReordering"            : true,
		     "cacheEnabled"                     : false,
		     "cellHintEnabled"                  : true,
		     "showBorders"                      : true,
		     "showColumnLines"                  : true,
		     "showRowLines"                     : true,
		     "export":
		     {
		         "allowExportSelectedData"      : false,
		         "enabled"                      : false,
		         "excelFilterEnabled"           : false,
		         "fileName"                     : "gridExport"
		     },
		     "sorting":
		     {
		        "mode"                          : "multiple"
		     },
		     "remoteOperations":
		     {
		         "filtering"                    : false,
		         "grouping"                     : false,
		         "paging"                       : false,
		         "sorting"                      : false,
		         "summary"                      : false
		     },
		     "editing":
		     {
		         "mode"                         : "batch",
		         "allowUpdating"                : false,
		         "allowAdding"                  : false,
		         "allowDeleting"                : false
		     },
		     "filterRow": {"visible"            : false},
		     "rowAlternationEnabled"            : false,
		     "columnFixing": {"enabled"         : true},
		     pager: {
		         visible: false,
		         showNavigationButtons: true,
		         showInfo: true
		     },
		     paging: {
		         enabled: false,
		         pageSize: 20
		     },
		     scrolling: {
		         mode: "virtual"
		     },
		     "searchPanel":
		     {
		         "visible"                      : false,
		         "width"                        : 250
		     },
		     onContentReady: function (e)
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
		     "selection":
		     {
		         "allowSelectAll"               : true,
		         "deferred"                     : false,
		         "mode"                         : "multiple",
		         "selectAllMode"                : "allPages",
		         "showCheckBoxesMode"           : "always"
		     },
		     "columns":
		     [
		         {
		             "dataField"                : "CNT",
		             "caption"                  : '${msgel.getMsg("RBA_50_05_04_007","순번")}',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "LOSC_FILE_NM",
		             "caption"                  : '${msgel.getMsg("RBA_50_01_01_01_100","첨부파일명")}',
		             "cssClass"                 : "link",
		             "alignment"                : "left",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "DR_DT",
		             "caption"                  : '${msgel.getMsg("RBA_50_05_01_106","변경일자")}',
		             "cellTemplate"             : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "REG_NM",
		             "caption"                  : '${msgel.getMsg("RBA_50_05_01_107","변경자")}',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "ATTCH_FILE_NO",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         },
		         {
		             "dataField"                : "FILE_SER",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         },
		         {
		             "dataField"                : "PHSC_FILE_NM",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         },
		         {
		             "dataField"                : "RPT_GJDT",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         }, /*
		         {
		             "dataField"                : "FILE_SER",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         } */
		     ],
		     "onCellClick": function(e)
		     {
		        if(e.data )
		        {
		        Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		        }
		     }
		     ,"summary" :{totalItems: [{column: 'CNT', summaryType: 'count', valueFormat: "fixedPoint"}],
					texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
       }).dxDataGrid("instance");

        GridObj3 = $("#GTDataGrid3_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
			 height	:"110px",
			 hoverStateEnabled     : true,
	    		wordWrapEnabled       : false,
	    		allowColumnResizing   : true,
	    		allowColumnReordering : true,
	    		columnResizingMode    : "widget", /* "widget" "nextColumn" */
	    		cacheEnabled          : false,
	    		cellHintEnabled       : true,
	    		showBorders           : true,
	    		showColumnLines       : true,
	    		showRowLines          : true,
	    		export : {allowExportSelectedData:true, enabled:true},
	            onExporting: function (e) {
	            	var workbook = new ExcelJS.Workbook();
	            	var worksheet = workbook.addWorksheet("Sheet1");
				    DevExpress.excelExporter.exportDataGrid({
				        component: e.component,
				        worksheet : worksheet,
				        autoFilterEnabled: true,
				    }).then(function() {
				        workbook.xlsx.writeBuffer().then(function(buffer) {
				            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}.xlsx");
				        });
				    });
				    e.cancel = true;
	            },
	    		sorting: { mode: "multiple"},
	    		loadPanel : { enabled: false },
	    		remoteOperations : {filtering:false, grouping:false, paging:false, sorting:false, summary:false},
		     editing: { mode: 'batch', allowUpdating: true, allowAdding: false, allowDeleting: false, selectTextOnEditStart: true},
		     filterRow: { visible: false },
		     rowAlternationEnabled            : true,
		     columnFixing : {"enabled"         : true},
		     pager: {
		         visible: false,
		         showNavigationButtons: true,
		         showInfo: true
		     },
		     paging: {
		         enabled: false,
		         pageSize: 20
		     },
		     scrolling: {
		         mode: "virtual"
		     },
		     searchPanel:
		     {
		         visible                      : false,
		         width                        : 250 ,
		         searchVisibleColumnsOnly: true
		     },
		     onContentReady: function (e)
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
		     selection: {
	    	       	allowSelectAll : true,
	    	       	deferred : false,
	    	       	mode : "multiple", /*none, single, multiple*/
	    	       	selectAllMode : "allPages",  /*: 'page' | 'allPages'*/
	    	       	showCheckBoxesMode : "always"  /*'onClick' | 'onLongTap' | 'always' | 'none'*/
    	     },
    	     scrolling   : {
    	        mode    : "virtual"
    	     },
		     columns:
		     [
		         {
		             "dataField"                : "BAS_YYMM",
		             "caption"                  : 'BAS_YYMM',
		             "alignment"                : "left",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "VALT01",
		             "caption"                  : 'VALT01',
		             "alignment"                : "left",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "VALT02",
		             "caption"                  : 'VALT02',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "VALT03",
		             "caption"                  : 'VALT03',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "VALT11",
		             "caption"                  : 'VALT11',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "VALT12",
		             "caption"                  : 'VALT12',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         },
		         {
		             "dataField"                : "VALT13",
		             "caption"                  : 'VALT13',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true
		         }
		     ],
		     "onCellClick": function(e)
		     {
		        if(e.data )
		        {
		        }
		     }
    	     ,"summary" :{totalItems: [{column: 'BAS_YYMM', summaryType: 'count', valueFormat: "fixedPoint"}],
					texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
      }).dxDataGrid("instance");
    }

    //그리드 클릭 이벤트
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){

    	form2.P_BAS_YYMM.value             = obj.BAS_YYMM;
        form2.P_RBA_VALT_LGDV_C.value      = obj.RBA_VALT_LGDV_C;
        form2.P_RBA_VALT_SMDV_C.value      = obj.RBA_VALT_SMDV_C;
        form2.P_RBA_VALT_LGDV_C_NM.value   = obj.RBA_VALT_LGDV_C_NM;
        form2.P_RBA_VALT_SMDV_C_NM.value   = obj.RBA_VALT_SMDV_C_NM;
        form2.P_EXP_TRM.value  			   = obj.EXP_TRM;

        form2.P_EXEC_B_BRNO_YN.value       = obj.EXEC_B_BRNO_YN;
        form2.P_EXEC_S_BRNO_YN.value       = obj.EXEC_S_BRNO_YN;

        form2.P_VALT_SDT.value           = (obj.VALT_SDT == undefined)?"":obj.VALT_SDT;        //수행시작일
        form2.P_VALT_EDT.value           = (obj.VALT_EDT == undefined)?"":obj.VALT_EDT;        //수행종료일
        form2.P_TGT_TRN_SDT.value        = (obj.TGT_TRN_SDT == undefined)?"":obj.TGT_TRN_SDT; //대상시작일
        form2.P_TGT_TRN_EDT.value        = (obj.TGT_TRN_EDT == undefined)?"":obj.TGT_TRN_EDT; //대상종료일
        form2.P_REAL_EDT.value        	 = (obj.REAL_EDT    == undefined)?"":obj.REAL_EDT; //대상종료일

            /* form2.P_BAS_YYMM.value             = obj.BAS_YYMM;
            form2.P_RBA_VALT_LGDV_C.value      = obj.RBA_VALT_LGDV_C;
            form2.P_RBA_VALT_SMDV_C.value      = obj.RBA_VALT_SMDV_C;
            form2.P_RBA_VALT_LGDV_C_NM.value   = obj.RBA_VALT_LGDV_C_NM;
            form2.P_RBA_VALT_SMDV_C_NM.value   = obj.RBA_VALT_SMDV_C_NM;
            form2.P_EXP_TRM.value  			   = obj.EXP_TRM;

            form2.P_EXEC_B_BRNO_YN.value       = obj.EXEC_B_BRNO_YN;
            form2.P_EXEC_S_BRNO_YN.value       = obj.EXEC_S_BRNO_YN;

            form2.P_VALT_SDT.value           = (obj.VALT_SDT == undefined)?"":obj.VALT_SDT;        //수행시작일
            form2.P_VALT_EDT.value           = (obj.VALT_EDT == undefined)?"":obj.VALT_EDT;        //수행종료일
            form2.P_TGT_TRN_SDT.value        = (obj.TGT_TRN_SDT == undefined)?"":obj.TGT_TRN_SDT; //대상시작일
            form2.P_TGT_TRN_EDT.value        = (obj.TGT_TRN_EDT == undefined)?"":obj.TGT_TRN_EDT; //대상종료일
            form2.P_REAL_EDT.value        	 = (obj.REAL_EDT    == undefined)?"":obj.REAL_EDT; //대상종료일 */
        //}
    }

    // 위험평가 일정관리 조회
    function doSearch(type){
        if(type == 'copy'){
        	window.location.href = window.document.URL;
        }
        overlay.show(true, true);

       /*  GridObj1.refresh({
            actionParam: {
                "pageID"  : pageID,
                "classID" : classID,
                "methodID": methodID,
                "BAS_YYMM": form.BAS_YYMM.value //기준연도
            },
            completedEvent:    doSearch_end
            ,failEvent:doSearch_end
        }); */

        var params   = new Object();
 		var methodID = "doSearch";
 		var classID  = "RBA_50_01_01_01";

 		params.pageID 	= pageID;
 		params.BAS_YYMM = form.BAS_YYMM.value; //기준연도3

 		sendService(classID, methodID, params, doSearch_end, doSearch_end);
    }

    // 위험평가 일정관리 조회 end
    function doSearch_end(gridData, data){
    	overlay.hide();
    	GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    	//확정취소 버튼
        var sfyn; sfyn = "";
        var sbYn; sbYn = "";
        var sbState; sbState = "";
        var sbYnNm; sbYnNm = "";
        var sbStateNm; sbStateNm = "";
        var batNm; batNm = "";
        var sreal_bas_yn; sreal_bas_yn = "";
        var sbStep; sbStep = "";

    	if(data.GRID_DATA[0] == null || data.GRID_DATA[0] == '') {
     		/* $("#btn_04").attr("style","display:none;"); */
    	} else {
     	    if(data.GRID_DATA[0].FIX_YN == "1"){
     		// 확정여부:Y
     		    $("#btn_04").attr("style","inline-block;");
     	    }else {
     		    /* $("#btn_04").attr("style","display:none;"); */
     	    }
            sfyn = (data.GRID_DATA[0].FIX_YN_M == "0") ? "N":"Y";
            form2.ING_STEP.value = data.GRID_DATA[0].ING_STEP
            form2.ING_STEP_NM.value = data.GRID_DATA[0].ING_STEP_NM
            sbStep = data.GRID_DATA[0].ING_STEP_NM
            form2.ATTCH_FILE_NO.value = data.GRID_DATA[0].ATTCH_FILE_NO;
     	}

        //확정여부 표시

        form.fixyn.value = sfyn;


        //진행상태
        form.ING_STEP_NM.value = sbStep;

        /* //RBA 실제 평가기준년월 여부
        sreal_bas_yn = (GridObj1.getRow(0).REAL_BAS_YN == "Y") ? "Y":"N";
        form.real_bas_yn.value = sreal_bas_yn; */

        //form2 초기화
        form2.P_BAS_YYMM.value           = "";
        form2.P_RBA_VALT_LGDV_C.value    = "";
        form2.P_RBA_VALT_SMDV_C.value    = "";
        form2.P_RBA_VALT_LGDV_C_NM.value = "";
        form2.P_RBA_VALT_SMDV_C_NM.value = "";
        form2.P_EXP_TRM.value 			 = "";

        form2.P_EXEC_B_BRNO_YN.value 	 = "";
        form2.P_EXEC_S_BRNO_YN.value 	 = "";

        form2.P_VALT_SDT.value           = "";
        form2.P_VALT_EDT.value           = "";
        form2.P_TGT_TRN_SDT.value        = "";
        form2.P_TGT_TRN_EDT.value        = "";
        form2.P_REAL_EDT.value        	 = "";

        //doSearch2();
        //doSearch3();

    }

    function doSearch2(){
        if(GridObj2==null) {
           return;
        }

        GridObj2.clearSelection();
        GridObj2.option('dataSource', []);

        /* var obj      = new Object();
        obj.pageID   = pageID;
        obj.classID  = classID;
        obj.methodID = "getSearchF";    //영역 부문  같이 활용
        obj.BAS_YYMM = form.BAS_YYMM.value;

        GridObj2.refresh({
            actionParam     : obj
            ,completedEvent  : doSearch_end2
        }); */
        var params   = new Object();
 		var methodID = "getSearchF";
 		var classID  = "RBA_50_01_01_01";

 		params.pageID 	= pageID;
 		params.BAS_YYMM = form.BAS_YYMM.value; //기준연도3

 		sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);

     }

     function doSearch2_success(gridData, data)
     {
    	GridObj2.refresh();
    	GridObj2.option("dataSource", gridData);
     }
     function doSearch2_fail(){
    	 overlay.hide();
     }

     function doSearch3(){
         if(GridObj3==null) {
            return;
         }

         GridObj3.clearSelection();
         GridObj3.option('dataSource', []);

         /* var obj      = new Object();
         obj.pageID   = pageID;
         obj.classID  = classID;
         obj.methodID = "getEndCheck";    //영역 부문  같이 활용
         obj.BAS_YYMM = form.BAS_YYMM.value;

         GridObj3.refresh({
             actionParam     : obj
             ,completedEvent  : doSearch_end3
         }); */
        var params   = new Object();
  		var methodID = "getEndCheck";
  		var classID  = "RBA_50_01_01_01";

  		params.pageID 	= pageID;
  		params.BAS_YYMM = form.BAS_YYMM.value; //기준연도3

  		sendService(classID, methodID, params, doSearch3_success, doSearch3_fail);

      }

     function doSearch3_success(gridData, data)
     {
    	GridObj3.refresh();
    	GridObj3.option("dataSource", gridData);
     }
     function doSearch3_fail(){
    	 overlay.hide();
     }


    // 일정수정
    function doModify(){

		//alert( "BAS_YYMM : " + form.BAS_YYMM.value);

    	if (form.BAS_YYMM.value == "999912" && ROLE_ID != "7") {
        	showAlert("수정 할 수 없는 년월입니다",'WARN');
			return;
		}

    	var selData  = GridObj1.getSelectedRowsData();

        if(selData == null || selData == "")
        {
        	showAlert('${msgel.getMsg("RBA_50_01_01_005","수정 할 대상을 선택 후 수정하세요.")}','WARN');
        }
        else
        {



        	if(selData[0].FIX_YN == "1"){
	        	showAlert('${msgel.getMsg("RBA_50_01_01_004","일정이 확정이 된 상태에서 수정이 불가능합니다.")}','WARN');
	        	return;
	        }else if(selData.length == 0){
	        	showAlert('${msgel.getMsg("RBA_50_01_01_005","수정 할 대상을 선택 후 수정하세요.")}','WARN');
	        	return;
	        }else if(selData.length == 1){
	        	var arrRBA_VALT_LGDV_C_NM = new Array();
	        	var arrRBA_VALT_SMDV_C_NM = new Array();
	        	var arrRBA_VALT_SMDV_C = new Array();

	            for(i = 0, count = 0; i < selData.length; i++) {
	            	rowData = selData[i];
 	            	arrRBA_VALT_LGDV_C_NM[i] = rowData.RBA_VALT_LGDV_C_NM ;
	            	arrRBA_VALT_SMDV_C_NM[i] = rowData.RBA_VALT_SMDV_C_NM ;
	            	arrRBA_VALT_SMDV_C[i] = rowData.RBA_VALT_SMDV_C ;

            		form2.P_VALT_SDT.value = rowData.VALT_SDT ;
     	        	form2.P_VALT_EDT.value = rowData.VALT_EDT ;
     	        	form2.P_TGT_TRN_SDT.value = rowData.TGT_TRN_SDT ;
     	        	form2.P_TGT_TRN_EDT.value = rowData.TGT_TRN_EDT ;
     	        	form2.P_VALT_METH_CTNT.value = rowData.VALT_METH_CTNT ;

	            }


 	        	form2.P_arrRBA_VALT_LGDV_C_NM.value =  arrRBA_VALT_LGDV_C_NM;
	        	form2.P_arrRBA_VALT_SMDV_C_NM.value =  arrRBA_VALT_SMDV_C_NM;
	        	form2.P_arrRBA_VALT_SMDV_C.value =  arrRBA_VALT_SMDV_C;

	        	//alert( "call mod length : " + selData[0].FIX_YN + "  " + selData.length );

	        	form2.P_BAS_YYMM.value = form.BAS_YYMM.value ;
	        	form2.p_COUNT.value = "1";





	            form2.pageID.value = "RBA_50_01_01_02";	// 일정수정

	            //alert( "call mod ingStep : " + form.ingStep.value );

	            form2.ingStep.value = form.ingStep.value;
	            var win;       win = window_popup_open(form2.pageID.value, 700, 500, '','No');
	            form2.target       = form2.pageID.value;
	            form2.action       = '<c:url value="/"/>0001.do';
	            form2.submit();

	        }else{

 	        	var arrRBA_VALT_LGDV_C_NM = new Array();
	        	var arrRBA_VALT_SMDV_C_NM = new Array();
	        	var arrRBA_VALT_SMDV_C = new Array();

	            for(i = 0, count = 0; i < selData.length; i++) {
	            	 rowData = selData[i];
 	            	 arrRBA_VALT_LGDV_C_NM[i] = rowData.RBA_VALT_LGDV_C_NM ;
	            	 arrRBA_VALT_SMDV_C_NM[i] = rowData.RBA_VALT_SMDV_C_NM ;
	            	 arrRBA_VALT_SMDV_C[i] = rowData.RBA_VALT_SMDV_C ;
	            	 count++;

	            	 if(i==0){
	            		form2.P_VALT_SDT.value = rowData.VALT_SDT ;
	     	        	form2.P_VALT_EDT.value = rowData.VALT_EDT ;
	     	        	form2.P_TGT_TRN_SDT.value = rowData.TGT_TRN_SDT ;
	     	        	form2.P_TGT_TRN_EDT.value = rowData.TGT_TRN_EDT ;
	            	 }
	            }


 	        	form2.P_arrRBA_VALT_LGDV_C_NM.value =  arrRBA_VALT_LGDV_C_NM;
	        	form2.P_arrRBA_VALT_SMDV_C_NM.value =  arrRBA_VALT_SMDV_C_NM;
	        	form2.P_arrRBA_VALT_SMDV_C.value =  arrRBA_VALT_SMDV_C;

	        	//alert( "call mod length : " + selData[0].FIX_YN + "  " + selData.length );

	        	form2.P_BAS_YYMM.value = form.BAS_YYMM.value ;  //2019.10.01 jsw
	        	form2.p_COUNT.value = count;





	            form2.pageID.value = "RBA_50_01_01_02";	// 일정수정

	            //alert( "call mod ingStep : " + form.ingStep.value );

	            form2.ingStep.value = form.ingStep.value;
	            var win;       win = window_popup_open(form2.pageID.value, 700, 500, '','No');
	            form2.target       = form2.pageID.value;
	            form2.action       = '<c:url value="/"/>0001.do';
	            form2.submit();
	        }
        }


    }

    // 일정복사
    function docopy(){

        form2.pageID.value = "RBA_50_01_01_03";
        var win;       win = window_popup_open("RBA_50_01_01_03", 600, 350, '','No');
        form2.target       = form2.pageID.value;
        form2.action       = '<c:url value="/"/>0001.do';
        form2.submit();
    }

    // 확정/취소
    function doConfirm() {

    	var rowsData = GridObj1.getDataSource().items();

		//alert( "step : [" + rowsData[0].ING_STEP + "]");

    	if(rowsData[0].ING_STEP == "00"){
            confirmState = "1";
            showConfirm("${msgel.getMsg('RBA_50_01_01_006','확정을 하시겠습니까?')}", "확정",function(){
                     var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = form.BAS_YYMM.value;
                     params.FIX_YN = "1";
                     params.ING_STEP = "10";  //confirmState
                     params.RBA_VALT_SMDV_C = rowsData[0].RBA_VALT_SMDV_C;

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);

            });


        }else{
        	if(rowsData[0].ING_STEP == "10"){
	            confirmState = "0";
	            showConfirm("${msgel.getMsg('RBA_50_01_01_007','확정을 취소하시겠습니까?')}", "취소",function(){
	            	 //$("button[id='btn_04']").prop('disabled', true);

	                 var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = form.BAS_YYMM.value;
                     params.FIX_YN = "0";
                     params.ING_STEP = "00";  //confirmState
                     params.RBA_VALT_SMDV_C = rowsData[0].RBA_VALT_SMDV_C;

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);
	            });
        	}else {
        		// 일정정보관리 확정단계에서만 취소 할수 있습니다. ==> 라고 수정이 필요
        		showAlert('${msgel.getMsg("RBA_50_01_01_01_112","일정정보관리 확정단계에서만 취소 할수 있습니다.")}','WARN');
           		return;
            }
        }
    }

 // 확정/취소 end
    function doConfirm_end() {
        //$("button[id='btn_04']").prop('disabled', false);
        doSearch();
    }

    // 마감/취소
    function doFinish(){

        if($("button[id='btn_04']") == null) return;

        var confirmState = "";

        var rowsData = GridObj1.getDataSource().items();

        if(rowsData[0].FIX_YN_M == "0"){
            confirmState = "1";
            showConfirm("${msgel.getMsg('RBA_50_01_01_055','마감을 하시겠습니까?')}", "확정",function(){
            	var params   = new Object();
                var methodID = "doFinish";
                var classID  = classID;

                params.pageID 	= pageID;
                params.BAS_YYMM = form.BAS_YYMM.value;
                params.FIX_YN = "1";  //confirmState
                params.ING_STEP = "99";

                sendService(classID, methodID, params, doSearch_end, doSearch_end);
                
            	 /* var cpc = chkPosCon();
                 if(cpc == "0"){

                     var params   = new Object();
                     var methodID = "doFinish";
                     var classID  = classID;

                     params.pageID 	= pageID;
                     params.BAS_YYMM = form.BAS_YYMM.value;
                     params.FIX_YN = "1";  //confirmState
                     params.ING_STEP = "99";

                     sendService(classID, methodID, params, doSearch_end, doSearch_end);
                 }else{
                     if(cpc == "1"){
                     	//alert("${msgel.getMsg('RBA_50_01_01_008','수행시작일 및 수행종료일이 기입되어야 확정이 가능합니다.')}");
                         showAlert('${msgel.getMsg("RBA_50_01_01_01_103","업무시작일자 및 업무종료일자가 기입되어야 확정이 가능합니다.")}','WARN');
                         doModify();
                         $("button[id='btn_04']").prop('disabled', false);
                     }else{
                     	//alert("${msgel.getMsg('RBA_50_01_01_009','전사 AML 내부통제 점검항목 관리는 대상시작일 및 대상종료일이 기입되어야 합니다.')}");
                         showAlert('${msgel.getMsg("RBA_50_01_01_01_104","전사 AML 내부통제 점검항목 관리는 대상시작일 및 대상종료일이 기입되어야 합니다.")}','WARN');
                         doModify();
                         $("button[id='btn_04']").prop('disabled', false);
                     }
                 } */
            });
        }else{
        	if(rowsData[0].FIX_YN_M == "1"){
	            confirmState = "0";
	            showConfirm("${msgel.getMsg('RBA_50_01_01_056','마감을 취소하시겠습니까?')}", "취소",function(){
	            	 $("button[id='btn_04']").prop('disabled', true);

	                 var params   = new Object();
                     var methodID = "doFinish";
                     var classID  = "RBA_50_01_01_01";

                     params.pageID 	= pageID;
                     params.BAS_YYMM = form.BAS_YYMM.value;
                     params.FIX_YN = "0";  //confirmState
                     params.ING_STEP = "10";

                     sendService(classID, methodID, params, doFinish_end, doFinish_end);
	            });
        	}else {
        		showAlert('${msgel.getMsg("RBA_50_01_01_01_105","배치가 진행중입니다. 배치가 완료된 후에 처리하여 주시기 바랍니다.")}','WARN');
           		return;
            }
        }

        $("button[id='btn_04']").prop('disabled', true);

    }

    function doFinish_end() {
        $("button[id='btn_04']").prop('disabled', false);
        doSearch();
    }

    // 확정 체크 스크립트
    function chkPosCon(){
        var flag = "0";
        for (var i = 0; i < GridObj1.rowCount(); i++) {
            var rowobj = GridObj1.getRow(i);
            //수행시작일&수행종료일 체크 시작
            if(rowobj.VALT_SDT.length != 8 || rowobj.VALT_EDT.length != 8){
                flag = "1";
                form2.P_BAS_YYMM.value           = rowobj.BAS_YYMM;
                form2.P_RBA_VALT_LGDV_C.value    = rowobj.RBA_VALT_LGDV_C;
                form2.P_RBA_VALT_SMDV_C.value    = rowobj.RBA_VALT_SMDV_C;
                form2.P_RBA_VALT_LGDV_C_NM.value = rowobj.RBA_VALT_LGDV_C_NM;
                form2.P_RBA_VALT_SMDV_C_NM.value = rowobj.RBA_VALT_SMDV_C_NM;
                form2.P_EXP_TRM.value  			 = rowobj.EXP_TRM;

                form2.P_EXEC_B_BRNO_YN.value     = rowobj.EXEC_B_BRNO_YN;
                form2.P_EXEC_S_BRNO_YN.value     = rowobj.EXEC_S_BRNO_YN;
                form2.P_VALT_SDT.value           = (rowobj.VALT_SDT == undefined)?"":rowobj.VALT_SDT;        //수행시작일
                form2.P_VALT_EDT.value           = (rowobj.VALT_EDT == undefined)?"":rowobj.VALT_EDT;        //수행종료일
                form2.P_TGT_TRN_SDT.value        = (rowobj.TGT_TRN_SDT  == undefined)?"":rowobj.TGT_TRN_SDT; //대상시작일
                form2.P_TGT_TRN_EDT.value        = (rowobj.TGT_TRN_EDT  == undefined)?"":rowobj.TGT_TRN_EDT; //대상종료일
                form2.P_REAL_EDT.value        	 = (rowobj.REAL_EDT  == undefined)?"":rowobj.REAL_EDT; //대상종료일

                return flag;
            }
            //대상시작일&대상종료일 체크 시작
            if(rowobj.RBA_VALT_SMDV_C == "D01"){
                if(rowobj.TGT_TRN_SDT.length != 8 || rowobj.TGT_TRN_EDT.length != 8){
                    flag = "2";
                    form2.P_BAS_YYMM.value           = rowobj.BAS_YYMM;
                    form2.P_RBA_VALT_LGDV_C.value    = rowobj.RBA_VALT_LGDV_C;
                    form2.P_RBA_VALT_SMDV_C.value    = rowobj.RBA_VALT_SMDV_C;
                    form2.P_RBA_VALT_LGDV_C_NM.value = rowobj.RBA_VALT_LGDV_C_NM;
                    form2.P_RBA_VALT_SMDV_C_NM.value = rowobj.RBA_VALT_SMDV_C_NM;
                    form2.P_EXP_TRM.value  			 = rowobj.EXP_TRM;

                    form2.P_EXEC_B_BRNO_YN.value     = rowobj.EXEC_B_BRNO_YN;
                    form2.P_EXEC_S_BRNO_YN.value     = rowobj.EXEC_S_BRNO_YN;
                    form2.P_VALT_SDT.value           = (rowobj.VALT_SDT == undefined)?"":rowobj.VALT_SDT;        //수행시작일
                    form2.P_VALT_EDT.value           = (rowobj.VALT_EDT == undefined)?"":rowobj.VALT_EDT;        //수행종료일
                    form2.P_TGT_TRN_SDT.value        = (rowobj.TGT_TRN_SDT  == undefined)?"":rowobj.TGT_TRN_SDT; //대상시작일
                    form2.P_TGT_TRN_EDT.value        = (rowobj.TGT_TRN_EDT  == undefined)?"":rowobj.TGT_TRN_EDT; //대상종료일
                    form2.P_REAL_EDT.value        	 = (rowobj.REAL_EDT  == undefined)?"":rowobj.REAL_EDT; //대상종료일
                    return flag;
                }
            }
        }
        return flag;
    }




    // 삭제처리
    function doDelete(){
        var rowsData = GridObj1.getDataSource().items();

        if($("button[id='btn_02']") == null) return;


        if( form.fixyn.value == "Y"){
            showAlert('${msgel.getMsg("RBA_50_01_01_01_106","일정이 확정이 된 상태에서 삭제가 불가능합니다.")}','WARN');
            return;
        }

        showConfirm("${msgel.getMsg('RBA_50_01_01_008','일정을 삭제 하시겠습니까?')}", "삭제",function(){

        	//$("button[id='btn_02']").prop('disabled', true);

            var methodID = "doDelete";

           /*  GridObj1.save({
                actionParam: {
                    "pageID"     : pageID,
                    "classID"    : classID,
                    "methodID"   : methodID,
                    "BAS_YYMM"   : form.BAS_YYMM.value
                },
                sendFlag      : "USERDATA",
                userGridData  : rowsData,
                completedEvent: doDelete_end
                ,failEvent    : doDeleteFail_end
            }); */

            var params   = new Object();
            var methodID = "doDelete";
            var classID  = "RBA_50_01_01_01";

            params.pageID 	= pageID;
            params.BAS_YYMM = form.BAS_YYMM.value;
            params.COPY_YYMM = form.BAS_YYMM.value;

            sendService(classID, methodID, params, doDelete_end, doDeleteFail_end);

        });



    }

    // 삭제 end
    function doDelete_end() {
        $("button[id='btn_02']").prop('disabled', false);
        window.location.href = window.document.URL;
        overlay.hide();
    }
    // 삭제 end
    function doDeleteFail_end() {
        $("button[id='btn_02']").prop('disabled', false);
        overlay.hide();
    }

    // 종료처리
    function doEnd(){
    	var selData = GridObj1.getSelectedRowsData();
    	var rowsData = GridObj3.getSelectedRowsData();

    	if(selData.length > 1){
    		showAlert('${msgel.getMsg("RBA_50_01_01_01_110","한건만 선택해서 배치처리 해주세요")}','WARN');
    		return;
    	}

        if(selData.length == 0){
            showAlert('${msgel.getMsg("RBA_50_01_01_009","수정 할 대상을 선택 후 종료처리 하세요.")}','WARN');
            return;
        }else{
        	for (var i=0; i < selData.length; i++){
        		var rowobj = selData[i];
        		if(rowobj.RBA_VALT_SMDV_C =="D01"){
        			if (rowobj.TGT_TRN_SDT.length != 8 || rowobj.TGT_TRN_EDT.length !=8){
        				showAlert('${msgel.getMsg("RBA_50_01_01_01_104","전사 AML 내부통제 점검항목 관리는 대상시작일 및 대상종료일이 기입되어야 합니다.")}','WARN');
                        return;
            		}
        		}else if (rowobj.VALT_SDT == "" && rowobj.VALT_EDT == "" ){
        			showAlert('${msgel.getMsg("RBA_50_01_01_01_107","업무 시작일,업무종료일을 입력 후 배치처리 하세요.")}','WARN');
                    return;
        		}else if (rowobj.RBA_VALT_SMDV_C == "E01"){
        			//2019.10.01 jsw 추가

        			if (GridObj3.getDataSource() == null){
        				showAlert("${msgel.getMsg('RBA_50_01_01_01_108','전사 AML 내부통제 점검항목 관리 (배치 STEP1)(매월) \\r배치가 진행되지 않았습니다. 확인 후 배치처리 하세요.')}",'WARN');
        				return;
        			}else {
        				if(rowsData.VALT03 != 0){
        					showAlert('${msgel.getMsg("RBA_50_01_01_01_109","위험평가가 미완료된 팀점이 있습니다. \\r확인 후 배치처리 하세요.")}','WARN');
        					return;
        				}
        			}
        		}else if(rowobj.RBA_VAlT_SMDV_C == "E02"){
        			//2019.10.01 jsw 추가
        			if (GridObj3.getDataSource() == null){
        				showAlert("${msgel.getMsg('RBA_50_01_01_01_108','전사 AML 내부통제 점검항목 관리 (배치 STEP1)(매월) \\r배치가 진행되지 않았습니다. 확인 후 배치처리 하세요.')}",'WARN');
        				return;
        			}else {
        				if(rowsData.VALT03 == 0 && rowsData.VALT13 == 0){
        					//아무것도 안함
        				}else{
        					showAlert('${msgel.getMsg("RBA_50_01_01_01_111","통제평가 미완료된 팀점이 있습니다. \\r확인 후 배치처리 하세요.")}','WARN');
        					return;
        				}
        			}
        		}
        	}
        }

        var selectedData = selData[0];	//한 건만 선택

    	form2.P_BAS_YYMM.value             = selectedData.BAS_YYMM;				//기준년월
        form2.P_RBA_VALT_LGDV_C.value      = selectedData.RBA_VALT_LGDV_C;		//대분류
        form2.P_RBA_VALT_LGDV_C_NM.value   = selectedData.RBA_VALT_LGDV_C_NM;	//대분류
        form2.P_RBA_VALT_SMDV_C.value      = selectedData.RBA_VALT_SMDV_C;		//구분
        form2.P_RBA_VALT_SMDV_C_NM.value   = selectedData.RBA_VALT_SMDV_C_NM;	//구분
        form2.P_EXP_TRM.value  			   = selectedData.EXP_TRM;				//예상소요기간
        form2.P_EXEC_B_BRNO_YN.value       = selectedData.EXEC_B_BRNO_YN;		//수행_현업부서여부
        form2.P_EXEC_S_BRNO_YN.value       = selectedData.EXEC_S_BRNO_YN;		//수행_주관부서여부

        form2.P_VALT_SDT.value           = (selectedData.VALT_SDT == undefined)?"":selectedData.VALT_SDT;        //수행시작일
        form2.P_VALT_EDT.value           = (selectedData.VALT_EDT == undefined)?"":selectedData.VALT_EDT;        //수행종료일
        form2.P_TGT_TRN_SDT.value        = (selectedData.TGT_TRN_SDT == undefined)?"":selectedData.TGT_TRN_SDT; //대상시작일
        form2.P_TGT_TRN_EDT.value        = (selectedData.TGT_TRN_EDT == undefined)?"":selectedData.TGT_TRN_EDT; //대상종료일
        form2.P_REAL_EDT.value        	 = (selectedData.REAL_EDT    == undefined)?"":selectedData.REAL_EDT; //실제종료일

        form2.pageID.value = "RBA_50_01_01_04";
        var win;       win = window_popup_open("RBA_50_01_01_04", 600, 420, '','No');
        form2.target       = form2.pageID.value;
        form2.action       = '<c:url value="/"/>0001.do';
        form2.submit();

    }

    function Grid2CellClick(id, GridObj2, selectData, rowIdx, colIdx, colId) {
        if (colId == "LOSC_FILE_NM") {
           downloadFile(GridObj2);
        }
    }
    function downloadFile(obj){

    	$("[name=pageID]", "#fileFrm").val('RBA_50_01_01_01');
    	$("#downFileName").val(obj.PHSC_FILE_NM);
    	$("#orgFileName").val(obj.LOSC_FILE_NM);
    	$("#downFilePath").val(obj.FILE_POS);
    	$("#BOARD_ID").val("b");
    	$("#BOARD_SEQ").val("s");
    	$("#FILE_SEQ").val("e");
    	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
    	$("#fileFrm").submit();
    }
    function Filesave_OpenPop() {

        var form2            = document.form2;
        form2.pageID.value   = "RBA_50_01_01_05";
        form2.methodID.value = "getSearchF";
        form2.classID.value  = classID;
        form2.BAS_YYMM.value = form.BAS_YYMM.value
        form2.P_BAS_YYMM.value = form.BAS_YYMM.value
        var win;         win = window_popup_open(form2, 700, 385, '', 'yes');
        form2.target         = form2.pageID.value;
        form2.action         = '<c:url value="/"/>0001.do';
        form2.submit();
    }

    function doFileDelete() {

        var selectedRows  = GridObj2.getSelectedRowsData();
        var selSize       = selectedRows.length;
        if(selSize == 0){
              showAlert('${msgel.getMsg("dataDeleteSelect","삭제할 데이타를 선택하십시오.")}','WARN');
              return;
          }

        showConfirm("${msgel.getMsg('doDelete','삭제하시겠습니까?')}", "${msgel.getMsg('AML_20_03_01_01_006','삭제')}",function(){
        	var params   = new Object();
        	var methodID = "doFileDelete";
        	var classID  = "RBA_50_01_01_01";

        	params.pageID 	= "RBA_10_05_01_01";
        	params.BAS_YYMM = form.BAS_YYMM.value;
        	params.gridData = selectedRows;
        	sendService(classID, methodID, params, doSearch2, doSearch2);
        });

    }

    function doOpenPop(){
    	form2.BAS_YYMM.value = form.BAS_YYMM.value
    	form2.pageID.value = "RBA_50_01_01_07";
        var win;       win = window_popup_open("RBA_50_01_01_07", 900, 475, '','No');
        form2.target       = form2.pageID.value;
        form2.action       = '<c:url value="/"/>0001.do';
        form2.submit();
        form2.BAS_YYMM.value = "";
    }

    function makeToolbarButtonGrids(e){

        var cmpnt; cmpnt = e.component;
        var useYN = "${outputAuth.USE_YN  }";  // 사용 유무
        var authC = "${outputAuth.C       }";  // 추가,수정 권한
        var authD = "${outputAuth.D       }";  // 삭제 권한
        if (useYN=="Y") {
            var gridID       = e.element.attr("id");    // 그리드 아이디
            var toolbarItems = e.toolbarOptions.items;
            toolbarItems.splice(0, 0, {
                "locateInMenu"  : "auto"
                ,"location"     : "after"
                ,"widget"       : "dxButton"
                ,"name"         : "filterButton"
                ,"showText"     : "inMenu"
                ,"options"      : {
                         "icon"      : ""
                       	,"elementAttr": { class: "btn-28 filter" }
            			,"text"      : ""
                        ,"hint"      : '필터'
                        ,"disabled"  : false
                        ,"onClick"   : function(){
								setupFilter();
                        }
                 }
            });
        }
    }

</script>
<!-- 팝업 이동 FORM -->
<form name="form2" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">

    <input type="hidden" name="P_BAS_YYMM">           <!-- 기준년월   -->
    <input type="hidden" name="P_RBA_VALT_LGDV_C">    <!-- 대분류  -->
    <input type="hidden" name="P_RBA_VALT_SMDV_C">    <!-- 구분  -->
    <input type="hidden" name="P_RBA_VALT_LGDV_C_NM">    <!-- 대분류  -->
    <input type="hidden" name="P_RBA_VALT_SMDV_C_NM">    <!-- 구분  -->
    <input type="hidden" name="P_EXP_TRM">  		   <!--주기  -->

    <input type="hidden" name="P_EXEC_B_BRNO_YN"> 	  <!-- 주관부서권한   -->
    <input type="hidden" name="P_EXEC_S_BRNO_YN"> 	  <!-- 현업권한부서   -->
    <input type="hidden" name="P_VALT_SDT">           <!-- 수행시작일 -->
    <input type="hidden" name="P_VALT_EDT">           <!-- 수행종료일 -->
    <input type="hidden" name="P_TGT_TRN_SDT">        <!-- 대상시작일 -->
    <input type="hidden" name="P_TGT_TRN_EDT">        <!-- 대상종료일 -->
    <input type="hidden" name="P_REAL_EDT">    		  <!-- 실제종료일 -->
    <input type="hidden" name="P_VALT_METH_CTNT">     <!-- 비고 -->
    <input type="hidden" name="p_COUNT">              <!-- 건수 -->
    <input type="hidden" name="P_arrRBA_VALT_LGDV_C_NM">
    <input type="hidden" name="P_arrRBA_VALT_SMDV_C_NM">
    <input type="hidden" name="P_arrRBA_VALT_SMDV_C">
	<input type="hidden" name="ATTCH_FILE_NO" value="${ATTCH_FILE_NO}" >
	<input type="hidden" name="FILE_SER" >
	<input type="hidden" name="BAS_YYMM">           <!-- 기준년월   -->
	<input type="hidden" name="ING_STEP">           <!-- 기준년월   -->
	<input type="hidden" name="ING_STEP_NM">           <!-- 기준년월   -->
    <input type="hidden" name="ingStep" >
</form>
<form name="fileFrm" id="fileFrm" method="POST">
<input type="hidden" name="pageID" />
<input type="hidden" name="downFileName" id="downFileName" value="" />
<input type="hidden" name="orgFileName" id="orgFileName" value="" />
<input type="hidden" name="downFilePath" id="downFilePath" value="" />
<input type="hidden" name="downType" id="downType" value="RBA" />
<input type="hidden" name="BOARD_ID"     id="BOARD_ID"   value=""     >
<input type="hidden" name="BOARD_SEQ"   id="BOARD_SEQ"  value="">
<input type="hidden" name="FILE_SEQ" 	id="FILE_SEQ" value= ""/>
</form>
<!-- MAIN FORM -->
<form name="form" id="form">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="ingStep" >

    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row" style="width:340px;">
            <div class="table-cell">
            	${condel.getLabel("RBA_50_03_02_001","평가회차")}
            	<div class="content">
            		<RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="" eventFunction='doSearch()'/>
            	</div>
            </div>
        </div>
        <div class="table-row" style="width:300px;">
        	<div class="table-cell">
            	${condel.getLabel("RBA_50_01_01_048","마감여부")}
            	<div class="content">
            		<input type="text" name= "fixyn" size="2" class="cond-input-text" style="text-align:center" readonly="readonly" />
            	</div>
            </div>
        </div>
        <div class="table-row" style="width:59.5%">
        	<div class="table-cell">
        		${condel.getLabel("RBA_50_01_01_047","진행상태")}
        		<div class="content">
            		<input type="text" name= "ING_STEP_NM" size="30" class="cond-input-text" style="text-align:left" readonly="readonly" />
            	</div>
            </div>
        </div>
            <!-- <div class="cond-item">
            	<span><i class="fa fa-chevron-circle-right" ></i>&nbsp;RBA 실제 평가 기준년월  여부</span>
                <input type="text" name= "real_bas_yn" size="2" class="cond-input-text" style="text-align:left" readonly="readonly" />
            </div> -->
    </div>
    <div class="button-area">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
        	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"RBA003", defaultValue:"신규회차생성", mode:"C", function:"docopy", cssClass:"btn-36"}')}
        	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"updateBtn", defaultValue:"수정", mode:"U", function:"doModify", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"RBA001", defaultValue:"확정/취소", mode:"U", function:"doConfirm", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
       </div>

<div class="tab-content-bottom" style="margin-top: 8px;">
    <div id="GTDataGrid1_Area"></div>
</div>
    <div class="tab-content-bottom type1">
	    <div class="inner-top">
	        <div id="GTDataGrid3_Area" style="display: none;"></div>
	    </div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />