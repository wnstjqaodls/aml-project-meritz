<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_30_06_02_01.jsp
* Description     : KRI 모니터링
* Group           : GTONE, R&D센터/개발2본부
* Author          : PJH
* Since           : 2025-06-25
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%@ page import="com.gtone.rba.server.type03.RBA_30.RBA_30_06.RBA_30_06_02.RBA_30_06_02_01"%>
<%
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLE_IDS", ROLE_IDS);
	
	DataObj input = new DataObj();
// 	DataObj output = RBA_30_06_02_01.getInstance().getSearch(input);
%>

<script>
var GridObj1;
var overlay = new Overlay();
var classID= "RBA_30_06_02_01";

	// Initialize
	$(document).ready(function(){
	    setupConditions();
	    setupGrids();
	    setupFilter("init");
	    
	    doSearch();
	});
	
	function setupFilter(FLAG){
		var gridArrs = new Array();
		var gridObj = new Object();
		gridObj.gridID = "GTDataGrid1_Area";
		gridArrs[0] = gridObj;
		
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
	
    function setupGrids(){ 

    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
        	gridId          				: "GTDataGrid1",
        	"width" :"100%",
        	height          : 'calc(90vh - 160px)',             
        	hoverStateEnabled    : true,
            wordWrapEnabled      : false,
            allowColumnResizing  : true,
            columnAutoWidth      : false,
            allowColumnReordering: true,
            cacheEnabled         : false,
            cellHintEnabled      : true,
            showBorders          : true,
            showColumnLines      : true,
            showRowLines         : true,
            export               : {allowExportSelectedData: true, enabled : true, excelFilterEnabled : true, fileName : "${pageTitle}"},
            sorting              : {mode: "multiple"},
            loadPanel            : {enabled: false},
            pager: {
                visible: false,
                showNavigationButtons: true,
                showInfo: true
            },
            paging: {
                enabled: false,
                pageSize: 20
            },
            scrolling: {
                mode: "virtual"
            },
            remoteOperations     : {filtering: false, grouping : false, paging : false, sorting : false, summary : false},
            editing: {mode : "batch", allowUpdating: false, allowAdding : false, allowDeleting : false},
            filterRow            : {visible: false},
            rowAlternationEnabled: false,
//             onCellPrepared   : function(e){
// 							                var columnName = e.column.dataField;
// 							                var dataGrid   = e.component;
// 							                var rowIndex   = dataGrid.getRowIndexByKey(e.key); 
							                
// 									        var MONITOR_RST_NEW            = dataGrid.cellValue(rowIndex, 'MONITOR_RST_NEW');
							                
// 									        if(rowIndex != -1){
// 									        	if(columnName == 'MONITOR_RST_NEW' || columnName == 'MONITOR_RST_OLD'){
// 													 e.cellElement.css('background-color', 'rgb(247 255 128)');
// 								        	}	
// 								}
// 			},
            searchPanel: {visible: false, width : 250},
            selection: {
		        allowSelectAll    : true,
		        deferred          : false,
		        mode              : "multiple",
		        selectAllMode     : "allPages",
		        showCheckBoxesMode: "always"
		    },
            columns: [
            	{dataField: "CNT", 					caption: '${msgel.getMsg("RBA_30_06_01_01_001","순번")}' ,alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, width : 80}, 
            	{dataField: "BAS_YYMM", 					caption: '${msgel.getMsg("RBA_30_06_02_02_005","기준년월")}' ,alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, visible:false}, 
    	        {dataField: "RSK_CATG1_C",				caption: '${msgel.getMsg("RBA_30_06_05_01_002","위험분류 Lv.1")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, visible:false},
    	        {dataField: "RSK_CATG1_C_NM",				caption: '${msgel.getMsg("RBA_30_06_05_01_002","위험분류 Lv.1")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true ,width : 100},
    	        
    	        {dataField: "RSK_CATG2_C",				caption: '${msgel.getMsg("RBA_30_06_05_01_003","위험분류 Lv.2")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true , visible:false}, 
    	        {dataField: "RSK_CATG2_C_NM",			caption: '${msgel.getMsg("RBA_30_06_05_01_003","위험분류 Lv.2")}',				alignment: "center",allowResizing: true,allowSearch  : true,allowSorting : true ,width : 100 },

    	        {dataField: "RSK_ELMT_C",				caption: '${msgel.getMsg("RBA_30_06_05_01_005","위험요소")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, visible:false}, 
    	        {dataField: "RSK_ELMT_C_NM",				caption: '${msgel.getMsg("RBA_30_06_05_01_005","위험요소")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, "cssClass": "link" ,width : 400 }, 
    	        
    	        {dataField: "MSUR_FRQ",				caption: '${msgel.getMsg("RBA_30_06_05_01_019","평가산출 기준")}',alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true , visible:false}, 
    	        {dataField: "MSUR_FRQ_NM",				caption: '${msgel.getMsg("RBA_30_06_05_01_019","평가산출 기준")}',alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true},
    	        {dataField: "APPLY_STD",			caption: '${msgel.getMsg("RBA_30_06_05_01_020","적용기준")}',		alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true} ,
    	        {dataField: "MONITOR_CYCLE",		caption: '${msgel.getMsg("RBA_30_06_01_01_010","모니터링 주기")}' , alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, visible:false},
    	        {dataField: "BRNO_NM",				caption: '${msgel.getMsg("RBA_30_06_05_01_001","대상부점")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true},
    	        {				caption: '${msgel.getMsg("RBA_30_06_05_01_022","모니터링 결과")}', alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true,
    	        	columns :[ 
								{ dataField : "MONITOR_RST_NEW"  , caption: '${msgel.getMsg("RBA_30_06_01_01_013","당기(발생값)")}',
									cellTemplate : function(container,options){
										const value = options.value;
										let grade = "";
										
										const frq = options.data.MSUR_FRQ;
										
										if(frq == "1"){
											grade = options.data.GRADE;
										}else{
											grade = options.data.MONITOR_RST_NEW_GRADE;
										}
										
										let bgColor = "";
										if(grade === "GREEN"){
											bgColor = "#28a745";
										}else if(grade === "YELLOW"){
											bgColor = "#ffc107";
										}else if(grade === "RED"){
											bgColor = "#dc3545";
										}
										
										container.css({
											"background-color" : bgColor
										}).text(grade + "(" + value + ")");
									}
									
									,alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, dataType:"number", format :"fixedPoint", percision:0
								},
								{ dataField : "MONITOR_RST_OLD"  , caption: '${msgel.getMsg("RBA_30_06_01_01_014","전기(발생값)")}',
									cellTemplate : function(container,options){
										const value = options.value;
										let grade = "";
										
										const frq = options.data.MSUR_FRQ;
										
										if(frq == "1"){
											grade = options.data.GRADE;
										}else{
											grade = options.data.MONITOR_RST_NEW_GRADE;
										}
										
										let bgColor = "";
										if(grade === "GREEN"){
											bgColor = "#28a745";
										}else if(grade === "YELLOW"){
											bgColor = "#ffc107";
										}else if(grade === "RED"){
											bgColor = "#dc3545";
										}
										
										container.css({
											"background-color" : bgColor
										}).text(grade + "(" + value + ")");

									}
									, alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, dataType:"number", format :"fixedPoint", percision:0
								}
					 		  ]
        		},
        		{dataField: "INDV_CORP_CCD",	caption      : '${msgel.getMsg("RBA_50_03_02_01_005","적용대상")}',
		            alignment    : "center", visible:false,
		            columns      : [
		            	{
				             dataField            : "INDV_YN",
				             caption              : '${msgel.getMsg("RBA_50_03_02_01_011","개인")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             lookup : { dataSource  : [{"KEY":"1","VALUE":"●"},{"KEY":"0","VALUE":""}] /* {"KEY":"","VALUE":"=선택="}, */
                                               ,displayExpr : "VALUE",valueExpr   : "KEY"},
				             width                : 50
				         },
				         {
				             dataField            : "CORP_YN",
				             caption              : '${msgel.getMsg("RBA_50_03_02_01_012","법인")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             lookup : { dataSource  : [{"KEY":"1","VALUE":"●"},{"KEY":"0","VALUE":""}] /* {"KEY":"","VALUE":"=선택="}, */
                                             ,displayExpr : "VALUE",valueExpr   : "KEY"},
				             width                : 50
				         }
				       ]
		        }
    	    ],
    	    summary: {
		        totalItems: [
		            {
		                column     : "CNT",
		                summaryType: "count"
		            }
		        ]
		    },
            onToolbarPreparing   : makeToolbarButtonGrids,
            onCellClick: function(e){
    	        if(e.data){
    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	        if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
    	        } else {
    	            e.component.clearSelection();
    	            e.component.selectRowsByIndexes(e.rowIndex);
    	        }
    	    }
		    ,"summary" :{totalItems: [{column: 'CNT', summaryType: 'count', valueFormat: "fixedPoint"}],
				texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
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
    
    //KRI 지표 등급 모니터링
    function doSearch(){
    	var params = new Object();
		var methodID = "getSearch";
		overlay.show(true, true);
		params.pageID  = "RBA_30_06_02_01";
		params.classID = "RBA_30_06_02_01";
		params.BAS_YYMM  = form.BAS_YYMM.value; 			// 기준년월
		params.BAS_LONG  = form.BAS_LONG.value;				// 기준반기
// 		params.BRNO		 = form.BRNO.value;					// 대상부점
		params.BRNO		 = $("#SEARCH_DEP_ID").val()=="99999"?"99999":$("#SEARCH_DEP_ID").val();     //부서코드
		params.CA= form.CA.value;							// 위험분류 Lv.1
		params.EV= form.EV.value;							// 위험분류 Lv.2
		params.RSK_ELMT_C_NM= form.RSK_ELMT_C_NM.value;			// 위험요소
		params.OVER_TGT_BRNO   = (form.OVER_TGT_BRNO.checked == true ? "1":"0");  // 한도초과 부점/지표
		params.MONITOR_RST= form.MONITOR_RST.value;			// 모니터링결과
		GridObj1.refresh();
        
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
        
    }
    
    function doSearch_end(gridData, data) {
        
        GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    	setTimeout( "deploy_end()", "3000") ;
    	//overlay.hide();
    	
    }
    
    
    function deploy_end() {
    	overlay.hide();
    }
    
    

    function doSearch_fail(){
		console.log("doSearch_fail");
		GridObj1.refresh();
    }
    
    function doSearchDetail(){
    	var selData  = GridObj1.getSelectedRowsData();

        if(selData == null || selData == ""){
        	showAlert('${msgel.getMsg("RBA_30_06_05_02_004","상세조회할 대상을 선택해주세요.")}','WARN');
        }else{	
        	var rowdata = selData[0];	//한 건만 선택
                 form2.pageID.value    = "RBA_30_06_02_02";
                 form2.classID.value   = "RBA_30_06_02_01";
                 form2.methodID.value   = "getSearchDetail";
                 form2.BAS_YYMM.value = rowdata.BAS_YYMM;
                 form2.RSK_CATG1_C_NM.value = rowdata.RSK_CATG1_C_NM;		// 위험분류 Lv.1
                 form2.RSK_CATG2_C_NM.value = rowdata.RSK_CATG2_C_NM;		// 위험분류 Lv.2
                 form2.RSK_ELMT_C.value = rowdata.RSK_ELMT_C;				// 위험요소
                 form2.RSK_ELMT_C_NM.value = rowdata.RSK_ELMT_C_NM;			// 위험요소
                 form2.INDV_YN.value = rowdata.INDV_YN;		// 적용대상(개인)
                 form2.CORP_YN.value = rowdata.CORP_YN;		// 적용대상(법인)
                 form2.BRNO_NM.value = rowdata.BRNO_NM;						// 대상부점
                 form2.BAS_YYMM.value = rowdata.BAS_YYMM;					// 기준년월
                 form2.MONITOR_RST_NEW.value = rowdata.MONITOR_RST_NEW;		// 당기발생현황
                 
                 form2.EDD_YN.value = rowdata.EDD_YN;		// 당기발생현황
                 
                 form2.target          = form2.pageID.value;
                 var win               = window_popup_open(form2.pageID.value, 1230, 560, '','yes');
                 form2.action          = '<c:url value="/"/>0001.do';
                 form2.submit();
        }
    }
    
 	// 그리드 클릭 - KRI 모니터링 상세 조회 팝업 호출
	function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){
        
        var pageID = "RBA_30_06_02_02";
        var methodID = "getSearchDetail";
        var form2  = document.form2;
        
        if (colId == "RSK_ELMT_C_NM") {
            form2.pageID.value    = "RBA_30_06_02_02";
            form2.classID.value   = "RBA_30_06_02_01";
            form2.methodID.value   = "getSearchDetail";
            form2.BAS_YYMM.value = obj.BAS_YYMM;
            form2.RSK_CATG1_C_NM.value = obj.RSK_CATG1_C_NM;		// 위험분류 Lv.1
            form2.RSK_CATG2_C_NM.value = obj.RSK_CATG2_C_NM;		// 위험분류 Lv.2
            form2.RSK_ELMT_C.value = obj.RSK_ELMT_C;				// 위험요소
            form2.RSK_ELMT_C_NM.value = obj.RSK_ELMT_C_NM;			// 위험요소
            form2.INDV_YN.value = obj.INDV_YN;		// 적용대상(개인)
            form2.CORP_YN.value = obj.CORP_YN;		// 적용대상(법인)
            form2.BRNO_NM.value = obj.BRNO_NM;						// 대상부점
            form2.BAS_YYMM.value = obj.BAS_YYMM;					// 기준연도
            form2.MONITOR_RST_NEW.value = obj.MONITOR_RST_NEW;		// 당기발생현황
            form2.EDD_YN.value = obj.EDD_YN;		// 당기발생현황
            
            form2.target          = form2.pageID.value;
            var win               = window_popup_open(form2.pageID.value, 1230, 560, '','yes');
            form2.action          = '<c:url value="/"/>0001.do';
            form2.submit();
        }
    }
    
</script>
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="RSK_CATG1_C_NM" >
    <input type="hidden" name="RSK_CATG2_C_NM" >
    <input type="hidden" name="RSK_ELMT_C" >
    <input type="hidden" name="RSK_ELMT_C_NM" >
    <input type="hidden" name="BRNO_NM" >
    <input type="hidden" name="BAS_YYMM" >
    <input type="hidden" name="MONITOR_RST_NEW" >
    <input type="hidden" name="INDV_YN" >
    <input type="hidden" name="CORP_YN" >
    <input type="hidden" name="EDD_YN" >
</form>
<form name="form" onkeydown="doEnterEvent('doSearch');">
	<input type="hidden" name="pageID"> 
	<input type="hidden"name="classID"> 
	<input type="hidden" name="methodID">

	<div class="inquiry-table type1" id='condBox1'>
		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel("RBA_30_07_01_02_001","기준연도")}
				${RBACondEL.getKRBASelect('BAS_YYMM','' ,'RBA_KRI_common_getComboData_BasYear' ,'' ,'' ,'' ,'doSearch()','','','ALL')}
			</div>
			<div class="table-cell">
				${condel.getLabel("RBA_30_06_05_01_002","위험분류 Lv.1")}
				${RBACondEL.getKRBASelect('CA','' ,'' ,'CA' ,'' ,'ALL' ,'nextSelectChange2_2("EV", "EV", this)','','','')}
			</div>
		</div>

		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel("RBA_30_06_05_01_021","기준반기")}
				<div class="content">
		          	<select name='BAS_LONG' id='BAS_LONG' class="dropdown">
			           <option class="dropdown-option" value='01' selected>${msgel.getMsg('RBA_30_06_05_01_023','상반기')}</option> 
			           <option class="dropdown-option" value='02' >${msgel.getMsg('RBA_30_06_05_01_024','하반기')}</option>
		       		</select>
				</div>
			</div>
			<div class="table-cell">
				${condel.getLabel("RBA_30_06_05_01_003","위험분류 Lv.2")}
				${RBACondEL.getKRBASelect('EV','150px' ,'' ,'EV' ,'' ,'ALL' ,'doSearch()','','','N')}
			</div>
		</div>

		<div class="table-row">
			<div class="table-cell">
	        	${condel.getLabel('RBA_30_06_05_01_001','대상부점')} 	
				${condel.getBranchSearch('SEARCH_DEP_ID','ALL')}
			</div>
			<div class="table-cell">
				${condel.getLabel("RBA_30_06_05_01_005","위험요소")}
				<div class="content">
					<input type="text" name="RSK_ELMT_C_NM" size="30" class="cond-input-text" style="text-align: left" />
				</div>
			</div>

		</div>
		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel("RBA_30_06_05_01_028","한도초과 부점/지표만 조회")}
				<div class="all">
					<input type="checkbox" id="checkbox1" name="OVER_TGT_BRNO" ${OVER_TGT_BRNO.equals("1") ? "checked='checked'":""}>
					<label for="checkbox1"></label>
				</div>
			</div>

			<div class="table-cell">
				${condel.getLabel("RBA_30_06_05_01_022","모니터링 결과")}
				<div class="content">
					<select name='MONITOR_RST' id='MONITOR_RST' class="dropdown">
						<option class="dropdown-option" value='ALL' selected>::${msgel.getMsg('AML_10_05_01_01_015','전체')}::</option>
						<option class="dropdown-option" value='GREEN'>${msgel.getMsg('RBA_30_06_05_01_025','GREEN')}</option>
						<option class="dropdown-option" value='YELLOW'>${msgel.getMsg('RBA_30_06_05_01_026','YELLOW')}</option>
						<option class="dropdown-option" value='RED'>${msgel.getMsg('RBA_30_06_05_01_027','RED')}</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="button-area">
   		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA_Detail_Search", defaultValue:"상세조회", mode:"R", function:"doSearchDetail", cssClass:"btn-36"}')}
    </div>
	<div class="tab-content-bottom" style="padding-top: 8px;">
		<div id="GTDataGrid1_Area"></div>
	</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />