<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_04_04_01.jsp
* Description     : 부서별내부통제점검항목관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-10
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLE_IDS",ROLE_IDS);

%>
<style type="text/css">
    * { white-space: nowrap;}
</style>
<script language="JavaScript">

	var GridObj1 = null;
	var GridObj2 = null;
    var overlay = new Overlay();
    var classID  = "RBA_50_04_04_01";

    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids1();
        setupGrids2();
        setupFilter("init");
        setupFilter2("init");
        //$("#TONGJE_MDDV_C").attr("style","width:230px;");
        setTimeout("doSearch()", 1000);
    });

    // Initial function
    function init() { initPage(); }

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridObj.title = "${condel.getLabel('RBA_50_01_01_216','부서목록')}";
    	gridArrs[0] = gridObj;

    	setupGridFilter2(gridArrs,FLAG);
    }

    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridObj.title = "${condel.getLabel('RBA_50_01_01_237','통제점검항목')}";
    	gridArrs[1] = gridObj;

    	setupGridFilter2(gridArrs,FLAG);
    }

    // 그리드 초기화 함수 셋업
    /* function setupGrids() {

    	 // 그리드1(Code Head) 초기화
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_04_04_01_Grid2'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(83vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,completedEvent  : function(){
        	   setTimeout("doSearch()", 1000)
        	   ;

               // 그리드2(Code Head) 초기화
        	   GridObj2 = initGrid3({
                   gridId          : 'GTDataGrid2'
                  ,headerId        : 'RBA_50_04_04_01_Grid1'
                  ,gridAreaId      : 'GTDataGrid2_Area'
                  ,height          : 'calc(83vh - 100px)'
                  ,useAuthYN       : '${outputAuth.USE_YN}'
                  ,completedEvent  : function(){
                	  setupGridFilter([GridObj1,GridObj2]);
                  }
               });
            }
           ,failEvent : doSearch_end
        });
    } */

    function setupGrids1(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			elementAttr: { class: "grid-table-type" },
    		height 				  : "calc(80vh - 100px)",
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
		        fileName               : "부서별 통제 점검항목 관리_부서목록.xlsx"
		    },
// 			onExporting: function (e) {
//     	    	var workbook = new ExcelJS.Workbook();
//     	    	var worksheet = workbook.addWorksheet("Sheet1");
//     		    DevExpress.excelExporter.exportDataGrid({
//     		        component: e.component,
//     		        worksheet: worksheet,
//     		        autoFilterEnabled: true,
//     		    }).then(function(){
//     		        workbook.xlsx.writeBuffer().then(function(buffer){
//     		            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}.xlsx");
//     		        });
//     		    });
//     		    e.cancel = true;
//             },
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
		    onToolbarPreparing   : makeToolbarButtonGrids,
		    filterRow            : {visible: false},
		    pager: {
		        visible: false,
		        showNavigationButtons: true,
		        showInfo: true
		    },
		    paging: {
		        enabled: false,
		        pageSize: 120
		    },
		    scrolling: {
		        mode: "virtual"
		    },
		    rowAlternationEnabled: true,
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
    	    columns:
		     [
		    	 {
			            dataField    : "BRNO",
			            caption      : '${msgel.getMsg("RBA_50_01_02_01_003","부서코드")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 60
			        },
			        {
			            dataField    : "MOFC_BRN_NAME",
			            caption      : '${msgel.getMsg("RBA_50_01_02_01_006","본점/지점")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 60
			        },
			        {
			            dataField    : "BRNO_NM",
			            caption      : '${msgel.getMsg("RBA_50_01_02_01_004","부서명")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width        : 100
			        },
			        {
			            dataField    : "AML_TJ_BRNO_YN",
			            caption      : 'MAIL전송여부',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible: false
			        },{
			            dataField    : "RNM",
			            caption      : '담당자 이름',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 100
			        },{
			            dataField    : "RUSER_ID",
			            caption      : '담당자 사번',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 100
			         },{
			            dataField    : "REMAIL",
			            caption      : '담당자 EMAIL',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 180
			         },{
			            dataField    : "BNM",
			            caption      : '책임자 이름',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 100
			         },{
			            dataField    : "BUSER_ID",
			            caption      : '책임자 사번',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 100
			        },{
			            dataField    : "BEMAIL",
			            caption      : '책임자 EMAIL',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 180
			        }
			        ,{
			            dataField    : "COUNT",
			            caption      : '${msgel.getMsg("RBA_50_04_04_01_100","통제업무건수")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 60
			        }
			        

		     ],
		     onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
		    ,"summary" :{totalItems: [{column: 'BRNO', summaryType: 'count', valueFormat: "fixedPoint"}],
				texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
		}).dxDataGrid("instance");
	}

    function setupGrids2(){
   	 GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
			 height	:"calc(80vh - 100px)",
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
			        fileName               : "부서별 통제 점검항목 관리_통제점검항목.xlsx"
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
			    editing: { mode: 'batch', allowUpdating: true, allowAdding: false, allowDeleting: false, selectTextOnEditStart: true},
			    onToolbarPreparing   : makeToolbarButtonGrids,
			    filterRow            : {visible: false},
			    pager: {
			        visible: false,
			        showNavigationButtons: true,
			        showInfo: true
			    },
			    paging: {
			        enabled: false,
			        pageSize: 60
			    },
			    scrolling: {
			        mode: "virtual"
			    },
			    rowAlternationEnabled: true,
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
			            dataField    : "TGT_YN",
			            caption      : '${msgel.getMsg("RBA_50_04_04_01_103","대상여부")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            lookup : { dataSource  : [{"KEY":"1","VALUE":"Y"},{"KEY":"0","VALUE":"N"}]
                        ,displayExpr : "VALUE",valueExpr   : "KEY"},
			            width : 55

			        },
			        {
			            dataField    : "BAS_YYMM",
			            caption      : '기준년월',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible: false
			        },
			        {
			            dataField    : "CNTL_CATG1_C",
			            caption      : '${msgel.getMsg("RBA_50_04_01_01_001","통제분류Lv1")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible      : false,
			            width : 150
			        },
			        {
			            dataField    : "CNTL_CATG1_C_NM",
			            caption      : '${msgel.getMsg("RBA_50_04_01_01_001","통제분류Lv1")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 90
			        },
			        {
			            dataField    : "CNTL_CATG2_C",
			            caption      : '${msgel.getMsg("RBA_50_04_01_01_002","통제분류Lv2")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible      : false,
			            width : 50
			        }, {
			            dataField    : "CNTL_CATG2_C_NM",
			            caption      : '${msgel.getMsg("RBA_50_04_01_01_002","통제분류Lv2")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80
			        },
			        {
			            dataField    : "CNTL_ELMN_C",
			            caption      : '${msgel.getMsg("RBA_50_04_01_01_003","통제요소")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible      : false,
			            width : 30
			        },
			        {
			            dataField    : "CNTL_ELMN_C_NM",
			            caption      : '${msgel.getMsg("RBA_50_04_01_01_003","통제요소")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 200
			        },
			        {
			            dataField    : "USE_YN",
			            caption      : '${msgel.getMsg("RBA_50_03_02_01_007","사용여부")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible      : false,
			            lookup : { dataSource  : [{"KEY":"1","VALUE":"Y"},{"KEY":"0","VALUE":"N"}]
                        ,displayExpr : "VALUE",valueExpr   : "KEY"},
			            width : 100
			        },
			        {
			            dataField    : "EVAL_TYPE_CD",
			            caption      : '${msgel.getMsg("RBA_50_04_01_01_004","평가유형")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80,
			            lookup : { dataSource  : [{"KEY":"1","VALUE":"단일 Y/N"},{"KEY":"2","VALUE":"복수 Y/N"},{"KEY":"3","VALUE":"실적입력"}] /* {"KEY":"","VALUE":"=선택="}, */
                        ,displayExpr : "VALUE",valueExpr   : "KEY"}
			        }
			        ,{
			            dataField    : "VALT_SDT",
			            caption      : '시작일자',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible: false
			        },{
			            dataField    : "VALT_EDT",
			            caption      : '시작일자',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible: false
			        },{
			            dataField    : "TGT_TRN_SDT",
			            caption      : '시작일자',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible: false
			        },{
			            dataField    : "TGT_TRN_EDT",
			            caption      : '시작일자',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible: false
			        }
			    ],
			    onCellPrepared : function(e){
			          if(e.rowType === 'data' && ( e.column.dataField === 'TGT_YN' ) ){
			           e.cellElement.css("color", "blue");
			          }
			    },
			    onCellClick: function(e){
			        if(e.data){
			           /* Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField); */
			        }
			    }
			    ,"summary" :{totalItems: [{column: 'TGT_YN', summaryType: 'count', valueFormat: "fixedPoint"}],
					texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
			}).dxDataGrid("instance");
   }

    // 검색조건 셋업
    function setupConditions() {
    	try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,true);
            cbox1.setItemWidths(220, 70, 0);
            cbox1.setItemWidths(220, 70, 1);
            cbox1.setItemWidths(220, 70, 2);

        } catch (e) {
        	showAlert(e.message,'ERR');
        }
    }

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

    //부점 조회
    function doSearch() {

		overlay.show(true, true);
        var params = new Object();
        var methodID    = "doSearch";
		var classID     = "RBA_50_04_04_01";

		params.pageID 	  = "RBA_50_04_04_01";
		params.BAS_YYMM   = $("#BAS_YYMM").val();//기준연도
		params.BRNO       = $("#SEARCH_DEP_ID").val()=="99999"?"ALL":$("#SEARCH_DEP_ID").val();

		sendService(classID, methodID, params, doSearch_success, doSearch_fail);

	}


    //Control Category end
    function doSearch_success(gridData) {
    	overlay.hide();
    	 try {
    		 GridObj1.refresh();
    		 GridObj1.option("dataSource", gridData);
     		 var row = gridData.length;


    	        if(row > 0){
    	        	GridObj1.refresh().then(function() {
             		  GridObj1.selectRowsByIndexes(0);
             		  Grid1Select( gridData[0] );
	             	});
	             	doSearch2(gridData);
    	        }else{
    				showAlert('${msgel.getMsg("RBA_50_04_04_01_102","조회결과가 없습니다.")}',"INFO");
    				GridObj1.clearSelection();
    				GridObj1.option('dataSource', []);
    				GridObj2.clearSelection();
    	     		GridObj2.option('dataSource', []);
    	        }
    		 } catch (e) {
    	        overlay.hide();
    	    } finally {
    	        overlay.hide();
    	    }
    }

    function doSearch_fail(){
    	overlay.hide();
    }

    function doSearch2(gridData) {
    	overlay.show(true, true);

        var classID  = "RBA_50_04_04_01";
        var methodID = "doSearch2";
        var params = new Object();
        params.pageID		= "RBA_50_04_04_01";
        params.BAS_YYMM		= $("#BAS_YYMM").val();
        params.BRNO         = gridData[0].BRNO;
        params.CNTL_CATG1_C = form.CNTL_CATG1_C.value;
        params.CNTL_CATG2_C = form.CNTL_CATG2_C.value;
        params.CNTL_ELMN_C_NM = form.CNTL_ELMN_C_NM.value;
        params.USE_YN       = form.USE_YN.value;

        sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
    }

    function doSearch2_success(gridData, data){
    	overlay.hide();
        try {
        	GridObj2.refresh();
        	GridObj2.option("dataSource",gridData);

    		var row = gridData.length;

    		//
   	        if(row > 0){
   	        	var cellData =  gridData[0];

   	        	//alert( "cellData : " + cellData.FIX_YN );

 	    		form.finish_yn.value = ( cellData.FIX_YN == "0") ? "N":"Y";
 	    		form.ING_STEP.value = cellData.ING_STEP;
 	    		form.ING_STEP_NM.value = cellData.ING_STEP_NM;
 	    		//Grid1Select2(cellData);
 	    		form2.VALT_SDT.value           = cellData.VALT_SDT             ;
	 	       	form2.VALT_EDT.value           = cellData.VALT_EDT             ;
	 	       	form2.TGT_TRN_SDT.value        = cellData.TGT_TRN_SDT          ;
	 	       	form2.TGT_TRN_EDT.value        = cellData.TGT_TRN_EDT          ;
	 	       	
	 	       	//alert( " cellData.VALT_SDT " + cellData.VALT_SDT );
   	        }


   		} catch (e) {
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }

    // 그리드 CellClick function
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId){

    	overlay.show(true, true);
        var selectRow = GridObj1.getSelectedRowsData();
        var methodID = "doSearch2";	//RBA_50_04_03_01_doSearch2
        var params = new Object();
        params.pageID	= "RBA_50_04_04_01";
        params.BAS_YYMM     	 = $("#BAS_YYMM").val();	//평가기준월
        params.BRNO     	     = obj.BRNO;			//부서
        params.CNTL_CATG1_C      = form.CNTL_CATG1_C.value;
        params.CNTL_CATG2_C      = form.CNTL_CATG2_C.value;
        params.USE_YN            = form.USE_YN.value;
        
        Grid1Select(obj);

        sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
    }
    
    function Grid1Select(obj) {
    	form2.BRNO.value            = obj.BRNO              ;
    	form2.MOFC_BRN_NAME.value   = obj.MOFC_BRN_NAME     ;
    	form2.BRNO_NM.value         = obj.BRNO_NM           ;
    	form2.AML_TJ_BRNO_YN.value  = obj.AML_TJ_BRNO_YN    ;
    	form2.RNM.value             = obj.RNM               ;
    	form2.RUSER_ID.value        = obj.RUSER_ID          ;
    	form2.REMAIL.value          = obj.REMAIL            ;
    	form2.BNM.value             = obj.BNM               ;
    	form2.BUSER_ID.value        = obj.BUSER_ID          ;
    	form2.BEMAIL.value          = obj.BEMAIL            ;
    	form2.COUNT.value           = obj.COUNT             ;
    	
    	form2.GYLJ_S_C_NM.value     = obj.GYLJ_S_C_NM;  // 결재상태

    }
    
    function Grid1Select2(obj) {
    	form2.VALT_SDT.value           = obj.VALT_SDT             ;
    	form2.VALT_EDT.value           = obj.VALT_EDT             ;
    	form2.TGT_TRN_SDT.value        = obj.TGT_TRN_SDT          ;
    	form2.TGT_TRN_EDT.value        = obj.TGT_TRN_EDT          ;
    	
    	alert( " stdate : " + selectRow[0].VALT_SDT);
    }

    function Grid2CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId){

    	alert( "값 : " + obj.TGT_YN );



        /* var selectRow = GridObj2.getSelectedRowsData();


        params.BAS_YYMM     	 = $("#BAS_YYMM").val();	//평가기준월
        params.BRNO     	     = obj.BRNO;			//부서
        params.CNTL_CATG1_C      = form.CNTL_CATG1_C.value;
        params.CNTL_CATG2_C      = form.CNTL_CATG2_C.value;
        params.USE_YN            = form.USE_YN.value; */

    }



    function doSave(){
    	if(form.ING_STEP.value != "50"){
			showAlert('${msgel.getMsg("RBA_50_01_01_01_115","확정이전 단계에서만 할수 있습니다.")}','WARN');
       		return;
		}
    	
    	if(form2.GYLJ_S_C_NM.value == "결재요청" || form2.GYLJ_S_C_NM.value == "결재완료"){
			showAlert('통제요소 결제진행 중에는 저장이 불가능 합니다.','WARN');
       		return;
		}

    	/*최근 형가일정인지 체크  */
    	//if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}','WARN'); return;};
    	/*업무 실제 종료일자 확인  */
    	//if(!chkCommValidation("CHK_MODIFY_POSSI_REAL_DT")) {alert('${msgel.getMsg("RBA_50_02_01_011","해당 업무단계의 실제종료일이 작성되어 있어 수정 불가능 합니다.")}'); return;};

    	//alert( "call doSave()2 ");

    	var obj1  = GridObj1.getSelectedRowsData()[0];

    	//alert( "call doSave()3 ");

        if(obj1 == undefined){
        	showAlert('${msgel.getMsg("AML_20_08_04_02_003","지점을 선택해 주세요.")}','WARN');
        	overlay.hide();
        	return;
        }



		var rowsData = GridObj2.getDataSource().items();
		var gobj; gobj = $('#GTDataGrid2_Area').dxDataGrid('instance');
		gobj.saveEditData();

		//alert( "call doSave()4 ");

	    showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){
	    	overlay.show(true, true);
        	var params   = new Object();
        	var methodID = "doSave";

        	params.pageID 	     = "RBA_50_04_04_01";
        	params.BAS_YYMM      =  $("#BAS_YYMM").val();
        	params.BRNO          = obj1.BRNO;
        	params.gridData      = rowsData;	//obj2;
        	
            params.CNTL_CATG1_C = form.CNTL_CATG1_C.value;
            params.CNTL_CATG2_C = form.CNTL_CATG2_C.value;
            params.CNTL_ELMN_C_NM = form.CNTL_ELMN_C_NM.value;
            params.USE_YN       = form.USE_YN.value;

            sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
            
            
            

        	//alert( "call doSave()4 ");
        	sendService(classID, methodID, params, doSave_end, doSave_end);
        });
    }
    function doSave_end(){
    	saveYn = true;
    	overlay.hide();
    	doSearch();
    }


    function doConfirm() {

/*     	if( form2.GYLJ_S_C_NM.value != "결재완료" ){
			showAlert('통제요소 결제완료 후, 확정이 가능 합니다.','WARN');
       		return;
		} */

		if(form.ING_STEP.value == "50"){

            showConfirm("${msgel.getMsg('RBA_50_01_01_006','확정을 하시겠습니까?')}", "확정",function(){
                     var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = $("#BAS_YYMM").val();
                     params.FIX_YN = "1";
                     params.ING_STEP = "60";  //confirmState
                     params.RBA_VALT_SMDV_C = "3.3";

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);

            });


        }else{
        	if(form.ING_STEP.value == "60" || form.ING_STEP.value == "61"){

	            showConfirm("${msgel.getMsg('RBA_50_01_01_007','확정을 취소하시겠습니까?')}", "취소",function(){
	            	// $("button[id='btn_07']").prop('disabled', true);

	                 var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = $("#BAS_YYMM").val();
                     params.FIX_YN = "0";
                     params.ING_STEP = "50";  //confirmState
                     params.RBA_VALT_SMDV_C = "3.3";

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);
	            });
        	}else {
        		// 일정정보관리 확정단계에서만 취소 할수 있습니다. ==> 라고 수정이 필요
        		showAlert('${msgel.getMsg("RBA_50_01_01_01_113","이후 확정된 STEP을 취소후 진행 할수 있습니다.")}','WARN');
           		return;
            }
        }



	}

	function doConfirm_end() {
        //$("button[id='btn_04']").prop('disabled', false);
        doSearch();
    }
	
	//배치수행
    function doStartBatch(){
               
       if(form.ING_STEP.value < 60) {
          showAlert('${msgel.getMsg("RBA_50_01_01_249","부서별 통제요소관리 확정이후에 배치수행 가능합니다.")}','WARN');
          return;
       }

       
       showConfirm( $("#BAS_YYMM").val().substring(0,4) + "년 : "+ $("#BAS_YYMM").val().substring(5,6) + "회차의 통제요소 배분 배치를 수행 하시겠습니까 ?","배치",function(){
    	   var params   = new Object();
    	   var methodID = "startBatch";
    	   var classID  = "RBA_50_03_03_01";
    	   
    	   overlay.show(true, true);
    	    		
    	   params.pageID 	= "RBA_50_04_04_01";
    	   params.BAS_YYMM  = $("#BAS_YYMM").val(); //기준연도3
    	   params.ING_STEP  = "3.3";
    	   
    	   
           
    	   
    	   sendService(classID, methodID, params, doStartBatch_end, doStartBatch_end); 
       });
       
       

     }
    
    function doStartBatch_end(){
    	overlay.hide();
    }
    
    
    function doMailPop()
    {
    	
		if(form.ING_STEP.value == "60" || form.ING_STEP.value == "61"){
    	
	    	 form2.pageID.value = "RBA_50_04_04_02";
	    	 form2.P_BAS_YYYY.value = $("#BAS_YYMM").val().substring(0,4);
	    	 form2.P_VALT_TRN.value = $("#BAS_YYMM").val().substring(4,6);
	    	 form2.BAS_YYMM.value = $("#BAS_YYMM").val();
	    	 
	         var win            = window_popup_open(form2.pageID.value, 620, 800, '','No');         
	         form2.target       = form2.pageID.value;
	         form2.action       = '<c:url value="/"/>0001.do';
	         form2.submit();
		} else {

			showAlert('통제요소 확정상태 이후에 메일전송이 가능합니다.','WARN');
	        return;
		
		}
    }






</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="P_GUBN" >
    <input type="hidden" name="BAS_YYMM" >
    <input type="hidden" name="P_BAS_YYYY">           <!-- 기준년도              -->
    <input type="hidden" name="P_VALT_TRN">           <!-- 회차                  -->
    <input type="hidden" name="BRNO" >
    <input type="hidden" name="MOFC_BRN_NAME" >
    <input type="hidden" name="BRNO_NM" >
    <input type="hidden" name="AML_TJ_BRNO_YN" >
    <input type="hidden" name="RNM" >
    <input type="hidden" name="RUSER_ID" >
    <input type="hidden" name="REMAIL" >
    <input type="hidden" name="BNM" >
    <input type="hidden" name="BUSER_ID" >
    <input type="hidden" name="BEMAIL" >
    <input type="hidden" name="COUNT" >
    <input type="hidden" name="VALT_SDT" >
    <input type="hidden" name="VALT_EDT" >
    <input type="hidden" name="TGT_TRN_SDT" >
    <input type="hidden" name="TGT_TRN_EDT" >
    <input type="hidden" name="GYLJ_S_C_NM" >
</form>
<form name="form">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >

    <div class="inquiry-table" id="condBox1">
        <div class="table-row">
        	<div class="table-cell">
            	${condel.getLabel('RBA_50_03_02_001','평가회차')}
            	<div class="content">
                	<%-- ${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'doSearch()')} --%>
                	<RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="Y" eventFunction='doSearch()'/>
            	</div>
            </div>
            <div class="table-cell">
            	${condel.getLabel('RBA_50_01_03_014','부서명')}
            	${condel.getBranchSearch('SEARCH_DEP_ID','ALL')}
            </div>
        </div>
        <div class="table-row">
        	<div class="table-cell">
      	 		${condel.getLabel('RBA_50_04_01_01_001','통제분류Lv1')}
      	 		${RBACondEL.getKRBASelect('CNTL_CATG1_C','' ,'' ,'P001' ,'' ,'ALL' ,'nextSelectChange2_2("CNTL_CATG2_C", "P002", this)','','','')}
	 		</div>
            <div class="table-cell">
            	${condel.getLabel('RBA_50_02_01_013','사용여부')}
            	<div class="content">
                	<select id='USE_YN' name='USE_YN' class="dropdown" style="width:80px">
                     	<option class="dropdown-option" value='' >::전체::</option>
                     	<option class="dropdown-option" value='0' >N</option>
                     	<option class="dropdown-option" value='1' SELECTED>Y</option>
                 	</select>
                </div>
            </div>
        </div>
        <div class="table-row">
        	<div class="table-cell">
      			${condel.getLabel('RBA_50_04_01_01_002','통제분류Lv2')}
	         	${JRBACondEL.getSRBASelect('','CNTL_CATG2_C' ,'P002' ,'160px' ,'' ,'' ,'ALL','')}
	 		</div>
            <div class="table-cell">
	      		${condel.getLabel('RBA_50_04_01_01_010','확정여부')}
	      		<div class="content"><input name="finish_yn" type="text" value="" class="cond-input-text" style="width:160px" readonly /></div>
		 	</div>
        </div>
        <div class="table-row">

		 	<div class="table-cell">
	       		${condel.getLabel('RBA_50_04_01_01_003','통제요소')}
	       		<div class="content"><input name="CNTL_ELMN_C_NM" type="text" value="" class="cond-input-text" size="30" /></div>
		 	</div>
            <div class="table-cell">
		       	${condel.getLabel("RBA_50_01_01_047","진행상태")}
		       	<div class="content">
            		<input type="text" name= "ING_STEP_NM" size="30" class="cond-input-text" style="text-align:left" readonly="readonly" />
            	</div>
		 	</div>
        </div>






    </div>

    <div class="cond-line"></div>
    <div class="button-area" style="text-align:right">
        <input type="text" class="cond-input-text" name="ING_STEP" id="ING_STEP" value="${ING_STEP}" style="border: 0px;background-color:white;color:white" readonly="readonly"></input>
    	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
    	${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"RBA001", defaultValue:"확정/취소", mode:"U", function:"doConfirm", cssClass:"btn-36 outlined"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"RBA022", defaultValue:"배치처리", mode:"C", function:"doStartBatch", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"sendMailBtn", defaultValue:"메일전송", mode:"C", function:"doMailPop", cssClass:"btn-36"}')}
    </div>

 	<div class="tab-content-bottom" style="padding-top: 8px;">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	        <tr>
	            <td valign="top">
	                <div id="GTDataGrid1_Area" style="width:65vw"></div>
	            </td>


	            <td style="margin-left: 1vw; width: 3vw;" ></td>


	            <td valign="top">
	                <div id="GTDataGrid2_Area" style="margin-left:1vw;width:31vw"></div>
	            </td>

	        </tr>
	    </table>
    </div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />