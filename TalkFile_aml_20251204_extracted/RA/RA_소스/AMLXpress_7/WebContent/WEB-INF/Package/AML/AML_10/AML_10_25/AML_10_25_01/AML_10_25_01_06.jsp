<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 신상품 체크리스트 결재이력
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 
* Since           : 2025.06
--%>

<%@page import="com.gtone.webadmin.util.JSONUtil,com.gtone.webadmin.util.CodeUtil"%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />

<%
	String appNo = Util.nvl( request.getParameter("APP_NO") );
	request.setAttribute("APP_NO", appNo);
%>

<script language="JavaScript">
	
	var GridObj1 = null;
	
	// [ Initialize ]
	$(document).ready(function(){
		
		setupGrids();
		setupFilter("init");
	});
	
	function setupGrids(){
		
	  GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
	         "elementAttr" : { class: "grid-table-type" },
       		 "height"					 : "calc(65vh)",
       	     "hoverStateEnabled"         : true,
   	         "wordWrapEnabled"           : false,
   	         "allowColumnResizing"       : true,
   	         "columnAutoWidth"           : true,
   	         "allowColumnReordering"     : true,
   	         "cacheEnabled"              : false,
   	         "cellHintEnabled"           : true,
   	         "showBorders"               : true,
   	         "showColumnLines"           : true,
   	         "showRowLines"              : true,
   	         "loadPanel"                 : {enabled: false},
   	         "export":{
   	              "allowExportSelectedData": true
   	            , "enabled" : true
   	            , "excelFilterEnabled" : true
   	         },
   	         "onExporting": function (e) {
			    var workbook = new ExcelJS.Workbook();
			    var worksheet = workbook.addWorksheet("Sheet1");
			    DevExpress.excelExporter.exportDataGrid({
			        component: e.component,
			        worksheet:worksheet,
			        autoFilterEnabled: true,
			    }).then(function() {
			        workbook.xlsx.writeBuffer().then(function(buffer) {
			            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "결재이력.xlsx");
			        });
			    });
			    e.cancel = true;
	         },
   	         "sorting":{ "mode" : "multiple" },
   	         "remoteOperations":{
   	            "filtering": false, "grouping": false,"paging": false, "sorting": false, "summary" : false
   	         },
   	         "editing":{
   	             "mode": "batch",	"allowUpdating": false,	"allowAdding": false,	"allowDeleting": false
   	         },
   	         "filterRow": {"visible"     : false},
   	         "onToolbarPreparing"  : makeToolbarButtonGrids,
   	         "rowAlternationEnabled"     : false,
   	         "columnFixing": {"enabled"  : true},
   	         "paging": {"enabled"        : false},
   	         "searchPanel":{
   	             "visible"               : false,
   	             "width"                 : 250
   	         },
   	         "selection":{
   	        	"allowSelectAll": false,
                "deferred": false,
                "mode": "single",
                "selectAllMode": "allPages",
                "showCheckBoxesMode": "none"
   	         },
   	         "columns":[
                    {"dataField":"LOGIN_ID","caption": "${msgel.getMsg('AML_10_25_01_01_009', '사번')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "10%" }
   	              , {"dataField":"USER_NM","caption": "${msgel.getMsg('AML_10_25_01_01_010', '결재자')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "15%" }
   	              , {"dataField":"DPRT_NM","caption": "${msgel.getMsg('AML_10_25_01_01_011', '소속부점')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "15%"}
   	              , {"dataField":"ROLE_NM","caption": "${msgel.getMsg('AML_10_25_01_01_012', '권한구분')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "10%"}
   	              , {"dataField":"HNDL_DY_TM","caption": "${msgel.getMsg('AML_10_25_01_01_013', '결재일자')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "15%"}
   	              , {"dataField":"SN_CCD_NM","caption": "${msgel.getMsg('AML_10_25_01_01_014', '결재상태')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "10%" }
   	              , {"dataField":"RSN_CNTNT","caption": "${msgel.getMsg('AML_10_25_01_01_015', '결재의견')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "25%"}
   	              , {"dataField":"APP_NO", "caption": 'APP_NO', "visible" : false }
   	              , {"dataField":"GYLJ_LINE_G_C", "caption": 'GYLJ_LINE_G_C', "visible" : false }
   	              , {"dataField":"HNDL_P_ENO", "caption": 'HNDL_P_ENO', "visible" : false }
   	              , {"dataField":"BRN_CD", "caption": 'BRN_CD', "visible" : false }
   	              , {"dataField":"APPR_ROLE_ID", "caption": 'APPR_ROLE_ID', "visible" : false }
   	              , {"dataField":"SN_CCD", "caption": 'SN_CCD', "visible" : false }
   	         ],
   	         "onInitialized" : function(e) {
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
	                   	,"elementAttr": { class: "btn-28 filter popupFilter" }
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
	
	function setupFilter(FLAG){
		
		var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;

    	setupGridFilter2(gridArrs,FLAG);
    }
	
	function doSearch(){
		
	    var params = new Object();
	    params.APP_NO = '<c:out value="${APP_NO}"/>';
	    
	    sendService("AML_10_25_01_01", "getApprHstSearch", params, doSearch_end, doSearch_end); 
	}
	
	function doSearch_end(gridData, actionParam){
		
	    GridObj1.option("dataSource", gridData);
	    GridObj1.refresh();
	}
	
	function doClose(){
		
	   window.close();
	}

</script>

<form name="form1" method="post">

    <div class="tab-content-bottom" style="margin-top:15px;">
      <div id="GTDataGrid1_Area"></div>
    </div>
    
    <div class="button-area" style="display:flex; justify-content: flex-end; padding-top: 8px;">
	  ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
    </div>

</form>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 
