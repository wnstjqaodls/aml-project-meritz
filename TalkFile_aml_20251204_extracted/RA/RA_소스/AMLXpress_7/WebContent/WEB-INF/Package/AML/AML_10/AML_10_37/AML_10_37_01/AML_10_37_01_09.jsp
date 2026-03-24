<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : AML_10_37_01_09.jsp
* Description     : 위험평가 기준관리 파일업로드
* Group           : GTONE, R&D센터/개발2본부
* Author          :
* Since           : 2025-06-30
********************************************************************************************************************************************
--%>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
  String RA_ITEM_CD     = Util.nvl(request.getParameter("RA_ITEM_CD")   );
  String ROLEID         = sessionAML.getsAML_ROLE_ID();

  request.setAttribute("RA_ITEM_CD"    , RA_ITEM_CD    );
  request.setAttribute("ROLEID"        , ROLEID        );
  
  String uploadFileX = PropertyService.getInstance().getProperty("aml.config","upload.file.x");
  request.setAttribute("uploadFileX",uploadFileX);
%>
<style>
.tab-content-bottom .row {
    padding-bottom: 1px;
}
.basic-table .title {
    background-color: #eff1f5;
    padding: 12px 12px 12px 16px;
    font-family: SpoqR;
    font-size: 14px;
    line-height: 2px;
    color: #444;
    letter-spacing: -0.28px;
}
</style>
<script>

    var GridObj1      = null;
    var classID       = "AML_10_37_01_06";
    var pageID        = "AML_10_37_01_09";
    var overlay       = new Overlay();
	var RA_ITEM_CD    = "${RA_ITEM_CD}";
	var ROLEID        = "${ROLEID}";

    $(document).ready(function(){
    	
    	if(RA_ITEM_CD == "I001") {
    		setupGrids();
    	}else if(RA_ITEM_CD == "I002") {
    		setupGrids2();    		
    	}else if(RA_ITEM_CD == "I003") {
    		setupGrids3();
    	}
    	doSearch();
    });

    function doSearch()
    {
    	var classID           = "AML_10_37_01_06";
        var methodID          = "getSearch";
        var params            = new Object();
        params.pageID         = pageID;
        params.RA_ITEM_CD     = RA_ITEM_CD;
        sendService(classID, methodID, params, doSearch_success, doSearch_success);
    }

    function doSearch_success(gridData, data) {
    	try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }

    function doSaveRe() {
		if(RA_ITEM_CD == "I001") {
			doSave();
		}else if(RA_ITEM_CD == "I002") {
			doSave2();
		}else if(RA_ITEM_CD == "I003") {
			doSave3();
		}
    }
    
    function doSave() {
    	GridObj1.saveEditData();
    	
    	showConfirm('${msgel.getMsg("AML_10_02_01_01_002","저장 하시겠습니까?")}', "저장",function(){
    	var allRowsData       = getDataSource(GridObj1);
    	var classID		      = "AML_10_37_01_06";
        var methodID	      = "doSave";
        var params            = new Object();
        overlay.show(true, true);
        params.RA_ITEM_CD     = RA_ITEM_CD;
        params.gridData       = allRowsData;
    	sendService(classID, methodID, params, doSave_end, doSearch_fail);
    	});
    }
    
    function doSave2() {
    	GridObj1.saveEditData();
    	showConfirm('${msgel.getMsg("AML_10_02_01_01_002","저장 하시겠습니까?")}', "저장",function(){
    	var allRowsData       = getDataSource(GridObj1);
    	var classID		      = "AML_10_37_01_06";
        var methodID	      = "doSave2";
        var params            = new Object();
        overlay.show(true, true);
        params.RA_ITEM_CD     = RA_ITEM_CD;
        params.gridData       = allRowsData;
    	sendService(classID, methodID, params, doSave_end, doSearch_fail);
    	});
    }
    
    function doSave3() {
    	GridObj1.saveEditData();
    	//showConfirm('${msgel.getMsg("AML_10_02_01_01_002","저장 하시겠습니까?")}', "저장",function(){
    	var allRowsData       = getDataSource(GridObj1);
    	
    	//var gridData = GridObj1.getSelectedRowsData();
    	var classID		      = "AML_10_37_01_06";
        var methodID	      = "doSave3";
        var params            = new Object();
        overlay.show(true, true);
        params.RA_ITEM_CD     = RA_ITEM_CD;
        params.classID        = classID;
        params.methodID       = methodID;
        params.gridData       = allRowsData;
        
        var maxcnt = 300;
        var savecnt = Math.ceil(allRowsData.length / maxcnt);
        var totalcnt = allRowsData.length;
        var gridDataArr = [];
               
        for( var ii = 0; ii < savecnt; ii++) {
        	gridDataArr[ii] = allRowsData.splice(0, allRowsData.length < maxcnt? allRowsData.length:maxcnt);
        }
        
        var i = 0;
        (window.doSaveCont = function() {
        	params['GRID_DATA'] = gridDataArr[i];

            jQuery.ajax({
                type        : 'POST'
               ,url         : '/JSONServlet?Action@@@=com.gtone.aml.common.action.DispatcherAction'
               ,dataType    : 'json'
               ,processData : true
               ,async       : true
               ,data        : params
               ,success     : function(data) {
            	   if(data&&data.PARAM_DATA[1].VALUE=="00001"){
                       showAlert(data.PARAM_DATA[2].VALUE, "ERR");
                       overlay.hide();
                       return;
                   }
                   if(++i==savecnt) {
                       doSave_end(data);
                   } else {
                       window.doSaveCont();
                   }
                }
               ,error       : function(xhr, textStatus) {
                    alert("Error" + textStatus);
                    overlay.hide();
                }
            })
        })();
        
        
        
        
        
        
    	//sendService(classID, methodID, params, doSave_end, doSearch_fail);
    	//});
    }

    function doSave_end() {
		overlay.hide();
    	//doSearch();
    	opener.doSearch2();
	}
    function doSearch_fail(){ overlay.hide(); }

    function setupGrids() {
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
				elementAttr: { class: "grid-table-type" },
				height          :  "calc(85vh - 10px)",
			    hoverStateEnabled : true,
			    wordWrapEnabled : false,
			    allowColumnResizing : true,
			    columnAutoWidth : true,
			    allowColumnReordering : true,
			    cacheEnabled : false,
			    cellHintEnabled : true,
			    showBorders : true,
			    showColumnLines : true,
			    showRowLines : true,
			    loadPanel : { enabled: false },
			    sorting: { mode: "multiple"},
			    remoteOperations : {filtering:false, grouping:false, paging:false, sorting:false, summary:false},
				editing: {
	 			    mode: "batch",
				 	allowUpdating: false,
					allowAdding: false,
	                allowDeleting: false
				},
			    filterRow: { visible: false },
			    rowAlternationEnabled : true,
			    pager: {visible: true, showNavigationButtons: true, showInfo: true},
			    paging: {enabled : true, pageSize : 50},
			    searchPanel: {visible: false, width: 250},
			    selection: {allowSelectAll : false , mode : "single", showCheckBoxesMode : "none"},
			    columnResizingMode : "widget",
			    scrolling   : {
			         mode: "standard"
			    },
			    columns: [ 
	     	        {dataField: "RA_ITEM_CD"			,caption: "위험평가항목코드"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	        {dataField: "RA_ITEM_CODE"			,caption: "상세코드"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	      	{dataField: "RA_ITEM_NM"			,caption: "상세코드 내용"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	    	{dataField: "ABS_HRSK_YN"			,caption: "당연EDD여부"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	  		{dataField: "RA_ITEM_SCR"			,caption: "위험점수"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      			{dataField: "FATF_BLACK_LIST_YN"	,caption: "FATF Black list"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	  	    {dataField: "FATF_GREY_LIST_YN"		,caption: "FATF Grey list"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "FINCEN_LIST_YN"		,caption: "FinCEN 제재국가"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "UN_SANTIONS_YN"		,caption: "UN 제재국가"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "OFAC_SANTIONS_YN"		,caption: "OFAC 제재국가"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "OECD_YN"				,caption: "OECD"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "TICPI_CPI_STA"			,caption: "TI_기준점수"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      			{dataField: "TICPI_CPI_IDX"			,caption: "TI_CPI_IDX"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "TICPI_CPI_IDX_SCR"		,caption: "TI"						,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      			{dataField: "INCRS_PROD_STA"		,caption: "INCRS_기준점수"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      			{dataField: "INCRS_PROD_YN"			,caption: "INCRS 마약생산유통국가"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "INCRS_CHEM_STA"		,caption: "INCRS_기준점수"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      			{dataField: "INCRS_CHEM_YN"			,caption: "INCRS 마약밀매수익금거래국가"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "EU_SANTIONS_YN"		,caption: "EU 제재국가"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "EU_HRT_YN"				,caption: "EU 고위험 제3국"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "BASEL_RIK_STA"			,caption: "Basel_기준점수"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      			{dataField: "BASEL_RIK_IDX"			,caption: "Basel_평균"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "BASEL_RIK_IDX_SCR"		,caption: "Basel"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false}
	      	    ]
		}).dxDataGrid("instance");
    }
    
    function setupGrids2() {
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
				elementAttr: { class: "grid-table-type" },
				height          :  "calc(85vh - 10px)",
			    hoverStateEnabled : true,
			    wordWrapEnabled : false,
			    allowColumnResizing : true,
			    columnAutoWidth : true,
			    allowColumnReordering : true,
			    cacheEnabled : false,
			    cellHintEnabled : true,
			    showBorders : true,
			    showColumnLines : true,
			    showRowLines : true,
			    loadPanel : { enabled: false },
			    sorting: { mode: "multiple"},
			    remoteOperations : {filtering:false, grouping:false, paging:false, sorting:false, summary:false},
				editing: {
	 			    mode: "batch",
				 	allowUpdating: false,
					allowAdding: false,
	                allowDeleting: false
				},
			    filterRow: { visible: false },
			    rowAlternationEnabled : true,
			    pager: {visible: true, showNavigationButtons: true, showInfo: true},
			    paging: {enabled : true, pageSize : 50},
			    searchPanel: {visible: false, width: 250},
			    selection: {allowSelectAll : false , mode : "single", showCheckBoxesMode : "none"},
			    columnResizingMode : "widget",
			    scrolling   : {
			         mode: "standard"
			    },
			    columns: [
	     	        {dataField: "RA_ITEM_CD"			,caption: "위험평가항목코드"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	        {dataField: "RA_ITEM_CODE"			,caption: "상세코드"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	      	{dataField: "RA_ITEM_NM"			,caption: "상세코드 내용"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	    	{dataField: "ABS_HRSK_YN"			,caption: "당연EDD여부"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	  		{dataField: "RA_ITEM_SCR"			,caption: "위험점수"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      			{dataField: "RA_IDJOB_YN1"			,caption: "법률,회계,세무 관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	  	    {dataField: "RA_IDJOB_YN2"			,caption: "투자자문 관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_YN3"			,caption: "부동산 관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_YN4"			,caption: "오락,도박,스포츠관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_YN5"			,caption: "대부업자,환전상"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_YN6"			,caption: "귀금속,예술품,골동품 판매상"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_STA_YN1"		,caption: "주류 도소매업,유흥주점업"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_STA_YN2"		,caption: "의료,제약관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_STA_YN3"		,caption: "건설산업"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_STA_YN4"		,caption: "무기,방위산업"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_STA_YN5"		,caption: "채광,금속,고물상"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_YN7"			,caption: "가상자산사업 의심"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_IDJOB_STA_YN6"		,caption: "무직자"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false}
	      	    ]
		}).dxDataGrid("instance");
    }
    
    function setupGrids3() {
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
				elementAttr: { class: "grid-table-type" },
				height          :  "calc(85vh - 10px)",
			    hoverStateEnabled : true,
			    wordWrapEnabled : false,
			    allowColumnResizing : true,
			    columnAutoWidth : true,
			    allowColumnReordering : true,
			    cacheEnabled : false,
			    cellHintEnabled : true,
			    showBorders : true,
			    showColumnLines : true,
			    showRowLines : true,
			    loadPanel : { enabled: false },
			    sorting: { mode: "multiple"},
			    remoteOperations : {filtering:false, grouping:false, paging:false, sorting:false, summary:false},
				editing: {
	 			    mode: "batch",
				 	allowUpdating: false,
					allowAdding: false,
	                allowDeleting: false
				},
			    filterRow: { visible: false },
			    rowAlternationEnabled : true,
			    pager: {visible: true, showNavigationButtons: true, showInfo: true},
			    paging: {enabled : true, pageSize : 50},
			    searchPanel: {visible: false, width: 250},
			    selection: {allowSelectAll : false , mode : "single", showCheckBoxesMode : "none"},
			    columnResizingMode : "widget",
			    scrolling   : {
			         mode: "standard"
			    },
			    columns: [
	     	        {dataField: "RA_ITEM_CD"			,caption: "위험평가항목코드"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	        {dataField: "RA_ITEM_CODE"			,caption: "상세코드"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	      	{dataField: "RA_ITEM_NM"			,caption: "상세코드 내용"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	    	{dataField: "ABS_HRSK_YN"			,caption: "당연EDD여부"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	  		{dataField: "RA_ITEM_SCR"			,caption: "위험점수"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      			{dataField: "RA_CORJOB_YN1"			,caption: "법률,회계,세무 관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	  	    {dataField: "RA_CORJOB_YN2"			,caption: "투자자문 관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_YN3"			,caption: "부동산 관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_YN4"			,caption: "오락,도박,스포츠관련"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_YN5"			,caption: "카지노"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_YN6"			,caption: "대부업자,환전상,소액해외송급업자"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_YN7"			,caption: "귀금속,예술품,골동품 판매상"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_STA_YN1"		,caption: "주류 도소매업,유흥주점업"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_STA_YN2"		,caption: "의료,제약관련"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_STA_YN3"		,caption: "건설산업"					,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_STA_YN4"		,caption: "무기,방위산업"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_STA_YN5"		,caption: "채광,금속,고물상"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      			{dataField: "RA_CORJOB_YN8"			,caption: "가상자산사업 의심"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false}
	      	    ]
		}).dxDataGrid("instance");
    }

    
    
    function popupClose() {
        self.close();
    }

    function downloadFile()
    {   
        //gtTemplateDownloadFile("form3","RA_NTN_TemplateFile.xlsx","RA_NTN_TemplateFile.xlsx","TEMPLATE","/RA");
    	var workbook = new ExcelJS.Workbook();
    	var worksheet = workbook.addWorksheet('Sheet1');
    	DevExpress.excelExporter.exportDataGrid({
    		component: GridObj1,
    		worksheet: worksheet,
    		autoFilterEnabled: true,
    	}).then(function() {
    		workbook.xlsx.writeBuffer().then(function(buffer) {
    			saveAs(new Blob([buffer], { type: 'application/octet-stream' }), '${pageTitle}.xlsx');
    		});
    	});
    }
    
    function clearGridObj1() {
		GridObj1.cancelEditData();
		GridObj1.clearSelection();
		GridObj1.option('dataSource', []);
	}
    
    function raFileUpload() {
    	clearGridObj1();
    	var allowedFileExtensions = "${uploadFileX}";
    	var fileUploader = gtFileUploader("raListFile",allowedFileExtensions,doSubmit_end);
    }

    function doSubmit_end(fileData) {
    	overlay.show();
        var captionList = new Array();
        var gridOrg; gridOrg = $('#GTDataGrid1_Area').dxDataGrid('instance');
        for (var i=0; i < gridOrg.columnCount(); i++){
            var input = new Object();
            input.dataField = gridOrg.columnOption(i).dataField;
            input.caption   = gridOrg.columnOption(i).caption;
            captionList.push(input);
        }

        var fileValue = fileData.storedFileNm;


		var params = new Object();
		params.captionName = JSON.stringify(captionList);
		params.fileName = fileValue;
		params.actionName = "com.gtone.aml.server.AML_10.AML_10_37.AML_10_37_01.AML_10_37_01_01_Action";
		sendService(null, null, params, doUpload_Success, doUpload_fail);
    }

    function doUpload_Success(dataSource) {
    	overlay.hide();
    	dataSource = dataSource.filter(function(item) {
    	    return item.RA_ITEM_CD !== null && item.RA_ITEM_CD !== "" && item.RA_ITEM_CD !== undefined;
    	});
    	//setButtonOneChangeStatus(false, false, true, true, true);

    	GridObj1.option("dataSource", dataSource);
    	GridObj1.refresh();
    }

    function doUpload_fail(dataSource) {
        overlay.hide();
    }

</script>


<style>
	.basic-table .title {
		/* min-width: 130px; */
		text-align: center;
	}

}
</style>
<form name="form3" id="form3">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID"> 
	<input type="hidden" name="FILE_SER">
	<input type="hidden" name="ATTCH_FILE_NO">
	<input type="hidden" name="downType" id="downType">   
	<input type="hidden" name="downFileName" id="downFileName">  
	<input type="hidden" name="orgFileName" id="orgFileName">    
	<input type="hidden" name="downFilePath" id="downFilePath">    
</form>

<form name="form1" method="post" onsubmit="return false;">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	<input type="hidden" name="RA_SN_CCD">
	<input type="hidden" name="RA_SEQ">
	<input type="hidden" name="RA_REF_SN_CCD">
	<input type="hidden" name="RA_GRD_CD">
	<input type="hidden" name="mode"     id = "mode"    >
    <input type="hidden" name="gbn"      id = "gbn"     >
    <input type="text"   name="temp"     id = "temp" style="display: none;">
	<input type="hidden" name="contentFile" id="contentFile">
    <input type="hidden" name="excelData"   id="excelData"  >



<div class="button-area" style="float:right"> 
 		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"templateDownload", defaultValue:"템플릿다운로드", mode:"C", function:"downloadFile", cssClass:"btn-36 outlined"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"uploadBtn", defaultValue:"파일 Upload", mode:"U", function:"raFileUpload", cssClass:"btn-36 upload"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSaveRe", cssClass:"btn-36"}')}
    	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"popupClose", cssClass:"btn-36"}')}
</div>
 
<div class="tab-content-bottom" style="clear: both;">
	<div class="panel-footer" >
        <div id = "GTDataGrid1_Area" style="padding-top:8px"></div>
    </div>
</div>
<div id="raListFile" style="display:none;" />

</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />
