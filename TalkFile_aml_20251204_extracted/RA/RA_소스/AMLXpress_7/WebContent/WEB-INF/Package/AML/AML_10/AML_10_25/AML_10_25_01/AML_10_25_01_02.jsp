<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
- File Name  : AML_10_25_01_02.jsp
- Author     :  
- Comment    : 신상품위험평가 체크리스트 신규등록
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
    String appState = Util.nvl( request.getParameter("APP_STATE") );  
    String snCcd = Util.nvl( request.getParameter("SN_CCD") );
    String TARGET_ROLE_ID = Util.nvl( request.getParameter("TARGET_ROLE_ID") );
    
	request.setAttribute("PRD_CK_ID", prdCkId);
	request.setAttribute("APP_NO", appNo);
	request.setAttribute("APP_STATE", appState);
    request.setAttribute("SN_CCD", snCcd);
    request.setAttribute("TARGET_ROLE_ID", TARGET_ROLE_ID);
    
	
	//세션 결재자 정보
	String ROLEID = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLEID", ROLEID);
	
	// 세션 부서 
	DataObj inputApr = new DataObj();
	inputApr.put("CD","S104");
	inputApr.put("GUBUN", "PRD01");
	com.gtone.aml.basic.common.data.DataObj obj = null;
	
	try{
		
		obj = com.gtone.aml.dao.common.MDaoUtilSingle.getData("AML_APR_YN", inputApr);
		
	}catch(AMLException e){
		Log.logAML(Log.ERROR, e);
	}
	
	// 최초결재자ID
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
    
    // [ Initialize ]
    $(document).ready(function(){
    	
    	$("#VERSION_ID").prop("disabled", true);
    	$("#APP_STATE").prop("disabled", true);
    	
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
	   	              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고 예시')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
	   	              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
		              , {"dataField":"REG_DT", "caption": 'REG_DT',"visible" : false }
		              , {"dataField":"UPDATEGUBUN","caption": "수정구분","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "8%"}
	   	         ]
	   	        ,"onEditorPreparing": function(e) {  
	   	        	if (e.parentType == "dataRow" && ( e.dataField == "EVLTN_ITEM" || e.dataField == "EVLTN_STND" ) ){  
			   	         e.editorName = "dxTextArea";  
			   	     }  
			   	 }  
	   	         ,"onCellClick" : function(e) {
	   	        	 if (e.component.isRowSelected(e.key) && e.columnIndex != 1 && e.columnIndex != 5) {
	   	    	            e.component.editCell(e.rowIndex,e.columnIndex);
	   	    	            
	   	    	        } else {
	   	    	            e.component.clearSelection();
	   	    	            e.component.selectRowsByIndexes(e.rowIndex);
	   	    	            clickRowGrid( "1", e.data, e.rowIndex);
	   	    	        }
	   	    	    }
	   	         ,"onRowUpdating" : function(e) {
	   	        	const targetCols = ["RISK_TP_CD","EVLTN_ITEM", "EVLTN_STND", "EVLTN_RMRK"];
	   	        	targetCols.forEach(col => {

	   	        		if(e.newData[col] !== undefined && e.newData[col] !== e.oldData[col]) {
							e.newData["UPDATEGUBUN"] = "변경";
	   	        		}
	   	        	});
	   	         }
	   	         
	   	         ,"onRowInserting" : function(e) {
	   	        	    e.data["LV1"] = 1;
   	    	            e.data["LV2"] = 1;
	   	    	        e.data["SRT_ORDR"] = e.component.totalCount()+1;
	   	    	     	e.data["UPDATEGUBUN"] = "추가";
	   	    	        $("#upBtn1").prop("disabled", true);
	   	    			$("#downBtn1").prop("disabled", true);
	   	    	    }
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
	   	              , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
	 	              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" , "encodeHtml":false }
	 	              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
	 	              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고 예시')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
	 	              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
		              , {"dataField":"REG_DT", "caption": 'REG_DT',"visible" : false }
		              , {"dataField":"UPDATEGUBUN","caption": "수정구분","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "8%"}
	 	         ]
	   	        ,"onEditorPreparing": function(e) {  
			   	    if (e.parentType == "dataRow" && ( e.dataField == "EVLTN_ITEM" || e.dataField == "EVLTN_STND" ) ){  
			   	         e.editorName = "dxTextArea";  
			   	     }  
			   	 }  
	   	         ,"onCellClick" : function(e) {
	   	        	 
	   	        	 if (e.component.isRowSelected(e.key) && e.columnIndex != 1 && e.columnIndex != 5) {
	   	    	            e.component.editCell(e.rowIndex,e.columnIndex);
	   	    	        } else {
	   	    	            e.component.clearSelection();
	   	    	            e.component.selectRowsByIndexes(e.rowIndex);
	   	    	            clickRowGrid( "2", e.data, e.rowIndex);
	   	    	        }
	   	    	    }
	   	      	,"onRowUpdating" : function(e) {
	   	        	const targetCols = ["RISK_TP_CD","EVLTN_ITEM", "EVLTN_STND", "EVLTN_RMRK"];
	   	        	targetCols.forEach(col => {

	   	        		if(e.newData[col] !== undefined && e.newData[col] !== e.oldData[col]) {
							e.newData["UPDATEGUBUN"] = "변경";
	   	        		}
	   	        	});
	   	         }
	   	         ,"onRowInserting" : function(e) {
	   	    	        e.data["LV1"] = 2;
	   	    	        e.data["LV2"] = 1;
	   	    	        e.data["RSNB_HRSK_RLVN_YN"] = 'Y';
	   	    	        e.data["SRT_ORDR"] = e.component.totalCount()+1;
	   	    	     	e.data["UPDATEGUBUN"] = "추가";
	   	    	        $("#upBtn2").prop("disabled", true);
	   	    			$("#downBtn2").prop("disabled", true);
	   	    	    }
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
	 	          , {"dataField":"SRT_ORDR","caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false  }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고 예시')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
		              , {"dataField":"REG_DT", "caption": 'REG_DT',"visible" : false }
		              , {"dataField":"UPDATEGUBUN","caption": "수정구분","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "8%"}
		         ]
	   	        ,"onEditorPreparing": function(e) {  
			   	    if (e.parentType == "dataRow" && ( e.dataField == "EVLTN_ITEM" || e.dataField == "EVLTN_STND" ) ){  
			   	         e.editorName = "dxTextArea";  
			   	     }  
			   	 }  
	   	         ,"onCellClick" : function(e) {
	   	        	 
	   	        	 if (e.component.isRowSelected(e.key) && e.columnIndex != 1 && e.columnIndex != 5) {
	   	    	            e.component.editCell(e.rowIndex,e.columnIndex);
	   	    	        } else {
	   	    	            e.component.clearSelection();
	   	    	            e.component.selectRowsByIndexes(e.rowIndex);
	   	    	            clickRowGrid( "3", e.data, e.rowIndex);
	   	    	        }
	   	    	    }
	   	      	,"onRowUpdating" : function(e) {
	   	        	const targetCols = ["RISK_TP_CD","EVLTN_ITEM", "EVLTN_STND", "EVLTN_RMRK"];
	   	        	targetCols.forEach(col => {

	   	        		if(e.newData[col] !== undefined && e.newData[col] !== e.oldData[col]) {
							e.newData["UPDATEGUBUN"] = "변경";
	   	        		}
	   	        	});
	   	         }
	   	         ,"onRowInserting" : function(e) {
	   	        	    e.data["LV1"] = 2;
   	    	            e.data["LV2"] = 2;
	   	    	        e.data["SRT_ORDR"] = e.component.totalCount()+1;
	   	    	     	e.data["UPDATEGUBUN"] = "추가";
	   	    	        $("#upBtn3").prop("disabled", true);
	   	    			$("#downBtn3").prop("disabled", true);
	   	    	    }
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
		          , {"dataField":"SRT_ORDR","caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false  }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고 예시')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
		              , {"dataField":"REG_DT", "caption": 'REG_DT',"visible" : false }
		              , {"dataField":"UPDATEGUBUN","caption": "수정구분","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "8%"}
		         ]
	   	        ,"onEditorPreparing": function(e) {  
			   	    if (e.parentType == "dataRow" && ( e.dataField == "EVLTN_ITEM" || e.dataField == "EVLTN_STND" ) ){  
			   	         e.editorName = "dxTextArea";  
			   	     }  
			   	 }  
	   	         ,"onCellClick" : function(e) {
	   	        	 
	   	        	 if (e.component.isRowSelected(e.key) && e.columnIndex != 1 && e.columnIndex != 5) {
	   	    	            e.component.editCell(e.rowIndex,e.columnIndex);
	   	    	        } else {
	   	    	            e.component.clearSelection();
	   	    	            e.component.selectRowsByIndexes(e.rowIndex);
	   	    	            clickRowGrid( "4", e.data, e.rowIndex);
	   	    	        }
	   	    	    }
	   	      	,"onRowUpdating" : function(e) {
	   	        	const targetCols = ["RISK_TP_CD","EVLTN_ITEM", "EVLTN_STND", "EVLTN_RMRK"];
	   	        	targetCols.forEach(col => {

	   	        		if(e.newData[col] !== undefined && e.newData[col] !== e.oldData[col]) {
							e.newData["UPDATEGUBUN"] = "변경";
	   	        		}
	   	        	});
	   	         }
	   	         ,"onRowInserting" : function(e) {
	   	        	    e.data["LV1"] = 2;
	    	            e.data["LV2"] = 3;
	   	    	        e.data["SRT_ORDR"] = e.component.totalCount()+1;
	   	    	     	e.data["UPDATEGUBUN"] = "추가";
	   	    	        $("#upBtn4").prop("disabled", true);
	   	    			$("#downBtn4").prop("disabled", true);
	   	    	    }
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
		          , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false  }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고 예시')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "20%"}
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
		              , {"dataField":"REG_DT", "caption": 'REG_DT',"visible" : false }
		              , {"dataField":"UPDATEGUBUN","caption": "수정구분","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "8%"}
		         ]
	   	        ,"onEditorPreparing": function(e) {  
			   	    if (e.parentType == "dataRow" && ( e.dataField == "EVLTN_ITEM" || e.dataField == "EVLTN_STND" ) ){  
			   	         e.editorName = "dxTextArea";  
			   	     }  
			   	 }  
	   	         ,"onCellClick" : function(e) {
	   	        	 
	   	        	 if (e.component.isRowSelected(e.key) && e.columnIndex != 1 && e.columnIndex != 5) {
	   	    	            e.component.editCell(e.rowIndex,e.columnIndex);
	   	    	        } else {
	   	    	            e.component.clearSelection();
	   	    	            e.component.selectRowsByIndexes(e.rowIndex);
	   	    	            clickRowGrid("5", e.data, e.rowIndex);
	   	    	        }
	   	    	    }
	   	      	,"onRowUpdating" : function(e) {
	   	        	const targetCols = ["RISK_TP_CD","EVLTN_ITEM", "EVLTN_STND", "EVLTN_RMRK"];
	   	        	targetCols.forEach(col => {

	   	        		if(e.newData[col] !== undefined && e.newData[col] !== e.oldData[col]) {
							e.newData["UPDATEGUBUN"] = "변경";
	   	        		}
	   	        	});
	   	         }
	   	         ,"onRowInserting" : function(e) {
	   	        	    e.data["LV1"] = 2;
	    	            e.data["LV2"] = 4;
	   	    	        e.data["SRT_ORDR"] = e.component.totalCount()+1;
	   	    	     	e.data["UPDATEGUBUN"] = "추가";
	   	    	        $("#upBtn5").prop("disabled", true);
	   	    			$("#downBtn5").prop("disabled", true);
	   	    	    }
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
		              , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "50%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND", "visible" : false }
		              , {"dataField":"EVLTN_RMRK","caption": "${msgel.getMsg('AML_10_25_01_02_023', '비고 예시')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%"} 
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
		              , {"dataField":"REG_DT", "caption": 'REG_DT',"visible" : false }
		              , {"dataField":"UPDATEGUBUN","caption": "수정구분","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "8%"}
		         ]
		   	     ,"onEditorPreparing": function(e) {  
			   	    if (e.parentType == "dataRow" && ( e.dataField == "EVLTN_ITEM" || e.dataField == "EVLTN_STND" ) ){  
			   	         e.editorName = "dxTextArea";  
			   	     }  
			   	 }  
	   	         ,"onCellClick" : function(e) {
	   	        	 
	   	        	 if (e.component.isRowSelected(e.key) && e.columnIndex != 1 && e.columnIndex != 5) {
	   	    	            e.component.editCell(e.rowIndex,e.columnIndex);
	   	    	        } else {
	   	    	            e.component.clearSelection();
	   	    	            e.component.selectRowsByIndexes(e.rowIndex);
	   	    	            clickRowGrid("6", e.data, e.rowIndex);
	   	    	        }
	   	    	    }
	   	      	,"onRowUpdating" : function(e) {
	   	        	const targetCols = ["RISK_TP_CD","EVLTN_ITEM", "EVLTN_STND", "EVLTN_RMRK"];
	   	        	targetCols.forEach(col => {

	   	        		if(e.newData[col] !== undefined && e.newData[col] !== e.oldData[col]) {
							e.newData["UPDATEGUBUN"] = "변경";
	   	        		}
	   	        	});
	   	         }
	   	         ,"onRowInserting" : function(e) {
	   	        	    e.data["LV1"] = 3;
	    	            e.data["LV2"] = 1;
	   	    	        e.data["SRT_ORDR"] = e.component.totalCount()+1;
	   	    	     	e.data["UPDATEGUBUN"] = "추가";
	   	    	        e.data["DEP_TP_CD"] = "M";
	   	    	        $("#upBtn6").prop("disabled", true);
	   	    			$("#downBtn6").prop("disabled", true);
	   	    	  }
	       	}).dxDataGrid("instance");
    	 
    	  GridObjArr.splice(1,0,GridObj1);
    	  GridObjArr.splice(2,0,GridObj2);
    	  GridObjArr.splice(3,0,GridObj3);
    	  GridObjArr.splice(4,0,GridObj4);
    	  GridObjArr.splice(5,0,GridObj5);
    	  GridObjArr.splice(6,0,GridObj6);
    	  
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
    	
    	GridObjArr.length = 0;
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
        
        GridObjArr.splice(1,0,GridObj1);
     	GridObjArr.splice(2,0,GridObj2);
     	GridObjArr.splice(3,0,GridObj3);
     	GridObjArr.splice(4,0,GridObj4);
     	GridObjArr.splice(5,0,GridObj5);
     	GridObjArr.splice(6,0,GridObj6);
   	  
     	$("#VERSION_ID").val(gridData[0].VERSION_ID);
     	$("#TITLE").val(gridData[0].TITLE);
     	
     	if( !isEmpty(prdCkId)  ){
     	  $("#APP_STATE").val('<c:out value="${APP_STATE}"/>');
     	}
    }
    
    function clickRowGrid(idx, data, rowIdx) {
    	
    	var gridDatas = getDataSource(GridObjArr[idx-1]);
    	
    	if(rowIdx == 0) {
    		$("#upBtn"+idx).prop("disabled", true);
    		$("#downBtn"+idx).prop("disabled", false);
    	} else if (rowIdx == gridDatas.length-1){
    		$("#upBtn"+idx).prop("disabled", false);
    		$("#downBtn"+idx).prop("disabled", true);
    	} else {
    		$("#upBtn"+idx).prop("disabled", false);
    		$("#downBtn"+idx).prop("disabled", false);
    	}

    	if(gridDatas.length == 1) {
    		$("#upBtn"+idx).prop("disabled", true);
    		$("#downBtn"+idx).prop("disabled", true);
    	}
    }
    
    function rowUp( idx ) {

    	var currentRow = GridObjArr[idx-1].getSelectedRowsData()[0];
    	if(!currentRow) {
    		showAlert("${msgel.getMsg('AML_20_00_01_01_009', '선택된 행이 없습니다.')}", "WARN");
    		return;
    	}

    	var allData = getDataSource(GridObjArr[idx-1]);
    	var currentIdx = Number(currentRow["SRT_ORDR"]) - 1;
    	var beChangedRow = allData[currentIdx - 1];
    	
    	if(currentIdx - 1 > 0 ) {
    		$("#downBtn").prop("disabled", false);
    	}
    	
    	allData.splice(currentIdx - 1, 1, currentRow);
    	allData.splice(currentIdx , 1, beChangedRow);
    	allData[currentIdx - 1]["SRT_ORDR"] = currentIdx;
    	allData[currentIdx]["SRT_ORDR"] = currentIdx+1;
    	GridObjArr[idx-1].refresh();
    	GridObjArr[idx-1].option("dataSource", allData);

    	if(currentIdx - 1 == 0 ) {
    		$("#upBtn"+idx).prop("disabled", true);
    	}

    	if(allData[0]["SRT_ORDR"] == currentRow["SRT_ORDR"]) {
    		$("#downBtn"+idx).prop("disabled", false);
    	}
    }

    function rowDown( idx ) {

    	var currentRow = GridObjArr[idx-1].getSelectedRowsData()[0];
    	
    	if(!currentRow) {
    	    showAlert("${msgel.getMsg('AML_20_00_01_01_009', '선택된 행이 없습니다.')}", "WARN");
    	}

    	var allData = getDataSource(GridObjArr[idx-1]);
    	var currentIdx = Number(currentRow["SRT_ORDR"]) - 1;
    	var beChangedRow = allData[currentIdx + 1];
    	if(currentIdx == 0) {
    		$("#upBtn"+idx).prop("disabled", false);
    	}
    	allData.splice(currentIdx + 1, 1, currentRow);
    	allData.splice(currentIdx , 1, beChangedRow);
    	allData[currentIdx + 1]["SRT_ORDR"] = currentIdx + 2;
    	allData[currentIdx]["SRT_ORDR"] = currentIdx + 1;
    	GridObjArr[idx-1].refresh();
    	GridObjArr[idx-1].option("dataSource", allData);
    	if(currentIdx + 1 == allData.length - 1 ) {
    		$("#downBtn"+idx).prop("disabled", true);
    	}
    }
    
    function rowAdd( idx ) {

    	GridObjArr[idx-1].addRow();
    	GridObjArr[idx-1].saveEditData();
    	GridObjArr[idx-1].refresh();
    }

    function rowDelete( idx ) {

    	var currentRow = GridObjArr[idx-1].getSelectedRowsData()[0];
    	if(!currentRow) {
    	    showAlert("${msgel.getMsg('AML_20_00_01_01_009', '선택된 행이 없습니다.')}", "WARN");
    	}
    	
    	
    	showConfirm("${msgel.getMsg('AML_10_01_01_01_045', '작성중인 내용이 있습니다. 정말 삭제하시겠습니까?')}", "삭제", function(){
    	

    	var allData = getDataSource(GridObjArr[idx-1]);
    	var currentIdx = Number(currentRow["SRT_ORDR"]) - 1;
    	
    	if(allData[currentIdx]) {
    		allData[currentIdx]["UPDATEGUBUN"] = "삭제";
    		allData[currentIdx]["SRT_ORDR"] = "99"; 
    	}
    	
    	//allData.splice(currentIdx,1);
    	
    	var seq = 1;
    	for(var i = 0; i< allData.length; i++) {
    		if(allData[i]["UPDATEGUBUN"] !== "삭제"){
    	    	allData[i]["SRT_ORDR"] = seq++;
    		}
    	}
    	
    	
    	//for(var i in allData) {
    	//	if(allData[i]["UPDATEGUBUN"] !== "삭제"){
    	//	allData[i]["SRT_ORDR"] = Number(i)+1;
    	//	}
    	//}
    	
    	GridObjArr[idx-1].refresh();
    	GridObjArr[idx-1].option("dataSource", allData);
    	});
    }

    function CheckValue(){
		
		if( isEmpty($("#TITLE").val()) ){

			showAlert( "${msgel.getMsg('AML_10_25_01_02_021', '체크리스트 개요를 입력하셔야 합니다.')}", "WARN");
			$("#TITLE").focus();
			return false;
			
		}else{
			
			var isEmptyYn = true;
			var totalLen = GridObjArr.length;
			
			for( var idx = 0 ; idx < totalLen ; idx++ ){
			        
	        	var tempData = getDataSource( GridObjArr[idx] );
	        	
	        	if( tempData.length > 0 ){

	        		for( var i = 0 ; i < tempData.length ; i++ ){
	        			
		        	    var vsCells = GridObjArr[idx].getVisibleColumns();
		        	    var srtordr = tempData[i]["SRT_ORDR"]
						
			        	for( var j = 0 ; j < vsCells.length ; j++ ){
		        		    
			        		if( "EVLTN_RMRK" != vsCells[j].dataField && isEmpty( tempData[i][vsCells[j].dataField] ) && "UPDATEGUBUN" != vsCells[j].dataField && srtordr != "99"){
			        		 	
			        			showAlert( "${msgel.getMsg('AML_10_25_01_02_022', '입력하지 않은 항목이 있습니다.')}", "WARN");
			        		 	GridObjArr[idx].focus( GridObjArr[idx].getCellElement(i, vsCells[j].dataField) );
			        			isEmptyYn = false;
				        		break;
			        		}
			        	}
			        	
			        	if(!isEmptyYn){
			        		break;
			        	}
	        		}
	        		
	        		if(!isEmptyYn){
		        		break;
		        	}
	        		
	        	}else{
	        		
	        		showAlert( "${msgel.getMsg('AML_10_25_01_02_022', '입력하지 않은 항목이 있습니다.')}", "WARN");
	        		GridObjArr[idx].focus();
	        		isEmptyYn = false;
	        		break;
	        	}
	        }
			
			return isEmptyYn;
		}

		return true;
    }
    
    function doSave(){
    
    	if( !CheckValue() ){
    		 overlay.hide();
    		 return;
    	}
    	
    	var classID = "AML_10_25_01_02";
    	var methodID = "doSave"
    	var gridArr = [];
    	var params = {};
		
    	var allRowsData = {};
    	var totalLen = GridObjArr.length;
        for( var idx = 0 ; idx < totalLen ; idx++ ){
        
        	var tempData = getDataSource( GridObjArr[idx] );
        	
        	if( tempData.length > 0 ){
        		
	        	for( var i = 0 ; i < tempData.length ; i++ ){
	        		
	        		if(tempData[i]["SRT_ORDR"] == 99) {
						continue;
	        		}
	        		tempData[i]["LV3"] = tempData[i]["SRT_ORDR"];	        		
	        		
	        		gridArr.push(tempData[i]);
	        	}
        	}
        }
        
        var params = new Object();
        
        
        
        params.PRD_CK_ID = prdCkId;
        params.TITLE = $("#TITLE").val();
        params.GRID_DATA = gridArr;
        
		showConfirm('${msgel.getMsg("AML_10_01_01_01_004","저장하시겠습니까?")}','저장', function(){
			 
			 sendService(classID, methodID, params, doSaveEnd, doSaveEnd );
		});
    }
    
   function doSaveEnd(gridData, actionParam){
    	
    	overlay.hide();
    	
    	prdCkId = gridData[0].PRD_CK_ID;
    	doSearch();
    	if( opener ){
    	  opener.doSearch();
    	}
   }
    
   function doApprReq(){
	   
	  var ROLEID = '<c:out value="${ROLEID}"/>';
	  var FIRST_APP_ID = '<c:out value="${FIRST_APP_ID}"/>';
	  	
	  if( ROLEID != FIRST_APP_ID ){
	  	showAlert('${msgel.getMsg("AML_10_17_01_01_003","최초  결재자가 아닙니다/")}', "WARN");
		return;
	  }
	  
	  if( !CheckValue() ){
  		 overlay.hide();
  		 return;
  	  }
	  
	  showConfirm('${msgel.getMsg("AML_10_25_01_02_024","승인요청 하시겠습니까?")}','승인요청', function(){
		  
		  form2.dis_flag.value = "P";
		  form2.pageID.value = 'AML_10_25_01_04';
		  form2.target = 'AML_10_25_01_04';
		  form2.action = '${path}/0001.do';
		  form2.method = "post";
   		  window_popup_open(form2.pageID.value, 600, 250, '','yes');
   		  form2.submit();
   		  form2.target = '';
	  });
   }
   
   function doAppr( rsnCntnt ){
	  	
  	  var classID = "AML_10_25_01_02";
   	  var methodID = "doApprReq"
  	  var gridArr = [];
		
  	  var allRowsData = {};
  	  var totalLen = GridObjArr.length;
      for( var idx = 0 ; idx < totalLen ; idx++ ){
      
      	var tempData = getDataSource( GridObjArr[idx] );
      	
      	if( tempData.length > 0 ){
      		
        	for( var i = 0 ; i < tempData.length ; i++ ){
        		if(tempData[i]["SRT_ORDR"] == 99) {
					continue;
        		}
        		tempData[i]["LV3"] = tempData[i]["SRT_ORDR"];
        		
        		gridArr.push(tempData[i]);
        	}
      	}
      }
      
      var params = new Object();
      params.PRD_CK_ID = prdCkId;
      params.TITLE = $("#TITLE").val();
      params.GRID_DATA = gridArr;
      params.RSN_CNTNT = rsnCntnt;
      params.APP_NO = '<c:out value="${APP_NO}"/>';
      params.SN_CCD = '<c:out value="${SN_CCD}"/>';   // S:승인요청, R:반려, E:승인완료
      params.FIRST_SNO = '<c:out value="${FIRST_SNO}"/>';
      
      sendService(classID, methodID, params, doApprSucc, doApprFail );
   }
   
   function doApprSucc(){
	   doSearch();
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
 <input type="hidden" name="gubun" >
 <input type="hidden" name="dis_flag" >
 <input type="hidden" name="APP_NO" >
 <input type="hidden" name="APP_DT" >
</form>

<form name="form1" id="form1" method="post"> 
 <input type="hidden" name="pageID" > 
 <input type="hidden" name="manualID" > 
 <input type="hidden" name="classID" > 
 <input type="hidden" name="methodID" >
 <input type="hidden" name="PRD_CK_ID" > 
 
  <div class="inquiry-table type1">
	   <div class="table-row"  >
		 <div class="table-cell">
		   ${condel.getInputText('{msgID:"AML_10_25_01_02_014", defaultValue:"체크리스트 버전 일련번호", name:"VERSION_ID", style:"margin-left:10px;margin-right:10px;", size:"20", maxLength:"50"}')}
		 </div>
	   </div>
	   
	   <div class="table-row"  >
		 <div class="table-cell">
		   ${condel.getInputText('{msgID:"AML_10_25_01_02_015", defaultValue:"체크리스트 개요", name:"TITLE", style:"margin-left:10px;margin-right:10px;", attr:"placeholder=※직전&nbsp;버전대비&nbsp;주요&nbsp;변경사항&nbsp;등&nbsp;작성", size:"50", maxLength:"300"}')}
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
	    <div style="width:30%; display:flex;justify-content:flex-end;margin-top:6px;margin-bottom:6px;">
		  <button class="btn-28" id="upBtn1" type="button" onclick="rowUp('1')" disabled>${msgel.getMsg('AML_20_00_01_01_028', '위로')}</button>
		  <button class="btn-28" id="downBtn1" type="button" onclick="rowDown('1')" disabled>${msgel.getMsg('AML_20_00_01_01_029', '아래로')}</button>
		  <button class="btn-28" id="addBtn1" type="button" onclick="rowAdd('1')">${msgel.getMsg('AML_00_00_00_00_009', '행추가')}</button>
		  <button class="btn-28" id="delBtn1" type="button" onclick="rowDelete('1')">${msgel.getMsg('AML_00_00_00_00_010', '행삭제')}</button>
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
	    <div style="width:30%; display:flex;justify-content:flex-end;margin-top:6px;margin-bottom:6px;">
		  <button class="btn-28" id="upBtn2" type="button" onclick="rowUp('2')" disabled>${msgel.getMsg('AML_20_00_01_01_028', '위로')}</button>
		  <button class="btn-28" id="downBtn2" type="button" onclick="rowDown('2')" disabled>${msgel.getMsg('AML_20_00_01_01_029', '아래로')}</button>
		  <button class="btn-28" id="addBtn2" type="button" onclick="rowAdd('2')">${msgel.getMsg('AML_00_00_00_00_009', '행추가')}</button>
		  <button class="btn-28" id="delBtn2" type="button" onclick="rowDelete('2')">${msgel.getMsg('AML_00_00_00_00_010', '행삭제')}</button>
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
	    <div style="width:30%; display:flex;justify-content:flex-end;margin-top:6px;margin-bottom:6px;">
		  <button class="btn-28" id="upBtn3" type="button" onclick="rowUp('3')" disabled>${msgel.getMsg('AML_20_00_01_01_028', '위로')}</button>
		  <button class="btn-28" id="downBtn3" type="button" onclick="rowDown('3')" disabled>${msgel.getMsg('AML_20_00_01_01_029', '아래로')}</button>
		  <button class="btn-28" id="addBtn3" type="button" onclick="rowAdd('3')">${msgel.getMsg('AML_00_00_00_00_009', '행추가')}</button>
		  <button class="btn-28" id="delBtn3" type="button" onclick="rowDelete('3')">${msgel.getMsg('AML_00_00_00_00_010', '행삭제')}</button>
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
	    <div style="width:30%; display:flex;justify-content:flex-end;margin-top:6px;margin-bottom:6px;">
		  <button class="btn-28" id="upBtn4" type="button" onclick="rowUp('4')" disabled>${msgel.getMsg('AML_20_00_01_01_028', '위로')}</button>
		  <button class="btn-28" id="downBtn4" type="button" onclick="rowDown('4')" disabled>${msgel.getMsg('AML_20_00_01_01_029', '아래로')}</button>
		  <button class="btn-28" id="addBtn4" type="button" onclick="rowAdd('4')">${msgel.getMsg('AML_00_00_00_00_009', '행추가')}</button>
		  <button class="btn-28" id="delBtn4" type="button" onclick="rowDelete('4')">${msgel.getMsg('AML_00_00_00_00_010', '행삭제')}</button>
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
	    <div style="width:30%; display:flex;justify-content:flex-end;margin-top:6px;margin-bottom:6px;">
		  <button class="btn-28" id="upBtn5" type="button" onclick="rowUp('5')" disabled>${msgel.getMsg('AML_20_00_01_01_028', '위로')}</button>
		  <button class="btn-28" id="downBtn5" type="button" onclick="rowDown('5')" disabled>${msgel.getMsg('AML_20_00_01_01_029', '아래로')}</button>
		  <button class="btn-28" id="addBtn5" type="button" onclick="rowAdd('5')">${msgel.getMsg('AML_00_00_00_00_009', '행추가')}</button>
		  <button class="btn-28" id="delBtn5" type="button" onclick="rowDelete('5')">${msgel.getMsg('AML_00_00_00_00_010', '행삭제')}</button>
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
	    <div style="width:30%; display:flex;justify-content:flex-end;margin-top:6px;margin-bottom:6px;">
		  <button class="btn-28" id="upBtn6" type="button" onclick="rowUp('6')" disabled>${msgel.getMsg('AML_20_00_01_01_028', '위로')}</button>
		  <button class="btn-28" id="downBtn6" type="button" onclick="rowDown('6')" disabled>${msgel.getMsg('AML_20_00_01_01_029', '아래로')}</button>
		  <button class="btn-28" id="addBtn6" type="button" onclick="rowAdd('6')">${msgel.getMsg('AML_00_00_00_00_009', '행추가')}</button>
		  <button class="btn-28" id="delBtn6" type="button" onclick="rowDelete('6')">${msgel.getMsg('AML_00_00_00_00_010', '행삭제')}</button>
		</div>
	 </div>
     <div id="GTDataGrid6_Area"></div>
    </div>		        		        
							
 </div>
 
 <div class="button-area" style="display:flex; justify-content: flex-end; padding-top: 8px;">
 
   <% if( "4".equals(ROLEID) ) { // 107:신상품 자금세탁위험평가 담당자, 108:신상품 자금세탁위험평가 책임자, 4:컴플라이언스운영팀 담당자, 104:보고책임자  %>
	 <button type="button" onclick="doSave()" id="btn_01" class="btn-36" mode="U">${msgel.getMsg("AML_10_25_01_02_017","임시저장")}</button>
	 <button type="button" onclick="doApprReq()" id="btn_02" class="btn-36" mode="U">${msgel.getMsg("AML_10_25_01_02_018","승인요청")}</button> 
   <% } %>
   
	${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
	
 </div>
 
</form> 

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />