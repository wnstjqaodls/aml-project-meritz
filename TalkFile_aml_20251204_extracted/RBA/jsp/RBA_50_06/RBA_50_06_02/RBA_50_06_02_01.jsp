<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_06_02_01.jsp
* Description     : KRI등급 모니터링
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-24
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_06.RBA_50_06_02.RBA_50_06_02_01" %>
<%
    String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    request.setAttribute("ROLE_IDS",ROLE_IDS);
    
    DataObj input  = new DataObj();
 	DataObj output = RBA_50_06_02_01.getInstance().doSearch2(input); 
 	String VALT_YYMM; VALT_YYMM = output.getText("CODE");
 	String MONTHS; //MONTHS = output.getText("CODE").substring(4,6).toString();
 	// 보안취약성 보완
 	MONTHS = output.getText("CODE").substring(4,6);
    request.setAttribute("VALT_YYMM"    , output.getText("CODE"));   
    request.setAttribute("MONTHS"       , MONTHS);   
%>
<style>
/*  table, th, td {
   border-collapse : initial;
   border          : 0.5px solid #CCCCCC;

}
th {
    font-weight     : 700;
} */
</style>
<script>
    var GridObj1;
    
    var tabID   = 0;
    var pageID  = "RBA_50_06_02_01";
    var classID = "RBA_50_06_02_01";
    var overlay = new Overlay();
    
    /** Initialize */
    $(document).ready(function(){
    	setupGrids();
    	setupFilter1("init");
    });
    
    function setupFilter1(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    function init() {
        initPage();
        //dvTab(tabID);
    }
    
    function setupGrids(){ 
    	/* GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_06_02_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 160px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,completedEvent  : function(){
               setupGridFilter([GridObj1]);
               doSearch();
            }
        }); */

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
            export               : {allowExportSelectedData: true, enabled : true, excelFilterEnabled : true, fileName : "gridExport"},
            sorting              : {mode: "multiple"},
            loadPanel            : {enabled: false},
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
            remoteOperations     : {filtering: false, grouping : false, paging : false, sorting : false, summary : false},
            editing: {mode : "batch", allowUpdating: false, allowAdding : false, allowDeleting : false},
            filterRow            : {visible: false},
            rowAlternationEnabled: false,
            onCellPrepared       : function(e){
								                var columnName = e.column.dataField;
								                var dataGrid   = e.component;
								                var rowIndex   = dataGrid.getRowIndexByKey(e.key); 
								               },
            searchPanel: {visible: false, width : 250},
            selection: {allowSelectAll : true, deferred : false, mode : "single", selectAllMode : "allPages", showCheckBoxesMode: "onClick"},
            columns: [
                    {"dataField" : "KRI_NO", "caption" : '${msgel.getMsg("RBA_50_06_01_03_001","ID")}', "width" : 100, "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true}, 
               		{"dataField" : "KRI_NM", "caption" : '${msgel.getMsg("RBA_50_06_01_02_106","KRI지표명")}', "alignment" : "center", "allowResizing" : true, "allowSearch" : true, "allowSorting" : true, "width" : 100}, 
               		{"dataField" : "KRI_CTNT","caption": '${msgel.getMsg("RBA_50_06_01_02_107","KRI지표산식")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"width": 200},
               		{"dataField": "CNT_1", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true}, 
                    {"dataField": "CNT_2", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_3", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_4", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_5", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_6", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_7", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_8", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_9", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_10", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_11", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                    {"dataField": "CNT_12", "caption": '', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true},
                	{"dataField": "TOTAL", "caption": '${msgel.getMsg("RBA_50_06_01_02_108","합계")}', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true, "dataType": "number"},
                	{"dataField": "AVG", "caption": '${msgel.getMsg("RBA_50_06_01_02_109","평균")}', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true, "dataType": "number"}
            		],
            onToolbarPreparing   : makeToolbarButtonGrids,
            onCellClick: function(e){
            }
        }).dxDataGrid("instance");
    	doSearch();
    }
     
    
    // 최초조회
    function doSearch(){
        overlay.show(true, true); 
        doSearch1();
    }
    
    //KRI 지표 등급 모니터링
    function doSearch1(){
    	GridObj1.clearSelection();
        GridObj1.option('dataSource', []);  
    	var Date =  form.Year.value.replaceAll("년","") + form.Months.value.replaceAll("월","") + '01'   ; 
        
    	/* GridObj1.refresh({
            actionParam: {
                "pageID"  : pageID,
                "classID" : classID,
                "methodID": "doSearch",
                "BAS_YYMM": Date ,
            },
            completedEvent: doSearch_end
            ,failEvent:doSearch_end
        }); */

    	var params = new Object();
		var methodID = "doSearch";
		overlay.show(true, true);
		params.pageID  = "RBA_50_06_02_01";
		params.classID = "RBA_50_06_02_01";
		params.BAS_YYMM  = Date;
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
        
    }
    
    function doSearch_end(dataSource, data) {
    	overlay.hide(); 
    	GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
 		
        var BASE_YYMM; BASE_YYMM = form.Year.value.replaceAll("년","") + form.Months.value.replaceAll("월","");        
	   	var gridCnt; gridCnt = GridObj1.totalCount();	   	
	   	var gridInstance; gridInstance = $("#GTDataGrid1_Area").dxDataGrid('instance');	   	
		if(gridCnt>0) {			
			var selObj = GridObj1.getRow(0);			
			/* gridInstance.columnOption('CNT_12', 'caption', selObj.VALT_YYMM_12 + '월');
	        gridInstance.columnOption('CNT_11', 'caption', selObj.VALT_YYMM_11 + '월');
	        gridInstance.columnOption('CNT_10', 'caption', selObj.VALT_YYMM_10 + '월');
	        gridInstance.columnOption('CNT_9',  'caption', selObj.VALT_YYMM_9 + '월');
	        gridInstance.columnOption('CNT_8',  'caption', selObj.VALT_YYMM_8 + '월');
			gridInstance.columnOption('CNT_7',  'caption', selObj.VALT_YYMM_7 + '월');
	        gridInstance.columnOption('CNT_6',  'caption', selObj.VALT_YYMM_6 + '월');
	        gridInstance.columnOption('CNT_5',  'caption', selObj.VALT_YYMM_5 + '월');
	        gridInstance.columnOption('CNT_4',  'caption', selObj.VALT_YYMM_4 + '월');
	        gridInstance.columnOption('CNT_3',  'caption', selObj.VALT_YYMM_3 + '월');
	        gridInstance.columnOption('CNT_2',  'caption', selObj.VALT_YYMM_2 + '월');
	        gridInstance.columnOption('CNT_1',  'caption', selObj.VALT_YYMM_1 + '월'); */
			gridInstance.columnOption('CNT_12', 'caption', '${msgel.getMsg("RBA_50_06_01_02_211","12월")}');
	        gridInstance.columnOption('CNT_11', 'caption', '${msgel.getMsg("RBA_50_06_01_02_210","11월")}');
	        gridInstance.columnOption('CNT_10', 'caption', '${msgel.getMsg("RBA_50_06_01_02_209","10월")}');
	        gridInstance.columnOption('CNT_9',  'caption', '${msgel.getMsg("RBA_50_06_01_02_208","9월")}');
	        gridInstance.columnOption('CNT_8',  'caption', '${msgel.getMsg("RBA_50_06_01_02_207","8월")}');
			gridInstance.columnOption('CNT_7',  'caption', '${msgel.getMsg("RBA_50_06_01_02_206","7월")}');
	        gridInstance.columnOption('CNT_6',  'caption', '${msgel.getMsg("RBA_50_06_01_02_205","6월")}');
	        gridInstance.columnOption('CNT_5',  'caption', '${msgel.getMsg("RBA_50_06_01_02_204","5월")}');
	        gridInstance.columnOption('CNT_4',  'caption', '${msgel.getMsg("RBA_50_06_01_02_203","4월")}');
	        gridInstance.columnOption('CNT_3',  'caption', '${msgel.getMsg("RBA_50_06_01_02_202","3월")}');
	        gridInstance.columnOption('CNT_2',  'caption', '${msgel.getMsg("RBA_50_06_01_02_201","2월")}');
	        gridInstance.columnOption('CNT_1',  'caption', '${msgel.getMsg("RBA_50_06_01_02_200","1월")}');
		}else{			
			gridInstance.columnOption('CNT_12', 'caption', '${msgel.getMsg("RBA_50_06_01_02_211","12월")}');
	        gridInstance.columnOption('CNT_11', 'caption', '${msgel.getMsg("RBA_50_06_01_02_210","11월")}');
	        gridInstance.columnOption('CNT_10', 'caption', '${msgel.getMsg("RBA_50_06_01_02_209","10월")}');
	        gridInstance.columnOption('CNT_9',  'caption', '${msgel.getMsg("RBA_50_06_01_02_208","9월")}');
	        gridInstance.columnOption('CNT_8',  'caption', '${msgel.getMsg("RBA_50_06_01_02_207","8월")}');
			gridInstance.columnOption('CNT_7',  'caption', '${msgel.getMsg("RBA_50_06_01_02_206","7월")}');
	        gridInstance.columnOption('CNT_6',  'caption', '${msgel.getMsg("RBA_50_06_01_02_205","6월")}');
	        gridInstance.columnOption('CNT_5',  'caption', '${msgel.getMsg("RBA_50_06_01_02_204","5월")}');
	        gridInstance.columnOption('CNT_4',  'caption', '${msgel.getMsg("RBA_50_06_01_02_203","4월")}');
			gridInstance.columnOption('CNT_3',  'caption', '${msgel.getMsg("RBA_50_06_01_02_202","3월")}');
	        gridInstance.columnOption('CNT_2',  'caption', '${msgel.getMsg("RBA_50_06_01_02_201","2월")}');
	        gridInstance.columnOption('CNT_1',  'caption', '${msgel.getMsg("RBA_50_06_01_02_200","1월")}');
		}
		gridInstance.columnOption('CNT_12', 'width', '80');
		gridInstance.columnOption('CNT_11', 'width', '80');
		gridInstance.columnOption('CNT_10', 'width', '80');
		gridInstance.columnOption('CNT_9', 'width', '80');
		gridInstance.columnOption('CNT_8', 'width', '80');
		gridInstance.columnOption('CNT_7', 'width', '80');
		gridInstance.columnOption('CNT_6', 'width', '80');
		gridInstance.columnOption('CNT_5', 'width', '80');
		gridInstance.columnOption('CNT_4', 'width', '80');
		gridInstance.columnOption('CNT_3', 'width', '80');
		gridInstance.columnOption('CNT_2', 'width', '80');
		gridInstance.columnOption('CNT_1', 'width', '80');
    }

    function doSearch_fail(){
		console.log("doSearch_fail");
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
    
</script>
<form name="form" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
    
    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row">
            <div class="table-cell">
            
             <%-- <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_01_02_001','평가기준월')}</span>
           	 ${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_ValtYear','','' ,'' ,'')}  --%>
	           	 <div class="title">
	           	 	<div class="txt">${msgel.getMsg("RBA_50_06_01_02_111","추출년월")}</div>
	           	 </div>
	           	 <div class="content">
	             	${condel.getSelect('{msgID:"", defaultValue:"", selectID:"Year", width:"80", sqlID:"MDAO.AML_20_01_12_01_getYearList",  firstComboWord:""}')}
	           	 	${condel.getSelect('{msgID:"", defaultValue:"", selectID:"Months", width:"80", code:"A310", initValue:"${MONTHS}", firstComboWord:""}')}
	           	 </div>
           	
           	 
           	 <%-- <span><i class='fa fa-chevron-circle-right' style='position:relative;top:1px;' ></i><span class='cond-label'>&nbsp;추출년월&nbsp;</span></span>
             ${condel.getSelect('{msgID:"", defaultValue:"", selectID:"Year", width:"80", sqlID:"AML_20_01_12_01_getYearList",  firstComboWord:""}')}
             <span>년&nbsp;&nbsp;</span>  
             ${condel.getSelect('{msgID:"", defaultValue:"", selectID:"Months", width:"80", code:"A310", initValue:"${MONTHS}", firstComboWord:""}')}
       	    </div> --%>
        	</div>
	    </div>
	</div>      
    <div class="button-area">
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
    </div>
	<div class="tab-content-bottom" style="padding-top: 8px;">
		<div id="GTDataGrid1_Area" style="width:95vw"></div>
	
	
<!--         <div id="tabCont1">

            <div id="div0" title="KRI등급 모니터링">
		            <table>
		                <tr>
		                    <td valign="top">
		                        <div id="GTDataGrid1_Area" style="width:94vw"></div>
		                    </td>
		                </tr>
		            </table>
            </div> 
        </div> -->
    </div>
        
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />