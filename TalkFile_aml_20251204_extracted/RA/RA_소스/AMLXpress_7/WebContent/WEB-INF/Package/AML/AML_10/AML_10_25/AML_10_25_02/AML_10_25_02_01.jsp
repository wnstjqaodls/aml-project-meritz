<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
- File Name  : AML_10_25_02_01.jsp
- Author     : 
- Comment    : 신상품·서비스 위험평가
- Version    : 1.0
- history    : 1.0 2025-06
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 신상품·서비스 위험평가
* Comment         : AML7.4 conversion
* Group           : GTONE, AML서비스팀
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 
* Since           : 2025. 06.
********************************************************************************************************************************************
--%>
<%@page import="com.gtone.webadmin.util.JSONUtil,com.gtone.webadmin.util.CodeUtil"%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%
    String sDate = DateUtil.addDays(DateUtil.getDateString(), -90, "yyyy-MM-dd");
    String eDate =DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
    request.setAttribute("stDate",sDate);
    request.setAttribute("edDate",eDate);
    
    //세션 결재자 정보
  	String ROLEID = sessionAML.getsAML_ROLE_ID();
  	request.setAttribute("ROLEID", ROLEID);
  	String AML_BDPT_CD_NAME = sessionAML.getsAML_BDPT_CD_NAME();
  	request.setAttribute("AML_BDPT_CD_NAME", AML_BDPT_CD_NAME);
  	String AML_BDPT_CD     = sessionAML.getsAML_BDPT_CD();
  	request.setAttribute("AML_BDPT_CD", AML_BDPT_CD);
  	
  	DataObj inputApr = new DataObj();
  	inputApr.put("DEP_DESC",AML_BDPT_CD);
    com.gtone.aml.basic.common.data.DataObj obj = null;

    try{
         obj = com.gtone.aml.dao.common.MDaoUtilSingle.getData("AML_DEP_ID_SEARCH",inputApr);
    }catch(AMLException e){
        Log.logAML(Log.ERROR, e);
    }
  	
  	String depid = obj.getText("DEP_ID");
  	request.setAttribute("depid",depid);
    
%>

<script language="JavaScript"> 

   var overlay = new Overlay();
   var GridObj1 = null;
   var dataSource = [];
   var ROLEID   = "${ROLEID}";
   var AML_BDPT_CD_NAME = "${AML_BDPT_CD_NAME}";
   var AML_BDPT_CD = "${AML_BDPT_CD}";
   var depid = "${depid}";
   

   
   // [ Initialize ]
   $(document).ready(function(){
   	
	  setupGrids();
	  setupFilter("init");
	      
	  
	  if(ROLEID == "4" || ROLEID == "104" || ROLEID == "7") {
		  $("#depidsearch").show();
	  }else {
		  $("#depidsearch").hide();
	  }
	  
	  
	  $("#PRD_CTGR_CD").on("change", function(){
		  
		  $("#PRD_TP_CD option:not(:eq(0))").remove();
		  
		  var params = new Object();
		  if( $(this).val() == 'PRDT' ){
			  if(ROLEID == "4") {
				  params.CD = "P202";
			  }else {
				  params.CD = "P202";
				  params.searchgubun = "Y";
			  }
			  
		  }else if( $(this).val() == 'SVC' ){
			  params.CD = "P203";
		  }
	       
	      sendService("AML_10_25_02_01", "getCodeSearch", params, doCdSearch_End, doCdSearch_End); 
	  });
      
      doSearch();
   });
   
   function setupGrids(){
	   
   	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
   	elementAttr: { class: "grid-table-type" },
   	dataSource				: dataSource,
   	gridId          		: "GTDataGrid1",
   	/*onToolbarPreparing		: makeToolbarButtonGrids,*/
   	width					:"100%",
   	height					:"calc(-150px + 85vh)",
       hoverStateEnabled 		: true,
       wordWrapEnabled 		: false,
       allowColumnResizing 	: true,
       columnAutoWidth 		: true,
       allowColumnReordering 	: true,
       columnResizingMode 		: 'widget',
       cacheEnabled 			: false,
       cellHintEnabled 		: true,
       showBorders 			: true,
       showColumnLines 		: true,
       showRowLines 			: true,
       sorting					: { mode: "multiple"},
       loadPanel 				: { enabled: false },
       remoteOperations 		: {filtering:false, grouping:false, paging:false, sorting:false, summary:false},
       editing					: { mode: 'cell', allowUpdating: false, allowAdding : false},
       filterRow				: { visible: false },
       rowAlternationEnabled 	: true,
       columnFixing			: {	enabled: true},
       pager: {
  	    	visible: true
  	    	,showNavigationButtons: true
  	    	,showInfo: true
  	    },
  	    paging: {
  	    	enabled : true
  	    	,pageSize : 20
  	    },
   	    scrolling : {
          mode            : "standard"
         ,preloadEnabled  : false
       },
       searchPanel				: {visible: false, width: 250},
       noDataText				: '${msgel.getMsg("AML_20_01_10_01_103","조회된 데이터가 없습니다.")}',
       /*
       export 					: {allowExportSelectedData : true ,enabled : false ,excelFilterEnabled : true},
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
       */
       selection : {
       	 allowSelectAll : false
          , deferred : false
          , mode : 'multiple'  /*none, single, multiple*/
          , selectAllMode : 'allPages' /*: 'page' | 'allPages'*/
          , showCheckBoxesMode : 'always' /*'onClick' | 'onLongTap' | 'always' | 'none'*/
       }
       , columns: [
             {dataField:'PRD_CTGR_CD', caption:'${msgel.getMsg("AML_10_25_02_01_001","구분")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, "width": "10%"
	       		 , "lookup" : {
	                dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P201"))%>
	               ,displayExpr : "VALUE"
	               ,valueExpr   : "KEY"
	             }
       	      }
	       	, {dataField:'PRD_TP_CD_NM', caption:'${msgel.getMsg("AML_10_25_02_01_002","상품유형")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, "width": "10%"}
	       	, {dataField:'PRD_EVLTN_ID', caption:'${msgel.getMsg("AML_10_25_02_01_003","평가일련번호")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, "width": "10%"}
	       	, {dataField:'PRD_NM', caption:'${msgel.getMsg("AML_10_25_02_01_004","상품/서비스명")}', alignment:'left', allowResizing:true, allowSorting:true, allowEditing:false, cssClass:'link' }
	       	, {dataField:'RSK_GRD', caption:'${msgel.getMsg("AML_10_25_02_01_005","위험등급")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, "width": "10%"
	       		, "lookup" : {
	                dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P301"))%>
	               ,displayExpr : "VALUE"
	               ,valueExpr   : "KEY"
	             }
		      }
	       	, {dataField:'EVLTN_DEPT_NM', caption:'${msgel.getMsg("AML_10_25_02_01_006","평가부서")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, "width": "10%"}
	       	, {dataField:'EVLTN_PRF_DT', caption:'${msgel.getMsg("AML_10_25_02_01_007","평가일자")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, "width": "10%"
	       		, "cellTemplate": function(cellElement,cellInfo){ 
	             	   cellElement.text(displayGTDataGridDate(cellInfo.text)); 
	                } 
	       	  }
	       	, {dataField:'EVLTN_STATE', caption:'${msgel.getMsg("AML_10_25_02_01_008","평가상태")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, cssClass:'link', "width": "15%"
	       		, "lookup" : {
	                dataSource  : <%=JSONUtil.listToJson(CodeUtil.getCodes("AML_00_00_00_00_common_getComboData", "P002"))%>
	               ,displayExpr : "VALUE"
	               ,valueExpr   : "KEY"
	             }
		      }
	       	, {dataField:'EVLTN_DEPT_ID', visible:false, allowSearch:false}
	       	, {dataField:'PRD_CK_ID', visible:false, allowSearch:false}
	       	, {dataField:'PRD_CD', visible:false, allowSearch:false}
	       	, {dataField:'PRD_TP_CD', visible:false, allowSearch:false}
	       	, {dataField:'APP_NO', visible:false, allowSearch:false}
            , {dataField:'SN_CCD', visible:false, allowSearch:false}
            , {dataField:'REG_DT', visible:false, allowSearch:false}
            , {dataField:'REG_NM', visible:false, allowSearch:false}
            , {dataField:'UPD_NM', visible:false, allowSearch:false}
            , {dataField:'RSNB_EDD_YN', visible:false, allowSearch:false}
       ]
       ,onCellPrepared : function(e){
	        var columnName = e.column.dataField;
	        var dataGrid   = e.component;
	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
	        var rskGrd    = dataGrid.cellValue(rowIndex, 'RSK_GRD');
	        var snCcd    = dataGrid.cellValue(rowIndex, 'SN_CCD');
	        var rsnbeddyn = dataGrid.cellValue(rowIndex, 'RSNB_EDD_YN');
	        
	        if(rowIndex != -1){
	        	
	            if(rskGrd == "30101"){
	                if(columnName == 'RSK_GRD'){
	                	e.cellElement[0].innerHTML = "<span class='criterion-tag low' style='width:100px;'>" + e.displayValue + "</span>"
	                }
	            }else if(rskGrd == "30102"){
	                if(columnName == 'RSK_GRD'){
	                	e.cellElement[0].innerHTML = "<span class='criterion-tag medium' style='width:100px;'>" + e.displayValue + "</span>"
	                }
	            }else if(rskGrd == "30103"){
	                if(columnName == 'RSK_GRD'){
	                	e.cellElement[0].innerHTML = "<span class='criterion-tag high' style='width:100px;'>" + e.displayValue + "</span>"
	                }
	            }else if(rskGrd == "30104"){ 
	                if(columnName == 'RSK_GRD'){
	                	e.cellElement[0].innerHTML = "<span class='criterion-tag veryhigh' style='width:100px;'>" + e.displayValue + "</span>"
	                }
	            }else {
	            	if(columnName == 'RSK_GRD'){
	                	//e.cellElement[0].innerHTML = "<span class='criterion-tag veryhigh' style='width:100px;'>" + e.displayValue + "</span>"
	                }
	            }
	            
	            if( snCcd == "N" ) {
	            	e.cellElement.removeClass("link");
	            }
	        }
	    }
       , onCellClick: function(e){
       	
           if(e.data ){
           	clickCellGrid('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
           }
       }
       , onInitialized : function(e) {
 	      //doSearch();
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
   
  function setupFilter(FLAG){
   
   	 var gridArrs = new Array();
   	 var gridObj = new Object();
     gridObj.gridID = "GTDataGrid1_Area";
     gridArrs[0] = gridObj;
     setupGridFilter2(gridArrs, FLAG);
  }
  
  function doSearch(){
       
       var classID  = "AML_10_25_02_01";
       var methodID = "getSearch";
       
       var params = new Object();
       params.pageID = "AML_10_25_02_01";
       params.ALL_APPR_DATE = ($("#ALL_EVLTN_DATE").is(":checked")==true ? "Y":"N");
       params.EVLTN_SD_DT = getDxDateVal("EVLTN_SD_DT", true);  
       params.EVLTN_ED_DT = getDxDateVal("EVLTN_ED_DT", true);  
       params.APPR_STATE = $("#wfCodeSts").val();     
       params.PRD_NM = $("#PRD_NM").val();
       
       if(ROLEID == "4" || ROLEID == "104" || ROLEID == "7") {
    	   params.DEP_ID = $("#DEP_ID").val();
       }else {
    	   params.DEP_ID = depid;
       }
       
       
       params.PRD_CTGR_CD = $("#PRD_CTGR_CD").val();   
       params.PRD_TP_CD = $("#PRD_TP_CD").val();
       params.RSK_GRD = $("#rskGrdCd").val();  
       
       overlay.show(true, true);      
       
       sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
  }
   
  function doSearch_success(gridData, data){
     overlay.hide();
     GridObj1.option("dataSource", gridData);
     GridObj1.refresh();
  }
   
  function doSearch_fail(){        
     overlay.hide();
  }	
  
  function doCdSearch_End(gridData, data){
	   
	   $.each(gridData, function(idx, val) {
		  $("#PRD_TP_CD").append('<option class="dropdown-option" value="'+ val.CD +'">'+ val.CD_NM +'</option>');
	   });
  }
  
  function clickCellGrid(id, obj, selectData, rowIdx, colIdx, columnId, colId){

	 var ROLEID = '<c:out value="${ROLEID}"/>';
	 
   	 if( obj && "PRD_NM" == columnId ){
   		
  		form2.PRD_EVLTN_ID.value = obj.PRD_EVLTN_ID;
	    form2.PRD_CK_ID.value = obj.PRD_CK_ID;
	    form2.APP_STATE.value = obj.SN_CCD_NM;
	    form2.APP_NO.value = obj.APP_NO;
	    form2.SN_CCD.value = obj.SN_CCD;
	    form2.EVLTN_STATE.value = obj.EVLTN_STATE;
	    
	    form2.pageID.value = "AML_10_25_02_02";
		form2.target = 'AML_10_25_02_02';
		if("SN" == obj.EVLTN_STATE && "4" == ROLEID) {
			form2.pageID.value = "AML_10_25_02_08";
			form2.target = 'AML_10_25_02_08';
		}
			
	    if(("S1" == obj.EVLTN_STATE && "108" == ROLEID ) || ("S3" == obj.EVLTN_STATE && "104" == ROLEID ) || ("SS" == obj.EVLTN_STATE && "104" == ROLEID ) ){
	    	
		   	form2.pageID.value = "AML_10_25_02_03";
		    form2.target = 'AML_10_25_02_03';
	    }
	    
	    form2.action = '${path}/0001.do';
	    window_popup_open( form2.pageID.value, 1200, 800, '','');
	    form2.submit();
   		    
   	 }else if( (obj && "EVLTN_STATE" == columnId && obj.EVLTN_STATE != 'N') && (obj && "EVLTN_STATE" == columnId && obj.EVLTN_STATE != 'SN')){
   		
   		form2.gyljlinegc.value =  obj.GYLJ_LINE_G_C;
	    form2.APP_NO.value = obj.APP_NO;
	    form2.pageID.value = "AML_10_25_02_06";
		form2.target = 'AML_10_25_02_06';
	    form2.action = '${path}/0001.do';
	    window_popup_open( form2.pageID.value, 900, 400, '','');
 	    form2.submit();
   	 }
  }        
   
  function doRegPopup(){
   
     try {

       if( "107" != ROLEID && "4" != ROLEID){ 
    	   showAlert( "${msgel.getMsg('AML_10_25_02_02_057', '상품·서비스 개발 담당자, 자금세탁사기예방팀 담당자만 신규등록 가능합니다.')}", "WARN");
    	   return;
       }    
       
	   form3.dis_flag.value = "P";
	   
	   if("4" == ROLEID) {
		   form3.pageID.value = 'AML_10_25_02_08';
		   form3.target = 'AML_10_25_02_08';
	   }else {
		   form3.pageID.value = 'AML_10_25_02_02';
		   form3.target = 'AML_10_25_02_02';
	   }
	   
	   form3.action = '${path}/0001.do';
	   form3.method = "post";
	   window_popup_open(form3.pageID.value, 1300, 1000, '','yes');
	   form3.submit();
	   form3.target = '';
          return;
          
    } catch (e) {
        showAlert(e, "ERR");
    } finally {
        overlay.hide(); 
    }
  }

  function doPrdAppr(){
	  
	  showConfirm('${msgel.getMsg("AML_10_25_02_01_011","삭제하시겠습니까?")}','삭제', function(){
		  
		  var rowsData = GridObj1.getSelectedRowsData();
		  
		  for (var i = 0; i < rowsData.length; i++){
			var deappno = rowsData[i].APP_NO;
			var deevltnstate = rowsData[i].EVLTN_STATE;
			var prdevltnid = rowsData[i].PRD_EVLTN_ID;
		  }
		  
		  form4.dis_flag.value = "DS";
		  form4.EVLTN_STATE.value = deevltnstate; 
		  form4.APP_NO.value = deappno;  
		  form4.PRD_EVLTN_ID.value = prdevltnid;
  		  form4.pageID.value = "AML_10_25_02_04";
  		  form4.target = "AML_10_25_02_04";
  		  form4.action = '${path}/0001.do';
  		  form4.method = "post";
          window_popup_open(form4.pageID.value, 600, 300, '','yes');
     	  form4.submit();
     	  form4.target = '';
	  });
  }
  
  function doAppr( rsnCntnt, target, evl, apn, peid){
	  overlay.show(true, true);
	  var classID  = "AML_10_25_02_02";
   	  var methodID = "AppRequest"
   	  var params   = new Object();
   	  
   	  params.RSN_CNTNT = rsnCntnt;
   	  params.SN_CCD    = target;
   	  params.EVLTN_STATE = target;
   	  params.APP_NO = apn;
   	  params.PRD_EVLTN_ID = peid;
   	  
   	  if("DD" == target) {
   		params.FIRST_SNO = "2";
   	  }else {
   		params.FIRST_SNO = "1";
   	  }
   	  params.GYLJ_LINE_G_C = "RA5";
   	  
   	  sendService(classID, methodID, params, doAppr_end, doAppr_end);
  }
  
  function doAppr_end() { overlay.hide(); doSearch();}
  
  function doPrdAppr2(){
	  
	  showConfirm('${msgel.getMsg("AML_10_25_02_01_017","결재(삭제)하시겠습니까?")}','결재', function(){
		  
		  var rowsData = GridObj1.getSelectedRowsData();
		  
		  for (var i = 0; i < rowsData.length; i++){
			var deappno = rowsData[i].APP_NO;
			var deevltnstate = rowsData[i].EVLTN_STATE;
			var prdevltnid = rowsData[i].PRD_EVLTN_ID;
		  }
		  
		  form4.dis_flag.value = "DD";
		  form4.EVLTN_STATE.value = deevltnstate; 
		  form4.APP_NO.value = deappno;  
		  form4.PRD_EVLTN_ID.value = prdevltnid;
  		  form4.pageID.value = "AML_10_25_02_04";
  		  form4.target = "AML_10_25_02_04";
  		  form4.action = '${path}/0001.do';
  		  form4.method = "post";
          window_popup_open(form4.pageID.value, 600, 300, '','yes');
     	  form4.submit();
     	  form4.target = '';
	  });
  }
  
  function doDeletePre() {
	  var gridData = GridObj1.getSelectedRowsData();
	  
	  if( gridData.length == 0 ){

		  showAlert( "${msgel.getMsg('AML_10_25_02_02_052', '선택된 건이 없습니다.')}", "WARN");
		  return;
      }
	  
	  for( var i =0 ; i < gridData.length ; i++ ){
		  if("4" == ROLEID && gridData[i].EVLTN_STATE != 'N' && gridData[i].EVLTN_STATE != 'SN') {
			  if("E" == gridData[i].EVLTN_STATE) {
				  doPrdAppr();
			  }else { doDelete2(); }
		  }else {
			  if("4" == ROLEID && gridData[i].EVLTN_STATE == 'SN') { doDelete2(); }
			  else { doDelete(); } 
		  }
	  }
  }
  
  function doDelete2(){
	  var gridData = GridObj1.getSelectedRowsData();
	  
	  showConfirm('${msgel.getMsg("AML_10_25_02_01_011","삭제하시겠습니까?")}','삭제', function(){
		sendService("AML_10_25_02_01", "doDelete", { "GRID_DATA" : gridData }, doDelete_success, doDelete_fail); 
	  });
  }
  
  function doDelete(){
	  var gridData = GridObj1.getSelectedRowsData();
	  var ck = false;
	  for( var i =0 ; i < gridData.length ; i++ ){
		  if( gridData[i].EVLTN_STATE != 'N'){ 
			  ck = true;
	          break;
		  }
	  }
	  
	  if( ck ){
		  showAlert( "${msgel.getMsg('AML_10_25_02_01_010', '평가상태가 \'임시저장\'인 건만 삭제 가능합니다.')}", "WARN");
		  return;
	  }

	  showConfirm('${msgel.getMsg("AML_10_25_02_01_011","삭제하시겠습니까?")}','삭제', function(){

      	sendService("AML_10_25_02_01", "doDelete", { "GRID_DATA" : gridData }, doDelete_success, doDelete_fail);
      
	  });	  

  }
  
  function doDelete_success(gridData, data){ doSearch(); }
	  
  function doDelete_fail(){ overlay.hide(); }	

  function doDownload() {

	  var workbook = new ExcelJS.Workbook();
      var worksheet = workbook.addWorksheet('Main sheet');

      DevExpress.excelExporter.exportDataGrid({
          component: GridObj1,
          worksheet: worksheet,
          autoFilterEnabled: true
      }).then(function () {
          return workbook.xlsx.writeBuffer();
      }).then(function (buffer) {
      	saveAs(new Blob([buffer], { type: 'application/octet-stream' }), '${pageTitle}.xlsx');
      }).catch(function (error) {
          console.error("엑셀 내보내기 오류:", error);
      });
  }	    

  var search_window = null;
  var zip_window = null;
  function changeUserDep(){
	  
      zip_window = null;
      if (search_window != null){
    	  search_window.close();
      }
      
      search_window          =  window_popup_open(form3, 580, 580, '');
      form3.pageID.value   = 'system_popup_dept_page';
      form3.viewName.value = 'system_popup_dept_page';
      form3.IS_MNG.value   = 'N';
      form3.FUNC_NM.value  = "changeDept"
      form3.target         = 'system_popup_dept_page';
      form3.action         = "<c:url value='/'/>0001.do";
      form3.submit();
      form3.target = '';
  }

  function changeDept(deptInfo){

	  $("#DEP_NM").val(deptInfo.depname);
	  $("#DEP_ID").val(deptInfo.depid);
	  
	  if (deptInfo.depid == -1 ){

		  $("#DEP_ID").val('');  
      }
  }

  
  
</script>

<form name="form4">
	<input type="hidden" name="dis_flag"    />
	<input type="hidden" name="pageID"      />
	<input type="hidden" name="classID"     /> 
	<input type="hidden" name="methodID"    />
	<input type="hidden" name="APP_NO"      />
	<input type="hidden" name="EVLTN_STATE" />
	<input type="hidden" name="PRD_EVLTN_ID" />
</form>
    
<form name="form3"  >
    <input type="hidden" name="dis_flag"    />
    <input type="hidden" name="dis_flag2"    />
    <input type="hidden" name="pageID"      />
	<input type="hidden" name="viewName" id="viewName"  />
	<input type="hidden" name="IS_MNG"   id="IS_MNG"    />
	<input type="hidden" name="FUNC_NM"  id="FUNC_NM"   />
</form>

<form name="form2" method="post" >
<input type="hidden" name="pageID" > 
<input type="hidden" name="classID" > 
<input type="hidden" name="methodID" >
<input type="hidden" name="dis_flag" >
<input type="hidden" name="APP_NO" >
<input type="hidden" name="PRD_EVLTN_ID" >
<input type="hidden" name="PRD_CK_ID" >
<input type="hidden" name="APP_STATE" >
<input type="hidden" name="SN_CCD" >
<input type="hidden" name="EVLTN_STATE" >
<input type="hidden" name="gyljlinegc" >
</form>

<form name="form1"  method="post" okeydown="doEnterEvent('doSedarch');" >
<input type="hidden" name="pageID" > 
<input type="hidden" name="manualID" > 
<input type="hidden" name="classID" > 
<input type="hidden" name="methodID" > 

 <div class="inquiry-table type1">
 
    <div class="table-row" >
        <div class="table-cell">
		    ${condel.getSelect('{msgID:"AML_10_25_02_01_009", defaultValue:"상품/서비스 구분", selectID:"PRD_CTGR_CD", code:"P201", firstComboWord:"ALL"}')}
	    </div>
		<div class="table-cell">
	       ${condel.getLabel("AML_10_25_02_01_006","평가부서","style='width:128px;'")}
	       <div class="content">
			 <input type="text" name="DEP_NM" id="DEP_NM" value='${AML_BDPT_CD_NAME}'  readonly>
			 <input id="depidsearch" type="button" name="nextSelectBtn" value="${msgel.getMsg('ADMIN_modifyUserForm_042','선택')}"  onclick="changeUserDep();" class="btn-36" style="margin-left: 5px;" >
			 <input type="hidden" name="DEP_ID" id="DEP_ID" value=''>
		   </div>
		</div>		      
	    <div class="table-cell">
	       ${condel.getLabel("AML_10_25_02_01_004","상품/서비스명","style='width:128px;'")}
	       <div class="content">
	        <input type="text" name="PRD_NM" id="PRD_NM" value="" size:"50" style="width:220px;" maxlength="50" >
	       </div>
	    </div>
	    
   </div>
   
	<div class="table-row" >
	   <div class="table-cell">
		  <div class="title">
		     <span class="txt">${msgel.getMsg('AML_10_25_02_01_002','상품유형')}</span>
		  </div>
		  <div class="content">
		    <select id="PRD_TP_CD" name="PRD_TP_CD" class="dropdown" >
		      <option class="dropdown-option" value="">::전체::</option>
            </select>
         </div>
	   </div>
	   <div class="table-cell">
		    ${condel.getLabel("AML_10_25_02_01_007","평가일자")}
			<div class="content">
				<div class='calendar'>
					${condel.getInputDateDx('EVLTN_SD_DT',stDate)} ~ ${condel.getInputDateDx('EVLTN_ED_DT',edDate)}
				</div>
				<div class="all">
					<input type="checkbox" id="ALL_EVLTN_DATE" name="ALL_EVLTN_DATE" value="Y" checked>
					<label for="ALL_EVLTN_DATE">${msgel.getMsg('AML_10_25_01_01_021','전체')}</label>
				</div>
	        </div>
	    </div>
	   <div class="table-cell">
	   </div>
   </div>
   
   <div class="table-row"  >
     <div class="table-cell">
	   ${condel.getSelect('{msgID:"AML_10_25_02_01_005", defaultValue:"위험등급", selectID:"rskGrdCd", code:"P301", firstComboWord:"ALL"}')}
	 </div>
	  <div class="table-cell">
	   ${condel.getSelect('{msgID:"AML_10_25_02_01_008", defaultValue:"평가상태", selectID:"wfCodeSts", code:"P002", firstComboWord:"ALL"}')}
	 </div>
     <div class="table-cell">
     </div>
   </div>
   
 </div>   
 
  <div class="button-area">
	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
	
	<button type='button' id='btn_02' class='btn-36' onClick='doRegPopup()'>${msgel.getMsg('AML_10_25_01_01_008','신규등록')}</button>
	
	<% if( "4".equals(ROLEID) || "107".equals(ROLEID) || "108".equals(ROLEID)) {  // (4)자금세탁사기예방팀 담당자, (107)신상품 담당자 %>
	<button type='button' id='btn_03' class='btn-36' onClick='doDeletePre()'>${msgel.getMsg('AML_10_25_01_01_016','삭제')}</button>
	<% } %>
	<% if( "104".equals(ROLEID)) {  // (104) 보고책임자%>
	<button type='button' id='btn_03' class='btn-36' onClick='doPrdAppr2()'>결재(삭제)</button>
	<% } %>
	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"RBA010", defaultValue:"엑셀 다운로드", mode:"C", function:"doDownload", cssClass:"btn-36"}')}
  </div>
  
  <div class="tab-content-bottom">
	<div id = "GTDataGrid1_Area" style="padding-top:8px"></div>
  </div>
  
</form> 

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" /> 
