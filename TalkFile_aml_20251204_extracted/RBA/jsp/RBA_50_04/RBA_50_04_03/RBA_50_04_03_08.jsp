<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 통제요소 샘플대상 조회
* Group           : GTONE, R&D센터/개발2본부
* Project         : 통제수행
* Author          : JYT
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

 	String BAS_YYYY            = Util.nvl(request.getParameter("BAS_YYYY"));
	String VALT_TRN            = Util.nvl(request.getParameter("VALT_TRN"));        //
	String CNTL_ELMN_C         = Util.nvl(request.getParameter("CNTL_ELMN_C"));        // 
	String BRNO                = Util.nvl(request.getParameter("BRNO"));
	
	
	request.setAttribute("BAS_YYYY"         , BAS_YYYY    );
	request.setAttribute("VALT_TRN"         , VALT_TRN   );
	request.setAttribute("CNTL_ELMN_C"      , CNTL_ELMN_C  );
	request.setAttribute("BRNO"             , BRNO );
	

%>
<script>
	var overlay       = new Overlay();
	var pageID        = "RBA_50_04_03_08";
	var classID       = "RBA_50_04_03_08";
	var BAS_YYYY      = "${BAS_YYYY}";
    var VALT_TRN      = "${VALT_TRN}";
    var CNTL_ELMN_C   = "${CNTL_ELMN_C}";
    var BRNO          = "${BRNO}";
    
	$(document).ready(function(){
		setupGrids();		
        doSearch();
	    
	});
	
	
	
	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			elementAttr: { class: "grid-table-type" },
    		height 				  : "calc(94vh - 106px)",
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
    		rowAlternationEnabled : true,
    		columnFixing: {	enabled: true},
    		dataSource: new DevExpress.data.ArrayStore({
    		   key: ["RSK_ELMT_C_NM"]
    		}),
    		pager: {
    		    visible: true,
    		    showNavigationButtons: true,
    		    showInfo: true
    		},
    		paging: {
    			enabled: false
    		},
    		scrolling: {
    		    mode: "standard",
    		    preloadEnabled: false
    		},
    	    searchPanel: {
    	           visible: false,
    	           width: 250,
    	           searchVisibleColumnsOnly: true
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
		             dataField            : "SNO",
		             caption              : '순번',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 50
		         },
		         {
		             dataField            : "RNMCNO",
		             caption              : '고객번호',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 90
		         },
		         {
		             dataField            : "BRNO_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_007","평가대상부점")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 130
		         },
		         {
		             dataField            : "CUST_NM",
		             caption              : '고객명',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 140
		         },
		         {
		             dataField            : "CUST_EN_NM",
		             caption              : '고객영문명',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 100
		         },
		         {
		             dataField            : "DATA05",
		             caption              : '실명번호',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 100
		         },
		         {
		             dataField            : "CDD_RGDT",
		             caption              : 'CDD등록일자',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 100
		         },
		         {
		             dataField            : "RG_NOTE",
		             caption              : '등록사유',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 140
		         },
		         {
		             dataField            : "PRXY_NM",
		             caption              : '대리인명',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 130
		         },
		         {
		             dataField            : "PRXY_EN_NM",
		             caption              : '대리인영문명',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             cssClass             : "link",
		             width                : 120
		         },
		         {
		             dataField            : "DATA10",
		             caption              : '대리인실명번호',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 100
		         },
		         {
		             dataField            : "PRXY_CDD_RGDT",
		             caption              : '대리인CDD등록일자',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             allowEditing         : false,
		             width                : 80
		         }

		     ],
		     onCellPrepared : function(e){
/* 		          if(e.rowType === 'data' &&
		        		  ( e.column.dataField === 'CNTL_ELMN_C_NM' || e.column.dataField === 'GYLJ_S_C' ) ){
		           e.cellElement.css("color", "blue");
		          } */
		     },
		     onCellClick: function(e){
		    	 /* if(e.rowType === 'data' && ( e.column.dataField === 'CNTL_ELMN_C_NM' ) ){
		    		 if(e.data){
		    	            Grid1CellClick1('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
	    	         }
	    	         if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
	    	         } else {
	    	            e.component.clearSelection();
	    	            e.component.selectRowsByIndexes(e.rowIndex);
	    	         }
			     } else if(e.rowType === 'data' && ( e.column.dataField === 'GYLJ_S_C_NM' ) ){
		    		 if(e.data){
		    	            Grid1CellClick2('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
	    	         }
	    	         if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
	    	         } else {
	    	            e.component.clearSelection();
	    	            e.component.selectRowsByIndexes(e.rowIndex);
	    	         }
			     } */

	    	}

		}).dxDataGrid("instance");
	}
	
	
	
	function doSearch() {
		var methodID = "doSearch";
        var params = new Object();
        params.pageID      = pageID;
        params.BAS_YYYY    = "${BAS_YYYY}";
        params.VALT_TRN    = "${VALT_TRN}";
        params.TONGJE_OPR_VALT_ID    = "${CNTL_ELMN_C}";
        params.BRNO        = "${BRNO}";
        
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}
	
    
    
    function doSearch_success(dataSource) {
    	GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
    	var cnt = dataSource.length;
    	var confirmCnt = 0;
    }

    function doSearch_fail(){
        overlay.hide();
    }

	
	function doClose() {
		self.close();
        opener.doClose();
	}
</script>



<form name=form1 method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >

<div id="GTDataGrid1_Area" ></div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />