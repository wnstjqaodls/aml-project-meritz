<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_02_01.jsp
* Description     : 통제 평가
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-05-14
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    request.setAttribute("ROLE_IDS",ROLE_IDS);
    
    String BRCD = sessionAML.getsAML_BDPT_CD();
    request.setAttribute("BRCD",BRCD);
%>
<style>
.table-box11 {
    margin  : 0;
    padding : 1px;
    display : inline-table;
    width   : 100%;
}
.table-box11 table{
    outline : 1px solid #CCCCCC;
    width   : 100%;
}
.table-box11 table tr+tr{
    border-top : 1px solid #CCCCCC;
}

.table-box11 table tr th{
    border-right    : 1px solid #CCCCCC;
    padding         : 5px 5px;
    background-color: #F3F6FC;
    font-weight     : 700;
    vertical-align  : top;
}
.table-box11 table tr td {
    padding : 5px 5px;
    border-right    : 1px solid #CCCCCC;
}
.title-text {
    padding : 5px 5px;
    font-size: 22px;
    color : black;
    border : 0px;
  }
</style>
<script>
    var GridObj1;
    var GridObj2;
    var GridObj3;
    var GridObj4;
    var GridObj5;
    var GridObj6;
    
    var tabID   = 0;
    var pageID  = "RBA_50_10_01_01";
    var classID = "RBA_50_10_01_01";
    var overlay = new Overlay();
    var BRCD =  '${BRCD}';
    
    /** Initialize */
    $(document).ready(function(){

    	var BAS_YYMM = parent.getMainsParams("BAS_YYMM"); 
    	doSearch();
    });
    
    function initAllGrid()
    {
/*     	initFirstTab ();
    	setupGrids();
    	setupGrids2();
    	setupGrids3();
    	setupGrids4();
    	setupGrids5();
    	setupGrids6();
    	
    	setupFilter("init");
    	setupFilter2("init"); */
    	doSearch();
    }
    
    function initFirstTab () {
    	$('#brnoChk').css("display","none");
        $('#brnoChkAll').css("display","");
        $('#valtMeth').css("display","");
        $('#todolist_box').css("display","");
        $('#btn_07').css("display","");
        
        form.TO_DO_CHECK.checked = true;
        setButtonDisplay();

    }
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }

    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridArrs[1] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }
    
    function setupFilter3(FLAG){
    	var gridArrs = new Array();
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid3_Area";
    	gridArrs[2] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }

    function setupFilter4(FLAG){
    	var gridArrs = new Array();
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid4_Area";
    	gridArrs[3] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }     

    function setupFilter5(FLAG){
    	var gridArrs = new Array();
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid5_Area";
    	gridArrs[4] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }     

    function setupFilter6(FLAG){
    	var gridArrs = new Array();
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid6_Area";
    	gridArrs[5] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }               
    
    
    function setupGrids(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
    		height				 : "calc(75vh - 100px)",
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
    	    export               : {
    	        allowExportSelectedData: true,
    	        enabled                : true,
    	        excelFilterEnabled     : true,
    	        fileName               : "gridExport"
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
    	    editing: {
    	        mode         : "batch",
    	        allowUpdating: false,
    	        allowAdding  : false,
    	        allowDeleting: false
    	    },
    	    filterRow            : {visible: false},
    	    onToolbarPreparing   : makeToolbarButtonGrids,
    	    rowAlternationEnabled: false,
    	    paging               : {enabled: false},
    	    onCellPrepared       : function(e){
    	        var columnName = e.column.dataField;
    	        var dataGrid   = e.component;
    	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
    	        var realEdt       = dataGrid.cellValue(rowIndex, 'REAL_EDT');
    	        var valtEdt       = dataGrid.cellValue(rowIndex, 'VALT_EDT');
    	        if(rowIndex != -1){
    	            if(realEdt == ''){
    	                if((valtEdt !='') && (columnName == 'RBA_VALT_LGDV_C_NM' || columnName == 'RBA_VALT_SMDV_C_NM' || columnName == 'VALT_SDT' || columnName == 'VALT_EDT'
    	                    || columnName == 'REAL_EDT' || columnName == 'ROWNUM' || columnName == 'EXP_TRM')){
    	                    e.cellElement.css('background-color', '#FF4848');
    	                }
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
    	        mode              : "single",
    	        selectAllMode     : "allPages",
    	        showCheckBoxesMode: "onClick"
    	    },
    	    columns: [
    	        {
    	            dataField    : "VALT_BRNM",
    	            caption      : '${msgel.getMsg("RBA_50_05_01_019","부점명")}',
    	            alignment    : "left",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "90"
    	        }, {
    	            dataField    : "VALT_BRNO",
    	            caption      : '부점코드',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "0",
    	            visible      : false
    	        }, {
    	            dataField    : "VALT01",
    	            caption      : '${msgel.getMsg("RBA_50_05_01_01_101","대상건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "60"
    	        }, {
    	            dataField    : "VALT02",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_100","설계평가건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "80"
    	        }, {
    	            dataField    : "VALT03",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_101","운영평가건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "80"
    	        }, {
    	            dataField    : "VALT04",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_102","완료여부")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "60"
    	        }
    	    ],
    	    summary: {
    	        totalItems: [
    	            {
    	                column: "VALT_BRNM",
    	                summaryType: "count",
    	                valueFormat: "fixedPoint", 
    	                alignment: "center"
    	            }
    	        ],
    	        texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}
    	    },
    	    onCellClick: function(e){
    	        if(e.data){
    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	    }
    	    
    	}).dxDataGrid("instance");	
    }
    
    
    function setupGrids2(){
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
    		height				 : "calc(75vh - 100px)",
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
    	    export               : {
    	        allowExportSelectedData: true,
    	        enabled                : true,
    	        excelFilterEnabled     : true,
    	        fileName               : "gridExport"
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
    	    editing: {
    	        mode         : "batch",
    	        allowUpdating: false,
    	        allowAdding  : false,
    	        allowDeleting: false
    	    },
    	    filterRow            : {visible: false},
    	    onToolbarPreparing   : makeToolbarButtonGrids,
    	    rowAlternationEnabled: false,
    	    paging               : {enabled: false},
    	    onCellPrepared       : function(e){
    	        var columnName = e.column.dataField;
    	        var dataGrid   = e.component;
    	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
    	        var DSGN_VALT_PNT       = dataGrid.cellValue(rowIndex, 'DSGN_VALT_PNT');
    	        var TONGJE_VALD_PNT     = dataGrid.cellValue(rowIndex, 'TONGJE_VALD_PNT'); 
    	        if(rowIndex != -1){ 
    	        	/*if	dataField == "DSGN_VALT_PNT" && DSGN_VALT_PNT == '입력') { 
    	                e.column.alignment = "center" ;
    	                e.cellElement.css('background-color', '#FF4848'); 
    	                 
    	            }*/
    	        }
    	    },
    	    searchPanel: {
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
    	            {
    	            "caption": '${msgel.getMsg("RBA_50_05_02_01_103","내부통제평가지표")}',
    	            "alignment": "center",
    	            "columns" : [
    	            	{
    		               "dataField": "PROC_LGDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_011","코드1")}',
    		               "width" : 50,
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true 
    		            },{
    		               "dataField": "PROC_LGDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_020","대분류")}',
    		               "width" : 120,
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		            }, {
    		               "dataField": "PROC_MDDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_013","코드2")}',
    		               "width" : 60,
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true 
    		            }, {
    		               "dataField": "PROC_MDDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_021","중분류")}',
    		               "width" : 130,
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		            }, {
    		               "dataField": "PROC_SMDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_015","코드3")}',
    		               "width" : 80,
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true 
    		           }, {
    		               "dataField": "PROC_SMDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_022","소분류")}',
    		               "width" : "150",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		            }, {
    		               "dataField": "TONGJE_NO",
    		               "caption": '${msgel.getMsg("RBA_50_02_01_03_100","통제번호")}',
    		               "width" : "80",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true 
    		           	}, {
    		               "dataField": "TONGJE_ACT_TITE",
    		               "caption": '${msgel.getMsg("RBA_50_04_01_022","통제활동명")}',
    		               "width" : "120",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true,
    		           	}, {
    		               "dataField": "DSGN_VALT_PNT",
    		               "caption": '${msgel.getMsg("RBA_50_04_01_024","설계평가")}',
    		               "width" : "80", 
    		               "alignment": "center",
    		               "allowResizing": true,
    		               "allowSearch": true,
    	            	   "cssClass"    : "link",
    		               "allowSorting": true
    		           }, {
    		               "dataField": "TONGJE_VALD_PNT",
    		               "caption": '${msgel.getMsg("RBA_50_05_02_01_104","운영평가")}',
    		               "width" : "80",
    		               "alignment": "center",
    		               "allowResizing": true,
    		               "allowSearch": true,
    	            	   "cssClass"    : "link",
    		               "allowSorting": true
    		           } ,{
    			            "dataField": "VALT_BRNO",
    			            "caption": '부점',
    			            "width" : 100,
    			            "alignment": "center",
    			            "allowResizing": true,
    			            "allowSearch": true,
    			            "allowSorting": true,
    			            "visible"      : false
    			        },{
    			            "dataField": "VALT_BRNM",
    			            "caption": '부점명',
    			            "width" : 100,
    			            "alignment": "center",
    			            "allowResizing": true,
    			            "allowSearch": true,
    			            "allowSorting": true,
    			            "visible"      : false
    			        },{
    			            "dataField": "BAS_YYMM",
    			            "caption": '기준년월',
    			            "width" : 100,
    			            "alignment": "center",
    			            "allowResizing": true,
    			            "allowSearch": true,
    			            "allowSorting": true,
    			            "visible"      : false
    			        },{
    			            "dataField": "COMPLETE_YN",
    			            "caption": '${msgel.getMsg("RBA_50_05_02_01_102","완료여부")}',
    			            "width" : 80,
    			            "alignment": "center",
    			            "allowResizing": true,
    			            "allowSearch": true,
    			            "allowSorting": true 
    			        } 
    	    		]
    	    		}],
    		    summary: {
    		        totalItems: [
    		            {
    		                column: "PROC_LGDV_C",
    		                summaryType: "count",
    		                valueFormat: "fixedPoint", 
    		                alignment: "center"
    		            }
    		        ],
    		        texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}
    		    },
    		    onCellClick: function(e){
    		        if(e.data){
    		            Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    		        }
    		    }
    	}).dxDataGrid("instance");	
    }
    function setupGrids3(){
    	GridObj3 = $("#GTDataGrid3_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
    		height				 : "calc(72vh - 100px)",
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
    	    export               : {
    	        allowExportSelectedData: true,
    	        enabled                : true,
    	        excelFilterEnabled     : true,
    	        fileName               : "gridExport"
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
    	    editing: {
    	        mode         : "batch",
    	        allowUpdating: false,
    	        allowAdding  : false,
    	        allowDeleting: false
    	    },
    	    filterRow            : {visible: false},
    	    onToolbarPreparing   : makeToolbarButtonGrids,
    	    rowAlternationEnabled: false,
    	    paging               : {enabled: false},
    	    onCellPrepared       : function(e){
    	        var columnName = e.column.dataField;
    	        var dataGrid   = e.component;
    	        var rowIndex   = dataGrid.getRow 
    	    },
    	    searchPanel: {
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
    	            {
    	            "caption": '${msgel.getMsg("RBA_50_05_02_01_103","내부통제평가지표")}',
    	            "alignment": "center",
    	            "columns" : [
    	            	{
    		               "dataField": "PROC_LGDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_011","코드1")}',
    		               "width" : 50,
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true 
    		            },{
    	            	   "dataField": "PROC_LGDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_020","대분류")}',
    		               "width" : 100,
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           },{
    	            	   "dataField": "PROC_MDDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_013","코드2")}',
    		               "width" : 60,
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }, {
    		               "dataField": "PROC_MDDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_021","중분류")}',
    		               "width" : 100,
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           },{
    	            	   "dataField": "PROC_SMDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_015","코드3")}',
    		               "width" : 80,
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }, {
    		               "dataField": "PROC_SMDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_022","소분류")}',
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }, {
    		               "dataField": "TONGJE_NO",
    		               "caption": '${msgel.getMsg("RBA_50_02_01_03_100","통제번호")}',
    		               "width" : "80",
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }, {
    		               "dataField": "TONGJE_ACT_TITE",
    		               "caption": '${msgel.getMsg("RBA_50_04_01_022","통제활동명")}',
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }
    		           ]
    	        },  {
    	            "caption": '${msgel.getMsg("RBA_50_05_02_01_105","통제유효성 평가점수")}',
    	            "alignment": "center",
    	            "columns" : [
    	            	{
    		               "dataField": "DSGN_VALT_PNT",
    		               "caption": '${msgel.getMsg("RBA_50_05_02_01_106","설계점수")}',
    		               "dataType"     : "number",
    		               "alignment": "right",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }, {
    		               "dataField": "TONGJE_VALD_PNT",
    		               "caption": '${msgel.getMsg("RBA_50_05_02_01_107","운영점수")}',
    		               "dataType" : "number",
    		               "alignment": "right",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }, {
    		               "dataField": "LST_TONGJE_VALT_PNT",
    		               "caption": '${msgel.getMsg("RBA_50_05_02_01_108","최종점수")}',
    		               "dataType" : "number",
    		               "alignment": "right",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }
    		           ]
    	        }
    	    ],
    	    summary: {
    	        totalItems: [
    	            {
    	                column: "PROC_LGDV_C",
    	                summaryType: "count",
    	                valueFormat: "fixedPoint", 
    	                alignment: "center"
    	            }
    	        ],
    	        texts: {count: "총: {0}건"}
    	    },
    	    onCellClick: function(e){
    	        if(e.data){
    	            Grid3CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	    }
    	}).dxDataGrid("instance");	
    }
    function setupGrids4(){
    	GridObj4 = $("#GTDataGrid4_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
    		height				 : "calc(75vh - 100px)",
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
    	    export               : {
    	        allowExportSelectedData: true,
    	        enabled                : true,
    	        excelFilterEnabled     : true,
    	        fileName               : "gridExport"
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
    	    editing: {
    	        mode         : "batch",
    	        allowUpdating: false,
    	        allowAdding  : false,
    	        allowDeleting: false
    	    },
    	    filterRow            : {visible: false},
    	    onToolbarPreparing   : makeToolbarButtonGrids,
    	    rowAlternationEnabled: false,
    	    paging               : {enabled: false},
    	    onCellPrepared       : function(e){
    	        var columnName = e.column.dataField;
    	        var dataGrid   = e.component;
    	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
    	        var realEdt       = dataGrid.cellValue(rowIndex, 'REAL_EDT');
    	        var valtEdt       = dataGrid.cellValue(rowIndex, 'VALT_EDT');
    	        if(rowIndex != -1){
    	            if(realEdt == ''){
    	                if((valtEdt !='') && (columnName == 'RBA_VALT_LGDV_C_NM' || columnName == 'RBA_VALT_SMDV_C_NM' || columnName == 'VALT_SDT' || columnName == 'VALT_EDT'
    	                    || columnName == 'REAL_EDT' || columnName == 'ROWNUM' || columnName == 'EXP_TRM')){
    	                    e.cellElement.css('background-color', '#FF4848');
    	                }
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
    	        mode              : "single",
    	        selectAllMode     : "allPages",
    	        showCheckBoxesMode: "onClick"
    	    },
    	    columns: [
    	            {
    	            "caption": '${msgel.getMsg("RBA_50_05_02_01_109","통제평가내역")}',
    	            "fixed"       : true ,
    	            "alignment": "center",
    	            "columns" : [
    	            	{
    		               "dataField": "PROC_LGDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_011","코드1")}',
    		               "width" : 50,
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true 
    		            },{
    	            	   "dataField": "PROC_LGDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_020","대분류")}',
    		               "width" : 100,
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           },{
    	            	   "dataField": "PROC_MDDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_013","코드2")}',
    		               "width" : 60,
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true 
    		           }, {
    		               "dataField": "PROC_MDDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_021","중분류")}',
    		               "width" : 100,
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           },{
    	            	   "dataField": "PROC_SMDV_C",
    		               "caption": '${msgel.getMsg("RBA_50_05_03_01_015","코드3")}',
    		               "width" : 80,
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true 
    		           }, {
    		               "dataField": "PROC_SMDV_NM",
    		               "caption": '${msgel.getMsg("RBA_50_05_01_022","소분류")}', 
    		               "alignment": "left",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }, {
    		               "dataField": "LST_TONGJE_VALT_PNT",
    		               "caption": '${msgel.getMsg("RBA_50_05_02_01_110","최종통제위험점수")}', 
    		               "dataType"     : "number",
    		               "alignment": "right",
    		               "allowResizing": true,
    		               "allowSearch": true,
    		               "allowSorting": true
    		           }
    		           ]
    	        } 
    	    ],
    	    summary: {
    	        totalItems: [
    	            {
    	                column: "PROC_LGDV_C",
    	                summaryType: "count",
    	                valueFormat: "fixedPoint", 
    	                alignment: "center"
    	            }
    	        ],
    	        texts: {count: "총: {0}건"}
    	    },
    	    onCellClick: function(e){
    	        if(e.data){
    	            Grid3CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	    }
    	}).dxDataGrid("instance");	
    }
    function setupGrids5(){
    	GridObj5 = $("#GTDataGrid5_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
    		height				 : "calc(75vh - 100px)",
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
    	    export               : {
    	        allowExportSelectedData: true,
    	        enabled                : true,
    	        excelFilterEnabled     : true,
    	        fileName               : "gridExport"
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
    	    editing: {
    	        mode         : "batch",
    	        allowUpdating: false,
    	        allowAdding  : false,
    	        allowDeleting: false
    	    },
    	    filterRow            : {visible: false},
    	    onToolbarPreparing   : makeToolbarButtonGrids,
    	    rowAlternationEnabled: false,
    	    paging               : {enabled: false},
    	    onCellPrepared       : function(e){
    	        var columnName = e.column.dataField;
    	        var dataGrid   = e.component;
    	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
    	        var realEdt       = dataGrid.cellValue(rowIndex, 'REAL_EDT');
    	        var valtEdt       = dataGrid.cellValue(rowIndex, 'VALT_EDT');
    	        if(rowIndex != -1){
    	            if(realEdt == ''){
    	                if((valtEdt !='') && (columnName == 'RBA_VALT_LGDV_C_NM' || columnName == 'RBA_VALT_SMDV_C_NM' || columnName == 'VALT_SDT' || columnName == 'VALT_EDT'
    	                    || columnName == 'REAL_EDT' || columnName == 'ROWNUM' || columnName == 'EXP_TRM')){
    	                    e.cellElement.css('background-color', '#FF4848');
    	                }
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
    	        mode              : "single",
    	        selectAllMode     : "allPages",
    	        showCheckBoxesMode: "onClick"
    	    },
    	    columns: [
    	        {
    	            dataField    : "VALT_BRNM",
    	            caption      : '${msgel.getMsg("RBA_50_05_01_019","부점명")}',
    	            alignment    : "left",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "90"
    	        }, {
    	            dataField    : "VALT_BRNO",
    	            caption      : '부점코드',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "0",
    	            visible      : false
    	        }, {
    	            dataField    : "VALT01",
    	            caption      : '${msgel.getMsg("RBA_50_05_01_01_101","대상건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "60"
    	        }, {
    	            dataField    : "VALT02",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_100","설계평가건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "80"
    	        }, {
    	            dataField    : "VALT03",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_101","운영평가건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "80"
    	        }, {
    	            dataField    : "VALT04",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_102","완료여부")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "60"
    	        }
    	    ],
    	    summary: {
    	        totalItems: [
    	            {
    	                column: "VALT_BRNM",
    	                summaryType: "count",
    	                valueFormat: "fixedPoint", 
    	                alignment: "center"
    	            }
    	        ],
    	        texts: {count: "총: {0}건"}
    	    },
    	    onCellClick: function(e){
    	        if(e.data){
    	            Grid5CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	    }
    	}).dxDataGrid("instance");	
    }
    function setupGrids6(){
    	GridObj6 = $("#GTDataGrid6_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
    		height				 : "calc(75vh - 100px)",
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
    	    export               : {
    	        allowExportSelectedData: true,
    	        enabled                : true,
    	        excelFilterEnabled     : true,
    	        fileName               : "gridExport"
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
    	    editing: {
    	        mode         : "batch",
    	        allowUpdating: false,
    	        allowAdding  : false,
    	        allowDeleting: false
    	    },
    	    filterRow            : {visible: false},
    	    onToolbarPreparing   : makeToolbarButtonGrids,
    	    rowAlternationEnabled: false,
    	    paging               : {enabled: false},
    	    onCellPrepared       : function(e){
    	        var columnName = e.column.dataField;
    	        var dataGrid   = e.component;
    	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
    	        var realEdt       = dataGrid.cellValue(rowIndex, 'REAL_EDT');
    	        var valtEdt       = dataGrid.cellValue(rowIndex, 'VALT_EDT');
    	        if(rowIndex != -1){
    	            if(realEdt == ''){
    	                if((valtEdt !='') && (columnName == 'RBA_VALT_LGDV_C_NM' || columnName == 'RBA_VALT_SMDV_C_NM' || columnName == 'VALT_SDT' || columnName == 'VALT_EDT'
    	                    || columnName == 'REAL_EDT' || columnName == 'ROWNUM' || columnName == 'EXP_TRM')){
    	                    e.cellElement.css('background-color', '#FF4848');
    	                }
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
    	        mode              : "single",
    	        selectAllMode     : "allPages",
    	        showCheckBoxesMode: "onClick"
    	    },
    	    columns: [
    	        {
    	            dataField    : "VALT_BRNM",
    	            caption      : '${msgel.getMsg("RBA_50_05_01_019","부점명")}',
    	            alignment    : "left",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "90"
    	        }, {
    	            dataField    : "VALT_BRNO",
    	            caption      : '부점코드',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "0",
    	            visible      : false
    	        }, {
    	            dataField    : "VALT01",
    	            caption      : '${msgel.getMsg("RBA_50_05_01_01_101","대상건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "60"
    	        }, {
    	            dataField    : "VALT02",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_100","설계평가건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "80"
    	        }, {
    	            dataField    : "VALT03",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_101","운영평가건수")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "80"
    	        }, {
    	            dataField    : "VALT04",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_01_102","완료여부")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width        : "60"
    	        }
    	    ],
    	    summary: {
    	        totalItems: [
    	            {
    	                column: "VALT_BRNM",
    	                summaryType: "count",
    	                valueFormat: "fixedPoint", 
    	                alignment: "center"
    	            }
    	        ],
    	        texts: {count: "총: {0}건"}
    	    },
    	    onCellClick: function(e){
    	        if(e.data){
    	            Grid6CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	    }
    	}).dxDataGrid("instance");	
    }
    
    
    function _dvTab(pageNum){
        $("#"+tabPanelID).dxTabPanel("instance").option("selectedIndex",pageNum);
        dvTab(pageNum);
    }
    
    function dvTab(pageNum){
    	
    	$('#btn_03').css("display","none");
        $('#btn_05').css("display","none");
        $('#btn_06').css("display","none");
        $('#todolist_box').css("display","none");
        $('#btn_07').css("display","none");
        
        tabID = pageNum;
        if (pageNum == 0) {        // 통제평가수행

			setupGrids();
			setupGrids2();
			
            $('#brnoChk').css("display","none");
            $('#brnoChkAll').css("display","");
            $('#valtMeth').css("display","");
            $('#todolist_box').css("display","");
            $('#btn_07').css("display","");
            
            form.TO_DO_CHECK.checked = true;
            setButtonDisplay();
            
        } else if (pageNum == 1) { // 통제평가결과조회

/* 			setupGrids5();
			setupGrids3();

			$('#brnoChkAll').css("display","none");
            $('#brnoChk').css("display","");
            $('#valtMeth').css("display","none");  */
        } else if (pageNum == 2) { // 부서별통제평가결과조회

			setupGrids6();
			setupGrids4();

            $('#brnoChkAll').css("display","none");
            $('#brnoChk').css("display","");
            $('#valtMeth').css("display","none");
        }
			//doSearch();
       // setTimeout('doSearch()', 500);
    }
    
    /** 탭 셋업 ->settimeout으로*/
    function setupTabPanel(defTabIdx){
    	if(parent.getMainsParams("tabID") != undefined){
    		tabID = parent.getMainsParams("tabID");
    		
    	}else{
    		if(flag = parent.getMainsParams("TodoList")){
    			tabID = 0;
    			
    		}else{
    			tabID = 0;
    		}
    	}
    	
    	tabPanelID = setupDxTab({
            "tabContID" : "tabCont1",
            "height"    : "100%",
            "onTabClick": function(e){
                dvTab(e.itemData.tabIdx);
            },
            "onInit"    : function(e){dvTab(tabID);},
            "defTabIdx" : tabID
        });
 
    }
    
    // 최초조회
    function doSearch(){
        //overlay.show(true, true);
        var params = new Object();
        var methodID    = "doSearch";
		var classID     = "RBA_50_10_01_01";
		params.pageID 	  = "RBA_50_10_01_01";
		
		//alert( "form.BAS_YYMM.value : " + form.BAS_YYMM.value);
		params.BAS_YYMM   = form.BAS_YYMM.value;//기준연도

		sendService(classID, methodID, params, doSearch_success, doSearch_fail);
        
        
        /* if (tabID == 0) {        
            doSearch1();
        } else if (tabID == 1) { 
            doSearch7();
        } else if (tabID == 2) {
            doSearch8();
        } */
    }
    
    
    function doSearch_success(gridData) {
    	overlay.hide();
    	var cnt = gridData.length;	//GridObj1.rowCount();
    	//console.log("cnt["+cnt+"]");
    	//alert( "cnt : " + cnt );
    	if( cnt > 0 ) {
    		var cellData =  gridData[0];
    		
    		//alert( "cellData.ALL_BAS_YYYY : " + cellData.ALL_BAS_YYYY);
			form.ACT_BASIC.value = cellData.ACT_BASIC;
			form.ACT_SCHD.value = cellData.ACT_SCHD;
			form.EVL_TERM.value = cellData.EVL_TERM;
			form.EVL_BRNO.value = cellData.EVL_BRNO;
			
			form.ALL_BAS_YYYY.value = cellData.ALL_BAS_YYYY;
			form.ALL_RISK_VAL.value = cellData.ALL_RISK_VAL;
			
			
			form.ALL_RISK_WAY.value = cellData.ALL_RISK_WAY;			
			form.ALL_TONGJE_VAL.value = cellData.ALL_TONGJE_VAL;
			form.ALL_TONGJE_WAY.value = cellData.ALL_TONGJE_WAY;			
			form.ALL_REMDR_VAL.value = cellData.ALL_REMDR_VAL;
			form.ALL_REMDR_WAY.value = cellData.ALL_REMDR_WAY;
			
			form.ALL_PRE_BAS_YYYY.value = cellData.ALL_PRE_BAS_YYYY;
			form.ALL_PRE_RISK_VAL.value = cellData.ALL_PRE_RISK_VAL;
			form.ALL_PRE_TONGJE_VAL.value = cellData.ALL_PRE_TONGJE_VAL;
			form.ALL_PRE_REMDR_VAL.value = cellData.ALL_PRE_REMDR_VAL;
			
			
			if( cellData.ALL_RISK_WAY == '상승(▲)') {
				form.ALL_RISK_WAY.style.color = "red";
			} else if( cellData.ALL_RISK_WAY == '하락(▼)') {
				form.ALL_RISK_WAY.style.color = "blue";
			} else {
				form.ALL_RISK_WAY.style.color = "black";
			}
			
			if( cellData.ALL_TONGJE_WAY == '상승(▲)') {
				form.ALL_TONGJE_WAY.style.color = "red";
			} else if( cellData.ALL_TONGJE_WAY == '하락(▼)') {
				form.ALL_TONGJE_WAY.style.color = "blue";
			} else {
				form.ALL_TONGJE_WAY.style.color = "black";
			}
			
			if( cellData.ALL_REMDR_WAY == '상승(▲)') {
				form.ALL_REMDR_WAY.style.color = "red";
			} else if( cellData.ALL_REMDR_WAY == '하락(▼)') {
				form.ALL_REMDR_WAY.style.color = "blue";
			} else {
				form.ALL_REMDR_WAY.style.color = "black";
			}
			
			
			form.ALL_NOTE.value = cellData.ALL_NOTE;
			
			
			form.REMDR_BAS_YYYY.value = cellData.REMDR_BAS_YYYY;
			form.REMDR_BAS_YYYY2.value = cellData.ALL_PRE_BAS_YYYY;
			form.REMDR_R1_VAL.value = cellData.REMDR_R1_VAL;
			form.REMDR_R2_VAL.value = cellData.REMDR_R2_VAL;
			form.REMDR_R3_VAL.value = cellData.REMDR_R3_VAL;
			form.REMDR_R4_VAL.value = cellData.REMDR_R4_VAL;
			form.REMDR_R5_VAL.value = cellData.REMDR_R5_VAL;
			form.REMDR_R1_PRE_VAL.value = cellData.REMDR_R1_PRE_VAL;
			form.REMDR_R2_PRE_VAL.value = cellData.REMDR_R2_PRE_VAL;
			form.REMDR_R3_PRE_VAL.value = cellData.REMDR_R3_PRE_VAL;
			form.REMDR_R4_PRE_VAL.value = cellData.REMDR_R4_PRE_VAL;
			form.REMDR_R5_PRE_VAL.value = cellData.REMDR_R5_PRE_VAL;
			
			form.REMDR_NOTE.value = cellData.REMDR_NOTE;
			
			
			
			
			form.TOP1_BRNO.value = cellData.TOP1_BRNO;
			form.TOP1_BAS_YYYY.value = cellData.TOP1_BAS_YYYY;
			form.TOP1_RISK_VAL.value = cellData.TOP1_RISK_VAL;
			form.TOP1_TONGJE_VAL.value = cellData.TOP1_TONGJE_VAL;
			form.TOP1_REMDR_VAL.value = cellData.TOP1_REMDR_VAL;
			form.TOP1_RISK_WAY.value = cellData.TOP1_RISK_WAY;
			form.TOP1_TONGJE_WAY.value = cellData.TOP1_TONGJE_WAY;
			form.TOP1_REMDR_WAY.value = cellData.TOP1_REMDR_WAY;			
			form.TOP1_PRE_BAS_YYYY.value = cellData.TOP1_PRE_BAS_YYYY;
			form.TOP1_PRE_RISK_VAL.value = cellData.TOP1_PRE_RISK_VAL;
			form.TOP1_PRE_TONGJE_VAL.value = cellData.TOP1_PRE_TONGJE_VAL;
			form.TOP1_PRE_REMDR_VAL.value = cellData.TOP1_PRE_REMDR_VAL;
			
			form.TOP2_BRNO.value = cellData.TOP2_BRNO;
			form.TOP2_BAS_YYYY.value = cellData.TOP2_BAS_YYYY;
			form.TOP2_RISK_VAL.value = cellData.TOP2_RISK_VAL;
			form.TOP2_TONGJE_VAL.value = cellData.TOP2_TONGJE_VAL;
			form.TOP2_REMDR_VAL.value = cellData.TOP2_REMDR_VAL;
			form.TOP2_RISK_WAY.value = cellData.TOP2_RISK_WAY;
			form.TOP2_TONGJE_WAY.value = cellData.TOP2_TONGJE_WAY;
			form.TOP2_REMDR_WAY.value = cellData.TOP2_REMDR_WAY;			
			form.TOP2_PRE_BAS_YYYY.value = cellData.TOP2_PRE_BAS_YYYY;
			form.TOP2_PRE_RISK_VAL.value = cellData.TOP2_PRE_RISK_VAL;
			form.TOP2_PRE_TONGJE_VAL.value = cellData.TOP2_PRE_TONGJE_VAL;
			form.TOP2_PRE_REMDR_VAL.value = cellData.TOP2_PRE_REMDR_VAL;
			
			form.TOP3_BRNO.value = cellData.TOP3_BRNO;
			form.TOP3_BAS_YYYY.value = cellData.TOP3_BAS_YYYY;
			form.TOP3_RISK_VAL.value = cellData.TOP3_RISK_VAL;
			form.TOP3_TONGJE_VAL.value = cellData.TOP3_TONGJE_VAL;
			form.TOP3_REMDR_VAL.value = cellData.TOP3_REMDR_VAL;
			form.TOP3_RISK_WAY.value = cellData.TOP3_RISK_WAY;
			form.TOP3_TONGJE_WAY.value = cellData.TOP3_TONGJE_WAY;
			form.TOP3_REMDR_WAY.value = cellData.TOP3_REMDR_WAY;			
			form.TOP3_PRE_BAS_YYYY.value = cellData.TOP3_PRE_BAS_YYYY;
			form.TOP3_PRE_RISK_VAL.value = cellData.TOP3_PRE_RISK_VAL;
			form.TOP3_PRE_TONGJE_VAL.value = cellData.TOP3_PRE_TONGJE_VAL;
			form.TOP3_PRE_REMDR_VAL.value = cellData.TOP3_PRE_REMDR_VAL;
			
			form.TOP4_BRNO.value = cellData.TOP4_BRNO;
			form.TOP4_BAS_YYYY.value = cellData.TOP4_BAS_YYYY;
			form.TOP4_RISK_VAL.value = cellData.TOP4_RISK_VAL;
			form.TOP4_TONGJE_VAL.value = cellData.TOP4_TONGJE_VAL;
			form.TOP4_REMDR_VAL.value = cellData.TOP4_REMDR_VAL;
			form.TOP4_RISK_WAY.value = cellData.TOP4_RISK_WAY;
			form.TOP4_TONGJE_WAY.value = cellData.TOP4_TONGJE_WAY;
			form.TOP4_REMDR_WAY.value = cellData.TOP4_REMDR_WAY;			
			form.TOP4_PRE_BAS_YYYY.value = cellData.TOP4_PRE_BAS_YYYY;
			form.TOP4_PRE_RISK_VAL.value = cellData.TOP4_PRE_RISK_VAL;
			form.TOP4_PRE_TONGJE_VAL.value = cellData.TOP4_PRE_TONGJE_VAL;
			form.TOP4_PRE_REMDR_VAL.value = cellData.TOP4_PRE_REMDR_VAL;
			
			form.TOP5_BRNO.value = cellData.TOP5_BRNO;
			form.TOP5_BAS_YYYY.value = cellData.TOP5_BAS_YYYY;
			form.TOP5_RISK_VAL.value = cellData.TOP5_RISK_VAL;
			form.TOP5_TONGJE_VAL.value = cellData.TOP5_TONGJE_VAL;
			form.TOP5_REMDR_VAL.value = cellData.TOP5_REMDR_VAL;
			form.TOP5_RISK_WAY.value = cellData.TOP5_RISK_WAY;
			form.TOP5_TONGJE_WAY.value = cellData.TOP5_TONGJE_WAY;
			form.TOP5_REMDR_WAY.value = cellData.TOP5_REMDR_WAY;			
			form.TOP5_PRE_BAS_YYYY.value = cellData.TOP5_PRE_BAS_YYYY;
			form.TOP5_PRE_RISK_VAL.value = cellData.TOP5_PRE_RISK_VAL;
			form.TOP5_PRE_TONGJE_VAL.value = cellData.TOP5_PRE_TONGJE_VAL;
			form.TOP5_PRE_REMDR_VAL.value = cellData.TOP5_PRE_REMDR_VAL;
			
			form.TOP_NOTE.value = cellData.TOP_NOTE;
			
			form.WEAK_PT1_NM.value   = cellData.WEAK_PT1_NM;
			form.WEAK_PT1_NOTE.value = cellData.WEAK_PT1_NOTE;
			form.WEAK_PT2_NM.value   = cellData.WEAK_PT2_NM;
			form.WEAK_PT2_NOTE.value = cellData.WEAK_PT2_NOTE;
			form.WEAK_PT3_NM.value   = cellData.WEAK_PT3_NM;
			form.WEAK_PT3_NOTE.value = cellData.WEAK_PT3_NOTE;
			form.WEAK_PT4_NM.value   = cellData.WEAK_PT4_NM;
			form.WEAK_PT4_NOTE.value = cellData.WEAK_PT4_NOTE;
			
			form.UPGRADE_REQ_CNT.value = cellData.UPGRADE_REQ_CNT;
			form.UPGRADE_ACT_CNT.value = cellData.UPGRADE_ACT_CNT;
			form.UPGRADE_ACT_RATE.value = cellData.UPGRADE_ACT_RATE;
			form.UPGRADE_NOTE.value = cellData.UPGRADE_NOTE;
			
			
			form.BRNO_UPGRADE_REQ_CNT.value = cellData.BRNO_UPGRADE_REQ_CNT;
			form.BRNO_UPGRADE_ACT_CNT.value = cellData.BRNO_UPGRADE_ACT_CNT;
			form.BRNO_UPGRADE_ACT_RATE.value = cellData.BRNO_UPGRADE_ACT_RATE;
			form.BRNO_UPGRADE_NOTE.value = cellData.BRNO_UPGRADE_NOTE;
			
			
			form.UPGRADE_WEAK1_NM.value   = cellData.UPGRADE_WEAK1_NM;
			form.UPGRADE_WEAK1_NOTE.value = cellData.UPGRADE_WEAK1_NOTE;
			form.UPGRADE_WEAK1_BRNO.value = cellData.UPGRADE_WEAK1_BRNO;
			
			form.UPGRADE_WEAK2_NM.value   = cellData.UPGRADE_WEAK2_NM;
			form.UPGRADE_WEAK2_NOTE.value = cellData.UPGRADE_WEAK2_NOTE;
			form.UPGRADE_WEAK2_BRNO.value = cellData.UPGRADE_WEAK2_BRNO;
			
			form.UPGRADE_WEAK3_NM.value   = cellData.UPGRADE_WEAK3_NM;
			form.UPGRADE_WEAK3_NOTE.value = cellData.UPGRADE_WEAK3_NOTE;
			form.UPGRADE_WEAK3_BRNO.value = cellData.UPGRADE_WEAK3_BRNO;
			
			
			
			if( cellData.TOP1_RISK_WAY == '상승(▲)') {
				form.TOP1_RISK_WAY.style.color = "red";
			} else if( cellData.TOP1_RISK_WAY == '하락(▼)') {
				form.TOP1_RISK_WAY.style.color = "blue";
			} else {
				form.TOP1_RISK_WAY.style.color = "black";
			}
			
			if( cellData.TOP1_TONGJE_WAY == '상승(▲)') {
				form.TOP1_TONGJE_WAY.style.color = "red";
			} else if( cellData.TOP1_TONGJE_WAY == '하락(▼)') {
				form.TOP1_TONGJE_WAY.style.color = "blue";
			} else {
				form.TOP1_TONGJE_WAY.style.color = "black";
			}
			
			if( cellData.TOP1_REMDR_WAY == '상승(▲)') {
				form.TOP1_REMDR_WAY.style.color = "red";
			} else if( cellData.TOP1_REMDR_WAY == '하락(▼)') {
				form.TOP1_REMDR_WAY.style.color = "blue";
			} else {
				form.TOP1_REMDR_WAY.style.color = "black";
			}
			
			
			if( cellData.TOP2_RISK_WAY == '상승(▲)') {
				form.TOP2_RISK_WAY.style.color = "red";
			} else if( cellData.TOP2_RISK_WAY == '하락(▼)') {
				form.TOP2_RISK_WAY.style.color = "blue";
			} else {
				form.TOP2_RISK_WAY.style.color = "black";
			}
			
			if( cellData.TOP2_TONGJE_WAY == '상승(▲)') {
				form.TOP2_TONGJE_WAY.style.color = "red";
			} else if( cellData.TOP2_TONGJE_WAY == '하락(▼)') {
				form.TOP2_TONGJE_WAY.style.color = "blue";
			} else {
				form.TOP2_TONGJE_WAY.style.color = "black";
			}
			
			if( cellData.TOP2_REMDR_WAY == '상승(▲)') {
				form.TOP2_REMDR_WAY.style.color = "red";
			} else if( cellData.TOP2_REMDR_WAY == '하락(▼)') {
				form.TOP2_REMDR_WAY.style.color = "blue";
			} else {
				form.TOP2_REMDR_WAY.style.color = "black";
			}
			
			
			if( cellData.TOP3_RISK_WAY == '상승(▲)') {
				form.TOP3_RISK_WAY.style.color = "red";
			} else if( cellData.TOP3_RISK_WAY == '하락(▼)') {
				form.TOP3_RISK_WAY.style.color = "blue";
			} else {
				form.TOP3_RISK_WAY.style.color = "black";
			}
			
			if( cellData.TOP3_TONGJE_WAY == '상승(▲)') {
				form.TOP3_TONGJE_WAY.style.color = "red";
			} else if( cellData.TOP3_TONGJE_WAY == '하락(▼)') {
				form.TOP3_TONGJE_WAY.style.color = "blue";
			} else {
				form.TOP3_TONGJE_WAY.style.color = "black";
			}
			
			if( cellData.TOP3_REMDR_WAY == '상승(▲)') {
				form.TOP3_REMDR_WAY.style.color = "red";
			} else if( cellData.TOP3_REMDR_WAY == '하락(▼)') {
				form.TOP3_REMDR_WAY.style.color = "blue";
			} else {
				form.TOP3_REMDR_WAY.style.color = "black";
			}
			
			
			if( cellData.TOP4_RISK_WAY == '상승(▲)') {
				form.TOP4_RISK_WAY.style.color = "red";
			} else if( cellData.TOP4_RISK_WAY == '하락(▼)') {
				form.TOP4_RISK_WAY.style.color = "blue";
			} else {
				form.TOP4_RISK_WAY.style.color = "black";
			}
			
			if( cellData.TOP4_TONGJE_WAY == '상승(▲)') {
				form.TOP4_TONGJE_WAY.style.color = "red";
			} else if( cellData.TOP4_TONGJE_WAY == '하락(▼)') {
				form.TOP4_TONGJE_WAY.style.color = "blue";
			} else {
				form.TOP4_TONGJE_WAY.style.color = "black";
			}
			
			if( cellData.TOP4_REMDR_WAY == '상승(▲)') {
				form.TOP4_REMDR_WAY.style.color = "red";
			} else if( cellData.TOP4_REMDR_WAY == '하락(▼)') {
				form.TOP4_REMDR_WAY.style.color = "blue";
			} else {
				form.TOP4_REMDR_WAY.style.color = "black";
			}
			
			if( cellData.TOP5_RISK_WAY == '상승(▲)') {
				form.TOP5_RISK_WAY.style.color = "red";
			} else if( cellData.TOP5_RISK_WAY == '하락(▼)') {
				form.TOP5_RISK_WAY.style.color = "blue";
			} else {
				form.TOP5_RISK_WAY.style.color = "black";
			}
			
			if( cellData.TOP5_TONGJE_WAY == '상승(▲)') {
				form.TOP5_TONGJE_WAY.style.color = "red";
			} else if( cellData.TOP5_TONGJE_WAY == '하락(▼)') {
				form.TOP5_TONGJE_WAY.style.color = "blue";
			} else {
				form.TOP5_TONGJE_WAY.style.color = "black";
			}
			
			if( cellData.TOP5_REMDR_WAY == '상승(▲)') {
				form.TOP5_REMDR_WAY.style.color = "red";
			} else if( cellData.TOP5_REMDR_WAY == '하락(▼)') {
				form.TOP5_REMDR_WAY.style.color = "blue";
			} else {
				form.TOP5_REMDR_WAY.style.color = "black";
			}
			
		}
    	
    	doSearch00();

    }

    function doSearch_fail(){
    	overlay.hide();
    }
    
    
    
    function doSearch00() {
		
		var params = new Object();
        var methodID    = "doSearch00";
		var classID     = "RBA_50_01_02_01";
		params.pageID 	  = "RBA_50_10_01_01";
		
		params.BAS_YYMM   = form.BAS_YYMM.value;//기준연도

		sendService(classID, methodID, params, doSearch00_end, doSearch00_fail);

	}

	function doSearch00_end(gridData, data) {

		//alert( "step : " + data.GRID_DATA[0].ING_STEP );
		form.ING_STEP_NM.value = data.GRID_DATA[0].ING_STEP_NM;
		form.ING_STEP.value = data.GRID_DATA[0].ING_STEP;
		form.FIX_YN.value = data.GRID_DATA[0].FIX_YN;
		
		
		if( form.FIX_YN.value == "1" ) {
			$("button[id='btn_01']").prop('disabled', true)
		} else {
			$("button[id='btn_01']").prop('disabled', false)
		}
			
		
		
		
	}
	function doSearch00_fail(){
		console.log("doSearch00_fail");
    }
    
    //통제유효성 평가 부점별 현황
    function doSearch1(){ 
    	if(form.TO_DO_CHECK.checked == true){
    		toDoCheck = 1;
        }else{
        	toDoCheck = 0;
        }
    	

   		var methodID = "doSearch"
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSaveBranch";
   		params.BAS_YYMM			= form.BAS_YYMM.value;
   		params.VALT_BRNO		= form.VALT_BRNO2.value;
   		params.TO_DO_CHECK		= toDoCheck;
   		params.ROLE_IDS			= '${ROLE_IDS}';
   		params.BRCD				= '${BRCD}';
   		sendService(classID, methodID, params, doSearch_end, doSearch2);
    }
    
	function doSearch_end(dataSource) { 
		overlay.hide();
		GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
	    
	    GridObj1.refresh().then(function() {
	    	GridObj1.selectRowsByIndexes(0)
	    });
	    
    	// 결재 권한 체크후 버튼 감춤
        var rowsData11 = GridObj2.getKeyByRowIndex(0);
    	var cnt = dataSource.length;
    	
    	if(cnt > 0){
    		Grid1CellClick('',dataSource[0], '', '', '', '', '');
//     		doSearch2();
    	}else{
            $('#btn_03').css("display","none");
            $('#btn_05').css("display","none");
            $('#btn_06').css("display","none");
            GridObj2.clearSelection();
            GridObj2.option('dataSource', []);
    	}
    }
    
    
    // 그리드 Grid1CellClick function
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId){
        overlay.show(true, true);

		var methodID = "doSearch2";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch2";
   		params.BAS_YYMM			= obj.BAS_YYMM; 
   		params.VALT_BRNO		= obj.VALT_BRNO;
   		params.VALD_VALT_METH_C = form.VALD_VALT_METH_C.value;
   		sendService(classID, methodID, params, doSearch_end2, doSearch_end2);
        
        
        //부서 클릭시 RowId
        form.SELNUM.value =  rowIdx;
        form.SELBRNO.value =  obj.VALT_BRNO;
    }
    
   // 통제유효성 평가내역
    function doSearch2(){
    	//deleteRows();
    	
    	var cellData =  GridObj1.getRow(0);
    	var gridCnt = GridObj1.rowCount();
    	var valtBrno = "";
    
    	if(gridCnt > 0){ 
    		valtBrno = cellData.VALT_BRNO
    	} 
    	

		var methodID = "doSearch2";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch2";
   		params.BAS_YYMM			= form.BAS_YYMM.value;
   		params.VALT_BRNO		= valtBrno;
   		params.VALD_VALT_METH_C = form.VALD_VALT_METH_C.value;
   		sendService(classID, methodID, params, doSearch_end2, doSearch_end2);
    }
   
    function doSearch_end2(dataSource) {
    	overlay.hide();
    	GridObj2.refresh();
        GridObj2.option("dataSource", dataSource);
    	
    	var rowsData11 = GridObj2.getKeyByRowIndex(0);
    	if(rowsData11.GYLJ_ROLE_ID != 0){	
	        if('${ROLE_IDS}' != rowsData11.GYLJ_ROLE_ID){
	      	    //승인요청버튼 삭제
	          	$("#btn_03").attr("style","display:none;");
	      		//승인버튼 삭제
	          	$("#btn_05").attr("style","display:none;");
	          	//반려버튼 삭제
	          	$("#btn_06").attr("style","display:none;");
	        }
    	}
    }
 
    
    //그리드 Grid2CellClick function
    function Grid2CellClick(id, obj, selectData, rowIdx, colIdx, colId){  
    	if(colId == "DSGN_VALT_PNT" || colId == "TONGJE_VALD_PNT" ){
	    	form3.pageID.value     = "RBA_50_05_02_02";
	        form3.BAS_YYMM.value   =  $("#BAS_YYMM").val();
	        form3.VALT_BRNO.value  = obj.VALT_BRNO;
	    	form3.TONGJE_FLD_C.value         = obj.PROC_FLD_C; 
	    	form3.TONGJE_LGDV_C.value        = obj.PROC_LGDV_C; 
	    	form3.TONGJE_MDDV_C.value        = obj.PROC_MDDV_C; 
	    	form3.TONGJE_SMDV_C.value        = obj.PROC_SMDV_C;
	    	form3.TONGJE_NO.value            = obj.TONGJE_NO;
	    	form3.GYLJ_S_C.value             = obj.GYLJ_S_C ;
	    	form3.FIRST_GYLJ_YN.value        = obj.FIRST_GYLJ_YN;
	        var win                = window_popup_open("RBA_50_05_02_02",  1030, 900, '','no');
	        form3.target           = "RBA_50_05_02_02";
	        form3.action           = '<c:url value="/"/>0001.do';
	        form3.submit();
    	}
    }
    
 	// 두번째 탭 (통제평가 결과조회)
    function doSearch7(){
		var methodID = "doSearch5";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch5";
   		params.BAS_YYMM			= form.BAS_YYMM.value;
   		params.VALT_BRNO		= form.VALT_BRNO2.value;
   		sendService(classID, methodID, params, doSearch_end7, doSearch_end7);
    }
 	
    function doSearch_end7(dataSource) {
    	overlay.hide();
    	GridObj5.refresh();
        GridObj5.option("dataSource", dataSource);
        
        GridObj5.refresh().then(function() {
        	GridObj5.selectRowsByIndexes(0)
	    	if (dataSource.length != 0 ){
	    		doSearch3();
	    	}
        });
    	
    }
    
    // 두번째 탭 (통제평가 결과조회)
    function doSearch3(){ 
    	
    	var cellData =  GridObj5.getKeyByRowIndex(0);
//     	var gridCnt = GridObj5.rowCount();
    	var gridCnt = GridObj1.getVisibleRows().length;
    	var valtBrno = "";
    
    	if(gridCnt > 0){ 
    		valtBrno = cellData.VALT_BRNO
    	} 	
    	
		var methodID = "doSearch3";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch3";
   		params.BAS_YYMM			= form.BAS_YYMM.value;
   		params.VALT_BRNO		= valtBrno;
   		sendService(classID, methodID, params, doSearch_end3, doSearch_end3);
    }
    
    function doSearch_end3(dataSource) {
    	overlay.hide();
    	GridObj3.refresh();
    	GridObj3.option("dataSource", dataSource);
    } 
     
    
    // 그리드 Grid5CellClick function
    function Grid5CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId){
        overlay.show(true, true); 
        var methodID   =   "doSearch3";
        
        //부서 클릭시 RowId
        form.SELNUM.value =  rowIdx;
        form.SELBRNO.value =  obj.VALT_BRNO;
        
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch3";
   		params.BAS_YYMM			= obj.BAS_YYMM; 
   		params.VALT_BRNO		= obj.VALT_BRNO;
   		sendService(classID, methodID, params, doSearch_end3, doSearch_end3);
    }

    
 	// 3번째탭(부서별 통제평가 결과조회))  
    function doSearch8(){

		var methodID = "doSearch6";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch6";
   		params.BAS_YYMM			= form.BAS_YYMM.value;
   		params.VALT_BRNO		= form.VALT_BRNO2.value;
   		sendService(classID, methodID, params, doSearch_end8, doSearch_end8);
    }
    
    function doSearch_end8(dataSource) {
    	
    	overlay.hide();
    	GridObj6.refresh();
        GridObj6.option("dataSource", dataSource);
        GridObj6.refresh().then(function() {
        	GridObj6.selectRowsByIndexes(0)
        });
    	
    	if (dataSource.length != 0 ){
    		doSearch4();
    	}
    } 
    
 	// 3번째탭(부서별 통제평가 결과조회)) 
    function doSearch4(){ 
    	var cellData =  GridObj6.getKeyByRowIndex(0);
    	var gridCnt = GridObj6.getVisibleRows().length;
    	var valtBrno = "";
    
    	if(gridCnt > 0){ 
    		valtBrno = cellData.VALT_BRNO
    	} 	

		var methodID = "doSearch4";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch4";
   		params.BAS_YYMM			= form.BAS_YYMM.value;
   		params.VALT_BRNO		= valtBrno;
   		sendService(classID, methodID, params, doSearch_end4, doSearch_end4);
    }
    
    function doSearch_end4(dataSource) {
    	overlay.hide();
    	GridObj4.refresh();
    	GridObj4.option("dataSource", dataSource);
		 
    } 
    
    
    //그리드 Grid6CellClick function
    function Grid6CellClick(id, obj, selectData, rowIdx, colIdx, colId){ 
    	 overlay.show(true, true);
         var methodID   =   "doSearch4";

		var methodID = "doSearch4";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch4";
   		params.BAS_YYMM			= obj.BAS_YYMM; 
   		params.VALT_BRNO		= obj.VALT_BRNO;
   		sendService(classID, methodID, params, doSearch_end4, doSearch_end4);
         
         //부서 클릭시 RowId
         form.SELNUM.value =  rowIdx;
         form.SELBRNO.value =  obj.VALT_BRNO;
    }
    
    
 
    function doSearch5(){

		var methodID = "doSearch";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch";
   		params.BAS_YYMM			= form.BAS_YYMM.value;
   		params.VALT_BRNO		= form.VALT_BRNO2.value;
   		
   		sendService(classID, methodID, params, doSearch_end5, doSearch_end5);
    }
    function doSearch_end5(dataSource) {
		var selNum = form.SELNUM.value;
		GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
	    GridObj1.refresh().then(function() {
	    	GridObj1.selectRowsByIndexes(selNum)
	    });
	    
		doSearch6();
        
    }
    function doSearch6(){
    	deleteRows();
    	seltBrno = form.SELBRNO.value;

		var methodID = "doSearch2";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch2";
   		params.BAS_YYMM			= form.BAS_YYMM.value;
   		params.VALT_BRNO		= seltBrno;
   		params.VALD_VALT_METH_C	= form.VALD_VALT_METH_C.value;
   		sendService(classID, methodID, params, doSearch_end2, doSearch_end2);
    }
    

    
    //평가 저장
    function doSave() {
    	
    	//overlay.show(true, true);
    	
    	

		var methodID = "doSave";
   		var params = new Object();
   		
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= methodID;
   		params.BAS_YYMM			= form.BAS_YYMM.value;    //평가기준월
   		
//   		alert( "doSave1 : " + classID + " : " + methodID + " : " + form.BAS_YYMM.value);
   		
   		params.ACT_BASIC           = form.ACT_BASIC.value;
   		params.ACT_SCHD            = form.ACT_SCHD.value;
   		params.EVL_TERM            = form.EVL_TERM.value;
   		params.EVL_BRNO            = form.EVL_BRNO.value;
   		params.ALL_NOTE            = form.ALL_NOTE.value;
   		params.REMDR_NOTE          = form.REMDR_NOTE.value;
   		params.TOP_NOTE            = form.TOP_NOTE.value;
   		params.WEAK_PT1_NM         = form.WEAK_PT1_NM.value;
   		params.WEAK_PT2_NM         = form.WEAK_PT2_NM.value;
   		params.WEAK_PT3_NM         = form.WEAK_PT3_NM.value;
   		params.WEAK_PT4_NM         = form.WEAK_PT4_NM.value;
   		params.WEAK_PT5_NM         = "";
   		params.WEAK_PT1_NOTE       = form.WEAK_PT1_NOTE.value;
   		params.WEAK_PT2_NOTE       = form.WEAK_PT2_NOTE.value;
   		params.WEAK_PT3_NOTE       = form.WEAK_PT3_NOTE.value;
   		params.WEAK_PT4_NOTE       = form.WEAK_PT4_NOTE.value;
   		params.WEAK_PT5_NOTE       = "";
   		params.UPGRADE_NOTE        = form.UPGRADE_NOTE.value;
   		params.BRNO_UPGRADE_NOTE   = form.BRNO_UPGRADE_NOTE.value;
   		params.UPGRADE_WEAK1_NM    = form.UPGRADE_WEAK1_NM.value;
   		params.UPGRADE_WEAK2_NM    = form.UPGRADE_WEAK2_NM.value;
   		params.UPGRADE_WEAK3_NM    = form.UPGRADE_WEAK3_NM.value;
   		params.UPGRADE_WEAK4_NM    = form.UPGRADE_WEAK4_NM.value;
   		params.UPGRADE_WEAK1_NOTE  = form.UPGRADE_WEAK1_NOTE.value;
   		params.UPGRADE_WEAK2_NOTE  = form.UPGRADE_WEAK2_NOTE.value;
   		params.UPGRADE_WEAK3_NOTE  = form.UPGRADE_WEAK3_NOTE.value;
   		params.UPGRADE_WEAK4_NOTE  = form.UPGRADE_WEAK4_NOTE.value;
   		params.UPGRADE_WEAK1_BRNO  = form.UPGRADE_WEAK1_BRNO.value;
   		params.UPGRADE_WEAK2_BRNO  = form.UPGRADE_WEAK2_BRNO.value;
   		params.UPGRADE_WEAK3_BRNO  = form.UPGRADE_WEAK3_BRNO.value;
   		params.UPGRADE_WEAK4_BRNO  = form.UPGRADE_WEAK4_BRNO.value;
   		
   		sendService(classID, methodID, params, doSaveEnd, doSaveEnd);
    }
    
    function doSaveEnd() {
    	//overlay.hide();
        //showAlert('${msgel.getMsg("RBA_50_03_03_001","저장이 완료되었습니다.")}', 'INFO');
        
        doSearch();
    }
    
    // 고위험영역개선관리 승인요청
    function openGyljPopUp0() { 		
        openGyljPopUp(0);
    }
 	
    // 승인
    function openGyljPopUp2() {
   		/* validation 추가 */
   		
        openGyljPopUp(2);
    }
    
 	// 반려
    function openGyljPopUp22() {
    /* validation 추가 */
    
        openGyljPopUp(1);
    }
    
    // 고위험영역개선관리 반려
    function openGyljPopUp1() {
        openGyljPopUp(1);
    }
    
    // 고위험영역개선관리 - 결재(RBA_50_07_02_04) 팝업 호출 function
    function openGyljPopUp(flag) {
    	var ROLE_ID = '${ROLE_IDS}';
    	
        if(!checkValid2()){
            return;
        }
		
        var gObj = GridObj2.getRow(0);
        var GYLJ_S_C;
        form4.pageID.value  = "RBA_50_05_01_08";
        
        if(flag=="0"){ //승인요청 
 			if(BRCD == gObj.VALT_BRNO){ 
 				GYLJ_S_C = "21";
 			}else{ 
 				if(ROLE_ID == "4"){
 					showAlert("타지점의 개선사항입니다.", "WARN");
 					return;
 				}else{
            		GYLJ_S_C = "21";
 				}
 			}
        } else if(flag=="1") {//반려
        	GYLJ_S_C = "22";
        }  else if(flag=="2") {//승인        
        	GYLJ_S_C = "21";        	
        }  else {
        	GYLJ_S_C = gObj.GYLJ_S_C;
        }
        
        var win = window_popup_open("RBA_50_05_01_08", 650, 260, '', 'yes');
        
        form4.BAS_YYMM.value    = gObj.BAS_YYMM ;       		    //기준년월
        form4.VALT_BRNO.value   = gObj.VALT_BRNO;  
        form4.GYLJ_ID.value     = gObj.GYLJ_ID;
        form4.GYLJ_S_C.value    = GYLJ_S_C;
        form4.GYLJ_G_C.value    = gObj.GYLJ_G_C;
        form4.FLAG.value    	= flag; 
        form4.GYLJ_GUBN.value  	= "TONGJE";
        form4.target            = form4.pageID.value;
        form4.action            = "<c:url value='/'/>0001.do"; 
        form4.submit();
      
    }
    
 	// 승인요청 validationn 체크
    function checkValid2(flag) {
       
    	var all_count = null;
    	var cnt = GridObj1.rowCount();
        if(cnt < 1){
        	showAlert('${msgel.getMsg("RBA_50_05_01_01_147","결재 진행 건이 없습니다.")}','WARN');
    		return false;
    	}
        
        
        var rowData = GridObj1.getSelectedRowsData();
        if(rowData.length == 0 ){
        	GridObj1.selectRow(0);  	 	
 			rowData = GridObj1.getSelectedRowsData();
   	 	}
        var obj = rowData[0];
   	 	
    	clear_yn = obj.VALT04;
    	all_count = GridObj2.getVisibleRows().length; 
    	
    	if(all_count < 1){
    		showAlert('${msgel.getMsg("RBA_50_05_01_01_147","결재 진행 건이 없습니다.")}','WARN');
    		return false;
    	}
    	
    	if(clear_yn != "Y"){
    		showAlert('${msgel.getMsg("RBA_50_05_02_01_114","통제유효성 평가를 모두 완료 하여야 결재를 진행 하실 수 있습니다.")}', "WARN");
    		return false;
    	}
    	
    	var rowsData2 = GridObj2.getKeyByRowIndex(0);
    	if(rowsData2.GYLJ_S_C == "3"){
    		showAlert('${msgel.getMsg("RBA_50_05_01_01_145","결재진행이 이미 완료 되었습니다.")}','WARN');
			return false;
		}
    	
		if(rowsData2.FIRST_GYLJ_YN != 'Y'){
			if( '${ROLE_IDS}' != rowsData2.GYLJ_ROLE_ID ){
				showAlert('${msgel.getMsg("RBA_50_05_01_01_149","결재 순번이 아닙니다.\\n결재 진행 상태를 확인 하여 주시기 바랍니다.")}','WARN');
				return false;
	    	}
		}    	
        return true;
    } 
 	
	function doSearch_appr() {
        form4.pageID.value  = "RBA_50_02_02_04";
        
        var rowData = GridObj1.getSelectedRowsData();
        if(rowData.length == 0 ){
        	if(GridObj1.getVisibleRows().length != 0){
        		GridObj1.selectRowsByIndexes(0);  	 	
     			rowData = GridObj1.getSelectedRowsData();
        	}else{
        		showAlert('${msgel.getMsg("RBA_50_05_01_01_150","수기평가 내역이 없습니다.")}','WARN');
        	}
   	 	}
        var obj = rowData[0];
   	 	
		if(obj.GYLJ_S_C == null || obj.GYLJ_S_C =='' ){
			showAlert('${msgel.getMsg("RBA_50_05_01_01_151","결재이력이 없습니다.")}','WARN');
			return;
		}
		form4.GYLJ_ID.value     = obj.GYLJ_ID;
        var win = window_popup_open(form4.pageID.value, 800, 320, '', '');
        form4.target		= form4.pageID.value;
        form4.action		= "<c:url value='/'/>0001.do"; 
        form4.submit();
	}
	
	function setButtonDisplay() {
    	var ROLE_ID = '${ROLE_IDS}';
    	
    	if("3"== ROLE_ID ) { //지점담당자일 경우 승인, 반려버튼 삭제
    		$("#btn_03").attr("style","inline-block;");
    	} else if("4"== ROLE_ID ) { //본점담당자일 경우 
    		//버튼들 다 보이도록
        	$("#btn_03").attr("style","inline-block;");//승인요청버튼
        	$("#btn_05").attr("style","inline-block;");//승인버튼
        	$("#btn_06").attr("style","inline-block;");//반려버튼
	    } else if("104"== ROLE_ID ) { //본점책임자 제어
	    	$("#btn_05").attr("style","inline-block;");//승인버튼
        	$("#btn_06").attr("style","inline-block;");//반려버튼
	    } else if("6"== ROLE_ID) { //지점책임자 버튼 제어
	       	$("#btn_05").attr("style","inline-block;");//승인버튼
        	$("#btn_06").attr("style","inline-block;");//반려버튼	
	    } else if("7"== ROLE_ID ) { //시스템관리자일 경우 모든 버튼 보이게
    		//버튼들 다 보이도록
    		$("#btn_03").attr("style","display:none;");//승인요청버튼
        	$("#btn_05").attr("style","display:none;");//승인버튼
        	$("#btn_06").attr("style","display:none;");//반려버튼
        } else { //나머지 권한들은 다 버튼 없음
       		//승인요청버튼 삭제
           	$("#btn_03").attr("style","display:none;");
       		//승인버튼 삭제
           	$("#btn_05").attr("style","display:none;");
           	//반려버튼 삭제
           	$("#btn_06").attr("style","display:none;");
       }	
    }	
    
	function refreshApprovalCount()
	{
	    if (opener) {
	        if (opener.opener) {
	            if (opener.opener.parent.getApprovalCount) opener.opener.parent.getApprovalCount();
	        } else if (opener.parent.getApprovalCount) opener.parent.getApprovalCount();
	    } else if (parent.getApprovalCount) parent.getApprovalCount();
	}

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
							} else if(gridID=="GTDataGrid3_Area") {
								setupFilter3();
							} else if(gridID=="GTDataGrid4_Area") {
								setupFilter4();
							} else if(gridID=="GTDataGrid5_Area") {
								setupFilter5();
							} else {//gridID=="GTDataGrid6_Area"
								setupFilter6();
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
	    
	    
	
	
	
	// 탭 셋업
    setTimeout(function() {
			var tabItemArr = [];
			var tabContentArr = [];
			
			tabItemArr.push(document.getElementById('tab-item1'));
			tabItemArr.push(document.getElementById('tab-item2'));
			tabItemArr.push(document.getElementById('tab-item3'));
			tabContentArr.push(document.getElementById('tab-content1'));
			tabContentArr.push(document.getElementById('tab-content2'));
			tabContentArr.push(document.getElementById('tab-content3'));
			
			$('#btn_03').css("display","none");
	        $('#btn_05').css("display","none");
	        $('#btn_06').css("display","none");
	        $('#btn_07').css("display","");
	        $('#todolist_box').css("display","");
			
			var _loop4 = function _loop4(idx) {
			    tabItemArr[idx].addEventListener('click', function (e) {
			    e.preventDefault();
			    tabID = idx;
			    
			    if (idx == 0) {	// 통제평가수행
//		             initSizeGTDataGrid3('GTDataGrid1_Area' , '100%','calc(75vh - 100px)','GTDataGrid1' , '<c:url value="/"/>GTDataGridServlet',initGTDataGrid1 );  // 그리드1 초기화
//		             initSizeGTDataGrid3('GTDataGrid2_Area' , '100%','calc(75vh - 100px)','GTDataGrid2' , '<c:url value="/"/>GTDataGridServlet',initGTDataGrid2 );  // 그리드2 초기화

					setupGrids();
					setupGrids2();
					setupFilter("init");
			    	setupFilter2("init");
			    }  else if (idx == 1) { // 통제평가결과조회
//		             initSizeGTDataGrid3('GTDataGrid5_Area' , '100%','calc(70vh - 100px)','GTDataGrid5' , '<c:url value="/"/>GTDataGridServlet',initGTDataGrid5 );  // 그리드5 초기화
//		             initSizeGTDataGrid3('GTDataGrid3_Area' , '100%','calc(70vh - 100px)','GTDataGrid3' , '<c:url value="/"/>GTDataGridServlet',initGTDataGrid3 );  // 그리드3 초기화
					setupGrids5();
					setupGrids3();
					setupFilter5("init");
			    	setupFilter3("init");
			    } else if (idx == 2) { // 부서별통제평가결과조회
//		         	initSizeGTDataGrid3('GTDataGrid6_Area' , '100%','calc(70vh - 100px)','GTDataGrid4' , '<c:url value="/"/>GTDataGridServlet',initGTDataGrid6 );  // 그리드6 초기화
//		             initSizeGTDataGrid3('GTDataGrid4_Area' , '100%','calc(70vh - 100px)','GTDataGrid4' , '<c:url value="/"/>GTDataGridServlet',initGTDataGrid4 );  // 그리드4 초기화
					setupGrids6();
					setupGrids4();
					setupFilter6("init");
			    	setupFilter4("init");
		        }
			    
 
			    for (var _i6 = 0; _i6 < tabItemArr.length; _i6++) {
			        tabItemArr[_i6].classList.remove('active');
			        tabContentArr[_i6].classList.remove('active');
			    }
			    tabItemArr[idx].classList.add('active');
			    tabContentArr[idx].classList.add('active');
			    showContent(idx);
				});
			};
			for (var idx = 0; idx < tabItemArr.length; idx++) {
			  _loop4(idx);
			}
		    function showContent(num) {
	      		for (var _i3 = 0; _i3 < tabContentArr.length; _i3++) {
		        	tabContentArr[_i3].style.display = 'none';
		      	}
		      	tabContentArr[num].style.display = 'block';
		      	if (num == 0) {	// 통제평가수행
		            //$('#btn_02').css("display","");
		            $('#brnoChk').css("display","none");
		            $('#brnoChkAll').css("display","");
		            $('#valtMeth').css("display","");
		            $('#todolist_box').css("display","");
		            $('#btn_07').css("display","");
		            
		            form.TO_DO_CHECK.checked = true;
		            setButtonDisplay();
			    }  else if (num == 1) { // 통제평가결과조회
		            //$('#btn_02').css("display","none");
		            $('#brnoChkAll').css("display","none");
		            $('#brnoChk').css("display","");
		            $('#valtMeth').css("display","none");
		            $('#todolist_box').css("display","none");
		            $('#btn_07').css("display","none");
			    } else if (num == 2) { // 부서별통제평가결과조회
		            //$('#btn_02').css("display","none");
		            $('#brnoChkAll').css("display","none");
		            $('#brnoChk').css("display","");
		            $('#valtMeth').css("display","none");
		            $('#todolist_box').css("display","none");
		            $('#btn_07').css("display","none");
		        }
			    
			    //doSearch();
		    }

		}, 500);
	
	
    function doExcelDown() {  
    	form5.pageID.value = "RBA_50_10_01_03";	// 일정수정
    	var win;       win = window_popup_open(  form5.pageID.value , 900, 800, '','No');
//     	form5.BAS_YYMM     = $("#BAS_YYMM").val();
    	form5.BAS_YYMM.value     = $("#BAS_YYMM").val();
     	console.log("1 ::::: " + form5.BAS_YYMM.value);
    	form5.target       = form5.pageID.value ;
    	form5.action       = '<c:url value="/"/>0001.do';
    	form5.submit(); 
    	 
   	}
    
    
 // 마감/취소
    function doFinish(){

        //if($("button[id='btn_04']") == null) return;

        var confirmState = "";

        if(form.FIX_YN.value == "0"){
            confirmState = "1";
            showConfirm("${msgel.getMsg('RBA_50_01_01_055','마감을 하시겠습니까?')}", "확정",function(){
            	var params = new Object();
                var methodID    = "doFinish";
        		var classID     = "RBA_50_01_01_01";
        		params.pageID 	  = "RBA_50_10_01_01";
        		params.FIX_YN = "1";  //confirmState
                params.ING_STEP = "99";
        		params.BAS_YYMM   = form.BAS_YYMM.value;//기준연도

        		sendService(classID, methodID, params, doFinish_end, doFinish_end);
                
            });
        }else{
        	if(form.FIX_YN.value == "1"){
	            confirmState = "0";
	            showConfirm("${msgel.getMsg('RBA_50_01_01_056','마감을 취소하시겠습니까?')}", "취소",function(){
	            	 //$("button[id='btn_04']").prop('disabled', true);

	                 var params   = new Object();
                     var methodID = "doFinish";
                     var methodID    = "doFinish";
             		 var classID     = "RBA_50_01_01_01";

                     params.pageID 	= pageID;
                     params.BAS_YYMM = form.BAS_YYMM.value;
                     params.FIX_YN = "0";  //confirmState
                     params.ING_STEP = "80";

                     sendService(classID, methodID, params, doFinish_end, doFinish_end);
	            });
        	}else {
        		showAlert('${msgel.getMsg("RBA_50_01_01_01_105","배치가 진행중입니다. 배치가 완료된 후에 처리하여 주시기 바랍니다.")}','WARN');
           		return;
            }
        }

       // $("button[id='btn_04']").prop('disabled', true);

    }

    function doFinish_end() {
        //$("button[id='btn_04']").prop('disabled', false);
        doSearch();
    }
	
</script>
<form name="form5" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="BAS_YYMM">
</form>

<form name="form3" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="BAS_YYMM">
    <input type="hidden" name="VALT_BRNO">
	<input type="hidden" name="TONGJE_FLD_C">
    <input type="hidden" name="TONGJE_LGDV_C">
    <input type="hidden" name="TONGJE_MDDV_C">
    <input type="hidden" name="TONGJE_SMDV_C">
    <input type="hidden" name="GYLJ_S_C">
    <input type="hidden" name="FIRST_GYLJ_YN">
    <input type="hidden" name="TONGJE_NO"> 
</form>

<form name="form4" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="BAS_YYMM">
	<input type="hidden" name="VALT_BRNO">
    <input type="hidden" name="GYLJ_ID" >
    <input type="hidden" name="GYLJ_S_C" >
    <input type="hidden" name="FLAG" >
    <input type="hidden" name="GYLJ_GUBN" >
    <input type="hidden" name="GYLJ_G_C" >
</form>

<form name="form2" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="TONGJE_FLD_C">
    <input type="hidden" name="TONGJE_LGDV_NM">
    <input type="hidden" name="TONGJE_LGDV_C">
    <input type="hidden" name="TONGJE_MDDV_NM">
    <input type="hidden" name="TONGJE_MDDV_C">
    <input type="hidden" name="TONGJE_SMDV_NM">
    <input type="hidden" name="TONGJE_SMDV_C">
    <input type="hidden" name="VALT_BRNO">
    <input type="hidden" name="VALT_BRNM">
    <input type="hidden" name="RSK_VALT_PNT">
    <input type="hidden" name="REG_YN">
    <input type="hidden" name="BAS_YYMM">
    <input type="hidden" name="P_GUBN">
    <input type="hidden" name="TONGJE_VALT_PNT">
</form>
<form name="form" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
    <input type="hidden" name="SELNUM">
    <input type="hidden" name="SELBRNO">
    
    
    
    
    <div class="linear-table" id='condBox1' style="min-width:1245px">
        <div class="table-row">
            <div class="table-cell">
            	${condel.getLabel('RBA_50_03_02_001','평가회차')}
           	 	<div class="content">
           	 		<RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="Y" eventFunction='doSearch()'/>
       	    	</div>
		       	${condel.getLabel("RBA_50_01_01_047","진행상태")}
		       	<div class="content">
		       	    <input type="text" name= "ING_STEP_NM" size="30" class="cond-input-text" style="text-align:left" readonly="readonly" />
		       	    <input type="text" class="cond-input-text" name="ING_STEP" id="ING_STEP" value="${ING_STEP}" style="border: 0px;background-color:white;color:white" readonly="readonly"></input>
		       	    <input type="text" class="cond-input-text" name="FIX_YN" id="FIX_YN" value="${FIX_YN}" style="border: 0px;background-color:white;color:white" readonly="readonly"></input>
            	</div>
       	    	<div class="content">
       	    		<input class="cond-input-text" type="text" name="blank" id="blank" value="" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;width:150px" readonly="readonly">
       	    	</div>
       	    	<div class="button-area">
			        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36 filled"}')}
			        ${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"excelDownBtn2", defaultValue:"Excel 다운로드", mode:"R", function:"doExcelDown", cssClass:"btn-36"}')}
			        ${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"RBA_50_01_01_01", defaultValue:"마감/취소", mode:"U", function:"doFinish", cssClass:"btn-36"}')} 
			    </div>
       	    </div>
        </div>
    </div>
    
    
<%--     <div class="button-area">
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
    </div> --%>
  
    
    
    <!-- 탭부분====================-------- -->
    
    
    
    <div class="popup-content2 tab-cont-box" style="height:72vh; margin: 8px 5px 5px 13px; ">
    	<ul class="tab-list2">
			<li class="tab-item2 active" id="tab-item1">
				<button type="button">${msgel.getMsg("RBA_50_10_01_01_001","수행개요")}</button>
			</li>
			<li class="tab-item2" id="tab-item2">
				<button type="button">${msgel.getMsg("RBA_50_10_01_01_002","결과 및 취약점")}</button>
			</li>
			<li class="tab-item2" id="tab-item3">
				<button type="button">${msgel.getMsg("RBA_50_10_01_01_003","개선현황")}</button>
			</li>
		</ul>
		<div class="tab-content-wrap">
			<div class="tab-content2 active" title="수행개요" id="tab-content1" style="display: block; margin-bottom: 10px;">
				<div class="tab-content-bottom">
				    <div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				    </div>
					<div class="card shadow-sm">
					  <div class="card-body">
					    <div class="table-responsive">
					      <table class="basic-table">
					        <thead>
					          <tr height="45px"><th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:20px; color:white;text-shadow:1px 1px black; width:15%">구&nbsp;&nbsp;&nbsp;&nbsp;분</th><th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:20px; color:white;text-shadow:2px 1px black">내&nbsp;&nbsp;&nbsp;&nbsp;용</th></tr>
					        </thead>
					        <tbody>
					          <tr height="80px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7;font-size:18px; font-weight:bold">수행 근거</td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="ACT_BASIC" id="ACT_BASIC" class="textarea-box" style="width:100%;" rows=3 maxlength="1000"></textarea>
					            </td>
					          </tr>
					          <tr height="150px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;font-weight:bold" >수행 일정</td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					              <textarea name="ACT_SCHD" id="ACT_SCHD" class="textarea-box" style="width:100%;" rows=5 maxlength="1000"></textarea>
					            </td>
					          </tr>
					          <tr height="50px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;font-weight:bold" >평가대상 기간</td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="EVL_TERM" id="EVL_TERM" class="textarea-box" style="width:100%;" rows=1 maxlength="1000"></textarea>
					            </td>
					          </tr>
					          <tr height="50px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;font-weight:bold" >평가대상 부점</td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="EVL_BRNO" id="EVL_BRNO" class="textarea-box" style="width:100%;" rows=3 maxlength="1000"></textarea>
					            </td>
					          </tr>
					          <tr height="180px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;font-weight:bold" >평가체계</td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					              <div class="row">
					                <div class="col-md-7">
					                  <ol>
					                    <li>▪ 전사 및 부점별 고유위험 및 통제효과성을 평가하고, 고유위험에서 효과적인 통제를 통해 완화된 위험을 제외한, 잔여(나머지)위험의 크기를 산출</li>
					                    <li>&nbsp;&nbsp;&nbsp;&nbsp; ✔ 고유위험 회사의 영업활동 및 거래 고객의 특성 등에 딸 노출될 수 밖에 없는 자금세탁 위험</li>
					                    <li>&nbsp;&nbsp;&nbsp;&nbsp; ✔ 통제효과성 회사의 자금세탁위험을 완화, 경감하기 위한 자금세탁방지 업무의 효과성</li>
					                    <li>▪ (잔여위험) = (고유위험) X { 1 - (통제효과성,%) }</li>
					                  </ol>
					                  <img src="<c:url value='/'/>Package/ext/images/rbatbl/rba_report2.PNG" style="display:block;"/>
					                </div>
					                <!-- <div class="col-md-5 text-center">
					                   <img src="../../assets/img/slide_1.jpg" alt="diagram" class="img-fluid rounded">
					                </div> -->
					              </div>
					            </td>
					          </tr>
					        </tbody>
					      </table>
					    </div>
					  </div>
					</div>							
				</div>
			</div>
			
			<div class="tab-content2" id="tab-content2" title="결과 및 취약점" style="display: none;">
				<div class="tab-content-bottom">
				    <div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				    </div>
					<div class="card shadow-sm mb-4">
					  <div class="card-body">
					    <div class="processbox-tag primary" style="margin-bottom:3px">
					    	 <span class="title-text">삼성증권 전체</span>
					    </div>
					    <div class="table-responsive">
					      <table class="basic-table">  
					        
					        <thead>
					          <tr height="45px">
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:20px; color:white;text-shadow:1px 1px black;width:15%">구&nbsp;&nbsp;&nbsp;&nbsp;분</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ff5050;font-size:20px; color:white;text-shadow:1px 1px black" colspan="2">고&nbsp;&nbsp;유&nbsp;&nbsp;위&nbsp;&nbsp;험</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#00b0f0;font-size:20px; color:white;text-shadow:1px 1px black" colspan="2">통&nbsp;&nbsp;제&nbsp;&nbsp;효&nbsp;&nbsp;과&nbsp;&nbsp;성</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#c00000;font-size:20px; color:white;text-shadow:1px 1px black" colspan="2">잔&nbsp;&nbsp;여&nbsp;&nbsp;위&nbsp;&nbsp;험</th>
					          </tr>
					        </thead>
					        <tbody>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; ">
					            	<input class="cond-input-text" type="text" name="ALL_BAS_YYYY" id="ALL_BAS_YYYY" value="${ALL_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC;  background-color:#deebf7; font-size:16px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="ALL_RISK_VAL" id="ALL_RISK_VAL" value="${ALL_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td rowspan="2" style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;">
					            	<input class="cond-input-text" type="text" name="ALL_RISK_WAY" id="ALL_RISK_WAY" value="${ALL_RISK_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="ALL_TONGJE_VAL" id="ALL_TONGJE_VAL" value="${ALL_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td rowspan="2" style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;">
					            	<input class="cond-input-text" type="text" name="ALL_TONGJE_WAY" id="ALL_TONGJE_WAY" value="${ALL_TONGJE_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ffffcd;font-size:15px;" >
					            	<input class="cond-input-text" type="text" name="ALL_REMDR_VAL" id="ALL_REMDR_VAL" value="${ALL_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					            </td>
					            <td rowspan="2" style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ffffcd;font-size:20px;">
					            	<input class="cond-input-text" type="text" name="ALL_REMDR_WAY" id="ALL_REMDR_WAY" value="${ALL_REMDR_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					            </td>
					          </tr>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;">
					            	<input class="cond-input-text" type="text" name="ALL_PRE_BAS_YYYY" id="ALL_PRE_BAS_YYYY" value="${ALL_PRE_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC;  background-color:#deebf7; font-size:16px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="ALL_PRE_RISK_VAL" id="ALL_PRE_RISK_VAL" value="${ALL_PRE_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="ALL_PRE_TONGJE_VAL" id="ALL_PRE_TONGJE_VAL" value="${ALL_PRE_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ffffcd;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="ALL_PRE_REMDR_VAL" id="ALL_PRE_REMDR_VAL" value="${ALL_PRE_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					            </td>
					          </tr>
					        </tbody>
					        <tbody>
					          <tr height="70px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;">결과설명</td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;" colspan="6" >
					            	<textarea name="ALL_NOTE" id="ALL_NOTE" class="textarea-box" style="width:100%;" rows=3 maxlength="1000"></textarea>
                                 </td>
					          </tr>
					        </tbody>
					      </table>
					    </div>
					  </div>
					</div>
					<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				    </div>
					<div class="card shadow-sm">
					  <div class="card-body">
					    <div class="processbox-tag primary" style="margin-bottom:3px">
					    	 <span class="title-text">전체 부점 잔여위험 분포</span>
					    </div>
					    <div class="table-responsive">
					      <table class="basic-table">
					        <thead>
					          <tr height="45px">
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:20px; color:white;text-shadow:1px 1px black;width:15%">구&nbsp;&nbsp;&nbsp;&nbsp;분</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0000ff;font-size:20px; color:white;text-shadow:1px 1px black">R1</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#00b050;font-size:20px; color:white;text-shadow:1px 1px black">R2</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ffc000;font-size:20px; color:black;text-shadow:1px 1px black">R3</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ff0000;font-size:20px; color:white;text-shadow:1px 1px black">R4</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#c00000;font-size:20px; color:white;text-shadow:1px 1px black">R5</th>
					          </tr>
					        </thead>
					        <tbody>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;">
					            	<input class="cond-input-text" type="text" name="REMDR_BAS_YYYY" id="REMDR_BAS_YYYY" value="${REMDR_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC;  background-color:#deebf7; font-size:16px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R1_VAL" id="REMDR_R1_VAL" value="${REMDR_R1_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R2_VAL" id="REMDR_R2_VAL" value="${REMDR_R2_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R3_VAL" id="REMDR_R3_VAL" value="${REMDR_R3_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R4_VAL" id="REMDR_R4_VAL" value="${REMDR_R4_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R5_VAL" id="REMDR_R5_VAL" value="${REMDR_R5_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					          </tr>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;">
					            	<input class="cond-input-text" type="text" name="REMDR_BAS_YYYY2" id="REMDR_BAS_YYYY2" value="${REMDR_BAS_YYYY2}" style="text-align:center;border: 0px solid #CCCCCC;  background-color:#deebf7; font-size:16px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R1_PRE_VAL" id="REMDR_R1_PRE_VAL" value="${REMDR_R1_PRE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R2_PRE_VAL" id="REMDR_R2_PRE_VAL" value="${REMDR_R2_PRE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R3_PRE_VAL" id="REMDR_R3_PRE_VAL" value="${REMDR_R3_PRE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R4_PRE_VAL" id="REMDR_R4_PRE_VAL" value="${REMDR_R4_PRE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<input class="cond-input-text" type="text" name="REMDR_R5_PRE_VAL" id="REMDR_R5_PRE_VAL" value="${REMDR_R5_PRE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					          </tr>
					        </tbody>
					        <tbody>
					          <tr height="70px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;">결과설명</td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;" colspan="6" >
					            	<textarea name="REMDR_NOTE" id="REMDR_NOTE" class="textarea-box" style="width:100%;" rows=3 maxlength="1000"></textarea>
                                 </td>
					          </tr>
					        </tbody>
					      </table>
					    </div>
					  </div>
					</div>
					
					<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				    </div>
					
					<div class="processbox-tag primary" style="margin-bottom:3px">
				    	 <span class="title-text">Top5 고위험 부점</span>
				    </div>
					<div class="card shadow-sm">
					  <div class="card-body">
					    <div class="table-responsive">
					      <table class="basic-table">
					        <thead>
					          <tr height="45px">
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:20px; color:white;text-shadow:1px 1px black;width:5%">순&nbsp;위</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:20px; color:white;text-shadow:1px 1px black;width:10%" >부&nbsp;&nbsp;점&nbsp;&nbsp;명</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:20px; color:white;text-shadow:1px 1px black" >구&nbsp;&nbsp;&nbsp;&nbsp;분</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ff5050;font-size:20px; color:white;text-shadow:1px 1px black" colspan="2">고&nbsp;&nbsp;유&nbsp;&nbsp;위&nbsp;&nbsp;험</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#00b0f0;font-size:20px; color:white;text-shadow:1px 1px black" colspan="2">통&nbsp;&nbsp;제&nbsp;&nbsp;효&nbsp;&nbsp;과&nbsp;&nbsp;성</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#c00000;font-size:20px; color:white;text-shadow:1px 1px black" colspan="2">잔&nbsp;&nbsp;여&nbsp;&nbsp;위&nbsp;&nbsp;험</th>
					          </tr>
					        </thead>
					        <tbody>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">1</td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP1_BRNO" id="TOP1_BRNO" value="${TOP1_BRNO}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP1_BAS_YYYY" id="TOP1_BAS_YYYY" value="${TOP1_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP1_RISK_VAL" id="TOP1_RISK_VAL" value="${TOP1_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP1_RISK_WAY" id="TOP1_RISK_WAY" value="${TOP1_RISK_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP1_TONGJE_VAL" id="TOP1_TONGJE_VAL" value="${TOP1_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP1_TONGJE_WAY" id="TOP1_TONGJE_WAY" value="${TOP1_TONGJE_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP1_REMDR_VAL" id="TOP1_REMDR_VAL" value="${TOP1_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px; background-color:#ffffcd;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP1_REMDR_WAY" id="TOP1_REMDR_WAY" value="${TOP1_REMDR_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP1_PRE_BAS_YYYY" id="TOP1_PRE_BAS_YYYY" value="${TOP1_PRE_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP1_PRE_RISK_VAL" id="TOP1_PRE_RISK_VAL" value="${TOP1_PRE_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP1_PRE_TONGJE_VAL" id="TOP1_PRE_TONGJE_VAL" value="${TOP1_PRE_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP1_PRE_REMDR_VAL" id="TOP1_PRE_REMDR_VAL" value="${TOP1_PRE_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">2</td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP2_BRNO" id="TOP2_BRNO" value="${TOP2_BRNO}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP2_BAS_YYYY" id="TOP2_BAS_YYYY" value="${TOP2_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP2_RISK_VAL" id="TOP2_RISK_VAL" value="${TOP2_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP2_RISK_WAY" id="TOP2_RISK_WAY" value="${TOP2_RISK_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP2_TONGJE_VAL" id="TOP2_TONGJE_VAL" value="${TOP2_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP2_TONGJE_WAY" id="TOP2_TONGJE_WAY" value="${TOP2_TONGJE_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP2_REMDR_VAL" id="TOP2_REMDR_VAL" value="${TOP2_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px; background-color:#ffffcd;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP2_REMDR_WAY" id="TOP2_REMDR_WAY" value="${TOP2_REMDR_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP2_PRE_BAS_YYYY" id="TOP2_PRE_BAS_YYYY" value="${TOP2_PRE_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP2_PRE_RISK_VAL" id="TOP2_PRE_RISK_VAL" value="${TOP2_PRE_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP2_PRE_TONGJE_VAL" id="TOP2_PRE_TONGJE_VAL" value="${TOP2_PRE_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP2_PRE_REMDR_VAL" id="TOP2_PRE_REMDR_VAL" value="${TOP2_PRE_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">3</td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP3_BRNO" id="TOP3_BRNO" value="${TOP3_BRNO}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP3_BAS_YYYY" id="TOP3_BAS_YYYY" value="${TOP3_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP3_RISK_VAL" id="TOP3_RISK_VAL" value="${TOP3_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP3_RISK_WAY" id="TOP3_RISK_WAY" value="${TOP3_RISK_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP3_TONGJE_VAL" id="TOP3_TONGJE_VAL" value="${TOP3_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP3_TONGJE_WAY" id="TOP3_TONGJE_WAY" value="${TOP3_TONGJE_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP3_REMDR_VAL" id="TOP3_REMDR_VAL" value="${TOP3_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px; background-color:#ffffcd;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP3_REMDR_WAY" id="TOP3_REMDR_WAY" value="${TOP3_REMDR_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP3_PRE_BAS_YYYY" id="TOP3_PRE_BAS_YYYY" value="${TOP3_PRE_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP3_PRE_RISK_VAL" id="TOP3_PRE_RISK_VAL" value="${TOP3_PRE_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP3_PRE_TONGJE_VAL" id="TOP3_PRE_TONGJE_VAL" value="${TOP3_PRE_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP3_PRE_REMDR_VAL" id="TOP3_PRE_REMDR_VAL" value="${TOP3_PRE_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">4</td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP4_BRNO" id="TOP4_BRNO" value="${TOP4_BRNO}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP4_BAS_YYYY" id="TOP4_BAS_YYYY" value="${TOP4_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP4_RISK_VAL" id="TOP4_RISK_VAL" value="${TOP4_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP4_RISK_WAY" id="TOP4_RISK_WAY" value="${TOP4_RISK_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP4_TONGJE_VAL" id="TOP4_TONGJE_VAL" value="${TOP4_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP4_TONGJE_WAY" id="TOP4_TONGJE_WAY" value="${TOP4_TONGJE_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP4_REMDR_VAL" id="TOP4_REMDR_VAL" value="${TOP4_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px; background-color:#ffffcd;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP4_REMDR_WAY" id="TOP4_REMDR_WAY" value="${TOP4_REMDR_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP4_PRE_BAS_YYYY" id="TOP4_PRE_BAS_YYYY" value="${TOP4_PRE_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP4_PRE_RISK_VAL" id="TOP4_PRE_RISK_VAL" value="${TOP4_PRE_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP4_PRE_TONGJE_VAL" id="TOP4_PRE_TONGJE_VAL" value="${TOP4_PRE_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP4_PRE_REMDR_VAL" id="TOP4_PRE_REMDR_VAL" value="${TOP4_PRE_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">5</td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP5_BRNO" id="TOP5_BRNO" value="${TOP5_BRNO}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP5_BAS_YYYY" id="TOP5_BAS_YYYY" value="${TOP5_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP5_RISK_VAL" id="TOP5_RISK_VAL" value="${TOP5_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP5_RISK_WAY" id="TOP5_RISK_WAY" value="${TOP5_RISK_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP5_TONGJE_VAL" id="TOP5_TONGJE_VAL" value="${TOP5_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP5_TONGJE_WAY" id="TOP5_TONGJE_WAY" value="${TOP5_TONGJE_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP5_REMDR_VAL" id="TOP5_REMDR_VAL" value="${TOP5_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:20px; background-color:#ffffcd;" rowspan="2">
					              	<input class="cond-input-text" type="text" name="TOP5_REMDR_WAY" id="TOP5_REMDR_WAY" value="${TOP5_REMDR_WAY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					            <tr>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:15px;font-weight:bold" >
					              	<input class="cond-input-text" type="text" name="TOP5_PRE_BAS_YYYY" id="TOP5_PRE_BAS_YYYY" value="${TOP5_PRE_BAS_YYYY}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP5_PRE_RISK_VAL" id="TOP5_PRE_RISK_VAL" value="${TOP5_PRE_RISK_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px;">
					              	<input class="cond-input-text" type="text" name="TOP5_PRE_TONGJE_VAL" id="TOP5_PRE_TONGJE_VAL" value="${TOP5_PRE_TONGJE_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					              </td>
					              <td style="text-align:center;border-right: 1px solid #CCCCCC; font-size:15px; background-color:#ffffcd;">
					              	<input class="cond-input-text" type="text" name="TOP5_PRE_REMDR_VAL" id="TOP5_PRE_REMDR_VAL" value="${TOP5_PRE_REMDR_VAL}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffcd; font-size:15px;" readonly="readonly">
					              </td>
					            </tr>
					        </tbody>
					        <tbody>
					          <tr height="70px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;font-weight:bold" colspan="2">결과설명</td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;" colspan="7" >
					            	<textarea name="TOP_NOTE" id="TOP_NOTE" class="textarea-box" style="width:100%;" rows=3 maxlength="1000"></textarea>
                                 </td>
					          </tr>
					        </tbody>
					      </table>
					      
					      
					    </div>
					  </div>
					</div>
					
					<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				    </div>
				    
				    <div class="processbox-tag primary" style="margin-bottom:3px">
				    	 <span class="title-text">RBA 수행 결과 및 주요 취약점</span>
				    </div>

					<div class="card shadow-sm">
					  <div class="card-body">
					    <div class="table-responsive">
					      <table class="basic-table">
					        <thead>
					          <tr height="45px">
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:20px; color:white;text-shadow:1px 1px black;width:20%">주&nbsp;요&nbsp;주&nbsp;제</th>
					            <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:20px; color:white;text-shadow:1px 1px black">내&nbsp;&nbsp;&nbsp;용</th>
					          </tr>
					        </thead>
					        
					        <tbody>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:20px;">
					            	<input class="cond-input-text" type="text" name="WEAK_PT1_NM" id="WEAK_PT1_NM" value="${WEAK_PT1_NM}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC; font-size:15px;font-weight:bold">
					            	<input class="cond-input-text" type="text" name="WEAK_PT1_NOTE" id="WEAK_PT1_NOTE" value="${WEAK_PT1_NOTE}" style="text-align:left;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;">
					            </td>
					          </tr>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:20px;">
					            	<input class="cond-input-text" type="text" name="WEAK_PT2_NM" id="WEAK_PT2_NM" value="${WEAK_PT2_NM}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC; font-size:15px;font-weight:bold">
					            	<input class="cond-input-text" type="text" name="WEAK_PT2_NOTE" id="WEAK_PT2_NOTE" value="${WEAK_PT2_NOTE}" style="text-align:left;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;">
					            </td>
					          </tr>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:20px;">
					            	<input class="cond-input-text" type="text" name="WEAK_PT3_NM" id="WEAK_PT3_NM" value="${WEAK_PT3_NM}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC; font-size:15px;font-weight:bold">
					            	<input class="cond-input-text" type="text" name="WEAK_PT3_NOTE" id="WEAK_PT3_NOTE" value="${WEAK_PT3_NOTE}" style="text-align:left;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;">
					            </td>
					          </tr>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:20px;">
					            	<input class="cond-input-text" type="text" name="WEAK_PT4_NM" id="WEAK_PT4_NM" value="${WEAK_PT4_NM}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC; font-size:15px;font-weight:bold">
					            	<input class="cond-input-text" type="text" name="WEAK_PT4_NOTE" id="WEAK_PT4_NOTE" value="${WEAK_PT4_NOTE}" style="text-align:left;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;">
					            </td>
					          </tr>
					        </tbody>
					      </table>
					    </div>
					  </div>
					</div>
					
					<div class="button-area btn-r" style="margin-top:20px;margin-bottom:8px;">
				    </div>
				    
				</div>
			</div>
					
			<div class="tab-content2" id="tab-content3" title="개선현황" style="display: none;">
				<div class="tab-content-bottom">
				<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				    </div>
				    <div class="processbox-tag primary" style="margin-bottom:3px">
				    	 <span class="title-text">건별 개선 현황</span>
				    </div>
				    
					<div class="card shadow-sm">
					  <div class="card-body">
					    <div class="table-responsive">
					      <table class="basic-table">
					        <thead>
					          <tr height="45px">
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:18px; color:white;text-shadow:1px 1px black; width:15%">개선&nbsp;&nbsp;요청&nbsp;&nbsp;건수(A)</th>
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:18px; color:white;text-shadow:2px 1px black">개선&nbsp;&nbsp;이행&nbsp;&nbsp;건수(B)</th>
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:18px; color:white;text-shadow:2px 1px black">개선&nbsp;&nbsp;이행률(B/A,&nbsp;&nbsp;%)</th>
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:18px; color:white;text-shadow:2px 1px black">비&nbsp;&nbsp;&nbsp;&nbsp;고</th>
					          </tr>
					        </thead>
					        <tbody>
					          <tr height="80px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;width:15%">
					            	<input class="cond-input-text" type="text" name="UPGRADE_REQ_CNT" id="UPGRADE_REQ_CNT" value="${UPGRADE_REQ_CNT}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;width:15%">
					            	<input class="cond-input-text" type="text" name="UPGRADE_ACT_CNT" id="UPGRADE_ACT_CNT" value="${UPGRADE_ACT_CNT}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;width:15%">
					            	<input class="cond-input-text" type="text" name="UPGRADE_ACT_RATE" id="UPGRADE_ACT_RATE" value="${UPGRADE_ACT_RATE}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_NOTE" id="UPGRADE_NOTE" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					          </tr>
					        </tbody>
					      </table>
					    </div>
					  </div>
					</div>
					
					
					<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				    </div>
				    <div class="processbox-tag primary" style="margin-bottom:3px">
				    	 <span class="title-text">부점별 개선 현황</span>
				    </div>
					<div class="card shadow-sm">
					  <div class="card-body">
					    <div class="table-responsive">
					      <table class="basic-table">
					        <thead>
					          <tr height="45px">
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:18px; color:white;text-shadow:1px 1px black; width:15%">개선&nbsp;요청&nbsp;대상&nbsp;부점(a)</th>
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:18px; color:white;text-shadow:2px 1px black">개선&nbsp;&nbsp;이행&nbsp;&nbsp;부점(b)</th>
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:18px; color:white;text-shadow:2px 1px black">개선&nbsp;&nbsp;이행률(b/a,&nbsp;&nbsp;%)</th>
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:18px; color:white;text-shadow:2px 1px black">비&nbsp;&nbsp;&nbsp;&nbsp;고</th>
					          </tr>
					        </thead>
					        <tbody>
					          <tr height="80px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;width:15%">
					            	<input class="cond-input-text" type="text" name="BRNO_UPGRADE_REQ_CNT" id="BRNO_UPGRADE_REQ_CNT" value="${BRNO_UPGRADE_REQ_CNT}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;width:15%">
					            	<input class="cond-input-text" type="text" name="BRNO_UPGRADE_ACT_CNT" id="BRNO_UPGRADE_ACT_CNT" value="${BRNO_UPGRADE_ACT_CNT}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:center;border-right: 1px solid #CCCCCC;font-size:15px;width:15%">
					            	<input class="cond-input-text" type="text" name="BRNO_UPGRADE_ACT_RATE" id="BRNO_UPGRADE_ACT_RATE" value="${BRNO_UPGRADE_ACT_RATE}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#ffffff; font-size:15px;" readonly="readonly">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="BRNO_UPGRADE_NOTE" id="BRNO_UPGRADE_NOTE" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					          </tr>
					        </tbody>
					      </table>
					    </div>
					  </div>
					</div>
					
					<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				    </div>
					
					
					<div class="processbox-tag primary" style="margin-bottom:3px">
				    	 <span class="title-text">주요 개선 조치</span>
				    </div>
					<div class="card shadow-sm">
					  <div class="card-body">
					    <div class="table-responsive">
					      <table class="basic-table">
					        <thead>
					          <tr height="45px">
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0;font-size:18px; color:white;text-shadow:1px 1px black; width:20%">취&nbsp;약&nbsp;점</th>
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:18px; color:white;text-shadow:2px 1px black">개&nbsp;선&nbsp;조&nbsp;치</th>
						          <th style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#0070c0; font-size:18px; color:white;text-shadow:2px 1px black">소관&nbsp;&nbsp;부점</th>
					          </tr>
					        </thead>
					        <tbody>
					          <tr height="60px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7;font-size:18px; ">
					            	<input class="cond-input-text" type="text" name="UPGRADE_WEAK1_NM" id="UPGRADE_WEAK1_NM" value="${UPGRADE_WEAK1_NM}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_WEAK1_NOTE" id="UPGRADE_WEAK1_NOTE" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_WEAK1_BRNO" id="UPGRADE_WEAK1_BRNO" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					          </tr>
					          <tr height="90px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;" >
					            	<input class="cond-input-text" type="text" name="UPGRADE_WEAK2_NM" id="UPGRADE_WEAK2_NM" value="${UPGRADE_WEAK2_NM}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_WEAK2_NOTE" id="UPGRADE_WEAK2_NOTE" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_WEAK2_BRNO" id="UPGRADE_WEAK2_BRNO" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					          </tr>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;" >
					            	<input class="cond-input-text" type="text" name="UPGRADE_WEAK3_NM" id="UPGRADE_WEAK3_NM" value="${UPGRADE_WEAK3_NM}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_WEAK3_NOTE" id="UPGRADE_WEAK3_NOTE" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_WEAK3_BRNO" id="UPGRADE_WEAK3_BRNO" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					          </tr>
					          <tr height="40px">
					            <td style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#deebf7; font-size:18px;" >
					            	<input class="cond-input-text" type="text" name="UPGRADE_WEAK4_NM" id="UPGRADE_WEAK4_NM" value="${UPGRADE_WEAK4_NM}" style="text-align:center;border: 0px solid #CCCCCC; background-color:#deebf7; font-size:15px;">
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_WEAK4_NOTE" id="UPGRADE_WEAK4_NOTE" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					            <td style="text-align:left;border-right: 1px solid #CCCCCC;font-size:15px;">
					            	<textarea name="UPGRADE_WEAK4_BRNO" id="UPGRADE_WEAK4_BRNO" class="textarea-box" style="width:100%;" rows=2 maxlength="1000"></textarea>
					            </td>
					          </tr>
					        </tbody>
					      </table>
					    </div>
					  </div>
					</div>
				  </div>
				</div>
			</div>
	    </div>
	</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />