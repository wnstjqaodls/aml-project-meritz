<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_03_02_03.jsp
* Description     : 신규위험요소 불러오기 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2025-07-30
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%
	
	String BAS_YYMM  = Util.nvl(request.getParameter("BAS_YYMM"));
	String RSK_ELMT_C = Util.nvl(request.getParameter("RSK_ELMT_C"));
	
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    request.setAttribute("RSK_ELMT_C",RSK_ELMT_C);
    
%>
<script language="JavaScript">
    
    var GridObj1 = null;
    var classID = "RBA_50_03_02_03";
    var pageID = "RBA_50_03_02_03";
    
    var FIRST_ROLE_ID =""; 
    
    // Initialize
    $(document).ready(function(){

        $('.popup-contents').css({overflow:"auto"});
        $("#CNTL_CATG1_C").attr("style","width:150px;");
        $("#CNTL_CATG2_C") .attr("style","width:200px;");
        $("#CNTL_ELMN_C") .attr("style","width:150px;");
        
        setupGrids();
		//setting();
		
        doSearch();
               			
    });
    
    
    /** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			elementAttr: { class: "grid-table-type" },
    		height 				  : "calc(100vh - 140px)",
    		hoverStateEnabled     : true,
    		wordWrapEnabled       : false,
    		allowColumnResizing   : true,
    		allowColumnReordering : true,
    		columnResizingMode    : "widget", /* "widget" "nextColumn" */
    		cacheEnabled          : false,
    		cellHintEnabled       : true,
    		showBorders           : true,
    		showColumnLines       : true,
    		showRowLines          : true,
    		export : {allowExportSelectedData:true, enabled:true},
            onExporting: function (e) {
            	var workbook = new ExcelJS.Workbook();
            	var worksheet = workbook.addWorksheet("Sheet1");
			    DevExpress.excelExporter.exportDataGrid({
			        component: e.component,
			        worksheet : worksheet,
			        autoFilterEnabled: true,
			    }).then(function() {
			        workbook.xlsx.writeBuffer().then(function(buffer) {
			            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}.xlsx");
			        });
			    });
			    e.cancel = true;
            },
    		sorting: { mode: "multiple"},
    		loadPanel : { enabled: false },
    		remoteOperations : {filtering:false, grouping:false, paging:false, sorting:false, summary:false},
    		editing: { mode: 'batch', allowUpdating: true, allowAdding: false, allowDeleting: false, selectTextOnEditStart: true},
    		filterRow: { visible: false },
    		rowAlternationEnabled : true,
    		columnFixing: {	enabled: true},
    		dataSource: new DevExpress.data.ArrayStore({
    		   key: ["RSK_ELMT_C_NM"]
    		}),
    		pager: {
    		    visible: true,
    		    showNavigationButtons: true,
    		    showInfo: true
    		},
    		paging: {
    			enabled: false
    		},
    		scrolling: {
    		    mode: "standard",
    		    preloadEnabled: false
    		},
    	    searchPanel: {
    	           visible: false,
    	           width: 250,
    	           searchVisibleColumnsOnly: true
    	       },
    	    selection: {
    	       	allowSelectAll : true,
    	       	deferred : false,
    	       	mode : "multiple", /*none, single, multiple*/
    	       	selectAllMode : "allPages",  /*: 'page' | 'allPages'*/
    	       	showCheckBoxesMode : "always"  /*'onClick' | 'onLongTap' | 'always' | 'none'*/
    	       },
    	    scrolling   : {
    	        mode    : "virtual"
    	    },
    	    columns:
		     [
		         {
		             dataField            : "RSK_CATG1_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_002","위험분류")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 80
		         },
		         {
		             dataField            : "RSK_VALT_ITEM_NM",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_003","평가항목")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 220
		         },
		         {
		             dataField            : "RSK_ELMT_C",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_008","위험요소")}',
		             alignment            : "left",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 300
		         },
		         {
		             dataField            : "RSK_ELMT_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_008","위험요소")}',
		             alignment            : "left",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 300
		         },
		         {
		             dataField            : "EDD_YN",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_004","당연EDD여부")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             lookup : { dataSource  : [{"KEY":"H","VALUE":"H"},{"KEY":"Y","VALUE":"Y"},{"KEY":"N","VALUE":"N"}] /* {"KEY":"","VALUE":"=선택="}, */
                     ,displayExpr : "VALUE",valueExpr   : "KEY"},
		             width                : 100
		         },
		         {
		             dataField            : "MSG",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_020","신규추가")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 100
		         }

		     ],
		     onCellPrepared : function(e){
		          if(e.rowType === 'data' && ( e.column.dataField == 'RSK_ELMT_C_NM' ) ){
		           e.cellElement.css("color", "blue");
		          }
	         },
	         onCellClick: function(e){
		    	 if( e.column.dataField == 'RSK_ELMT_C_NM'  ){

		    		 Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		    		 /* if(e.data){
		    			 Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
	    	         }
	    	         if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
	    	         } else {
	    	            e.component.clearSelection();
	    	            e.component.selectRowsByIndexes(e.rowIndex);
	    	         } */
			     }

	    	}

		}).dxDataGrid("instance");
	}


	// 그리드 클릭 - KRI 상세정보 팝업 호출
	function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){

        var pageID  = "RBA_50_03_02_02";
        var classID = "RBA_50_03_02_02";
        var form2  = document.form2;

        //alert( "test popup : " + colId);
        if (obj.MSG == "추가") {
        	alert( "[" + obj.RSK_ELMT_C_NM + "] 신규추가대상으로 전산개발요건 입니다");
        } else if (colId == "RSK_ELMT_C_NM") {

        	//alert( "call popup " + obj.RSK_ELMT_C);

            form2.pageID.value    = pageID;
            form2.classID.value   = classID;
            form2.BAS_YYMM.value       = form1.BAS_YYMM.value;
            form2.RSK_ELMT_C.value     = obj.RSK_ELMT_C;		// 통제요소
            form2.FLAG.value           = "0";
            form2.EDD_YN.value         = obj.EDD_YN;

            //alert( "test popup : " + form2.FLAG.value + "   EDD_YN : " + form2.EDD_YN.value);

            form2.target          = form2.pageID.value;
            var win               = window_popup_open(form2.pageID.value, 750, 850, '','yes');
            form2.action          = '<c:url value="/"/>0001.do';
            form2.submit();
        }
        
        
    }
    
    // Initial function
    function init() { initPage();}
    
    //위험평가지표관리 상세 조회
    function doSearch(){
    	    
        var classID  = "RBA_50_03_02_03"; 
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= pageID;
        params.BAS_YYMM = form1.BAS_YYMM.value;
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }
    //위험평가지표관리 상세 완료
    function doSearch_success(gridData, data){
    	GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    }
    function doSearch_fail(){    	 
    	
    }

    
    //위험평가지표관리 상세 저장
    function doSave() {

		 showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>', '${msgel.getMsg("AML_00_00_01_01_025","저장")}', doSave_Action);
    }

    function doSave_Action(){

		var methodID    = "doSave";
		var obj = new Object();
		var classID  = "RBA_50_03_02_02"; 
		
		//alert( "call save : " + form1.BAS_YYMM.value);
		
		obj.pageID            = "RBA_50_03_02_02";					//"RBA_50_04_03_02";
		obj.BAS_YYMM 	      = form1.BAS_YYMM.value; //"${BAS_YYMM}";		//평가년월
		obj.RSK_ELMT_C        = form1.RSK_ELMT_C.value; //"${RSK_ELMT_C}";
		obj.USE_YN            = form1.USE_YN1.value; //"${USE_YN1}";
		obj.RSK_PNT           = form1.RSK_PNT.value; //"${RSK_PNT}";
		obj.RSK_ELMT_DTL_CTNT = form1.RSK_ELMT_DTL_CTNT.value; //"${RSK_ELMT_DTL_CTNT}";
		obj.COMMENT_CTNT      = form1.COMMENT_CTNT.value; //"${COMMENT_CTNT}";

		sendService(classID, methodID, obj, doSave_end, doSave_end);
   }
  
    //위험평가지표관리 상세 완료
    function doSave_end() { 
       opener.doSearch();
       window.close();
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
    <input type="hidden" name="SEND_3_CNTL_CATG1_C" id="SEND_3_CNTL_CATG1_C">
    <input type="hidden" name="SEND_3_CNTL_CATG2_C" id="SEND_3_CNTL_CATG2_C">
    <input type="hidden" name="SEND_3_RSK_INDCT" id="SEND_3_RSK_INDCT">
    <input type="hidden" name="SEND_3_GYLJ_ID" id="SEND_3_GYLJ_ID">
    <input type="hidden" name="SEND_3_FLAG" id="SEND_3_FLAG">
    <input type="hidden" name="SEND_3_GYLJ_G_C" id="SEND_3_GYLJ_G_C">
</form>
<form name="form2" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
	<input type="hidden" name="BAS_YYMM" >
	<input type="hidden" name="FLAG" >
	<input type="hidden" name="EDD_YN" >
	<input type="hidden" name="RSK_ELMT_C" >
</form>
<form name="form1" id="form1" method="post">
<input type="hidden" name="pageID">
<input type="hidden" name="classID"> 
<input type="hidden" name="methodID">
<input type="hidden" name="GUBN">
<input type="hidden" name="BAS_YYMM" value="${BAS_YYMM}">
<input type="hidden" name="RSK_ELMT_C" value="${RSK_ELMT_C}">
<input type="hidden" name="mode">
    <div class="panel panel-primary" >
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
     <div align="right" style="margin-top: 8px">
         ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')}
     </div>
    
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />