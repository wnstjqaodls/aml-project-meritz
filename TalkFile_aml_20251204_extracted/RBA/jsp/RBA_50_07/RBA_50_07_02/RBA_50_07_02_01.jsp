<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_07_02_01.jsp
* Description     : 고위험영역개선관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : SBJ
* Since           : 2018-04-25
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    request.setAttribute("ROLE_IDS",ROLE_IDS);
    //out.println("ROLE_IDS="+ROLE_IDS);
%>
<script language="JavaScript">

    var GridObj1 ;
    var GridObj2 ;
    var classID  = "RBA_50_07_02_01";
    var overlay  = new Overlay();
    var BAS_YYMM    = "";
    var VALT_BRNO  = "";
    var curRow   = -1;
    var ROLE_ID =  '${ROLE_IDS}';

    var pCCD     = "1";
    var firtsCnt = 0;

    var overlay  = new Overlay();

    /** Initialize */
    $(document).ready(function(){
        setupGrids1();
        setupGrids2();
        setupFilter("init");
        setupFilter2("init");
        doSearch();
        setButtonDisplay();
        var BRNO = parent.getMainsParams("BRNO");
        var BAS_YYMM = parent.getMainsParams("BAS_YYMM");
        var VALT_BRNO = "";
        if(BRNO != undefined){
            VALT_BRNO = BRNO;
            form.BAS_YYMM.value = BAS_YYMM;
            form.VALT_BRNO.value = VALT_BRNO;
        }

    });

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridObj.title = "${msgel.getMsg('RBA_50_07_02_01_004','부점별 현황')}";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }
    
    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridObj.title = "${msgel.getMsg('RBA_50_07_02_01_005','부점별 개선방안 상세등록내역')}";
    	gridArrs[1] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }

    function setupGrids1(){
    	 GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		 elementAttr: { class: "grid-table-type" },
			 height	:"calc(83vh - 100px)",
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
			        allowExportSelectedData: true,
			        enabled                : true,
			        excelFilterEnabled     : true,
			        fileName               : "gridExport"
			    },
			    sorting              : {mode: "multiple"},
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
			    onToolbarPreparing   : makeToolbarButtonGrids,
			    filterRow            : {visible: false},
			    rowAlternationEnabled: false,
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
			    selection: {
			        allowSelectAll    : true,
			        deferred          : false,
			        mode              : "single",
			        selectAllMode     : "allPages",
			        showCheckBoxesMode: "onClick"
			    },
			    "columns":[
			  
			    		{
				            "dataField": "DPRT_NM",
				            "caption": '${msgel.getMsg("RBA_50_05_01_019","부점명")}',
				            "width" : 85,
				            "alignment": "left",
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        	},
			                           {
							"dataField": "TRGT_CNT",
				            "caption": '${msgel.getMsg("RBA_50_05_01_01_101","대상건수")}',
				            "width" : 100,
				            "dataType": "number",
				            "alignment": "right",
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        	},
			                           {
							"dataField": "CMPT_CNT",
				            "caption": '${msgel.getMsg("RBA_50_05_01_01_102","완료건수")}',
				            "width" : 100,
				            "dataType": "number",
				            "alignment": "right",
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        	}                                   
			           
			    ],
			    onCellClick: function(e){ 
			        if(e.data ){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }	 
        }).dxDataGrid("instance");	
    }
    
    function setupGrids2(){
   	 GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
   		elementAttr: { class: "grid-table-type" },
			 height	:"calc(83vh - 100px)",
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
			    sorting              : {mode: "multiple"},
			    export               : {
			        allowExportSelectedData: true,
			        enabled                : true,
			        excelFilterEnabled     : true,
			        fileName               : "gridExport"
			    },
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
			    onToolbarPreparing   : makeToolbarButtonGrids,
			    filterRow            : {visible: false},
			    rowAlternationEnabled: false,
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
			    onCellPrepared       : function(e){
			        var columnName = e.column.dataField;
			        var dataGrid   = e.component;
			        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
			        var remdrRskGdCnm       = dataGrid.cellValue(rowIndex, 'REMDR_RSK_GD_C_NM');
			        
			        if(rowIndex != -1){
			        
			             if((remdrRskGdCnm =='Red') && (columnName == 'REMDR_RSK_GD_C_NM')){
			                 e.cellElement.css('background-color', '#FF0000');
			             } else if((remdrRskGdCnm =='Yellow') && (columnName == 'REMDR_RSK_GD_C_NM')){
			                 e.cellElement.css('background-color', '#FFFF00');
			             } else if((remdrRskGdCnm =='Green') && (columnName == 'REMDR_RSK_GD_C_NM')){
			                 e.cellElement.css('background-color', '#00FF00');
			             }   
			            
			        }
			    },
			    searchPanel          : {
			        visible: false,
			        width  : 250
			    },
				 selection:                  {
				     "allowSelectAll": true,
				     "deferred": false,
				     "mode": "multiple",
				     "selectAllMode": "allPages",
				     "showCheckBoxesMode": 'always'
				 },
				onContentReady: function (e) {
				    e.component.columnOption("command:select", "width", 30);
				},
				editCellTemplate : function(cellElement, cellInfo) {
				    $("<div>").appendTo(cellElement).dxCheckBox({
				       visible : true
				    })
				  },
			    "columns":[
			    
			    
			    		{
				            "dataField": "POOL_SNO",
				            "caption": '순번',
				            "visible" : false,
				            "dataType": "number",
				            "alignment": "right",
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        	},
			                                {
			               "dataField": "DPRT_NM",
			               "caption": '${msgel.getMsg("RBA_50_05_03_01_003","부서명")}',
			               "width" : 100,
			               "visible": true,
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           },
			                           {
			            "caption": '${msgel.getMsg("RBA_50_05_01_01_103","표준AML업무프로세스")}',
			            "alignment": "center",
			            "columns" : [{
			               "dataField": "PROC_LGDV_C_NM",
			               "caption": '${msgel.getMsg("RBA_50_05_03_01_012","대구분")}',
			               "width" : 100,
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           },
			                                {
			               "dataField": "PROC_MDDV_C_NM",
			               "caption": '${msgel.getMsg("RBA_50_05_03_01_014","중구분")}',
			               "width" : 120,
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           },
			                                {
			               "dataField": "PROC_SMDV_NM",
			               "caption": '${msgel.getMsg("RBA_50_05_03_01_016","소구분")}',
			               "width" : 200,
			               "cssClass"   : "link",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           }]
			        },					{
			            "caption": '${msgel.getMsg("RBA_50_05_03_01_017","위험점수")}',
			            "alignment": "center",
			            "columns" :[{
			              "dataField": "RSK_VALT_PNT",
			              "caption": '',
			              "width" : 70,
			              "dataType": "number",
				          "alignment": "right",
			              "allowResizing": true,
			              "allowSearch": true,
			              "allowSorting": true
			               },			{
			              "dataField": "RSK_VALT_RT",
			              "caption": '백분위점수',
			              "width" : 70,
			              "dataType": "number",
				          "alignment": "right",
			              "allowResizing": true,
			              "allowSearch": true,
			              "allowSorting": true,
			              "visible": false
			               }
			               ]
			        },					{
			            "caption": '${msgel.getMsg("RBA_50_05_03_01_018","통제점수")}',
			            "alignment": "center",
			            "columns" :[{
			              "dataField": "TONGJE_VALT_PNT",
			              "caption": '',
			              "width" : 70,
			              "alignment": "right",
			              "allowResizing": true,
			              "allowSearch": true,
			              "allowSorting": true
			               },			{
			              "dataField": "TONGJE_VALT_RT",
			              "caption": '백분위점수',
			              "width" : 70,
			              "dataType": "number",
				           "alignment": "right",
			              "allowResizing": true,
			              "allowSearch": true,
			              "allowSorting": true,
			              "visible": false
			               }
			               ]
			        },					{
			            "caption": '${msgel.getMsg("RBA_50_07_02_01_100","잔여위험")}',
			            "columns" :[{
			              "dataField": "REMDR_RSK_PNT",
			              "caption": '${msgel.getMsg("RBA_50_05_01_01_104","점수")}',
			              "width" : 70,
			              "dataType": "number",
				          "alignment": "right",
			              "allowResizing": true,
			              "allowSearch": true,
			              "allowSorting": true
			               },			{
			              "dataField": "REMDR_RSK_GD_C_NM",
			              "caption": '${msgel.getMsg("RBA_50_05_04_010","등급")}',
			              "width" : 70,
			              "alignment": "center",
			              "allowResizing": true,
			              "allowSearch": true,
			              "allowSorting": true
			               }
			               ]
			        },
			        {
							"dataField": "GYLJ_ROLE_NM",
				            "caption": '${msgel.getMsg("RBA_50_02_02_04_100","결재단계")}',
				            "alignment": "center",
				            "width" : 80,
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        },
			        {
							"dataField": "GYLJ_S_C_NM",
				            "caption": '${msgel.getMsg("RBA_50_07_02_01_002","결재상태")}',
				            "alignment": "center",
				            "cssClass"   : "link",
				            "width" : 80,
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        },
			        {
							"dataField": "GYLJ_S_C",
				            "caption": '결재상태',
				            "visible": false,
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        },
			        {
							"dataField": "GYLJ_ROLE_ID",
				            "caption": '결재ROLE_ID',
				            "width" : 10,
				            "visible": false,
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        },
			        {
							"dataField": "GYLJ_JKW_NM",
				            "caption": '결재자',
				            "width" : 90,
				            "alignment": "center",
				            "visible": true,
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        }, 
			        {
							"dataField": "IMPRV_CMPT_YN",
				            "caption": '개선완료여부코드',
				            "visible": false,
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        }, 
			        {
							"dataField": "IMPRV_CMPT_YN_NM",
				            "caption": '${msgel.getMsg("RBA_50_07_02_01_101","개선완료여부")}',
				            "width" : 90,
				            "alignment": "center",
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        }, 
			        {
							"dataField": "TONJE_BRNO_YN",
				            "caption": '통제부서여부',
				            "width" : 90,
				            "alignment": "center",
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true,
				            "visible": false
				            
			        }                        
			    ],
			    onCellClick: function(e){ 
			        if(e.data ){
			        }
			            Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			    }	 
       }).dxDataGrid("instance");	
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
	            ,"name"         : "filterButton"
	            ,"showText"     : "inMenu"
	            ,"options"      : {
	                     "icon"      : "" 
	                   	,"elementAttr": { class: "btn-28 filter" }
	        			,"text"      : ""       
	                    ,"hint"      : '필터'
	                    ,"disabled"  : false
	                    ,"onClick"   : function(){
							if(gridID=="GTDataGrid1_Area"){
								setupFilter();
							} else {//gridID=="GTDataGrid3_Area"
								setupFilter2();
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

    /** Search CODE Head */
    function doSearch() {
    	 GridObj1.clearSelection();
    	 GridObj1.option('dataSource', []);
    	 
         overlay.show(true, true);

         var toDoCheck = 0; //나의할일 체크 플래그

         if(form.TO_DO_CHECK.checked == true){
             toDoCheck = 1;
         }else{
             toDoCheck = 0;
         }

         var classID  = "RBA_50_07_02_01";
         var methodID = "doSearch";
         var params = new Object();
         params.pageID	="RBA_50_07_02_01";
         params.BAS_YYMM 		= form.BAS_YYMM.value;
         params.VALT_BRNO		= form.SEARCH_DEP_ID.value;
         params.IMPRV_CMPT_YN	= $("#IMPRV_CMPT_YN").val();  //개선완료여부
         params.GYLJ_S_C		= form.GYLJ_S_C.value ;
         params.TO_DO_CHECK		= toDoCheck;
         params.ROLE_IDS		=  '${ROLE_IDS}';
  
         sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }

    /** Search CODE Head end */
    function doSearch_success(gridData, data){

        overlay.hide();

        var row = gridData.length;
        if(row > 0){
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
            if(ROLE_ID == "3"||ROLE_ID == "6"){ //지점담당자일 경우만 행선택
            	GridObj1.refresh().then(function() {
          		   GridObj1.selectRowsByIndexes(0)
 	         	});
            	Grid1CellClick("GTDataGrid1", gridData[0] );
                //obj = GridObj1.selectRow(0, true).getRowNew(0, function(data){ Grid1CellClick("GTDataGrid1", data); });
            } else {
                doSearch2();            }
        } else {
        	GridObj1.clearSelection();
        	GridObj1.option('dataSource', []);
            GridObj2.clearSelection();
            GridObj2.option('dataSource', []);
            return;
        }
    }
    
    function doSearch_fail(){
    	overlay.hide();
    }

    /** Click Code Head */
    var Grid1CellClick = function(id, obj, selectData, rowIdx, colIdx, columnId, colId){

        //if (curRow!=rowIdx) {
            curRow      = rowIdx;
            BAS_YYMM    = obj.BAS_YYMM;
            VALT_BRNO   = obj.VALT_BRNO;

            DPRT_NM  = obj.DPRT_NM;
            form.SEARCH_DEP_ID.value = VALT_BRNO;
            form.DEP_TITLE.value = DPRT_NM;
            doSearch2();
        //}
    }

    /** Search CODE Detail */
     function doSearch2(){
        if(GridObj2 == null){
            return;
        }
        GridObj2.clearSelection();
        GridObj2.option('dataSource', []);

        if(VALT_BRNO==""){
            VALT_BRNO = form.SEARCH_DEP_ID.value;
        }

        var toDoCheck = 0; //나의할일 체크 플래그

        if(form.TO_DO_CHECK.checked == true){
            toDoCheck = 1;
        }else{
            toDoCheck = 0;
        }
       
        var classID  = "RBA_50_07_02_01";
        var methodID = "doSearch2";
        var params = new Object();
        params.pageID	="RBA_50_07_02_01";
        params.BAS_YYMM 		= form.BAS_YYMM.value;
        params.VALT_BRNO		= form.SEARCH_DEP_ID.value;
        params.IMPRV_CMPT_YN	= $("#IMPRV_CMPT_YN").val();  //개선완료여부
        params.GYLJ_S_C		= form.GYLJ_S_C.value ;
        params.TO_DO_CHECK		= toDoCheck;
        params.ROLE_IDS		=  '${ROLE_IDS}';
 
        sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
    }

    /** Search CODE Detail */
    function doSearch2_success(gridData, data){
    	
    	GridObj2.refresh();
    	GridObj2.option("dataSource",gridData);
    	
        setButtonDisplay();
    }

    // 상세 팝업
    function Grid2CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId) {
  
        // var obj = GridObj2.getSelectedRowsData();console.log(obj);
        if(columnId == "PROC_SMDV_NM") { //소분류명 클릭시 개선관리 수정 팝업호출

             form2.P_GUBN.value       = "1";                 //구분:0 등록 1:수정
             form2.pageID.value       = "RBA_50_07_02_02";
             var win                  = window_popup_open("RBA_50_07_02_02",  1390, 820, '','yes');
             form2.BAS_YYMM.value     = obj.BAS_YYMM;
             form2.PROC_FLD_C.value   = obj.PROC_FLD_C;
             form2.PROC_LGDV_C.value  = obj.PROC_LGDV_C;
             form2.PROC_MDDV_C.value  = obj.PROC_MDDV_C;
             form2.PROC_SMDV_C.value  = obj.PROC_SMDV_C;
             form2.VALT_BRNO.value    = obj.VALT_BRNO;
             form2.POOL_SNO.value     = obj.POOL_SNO;
             form2.GYLJ_S_C.value     = obj.GYLJ_S_C;
             form2.GYLJ_ID.value      = obj.GYLJ_ID;
             form2.GYLJ_ROLE_ID.value = obj.GYLJ_ROLE_ID;
             form2.TONJE_BRNO_YN.value = obj.TONJE_BRNO_YN;
             form2.target             = form2.pageID.value;
             form2.action             = '<c:url value="/"/>0001.do';
             form2.submit();

        } else if(columnId == "GYLJ_S_C_NM"){     //결재상태  클릭시 결재상제정보 팝업 호출

            form2.pageID.value     = "RBA_50_02_02_04";
            form2.GYLJ_ID.value    =  obj.GYLJ_ID;
            var win;           win = window_popup_open("RBA_50_02_02_04",  850, 400, '','no');
            form2.target           = form2.pageID.value;
            form2.action           = '<c:url value="/"/>0001.do';
            form2.submit();

        }
    }



    //개선조치대응사항  등록/수정 팝업 호출
    function doRegister() {

         var selectedRows = GridObj2.getSelectedRowsData();
         var size         = selectedRows.length;
         var rowsData; rowsData     = GridObj2.getSelectedRowsData();

         if(size <= 0 ){
        	 showAlert("${msgel.getMsg('RBA_50_07_02_01_006','등록할 데이타를 선택하십시오')}",'WARN');
             return;
         }

         if(!checkValid()){
             return;
         }

         var obj = GridObj2.getSelectedRowsData()[0];
        

         form2.P_GUBN.value       = "0";                 //구분:0 등록 1:수정
         form2.pageID.value       = "RBA_50_07_02_02";

         var win;             win = window_popup_open("RBA_50_07_02_02",  1190, 825, '','yes');

         form2.BAS_YYMM.value     = obj.BAS_YYMM;
         form2.PROC_FLD_C.value   = obj.PROC_FLD_C;
         form2.PROC_LGDV_C.value  = obj.PROC_LGDV_C;
         form2.PROC_MDDV_C.value  = obj.PROC_MDDV_C;
         form2.PROC_SMDV_C.value  = obj.PROC_SMDV_C;
         form2.VALT_BRNO.value    = obj.VALT_BRNO;
         form2.GYLJ_ROLE_ID.value    = obj.GYLJ_ROLE_ID;
         form2.target             = form2.pageID.value;
         form2.action             = '<c:url value="/"/>0001.do';
         form2.submit();
    }

    function setButtonDisplay() {
        var ROLE_ID = '${ROLE_IDS}';

        if("3"== ROLE_ID ) { //지점담당자일 경우 승인, 반려버튼 삭제

            //승인버튼 삭제
            $("#btn_05").attr("style","display:none;");
            //반려버튼 삭제
            $("#btn_06").attr("style","display:none;");

        } else if("4"== ROLE_ID ) { //본점담당자일 경우

            //버튼들 다 보이도록
            $("#btn_01").attr("style","inline-block;");//조회버튼
            $("#btn_02").attr("style","inline-block;");//등록버튼
            $("#btn_04").attr("style","inline-block;");//승인요청버튼
            $("#btn_05").attr("style","inline-block;");//승인버튼
            $("#btn_06").attr("style","inline-block;");//반려버튼

        } else if("104"== ROLE_ID ) { //본점책임자 제어
            //등록버튼 삭제
            $("#btn_02").attr("style","display:none;");
            //등록버튼 삭제
            $("#btn_02").attr("style","display:none;");
            //승인요청 버튼 삭제
            $("#btn_03").attr("style","display:none;");

        } else if("6"== ROLE_ID) { //지점책임자 버튼 제어

            //승인요청 버튼 삭제
            $("#btn_03").attr("style","display:none;");

        } else if("7"== ROLE_ID ) { //시스템관리자일 경우 모든 버튼 보이게

            //버튼들 다 보이도록
            $("#btn_01").attr("style","inline-block;");//조회버튼
            $("#btn_02").attr("style","inline-block;");//등록버튼
            $("#btn_03").attr("style","inline-block;");//승인요청버튼
            $("#btn_05").attr("style","inline-block;");//승인버튼
            $("#btn_06").attr("style","inline-block;");//반려버튼


        } else { //나머지 권한들은 다 버튼 없음

            //등록버튼 삭제
            $("#btn_02").attr("style","display:none;");
            //승인요청버튼 삭제
            $("#btn_04").attr("style","display:none;");
            //승인버튼 삭제
            $("#btn_05").attr("style","display:none;");
            //반려버튼 삭제
            $("#btn_06").attr("style","display:none;");
       }
    }


    // 고위험영역개선관리 승인요청
    function openGyljPopUp0() {
        openGyljPopUp(0);
    }

    // 승인
    function openGyljPopUp2() {
        /* validation 추가 */

        openGyljPopUp(2);
    }

    // 반려
    function openGyljPopUp22() {
    /* validation 추가 */

        openGyljPopUp(1);
    }

    // 고위험영역개선관리 반려
    function openGyljPopUp1() {
        openGyljPopUp(1);
    }

    // 고위험영역개선관리 - 결재(RBA_50_07_02_04) 팝업 호출 function
    function openGyljPopUp(flag) {
        var ROLE_ID; ROLE_ID = '${ROLE_IDS}';

        if(!checkValid2(flag)){
            return;
        }

        var obj; obj  = GridObj1.getSelectedRowsData()[0];

        var sCnt     = 0;
        var rowsData = GridObj2.getSelectedRowsData();

        sCnt = Object.keys(rowsData).length;

        if(sCnt == 0){
            showAlert('${msgel.getMsg("RBA_50_07_02_01_013","한건만 등록하실수 있습니다.")}','WARN');
            return;
        }


        var GYLJ_S_C;
        var gObj = rowsData[0];

        form3.pageID.value  = "RBA_50_07_02_04";

        if(flag=="0"){ //승인요청
            GYLJ_S_C = "21";
        } else if(flag=="1") {//반려
            GYLJ_S_C = "22";
        }  else if(flag=="2") {//승인
            GYLJ_S_C = "21";
        }  else {
            GYLJ_S_C = gObj.GYLJ_S_C;
        }

        var win; win = window_popup_open("RBA_50_07_02_04", 650, 310, '', 'yes');

        form3.BAS_YYMM.value    = gObj.BAS_YYMM ;                   //기준년월
        form3.PROC_FLD_C.value  = gObj.PROC_FLD_C;
        form3.PROC_LGDV_C.value = gObj.PROC_LGDV_C;
        form3.PROC_MDDV_C.value = gObj.PROC_MDDV_C;
        form3.PROC_SMDV_C.value = gObj.PROC_SMDV_C;
        form3.VALT_BRNO.value   = gObj.VALT_BRNO;
        form3.GYLJ_ID.value     = gObj.GYLJ_ID;
        form3.GYLJ_S_C.value    = GYLJ_S_C;
        form3.GYLJ_JKW_NM.value = gObj.GYLJ_JKW_NM;
        form3.GYLJ_G_C.value    = gObj.GYLJ_G_C;

        form3.FLAG.value        = flag;
        form3.GYLJ_MODE.value   = "M";

        form3.target            = form3.pageID.value;
        form3.action            = "<c:url value='/'/>0001.do";
        form3.submit();

    }


    // 등록 validation  체크
    function checkValid() {

        var chkCnt; chkCnt = 0;
        var sCnt     = 0;
        var rowsData = GridObj2.getSelectedRowsData();

        sCnt = Object.keys(rowsData).length;

        if(sCnt > 1){
            showAlert('${msgel.getMsg("RBA_50_07_02_01_007","한건만 등록하실수 있습니다.")}','WARN');
            return;
        }

        var gObj; gObj = rowsData[0];

       return true;
    }

    // 승인요청 validationn 체크
    function checkValid2(flag) {

        var chkCnt = 0;
        var appTrgtCnt = 0; //승인대상건수
        var rejTrgtCnt = 0; //반려대상건수
        var wrongRoleCnt     = 0;
        var sCnt     = 0;

        var rowsData = GridObj2.getSelectedRowsData();

        sCnt = Object.keys(rowsData).length;

        for(i=0;i<sCnt;i++){
            var gObj = rowsData[i];
            if(gObj.GYLJ_S_C != "11"){
                chkCnt++;
            }

            if( gObj.GYLJ_S_C != "21"){
                appTrgtCnt++;
            }

            if(gObj.GYLJ_S_C != "21" && gObj.GYLJ_S_C != "22"){
                rejTrgtCnt++;
            }

            if(gObj.GYLJ_ROLE_ID !=  ROLE_ID){
                wrongRoleCnt++;
            }
        }

        if(flag=="0"){

            if(chkCnt>0){
                showAlert('${msgel.getMsg("RBA_50_07_02_01_008","저장건만 승인요청하실수 있습니다.")}','WARN');
                return;
            }
        } else if(flag=="1"){
            if(rejTrgtCnt>0){
                showAlert('${msgel.getMsg("RBA_50_07_02_01_009","진행중인 건만 반려하실수 있습니다.")}','WARN');
                return;
            }

            if(wrongRoleCnt>0){
                showAlert('${msgel.getMsg("RBA_50_07_02_01_010","담당건만 반려하실수 있습니다.")}','WARN');
                return;
            }

        } else if(flag=="2"){
             if(appTrgtCnt>0){
                showAlert('${msgel.getMsg("RBA_50_07_02_01_011","진행중인 건만 승인하실수 있습니다.")}','WARN');
                return;
            }

            if(wrongRoleCnt>0){
                showAlert('${msgel.getMsg("RBA_50_07_02_01_012","담당건만 승인하실수 있습니다.")}','WARN');
                return;
            }
        }

       return true;
    }


    // 일괄결재
    function doApprove(GYLJ_S_C,GYLJ_FLAG,NOTE_CTNT){

    var GYLJ_ROLE_ID = '${ROLE_IDS}';
    var rowsData =   GridObj2.getSelectedRowsData();
       var params   = new Object();
   	var methodID = "doSave";
   	var classID  = "RBA_50_07_02_01";
   	 		
   	params.pageID 	= "RBA_50_07_02_01";
   	params.CON_YN 	= "0";
   	params.pageID            = pageID;
   	params.classID           = classID;
   	params.methodID          = methodID;
   	params.BAS_YYMM          = "${BAS_YYMM}";
   	params.GYLJ_G_C          = "W05";
   	params.GYLJ_S_C          = GYLJ_S_C;
   	params.GYLJ_ROLE_ID      = GYLJ_ROLE_ID;
   	params.GYLJ_FLAG         = GYLJ_FLAG;
   	params.NOTE_CTNT         = NOTE_CTNT;
   	
   	params.gridData = rowsData; 		
   	
   	sendService(classID, methodID, params, doApporveEnd, doApporveEnd); 

   }


   //결재완료후
   function doApporveEnd() {
       refreshApprovalCount();

        doSearch();
        //opener.doSearch();
   }


    // 그리드1 CellClick
    function Grid1CellClick(gridId, obj, selData, rowIdx, colIdx, colId) {

        if(colId == "GYLJ_S_NM"){
            form2.pageID.value  = "RBA_30_04_03_04";
            var win; win = window_popup_open(form2, 750, 275, '', 'yes');
            form2.GYLJ_ID.value = obj.GYLJ_ID;
            form2.target        = form2.pageID.value;
            form2.action        = "<c:url value='/'/>0001.do";
            form2.submit();
        }
    }

    // 평가지점을 타부점으로 변경 시 나의 할 일 CHECK 해제 function
    function checkToDo(){
        var DEPT_CD   = form.DEPT_CD.value;
        var VALT_BRNO = form.VALT_BRNO.value;
        if(DEPT_CD != VALT_BRNO){
            form.TO_DO_CHECK.checked = false;
        }
    }

    // 나의 할 일 CHECK 시 본인 지점 이벤트 function
    function setValtBrno(){
        var DEPT_CD = form.DEPT_CD.value;
        if(form.TO_DO_CHECK.checked == true){
            form.VALT_BRNO.value = DEPT_CD;
            var obj = new Object();
            obj = form.VALT_BRNO;
            doRBASearchInput(obj, "com.gtone.rba.common.action.GetKRBADepInfoByCd", "setDepName2");
        }
    }



</script>

<form name="form3" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM">
    <input type="hidden" name="PROC_FLD_C">
    <input type="hidden" name=PROC_LGDV_C>
    <input type="hidden" name="PROC_MDDV_C">
    <input type="hidden" name="PROC_SMDV_C">
    <input type="hidden" name="VALT_BRNO">
    <input type="hidden" name="GYLJ_ID" >
    <input type="hidden" name="GYLJ_S_C" >
    <input type="hidden" name="GYLJ_JKW_NM" >
    <input type="hidden" name="FLAG" >
    <input type="hidden" name="GYLJ_G_C" >
    <input type="hidden" name="GYLJ_MODE" >
    <input type="hidden" name="GYLJ_ROLE_ID" >

</form>

<form name="form2" method="post" >
<input type="hidden" name="pageID" >
<input type="hidden" name="classID">
<input type="hidden" name="methodID">
<input type="hidden" name="BAS_YYMM">
<input type="hidden" name="PROC_FLD_C">
<input type="hidden" name=PROC_LGDV_C>
<input type="hidden" name="PROC_MDDV_C">
<input type="hidden" name="PROC_SMDV_C">
<input type="hidden" name="VALT_BRNO">
<input type="hidden" name="POOL_SNO">
<input type="hidden" name="GYLJ_ID">
<input type="hidden" name="GYLJ_S_C">
<input type="hidden" name="GYLJ_ROLE_ID">
<input type="hidden" name="P_GUBN" >
<input type="hidden" name="TONJE_BRNO_YN" >

 <!-- 기존 값 조회시 Parameter를 넘긴다 -->
</form>

<form name="form" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="text" name="temp" style="display: none;">
    <div class="inquiry-table type1" id='condBox1'>
	        <div class="table-row" style="width: 25%;">
	            <div class="table-cell">
		                ${condel.getLabel('RBA_50_10_01_01_001','기준년월')}
		            <div class="content">
		                <%-- ${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'')} --%>
		                <RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="Y" eventFunction='doSearch()'/>
		            </div>
	            </div>
	            <div class="table-cell">
	                ${condel.getLabel('RBA_50_07_02_01_002','결재상태')}
					<div class="content">
		                ${SRBACondEL.getSRBASelect('GYLJ_S_C','300' ,'' ,'R325' ,'','ALL','','','','')}
					</div>			
				</div>
	        </div>
	        <div class="table-row" style="width: 29%;">
	            <div class="table-cell">
	            	<div class="title">
	            		<div class="txt">${msgel.getMsg("RBA_50_07_02_01_103","지점 검색")}</div>
	            	</div>
	            	<div class="content">
		                <RBATag:searchRbaInput searchName="SEARCH_DEP_ID" searchClass="cond-select" searchStyle="width: 130px;" text1Name="DEP_ID"
		                    text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>"
		                    searchFunction='doRBASearchInput(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepName2")'
		                    popupFunction='doRBASelectInputPopup("searchRbaDepPopup", 480, 580, "SEARCH_DEP_ID", "setRBASearchInputPopup(searchName, searchInfo)")'
		                    searchValue="<%=BDPT_CD%>" text1Value="<%=BDPT_CD%>" text2Value="<%=BDPT_CD_NAME%>"/>
	            	
	            	</div>
	            </div>
	            <div class="table-cell">
					<div class="title">
						<div class="txt">${msgel.getMsg('RBA_50_05_01_01_131','나의 할 일')}</div>
					</div>
					<div class="content">                        
                        <div class="all">
							<input type="checkbox" id="TO_DO_CHECK" name="TO_DO_CHECK" value="Y" checked>
							<label for="TO_DO_CHECK"></label>	
		           		</div>
                        
					</div>
				</div>
	        </div>
	        <div class="table-row" style="width: 46%;">
	        	<div class="table-cell">
	                ${condel.getLabel('RBA_50_07_02_01_003','개선여부')}
		 			
		 			<div class="content">
		                ${SRBACondEL.getSRBASelect('IMPRV_CMPT_YN','300' ,'' ,'R326' ,'','ALL','','','','')}
		 			</div>       
	        	</div>
	        	<div class="table-cell">
	        	</div>
	        </div>			
    </div>
        
    <div class="button-area">
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA004", defaultValue:"등록", mode:"C", function:"doRegister", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"reqApprBtn", defaultValue:"승인요청", mode:"U", function:"openGyljPopUp0", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"apprBtn", defaultValue:"승인", mode:"U", function:"openGyljPopUp2", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"denyBtn", defaultValue:"반려", mode:"U", function:"openGyljPopUp22", cssClass:"btn-36"}')}

    </div>
<%-- 
     <div class="panel panel-primary">
        <div class="panel-footer" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="18%" height="30">
                        <table border="0" cellpadding="0" cellspacing="0" class="btn_area">
                            <tr>
                                <td width="100">
                                    <div class="table-title" style="padding-left:20px;">${msgel.getMsg('RBA_50_07_02_01_004','부점별 현황')}</div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="1%"></td>
                    <td width="76%" height="30">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td height="30">
                                    <div class="table-title" style="padding-left:20px;">${msgel.getMsg('RBA_50_07_02_01_005','부점별 개선방안 상세등록내역')}</div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        <div style="width:18vw" id="GTDataGrid1_Area"></div>
                    </td>
                    <td></td>
                    <td valign="top">
                        <div style="width:75vw" id="GTDataGrid2_Area"></div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
     --%>
    
    <div class="tab-content-bottom" >
		<div class="cont-area3" style="padding-top: 8px;">
			<div class="cont-area3-left" style="width:20%">				
				<div id="GTDataGrid1_Area"></div>
			</div>
			<div class="arrow-area" style="width:1%; background-color: #fff; margin: 293px 0px;" align="center"></div>
			<div class="cont-area3-right" style="width:79%">				
				<div id="GTDataGrid2_Area"></div>
			</div>
		</div>	
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />