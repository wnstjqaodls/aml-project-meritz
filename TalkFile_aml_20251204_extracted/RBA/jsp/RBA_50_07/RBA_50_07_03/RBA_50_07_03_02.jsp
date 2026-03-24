<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_07_03_01.jsp
* Description     : RBA 위험평가결과 보고
* Group           : GTONE, R&D센터/개발2본부
* Author          : 정성원
* Since           : 2019-04-03
********************************************************************************************************************************************
--%>
<%@ page import="java.text.ParseException" %>
<%@page import="java.util.Locale"%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<% 
	String Date = "";
	try{
	Date = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
	}catch(ParseException e){
		Log.logAML(Log.ERROR, e);
    }
	request.setAttribute("Date",Date);
%>

<script>
    var GridObj1;
    var GridObj2;
    var GridObj3;
    var GridObj4;
    
    var tabID   = 0;
    var pageID  = "RBA_50_07_03_02";
    var classID = "RBA_50_07_03_02";
    var overlay = new Overlay();

    var intervalResult = "";
        
    /** Initialize */
    $(document).ready(function(){
    	 setupGrids();
    	 setupGrids2();
    	 setupGrids3();
    	 setupGrids4();
    	 setupFilter("init");
         setupFilter2("init");
         setupFilter3("init");
         setTimeout('doSearch()', 1000);
    }); 

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";    	
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }

    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridArrs[1] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }

    function setupFilter3(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid3_Area";
    	gridArrs[2] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    
 	function setupGrids() { 

 		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
 			elementAttr: { class: "grid-table-type" },
 	    	gridId : "GTDataGrid1",	
 	    	width	:"100%",
 	    	height :"300px",
 	    	useAuthYN : '${outputAuth.USE_YN}',
 	    	hoverStateEnabled    : true,
 	       wordWrapEnabled      : false,
 	       allowColumnResizing  : true,
 	       columnAutoWidth      : true,
 	       allowColumnReordering: true,
 	       cacheEnabled         : false,
 	       cellHintEnabled      : true,
 	       showBorders          : true,
 	       showColumnLines      : true,
 	       showRowLines         : true,
 	       sorting              : {mode: "multiple"},
 	       remoteOperations     : {
 	           filtering: false,
 	           grouping : false,
 	           paging   : false,
 	           sorting  : false,
 	           summary  : false
 	       },
 	       editing: {
 	           mode         : "batch",
 	           allowUpdating: false,
 	           allowAdding  : false,
 	           allowDeleting: false
 	       },
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
 			            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${msgel.getMsg('RBA_50_07_03_02_112','AML 업무 프로세스 상위 Top10 RBA 총 위험평가 내역')}.xlsx");
 			        });
 			    });
 			    e.cancel = true;
 	        },
 	       filterRow            : {visible: false},
		   onToolbarPreparing   : makeToolbarButtonGrids,
 	       rowAlternationEnabled: false,
 	       columnFixing         : {enabled: true},
 	      pager: {
 	         visible: true,
 	         showNavigationButtons: true,
 	         showInfo: true
 	     },
 	     paging: {
 	         enabled: true,
 	         pageSize: 20
 	     },
 	     scrolling: {
 	         mode: "standard",
 	         preloadEnabled: false
 	     },
 	       onCellPrepared       : function(e){
 	           var columnName = e.column.dataField;
 	           var dataGrid   = e.component;
 	           var rowIndex   = dataGrid.getRowIndexByKey(e.key);
 	           
 	           var remdrRskGdC       = dataGrid.cellValue(rowIndex, 'REMDR_RSK_GD_C_NM'); 
 	           
 	           if(rowIndex != -1){
 	                  if((remdrRskGdC =='Red') && (columnName == 'REMDR_RSK_GD_C_NM')){
 	                      e.cellElement.css('background-color', '#FF4848');
 	                  }
 	                  if((remdrRskGdC =='Yellow') && (columnName == 'REMDR_RSK_GD_C_NM')){
 	                      e.cellElement.css('background-color', 'yellow');
 	                  }
 	                  if((remdrRskGdC =='Green') && (columnName == 'REMDR_RSK_GD_C_NM')){
 	                      e.cellElement.css('background-color', 'green');
 	                  }
 	                   
 	           }
 	       },
 	       searchPanel : {visible: false, width  : 250},
 	       selection: {allowSelectAll : true, deferred : false, mode : "single", selectAllMode : "allPages", showCheckBoxesMode: "onClick"},
 	       columns: [
 	           {dataField : "NUM", caption : 'No.', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true, width : "10%",
 	               cellTemplate : function (cellElement, cellInfo) {
 	             		if(cellInfo.data){
 	              			cellElement.append($("<span style='font-weight:bold;'>").text(cellInfo.data.NUM)).append("</span>");
 	          			}
 	          		}
 	           }, 
 	           {dataField : "BAS_YYMM", caption : '${msgel.getMsg("RBA_50_08_07_001","기준년월")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true, width : "10%"}, 
 	           {dataField : "DUE", caption : '${msgel.getMsg("RBA_50_07_03_02_100","평가 대상 기간")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true}, 
 	           {dataField : "BRNO", caption : '${msgel.getMsg("RBA_50_07_03_02_101","평가 참여 부서수")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true}, 
 	           		{caption: '${msgel.getMsg("RBA_50_06_01_02_109","평균")}',
 	   		   			columns: [
				 	   			   		{dataField : "RSK_VALT_PNT", 		caption : '${msgel.getMsg("RBA_50_05_03_01_017","위험점수")}', alignment    : "center", allowResizing: true, allowSearch  : true, allowSorting : true}, 
				 	   			   		{dataField : "TONGJE_VALT_PNT", 	caption : '${msgel.getMsg("RBA_50_70_02_02_017","통제위험점수")}',  alignment    : "center", allowResizing: true, allowSearch  : true, allowSorting : true} 
		 	   		    			]
 	   	   	 		}, 
 	           {dataField : "REMDR_RSK_PNT", caption : '${msgel.getMsg("RBA_50_70_02_02_044","잔여위험점수")}', alignment : "center",  allowResizing: true, allowSearch  : true, "dataType": "number", allowSorting : true},
 	           {dataField : "REMDR_RSK_GD_C_NM", caption : '${msgel.getMsg("RBA_50_70_02_02_019","잔여위험등급")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true}, 
 	           {dataField : "BEFORE_REMDR_RSK_PNT", caption : '${msgel.getMsg("RBA_50_07_03_02_102","전월잔여점수")}', alignment : "center", allowResizing: true, allowSearch  : true, "dataType": "number", allowSorting : true}, 
 	           {dataField : "DIFFER", caption : '${msgel.getMsg("RBA_50_07_03_02_103","변화량")}', alignment    : "center", allowResizing: true, allowSearch  : true, "dataType": "number", allowSorting : true}
 	       ],
 	       onCellClick: function(e){
 	       }
 	   }).dxDataGrid("instance");

 	}
 	
 	function setupGrids2(){
 	    	
 		GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
 			elementAttr: { class: "grid-table-type" },
 	    	gridId : "GTDataGrid2",	
 	    	width	:"100%",
 	    	height :"300px",
 	    	useAuthYN : '${outputAuth.USE_YN}',
 	    	hoverStateEnabled    : true,
 	       wordWrapEnabled      : false,
 	       allowColumnResizing  : true,
 	       columnAutoWidth      : true,
 	       allowColumnReordering: true,
 	       cacheEnabled         : false,
 	       cellHintEnabled      : true,
 	       showBorders          : true,
 	       showColumnLines      : true,
 	       showRowLines         : true,
 	       sorting              : {mode: "multiple"},
 	       remoteOperations     : {
 	           filtering: false,
 	           grouping : false,
 	           paging   : false,
 	           sorting  : false,
 	           summary  : false
 	       },
 	       editing: {
 	           mode         : "batch",
 	           allowUpdating: false,
 	           allowAdding  : false,
 	           allowDeleting: false
 	       },
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
 			            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${msgel.getMsg('RBA_50_07_03_02_113','RBA 위험평가 주요 5개 지점별 상세내역')}.xlsx");
 			        });
 			    });
 			    e.cancel = true;
 	        },
 	       filterRow            : {visible: false},
		   onToolbarPreparing   : makeToolbarButtonGrids,
 	       rowAlternationEnabled: false,
 	       columnFixing         : {enabled: true},
 	      pager: {
 	         visible: true,
 	         showNavigationButtons: true,
 	         showInfo: true
 	     },
 	     paging: {
 	         enabled: true,
 	         pageSize: 20
 	     },
 	     scrolling: {
 	         mode: "standard",
 	         preloadEnabled: false
 	     },
 	       onCellPrepared       : function(e){
 	           var columnName = e.column.dataField;
 	           var dataGrid   = e.component;
 	           var rowIndex   = dataGrid.getRowIndexByKey(e.key); 
 	           
 	           var remdrRskGdC1       = dataGrid.cellValue(rowIndex, 'REMDR_RSK_GD_C_NM1'); 
 	           var remdrRskGdC2       = dataGrid.cellValue(rowIndex, 'REMDR_RSK_GD_C_NM2'); 
 	           
 	           if(rowIndex != -1){
 	                  if((remdrRskGdC1 =='Red') && (columnName == 'REMDR_RSK_GD_C_NM1')){
 	                      e.cellElement.css('background-color', '#FF4848');
 	                  }
 	                  if((remdrRskGdC1 =='Yellow') && (columnName == 'REMDR_RSK_GD_C_NM1')){
 	                      e.cellElement.css('background-color', 'yellow');
 	                  }
 	                  if((remdrRskGdC1 =='Green') && (columnName == 'REMDR_RSK_GD_C_NM1')){
 	                      e.cellElement.css('background-color', 'green');
 	                  }
 	                   
 	           }
 	           
 	           if(rowIndex != -1){
 	                  if((remdrRskGdC2 =='Red') && (columnName == 'REMDR_RSK_GD_C_NM2')){
 	                      e.cellElement.css('background-color', '#FF4848');
 	                  }
 	                  if((remdrRskGdC2 =='Yellow') && (columnName == 'REMDR_RSK_GD_C_NM2')){
 	                      e.cellElement.css('background-color', 'yellow');
 	                  }
 	                  if((remdrRskGdC2 =='Green') && (columnName == 'REMDR_RSK_GD_C_NM2')){
 	                      e.cellElement.css('background-color', 'green');
 	                  } 
 	           }
 	            
 	       },
 	       searchPanel : {visible: false, width  : 250},
 	       selection: {allowSelectAll : true, deferred : false, mode : "single", selectAllMode : "allPages", showCheckBoxesMode: "onClick"},
 	       columns: [ 
 	    	   		{dataField : "NUM", caption : 'No.', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true, width : "10%",
 	   		            cellTemplate : function (cellElement, cellInfo) {
 	   		          		if(cellInfo.data){
 	   		           			cellElement.append($("<span style='font-weight:bold;'>").text(cellInfo.data.NUM)).append("</span>");
 	   		       			}
 	   		       		}
 	   		        },
 	   		        {dataField : "BAS_YYMM", caption: '${msgel.getMsg("RBA_50_07_03_02_106","최근회차")}',
 	   	    			columns: [ 
 	   						        {dataField : "VALT_BRNO", caption : '지점', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true, visible : false},
 	   						        {dataField : "DPRT_NM",    caption : '${msgel.getMsg("RBA_50_07_03_02_104","지점")}', alignment    : "center", allowResizing: true, allowSearch  : true, allowSorting : true},
 	   						        {dataField : "RSK_VALT_PNT", caption : '${msgel.getMsg("RBA_50_70_02_02_015","총위험점수")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true},
 	   						        {dataField : "TONGJE_VALT_PNT", caption : '${msgel.getMsg("RBA_50_05_03_01_018","통제점수")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true},
 	   						        {caption: '${msgel.getMsg("RBA_50_07_02_01_100","잔여위험")}',
 	   							    	columns: [
 	   								    			 {dataField : "REMDR_RSK_PNT", 			caption : '${msgel.getMsg("RBA_50_05_01_01_104","점수")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true},
 	   								    			 {dataField : "REMDR_RSK_GD_C_NM1",	caption : '${msgel.getMsg("RBA_50_05_04_010","등급")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true}
 	   							    			 	]
 	   				    			} 
 	   						      ]
 	   				},
 	   				{dataField : "BAS_YYMM2", caption: '${msgel.getMsg("RBA_50_07_03_02_105","직전회차")}',
 	   	    			columns: [ 
 	   						        {dataField : "VALT_BRNO2", caption : '지점', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true, visible : false},
 	   						        {dataField : "DPRT_NM2", caption : '${msgel.getMsg("RBA_50_07_03_02_104","지점")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true},
 	   						        {dataField : "RSK_VALT_PNT2", caption : '${msgel.getMsg("RBA_50_70_02_02_015","총위험점수")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true},
 	   						        {dataField : "TONGJE_VALT_PNT2", caption : '${msgel.getMsg("RBA_50_05_03_01_018","통제점수")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true},
 	   						        {caption: '${msgel.getMsg("RBA_50_07_02_01_100","잔여위험")}',
 	   							    	columns: [
 	   								    			 {dataField : "REMDR_RSK_PNT2", caption : '${msgel.getMsg("RBA_50_05_01_01_104","점수")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true},
 	   								    			 {dataField : "REMDR_RSK_GD_C_NM2", caption : '${msgel.getMsg("RBA_50_05_04_010","등급")}', alignment : "center", allowResizing: true, allowSearch  : true, allowSorting : true}
 	   							    			 	]
 	   				    			} 
 	   						      ]
 	   				} 
 	   	],
 	       onCellClick: function(e){
 	       }
 	   }).dxDataGrid("instance");
 	}    	
 	
 	function setupGrids3(){

 		GridObj3 = $("#GTDataGrid3_Area").dxDataGrid({
 			elementAttr: { class: "grid-table-type" },
 	    	gridId : "GTDataGrid3",	
 	    	width	:"100%",
 	    	height :"300px",
 	    	useAuthYN : '${outputAuth.USE_YN}',
 	    	hoverStateEnabled    : true,
 	       wordWrapEnabled      : false,
 	       allowColumnResizing  : true,
 	       columnAutoWidth      : true,
 	       allowColumnReordering: true,
 	       cacheEnabled         : false,
 	       cellHintEnabled      : true,
 	       showBorders          : true,
 	       showColumnLines      : true,
 	       showRowLines         : true,
 	       sorting              : {mode: "multiple"},
 	       remoteOperations     : {
 	           filtering: false,
 	           grouping : false,
 	           paging   : false,
 	           sorting  : false,
 	           summary  : false
 	       },
 	       editing: {
 	           mode         : "batch",
 	           allowUpdating: false,
 	           allowAdding  : false,
 	           allowDeleting: false
 	       },
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
 			            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${msgel.getMsg('RBA_50_07_03_02_107','ML/TF위험지표')}.xlsx");
 			        });
 			    });
 			    e.cancel = true;
 	        },
 	       filterRow            : {visible: false},
		   onToolbarPreparing   : makeToolbarButtonGrids,
 	       rowAlternationEnabled: false,
 	       columnFixing         : {enabled: true},
 	      pager: {
 	         visible: true,
 	         showNavigationButtons: true,
 	         showInfo: true
 	     },
 	     paging: {
 	         enabled: true,
 	         pageSize: 20
 	     },
 	     scrolling: {
 	         mode: "standard",
 	         preloadEnabled: false
 	     },
 	       onCellPrepared       : function(e){
 	           var columnName = e.column.dataField;
 	           var dataGrid   = e.component;
 	           var rowIndex   = dataGrid.getRowIndexByKey(e.key); 
 	            
 	       },
 	       searchPanel : {visible: false, width  : 250},
 	       selection: {allowSelectAll : true, deferred : false, mode : "single", selectAllMode     : "allPages", showCheckBoxesMode: "onClick"},
 	       columns: [
 	           {dataField    : "RSK_INDCT", caption      : '${msgel.getMsg("RBA_50_07_03_02_107","ML/TF위험지표")}',  alignment    : "center", allowResizing: true, allowSearch  : true, allowSorting : true}, 
 	           {dataField    : "RSK_INDCT_NM", caption      : '${msgel.getMsg("RBA_50_07_03_02_107","ML/TF위험지표")}', alignment    : "center", allowResizing: true, allowSearch  : true, allowSorting : true}, 
 	           {caption: '${msgel.getMsg("RBA_50_07_03_02_108","월 평균 발생 건수")}',
 	   		   	columns: [
 	   			   				{dataField    : "CNT", caption      : '${msgel.getMsg("RBA_50_07_03_02_106","최근회차")}', alignment    : "center", allowResizing: true, allowSearch  : true, allowSorting : true}, 
 	   			   				{dataField    : "CNT2", caption      : '${msgel.getMsg("RBA_50_07_03_02_105","직전회차")}', alignment    : "center", allowResizing: true, allowSearch  : true, allowSorting : true} 
 	   		        
 	   		    			 ]
 	   	    	}, 
 	           {dataField    : "DIFFER", caption      : '${msgel.getMsg("RBA_50_07_03_02_103","변화량")}', alignment    : "center", allowResizing: true, allowSearch  : true, allowSorting : true} 
 	       ],
 	       onCellClick: function(e){
 	       }
 	   }).dxDataGrid("instance");
 	    	
 	}
 	
 	function setupGrids4(){

 		GridObj4 = $("#GTDataGrid4_Area").dxDataGrid({
 			elementAttr: { class: "grid-table-type" },
 	    	gridId : "GTDataGrid4",	
 	    	width	:"100%",
 	    	height :"300px",
 	    	useAuthYN : '${outputAuth.USE_YN}',
 	    	hoverStateEnabled    : true,
 	       wordWrapEnabled      : false,
 	       allowColumnResizing  : true,
 	       columnAutoWidth      : true,
 	       allowColumnReordering: true,
 	       cacheEnabled         : false,
 	       cellHintEnabled      : true,
 	       showBorders          : true,
 	       showColumnLines      : true,
 	       showRowLines         : true,
 	       sorting              : {mode: "multiple"},
 	       remoteOperations     : {
 	           filtering: false,
 	           grouping : false,
 	           paging   : false,
 	           sorting  : false,
 	           summary  : false
 	       },
 	       editing: {
 	           mode         : "batch",
 	           allowUpdating: false,
 	           allowAdding  : false,
 	           allowDeleting: false
 	       },
 	       export : {
 	           allowExportSelectedData : true
 	          ,enabled                 : false
 	          ,excelFilterEnabled      : true
 	          ,fileName                : ""
 	       },
 	       filterRow            : {visible: false},
 	       rowAlternationEnabled: false,
 	       columnFixing         : {enabled: true},
 	      pager: {
 	         visible: true,
 	         showNavigationButtons: true,
 	         showInfo: true
 	     },
 	     paging: {
 	         enabled: true,
 	         pageSize: 20
 	     },
 	     scrolling: {
 	         mode: "standard",
 	         preloadEnabled: false
 	     },
 	       onCellPrepared       : function(e){
 	           var columnName = e.column.dataField;
 	           var dataGrid   = e.component;
 	           var rowIndex   = dataGrid.getRowIndexByKey(e.key); 
 	            
 	       },
 	       searchPanel          : {
 	           visible: false,
 	           width  : 250
 	       },
 	       selection: {
 	           allowSelectAll    : true,
 	           deferred          : false,
 	           mode              : "single",
 	           selectAllMode     : "allPages",
 	           showCheckBoxesMode: "onClick"
 	       },
 	       columns: [ 
						{dataField : "BAS_YYMM", caption : 'BAS_YYMM', alignment : "left", allowResizing: true, allowSearch  : true, allowSorting : true},
		 	            {dataField : "IMPRV_RSLT_CTNT", caption : 'IMPRV_RSLT_CTNT', alignment    : "left", allowResizing: true, allowSearch  : true, allowSorting : true},
						{dataField : "FILE_POS", caption : 'FILE_POS', alignment : "left", allowResizing: true, allowSearch  : true, allowSorting : true},
						{dataField : "FILE_NAME", caption : 'FILE_NAME', alignment : "left", allowResizing: true, allowSearch  : true, allowSorting : true},
						{dataField : "FILE_EXIST", caption : 'FILE_EXIST', alignment : "left", allowResizing: true, allowSearch  : true, allowSorting : true},
	 	       			],
 	       onCellClick: function(e){
 	       }
 	   }).dxDataGrid("instance");
 	} 	 
 	 
    
    function doSearch(){
        overlay.show(true, true); 
        doSearch1(); 
    }
    
    function doSearch1(){ 
        
         overlay.show(true, true);
    	 var params = new Object();
         var methodID = "doSearch1";
         params.pageID = pageID;
         params.BAS_YYMM = form.BAS_YYMM.value;
         params.Date = form.Date.value;

         sendService(classID, methodID, params, doSearch_end1, doSearch_end1);
    } 
    
    function doSearch_end1(gridData) {  
    	overlay.hide(); 
    	GridObj1.refresh();
        GridObj1.option("dataSource", gridData);
    	doSearch2();
    }  

    function doSearch2(){ 

    	overlay.show(true, true);
   	 	var params = new Object();
        var methodID = "doSearch2";
        params.pageID = pageID;
        params.BAS_YYMM = form.BAS_YYMM.value;
        params.Date = form.Date.value;
        
        sendService(classID, methodID, params, doSearch_end2, doSearch_end2);
    }
    
    
    function doSearch_end2(gridData) { 
    	overlay.hide();
    	GridObj2.refresh();
        GridObj2.option("dataSource", gridData);
    	doSearch3();
    }
    	
    
    function doSearch3(){ 
    	
    	overlay.show(true, true);
   	 	var params = new Object();
        var methodID = "doSearch3";
        params.pageID = pageID;
        params.BAS_YYMM = form.BAS_YYMM.value;
        params.Date = form.Date.value;
        
        sendService(classID, methodID, params, doSearch_end3, doSearch_end3);
    }
    
    function doSearch_end3(gridData) { 
    	GridObj3.refresh();
    	GridObj3.option("dataSource", gridData);
    	doSearch4();
    	initChart1();
    	overlay.hide();
    }  
    
    function doSearch4(){ 
    	
    	overlay.show(true, true);
   	 	var params = new Object();
        var methodID = "doSearch4";
        params.pageID = pageID;
        params.BAS_YYMM = form.BAS_YYMM.value;
        
        sendService(classID, methodID, params, doSearch_end4, doSearch_end4);
    } 
    
    function doSearch_end4(gridData) {  
    	GridObj4.refresh();
    	GridObj4.option("dataSource", gridData);
    	
    	var selObj = gridData;
    	var gridCnt   = selObj.length; 
    	
    	var selObj2 = gridData[0];
    	
    	if(selObj[0].FILE_EXIST=="N"){
    		form.existFile.value = 'N';
            form.existFile.style.color = 'red';
    	}else{
    		form.existFile.value = 'Y';
            form.existFile.style.color = 'blue';
    	}
    	
        if(gridCnt>0) {
            jQuery("#IMPRV_RSLT_CTNT").html(selObj2.IMPRV_RSLT_CTNT); 
        } else {
            jQuery("#IMPRV_RSLT_CTNT").text(""); 
        }
        overlay.hide();  
    }
    
    function initChart1(){ 
    	var url;
    	url = "/0001.do?pageID=RBA_50_07_03_chart4";
    	form2.BAS_YYMM.value = form.BAS_YYMM.value;
		form2.action = url;
		form2.target = 'Chart1_Area'; 
		form2.submit(); 
    } 
    
    function doExcelMake() { 
    	if (form.existFile.value == 'Y') {

    		showConfirm("${msgel.getMsg('RBA_50_07_03_02_109','이미 생성된 파일이 존재합니다. 계속 진행하겠습니까?')}","파일생성",function(){
    			var BAS_YYMM = form.BAS_YYMM.value;
    	    	var BAS_YYMM2 = form.Date.value;
    	    	    	       
    	    	overlay.show(true, true);
    	   	 	var params = new Object();
    	        var methodID = "makeExcelFile";
    	        params.pageID = pageID;
    	        params.BAS_YYMM = BAS_YYMM;
    	        params.BAS_YYMM2 = BAS_YYMM2;
    	    	params.IMPRV_RSLT_CTNT = form.IMPRV_RSLT_CTNT.value ;
    	        
    	        sendService(classID, methodID, params, doExcelMake_end, doExcelMake_end);
    		});
    	}else{
    		showConfirm("${msgel.getMsg('RBA_50_07_03_02_110','보고파일을 생성 하시겠습니까 ? 생성시간은 20 ~ 30분 소요됩니다.')}","파일생성",function(){
    	    	var BAS_YYMM = form.BAS_YYMM.value;
    	    	var BAS_YYMM2 = form.Date.value;
    	    	var IMPRV_RSLT_CTNT = form.IMPRV_RSLT_CTNT.value ;

    	    	overlay.show(true, true);
    	   	 	var params = new Object();
    	        var methodID = "makeExcelFile";
    	        params.pageID = pageID;
    	        params.BAS_YYMM = BAS_YYMM;
    	        params.BAS_YYMM2 = BAS_YYMM2;
    	    	params.IMPRV_RSLT_CTNT = form.IMPRV_RSLT_CTNT.value ;
    	        
    	        sendService(classID, methodID, params, doExcelMake_end, doExcelMake_end);
        	});	
    	}
    }
    
    
    function doExcelMake_end() {
    	showAlert("${msgel.getMsg('RBA_50_07_03_002','엑셀 파일생성이 완료되었습니다.')}","INFO");
    	doSearch();
    }
    
    function doExcelDown() {
    	if (form.existFile.value == 'N') {
    		showAlert("${msgel.getMsg('RBA_50_07_03_003','선택하신 평가기준월은 보고파일생성 후에 다운로드가 가능합니다.')}","WARN");
    		return;
    	}
    	
    	var url  = "<c:url value='/'/>0001.do?pageID=RBA_50_07_03_02_ExcelFileDownload";
    	form2.BAS_YYMM.value	= form.BAS_YYMM.value;
    	form2.BAS_YYMM2.value	= form.Date.value;
		form2.action 			= url;
		form2.target 			= '_self';
		form2.method    		= "post";  
		form2.submit();
    }
    
    function doSave() {
    	if (form.IMPRV_RSLT_CTNT.value == "" || form.IMPRV_RSLT_CTNT.value == null) {
    		showAlert('${msgel.getMsg("RBA_50_07_03_02_111","결과 분석 및 개선 방향을 입력하십시오.")}', "WARN");
			form.IMPRV_RSLT_CTNT.focus();
			return ;
			
		}
    	
    	overlay.show(true, true);
   	 	var params = new Object();
        var methodID = "doSave";
        params.pageID = pageID;
        params.BAS_YYMM = form.BAS_YYMM.value;
        params.IMPRV_RSLT_CTNT = form.IMPRV_RSLT_CTNT.value ;
        
        sendService(classID, methodID, params, doSave_end, doSave_end);
        
    }
    
    function doSave_end() {
    	doSearch();
    }

 // [ make ]
    var saveitemobj;
	    /** 툴바 버튼 설정 */
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
							if(gridID=="GTDataGrid1_Area"){
								setupFilter();
							} else if(gridID=="GTDataGrid2_Area") {
								setupFilter2();
							} else {//gridID=="GTDataGrid3_Area"
								setupFilter3();
							}
	                    }
	             }
	        });
	        var btnLastIndex=0;
	        for(;btnLastIndex<toolbarItems.length; btnLastIndex++){
	            if(toolbarItems[btnLastIndex].widget != "dxButton") {
	                break;
	            }
	        }
	    }
	}

</script>

<form name="form2" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="BAS_YYMM">
    <input type="hidden" name="BAS_YYMM2">
    <input type="hidden" name="GRID_CNT">
</form>

<form name="form">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID"> 
    <input type="hidden" name="FY1"> 
    <input type="hidden" name="FY2"> 
    <input type="hidden" name="FY3"> 
 
    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row" style="width:17%;">
            <div class="table-cell">
	            ${condel.getLabel('RBA_50_03_01_020','보고일자')}
				<div class="content">
					<input type="text" class="cond-input-text" name=Date value="${Date}" style="border: 0px;" readonly="readonly" />
				</div>
	        </div>	       
	    </div>
	    <div class="table-row" style="width:25%;">
	    	<div class="table-cell">
		    	${condel.getLabel('RBA_50_10_01_01_001','기준년월')}
				<div class="content">
					<RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="Y" eventFunction='doSearch()'/>
				</div>
            </div>
	    </div>
	    <div class="table-row" style="width:58%;">
	    	<div class="table-cell">
	    		${condel.getLabel('RBA_50_07_03_001','보고파일생성여부')}
				<div class="content">
					<input name="existFile" id="existFile" type="text" style="text-align:center" class="cond-input-text" size="3" readonly />
				</div>
            </div>
	    </div>
	</div>
    <div class="button-area" style="text-align:right">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"excelMakeBtn", defaultValue:"보고파일생성", mode:"C", function:"doExcelMake", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"excelDownBtn", defaultValue:"보고파일다운로드", mode:"C", function:"doExcelDown", cssClass:"btn-36"}')}
	</div>
	
	<div class="tab-content-bottom">
		<table class="basic-table" style="width:100%; margin-top: 8px; table-layout:fixed">
			<tr>
				<th align="left"><b>1.${msgel.getMsg('RBA_50_07_03_02_200','RBA 위험평가 수행 내역')} </b></th>
			</tr>
			<tr>
				<td>
					- <span style="color:blue"> NO</span> : ${msgel.getMsg('RBA_50_07_03_02_201','"보고서 생성일자"의 보고년월("YYYY.MM) 기준 1년 동안의 RBA 평가 결과를 조회함')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_07_03_02_202','평가대상기간')}</span> : ${msgel.getMsg('RBA_50_07_03_02_203','RBA 위험평가 거래 기간 (예: 반기 1회 RBA 위험평가 수행 시, 6개월의 거래결과 합산)')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_07_03_02_204','평가참여부서수')}</span> : ${msgel.getMsg('RBA_50_07_03_02_205','RBA 위험평가 시 "위험평가"와 "통제평가"에 참여했던 전체 부서 수 (지점10 + 본사2 : 예시 DATA 참조)')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_07_03_02_206','위험점수 (전사 평균)')}</span> : ${msgel.getMsg('RBA_50_07_03_02_207','전체 부서의 프로세스 별 위험점의 평균 점수')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_07_03_02_208','통제위험점수 (전사 평균)')}</span> : ${msgel.getMsg('RBA_50_07_03_02_209','전체 부서의 프로세스 별 통제점수의 평균 점수')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_70_02_02_044','잔여위험점수')}</span> : ${msgel.getMsg('RBA_50_07_03_02_210','위험점수 × 통제점수 ÷ 100')} <br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_05_03_01_020','잔여위험등급')} </span>: ${msgel.getMsg('RBA_50_07_03_02_211','70 이상 "RED" , 40 이상 "YELLOW" , 40미만 "GREEN"')}
					${msgel.getMsg('RBA_50_07_03_02_212','(단, RBA 위험평가 등급 관리에서 기준 임계치 변경할 경우 달라질 수 있음)')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_07_03_02_103','변화량')}</span> : ${msgel.getMsg('RBA_50_07_03_02_213','이전 RBA 평가회차의 잔여위험 점수 변화 표시')}
					${msgel.getMsg('RBA_50_07_03_02_214','(단, 상승 혹은 하락의 서식 및 색상 변경은 시스템 지원 기능 수준에 따라 변경 될 수 있음)')}  <br>
				</td>
			</tr>
		</table>
		<div id="GTDataGrid1_Area" style="width:94vw; margin-top: 8px;"></div>
		<table class="basic-table" style="width:100%; table-layout:fixed; margin-top: 8px;">
			<tr>
				<th colspan='11' align="left"><b>2. ${msgel.getMsg('RBA_50_07_03_02_215','RBA 위험평가 상세 결과 요약')} </b></th>
			</tr>
			<tr>
				<th colspan='11' align="left"><b>2-1. ${msgel.getMsg('RBA_50_07_03_02_113','RBA 위험평가 주요 5개 지점별 상세내역')}</b></th>
			</tr>
			<tr>
				<td colspan='11'>
					- <span style="color:blue"> NO</span> : ${msgel.getMsg('RBA_50_07_03_02_216','"RBA 위험평가 수행내역"에 포함된 RBA 위험평가 최근 수행 회차의 잔여위험 점수가 높은 5개의 지점 결과 조회')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_08_05_02_002','지점명')}</span> : ${msgel.getMsg('RBA_50_08_05_02_002','지점명')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_05_03_01_017','위험점수')}</span> : ${msgel.getMsg('RBA_50_07_03_02_217','지점의 AML 업무 프로세스 別 위험점수의 평균')}<br> 
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_07_03_02_208','통제위험점수 (전사 평균)')}</span> : ${msgel.getMsg('RBA_50_07_03_02_218','지점의 AML 업무 프로세스 別 통제점수의 전체 평균')}<br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_70_02_02_044','잔여위험점수')}</span> : ${msgel.getMsg('RBA_50_07_03_02_210','위험점수 × 통제점수 ÷ 100')} <br>
					- <span style="color:blue"> ${msgel.getMsg('RBA_50_05_03_01_020','잔여위험등급')} </span>: ${msgel.getMsg('RBA_50_07_03_02_211','70 이상 "RED" , 40 이상 "YELLOW" , 40미만 "GREEN"')}
					${msgel.getMsg('RBA_50_07_03_02_212','(단, RBA 위험평가 등급 관리에서 기준 임계치 변경할 경우 달라질 수 있음)')}<br>
					- <span style="color:blue">${msgel.getMsg('RBA_50_07_03_02_103','변화량')}</span> : ${msgel.getMsg('RBA_50_07_03_02_213','이전 RBA 평가회차의 잔여위험 점수 변화 표시')}
					${msgel.getMsg('RBA_50_07_03_02_214','(단, 상승 혹은 하락의 서식 및 색상 변경은 시스템 지원 기능 수준에 따라 변경 될 수 있음)')}  <br>
				</td>
			</tr>
		</table> 
		<div id="GTDataGrid2_Area" style="width:94vw; margin-top: 8px;"></div>
		<table class="basic-table" style="width:100%; margin-top:8px; margin-bottom:0px;">
			<tr>
				<th align="left"><b>2-2. ${msgel.getMsg('RBA_50_07_03_02_219','Enterprise-wide ML/TF Risk Indicator incidence')} </b></th>
			</tr>
			<tr>
				<td>
					- <span style="color:blue">${msgel.getMsg('RBA_50_07_03_02_107','ML/TF위험지표')}</span> : ${msgel.getMsg('RBA_50_07_03_02_220','"RBA 위험평가" 수행 시 Batch 수행 된 위험지표 (RI: Risk Indicator) 전체 목록')}<br>
					- <span style="color:blue">${msgel.getMsg('RBA_50_07_03_02_108','월 평균 발생 건수')}</span>: ${msgel.getMsg('RBA_50_07_03_02_221','KRI 화면 內 조회되는 ML/TF 위험지표 別 전사 발생 건수의 RBA 위험평가 회차별 평균')}<br> 
					- <span style="color:blue">${msgel.getMsg('RBA_50_07_03_02_103','변화량')} </span>: ${msgel.getMsg('RBA_50_07_03_02_213','이전 RBA 평가회차의 잔여위험 점수 변화 표시')} <br> 
					- <span style="color:blue">${msgel.getMsg('RBA_50_07_03_02_223','차트')} </span>: ${msgel.getMsg('RBA_50_07_03_02_222','관련된 내용을 차트로 표기 (차트의 서식 및 색상은 시스템 지원 기능 수준에 따라 변경 될 수 있음)')}<br>
				</td>
			</tr>
		</table>
		<div id="GTDataGrid3_Area" style="width:94vw; margin-top: 8px;"></div> 
		<table class="basic-table" style="width:100%; table-layout:fixed; margin-top: 8px;"> 
			<tr>
				<th align="left" ><b>2-3. ${msgel.getMsg('RBA_50_07_03_02_224','전사 자금세탁 위험요소(ML/TF Risk Indicator) 발생 현황 그래프')} </b></th>
			</tr>
		</table>
		<div class="table-box" style="margin-top:8px">
			<iframe name="Chart1_Area" width="96%" height="380px;"></iframe>
		</div>
		<table class="basic-table" style="width:100%; table-layout:fixed; margin-top: 8px;">
			<tr>
				<th align="left"><b>3. ${msgel.getMsg('RBA_50_07_03_02_225','결과 분석 및 개선 방향')} </b></th>
			</tr>
			<tr>
				<td>
					- ${msgel.getMsg('RBA_50_07_03_02_226','전사의 RBA 위험평가 "잔여위험 점수 및 등급" 결과에 대한 추이 분석 결과')} <br>
					- ${msgel.getMsg('RBA_50_07_03_02_227','지점 別 "위험평가" , "통제평가" 현황 및 개선방안 제출 내용에 관한 요약 기술')}<br>
					- ${msgel.getMsg('RBA_50_07_03_02_228','최근 1년간, 위험한 거래 요인에 대한 준법감시팀의 관점 및 대응 계획 기술')}
				</td> 
			</tr> 
		</table>
		<table class="basic-table" style="width:100%; table-layout:fixed">
			<tr>
				<td>
					<textarea class="textarea-box" id="IMPRV_RSLT_CTNT" rows="5"></textarea>
				</td>
 			</tr>
		</table>
	</div>
	<div class="tab-content-bottom" style="visibility:hidden;">
		<div id="GTDataGrid4_Area" style="display:none;"></div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />