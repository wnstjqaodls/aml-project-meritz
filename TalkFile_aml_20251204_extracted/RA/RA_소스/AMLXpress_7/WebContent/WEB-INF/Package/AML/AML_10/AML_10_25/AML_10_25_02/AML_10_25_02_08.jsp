<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
- File Name  : AML_10_25_02_02.jsp
- Author     :  
- Comment    : 신상품위험평가 등록(자금세탁사기예방팀 담당자)
- Version    : 1.0
- history    : 1.0 2025-06
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
--%>
<%@ page import="com.gtone.webadmin.util.JSONUtil,com.gtone.webadmin.util.CodeUtil"%>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<%@ page import="com.gtone.aml.server.AML_10.AML_10_25.AML_10_25_02.AML_10_25_02_02"%>


<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%

	String sDate = DateUtil.addDays(DateUtil.getDateString(), -90, "yyyy-MM-dd");
	String eDate =DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
	String todayDate = jspeed.base.util.DateHelper.currentTime(PropertyService.getInstance().getProperty("aml.config", "dateFormat"));
	request.setAttribute("stDate",sDate);
	request.setAttribute("edDate",eDate);
	request.setAttribute("todayDate", todayDate);
    
    String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
    request.setAttribute("uploadFile",uploadFile);

    String prdEvltnId = Util.nvl( request.getParameter("PRD_EVLTN_ID") );
	String prdCkId = Util.nvl( request.getParameter("PRD_CK_ID") );
    String appNo = Util.nvl( request.getParameter("APP_NO") );
    String EVLTN_STATE = Util.nvl( request.getParameter("EVLTN_STATE") );  
    String snCcd = Util.nvl( request.getParameter("SN_CCD") );
    request.setAttribute("PRD_EVLTN_ID", prdEvltnId);
	request.setAttribute("PRD_CK_ID", prdCkId);
	request.setAttribute("APP_NO", appNo);
	request.setAttribute("EVLTN_STATE", EVLTN_STATE);
    request.setAttribute("SN_CCD", snCcd);
    
    DataObj in = new DataObj();							
    in.put("PRD_EVLTN_ID", prdEvltnId );
    DataObj output = AML_10_25_02_02.getInstance().getSearchFiles(in);
    if(output.getCount("FILE_SER") > 0) {                               
		request.setAttribute("FILES",output.getRowsToMap());
	}
    
    //세션 부서정보
    String depId = helper.getDeptId().toString();
    String depNm = helper.getDeptName();
    request.setAttribute("DEP_ID", depId);
    request.setAttribute("DEP_NM", depNm);
    
	//세션 결재자 정보
	String ROLEID = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLEID", ROLEID);
	
    if( "4".equals(ROLEID) ){
    	request.setAttribute("isCkAbled", false);
    	request.setAttribute("isCkAbled2", false);
    }else{
    	request.setAttribute("isCkAbled", true);
   	    request.setAttribute("isCkAbled2", true);
    }
	
	// 세션 부서 
	DataObj inputApr = new DataObj();
	inputApr.put("CD","S104");
	inputApr.put("GUBUN", "RA5");
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
	for( int i=0 ; i < REPLCE_FIRST_APP_ID.length 	; i++ ){
		
		if( i == 0 ){
			
			FIRST_APP_ID = REPLCE_FIRST_APP_ID[0];
			request.setAttribute("FIRST_APP_ID", FIRST_APP_ID);
			
		}else if( i == 1){
			
			FIRST_SNO = REPLCE_FIRST_APP_ID[1];
			request.setAttribute("FIRST_SNO", FIRST_SNO);
		}
	}
	
%> 

<style>

.dx-datagrid-rowsview .dx-row {
  height: 40px; 
}

.dx-fileuploader-wrapper {
    padding: 12px;
}

.dx-fileuploader-input-container {

   display: none;
}

.dx-fileuploader-input-wrapper .dx-button {
    float: right;
}

.popup-content {
    padding: 0px 30px;
}

.popup .dropdown {
    width: 150px;
}

.checkbox-container {
	display: flex;
	gap: 10px;
	align-items: center;
}

.label-checkbox {
	display: flex;
	align-items: center;
	gap: 5px;
}

textarea.custom-textarea {
	width: 100%;
	height: 60px;
	padding: 6px;
	box-sizing: border-box;
	font-family: inherit;
	font-size: 13px;
	border: 1px solid #ccc;
	resize: vertical;
}

textarea.custom-textarea::placeholder {
	opacity: 1 !important;
	color: #999 !important;
}

.placeholder-fake {
	color: #aaa;
	font-style: italic;
}

.input-round {
	border-radius: 10px;
		padding: 6px 12px;
	border: 1px solid #ccc;
	}
	
.divider {
    border-top: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    padding: 2px;
}

input[type=text] {
    padding: 7px 10px;
    height: 29px;
    border: 1px solid #ccc;
    font-family: SpoqR;
    font-size: 14px;
    line-height: 22px;
    color: #48505d;
    letter-spacing: -0.28px;
}

/* 기본정보 테이블 */
.basic-info {
  width: 100%;
  border-collapse: collapse;
  margin-top: 2px;
  font-size: 13px;
  border-top: 2px solid black;
}

.basic-info th,
.basic-info td {
  border: 1px solid #ccc;
  padding: 8px;
  text-align: center;
}

.basic-info th {
  background-color: #f6f6f6;
  width: 11%;
}

/* 텍스트 영역 */
.textarea-box {
  width: 100%;
  height: 80px;
  padding: 8px;
  font-size: 13px;
  border: 1px solid #ccc;
  resize: vertical;
  margin-top: 10px;
}

.risk-table {
    width: 100%;
    border-collapse: collapse;
    font-family: sans-serif;
    font-size: 13px;
    table-layout: fixed;
    border-top: 2px solid black;
  }

  .risk-table th,
  .risk-table td {
    border: 1px solid #ccc;
    padding: 8px;
    text-align: center;
    vertical-align: middle;
  }

  .risk-table th {
    background-color: #f5f5f5;
    font-weight: bold;
  }

  .danger-text {
    color: red;
    font-weight: bold;
  }

  .normal-text {
    color: green;
    font-weight: bold;
  }

  .criteria-text {
    text-align: left;
    line-height: 1.6;
    white-space: pre-wrap;
    padding-left: 10px;
  }

  .highlight-bg-red {
    background-color: #ffeaea;
  }

  .highlight-bg-green {
    background-color: #eaffea;
  }
  
 .danger-text { color: red; font-weight: bold; }
 .warning-text { color: orange; font-weight: bold; }
 .safe-text { color: green; font-weight: bold; }
 .low-text { color: #555; font-weight: bold; }
 .criteria-text { text-align: left; padding-left: 10px; line-height: 1.5; }
 
  

/* 첨부파일 테이블 */
.file-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
  margin-bottom: 10px;
  font-size: 13px;
}

.file-table th,
.file-table td {
  border: 1px solid #ccc;
  padding: 6px 8px;
  text-align: left;
}

.file-table th {
  background-color: #f0f0f0;
  text-align: center;
}

.file-table .actions {
  text-align: center;
}

.file-table .download-link {
  color: blue;
  text-decoration: underline;
  cursor: pointer;
}

.file-table .delete-link {
  color: red;
  cursor: pointer;
}

</style>
 
<script language="JavaScript"> 
 
    var overlay = new Overlay();
    var prdEvltnId = '<c:out value="${PRD_EVLTN_ID}"/>';
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
    var isCkAbled = <c:out value="${isCkAbled}"/>;
    var isCkAbled2 = <c:out value="${isCkAbled2}"/>;
    var ROLEID = "${ROLEID}";
    var EVLTN_STATE = "${EVLTN_STATE}";
    var snccd = "${SN_CCD}";
    var appno = null;
    var rsk_scr = null;
    
    // [ Initialize ]
    $(document).ready(function(){
    	
    	$("#VERSION_ID").prop("disabled", true);
    	
    	setupGrids();
    	
    	$("#PRD_CTGR_CD").on("change", function(){
  		  
  		   $("#PRD_TP_CD option:not(:eq(0))").remove();
  		  
  		   var params = new Object();
  		   if( $(this).val() == 'PRDT' ){
  			  params.CD = "P202";
  		   }else if( $(this).val() == 'SVC' ){
  			  params.CD = "P203";
  		   }
  	       
  	       sendService("AML_10_25_02_01", "getCodeSearch", params, doCdSearch_End, doCdSearch_End); 
  	   });
    	
       var allowedFileExtensions = "${uploadFile}";
       var fileUploader = gtFileUploader("file-uploader",allowedFileExtensions,doSubmit_end,true,false);
       
       /* if(!isCkAbled2){
           doDisabledSet();
       }else{
    	   $("#SMRY_OPNN_TMP").prop("disabled", true);
       } */

       $("#preRsltList").on("click", function(){
   	    
   	      try {

   	       form2.PRD_CK_ID.value = prdCkId
   	 	   form2.dis_flag.value = "P";
   	 	   form2.pageID.value = 'AML_10_25_02_07';
   	 	   form2.target = 'AML_10_25_02_07';
   	 	   form2.action = '${path}/0001.do';
   	 	   form2.method = "post";
   	 	   window_popup_open(form2.pageID.value, 1300, 700, '','yes');
   	 	   form2.submit();
   	 	   form2.target = '';
   	       return;
   	           
   	     } catch (e) {
   	         showAlert(e, "ERR");
   	     } finally {
   	         overlay.hide(); 
   	     }
       });

       $("#listExcelDown").on("click", function(){

     	    if( isEmpty(prdEvltnId) ){

     	    	showAlert( "${msgel.getMsg('AML_10_25_02_01_012', '저장 후 다운로드가 가능합니다.')}", "WARN");
     	    	return;
   	        }

     	    exportEvltn();
        });
     	
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
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P101"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
		              , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RSLT","caption": "${msgel.getMsg('AML_10_25_02_02_022', '답변')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false
		            	  
		            	  , "cellTemplate":  function(container, options) {
		            		  
		                      const data = options.data;
		                      const grid = options.component;
		                      const wrapper = $("<div>").addClass("checkbox-container");
		                      const aGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("Y").appendTo(aGroup);
		                      
		                      const checkA = $("<div>");	                          
		                      checkA.dxCheckBox({
		                          value: data.EVLTN_RSLT === "Y"
		                        , disabled: isCkAbled || data.isDisabled
		                        , onValueChanged: function(e) {
		                        	
		                              if(e.value){
		                           		  
		                            	  e.component.option("value", true);
		                                  checkB.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "Y";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                          }
		                      }).appendTo(aGroup);
		
		                      const bGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("N").appendTo(bGroup);
		                      const checkB = $("<div>");
		                      checkB.dxCheckBox({
		                          value: data.EVLTN_RSLT === "N"
		                        , disabled: isCkAbled || data.isDisabled
		                        , onValueChanged: function(e) {
		                        	  
		                        	  if (e.value) {
		                           		   
		                        		  e.component.option("value", true);
		                                  checkA.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "N";
		                                  
		                                  if(options.rowIndex === 0 || options.rowIndex === 2) {
											const targetIndex = options.rowIndex === 0 ? 1 : 3;
											const targetRow = grid.getVisibleRows()[targetIndex];
											
												if(targetRow) {
													targetRow.data.isDisabled = true;
													targetRow.data.EVLTN_RSLT = "T";
													grid.refresh();
												}
		                                  }
		                                  
		                              }else{
		                            	  options.data.EVLTN_RSLT = "";
		                            	  if(options.rowIndex === 0 || options.rowIndex === 2) {
												const targetIndex = options.rowIndex === 0 ? 1 : 3;
												const targetRow = grid.getVisibleRows()[targetIndex];
												
												if(targetRow) {
													targetRow.data.isDisabled = false;
													grid.refresh();
												}
			                              }
		                              }
		                          }
		                      }).appendTo(bGroup);            
		                      
		                      wrapper.append(aGroup, bGroup);
		                      container.append(wrapper);
		                      
		                  }
		              }
		              , {"dataField":"EVLTN_RSLT_RMRK","caption": "${msgel.getMsg('AML_10_25_02_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": true, "width": "20%"
		            	  
		            	  , "cellTemplate": function (container, options) {
		            		 	const value = options.value;			                    
		            		 	const data = options.data;
		            		 	const grid = options.component;
		            		 	const rows = grid.getVisibleRows();
		            		 	const idx = options.rowIndex;
		            		 	
		            		 	
		            		 	
		            		 	//const tempText = options.data.EVLTN_RMRK || "";
		            		 	let displayText = options.value || "";

		            		 	if (idx % 2 === 1) {
									const prevRow = rows[idx -1];
									if(prevRow && prevRow.data.EVLTN_RSLT === "N") {
										displayText = "해당사항 없음";
									}else {
										displayText = options.data.EVLTN_RMRK || "";
									}
		            		 	}
		            		 	
			   	 	   	        //const displayText = value || tempText;
			   	 	   	        const span = $("<span>").addClass(value ? "" : "placeholder-fake").css({
			   	 	   	                "display": "inline-block",
			   	 	   	                "white-space": "nowrap",
			   	 	   	                "overflow": "hidden",
			   	 	   	                "text-overflow": "ellipsis",
			   	 	   	                "max-width": "100%",
			   	 	   	                "color" : "#444"
			   	 	   	            }).attr("title", displayText).text(displayText);
			   	 	   	        
			   	 	   	        container.append(span);
		                    }
		                    , "editCellTemplate": function (cellElement, cellInfo) {

		                    	
		                    	const data = cellInfo.data;
		                        const textarea = document.createElement("textarea");
		                        textarea.className = "custom-textarea";
		                        textarea.disabled = isCkAbled || data.isDisabled;
		                        
		                        if(data.isDisabled == true) {
		                        	textarea.value = "해당사항 없음";	
		                        }else {
		                        	textarea.value = cellInfo.value || "";
		                        }
		                        
		                        textarea.addEventListener("input", function () {
		                            cellInfo.setValue(this.value);
		                        });
		                      
		                        
		                        cellElement[0].innerHTML = "";
		                        cellElement[0].appendChild(textarea);
			                }
		                }
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"EVLTN_RMRK", "caption": 'EVLTN_RMRK', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
		         ]
		   	    
	   	      
	   	         
	   	         
	   	        
	   	         
	   	         /*
	   	      , onEditorPreparing: function (e) {  
                  if (e.parentType == "dataRow" && e.dataField == "EVLTN_RMRK") {  
                      var editor = e.component;  
                      e.editorOptions.placeholder = "enter a value";  
                  }  
                }
			   	 */
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
	 	                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
	 	                	, "lookup" : {
	 	    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P102"))%>
	 	    		              ,displayExpr : "VALUE"
	 	    		              ,valueExpr   : "KEY"
	 	    	            }
	 	                }
	   	              , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
	 	              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
	 	              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
	 	              , {"dataField":"EVLTN_RSLT","caption": "${msgel.getMsg('AML_10_25_02_02_022', '답변')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false 
	 	            	  
	 	            	 , "cellTemplate":  function(container, options) {
		            		  
		                      const data = options.data;
		                      const wrapper = $("<div>").addClass("checkbox-container");
		                      const aGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("Y").appendTo(aGroup);
		                      
		                      const checkA = $("<div>");	                          
		                      checkA.dxCheckBox({
		                          value: data.EVLTN_RSLT === "Y"
		                        , disabled: isCkAbled
		                        , onValueChanged: function(e) {
		                        	
		                              if(e.value){
		                           		  
		                            	  e.component.option("value", true);
		                                  checkB.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "Y";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                              evaluateRisk();
		                          }
		                      }).appendTo(aGroup);
		
		                      const bGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("N").appendTo(bGroup);
		                      const checkB = $("<div>");
		                      checkB.dxCheckBox({
		                          value: data.EVLTN_RSLT === "N"
		                        , disabled: isCkAbled
		                        , onValueChanged: function(e) {
		                        	  
		                        	  if (e.value) {
		                           		  
		                        		  e.component.option("value", true);
		                                  checkA.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "N";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                        	  evaluateRisk();
		                          }
		                      }).appendTo(bGroup);
		
		                      wrapper.append(aGroup, bGroup);
		                      container.append(wrapper);
		                  }
	 	              }
	 	              , {"dataField":"EVLTN_RSLT_RMRK","caption": "${msgel.getMsg('AML_10_25_02_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": true, "width": "20%"
	 	            	  
	 	            	  , "cellTemplate": function (container, options) {
		   	            		
		   	            		const value = options.value;
			   	 	   	        const tempText = options.data.EVLTN_RMRK || "";
			   	 	   	        //const placeholder = `${tempText}`;
			   	 	   	        const displayText = value || tempText;
			   	 	   	        const span = $("<span>").addClass(value ? "" : "placeholder-fake").css({
			   	 	   	                "display": "inline-block",
			   	 	   	                "white-space": "nowrap",
			   	 	   	                "overflow": "hidden",
			   	 	   	                "text-overflow": "ellipsis",
			   	 	   	                "max-width": "100%",
			   	 	   	         		"color" : "#444",
			   	 	   	            }).attr("title", displayText).text(displayText);
	
			   	 	   	        container.append(span);
		                    }
	   	                    , "editCellTemplate": function (cellElement, cellInfo) {
			                    	
		                        const textarea = document.createElement("textarea");
		                        textarea.className = "custom-textarea";
		                        textarea.value = cellInfo.value || "";
		                        textarea.disabled = isCkAbled;
		                        textarea.addEventListener("input", function () {
		                            cellInfo.setValue(this.value);
		                        });
		                        
		                        cellElement[0].innerHTML = "";
		                        cellElement[0].appendChild(textarea);
			                }
	 	                }
	 	              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"EVLTN_RMRK", "caption": 'EVLTN_RMRK', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
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
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P103"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
	 	              , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RSLT","caption": "${msgel.getMsg('AML_10_25_02_02_022', '답변')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false
		            	  
		            	  , "cellTemplate":  function(container, options) {
		            		  
		                      const data = options.data;
		                      const wrapper = $("<div>").addClass("checkbox-container");
		                      const aGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("Y").appendTo(aGroup);
		                      
		                      const checkA = $("<div>");	                          
		                      checkA.dxCheckBox({
		                          value: data.EVLTN_RSLT === "Y"
		                        , disabled: isCkAbled
		                        , onValueChanged: function(e) {
		                        	
		                              if(e.value){
		                           		  
		                            	  e.component.option("value", true);
		                                  checkB.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "Y";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                              evaluateRisk();
		                          }
		                      }).appendTo(aGroup);
		
		                      const bGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("N").appendTo(bGroup);
		                      const checkB = $("<div>");
		                      checkB.dxCheckBox({
		                          value: data.EVLTN_RSLT === "N"
		                        , disabled: isCkAbled
		                        , onValueChanged: function(e) {
		                        	  
		                        	  if (e.value) {
		                           		  
		                        		  e.component.option("value", true);
		                                  checkA.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "N";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                        	  evaluateRisk();
		                          }
		                      }).appendTo(bGroup);
		
		                      wrapper.append(aGroup, bGroup);
		                      container.append(wrapper);
		                  }
		              }
		              , {"dataField":"EVLTN_RSLT_RMRK","caption": "${msgel.getMsg('AML_10_25_02_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": true, "width": "20%"
		            	  
		            	  , "cellTemplate": function (container, options) {
		   	            		
		   	            		const value = options.value;
			   	 	   	        const tempText = options.data.EVLTN_RMRK || "";
			   	 	   	        //const placeholder = `${tempText}`;
			   	 	   	        const displayText = value || tempText;
			   	 	   	        const span = $("<span>").addClass(value ? "" : "placeholder-fake").css({
			   	 	   	                "display": "inline-block",
			   	 	   	                "white-space": "nowrap",
			   	 	   	                "overflow": "hidden",
			   	 	   	                "text-overflow": "ellipsis",
			   	 	   	                "max-width": "100%",
			   	 	   	         		"color" : "#444",
			   	 	   	            }).attr("title", displayText).text(displayText);
	
			   	 	   	        container.append(span);
		                    }
	 	                    , "editCellTemplate": function (cellElement, cellInfo) {
			                    	
		                        const textarea = document.createElement("textarea");
		                        textarea.className = "custom-textarea";
		                        textarea.value = cellInfo.value || "";
		                        textarea.disabled = isCkAbled;
		                        textarea.addEventListener("input", function () {
		                            cellInfo.setValue(this.value);
		                        });
		                        
		                        cellElement[0].innerHTML = "";
		                        cellElement[0].appendChild(textarea);
			                }
		                }
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"EVLTN_RMRK", "caption": 'EVLTN_RMRK', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
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
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P104"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
		              , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RSLT","caption": "${msgel.getMsg('AML_10_25_02_02_022', '답변')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false
		            	  
		            	  , "cellTemplate":  function(container, options) {
		            		  
		                      const data = options.data;
		                      const wrapper = $("<div>").addClass("checkbox-container");
		                      const aGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("Y").appendTo(aGroup);
		                      
		                      const checkA = $("<div>");	                          
		                      checkA.dxCheckBox({
		                          value: data.EVLTN_RSLT === "Y"
		                        , disabled: isCkAbled
		                        , onValueChanged: function(e) {
		                        	
		                              if(e.value){
		                           		  
		                            	  e.component.option("value", true);
		                                  checkB.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "Y";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                              evaluateRisk();
		                          }
		                      }).appendTo(aGroup);
		
		                      const bGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("N").appendTo(bGroup);
		                      const checkB = $("<div>");
		                      checkB.dxCheckBox({
		                          value: data.EVLTN_RSLT === "N"
		                        , disabled: isCkAbled
		                        , onValueChanged: function(e) {
		                        	  
		                        	  if (e.value) {
		                           		  
		                        		  e.component.option("value", true);
		                                  checkA.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "N";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                        	  evaluateRisk();
		                          }
		                      }).appendTo(bGroup);
		
		                      wrapper.append(aGroup, bGroup);
		                      container.append(wrapper);
		                  }
		              }
		              , {"dataField":"EVLTN_RSLT_RMRK","caption": "${msgel.getMsg('AML_10_25_02_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": true, "width": "20%"
		            	  
		            	  , "cellTemplate": function (container, options) {
		   	            		
		   	            		const value = options.value;
			   	 	   	        const tempText = options.data.EVLTN_RMRK || "";
			   	 	   	        //const placeholder = `${tempText}`;
			   	 	   	        const displayText = value || tempText;
			   	 	   	        const span = $("<span>").addClass(value ? "" : "placeholder-fake").css({
			   	 	   	                "display": "inline-block",
			   	 	   	                "white-space": "nowrap",
			   	 	   	                "overflow": "hidden",
			   	 	   	                "text-overflow": "ellipsis",
			   	 	   	                "max-width": "100%",
			   	 	   	        		"color" : "#444",
			   	 	   	            }).attr("title", displayText).text(displayText);
	
			   	 	   	        container.append(span);
		                    }
		                    , "editCellTemplate": function (cellElement, cellInfo) {
			                    	
		                        const textarea = document.createElement("textarea");
		                        textarea.className = "custom-textarea";
		                        textarea.value = cellInfo.value || "";
		                        textarea.disabled = isCkAbled;
		                        textarea.addEventListener("input", function () {
		                            cellInfo.setValue(this.value);
		                        });
		                        
		                        cellElement[0].innerHTML = "";
		                        cellElement[0].appendChild(textarea);
			                }
		                }
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"EVLTN_RMRK", "caption": 'EVLTN_RMRK', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
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
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P105"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
		              , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "30%" }
		              , {"dataField":"EVLTN_RSLT","caption": "${msgel.getMsg('AML_10_25_02_02_022', '답변')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false 
		            	  
		            	  , "cellTemplate":  function(container, options) {
		            		  
		                      const data = options.data;
		                      const wrapper = $("<div>").addClass("checkbox-container");
		                      const aGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("Y").appendTo(aGroup);
		                      
		                      const checkA = $("<div>");	                          
		                      checkA.dxCheckBox({
		                          value: data.EVLTN_RSLT === "Y"
		                        , disabled: isCkAbled
		                        , onValueChanged: function(e) {
		                        	
		                              if(e.value){
		                           		  
		                            	  e.component.option("value", true);
		                                  checkB.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "Y";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                              evaluateRisk();
		                          }
		                      }).appendTo(aGroup);
		
		                      const bGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("N").appendTo(bGroup);
		                      const checkB = $("<div>");
		                      checkB.dxCheckBox({
		                          value: data.EVLTN_RSLT === "N"
		                        , disabled: isCkAbled
		                        , onValueChanged: function(e) {
		                        	  
		                        	  if (e.value) {
		                           		  
		                        		  e.component.option("value", true);
		                                  checkA.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "N";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                        	  evaluateRisk();
		                          }
		                      }).appendTo(bGroup);
		
		                      wrapper.append(aGroup, bGroup);
		                      container.append(wrapper);
		                  }
		              }
		              , {"dataField":"EVLTN_RSLT_RMRK","caption": "${msgel.getMsg('AML_10_25_02_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": true, "width": "20%"
		            	  
		            	  , "cellTemplate": function (container, options) {
		   	            		
		   	            		const value = options.value;
			   	 	   	        const tempText = options.data.EVLTN_RMRK || "";
			   	 	   	        //const placeholder = `${tempText}`;
			   	 	   	        const displayText = value || tempText;
			   	 	   	        const span = $("<span>").addClass(value ? "" : "placeholder-fake").css({
			   	 	   	                "display": "inline-block",
			   	 	   	                "white-space": "nowrap",
			   	 	   	                "overflow": "hidden",
			   	 	   	                "text-overflow": "ellipsis",
			   	 	   	                "max-width": "100%",
			   	 	   	         		"color" : "#444",
			   	 	   	            }).attr("title", displayText).text(displayText);
	
			   	 	   	        container.append(span);
		                    }
		                    , "editCellTemplate": function (cellElement, cellInfo) {
			                    	
		                        const textarea = document.createElement("textarea");
		                        textarea.className = "custom-textarea";
		                        textarea.value = cellInfo.value || "";
		                        textarea.disabled = isCkAbled;
		                        textarea.addEventListener("input", function () {
		                            cellInfo.setValue(this.value);
		                        });
		                        
		                        cellElement[0].innerHTML = "";
		                        cellElement[0].appendChild(textarea);
			                }
		                }
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"EVLTN_RMRK", "caption": 'EVLTN_RMRK', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
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
		                {"dataField":"RISK_TP_CD", "caption": "${msgel.getMsg('AML_10_25_01_02_002', '위험구분')}", "alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting" :false,"allowEditing": false, "allowEditing" : false, "width": "15%"
		                	, "lookup" : {
		    	                  dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P106"))%>
		    		              ,displayExpr : "VALUE"
		    		              ,valueExpr   : "KEY"
		    	            }
		                }
		              , {"dataField":"SRT_ORDR", "caption": "${msgel.getMsg('AML_10_25_02_02_055', '순서')}","alignment": "center", "allowResizing": true,"allowSearch": true, "allowSorting": true , "allowEditing" : false, "width": "5%" }
		              , {"dataField":"EVLTN_ITEM","caption": "${msgel.getMsg('AML_10_25_01_02_003', '평가항목')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "width": "60%", "encodeHtml":false }
		              , {"dataField":"EVLTN_STND","caption": "${msgel.getMsg('AML_10_25_01_02_004', '평가기준')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false, "visible" : false }
		              , {"dataField":"EVLTN_RSLT","caption": "${msgel.getMsg('AML_10_25_02_02_022', '답변')}","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": false 
		            	  
			               , "cellTemplate":  function(container, options) {
			            		  
		                      const data = options.data;
		                      const wrapper = $("<div>").addClass("checkbox-container");
		                      const aGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("Y").appendTo(aGroup);
		                      
		                      const checkA = $("<div>");	                          
		                      checkA.dxCheckBox({
		                          value: data.EVLTN_RSLT === "Y"
		                        , disabled: isCkAbled2
		                        , onValueChanged: function(e) {
		                        	
		                              if(e.value){
		                           		  
		                            	  e.component.option("value", true);
		                                  checkB.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "Y";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                              evaluateRisk();
		                          }
		                      }).appendTo(aGroup);
		
		                      const bGroup = $("<div>").addClass("label-checkbox");
		                      $("<span>").text("N").appendTo(bGroup);
		                      const checkB = $("<div>");
		                      checkB.dxCheckBox({
		                          value: data.EVLTN_RSLT === "N"
		                        , disabled: isCkAbled2
		                        , onValueChanged: function(e) {
		                        	  
		                        	  if (e.value) {
		                           		  
		                        		  e.component.option("value", true);
		                                  checkA.dxCheckBox("instance").option("value", false);
		                                  options.data.EVLTN_RSLT = "N";
		                                  
		                              }else{
		                            	  
		                            	  options.data.EVLTN_RSLT = "";
		                              }
		                              
		                        	  evaluateRisk();
		                          }
		                      }).appendTo(bGroup);
		
		                      wrapper.append(aGroup, bGroup);
		                      container.append(wrapper);
		                  }
		              }
		              , {"dataField":"EVLTN_RSLT_RMRK","caption": "${msgel.getMsg('AML_10_25_02_02_023', '비고')}","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": false,"allowEditing": true, "width": "20%"
		            	  
		            	  , "cellTemplate": function (container, options) {
		   	            		
		   	            		const value = options.value;
			   	 	   	        const tempText = options.data.EVLTN_RMRK || "";
			   	 	   	        //const placeholder = `${tempText}`;
			   	 	   	        const displayText = value || tempText;
			   	 	   	        const span = $("<span>").addClass(value ? "" : "placeholder-fake").css({
			   	 	   	                "display": "inline-block",
			   	 	   	                "white-space": "nowrap",
			   	 	   	                "overflow": "hidden",
			   	 	   	                "text-overflow": "ellipsis",
			   	 	   	                "max-width": "100%",
			   	 	   	         		"color" : "#444",
			   	 	   	            }).attr("title", displayText).text(displayText);
	
			   	 	   	        container.append(span);
		                    }
		                    , "editCellTemplate": function (cellElement, cellInfo) {
			                    	
		                        const textarea = document.createElement("textarea");
		                        textarea.className = "custom-textarea";
		                        textarea.value = cellInfo.value || "";
		                        textarea.disabled = isCkAbled2;
		                        textarea.addEventListener("input", function () {
		                            cellInfo.setValue(this.value);
		                        });
		                        
		                        cellElement[0].innerHTML = "";
		                        cellElement[0].appendChild(textarea);
			                }
		                }
		              , {"dataField":"LV1", "caption": 'LV1', "visible" : false }
		              , {"dataField":"LV2", "caption": 'LV2', "visible" : false }
		              , {"dataField":"LV3", "caption": 'LV3', "visible" : false }
		              , {"dataField":"EVLTN_RMRK", "caption": 'EVLTN_RMRK', "visible" : false }
		              , {"dataField":"RSNB_HRSK_RLVN_YN", "caption": 'RSNB_HRSK_RLVN_YN',"visible" : false }
		              , {"dataField":"DEP_TP_CD", "caption": 'DEP_TP_CD',"visible" : false }
		         ]
	       	}).dxDataGrid("instance");
    	 
    	  GridObjArr.length = 0;
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
    
    function doCdSearch_End(gridData, data){
    	
 	   $.each(gridData, function(idx, val) {
 		  $("#PRD_TP_CD").append('<option class="dropdown-option" value="'+ val.CD +'">'+ val.CD_NM +'</option>');
 	   });
 	   
 	   $.each(data.PARAM_DATA, function(idx, val) {
  		  
 		   if( val.KEY == 'PRD_TP_CD'){
 			   
 			 $("#PRD_TP_CD").val(val.VALUE);
 		   	 return false;
 		   }
	   });
   }
    
    function doSearch(){
    	
    	overlay.show(true, true);
    	
        var params = new Object();
        
        if( !isEmpty(prdEvltnId)  ){
           params.PRD_EVLTN_ID = prdEvltnId;
        }
        
        sendService("AML_10_25_02_02", "getSearch", params, doSearch_end, doSearch_end); 
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

     	prdEvltnId = isEmpty(gridData[0].PRD_EVLTN_ID)?"":gridData[0].PRD_EVLTN_ID;
        prdCkId = gridData[0].PRD_CK_ID;
        
        $("#VERSION_ID").val(gridData[0].VERSION_ID);
     	$("#PRD_NM").val(gridData[0].PRD_NM);

     	if( !isEmpty(gridData[0].EVLTN_DEPT_NM) ){
     	  $("#EVLTN_DEPT_NM").val(gridData[0].EVLTN_DEPT_NM);
     	  $("#EVLTN_DEPT_ID").val(gridData[0].EVLTN_DEPT_ID);
        }
     	if( !isEmpty(gridData[0].EVLTN_USER_ID) ){
       	  $("#EVLTN_USER_LG_ID").val(gridData[0].EVLTN_USER_ID);
       	  $("#EVLTN_USER_ID").val(gridData[0].EVLTN_USER_ID);
        }
     	if( !isEmpty(gridData[0].EVLTN_USER_NM) ){
       	  $("#EVLTN_USER_NM").val(gridData[0].EVLTN_USER_NM);
        }
	    if( !isEmpty(gridData[0].RLS_EXPCT_DT) ){
	    	 setDxDateVal("RLS_EXPCT_DT_TMP" , gridData[0].RLS_EXPCT_DT);
		}
	    if( !isEmpty(gridData[0].EVLTN_PRF_DT) ){
	    	 setDxDateVal("EVLTN_PRF_DT_TMP" , gridData[0].EVLTN_PRF_DT);
		}
     	$("#PRD_RMRK_TMP").val(gridData[0].PRD_RMRK);     	
     	$("#SMRY_OPNN_TMP").val(gridData[0].SMRY_OPNN);
     	$("#PRD_CTGR_CD").val(gridData[0].PRD_CTGR_CD);
     	$("#PRD_TP_CD option:not(:eq(0))").remove();
     	
     	appno = gridData[0].APP_NO;
		var params = new Object();
		params.PRD_TP_CD = gridData[0].PRD_TP_CD
		if( gridData[0].PRD_CTGR_CD == 'PRDT' ){
		  params.CD = "P202";
		}else if( gridData[0].PRD_CTGR_CD == 'SVC' ){
		  params.CD = "P203";
		}
	    sendService("AML_10_25_02_01", "getCodeSearch", params, doCdSearch_End, doCdSearch_End); 
     	
     	evaluateRisk();

     	if(ROLEID == "4") { 
     		if(EVLTN_STATE == "SS" || EVLTN_STATE == "RR" || EVLTN_STATE == "E") {
     			$("#btn_01").hide();
     	     	$("#btn_02").hide();		
            }else {
            	if(prdEvltnId == "" || prdEvltnId.trim() == "") {
         	     	$("#btn_02").hide();
            	}else {
            		$("#btn_01").show();
         	     	$("#btn_02").show();
            	}
            }
        }
    }

    function doSearchPreEvltn(  prdEvltnId ){
    	
    	overlay.show(true, true);
    	
        var params = new Object();
        
        if( !isEmpty(prdEvltnId)  ){
           params.PRD_EVLTN_ID = prdEvltnId;
        }
        
        sendService("AML_10_25_02_02", "getSearch", params, doSearchPreEvltn_end, doSearchPreEvltn_end); 
    }
    
    function doSearchPreEvltn_end(gridData, actionParam){
    	
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

     	evaluateRisk();
    }
    
    function doSubmit_end(fileData){
    	
    	var addLine;
        var divId = fileData.storedFileNm.substring(0,fileData.storedFileNm.lastIndexOf("."));
       	
       	if(fileData != undefined){

       		if( $("#fileBox > tr > td").html() == '&nbsp;'){

       			$("#fileBox").children().first().remove();
            }
       		
       		addLine	= "<tr id='"+divId+"'>"
       				+"<td style=\"text-align: center;\"></td>"
       				+"<td class=\"file-name\">"+fileData.origFileNm+"</td>"
       				+"<td style=\"text-align:center;\">"+fileData.fileSize+"&nbsp;kb</td>"
       				+"<td style=\"text-align: center;\">"
       				+" <a onclick=\"prdTempFileDel('"+divId+"','/upload/attachTmp/','"+fileData.storedFileNm+"');\" >"
       				+"  <input type='hidden' name='fileSizes' id='fileSizes' class='fileSize' value='"+fileData.fileSize+"' />"
       				+"  <input type='hidden' name='origFileNms' id='origFileNms' class='origFileNm' value='"+fileData.origFileNm+"' />"
       				+"  <input type='hidden' name='storedFileNms' id='storedFileNms' class='storedFileNm' value='"+fileData.storedFileNm+"' />"
       				+"  <input type='hidden' name='filePaths' id='filePaths' class='filePath' value='"+fileData.filePath+"' />"
       				+"  <div class='dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon' role='button' aria-hidden='true' aria-label='close'>"
       				+"	 <div class='dx-button-content'><span class=\"delete-link\">${msgel.getMsg('AML_10_25_02_02_035', '삭제')}</span></div>"
       				+"  </div>"
       				+" </a>"
       				+" </td>"
       				+"</tr>";
       				
       		$("#fileBox").append(addLine);
       	}	
    }	

    function prdViewDelete(org){
        
    	$(org).closest(".tx").remove();

    	if( isEmpty($("#fileBox > tr > td").html()) ){

    		var child = "<tr><td colspan=\"4\" style=\"text-align: center;\" >&nbsp;</td></tr>";
   			$("#fileBox").append(child);
        }
    }

    function prdTempFileDel(id,p,f){
    
    	var form = document.fileFrm;
     	fileFrm.downFilePath.value =p;
     	fileFrm.downFileName.value = f;
     	
     	var option = {
     		url : '/file/fileDel.do',
     		dataType : 'json'
     	};

     	$('#fileFrm').ajaxSubmit(option);
    	$("#"+id).remove();	

    	if( isEmpty($("#fileBox > tr > td").html()) ){

    		var child = "<tr><td colspan=\"4\" style=\"text-align: center;\" >&nbsp;</td></tr>";
   			$("#fileBox").append(child);
        }
        
     	return false;
    }
    
    
     //파일 다운
     function downloadFile(f,o,p){
         
     	$("#downFileName").val(f);
     	$("#orgFileName").val(o); 
     	$("#downFilePath").val($("#filePaths").val()); 	
     	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
     	$("#fileFrm").submit();
     }

     function doDisabledSet(){

	    $("#VERSION_ID").prop("disabled", true);
     	$("#preRsltList").hide();
     	$("#preRsltCmnt").hide(); 
     	$("#PRD_CTGR_CD").prop("disabled", true);
     	$("#PRD_TP_CD").prop("disabled", true);
     	$("#PRD_NM").prop("disabled", true);
     	$("#EVLTN_DEPT_NM").prop("disabled", true);
     	$("#EVLTN_USER_LG_ID").prop("disabled", true);
     	$("#EVLTN_USER_NM").prop("disabled", true);
     	$("#RLS_EXPCT_DT_TMP").prop("disabled", true);
     	$("#EVLTN_PRF_DT_TMP").prop("disabled", true);
     	$("#PRD_RMRK_TMP").prop("disabled", true);

     	$(".dx-texteditor-input-container").children("input").prop("disabled", true);
     	$(".dx-texteditor-buttons-container").remove(); 
     	
     }

     function doAbledSet(){
         
      	$("#PRD_CTGR_CD").prop("disabled", false);
      	$("#PRD_TP_CD").prop("disabled", false);
      	$("#PRD_NM").prop("disabled", false);
      	$("#EVLTN_DEPT_NM").prop("disabled", false);
      	$("#EVLTN_USER_LG_ID").prop("disabled", false);
      	$("#EVLTN_USER_NM").prop("disabled", false);
      	$("#RLS_EXPCT_DT_TMP").prop("disabled", false);
      	$("#EVLTN_PRF_DT_TMP").prop("disabled", false);
      	$("#PRD_RMRK_TMP").prop("disabled", false);
     }

     
     function doSave(){
    	 if( !CheckValue() ){
      		 overlay.hide();
      		 return;
      	  }
    	 
    	var inputText = $("#PRD_RMRK_TMP").val();
  	    //var minLen = inputText.replace(/\s/g , "").length;
  	   
    	if( isEmpty($("#PRD_NM").val()) ){

			showAlert( "${msgel.getMsg('AML_10_25_02_02_046', '상품·서비스명을 입력하세요.')}", "WARN");
			$("#PRD_NM").focus();
			
			return;
			
    	}
    	//else if(minLen < 30){
    	//	showAlert( "${msgel.getMsg('AML_10_25_02_01_014', '종합의견은 최소 30자(공백 제거) 이상 입력해야 합니다.')}", "WARN");
   	    // 	return;
	    //}
	   
    	var gridArr = [];
     	var totalLen = GridObjArr.length;
        for( var idx = 0 ; idx < totalLen ; idx++ ){
         
           var tempData = getDataSource( GridObjArr[idx] );
         	
           if( tempData.length > 0 ){
         		
 	         	for( var i = 0 ; i < tempData.length ; i++ ){
 	        	
 	        		var tempLow = {};
 	        		tempLow.LV1 = tempData[i].LV1;
 	        		tempLow.LV2 = tempData[i].LV2; 
 	        		tempLow.LV3 = tempData[i].LV3;
 	        		tempLow.RSNB_HRSK_RLVN_YN = tempData[i].RSNB_HRSK_RLVN_YN;
 	        		tempLow.RISK_TP_CD = tempData[i].RISK_TP_CD;
 	        		tempLow.EVLTN_RSLT = tempData[i].EVLTN_RSLT;
 	        		tempLow.EVLTN_RSLT_RMRK = tempData[i].EVLTN_RSLT_RMRK;
 	        		
 	        		gridArr.push(tempLow);
 	        	}
           }
        }
         
    	form1.GRID_DATA.value = JSON.stringify(gridArr);
        form1.PRD_EVLTN_ID.value = prdEvltnId;
        form1.PRD_CK_ID.value = prdCkId;
    	form1.RLS_EXPCT_DT.value = getDxDateVal("RLS_EXPCT_DT_TMP", true);
    	form1.EVLTN_PRF_DT.value = getDxDateVal("EVLTN_PRF_DT_TMP", true);
    	form1.PRD_RMRK.value = $("#PRD_RMRK_TMP").val();
    	form1.SMRY_OPNN.value = $("#SMRY_OPNN_TMP").val();
    	form1.EVLTN_STATE.value = 'SN';
    	form1.RSK_GRD.value = form1.RSK_GRD.value;
    	form1.APP_NO.value = '<c:out value="${APP_NO}"/>';
    	  
    	showConfirm('${msgel.getMsg("RBA_90_01_06_01_109","저장하시겠습니까")}', "저장", 	function(){
    		
    		var option = {
    				url : '${ctx}/prd/doPrdSave.do',
    				dataType : 'json',				
    				success : function(data){			
    					
    					if(data.status == 'success'){

    						showAlert(data.serviceMessage,"INFO", function(){

    							form2.PRD_EVLTN_ID.value = data.SAVE.PRD_EVLTN_ID;
    						    form2.PRD_CK_ID.value = data.SAVE.PRD_CK_ID;
    					    	form2.pageID.value = "AML_10_25_02_08";
    							form2.target = '_self';
    						    form2.action = '${path}/0001.do';
    						    form2.submit();
        				     });
        						
    						doSave_end(data);
    						
    					}else{

    						showAlert(data.serviceMessage,"ERR");	
    					}	
    				}				 
    		};
    		
    		$('#form1').ajaxSubmit(option);
    		return false;
    	});
    }
     
     
    function doSave_end(data){
	    
    	if( opener ){
    	  opener.doSearch();
    	}
    }
     
    // 위험도 계산
    function evaluateRisk() {
    	
    	var rsnbHrskRlvnYn = false;  //당연고위험 
    	var srcTotal = 0;
    	var ckTotal = 0;
    	var ckCnt = 0;
    	var ckCnt2 = 0;
     	var noneCkCnt = 0;
     	var noneCkCnt2 = 0;
    	var gridObjArrLen = GridObjArr.length;
     	
        for( var idx = 1 ; idx < gridObjArrLen ; idx++ ){
         
           var tempData = getDataSource( GridObjArr[idx] );
           
           if( idx < 5 ){
              
        	   //배점
        	   srcTotal += tempData.length;
               $("#srcCnt"+String(idx).padStart(2,"0")).html( tempData.length );
               $("#ownTotalScore").html( srcTotal );
               
               //위험점수
               for( var i = 0 ; i < tempData.length ; i++ ){
            	   
            	   // 배점
        		   if( tempData[i].EVLTN_RSLT == 'Y' ){
        			   ckCnt++;
        			   ckTotal++;
        		   }

        		   // 빈값 체크
            	   if( isEmpty( tempData[i].EVLTN_RSLT ) ){
            		   noneCkCnt++;
            	   }
            	   
        		   // 당연 고위험
        		   if( tempData[i].EVLTN_RSLT == 'Y' && tempData[i].RSNB_HRSK_RLVN_YN == 'Y' ){
        			   rsnbHrskRlvnYn = true;
        		   }
        			   
        		   $("#ckCnt"+String(idx).padStart(2,"0")).html( ckCnt );
               }

               $("#ownTotalRisk").html( ckTotal );
               ckCnt = 0;
               
           }else{
               
        	   var crtlTpcd = '';
        	   var ctrlCnt = 0;
        	   var ctrlCnt2 = 0;
        	   for( var i = 0 ; i < tempData.length ; i++ ){
        		   
        		   if( isEmpty(crtlTpcd) || crtlTpcd == tempData[i].RISK_TP_CD ){
        			   
        			   //배점
        			   crtlTpcd = tempData[i].RISK_TP_CD;
        			   ctrlCnt++;
        			   $("#srcCnt"+String(idx).padStart(2,"0")).html( ctrlCnt );
        			   
        			   // 빈값 체크
                	   if( isEmpty( tempData[i].EVLTN_RSLT ) ){
                		   noneCkCnt2++;
                	   }
        			   
        			    //위험점수
        			   if( tempData[i].EVLTN_RSLT == 'N' ){
            			   ckCnt++;
            		   }
        			   
        			   $("#ckCnt"+String(idx).padStart(2,"0")).html( ckCnt );
        			   
        		   }else if( crtlTpcd != tempData[i].RISK_TP_CD ){

        			   //배점
        			   ctrlCnt2++;
        			   $("#srcCnt"+String(idx+1).padStart(2,"0")).html( ctrlCnt2 );
        			   
        			   //위험점수
        			   if( tempData[i].EVLTN_RSLT == 'N' ){
        				   ckCnt2++;
            		   }else if( isEmpty( tempData[i].EVLTN_RSLT ) ){
                		   noneCkCnt2++;
                	   }
        			   
        			   $("#ckCnt"+String(idx+1).padStart(2,"0")).html( ckCnt2 );
        		   }
               }
        	 
        	   $("#ctrlTotalScore").html( ctrlCnt + ctrlCnt2 );
        	   $("#ctrlTotalRisk").html( ckCnt + ckCnt2 );
           }
        }
        
        var ownTotalScore = parseFloat($("#ownTotalScore").html());
        var ownTotalRisk = parseFloat($("#ownTotalRisk").html());
        var ctrlTotalScore = parseFloat($("#ctrlTotalScore").html());
        var ctrlTotalRisk = parseFloat($("#ctrlTotalRisk").html());
        var rsltTotal = (( ownTotalRisk/ ownTotalScore ) * 100); 
        rsk_scr = ownTotalRisk;
        
        //고유위험평가
        if( rsltTotal < 30 ){
        	
        	form1.RSK_GRD.value = "30101";
        	$("#ownRiskResult").html('${msgel.getMsg("AML_10_25_02_02_036","저위험")}');
        	$("#ownRiskResult").css({"background-color": "#e8f1f9"});
        	
        }else if( rsltTotal >= 30 && rsltTotal < 60 ){
        	
        	form1.RSK_GRD.value = "30102";
        	$("#ownRiskResult").html('${msgel.getMsg("AML_10_25_02_02_037","중위험")}');
        	$("#ownRiskResult").css({"background-color": "#ffab42"});
        }else{	
        	
        	form1.RSK_GRD.value = "30103";
        	$("#ownRiskResult").html('${msgel.getMsg("AML_10_25_02_02_038","고위험")}');
        	$("#ownRiskResult").css({"background-color": "#ff6628"});
        }

        if( rsnbHrskRlvnYn ){
        	
        	form1.RSK_GRD.value = "30103";
        	form1.RSNB_EDD_YN.value = "Y"; //당연EDD여부
        	$("#ownRiskResult").html('${msgel.getMsg("AML_10_04_01_04_108","당연고위험")}');
        	$("#ownRiskResult").css({"background-color": "#ff6628"});
        }
        
        //통제위험평가
        if( ctrlTotalRisk > 0 ){
        	
        	form1.CNTRL_RVW_YN.value = "Y";
        	$("#ctrlRiskResult").html('${msgel.getMsg("AML_10_25_02_02_040","통제 미비사항 존재 - 재검토 필요")}');
        	$("#ctrlRiskResult").css({"background-color": "#efbfbf"});
        	$("#btn_03").hide();
        	
        }else{
        	
        	form1.CNTRL_RVW_YN.value = "N";
        	$("#ctrlRiskResult").html('${msgel.getMsg("AML_10_25_02_02_041","이상없음")}');
        	$("#ctrlRiskResult").css({"background-color": "#e2f0d9"});
        	$("#btn_03").show();
        }

        if( noneCkCnt > 0 ){
        	
           form1.RSK_GRD.value = "";
           form1.RSNB_EDD_YN.value = ""; //당연EDD여부
      	   $("#ownRiskResult").html('${msgel.getMsg("AML_10_25_02_02_042","고유위험평가를 완료하세요.")}');
      	   $("#ownRiskResult").css({"background-color": "#ffffff"});
        }
         
        if( noneCkCnt2 > 0 ){
         	
      	   form1.CNTRL_RVW_YN.value = "";
      	   $("#ctrlRiskResult").html('${msgel.getMsg("AML_10_25_02_02_043","통제위험평가를 완료하세요.")}');
      	   $("#ctrlRiskResult").css({"background-color": "#ffffff"});
        }
    }
    
    
    function CheckValue(){
    	var inputText = $("#PRD_RMRK_TMP").val();
    	var minLen = inputText.replace(/\s/g , "").length;
    	
    	var inputText2 = $("#SMRY_OPNN_TMP").val();
    	var minLen2 = inputText2.replace(/\s/g , "").length;
    	
    	if(minLen < 30){
    		showAlert( "${msgel.getMsg('AML_10_25_02_01_014', '종합의견은 최소 30자(공백 제거) 이상 입력해야 합니다.')}", "WARN");
   	     	return false;
	    }
    	
		if(minLen2 < 30) {
			showAlert( "${msgel.getMsg('AML_10_25_02_02_049', '자금세탁사기예방팀 종합의견을 작성하세요.')}", "WARN");
			return false;
        }
    	
    	if( isEmpty($("#PRD_CTGR_CD").val()) ){

			showAlert( "${msgel.getMsg('AML_10_25_02_02_044', '상품·서비스 구분을 선택하세요.')}", "WARN");
			$("#PRD_CTGR_CD").focus();
			
			return false;

    	}

        if( isEmpty($("#PRD_TP_CD").val()) ){
    		
			showAlert( "${msgel.getMsg('AML_10_25_02_02_045', '상품유형을 선택하세요.')}", "WARN");
			$("#PRD_TP_CD").focus();
			
			return false;
    	}

        if( isEmpty($("#PRD_NM").val()) ){
		
			showAlert( "${msgel.getMsg('AML_10_25_02_02_046', '상품·서비스명을 입력하세요.')}", "WARN");
			$("#PRD_NM").focus();
			
			return false;
        }

        var ROLEID = '<c:out value="${ROLEID}"/>';
        var todayDate = "${todayDate}".replaceAll("-", "");
        var rlsExpctDt = getDxDateVal("RLS_EXPCT_DT_TMP", true)
        var evltnPrfDt = getDxDateVal("EVLTN_PRF_DT_TMP", true)
        
	    if((rlsExpctDt < todayDate) ){

	    	showAlert( "${msgel.getMsg('AML_10_25_02_02_047', '출시예정일자가 오늘보다 이전일 수 없습니다.')}", "WARN");
			$("#RLS_EXPCT_DT_TMP > div.dx-dropdowneditor-input-wrapper > div > div.dx-texteditor-input-container > input").focus();
			
            return false;
		}

        if((evltnPrfDt < todayDate) ){

	    	showAlert( "${msgel.getMsg('AML_10_25_02_02_048', '위험평가 수행일자가 오늘보다 이전일 수 없습니다.')}", "WARN");
			$("#EVLTN_PRF_DT_TMP > div.dx-dropdowneditor-input-wrapper > div > div.dx-texteditor-input-container > input").focus();
			
			return false;
		}
        
		var isEmptyYn = true;
		var totalLen = GridObjArr.length;

		for( var idx = 0 ; idx < totalLen ; idx++ ){
		        
        	var tempData = getDataSource( GridObjArr[idx] );

        	
        	
       	    if( !isCkAbled && idx < 5 ){

       	    	for( var i = 0 ; i < tempData.length ; i++ ){
        			
	        	    var vsCells = GridObjArr[idx].getVisibleColumns();
	        	    
		        	for( var j = 0 ; j < vsCells.length ; j++ ){
		        		if( "EVLTN_RSLT" == vsCells[j].dataField && isEmpty( tempData[i][vsCells[j].dataField] )){
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
        		
       	    }else if( !isCkAbled2 && idx >= 5 ){

       	    	for( var i = 0 ; i < tempData.length ; i++ ){
        			
	        	    var vsCells = GridObjArr[idx].getVisibleColumns();
	        		
		        	for( var j = 0 ; j < vsCells.length ; j++ ){
	        		    
		        		if( "EVLTN_RSLT" == vsCells[j].dataField && isEmpty( tempData[i][vsCells[j].dataField] )){

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
        	}   

       	    if(!isEmptyYn){
        		break;
        	}
        }

	    if( !isEmptyYn ){

	       return false;
		}

		return true;
   }

    function exportEvltn(){

  	  overlay.show(true, true);
  	
      var params = new Object();
      params.PRD_EVLTN_ID = prdEvltnId;
      sendService("AML_10_25_02_02", "doExportPrdEvltn", params, exportEvltn_end, exportEvltn_end);
      
  	}

  	function exportEvltn_end( grid, data){

  		overlay.hide();

  		var ck = true;
  		if( !isEmpty(data.PARAM_DATA) ){
	  		
	        $.each( data.PARAM_DATA, function(i,v){
	
	            if( v.KEY == 'fileName' && v.VALUE != 0 ){
	
	    			$("[name=pageID]", "#fileFrm").val("AML_10_25_02_02");
	    	    	$("#downFileName").val(v.VALUE + ".xlsx");
	    	    	$("#orgFileName").val(v.VALUE + ".xlsx");
	    	    	$("#downFilePath").val("");
	    	    	$("#FILE_SEQ").val(0);
	    	    	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
	    	    	$("#fileFrm").submit();
	    	    	
	    	    	 ck = false;
	      	    	 return false;
	            }
	        });
  	    }

  		if(ck){
	          
	       showAlert("처리 중 오류가 발생하였습니다","ERR");
	    }
  	}

   function doPrdAppr(target){

	  if( !CheckValue() ){
		 overlay.hide();
	 	 return;
	  }

	  var msg = "", msg2 ="" ;
      var targetPageId = "AML_10_25_01_04";
      
	  if( target == "R" ){

		 msg = '${msgel.getMsg("AML_10_25_01_02_026","반려 하시겠습니까?")}'
		 msg2 = '${msgel.getMsg("AML_10_25_01_02_020","반려")}'
		 targetPageId = "AML_10_25_02_05";
    	
      }else{

    	 msg = '${msgel.getMsg("AML_10_25_01_02_024","승인요청 하시겠습니까?")}'
    	 msg2 = '${msgel.getMsg("AML_10_22_00_01_010","승인")}'
    	 targetPageId = "AML_10_25_02_04";    		
    	
      }
	
  	  showConfirm( msg, msg2, function(){
  		  
  		  form2.dis_flag.value = "P";
  		  form2.pageID.value = targetPageId;
  		  form2.target = targetPageId;
  		  form2.action = '${path}/0001.do';
  		  form2.method = "post";
          window_popup_open(form2.pageID.value, 600, 300, '','yes');
     	  form2.submit();
     	  form2.target = '';
  	  });
   }
   	   
   function doAppr( rsnCntnt, target){

	  overlay.show(true, true);
	   
  	  var classID = "AML_10_25_02_02";
   	  var methodID = "doPrdApprReq"

      doAbledSet();
      	  
   	  var gridArr = [];
	  var totalLen = GridObjArr.length;
	  for( var idx = 0 ; idx < totalLen ; idx++ ){
	
		  var tempData = getDataSource( GridObjArr[idx] );
		 
		  if( tempData.length > 0 ){
		   		
		     for( var i = 0 ; i < tempData.length ; i++ ){
		   			
				var tempLow = {};
				tempLow.LV1 = tempData[i].LV1;
				tempLow.LV2 = tempData[i].LV2;
				tempLow.LV3 = tempData[i].LV3;
				tempLow.RSNB_HRSK_RLVN_YN = tempData[i].RSNB_HRSK_RLVN_YN;
				tempLow.RISK_TP_CD = tempData[i].RISK_TP_CD;
				tempLow.EVLTN_RSLT = tempData[i].EVLTN_RSLT;
				tempLow.EVLTN_RSLT_RMRK = tempData[i].EVLTN_RSLT_RMRK;
				
				gridArr.push(tempLow);
			}
		  }
	  }
	
	  form1.GRID_DATA.value = JSON.stringify(gridArr);
	  form1.PRD_EVLTN_ID.value = prdEvltnId;
	  form1.PRD_CK_ID.value = prdCkId;
	  form1.RLS_EXPCT_DT.value = getDxDateVal("RLS_EXPCT_DT_TMP", true);
	  form1.EVLTN_PRF_DT.value = getDxDateVal("EVLTN_PRF_DT_TMP", true);
	  form1.PRD_RMRK.value = $("#PRD_RMRK_TMP").val();
	  form1.SMRY_OPNN.value = $("#SMRY_OPNN_TMP").val();
	  form1.APP_NO.value = appno;
	  form1.RSN_CNTNT.value = rsnCntnt;
	  form1.RSK_GRD.value = form1.RSK_GRD.value;
	  form1.gylj_linegc.value = "RA5";
	  var ROLEID = '<c:out value="${ROLEID}"/>';
	  if( target == 'R' ){
		  
		  if( "4" == ROLEID ){
		    form1.SN_CCD.value = 'R'; 
		    form1.EVLTN_STATE.value = 'S1';
		    form1.FIRST_SNO.value = '3'
		  }
	    	 
	  }else{
		  
		  
		  if( "4" == ROLEID ){
	    	 if("RR" == snccd) {
	    		 form1.SN_CCD2.value = 'R';
	    		 form1.SN_CCD.value = 'SS'; 
		    	 form1.EVLTN_STATE.value = 'SS';
		    	 form1.FIRST_SNO.value = '1'
	    	 }else {
	    		 form1.SN_CCD.value = 'SS'; 
		    	 form1.EVLTN_STATE.value = 'SS';
		    	 form1.FIRST_SNO.value = '1'
	    	 }
			 
	      }
      }
	        
	  var option = {
		url : '${ctx}/prd/doPrdApprReq.do',
		dataType : 'json',				
		success : function(data){			
			
			if(data.status == 'success'){
				
				alert(data.serviceMessage);	
				doApprSucc();
				
			}else{
				
				alert(data.serviceMessage);
				doApprFail();
			}	
		}				 
	  };
	
  	  $('#form1').ajaxSubmit(option);
  	  return false;
   };
  	
   
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

<form name="fileFrm" id="fileFrm" method="POST">
<input type="hidden" name="pageID" />
<input type="hidden" name="downFileName" id="downFileName" value="" />
<input type="hidden" name="orgFileName" id="orgFileName" value="" />
<input type="hidden" name="downFilePath" id="downFilePath" value="" />
<input type="hidden" name="downType" id="downType" value="PRD" />
</form>
   
<form name="form2" method="post" >
 <input type="hidden" name="pageID" > 
 <input type="hidden" name="manualID" >
 <input type="hidden" name="classID" > 
 <input type="hidden" name="methodID" >
 <input type="hidden" name="gubun" >
 <input type="hidden" name="PRD_EVLTN_ID" >
 <input type="hidden" name="PRD_CK_ID" >
 <input type="hidden" name="dis_flag" >
</form>


<form name="form1" id="form1" method="post"> 
  <input type="hidden" name="pageID" > 
  <input type="hidden" name="manualID" > 
  <input type="hidden" name="classID" > 
  <input type="hidden" name="methodID" >
  <input type="hidden" name="PRD_EVLTN_ID" value="<c:out value="${PRD_EVLTN_ID}"/>">
  <input type="hidden" name="PRD_CK_ID" value="<c:out value="${PRD_CK_ID}"/>">
  <input type="hidden" name="EVLTN_DEPT_ID" id="EVLTN_DEPT_ID" value="<c:out value="${DEP_ID}"/>">
  <input type="hidden" name="EVLTN_USER_ID" id="EVLTN_USER_ID" value="<c:out value="${LOGIN_ID}"/>">
  <input type="hidden" name="RLS_EXPCT_DT" >
  <input type="hidden" name="EVLTN_PRF_DT" >
  <input type="hidden" name="PRD_RMRK" >
  <input type="hidden" name="SMRY_OPNN" >
  <input type="hidden" name="RSK_GRD" >
  <input type="hidden" name="CNTRL_RVW_YN" >
  <input type="hidden" name="RSNB_EDD_YN" >
  <input type="hidden" name="GRID_DATA" >
  <input type="hidden" name="APP_NO" value="<c:out value="${APP_NO}"/>">
  <input type="hidden" name="SN_CCD" value="<c:out value="${SN_CCD}"/>">
  <input type="hidden" name="FIRST_SNO" value="<c:out value="${FIRST_SNO}"/>">
  <input type="hidden" name="EVLTN_STATE" >
  <input type="hidden" name="RSN_CNTNT" >
  <input type="hidden" name="RSK_SCR" >
  <input type="hidden" name="gylj_linegc" >
  <input type="hidden" name="SN_CCD2" >

  <div style="display: flex; justify-content: space-between; align-items: center;">
    <div>
      <span style="font-size: 17px;color: #333;"> ${msgel.getMsg('AML_10_25_02_02_001', '신상품·서비스 위험평가 체크리스트')}</span>
    </div>
    <div>
      <span style="font-size: 17px;color: #333;" >${msgel.getMsg('AML_10_25_01_02_014', '체크리스트 버전 일련번호')}</span>
      <input type="text" class="input-round" id="VERSION_ID" name="VERSION_ID" size="25" maxlength="50" style="text-align: center;margin:7px 0 10px 0;" disabled />
    </div>
  </div>

  <div class="divider"></div>
 
  <div class="tab-content-bottom" style="margin-top:12px;">
   <div class="button-area"  style="display: flex; justify-content: space-between; align-items: center;" >
	 <div>
 	   <h2 class="tab-content-title" style="font-size: inherit;" >${msgel.getMsg('AML_10_25_02_02_002', '1.신상품/서비스 개요')}</h2>
	 </div>
	 <div>	
	   <button type="button" onclick="" id="preRsltList" class="btn-36" mode="U">${msgel.getMsg("AML_10_25_02_02_003","기존 평가결과 불러오기")}</button>
	   <button type="button" onclick="" id="listExcelDown" class="btn-36" mode="U">${msgel.getMsg("AML_10_25_02_02_004","엑셀 다운로드")}</button>
	</div>
   </div>
  </div>
 
  <span id="preRsltCmnt" style="font-size: small;color: grey;">${msgel.getMsg('AML_10_25_02_02_005', '※”기존 평가결과 불러오기” 버튼 클릭 시 과거 평가 시 작성한 체크리스트를 조회 및 불러올 수 있습니다.')}</span>
 
  <div class="tab-content-bottom" style="margin-top:15px;">
       
   <h3 class="tab-content-title" style="margin-left: 10px;">${msgel.getMsg('AML_10_25_02_02_006', '1-1.기본정보')}</h3> 
       
   <table class="basic-info">
	 
	 <tr>
	   <th>${msgel.getMsg('AML_10_25_02_02_007', '상품·서비스 구분')}</th>
	   <td style="width:10%" >
  	     ${condel.getSelect('{selectID:"PRD_CTGR_CD", width:"100%", sqlID:"", code:"P201", initValue:"", firstComboWord:"ALL"}')}
	   </td>
	   <th>${msgel.getMsg('AML_10_25_02_02_008', '상품유형')}</th>
	   <td style="width:10%">
	      <div class="content">
		    <select id="PRD_TP_CD" name="PRD_TP_CD" class="dropdown" >
		      <option class="dropdown-option" value="">::전체::</option>
            </select>
         </div>
	   </td>
	   <th>${msgel.getMsg('AML_10_25_02_02_009', '상품·서비스명')}</th>
	   <td>
	     <div class="content">
	        <input type="text" name="PRD_NM" id="PRD_NM" value="" size:"50" style="width:100%;" maxlength="50" >
	      </div>
	   </td>
	 </tr>
	  
	 <tr>
	   <th>${msgel.getMsg('AML_10_25_02_02_010', '상품·서비스 기획부서')}</th>
	   <td colspan="3">
	      <input type="text" id="EVLTN_DEPT_NM" value="${DEP_NM}" style="width:100%;" maxlength="50" disabled="disabled" />
	   </td>
	   <th>${msgel.getMsg('AML_10_25_02_02_011', '평가자')}</th>
	   <td>
	     <div style="display: flex;">
	      <input type="text" id="EVLTN_USER_LG_ID" value="${LOGIN_ID}" disabled="disabled" />
	      <input type="text" id="EVLTN_USER_NM"   value="${USER_NAME}" style="margin-left:3px;" disabled="disabled" />
	     </div>
	   </td>
	 </tr>
	 <tr>
	   <th>${msgel.getMsg('AML_10_25_02_02_012', '출시예정일자')}</th>
	   <td colspan="3">
	     <div class='calendar'>
		    ${condel.getInputDateDx('RLS_EXPCT_DT_TMP',edDate)}
		 </div>
       </td>
	   <th>${msgel.getMsg('AML_10_25_02_02_013', '위험평가 수행일자')}</th>
	   <td colspan="3">
	     <div class="content">
	       <div class='calendar'>
		    ${condel.getInputDateDx('EVLTN_PRF_DT_TMP',edDate)}
		   </div>
		 </div>
       </td>
	  </tr>
	  <tr>
	    <th>${msgel.getMsg('AML_10_25_02_02_014', '상품·서비스 개요')}</th>
	    <td colspan="5">
	     <textarea id="PRD_RMRK_TMP" form="form1" class="textarea-box" placeholder="${msgel.getMsg('AML_10_25_02_02_015', '상품 주요 특징, 내용 및 프로세스 등 개요 작성\\n(예. 당사 CMA 계좌 예치금을 콜, 국공채, 은행CD 등 MMF 단기금융상품에 투자하는 실적배당형 상품)')}"></textarea>
	    </td>
	  </tr>
	  
	</table>
    
    <table class="file-table">
     <thead>
      <tr>
        <th colspan="4" style="padding: 0;">
        
          <table style="border-collapse: collapse; width: 100%; border:none;" >
           <tr>
             <td style="width:85%;border: none;text-align: center;">
               <span style="font-weight: bold;">${msgel.getMsg('AML_10_25_02_02_016', '상품 관련 증빙자료 첨부')}</span>
                <br>
               <span style="font-size: 11px; color: gray;">${msgel.getMsg('AML_10_25_02_02_017', '*상품의 구조 및 내용 등 세부 내용을 확인할 수 있는 설명 자료를 첨부하세요. (예. 상품 기획 문서, 상품설명서, 홍보자료, 관련 내규/매뉴얼 등)')}</span>
             </td>
             <td style="border: none; text-align: right; padding-top: 10px;">
               <div id="file-uploader" style="margin-left: auto;"></div>
             </td>
           </tr>
          </table>
          
        </th>
      </tr>
      <tr>
        <th style="width:5%;" >${msgel.getMsg('AML_10_25_02_02_018', 'No.')}</th>
        <th class="file-name">${msgel.getMsg('AML_10_25_02_02_019', '파일명')}</th>
        <th style="width:10%;" >${msgel.getMsg('AML_10_25_02_02_020', '파일크기')}</th>
        <th style="width:10%;" >${msgel.getMsg('AML_10_25_02_02_021', 'Action')}</th>
      </tr>
     </thead>
     <tbody id="fileBox">
     
	     <c:choose>
	      <c:when test="${ fn:length( FILES ) == 0 }">
	      
	        <tr>
	         <td colspan="4" style="text-align: center;" >&nbsp;</td>
	        </tr>
	        
	      </c:when>
	      <c:otherwise>
	      
		       <c:forEach items="${FILES}" var="result" varStatus="status">
		         <c:set var="i" value="${status.index}" />
		         <tr id="file${i}" class="tx">
		           <td style="text-align: center;" >${i+1}</td>
		           <td class="file-name">
				   	 <a href="javascript:void(0);" class="link" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" ><c:out value="${result.LOSC_FILE_NM }"/></a>
				   </td>
				   <td style="text-align: center;"><c:out value="${result.FILE_SIZE}"/>&nbsp;kb</td>   	
				   <td style="text-align: center;">
		             <a onclick="prdViewDelete(this);" > 
			              <input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.FILE_SIZE }"/>"/>
					 	  <input name="origFileNms" class="origFileNms" type="hidden" value="<c:out value="${result.LOSC_FILE_NM }"/>"/>
						  <input name="storedFileNms" class="storedFileNms" type="hidden" value="<c:out value="${result.PHSC_FILE_NM }"/>"/>
						  <input name="filePaths" id="filePaths" class="filePaths" type="hidden" value="<c:out value="${result.FILE_POS }"/>"/>
						  <div class="dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon" role="button" aria-hidden="true" aria-label="close">
						    <div class="dx-button-content"><span class="delete-link">${msgel.getMsg('AML_10_25_02_02_035', '삭제')}</span></div>
						  </div>
					 </a>
		           </td>			    	
				 </tr>
			   </c:forEach>
		   
		  </c:otherwise>
		 </c:choose>
	   
     </tbody>
   </table>
   
 <div>
	  <div class="button-area" >
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_024', '1-2.절차/시스템의 변경여부')}</h2>
	    </div>
	  </div>
      <div id="GTDataGrid1_Area"></div>
 </div>
	
  <br/>
	
    <div class="tab-content-bottom">
      <h3 class="tab-content-title" style="font-size: inherit;" >${msgel.getMsg('AML_10_25_02_02_025', '2.상품 고유위험 평가 - 상품·서비스 개발부서 작성')}</h3> 
	  <div class="button-area" >
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_026', '2-1.당연고위험 상품 해당여부')}</h2>
	    </div>
	 </div>
     <div id="GTDataGrid2_Area"></div>
    </div>
    
    <br/>
    
    <div class="tab-content-bottom">
      <div class="button-area">    
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_027', '2-2.고객위험(상품을 이용할 고객에 대한 위험평가)')}</h2>
	    </div>
	  </div>
      <div id="GTDataGrid3_Area"></div>
    </div>
    
    <br/>
    
    <div class="tab-content-bottom">
	  <div class="button-area">    
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_028', '2-3.상품위험(상품 특성에 내재된 자금세탁위험에 대한 위험평가)')}</h2>
	    </div>
	 </div>
     <div id="GTDataGrid4_Area"></div>
    </div>
    
    <br/>
    
	<div class="tab-content-bottom">
	  <div class="button-area">    
	    <div style="width:70%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_029', '2-4.채널위험(채널 특성에 내재된 자금세탁위험에 대한 위험평가)')}</h2>
	    </div>
	 </div>
     <div id="GTDataGrid5_Area"></div>
    </div>
    
    <br/>
	
    <div class="tab-content-bottom">
	  <div class="button-area">    
	    <div style="width:70%;">
 	      <h3 class="tab-content-title" style="margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_030', '3.통제위험평가-자금세탁사기예방팀 작성')}</h3>
	    </div>
	 </div>
     <div id="GTDataGrid6_Area"></div>
    </div>		        		        
    
    <br/>
	
    <div class="tab-content-bottom">
 	  <h3 class="tab-content-title" style="font-size: inherit; margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_031', '4.위험평가 결과 및 종합의견')}</h3>
	  <div class="button-area">    
	    <div style="width:100%;margin-left:10px;">
	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_032', '4-1.위험평가 결과')}</h2>
	      <div style="margin-left:-10px;">
		      <table id="riskTable" class="risk-table" border="1" cellpadding="5" cellspacing="0">
				  <thead>
				    <tr>
				      <th style="width:10%">평가구분</th>
				      <th style="width:15%">평가영역</th>
				      <th style="width:10%">배점</th>
				      <th style="width:10%">위험점수</th>
				      <th style="width:15%">위험평가 결과</th>
				      <th>위험수준 평가기준</th>
				    </tr>
				  </thead>
				  <tbody>
				    <tr>
				     <td rowspan="4" style="background-color: #f5f5f5;">고유위험평가</td>
				     <td>당연고위험상품</td>
				     <td id="srcCnt01" >0</td>
				     <td id="ckCnt01" >0</td>
				     <td rowspan="5" id="ownRiskResult"></td>
				     <td rowspan="5" class="criteria-text">
				       <div style="display: flex; flex-direction: column; align-items: flex-start;">
					    <div><span class="danger-text">당연고위험</span>: 업무규정 등에서 정하는 고위험 상품</div>
					    <div><span class="danger-text">고위험</span>: 총점 대비 60% 이상</div>
					    <div><span class="warning-text">중위험</span>: 30~60% 미만</div>
					    <div><span class="low-text">저위험</span>: 30% 미만</div>
					   </div>
				     </td>
				    </tr>
				    <tr> 
				     <td>고객위험</td>
				     <td id="srcCnt02" >0</td>
				     <td id="ckCnt02" >0</td>
				    </tr>
				    <tr>
				      <td>상품위험</td>
				      <td id="srcCnt03" >0</td>
				      <td id="ckCnt03" >0</td>
				    </tr>
				    <tr>
				      <td>채널위험</td>
				      <td id="srcCnt04" >0</td>
				      <td id="ckCnt04" >0</td>
				    </tr>
				    <tr style="background-color: #f5f5f5;">
				      <td colspan="2" >합계</td>
				      <td id="ownTotalScore">0</td>
				      <td id="ownTotalRisk">0</td>
				    </tr>
				
				    <tr>
				      <td rowspan="2"  style="background-color: #f5f5f5;" >통제위험평가</td>
				      <td>업무절차</td>
				      <td id="srcCnt05" >0</td>
				      <td id="ckCnt05" >0</td>
				      <td rowspan="3" id="ctrlRiskResult"></td>
				      <td rowspan="3" class="criteria-text">
				        <div style="display: flex; flex-direction: column; align-items: flex-start;">
					      <div>1점 이상 시, 통제 보완/추가 조치 필요</div>
					    </div>
				      </td>
				      
				    </tr>
				    <tr>
				      <td>전산통제</td>
				      <td id="srcCnt06" >0</td>
				      <td id="ckCnt06" >0</td>
				     </tr>
				     <tr style="background-color: #f5f5f5;">
				       <td colspan="2"  >합계</td>
				       <td id="ctrlTotalScore" >0</td>
				       <td id="ctrlTotalRisk">0</td>
				     </tr>
				  </tbody>
				</table>
	 
	      </div>
	    </div>
	  </div>
    </div>
    
    <div class="tab-content-bottom">
	  <div class="button-area">    
	    <div style="width:100%; margin-left:10px;" >
 	      <h2 class="tab-content-title" style=" margin-top:12px;">${msgel.getMsg('AML_10_25_02_02_033', '4-2.종합의견')}</h2>
	      <div style="margin-left:-10px;">
          
             <table class="basic-info">
			  <tr>
			   <th>${msgel.getMsg('AML_10_25_02_02_034', '자금세탁사기예방팀 종합의견')}</th>
			   <td>
		  	      <textarea id="SMRY_OPNN_TMP" class="textarea-box" ></textarea>
			   </td>
			  </tr>
		     </table>
	 
	     </div>
	    </div>
	 </div>
    </div>
    
    
	 <div class="button-area" style="display:flex; justify-content: flex-end; padding-top: 8px; padding: 14px 20px 10px 0;">
		 
	   <% if( "4".equals(ROLEID) ) { // 자금세탁사기예방팀 담당자 %>
		 <button type="button" onclick="doSave()" id="btn_01" class="btn-36" mode="U">${msgel.getMsg("AML_10_20_01_01_012","저장")}</button>
		 <button type="button" onclick="doPrdAppr()" id="btn_02" class="btn-36" mode="U">${msgel.getMsg("AML_10_25_01_02_018","승인요청")}</button> 
	   <% } %>
		${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
		
	 </div>
 
</form> 

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />