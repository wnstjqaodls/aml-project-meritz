<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_90_01_04_01.jsp
- Author     : 권얼
- Comment    : FIU 지표결과관리
- Version    : 1.0
- history    : 1.0 20181121
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%
	String ROLEID = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLEID",ROLEID);
%>

<script language="JavaScript">

	var GridObj1;
   	var GridObj2;

   	var overlay = new Overlay();
   	var classID    = "RBA_90_01_04_01";

   	$(document).ready(function(){
		setupGrids();
		setupGrids2();
		doSearch();
		setupFilter("init");
        setupFilter2("init");
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

	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 "height"			 : "calc(60vh - 70px)",
		     "hoverStateEnabled" : true,
		     "wordWrapEnabled" : false,
		     "allowColumnResizing" : true,
		     "columnAutoWidth" : true,
		     "allowColumnReordering" : true,
		     "columnResizingMode"     : "widget",
		     "cacheEnabled" : false,
		     "cellHintEnabled" : true,
		     "showBorders" : true,
		     "showColumnLines" : true,
		     "showRowLines" : true,
		     "loadPanel" : {enabled: false},
		     "export":
		     {
		         "allowExportSelectedData"  : true,
		         "enabled"                  : true,
		         "excelFilterEnabled"       : true
		     },
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
	         pager: {
	             visible: true,
	             showNavigationButtons: true,
	             showInfo: true
	         },
	         paging: {
	             enabled: true,
	             pageSize: 50
	         },
	         scrolling: {
	             mode: "standard",
	             preloadEnabled: false
	         },
		     "sorting": {"mode"             : "single"},
		     "remoteOperations":                  {
		         "filtering"                : false,
		         "grouping"                 : false,
		         "paging"                   : false,
		         "sorting"                  : false,
		         "summary"                  : false
		     },
		     "editing":
		     {
		         "mode"                     : "batch",
		         "allowUpdating"            : false,
		         "allowAdding"              : false,
		         "allowDeleting"            : false
		     },
		     "filterRow"                    : {"visible": false},
		     onToolbarPreparing   : makeToolbarButtonGrids,
		     "rowAlternationEnabled"        : true,
		     "columnFixing": {"enabled"     : true},
		     "searchPanel":
		     {
		         "visible"                  : false,
		         "width"                    : 250
		     },
		     onContentReady: function (e)
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
		     "selection":
		     {
		         "allowSelectAll"           : true,
		         "deferred"                 : false,
		         "mode"                     : "single",
		         "selectAllMode"            : "allPages",
		         "showCheckBoxesMode"       : "onClick"
		     },
		     "columns":
		     [
		         {
		             "dataField"            : "JIPYO_IDX",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_002","지표번호")}',
		             "cssClass"         	: "link",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "fixed" 	            : true,
		             "width"                : 90
		         },
		         {
		             "dataField"            : "JIPYO_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_03_01_002","위험지표명")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 200
		         },
		         {
		             "dataField"            : "INP_ITEM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_014","입력항목")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 90
		         },
		         {
		             "dataField"            : "INP_UNIT_C_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_020","입력단위")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 70
		         },
		         {
		             "dataField"            : "ALLT_PNT",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_016","배점")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 60
		         },
		         {
		             "dataField"            : "IN_V_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_03_01_004","입력값")}',
		             "alignment"            : "center",
		             "cssClass"         	: "link",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 70
		         },
		         {
		             "dataField"            : "RPT_PNT",
		             "caption"              : '${msgel.getMsg("RBA_90_01_03_01_005","지표점수")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 70,
		             "visible"				: false
		         },
		         {
		             "dataField"            : "ATTCH_FILE_YN",
		             "caption"              : '${msgel.getMsg("RBA_90_01_03_01_006","증빙파일")}',
		             "alignment"            : "center",
		             "cssClass"         	: "link",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		         {
		             "dataField"            : "ITEM_S_C_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_03_01_001","항목상태")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		         {
		             "dataField"            : "CAL_FRML",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_023","산출식")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 250
		         },
		         {
		             "dataField"            : "CAL_METH",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_012","산출방법")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 150
		         },
		         {
		             "dataField"            : "JIPYO_C_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_004","위험구분")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		         {
		             "dataField"            : "RSK_CATG_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_005","카테고리")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		          {
		             "dataField"            : "RSK_FAC_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_006","항목")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 170
		         },
		         {
		             "dataField"            : "CHG_DT",
		             "caption"              : '${msgel.getMsg("RBA_90_01_02_01_100","변경일자")}',
		             "cellTemplate"      	: function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 90
		         },
		         {
		             "dataField"            : "FRMG_MABD_C",
		             "caption"              : 'FRMG_MABD_C',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "VALT_G",
		             "caption"              : 'VALT_G',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "IN_V_TP_C",
		             "caption"              : 'IN_V_TP_C',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "WEGHT",
		             "caption"              : 'WEGHT',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "CNCT_JIPYO_C_I",
		             "caption"              : 'CNCT_JIPYO_C_I',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "BAS_V",
		             "caption"              : 'BAS_V',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "JIPYO_DESC",
		             "caption"              : 'JIPYO_DESC',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "JIPYO_BIGO_CTNT",
		             "caption"              : 'JIPYO_BIGO_CTNT',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "EST_BAS_SCOP",
		             "caption"              : 'EST_BAS_SCOP',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "ANEX_CTNT",
		             "caption"              : 'ANEX_CTNT',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "INP_UNIT_C",
		             "caption"              : 'INP_UNIT_C',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "ATTCH_FILE_NO",
		             "caption"              : 'ATTCH_FILE_NO',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "ITEM_S_C",
		             "caption"              : 'ITEM_S_C',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "JIPYO_C",
		             "caption"              : 'JIPYO_C',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "RSK_FAC",
		             "caption"              : 'RSK_FAC',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "RSK_CATG",
		             "caption"              : 'RSK_CATG',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "IN_V",
		             "caption"              : '${msgel.getMsg("RBA_90_01_03_01_004","입력값")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "IN_V_EXCEL",
		             "caption"              : '${msgel.getMsg("RBA_90_01_04_01","입력값엑셀")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         }

		     ],
		     "onCellClick": function(e)
		     {
		        if(e.data )
		        {
		            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		        }
		     }
		}).dxDataGrid("instance");
	}
	function setupGrids2(){
		GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 "height"			 : "calc(60vh - 220px)",
		     "hoverStateEnabled"            : true,
		     "wordWrapEnabled"              : false,
		     "allowColumnResizing"          : true,
		     "columnAutoWidth"              : true,
		     "allowColumnReordering"        : true,
		     "cacheEnabled"                 : false,
		     "cellHintEnabled"              : true,
		     "showBorders"                  : true,
		     "showColumnLines"              : true,
		     "showRowLines"                 : true,
		     "loadPanel"                    : {enabled: false},
		     "export":
		     {
		         "allowExportSelectedData"  : true,
		         "enabled"                  : true,
		         "excelFilterEnabled"       : true
		     },
		     onExporting: function (e) {
	    	    	var workbook = new ExcelJS.Workbook();
	    	    	var worksheet = workbook.addWorksheet("Sheet1");
	    		    DevExpress.excelExporter.exportDataGrid({
	    		        component: e.component,
	    		        worksheet: worksheet,
	    		        autoFilterEnabled: true,
	    		    }).then(function(){
	    		        workbook.xlsx.writeBuffer().then(function(buffer){
	    		            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "gridExport.xlsx");
	    		        });
	    		    });
	    		    e.cancel = true;
	         },
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
		     "sorting": {"mode"             : "multiple"},
		     "remoteOperations":                  {
		         "filtering"                : false,
		         "grouping"                 : false,
		         "paging"                   : false,
		         "sorting"                  : false,
		         "summary"                  : false
		     },
		     "editing":
		     {
		         "mode"                     : "batch",
		         "allowUpdating"            : false,
		         "allowAdding"              : false,
		         "allowDeleting"            : false
		     },
		     "filterRow"                    : {"visible": false},
		     onToolbarPreparing   : makeToolbarButtonGrids,
		     "rowAlternationEnabled"        : true,
		     "columnFixing": {"enabled"     : true},
		     "searchPanel":
		     {
		         "visible"                  : false,
		         "width"                    : 250
		     },
		     onContentReady: function (e)
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
		     "selection":
		     {
		         "allowSelectAll"           : true,
		         "deferred"                 : false,
		         "mode"                     : "multiple",
		         "selectAllMode"            : "allPages",
		         "showCheckBoxesMode"       : "alaways"
		     },
		     "columns":
		     [
		          {
		             "dataField"            : "FILE_SER",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_01_100","순번")}',
		             "cssClass"         	: "link",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : "5%"
		         },
		         {
		             "dataField"            : "LOSC_FILE_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_04_01_101","첨부파일명")}',
		             "cssClass"         	: "link",
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : "75%"
		         },
		         {
		             "dataField"            : "DR_DT",
		             "caption"              : '${msgel.getMsg("RBA_90_01_02_01_100","변경일자")}',
		             "cellTemplate"      	: function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : "10%"
		         }
		         ,
		         {
		             "dataField"            : "USER_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_04_01_102","등록자")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : "10%"
		         },
		         {
		             "dataField"            : "RPT_GJDT",
		             "caption"              : 'RPT_GJDT',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "RPT_YN",
		             "caption"              : 'RPT_YN',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "ATTCH_FILE_NO",
		             "caption"              : 'ATTCH_FILE_NO',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "DATA_G",
		             "caption"              : 'DATA_G',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         }
		     ],
		     "onCellClick": function(e)
		     {
		        if(e.data )
		        {
		            Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		        }
		     }
		}).dxDataGrid("instance");
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
	                    ,"hint"      : '${msgel.getMsg("RBA_90_01_01_01_104","필터")}'
	                    ,"disabled"  : false
	                    ,"onClick"   : function(){
	                    	if(gridID=="GTDataGrid1_Area"){
								setupFilter();
							} else {//gridID=="GTDataGrid2_Area"
								setupFilter2();
							}
	                    }
	             }
	        });
	    }
	}


// 	function initGTDataGrid1(gridId, gridDivId, height){
// 	    GridObj1 = initGrid3(gridId, "RBA_90_01_04_01_Grid1", "", "", gridDivId, height, "${outputAuth.USE_YN}", '');
// 	    doSearch();
// 	}

// 	function initGTDataGrid2(gridId, gridDivId, height){

// 		GridObj2 = initGrid3(gridId, "RBA_90_01_04_01_Grid2", "", "", gridDivId, height, "${outputAuth.USE_YN}", '');
// 	}

   	/*
	 * KoFIU지표 코드관리 (위험구분 - 카테고리 - 항목)
	 */
	function jipyoSelectChange(v_gubun, nextGrp, GrpObj, v_afterFun) {
		var RPT_GJDT = form1.RPT_GJDT.value;
		var gubun = "";
		nextSelectChangeReportIndex(v_gubun, RPT_GJDT, nextGrp, GrpObj, v_afterFun , gubun);
	}

	function onAftreJipyoCCdList() {
		nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
	}

	function onAftreRptGjdtCdList() {
		nextSelectChangeReportIndex("RSK_CATG",form1.RPT_GJDT.value, "A002" ,"" ,"","INIT");
		nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
		doSearch();
	}

   	function doSearch() {

   		overlay.show(true, true);
   		var methodID = "doSearch";
   		var obj = new Object();

      	obj.pageID = pageID;
      	obj.classID = classID;
      	obj.methodID = "doSearch";

      	obj.RPT_GJDT	= form1.RPT_GJDT.value;
      	obj.JIPYO_IDX	= form1.JIPYO_IDX.value;
      	obj.JIPYO_NM	= form1.JIPYO_NM.value;
      	obj.JIPYO_C		= form1.JIPYO_C.value;
      	obj.RSK_CATG	= form1.RSK_CATG.value;
      	obj.RSK_FAC		= form1.RSK_FAC.value;
      	obj.VALT_G		= form1.VALT_G.value;
      	obj.ROLE_ID	    = form1.ROLE_ID.value;

      	sendService(classID, methodID, obj, doSearch_end, doSearch_end);

   }

   	function doSearch_end(dataSource) {

   		GridObj1.refresh();
   	    GridObj1.option("dataSource", dataSource);
   		row = dataSource.length;

		if(row > 0){

			obj = dataSource[0];
			form1.GYLJ_ID.value 			=	obj.GYLJ_ID			// 결재ID
            form1.GYLJ_S_C.value			=	obj.GYLJ_S_C		// 결재상태코드
            form1.GYLJ_S_C_NM.value			=	obj.GYLJ_S_C_NM

            var JIPYO_CNT 		= obj.JIPYO_CNT;
            var ITEM_S_C_CNT	= obj.ITEM_S_C_CNT;

            if ( JIPYO_CNT == ITEM_S_C_CNT ) {
            	form1.JIPYO_FIX_YN.value = "1";
            } else {
            	form1.JIPYO_FIX_YN.value = "0";
            }
		}else{
// 			showAlert('${msgel.getMsg("RBA_90_01_04_01_120","조회결과가 없습니다.")}', "INFO");
			GridObj1.option('dataSource', []);
		}

		doSearch2();

	}

	function doSearch2() {
       if(GridObj2==null) {
			return;
		}
		GridObj2.option('dataSource', []);
		var methodID 	= "getSearchF"
	    var obj 		= new Object();
	    obj.pageID 		= pageID;
	    obj.classID 	= classID;
	    obj.methodID	= "getSearchF";
	    obj.RPT_GJDT 	= form1.RPT_GJDT.value;
	    sendService(classID, methodID, obj, doSearch_end2, doSearch_end2);

// 	    GridObj2.refresh({
// 	   	 	actionParam     : obj
// 	   	 	,completedEvent : doSearch_end2
//    		});
	}

	function doSearch_end2(dataSource) {
		if ( form1.RPT_GJDT.value.length == 8 ) {
			form1.RPT_GJDT_F.value = form1.RPT_GJDT.value.substring(0,4) + "-" + form1.RPT_GJDT.value.substring(4,6) + "-" + form1.RPT_GJDT.value.substring(6,8);
		}
		GridObj2.refresh();
   	    GridObj2.option("dataSource", dataSource);
		doSearch3();

		}

	function doSearch3() {
    	form1.GYLJ_ID.value				=	"0";
    	form1.GYLJ_ROLE_ID.value		=	"0";
        form1.lastApprovalState.value	=	"";		// 최종승인여부
        form1.approvalState.value		=	"";		// 결재상태
        form1.NEXT_GYLJ_ROLE_ID.value	=	"";		// 다음결재자
        form1.FIRST_GYLJ.value			=	"";		// 최초결재자
        form1.END_GYLJ.value			=	"";		// 마지막결재자

        var methodID 	= "getSearchGYLJ"
   	    var obj 		= new Object();
	    obj.pageID 		= pageID;
	    obj.classID 	= classID;
	    obj.methodID	= "getSearchGYLJ";
	    obj.RPT_GJDT 	= form1.RPT_GJDT.value;
        sendService(classID, methodID, obj, doSearch_end3, doSearch_end3);

	}

	function doSearch_end3(param, data) {
		if (data&&data.GRID_DATA&&data.GRID_DATA.length>0) {
			var obj = data.GRID_DATA[0];
        	form1.GYLJ_ID.value				=	obj.GYLJ_ID;
        	form1.GYLJ_ROLE_ID.value		=	obj.GYLJ_ROLE_ID;
            form1.lastApprovalState.value	=	obj.FINL_GYLJ_S;		// 최종결재여부
            form1.approvalState.value		=	obj.GYLJ_S_C_NM;		// 결재상태
            form1.NEXT_GYLJ_ROLE_ID.value	=	obj.NEXT_GYLJ_ROLE_ID;	// 다음결재자
            form1.FIRST_GYLJ.value			=	obj.FIRST_GYLJ;			// 최초결재자
            form1.END_GYLJ.value			=	obj.END_GYLJ;			// 마지막결재자


            //결재, 반려, 결재요청 버튼 비활성화
            //GYLJ_S_C 결재상태코드 		(0 : 미결재 , 12 : 결재요청 , 22 : 반려, 3 : 완료  )
            if (form1.ROLE_ID.value == 4) {										//본점담당자
				if ( obj.GYLJ_S_C == 0 ) {	//미결재
					$("#btn_07").attr("disabled",false);	// 결재요청
					$("#btn_05").attr("disabled",true);		// 결재
					$("#btn_06").attr("disabled",true);		// 반려
				} else if(obj.GYLJ_S_C == 22){
					$("#btn_07").attr("disabled",false);	// 결재요청
					$("#btn_05").attr("disabled",true);		// 결재
					$("#btn_06").attr("disabled",true);		// 반려
				} else {
					$("#btn_07").attr("disabled",true);		// 결재요청
					$("#btn_05").attr("disabled",true);		// 결재
					$("#btn_06").attr("disabled",true);		// 반려
				}
			} else if (form1.ROLE_ID.value == 104) {								//본점책임자
				if ( obj.GYLJ_S_C == 12 ) {	// 결재요청
					$("#btn_07").attr("disabled",true);		// 결재요청
					$("#btn_05").attr("disabled",false);	// 결재
					$("#btn_06").attr("disabled",false);	// 반려
				} else {
					$("#btn_07").attr("disabled",true);		// 결재요청
					$("#btn_05").attr("disabled",true);		// 결재
					$("#btn_06").attr("disabled",true);		// 반려
				}
			} else {
				$("#btn_07").attr("disabled",true);			// 결재요청
				$("#btn_05").attr("disabled",true);			// 결재
				$("#btn_06").attr("disabled",true);			// 반려
			}

 		} else {
        	form1.GYLJ_ID.value				=	"0";
        	form1.GYLJ_ROLE_ID.value		=	"0";
            form1.lastApprovalState.value	=	"";		// 최종결재여부
            form1.approvalState.value		=	"";		// 결재상태
            form1.NEXT_GYLJ_ROLE_ID.value	=	"0";	// 다음결재자
            form1.FIRST_GYLJ.value			=	"0";	// 최초결재자
            form1.END_GYLJ.value			=	"0";	// 마지막결재자

		}

		overlay.hide();
	}

	function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId) {

		if ( columnId == "JIPYO_IDX" ) {	// 지표번호 - 상세팝업
			form2.pageID.value  = 'RBA_90_01_03_05';
			var	win	= window_popup_open(form2.pageID.value, 1010,900, '');
			form2.RPT_GJDT.value 		= form1.RPT_GJDT.value;
			form2.JIPYO_IDX.value 	  	= obj.JIPYO_IDX;
			form2.JIPYO_FIX_YN.value 	= form1.JIPYO_FIX_YN.value;
			form2.IN_V_TP_C.value 		= obj.IN_V_TP_C;
			form2.CNCT_JIPYO_C_I.value	= obj.CNCT_JIPYO_C_I;
			form2.JIPYO_VIEW.value		= "Y";
			form2.target = form2.pageID.value;
			form2.action = '<c:url value="/"/>0001.do';
			form2.submit();
		}else if ( columnId == "IN_V_NM" ) {	// 지표 값 추이 팝업
			if (obj.IN_V != ""){
				form3.pageID.value  = 'RBA_90_01_04_07';
				var	win	= window_popup_open(form3.pageID.value, 500, 475, '');

				form3.RPT_GJDT.value	= form1.RPT_GJDT.value;	// 보고기준일
				form3.JIPYO_IDX.value	= obj.JIPYO_IDX;		// 지표번호

				form3.target = form3.pageID.value;
				form3.action = '<c:url value="/"/>0001.do';
				form3.submit();
			}
		} else if ( columnId == "ATTCH_FILE_YN") {	// 증빙파일 - 파일 다운로드

			if (obj.ATTCH_FILE_YN  == 'Y') {
				form4.pageID.value  = "RBA_90_01_03_03";
		      	var win; win = window_popup_open(form4.pageID.value, 605, 390, '');

		      	form4.RPT_GJDT.value 	= form1.RPT_GJDT.value;
		      	form4.JIPYO_IDX.value = obj.JIPYO_IDX;
		      	form4.JIPYO_NM.value = obj.JIPYO_NM;
		      	form4.ATTCH_FILE_NO.value = obj.ATTCH_FILE_NO;
		      	form4.gubun.value = 'download';
		      	form4.target = form4.pageID.value;
		      	form4.action = '<c:url value="/"/>0001.do';
		      	form4.submit();

			} else {
				showAlert('${msgel.getMsg("RBA_90_01_04_01_103","증빙파일이 없습니다.")}', 'WARN');
				return;
			}

		}
	}

	// 보고파일생성
	function doReportFileDownload() {
		// 결재상태가 3:완료인 경우만 보고파일을 생성한다.
		var GYLJ_S_C =  form1.GYLJ_S_C.value;

		if ( GYLJ_S_C != 3 ) {
			showAlert("${msgel.getMsg('RBA_90_01_04_01_104','보고파일 생성은 결제가 완료되어야 가능합니다.')}", "WARN");
			return;
		}

    	form2.RPT_GJDT.value = form1.RPT_GJDT.value;

      	form2.target	= "_self";
      	form2.action    =  "<c:url value='/'/>0001.do?pageID=rbaFIURptExcelDown";  // "TB_EBZI_AML_LOG_AC"."PGE_ID" 길이제한 오류
      	form2.method	= "post";
      	form2.submit();
	}

   	function Filesave_OpenPop() {
      	var form2 = document.form2;

      	form2.pageID.value  = "RBA_90_01_04_02";
      	form2.methodID.value  = "getSearchFList";
      	form2.classID.value  = "RBA_90_01_04_01";

      	form2.RPT_GJDT.value	=	form1.RPT_GJDT.value;
      	form2.RPT_GJDT_F.value	=	form1.RPT_GJDT_F.value;
      	form2.RPT_GJDT_F.value	=	form1.RPT_GJDT_F.value;
      	/* if(GridObj2.getRow(0).ATTCH_FILE_NO == "" ||GridObj2.getRow(0).ATTCH_FILE_NO ==  undefined){
      		form2.ATTCH_FILE_NO.value = "0";
      	}else{
      	} */


      	var win; win = window_popup_open(form2.pageID.value, 650,500, '');

      	form2.target = form2.pageID.value;
      	form2.action = '<c:url value="/"/>0001.do';
      	form2.submit();
	}

   	function doDelete() {

   		var selectedRows = GridObj2.getSelectedRowsData();
		var size         = selectedRows.length;

		if(size <= 0 ){
			showAlert("${msgel.getMsg('RBA_90_01_04_01_105','데이타를 선택하십시오.')}", "WARN");
			return;
		}

      	showConfirm("${msgel.getMsg('RBA_90_01_04_01_106','삭제하시겠습니까?')}", "${msgel.getMsg('RBA_90_01_04_01_107','삭제')}", function(){
	      	var obj = new Object();
	      	var methodID ="doDelete";
		    obj.pageID 		 = pageID;
		    obj.classID 	 = classID;
		    obj.methodID 	 = methodID;
		    obj.gridData	 = GridObj2.getSelectedRowsData();

		    sendService(classID, methodID, obj, doSearch2, doSearch2);
      	});

// 	    GridObj2.save({
//         	actionParam     : obj
//         	,sendFlag        : "SELECTED"
//        		,completedEvent  : doSearch2
//     	});

	}

	function Grid2CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId) {
   		if (columnId == "LOSC_FILE_NM") {
       		downloadFile(obj.PHSC_FILE_NM, obj.LOSC_FILE_NM, obj.FILE_POS);
       	}
	}

	function doApproval(FLAG) {

		var ROLE_ID; ROLE_ID = form1.ROLE_ID.value;
		var GYLJ_ROLE_ID; GYLJ_ROLE_ID = form1.GYLJ_ROLE_ID.value;
		var GYLJ_S_C; GYLJ_S_C = form1.GYLJ_S_C.value;
		var JIPYO_FIX_YN; JIPYO_FIX_YN = form1.JIPYO_FIX_YN.value;
		var NEXT_GYLJ_ROLE_ID; NEXT_GYLJ_ROLE_ID = form1.NEXT_GYLJ_ROLE_ID.value;

		if ( GridObj1.totalCount() == 0 ) {
			return;
		}

		//결재상태 확인
		if(!CheckValue(FLAG)){
			return;
		}

	   form1.pageID.value  = "RBA_90_01_04_05";
       var win; win = window_popup_open(form1.pageID.value, 650, 384, '', 'yes');
       form1.FLAG.value	= FLAG;
       form1.target		= form1.pageID.value;
       form1.action		= "<c:url value='/'/>0001.do";
       form1.submit();

	}

	function doSrarchGYLJHistory() {

        form1.pageID.value  = "RBA_90_01_04_06";

		if(form1.GYLJ_ID.value == "0"){
			showAlert("${msgel.getMsg('RBA_90_01_04_01_108','결재이력이 없습니다.')}", "WARN");
			return;
		}

        var win; win = window_popup_open(form1.pageID.value, 800, 400, '', '');

        form1.target		= form1.pageID.value;
        form1.action		= "<c:url value='/'/>0001.do";
        form1.submit();
	}

	function downloadFile ( p, l, f ) {
	 	$("#downFileName").val(p);
	 	$("#orgFileName").val(l);
	 	$("#downFilePath").val(f);
	 	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
	 	$("#fileFrm").submit();
	}

	function CheckValue(FLAG){

		var ROLE_ID 		= form1.ROLE_ID.value;
		var GYLJ_ROLE_ID	= form1.GYLJ_ROLE_ID.value;
		var GYLJ_S_C 		= form1.GYLJ_S_C.value;
		var JIPYO_FIX_YN	= form1.JIPYO_FIX_YN.value;
		var NEXT_GYLJ_ROLE_ID = form1.NEXT_GYLJ_ROLE_ID.value;
		var FIRST_GYLJ 		= form1.FIRST_GYLJ.value;
		var END_GYLJ 		= form1.END_GYLJ.value;
		

		if ( JIPYO_FIX_YN != "1" ) {
			showAlert("${msgel.getMsg('RBA_90_01_04_01_109','FIU 지표 항목상태가 전부 확정 되어야 결재가 가능합니다.')}", "WARN");
			return;
		}

		// 결재 진행중이고 사용자의 권한과 결재이력에 등록된 최종 권한이 같으면 결재 재실행 불가
		if ( NEXT_GYLJ_ROLE_ID != ROLE_ID ) {
			showAlert("${msgel.getMsg('RBA_90_01_04_01_110','결재 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
			return;
		}

		// 결재 진행중이고 사용자의 권한과 결재이력에 등록된 최종 권한이 같으면 결재 재실행 불가
		if ( GYLJ_S_C != 0 && ROLE_ID == GYLJ_ROLE_ID ) {
			showAlert("${msgel.getMsg('RBA_90_01_04_01_111','현재 결재가 실행 되었습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
			return;
		}

		//결재 FLAG (0:결재요청, 1:반려, 2:승인)
		//결재상태코드 GYLJ_S_C (0 : 미결재 , 12 : 결재요청 , 22 : 반려, 3 : 완료  )

		//결재요청
		if(FLAG == "0"){

			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_112','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}

			if ( END_GYLJ == ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_113','승인요청 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

		//반려
		}else if(FLAG == "1"){

			if(GYLJ_S_C =="0"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_114','미결재 상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if ( FIRST_GYLJ == ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_115','반려 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_116','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}

		//승인
		}else if(FLAG == "2"){
			if ( END_GYLJ != ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_117','승인 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="0"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_118','미결재 상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="22"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_119','현재 반려상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_116','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}
		}

		return true;
	}

</script>
<style>
#jipyoTable {
    border-collapse : separate;
    border-spacing:0;
}

#jipyoTable thead th{
   position: sticky;
   top: 0;
   border-right: 1px solid #ccc;
   background-color: #eaeaea;
   border-top: 2px solid #222;
    border-bottom: 1px solid #222;
    z-index:1;
}

#jipyoTable tbody td{
   border-bottom: 1px solid #e9eaeb;
   border-right: 1px solid #e9eaeb;
}
</style>
<!-- 파일 삭제, 다운로드 -->
<form name="fileFrm" id="fileFrm" method="POST">
<input type="hidden" name="downFileName" id="downFileName" value="" />
<input type="hidden" name="orgFileName" id="orgFileName" value="" />
<input type="hidden" name="downFilePath" id="downFilePath" value="" />
<input type="hidden" name="downType" id="downType" value="JIPYO" />
</form>
<form name="form4" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="RPT_GJDT">
	<input type="hidden" name="JIPYO_IDX">
	<input type="hidden" name="JIPYO_NM">
	<input type="hidden" name="ATTCH_FILE_NO">
	<input type="hidden" name="gubun">
</form>
<form name="form3" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
	<input type="hidden" name="RPT_GJDT">
	<input type="hidden" name="JIPYO_IDX">
</form>
<form name="form2" method="post">
   	<input type="hidden"  name="pageID"/>
   	<input type="hidden"  name="classID"/>
   	<input type="hidden"  name="methodID"/>
   	<input type="hidden"  name="mode"/>
   	<input type="hidden"  name="RPT_GJDT"/>
   	<input type="hidden"  name="RPT_GJDT_F"/>
	<input type="hidden"  name="JIPYO_IDX">
	<input type="hidden"  name="JIPYO_FIX_YN">
   	<input type="hidden"  name="SNO" />
   	<input type="hidden"  name="FILE_SER" />
	<input type="hidden"  name="IN_V_TP_C" >
	<input type="hidden"  name="CNCT_JIPYO_C_I" >
   	<input type="hidden"  name="JIPYO_VIEW"/>
   	<input type="hidden"  name="ROLE_ID" value="${ROLEID}">
</form>

<form name="form1" method="post" onkeydown="doEnterEvent();">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
   	<input type="hidden" name="ATTCH_FILE_NO"/>
   	<input type="hidden" name="FILE_SER"/>
   	<input type="hidden" name="ROLE_ID" value="${ROLEID}">
   	<input type="hidden" name="GYLJ_LINE_G_C" value="W99">	<!-- 결재선구분코드 = W99 : FIU지표결과관리 -->
   	<input type="hidden" name="GYLJ_ID"/>		<!-- 결재ID -->
   	<input type="hidden" name="GYLJ_S_C"/>		<!-- 결재상태코드 -->
   	<input type="hidden" name="GYLJ_S_C_NM"/>	<!-- 결재상태 -->
   	<input type="hidden" name="FLAG"/>
   	<input type="hidden" name="JIPYO_FIX_YN"/>
   	<input type="hidden" name="GYLJ_ROLE_ID"/>
   	<input type="hidden" name="NEXT_GYLJ_ROLE_ID"/>
   	<input type="hidden" name="RPT_GJDT_F" />
   	<input type="hidden" name="FIRST_GYLJ" />
   	<input type="hidden" name="END_GYLJ" />

	<!-- Content 1 Start -->
	<div class="inquiry-table type4" id="condBox1">
    	<div class="table-row" style="width:21%;">
     		<div class="table-cell">
     			${condel.getLabel('RBA_90_01_01_02_001','보고기준일')}
				${JRBACondEL.getJRBASelect('','RPT_GJDT' ,'' ,'140px' ,'JRBA_common_getRPT_GJDT' ,'' ,'','jipyoSelectChange("JIPYO_C", "A001", this, "onAftreRptGjdtCdList()")')}
     		</div>
     		<div class="table-cell">
     			${condel.getLabel('RBA_90_01_01_02_004','위험구분')}
	          	${JRBACondEL.getJRBASelect('MAX','JIPYO_C' ,'A001' ,'140px' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_CATG", "A002", this, "onAftreJipyoCCdList()")')}
     		</div>
     	</div>
    	<div class="table-row" style="width:20%;">
     		<div class="table-cell">
     			${condel.getLabel('RBA_90_01_01_02_002','지표번호')}
	            ${condel.getInputCustomerNo('JIPYO_IDX')}
     		</div>
     		<div class="table-cell">
     			${condel.getLabel('RBA_90_01_01_02_005','카테고리')}
				${JRBACondEL.getJRBASelect('','RSK_CATG' ,'A002' ,'' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_FAC", "A003", this)')}
     		</div>
     	</div>
    	<div class="table-row" style="width:21%;">
     		<div class="table-cell">
     			${condel.getLabel('RBA_90_01_01_02_003','지표명')}
	         	${condel.getInputCustomerNo('JIPYO_NM')}
     		</div>
     		<div class="table-cell">
     			${condel.getLabel('RBA_90_01_01_02_006','항목')}
				${JRBACondEL.getJRBASelect('','RSK_FAC' ,'A003' ,'' ,'' ,'' ,'ALL','')}
     		</div>
     	</div>
    	<div class="table-row" style="width:38%;">
     		<div class="table-cell">
     			${condel.getLabel('RBA_90_01_01_02_007','평가구분')}
				${JRBACondEL.getJRBASelect('MAX','VALT_G' ,'A007' ,'' ,'' ,'' ,'ALL','')}
     		</div>
     		<div class="table-cell" style="border-bottom: 1px solid #dedede"></div>
     	</div>
     </div>
	<div class="button-area">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
	<% if ( "104".equals(ROLEID) ) { %> <!-- 본점책임자 -->
		${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"apprBtn", defaultValue:"승인", mode:"C", function:"doApproval(2)", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"denyBtn", defaultValue:"반려", mode:"C", function:"doApproval(1)", cssClass:"btn-36"}')}
	<% } else if ( "4".equals(ROLEID) ) { %> <!-- 본점담당자 -->
		${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
	<% } %>
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"excelMakeBtn", defaultValue:"보고파일생성", mode:"R", function:"doReportFileDownload", cssClass:"btn-36"}')}
    </div>
    <div class="inquiry-table" id="condBox2" style="margin-top:10px;">
    	<div class="table-row">
    		<div class="table-cell">
			${condel.getLabel('RBA_90_01_01_01_026','최종승인여부')}
			<div class="content" style="width:100px">
				<input type="text" class="input_text" id="lastApprovalState" name="lastApprovalState" maxlength="5" style="width:100%;" readonly />
			</div>
			&nbsp;&nbsp;${condel.getLabel('RBA_90_01_01_01_027','결재상태')}
			<div class="content">
				<input type="text" class="input_text" id="approvalState" name="approvalState" maxlength="10" readonly />
			</div>
			&nbsp;${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"apprHistoryBtn", defaultValue:"결재이력", mode:"R", function:"doSrarchGYLJHistory", cssClass:"btn-36"}')}
       		</div>
       	</div>
   </div>
	<div class="tab-content-bottom" style="margin-top: 8px;">
	        <div id="GTDataGrid1_Area"></div>
	</div>
	<div class="button-area" id="condBox2">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"attachFile", defaultValue:"첨부파일", mode:"R", function:"Filesave_OpenPop", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
    </div>
	<div class="tab-content-bottom" style="margin-top: 8px;">
	    <div id="GTDataGrid2_Area"></div>
 	</div>
  	<div id="notice" name="notice" style="Z-INDEX: 0; LEFT: 25px; WIDTH: 350px; POSITION: absolute; TOP: 220px; HEIGHT: 150px; display:none">
		<!---------------------------------------------------------------------------- -->
		<iframe id='frame_notice' name="frame_notice" frameborder="0" width="100%" height="100%" scrolling="no" ></iframe>
		<!---------------------------------------------------------------------------- -->
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />