<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 결재실행
* Group           : GTONE, R&D센터/개발2본부
* Project         : 결재실행
* Author          : JJH
* Since           : 2025. 06. 25.
********************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<%
	String stDate = jspeed.base.util.DateHelper.currentTime(PropertyService.getInstance().getProperty("aml.config","dateFormat"));
	request.setAttribute("stDate",stDate);

	String RA_ITEM_CD    = Util.nvl(request.getParameter("RA_ITEM_CD"));
	String RA_SEQ        = Util.nvl(request.getParameter("RA_SEQ"));
	String RA_REF_SN_CCD = Util.nvl(request.getParameter("RA_REF_SN_CCD"));
	String INTV_VAL_YN   = Util.nvl(request.getParameter("INTV_VAL_YN"));

	String APP_NO      = Util.nvl(request.getParameter("APP_NO"));
	String SN_CCD      = Util.nvl(request.getParameter("SN_CCD"));
	String PRV_APP_NO  = Util.nvl(request.getParameter("PRV_APP_NO"));

	request.setAttribute("RA_ITEM_CD"     , RA_ITEM_CD     );
	request.setAttribute("RA_SEQ"         , RA_SEQ         );
	request.setAttribute("RA_REF_SN_CCD"  , RA_REF_SN_CCD  );
	request.setAttribute("INTV_VAL_YN"    , INTV_VAL_YN  );

	request.setAttribute("APP_NO",     APP_NO     );
	request.setAttribute("SN_CCD",     SN_CCD     );
	request.setAttribute("PRV_APP_NO", PRV_APP_NO );


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

    String USERNAME   = sessionAML.getsAML_USER_NAME();
    String BDPTCDNAME = sessionAML.getsAML_BDPT_CD_NAME();
    String BDPTCD     = sessionAML.getsAML_BDPT_CD();
    String ROLEID     = sessionAML.getsAML_ROLE_ID();
    String ROLENAME   = sessionAML.getsAML_ROLE_NAME();
    String POSITION_NAME = Util.nvl(request.getParameter("POSITION_NAME"));

    request.setAttribute("USERNAME",USERNAME);
    request.setAttribute("BDPTCDNAME",BDPTCDNAME);
    request.setAttribute("BDPTCD",BDPTCD);
    request.setAttribute("ROLEID",ROLEID);
    request.setAttribute("ROLENAME",ROLENAME);
    request.setAttribute("POSITION_NAME",POSITION_NAME);


%>
<script>
	var overlay       = new Overlay();
	var pageID        = "AML_10_37_01_05";
	var classID       = "AML_10_37_01_05";
	var USERNAME      = "${USERNAME}";
    var BDPTCDNAME    = "${BDPTCDNAME}";
    var BDPTCD        = "${BDPTCD}";
    var ROLEID        = "${ROLEID}";
    var ROLENAME      = "${ROLENAME}";
    var stDate        = "${stDate}";
    var POSITION_NAME = "${POSITION_NAME}";
    var RA_ITEM_CD    = "${RA_ITEM_CD}";
    var RA_SEQ        = "${RA_SEQ}";
    var RA_REF_SN_CCD = "${RA_REF_SN_CCD}";
    var INTV_VAL_YN   = "${INTV_VAL_YN}";

	$(document).ready(function(){
	    setupGrids1();
	    form1.USERNAME.value      = USERNAME;
	    form1.BDPTCDNAME.value    = BDPTCDNAME;
	    form1.stDate.value        = stDate;
	    form1.POSITION_NAME.value = POSITION_NAME;
	    doSearch();
	});

	function doSearch() {
		var methodID = "doApprHist3";
        var params = new Object();
        params.pageID      = pageID;
        params.RA_ITEM_CD  = RA_ITEM_CD;

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}

	function doSearch_success(gridData, data){
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

    function doSearch_fail(){
        overlay.hide();
    }

	// 그리드 초기화 함수 셋업
    function setupGrids1(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(40vh - 65px)",
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
        	   ,export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
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
		   	    	visible: false
		   	    	,showNavigationButtons: true
		   	    	,showInfo: true
		   	    }
		   	   ,paging: {
		   	    	enabled : true
		   	    	,pageSize : 20
		   	    }
	     	   ,remoteOperations : {filtering: false,grouping: false,paging: false,sorting: true,summary: false}
	     	   ,rowAlternationEnabled : true
	     	   ,scrolling : {mode: "standard",preloadEnabled: false}
	     	   ,searchPanel : {visible : false,width: 250}
	     	   ,selection: {
	     	        allowSelectAll: true
	     	       ,deferred: false
	     	       ,mode: 'none'  /* none, single, multiple                       */
	     	       ,selectAllMode: 'allPages'      /* 'page' | 'allPages'                          */
	     	       ,showCheckBoxesMode: 'none'    /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
	     	    }
	     	   ,showBorders     : true
	     	   ,showColumnLines : true
	     	   ,showRowLines    : true
	     	   ,sorting         : { mode: "single"}
	     	   ,wordWrapEnabled : false
	     	   ,columns: [
	     	        {dataField: "HNDL_P_NM"		,caption: "결재자"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	        {dataField: "BRN_NM"		,caption: "소속부점"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
	      	      	{dataField: "POSITION_NAME"	,caption: "직위"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 80},
	      	    	{dataField: "HNDL_DY_TM"	,caption: "결재일시"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 150},
	      	  		{dataField: "SN_CCD_YN"		,caption: "반려여부"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, width : 80},
	      			{dataField: "RSN_CNTNT"		,caption: "결재/반려의견"	,alignment: "left"	,allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false}
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

    /* 결재요청 */
    function doSave(){

        if ($("#RSN_CNTNT").val() == "") {
            showAlert("${msgel.getMsg('AML_10_01_01_01_040','결재의견을 입력하세요.')}",'WARN');
            return;
        }

        var mesg = '${msgel.getMsg("AML_10_03_01_01_026","결제요청 하시겠습니까?")}';
        var mesg2 ='${msgel.getMsg("AML_00_00_01_01_074","결재")}';

        showConfirm(mesg,mesg2,function(){
            overlay.show(true, true);
            var classID              = "AML_10_37_01_05";
            var methodID             = "firstAppRequest";
            var params               = new Object();
            params.pageID            = pageID;
            params.GYLJ_LINE_G_C     = "RA2";
            params.SN_CCD            = "S";               // S:요청,R:거절,E:결제완료;
            
            params.SNO               = "${FIRST_SNO}";
            params.FIRST_SNO         = "${FIRST_SNO}";	

            params.APP_NO            = "${APP_NO}";
            params.RSN_CNTNT         = $("#RSN_CNTNT").val();

            params.RA_ITEM_CD        = RA_ITEM_CD;
            params.RA_SEQ            = RA_SEQ;
            params.RA_REF_SN_CCD     = RA_REF_SN_CCD;

            sendService(classID, methodID, params, doSave_end, doSave_end);
        });
    }

    /* 결재완료 */
    function doSave2() {

    	if ($("#RSN_CNTNT").val() == "") {
            showAlert("${msgel.getMsg('AML_10_01_01_01_040','결재의견을 입력하세요.')}",'WARN');
            return;
        }

    	var mesg = '${msgel.getMsg("AML_10_17_01_01_015","결재하시겠습니까?")}';
        var mesg2 ='${msgel.getMsg("AML_10_17_01_01_017","결재")}';

        showConfirm(mesg,mesg2,function(){
            overlay.show(true, true);
            var classID              = "AML_10_37_01_05";
            var methodID             = "doAppr";
            var params               = new Object();
            params.pageID            = pageID;
            params.GYLJ_LINE_G_C     = "RA2";
            params.SN_CCD            = "E";               // S:요청,R:거절,E:결제완료;
            params.SNO               = "${FIRST_SNO}";
            params.APP_NO            = "${APP_NO}";
            params.PRV_APP_NO        = "${PRV_APP_NO}";
            params.RSN_CNTNT         = $("#RSN_CNTNT").val();

            params.RA_ITEM_CD        = RA_ITEM_CD;
            params.RA_SEQ            = RA_SEQ;

            sendService(classID, methodID, params, doSave_end, doSave_end);
        });
    }

    function doSave_end()
    {
    	overlay.hide();
    	$("#sbtn_01").hide();
    	doSearch();

    	if(RA_ITEM_CD == "I001"){
    		opener.doSearch2();
    	}else if(RA_ITEM_CD == "I002") {
    		opener.doSearch3();
    	}else if(RA_ITEM_CD == "I003") {
    		opener.doSearch4();
    	}else if(INTV_VAL_YN == "Y" && RA_ITEM_CD !="I001"&& RA_ITEM_CD !="I002"&& RA_ITEM_CD !="I003") {
    		opener.doSearch5();
    	}else {
    		opener.doSearch6();
    	}
    }
</script>

<form name=form1 method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
    <input type="hidden" name="APP_NO" value="${APP_NO}">
    <input type="hidden" name="NOW_SN_CCD" value="${SN_CCD}">

<div class="tab-content">
	<div class="row" style="padding-top: 8px">
		<h4 class="tab-content-title">결재 이력</h4>
	</div>
	<div class="panel-footer" >
        <div id = "GTDataGrid1_Area"></div>
    </div>

	<div class="row" style="padding-top: 8px">
		<h4 class="tab-content-title">결재 실행</h4>
	</div>

    	<table class="basic-table">
        	<tr>
            	<th class="title" style="text-align: center">결재자</th>
            	<td> <input type=text  name="USERNAME" id="USERNAME" style="text-align: center" readonly></td>
            	<th class="title" style="text-align: center">소속부점</th>
            	<td> <input type=text  name="BDPTCDNAME" id="BDPTCDNAME" style="text-align: center" readonly></td>
        	</tr>
        	<tr>
        		<th class="title" style="text-align: center">직위</th>
            	<td> <input type=text  name="POSITION_NAME" id="POSITION_NAME" style="text-align: center" readonly></td>
            	<th class="title" style="text-align: center">결재일자</th>
            	<td> <input type=text  name="stDate" id="stDate" style="text-align: center" readonly></td>
        	</tr>
        	<tr>
        		<th class="title" style="text-align: center">결재의견</th>
            	<td colspan="3"><textarea class="textarea-box" name="RSN_CNTNT" id="RSN_CNTNT" style="width:100%;height:150px"></textarea></td>
        	</tr>
    	</table>
</div>
<br>
<div class="button-area" style="float:right">
	<% if ( "4".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
    ${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"approvalBtn", defaultValue:"결재", mode:"C", function:"doSave", cssClass:"btn-36"}')}
    <% } %>
    <% if ( "104".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
    ${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"approvalBtn", defaultValue:"결재", mode:"C", function:"doSave2", cssClass:"btn-36"}')}
    <% } %>
    ${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />