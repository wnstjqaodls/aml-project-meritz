<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_90_01_02_01.jsp
- Author     :
- Comment    : FIU지표관리
- Version    :
- history    :
********************************************************************************************************************************************
* Modifier        : 이혁준
* Update          : 2018. 12. 04
* Alteration      :
*******************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLE_IDS",ROLE_IDS);
%>
<!--  -->
<script language="JavaScript">

	var GridObj1;

	var pageID 	 = "RBA_90_01_02_01";
	var overlay = new Overlay();

	$(document).ready(function(){
		setupGrids();
		doSearch();
		setting();
		setupFilter("init");
    });

	function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridObj.title  = "";
    	gridArrs[0] = gridObj;

    	setupGridFilter2(gridArrs,FLAG);
    }

	function setting() {
		form1.JIPYO_NM.style.width="200px";

		//기초데이터 등록 및 수정, 확정 못하게 버튼 제거
		var RPT_GJDT = form1.RPT_GJDT.value;
		if (RPT_GJDT == "99991231"){
			$("#btn_02").remove();
			$("#btn_03").remove();

			//클릭이벤트 제거
			GridObj1.option("onCellClick", null);
			const columns = GridObj1.option("columns");
			columns.forEach(function(col) {
		        if (col.cssClass === "link") {
		            delete col.cssClass;
		        }
		    });
			GridObj1.option("columns", columns);
		}
	}

	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 "height"						: "calc(-108px + 70vh)",
		     "hoverStateEnabled"            : true,
		     "wordWrapEnabled"              : false,
		     "allowColumnResizing"          : true,
		     "columnAutoWidth"              : true,
		     "allowColumnReordering"        : true,
		     "cacheEnabled"                 : false,
		     "cellHintEnabled"              : true,
		     "showBorders"                  : true,
		     "showColumnLines"              : true,
		     "showRowLines"                 : true,
		     "loadPanel"                    : {enabled: false},
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
		     "sorting": {"mode"             : "multiple"},
		     "remoteOperations":                  {
		         "filtering"                : false,
		         "grouping"                 : false,
		         "paging"                   : false,
		         "sorting"                  : false,
		         "summary"                  : false
		     },
		     "editing":
		     {
		         "mode"                     : "batch",
		         "allowUpdating"            : false,
		         "allowAdding"              : false,
		         "allowDeleting"            : false
		     },
		     "filterRow"                    : {"visible": false},
		     onToolbarPreparing   : makeToolbarButtonGrids,
		     pager: {
		         visible: true,
		         showNavigationButtons: true,
		         showInfo: true
		     },
		     paging: {
		         enabled: true,
		         pageSize: 50
		     },
		     scrolling: {
		         mode: "standard",
		         preloadEnabled: false
		     },
		     "rowAlternationEnabled"        : true,
		     "columnFixing": {"enabled"     : true},
		     "searchPanel":
		     {
		         "visible"                  : false,
		         "width"                    : 250
		     },
		     onContentReady: function (e)
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
		     "selection":
		     {
		         "allowSelectAll"           : true,
		         "deferred"                 : false,
		         "mode"                     : "multiple",
		         "selectAllMode"            : "allPages",
		         "showCheckBoxesMode"       : "always"
		     },
		     "columns":
		     [
		         {
		             "dataField"            : "JIPYO_IDX",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_002','지표번호')}",
		             "cssClass"         	: "link",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "fixed" 	            : true,
		             "width"                : 120
		         },
		         {
		             "dataField"            : "JIPYO_C_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_004','위험구분')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		         {
		             "dataField"            : "RSK_CATG_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_005','카테고리')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		         {
		             "dataField"            : "RSK_FAC_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_006','항목')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 100
		         },
		         {
		             "dataField"            : "JIPYO_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_003','지표명')}",
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 200
		         },
		         {
		             "dataField"            : "CAL_FRML",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_023','산출식')}",
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 200
		         },
		         {
		             "dataField"            : "INP_ITEM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_014','입력항목')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		         {
		             "dataField"            : "VALT_G_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_007','평가구분')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 100
		         },
		         {
		             "dataField"            : "ALLT_PNT",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_016','배점')}",
		             "alignment"            : "right",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 50
		         },
		         {
		             "dataField"            : "CAL_METH",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_012','산출방법')}",
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 160
		         },
		         {
		             "dataField"            : "IN_METH_C_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_024','입력방식')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 70
		         },
		         {
		             "dataField"            : "DPRT_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_009','관리지점')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 70
		         },
		         {
		             "dataField"            : "JIPYO_USYN_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_008','사용여부')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 70
		         },
		         {
		             "dataField"            : "CHG_DT",
		             "caption"              : "${msgel.getMsg('RBA_90_01_02_01_100','변경일자')}",
		             "cellTemplate"      	: function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 85
		         },
		         {
		             "dataField"            : "CHG_OP_JKW_NM",
		             "caption"              : "${msgel.getMsg('RBA_90_01_02_01_101','변경자')}",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true
		         },
		         {
		             "dataField"            : "JIPYO_USYN",
		             "caption"              : "JIPYO_USYN",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "JIPYO_FIX_YN",
		             "caption"              : "JIPYO_FIX_YN",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "IN_METH_C",
		             "caption"              : "IN_METH_C",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "IN_V_TP_C",
		             "caption"              : "IN_V_TP_C",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "CNCT_JIPYO_C_I",
		             "caption"              : "CNCT_JIPYO_C_I",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "CHG_OP_JKW_NO",
		             "caption"              : "CHG_OP_JKW_NO",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "MNG_BRNO",
		             "caption"              : "MNG_BRNO",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "JIPYO_DESC",
		             "caption"              : "JIPYO_DESC",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "WEGHT",
		             "caption"              : "WEGHT",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "BAS_V",
		             "caption"              : "BAS_V",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "JIPYO_BIGO_CTNT",
		             "caption"              : "JIPYO_BIGO_CTNT",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "ANEX_CTNT",
		             "caption"              : "ANEX_CTNT",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "VALT_G",
		             "caption"              : "VALT_G",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "JIPYO_C",
		             "caption"              : "JIPYO_C",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "RPT_GJDT",
		             "caption"              : "RPT_GJDT",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         }
		     ],
		     "onCellClick": function(e)
		     {
		        if(e.data )
		        {
		            Grid1CellClick("gridId", e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
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

	function doSearch(){

		overlay.show(true, true);
		var classID		= "RBA_90_01_02_01";
		var methodID	= "getSearch";
		var obj 		= new Object();
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "getSearch";
		obj.RPT_GJDT  	= jQuery("#RPT_GJDT option:selected").val();			// 보고기준일
		obj.JIPYO_IDX 	= form1.JIPYO_IDX.value.trim();							// 지표번호
		obj.JIPYO_NM  	= form1.JIPYO_NM.value.trim();							// 지표명
 		obj.JIPYO_C  	= form1.JIPYO_C.value.trim();							// 위험구분
 		obj.RSK_CATG  	= form1.RSK_CATG.value.trim();							// 카테고리
 		obj.RSK_FAC  	= form1.RSK_FAC.value.trim();							// 항목
 		obj.IN_METH_C  	= $("#IN_METH_C option:selected").val();				// 입력방식
 		obj.VALT_G  	= form1.VALT_G.value.trim();							// 평가구분
 		obj.JIPYO_USYN  = $("#JIPYO_USYN option:selected").val();				//사용여부
 		obj.MNG_BRNO  	= $("#SEARCH_DEP_ID").val().trim() != "99999" ? $("#SEARCH_DEP_ID").val().trim(): "";			//관리점

 		sendService(classID, methodID, obj, doSearch_success, doSearch_fail);
	}

	function doSearch_success(dataSource){
		overlay.hide();
		GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
		row = GridObj1.totalCount();
		doSearch2();
	}

	function doSearch_fail(){
		overlay.hide();
	}

	function doSearch2(){
		var classID		= "RBA_90_01_02_01";
		var methodID	= "getConfirmStatus";
		var obj 		= new Object();
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "getConfirmStatus";
		obj.RPT_GJDT  	= jQuery("#RPT_GJDT option:selected").val();			// 보고기준일
 		sendService(classID, methodID, obj, doSearch_end2, doSearch_end2);
	}

	function doSearch_end2(param, data)
	{
		var gridData = data.GRID_DATA
		var rowCount = gridData.length;
	    var jipyoFixYn = 0;

	    for( var i=0; i  < rowCount; i++)
	    {
	        var obj = gridData[i];
	        jipyoFixYn = obj.JIPYO_FIX_YN;
	    }

	    $("#JIPYO_FIX_YN_NM").val(jipyoFixYn == "1" ? "Y":"N");
	 	$("#JIPYO_FIX_YN").val(jipyoFixYn != "" ? jipyoFixYn : "0") ;
	 	$("#JIPYO_FIX_YN_NM").attr("readonly" , true);

	}


	function doSaveBranch(){

		var selectedRows = GridObj1.getSelectedRowsData();
        var selSize      = selectedRows.length;
        var obj 		 = new Object();
		if(selSize == 0){
			showAlert('${msgel.getMsg("RBA_90_01_02_01_201","저장할 데이타를 선택하십시오.")}', "WARN");
			return;
		}

		if (form1.JIPYO_FIX_YN_NM.value=="확정") {
			showAlert('${msgel.getMsg("RBA_90_01_02_01_202","확정된 기준일자의 보고지표는 관리지점을 변경할 수 없습니다.")}', "WARN");
			return;
		}

		if(form1.SEARCH_DEP_ID2.value == "" || form1.SEARCH_DEP_ID2.value == null ){
			showAlert('${msgel.getMsg("RBA_90_01_02_01_203","관리지점을 입력해주세요.")}', "WARN");
			return;
		}
		if(form1.SEARCH_DEP_ID2.value == "999"){
			showAlert('${msgel.getMsg("RBA_90_01_02_01_204","전체가 아닌 관리지점을 입력해주세요.")}', "WARN");
			return;
		}

	    showConfirm('${msgel.getMsg("RBA_90_01_02_01_205","관리지점을 저장하시겠습니까?")}', "저장",doSaveBranch_Action);

	}

	function doSaveBranch_Action(){
	    var classID  = "RBA_90_01_02_01"
	    var methodID = "doSaveBranch"
	    var obj = new Object();
 		obj.pageID 			= pageID;
		obj.classID 		= "RBA_90_01_02_01";
		obj.methodID 		= "doSaveBranch";
		obj.RPT_GJDT 		= form1.RPT_GJDT.value;
		obj.MNG_BRNO_SAVE 	= form1.SEARCH_DEP_ID2.value;
		obj.gridData		= GridObj1.getSelectedRowsData();

		sendService(classID, methodID, obj, doSearch, doSearch);
	}

	/**
	 *  보고지표관리 등록
	 */
	function doCreateItem(){

		if ($("#JIPYO_FIX_YN").val()=="1") {
			showAlert('${msgel.getMsg("RBA_90_01_02_01_206","확정된 기준일자의 보고지표는 신규로 등록할 수 없습니다.")}', "WARN");
			return;
		}

		var form3 = document.form3;

		form3.RPT_GJDT.value =$("#RPT_GJDT option:selected").val();
		form3.JIPYO_FIX_YN.value =$("#JIPYO_FIX_YN").val();
		form3.pageID.value = "RBA_90_01_02_04";
		form3.target ="RBA_90_01_02_04";
		window_popup_open(form3.pageID.value,1010,944,'');
		form3.action = "<c:url value='/'/>0001.do";
		form3.submit();

	}

	/* 등록링크 클릭  팝업*/
	function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId) {

		if(columnId == "JIPYO_IDX" ) {	//수정 팝업

			if (form1.JIPYO_FIX_YN_NM.value == "확정") {
				form2.pageID.value  = 'RBA_90_01_03_05';
				var	win; win = window_popup_open(form2.pageID.value, 1060, 825, '');
				form2.RPT_GJDT.value 		= obj.RPT_GJDT;
				form2.JIPYO_IDX.value 	  	= obj.JIPYO_IDX;
				form2.IN_V_TP_C.value 		= obj.IN_V_TP_C;
				form2.CNCT_JIPYO_C_I.value	= obj.CNCT_JIPYO_C_I;
				form2.JIPYO_VIEW.value		= "Y";
				form2.target = form2.pageID.value;
				form2.action = '<c:url value="/"/>0001.do';
				form2.submit();

			}else{
				form2.pageID.value  		= 'RBA_90_01_02_02';
				var	win;   win = window_popup_open(form2.pageID.value, 1110, 828, '','yes');
				form2.RPT_GJDT.value 		= obj.RPT_GJDT;
				form2.JIPYO_IDX.value 	  	= obj.JIPYO_IDX;
				form2.MODIFY.value 			= 'Y';
				form2.JIPYO_FIX_YN.value 	= $("#JIPYO_FIX_YN").val();
				form2.target 				= form2.pageID.value;
				form2.action 				= '<c:url value="/"/>0001.do';
				form2.submit();
			}
	    }
	}

	function doConfirm(){

		var RPT_GJDT = $("#RPT_GJDT option:selected").val();
		var confirmStatus; confirmStatus = $("#JIPYO_FIX_YN").val();

		try {
		    jQuery.ajax({
	            url         : "/JSONServlet?Action@@@=com.gtone.aml.common.action.DispatcherAction"
	           ,type        : "POST"
	           ,dataType    : "json"
	           ,processData : true
	           ,data        : {
	               "pageID"     		: "RBA_90_01_02_01"
	              ,"classID"    		: "RBA_90_01_02_01"
	              ,"methodID"   		: "doCheckJipyoV"
	              ,"RPT_GJDT"			:  RPT_GJDT
	           }
	           ,success : function(jsondata) {
	               try {
	                   if (jsondata&&jsondata.GRID_DATA&&jsondata.GRID_DATA.length>0) {

	                	   if(jsondata.GRID_DATA[0]["RESULT"] == "false"){
	                		   showAlert('${msgel.getMsg("RBA_90_01_02_01_207","이미 확정처리된 지표데이터가 존재하여 확정/취소 할 수 없습니다.")}', "WARN");
	                		   return;
	                	   }else{

	                		   if (confirmStatus=="1") {
	                			   showConfirm('${msgel.getMsg("RBA_90_01_02_01_208","확정 취소하시겠습니까?")}', "확정",doConfirm_Action);
	                			} else {
	                			   showConfirm('${msgel.getMsg("RBA_90_01_02_01_209","확정하시겠습니까?")}', "확정", doConfirm_Action);
	                			}
	                	   }
	                   }
	               } catch (e) {showAlert(e.message, "ERR");}
	            }
	           ,error : function(xhr, textStatus) {showAlert(textStatus, "ERR");}
	        });
	    } catch (e) {showAlert(e.message, "ERR");}

	}

	function doConfirm_Action() {
		var RPT_GJDT = $("#RPT_GJDT option:selected").val();
	    var obj = new Object();
		var classID 		= "RBA_90_01_02_01";
		var methodID 		= "doConfirm";
	    obj.pageID 			= pageID;
		obj.classID 		= "RBA_90_01_02_01";
		obj.methodID 		= "doConfirm";
		obj.RPT_GJDT 		= RPT_GJDT;
		sendService(classID, methodID, obj, doSearch, doSearch);
	}

	 function onAftreRptGjdtCdList() {

		 nextSelectChangeReportIndex("RSK_CATG",form1.RPT_GJDT.value, "A002" ,"" ,"","INIT");
		 nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
		 nextSelectChangeReportIndex("VALT_G", form1.RPT_GJDT.value, "A007" ,"" ,"","");
		 nextSelectChangeReportIndex("IN_METH_C", form1.RPT_GJDT.value, "A013" ,"" ,"","");

		 jQuery("#VALT_G").val("");
		 jQuery("#JIPYO_USYN").val("1");
		 setTimeout("doSearch()","800");
	 }

	 function onAftreJipyoCCdList() {
		 nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
	 }

	 function jipyoSelectChange(v_gubun, nextGrp, GrpObj, v_afterFun) {
		var RPT_GJDT = form1.RPT_GJDT.value;
		var gubun = "";
		nextSelectChangeReportIndex(v_gubun, RPT_GJDT, nextGrp, GrpObj, v_afterFun , gubun);
	}

	 function doReportSimpleFileDownload(){
	 	form2.RPT_GJDT.value =$("#RPT_GJDT option:selected").val();
		form2.target	= "_self";
		form2.action    =  "<c:url value='/'/>0001.do?pageID=rbaFIURptXLSSimpleDown";   // "TB_EBZI_AML_LOG_AC"."PGE_ID" 길이제한 오류
	   	form2.method	= "post";
	   	form2.submit();
	 }
	 
	 function evalStd(){
		 	
			var selectedRows = GridObj1.getSelectedRowsData();
	   		var selSize      = selectedRows.length;
	   		var cnt = 0;
			var JIPYO_IDX = "";				//지표번호
			var IN_V_TP_C = "";				//입력값타입
			var CNCT_JIPYO_C_I = "";		//연결코드정보
			var VALT_G = "";
			var JIPYO_C = "";
			
			if(selSize == 0){
				showAlert('${msgel.getMsg("RBA_90_01_03_01_217","데이터를 선택하십시오.")}', "WARN"); 
				return;
			}
				
			for (var i=0; i<selSize; i++) {
				JIPYO_IDX 		= selectedRows[i].JIPYO_IDX;
				IN_V_TP_C 		= selectedRows[i].IN_V_TP_C;
				CNCT_JIPYO_C_I 	= selectedRows[i].CNCT_JIPYO_C_I;
				VALT_G 			= selectedRows[i].VALT_G;
				JIPYO_C 		= selectedRows[i].JIPYO_C;
				
				cnt++;
	        }
			
			if(cnt > 1){
				showAlert('${msgel.getMsg("RBA_90_01_02_01_210","한 건만 선택 가능합니다.")}', "WARN");
				return;
			}
				
			if(!(JIPYO_C == 'O' && (VALT_G =='1' || VALT_G =='4')) ){
				showAlert('${msgel.getMsg("RBA_90_01_02_01_211","평가기준은 운영위험(Range 평가/여부평가)만 가능합니다.")}', "WARN");
				return;
			}
				
			var form4 = document.form4;
		  	form4.RPT_GJDT.value 		= $("#RPT_GJDT option:selected").val();
			form4.JIPYO_IDX.value 	  	= JIPYO_IDX;
			form4.JIPYO_FIX_YN.value 	= $("#JIPYO_FIX_YN").val();
			form4.IN_V_TP_C.value 		= IN_V_TP_C;
			form4.CNCT_JIPYO_C_I.value 	= CNCT_JIPYO_C_I;
			form4.pageID.value 			= "RBA_90_01_02_03";
			form4.target 				= "RBA_90_01_02_03";
			window_popup_open(form4.pageID.value,850,985,'');
			form4.action = "<c:url value='/'/>0001.do";
			form4.submit();
		  
		 }

</script>
<form name="from0" method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
</form>
<form name="form4" method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	<input type="hidden" name="RPT_GJDT" >
	<input type="hidden" name="JIPYO_IDX" >
	<input type="hidden" name="IN_V_TP_C" >
	<input type="hidden" name="CNCT_JIPYO_C_I" >
	<input type="hidden" name="JIPYO_FIX_YN" id= "JIPYO_FIX_YN">
	<input type="hidden" name="JIPYO_VIEW" id ="JIPYO_VIEW" value="N" >
</form>

<form name="form3" method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	<input type="hidden" name="RPT_GJDT" >
	<input type="hidden" name="JIPYO_FIX_YN" id= "JIPYO_FIX_YN">
</form>

<form name="form2" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
	<input type="hidden" name="RPT_GJDT">
	<input type="hidden" name="JIPYO_IDX">
	<input type="hidden" name="MODIFY" >
	<input type="hidden" name="JIPYO_VIEW" >
	<input type="hidden" name="IN_V_TP_C" >
	<input type="hidden" name="CNCT_JIPYO_C_I" >
	<input type="hidden" name="JIPYO_FIX_YN" id= "JIPYO_FIX_YN">
</form>
<form name="form1" onkeydown="doEnterEvent('doSearch');">
	<input type="hidden" name="pageID">
	<input type="hidden" id="classID" name="classID">
	<input type="hidden" id="methodID" name="methodID">

 <div class="inquiry-table type4" id="condBox1">
    <div class="table-row" style="width:24%;">
      <div class="table-cell">
       		${condel.getLabel('RBA_90_01_01_02_001','보고기준일')}
			${JRBACondEL.getJRBASelect('','RPT_GJDT' ,'' ,'140px' ,'JRBA_common_getRPT_GJDT' ,'' ,'','jipyoSelectChange("JIPYO_C", "A001", this, "onAftreRptGjdtCdList()")')}
	  </div>
      <div class="table-cell">
      		${condel.getLabel('RBA_90_01_01_02_004','위험구분')}
	        ${JRBACondEL.getJRBASelect('MAX','JIPYO_C' ,'A001' ,'140px' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_CATG", "A002", this, "onAftreJipyoCCdList()")')}
	  </div>
      <div class="table-cell">
      		${condel.getLabel('RBA_90_01_01_02_007','평가구분')}
			${JRBACondEL.getJRBASelect('MAX','VALT_G' ,'A007' ,'140px' ,'' ,'' ,'ALL','')}
	  </div>
	</div>
    <div class="table-row" style="width:20%;">
      <div class="table-cell">
         	${condel.getLabel('RBA_90_01_01_02_002','지표번호')}
            ${condel.getInputCustomerNo('JIPYO_IDX')}
      </div>
      <div class="table-cell">
         	${condel.getLabel('RBA_90_01_01_02_005','카테고리')}
			${JRBACondEL.getJRBASelect('','RSK_CATG' ,'A002' ,'' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_FAC", "A003", this)')}
      </div>
      <div class="table-cell">
			${condel.getLabel('RBA_90_01_01_02_008','사용여부')}
			<div class="content">
	    	<select id="JIPYO_USYN" name="JIPYO_USYN"  class="dropdown" >
				<option value="">::전체::</option>
				<option value="1" selected>Y</option>
				<option value="0" >N</option>
			</select>
			</div>
      </div>
	</div>
    <div class="table-row" style="width:32%;">
      <div class="table-cell">
         	${condel.getLabel('RBA_90_01_01_02_003','지표명')}
         	${condel.getInputCustomerNo('JIPYO_NM')}
       </div>
      <div class="table-cell">
         	${condel.getLabel('RBA_90_01_01_02_006','항목')}
			${JRBACondEL.getJRBASelect('','RSK_FAC' ,'A003' ,'' ,'' ,'' ,'ALL','')}
       </div>
      <div class="table-cell">
   		 	${condel.getLabel('RBA_90_01_01_02_009','관리지점')}
			<%if ("7".equals(ROLE_IDS) || "5".equals(ROLE_IDS) || "4".equals(ROLE_IDS)) {%>
				${condel.getBranchSearch('SEARCH_DEP_ID','ALL')}
			<%}else{%>
				${condel.getBranchSearch('SEARCH_DEP_ID',BDPT_CD,BDPT_CD,'','')}
			<%} %>
       </div>
      </div>
    	<div class="table-row" style="width:24%;">
       	  	<div class="table-cell">
    		${condel.getLabel('RBA_90_01_01_02_024','입력방식')}
			${JRBACondEL.getJRBASelect('MAX','IN_METH_C' ,'A013' ,'' ,'' ,'' ,'ALL','')}
			</div>
       	<div class="table-cell">
  	        ${condel.getLabel('RBA_90_01_01_02_025','확정여부')}
  	        <div class="content">
			<input type="text" class="input_text" id="JIPYO_FIX_YN_NM" name="JIPYO_FIX_YN_NM" maxlength="10" style="width:135px;text-align:center;" readonly />
			<input type="hidden" name="JIPYO_FIX_YN" id="JIPYO_FIX_YN">
			</div>
    	</div>
    	<div class="table-cell" style="border-bottom: 1px solid #dedede"></div>
    	</div>
  </div>
  <div class="button-area">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"AML_90_01_01_01_btn_02", defaultValue:"등록", mode:"C", function:"doCreateItem", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"evalStdBtn", defaultValue:"평가기준", mode:"R", function:"evalStd", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"BatchConfirmCancelBtn", defaultValue:"확정/취소", mode:"U", function:"doConfirm", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"simpleReportCreateBtn", defaultValue:"샘플보고파일", mode:"R", function:"doReportSimpleFileDownload", cssClass:"btn-36"}')}
   </div>
	<div class="inquiry-table" style="margin-top: 8px;">
		<div class="table-row">
	    	<div class="table-cell">
          		<%if ("7".equals(ROLE_IDS) || "5".equals(ROLE_IDS) || "4".equals(ROLE_IDS)) {%>
						${condel.getLabel('RBA_90_01_01_02_009','관리지점')}
            		    ${condel.getBranchSearch('SEARCH_DEP_ID2','ALL')}
						${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSaveBranch", cssClass:"btn-36"}')}
				 <%}%>
			</div>
		</div>
	</div>
	<div class="tab-content-bottom" style="margin-top: 8px;">
	    <div id="GTDataGrid1_Area"></div>
	</div>
</form>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />