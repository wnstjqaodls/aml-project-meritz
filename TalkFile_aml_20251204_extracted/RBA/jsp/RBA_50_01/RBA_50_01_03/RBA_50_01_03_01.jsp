<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_03_01.jsp
* Description     : 사용자관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-27
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<style type="text/css">
    * { white-space: nowrap;}
</style>
<script language="JavaScript">
    
    var GridObj1;
    var overlay = new Overlay();
    var classID= "RBA_50_01_03_01";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        setupFilter("init");
    });
    
    // Initial function
    //function init() { initPage(); }
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
        	onToolbarPreparing		: makeToolbarButtonGrids,	
        	"width" 						: "100%",
    		"height"						:"calc(85vh - 100px)",
    		hoverStateEnabled    	: true,
    	    wordWrapEnabled      	: false,
    	    allowColumnResizing  	: true,
    	    columnAutoWidth      	: true,
    	    allowColumnReordering	: true,
    	    cacheEnabled 			: false,
    	    cellHintEnabled 		: true,
    	    showBorders 			: true,
    	    showColumnLines 		: true,
    	    showRowLines 			: true,
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
            sorting         : {mode   : "multiple"},
    	    loadPanel       : {enabled: false},
    	    remoteOperations			: {filtering: false,grouping: false,paging: false,sorting: false,summary: false},
    	    editing						: {mode: "batch",allowUpdating: false, allowAdding  : false,allowDeleting: false},
    	    filterRow            			: {visible: false},
    	    rowAlternationEnabled	: false,
    	    searchPanel          		: {visible: false,width: 250},
    	    selection						: {allowSelectAll: false, deferred: false, mode: "multiple",selectAllMode: "page", showCheckBoxesMode: "always"},
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
    	    columns: [
    	    	{dataField: "HGRK_BRNO_NM", 	caption: '${msgel.getMsg("RBA_50_01_03_01_100","상위부서명")}', 		visible: false}, 
    	        {dataField: "HGRK_BRNO",		caption: '${msgel.getMsg("RBA_50_01_03_01_101","상위부서코드")}',		visible: false},
    	        {dataField: "BRNO",				caption: '${msgel.getMsg("RBA_50_01_02_01_003","부서코드")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true,width : "10%"}, 
    	        {dataField: "BRNO_NM",			caption: '${msgel.getMsg("RBA_50_01_02_01_004","부서명")}',			alignment: "center",allowResizing: true,allowSearch  : true,allowSorting : true,width : "200"},
    	        {dataField: "AML_TJ_BRNO_YN",	caption: '${msgel.getMsg("RBA_50_01_02_01_007","AML통제부서여부")}',		alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true,cssClass: "link",width: "120px",visible: false}, 
    	        {dataField: "BRNO3",			caption: '${msgel.getMsg("RBA_50_01_03_01_102","지점담당자")}',			alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,width: "30%"}, 
    	        {dataField: "BRNO6",			caption: '${msgel.getMsg("RBA_50_01_03_01_103","지점책임자")}',			alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,width : "15%"}, 
    	        {dataField: "BRNO4",			caption: '${msgel.getMsg("RBA_50_01_03_01_104","본점담당자")}',			alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,width : "15%"}, 
    	        {dataField: "BRNO5",			caption: '${msgel.getMsg("RBA_50_01_03_01_105","본점책임자")}',			alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,width : "15%"}
    	    ],
    	    onCellClick: function(e){
    	        /* if(e.data){
    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        } */
    	        if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
    	        } else {
    	            e.component.clearSelection();
    	            e.component.selectRowsByIndexes(e.rowIndex);
    	        }
    	    },
    	    onInitialized : function(e) {
	        	doSearch();
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
                        ,"hint"      : '필터'
                        ,"disabled"  : false
                        ,"onClick"   : function(){
								setupFilter();
                        }
                 }
            });
        }
    }    
    
    // 검색조건 셋업
    function setupConditions() {
    	try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(280, 90, 0);
            cbox1.setItemWidths(600, 90, 1);
        } catch (e) {
            showAlert(e.message,'ERR');
        }
    }
    
    //사용자 조회 
    function doSearch() {
    	
    	overlay.show(true, true);

        var params = new Object();
        var methodID = "doSearch";
		var classID  = "RBA_50_01_03_01";
		overlay.show(true, true);
		params.pageID 	= "RBA_50_01_03_01";
		params.HGRK_BRNO_NM   = form.HGRK_BRNO_NM.value;//기준연도
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
    }
    
    //자금세탁 사례관리 조회 end
    function doSearch_end(gridData, data) {
        overlay.hide();
        GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    }

    function doSearch_fail() {
        console.log("doSearch_fail");
    }
    
    // 사용자 권한 팝업 호출
    function doChange() {
    	
        var selectedRows  = GridObj1.getSelectedRowsData();
        var selectedHead  = GridObj1.getSelectedRowsData();
        var selSize       = selectedRows.length;
	    if(selSize >= 2){
	        showAlert("${msgel.getMsg('RBA_50_01_03_012','하나의 데이터를 선택하십시오.')}","WARN"); 
	        return;
	    }
        if(selSize == 0){
            showAlert("${msgel.getMsg('RBA_50_01_03_013','변경할 데이터를 선택하십시오.')}","WARN"); 
            return;
        }
    
        var obj = new Object();
        obj.BRNO         = selectedHead[0].BRNO;
        obj.BRNO_NM      = selectedHead[0].BRNO_NM;
    	
        form2.classID.value    = classID;
        form2.pageID.value     = "RBA_50_01_03_02";
        form2.BRNO.value       = obj.BRNO;
        form2.BRNO_NM.value    = obj.BRNO_NM;
        var win;           win = window_popup_open("RBA_50_01_03_02", 850, 550, '','no');
        form2.target           = form2.pageID.value;
        form2.action           = '<c:url value="/"/>0001.do';
        form2.submit();
    }
    
</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BRNO" >
    <input type="hidden" name="BRNO_NM" >
</form>
<form name="form" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">    
    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row" style="width:100%;">
            <div class="table-cell">
            	<div class="title">
            		<div class="txt">${msgel.getMsg('RBA_50_01_03_014','부서명')}</div>
            	</div>
            	<div class="content">
            		<input name="HGRK_BRNO_NM" type="text" value="" class="cond-input-text" size="70" />
            	</div>
            </div>
        </div>
    </div>
   	<div class="button-area" style="display: flex;justify-content: flex-end;">
    		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"alterationBtn", defaultValue:"변경", mode:"U", function:"doChange", cssClass:"btn-36"}')}
       </div>
    
    <div class="tab-content-bottom" style="margin-top: 8px;">
        <div id="GTDataGrid1_Area"></div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />