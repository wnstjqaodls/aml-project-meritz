<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_30_06_01_01.jsp
* Description     : KRI POOL관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : PJH
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<script language="JavaScript">
    
    var GridObj1;
    var overlay = new Overlay();
    var classID= "RBA_30_06_01_01";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        setupFilter("init");
    });
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
        	onToolbarPreparing		: makeToolbarButtonGrids,	
        	"width" 						: "100%",
    		"height"						:"calc(85vh - 100px)",
    		hoverStateEnabled    	: true,
    	    wordWrapEnabled      	: false,
    	    allowColumnResizing  	: true,
    	    columnAutoWidth      	: true,
    	    allowColumnReordering	: true,
    	    cacheEnabled 			: false,
    	    cellHintEnabled 		: true,
    	    showBorders 			: true,
    	    showColumnLines 		: true,
    	    showRowLines 			: true,
    	    export 					: {allowExportSelectedData : true ,enabled : true ,excelFilterEnabled : true},
    	    onExporting: function (e) {
    	    	var workbook = new ExcelJS.Workbook();
    	    	var worksheet = workbook.addWorksheet("Sheet1");
    		    DevExpress.excelExporter.exportDataGrid({
    		        component: e.component,
    		        worksheet: worksheet,
    		        autoFilterEnabled: true,
    		    }).then(function(){
    		        workbook.xlsx.writeBuffer().then(function(buffer){
    		            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}.xlsx");
    		        });
    		    });
    		    e.cancel = true;
            },
            sorting         : {mode   : "multiple"},
    	    loadPanel       : {enabled: false},
    	    remoteOperations			: {filtering: false,grouping: false,paging: false,sorting: false,summary: false},
    	    editing						: {mode: "batch",allowUpdating: false, allowAdding  : false,allowDeleting: false},
    	    filterRow            			: {visible: false},
    	    rowAlternationEnabled	: false,
    	    searchPanel          		: {visible: false,width: 250},
    	    selection						: {allowSelectAll: false, deferred: false, mode: "multiple",selectAllMode: "page", showCheckBoxesMode: "always"},
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
    	        mode: "virtual",
    	        preloadEnabled: false
    	    },
    	    columns: [
    	    	{dataField: "CNT", 					caption: '${msgel.getMsg("RBA_30_06_01_01_001","순번")}' , alignment: "center"}, 
    	        {dataField: "RSK_CATG1_C",				caption: '${msgel.getMsg("RBA_30_06_05_01_002","위험분류 Lv.1")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, visible:false},
    	        {dataField: "RSK_CATG1_C_NM",				caption: '${msgel.getMsg("RBA_30_06_05_01_002","위험분류 Lv.1")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true},
    	        
    	        {dataField: "RSK_CATG2_C",				caption: '${msgel.getMsg("RBA_30_06_05_01_003","위험분류 Lv.2")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true , visible:false}, 
    	        {dataField: "RSK_CATG2_C_NM",			caption: '${msgel.getMsg("RBA_30_06_05_01_003","위험분류 Lv.2")}',				alignment: "center",allowResizing: true,allowSearch  : true,allowSorting : true },

    	        {dataField: "RSK_ELMT_C",				caption: '${msgel.getMsg("RBA_30_06_05_01_005","위험요소")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, visible:false}, 
    	        {dataField: "RSK_ELMT_C_NM",				caption: '${msgel.getMsg("RBA_30_06_05_01_005","위험요소")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, "cssClass": "link"}, 
    	        
    	        {dataField: "KOFIU_YN",			caption: '${msgel.getMsg("RBA_30_06_05_01_006","KoFIU지표 연계여부")}',		alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true}, 
    	        {dataField: "KOFIU_NO",			caption: '${msgel.getMsg("RBA_30_06_05_01_018","KoFIU 지표명")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true}, 
    	        {dataField: "INDV_CORP_CCD",	caption      : '${msgel.getMsg("RBA_50_03_02_01_005","적용대상")}',
		            alignment    : "center",
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
		        },
    	        {dataField: "MSUR_FRQ",				caption: '${msgel.getMsg("RBA_30_06_05_01_019","평가산출 기준")}',
    	        	lookup : {
    	        		dataSource : [
    	        			{ code : "1" , name : "해당 고객 수" },
    	        			{ code : "2" , name : "해당 거래금액" },
    	        		],
    	        		valueExpr : "code",
    	        		displayExpr : "name"
    	        	},
    	        	alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true
    	        },
    	        {dataField: "EDD_YN",			caption: '${msgel.getMsg("RBA_30_06_05_01_008","당연EDD 대상여부")}',		alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true}, 
    	        {dataField: "APPLY_STD",			caption: '${msgel.getMsg("RBA_30_06_05_01_020","적용기준")}',		
    	        	lookup : {
    	        		dataSource : [
    	        			{ code : "1" , name : "발생 규모" },
    	        			{ code : "2" , name : "상승률" },
    	        		],
    	        		valueExpr : "code",
    	        		displayExpr : "name"
    	        	},
    	        	alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true
    	        },
    	        {dataField: "MONITOR_FST_LT",			caption: '${msgel.getMsg("RBA_30_06_01_01_008","1차 한도(Yellow)")}',		alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true}, 
    	        {dataField: "MONITOR_SND_LT",			caption: '${msgel.getMsg("RBA_30_06_01_01_009","2차 한도(Red)")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true}, 
    	        {dataField: "MONITOR_CYCLE",				caption: '${msgel.getMsg("RBA_30_06_01_01_010","모니터링 주기")}',	
    	        	lookup : {
    	        		dataSource : [
    	        			{ code : "6" , name : "반기" },
    	        		],
    	        		valueExpr : "code",
    	        		displayExpr : "name"
    	        	},
    	        	alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true
    	        },
    	        {dataField: "MONITOR_YN",				caption: '${msgel.getMsg("RBA_30_06_05_01_009","모니터링 대상 여부")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true}
    	    ],
    	    onCellClick: function(e){
    	        if(e.data){
    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	        if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
    	        } else {
    	            e.component.clearSelection();
    	            e.component.selectRowsByIndexes(e.rowIndex);
    	        }
    	    },
    	    onInitialized : function(e) {
	        	doSearch();
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
								setupFilter();
                        }
                 }
            });
        }
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
    
    function doSearch() {
    	
    	overlay.show(true, true);

        var params = new Object();
        var methodID = "getSearch";
		var classID  = "RBA_30_06_01_01";
		params.pageID 	= "RBA_30_06_01_01"; 

		
		params.CA= form.CA.value;			// 위험분류 Lv.1
		params.EV= form.EV.value;			// 위험분류 Lv.2
		params.RSK_ELMT_C_NM= form.RSK_ELMT_C_NM.value;			// 위험요소
		params.EDD_YN = form.EDD_YN.value;			// 당연 EDD 대상여부
		params.MONITOR_YN = form.MONITOR_YN.value;			// 모니터링 대상여부
		params.KOFIU_YN = form.KOFIU_YN.value;			// Kofiu지표연계 여부
		params.indiv_flag = form.indiv_flag.value;			
		
		params.INDV_YN = '';
		params.CORP_YN = '';
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
    }
    
    //자금세탁 사례관리 조회 end
    function doSearch_end(gridData, data) {
        overlay.hide();
        GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    	
    }

    function doSearch_fail() {
        console.log("doSearch_fail");
    }
    
    function doSearchDetail(){
    	var selData  = GridObj1.getSelectedRowsData();

        if(selData == null || selData == ""){
        	showAlert('${msgel.getMsg("RBA_30_06_02_02_004","상세조회할 대상을 선택해주세요.")}','WARN');
        }else{	
        	var rowdata = selData[0];	//한 건만 선택
        	 form2.pageID.value    =  "RBA_30_06_01_02";
             form2.classID.value   = classID;
             form2.RSK_CATG1_C_NM.value = rowdata.RSK_CATG1_C_NM;		// 위험분류 Lv.1
             form2.RSK_CATG2_C_NM.value = rowdata.RSK_CATG2_C_NM;		// 위험분류 Lv.2
             form2.RSK_ELMT_C.value = rowdata.RSK_ELMT_C;						// 위험요소
             form2.RSK_ELMT_C_NM.value = rowdata.RSK_ELMT_C_NM;						// 위험요소
             form2.KOFIU_YN.value = rowdata.KOFIU_YN;					// KoFIU 연계여부
             form2.KOFIU_NO.value = rowdata.KOFIU_NO;					// KoFIU 연계 지표명
             form2.MSUR_FRQ.value = rowdata.MSUR_FRQ;		// 평가 산출 기준
             form2.EDD_YN.value = rowdata.EDD_YN;		// 당연EDD여부
             form2.MONITOR_FST_LT.value = rowdata.MONITOR_FST_LT;		// 1차 한도
             form2.MONITOR_SND_LT.value = rowdata.MONITOR_SND_LT;		// 2차 한도
             form2.MONITOR_CYCLE.value = rowdata.MONITOR_CYCLE;		// 모니터링 주기
             form2.MONITOR_YN.value = rowdata.MONITOR_YN;		// 모니터링 대상여부
             form2.APPLY_STD.value = rowdata.APPLY_STD;		// 적용기준
             form2.INDV_YN.value = rowdata.INDV_YN;		// 적용기준
             form2.CORP_YN.value = rowdata.CORP_YN;		// 적용기준
             form2.INDV_CORP_CCD.value = rowdata.INDV_CORP_CCD;
             
 	    	if( form2.INDV_YN.value === '1' && form2.CORP_YN.value === '1' ) {
 	    		form2.INDV_CORP_CCD.value 	= '개인/법인';
 			} else if( form2.INDV_YN.value === '1' ) {
 				form2.INDV_CORP_CCD.value  	= '개인';
 			} else if( form2.CORP_YN.value === '1' ) {
 				form2.INDV_CORP_CCD.value  	= '법인';
 			}
             
             
             form2.target          = form2.pageID.value;
             /* var win               = window_popup_open(form2.pageID.value, 700, 475, '','yes'); */
             var win               = window_popup_open(form2.pageID.value, 990, 560, '','yes');
             form2.action          = '<c:url value="/"/>0001.do';
             form2.submit();
        }
    }
    
 // 그리드 클릭 - KRI 상세정보 팝업 호출
	function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){
        
        var pageID = "RBA_30_06_01_02";
        var form2  = document.form2;
        if (colId == "RSK_ELMT_C_NM") {
        	
            form2.pageID.value    = pageID;
            form2.classID.value   = classID;
            form2.RSK_CATG1_C_NM.value = obj.RSK_CATG1_C_NM;		// 위험분류 Lv.1
            form2.RSK_CATG2_C_NM.value = obj.RSK_CATG2_C_NM;		// 위험분류 Lv.2
            form2.RSK_ELMT_C.value = obj.RSK_ELMT_C;						// 위험요소
            form2.RSK_ELMT_C_NM.value = obj.RSK_ELMT_C_NM;						// 위험요소
            form2.KOFIU_YN.value = obj.KOFIU_YN;					// KoFIU 연계여부
            form2.KOFIU_NO.value = obj.KOFIU_NO;					// KoFIU 연계 지표명
            form2.MSUR_FRQ.value = obj.MSUR_FRQ;		// 평가 산출 기준
            form2.EDD_YN.value = obj.EDD_YN;		// 당연EDD여부
            form2.MONITOR_FST_LT.value = obj.MONITOR_FST_LT;		// 1차 한도
            form2.MONITOR_SND_LT.value = obj.MONITOR_SND_LT;		// 2차 한도
            form2.MONITOR_CYCLE.value = obj.MONITOR_CYCLE;		// 모니터링 주기
            form2.MONITOR_YN.value = obj.MONITOR_YN;		// 모니터링 대상여부
            form2.APPLY_STD.value = obj.APPLY_STD;		// 적용기준
            form2.INDV_YN.value = obj.INDV_YN;		// 적용기준
            form2.CORP_YN.value = obj.CORP_YN;		// 적용기준
            form2.INDV_CORP_CCD.value = obj.INDV_CORP_CCD;
            
	    	if( form2.INDV_YN.value === '1' && form2.CORP_YN.value === '1' ) {
	    		form2.INDV_CORP_CCD.value 	= '개인/법인';
			} else if( form2.INDV_YN.value === '1' ) {
				form2.INDV_CORP_CCD.value  	= '개인';
			} else if( form2.CORP_YN.value === '1' ) {
				form2.INDV_CORP_CCD.value  	= '법인';
			}
            
            
            form2.target          = form2.pageID.value;
            /* var win               = window_popup_open(form2.pageID.value, 700, 475, '','yes'); */
            var win               = window_popup_open(form2.pageID.value, 990, 560, '','yes');
            form2.action          = '<c:url value="/"/>0001.do';
            form2.submit();
        }
    }
    
</script>
<style>
	.inquiry-table .table-cell .title {
	    min-width: 170px;
	}
</style>
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="RSK_CATG1_C_NM" >
    <input type="hidden" name="RSK_CATG2_C_NM" >
    <input type="hidden" name="RSK_ELMT_C" >
    <input type="hidden" name="RSK_ELMT_C_NM" >
    <input type="hidden" name="KOFIU_YN" >
    <input type="hidden" name="KOFIU_NO" >
    <input type="hidden" name="INDV_CORP_CCD" >
    <input type="hidden" name="INDV_YN" >
    <input type="hidden" name="CORP_YN" >
    <input type="hidden" name="MONITOR_FST_LT" >
    <input type="hidden" name="MONITOR_SND_LT" >
    <input type="hidden" name="MONITOR_YN" >
    <input type="hidden" name="MONITOR_CYCLE" >
    <input type="hidden" name="MSUR_FRQ" >
    <input type="hidden" name="APPLY_STD" >
    <input type="hidden" name="EDD_YN" >
</form>
<form name="form" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">    
    <div class="inquiry-table type4">
    	<div class="table-row">
        	<div class="table-cell">
            	${condel.getLabel("RBA_30_06_05_01_002","위험분류 Lv.1")}
           		${RBACondEL.getKRBASelect('CA','' ,'' ,'CA' ,'' ,'ALL' ,'nextSelectChange2_2("EV", "EV", this)','','','')}
            </div>
            <div class="table-cell">
           		 ${condel.getLabel("RBA_30_06_01_01_011","적용대상(개인/법인)")}
            	<div class="content">
            		${SRBACondEL.getSRBASelect('indiv_flag','' ,'' ,'KR01' ,'','ALL','','','','')}
            	</div>
            </div>
        </div>
        
        <div class="table-row">
        	<div class="table-cell">
            	${condel.getLabel("RBA_30_06_05_01_003","위험분류 Lv.2")}
                ${RBACondEL.getKRBASelect('EV','' ,'' ,'EV' ,'' ,'ALL' ,'doSearch()','','','N')}
            </div>
            <div class="table-cell">
            	${condel.getLabel("RBA_30_06_05_01_008","당연EDD 대상여부")}
            	<div class="content">
		          	<select name='EDD_YN' id='EDD_YN' class="dropdown">
			           <option class="dropdown-option" value='ALL' selected>::${msgel.getMsg('AML_10_05_01_01_015','전체')}::</option>
			           <option class="dropdown-option" value='Y' >${msgel.getMsg('AML_10_03_01_01_014','Y')}</option> 
			           <option class="dropdown-option" value='N' >${msgel.getMsg('AML_10_03_01_01_013','N')}</option>
		       		</select>
		         </div>
            </div>
        </div>
        
        
        <div class="table-row">
        	<div class="table-cell">
            	${condel.getLabel("RBA_30_06_05_01_005","위험요소")}
            	<div class="content">
            		<input type="text" name= "RSK_ELMT_C_NM" size="30" class="cond-input-text" style="text-align:left"/>
            	</div>
            </div>
        
        	<div class="table-cell">
            	${condel.getLabel("RBA_30_06_05_01_009","모니터링 대상여부")}
            	<div class="content">
		          	<select name='MONITOR_YN' id='MONITOR_YN' class="dropdown">
			           <option class="dropdown-option" value='ALL' selected>::${msgel.getMsg('AML_10_05_01_01_015','전체')}::</option>
			           <option class="dropdown-option" value='Y' >${msgel.getMsg('AML_10_03_01_01_014','Y')}</option> 
			           <option class="dropdown-option" value='N' >${msgel.getMsg('AML_10_03_01_01_013','N')}</option>
		       		</select>
		         </div>
            </div>
        </div>

        <div class="table-row">
        	<div class="table-cell">
            	${condel.getLabel("RBA_30_06_05_01_006","KoFIU지표 연계여부")}
            	<div class="content">
		          	<select name='KOFIU_YN' id='KOFIU_YN' class="dropdown">
			           <option class="dropdown-option" value='ALL' selected>::${msgel.getMsg('AML_10_05_01_01_015','전체')}::</option>
			           <option class="dropdown-option" value='Y' >${msgel.getMsg('AML_10_03_01_01_014','Y')}</option> 
			           <option class="dropdown-option" value='N' >${msgel.getMsg('AML_10_03_01_01_013','N')}</option>
		       		</select>
		         </div>
            </div>
        
        	<div class="table-cell">
            </div>
            </div>
        </div>
        
    </div>
   	<div class="button-area" style="display: flex;justify-content: flex-end;">
    		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA_Detail_Search", defaultValue:"상세조회", mode:"R", function:"doSearchDetail", cssClass:"btn-36"}')} 
    </div>
    <div class="tab-content-bottom" style="margin-top: 8px;">
        <div id="GTDataGrid1_Area"></div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />