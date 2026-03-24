<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_30_06_07_01.jsp
* Description     : KRI위험기준관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : PJH
* Since           : 2025-06-20
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>

<script language="JavaScript">

    var GridObj1 ;
    var GridObj2 ;
    var GridObj3 ;
    var classID  = "RBA_30_06_07_01";
    var overlay  = new Overlay();
    var addCD    = "";
    var addCD2   = "K001";
    var addCD3   = "K002";
    var addCD4   = "K003";
    var addCDNM  = "";
    var addDTLCNM2  = "";
    var addDTLC  = "";
    var addDTLC2 = "";
    var curRow   = -1;
    var curRow2  = -1;
    var pCCD     = "1";
    var firtsCnt = 0;
    var overlay  = new Overlay();
    /** Initialize */
    $(document).ready(function(){
        setupGrids1();
        setupGrids2();
        setupGrids3();
        setupFilter1("init");
        setupFilter2("init");
        setupFilter3("init");
        $(".dx-datagrid-cancel-button").closest("div.dx-toolbar-button").remove();
        doSearch();
    });

    function setupFilter1(FLAG){
        var gridArrs = new Array();
        var gridObj = new Object();
        gridObj.gridID = "GTDataGrid1_Area";
        gridObj.title = "${msgel.getMsg('RBA_50_01_04_01_121','위험분류(Lv1)')}";
        gridArrs[0] = gridObj;

        setupGridFilter2(gridArrs,FLAG);
    }

    function setupFilter2(FLAG){
        var gridArrs = new Array();
        var gridObj = new Object();
        gridObj = new Object();
        gridObj.gridID = "GTDataGrid2_Area";
        gridObj.title = "${msgel.getMsg('RBA_50_01_04_01_122','위험분류(Lv2)')}";
        gridArrs[1] = gridObj;


        setupGridFilter2(gridArrs,FLAG);
    }

    function setupFilter3(FLAG){
        var gridArrs = new Array();
        var gridObj = new Object();
        gridObj = new Object();
        gridObj.gridID = "GTDataGrid3_Area";
        gridObj.title = "${msgel.getMsg('RBA_50_01_04_01_123','위험요소')}";
        gridArrs[1] = gridObj;


        setupGridFilter2(gridArrs,FLAG);
    }



    function setupGrids1(){
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
            elementAttr: { class: "grid-table-type" },
             height :"calc(40vh - 80px)",
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
                export                  : {allowExportSelectedData : true ,enabled : true ,excelFilterEnabled : true},
                onExporting: function (e) {
                    var workbook = new ExcelJS.Workbook();
                    var worksheet = workbook.addWorksheet("Sheet1");
                    DevExpress.excelExporter.exportDataGrid({
                        component: e.component,
                        worksheet: worksheet,
                        autoFilterEnabled: true,
                    }).then(function(){
                        workbook.xlsx.writeBuffer().then(function(buffer){
                            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}_대분류.xlsx");
                        });
                    });
                    e.cancel = true;
                },
                sorting         : {mode: "multiple"},
                remoteOperations: {
                    filtering: false,
                    grouping : false,
                    paging   : false,
                    sorting  : false,
                    summary  : false
                },
                editing: {
                    mode         : "batch",
                    allowUpdating: true,
                    allowAdding  : true,
                    allowDeleting: false
                },
                onToolbarPreparing   : makeToolbarButtonGrids,
                filterRow            : {visible: false},
                rowAlternationEnabled: false,
                columnFixing         : {enabled: true},
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
                searchPanel          : {
                    visible: false,
                    width  : 250
                },
                selection: {
                    allowSelectAll    : true,
                    deferred          : false,
                    mode              : "multiple",
                    selectAllMode     : "allPages",
                    showCheckBoxesMode: "onClick"
                },
                columns: [
                    {
                        dataField    : "GRP_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_100","그룹코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField    : "DTL_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_101","상세코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true
                    },{
                        dataField    : "DTL_C_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_102","그룹코드명")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true
                    }, {
                        dataField    : "GRP_B_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_103","분류명")}',
                        lookup       : {
                            dataSource: [
                                {
                                    KEY  : "1",
                                    VALUE: "RBA"
                                }, {
                                    KEY  : "2",
                                    VALUE: "System"
                                }
                            ],
                            displayExpr: "VALUE",
                            valueExpr  : "KEY"
                        },
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true,
                        visible      : false
                    }, {
                        dataField    : "CON_YN",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_104","수정여부")}',
                        lookup       : {
                            dataSource: [
                                {
                                    KEY  : "1",
                                    VALUE: "Y"
                                }, {
                                    KEY  : "0",
                                    VALUE: "N"
                                 }
                            ],
                            displayExpr: "VALUE",
                            valueExpr  : "KEY"
                        },
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true,
                        visible      : false
                    }, {
                        dataField    : "DR_DT",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_105","등록일")}',
                        cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "DR_TIME",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_106","등록시간")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "DR_OP_JKW_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_107","등록자")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "CHG_DT",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_108","변경일")}',
                        cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "CHG_TIME",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_109","변경시간")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "CHG_OP_JKW_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_110","변경자")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "HGRK_GRP_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_111","상세그룹코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true,
                        visible      : false
                    }
                ],
                onRowInserting: function(e) {
                    e.data["USYN" ]  = "1";
                    e.data["GRP_C"] = "K001"; //addCD2;
                    e.data["IDU"        ] = "I";
                    var mycols = e.component.option("columns");
                    for (var i=0; i<mycols.length; i++) {
                        var mycolobj = mycols[i];
                        var colname  = mycolobj["dataField"];
                        if (colname!="GRP_C" && colname!="USYN" && colname!="IDU") {
                            e.data[colname] = "";
                        }
                    }
                  },
                onCellClick: function(e){
                    if (e.component.isRowSelected(e.key) && (e.data.IDU=="I" && e.columnIndex>=2 && e.columnIndex<=3)) {
                        e.component.editCell(e.rowIndex,e.columnIndex);
                    } else if (e.rowIndex != undefined){
                        e.component.clearSelection();
                        e.component.selectRowsByIndexes(e.rowIndex);
                        if(e.data["DR_DT"]==undefined){
                            e.component.columnOption('DTL_C', 'allowEditing', true);
                        }else{
                            e.component.columnOption('DTL_C', 'allowEditing', false);
                        }
                        Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
                    }
                }
                ,"summary" :{totalItems: [{column: 'GRP_C', summaryType: 'count', valueFormat: "fixedPoint"}],
  					texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
        }).dxDataGrid("instance");
    }

    function setupGrids2(){
        GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
            elementAttr: { class: "grid-table-type" },
             height :"calc(40vh - 80px)",
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
                export                  : {allowExportSelectedData : true ,enabled : true ,excelFilterEnabled : true},
                onExporting: function (e) {
                    var workbook = new ExcelJS.Workbook();
                    var worksheet = workbook.addWorksheet("Sheet1");
                    DevExpress.excelExporter.exportDataGrid({
                        component: e.component,
                        worksheet: worksheet,
                        autoFilterEnabled: true,
                    }).then(function(){
                        workbook.xlsx.writeBuffer().then(function(buffer){
                            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}_중분류.xlsx");
                        });
                    });
                    e.cancel = true;
                },
                sorting         : {mode: "multiple"},
                remoteOperations: {
                    filtering: false,
                    grouping : false,
                    paging   : false,
                    sorting  : false,
                    summary  : false
                },
                editing: {
                    mode         : "batch",
                    allowUpdating: true,
                    allowAdding  : true,
                    allowDeleting: false
                },
                onToolbarPreparing   : makeToolbarButtonGrids,
                filterRow            : {visible: false},
                rowAlternationEnabled: false,
                columnFixing         : {enabled: true},
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
                searchPanel          : {
                    visible: false,
                    width  : 250
                },
                selection: {
                    allowSelectAll    : true,
                    deferred          : false,
                    mode              : "multiple",
                    selectAllMode     : "allPages",
                    showCheckBoxesMode: "onClick"
                },
                columns: [
                    {
                        dataField    : "GRP_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_100","그룹코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowEditing : false,
                        allowSorting : true
                    }, {
                        dataField    : "DTL_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_101","상세코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    },{
                        dataField    : "DTL_C_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_112","상세코드명")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true
                    }, {
                        dataField: "USYN",
                        caption  : '${msgel.getMsg("RBA_50_02_01_013","사용여부")}',
                        lookup   : {
                            dataSource: [
                                {
                                    KEY  : "1",
                                    VALUE: "Y"
                                }, {
                                    KEY  : "0",
                                    VALUE: "N"
                                }
                            ],
                            displayExpr: "VALUE",
                            valueExpr  : "KEY"
                        },
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true
                    }, {
                        dataField    : "SNO",
                        caption      : '${msgel.getMsg("RBA_50_08_01_02_001","순번")}',
                        dataType     : "number",
                        format       : "fixedPoint",
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true
                    }, {
                        dataField    : "HGRK_GRP_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_113","상위그룹코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : true
                    }, {
                        dataField    : "HGRK_GRP_C_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_114","상위그룹코드명")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField    : "HGRK_DTL_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_115","상위상세코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField    : "HGRK_DTL_C_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_116","상위상세코드명")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    },  {
                        dataField    : "DR_DT",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_117","등록일자")}',
                        cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "DR_TIME",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_106","등록시간")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "DR_OP_JKW_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_107","등록자")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    },{
                        dataField    : "CHG_DT",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_108","변경일")}',
                        cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "CHG_TIME",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_109","변경시간")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "CHG_OP_JKW_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_110","변경자")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }
                ],
                onCellClick: function(e){
                    if (e.component.isRowSelected(e.key) && ((e.data.IDU=="I" && e.columnIndex<=5) || (e.columnIndex>=2 && e.columnIndex<=5))) {
                        e.component.editCell(e.rowIndex,e.columnIndex);
                    } else if (e.rowIndex != undefined){
                        e.component.clearSelection();
                        e.component.selectRowsByIndexes(e.rowIndex);
                        if(e.data["DR_DT"]==undefined){
                            e.component.columnOption('DTL_C', 'allowEditing', true);
                        }else{
                            e.component.columnOption('DTL_C', 'allowEditing', false);
                        }
                        Grid1CellClick2('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
                    }
                },
                onRowInserting: function(e) {
                    e.data["USYN" ]  = "1";
                    e.data["GRP_C"] = "K002"; //addCD3;
                    e.data["HGRK_GRP_C"] = "K001";
                    e.data["HGRK_DTL_C"] = addDTLC2;
                    e.data["HGRK_DTL_C_NM"] = addDTLCNM;
                    e.data["IDU"        ] = "I";
                    var mycols = e.component.option("columns");
                    for (var i=0; i < mycols.length; i++) {
                        var mycolobj = mycols[i];
                        var colname  = mycolobj["dataField"];
                        if (colname!="GRP_C" && colname!="USYN" && colname!="HGRK_GRP_C" && colname!="HGRK_DTL_C" && colname!="HGRK_DTL_C_NM" && colname!="IDU") {
                            e.data[colname] = "";
                        }
                    }
                  }
                ,"summary" :{totalItems: [{column: 'GRP_C', summaryType: 'count', valueFormat: "fixedPoint"}],
  					texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
        }).dxDataGrid("instance");
    }

    function setupGrids3(){
        GridObj3 = $("#GTDataGrid3_Area").dxDataGrid({
            elementAttr: { class: "grid-table-type" },
             height :"calc(50vh - 100px)",
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
                export                  : {allowExportSelectedData : true ,enabled : true ,excelFilterEnabled : true},
                onExporting: function (e) {
                    var workbook = new ExcelJS.Workbook();
                    var worksheet = workbook.addWorksheet("Sheet1");
                    DevExpress.excelExporter.exportDataGrid({
                        component: e.component,
                        worksheet: worksheet,
                        autoFilterEnabled: true,
                    }).then(function(){
                        workbook.xlsx.writeBuffer().then(function(buffer){
                            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}_소분류.xlsx");
                        });
                    });
                    e.cancel = true;
                },
                sorting         : {mode: "multiple"},
                remoteOperations: {
                    filtering: false,
                    grouping : false,
                    paging   : false,
                    sorting  : false,
                    summary  : false
                },
                editing: {
                    mode         : "batch",
                    allowUpdating: true,
                    allowAdding  : true,
                    allowDeleting: false
                },
                onToolbarPreparing   : makeToolbarButtonGrids,
                filterRow            : {visible: false},
                rowAlternationEnabled: false,
                columnFixing         : {enabled: true},
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
                searchPanel          : {
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
                        dataField    : "GRP_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_100","그룹코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowEditing : false,
                        allowSorting : true
                    }, {
                        dataField    : "DTL_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_101","상세코드")}',
                        alignment    : "left",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    },{
                        dataField    : "DTL_C_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_112","상세코드명")}',
                        alignment    : "left",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField: "USYN",
                        caption      : '${msgel.getMsg("RBA_50_02_01_013","사용여부")}',
                        lookup   : {
                            dataSource: [
                                {
                                    KEY  : "1",
                                    VALUE: "Y"
                                }, {
                                    KEY  : "0",
                                    VALUE: "N"
                                }
                            ],
                            displayExpr: "VALUE",
                            valueExpr  : "KEY"
                        },
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField    : "SNO",
                        caption      : '${msgel.getMsg("RBA_50_05_04_007","순번")}',
                        dataType     : "number",
                        format       : "fixedPoint",
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField    : "HGRK_GRP_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_113","상위그룹코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField    : "HGRK_GRP_C_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_114","상위그룹코드명")}',
                        alignment    : "left",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField    : "HGRK_DTL_C",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_115","상위상세코드")}',
                        alignment    : "center",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    }, {
                        dataField    : "HGRK_DTL_C_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_116","상위상세코드명")}',
                        alignment    : "left",
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true,
                        allowEditing : false
                    },  {
                        dataField    : "DR_DT",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_117","등록일자")}',
                        cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "DR_TIME",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_106","등록시간")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "DR_OP_JKW_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_107","등록자")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    },{
                        dataField    : "CHG_DT",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_108","변경일")}',
                        cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "CHG_TIME",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_109","변경시간")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }, {
                        dataField    : "CHG_OP_JKW_NM",
                        caption      : '${msgel.getMsg("RBA_50_01_04_01_110","변경자")}',
                        alignment    : "center",
                        allowEditing : false,
                        allowResizing: true,
                        allowSearch  : true,
                        allowSorting : true
                    }
                ],
                onCellClick: function(e){
                    if (e.component.isRowSelected(e.key) && ((e.data.IDU=="I" && e.columnIndex>=2 && e.columnIndex<=5) || (e.data.IDU=="U" && e.columnIndex>=3 && e.columnIndex<=5))) {
                        e.component.editCell(e.rowIndex,e.columnIndex);
                    }

                },
                onRowInserting: function(e) {
                    e.data["USYN" ]  = "1";
                    e.data["GRP_C"] = "K003"; //addCD4;
                    e.data["HGRK_GRP_C"] = "K002";
                    e.data["HGRK_DTL_C"] = addDTLC;
                    e.data["HGRK_DTL_C_NM"] = addDTLCNM2;
                    e.data["IDU"        ] = "I";
                    var mycols = e.component.option("columns");
                    for (var i=0; i < mycols.length; i++) {
                        var mycolobj = mycols[i];
                        var colname  = mycolobj["dataField"];
                        if (colname!="GRP_C" && colname!="USYN" && colname!="HGRK_GRP_C" && colname!="HGRK_DTL_C" && colname!="HGRK_DTL_C_NM" && colname!="IDU") {
                            e.data[colname] = "";
                        }
                    }
                  }
                ,"summary" :{totalItems: [{column: 'GRP_C', summaryType: 'count', valueFormat: "fixedPoint"}],
					texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
        }).dxDataGrid("instance");
    }
    /** Grid1 행 추가 */
    function addRowGrid1(cmpnt){
        try {
            GridObj2.cancelEditData();
            GridObj2.clearSelection();
            GridObj2.option('dataSource', []);
            GridObj3.cancelEditData();
            GridObj3.clearSelection();
            GridObj3.option('dataSource', []);
            cmpnt.addRow();
            cmpnt.saveEditData();
            cmpnt.columnOption('DTL_C', 'sortOrder', 'asc');
            setTimeout(function(){cmpnt.selectRowsByIndexes([0]);cmpnt.editCell(0,2);},100);
        } catch (e) {
            showAlert(e,'ERR');
        } finally {
            overlay.hide();
        }
    }
     /** Grid2 행 추가 */
    function addRowGrid2(e){

    var selectedRows = GridObj1.getSelectedRowsData();

    curRow = selectedRows.length -1
        if (curRow>-1) {
            var grid1; grid1 = $('#GTDataGrid1_Area').dxDataGrid('instance');
            var data = grid1.getDataSource().items()[curRow];

            if (data.GRP_CD=="") {
                // 선택 된 Code Head 가 아직 생성중임
                showAlert('${msgel.getMsg("AML_10_01_01_01_027","선택 된 Code Head 가 아직 생성중임")}','WARN');
            } else {
                var selkeys = $('#GTDataGrid1_Area').dxDataGrid('instance').getSelectedRowKeys();

                if (selkeys&&selkeys.length>0) {
                    var gobj; gobj = $('#GTDataGrid2_Area').dxDataGrid('instance');
                    gobj.addRow();
                    gobj.saveEditData();
                    gobj.columnOption('DTL_C', 'sortOrder', 'asc');
                    setTimeout(function(){gobj.selectRowsByIndexes([0]);gobj.editCell(0,2);},100);
                } else {
                    // 선택 된 Code Head 없음
                    showAlert('${msgel.getMsg("AML_10_01_01_01_030","선택 된 Code Head 없음1")}','WARN');
                }
            }
        } else {
            // 선택 된 Code Head 없음
            showAlert('${msgel.getMsg("AML_10_01_01_01_031","선택 된 Code Head 없음2")}','WARN');
        }
        $(".dx-button-text").css("display","inline-block").css("margin-left","3px");
        overlay.hide();
    }

    function addRowGrid3(e){

    var selectedRows = GridObj2.getSelectedRowsData();

    curRow2 = selectedRows.length -1
        if (curRow2>-1) {
            var grid2; grid2 = $('#GTDataGrid2_Area').dxDataGrid('instance');
            var data2; data2 = grid2.getDataSource().items()[curRow2];

            if (data2.GRP_CD=="") {
                // 선택 된 Code Head 가 아직 생성중임
                showAlert('${msgel.getMsg("AML_10_01_01_01_027","선택 된 Code Head 가 아직 생성중임")}','WARN');
            } else {
                var selkeys = $('#GTDataGrid2_Area').dxDataGrid('instance').getSelectedRowKeys();

                if (selkeys&&selkeys.length>0) {
                     var gobj3; gobj3 = $('#GTDataGrid3_Area').dxDataGrid('instance');
                     gobj3.addRow();
                     gobj3.saveEditData();
                     gobj3.columnOption('DTL_C', 'sortOrder', 'asc');
                     setTimeout(function(){
                        var arr = new Array;
                         for(i=0; i<gobj3.totalCount(); i++){
                            var obj; obj = gobj3.getDataSource().items()[i];
                            if(obj.DR_DT == undefined || obj.DR_DT == null || obj.DR_DT == ''){
                               arr.push(i);
                            }
                         }
                        gobj3.selectRowsByIndexes(arr);
                        gobj3.editCell(0,2);
                    },100);
                } else {
                    // 선택 된 Code Head 없음
                    showAlert('${msgel.getMsg("AML_10_01_01_01_030","선택 된 Code Head 없음1")}','WARN');

                }
            }
        } else {
            // 선택 된 Code Head 없음
            showAlert("${msgel.getMsg('AML_10_01_01_01_031', '선택 된 Code Head 없음2')}",'WARN');
        }
        $(".dx-button-text").css("display","inline-block").css("margin-left","3px");
        overlay.hide();
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
                ,"name"         : "refreshButton"
                ,"showText"     : "inMenu"
                ,"options"      : {
                         "icon"      : "pulldown"
                        ,"hint"      : '새로고침'
                        ,"disabled"  : false
                        ,"onClick"   : function(){
                            if(gridID=="GTDataGrid1_Area"){
                                doSearch();
                            } else if(gridID=="GTDataGrid2_Area"){
                                doSearch2();
                            } else {//gridID=="GTDataGrid3_Area"
                                doSearch3();
                            }
                        }
                 }
            });
            toolbarItems.splice(0, 0, {
                "locateInMenu"  : "auto"
                ,"location"     : "after"
                ,"widget"       : "dxButton"
                ,"name"         : "filterButton"
                ,"showText"     : "inMenu"
                ,"options"      : {
                         "icon"      : ""
                        ,"elementAttr": { class: "btn-28 filter" }
                        ,"hint"      : '필터'
                        ,"disabled"  : false
                        ,"onClick"   : function(){
                            if(gridID=="GTDataGrid1_Area"){
                                setupFilter1();
                            } else if(gridID=="GTDataGrid2_Area"){
                                setupFilter2();
                            } else {//gridID=="GTDataGrid3_Area"
                                setupFilter3();
                            }
                            $(".dx-datagrid-cancel-button").closest("div.dx-toolbar-button").remove();
                        }
                 }
            });
            var btnLastIndex=0;
            for(;btnLastIndex<toolbarItems.length; btnLastIndex++){
                if(toolbarItems[btnLastIndex].widget != "dxButton") {
                    break;
                }
            }
            if (authD=="Y") {
                toolbarItems.splice(btnLastIndex, 0, {
                    "locateInMenu" : "auto"
                   ,"location"     : "after"
                   ,"widget"       : "dxButton"
                   ,"name"         : "removeButton"
                   ,"showText"     : "always"
                   ,"options"      : {
                           /*  "icon"      : " "    */
                            "elementAttr": { class: "btn-28" }
                           ,"text"      : "${msgel.getMsg('AML_00_00_01_01_027','삭제')}"
                           ,"hint"      : '행을 삭제'
                           ,"disabled"  : false
                           ,"onClick"   : function(){
                            if (gridID=="GTDataGrid1_Area") {
                                doDelete1(cmpnt);
                            }else if (gridID=="GTDataGrid2_Area") {
                                doDelete2(cmpnt);
                            }else {
                                doDelete3(cmpnt);
                            }
                        }
                     }
                });
            }
            if (authC=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "saveButton") {
                        item.showText           = "always";
                        item.widget             = "dxButton";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_025','저장')}";
                        item.options.disabled   = false;
                        item.options.elementAttr= { class: "btn-28" };
                        item.options.icon       = "";
                        item.options.onClick    = function(){
                            if (gridID=="GTDataGrid1_Area") {
                                doSave1(cmpnt);
                            }else if (gridID=="GTDataGrid2_Area") {
                                doSave2(cmpnt);
                            }else {
                                doSave3(cmpnt);
                            }
                        }
                    } else if (item.name === "addRowButton") {
                        item.showText           = "always";
                        item.options.text       =  "${msgel.getMsg('AML_00_00_01_01_024','추가')}";
                        item.options.disabled   = false;
                        item.options.elementAttr= { class: "btn-28" };
                        item.options.icon       = "";
                        item.options.onClick    = function(){
                            if (gridID=="GTDataGrid1_Area") {
                                addRowGrid1(cmpnt);
                            }else if (gridID=="GTDataGrid2_Area"){
                                addRowGrid2(cmpnt);
                            }else {
                                addRowGrid3(cmpnt);
                            }
                        }
                    }
                });
            }
            if (authC=="Y"||authD=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "revertButton") {
                        item.showText           = "always";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_026','취소')}";
                        item.options.elementAttr= { class: "btn-28" };
                        item.options.icon       = "";
                        item.options.disabled   = false;
                        return;
                    }
                });
            }
        }
    }

    /** Search CODE Head */
    var doSearch = function() {

        if($("button[id='btn_01']") == null) return;

        $("button[id='btn_01']").prop('disabled', true);
        GridObj1.cancelEditData();
        var classID  = "RBA_30_06_07_01";
        var methodID = "doSearch";
        var params = new Object();
        params.pageID   = pageID;

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);

    }

    /** Search CODE Head end */
    function doSearch_success(gridData, data) {
         try {
            GridObj1.refresh();
            GridObj1.option("dataSource",gridData);

            $("button[id='btn_01']").prop('disabled', false);

             var row = gridData.length;

             if(row > 0){
                GridObj1.refresh().then(function() {
                       GridObj1.selectRowsByIndexes(0)
                });
                Grid1CellClick("GTDataGrid1", gridData[0] );
             }else{
                 form.GRP_CD_1.value = "";
             }
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

    /** Click Code Head */
    var Grid1CellClick = function(id, obj, selectData, rowIdx, colIdx, columnId, colId){
        curRow = -1;
        if (curRow!=rowIdx) {
            curRow                = rowIdx;
            addCD                 = obj.GRP_C;
            addCDNM               = obj.GRP_C_NM;
            addDTLC2              = obj.DTL_C;
            addDTLCNM             = obj.DTL_C_NM;
            form.GRP_CD_1.value   = obj.GRP_C;
            doSearch2();
        }
    }

     var Grid1CellClick2 = function(id, obj, selectData, rowIdx, colIdx, columnId, colId){
        curRow2 = -1;
        if (curRow2!=rowIdx) {
            curRow2               = rowIdx;
            addCD3                = 'K002';
            addCDNM               = obj.GRP_C_NM;
            addDTLC               = obj.DTL_C;
            addDTLCNM2            = obj.DTL_C_NM;
            form.GRP_CD_1.value   = obj.GRP_C;
            doSearch3();
        }
    }

    /** Search CODE Detail */

    var doSearch2 = function() {
        if(GridObj2 == null){
            return;
        }
        GridObj2.cancelEditData();
        GridObj2.clearSelection();
        GridObj2.option('dataSource', []);

        var classID  = "RBA_30_06_07_01";
        var methodID = "doSearch2";
        var params = new Object();
        params.pageID   = pageID;
        params.GRP_C    = addCD;
        params.DTL_C    = addDTLC2;
        sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
    }

    /** Search CODE Detail */
     function doSearch2_success(gridData, data){
        try {
            GridObj2.refresh();
            GridObj2.option("dataSource",gridData);

            $("button[id='btn_01']").prop('disabled', false);

            var row = gridData.length;
            if(row > 0){
                GridObj2.refresh().then(function() {
                   GridObj2.selectRowsByIndexes(0)
                });
                Grid1CellClick2("GTDataGrid2", gridData[0] );
            }else{
                //2018.07.19
                addDTLC = "";
                doSearch3();
                form.GRP_CD_1.value = "";
            }

        } catch (e) {
            showAlert(e,'ERR');
            overlay.hide();
        } finally {
            overlay.hide();
        }
    }

    var doSearch3 = function() {

        if(GridObj3 == null){

            return;
        }
        GridObj3.cancelEditData();
        GridObj3.clearSelection();
        GridObj3.option('dataSource', []);

        var classID  = "RBA_30_06_07_01";
        var methodID = "doSearch3";
        var params = new Object();
        params.DTL_C    = addDTLC;

        sendService(classID, methodID, params, doSearch3_success, doSearch_fail);

    }

    /** Search CODE Detail */
    function doSearch3_success(gridData, data){
        try {
            GridObj3.refresh();
            GridObj3.option("dataSource",gridData);

            $.each(data.GRID_DATA,function(i,o){o.IDU="U";});
        } catch (e) {
            showAlert(e,'ERR');
            overlay.hide();
        } finally {
            overlay.hide();
        }
    }

    var doSave1 = function(gi) {
        gi.saveEditData();

        var rowsData = GridObj1.getSelectedRowsData();
        if(rowsData.length==0){
            showAlert('${msgel.getMsg("AML_10_01_01_01_003","저장 할 데이타를 선택하십시오.")}','WARN');
            return;
        }

        var allRowsData = GridObj1.getDataSource().items();
        var keyArr = new Array();
        for (var i=0;i<allRowsData.length; i++) {
            keyArr.push(allRowsData[i].DTL_C);
        }

        for (var i=0; i<rowsData.length; i++) {
            var obj = rowsData[i];
            if (obj.DTL_C=="") {
                showAlert('${msgel.getMsg("RBA_10_09_01_01_003","상세코드를 입력하십시오.")}','WARN');
                return false;
            }
            if (obj.DTL_C_NM=="") {
            	showAlert('${msgel.getMsg("RBA_10_09_01_01_004","상세코드명을 입력하십시오.")}','WARN');
                return false;
            }
            var firstIndex = jQuery.inArray(obj.DTL_C, keyArr);
            if(obj.IDU=="U" || obj.IDU=="I") firstIndex++;
            if(jQuery.inArray(obj.DTL_C, keyArr, firstIndex)>-1){
                showAlert('${msgel.getMsg("AML_10_01_01_01_017","동일한 코드가 있어 저장할수 없습니다.")}','WARN');
                return false;
            }
        }
        showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){

            var params   = new Object();
            var methodID = "doSave";
            var classID  = "RBA_30_06_07_01";

            params.pageID   = pageID;
            params.CON_YN   = "0";
            params.gridData = rowsData;
            sendService(classID, methodID, params, doSave1_end, doSave1_end);
        });

    }

    var doSave1_end = function() {
        doSearch();
    }

    var doSave2 = function(gi) {
        gi.saveEditData();

        var rowsData = GridObj2.getSelectedRowsData();
        if(rowsData.length==0){
            showAlert('${msgel.getMsg("AML_10_01_01_01_003","저장 할 데이타를 선택하십시오.")}','WARN');
            return;
        }

        var allRowsData = GridObj2.getDataSource().items();
        var keyArr = new Array();
        for (var i=0;i<allRowsData.length; i++) {
            keyArr.push(allRowsData[i].DTL_C);
        }

        for (var i=0; i<rowsData.length; i++) {
            var obj = rowsData[i];
            if (obj.DTL_C=="") {
                showAlert('${msgel.getMsg("RBA_10_09_01_01_003","상세코드를 입력하십시오.")}','WARN');
                return false;
            }
            if (obj.DTL_C_NM=="") {
                showAlert('${msgel.getMsg("RBA_10_09_01_01_004","상세코드명을 입력하십시오.")}','WARN');
                return false;
            }
            if (obj.SNO=="") {
                showAlert('${msgel.getMsg("RBA_50_01_04_01_001","순번을 입력하십시오.")}','WARN');
                return false;
            }
            var firstIndex = jQuery.inArray(obj.DTL_C, keyArr);
            if(obj.IDU=="U" || obj.IDU=="I") firstIndex++;
            if(jQuery.inArray(obj.DTL_C, keyArr, firstIndex)>-1){
                showAlert('${msgel.getMsg("AML_10_01_01_01_017","동일한 코드가 있어 저장할수 없습니다.")}','WARN');
                return false;
            }
        }

        showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){

            var params   = new Object();
            var methodID = "doSave2";
            var classID  = "RBA_30_06_07_01";

            params.pageID   = pageID;
            params.HGRK_GRP_C   = obj.HGRK_GRP_C;
            params.HGRK_DTL_C   = obj.HGRK_DTL_C;
            params.gridData = rowsData;
            sendService(classID, methodID, params, doSave2_end, doSave2_end);
        });

    }

    var doSave2_end = function (){
        //2018.07.19
        //doSearch3();
        doSearch2();
    }

    var doSave3 = function(gi) {
        gi.saveEditData();

        var rowsData = GridObj3.getSelectedRowsData();
        if(rowsData.length==0){
            showAlert('${msgel.getMsg("AML_10_01_01_01_003","저장 할 데이타를 선택하십시오.")}','WARN');
            return;
        }

        var allRowsData = GridObj3.getDataSource().items();
        var keyArr = new Array();
        for (var i=0;i<allRowsData.length; i++) {
            keyArr.push(allRowsData[i].DTL_C);
        }

        for (var i=0; i<rowsData.length; i++) {
            var obj = rowsData[i];
            if (obj.DTL_C=="") {
                showAlert('${msgel.getMsg("RBA_10_09_01_01_003","상세코드를 입력하십시오.")}','WARN');
                return false;
            }
            if (obj.DTL_C_NM=="") {
                showAlert('${msgel.getMsg("RBA_10_09_01_01_004","상세코드명을 입력하십시오.")}','WARN');
                return false;
            }
            if (obj.SNO=="") {
                showAlert('${msgel.getMsg("RBA_50_01_04_01_001","순번을 입력하십시오.")}','WARN');
                return false;
            }
            var firstIndex = jQuery.inArray(obj.DTL_C, keyArr);
            if(obj.IDU=="U" || obj.IDU=="I") firstIndex++;
            if(jQuery.inArray(obj.DTL_C, keyArr, firstIndex)>-1){
                showAlert('${msgel.getMsg("AML_10_01_01_01_017","동일한 코드가 있어 저장할수 없습니다.")}','WARN');
                return false;
            }
        }

        showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){

            var params   = new Object();
            var methodID = "doSave3";
            var classID  = "RBA_30_06_07_01";

            params.pageID   = pageID;
            params.HGRK_GRP_C   = obj.HGRK_GRP_C;
            params.HGRK_DTL_C   = obj.HGRK_DTL_C;
            params.gridData = rowsData;
            sendService(classID, methodID, params, doSave3_end, doSave3_end);
        });

    }

    var doSave3_end = function (){
         doSearch3();
    }

    var doDelete1 = function() {

        var selectedRows  = GridObj1.getSelectedRowsData();
       var size          = selectedRows.length;
       var selectedHead  = GridObj1.getSelectedRowsData()[0];

        if(size <= 0){
            showAlert('${msgel.getMsg("AML_10_01_01_01_006","삭제할 데이타를 선택하십시오.")}','WARN');
            return;
        }

        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

            var params   = new Object();
            var methodID = "doDelete";
            var classID  = "RBA_30_06_07_01";

            params.pageID   = pageID;
            params.GRP_C           = selectedHead.GRP_C;
            params.DTL_C           = selectedHead.DTL_C;
            params.gridData = selectedRows;

            sendService(classID, methodID, params, doSave1_end, doSave1_end);
        });

    }

    var doDelete2 = function() {

        var obj2 = new Object();
        var methodID; methodID = "doDelete2";
        var selectedHead2 = GridObj2.getSelectedRowsData()[0];
        var selectedRows2 = GridObj2.getSelectedRowsData();
        var size2         = selectedRows2.length;


        if(size2 <= 0){
            showAlert('${msgel.getMsg("AML_10_01_01_01_006","삭제할 데이타를 선택하십시오.")}','WARN');
            return;
       }

        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

            var params   = new Object();
            var methodID = "doDelete2";
            var classID  = "RBA_30_06_07_01";

            params.pageID   = pageID;
            params.GRP_C           = selectedHead2.GRP_C;
            params.GRP_C           = selectedHead2.GRP_C;
            params.DTL_C           = selectedHead2.DTL_C;
            params.HGRK_GRP_C      = selectedHead2.HGRK_GRP_C;
            params.HGRK_GRP_C_NM   = selectedHead2.HGRK_GRP_C_NM;
            params.HGRK_DTL_C      = selectedHead2.HGRK_DTL_C;
            params.HGRK_DTL_C_NM   = selectedHead2.HGRK_DTL_C_NM;
            params.gridData = selectedRows2;

            sendService(classID, methodID, params, doSave2_end, doSave2_end);
        });

    }

    var doDelete3 = function() {

        var obj3 = new Object();
        var methodID3; methodID3    = "doDelete3";
        var selectedHead3 = GridObj3.getSelectedRowsData()[0];
        var selectedRows3 = GridObj3.getSelectedRowsData();
        var size3         = selectedRows3.length;


        if(size3 <= 0){
            showAlert('${msgel.getMsg("AML_10_01_01_01_006","삭제할 데이타를 선택하십시오.")}','WARN');
            return;
       }
        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

            var params   = new Object();
            var methodID = "doDelete3";
            var classID  = "RBA_30_06_07_01";

            params.pageID   = pageID;
            params.GRP_C           = selectedHead3.GRP_C;
            params.DTL_C           = selectedHead3.DTL_C;
            params.HGRK_GRP_C      = selectedHead3.HGRK_GRP_C;
            params.HGRK_GRP_C_NM   = selectedHead3.HGRK_GRP_C_NM;
            params.HGRK_DTL_C      = selectedHead3.HGRK_DTL_C;
            params.HGRK_DTL_C_NM   = selectedHead3.HGRK_DTL_C_NM;
            params.gridData = selectedRows3;

            sendService(classID, methodID, params, doSave3_end, doSave3_end);
        });
    }

    var CheckCnt = function(gObj) {
        for(i=0; i<gObj.rowCount(); i++){
            obj = gObj.getRow(i);
            if(obj.SELECTED == "1"){
                return true;
            }
        }
        return false;
    }

</script>

<form name="form" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID"> <input type="hidden"
        name="GRP_CD_1"> <input type="text" name="temp"
        style="display: none;">
    <div class="cond-box" id="condBox1">
        <div class="button-area" style="text-align: right; padding-top: 4px">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
        </div>
    </div>
    <div class="tab-content-bottom" style="margin-top: 8px;">

            <div id="GTDataGrid1_Area"></div>
    </div>
    <div class="tab-content-bottom" style="margin-top: 8px;">

            <div id="GTDataGrid2_Area"></div>
    </div>
    <div class="tab-content-bottom" style="margin-top: 8px;">

            <div id="GTDataGrid3_Area"></div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />