<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_02_02_04.jsp
* Description     : 부서별 업무프로세스 결재 상세 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-08
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String GYLJ_ID = request.getParameter("GYLJ_ID");
    request.setAttribute("GYLJ_ID", GYLJ_ID);
%>
<script language="JavaScript">
    
    var GridObj1;
    var classID = "RBA_50_02_02_04";
    var overlay  = new Overlay();
    // Initialize
    $(document).ready(function(){
        setupGrids();
        doSearch();
        setupFilter("init");
    });
    
    // Initial function
    function init(){
        initPage();
    }
    
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
		// gridObj.title    = "타이틀";    	
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
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
	                   	,"elementAttr": { class: "btn-28 filter popupFilter" }
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
    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
        // 그리드1(Code Head) 초기화
        
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
			 height	:"calc(90vh - 100px)",
			 hoverStateEnabled    : true,
			    wordWrapEnabled      : false,
			    allowColumnResizing  : true,
			    columnAutoWidth      : true,
			    allowColumnReordering: true,
			    cacheEnabled         : false,
			    cellHintEnabled      : true,
			    export               : {
			        allowExportSelectedData: true,
			        enabled                : true,
			        excelFilterEnabled     : true,
			        fileName               : "gridExport"
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
			        allowUpdating: false,
			        allowAdding  : false,
			        allowDeleting: false
			    },
			    filterRow            : {visible: false},
			    rowAlternationEnabled: true,
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
			    searchPanel          : {
			        visible: false,
			        width  : 250
			    },
			    onToolbarPreparing   : makeToolbarButtonGrids,
			    selection: {
			        allowSelectAll    : true,
			        deferred          : false,
			        mode              : "single",
			        selectAllMode     : "allPages",
			        showCheckBoxesMode: "onClick"
			    },
			    columns: [
			        {
			            dataField    : "GYLJ_ID",
			            caption      : '결재ID',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "GYLJ_SER",
			            caption      : '${msgel.getMsg("RBA_50_05_04_007","순번")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width        : 70
			        }, {
			            dataField    : "ROLE_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_02_04_100","결재단계")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "GYLJ_S_C_NM",
			            caption      : '${msgel.getMsg("RBA_50_07_02_01_002","결재상태")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "GYLJ_DT",
			            caption      : '${msgel.getMsg("RBA_50_02_02_04_101","결재일자")}',
			            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "HNDL_JKW_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_02_04_102","처리자")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "HNDL_DEP_NM",
			            caption      : '처리지점',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "NOTE_CTNT",
			            caption      : '${msgel.getMsg("RBA_50_02_02_04_103","결재사유")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "HNDL_DY_TM",
			            caption      : '${msgel.getMsg("RBA_50_02_02_04_104","처리일시")}',
			            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text,"long")); },
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }
			    ]
	        }).dxDataGrid("instance");	
    }
    
    // 결재상태 요청자 조회
    function doSearch(){
    	overlay.show(true, true);
        var params   = new Object();
    	var methodID = "doSearch";
    	var classID  = "RBA_50_02_02_04";
    	 		
    	params.pageID 	= "RBA_50_02_02_04";
    	params.GYLJ_ID 	=  "${GYLJ_ID}";

    	sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
    }
    
    // 결재상태 요청자 조회 end
   function doSearch_success(gridData, data){
        try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
   		} catch (e) {
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
    
    function doSearch_fail(){    	 
    	overlay.hide();
    }
    
</script>

<form name="form" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
    <div class="panel panel-primary">
        <div id="GTDataGrid1_Area"></div>
    </div>
    <div class="panel panel-primary">
    	<div align="right" style="margin-top: 8px">
    	 	<span>
                ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
            </span>
    	</div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 