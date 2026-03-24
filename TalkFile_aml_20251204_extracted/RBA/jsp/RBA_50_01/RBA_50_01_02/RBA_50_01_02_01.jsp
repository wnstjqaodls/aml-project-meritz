<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_02_01.jsp
* Description     : 평가부점 관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-25
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
	<script language="JavaScript">
	var GridObj1 = null;
	var GridObj2 = null;
	var overlay = new Overlay();
	var classID  = "RBA_50_01_02_01";
	var arrDeleteRows = "";

	$(document).ready(function(){
		setupGrids();
		setupFilter1("init");
        setupFilter2("init");

	});

    function doSearch01() {
		if(form1.BRNO_NM1.value != ""){
			doSearch();
		}else if (form1.BRNO_NM2.value != ""){
        	doSearch2();
		}
	}

    // 그리드 초기화 함수 셋업
    function setupGrids(){

    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
        	"width" 						: "100%",
    		"height"						: "calc(95vh - 250px)",
    		"hoverStateEnabled": true,
    		 "wordWrapEnabled": false,
    		 "allowColumnResizing": true,
    		 "columnAutoWidth": true,
    		 "allowColumnReordering": true,
    		 "cacheEnabled": false,
    		 "cellHintEnabled": true,
    		 "showBorders": true,
				"onToolbarPreparing"	: makeToolbarButtonGrids,
    		 "showColumnLines": true,
    		 "showRowLines": true,
    		 "export":{"allowExportSelectedData": false,"enabled": false,"excelFilterEnabled": false,"fileName": "gridExport"},
    		 "sorting": {"mode": "multiple"},
    		 "remoteOperations":{"filtering": false, "grouping": false, "paging": false,"sorting": false,"summary": false},
    		 "editing":{"mode": "batch","allowUpdating": false, "allowAdding": false, "allowDeleting": false},
    		 "filterRow": {"visible": false},
    		 "rowAlternationEnabled": false,
    		 "columnFixing": {"enabled": true},
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
    		 "searchPanel":{ "visible": false,"width": 250},
    		 "selection":{"allowSelectAll": true, "deferred": false,"mode": "multiple","selectAllMode": "allPages", "showCheckBoxesMode": "always" },
    		 "columns": [
    			 {"dataField": "HGRK_BRNO",			"caption": '${msgel.getMsg("RBA_50_01_02_01_001","본부번호")}',"alignment": "center", "allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "15%","visible": false,"allowEditing": false},
    		     {"dataField": "HGRK_BRNO_NM",		"caption": '${msgel.getMsg("RBA_50_01_02_01_002","본부명")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": false,"width": "25%","allowEditing": false},
    		     {"dataField": "BRNO",					"caption":'${msgel.getMsg("RBA_50_01_02_01_003","부서코드")}',"alignment": "center","allowResizing": true, "allowSearch": true,"allowSorting": true,"width": "100","allowEditing": false},
    		     {"dataField": "MOFC_BRN_NAME",	"caption": '${msgel.getMsg("RBA_50_01_02_01_006","본사/지점")}',"alignment": "center","allowResizing": true, "allowSearch": true,"allowSorting": true,"width": "15%","allowEditing": false},
    		     {"dataField": "BRNO_NM",				"caption": '${msgel.getMsg("RBA_50_01_02_01_004","부서명")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "40%","allowEditing": false},
    		     {"dataField": "MOFC_BRN_CCD",		"caption": '${msgel.getMsg("RBA_50_01_02_01_005","지점본사코드")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": false,"width": "40","allowEditing": false},
    		     {"dataField": "KYC_YN",				"caption": '${msgel.getMsg("RBA_50_01_02_01_010","최근1년KYC수행여부")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "20%","allowEditing": false},
    		     {"dataField": "PRE_USE_YN",				"caption": '${msgel.getMsg("RBA_50_01_02_01_011","직전회차 여부")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "20%","allowEditing": false},
    		     {"dataField": "AML_TJ_BRNO_YN", 	"caption": '${msgel.getMsg("RBA_50_01_02_01_007","AML통제부서여부")}', "alignment": "center", "allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "0%","visible": false,
    		         "lookup": {dataSource  : [{"VALUE":"0","LABEL":"N"},{"VALUE":"1","LABEL":"Y"}],displayExpr : "LABEL",valueExpr   : "VALUE"},
    		         "allowEditing": true,showEditorAlways: true}
    		 ]
        }).dxDataGrid("instance");


        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
        	"width" 						: "100%",
    		"height"						:"calc(95vh - 250px)",
    		"hoverStateEnabled": true,
    		 "wordWrapEnabled": false,
    		 "allowColumnResizing": true,
    		 "columnAutoWidth": true,
    		 "allowColumnReordering": true,
    		 "cacheEnabled": false,
    		 "cellHintEnabled": true,
    		 "showBorders": true,
			 "onToolbarPreparing"	: makeToolbarButtonGrids,
    		 "showColumnLines": true,
    		 "showRowLines": true,
    		 "export":{
    		     "allowExportSelectedData": false,
    		     "enabled": false,
    		     "excelFilterEnabled": false,
    		     "fileName": "gridExport"
    		 },
    		 "sorting": {"mode": "multiple"},
    		 "remoteOperations":{
    		     "filtering": false,
    		     "grouping": false,
    		     "paging": false,
    		     "sorting": false,
    		     "summary": false
    		 },
    		 "editing":{
    		     "mode": "batch",
    		     "allowUpdating": false,
    		     "allowAdding": false,
    		     "allowDeleting": false
    		 },
    		 "filterRow": {"visible": false},
    		 "rowAlternationEnabled": false,
    		 "columnFixing": {"enabled": true},
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
    		 "searchPanel":{
    		     "visible": false,
    		     "width": 250
    		 },
    		 "selection":{
    		     "allowSelectAll": true,
    		     "deferred": false,
    		     "mode": "multiple",
    		     "selectAllMode": "allPages",
    		     "showCheckBoxesMode": "always"
    		 },
    		 "columns":[
    			 {"dataField": "HGRK_BRNO",			"caption": '${msgel.getMsg("RBA_50_01_02_01_001","본부번호")}',"alignment": "center", "allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "15%","visible": false,"allowEditing": false},
    		     {"dataField": "HGRK_BRNO_NM",		"caption": '${msgel.getMsg("RBA_50_01_02_01_002","본부명")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": false,"width": "25%","allowEditing": false},
    		     {"dataField": "BRNO",					"caption":'${msgel.getMsg("RBA_50_01_02_01_003","부서코드")}',"alignment": "center","allowResizing": true, "allowSearch": true,"allowSorting": true,"width": "100","allowEditing": false},
    		     {"dataField": "MOFC_BRN_NAME",	"caption": '${msgel.getMsg("RBA_50_01_02_01_006","본사/지점")}',"alignment": "center","allowResizing": true, "allowSearch": true,"allowSorting": true,"width": "15%","allowEditing": false},
    		     {"dataField": "BRNO_NM",				"caption": '${msgel.getMsg("RBA_50_01_02_01_004","부서명")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "40%","allowEditing": false},
    		     {"dataField": "MOFC_BRN_CCD",		"caption": '${msgel.getMsg("RBA_50_01_02_01_005","지점본사코드")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"visible": false,"width": "40","allowEditing": false},
    		     {"dataField": "KYC_YN",				"caption": '${msgel.getMsg("RBA_50_01_02_01_010","최근1년KYC수행여부")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "20%","allowEditing": false},
    		     {"dataField": "PRE_USE_YN",				"caption": '${msgel.getMsg("RBA_50_01_02_01_011","직전회차 여부")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"width": "20%","allowEditing": false},
    		     {"dataField": "AML_TJ_BRNO_YN",	"caption": '${msgel.getMsg("RBA_50_01_02_01_007","AML통제부서여부")}',"alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true,"allowEditing": false,"visible": false}
    		 ]
        }).dxDataGrid("instance");
        doSearch();
    }

	function doSearch() {
		overlay.show(true, true);
		GridObj1.clearSelection();
        GridObj1.option('dataSource', []);

        var params = new Object();
        var methodID    = "doSearchBrno";
		var classID  = "RBA_50_01_02_01";
		overlay.show(true, true);
		params.pageID 	= "RBA_50_01_02_01";
		params.BAS_YYMM   = form1.BAS_YYMM.value;//기준연도
		params.BRNO   = form1.BRNO_NM1.value; //부서
		params.MOFC   = form1.mofckbn.value;
		params.AML_TJ_BRNO_YN   = form1.aml_tj_brno_yn.value;

		params.KYC_YN   = form1.kyc_yn.value;
		params.PRE_USE_YN   = form1.pre_use_yn.value;

		sendService(classID, methodID, params, doSearch_end, doSearch_fail);

	}

	function doSearch_end(gridData, data) {
		GridObj1.refresh();
	    GridObj1.option("dataSource", gridData);
		doSearch2(gridData, data);
	}

	function doSearch_fail(){
		console.log("doSearch_fail");
    }

	function doSearch2(gridData, data) {
		overlay.show(true, true);
		GridObj2.clearSelection();
        GridObj2.option('dataSource', []);

	    var params = new Object();
        var methodID 	= "doSearchBrno2";
		var classID  = "RBA_50_01_02_01";
		overlay.show(true, true);
		params.pageID 	= "RBA_50_01_02_01";
		params.BAS_YYMM   = form1.BAS_YYMM.value;//기준연도
		params.BRNO   = form1.BRNO_NM2.value; //부서
		params.MOFC   = form1.mofckbn.value;
		params.KYC_YN   = form1.kyc_yn.value;
		params.PRE_USE_YN   = form1.pre_use_yn.value;

		sendService(classID, methodID, params, doSearch2_end, doSearch2_fail);
	}

	function doSearch2_end(gridData, data) {
		GridObj2.refresh();
	    GridObj2.option("dataSource", gridData);
		overlay.hide();

		doSearch00();
	}
	function doSearch2_fail(){
		console.log("doSearch_fail");
    }



	function doSearch00() {

	    var params = new Object();
        var methodID 	= "doSearch00";
		var classID  = "RBA_50_01_02_01";

		params.pageID 	= "RBA_50_01_02_01";
		params.BAS_YYMM   = form1.BAS_YYMM.value;//기준연도
		sendService(classID, methodID, params, doSearch00_end, doSearch00_fail);

	}

	function doSearch00_end(gridData, data) {

		//alert( "step : " + data.GRID_DATA[0].ING_STEP );
		form1.ING_STEP.value = data.GRID_DATA[0].ING_STEP;
	}
	function doSearch00_fail(){
		console.log("doSearch00_fail");
    }


    function dup_chk(no, rowsData)
    {
    	var selectedRows2 = GridObj2.getSelectedRowsData();

        for (var k=0;k<selectedRows2.length;k++) {
            var selObj1 = rowsData[no];
            var selObj2 = GridObj2.getRow(k);
            if (selObj1.HGRK_BRNO == selObj2.HGRK_BRNO && selObj1.BRNO == selObj2.BRNO && selObj1.MOFC_BRN_CCD == selObj2.MOFC_BRN_CCD && selObj3.DL_SQ == selObj4.DL_SQ ) {
                return true;
            }
        }
        return false;
    }

	function remove_data(){	//	1 >> 2
		var rowsData = GridObj1.getSelectedRowsData();

        var selSize = rowsData.length;
        if (selSize==0) {
            showAlert("${msgel.getMsg('AML_10_09_01_01_004','선택된 건이 없습니다.')}", 'WARN');
            return;
        }

        var dataSource2 = GridObj2.getDataSource();
        var dataSource1 = GridObj1.getDataSource();

        //grid1에서 제거하기
        for(var i=0; i<selSize; i++){
			dataSource1.store().remove(rowsData[i]);
        }

        //grid2에 추가하기
        for(var i=0; i<selSize; i++){
        	dataSource2.store().insert(rowsData[i]);
        }

        GridObj1.clearSelection();

		dataSource1.reload();
		dataSource2.reload();
	}

	function move_data(){	// 1 << 2
		var rows2Data = GridObj2.getSelectedRowsData();

        var selSize = rows2Data.length;
        if (selSize==0) {
            showAlert("${msgel.getMsg('AML_10_09_01_01_004','선택된 건이 없습니다.')}", 'WARN');
            return;
        }


        var dataSource2 = GridObj2.getDataSource();
        var dataSource1 = GridObj1.getDataSource();

        //grid2에서 제거하기
        for(var i=0; i<selSize; i++){
			dataSource2.store().remove(rows2Data[i]);
        }

        //grid1에 추가하기
        for(var i=0; i<selSize; i++){
        	dataSource1.store().insert(rows2Data[i]);
        }

        GridObj2.clearSelection();

		dataSource1.reload();
		dataSource2.reload();
	}

	function chk_selected(GridObj) {

		var selectedRows = GridObj.getSelectedRowsData();
		var selSize      = selectedRows.length;

		for(var i = 0; i < selectedRows.length; i++) {
			var selObj; selObj = GridObj.getKeyByRowIndex(i);
			if(selSize > 0) {
				return true;
			}
		}
		return false;
	}

	function doSaveBrno(){
        /*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}',"WARN"); return;};
    	/*업무 실제 종료일자 확인  */
    	//if(!chkCommValidation("CHK_MODIFY_POSSI_REAL_DT")) {alert('${msgel.getMsg("RBA_50_02_01_011","해당 업무단계의 실제종료일이 작성되어 있어 수정 불가능 합니다.")}'); return;};

	    showConfirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}", "${msgel.getMsg('AML_20_01_01_20_012','저장')}", doSaveBrno_Action);

	}

	function doSaveBrno_Action(){
		var allData     = getDataSource(GridObj1);

		var obj = new Object();
		var methodID    = "doSaveBrno";
		var classID     = "RBA_50_01_02_01";
        obj.pageID      = "RBA_50_01_02_01";
        obj.BAS_YYMM 	= form1.BAS_YYMM.value;
        obj.gridData	= allData;

        sendService(classID, methodID, obj, doSaveBrno_end, doSaveBrno_fail);
	}

	function doSaveBrno_end(){
		setupGrids();
	}

	function doSaveBrno_fail (){
		console.log("doSaveBrno_fail");
	}

	function doDelete(){
		/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}',"WARN"); return;};
    	/*업무 실제 종료일자 확인  */
    	if(!chkCommValidation("CHK_MODIFY_POSSI_REAL_DT")) {showAlert('${msgel.getMsg("RBA_50_02_01_011","해당 업무단계의 실제종료일이 작성되어 있어 수정 불가능 합니다.")}',"WARN"); return;};

        if(rowsData.length <= 0 ){
        	showAlert("${msgel.getMsg('dataDeleteSelect','삭제할 데이타를 선택하십시오.')}","WARN");
        	return;
        }

		 //if(!confirm('<fmt:message key="AML_10_14_01_01_003" initVal="처리하시겠습니까?"/>')) return;
		 showConfirm("${msgel.getMsg('RBA_50_08_03_02_014','삭제하시겠습니까?')}", "${msgel.getMsg('AML_20_03_01_01_006','삭제')}", doDelete_Action);

	}

	function doDelete_Action(){

		var rowsData     = GridObj1.getDataSource().items();
		var obj = new Object();
        obj.pageID      = "RBA_50_01_02_01";
        obj.classID     = "RBA_50_01_02_01";
        obj.methodID    = "doDelete";
        obj.BAS_YYMM 	= form1.BAS_YYMM.value;
        obj.GRID_DATA	= rowsData;

        sendService(classID, methodID, obj, doDelete_end, doDelete_fail);

	}

	function doDelete_end(){
		setupGrids();
	}

	function doDelete_fail(){
		console.log("doDelete_fail");
	}

    function chkCommValidation(CHK_GUBN){
    	//전사업무 프로세스 관리의 코드값
    	var RBA_VALT_SMDV_C = "B01"

    	var callbackfunc = "chkMaxBasYYMM_end";
		var actionName = "com.gtone.rba.common.action.CommonValidationCheckAction";
    	var paramdata = new Object();
    	paramdata.BAS_YYMM = $("#BAS_YYMM").val();
    	paramdata.CHK_GUBN = CHK_GUBN;
    	paramdata.RBA_VALT_SMDV_C = RBA_VALT_SMDV_C;


    	if(chkValidationSync(actionName,paramdata,callbackfunc)){
    		return true;
    	}else {
    		return false;
    	}
    }

    /** 툴바 버튼 설정 */
    function makeToolbarButtonGrids(e)
    {
        var useYN  = "${outputAuth.USE_YN  }";  // 사용 유무
        var authC  = "${outputAuth.C       }";  // 추가,수정 권한
        var authD  = "${outputAuth.D       }";  // 삭제 권한
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
                        ,"onClick"   : gridID=="GTDataGrid1_Area"?setupFilter1:setupFilter2
                 }
            });
        }
    }

    function setupFilter1(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	setupGridFilter2(gridArrs, FLAG);
    }

    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridArrs[1] = gridObj;
    	setupGridFilter2(gridArrs, FLAG);
    }


 // 확정/취소
    function doConfirm() {

	    //alert( "call doConfirm");

		//alert( "step : [" + form1.ING_STEP.value + "]");

    	if(form1.ING_STEP.value == "10"){

            showConfirm("${msgel.getMsg('RBA_50_01_01_006','확정을 하시겠습니까?')}", "확정",function(){
                     var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = form1.BAS_YYMM.value;
                     params.FIX_YN = "1";
                     params.ING_STEP = "20";  //confirmState
                     params.RBA_VALT_SMDV_C = "1.2";

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);

            });


        }else{
        	if(form1.ING_STEP.value == "20"){

	            showConfirm("${msgel.getMsg('RBA_50_01_01_007','확정을 취소하시겠습니까?')}", "취소",function(){
	            	 $("button[id='btn_04']").prop('disabled', true);

	                 var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = form1.BAS_YYMM.value;
                     params.FIX_YN = "0";
                     params.ING_STEP = "10";  //confirmState
                     params.RBA_VALT_SMDV_C = "1.2";

                     sendService(classID, methodID, params, doSearch_end, doSearch_end);
	            });
        	}else {
        		// 일정정보관리 확정단계에서만 취소 할수 있습니다. ==> 라고 수정이 필요
        		if( form1.ING_STEP.value > "20") {
        			showAlert('${msgel.getMsg("RBA_50_01_01_01_113","이후 확정된 STEP을 취소후 진행 할수 있습니다.")}','WARN');
        		} else {
        			showAlert('${msgel.getMsg("RBA_50_01_01_01_114","이전 STEP이 확정된 후 진행 할수 있습니다.")}','WARN');
				}
        		
           		return;
            }
        }
    }

 // 확정/취소 end
    function doConfirm_end() {
        //$("button[id='btn_04']").prop('disabled', false);
        doSearch();
    }

</script>

<style>
.table-title * {
    margin-left : 0;
}
</style>
<body>
<form name="form1" method="post"  onkeydown="doEnterEvent('doSearch01');">
<input type="hidden" name="pageID" >
<input type="hidden" name="classID" >
<input type="hidden" name="methodID" >
<input type="hidden" name="ROLE_ID" value="${ROLE_ID}">
<input type="hidden" name="BDPT_CD" value="${BDPT_CD}">
<input type="hidden" name="AML_LOGIN_ID" value="${ID}">
    <div class="inquiry-table" id='condBox1'>
        <div class="table-row">
            <div class="table-cell">
	            ${condel.getLabel("RBA_50_10_01_01_001","평가회차")}
	            <div class="content">
					${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'setupGrids()')}
				</div>
	        </div>
	    </div>
	    	<div class="table-cell">
	    		${condel.getLabel("RBA_50_01_02_01_008","본사/지점구분")}
		    	<div class="content">
					<select name="mofckbn" id="mofckbn" class="dropdown" onChange=''><!--onChange='ccdChange(this)'  -->
		                <%-- <AMLTag:combobox_option code="A029"  initValue="9" firstComboWord='' /> --%>
		                ${condel.getSelectOption('','M043','9','ALL','ALL')}
		            </select>
				</div>
	    		${condel.getLabel("RBA_50_05_03_01_005","통제부서여부")}
	    		<div class="content">
					<select name="aml_tj_brno_yn" id="aml_tj_brno_yn" class="dropdown" onChange=''><!--onChange='ccdChange(this)'  -->
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='1' >Y</option>
		                <option value='0' >N</option>
		            </select>
				</div>

				${condel.getLabel("RBA_50_01_02_01_010","최근1년 KYC수행 여부")}
	    		<div class="content">
					<select name="kyc_yn" id="kyc_yn" class="dropdown" onChange=''><!--onChange='ccdChange(this)'  -->
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='Y' >Y</option>
		                <option value='N' >N</option>
		            </select>
				</div>

				${condel.getLabel("RBA_50_01_02_01_011","직전회차 여부")}
	    		<div class="content">
					<select name="pre_use_yn" id="pre_use_yn" class="dropdown" onChange=''><!--onChange='ccdChange(this)'  -->
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='Y' >Y</option>
		                <option value='N' >N</option>
		            </select>
				</div>
            </div>
	</div>
	<div class="button-area" style="text-align:right">
		<input type="text" class="cond-input-text" name="ING_STEP" id="ING_STEP" value="${ING_STEP}" style="border: 0px;background-color:white;color:white" readonly="readonly"></input>
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn5_035", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSaveBrno", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"RBA001", defaultValue:"확정/취소", mode:"U", function:"doConfirm", cssClass:"btn-36"}')}
		<%-- ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-minus"}')} --%>
	</div>
	<div class="tab-content-bottom">
		<div class="cont-area3" style="padding-top:0px;">
			<div class="cont-area3-left">
				<div class="linear-warp">
					<h4 class="tab-content-title">${msgel.getMsg('RBA_50_01_02_003','미등록지점')}</h4>
					<div class="linear-table" style="margin-bottom:8px;">
						<div class="table-row">
							<div class="table-cell" style="width:100%;">
								<div class="title" style="min-width:160px;">
									<div class="txt">${msgel.getMsg('RBA_50_01_02_01_009','부점코드(명)')}</div>
								</div>
								<div class="content"><input name="BRNO_NM2" type="text" value="" class="cond-input-text" size="30" /></div>
								<div class="button-area" style="padding-top: 0px; width:100%;">
									${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch2", cssClass:"btn-36 filled"}')}
								</div>
							</div>
						</div>
					</div>
				</div>

				<div id="GTDataGrid2_Area"></div>
			</div>
			<div class="arrow-area" style="width:3vw; background-color: #fff; margin: 293px 0px;" align="center">
						<img src="<c:url value='/'/>Package/design/images/icons/Button_Right.png" style="display:block;" onclick="move_data()"/></button>
				<br />
				<br />
						<img src="<c:url value='/'/>Package/design/images/icons/Button_left.png" style="display:block;" onclick="remove_data()"/></button>

			</div>
			<div class="cont-area3-right">


				<div class="linear-warp">
					<h4 class="tab-content-title">${msgel.getMsg('RBA_50_01_02_002','등록지점')}</h4>
					<div class="linear-table" style="margin-bottom:8px;">
						<div class="table-row">
							<div class="table-cell" style="width:100%;">
								<div class="title" style="min-width:160px;">
									<div class="txt">${msgel.getMsg('RBA_50_01_02_01_009','부점코드(명)')}</div>
								</div>
								<div class="content"><input name="BRNO_NM1" type="text" value="" class="cond-input-text" size="30" /></div>
								<div class="button-area" style="padding-top: 0px; width:100%;">
									${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
								</div>
							</div>
						</div>

					</div>
				</div>
				<div id="GTDataGrid1_Area"></div>
			</div>
		</div>
	</div>
</form>
</body>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />