<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_02_03.jsp
* Description     : 통제수기평가 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-05-25
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<% 
    String BAS_YYMM     = request.getParameter("BAS_YYMM");  
	String KBN          = request.getParameter("KBN");  
	String DSGN_VALT_TP_C     = request.getParameter("DSGN_VALT_TP_C");  
	String TONGJE_SCOR_OFFR_C = request.getParameter("TONGJE_SCOR_OFFR_C"); 
	
    request.setAttribute("BAS_YYMM",BAS_YYMM); 
    request.setAttribute("KBN",KBN); 
    request.setAttribute("DSGN_VALT_TP_C",DSGN_VALT_TP_C); 
    request.setAttribute("TONGJE_SCOR_OFFR_C",TONGJE_SCOR_OFFR_C); 
%>
<style type="text/css">
    * { white-space: nowrap;}
</style>
<script language="JavaScript">
    
    var GridObj1;
    var GridObj2;
    var DSGN_PNT = "";  // 설계평가 점수
    var OPR_PNT = "";   // 운영평가 점수
    var DSGN_TP_C_V = "";  // 설계평가 점수
    var OPR_TP_C_V = "";   // 운영평가 점수
    var overlay = new Overlay();
    var classID  = "RBA_50_05_02_03";
    
    // Initialize
    $(document).ready(function(){
    	setupGrids();
    	setupFilter("init");
    	setupFilter2("init");
    	if ("${KBN}" == "D"){
	    	doSearch();
    	}else if ("${KBN}" == "O") {
	    	doSearch2();
    	}
    });

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }

    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridArrs[1] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    // Initial function
    function init() { initPage(); }
    
    //그리드1(Code Head) 초기화
    function initGTDataGrid1(gridId, gridDivId, height) { 
        GridObj1 = initGrid3(gridId, "RBA_50_05_02_03_Grid1", "", "", gridDivId, height, "${outputAuth.USE_YN}", '설계평가 점수');
        doSearch(); 
    }
    //그리드2(Code Head) 초기화
    function initGTDataGrid2(gridId, gridDivId, height) { 
        GridObj2 = initGrid3(gridId, "RBA_50_05_02_03_Grid2", "", "", gridDivId, height, "${outputAuth.USE_YN}", '운영평가 점수');
        doSearch2();  
    }
    
 	// 그리드 초기화 함수 셋업
    function setupGrids(){  
        if ("${KBN}" == "D"){
			GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
				elementAttr: { class: "grid-table-type" },
				height				 : "calc(90vh - 100px)",
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
			    onToolbarPreparing   : makeToolbarButtonGrids, 
			    rowAlternationEnabled: false,
			    columnFixing         : {enabled: true},
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
			    columns: [
			        {
			            dataField    : "TP_DTL_CTNT",
			            caption      : '${msgel.getMsg("RBA_50_05_02_03_100","설계평가 세부사항")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : "80%"
			        },  {
			            dataField    : "TP_VALT_PNT",
			            caption      : '${msgel.getMsg("RBA_50_05_02_03_101","설계평가 점수")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : "20%"
			        } ,  {
			            dataField    : "TP_C_V",
			            caption      : '설계평가 유형코드값',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : "20%" ,
			            visible : false
			        } 
			    ],
			    onCellClick: function(e){ 
			        if(e.data ){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
			}).dxDataGrid("instance");

        	$('#GTDataGrid1_Area').css("display","");
        	$('#GTDataGrid2_Area').css("display","none");
        }else if ("${KBN}" == "O") {
        	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
        		elementAttr: { class: "grid-table-type" },
        		height				 : "calc(90vh - 100px)",
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
        	    columnFixing         : {enabled: true},
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
        	    columns: [
        	        {
        	            dataField    : "TP_DTL_CTNT",
        	            caption      : '${msgel.getMsg("RBA_50_05_02_03_102","운영평가 세부사항")}운영평가 세부사항',
        	            alignment    : "left",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : "80%"
        	        },  {
        	            dataField    : "TP_VALT_PNT",
        	            caption      : '${msgel.getMsg("RBA_50_05_02_03_103","운영평가 점수")}',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : "20%"
        	        } ,  {
        	            dataField    : "TP_C_V",
        	            caption      : '운영평가유형 코드값',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : "20%" ,
        	            visible : false
        	        } 
        	    ],
        	    onCellClick: function(e){ 
        	        if(e.data ){
        	            Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
        	        }
        	    }
        	}).dxDataGrid("instance");
        	$('#GTDataGrid1_Area').css("display","none");
        	$('#GTDataGrid2_Area').css("display","");
        } 
        
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
	                   	,"elementAttr": { class: "btn-28 filter popupFilter" }
	        			,"text"      : ""       
	                    ,"hint"      : '필터'
	                    ,"disabled"  : false
	                    ,"onClick"   : function(){
	                    	if(gridID=="GTDataGrid1_Area"){
								setupFilter();
							}  else {//gridID=="GTDataGrid2_Area"
								setupFilter2();
							}
	                    }
	             }
	        });
	    }
	}
    
  	//통제점검항목 상세 조회
    function doSearch(){ 
        var methodID = "doSearch";
//         GridObj1.refresh({
//             actionParam: {
//                 "pageID"  	: pageID,
//                 "classID" 	: classID,
//                 "methodID"	: methodID,
//                 "BAS_YYMM"  : "${BAS_YYMM}", 
//                 "TONGJE_G_C" : "${DSGN_VALT_TP_C}" 
//             },
//             completedEvent: doSearch_end
//         });
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch";
   		params.BAS_YYMM			= "${BAS_YYMM}"; 
   		params.TONGJE_G_C		= "${DSGN_VALT_TP_C}"; 
   		sendService(classID, methodID, params, doSearch_end, doSearch_end);
    }
    
    //통제점검항목 상세 완료
    function doSearch_end(dataSource){ 
    	overlay.hide(); 
    	GridObj1.refresh();
        GridObj1.option("dataSource", dataSource);
    }
    
  	//통제점검항목 상세 조회
    function doSearch2(){ 
		var methodID = "doSearch2";
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch2";
   		params.BAS_YYMM			= "${BAS_YYMM}";
   		params.TONGJE_G_C		= "${TONGJE_SCOR_OFFR_C}"; 
   		sendService(classID, methodID, params, doSearch_end2, doSearch_end2);
    }
  	
  	//통제점검항목 상세 완료
    function doSearch_end2(dataSource){ 
    	overlay.hide();
    	GridObj2.refresh();
        GridObj2.option("dataSource", dataSource); 
    }
  	
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId){ 
    	DSGN_PNT = obj.TP_VALT_PNT ; 
    	DSGN_TP_C_V = obj.TP_C_V ;
  	}
  	
	function Grid2CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId){ 
		OPR_PNT = obj.TP_VALT_PNT ; 
		OPR_TP_C_V = obj.TP_C_V ;
  	}
   
    
    //수기평가저장
	function doSelect(){ 
        if(DSGN_PNT == "" && "${KBN}" == "D"){
        	showAlert("설계평가 점수를 선택하세요",'WARN');
            return false;
        } else if (OPR_PNT == "" && "${KBN}" == "O"){ 
        	showAlert("운영평가 점수를 선택하세요",'WARN');
            return false;
        } 
        
        if("${KBN}" == "D"){
        opener.document.getElementById("DESIGN_VALUE").value = DSGN_PNT ; 
        opener.document.getElementById("DSGN_TP_C_V").value = DSGN_TP_C_V ;
        } else if ("${KBN}" == "O"){
        opener.document.getElementById("OPERATION_VALUE").value = OPR_PNT ;
        opener.document.getElementById("OPR_TP_C_V").value = OPR_TP_C_V ;
        }
        window.close();
	}
    // 일정수정 팝업 close
    function appro_end() {
        $("button[id='btn_01']").prop('disabled', false);
       // opener.doSearch();
        window.close();
    }
    function getRadioValue(onm){
        robj = document.form[onm];
        for(i=0;i<robj.length;i++){
            if(robj[i].checked==true) {
                return robj[i].value;
            }
        }
        return "";
    }
</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="TONGJE_SMDV_C" value="${TONGJE_SMDV_C}">
</form>
<form name="form">
    <div class="tab-content-bottom" >
		    <!-- <div class="table-title" style="padding-left:20px;"> 설계평가 점수</div> -->
			<div id="GTDataGrid1_Area"></div>
	   
		    <!-- <div class="table-title" style="padding-left:20px;"> 운영평가 점수 </div> -->
			<div id="GTDataGrid2_Area"></div>
    </div> 
<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">
    ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"selBtn", defaultValue:"선택", mode:"R", function:"doSelect", cssClass:"btn-36"}')}
    ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"appro_end", cssClass:"btn-36"}')}
</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />