<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
- File Name  : AML_10_25_01_03.jsp
- Author     :  
- Comment    : 신상품위험평가 체크리스트 상세화면
- Version    : 1.0
- history    : 1.0 2025-06
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
--%>
<%@ page import="com.gtone.webadmin.util.JSONUtil,com.gtone.webadmin.util.CodeUtil"%>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%
    
    String prdCkId = Util.nvl( request.getParameter("PRD_CK_ID") );
    String appNo = Util.nvl( request.getParameter("APP_NO") );
    String snCcd = Util.nvl( request.getParameter("SN_CCD") );
    String appState = Util.nvl( request.getParameter("APP_STATE") );
    String TARGET_ROLE_ID = Util.nvl( request.getParameter("TARGET_ROLE_ID") );
    String rsncntnt = Util.nvl( request.getParameter("RSN_CNTNT") );
    
    request.setAttribute("PRD_CK_ID", prdCkId);
    request.setAttribute("APP_NO", appNo);
    request.setAttribute("SN_CCD", snCcd);
    request.setAttribute("APP_STATE", appState);
    request.setAttribute("TARGET_ROLE_ID", TARGET_ROLE_ID);
    request.setAttribute("RSN_CNTNT", rsncntnt);
    
    //세션 결재자 정보
  	String ROLEID = sessionAML.getsAML_ROLE_ID();
  	request.setAttribute("ROLEID", ROLEID);
  	
	DataObj inputApr = new DataObj();
	inputApr.put("CD","S104");
	inputApr.put("GUBUN", "PRD01");
	com.gtone.aml.basic.common.data.DataObj obj = null;
	
	try{
		
		obj = com.gtone.aml.dao.common.MDaoUtilSingle.getData("AML_APR_YN", inputApr);
		
	}catch(AMLException e){
		Log.logAML(Log.ERROR, e);
	}
	
	String FIRST_APP_ID = obj.getText("FIRST_APP_ID");
	String[] REPLCE_FIRST_APP_ID = FIRST_APP_ID.split("-");
	
	String FIRST_SNO = "";
	for( int i=0 ; i < REPLCE_FIRST_APP_ID.length ; i++ ){
		
		if( i == 0 ){
			
			FIRST_APP_ID = REPLCE_FIRST_APP_ID[0];
			request.setAttribute("FIRST_APP_ID", FIRST_APP_ID);
			
		}else if( i == 1){
			
			FIRST_SNO = REPLCE_FIRST_APP_ID[1];
			request.setAttribute("FIRST_SNO", FIRST_SNO);
		}
	}
	
%> 

<script language="JavaScript"> 

	var overlay = new Overlay();
	var prdCkId = '<c:out value="${PRD_CK_ID}"/>';
	var GridObjArr = [];
	var GridObj1 = null;
	var GridObj2 = null;
	var GridObj3 = null;
	var GridObj4 = null;
	var GridObj5 = null;
	var GridObj6 = null;
	var dataSource1 = [];
	var dataSource2 = [];
	var dataSource3 = [];
	var dataSource4 = [];
	var dataSource5 = [];
	var dataSource6 = [];
	var TARGET_ROLE_ID = "${TARGET_ROLE_ID}";
    var ROLEID         = "${ROLEID}";
    var APP_NO         = "${APP_NO}";
    var RSN_CNTNT      = "${RSN_CNTNT}";
	// [ Initialize ]
	$(document).ready(function(){
		
		$("#VERSION_ID").prop("disabled", true);
		$("#TITLE").prop("disabled", true);
		$("#APP_STATE").prop("disabled", true);
		
		if(TARGET_ROLE_ID == ROLEID) {
    		$("#btn_03").show();
    		$("#btn_04").show();
    	}else {
    		$("#btn_03").hide();
    		$("#btn_04").hide();
        }
		
		setupGrids();
	    doSearch();
	});
	
	function setupGrids(){
    	
      try{
    	  
    	  GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
		          elementAttr : { class: "grid-table-type" },
			     "dataSource"                : dataSource1 ,
	       		 "height"					 : "calc(29vh)",
	       	     "hoverStateEnabled"         : true,
	   	         "wordWrapEnabled"           : false,
	   	         "allowColumnResizing"       : true,
	   	         "columnAutoWidth"           : true,
	   	         "allowColumnReordering"     : true,
	   	         "cacheEnabled"              : false,
	   	         "cellHintEnabled"           : true,
	   	         "showBorders"               : true,
	   	         "showColumnLines"           : true,
	   	         "showRowLines"              : true,
	   	         "loadPanel"                 : {enabled: false},
	   	         "export":{
	   	            "allowExportSelectedData": false, "enabled" : false, "excelFilterEnabled" : false, "fileName": "gridExport"
	   	         },
	   	         "sorting":{ "mode" : "multiple" },
	   	         "remoteOperations":{
	   	            "filtering": false, "grouping": false,"paging": false, "sorting": false, "summary" : false
	   	         },
	   	         "editing":{
	   	             "mode": "cell",	"allowUpdating": true,	"allowAdding": false,	"allowDeleting": false
	   	         },
	   	         "filterRow": {"visible"     : false},
	   	         "rowAlternationEnabled"     : false,
	   	         "columnFixing": {"enabled"  : true},
	   	         "paging": {"enabled"        : false},
	   	         "searchPanel":{
	   	             "visible"               : false,
	   	             "width"                 : 250
	   	         },
	   	         "selection":{
	   	             "allowSelectAll" : true,"deferred": false,"mode":"single","selectAllMode": "allPages","showCheckBoxesMode"    : "onClick"
	   	         },
	   	         "columns":[
	   	                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
	   	                	, "lookup" : {
	   	    	                    dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P101"))%>
	   	    		              ,displayExpr : "VALUE"
	   	    		              ,valueExpr   : "KEY"
	   	    	            }
	   	                }
	     	          , {"dataField":"SRT_ORDR", "caption": '순서',"alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
	   	              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
	   	              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
	   	              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
	   	              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
	   	         ]
	       	}).dxDataGrid("instance");
    	 
    	  GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
    		     elementAttr : { class: "grid-table-type" },
			     "dataSource"                : dataSource2 ,
	       		 "height"					 : "calc(29vh)",
	       	     "hoverStateEnabled"         : true,
	   	         "wordWrapEnabled"           : false,
	   	         "allowColumnResizing"       : true,
	   	         "columnAutoWidth"           : true,
	   	         "allowColumnReordering"     : true,
	   	         "cacheEnabled"              : false,
	   	         "cellHintEnabled"           : true,
	   	         "showBorders"               : true,
	   	         "showColumnLines"           : true,
	   	         "showRowLines"              : true,
	   	         "loadPanel"                 : {enabled: false},
	   	         "export":{
	   	            "allowExportSelectedData": false, "enabled" : false, "excelFilterEnabled" : false, "fileName": "gridExport"
	   	         },
	   	         "sorting":{ "mode" : "multiple" },
	   	         "remoteOperations":{
	   	            "filtering": false, "grouping": false,"paging": false, "sorting": false, "summary" : false
	   	         },
	   	         "editing":{
	   	             "mode": "cell",	"allowUpdating": true,	"allowAdding": false,	"allowDeleting": false
	   	         },
	   	         "filterRow": {"visible"     : false},
	   	         "rowAlternationEnabled"     : false,
	   	         "columnFixing": {"enabled"  : true},
	   	         "paging": {"enabled"        : false},
	   	         "searchPanel":{
	   	             "visible"               : false,
	   	             "width"                 : 250
	   	         },
	   	         "selection":{
	   	             "allowSelectAll" : true,"deferred": false,"mode":"single","selectAllMode": "allPages","showCheckBoxesMode"    : "onClick"
	   	         },
		   	      "columns":[
	 	                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
	 	                	, "lookup" : {
	 	    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P102"))%>
	 	    		              ,displayExpr : "VALUE"
	 	    		              ,valueExpr   : "KEY"
	 	    	            }
	 	                }
	   	              , {"dataField":"SRT_ORDR", "caption": '순서',"alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
	 	              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
	 	              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
	 	              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
	 	              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
	 	         ]
	       	}).dxDataGrid("instance");
    	  
    	  GridObj3 = $("#GTDataGrid3_Area").dxDataGrid({
    		      elementAttr : { class: "grid-table-type" },
			     "dataSource"                : dataSource3 ,
	       		 "height"					 : "calc(29vh)",
	       	     "hoverStateEnabled"         : true,
	   	         "wordWrapEnabled"           : false,
	   	         "allowColumnResizing"       : true,
	   	         "columnAutoWidth"           : true,
	   	         "allowColumnReordering"     : true,
	   	         "cacheEnabled"              : false,
	   	         "cellHintEnabled"           : true,
	   	         "showBorders"               : true,
	   	         "showColumnLines"           : true,
	   	         "showRowLines"              : true,
	   	         "loadPanel"                 : {enabled: false},
	   	         "export":{
	   	            "allowExportSelectedData": false, "enabled" : false, "excelFilterEnabled" : false, "fileName": "gridExport"
	   	         },
	   	         "sorting":{ "mode" : "multiple" },
	   	         "remoteOperations":{
	   	            "filtering": false, "grouping": false,"paging": false, "sorting": false, "summary" : false
	   	         },
	   	         "editing":{
	   	             "mode": "cell",	"allowUpdating": true,	"allowAdding": false,	"allowDeleting": false
	   	         },
	   	         "filterRow": {"visible"     : false},
	   	         "rowAlternationEnabled"     : false,
	   	         "columnFixing": {"enabled"  : true},
	   	         "paging": {"enabled"        : false},
	   	         "searchPanel":{
	   	             "visible"               : false,
	   	             "width"                 : 250
	   	         },
	   	         "selection":{
	   	             "allowSelectAll" : true,"deferred": false,"mode":"single","selectAllMode": "allPages","showCheckBoxesMode"    : "onClick"
	   	         },
		   	      "columns":[
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P103"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
	 	          , {"dataField":"SRT_ORDR", "caption": '순서',"alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		         ]
	       	}).dxDataGrid("instance");
    	  
    	  GridObj4 = $("#GTDataGrid4_Area").dxDataGrid({
    		     elementAttr : { class: "grid-table-type" },
			     "dataSource"                : dataSource4 ,
	       		 "height"					 : "calc(29vh)",
	       	     "hoverStateEnabled"         : true,
	   	         "wordWrapEnabled"           : false,
	   	         "allowColumnResizing"       : true,
	   	         "columnAutoWidth"           : true,
	   	         "allowColumnReordering"     : true,
	   	         "cacheEnabled"              : false,
	   	         "cellHintEnabled"           : true,
	   	         "showBorders"               : true,
	   	         "showColumnLines"           : true,
	   	         "showRowLines"              : true,
	   	         "loadPanel"                 : {enabled: false},
	   	         "export":{
	   	            "allowExportSelectedData": false, "enabled" : false, "excelFilterEnabled" : false, "fileName": "gridExport"
	   	         },
	   	         "sorting":{ "mode" : "multiple" },
	   	         "remoteOperations":{
	   	            "filtering": false, "grouping": false,"paging": false, "sorting": false, "summary" : false
	   	         },
	   	         "editing":{
	   	             "mode": "cell",	"allowUpdating": true,	"allowAdding": false,	"allowDeleting": false
	   	         },
	   	         "filterRow": {"visible"     : false},
	   	         "rowAlternationEnabled"     : false,
	   	         "columnFixing": {"enabled"  : true},
	   	         "paging": {"enabled"        : false},
	   	         "searchPanel":{
	   	             "visible"               : false,
	   	             "width"                 : 250
	   	         },
	   	         "selection":{
	   	             "allowSelectAll" : true,"deferred": false,"mode":"single","selectAllMode": "allPages","showCheckBoxesMode"    : "onClick"
	   	         },
		   	      "columns":[
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P104"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
		          , {"dataField":"SRT_ORDR", "caption": '순서',"alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		         ]
	       	}).dxDataGrid("instance");
    	  
    	  GridObj5 = $("#GTDataGrid5_Area").dxDataGrid({
    		     elementAttr : { class: "grid-table-type" },
			     "dataSource"                : dataSource5 ,
	       		 "height"					 : "calc(29vh)",
	       	     "hoverStateEnabled"         : true,
	   	         "wordWrapEnabled"           : false,
	   	         "allowColumnResizing"       : true,
	   	         "columnAutoWidth"           : true,
	   	         "allowColumnReordering"     : true,
	   	         "cacheEnabled"              : false,
	   	         "cellHintEnabled"           : true,
	   	         "showBorders"               : true,
	   	         "showColumnLines"           : true,
	   	         "showRowLines"              : true,
	   	         "loadPanel"                 : {enabled: false},
	   	         "export":{
	   	            "allowExportSelectedData": false, "enabled" : false, "excelFilterEnabled" : false, "fileName": "gridExport"
	   	         },
	   	         "sorting":{ "mode" : "multiple" },
	   	         "remoteOperations":{
	   	            "filtering": false, "grouping": false,"paging": false, "sorting": false, "summary" : false
	   	         },
	   	         "editing":{
	   	             "mode": "cell",	"allowUpdating": true,	"allowAdding": false,	"allowDeleting": false
	   	         },
	   	         "filterRow": {"visible"     : false},
	   	         "rowAlternationEnabled"     : false,
	   	         "columnFixing": {"enabled"  : true},
	   	         "paging": {"enabled"        : false},
	   	         "searchPanel":{
	   	             "visible"               : false,
	   	             "width"                 : 250
	   	         },
	   	         "selection":{
	   	             "allowSelectAll" : true,"deferred": false,"mode":"single","selectAllMode": "allPages","showCheckBoxesMode"    : "onClick"
	   	         },
		   	      "columns":[
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P105"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
		          , {"dataField":"SRT_ORDR", "caption": '순서',"alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		         ]
	       	}).dxDataGrid("instance");
    	  
    	  GridObj6 = $("#GTDataGrid6_Area").dxDataGrid({
    		     elementAttr : { class: "grid-table-type" },
			     "dataSource"                : dataSource6 ,
	       		 "height"					 : "calc(29vh)",
	       	     "hoverStateEnabled"         : true,
	   	         "wordWrapEnabled"           : false,
	   	         "allowColumnResizing"       : true,
	   	         "columnAutoWidth"           : true,
	   	         "allowColumnReordering"     : true,
	   	         "cacheEnabled"              : false,
	   	         "cellHintEnabled"           : true,
	   	         "showBorders"               : true,
	   	         "showColumnLines"           : true,
	   	         "showRowLines"              : true,
	   	         "loadPanel"                 : {enabled: false},
	   	         "export":{
	   	            "allowExportSelectedData": false, "enabled" : false, "excelFilterEnabled" : false, "fileName": "gridExport"
	   	         },
	   	         "sorting":{ "mode" : "multiple" },
	   	         "remoteOperations":{
	   	            "filtering": false, "grouping": false,"paging": false, "sorting": false, "summary" : false
	   	         },
	   	         "editing":{
	   	             "mode": "cell",	"allowUpdating": true,	"allowAdding": false,	"allowDeleting": false
	   	         },
	   	         "filterRow": {"visible"     : false},
	   	         "rowAlternationEnabled"     : false,
	   	         "columnFixing": {"enabled"  : true},
	   	         "paging": {"enabled"        : false},
	   	         "searchPanel":{
	   	             "visible"               : false,
	   	             "width"                 : 250
	   	         },
	   	         "selection":{
	   	             "allowSelectAll" : true,"deferred": false,"mode":"single","selectAllMode": "allPages","showCheckBoxesMode"    : "onClick"
	   	         },
		   	      "columns":[
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P106"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
		              , {"dataField":"SRT_ORDR", "caption": '순서',"alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "50%", "encodeHtml":false}
		              , {"dataField":"EVLTN_STND", "visible" : false }
		              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%"}
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		         ]
	   	         
	       	}).dxDataGrid("instance");
    	  
      }catch(e){
    	  console.log('errr:'+e);
      }
    }
    
    function doSearch(){
    	
    	overlay.show(true, true);
    	
        var params = new Object();
        
        if( !isEmpty(prdCkId)  ){
           params.PRD_CK_ID = prdCkId;
        }
        
        sendService("AML_10_25_01_02", "getSearch", params, doSearch_end, doSearch_end); 
    }
    
    function doSearch_end(gridData, actionParam){
    	
    	overlay.hide();
    	
		dataSource1.length = 0;
    	dataSource2.length = 0;
    	dataSource3.length = 0;
    	dataSource4.length = 0;
    	dataSource5.length = 0;
    	dataSource6.length = 0;
    	
        for( var i = 0 ;  i < gridData.length ; i++ ){
        	
        	if( gridData[i].GR == 1 ){
        		dataSource1.push(gridData[i]);
        	}else if( gridData[i].GR == 2 ){
        		dataSource2.push(gridData[i]);
        	}else if( gridData[i].GR == 3 ){
        		dataSource3.push(gridData[i]);
        	}else if( gridData[i].GR == 4 ){
        		dataSource4.push(gridData[i]);
        	}else if( gridData[i].GR == 5 ){
        		dataSource5.push(gridData[i]);
        	}else if( gridData[i].GR == 6 ){
        		dataSource6.push(gridData[i]);
        	}
        }
        
        GridObj1.option("dataSource", dataSource1);
        GridObj1.refresh();
        GridObj2.option("dataSource", dataSource2);
        GridObj2.refresh();
        GridObj3.option("dataSource", dataSource3);
        GridObj3.refresh();
        GridObj4.option("dataSource", dataSource4);
        GridObj4.refresh();
        GridObj5.option("dataSource", dataSource5);
        GridObj5.refresh();
        GridObj6.option("dataSource", dataSource6);
        GridObj6.refresh();
        
     	$("#VERSION_ID").val(gridData[0].VERSION_ID);
     	$("#TITLE").val(gridData[0].TITLE);
     	$("#APP_STATE").val('<c:out value="${APP_STATE}"/>');
     	
    }
    
    function doApprReq( target ){
 	   
      var msg = "", msg2 ="" ;
      var targetPageId = "AML_10_25_01_04";
      
	  if( target == "S" ){
    		
    	msg = '${msgel.getMsg("AML_10_25_01_02_025","결재 하시겠습니까?")}'
    	msg2 = '${msgel.getMsg("AML_10_25_01_02_019","결재")}'
    		targetPageId = "AML_10_25_01_04";
    	
      }else{
    		
    	msg = '${msgel.getMsg("AML_10_25_01_02_026","반려 하시겠습니까?")}'
    	msg2 = '${msgel.getMsg("AML_10_25_01_02_020","반려")}'
    		targetPageId = "AML_10_25_01_05";
      }
	
  	  showConfirm( msg, msg2, function(){
  		  
  		  form2.dis_flag.value = "P";
  		  form2.pageID.value = targetPageId;
  		  form2.APP_NO.value = APP_NO;
  		  form2.RSN_CNTNT.value = RSN_CNTNT;
  		  form2.target = targetPageId;
  		  form2.action = '${path}/0001.do';
  		  form2.method = "post";
          window_popup_open(form2.pageID.value, 600, 450, '','yes');
     	  form2.submit();
     	  form2.target = '';
  	  });
    }
    
    function doAppr( rsnCntnt, target ){
	  	
    	var classID = "AML_10_25_01_02";
     	var methodID = "doAppr"
     	var ROLEID = '<c:out value="${ROLEID}"/>';
        var params = new Object();
        params.PRD_CK_ID = prdCkId;
        params.APP_NO = '<c:out value="${APP_NO}"/>';
        params.RSN_CNTNT = rsnCntnt;
        //params.SN_CCD = target;   // S:승인요청, R:반려, E:승인완료
        
        if(target=='R') {
        	if("104" == ROLEID) {
            	params.FIRST_SNO = "2";
            	params.SN_CCD = target;
            }
		}else if(target=='S') {
			if("104" == ROLEID) {
        		params.FIRST_SNO = "2";
        		params.SN_CCD = target;
			}

 		}
        
        
        
        sendService(classID, methodID, params, doApprSucc, doApprFail );
     }
    
    function doApprSucc(){
 	   
 	   overlay.hide();
    	
 	   if( opener ){
 	     opener.doSearch();
       }
 	   
 	   doClose();
    }
    
    function doApprFail(){
 	   
 	   overlay.hide();
    }
    
    function doClose(){
    	
    	window.close();
    }
 
    function isEmpty( str ){
    	
    	if( str == null || str == "" || (str+"").trim().length == 0 || str == undefined ){
    		return true;
    	}

    	return false;
    }
    
 </script>

<form name="form2" method="post" >
 <input type="hidden" name="pageID" > 
 <input type="hidden" name="manualID" >
 <input type="hidden" name="classID" > 
 <input type="hidden" name="methodID" >
 <input type="hidden" name="dis_flag" >
 <input type="hidden" name="APP_NO" >
 <input type="hidden" name="RSN_CNTNT" >
</form>

<form name="form1" id="form1" method="post"> 
 <input type="hidden" name="pageID" > 
 <input type="hidden" name="manualID" > 
 <input type="hidden" name="classID" > 
 <input type="hidden" name="methodID" > 
 
 <div class="inquiry-table type1">
	   <div class="table-row"  >
		 <div class="table-cell">
		   ${condel.getInputText('{msgID:"AML_10_25_01_02_014", defaultValue:"체크리스트 버전 일련번호", name:"VERSION_ID", style:"margin-left:10px;margin-right:10px;", size:"20", maxLength:"50"}')}
		 </div>
	   </div>
	   
	   <div class="table-row"  >
		 <div class="table-cell">
		   ${condel.getInputText('{msgID:"AML_10_25_01_02_015", defaultValue:"체크리스트 개요", name:"TITLE", style:"margin-left:10px;margin-right:10px;", size:"50", maxLength:"300"}')}
		 </div>
	   </div>
	   
	   <div class="table-row"  >
		 <div class="table-cell">
		   ${condel.getInputText('{msgID:"AML_10_25_01_02_016", defaultValue:"결재상태", name:"APP_STATE", style:"margin-left:10px;margin-right:10px;", size:"25", maxLength:"50"}')}
		 </div>
	   </div>
  </div>   
 
  <div class="tab-content-bottom" style="margin-top:15px;">
   
    <div class="tab-content-bottom">
      <h3 class="tab-content-title">${msgel.getMsg('AML_10_25_01_02_005', '1.신상품/서비스 개요')}</h3>
	  <div class="button-area" >
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_01_02_006', '1-1.절차/시스템의 변경여부')}</h2>
	    </div>
	  </div>
      <div id="GTDataGrid1_Area"></div>
    </div>
	
	<br/>
	
    <div class="tab-content-bottom">
      <h3 class="tab-content-title" >${msgel.getMsg('AML_10_25_01_02_007', '2.상품고유위험 평가')}</h3> 
	  <div class="button-area" >
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_01_02_008', '2-1.당연고위험 상품')}</h2>
	    </div>
	 </div>
     <div id="GTDataGrid2_Area"></div>
    </div>
    
    <br/>
    
    <div class="tab-content-bottom">
      <div class="button-area">    
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_01_02_009', '2-2.고객위험')}</h2>
	    </div>
	  </div>
      <div id="GTDataGrid3_Area"></div>
    </div>
    
    <br/>
    
    <div class="tab-content-bottom">
	  <div class="button-area">    
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_01_02_010', '2-3.상품위험')}</h2>
	    </div>
	 </div>
     <div id="GTDataGrid4_Area"></div>
    </div>
    
    <br/>
    
	<div class="tab-content-bottom">
	  <div class="button-area">    
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_01_02_012', '2-4.채널위험')}</h2>
	    </div>
	 </div>
     <div id="GTDataGrid5_Area"></div>
    </div>
    
    <br/>
	
    <div class="tab-content-bottom">
	  <div class="button-area">    
	    <div style="width:70%;>
 	      <h3 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_01_02_013', '3.통제위험평가')}</h3>
	    </div>
	 </div>
     <div id="GTDataGrid6_Area"></div>
    </div>		        		        
							
 </div>
 
   <div class="button-area" style="display:flex; justify-content: flex-end; padding-top: 8px;">
    
    <% if( "104".equals(ROLEID)) { // 107:신상품 자금세탁위험평가 담당자, 108:신상품 자금세탁위험평가 책임자, 4:컴플라이언스운영팀 담당자, 104:보고책임자  %>
     <button type="button" onclick="doApprReq('S')" id="btn_03" class="btn-36" mode="U">${msgel.getMsg("AML_10_25_01_02_019","결재")}</button>
     <button type="button" onclick="doApprReq('R')" id="btn_04" class="btn-36" mode="U">${msgel.getMsg("AML_10_25_01_02_020","반려")}</button>
    <% } %>
   
	${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
	
 </div>
</form> 

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />