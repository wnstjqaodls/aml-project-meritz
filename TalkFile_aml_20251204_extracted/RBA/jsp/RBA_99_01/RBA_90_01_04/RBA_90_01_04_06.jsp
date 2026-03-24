<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_04_06.jsp
- Author     : NHM
- Comment    : 결재이력팝업
- Version    : 1.0
- history    : 1.0 2018-12-11
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %> 
<%
	String RPT_GJDT	= Util.nvl(request.getParameter("RPT_GJDT") , "");
	String GYLJ_ID 	= Util.nvl(request.getParameter("GYLJ_ID") , "");
	request.setAttribute("RPT_GJDT", RPT_GJDT);
	request.setAttribute("GYLJ_ID", GYLJ_ID);
%>
<script language="JavaScript">
	/** 
	 * Initial function 
	 */ 
	var GridObj1 = null;
	var classID  = "RBA_90_01_04_06";
	
	$(document).ready(function(){
		setupGrids();
		doSearch();
		setupFilter("init");
	});

	function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		  elementAttr: { class: "grid-table-type" },
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
    	         "excelFilterEnabled"       : false,
    	         "fileName"                 : "gridExport"
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
    	             "dataField"            : "GYLJ_SER",
    	             "caption"              : '${msgel.getMsg("RBA_90_01_04_06_100","결재단계")}',
    	             "alignment"            : "center",
    	             "allowResizing"        : true,
    	             "allowSearch"          : true,
    	             "allowSorting"         : true,
    	             "width"                : "15%"
    	         },     
    	         {
    	             "dataField"            : "GYLJ_S_C_NM",
    	             "caption"              : '${msgel.getMsg("RBA_90_01_01_01_027","결재상태")}',
    	             "alignment"            : "center",
    	             "allowResizing"        : true,
    	             "allowSearch"          : true,
    	             "allowSorting"         : true,
    	             "width"                : "15%"
    	         },
    	         {
    	             "dataField"            : "DEP_TITLE",
    	             "caption"              : '${msgel.getMsg("RBA_90_01_04_06_101","처리지점")}',
    	             "alignment"            : "center",
    	             "allowResizing"        : true,
    	             "allowSearch"          : true,
    	             "allowSorting"         : true,
    	             "width"                : "15%"
    	         },         
    	         {
    	             "dataField"            : "NOTE_CTNT",
    	             "caption"              : '${msgel.getMsg("RBA_90_01_04_06_102","결재사유")}',
    	             "alignment"            : "center",
    	             "allowResizing"        : true,
    	             "allowSearch"          : true,
    	             "allowSorting"         : true,
    	             "width"                : "25%"
    	         },
    	         {
    	             "dataField"            : "GYLJ_DT",
    	             "caption"              : '${msgel.getMsg("AML_10_03_05_01_106","변경일시")}',
    	             "cellTemplate"      	: function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },             
    	             "alignment"            : "center",
    	             "allowResizing"        : true,
    	             "allowSearch"          : true,
    	             "allowSorting"         : true,
    	             "width"                : "15%"
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
	                    ,"hint"      : '${msgel.getMsg("RBA_90_01_01_01_104","필터")}'
	                    ,"disabled"  : false
	                    ,"onClick"   : function(){
								setupFilter();
	                    }
	             }
	        });
	    }
	}
	   
   	function doSearch() {
   		
		var methodID 		= "doSearch";
		var obj 			= new Object();
	    obj.pageID 			= pageID;
		obj.classID 		= "RBA_90_01_04_06";
		obj.methodID 		= "doConfirm";
		obj.RPT_GJDT		= "${RPT_GJDT}";
		obj.GYLJ_ID			= "${GYLJ_ID}";
		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
	}
   	
   	function doSearch_end(dataSource){
   		GridObj1.refresh();
   	    GridObj1.option("dataSource", dataSource);
   	}
   	
   	
</script>
<form name="form1" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
		<div class="tab-content-bottom" style="padding-top:10px">
	        <div style="width:100%" id="GTDataGrid1_Area"></div>
		</div>
	<div class="tab-content-top"> 	
	<div class="button-area" style="display: flex;justify-content: flex-end; padding-top:8px;">  
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}	
    	</div>
   	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />
