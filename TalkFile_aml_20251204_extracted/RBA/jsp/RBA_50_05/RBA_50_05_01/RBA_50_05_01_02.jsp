<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_01_02.jsp
* Description     : 지표목록 상세 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-05-10
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String PROC_SMDV_C     = request.getParameter("PROC_SMDV_C");
	String VALT_BRNO     = request.getParameter("VALT_BRNO");
	String RSK_FAC     = request.getParameter("RSK_FAC");
	String VALT_YYMM     = request.getParameter("VALT_YYMM");
	
    request.setAttribute("PROC_SMDV_C",PROC_SMDV_C);
    request.setAttribute("VALT_BRNO",VALT_BRNO);
    request.setAttribute("VALT_YYMM",VALT_YYMM);
    request.setAttribute("RSK_FAC",RSK_FAC);
     
%>
<script language="JavaScript">
    
    var GridObj1;
    var GridObj2;
    var GridObj3;
    var GridObj4;
    var GridObj5;
    var overlay = new Overlay();
    var classID  = "RBA_50_05_01_02";
    
    var pageSize = 30;
    var pageNumber = 0;
    var objParam= null;
    
    // Initialize
    $(document).ready(function(){
    	setupGrids1();
    	doSearch();
        if (form2.RSK_FAC.value.substring(0,4) == ("RI03") || form2.RSK_FAC.value.substring(0,4) == ("RI04")){
        	setupGrids2();
    	 } else if (form2.RSK_FAC.value.substring(0,4) == ("RI01") || form2.RSK_FAC.value.substring(0,4) == ("RI02")){ 
    		 setupGrids3();
    	}
        
        setupFilter1("init");
        setupFilter2("init");
        setupFilter3("init");
    });
    
    function setupFilter1(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridArrs[1] = gridObj;
    	
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    function setupFilter3(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid3_Area";
    	gridObj.title = "${msgel.getMsg('RBA_50_05_01_015','ML/TF Risk Factor 상세내역')}";
    	gridArrs[2] = gridObj;
    	
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() { 
    	
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_05_01_02_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(20vh)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : 'test'
           ,completedEvent  : function(){
               setupGridFilter([GridObj1]);
               doSearch();
               
                
               if (form2.RSK_FAC.value.substring(0,4) == ("RI03") || form2.RSK_FAC.value.substring(0,4) == ("RI04")){
           		   // 상품:서비스:거래, 채널
            	   //거래상세내역 그리드
            	   GridObj2 = initGrid3({
                       gridId          : 'GTDataGrid2'
                      ,headerId        : 'RBA_50_05_01_02_Grid2'
                      ,gridAreaId      : 'GTDataGrid2_Area'
                      ,height          :  '330'
                      ,useAuthYN       : '${outputAuth.USE_YN}'
                      //,gridHeadTitle   : '미등록지점'
                      ,completedEvent  : function(){
                          setupGridFilter([GridObj1, GridObj2]); 
                       }
                   });
           	   } else if (form2.RSK_FAC.value.substring(0,4) == ("RI01") || form2.RSK_FAC.value.substring(0,4) == ("RI02")){ 
           			//고객상세내역 그리드
               	   GridObj3 = initGrid3({
                          gridId          : 'GTDataGrid3'
                         ,headerId        : 'RBA_50_05_01_02_Grid3'
                         ,gridAreaId      : 'GTDataGrid3_Area'
                         ,height          :  '330'
                         ,useAuthYN       : '${outputAuth.USE_YN}'
                         //,gridHeadTitle   : '미등록지점'
                         ,completedEvent  : function(){
                             setupGridFilter([GridObj1, GridObj2, GridObj3]); 
                          }
                    });
           	   }  	       
            }
        }); 
    }
    
    function setupGrids1() { 
    	 GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 elementAttr: { class: "grid-table-type" },
			 height	:"calc(30vh)",
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
			        allowExportSelectedData: false,
			        enabled                : false,
			        excelFilterEnabled     : false,
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
			    rowAlternationEnabled: false,
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
			        var RSK_CATG       = dataGrid.cellValue(rowIndex, 'RSK_CATG');
			        if(RSK_CATG =='RC-04'){
			        	e.cellElement.removeClass('link');
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
				            "caption": '${msgel.getMsg("RBA_50_05_01_02_100","위험지표")}',
				            "alignment": "center",
				            "columns" : [
			              {
				               "dataField": "PROC_LGDV_C",
				               "caption": '대분류',
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			                   "visible"      : false
				           }, {
				               "dataField": "PROC_MDDV_C",
				               "caption": '중분류',
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			                   "visible"      : false
				           }, {
				               "dataField": "PROC_SMDV_C",
				               "caption": '소분류',
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			                   "visible"      : false
				           }, {
				               "dataField": "RSK_CATG",
				               "caption": 'L1',
				               "width" : "75",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "RSK_CATG_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_101","위험범주(L1)")}',
				               "width" : "140",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "RSK_FAC",
				               "caption": 'L2',
				               "width" : "75",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           },{
				               "dataField": "RSK_FAC_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_102","위험요소(L2)")}',
				               "alignment": "center",
				               "width" : "190",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "RSK_INDCT",
				               "caption": 'L3',
				               "alignment": "center",
				               "width" : "75",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "RSK_INDCT_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_103","위험요소상세(L3)")}',
				               "alignment": "center",
				               "width" : "190",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "VALT_BRNM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_01_106","부점")}',
				               "alignment": "center",
				               "height":"200px",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true 
				               
				           }, {
				               "dataField": "VALT_STD_UNIT_NM",
				               "caption": '평가단위',
				               "alignment": "center",
				               "allowResizing": true,
				               "width" : "65",
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           }, {
				               "dataField": "VALT_CNT",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_104","평가건수")}',
				               "width" : "40%",
				               "cssClass"   : "link",
				               "alignment": "center",
				               "height":"200px",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }
				           
				           ]
			        }
			    ],
			    onToolbarPreparing   : makeToolbarButtonGrids,
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
        }).dxDataGrid("instance");
    }
	function setupGrids2() { 
		 GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
			 elementAttr: { class: "grid-table-type" },
			 height	:"330",
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
			        allowExportSelectedData: false,
			        enabled                : false,
			        excelFilterEnabled     : false,
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
			    rowAlternationEnabled: false,
			    onCellPrepared       : function(e){

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
			            "caption": '${msgel.getMsg("RBA_50_05_01_02_105","RBA 위험요소별 상세 거래 내역")}',
			            "alignment": "center",
			            "columns" : [
			               {
				               "dataField": "PROC_FLD_C",
				               "caption": '프로세스영역코드',
				               "width" : 80,
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           }, {
				               "dataField": "PROC_LGDV_C",
				               "caption": '대분류',
				               "width" : "80",
				               "alignment": "center",
				               "height":"200px",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           }, {
				               "dataField": "PROC_MDDV_C",
				               "caption": '중분류',
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           },{
				               "dataField": "PROC_SMDV_C",
				               "caption": '소분류',
				               "alignment": "center",
				               "width" : 80,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           },{
				               "dataField": "PROC_FLD_NM",
				               "caption": '프로세스영역',
				               "width" : 80,
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           }, {
				               "dataField": "PROC_LGDV_NM",
				               "caption": '대분류',
				               "width" : "80",
				               "alignment": "center",
				               "height":"200px",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           }, {
				               "dataField": "PROC_MDDV_NM",
				               "caption": '중분류',
				               "width" : "0",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           },{
				               "dataField": "PROC_SMDV_NM",
				               "caption": '소분류',
				               "alignment": "center",
				               "width" : 0,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           }, {
				               "dataField": "RSK_CATG",
				               "caption": '카테고리',
				               "alignment": "center",
				               "width" : "0",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				           }, {
				               "dataField": "RSK_FAC",
				               "caption": '팩터',
				               "alignment": "center",
				               "width" : "0",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				          }, {
				               "dataField": "RSK_INDCT",
				               "caption": '인디케이터',
				               "alignment": "center",
				               "width" : "0",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				          }, {
				               "dataField": "VALT_YYMM",
				               "caption": '평가기준년월',
				               "alignment": "center",
				               "width" : "0",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
				          }, {
				               "dataField": "VALT_BRNO",
				               "caption": '평가부점',
				               "alignment": "center",
				               "width" : "0",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
			           		   "visible"      : false
			           	  }, {
				               "dataField": "GNL_AC_NO",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_106","계좌번호")}',
				               "width" : "130",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "cellTemplate": function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"GNL_AC_NO")); }
				          },{
				               "dataField": "DL_DT",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_107","거래일자")}',
				               "cellTemplate" : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				               "alignment": "center",
				               "width" : 80,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "AML_CUST_ID",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_108","실명확인번호")}',
				               "width" : 120, 
				               "cellTemplate" : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"AML_CUST_ID")); },
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "GDS_NO",
				               "caption": '상품코드',
				               "width" : "100",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           }, {
				               "dataField": "GDS_CD_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_003","상품")}',
				               "width" : "100",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "DL_CHNNL_CD",
				               "caption": '거래채널코드',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           }, {
				               "dataField": "DL_CHNNL_CD_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_109","거래채널")}',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true 
				           }, {
				               "dataField": "DL_MD_CCD",
				               "caption": '거래매체구분',
				               "width" : "100",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           },{
				               "dataField": "DL_TYP_CD",
				               "caption": '거래종류코드',
				               "alignment": "center",
				               "width" : 80,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           },{
				               "dataField": "DL_TYP_CD_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_110","거래종류")}',
				               "alignment": "center",
				               "width" : 80,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "DL_WY_CD",
				               "caption": '거래방법코드',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           }, {
				               "dataField": "DL_WY_CD_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_111","거래방법")}',
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "SMRY_TYP_CD",
				               "caption": '적요코드',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           }, {
				               "dataField": "SMRY_TYP_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_112","적요명")}',
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "DL_AMT",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_113","거래금액")}',
				               "format": "fixedPoint",
				               "alignment": "center",
				               "allowResizing": true, 
				               "allowSearch": true,
				               "cellTemplate" :  function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"MONEY")); }  ,
				               "allowSorting": true
				           }, {
				               "dataField": "CSH_AMT",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_114","현금금액")}',
				               "format": "fixedPoint",
				               "alignment": "center",
				               "allowResizing": true, 
				               "allowSearch": true,
				               "cellTemplate" :  function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"MONEY")); }  ,
				               "allowSorting": true
				           }, {
				               "dataField": "CHCK_AMT",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_115","수표금액")}',
				               "format": "fixedPoint",
				               "alignment": "center",
				               "allowResizing": true, 
				               "allowSearch": true,
				               "cellTemplate" :  function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"MONEY")); }  ,
				               "allowSorting": true
				           }
				           ]
			        }
			    ],
			    onToolbarPreparing   : makeToolbarButtonGrids,
			    onCellClick: function(e){
			        if(e.data){
			            Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
        }).dxDataGrid("instance");	
    }
	function setupGrids3() { 
		 GridObj3 = $("#GTDataGrid3_Area").dxDataGrid({
			 height	:"calc(35vh)",
			 elementAttr: { class: "grid-table-type" },
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
			        allowExportSelectedData: false,
			        enabled                : false,
			        excelFilterEnabled     : false,
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
			    rowAlternationEnabled: false,
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
			            "caption": '${msgel.getMsg("RBA_50_05_01_02_105","RBA 위험요소별 상세 고객정보")}',
			            "alignment": "center",
			            "columns" : [
						   {
				               "dataField": "AML_CUST_ID",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_108","실명확인번호")}',
				               "width" : 85,
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "cellTemplate" : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"AML_CUST_ID")); },
				               "allowSorting": true
				           }, {
				               "dataField": "CS_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_116","고객명")}',
				               "width" : "100",
				               "alignment": "center",
				               "height":"200px",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "NTN_CD",
				               "caption": '국가코드',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               visible : false
				           }, {
				               "dataField": "NTN_CD_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_117","국가명")}',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "INDV_CORP_CCD",
				               "caption": '개인법인구분',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               visible : false
				           }, {
				               "dataField": "INDV_CORP_CCD_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_118","개인법인구분")}',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "BTYMD",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_119","생년월일")}',
				               "cellTemplate" : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           },{
				               "dataField": "UNAGE_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_120","미성년자여부")}',
				               "alignment": "center",
				               "width" : 80,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           },{
				               "dataField": "INDST_RSK_DVD_CD",
				               "caption": '업종코드',
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               visible : false
				           },{
				               "dataField": "INDST_RSK_DVD_CD_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_121","업종명")}',
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           },{
				               "dataField": "JOB_C",
				               "caption": '직업코드',
				               "alignment": "center",
				               "width" : 80,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               visible : false
				           },{
				               "dataField": "JOB_C_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_122","직업코드")}',
				               "alignment": "center",
				               "width" : 80,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "PEP_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_123","PEP여부")}',
				               "alignment": "center",
				               "width" : "80",
				               "height":"200px",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "LG_AMT_ASTS_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_124","고액자산가여부")}',
				               "alignment": "center",
				               "width" : "100",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "NPRFT_GROUP_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_125","비영리단체여부")}',
				               "width" : "100",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "LSTNG_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_126","상장여부")}',
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           },{
				               "dataField": "NFR_DIT_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_127","내외국인여부")}',
				               "alignment": "center",
				               "width" : 80,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "RSDNC_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_128","거주여부")}',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "NEW_CUST_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_129","신규고객여부")}',
				               "alignment": "center",
				               "width" : "80",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "UN_TRN_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_130","불공정거래적발여부")}',
				               "width" : "100",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				            }, {
				               "dataField": "STR_YN",
				               "caption": '${msgel.getMsg("RBA_50_05_01_02_131","의심거래보고이력여부")}',
				               "width" : "100",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }
				           ]
			        }
			    ],
			    onToolbarPreparing   : makeToolbarButtonGrids,
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
       }).dxDataGrid("instance");	
   }
    
    function doSearch(){
/*         
        GridObj1.refresh({
            actionParam: {
                "pageID"       : pageID,
                "classID"      : classID,
                "methodID"     : "doSearch",
                "VALT_YYMM"    : form2.VALT_YYMM.value,
                "VALT_BRNO"    : form2.VALT_BRNO.value,
                "PROC_SMDV_C"  : form2.PROC_SMDV_C.value,
                "RSK_FAC"      : form2.RSK_FAC.value
            },
            completedEvent: doSearch_end
            ,failEvent:doSearch_end
        }); */
        
        var params   = new Object();
    	var methodID = "doSearch";
    	var classID  = "RBA_50_05_01_02";
    	 		
    	params.pageID 	= "RBA_50_05_01_02";
    	params.VALT_YYMM    = form2.VALT_YYMM.value;
    	params.VALT_BRNO    = form2.VALT_BRNO.value;
    	params.PROC_SMDV_C  = form2.PROC_SMDV_C.value;
    	params.RSK_FAC      = form2.RSK_FAC.value;
    	sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
    }
    
    
    function doSearch_success(gridData, data) {
    	GridObj1.refresh();
    	GridObj1.option("dataSource",gridData);
    	var gridCnt = gridData.length;
    	var selObj = gridData[0];
    	
    	if(gridCnt>0) {
    		var lCd = selObj.PROC_LGDV_C;
    		var lNm = selObj.PROC_LGDV_NM;
    		var mCd = selObj.PROC_MDDV_C;
    		var mNm = selObj.PROC_MDDV_NM;
    		var sCd = selObj.PROC_SMDV_C;
    		var sNm = selObj.PROC_SMDV_NM;
    		$('#t01').text(lCd);
    		$('#t02').text(lNm);
    		$('#t03').text(mCd);
    		$('#t04').text(mNm);
    		$('#t05').text(sCd);
    		$('#t06').text(sNm); 
    	}
    	overlay.hide();
    }
    
    function doSearch_fail(){    	 
    	overlay.hide();
    }
    
    // 평가건수 클릭 시 그리드 Grid1CellClick function
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){
    	objParam = obj;
    	//ExcelExport할때 쓰려고 셋팅
    	form3.RSK_INDCT.value=obj.RSK_INDCT;
    	form3.PROC_LGDV_C.value=obj.PROC_LGDV_C;
    	form3.PROC_MDDV_C.value=obj.PROC_MDDV_C;
    	form3.RSK_CATG.value=obj.RSK_CATG;  
    	form3.VALT_BRNO.value=obj.VALT_BRNO;  
    	
    	if(obj.RSK_CATG =="RI01" || obj.RSK_CATG =="RI02") {
			//고객수 
    		if(colId == "VALT_CNT"){ 
	        		doSearch3(); 
    		}  
    	}//거래수
	    else {
        	if(colId == "VALT_CNT"){
        		doSearch2();
        	} 
    	} 
    }
    
    
    //거래조회
    function doSearch2(pageNumber) {
    	var obj = objParam;
        overlay.show(true, true);
/*         var methodID   =   "doSearch2";

        GridObj2.refresh({
            actionParam: {
                "pageID"  	: "RBA_50_05_01_02",
                "classID" 	: classID,
                "methodID"	: methodID,
                "VALT_YYMM"	: obj.VALT_YYMM, 
                "VALT_BRNO" : obj.VALT_BRNO,
                "RSK_CATG"	: obj.RSK_CATG, 
                "RSK_FAC"   : obj.RSK_FAC,
                "RSK_INDCT"	: obj.RSK_INDCT, 
                "PROC_LGDV_C"  : obj.PROC_LGDV_C,
                "PROC_MDDV_C"  : obj.PROC_MDDV_C, 
                "PROC_SMDV_C"  : obj.PROC_SMDV_C,
                "pageNumber"    : pageNumber!=undefined?pageNumber:0,   
                "pageSize"      : pageSize           
            },
            completedEvent: doSearch_end2,
            failEvent: doSearch_end2
            
        });
         */
        var classID  = "RBA_50_05_01_02";
        var methodID = "doSearch2";
        var params = new Object();
        params.pageID	= pageID;
        params.VALT_YYMM	= obj.VALT_YYMM; 
        params.VALT_BRNO 	= obj.VALT_BRNO;
        params.RSK_CATG		= obj.RSK_CATG; 
        params.RSK_FAC   	= obj.RSK_FAC;
        params.RSK_INDCT	= obj.RSK_INDCT; 
        params.PROC_LGDV_C  = obj.PROC_LGDV_C;
        params.PROC_MDDV_C  = obj.PROC_MDDV_C; 
        params.PROC_SMDV_C  = obj.PROC_SMDV_C;
        params.pageNumber    = pageNumber!=undefined?pageNumber:0;   
        params.pageSize      = pageSize           
     
        sendService(classID, methodID, params, doSearch_end2, doSearch_end2);
    }
    
    
    //고객조회
    function doSearch3(pageNumber) {
    	var obj = objParam;
        overlay.show(true, true);
        /* var methodID   =   "doSearch3";

        GridObj3.refresh({
            actionParam: {
                "pageID"  	: pageID,
                "classID" 	: classID,
                "methodID"	: methodID,
                "VALT_YYMM"	: obj.VALT_YYMM, 
                "VALT_BRNO" : obj.VALT_BRNO,
                "RSK_CATG"	: obj.RSK_CATG, 
                "RSK_FAC"   : obj.RSK_FAC,
                "RSK_INDCT"	: obj.RSK_INDCT, 
                "PROC_LGDV_C"  : obj.PROC_LGDV_C,
                "PROC_MDDV_C"  : obj.PROC_MDDV_C, 
                "PROC_SMDV_C"  : obj.PROC_SMDV_C,
                "pageNumber"    : pageNumber!=undefined?pageNumber:0,   
                "pageSize"      : pageSize           
            },
            completedEvent: doSearch_end3,
            failEvent: doSearch_end3
            
        }); */
        
        var classID  = "RBA_50_05_01_02";
        var methodID = "doSearch3";
        var params = new Object();
        params.pageID	= pageID;
        params.VALT_YYMM	= obj.VALT_YYMM; 
        params.VALT_BRNO 	= obj.VALT_BRNO;
        params.RSK_CATG		= obj.RSK_CATG; 
        params.RSK_FAC   	= obj.RSK_FAC;
        params.RSK_INDCT	= obj.RSK_INDCT; 
        params.PROC_LGDV_C  = obj.PROC_LGDV_C;
        params.PROC_MDDV_C  = obj.PROC_MDDV_C; 
        params.PROC_SMDV_C  = obj.PROC_SMDV_C;
        params.pageNumber    = pageNumber!=undefined?pageNumber:0;   
        params.pageSize      = pageSize           
     
        sendService(classID, methodID, params, doSearch_end3, doSearch_end3);
    }
    
    function doSearch_end2(e) {
    	overlay.hide();
    	window.gsb.setPaging({pageNumber:e.GRID_PAGE_DATA[0].pageNumber,totalCount:e.GRID_PAGE_DATA[0].totalCount});
    }

    function doSearch_end3(e) {
    	
    	overlay.hide();
    	window.gsb.setPaging({pageNumber:e.GRID_PAGE_DATA[0].pageNumber,totalCount:e.GRID_PAGE_DATA[0].totalCount}); 
    	GridObj3.setHeight('calc(40vh)');
    } 
    
    
    // 팝업 close
    function appro_end() {
        $("button[id='btn_01']").prop('disabled', false);
        opener.doSearch();
        window.close();
    }

    
    
    function doExport(){
    	if(form3.RSK_INDCT.value==""){
    		showAlert('ExcelExport 대상 데이터가 없습니다.','WARN');
    		return ;
    	}
        
        var actionStr = "";
        
        if(form2.RSK_FAC.value.substring(0,4) == ("RI01") || form2.RSK_FAC.value.substring(0,4) == ("RI02")) {
        	//고객정보
        	actionStr="Package/RBA/common/fileDown/sRbaExcelFileDownload3.jsp";
        	var gridCnt = GridObj3.totalCount();
        	if(gridCnt < 1) {
        		showAlert('ExcelExport 대상 데이터가 없습니다.','WARN');
        		return ;
        	}
        } else if("03" == form3.VALT_STD_UNIT.value) {
        	//계좌정보
        	actionStr="Package/RBA/common/fileDown/sRbaExcelFileDownload4.jsp";
        	
        	var gridCnt = GridObj5.totalCount();
        	if(gridCnt < 1) {
        		showAlert('ExcelExport 대상 데이터가 없습니다.','WARN');
        		return ;
        	}
        } else if(form2.RSK_FAC.value.substring(0,4) == ("RI03") || form2.RSK_FAC.value.substring(0,4) == ("RI04")) {
        	//거래정보
        	actionStr="Package/RBA/common/fileDown/sRbaExcelFileDownload5.jsp";
        	
        	var gridCnt = GridObj2.totalCount();
        	if(gridCnt < 1) {
        		showAlert('ExcelExport 대상 데이터가 없습니다.','WARN');
        		return ;
        	}
        }
        
        
        showConfirm("데이터에 따라 1~5분 소요될 수 있습니다. 다운로드 하시겠습니까 ?", "저장",function(){
        	form3.target                 = "_self";
            form3.action                 = actionStr;
            form3.method                 = "post";
            form3.submit();
        });
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
              "locateInMenu"      : "auto",
              "location"         : "after",
              "widget"         : "dxButton",
              "name"            : "filterButton",
              "showText"         : "inMenu",
              "options"         :
              {
                 "icon"         : "" ,
                 "elementAttr"   : { class: "btn-28 filter popupFilter" },
                 "text"         : "",
                 "hint"         : '필터',
                 "disabled"      : false,
                 "onClick"      : 
                    function(){
                       if(gridID=="GTDataGrid1_Area"){
                          setupFilter1();
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
    
</script>
<form name="form3" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="PROC_SMDV_C" value="${PROC_SMDV_C}">
    <input type="hidden" name="RSK_FAC" value="${RSK_FAC}">
    <input type="hidden" name="VALT_BRNO" value="${VALT_BRNO}">
    <input type="hidden" name="VALT_YYMM" value="${VALT_YYMM}">
    <input type="hidden" name="PROC_LGDV_C">
    <input type="hidden" name="PROC_MDDV_C">
    <input type="hidden" name="RSK_INDCT">
    <input type="hidden" name="RSK_CATG">
    <input type="hidden" name="VALT_STD_UNIT">
    
    
    
</form>
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="PROC_SMDV_C" value="${PROC_SMDV_C}">
    <input type="hidden" name="RSK_FAC" value="${RSK_FAC}">
    <input type="hidden" name="VALT_BRNO" value="${VALT_BRNO}">
    <input type="hidden" name="VALT_YYMM" value="${VALT_YYMM}">
</form>
<form name="form">
    <div class="tab-content-bottom">
        <div class="panel-footer" >
            <h4 class="tab-content-title" style="margin-bottom: 8px">${msgel.getMsg('RBA_50_05_01_011','지표목록')}</h4>
<!--         <div class="table-title" style="padding-left:20px;"></div> -->

		<div class="table-box11">
			<table class="grid-table division">
				<thead>
					<tr style="text-align:center;background-color: #eaeaea;">
	                	<th width="10%"  rowspan="2" style="border-right: 1px solid white;">${msgel.getMsg('RBA_50_05_01_016','AML업무')}<br>${msgel.getMsg('RBA_50_05_01_017','AML프로세스')}</th>
	                	<th width="7%" style=" border-right: 1px solid white;" align="center";>L1</th>
	                	<th width="20%"  style="border-right: 1px solid white;">${msgel.getMsg('RBA_50_05_01_012','대분류(L1)')}</th>
	                	<th width="7%" style="border-right: 1px solid white;" align="center">L2</th>
	                	<th width="20%"  style="border-right: 1px solid white;">${msgel.getMsg('RBA_50_05_01_013','중분류(L2)')}</th>
	                	<th width="7%" style="border-right: 1px solid white;" align="center">L3</th>
	                	<th width="30%"  >${msgel.getMsg('RBA_50_05_01_014','소분류(L3)')}</th>
	              	</tr>
	            	<tr style="text-align:center;background-color: #eaeaea;">
	                	<th width="7%" align="center" height="30" id="t01" style="background-color: white; font-weight: normal; text-align: center;"></th>
	                  	<th width="20%"  style="text-align:center; background-color: white; font-weight: normal;" id="t02"></th>
	                  	<th width="7%" align="center" id="t03" style="background-color: white; font-weight: normal; text-align: center;"></th>
	                  	<th width="20%"  style="text-align:center; background-color: white; font-weight: normal;" id="t04"></th>
	                  	<th width="7%" align="center" id="t05" style="background-color: white; font-weight: normal; text-align: center;"></th>
	                  	<th width="20%"  style="text-align:center; background-color: white; font-weight: normal;" id="t06"></th>
	              	</tr style="text-align:center;background-color: #eaeaea;">
	            </thead>

			 </table>
		</div>
		
		<div id="GTDataGrid1_Area" style="margin-top: 8px;"></div>
 <%--       <div style="margin-top: 8px">
	    	<div id="GTDataGrid1_Area"></div>
 	        <div id="text_info_Area" class="tab-content-bottom">
			<table class="basic-table">
				<tr>
					<td>
			        	<h4 class="tab-content-title">${msgel.getMsg('RBA_50_05_01_015','ML/TF Risk Factor 상세내역')}</h4>
		        	</td>
			        	<td align=right>
			        		<!--  
			        		<div onclick ="doExport()" class="dx-datagrid-toolbar-button dx-datagrid-export-button dx-button dx-button-normal dx-widget dx-button-has-icon">
			        			<div class="dx-button-content">
			        				<i class="dx-icon dx-icon-export"></i>
			       				</div>
			        		</div>
			        		-->
			        	</td>
		       	</tr>
	       	</table>
			</div> 
		</div>--%> 
		
		<div id="GTDataGrid2_Area" style="margin-top: 8px;"></div> 
		<div id="GTDataGrid3_Area" style="margin-top: 8px;"></div> 
			
	</div>
	
   	<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">
      	 ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"appro_end", cssClass:"btn-36"}')}	
	</div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />
