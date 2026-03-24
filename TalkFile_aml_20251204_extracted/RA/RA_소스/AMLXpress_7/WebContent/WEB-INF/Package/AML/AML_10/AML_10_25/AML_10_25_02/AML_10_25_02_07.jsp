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
* Description     :  기존 평가결과 불러오기 
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
    
    String prdCkId = Util.nvl( request.getParameter("PRD_CK_ID") );
    request.setAttribute("PRD_CK_ID", prdCkId);
    
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
	  
	  if(ROLEID == "4" || ROLEID == "104") {
		  $("#depidsearch").show();
	  }else {
		  $("#depidsearch").hide();
	  }
	  
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
      
      doSearch();
   });
   
   function setupGrids(){
	   
   	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
   	elementAttr: { class: "grid-table-type" },
   	dataSource				: dataSource,
   	gridId          		: "GTDataGrid1",
   	/*onToolbarPreparing		: makeToolbarButtonGrids,*/
   	width					:"100%",
   	height					:"calc(53vh)",
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
	       	, {dataField:'PRD_NM', caption:'${msgel.getMsg("AML_10_25_02_01_004","상품/서비스명")}', alignment:'left', allowResizing:true, allowSorting:true, allowEditing:false }
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
	       	, {dataField:'EVLTN_STATE', caption:'${msgel.getMsg("AML_10_25_02_01_008","평가상태")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, "width": "15%"
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
       ]
       ,onCellPrepared : function(e){
	        var columnName = e.column.dataField;
	        var dataGrid   = e.component;
	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
	        var rskGrd    = dataGrid.cellValue(rowIndex, 'RSK_GRD');
	        var snCcd    = dataGrid.cellValue(rowIndex, 'SN_CCD');
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
	            }else{
	                if(columnName == 'RSK_GRD'){
	                	//e.cellElement[0].innerHTML = "<span class='criterion-tag veryhigh' style='width:100px;'>" + e.displayValue + "</span>"
	                }
	            }
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
   
  function setupFilter(FLAG){
   
   	 var gridArrs = new Array();
   	 var gridObj = new Object();
     gridObj.gridID = "GTDataGrid1_Area";
     gridArrs[0] = gridObj;
     setupGridFilter2(gridArrs, FLAG);
  }
  
  function doSearch(){
       
       var classID  = "AML_10_25_02_01";
       var methodID = "getSearch2";
       
       var params = new Object();
       params.pageID = "AML_10_25_02_01";
       params.ALL_APPR_DATE = ($("#ALL_EVLTN_DATE").is(":checked")==true ? "Y":"N");
       params.EVLTN_SD_DT = getDxDateVal("EVLTN_SD_DT", true);  
       params.EVLTN_ED_DT = getDxDateVal("EVLTN_ED_DT", true);  
       params.APPR_STATE = $("#wfCodeSts").val();     
       params.PRD_NM = $("#PRD_NM").val();
       
       if(ROLEID == "4" || ROLEID == "104") {
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
	  
      if (deptInfo.depcode == null || deptInfo.depcode ==""){
    	  return;
      }
      
      $("#DEP_NM").val(deptInfo.depname);
      $("#DEP_ID").val(deptInfo.depid);
  }

  // 불러오기 
  function doGetPreEvltn(){

	 var gridData = GridObj1.getSelectedRowsData();

     if( gridData.length == 0 ){
    	 showAlert( "${msgel.getMsg('AML_10_25_02_02_052', '선택된 건이 없습니다.')}", "WARN");
	    return;
     }
     
     if(gridData.length > 1) {
    	 showAlert( "${msgel.getMsg('AML_10_25_02_02_056', '1건 이상 입니다. 1건만 선택해주세요.')}", "WARN");
    	 return;
     }

	 if( '<c:out value="${PRD_CK_ID}"/>' !=  gridData[0].PRD_CK_ID ){

		showAlert( "${msgel.getMsg('AML_10_25_02_02_053', '선택한 평가건의 체크리스트 버전이 현행 체크리스트 버전과 다릅니다. 현행 체크리스트 버전으로 평가를 수행하세요.')}", "WARN");
	    return;
	 }
	     
	 parent.window.opener.focus();		
	 parent.window.opener.openerView.doSearchPreEvltn(  gridData[0].PRD_EVLTN_ID );
	 window.close();
  }

  function doClose(){
	   	
    window.close();
  }
  
</script>
    
<form name="form3"  >
    <input type="hidden" name="dis_flag"    />
    <input type="hidden" name="pageID"      />
	<input type="hidden" name="viewName" id="viewName"  />
	<input type="hidden" name="IS_MNG"   id="IS_MNG"    />
	<input type="hidden" name="FUNC_NM"  id="FUNC_NM"   />
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
			 <input type="text" name="DEP_NM" id="DEP_NM" value="${AML_BDPT_CD_NAME}"  readonly>
			 <input id="depidsearch" type="button" name="nextSelectBtn" value="${msgel.getMsg('ADMIN_modifyUserForm_042','선택')}"  onclick="changeUserDep();" class="btn-36" style="margin-left: 5px;" >
			 <input type="hidden" name="DEP_ID" id="DEP_ID" value="">
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
	<button type='button' id='btn_02' class='btn-36' onClick='doGetPreEvltn()'>${msgel.getMsg('AML_10_25_02_02_051','불러오기')}</button>
  </div>
  
  <div class="tab-content-bottom">
	<div id = "GTDataGrid1_Area" style="padding-top:8px"></div>
  </div>
  
  <div class="button-area" style="display:flex; justify-content: flex-end; padding-top: 8px; padding: 14px 20px 10px 0;">
	 ${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
  </div>
	 
</form> 

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" /> 
