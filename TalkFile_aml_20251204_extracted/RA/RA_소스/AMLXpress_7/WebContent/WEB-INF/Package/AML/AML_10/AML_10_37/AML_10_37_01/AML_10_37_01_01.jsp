<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : AML_10_37_01_01.jsp
* Description     : 위험평가 기준관리
* Group           : GTONE, R&D센터/개발2본부
* Author          :
* Since           : 2024-04-29
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<%
	String stDate = jspeed.base.util.DateHelper.currentTime(PropertyService.getInstance().getProperty("aml.config","dateFormat"));
	request.setAttribute("stDate",stDate);

    String RA_APPR_YN = PropertyService.getInstance().getProperty("aml.config", "RA_APPR_YN");
    request.setAttribute("RA_APPR_YN", RA_APPR_YN);

    // S 결재정보가져오기
    DataObj inputApr = new DataObj();
    inputApr.put("CD","S104");
    inputApr.put("GUBUN","RA2");
    com.gtone.aml.basic.common.data.DataObj obj = null;

    try{
         obj = com.gtone.aml.dao.common.MDaoUtilSingle.getData("AML_APR_YN",inputApr);
    }catch(AMLException e){
        Log.logAML(Log.ERROR, e);
    }

    // 사용여부
    String APP_YN = obj.getText("APP_YN");
    request.setAttribute("APP_YN",APP_YN);

    // 최초결재자ID
    String FIRST_APP_ID = obj.getText("FIRST_APP_ID");

    String[] REPLACE_FIRST_APP_ID = FIRST_APP_ID.split("-");
    String FIRST_SNO = "";
    for (int i=0; i<REPLACE_FIRST_APP_ID.length; i++) {
        if(i==0){
            FIRST_APP_ID = REPLACE_FIRST_APP_ID[0];
            System.out.println("FIRST_APP_ID:"+FIRST_APP_ID);
            request.setAttribute("FIRST_APP_ID",FIRST_APP_ID);

        }else if(i==1){
            FIRST_SNO = REPLACE_FIRST_APP_ID[1];
            System.out.println("FIRST_SNO:"+FIRST_SNO);
            request.setAttribute("FIRST_SNO",FIRST_SNO);
        }
    }
    //System.out.println("FIRST_SNO:"+FIRST_SNO);
    // 세션결재자정보

	String USERNAME   = sessionAML.getsAML_USER_NAME();
    String BDPTCDNAME = sessionAML.getsAML_BDPT_CD_NAME();
    String BDPTCD     = sessionAML.getsAML_BDPT_CD();
    String ROLEID     = sessionAML.getsAML_ROLE_ID();
    String ROLENAME   = sessionAML.getsAML_ROLE_NAME();
    String RANKID     = sessionAML.getsAML_RANK_ID();

    request.setAttribute("USERNAME",USERNAME);
    request.setAttribute("BDPTCDNAME",BDPTCDNAME);
    request.setAttribute("BDPTCD",BDPTCD);
    request.setAttribute("ROLEID",ROLEID);
    request.setAttribute("ROLENAME",ROLENAME);
    request.setAttribute("RANKID",RANKID);
    
    String uploadFileX = PropertyService.getInstance().getProperty("aml.config","upload.file.x");
	request.setAttribute("uploadFileX",uploadFileX);
%>
<style>
.tree-conformation-area .t01-menu a nobr {
    font-family: SpoqR;
    font-size: 12px;
    line-height: 22px;
    color: #444;
    letter-spacing: -0.32px;
}
</style>
<script>

    var GridObj1;
    var GridObj2;
    var overlay = new Overlay();
    var classID  = "AML_10_37_01_01";
    var pageID  = "AML_10_37_01_01";
    var curRow  = -1;
    var clickedRowIndex;
    var USERNAME   = "${USERNAME}";
    var BDPTCDNAME = "${BDPTCDNAME}";
    var BDPTCD     = "${BDPTCD}";
    var ROLEID     = "${ROLEID}";
    var ROLENAME   = "${ROLENAME}";
    var stDate     = "${stDate}";
    var RANKID     = "${RANKID}";

    // Initialize
    $(document).ready(function(){
    	$("#GTDataGrid2_Area").find(".dx-toolbar-after").hide();
    	setupGrids1();
        setupGrids2();
        
        $("#RISK_ELMT_CDNT").on("change", function(){
  		  $("#RISK_ELMT_CD2 option:not(:eq(0))").remove();
  		  var params = new Object();
  		  if($(this).val() == 'R10601') {
  			params.NTNGUBUN = "YN"
  		  }else if($(this).val() == 'R10901') {
  			params.NTNGUBUN = "NN"
  		  }else {
  			params.NTNGUBUN = "YY"
  			params.CD = "N003";
  		  }
  	      sendService("AML_10_37_01_01", "getCodeSearch", params, doCdSearch_End, doCdSearch_End); 
  	  });
        
        $("#RISK_ELMT_CDIND").on("change", function(){      	
  		  $("#RISK_ELMT_CD2 option:not(:eq(0))").remove();
  		  
  		  var params = new Object();
  		  params.NTNGUBUN = "YY"
  		  params.CD = "N003";
  	      sendService("AML_10_37_01_01", "getCodeSearch", params, doCdSearch_End, doCdSearch_End); 
  	  });
        
        $("#RISK_ELMT_CDCOR").on("change", function(){
  		  $("#RISK_ELMT_CD2 option:not(:eq(0))").remove();
  		  
  		  var params = new Object();
  		  params.NTNGUBUN = "YY"
          params.CD = "N003";
  	      sendService("AML_10_37_01_01", "getCodeSearch", params, doCdSearch_End, doCdSearch_End); 
  	  });  
        
        doSearch();
    });
 
    function doCdSearch_End(gridData, data){
 	  $.each(gridData, function(idx, val) {
		  $("#RISK_ELMT_CD2").append('<option class="dropdown-option" value="'+ val.CD +'">'+ val.CD_NM +'</option>');
	   });
   }
    
    // 그리드 초기화 함수 셋업
    function setupGrids1(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(90vh - 150px)",
			 hoverStateEnabled      : true
	     	   ,wordWrapEnabled        : false
	     	   ,allowColumnResizing     : true
	     	   ,columnAutoWidth        : true
	     	   ,allowColumnReordering : true
	     	   ,columnResizingMode    : "widget"
	     	   ,cacheEnabled             : false
	     	   ,cellHintEnabled           : true
	     	   ,showBorders              : true
	     	   ,showColumnLines        : true
	     	   ,showRowLines            : true
	     	   ,loadPanel                  : { enabled: false }
    		   ,editing: {mode : "batch", allowUpdating: false, allowAdding  : false, allowDeleting: false }
        	   ,export : {allowExportSelectedData: true,enabled: true,excelFilterEnabled: true}
	     	   ,onExporting: function (e) {
					var workbook = new ExcelJS.Workbook();
					var worksheet = workbook.addWorksheet("Sheet1");
				    DevExpress.excelExporter.exportDataGrid({
				        component: e.component,
				        worksheet : worksheet,
				        autoFilterEnabled: true,
				    }).then(function() {
				        workbook.xlsx.writeBuffer().then(function(buffer) {
				            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "ra_item.xlsx");
				        });
				    });
				    e.cancel = true;
	            }
	     	   ,filterRow: { visible: false }
	     	   ,hoverStateEnabled: true
	     	   ,loadPanel: { enabled: false }
	     	   ,pager: {
		   	    	visible: true
		   	    	,showNavigationButtons: true
		   	    	,showInfo: true
		   	    }
		   	   ,paging: {
		   	    	enabled : true
		   	    	,pageSize : 20
		   	    }
	     	   ,remoteOperations : {filtering: true,grouping: true,paging: true,sorting: true,summary: true}
	     	   ,rowAlternationEnabled : true
	     	   ,scrolling : {mode: "standard",preloadEnabled: false}
	     	   ,searchPanel : {visible : false,width: 250}
	     	   ,selection: {
	     	        allowSelectAll: true
	     	       ,deferred: false
	     	       ,mode: 'single'  /* none, single, multiple                       */
	     	       ,selectAllMode: 'allPages'      /* 'page' | 'allPages'                          */
	     	       ,showCheckBoxesMode: 'always'    /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
	     	    }
	     	   ,showBorders     : true
	     	   ,showColumnLines : true
	     	   ,showRowLines    : true
	     	   ,sorting         : { mode: "single"}
	     	   ,wordWrapEnabled : false
	     	   ,columns: [
	     	        {dataField: "RA_ITEM_CD",caption: "위험평가항목코드",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false, visible : false},
	      	        {dataField: "ITEM_NM",caption: "${msgel.getMsg('AML_10_36_01_01_003','위험평가항목명')}",alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	        {dataField: "INTV_VAL_YN",caption: "구간여부",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false, visible : false},
	      	        {dataField: "SN_CCD_NM_ING",caption: "SN_CCD_NM_ING",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false, visible : false},
	      	        {dataField: "SN_CCD_NM",caption: "SN_CCD_NM",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false, visible : false}
	      	    ]
	      	    // events
		       ,"onRowInserting" : function(e) {

	     	    }
	     	   ,onCellClick: function(e){
	     		   if(e.rowType != "header" && e.rowType != "filter"){
	     			  Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
	     		   }

                }
	  	}).dxDataGrid("instance");
    }

 	// 국가 그리드 초기화 함수 셋업
    function setupGrids2(){
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
              width		 			 : "100%"
             ,height		 		 : "calc(70vh - 150px)"
 			 ,elementAttr: { class: "grid-table-type" }
             ,hoverStateEnabled      : true
             ,wordWrapEnabled        : false
             ,allowColumnResizing    : true
             ,columnAutoWidth        : true 
             ,allowColumnReordering  : true
             ,columnResizingMode     :'widget'  /* "widget" "nextColumn" */
             ,cacheEnabled           : false
             ,cellHintEnabled        : true
             ,showBorders            : true
             ,showColumnLines        : true
             ,showRowLines           : true
 		    //,onToolbarPreparing   : makeToolbarButtonGrids
             ,loadPanel              : { enabled: false }
             , export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
             ,sorting         		: { mode: "multiple"}
             ,remoteOperations		: {
                  filtering   : true
                 ,grouping    : true
                 ,paging      : true
                 ,sorting     : true
                 ,summary     : true
              }
             ,editing 				: {
                  mode            : 'batch'
                 ,allowUpdating   : false
                 ,allowAdding     : false
              }
             ,filterRow              : { visible: false }
             ,rowAlternationEnabled  : true
             ,columnFixing           : { enabled: true }
             ,pager: {
 	   	    	visible: false
 	   	    	,showNavigationButtons: true
 	   	    	,showInfo: true
 	   	    }
 	   	    ,paging: {
 	   	    	enabled : false
 	   	    	,pageSize : 20
 	   	    }
 		   	,scrolling : {
                 mode            : "virtual" /*standard*/
                ,preloadEnabled  : false
             }
             ,searchPanel: {visible : false,width   : 250}
             ,selection: {
                  allowSelectAll      : true
                 ,deferred            : false
                 ,mode                : 'single'    /* none, single, multiple                       */
                 ,selectAllMode       : 'allPages'    /* 'page' | 'allPages'                          */
                 ,showCheckBoxesMode  : 'onClick'      /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
              }
               ,columns: [
            	    {dataField: "SEQ"				,caption: "No."					,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "50px"},
            	    {dataField: "RA_ITEM_CD"		,caption: "위험평가항목코드"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false,	fixed:true},
            	    {dataField: "RA_ITEM_CODE"		,caption: "상세코드"				,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "70px"},
                    {dataField: "RA_ITEM_NM"		,caption: "상세코드 내용"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "200px"},
                    {dataField: "ABS_HRSK_YN"		,caption: "당연EDD여부"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "90px"},
                    {dataField: "RA_ITEM_SCR"		,caption: "위험점수"				,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "70px"},
                    {caption: "재계산 결과",
                    	columns : [
                    		{dataField: "RECAL_ABS_HRSK_YN"	,caption: "당연EDD여부"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true, "width": "90px"},
                    		{dataField: "RECAL_RA_ITEM_SCR"	,caption: "위험점수"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, "width": "70px"},
                    		{dataField: "RECAL_RA_SCR"		,caption: "변동 구분"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true, "width": "70px"},
                    	],alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: true
                   	},
                    {caption: "위험요소",
                   		columns : [
                   			{caption:"FATF Black list",
                   				columns:[
                   					{dataField: "FATF_BLACK_LIST_YN"	,caption: "당연EDD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, //
                       			],
                   			},
                   			{caption:"FATF Grey list",
                   				columns:[
                   					{dataField: "FATF_GREY_LIST_YN"		,caption: "당연EDD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, //
                       			],
                   			},
                   			{caption:"FinCEN 제재국가",
                   				columns:[
                   					{dataField: "FINCEN_LIST_YN"		,caption: "당연EDD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   			{caption:"UN 제재국가",
                   				columns:[
                   					{dataField: "UN_SANTIONS_YN"		,caption: "당연EDD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   			{caption:"OFAC 제재국가",
                   				columns:[
                   					{dataField: "OFAC_SANTIONS_YN"		,caption: "당연EDD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   			{caption:"OECD",
                   				columns:[
                   					{dataField: "OECD_YN"				,caption: "당연EDD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   			{caption:"TI",
                   				columns:[
                   					{dataField: "TICPI_CPI_IDX_SCR"		,caption: "1"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   			{caption:"INCRS 마약생산유통국가",
                   				columns:[
                   					{dataField: "INCRS_PROD_YN"			,caption: "1"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   			{caption:"INCRS 마약밀매수익금거래국가",
                   				columns:[
                   					{dataField: "INCRS_CHEM_YN"			 ,caption: "1"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, //
                       			],
                   			},
                   			{caption:"EU 제재국가",
                   				columns:[
                   					{dataField: "EU_SANTIONS_YN"		,caption: "당연EDD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   			{caption:"EU 고위험 제3국",
                   				columns:[
                   					{dataField: "EU_HRT_YN"				,caption: "당연EDD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   			{caption:"Basel",
                   				columns:[
                   					{dataField: "BASEL_RIK_IDX_SCR"		,caption: "1"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true}, // 
                       			],
                   			},
                   		],
                   	},
					
                   	{dataField: "RA_ITEM_NTN_CD"	,caption: "위험평가항목값(상세코드)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false},
                   	{dataField: "RA_SN_CCD"			,caption: "결재상태코드"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SN_CCD_NM"		,caption: "결재상태"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_NO"			,caption: "결재번호"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_DT"			,caption: "결재일자"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_NO"		,caption: "최종결재번호"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_DT"		,caption: "최종결재일자"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD_NM" 		,caption: "결재상태"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD"			,caption: "결재코드"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_NO"			,caption: "결재번호"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "GYLJ_LINE_G_C"		,caption: "결재선구분코드"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_DT"			,caption: "결재일자"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SNO"				,caption: "최종순번"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "PRV_APP_NO"		,caption: "이전결재번호"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RSN_CNTNT"			,caption: "결재사유"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SEQ"			,caption: "변경시퀀스"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "POSITION_NAME"		,caption: "POSITION_NAME",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_REF_SN_CCD"		,caption: "RA_REF_SN_CCD",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false}
                ]
                // events
                ,onCellClick: function(e){
                		e.component.clearSelection();
        	            e.component.selectRowsByIndexes(e.rowIndex);
                		Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
                }
               ,onCellPrepared : function(e){
           		   if(e.rowType === 'data' && (e.column.dataField === 'ABS_HRSK_YN') || (e.column.dataField === 'RECAL_ABS_HRSK_YN')){
           			   if(e.value === "Y" || e.value === "H")
                 		       e.cellElement.css("color", "red");
                 	}
 		     	}
        }).dxDataGrid("instance");
    }

 	// 직업 그리드 초기화 함수 셋업
    function setupGrids3(){
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
             width		 			: "100%"
             ,height		 			: "calc(70vh - 150px)"
 			 ,elementAttr: { class: "grid-table-type" }
             ,hoverStateEnabled      : true
             ,wordWrapEnabled        : false
             ,allowColumnResizing    : true
             ,columnAutoWidth        : true
             ,allowColumnReordering  : true
             ,columnResizingMode     :'widget'  /* "widget" "nextColumn" */
             ,cacheEnabled           : false
             ,cellHintEnabled        : true
             ,showBorders            : true
             ,showColumnLines        : true
             ,showRowLines           : true
 		    //,onToolbarPreparing   : makeToolbarButtonGrids
             ,loadPanel              : { enabled: false }
             , export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
             ,sorting         		: { mode: "multiple"}
             ,remoteOperations		: {
                  filtering   : true
                 ,grouping    : true
                 ,paging      : true
                 ,sorting     : true
                 ,summary     : true
              }
             ,editing 				: {
                  mode            : 'batch'
                 ,allowUpdating   : false
                 ,allowAdding     : false
              }
             ,filterRow              : { visible: false }
             ,rowAlternationEnabled  : true
             ,columnFixing           : { enabled: true }
             ,pager: {
 	   	    	visible: false
 	   	    	,showNavigationButtons: true
 	   	    	,showInfo: true
 	   	    }
 	   	    ,paging: {
 	   	    	enabled : false
 	   	    	,pageSize : 20
 	   	    }
 		   	,scrolling : {
                 mode            : "virtual" /*standard*/
                ,preloadEnabled  : false
             }
             ,searchPanel: {visible : false,width   : 250}
             ,selection: {
                  allowSelectAll      : true
                 ,deferred            : false
                 ,mode                : 'single'    /* none, single, multiple                       */
                 ,selectAllMode       : 'allPages'    /* 'page' | 'allPages'                          */
                 ,showCheckBoxesMode  : 'onClick'      /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
              }
               ,columns: [
            	   {dataField: "SEQ"				,caption: "No."					,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "50px"},
           	       {dataField: "RA_ITEM_CD"			,caption: "위험평가항목코드"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false,	fixed:true},
           	       {dataField: "RA_ITEM_CODE"		,caption: "상세코드"				,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "70px"},
           	       {dataField: "RA_ITEM_IDJOB_NM1"	,caption: "위험평가항목값(상세코드)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false,	fixed:true},
                   {dataField: "RA_ITEM_NM"			,caption: "상세코드 내용"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "200px"},
                   {dataField: "ABS_HRSK_YN"		,caption: "당연EDD여부"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "90px"},
                   {dataField: "RA_ITEM_SCR"		,caption: "위험점수"				,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "70px"},
                   {caption: "재계산 결과",
                   	columns : [
                   		{dataField: "RECAL_ABS_HRSK_YN"	,caption: "당연EDD여부",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true, "width": "90px"},
                   		{dataField: "RECAL_RA_ITEM_SCR"	,caption: "위험점수",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, "width": "70px"},
                   		{dataField: "RECAL_RA_SCR"		,caption: "변동 구분",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true, "width": "70px"},
                   	],alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: true
                  	},
                    {caption: "비금융 전문서비스",
                   		columns : [
                   			{caption:"법률,회계,세무 관련",
                   				columns:[
                   					{dataField: "RA_IDJOB_YN1"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"투자자문 관련",
                   				columns:[
                   					{dataField: "RA_IDJOB_YN2"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"부동산 관련",
                   				columns:[
                   					{dataField: "RA_IDJOB_YN3"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   		],
                   	},
                   	{caption: "현금 집중거래 산업",
                   		columns : [
                   			{caption:"오락,도박,스포츠관련",
                   				columns:[
                   					{dataField: "RA_IDJOB_YN4"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"대부업자,환전상",
                   				columns:[
                   					{dataField: "RA_IDJOB_YN5"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"귀금속,예술품,골동품 판매상",
                   				columns:[
                   					{dataField: "RA_IDJOB_YN6"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"주류 도소매업,유흥주점업",
                   				columns:[
                   					{dataField: "RA_IDJOB_STA_YN1"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_IDJOB_STA1"		,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   		],
                   	},
                   	{caption: "부패 위험 산업/직종",
                   		columns : [
                   			{caption:"의료,제약관련",
                   				columns:[
                   					{dataField: "RA_IDJOB_STA_YN2"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_IDJOB_STA2"		,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   			{caption:"건설산업",
                   				columns:[
                   					{dataField: "RA_IDJOB_STA_YN3"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_IDJOB_STA3"		,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   			{caption:"무기,방위산업",
                   				columns:[
                   					{dataField: "RA_IDJOB_STA_YN4"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_IDJOB_STA4"		,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   			{caption:"채광,금속,고물상",
                   				columns:[
                   					{dataField: "RA_IDJOB_STA_YN5"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_IDJOB_STA5"		,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   		],
                   	},
                   	{caption: "가상자산사업 의심업종",
                   		columns : [
                   			{caption:"가상자산사업 의심",
                   				columns:[
                   					{dataField: "RA_IDJOB_YN7"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			}
                   		],
                   	},
                   	{caption: "자금력 의심 고객",
                   		columns : [
                   			{caption:"무직자",
                   				columns:[
                   					{dataField: "RA_IDJOB_STA_YN6"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_IDJOB_STA6"		,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   		],
                   	},


                    {dataField: "RA_SN_CCD"			,caption: "결재상태코드"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SN_CCD_NM"		,caption: "결재상태"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_NO"			,caption: "결재번호"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_DT"			,caption: "결재일자"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_NO"		,caption: "최종결재번호"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_DT"		,caption: "최종결재일자"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD_NM" 		,caption: "결재상태"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD"			,caption: "결재코드"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_NO"			,caption: "결재번호"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "GYLJ_LINE_G_C"		,caption: "결재선구분코드"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_DT"			,caption: "결재일자"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SNO"				,caption: "최종순번"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "PRV_APP_NO"		,caption: "이전결재번호"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RSN_CNTNT"			,caption: "결재사유"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SEQ"			,caption: "변경시퀀스"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "POSITION_NAME"		,caption: "POSITION_NAME",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_REF_SN_CCD"		,caption: "RA_REF_SN_CCD",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false}

                ]
                // events
               ,"onRowInserting" : function(e) {
                }
                ,onCellClick: function(e){
                		e.component.clearSelection();
        	            e.component.selectRowsByIndexes(e.rowIndex);
                		Grid3CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
                }
        }).dxDataGrid("instance");
    }

 	// 업종 그리드 초기화 함수 셋업
    function setupGrids4(){
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
             width		 			: "100%"
             ,height		 			: "calc(70vh - 150px)"
 			 ,elementAttr: { class: "grid-table-type" }
             ,hoverStateEnabled      : true
             ,wordWrapEnabled        : false
             ,allowColumnResizing    : true
             ,columnAutoWidth        : true
             ,allowColumnReordering  : true
             ,columnResizingMode     :'widget'  /* "widget" "nextColumn" */
             ,cacheEnabled           : false
             ,cellHintEnabled        : true
             ,showBorders            : true
             ,showColumnLines        : true
             ,showRowLines           : true
 		    //,onToolbarPreparing   : makeToolbarButtonGrids
             ,loadPanel              : { enabled: false }
             , export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
             ,sorting         		: { mode: "multiple"}
             ,remoteOperations		: {
                  filtering   : true
                 ,grouping    : true
                 ,paging      : true
                 ,sorting     : true
                 ,summary     : true
              }
             ,editing 				: {
                  mode            : 'batch'
                 ,allowUpdating   : false
                 ,allowAdding     : false
              }
             ,filterRow              : { visible: false }
             ,rowAlternationEnabled  : true
             ,columnFixing           : { enabled: true }
             ,pager: {
 	   	    	visible: false
 	   	    	,showNavigationButtons: true
 	   	    	,showInfo: true
 	   	    }
 	   	    ,paging: {
 	   	    	enabled : false
 	   	    	,pageSize : 20
 	   	    }
 		   	,scrolling : {
                 mode            : "virtual" /**standard/
                ,preloadEnabled  : false
             }
             ,searchPanel: {visible : false,width   : 250}
             ,selection: {
                  allowSelectAll      : true
                 ,deferred            : false
                 ,mode                : 'single'    /* none, single, multiple                       */
                 ,selectAllMode       : 'allPages'    /* 'page' | 'allPages'                          */
                 ,showCheckBoxesMode  : 'onClick'      /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
              }
               ,columns: [
            	   {dataField: "SEQ"				,caption: "No."					,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "50px"},
           	       {dataField: "RA_ITEM_CD"			,caption: "위험평가항목코드"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false,	fixed:true},
           	       {dataField: "RA_ITEM_CODE"		,caption: "상세코드"				,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "70px"},
                   {dataField: "RA_ITEM_NM"			,caption: "상세코드 내용"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "200px"},
                   {dataField: "ABS_HRSK_YN"		,caption: "당연EDD여부"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "90px"},
                   {dataField: "RA_ITEM_SCR"		,caption: "위험점수"				,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true,	fixed:true, "width": "70px"},
                   {caption: "재계산 결과",
                   	columns : [
                   		{dataField: "RECAL_ABS_HRSK_YN"	,caption: "당연EDD여부",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true, "width": "90px"},
                   		{dataField: "RECAL_RA_ITEM_SCR"	,caption: "위험점수",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, "width": "70px"},
                   		{dataField: "RECAL_RA_SCR"		,caption: "변동 구분",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true, "width": "70px"},
                   	],alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: true
                  	},
                    {caption: "비금융 전문서비스",
                   		columns : [
                   			{caption:"법률,회계,세무 관련",
                   				columns:[
                   					{dataField: "RA_CORJOB_YN1"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"투자자문 관련",
                   				columns:[
                   					{dataField: "RA_CORJOB_YN2"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"부동산 관련",
                   				columns:[
                   					{dataField: "RA_CORJOB_YN3"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   		],
                   	},
                   	{caption: "현금 집중거래 산업",
                   		columns : [
                   			{caption:"오락,도박,스포츠관련",
                   				columns:[
                   					{dataField: "RA_CORJOB_YN4"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"카지노",
                   				columns:[
                   					{dataField: "RA_CORJOB_YN5"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"대부업자,환전상,소액해외송급업자",
                   				columns:[
                   					{dataField: "RA_CORJOB_YN6"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"귀금속,예술품,골동품 판매상",
                   				columns:[
                   					{dataField: "RA_CORJOB_YN7"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			},
                   			{caption:"주류 도소매업,유흥주점업",
                   				columns:[
                   					{dataField: "RA_CORJOB_STA_YN1"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_CORJOB_STA1"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   		],
                   	},
                   	{caption: "부패 위험 산업/직종",
                   		columns : [
                   			{caption:"의료,제약관련",
                   				columns:[
                   					{dataField: "RA_CORJOB_STA_YN2"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_CORJOB_STA2"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   			{caption:"건설산업",
                   				columns:[
                   					{dataField: "RA_CORJOB_STA_YN3"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_CORJOB_STA3"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   			{caption:"무기,방위산업",
                   				columns:[
                   					{dataField: "RA_CORJOB_STA_YN4"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_CORJOB_STA4"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   			{caption:"채광,금속,고물상",
                   				columns:[
                   					{dataField: "RA_CORJOB_STA_YN5"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                   					{dataField: "RA_CORJOB_STA5"	,caption: "6.67",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false}
                       			],
                   			},
                   		],
                   	},
                   	{caption: "가상자산사업 의심업종",
                   		columns : [
                   			{caption:"가상자산사업 의심",
                   				columns:[
                   					{dataField: "RA_CORJOB_YN8"	,caption: "당연EDD",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:true},
                       			],
                   			}
                   		],
                   	},

                    {dataField: "RA_SN_CCD"		,caption: "결재상태코드"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SN_CCD_NM"	,caption: "결재상태"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_NO"		,caption: "결재번호"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_DT"		,caption: "결재일자"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_NO"	,caption: "최종결재번호"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_DT"	,caption: "최종결재일자"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD_NM" 	,caption: "결재상태"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD"		,caption: "결재코드"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_NO"		,caption: "결재번호"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "GYLJ_LINE_G_C"	,caption: "결재선구분코드"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_DT"		,caption: "결재일자"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SNO"			,caption: "최종순번"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "PRV_APP_NO"	,caption: "이전결재번호"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RSN_CNTNT"		,caption: "결재사유"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SEQ"		,caption: "변경시퀀스"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "POSITION_NAME"	,caption: "POSITION_NAME",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false}
                ]
                // events
               ,"onRowInserting" : function(e) {
                }
                ,onCellClick: function(e){
                		e.component.clearSelection();
        	            e.component.selectRowsByIndexes(e.rowIndex);
                		Grid4CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
                }
        }).dxDataGrid("instance");
    }

 	// 그리드 초기화 함수 셋업
    function setupGrids5(){
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
              width		 			 : "100%"
             ,height		 		 : "calc(70vh - 150px)"
 			 ,elementAttr: { class: "grid-table-type" }
             ,hoverStateEnabled      : true
             ,wordWrapEnabled        : false
             ,allowColumnResizing    : true
             ,columnAutoWidth        : true
             ,allowColumnReordering  : true
             ,columnResizingMode     :'widget'  /* "widget" "nextColumn" */
             ,cacheEnabled           : false
             ,cellHintEnabled        : true
             ,showBorders            : true
             ,showColumnLines        : true
             ,showRowLines           : true
 		    //,onToolbarPreparing   : makeToolbarButtonGrids
             ,loadPanel              : { enabled: false }
             , export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
             ,sorting         		: { mode: "multiple"}
             ,remoteOperations		: {
                  filtering   : false
                 ,grouping    : false
                 ,paging      : false
                 ,sorting     : false
                 ,summary     : false
              }
             ,editing 				: {
                  mode            : 'batch'
                 ,allowUpdating   : false
                 ,allowAdding     : false
              }
             ,filterRow              : { visible: false }
             ,rowAlternationEnabled  : true
             ,columnFixing           : { enabled: true }
             ,pager: {
 	   	    	visible: false
 	   	    	,showNavigationButtons: true
 	   	    	,showInfo: true
 	   	    }
 	   	    ,paging: {
 	   	    	enabled : false
 	   	    	,pageSize : 20
 	   	    }
 		   	,scrolling : {
                 mode            : "standard"
                ,preloadEnabled  : false
             }
             ,searchPanel: {visible : false,width   : 250}
             ,selection: {
                  allowSelectAll      : true
                 ,deferred            : false
                 ,mode                : 'single'    /* none, single, multiple                       */
                 ,selectAllMode       : 'allPages'    /* 'page' | 'allPages'                          */
                 ,showCheckBoxesMode  : 'onClick'      /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
              }
               ,columns: [
            	    {dataField: "SEQ"				,caption: "No."			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true, "width": "50px"},
            	    {dataField: "RA_ST_INTV_VAL"	,caption: "시작 값"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true, "width": "100px"},
            	    {dataField: "GUGAN1"			,caption: "구간 1"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true, "width": "100px"},
                    {dataField: "RA_ET_INTV_VAL"	,caption: "종료 값"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true, "width": "100px"},
                    {dataField: "GUGAN2"			,caption: "구간 2"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true, "width": "100px"},
                    {dataField: "C_ABS_HRSK_YN"	,caption: "당연EDD여부"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: true, 	visible : true, "width": "90px"
            	    	,lookup   : {
                        dataSource: [
                            {
                                "KEY"  : "Y",
                                "VALUE": "Y"
                            }, {
                                "KEY"  : "N",
                                "VALUE": "N"
                            }
                        ],
                        displayExpr: "VALUE",
                        valueExpr  : "KEY"
                    },},
                    {dataField: "C_RA_ITEM_SCR"		,caption: "위험점수"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true, "width": "90px"},
                    {dataField: "RA_RMRK"			,caption: "비고(메모)"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true},
                    {dataField: "RA_ITEM_CODE"		,caption: "RA_ITEM_CODE",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false},
            	    {dataField: "C_RA_ITEM_NM"		,caption: "RA_ITEM_NM"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false,  visible : false},
            	    {dataField: "RA_ITEM_CD"		,caption: "RA_ITEM_CD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false,  visible : false},

                    {dataField: "RA_SN_CCD"			,caption: "결재상태코드"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SN_CCD_NM"		,caption: "결재상태"	  		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_NO"			,caption: "결재번호"	  		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_DT"			,caption: "결재일자"	  		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_NO"		,caption: "최종결재번호"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_DT"		,caption: "최종결재일자"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD_NM" 		,caption: "결재상태"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD"			,caption: "결재코드"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "GYLJ_LINE_G_C"		,caption: "결재선구분코드"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_DT"			,caption: "결재일자"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SNO"				,caption: "최종순번"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "PRV_APP_NO"		,caption: "이전결재번호"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RSN_CNTNT"			,caption: "결재사유"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SEQ"			,caption: "변경시퀀스"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "POSITION_NAME"		,caption: "POSITION_NAME"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_REF_SN_CCD"		,caption: "RA_REF_SN_CCD"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false}
                ]
                // events
               ,"onRowInserting" : function(e) {
                }
               ,onCellPrepared : function(e){
           		   if(e.rowType === 'data' &&
                 		     ( e.column.dataField === 'RA_ST_INTV_VAL' || e.column.dataField === 'RA_ET_INTV_VAL' || e.column.dataField === 'C_ABS_HRSK_YN' || e.column.dataField === 'C_RA_ITEM_SCR' || e.column.dataField === 'RA_RMRK' || e.column.dataField === 'C_RA_ITEM_NM')){
                 		       e.cellElement.css("color", "blue");
                 		     }
 		     	}
                ,onCellClick: function(e){
                	if(e.rowType != "header" && e.rowType != "filter" && e.rowType != "totalFooter"){
                        if (e.component.isRowSelected(e.key)){
                        	if (e.column.dataField=="RA_ST_INTV_VAL"){
                        		e.component.editCell(e.rowIndex,"RA_ST_INTV_VAL");
                        	}else if (e.column.dataField=="RA_ET_INTV_VAL"){
                        		e.component.editCell(e.rowIndex,"RA_ET_INTV_VAL");
                        	}else if (e.column.dataField=="C_ABS_HRSK_YN") {
                        		e.component.editCell(e.rowIndex,"C_ABS_HRSK_YN");
                        	}else if (e.column.dataField=="C_RA_ITEM_SCR") {
                        		e.component.editCell(e.rowIndex,"C_RA_ITEM_SCR");
                        	}else if (e.column.dataField=="RA_RMRK"){
                        		e.component.editCell(e.rowIndex,"RA_RMRK");
                        	}
                        }

                    }
                		Grid5CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
                }
        }).dxDataGrid("instance");
    }

 	// 그리드 초기화 함수 셋업
    function setupGrids6(){
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
             width		 			: "100%"
             ,height		 			: "calc(70vh - 150px)"
 			 ,elementAttr: { class: "grid-table-type" }
             ,hoverStateEnabled      : true
             ,wordWrapEnabled        : false
             ,allowColumnResizing    : true
             ,columnAutoWidth        : true
             ,allowColumnReordering  : true
             ,columnResizingMode     :'widget'  /* "widget" "nextColumn" */
             ,cacheEnabled           : false
             ,cellHintEnabled        : true
             ,showBorders            : true
             ,showColumnLines        : true
             ,showRowLines           : true
 		    //,onToolbarPreparing   : makeToolbarButtonGrids
             ,loadPanel              : { enabled: false }
             , export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
             ,sorting         		: { mode: "multiple"}
             ,remoteOperations		: {
                  filtering   : false
                 ,grouping    : false
                 ,paging      : false
                 ,sorting     : false
                 ,summary     : false
              }
             ,editing 				: {
                  mode            : 'batch'
                 ,allowUpdating   : false
                 ,allowAdding     : false
              }
             ,filterRow              : { visible: false }
             ,rowAlternationEnabled  : true
             ,columnFixing           : { enabled: true }
             ,pager: {
 	   	    	visible: false
 	   	    	,showNavigationButtons: true
 	   	    	,showInfo: true
 	   	    }
 	   	    ,paging: {
 	   	    	enabled : false
 	   	    	,pageSize : 20
 	   	    }
 		   	,scrolling : {
                 mode            : "standard"
                ,preloadEnabled  : false
             }
             ,searchPanel: {visible : false,width   : 250}
             ,selection: {
                  allowSelectAll      : true
                 ,deferred            : false
                 ,mode                : 'single'    /* none, single, multiple                        */
                 ,selectAllMode       : 'allPages'    /* 'page' | 'allPages'                          */
                 ,showCheckBoxesMode  : 'onClick'      /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
              }
               ,columns: [
            	    {dataField: "SEQ"			,caption: "No."			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, 	visible : true, "width": "50px"},
            	    {dataField: "RA_ITEM_CODE"	,caption: "상세코드"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, 	visible : true, "width": "70px"},
            	    {dataField: "C_RA_ITEM_NM"	,caption: "상세코드 내용"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: true, 	visible : true, "width": "200px"},
            	    {dataField: "RA_ITEM_CD"	,caption: "RA_ITEM_CD"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false,  	visible : false},
                    {dataField: "C_ABS_HRSK_YN"	,caption: "당연EDD여부"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: true, 	visible : true, "width": "90px"
            	    	,lookup   : {
                        dataSource: [
                            {
                                "KEY"  : "Y",
                                "VALUE": "Y"
                            }, {
                                "KEY"  : "N",
                                "VALUE": "N"
                            }
                        ],
                        displayExpr: "VALUE",
                        valueExpr  : "KEY"
                    },},
                    {dataField: "C_RA_ITEM_SCR"	,caption: "위험점수"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, 	visible : true, "width": "90px"},
                    {dataField: "RA_RMRK"		,caption: "비고(메모)"		,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: true, 	visible : true},

                    {dataField: "RA_SN_CCD"			,caption: "결재상태코드"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SN_CCD_NM"		,caption: "결재상태"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_NO"			,caption: "결재번호"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_DT"			,caption: "결재일자"	  	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_NO"		,caption: "최종결재번호"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_DT"		,caption: "최종결재일자"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD_NM" 		,caption: "결재상태"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD"			,caption: "결재코드"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_NO"			,caption: "결재번호"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "GYLJ_LINE_G_C"		,caption: "결재선구분코드"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_DT"			,caption: "결재일자"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SNO"				,caption: "최종순번"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "PRV_APP_NO"		,caption: "이전결재번호"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RSN_CNTNT"			,caption: "결재사유"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SEQ"			,caption: "변경시퀀스"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "POSITION_NAME"		,caption: "POSITION_NAME",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_REF_SN_CCD"		,caption: "RA_REF_SN_CCD",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false}
                ]
               ,onCellPrepared : function(e){
           		   if(e.rowType === 'data' &&
                 		     ( e.column.dataField === 'C_ABS_HRSK_YN' || e.column.dataField === 'C_RA_ITEM_SCR' || e.column.dataField === 'RA_RMRK' || e.column.dataField === 'C_RA_ITEM_NM')){
                 		       e.cellElement.css("color", "blue");
                 		     }
 		     	}
                ,onCellClick: function(e){
                	if(e.rowType != "header" && e.rowType != "filter" && e.rowType != "totalFooter"){
                        if (e.component.isRowSelected(e.key) && (e.columnIndex>=2 && e.columnIndex<=5)){
                            e.component.editCell(e.rowIndex,e.columnIndex);
                        }
                    }

                		Grid6CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
                }
        }).dxDataGrid("instance");
    }

 	// 그리드 CellClick function
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId , colId){}

    // 국가별 평가관리
    function Grid2CellClick(id, obj, selectData, rowIdx, colIdx, colId){
       clickedRowIndex = rowIdx;
       if(colId == "RA_ITEM_CODE" && obj){
   		   form1.pageID.value = 'AML_10_37_01_02';
           window_popup_open(form1.pageID.value, 900, 950, '');
           form1.RA_ITEM_CD.value    = obj.RA_ITEM_CD;
           form1.RA_ITEM_CODE.value  = obj.RA_ITEM_CODE;
           form1.RA_SEQ.value        = obj.RA_SEQ;
           form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
           form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
           form1.target              = form1.pageID.value;
           form1.action              = "<c:url value='/'/>0001.do";
           form1.submit();
       }else if(colId == "RA_ITEM_NM" && obj) {
   		   form1.pageID.value = 'AML_10_37_01_02';
   		   window_popup_open(form1.pageID.value, 900, 950, '');
   		   form1.RA_ITEM_CD.value    = obj.RA_ITEM_CD;
           form1.RA_ITEM_CODE.value  = obj.RA_ITEM_CODE;
           form1.RA_SEQ.value        = obj.RA_SEQ;
           form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
           form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
   		   form1.target              = form1.pageID.value;
           form1.action              = "<c:url value='/'/>0001.do";
           form1.submit();
       }
    }

 	// 직업별 평가관리
    function Grid3CellClick(id, obj, selectData, rowIdx, colIdx, colId){
       clickedRowIndex = rowIdx;

       if(colId == "RA_ITEM_CODE" && obj){
   		   form1.pageID.value = 'AML_10_37_01_03';
           window_popup_open(form1.pageID.value, 900, 1000, '');
           form1.RA_ITEM_CD.value    = obj.RA_ITEM_CD;
           form1.RA_ITEM_CODE.value  = obj.RA_ITEM_CODE;
           form1.RA_SEQ.value        = obj.RA_SEQ;
           form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
           form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
           form1.target             = form1.pageID.value;
           form1.action             = "<c:url value='/'/>0001.do";
           form1.submit();
       }else if(colId == "RA_ITEM_NM" && obj) {
   		   form1.pageID.value = 'AML_10_37_01_03';
   		   window_popup_open(form1.pageID.value, 900, 1000, '');
   		   form1.RA_ITEM_CD.value    = obj.RA_ITEM_CD;
           form1.RA_ITEM_CODE.value  = obj.RA_ITEM_CODE;
           form1.RA_SEQ.value        = obj.RA_SEQ;
           form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
           form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
   		   form1.target             = form1.pageID.value;
           form1.action             = "<c:url value='/'/>0001.do";
           form1.submit();
       }
    }

	// 업종별 평가관리
    function Grid4CellClick(id, obj, selectData, rowIdx, colIdx, colId){
       clickedRowIndex = rowIdx;
       if(colId == "RA_ITEM_CODE" && obj){
   		   form1.pageID.value = 'AML_10_37_01_04';
           window_popup_open(form1.pageID.value, 900, 1000, '');
           form1.RA_ITEM_CD.value    = obj.RA_ITEM_CD;
           form1.RA_ITEM_CODE.value  = obj.RA_ITEM_CODE;
           form1.RA_SEQ.value        = obj.RA_SEQ;
           form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
           form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
           form1.target              = form1.pageID.value;
           form1.action              = "<c:url value='/'/>0001.do";
           form1.submit();
       }else if(colId == "RA_ITEM_NM" && obj) {
   		   form1.pageID.value = 'AML_10_37_01_04';
   		   window_popup_open(form1.pageID.value, 900, 1000, '');
   		   form1.RA_ITEM_CD.value    = obj.RA_ITEM_CD;
           form1.RA_ITEM_CODE.value  = obj.RA_ITEM_CODE;
           form1.RA_SEQ.value        = obj.RA_SEQ;
           form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
           form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
   		   form1.target              = form1.pageID.value;
           form1.action              = "<c:url value='/'/>0001.do";
           form1.submit();
       }
    }

    function Grid5CellClick(id, obj, selectData, rowIdx, colIdx, colId){}
	function Grid6CellClick(id, obj, selectData, rowIdx, colIdx, colId){}

    /* TAP 위험평가항목 검색 */
    function doSearch() {
    	overlay.hide();
        var classID  = "AML_10_37_01_01";
        var methodID = "getSearchMaster";
        var params = new Object();
        params.pageID   = pageID;
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }

    function doSearch_fail(){ overlay.hide(); }

    function doSearch_success(gridData, data){
    	GridObj1.refresh();
        GridObj1.option("dataSource",gridData);
        var row = gridData.length;

        if(row > 0){
            GridObj1.refresh().then(function() {
            	GridObj1.selectRowsByIndexes(0);
            });
        }

        var row = gridData.length;

        if (row > 0) {
            var str = "<table >";
            for (var i=0; i<row; i++) {
                var item = gridData[i];
                if("${RA_APPR_YN}" == "Y"){
                    flag = item.SN_CCD_NM;
                }else{
                    flag = item.APPLY_FLAG;
                }
                if (item) {
                    str += '<tr>';
                    str += '    <td>';
                    str += '        <table class="t01_area" style="table-layout:fixed;width:100%">';
                    str += '        <tr>';
                    str += '            <td height=25 style="cursor:pointer;" title="'+item.ITEM_NM+'" onclick="showGridSubFrame(\''+item.RA_ITEM_CD+'\',\''+i+'\',\''+gridData+'\',\''+item.ITEM_NM+'\',\''+item.INTV_VAL_YN+'\')">';
                    str += '                <span id="span_'+i+'" class="t01-menu" >';
                    str += '                    <a href="javascript:">';
                    str += '                    <span class="longcut"><nobr> '+item.ITEM_NM+'</nobr></span>';
                	str += '                    <span style="font-size:10px;color:#FF4848;text-align:right;padding-left:5px"> '+flag+' </span>';
                    str += '                    </a>';
                    str += '                </span>';
                    str += '            </td>';
                    str += '        </tr>';
                    str += '        </table>';
                    str += '    </td>';
                    str += '</tr>';
                    str += '<tr>';
                    str += '    <td class="t01_line"></td>';
                    str += '</tr>';
                }
            }
            str += '</table>';
            var row = "<div>";
            row += "</div>"
            $("#htmlGrid").html(str).dxScrollView();
            showGridSubFrame(gridData[0].RA_ITEM_CD, 0, gridData, gridData[0].ITEM_NM, gridData[0].INTV_VAL_YN);

            //$("#span_0").attr("class","t01-menu-on");
        }
    }

    function showGridSubFrame(RA_ITEM_CD, selectedIndex, gridData, ITEM_NM, INTV_VAL_YN){
    	GridObj1.selectRowsByIndexes(selectedIndex);
        for (var i=0; i<gridData.length; i++) {
            if (gridData[i]) {
            	$("#span_"+i).attr("class","t01-menu");
            }
        }
        $("#span_"+selectedIndex).attr("class","t01-menu-on");
        if (curRow!=selectedIndex) {
            $("#subBizTitle").text(ITEM_NM);
             curRow                     = selectedIndex;
             form1.RA_ITEM_CD.value     = RA_ITEM_CD;
             form1.INTV_VAL_YN.value    = INTV_VAL_YN;
             form1.CUR_ROW.value        = selectedIndex;
             form1.SEARCH_GUBUN.value   = "Y";
             doSearchGubun();
             document.form1.reset();
         }
    }
    
		

    function doSearchGubun() {
    	var RA_ITEM_GUBUN = form1.RA_ITEM_CD.value;
    	var INTV_VAL_YN   = form1.INTV_VAL_YN.value;
    	var tab1Div = document.getElementById("ra-item-gubun");
    	var tab2Div = document.getElementById("ra-item-gubun2");

    	if(RA_ITEM_GUBUN == "I001") {
    		tab1Div.style.display = "block";
    		tab2Div.style.display = "none";

    		$(".risk1").show();
    		$(".risk2").hide();
    		$(".risk3").hide();

    		doSearch2();
    	}else if(RA_ITEM_GUBUN == "I002"){
    		tab1Div.style.display = "block";
    		tab2Div.style.display = "none";

    		$(".risk1").hide();
    		$(".risk2").show();
    		$(".risk3").hide();

    		doSearch3();
    	}else if(RA_ITEM_GUBUN == "I003"){
    		tab1Div.style.display = "block";
    		tab2Div.style.display = "none";

    		$(".risk1").hide();
    		$(".risk2").hide();
    		$(".risk3").show();

    		doSearch4();
    	}else if(INTV_VAL_YN == "Y" && RA_ITEM_GUBUN !="I001"&& RA_ITEM_GUBUN !="I002"&& RA_ITEM_GUBUN !="I003"){
    		tab1Div.style.display = "none";
    		tab2Div.style.display = "block";
    		$(".risk1").hide();
    		$(".risk2").hide();
    		$(".risk3").hide();

    		doSearch5();
    	}else if(INTV_VAL_YN == "N" && RA_ITEM_GUBUN !="I001"&& RA_ITEM_GUBUN !="I002"&& RA_ITEM_GUBUN !="I003"){
    		tab1Div.style.display = "none";
    		tab2Div.style.display = "block";
    		$(".risk1").hide();
    		$(".risk2").hide();
    		$(".risk3").hide();

    		doSearch6();
    	}
    }

    function doSearchRe() {
    	form1.SEARCH_GUBUN.value = "N";
    	var RA_ITEM_GUBUN = form1.RA_ITEM_CD.value;
    	var INTV_VAL_YN   = form1.INTV_VAL_YN.value;
    	if(form1.RA_ITEM_CD.value == "I001") {
    		doSearch2();
    	}else if(form1.RA_ITEM_CD.value == "I002"){
    		doSearch3();
    	}else if(form1.RA_ITEM_CD.value == "I003"){
    		doSearch4();
    	}else if(INTV_VAL_YN == "Y" && RA_ITEM_GUBUN !="I001"&& RA_ITEM_GUBUN !="I002"&& RA_ITEM_GUBUN !="I003") {
    		doSearch5();
    	}else if(INTV_VAL_YN == "N" && RA_ITEM_GUBUN !="I001"&& RA_ITEM_GUBUN !="I002"&& RA_ITEM_GUBUN !="I003") {
    		doSearch6();
    	}
    }

    /* 국가별 평가관리 조회 */
    function doSearch2() {
    	overlay.show(true,true);
        setupGrids2();
        doSearchGridNtn();
        if(form1.SEARCH_GUBUN.value == "Y") {
        	var methodID            = "getSearchDetail";
            var params              = new Object();
            params.pageID           = pageID;
            params.RA_ITEM_CD       = form1.RA_ITEM_CD.value;
            params.RA_ITEM_NM       = "";
            params.RA_ITEM_CODE     = "";
            params.ABS_HRSK_YN      = "ALL";
            params.RECAL_RA_SCR_NM  = "ALL";
            params.RANKID           = RANKID;
            params.RISK_ELMT_CD     = "ALL";
            sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
        }else {
        	var methodID = "getSearchDetail";
            var params = new Object();

            params.pageID           = pageID;
            params.RA_ITEM_CD       = form1.RA_ITEM_CD.value;
            params.RA_ITEM_NM       = form1.RA_ITEM_NM.value;
            params.RA_ITEM_CODE     = form1.RA_ITEM_CODE_SE.value;
            params.ABS_HRSK_YN      = form1.ABS_HRSK_YN.value;
            params.RECAL_RA_SCR_NM  = form1.RECAL_RA_SCR_NM.value;
            params.RANKID           = RANKID;
            params.RISK_ELMT_CD     = form1.RISK_ELMT_CDNT.value;
            params.RISK_ELMT_CD2    = form1.RISK_ELMT_CD2.value;

            sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
        }
    }

    /* 직업별 평가관리 조회 */
    function doSearch3() {
    	overlay.show(true,true);
        setupGrids3();
        doSearchGridIdjob();
        if(form1.SEARCH_GUBUN.value == "Y") {
        	var methodID            = "getSearchDetail";
            var params              = new Object();
            params.pageID           = pageID;
            params.RA_ITEM_CD       = form1.RA_ITEM_CD.value;
            params.RA_ITEM_NM       = "";
            params.RA_ITEM_CODE     = "";
            params.ABS_HRSK_YN      = "ALL";
            params.RECAL_RA_SCR_NM  = "ALL";
            params.RANKID           = RANKID;
            params.RISK_ELMT_CD     = "ALL";
            sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
        }else {
        	var methodID = "getSearchDetail";
            var params = new Object();
            params.pageID           = pageID;
            params.RA_ITEM_CD       = form1.RA_ITEM_CD.value;
            params.RA_ITEM_NM       = form1.RA_ITEM_NM.value;
            params.RA_ITEM_CODE     = form1.RA_ITEM_CODE_SE.value;
            params.ABS_HRSK_YN      = form1.ABS_HRSK_YN.value;
            params.RECAL_RA_SCR_NM  = form1.RECAL_RA_SCR_NM.value;
            params.RANKID           = RANKID;
            params.RISK_ELMT_CD     = form1.RISK_ELMT_CDIND.value;
            params.RISK_ELMT_CD2    = form1.RISK_ELMT_CD2.value;
            sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
        }
    }

    /* 업종별 평가관리 조회 */
    function doSearch4() {
    	overlay.show(true,true);
        setupGrids4();
        doSearchGridCorjob();
        if(form1.SEARCH_GUBUN.value == "Y") {
        	var methodID            = "getSearchDetail";
            var params              = new Object();
            params.pageID           = pageID;
            params.RA_ITEM_CD       = form1.RA_ITEM_CD.value;
            params.RA_ITEM_NM       = "";
            params.RA_ITEM_CODE     = "";
            params.ABS_HRSK_YN      = "ALL";
            params.RECAL_RA_SCR_NM  = "ALL";
            params.RANKID           = RANKID;
            params.RISK_ELMT_CD     = "ALL";
            sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
        }else {
        	var methodID = "getSearchDetail";
            var params = new Object();
            params.pageID           = pageID;
            params.RA_ITEM_CD       = form1.RA_ITEM_CD.value;
            params.RA_ITEM_NM       = form1.RA_ITEM_NM.value;
            params.RA_ITEM_CODE     = form1.RA_ITEM_CODE_SE.value;
            params.ABS_HRSK_YN      = form1.ABS_HRSK_YN.value;
            params.RECAL_RA_SCR_NM  = form1.RECAL_RA_SCR_NM.value;
            params.RANKID           = RANKID;
            params.RISK_ELMT_CD     = form1.RISK_ELMT_CDCOR.value;
            params.RISK_ELMT_CD2    = form1.RISK_ELMT_CD2.value;
            sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
        }
    }

    /* 구간평가관리 조회 */
    function doSearch5() {
    	overlay.show(true,true);
        setupGrids5();

        var methodID      = "getSearchDetail";
        var params        = new Object();
        var RA_ITEM_CD    = form1.RA_ITEM_CD.value;
        params.pageID     = pageID;
        params.RA_ITEM_CD = RA_ITEM_CD;
        params.RANKID     = RANKID;
        sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
    }

    /* 구간x평가관리 조회 */
    function doSearch6() {
    	overlay.show(true,true);
        setupGrids6();

        var methodID      = "getSearchDetail";
        var params        = new Object();
        var RA_ITEM_CD    = form1.RA_ITEM_CD.value;
        params.pageID     = pageID;
        params.RA_ITEM_CD = RA_ITEM_CD;
        params.RANKID     = RANKID;
        sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
    }

    function doSearch2_success(gridData, data){
    	if(gridData.length>0){
	        var obj = gridData[0];
	        form3.RA_SEQ.value        = obj.RA_SEQ;
	        form3.RA_APP_NO.value     = obj.RA_APP_NO;
	        form3.POSITION_NAME.value = obj.POSITION_NAME;
	        form3.PRV_APP_NO.value    = obj.PRV_APP_NO;
	        form3.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
	        form3.RA_SN_CCD.value     = obj.RA_SN_CCD;
	        form3.UPLOAD_GUBUN.value  = obj.UPLOAD_GUBUN;
	        
	        if(form3.RA_SN_CCD.value == "S") {
	        	$("#btn_05").hide();
	        	$("#btn_06").hide();
	        	$("#btn_07").hide();
	        	$("#btn_08").show();
	        	$("#btn_09").show();
	        	$("#btn_10").hide();
	        	$("#btn_11").hide();
	        	$("#btn_12").show();
	        	$("#btn_13").show();
	        	$("#btn_14").show();
	        	$("#btn_15").show();
	        }else if(form3.RA_SN_CCD.value == "E" || form3.RA_SN_CCD.value == "R") {
	        	if("Z" == form3.UPLOAD_GUBUN.value) {
	        		$("#btn_06").show();
	        	}else {
	        		$("#btn_06").hide();
	        	}
	        	$("#btn_07").hide();
	        	$("#btn_08").hide();
	        	$("#btn_09").hide();
	        	$("#btn_05").show();
	        	$("#btn_10").show();
	        	$("#btn_11").hide();
	        	$("#btn_12").hide();
	        	$("#btn_13").hide();
	        	$("#btn_14").hide();
	        	$("#btn_15").hide();
	        }else if(form3.RA_SN_CCD.value == "N"){
	        	if("Z" == form3.UPLOAD_GUBUN.value) {
	        		$("#btn_06").show();
	        	}else {
	        		$("#btn_06").hide();
	        	}
	        	$("#btn_05").show();
	        	//$("#btn_06").show();
	        	$("#btn_07").show();
	        	$("#btn_10").show();
	        	$("#btn_11").show();
	        	$("#btn_08").hide();
	        	$("#btn_09").hide();
	        	$("#btn_12").hide();
	        	$("#btn_13").hide();
	        	$("#btn_14").hide();
	        	$("#btn_15").hide();
	        }else if(form3.RA_SN_CCD.value == ""){
	        	if("Z" == form3.UPLOAD_GUBUN.value) {
	        		$("#btn_06").show();
	        	}else {
	        		$("#btn_06").hide();
	        	}
	        	$("#btn_05").show();
	        	//$("#btn_06").show();
	        	$("#btn_07").hide();
	        	$("#btn_08").hide();
	        	$("#btn_09").hide();
	        	$("#btn_10").show();
	        	$("#btn_11").hide();
	        	$("#btn_12").hide();
	        	$("#btn_13").hide();
	        	$("#btn_14").hide();
	        	$("#btn_15").hide();
	        }else {
	        	$("#btn_06").hide();
	        	$("#btn_07").hide();
	        	$("#btn_08").hide();
	        	$("#btn_09").hide();
	        	$("#btn_10").show();
	        	$("#btn_11").hide();
	        	$("#btn_12").hide();
	        	$("#btn_13").hide();
	        	$("#btn_14").hide();
	        	$("#btn_15").hide();
	        }

	        $("#RA_SN_CCD_NM").val(obj.RA_SN_CCD_NM);
	        $("#C_RA_SN_CCD_NM").val(obj.RA_SN_CCD_NM);
	    }
    	try {
        	GridObj2.refresh();
        	GridObj2.option("dataSource",gridData);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }

    function doSearch2_fail(){
        overlay.hide();
    }

    function doSearchGridNtn() {
    	overlay.show(true,true);
    	var methodID      = "getSearchGubun";
    	var classID       = "AML_10_37_01_02";
        var params        = new Object();
        sendService(classID, methodID, params, doSearchGridNtn_success, doSearch2_fail);
    }
    
    function doSearchGridNtn_success(gridData, data) {
    	if(gridData.length>0){
	        var obj = gridData[0];

	        const grid = $("#GTDataGrid2_Area").dxDataGrid("instance");

	        //grid.option("columns", columns);
	        
			const targets = ["FATF_BLACK_LIST_YN", "FATF_GREY_LIST_YN", "FINCEN_LIST_YN", "UN_SANTIONS_YN", "OFAC_SANTIONS_YN", "OECD_YN", "TICPI_CPI_IDX_SCR", "INCRS_PROD_YN", "INCRS_CHEM_YN", "EU_SANTIONS_YN", "EU_HRT_YN", "BASEL_RIK_IDX_SCR"];

			targets.forEach(field => {
				if(field === "FATF_BLACK_LIST_YN") { grid.columnOption("FATF_BLACK_LIST_YN", "caption", obj.RISK_SCR_NM1); }
				if(field === "FATF_GREY_LIST_YN")  { grid.columnOption("FATF_GREY_LIST_YN", "caption", obj.RISK_SCR_NM2);  }
				if(field === "FINCEN_LIST_YN")     { grid.columnOption("FINCEN_LIST_YN", "caption", obj.RISK_SCR_NM3);     }
				if(field === "UN_SANTIONS_YN")     { grid.columnOption("UN_SANTIONS_YN", "caption", obj.RISK_SCR_NM4);     }
				if(field === "OFAC_SANTIONS_YN")   { grid.columnOption("OFAC_SANTIONS_YN", "caption", obj.RISK_SCR_NM5);   }
				if(field === "OECD_YN")            { grid.columnOption("OECD_YN", "caption", obj.RISK_SCR_NM6);            }
				if(field === "TICPI_CPI_IDX_SCR")  { grid.columnOption("TICPI_CPI_IDX_SCR", "caption", obj.RISK_SCR_NM7);  }
				if(field === "INCRS_PROD_YN")      { grid.columnOption("INCRS_PROD_YN", "caption", obj.RISK_SCR_NM8);      }
				if(field === "INCRS_CHEM_YN")      { grid.columnOption("INCRS_CHEM_YN", "caption", obj.RISK_SCR_NM9);      }
				if(field === "EU_SANTIONS_YN")     { grid.columnOption("EU_SANTIONS_YN", "caption", obj.RISK_SCR_NM10);    }
				if(field === "EU_HRT_YN")          { grid.columnOption("EU_HRT_YN", "caption", obj.RISK_SCR_NM11);         }
				if(field === "BASEL_RIK_IDX_SCR")  { grid.columnOption("BASEL_RIK_IDX_SCR", "caption", obj.RISK_SCR_NM12); }
			});
    	} 
   	    overlay.hide();
    }
    
    function doSearchGridIdjob() {
    	overlay.show(true,true);
    	var methodID      = "getSearchGubun";
    	var classID       = "AML_10_37_01_03";
        var params        = new Object();
        sendService(classID, methodID, params, doSearchGridIdjob_success, doSearch2_fail);
    }
    
    function doSearchGridIdjob_success(gridData, data) {
    	if(gridData.length>0){
	        var obj = gridData[0];
	        const grid = $("#GTDataGrid2_Area").dxDataGrid("instance");

	        //grid.option("columns", columns);
	        
			const targets = ["RA_IDJOB_YN1", "RA_IDJOB_YN2", "RA_IDJOB_YN3", "RA_IDJOB_YN4", "RA_IDJOB_YN5", "RA_IDJOB_YN6", "RA_IDJOB_STA_YN1", "RA_IDJOB_STA_YN2", "RA_IDJOB_STA_YN3", "RA_IDJOB_STA_YN4", "RA_IDJOB_STA_YN5", "RA_IDJOB_YN7", "RA_IDJOB_STA_YN6"];

			targets.forEach(field => {
				if(field === "RA_IDJOB_YN1")      { grid.columnOption("RA_IDJOB_YN1", "caption", obj.RISK_SCR_NM1);      }
				if(field === "RA_IDJOB_YN2")      { grid.columnOption("RA_IDJOB_YN2", "caption", obj.RISK_SCR_NM2);      }
				if(field === "RA_IDJOB_YN3")      { grid.columnOption("RA_IDJOB_YN3", "caption", obj.RISK_SCR_NM3);      }
				if(field === "RA_IDJOB_YN4")      { grid.columnOption("RA_IDJOB_YN4", "caption", obj.RISK_SCR_NM4);      }
				if(field === "RA_IDJOB_YN5")      { grid.columnOption("RA_IDJOB_YN5", "caption", obj.RISK_SCR_NM5);      }
				if(field === "RA_IDJOB_YN6")      { grid.columnOption("RA_IDJOB_YN6", "caption", obj.RISK_SCR_NM6);      }
				if(field === "RA_IDJOB_STA_YN1")  { grid.columnOption("RA_IDJOB_STA_YN1", "caption", obj.RISK_SCR_NM7);  }
				if(field === "RA_IDJOB_STA_YN2")  { grid.columnOption("RA_IDJOB_STA_YN2", "caption", obj.RISK_SCR_NM8);  }
				if(field === "RA_IDJOB_STA_YN3")  { grid.columnOption("RA_IDJOB_STA_YN3", "caption", obj.RISK_SCR_NM9);  }
				if(field === "RA_IDJOB_STA_YN4")  { grid.columnOption("RA_IDJOB_STA_YN4", "caption", obj.RISK_SCR_NM10); }
				if(field === "RA_IDJOB_STA_YN5")  { grid.columnOption("RA_IDJOB_STA_YN5", "caption", obj.RISK_SCR_NM11); }
				if(field === "RA_IDJOB_YN7")      { grid.columnOption("RA_IDJOB_YN7", "caption", obj.RISK_SCR_NM12);     }
				if(field === "RA_IDJOB_STA_YN6")  { grid.columnOption("RA_IDJOB_STA_YN6", "caption", obj.RISK_SCR_NM13); }
			});
    	}
    	overlay.hide();
    }
    
    function doSearchGridCorjob() {
    	overlay.show(true,true);
    	var methodID      = "getSearchGubun";
    	var classID       = "AML_10_37_01_04";
        var params        = new Object();
        sendService(classID, methodID, params, doSearchGridCorjob_success, doSearch2_fail);
    }
    
    function doSearchGridCorjob_success(gridData, data) { 
    	if(gridData.length>0){
	        var obj = gridData[0];
	        const grid = $("#GTDataGrid2_Area").dxDataGrid("instance");

	        //grid.option("columns", columns);
	        
			const targets = ["RA_CORJOB_YN1", "RA_CORJOB_YN2", "RA_CORJOB_YN3", "RA_CORJOB_YN4", "RA_CORJOB_YN5", "RA_CORJOB_YN6", "RA_CORJOB_YN7", "RA_CORJOB_STA_YN1", "RA_CORJOB_STA_YN2", "RA_CORJOB_STA_YN3", "RA_CORJOB_STA_YN4", "RA_CORJOB_STA_YN5", "RA_CORJOB_YN8"];

			targets.forEach(field => {
				if(field === "RA_CORJOB_YN1")      { grid.columnOption("RA_CORJOB_YN1", "caption", obj.RISK_SCR_NM1);      }
				if(field === "RA_CORJOB_YN2")      { grid.columnOption("RA_CORJOB_YN2", "caption", obj.RISK_SCR_NM2);      }
				if(field === "RA_CORJOB_YN3")      { grid.columnOption("RA_CORJOB_YN3", "caption", obj.RISK_SCR_NM3);      }
				if(field === "RA_CORJOB_YN4")      { grid.columnOption("RA_CORJOB_YN4", "caption", obj.RISK_SCR_NM4);      }
				if(field === "RA_CORJOB_YN5")      { grid.columnOption("RA_CORJOB_YN5", "caption", obj.RISK_SCR_NM5);      }
				if(field === "RA_CORJOB_YN6")      { grid.columnOption("RA_CORJOB_YN6", "caption", obj.RISK_SCR_NM6);      }
				if(field === "RA_CORJOB_YN7")      { grid.columnOption("RA_CORJOB_YN7", "caption", obj.RISK_SCR_NM7);      }
				if(field === "RA_CORJOB_STA_YN1")  { grid.columnOption("RA_CORJOB_STA_YN1", "caption", obj.RISK_SCR_NM8);  }
				if(field === "RA_CORJOB_STA_YN2")  { grid.columnOption("RA_CORJOB_STA_YN2", "caption", obj.RISK_SCR_NM9);  }
				if(field === "RA_CORJOB_STA_YN3")  { grid.columnOption("RA_CORJOB_STA_YN3", "caption", obj.RISK_SCR_NM10); }
				if(field === "RA_CORJOB_STA_YN4")  { grid.columnOption("RA_CORJOB_STA_YN4", "caption", obj.RISK_SCR_NM11); }
				if(field === "RA_CORJOB_STA_YN5")  { grid.columnOption("RA_CORJOB_STA_YN5", "caption", obj.RISK_SCR_NM12); }
				if(field === "RA_CORJOB_YN8")      { grid.columnOption("RA_CORJOB_YN8", "caption", obj.RISK_SCR_NM13);     }
			});
    	}
    	overlay.hide();
    }
    
    //결재요청
    function PopKYCPage() {
    	var RA_ITEM_CD    = form1.RA_ITEM_CD.value;
		var RA_SEQ        = form3.RA_SEQ.value;
		var RA_APP_NO     = form3.RA_APP_NO.value;
		var POSITION_NAME = form3.POSITION_NAME.value;
		var RA_REF_SN_CCD = form3.RA_REF_SN_CCD.value;
		var INTV_VAL_YN   = form1.INTV_VAL_YN.value;
		var RA_SN_CCD     = form3.RA_SN_CCD.value;

	   	form3.pageID.value = 'AML_10_37_01_05';
	    window_popup_open(form3.pageID.value, 900, 680, '', '');
	    form3.target              = form3.pageID.value;
	    form3.RA_ITEM_CD.value    = RA_ITEM_CD;
	    form3.RA_SEQ.value        = RA_SEQ;
	    form3.POSITION_NAME.value = POSITION_NAME;
	    form3.APP_NO.value        = RA_APP_NO;
	    form3.RA_REF_SN_CCD.value = RA_REF_SN_CCD;
	    form3.INTV_VAL_YN.value   = INTV_VAL_YN;
	    form3.RA_SN_CCD.value     = RA_SN_CCD;

	    form3.action           = "<c:url value='/'/>0001.do";
	    form3.submit();
    }

  	//결재완료
    function PopKYCPage3() {
    	var RA_ITEM_CD    = form1.RA_ITEM_CD.value;
		var RA_SEQ        = form3.RA_SEQ.value;
		var RA_APP_NO     = form3.RA_APP_NO.value;
		var POSITION_NAME = form3.POSITION_NAME.value;
		var PRV_APP_NO    = form3.PRV_APP_NO.value;
		var INTV_VAL_YN   = form1.INTV_VAL_YN.value;

		form3.pageID.value = 'AML_10_37_01_05';
	    window_popup_open(form3.pageID.value, 900, 680, '', '');
	    form3.target              = form3.pageID.value;
	    form3.RA_ITEM_CD.value    = RA_ITEM_CD;
	    form3.RA_SEQ.value     	  = RA_SEQ;
	    form3.POSITION_NAME.value = POSITION_NAME;
	    form3.APP_NO.value        = RA_APP_NO;
        form3.PRV_APP_NO.value    = PRV_APP_NO;
        form3.INTV_VAL_YN.value   = INTV_VAL_YN;

        form3.action              = "<c:url value='/'/>0001.do";
        form3.submit();

    }

  	//반려실행
    function PopKYCPage2() {
    	var RA_ITEM_CD    = form1.RA_ITEM_CD.value;
		var RA_SEQ        = form3.RA_SEQ.value;
		var RA_APP_NO     = form3.RA_APP_NO.value;
		var POSITION_NAME = form3.POSITION_NAME.value;
		var INTV_VAL_YN   = form1.INTV_VAL_YN.value;

    	form3.pageID.value = 'AML_10_37_01_06';
    	window_popup_open(form3.pageID.value, 900, 680, '', '');
	    form3.target              = form3.pageID.value;
	    form3.RA_ITEM_CD.value    = RA_ITEM_CD;
	    form3.RA_SEQ.value        = RA_SEQ;
	    form3.POSITION_NAME.value = POSITION_NAME;
	    form3.APP_NO.value        = RA_APP_NO;
	    form3.INTV_VAL_YN.value   = INTV_VAL_YN;

	    form3.action           = "<c:url value='/'/>0001.do";
	    form3.submit();
    }

  	//변경이력
    function doHistoryList() {
		var RA_ITEM_CD    = form1.RA_ITEM_CD.value;
		var INTV_VAL_YN   = form1.INTV_VAL_YN.value;
		
    	form3.pageID.value = 'AML_10_37_01_07';
        window_popup_open(form3.pageID.value, 900, 680, '', '');
        form3.target = form3.pageID.value;
        form3.RA_ITEM_CD.value    = RA_ITEM_CD;
        form3.INTV_VAL_YN.value   = INTV_VAL_YN;
        form3.action = "<c:url value='/'/>0001.do";
        form3.submit();
    }

  	//결재이력
	function PopKYCPage_Hist() {
		var RA_ITEM_CD    = form1.RA_ITEM_CD.value;

		form3.pageID.value = 'AML_10_37_01_08';
		window_popup_open(form3.pageID.value, 900, 450, '','');
		form3.target           = form3.pageID.value;
		form3.RA_ITEM_CD.value = RA_ITEM_CD;
		form3.action           = "<c:url value='/'/>0001.do";
        form3.submit();
	}

  	//위험점수재계산
  	function reCalcul() {
  		var RA_ITEM_CD    = form1.RA_ITEM_CD.value;
  		var RA_SEQ        = form3.RA_SEQ.value;
  		var RA_REF_SN_CCD = form3.RA_REF_SN_CCD.value;
  		var RA_SN_CCD     = form3.RA_SN_CCD.value;
  		var UPLOAD_GUBUN  = form3.UPLOAD_GUBUN.value;
  		//alert("111 :" + RA_ITEM_CD + " 222 : " + UPLOAD_GUBUN);
  		
  		if(RA_ITEM_CD == "I001") {
  			var classID               = "AML_10_37_01_02";
  		}else if(RA_ITEM_CD == "I002") {
  			var classID               = "AML_10_37_01_03";
  		}else if(RA_ITEM_CD == "I003") {
  			var classID               = "AML_10_37_01_04";
  		}
  		
  			showConfirm('${msgel.getMsg("AML_10_36_01_01_034","위험평가 재계산 하시겠습니까?")}', "위험평가 재계산",function(){
  			overlay.show(true, true);
  	    	var methodID              = "reCalcul";
  	        var params                = new Object();
  	        params.pageID             = pageID;
  	        params.RA_ITEM_CD         = RA_ITEM_CD;
  	        params.RA_SEQ             = RA_SEQ;
  	        params.RA_REF_SN_CCD      = RA_REF_SN_CCD;
  	        params.RA_SN_CCD          = RA_SN_CCD;
  	        params.UPLOAD_GUBUN       = UPLOAD_GUBUN;

  	        sendService(classID, methodID, params, doSave2_end, doSave2_end);

  			});
  	}
  	
  	function doSave2_end() {
  		var RA_ITEM_GUBUN = form1.RA_ITEM_CD.value;
    	var INTV_VAL_YN   = form1.INTV_VAL_YN.value;
    	
    	if(RA_ITEM_GUBUN == "I001") {
			doSearch2();
			doSearch_reCalcul();
    	}else if (RA_ITEM_GUBUN == "I002"){
			doSearch3();
			doSearch_reCalcul();
    	}else if (RA_ITEM_GUBUN == "I003"){
			doSearch4();
			doSearch_reCalcul();
  		}
  	}
  	
  	function doSearch_reCalcul() {
  		var classID              = "AML_10_37_01_01";
        var methodID             = "getSearch_reCalcul";
        var params               = new Object();
        var RA_ITEM_CD       	 = form1.RA_ITEM_CD.value;

        params.pageID            = pageID;
        params.RA_ITEM_CD        = RA_ITEM_CD;
        
        sendService(classID, methodID, params, doSearch_reCalcul_success, doSearch_reCalcul_success);
  	}
  	
  	function doSearch_reCalcul_success(gridData, data) {
  		overlay.hide();
  		if(gridData.length>0){
            var obj = gridData[0];

            form3.recalculCNT1.value = obj.CNT1;
            form3.recalculCNT2.value = obj.CNT2;
            
            var recalculCNT1 = form3.recalculCNT1.value;
            var recalculCNT2 = form3.recalculCNT2.value;
            
            if(recalculCNT1 > 0 || recalculCNT2 > 0){
            	showAlert( "${msgel.getMsg('AML_10_01_01_01_046', '위험점수/당연EDD 여부가 변경되었습니다.')}", "INFO");
            }else {
            	showAlert( "${msgel.getMsg('AML_10_01_01_01_047', '변경사항이 없습니다.')}", "INFO");
            }
        }
  	}

  	//공통저장
  	function doSave() {
  		GridObj2.saveEditData();

  		showConfirm('${msgel.getMsg("AML_10_02_01_01_002","저장 하시겠습니까?")}', "저장",function(){

		var RA_ITEM_CD       = form1.RA_ITEM_CD.value;
		var RA_REF_SN_CCD    = form3.RA_REF_SN_CCD.value;
		var RA_SN_CCD        = form3.RA_SN_CCD.value;
		var RA_SEQ           = form3.RA_SEQ.value;
		var allRowsData      = getDataSource(GridObj2);
        var classID		     = "AML_10_37_01_05";
    	var methodID	     = "doSave";
    	var params           = new Object();
    	params.pageID        = pageID;
    	params.RA_ITEM_CD    = RA_ITEM_CD;
    	params.RA_REF_SN_CCD = RA_REF_SN_CCD;
    	params.RA_SEQ        = RA_SEQ;
    	params.RA_SN_CCD     = RA_SN_CCD;
        params.gridData      = allRowsData;

  		sendService(classID, methodID, params, doSave_end, doSave_fail);

    	});
  	}

  	function doSave_end() {
  		var RA_ITEM_GUBUN = form1.RA_ITEM_CD.value;
    	var INTV_VAL_YN   = form1.INTV_VAL_YN.value;
    	
    	if(RA_ITEM_GUBUN == "I001") {
			doSearch2();
    	}else if (RA_ITEM_GUBUN == "I002"){
			doSearch3();
    	}else if (RA_ITEM_GUBUN == "I003"){
			doSearch4();
  		}else if (INTV_VAL_YN == "Y" && RA_ITEM_GUBUN !="I001"&& RA_ITEM_GUBUN !="I002"&& RA_ITEM_GUBUN !="I003"){
			doSearch5();
		}else if (INTV_VAL_YN == "N" && RA_ITEM_GUBUN !="I001"&& RA_ITEM_GUBUN !="I002"&& RA_ITEM_GUBUN !="I003"){
			doSearch6();
		}
  	}

	function doSave_fail() { overlay.hide(); }

	function doDownload() {
    	var workbook = new ExcelJS.Workbook();
    	var worksheet = workbook.addWorksheet('Sheet1');
    	DevExpress.excelExporter.exportDataGrid({
    		component: GridObj2,
    		worksheet: worksheet,
    		autoFilterEnabled: true,
    	}).then(function() {
    		workbook.xlsx.writeBuffer().then(function(buffer) {
    			saveAs(new Blob([buffer], { type: 'application/octet-stream' }), '${pageTitle}.xlsx');
    		});
    	});
    }
    
	function doUpload() {
		form1.pageID.value = 'AML_10_37_01_09';
        window_popup_open(form1.pageID.value, 1400, 1000, '');
        form1.RA_ITEM_CD.value    = form1.RA_ITEM_CD.value;
        form1.target              = form1.pageID.value;
        form1.action              = "<c:url value='/'/>0001.do";
        form1.submit(); 
	}

</script>
<style>

.tree-conformation-area .t01-menu-on a::before {
    display:none;
}
.tree-conformation-area .t01-menu::before {
    display:none;
}
.tree-conformation-area .t01_area td:hover .t01-menu::before {
    display:none;
}
.tree-conformation-area .t01-menu-on nobr {
    padding-left : 0px;
}
.tree-conformation-area .dx-datagrid-table tbody td {
    border-right: 0px;
}
</style>

<form name="form3" method="post" >
	<input type="hidden" name="pageID" >
	<input type="hidden" name="RA_ITEM_CD">
	<input type="hidden" name="RA_SEQ">
    <input type="hidden" name="RA_APP_NO">
    <input type="hidden" name="POSITION_NAME">
    <input type="hidden" name="APP_NO">
    <input type="hidden" name="PRV_APP_NO">
    <input type="hidden" name="RA_REF_SN_CCD">
    <input type="hidden" name="RA_SN_CCD">
    <input type="hidden" name="INTV_VAL_YN">
    <input type="hidden" name="UPLOAD_GUBUN">
    <input type="hidden" name="recalculCNT1">
    <input type="hidden" name="recalculCNT2">
    
</form>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="RA_ITEM_CD">
    <input type="hidden" name="APP_NO">
    <input type="hidden" name="SNO">
    <input type="hidden" name="PRV_APP_NO">
</form>

<form name="form1" method="post">
	<input type="hidden" name="pageID">
    <input type="hidden" name="RA_ITEM_CD">
    <input type="hidden" name="RA_ITEM_CODE">
    <input type="hidden" name="CUR_ROW">
    <input type="hidden" name="SN_CCD">
    <input type="hidden" name="INTV_VAL_YN">
    <input type="hidden" name="SEARCH_GUBUN">
    <input type="hidden" name="RA_SN_CCD">
    <input type="hidden" name="RA_SEQ">
	<input type="hidden" name="RA_REF_SN_CCD">
	<input type="text"   name="temp"     id = "temp" style="display: none;">
    <input type="hidden" name="contentFile" id="contentFile">
    <input type="hidden" name="excelData"   id="excelData"  >

    <div id="RAITEMSCRFile" style="display: none;"></div>
    <div class="button-area"></div>
    <div class="tree-conformation-area">
	    <div class="tree-left" style="height:700px; overflow-y: scroll;">
	    	<%-- <h4 class="tree-title">${msgel.getMsg("AML_10_03_01_01_048","위험분류별 위험요소관리")}</h4> --%>
	     <ul class="tree-list" >
	        <li class="tree-item active">
	          <div id="htmlGrid"></div>
	       </li>
	     </ul>
	    </div>

     	<div id="template_right" class="tree-right" style="width:85%;">
        	<div id="subBizTitle" class="title" style="font-family:SpoqB;font-size: 20px;color: #444;letter-spacing: -0.4px;line-height: normal;" ></div>
				<%-- <h4 class="tree-title">${msgel.getMsg("AML_10_03_01_01_049","국가 위험요소")}</h4> --%>
				<br>
			<div class="ra-item-gubun" id="ra-item-gubun">
				<div class="inquiry-table">

					<div class="table-row"> 
						<div class="table-cell">
							${condel.getLabel('AML_10_36_01_01_030','상세코드내용')}
							<div class="content">
				            	<input name="RA_ITEM_NM" type="text" value="" size="23" />
							</div>
						</div> 
						<div class="risk1">
							<div class="table-cell">
								${condel.getSelect('{msgID:"AML_10_36_01_01_033", defaultValue:"위험요소", selectID:"RISK_ELMT_CDNT", width:"200", sqlID:"MDAO.AML_10_37_01_01_common_getComboData", firstComboWord:"ALL"}')}
							</div>
						</div>
						<div class="risk2">
							<div class="table-cell">
								${condel.getSelect('{msgID:"AML_10_36_01_01_033", defaultValue:"위험요소", selectID:"RISK_ELMT_CDIND", width:"200", sqlID:"MDAO.AML_10_37_01_01_common_getComboData2", firstComboWord:"ALL"}')}
							</div>
						</div>
						<div class="risk3">
							<div class="table-cell">
								${condel.getSelect('{msgID:"AML_10_36_01_01_033", defaultValue:"위험요소", selectID:"RISK_ELMT_CDCOR", width:"200", sqlID:"MDAO.AML_10_37_01_01_common_getComboData3", firstComboWord:"ALL"}')}
							</div>
						</div>
					</div>
					<div class="table-row">
						<div class="table-cell">
							${condel.getLabel('AML_10_36_01_01_031','상세코드')}
							<div class="content">
				            	<input name="RA_ITEM_CODE_SE" type="text" value="" size="10" />
							</div>
						</div>
						<div class="table-cell"> 
							 <div class="content">
							 	<select id="RISK_ELMT_CD2" name="RISK_ELMT_CD2" class="dropdown" >
							      <option class="dropdown-option" value="ALL">::전체::</option> 
					            </select>
					         </div>
						</div>

					</div>
					<div class="table-row">
						<div class="table-cell">
							${condel.getLabel('AML_10_36_01_01_029','당연 EDD여부')}
		            		<div class="content">
								<select name="ABS_HRSK_YN" id="ABS_HRSK_YN" class="dropdown">
									<option value="ALL">::전체::</option>
	                				<option value="Y">Y</option>
	                				<option value="H">H</option>
	                				<option value="YH">Y + H</option>
	                				<option value="N">N</option>
								</select>
							</div>
						</div>
						<div class="table-cell">
						</div>
					</div>
					<div class="table-row">
						<div class="table-cell">
							${condel.getLabel('AML_10_36_01_01_032','변동 구분')}
		            		<div class="content">
								<select name="RECAL_RA_SCR_NM" id="RECAL_RA_SCR_NM" class="dropdown">
	                				<option value="ALL">::전체::</option>
	                				<option value="U">위험점수 상승</option>
	                				<option value="D">위험점수 하락</option>
	                				<option value="M">위험점수 유지</option>
								</select>
							</div>
						</div>
						<div class="table-cell">
						</div>
					</div>

					<div class="table-row">
						<div class="table-cell">
						</div>

						<div class="table-cell" >
							<div class="button-area" style="padding-bottom:8px; padding-right:36px; position:absolute; right:0;">
								${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearchRe", cssClass:"btn-36 filled"}')}
							</div>
						</div>
					</div>
				</div>

				<div style="display:flex;">
					<div class="button-area">
						<label>결재상태</label>
						<input type=text  name="RA_SN_CCD_NM" id="RA_SN_CCD_NM" style="text-align: center; width:100px; margin-left:10px; margin-right:10px;"   readonly>
						${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"apprHistoryBtn", defaultValue:"결재이력", mode:"R", function:"PopKYCPage_Hist", cssClass:"btn-36"}')}
					</div>

			        <div class="button-area" style="width:100%;">
						${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"changeHisBtn", defaultValue:"변경이력", mode:"R", function:"doHistoryList", cssClass:"btn-36"}')}
						${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"excelDown37", defaultValue:"엑셀 다운로드", mode:"R", function:"doDownload", cssClass:"btn-36 outlined"}')}
						${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"excelUplode37", defaultValue:"엑셀 업로드", mode:"R", function:"doUpload", cssClass:"btn-36 upload"}')}
						${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"riskrecal", defaultValue:"위험점수 재계산", mode:"R", function:"reCalcul", cssClass:"btn-36 filled"}')}
			        <% if ( "4".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
			        	${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"approvalBtn", defaultValue:"결재", mode:"R", function:"PopKYCPage", cssClass:"btn-36"}')}
			        <% } %>
			        <% if ( "104".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
			        	${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"approvalBtn", defaultValue:"결재", mode:"R", function:"PopKYCPage3", cssClass:"btn-36"}')}
			        	${btnel.getButton(outputAuth, '{btnID:"btn_09", cdID:"denyBtn", defaultValue:"반려", mode:"R", function:"PopKYCPage2", cssClass:"btn-36"}')}
			        <% } %>
			        </div>
		        </div>
	        </div>

	        <div class="ra-item-gubun2" id="ra-item-gubun2">
	        	<div style="display:flex;">
					<div class="button-area">
						<label>결재상태</label>
						<input type=text  name="C_RA_SN_CCD_NM"  id="C_RA_SN_CCD_NM" style="text-align: center; width:100px; margin-left:10px; margin-right:10px;"   readonly>
						${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"apprHistoryBtn", defaultValue:"결재이력", mode:"R", function:"PopKYCPage_Hist", cssClass:"btn-36"}')}
					</div>
			        <div class="button-area" style="width:100%;">
						${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"changeHisBtn", defaultValue:"변경이력", mode:"R", function:"doHistoryList", cssClass:"btn-36"}')}
						${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"excelDown37", defaultValue:"엑셀 다운로드", mode:"R", function:"doDownload", cssClass:"btn-36 outlined"}')}
						<%-- ${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"excelUplode37", defaultValue:"엑셀 업로드", mode:"R", function:"doUpload", cssClass:"btn-36 upload"}')} --%>
			        <% if ( "4".equals(ROLEID)) { // 4:컴플라이언스운영팀 담당자,5:컴플라이언스운영팀 책임자,104:보고책임자 %> 
			        	${btnel.getButton(outputAuth, '{btnID:"btn_10", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave", cssClass:"btn-36"}')}
			        	${btnel.getButton(outputAuth, '{btnID:"btn_11", cdID:"approvalBtn", defaultValue:"결재", mode:"R", function:"PopKYCPage", cssClass:"btn-36"}')}
			        <% } %>
			        <% if ( "104".equals(ROLEID)) { // 4:컴플라이언스운영팀 담당자,5:컴플라이언스운영팀 책임자,104:보고책임자 %>
			        	${btnel.getButton(outputAuth, '{btnID:"btn_12", cdID:"approvalBtn", defaultValue:"결재", mode:"R", function:"PopKYCPage3", cssClass:"btn-36"}')}
			        	${btnel.getButton(outputAuth, '{btnID:"btn_13", cdID:"denyBtn", defaultValue:"반려", mode:"R", function:"PopKYCPage2", cssClass:"btn-36"}')}
			        <% } %>
			        </div>
		        </div>
	        </div>

	        <br>
            <div id="GTDataGrid2_Area"></div>
        </div>
    </div>
	<div id="GTDataGrid1_Area" style="display : none;"></div>
	<div id="RAListFile" style="display:none;" />
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />