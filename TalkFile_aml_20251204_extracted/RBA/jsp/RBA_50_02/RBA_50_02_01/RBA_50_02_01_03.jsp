<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_02_01_03.jsp
* Description     : 업무프로세스 사용부서
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-08-16
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	
	String BAS_YYMM  = Util.nvl(request.getParameter("BAS_YYMM"));
	String PROC_FLD_C  = Util.nvl(request.getParameter("PROC_FLD_C"));
	String PROC_LGDV_C   = Util.nvl(request.getParameter("PROC_LGDV_C"));
	String PROC_MDDV_C = Util.nvl(request.getParameter("PROC_MDDV_C"));
	String PROC_SMDV_C = Util.nvl(request.getParameter("PROC_SMDV_C"));
	
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    request.setAttribute("PROC_FLD_C",PROC_FLD_C);
    request.setAttribute("PROC_LGDV_C",PROC_LGDV_C);
    request.setAttribute("PROC_MDDV_C",PROC_MDDV_C);
    request.setAttribute("PROC_SMDV_C",PROC_SMDV_C);
    
%>
<script>
    
    var GridObj1;
    var classID = "RBA_50_02_01_03";
    var pageID = "RBA_50_02_01_03";
    
    
    // Initialize
    $(document).ready(function(){
        $('.popup-contents').css({overflow:"auto"});
        setupGrids();
        setupFilter("init");
        doSearch();
    });
    
    // Initial function
    function init() { initPage();}
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	//gridObj.title = "STR검색";
    	gridArrs[0] = gridObj;
    	setupGridFilter2(gridArrs, FLAG);	
    }
    
    // 그리드 초기화 함수 셋업
	function setupGrids(){
        	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        		elementAttr: { class: "grid-table-type" },
        	    onToolbarPreparing: makeToolbarButtonGrids,
        		height          : 'calc(90vh - 100px)',
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
        		            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "업무프로세스관리_사용부서 수.xlsx");
        		        });
        		    });
        		    e.cancel = true;
                },
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
        	    sorting         : {mode   : "multiple"},
        	    loadPanel       : {enabled: false},
        	    remoteOperations: {
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
        	    searchPanel          : {
        	        visible: false,
        	        width  : 250
        	    },
        	    selection: {
        	        allowSelectAll    : true,
        	        deferred          : false,
        	        mode              : "multiple",
        	        selectAllMode     : "allPages",
        	        showCheckBoxesMode: "none"
        	    },
        	    columns: [
        	    	{
        	            dataField    : "BAS_YYMM",
        	            caption      : '기준년월',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            visible      : false,
        	            width : 50
        	        }, {
        	            dataField    : "PROC_FLD_C",
        	            caption      : '프로세스영역코드',
        	            alignment    : "left",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            visible      : false
        	        }, {
        	            dataField    : "PROC_FLD_NM",
        	            caption      : '${msgel.getMsg("RBA_50_02_01_017","영역")}',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : 100
        	        },{
        	            dataField    : "PROC_LGDV_C",
        	            caption      : '${msgel.getMsg("RBA_50_05_03_01_011","코드1")}',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : 50
        	        }, {
        	            dataField    : "PROC_LGDV_NM",
        	            caption      : '${msgel.getMsg("RBA_50_04_01_001","대분류")}',
        	            alignment    : "left",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	        }, {
        	            dataField    : "PROC_MDDV_C",
        	            caption      : '${msgel.getMsg("RBA_50_05_03_01_013","코드2")}',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : 80
        	        }, {
        	            dataField    : "PROC_MDDV_NM",
        	            caption      : '${msgel.getMsg("RBA_50_05_01_021","중분류")}',
        	            alignment    : "left",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : "60%"
        	        },  {
        	            dataField    : "PROC_SMDV_C",
        	            caption      : '${msgel.getMsg("RBA_50_05_03_01_015","코드3")}',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : 80
        	        }, {
        	            dataField    : "PROC_SMDV_NM",
        	            caption      : '${msgel.getMsg("RBA_50_05_01_022","소분류")}',
        	            alignment    : "left",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : 300
        	        }, {
        	            dataField    : "TONGJE_NO",
        	            caption      : '${msgel.getMsg("RBA_50_02_01_03_100","통제번호")}',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true 
        	        }, {
        	            dataField    : "USYN",
        	            caption      : '사용여부코드',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            visible      : false
        	        }, {
        	            dataField    : "VALT_BRNO",
        	            caption      : '${msgel.getMsg("RBA_50_01_02_01_003","부서코드")}',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : 70
        	        }, {
        	            dataField    : "VALT_BRNO_NM",
        	            caption      : '${msgel.getMsg("RBA_50_01_02_01_004","부서명")}',
        	            alignment    : "center",
        	            allowResizing: true,
        	            allowSearch  : true,
        	            allowSorting : true,
        	            width : "30%"
        	        }
        	    ],
        	    onCellClick: function(e){
        	        if(e.data){
        	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
        	        }
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
								setupFilter();
                        }
                 }
            });
        }
    }    
    
    //위험평가지표관리 상세 조회
    function doSearch(){
        
        var classID  = "RBA_50_02_01_03"; 
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= pageID;
        params.BAS_YYMM  	= "${BAS_YYMM}";
        params.PROC_FLD_C   = "${PROC_FLD_C}";
        params.PROC_LGDV_C  = "${PROC_LGDV_C}";
        params.PROC_MDDV_C  = "${PROC_MDDV_C}";
        params.PROC_SMDV_C 	= "${PROC_SMDV_C}";
        console.log(params);
        sendService(classID, methodID, params, doSearch_end, doSearch_end);
    }
    
    //위험평가지표관리 상세 완료
    function doSearch_end(gridData, data){ 

    	GridObj1.refresh();
    	GridObj1.option("dataSource",gridData);
    	
    	var gridInstance; gridInstance = $("#GTDataGrid1_Area").dxDataGrid('instance');
    	if ("${PROC_FLD_C}" == "1"){ 
    		gridInstance.columnOption('TONGJE_NO', 'visible', false); 
    	}else {
    		gridInstance.columnOption('TONGJE_NO', 'visible', true);
    	}
    }
    
</script>
<!-- 저장용 iframe -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top"><iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe></td>
    </tr>
</table>


<form name="form3" method="post" >
    <input type="hidden" name="pageID" > 
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="SEND_3_BAS_YYMM" id="SEND_3_BAS_YYMM">
    <input type="hidden" name="SEND_3_RSK_CATG" id="SEND_3_RSK_CATG">
    <input type="hidden" name="SEND_3_RSK_FAC" id="SEND_3_RSK_FAC">
    <input type="hidden" name="SEND_3_RSK_INDCT" id="SEND_3_RSK_INDCT">
    <input type="hidden" name="SEND_3_GYLJ_ID" id="SEND_3_GYLJ_ID">
    <input type="hidden" name="SEND_3_FLAG" id="SEND_3_FLAG">
    <input type="hidden" name="SEND_3_GYLJ_G_C" id="SEND_3_GYLJ_G_C">
</form>

<form name="form1" id="form1" method="post">
<input type="hidden" name="pageID">
<input type="hidden" name="classID"> 
<input type="hidden" name="methodID">
<input type="hidden" name="GUBN">
<input type="hidden" name="BAS_YYMM" value="${BAS_YYMM}">
<input type="hidden" name="mode">
    <div class="tab-content-bottom">      
        	 <div id="GTDataGrid1_Area"></div>
    </div>
	<div class="button-area" style="display: flex;justify-content: flex-end; padding-top:8px;">  
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')}
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />