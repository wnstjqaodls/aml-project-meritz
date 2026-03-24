<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_03_01.jsp
* Description     : 잔여위험 평가
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-05-14
--%>
<%@ page import="com.gtone.aml.basic.common.data.DataObj" %>
<%@ page import="com.gtone.aml.basic.common.util.*"       %>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_01.RBA_50_05_01_01"  %>

<%
    String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    request.setAttribute("ROLE_IDS",ROLE_IDS);
    
    String BRCD = sessionAML.getsAML_BDPT_CD();
    request.setAttribute("BRCD",BRCD);
    
    DataObj input = new DataObj();
    input.put("BRCD",BRCD);
    
//     DataObj output = RBA_50_05_01_01.getInstance().getSearchChart(input);

%>
<script language="JavaScript">

	var GridObj1 = null;
	var GridObj2 = null;
	var overlay = new Overlay();
	var classID  = "RBA_50_05_03_01";

	// Initialize
	$(document).ready(function(){
	    setupConditions();
	    setupGrids1();
	    setupGrids2();
	    setupFilter("init");
	    
	    doSearch();
	    
	    initChart1();
	});

	/** 그리드 셋업 */
	function setupGrids1(){
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
//             export:
// 		     {
// 		         "allowExportSelectedData"  : true,
// 		         "enabled"                  : true,
// 		         "excelFilterEnabled"       : false,
// 		         "fileName"                 : "gridExport"
// 		     },
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
                mode: "standard",
                preloadEnabled: false
            },
            remoteOperations     : {filtering: false, grouping : false, paging : false, sorting : false, summary : false},
            editing: {mode : "batch", allowUpdating: false, allowAdding : false, allowDeleting : false},
            filterRow            : {visible: false},
            rowAlternationEnabled: false,
            searchPanel: {visible: false, width : 250},
            selection: {
    	       	allowSelectAll : true,
    	       	deferred : false,
    	       	mode : "single", /*none, single, multiple*/
    	       	selectAllMode : "allPages",  /*: 'page' | 'allPages'*/
    	       	showCheckBoxesMode : "always"  /*'onClick' | 'onLongTap' | 'always' | 'none'*/
    	    },
		    onCellPrepared : function(e){
		          if(e.rowType === 'data' && ( e.column.dataField === 'REMDR_RSK_GD_C' ) || ( e.column.dataField === 'BF_REMDR_RSK_GD_C' )) {
					 if(e.value === "R1"){
		           		e.cellElement.css("color", "BLUE");
					 }else if(e.value === "R2"){
		           		e.cellElement.css("color", "GREEN");
					 }else if(e.value === "R3"){
		           		e.cellElement.css("color", "#b1b100");
					 }else if(e.value === "R4"){
						 e.cellElement.css("color", "ORANGE");
					 }else if(e.value === "R5"){
						 e.cellElement.css("color", "RED");
					 }else if(e.value === "합계"){
						 e.cellElement.css("font-weight", "bold");
					 }
		          }
	         },
	         onRowPrepared : function(e){
		          if(e.rowType === 'data') {
					 if(e.data.BRNO_NM === "삼성증권"){
		           		e.rowElement.css("background-color", "#dcebfd");
		           		e.rowElement.css("font-weight", "bold");
					 }
		          }
	         },
	         onSelectionChanged : function(e){
				var selectedRow = e.selectedRowsData[0];
				if (selectedRow){

					$('#selectedBrnoNm').val(selectedRow.BRNO_NM);
					$('#selectedBrno').val(selectedRow.BRNO);
					
					doSearch2();

				}
		    },
		    
    	    columns:
		     [
		       
		    	 {
		             dataField            : "MOFC_BRNO_NM",
		             caption              : '${msgel.getMsg("RBA_50_05_03_01_004","부점구분")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 90
		    	 },
		    	 {
		             dataField            : "HGRK_BRNO_NM",
		             caption              : '${msgel.getMsg("RBA_50_05_03_01_004","부점구분")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible			  : false
		    	 },
		    	 {
		             dataField            : "BRNO",
		             caption              : '${msgel.getMsg("RBA_50_05_03_01_005","평가대상부점")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible			  : false,
		             width                : 100
		         },
		         {
		             dataField            : "BRNO_NM",
		             caption              : '${msgel.getMsg("RBA_50_05_03_01_005","평가대상부점")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 120
		         },
		         {
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_001","기준회차")}',
			            alignment    : "center",
			            columns      : [
			            	 {
					             dataField            : "REMDR_RSK_GD_C",
					             caption              : '${msgel.getMsg("RBA_50_05_03_01_006","위험등급")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false,
					         },
						     {
					             dataField            : "FINAL_VAL",
					             caption              : '${msgel.getMsg("RBA_50_05_03_01_007","잔여위험")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false
					         },
						     {
					             dataField            : "RISK_VAL",
					             caption              : '${msgel.getMsg("RBA_50_05_03_01_008","고유위험")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false
					         },
						     {
					             dataField            : "TONGJE_VAL",
					             caption              : '${msgel.getMsg("RBA_50_05_03_01_009","통제효과성")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false
					         }
					         
					    ]
				 },
		         {
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_010","직전회차")}',
			            alignment    : "center",
			            columns      : [
			            	{
					             dataField            : "BF_REMDR_RSK_GD_C",
					             caption              : '${msgel.getMsg("RBA_50_05_03_01_006","위험등급")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false,
					         },
						     {
					             dataField            : "BF_FINAL_VAL",
					             caption              : '${msgel.getMsg("RBA_50_05_03_01_007","잔여위험")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false
					         },
						     {
					             dataField            : "BF_RISK_VAL",
					             caption              : '${msgel.getMsg("RBA_50_05_03_01_008","고유위험")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false
					         },
						     {
					             dataField            : "BF_TONGJE_VAL",
					             caption              : '${msgel.getMsg("RBA_50_05_03_01_009","통제효과성")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false
					         }
					         
					    ]
				 },
				 {
		             dataField            : "CHANGE_GUBUN",
		             caption              : '${msgel.getMsg("RBA_50_05_01_112","변동구분")}',
		             alignment            : "center",
// 		             lookup 			  : { 
// 											  dataSource  : [ 
// 												  		      {"KEY":"00","VALUE":"유지(-)"},
// 															  {"KEY":"01","VALUE":"하락(▼)"},
// 															  {"KEY":"02","VALUE":"상승(▲)"}
// 														    ]
// 		             						  ,displayExpr : "VALUE"
// 		             						  ,valueExpr   : "KEY"
// 		             						},
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible			  : false
		         },

		     ]
	 	    ,summary: {
	 	        totalItems: [
	 	            {
	 	                column     : "MOFC_BRNO_NM",
	 	                summaryType: "count"
	 	            }
	 	        ]
	 	    }
		    ,onToolbarPreparing   : makeToolbarButtonGrids
		}).dxDataGrid("instance");
	}
	
	/** 그리드 셋업 */
	function setupGrids2(){
		GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
			elementAttr: { class: "grid-table-type" },
        	gridId          				: "GTDataGrid2",
        	"width" :"100%",
        	height          : 'calc(46vh - 105px)',             
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
            sorting              : {mode: "multiple"},
            loadPanel            : {enabled: false},
            remoteOperations     : {filtering: false, grouping : false, paging : false, sorting : false, summary : false},
            editing: {mode : "batch", allowUpdating: false, allowAdding : false, allowDeleting : false},
            filterRow            : {visible: false},
            rowAlternationEnabled: false,
            searchPanel: {visible: false, width : 250},
		    onCellPrepared : function(e){
		          if(e.rowType === 'data' && ( e.column.dataField === 'REMDR_RSK_GD_C') ) {
					 if(e.value === "R1"){
		           		e.cellElement.css("color", "BLUE");
					 }else if(e.value === "R2"){
		           		e.cellElement.css("color", "GREEN");
					 }else if(e.value === "R3"){
		           		e.cellElement.css("color", "#b1b100");
					 }else if(e.value === "R4"){
						 e.cellElement.css("color", "ORANGE");
					 }else if(e.value === "R5"){
						 e.cellElement.css("color", "RED");
					 }else if(e.value === "합계"){
						 e.cellElement.css("font-weight", "bold");
					 }
		          }
	         },
    	    columns:
		     [
		       
		    	 {
		             dataField            : "REMDR_RSK_GD_C",
		             caption              : '${msgel.getMsg("RBA_50_05_03_01_006","위험등급")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		         },
		    	 {
		             dataField            : "CUR_BRNO_CNT",
		             caption              : '${msgel.getMsg("RBA_50_05_03_01_203","부점 수")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible			  : true,
		    	 },
		    	 {
		             dataField            : "PREV_BRNO_CNT",
		             caption              : '${msgel.getMsg("RBA_50_05_03_01_204","직전 부점 수")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible			  : true
		    	 }

		     ]
		}).dxDataGrid("instance");
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
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
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
												setupFilter();
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
	
	function doSearch() {
        overlay.show(true, true);

		var params = new Object();
		var methodID = "doSearch";
		
		params.pageID 		   = "RBA_50_05_03_01";
		params.classID 		   = "RBA_50_05_03_01";
		params.CHANGE_GUBUN    = form1.CHANGE_GUBUN.value;
		params.BAS_YYMM        = form1.BAS_YYMM.value;
		params.BRNO		       = $("#SEARCH_DEP_ID").val()=="99999"?"99999":$("#SEARCH_DEP_ID").val();     //부서코드
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
	}
	
    function doSearch_end(gridData, data) {
        overlay.hide();

        GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    	
    	doSearchCnt();

    }

    function doSearch2()
    {
    	overlay.show(true, true);
        var params            = new Object();
 		var methodID          = "getSearchChart1";
		params.BRNO 		  = $("#selectedBrno").val();
// 		params.BRNO_NM 		  = $("#selectedBrnoNm").val();
		params.pageID 		  = "RBA_50_05_03_01";
		params.classID 		  = "RBA_50_05_03_01";
		params.BAS_YYMM       = form1.BAS_YYMM.value;
		
		sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
    }
    
    function doSearch2_success(gridData, data){
    	if(gridData.length>0){
	        var obj = gridData[0];	        
	        form3.JSON_RESULT.value = JSON.stringify(obj.JSON_RESULT);
	        
    	}
    	initChart1();
		overlay.hide();
    }
    
    // 위험등급별 부점 수 , 직전 부점수 그리드
    function doSearchCnt()
	{
    	overlay.show(true, true);
        var params            = new Object();
 		var methodID          = "doSearchCnt";
 		
 		params.pageID 		  = "RBA_50_05_03_01";
		params.classID 		  = "RBA_50_05_03_01";
		params.BAS_YYMM       = form1.BAS_YYMM.value;

		sendService(classID, methodID, params, doSearchCnt_success, doSearch_fail);

	}
    
    function doSearchCnt_success(gridData, data) {
        overlay.hide();

        GridObj2.refresh();
    	GridObj2.option("dataSource", gridData);

    }
    
    function doSearch_fail(){
		console.log("doSearch_fail");
    }
    
    function doPopup() {

    	
        form2.pageID.value = "RBA_50_05_03_02";	//등급별 구간설정 팝업
        form2.BAS_YYMM.value = form1.BAS_YYMM.value ; 
        
        var win;       win = window_popup_open(form2.pageID.value, 700, 500, '','No');
        form2.target       = form2.pageID.value;
        form2.action       = '<c:url value="/"/>0001.do';
        form2.submit();
	}
    
    function doExcelDown() {

		  var workbook = new ExcelJS.Workbook();
	      var worksheet = workbook.addWorksheet('Main sheet');
	
	      DevExpress.excelExporter.exportDataGrid({
	          component: GridObj1,
	          worksheet: worksheet,
	          autoFilterEnabled: true
	      }).then(function () {
	          return workbook.xlsx.writeBuffer();
	      }).then(function (buffer) {
	      	saveAs(new Blob([buffer], { type: 'application/octet-stream' }), '${pageTitle}.xlsx');
	      }).catch(function (error) {
	          console.error("엑셀 내보내기 오류:", error);
	      });
	  }	  
	
	  
    function initChart1(brno) {
	    var dataSource = JSON.parse(form3.JSON_RESULT.value);
	    var brno = $("#selectedBrno").val();
	    
        $("#chart1").dxChart({
              "dataSource": dataSource
             ,"title": {
                        "horizontalAlignment": "left"
                        ,"font": {
                                   "size": 14
                                  ,"family": "ng,Roboto,'Helvetica Neue',Arial,sans-serif"
                                  ,"weight": "bolder"
                                  ,"color": "#409AD6"
                                 }
                       }
        	,"commonSeriesSettings": {
				            			"argumentField": "RISK_TYPE",
				            			 type          : "bar",
				            			 label		   : {
												visible : true,
												position : "outside",
												customizeText : function(e){
													return e.valueText;
												}
				            			 }
			
				          		     }
            ,"series": [
		            	 	{
								type : "bar",
								valueField : "MAX_VAL",
								name : "기준 회차 MAX"
							},
            	 			{
								type : "bar",
								valueField : "CUR_VAL",
								name : "기준 회차 점수"
							},
							{
								type : "bar",
								valueField : "BF_VAL",
								name : "직전 회차 점수"
							}
							

                        ]
             ,"valueAxis" : 
            	 {
            		 visible: false
             	 }
             ,"legend": {
                          "verticalAlignment": "bottom"
                         ,"horizontalAlignment": "center"
                        }
             ,"export": {
                          "enabled": false
                        }
             ,"onPointClick": function (e) {
                                e.target.select();
                              }
        });
    }
	
</script>
<form name="form3">
	<input type="hidden" name="JSON_RESULT">
</form>
<input type="hidden" name="selectedBrno" id="selectedBrno" value="">

<form name="form0" method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
</form>
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
</form>
<form name="form1" method="post" >
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">

    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row">
            <div class="table-cell">
	            ${condel.getLabel("RBA_50_03_02_001","평가회차")}
	            <div class="content">
					${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'doSearch()')}
				</div>
	        </div>
	    </div>
	    	<div class="table-cell">
	    		${condel.getLabel('RBA_50_05_01_112','변동구분')}
		       	<div class="content" >
					<select name="CHANGE_GUBUN" id="CHANGE_GUBUN" class="dropdown" onChange='doSearch()' style="width:160px" >
		            	<option value='ALL' SELECTED >${msgel.getMsg("RBA_50_07_02_01_104","::: 전체 :::")}</option>
		                <option value='02' >${msgel.getMsg("RBA_50_05_01_113","상승")}</option>
		                <option value='00' >${msgel.getMsg("RBA_50_05_01_114","유지")}</option>
		                <option value='01' >${msgel.getMsg("RBA_50_05_01_115","하락")}</option>
		            </select>
				</div>
				${condel.getLabel('RBA_30_06_05_01_001','대상부점')} 	
				${condel.getBranchSearch('SEARCH_DEP_ID','ALL')}
            </div>
	</div>
	
	<div class="button-area">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"excelDownBtn2", defaultValue:"Excel 다운로드", mode:"R", function:"doExcelDown", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"doRbaLevel", defaultValue:"등급별구간설정", mode:"R", function:"doPopup", cssClass:"btn-36 filled"}')}
	</div>

	<div style="display: flex; gap:20px;">
		<div class="tab-content-bottom" style="width:65%;">
	        <div id = "GTDataGrid1_Area" style="padding-top:8px;"></div>
	    </div>
	    <div class="tab-content-bottom" style="width:35%; padding-top:44px;">
			<div class="dash-board-cont-box">
				<div id = "GTDataGrid2_Area" ></div>
			</div>
			<div class="table-cell">
		            ${condel.getLabel("RBA_50_04_01_01_005","평가대상부점")}
					<input type="text" class="cond-input-text" id="selectedBrnoNm" name="selectedBrnoNm" style="text-align:center" readOnly />
	        	</div>
                <div style="display:inline-block;width:calc(100%); height:250px; padding-top:4px;">
                	<div id="chart1" style="width:100%;height:85%;text-align:center;"></div>
                </div>
	    </div>
    </div>
</form>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />