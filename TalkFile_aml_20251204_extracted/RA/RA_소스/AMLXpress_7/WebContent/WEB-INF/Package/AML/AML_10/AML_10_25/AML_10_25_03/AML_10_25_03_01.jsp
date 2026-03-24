<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
- File Name  : AML_10_25_03_01.jsp
- Author     : 
- Comment    : 신상품 
- Version    : 1.0
- history    : 1.0 2025-07-08
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%
    String sDate = DateUtil.addDays(DateUtil.getDateString(), -30, "yyyy-MM-dd");
    String eDate =DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");

    request.setAttribute("stDate",sDate);
    request.setAttribute("edDate",eDate);
    
    String ROLEID = sessionAML.getsAML_ROLE_ID();
  	request.setAttribute("ROLEID", ROLEID);
  	String AML_BDPT_CD_NAME = sessionAML.getsAML_BDPT_CD_NAME();
  	request.setAttribute("AML_BDPT_CD_NAME", AML_BDPT_CD_NAME);
  	String AML_BDPT_CD     = sessionAML.getsAML_BDPT_CD();
  	request.setAttribute("AML_BDPT_CD", AML_BDPT_CD);
  	
  	DataObj inputApr = new DataObj();
  	inputApr.put("DEP_DESC",AML_BDPT_CD);
    com.gtone.aml.basic.common.data.DataObj obj = null;
    
    try{
        obj = com.gtone.aml.dao.common.MDaoUtilSingle.getData("AML_DEP_ID_SEARCH",inputApr);
   }catch(AMLException e){
       Log.logAML(Log.ERROR, e);
   }
 	
 	String depid = obj.getText("DEP_ID");
 	request.setAttribute("depid",depid);
%> 


<script language="JavaScript"> 

    var GridObj1 = null;
    var GridObj2 = null;
    var GridObj3 = null;
    var overlay = new Overlay();
    var pageID	 = "AML_10_25_03_01";	
	var classID  = "AML_10_25_03_01";
	var ROLEID   = "${ROLEID}";
	var AML_BDPT_CD_NAME = "${AML_BDPT_CD_NAME}";
	var AML_BDPT_CD = "${AML_BDPT_CD}";
	var depid = "${depid}";
    
    // [ Initialize ]
    $(document).ready(function(){
    	setupGrids();
    	setupTabPanel(0);
    	    	
    	// 텝 클릭 이벤트
        $(".mngtab-item").click(function(e){
        	setupTabPanel($(this).index());
        });
    	
        if(ROLEID == "4" || ROLEID == "104" || ROLEID == "7") {
  		  $("#depidsearch").show();
  		  $("#depidsearch2").show();
  		  $("#depidsearch3").show();
  	  	}else {
  		  $("#depidsearch").hide();
  		  $("#depidsearch2").hide();
  		  $("#depidsearch3").hide();
  	  	}
    });
    
    /** 탭 셋업 */
    function setupTabPanel(defTabIdx)
    {
        var indx = defTabIdx || 0;
        var tabItm = $(".mngtab-item");
        var tabCon = $(".mngtab-content");

        //탭 헤드 활성 클래스 제거
        tabItm.each(function (idx,item) {
       	    $(item).removeClass("active");
        });

        //탭 영역 활성 클래스 제거 및 숨김처리
        tabCon.each(function (idx,item) {
    		$(item).removeClass("active");
    	    $(item).css("display","none");
    	});

        //선택한 index영역만 활성 처리
        $(tabItm[indx]).addClass("active");
        $(tabCon[indx]).addClass("active");
        $(tabCon[indx]).css("display","block");
        
        if(indx == 0) {
        	doSearch();
        } else if(indx == 1) {
        	doSearch1();
        } else {//indx == 2
        	doSearch2();
        }
    }
    
    function setupGrids()
    {
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
               width		 			: "100%",
               height		 			: "calc(60vh)",
               elementAttr: { class: "grid-table-type" },
           	gridId          		: "GTDataGrid1",
       	    "hoverStateEnabled"		: true,
       	    "wordWrapEnabled"		: false,
       	    "allowColumnResizing"	: true,
       	    "columnAutoWidth"		: true,
       	    "allowColumnReordering"	: true,
       	    "columnResizingMode"   	: "widget",  /* "widget" "nextColumn" */
       	    "cacheEnabled"			: false,
       	    "cellHintEnabled"		: true,
       	    "showBorders"			: true,
       	    "showColumnLines"		: true,
       	    "showRowLines"			: true,
       	    "loadPanel" 			: { enabled: false },
       	    "scrolling" 			: {mode: "standard"},
			/* "onToolbarPreparing"	: makeToolbarButtonGrids, */
       	    "export"				:{
       	        "allowExportSelectedData": false,
       	        "enabled": true,
       	        "excelFilterEnabled": true,
       	        "fileName": "임시평가 등록상품 조회"
       	    },
       	    "sorting"				: {"mode": "multiple"},
       	    "remoteOperations"		: {
       	        "filtering": false,
       	        "grouping": false,
       	        "paging": false,
       	        "sorting": false,
       	        "summary": false
       	    },
       	    "editing"				: {
       	        "mode": "batch",
       	        "allowUpdating": false,
       	        "allowAdding": false,
       	        "allowDeleting": false
       	    },
       	    "filterRow"				: {"visible": false},
       	    "rowAlternationEnabled"	: true,
       	    "columnFixing"			: {"enabled": true},
       	    "searchPanel"			:{
       	        "visible": false,
       	        "width": 250
       	    },
       	    pager: {
	   	    	visible: true
	   	    	,showNavigationButtons: true
	   	    	,showInfo: true
	   	    },
	   	    paging: {
	   	    	enabled : true
	   	    	,pageSize : 20
	   	    },
       	        "selection"         	: {
       	        "allowSelectAll"    : true
       	       ,"deferred"          : false
       	       ,"mode"              : "multiple"
       	       ,"selectAllMode"     : "allPages"
       	       ,"showCheckBoxesMode": "none"
       	    },
       	    onCellPrepared        : function(e){
       	    	var columnName = e.column.dataField;
       	        var rowType = e.rowType;
       	        var dataGrid   = e.component;
       	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
       	        var classnm = dataGrid.cellValue(rowIndex, 'RSK_GRD_NM');
       	        if(classnm === ''){
       	        	e.cellElement.css('background-color', '#CCCCCC');
       	        }
       	        if(columnName == 'RSK_GRD_NM'){
       	        	if(classnm === "당연고위험") e.cellElement[0].innerHTML = "<span class='criterion-tag veryhigh' style='width:100px;'>" + classnm + "</span>"
       	        	else if(classnm === "고위험") e.cellElement[0].innerHTML = "<span class='criterion-tag high' style='width:100px;'>" + classnm + "</span>"
       	        	else if(classnm === "중위험") e.cellElement[0].innerHTML = "<span class='criterion-tag medium' style='width:100px;'>" + classnm + "</span>"
       	        	else if(classnm === "저위험") e.cellElement[0].innerHTML = "<span class='criterion-tag low' style='width:100px;'>" + classnm + "</span>"
       	        	else if(classnm === "초저위험") e.cellElement[0].innerHTML = "<span class='criterion-tag verylow' style='width:100px;'>" + classnm + "</span>"
       	        }
   		    },
       	    "columns": [
       	        {"dataField": "GDS_TYP","caption": '${msgel.getMsg("AML_10_25_02_01_002","상품유형")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true, "visible": true},
       	        {"dataField": "PRDT_ALIS","caption": '상품코드',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": true}, 
       	        {"dataField": "PRDT_NM","caption": '상품명',"alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": true},
       	        {"dataField": "DTBR_CODE","caption": '${msgel.getMsg("AML_10_25_03_01_004","상품등록부서")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": false},
       	        {"dataField": "DTBR_CODE_NM","caption": '${msgel.getMsg("AML_10_25_03_01_004","상품등록부서")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": true},
       	        {"dataField": "GDS_REG_USER","caption": '상품등록자',
       	        	"columns":
        	        	[{
    			            "dataField"    : "EMPY_NO"
    						,"caption"       : '${msgel.getMsg("AML_10_23_01_01_101","사번")}'
    						,"alignment"     : "center"
    						,"allowResizing" : true
    						,"allowSearch"   : true
    						,"allowSorting"  : true
    						,"allowEditing"  : false
    					},{
    			            "dataField"    : "EMPY_NAME"
       						,"caption"       : '${msgel.getMsg("AML_10_07_01_01_050","성명")}'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					}]
       	        },
       	        {"dataField": "RTNG_APLY_DATE","caption": '${msgel.getMsg("AML_10_25_03_01_005","상품등록일")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": true,
       	        	"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }},
      	        	{"dataField": "TEMP_EVAL_INFO","caption": '임시평가정보',
       	        	"columns":
           	        	[{
       			            "dataField"    : "PRD_EVLTN_ID"
       						,"caption"       : '임시평가일련번호'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "PRD_NM"
       						,"caption"       : '임시평가명'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "RSK_GRD_NM"
       						,"caption"       : '위험등급'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "RSK_GRD"
       						,"caption"       : '${msgel.getMsg("AML_10_25_01_01_006","위험등급")}'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       						,"visible"		 : false
       					}]
          	        },
       	    ]
       	    ,"onCellClick": function(e){ 
       	    	if(e.data ){  
       	    		Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);        
        	    }
        	}
        }).dxDataGrid("instance");
        
        GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
            width		 			: "100%",
            height		 			: "calc(60vh)",
            elementAttr: { class: "grid-table-type" },
        	gridId          		: "GTDataGrid2",
    	    "hoverStateEnabled"		: true,
    	    "wordWrapEnabled"		: false,
    	    "allowColumnResizing"	: true,
    	    "columnAutoWidth"		: true,
    	    "allowColumnReordering"	: true,
    	    "columnResizingMode"   	: "widget",  /* "widget" "nextColumn" */
    	    "cacheEnabled"			: false,
    	    "cellHintEnabled"		: true,
    	    "showBorders"			: true,
    	    "showColumnLines"		: true,
    	    "showRowLines"			: true,
    	    "loadPanel" 			: { enabled: false },
    	    "scrolling" 			: {mode: "standard"},
			/* "onToolbarPreparing"	: makeToolbarButtonGrids, */
    	    "export"				:{
    	        "allowExportSelectedData": true,
    	        "enabled": true,
    	        "excelFilterEnabled": true,
    	        "fileName": "기존상품 수정건 조회"
    	    },
    	    "sorting"				: {"mode": "multiple"},
    	    "remoteOperations"		: {
    	        "filtering": false,
    	        "grouping": false,
    	        "paging": false,
    	        "sorting": false,
    	        "summary": false
    	    },
    	    "editing"				: {
    	        "mode": "batch",
    	        "allowUpdating": false,
    	        "allowAdding": false,
    	        "allowDeleting": false
    	    },
    	    "filterRow"				: {"visible": false},
    	    "rowAlternationEnabled"	: true,
    	    "columnFixing"			: {"enabled": true},
    	    "searchPanel"			:{
    	        "visible": false,
    	        "width": 250
    	    },
    	    pager: {
	   	    	visible: true
	   	    	,showNavigationButtons: true
	   	    	,showInfo: true
	   	    },
	   	    paging: {
	   	    	enabled : true
	   	    	,pageSize : 20
	   	    },
    	        "selection"         	: {
    	        "allowSelectAll"    : true
    	       ,"deferred"          : false
    	       ,"mode"              : "multiple"
    	       ,"selectAllMode"     : "allPages"
    	       ,"showCheckBoxesMode": "always"
    	    },
    	    onCellPrepared        : function(e){
    	    	var columnName = e.column.dataField;
    	        var rowType = e.rowType;
    	        var dataGrid   = e.component;
    	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
    	        var classnm = dataGrid.cellValue(rowIndex, 'EVAL_RSK_GRD_NM');
    	        var classnm2 = dataGrid.cellValue(rowIndex, 'CHK_YN');
    	        if(classnm === ''){
    	        	e.cellElement.css('background-color', '#CCCCCC');
    	        }
    	        if(columnName == 'EVAL_RSK_GRD_NM'){
    	        	if(classnm === "${msgel.getMsg('AML_21_01_01_01_104', '초고위험')}") e.cellElement[0].innerHTML = "<span class='criterion-tag veryhigh' style='width:100px;'>" + classnm + "</span>"
    	        	else if(classnm === "${msgel.getMsg('AML_21_01_01_01_103', '고위험')}") e.cellElement[0].innerHTML = "<span class='criterion-tag high' style='width:100px;'>" + classnm + "</span>"
    	        	else if(classnm === "${msgel.getMsg('AML_21_01_01_01_102', '중위험')}") e.cellElement[0].innerHTML = "<span class='criterion-tag medium' style='width:100px;'>" + classnm + "</span>"
    	        	else if(classnm === "${msgel.getMsg('AML_21_01_01_01_101', '저위험')}") e.cellElement[0].innerHTML = "<span class='criterion-tag low' style='width:100px;'>" + classnm + "</span>"
    	        	else if(classnm === "${msgel.getMsg('AML_21_01_01_01_100', '초저위험')}") e.cellElement[0].innerHTML = "<span class='criterion-tag verylow' style='width:100px;'>" + classnm + "</span>"
    	        }
    	        if(columnName == 'CHK_YN'){
    	        	if(classnm2 === "${msgel.getMsg('AML_10_25_03_01_022', '미확인')}") e.cellElement.css('color', 'red');
    	        }
		    },
    	    "columns": [
    	    	{"dataField": "GDS_UPD_INFO","caption": '상품 수정 등록정보',
    	        	"columns":
        	        	[{
    			            "dataField"    : "GDS_TYP"
    						,"caption"       : '상품유형'
    						,"alignment"     : "center"
    						,"allowResizing" : true
    						,"allowSearch"   : true
    						,"allowSorting"  : true
    						,"allowEditing"  : false
    					},{
    			            "dataField"    : "GDS_CD"
       						,"caption"       : '상품코드'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					},{
    			            "dataField"    : "GDS_NM"
       						,"caption"       : '상품명'
       						,"alignment"     : "left"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					},{
    			            "dataField"    : "GDS_REG_DEPT"
       						,"caption"       : '상품등록부서'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       						,"visible"       : false
       					},{
    			            "dataField"    : "GDS_REG_DEPT1"
           						,"caption"       : '상품등록부서'
           						,"alignment"     : "center"
           						,"allowResizing" : true
           						,"allowSearch"   : true
           						,"allowSorting"  : true
           						,"allowEditing"  : false
           				},{"dataField": "GDS_UPD_USER","caption": '상품 수정 등록자',
       	    	        	"columns":
       	        	        	[{
       	    			            "dataField"    : "GDS_UPD_USER_ID"
       	    						,"caption"       : '${msgel.getMsg("AML_10_23_01_01_101","사번")}'
       	    						,"alignment"     : "center"
       	    						,"allowResizing" : true
       	    						,"allowSearch"   : true
       	    						,"allowSorting"  : true
       	    						,"allowEditing"  : false
       	    					},{
       	    			            "dataField"    : "GDS_UPD_USER_NM"
       	       						,"caption"       : '${msgel.getMsg("AML_10_07_01_01_050","성명")}'
       	       						,"alignment"     : "center"
       	       						,"allowResizing" : true
       	       						,"allowSearch"   : true
       	       						,"allowSorting"  : true
       	       						,"allowEditing"  : false
       	       					}]
       					},{
    			            "dataField"    : "GDS_UPD_DT"
       						,"caption"       : '${msgel.getMsg("AML_10_25_03_01_014","상품 수정 등록일")}'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       						,"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }
       					},{
    			            "dataField"    : "UPD_DESC"
       						,"caption"       : '변경/수정사항 요약'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       	    	        }]
    	        },
    	    	{"dataField": "RSK_EVAL_INFO","caption": '위험평가정보',
    	        	"columns":
           	        	[{
       			            "dataField"    : "EVAL_NO"
       						,"caption"       : '평가일련번호'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "EVAL_GDS_NM"
       						,"caption"       : '상품/서비스명'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "EVAL_RSK_GRD_NM"
       						,"caption"       : '위험등급'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "EVAL_RSK_GRD_CD"
       						,"caption"       : '위험등급'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       						,"visible"		 : false
       					},{
       			            "dataField"    : "EVAL_DT"
       						,"caption"       : '평가일자'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       						,"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }
       					}]
    	        },
    	    	{"dataField": "MONITOR_RESULT","caption": '${msgel.getMsg("AML_10_25_03_01_012","모니터링 결과")}',
    	        	"columns":
           	        	[{
       			            "dataField"    : "CONFIRM_YN"
       						,"caption"       : '확인여부'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : false
       						,"visible"       : false
       					},{
       			            "dataField"    : "CONFIRM_DT"
       						,"caption"       : '확인일자'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : true
       						,"allowEditing"  : true
       						,"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }
       					}]
    	        }
    	    ]
    	    ,"onCellClick": function(e){ 
    	    	if(e.data ){  
    	    		Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);        
    	    	}
	    	}
	    }).dxDataGrid("instance");
        
        GridObj3 = $("#GTDataGrid3_Area").dxDataGrid({
            width		 			: "100%",
            height		 			: "calc(60vh)",
            elementAttr: { class: "grid-table-type" },
        	gridId          		: "GTDataGrid3",
    	    "hoverStateEnabled"		: true,
    	    "wordWrapEnabled"		: false,
    	    "allowColumnResizing"	: true,
    	    "columnAutoWidth"		: true,
    	    "allowColumnReordering"	: true,
    	    "columnResizingMode"   	: "widget",  /* "widget" "nextColumn" */
    	    "cacheEnabled"			: false,
    	    "cellHintEnabled"		: true,
    	    "showBorders"			: true,
    	    "showColumnLines"		: true,
    	    "showRowLines"			: true,
    	    "loadPanel" 			: { enabled: false },
    	    "scrolling" 			: {mode: "standard"},
			/* "onToolbarPreparing"	: makeToolbarButtonGrids, */
    	    "export"				:{
    	        "allowExportSelectedData": true,
    	        "enabled": true,
    	        "excelFilterEnabled": true,
    	        "fileName": "평가건별 복수상품 매핑건 조회"
    	    },
    	    "sorting"				: {"mode": "multiple"},
    	    "remoteOperations"		: {
    	        "filtering": false,
    	        "grouping": false,
    	        "paging": false,
    	        "sorting": false,
    	        "summary": false
    	    },
    	    "editing"				: {
    	        "mode": "batch",
    	        "allowUpdating": false,
    	        "allowAdding": false,
    	        "allowDeleting": false
    	    },
    	    "filterRow"				: {"visible": false},
    	    "rowAlternationEnabled"	: true,
    	    "columnFixing"			: {"enabled": true},
    	    "searchPanel"			:{
    	        "visible": false,
    	        "width": 250
    	    },
    	    pager: {
	   	    	visible: false
	   	    	,showNavigationButtons: false
	   	    	,showInfo: false
	   	    },
	   	    paging: {
	   	    	enabled : false
	   	    	,pageSize : 20
	   	    },
    	        "selection"         	: {
    	        "allowSelectAll"    : true
    	       ,"deferred"          : false
    	       ,"mode"              : "multiple"
    	       ,"selectAllMode"     : "allPages"
    	       ,"showCheckBoxesMode": "always"
    	    },
    	    onCellPrepared        : function(e){
    	    	var columnName = e.column.dataField;
    	        var rowType = e.rowType;
    	        var dataGrid   = e.component;
    	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
    	        var classnm = dataGrid.cellValue(rowIndex, 'RSK_GRD_NM');
    	        var classnm2 = dataGrid.cellValue(rowIndex, 'CONFIRM_NM');
    	        /* if(classnm === ''){
    	        	e.cellElement.css('background-color', '#CCCCCC');
    	        } */
    	        if(columnName == 'RSK_GRD_NM'){
    	        	if(classnm === "당연고위험") e.cellElement[0].innerHTML = "<span class='criterion-tag veryhigh' style='width:100px;'>" + classnm + "</span>"
    	        	else if(classnm === "고위험") e.cellElement[0].innerHTML = "<span class='criterion-tag high' style='width:100px;'>" + classnm + "</span>"
    	        	else if(classnm === "중위험") e.cellElement[0].innerHTML = "<span class='criterion-tag medium' style='width:100px;'>" + classnm + "</span>"
    	        	else if(classnm === "저위험") e.cellElement[0].innerHTML = "<span class='criterion-tag low' style='width:100px;'>" + classnm + "</span>"
    	        	else if(classnm === "초저위험") e.cellElement[0].innerHTML = "<span class='criterion-tag verylow' style='width:100px;'>" + classnm + "</span>"
    	        }
    	        if(columnName == 'CONFIRM_NM'){
    	        	if(classnm2 === "미확인") e.cellElement.css('color', 'red');
    	        }
		    },
    	    "columns": [
    	    	{"dataField": "RSK_EVAL_INFO","caption": '위험평가정보',
    	        	"columns":
           	        	[{
    			            "dataField"    : "PRD_TP_NM"
       						,"caption"       : '상품유형'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "PRD_EVLTN_ID"
       						,"caption"       : '평가일련번호'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "PRD_NM"
       						,"caption"       : '상품/서비스명'
       						,"alignment"     : "left"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "RSK_GRD_NM"
       						,"caption"       : '위험등급'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       					},{
       			            "dataField"    : "RSK_GRD"
       						,"caption"       : '위험등급'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       						,"visible"		 : false
       					},{
       			            "dataField"    : "EVLTN_PRF_DT"
       						,"caption"       : '평가일자'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       						,"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }
       					}]
    	        },
    	    	{"dataField": "GDS_REG_INFO","caption": '상품등록정보',
    	        	"columns":
        	        	[{
    			            "dataField"    : "PRDT_ALIS_B"
       						,"caption"       : '상품코드'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       					},{
    			            "dataField"    : "PRDT_ALIS"
           						,"caption"       : '상품코드'
           						,"alignment"     : "center"
           						,"allowResizing" : true
           						,"allowSearch"   : true
           						,"allowSorting"  : false
           						,"allowEditing"  : false
           						,"visible"       : false
           				},{
    			            "dataField"    : "PCPR_ID"
           						,"caption"       : '상품코드'
           						,"alignment"     : "center"
           						,"allowResizing" : true
           						,"allowSearch"   : true
           						,"allowSorting"  : false
           						,"allowEditing"  : false
           						,"visible"       : false
           				},{
    			            "dataField"    : "PRDT_NM"
       						,"caption"       : '상품명'
       						,"alignment"     : "left"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       					},{
    			            "dataField"    : "DTBR_CODE"
       						,"caption"       : '상품등록부서'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       						,"visible"       : false
       					},{
    			            "dataField"    : "DTBR_CODE_NM"
           						,"caption"       : '상품등록부서'
           						,"alignment"     : "center"
           						,"allowResizing" : true
           						,"allowSearch"   : true
           						,"allowSorting"  : false
           						,"allowEditing"  : false
           				},{"dataField": "GDS_REG_USER","caption": '상품등록자',
       	    	        	"columns":
       	        	        	[{
       	    			            "dataField"    : "EMPY_NO"
       	    						,"caption"       : '${msgel.getMsg("AML_10_23_01_01_101","사번")}'
       	    						,"alignment"     : "center"
       	    						,"allowResizing" : true
       	    						,"allowSearch"   : true
       	    						,"allowSorting"  : false
       	    						,"allowEditing"  : false
       	    					},{
       	    			            "dataField"    : "EMPY_NAME"
       	       						,"caption"       : '${msgel.getMsg("AML_10_07_01_01_050","성명")}'
       	       						,"alignment"     : "center"
       	       						,"allowResizing" : true
       	       						,"allowSearch"   : true
       	       						,"allowSorting"  : false
       	       						,"allowEditing"  : false
       	       					}]
       					},{
    			            "dataField"    : "PRCE_DATE_TIME"
       						,"caption"       : '${msgel.getMsg("AML_10_25_03_01_005","상품등록일")}'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       						,"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }
       					},{
    			            "dataField"    : "IFMN_LAST_PRCE_DATE_TIME"
           						,"caption"       : '${msgel.getMsg("AML_10_25_03_01_005","상품등록일")}'
           						,"alignment"     : "center"
           						,"allowResizing" : true
           						,"allowSearch"   : true
           						,"allowSorting"  : false
           						,"allowEditing"  : false
           						,"visible"       : false
           						,"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }
           				}]
    	        },
    	    	{"dataField": "MONITOR_RESULT","caption": '${msgel.getMsg("AML_10_25_03_01_012","모니터링 결과")}',
    	        	"columns":
           	        	[{
       			            "dataField"    : "CONFIRM_YN"
       						,"caption"       : '확인여부'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       						,"visible"       : false
       					},{
       			            "dataField"    : "CONFIRM_NM"
           						,"caption"       : '확인여부'
           						,"alignment"     : "center"
           						,"allowResizing" : true
           						,"allowSearch"   : true
           						,"allowSorting"  : false
           						,"allowEditing"  : false
           						,"visible"       : true
           				},{
       			            "dataField"    : "CONFIRM_DT"
       						,"caption"       : '확인일자'
       						,"alignment"     : "center"
       						,"allowResizing" : true
       						,"allowSearch"   : true
       						,"allowSorting"  : false
       						,"allowEditing"  : false
       						, "visible"      : false
       						,"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }
       					},{
       			            "dataField"    : "CONFIRM_DT2"
           						,"caption"       : '확인일자'
           						,"alignment"     : "center"
           						,"allowResizing" : true
           						,"allowSearch"   : true
           						,"allowSorting"  : false
           						,"allowEditing"  : false
           						,"visible"       : true
           						,"cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); }
           				}]
    	        }
    	    ]
    	    ,"onCellClick": function(e){ 
    	    	if(e.data){  
    	    		Grid3CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);        
    	    	}
	    	}
	    }).dxDataGrid("instance");
    }
    function Grid1CellClick() {}; //필요시 구현
    function Grid2CellClick() {}; //필요시 구현
    function Grid3CellClick() {}; //필요시 구현
    
    function doSearch()
    {
    	overlay.show(true, true);
    	var classID = "AML_10_25_03_01";
    	var methodID = "getSearch";
    	var params = new Object();
    	
    	if(ROLEID == "4" || ROLEID == "104" || ROLEID == "7") {
    		params.BRN_CD_tab = $("#BRN_CD_tab0").val();
    	}else {
    		params.BRN_CD_tab = AML_BDPT_CD;
    	}
    	
    	params.REG_SD_DT = getDxDateVal("GDS_REG_ST_DT_tab0", true);  
        params.REG_ED_DT = getDxDateVal("GDS_REG_ED_DT_tab0", true);
        params.searchgubun = "A";
    	
    	sendService(classID, methodID, params, doSearch_end, doSearch_end);
    }
   	
    function doSearch_end(dataSource)
    {
    	overlay.hide();
    	GridObj1.refresh();
        GridObj1.option("dataSource", dataSource);
    }
    
    function doSearch1()
    {
    	overlay.show(true, true);
    	var classID = "AML_10_25_03_01";
    	var methodID = "getSearch";
    	var params = new Object();
    	
    	if(ROLEID == "4" || ROLEID == "104" || ROLEID == "7") {
    		params.BRN_CD_tab = $("#BRN_CD_tab1").val();
    	}else {
    		params.BRN_CD_tab = AML_BDPT_CD;
    	}
    	params.REG_SD_DT = getDxDateVal("GDS_REG_ST_DT_tab1", true);  
        params.REG_ED_DT = getDxDateVal("GDS_REG_ED_DT_tab1", true);
        params.CONFIRM_YN = $("#monitor_result_tab1").val();
    	params.searchgubun = "B";
    	
    	alert("협의중 입니다.");
    	doSearch1_end();
    	//sendService(classID, methodID, params, doSearch1_end, doSearch1_end);
    }
   	
    function doSearch1_end(dataSource)
    {
    	overlay.hide();
    	GridObj2.refresh();
        GridObj2.option("dataSource", dataSource);
    }
    
    function doSearch2()
    {
    	overlay.show(true, true);
    	var classID = "AML_10_25_03_01";
    	var methodID = "getSearch";
    	var params = new Object();
    	
    	if(ROLEID == "4" || ROLEID == "104" || ROLEID == "7") {
    		params.BRN_CD_tab = $("#BRN_CD_tab2").val();
    	}else {
    		params.BRN_CD_tab = AML_BDPT_CD;
    	}
    	
    	params.REG_SD_DT = getDxDateVal("GDS_REG_ST_DT_tab2", true);  
        params.REG_ED_DT = getDxDateVal("GDS_REG_ED_DT_tab2", true);
        params.CONFIRM_YN = $("#monitor_result_tab2").val();
    	params.searchgubun = "C";
    	
    	sendService(classID, methodID, params, doSearch2_end, doSearch2_end);
    }
   	
    function doSearch2_end(dataSource)
    {
    	overlay.hide();
    	GridObj3.refresh();
        GridObj3.option("dataSource", dataSource);
    }
    
    var search_window = null;
    function popupSearchDept(indx)
    {
        if (search_window != null) search_window.close();
        search_window        =  window_popup_open(form2, 700, 650, '');
        form2.pageID.value   = 'system_popup_dept_page';         
        form2.viewName.value = 'system_popup_dept_page';
        form2.target         = 'system_popup_dept_page';
        form2.action         = "<c:url value='/'/>0001.do";
        form2.IS_MNG.value   = 'N';
        if(indx == 0) form2.FUNC_NM.value  = "changeDeptTab0";
        else if(indx == 1) form2.FUNC_NM.value  = "changeDeptTab1";
        else form2.FUNC_NM.value  = "changeDeptTab2"; //indx == 2
        form2.submit();
        form2.target = '';
    }
    
    function changeDeptTab0(deptInfo)
    {
        //if (deptInfo.depcode == null || deptInfo.depcode =="") return;
        $("#BRN_CD_tab0").val(deptInfo.depcode);
        $("#BRN_NM_tab0").val(deptInfo.depname);
        if (deptInfo.depcode == -1 ){
  		  $("#BRN_CD_tab0").val('');  
        }
    }
    
    function changeDeptTab1(deptInfo)
    {
        //if (deptInfo.depcode == null || deptInfo.depcode =="") return;
        $("#BRN_CD_tab1").val(deptInfo.depcode);
        $("#BRN_NM_tab1").val(deptInfo.depname);
        if (deptInfo.depcode == -1 ){
    		  $("#BRN_CD_tab1").val('');  
          }
    }
    
    function changeDeptTab2(deptInfo)
    {
        //if (deptInfo.depcode == null || deptInfo.depcode =="") return;
        $("#BRN_CD_tab2").val(deptInfo.depcode);
        $("#BRN_NM_tab2").val(deptInfo.depname);
        if (deptInfo.depcode == -1 ){
    		  $("#BRN_CD_tab2").val('');  
          }
    }
    
    function doChkReg(idx) {//tab 1 -> idx = 1, tab 2 -> idx = 2
    	if(idx == "1") {
    		doSave();
    	}else {
    		doSave2();
    	}
    }
    
    function doSave() 
    {
    	var rowsData = GridObj2.getSelectedRowsData();
    	
    	if (rowsData.length == 0) {
            showAlert('${msgel.getMsg("AML_10_03_01_01_001","선택된 데이터가 없습니다")}','WARN');
            return;
        }
    	
    	if (rowsData.length > 1) {
    		showAlert( "${msgel.getMsg('AML_10_25_02_02_056', '1건 이상 입니다. 1건만 선택해주세요.')}", "WARN");
       	 	return;
        }
    	
    	for (var i = 0; i < rowsData.length; i++) {
			var PRDT_ALIS = rowsData[i].PRDT_ALIS_B.trim();
    	}
    	
    	var classID          = "AML_10_25_03_01";
    	var methodID         = "doSave"; 
    	var params           = new Object();
    	
    	showConfirm('${msgel.getMsg("AML_10_25_03_01_025","확인등록 하시겠습니까?")}', "확인",function(){
        	
       	params.pageID    = pageID;
       	params.PRDT_ALIS = PRDT_ALIS;
       	
     	params.searchgubun = "B";
       	sendService(classID, methodID, params, doSave_end, doSave_end);

       	});	
    }
    
    function doSave2() {
    	var rowsData = GridObj3.getSelectedRowsData();
    	
    	if (rowsData.length == 0) {
            showAlert('${msgel.getMsg("AML_10_03_01_01_001","선택된 데이터가 없습니다")}','WARN');
            return;
        }
    	
    	if (rowsData.length > 1) {
    		showAlert( "${msgel.getMsg('AML_10_25_02_02_056', '1건 이상 입니다. 1건만 선택해주세요.')}", "WARN");
       	 	return;
        }
    	
    	for (var i = 0; i < rowsData.length; i++) {
			var PRDT_ALIS = rowsData[i].PRDT_ALIS_B.trim();
    	}
    	showConfirm('${msgel.getMsg("AML_10_25_03_01_025","확인등록 하시겠습니까?")}', "확인",function(){
    		
   		var classID          = "AML_10_25_03_01";
        var methodID         = "doSave"; 
        var params           = new Object();
       	params.pageID        = pageID;
       	params.PRDT_ALIS     = PRDT_ALIS;
       	params.searchgubun   = "C";
       	
       	sendService(classID, methodID, params, doSave2_end, doSave2_end);
       	
    	});	
    }
    
    
    function doChkRegCancel(idx) { //tab 1 -> idx = 1, tab 2 -> idx = 2
    	if(idx == "1") {
			doSave3();
    	}else {
			doSave4();
    	}
    } 
    
    function doSave3()
    {
    	
    	var rowsData = GridObj2.getSelectedRowsData();
    	
    	if (rowsData.length == 0) {
            showAlert('${msgel.getMsg("AML_10_03_01_01_001","선택된 데이터가 없습니다")}','WARN');
            return;
        }
    	
    	for (var i = 0; i < rowsData.length; i++) {
			var PRDT_ALIS = rowsData[i].PRDT_ALIS_B.trim();
    	}
    	
    	var classID          = "AML_10_25_03_01";
    	var methodID         = "doSave2"; 
    	var params           = new Object();
    	
    	showConfirm('${msgel.getMsg("AML_10_25_03_01_026","확인등록 취소 하시겠습니까?")}', "취소",function(){
        	
       	params.pageID    = pageID;
       	params.PRDT_ALIS = PRDT_ALIS;
       	params.searchgubun = "B";
       	
       	sendService(classID, methodID, params, doSave_end, doSave_end);
       	});	
    }
    
    function doSave4()
    {
    	var rowsData = GridObj3.getSelectedRowsData();
    	
    	if (rowsData.length == 0) {
            showAlert('${msgel.getMsg("AML_10_03_01_01_001","선택된 데이터가 없습니다")}','WARN');
            return;
        }
    	
    	for (var i = 0; i < rowsData.length; i++) {
			var PRDT_ALIS = rowsData[i].PRDT_ALIS_B.trim();
    	}
    	
    	var classID          = "AML_10_25_03_01";
    	var methodID         = "doSave2"; 
    	var params           = new Object();
    	
    	showConfirm('${msgel.getMsg("AML_10_25_03_01_026","확인등록 취소 하시겠습니까?")}', "취소",function(){
        	
       	params.pageID    = pageID;
       	params.PRDT_ALIS = PRDT_ALIS;
       	
       	params.searchgubun = "C";
       	sendService(classID, methodID, params, doSave2_end, doSave2_end);
       	});	
    }
    
    function doSave_end() {
    	overlay.hide();
		doSearch1();
    }
    function doSave2_end() {
    	overlay.hide();
		doSearch2();
    }
</script>

<form name="form2" method="post" >
	<input type="hidden" name="pageID"  id="pageID"     />
    <input type="hidden" name="viewName" id="viewName"  />  
    <input type="hidden" name="classID"  id="classID"   />
    <input type="hidden" name="methodID" id="methodID"  />
    <input type="hidden" name="IS_MNG"   id="IS_MNG"    />
    <input type="hidden" name="FUNC_NM"  id="FUNC_NM"   />
</form>


<form name="form1"  method="post" okeydown="doEnterEvent('doSedarch');" >
<input type="hidden" name="pageID" > 
<input type="hidden" name="manualID" > 
<input type="hidden" name="classID" > 
<input type="hidden" name="methodID" > 

<div id="mngCenterArea">
	<ul class="mngtab-list">
		<li class="mngtab-item">
			<button type="button">${msgel.getMsg('AML_10_25_03_01_001','임시평가 등록상품 조회')}</button>
		</li>
		<li class="mngtab-item">
			<button type="button">${msgel.getMsg('AML_10_25_03_01_002','기존상품 수정건 조회')}</button>
		</li>
		<li class="mngtab-item">
			<button type="button">${msgel.getMsg('AML_10_25_03_01_003','평가건별 복수상품 매핑건 조회')}</button>
		</li>
	</ul>
	<div class="tab-content-wrap">
		<div class="mngtab-content" style="display:none;">
			<div class="inquiry-table type1" style="margin-top:5px;">
				<div class="table-row">
					<div class="table-cell">
						<div class="title">
							<span class="txt" title="${msgel.getMsg('AML_10_25_03_01_004','상품등록부서')}">${msgel.getMsg('AML_10_25_03_01_004','상품등록부서')}</span>
						</div>
						<div class="content">
							<input name="BRN_CD_tab0" id="BRN_CD_tab0" type="text"  value="" readonly="readonly" style="width: 100px;display:none;"/>
	                        <input name="BRN_NM_tab0" id="BRN_NM_tab0" type="text" value="${AML_BDPT_CD_NAME}" readonly="readonly" style="width: 140px;"/>
	                        <button id="depidsearch3" type="button" Onclick="popupSearchDept(0);" style="cursor: pointer;margin-left:5px;" class="btn-36">${msgel.getMsg('ADMIN_createMenuForm_040','검색')}</button>
						</div>
					</div>
				</div>
				<div class="table-row">
					<div class="table-cell">
						<div class="title">
							<span class="txt" title="${msgel.getMsg('AML_10_25_03_01_005','상품등록일')}">${msgel.getMsg('AML_10_25_03_01_005','상품등록일')}</span>
						</div>
						<div class="content">
							<div class='calendar'>
								${condel.getInputDateDx('GDS_REG_ST_DT_tab0',stDate)} ~ ${condel.getInputDateDx('GDS_REG_ED_DT_tab0',edDate)}
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		    </div>
		    <div id = "GTDataGrid1_Area" style="padding-top:8px"></div>
		    <table class="basic-table" style="width:100%; margin-top:8px; margin-bottom:0px;">
				<tr>
					<td>
						<p style="color:blue;display:inline-block;">※ ${msgel.getMsg('AML_10_25_03_01_011','시스템 배치로 인해 계정계 상품 등록 D+1일부터 본 화면에서 조회됩니다.')}</p>
					</td>
				</tr>
			</table>
		</div>
		<div class="mngtab-content" style="display:none">
			<div class="inquiry-table type1" style="margin-top:5px;">
				<div class="table-row">
					<div class="table-cell">
						<div class="title">
							<span class="txt" title="${msgel.getMsg('AML_10_25_03_01_004','상품등록부서')}">${msgel.getMsg('AML_10_25_03_01_004','상품등록부서')}</span>
						</div>
						<div class="content">
							<input name="BRN_CD_tab1" id="BRN_CD_tab1" type="text"  value="" readonly="readonly" style="width: 100px;display:none;"/>
	                        <input name="BRN_NM_tab1" id="BRN_NM_tab1" type="text" value="${AML_BDPT_CD_NAME}" readonly="readonly" style="width: 140px;"/>
	                        <button id="depidsearch2" type="button" Onclick="popupSearchDept(1);" style="cursor: pointer;margin-left:5px;" class="btn-36">${msgel.getMsg('ADMIN_createMenuForm_040','검색')}</button>
						</div>
					</div>
				</div>
				<div class="table-row">
					<div class="table-cell">
						<div class="title" style="width:140px;">
							<span class="txt" title="${msgel.getMsg('AML_10_25_03_01_014','상품 수정 등록일')}">${msgel.getMsg('AML_10_25_03_01_014','상품 수정 등록일')}</span>
						</div>
						<div class="content">
							<div class='calendar'>
								${condel.getInputDateDx('GDS_REG_ST_DT_tab1',stDate)} ~ ${condel.getInputDateDx('GDS_REG_ED_DT_tab1',edDate)}
							</div>
						</div>
					</div>
				</div>
				<div class="table-row">
					<div class="table-cell">
						<div class="title">
							<span class="txt" title="${msgel.getMsg('AML_10_25_03_01_012','모니터링 결과')}">${msgel.getMsg('AML_10_25_03_01_012','모니터링 결과')}</span>
						</div>
						<div class="content">
							<select name = "monitor_result_tab1" id="monitor_result_tab1" class="dropdown">
								<option class="dropdown-option"value="ALL" selected>::${msgel.getMsg('AML_10_25_01_01_021','전체')}::</option>
								<option class="dropdown-option"value="E" >${msgel.getMsg('AML_10_25_03_01_021','확인완료')}</option>
								<option class="dropdown-option"value="N" >${msgel.getMsg('AML_10_25_03_01_022','미확인')}</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				<% if ( "4".equals(ROLEID) || "7".equals(ROLEID)) {// 4:컴플라이언스운영팀 담당자,5:컴플라이언스운영팀 책임자,104:보고책임자 %>
				<button type="button" onclick="doChkReg(1)" id="btn_02" class="btn-36" mode="U">${msgel.getMsg('AML_10_25_03_01_023', '확인등록')}</button>
				<button type="button" onclick="doChkRegCancel(1)" id="btn_03" class="btn-36" mode="U">${msgel.getMsg('AML_10_25_03_01_024', '확인등록 취소')}</button>
				<% } %>
				${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch1", cssClass:"btn-36 filled"}')}
		    </div>
		    <div id = "GTDataGrid2_Area" style="padding-top:8px"></div>
		    <table class="basic-table" style="width:100%; margin-top:8px; margin-bottom:0px;">
				<tr>
					<td>
						<p style="color:blue;display:inline-block;">※ ${msgel.getMsg('AML_10_25_03_01_011','시스템 배치로 인해 계정계 상품 등록 D+1일부터 본 화면에서 조회됩니다.')}</p>
					</td>
				</tr>
			</table>
		</div>
		<div class="mngtab-content" style="display:none">
			<div class="inquiry-table type1" style="margin-top:5px;">
				<div class="table-row">
					<div class="table-cell">
						<div class="title">
							<span class="txt" title="${msgel.getMsg('AML_10_25_03_01_004','상품등록부서')}">${msgel.getMsg('AML_10_25_03_01_004','상품등록부서')}</span>
						</div>
						<div class="content">
							<input name="BRN_CD_tab2" id="BRN_CD_tab2" type="text"  value="" readonly="readonly" style="width: 100px;display:none;"/>
	                        <input name="BRN_NM_tab2" id="BRN_NM_tab2" type="text" value="${AML_BDPT_CD_NAME}" readonly="readonly" style="width: 140px;"/>
	                        <button id="depidsearch" type="button" Onclick="popupSearchDept(2);" style="cursor: pointer;margin-left:5px;" class="btn-36">${msgel.getMsg('ADMIN_createMenuForm_040','검색')}</button>
						</div>
					</div>
				</div>
				<div class="table-row">
					<div class="table-cell">
						<div class="title">
							<span class="txt" title="${msgel.getMsg('AML_10_25_03_01_005','상품등록일')}">${msgel.getMsg('AML_10_25_03_01_005','상품등록일')}</span>
						</div>
						<div class="content">
							<div class='calendar'>
								${condel.getInputDateDx('GDS_REG_ST_DT_tab2',stDate)} ~ ${condel.getInputDateDx('GDS_REG_ED_DT_tab2',edDate)}
							</div>
						</div>
					</div>
				</div>
				<div class="table-row">
					<div class="table-cell">
						<div class="title">
							<span class="txt" title="${msgel.getMsg('AML_10_25_03_01_012','모니터링 결과')}">${msgel.getMsg('AML_10_25_03_01_012','모니터링 결과')}</span>
						</div>
						<div class="content">
							<select name = "monitor_result_tab2" id="monitor_result_tab2" class="dropdown">
								<option class="dropdown-option"value="ALL" selected>::${msgel.getMsg('AML_10_28_01_01_005','전체')}::</option>
								<option class="dropdown-option"value="E" >${msgel.getMsg('AML_10_25_03_01_021','확인완료')}</option>
								<option class="dropdown-option"value="N" >${msgel.getMsg('AML_10_25_03_01_022','미확인')}</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="button-area btn-r" style="margin-top:8px;margin-bottom:8px;">
				<% if ( "4".equals(ROLEID) || "7".equals(ROLEID)) {// 4:컴플라이언스운영팀 담당자,5:컴플라이언스운영팀 책임자,104:보고책임자 %>
				<button type="button" onclick="doChkReg(2)" id="btn_05" class="btn-36" mode="U">${msgel.getMsg('AML_10_25_03_01_023', '확인등록')}</button>
				<button type="button" onclick="doChkRegCancel(2)" id="btn_06" class="btn-36" mode="U">${msgel.getMsg('AML_10_25_03_01_024', '확인등록 취소')}</button>
				<% } %>
				${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch2", cssClass:"btn-36 filled"}')}
		    </div>
		    <div id = "GTDataGrid3_Area" style="padding-top:8px"></div>
		    <table class="basic-table" style="width:100%; margin-top:8px; margin-bottom:0px;">
				<tr>
					<td>
						<p style="color:blue;display:inline-block;">※ ${msgel.getMsg('AML_10_25_03_01_011','시스템 배치로 인해 계정계 상품 등록 D+1일부터 본 화면에서 조회됩니다.')}</p>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</form> 

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" /> 
