<%@page import="com.gtone.aml.util.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_01_01.jsp
* Description     : ML/TF 위험평가
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-30
--%>
<%@ page import="com.gtone.aml.basic.common.data.DataObj" %>
<%@ page import="com.gtone.aml.basic.common.util.*"       %>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_02.RBA_50_05_02_01"  %>

<%
    String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    request.setAttribute("ROLE_IDS",ROLE_IDS);
    
    String BRCD = sessionAML.getsAML_BDPT_CD();
    request.setAttribute("BRCD",BRCD);
    
    DataObj input = new DataObj();
    input.put("BRCD",BRCD);
    
    DataObj output = RBA_50_05_02_01.getInstance().getSearchChart1(input);
//  	DataObj output = MDaoUtilSingle.getData("RBA_50_05_02_01_getChart" , input);
%>
<script language="JavaScript">

	var GridObj1 = null;
	var overlay = new Overlay();
	var classID  = "RBA_50_05_02_01";

	// Initialize
	$(document).ready(function(){
	    setupConditions();
	    setupGrids();
	    setupFilter("init");
	    
	    doSearch();
	    
	    initChart1();
	});

	/** 그리드 셋업 */
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
                mode: "virtual"
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
		          if(e.rowType === 'data' && ( e.column.dataField === 'UP_DOWN_INFO') ) {
					 if(e.value === "상승"){
		           		e.cellElement.css("color", "red");
					 }else if(e.value === "하락"){
		           		e.cellElement.css("color", "blue");
					 }else{
		           		e.cellElement.css("color", "black");
					 }
		          }
	         },
	         onRowPrepared : function(e){
		          if(e.rowType === 'data') {
					 if(e.data.CNTL_CATG1_C_NM === "통제요소 전체"){
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
//	 					initChart1(brno);
//	 					loadChart(selectedRow.HGRK_BRNO);

					}
		         },
    	    columns:
		     [
		       
		    	 {
		             dataField            : "SORT_ORDER",
		             caption			  : '${msgel.getMsg("RBA_30_06_01_01_001","순번")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible			  : false
		         },
		    	 {
		             dataField            : "HG_RNK_DPRT_CD",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_006","부점구분")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible			  : false
		    	 },
		    	 {
		             dataField            : "MOFC_BRNO_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_006","부점구분")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 150
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
		             width                : 180
		         },
		         {
		             dataField            : "CNTL_CATG1_C",
		             caption              : '${msgel.getMsg("RBA_50_04_01_02_001","통제분류Lv1")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false
		         },
		    	 {
		             dataField            : "CNTL_CATG1_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_01_02_001","통제분류Lv1")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true
		         },
		         {
		             dataField            : "TONGJE_VAL",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_012","통과효과성")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		         },
			     {
		             dataField            : "BF_TONGJE_VAL",
		             caption              : '${msgel.getMsg("RBA_50_05_02_01_115","직전통제효과성")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false
		         }
		         , {
		             dataField            : "UP_DOWN_INFO",
		             caption              : '${msgel.getMsg("RBA_50_05_01_112","변동구분")}',
		             alignment            : "center",
		             lookup 			  : { 
											  dataSource  : [ 
												  		      {"KEY":"유지","VALUE":"유지(-)"},
															  {"KEY":"하락","VALUE":"하락(▼)"},
															  {"KEY":"상승","VALUE":"상승(▲)"}
														    ]
		             						  ,displayExpr : "VALUE"
		             						  ,valueExpr   : "KEY"
		             						},
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		         },

		     ]
	        ,summary :{totalItems: [{column: 'MOFC_BRNO_NM', summaryType: 'count', valueFormat: "fixedPoint"}],
						texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
		    ,onToolbarPreparing   : makeToolbarButtonGrids
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
		
		params.pageID 		   = "RBA_50_05_02_01";
		params.classID 		   = "RBA_50_05_02_01";
		params.BAS_YYMM        = form1.BAS_YYMM.value;
		params.CNTL_CATG1_C    = form1.CNTL_CATG1_C.value;
		params.CHANGE_GUBUN    = form1.CHANGE_GUBUN.value;
		
		params.BRNO		       = $("#SEARCH_DEP_ID").val()=="99999"?"99999":$("#SEARCH_DEP_ID").val();     //부서코드

		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
	}
	
    function doSearch_end(gridData, data) {
        overlay.hide();

        GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    	
//     	doSearch2();
    }
    
    function doSearch2()
    {
    	overlay.show(true, true);
        var params            = new Object();
 		var methodID          = "getSearchChart1";
		var brnoNm 			  = $("selectedBrnoNm").val();

		params.pageID 		  = "RBA_50_05_02_01";
		params.classID 		  = "RBA_50_05_02_01";
		params.BAS_YYMM       = form1.BAS_YYMM.value;
		params.BRNO 		  = $("#selectedBrno").val();
		
		params.CHANGE_GUBUN    = form1.CHANGE_GUBUN.value;
			
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

    function doSearch_fail(){
		console.log("doSearch_fail");
    }
    

	function doExcelDown() {
		ExcelDownHistorySave();
		return;
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
		    var brno = $("#selectedBrnoNm").val();
		  
	        $("#chart1").dxChart({
	              "dataSource": dataSource			// 초기차트 미출력
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
									valueField : "MAX_SCORE",
									name : "기준회차 MAX"
								},
	            	 			{
									type : "bar",
									valueField : "CUR_SCORE",
									name : "기준회차 통제효과성"
								},
								{
									type : "bar",
									valueField : "PREV_SCORE",
									name : "직전회차 통제효과성"
								},

	                        ]
	             ,"valueAxis" : 
            	 {
            		 "visible": false
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
	
		// 개선 조치 요청 팝업 호출
	    function doImprove() {
	        var selData  = GridObj1.getSelectedRowsData();

	        if(selData == null || selData == ""){
	        	showAlert('${msgel.getMsg("RBA_50_05_01_117","개선조치할 대상을 선택해주세요.")}','WARN');
	        } else if(selData[i].BRNO_NM == '삼성증권'){	
	        	showAlert('${msgel.getMsg("RBA_50_05_01_118","평가대상부점이 [삼성증권] 인 경우 개선조치요청이 불가합니다.")}','WARN');
	        } else{	
	        	var rowdata = selData[0];	//한 건만 선택
	                 form2.pageID.value    = "RBA_50_05_06_02";
//	                  form2.classID.value   = "RBA_50_05_06_02";
			         form2.addGubun.value     	=  "Y";
	                 form2.BAS_YYMM.value = form1.BAS_YYMM.value;
	                 form2.CNTL_CATG1_C.value = rowdata.CNTL_CATG1_C;		// 위험분류 Lv.1
	                 form2.CNTL_CATG1_C_NM.value = rowdata.CNTL_CATG1_C_NM;		// 위험분류 Lv.1
	                 form2.CNTL_ELMN_C.value = "ALL";				// 위험요소
	                 form2.CNTL_ELMN_C_NM.value = "ALL";				// 위험요소
	                 form2.BRNO_NM.value = rowdata.BRNO_NM;						// 대상부점
	                 form2.BRNO.value = rowdata.BRNO;						// 대상부점

	                 form2.target          = form2.pageID.value;
	                 var win               = window_popup_open(form2.pageID.value, 1230, 560, '','yes');
	                 form2.action          = '<c:url value="/"/>0001.do';
	                 form2.submit();
	        }
	    }
</script>
<form name="form3">
	<input type="hidden" name="JSON_RESULT">
</form>
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
    <input type="hidden" name="CNTL_CATG1_C" >
    <input type="hidden" name="CNTL_CATG1_C_NM" >
    <input type="hidden" name="CNTL_ELMN_C" >
    <input type="hidden" name="CNTL_ELMN_C_NM" >
    <input type="hidden" name="HGRK_BRNO" >
    <input type="hidden" name="BRNO" >
    <input type="hidden" name="BRNO_NM" >
    <input type="hidden" name="CUR_RSK_PNT" >
    <input type="hidden" name="PREV_RSK_PNT" >
    <input type="hidden" name="CHANGE_GUBUN" >
    <input type="hidden" name="MAX_SCORE" >
    <input type="hidden" name="CUR_SCORE" >
    <input type="hidden" name="PREV_SCORE" >
    <input type="hidden" name="addGubun" id="addGubun"/>
    
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
	    		${condel.getLabel('RBA_50_01_04_01_124','통제분류(Lv1)')}
      	 		${JRBACondEL.getSRBASelect('','CNTL_CATG1_C' ,'P001' ,'160px' ,'' ,'' ,'ALL','doSearch()')}
	    		${condel.getLabel('RBA_50_05_01_112','변동구분')}
		       	<div class="content" >
					<select name="CHANGE_GUBUN" id="CHANGE_GUBUN" class="dropdown" onChange='doSearch()' style="width:160px" >
		            	<option value='ALL' SELECTED >${msgel.getMsg("RBA_50_05_01_116","::: 전체 :::")}</option>
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
		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"doIMPV", defaultValue:"개선 조치 요청", mode:"C", function:"doImprove", cssClass:"btn-36 "}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"excelDownBtn2", defaultValue:"Excel 다운로드", mode:"R", function:"doExcelDown", cssClass:"btn-36"}')}
	</div>

	<div style="display: flex; gap:20px;">
		<div class="tab-content-bottom" style="width:60%;">
	        <div id = "GTDataGrid1_Area" style="padding-top:8px;"></div>
	    </div>
	    <div class="tab-content-bottom" style="width:40%; padding-top:20px;">
			<div class="dash-board-cont-box">
				<div class="table-cell">
		            ${condel.getLabel("RBA_50_05_01_019","부점명")}
					<input type = "text" class="cond-input-text" id="selectedBrnoNm" style="text-align:center" readOnly/>
					<input type="hidden" class="cond-input-text" id="selectedBrno" name = "BRNO">

	        	</div>
                <div style="display:inline-block;width:calc(100%); height:500px; padding-top:4px;">
                    	<div id="chart1" style="width:100%;height:100%;text-align:center;"></div>
                </div>
			</div>
	    </div>
    </div>
</form>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />