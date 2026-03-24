<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 결재이력
* Group           : GTONE, R&D센터/개발2본부
* Project         : 결재실행
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

	String ROLE_ID2             = Util.nvl(request.getParameter("ROLE_ID"));
	String GYLJ_ID             = Util.nvl(request.getParameter("GYLJ_ID"));        // 결재ID
	String BAS_YYMM            = Util.nvl(request.getParameter("BAS_YYMM"));        // 
	String TABLE_NM            = Util.nvl(request.getParameter("TABLE_NM"));        // 
	String BRNO                = Util.nvl(request.getParameter("BRNO"));
	String LV3                 = Util.nvl(request.getParameter("LV3"));
	
	
	request.setAttribute("GYLJ_ID"          , GYLJ_ID    );
	request.setAttribute("BAS_YYMM"         , BAS_YYMM   );
	request.setAttribute("TABLE_NM"         , TABLE_NM   );
	request.setAttribute("ROLE_ID2"         , ROLE_ID2 );
	
	request.setAttribute("BRNO"           , BRNO );
	request.setAttribute("LV3"            , LV3 );
	
	

    String USERNAME   = sessionAML.getsAML_USER_NAME();
    String BDPTCDNAME = sessionAML.getsAML_BDPT_CD_NAME();
    String BDPTCD     = sessionAML.getsAML_BDPT_CD();
    String ROLEID     = sessionAML.getsAML_ROLE_ID();
    String ROLENAME   = sessionAML.getsAML_ROLE_NAME();
    //String POSITION_NAME = Util.nvl(request.getParameter("POSITION_NAME"));

    request.setAttribute("USERNAME",USERNAME);
    request.setAttribute("BDPTCDNAME",BDPTCDNAME);
    request.setAttribute("BDPTCD",BDPTCD);
    request.setAttribute("ROLEID",ROLEID);
    request.setAttribute("ROLENAME",ROLENAME);
    //request.setAttribute("POSITION_NAME",POSITION_NAME);


%>
<script>
	var overlay       = new Overlay();
	var pageID        = "RBA_50_04_03_06";
	var classID       = "RBA_50_03_02_02";
	var USERNAME      = "${USERNAME}";
    var BDPTCDNAME    = "${BDPTCDNAME}";
    var BDPTCD        = "${BDPTCD}";
    var ROLEID        = "${ROLEID}";
    var ROLENAME      = "${ROLENAME}";
    var stDate        = "${stDate}";
    //var POSITION_NAME = "${POSITION_NAME}";
    
    
    var GYLJ_ID       = "${GYLJ_ID}";
    var BAS_YYMM      = "${BAS_YYMM}";
    var TABLE_NM      = "${TABLE_NM}";
    var FLAG          = "${FLAG}";
    var ROLE_ID2      = "${ROLE_ID2}";
    
    var BRNO          = "${BRNO}";
    var LV3           = "${LV3}";
    
    
    var GYLJ_ROLE_ID        = "${GYLJ_ROLE_ID}";
    var GYLJ_S_C            = "${GYLJ_S_C}";
    var NEXT_GYLJ_ROLE_ID   = "${NEXT_GYLJ_ROLE_ID}";
    var FIRST_GYLJ          = "${FIRST_GYLJ}";
    var END_GYLJ            = "${END_GYLJ}";
	
    
	$(document).ready(function(){
	    setupGrids1();
	    doSearch();
	});

	function doSearch() {
		var methodID = "doSearchGJ";
        var params = new Object();
        params.pageID      = pageID;
        params.GYLJ_ID     = GYLJ_ID;
        params.BAS_YYMM     = BAS_YYMM;
        params.TABLE_NM     = TABLE_NM;
        
        params.BRNO         = BRNO;
        params.LV3          = LV3;

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}

	function doSearch_success(gridData, data){
    	try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
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
    
    


	// 그리드 초기화 함수 셋업
    function setupGrids1(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(75vh - 56px)",
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
	     	        {dataField: "HNDL_P_NM"		,caption: "결재자"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	        {dataField: "BRN_NM"		,caption: "소속부점"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	      	{dataField: "POSITION_NAME"	,caption: "직위"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 80},
	      	    	{dataField: "HNDL_DY_TM"	,caption: "결재일시"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 150},
	      	  		{dataField: "SN_CCD_YN"		,caption: "반려여부"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 80},
	      			{dataField: "NOTE_CTNT"		,caption: "결재/반려의견"	,alignment: "left"	,allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false}
	      	    ]
	      	    // events
		       ,"onRowInserting" : function(e) {

	     	    }
	     	   ,onCellClick: function(e){
	     		   if(e.rowType != "header" && e.rowType != "filter"){
	     			  Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
	     		   }

                }
	  	}).dxDataGrid("instance");
    }

    
    
</script>

<form name=form1 method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
    <input type="hidden" name="APP_NO" value="${APP_NO}">
    <input type="hidden" name="NOW_SN_CCD" value="${SN_CCD}">
</form>

<div class="tab-content">
	<div class="row" style="padding-top: 8px">
		<h4 class="tab-content-title">결재 이력</h4>
	</div>
	<div class="panel-footer" >
        <div id = "GTDataGrid1_Area"></div>
    </div>	
</div>

<div class="button-area" style="float:right">
    ${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
</div>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />