<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_01_07.jsp
* Description     : 배치수행정보
* Group           : GTONE
* Author          : BSL
* Since           : 2018-07-06
--%>
<%@ page import="java.text.ParseException" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp"%>
<%
    String startDate = "";
    String endDate = "";  
   try{
    if("".equals(startDate)) {
     startDate = DateUtil.addDays(DateUtil.getDateString(), -365, "yyyy-MM-dd");
    }
    if("".equals(endDate)) {
     endDate = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
    }
	}catch(ParseException e){
		Log.logAML(Log.ERROR, e);
	}
    
    String BAS_YYMM =  request.getParameter("BAS_YYMM");
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    
    request.setAttribute("startDate",startDate);
    request.setAttribute("endDate",endDate);
%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />

<script language="JavaScript">
    
    var GridObj1;
    var overlay = new Overlay();
    var classID  = "RBA_50_01_01_07";
    var pageID = "RBA_50_01_01_07"
    // Initialize
    $(document).ready(function(){
        $('.popup-contents').css({overflow:"auto"});
        setupGrids();
        setupFilter("init");
    });
    
    // Initial function
    function init() { initPage(); }
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridObj.title = "${msgel.getMsg('RBA_50_01_01_205','보고서관리')}";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(80vh - 130px)",
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
				        enabled                : false,
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
				    columns: [
				        {
				            dataField    : "RBA_BTCH_DT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_100","RBA배치일자")}',
				            alignment    : "center",
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "BAS_YYMM",
				            caption      : '${msgel.getMsg("RBA_50_05_03_01_001","기준년월")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "ING_STEP_NM",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_101","진행단계")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "20%"
				        },  {
				            dataField    : "ING_STEP",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_102","진행단계코드")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            visible      : false
				        },  {
				            dataField    : "RBA_BTCH_SDT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_103","배치시작일자")}',
				            alignment    : "center",
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "RBA_BTCH_EDT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_104","배치종료일자")}',
				            alignment    : "center",
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "RBA_BTCH_S_C",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_105","배치진행상태코드")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "12%",
				            visible      : false
				        },  {
				            dataField    : "RBA_BTCH_S_C_NM",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_106","배치진행상태")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "ERR_CTNT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_107","배치내용")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true
				        }
				    ],
				    onToolbarPreparing	 : makeToolbarButtonGrids,
				    onCellClick: function(e){ 
				        if(e.data ){
				            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
				        }
				    },onInitialized : function(e) {
		                  	  doSearch(); 
		                 }
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
                          setupFilter();
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
    
    function doSearch(){  
    	overlay.show();
    	var startDate  = getDxDateVal("startDate").replaceAll("-","");
   		var endDate    = getDxDateVal("endDate").replaceAll("-","");
        
   		if (startDate > endDate){
     	  showAlert('종료일은 시작일보다 빠를 수 없습니다.','WARN');
           setupCalendarDx("startDate", "${startDate}");
           setupCalendarDx("endDate", "${endDate}");
    	   startDate   = getDxDateVal("startDate").replaceAll("-","");
     	   endDate     = getDxDateVal("endDate").replaceAll("-","");
   	 	}
   		
        //달력 선택 후 / 제거
        if(startDate.indexOf('/') == -1){
        } else{
           startDate   = getDxDateVal("startDate").replaceAll("/","");
        }
        
        if(endDate.indexOf('/')   == -1){
        } else{
           endDate     = getDxDateVal("endDate").replaceAll("/","");
        }
        
        /* var obj        = new Object();
        obj.pageID     = pageID;
        obj.classID    = classID;
        obj.methodID   = "doSearch";
        obj.startDate  = startDate;
        obj.endDate    = endDate;
        
        //평가기준월로 조회 html 주석도 같이 제거
        //obj.BAS_YYMM   = form1.BAS_YYMM.value;
        
        GridObj1.refresh({
        	actionParam     : obj
        }); */
        var params   = new Object();
 		var methodID = "doSearch";
 		var classID  = "RBA_50_01_01_07";
 		
 		params.pageID 	= "RBA_50_01_01_07";
 		params.startDate = startDate; //기준연도3
 		params.endDate   = endDate; //기준연도3
 		
 		sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
    }
    
    function doSearch_success(gridData, data){
        try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
        	 overlay.hide();
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
    
    function doSearch_fail(){    	 
    	overlay.hide();
    }
    
    //배치재수행팝업
    function doRetryBatch(){ 
    	form1.pageID.value = "RBA_50_01_01_08";
        var win;       win = window_popup_open("RBA_50_01_01_08", 620, 405, '','Yes');
        form1.target       = "RBA_50_01_01_08";
        form1.action       = '<c:url value="/"/>0001.do';
        form1.submit();
    }
</script> 
<form name="form1" onkeydown="doEnterEvent('doSearch');"  method="post">

<input type="hidden" name="pageID"      id="pageID"      value=""    />
<input type="hidden" name="BAS_YYMM"    id="BAS_YYMM"    value="<c:out value='${param.BAS_YYMM}'/>"    />
<input type="hidden" name="ING_STEP"    id="ING_STEP"    value="<c:out value='${param.ING_STEP}'/>"    />
<input type="hidden" name="ING_STEP_NM" id="ING_STEP_NM" value="<c:out value='${param.ING_STEP_NM}'/>" />
    
	<div class="cond-box" id="condBox1">
	    <div class="inquiry-table">
	        	<div class="table-cell">
	            	${condel.getLabel('RBA_50_08_07_001','배치기준일')}
	            	<div class="content">
	            		<div class="calendar">
	            			${condel.getInputDateDx('startDate',startDate)} ~ ${condel.getInputDateDx('endDate',endDate)}
	            		</div>
	        		</div>
	        	</div>
	    </div>
	</div>

	<div class="button-area" style="display: flex;justify-content: flex-end; padding-top:8px;">  

	        ${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
	        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"RBA028", defaultValue:"배치재수행", mode:"C", function:"doRetryBatch", cssClass:"btn-36"}')}

    </div>
    
<div class="tab-content-bottom" style="margin-top: 8px;">      
    <div id="GTDataGrid1_Area"></div>
</div>
	<div class="button-area" style="display: flex;justify-content: flex-end; padding-top:8px;">  
	        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close()", cssClass:"btn-36"}')}
	</div>
</form>
</body>
</html>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />