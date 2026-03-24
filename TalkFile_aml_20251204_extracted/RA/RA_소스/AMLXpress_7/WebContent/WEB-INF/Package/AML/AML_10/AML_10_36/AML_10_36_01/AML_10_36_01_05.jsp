<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 변경이력
* Group           : GTONE, R&D센터/개발2본부
* Project         : 변경이력
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

	String RISK_ELMT_C   = Util.nvl(request.getParameter("RISK_ELMT_C"));
	request.setAttribute("RISK_ELMT_C",   RISK_ELMT_C  );

%>
<script>
	var overlay    = new Overlay();
	var pageID     = "AML_10_36_01_04";
	var classID    = "AML_10_36_01_02";
    var RISK_ELMT_C = "${RISK_ELMT_C}";

	$(document).ready(function(){
	    setupGrids1();
	    doSearch();
	    
	    
	});

	function doSearch() {
		var methodID = "doApprHist";
        var params = new Object();
        params.pageID      = pageID;
        params.RISK_ELMT_C = RISK_ELMT_C;

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}

	function doSearch_success(gridData, data){
		if(gridData.length>0){
	        var obj = gridData[0];
	        form1.FACT_SEQ.value    = obj.SEQ;
    	}
		try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	        doSearch2();
   	    }
    }

    function doSearch_fail(){
        overlay.hide();
    }

    function doSearch2(obj) {
		var methodID  = "doApprHist2";
		var FACT_SEQ  = form1.FACT_SEQ.value;
        var params    = new Object();
        params.pageID = pageID;
		params.FACT_SEQ = FACT_SEQ;

        sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
	}

    function doSearch3() {
		var methodID  = "doApprHist2";
        var params    = new Object();
        var NUM_SQ    = form1.NUM_SQ.value;
        params.pageID = pageID;
		params.NUM_SQ = NUM_SQ;

        sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
	}

    function doSearch2_success(gridData, data){
    	if(gridData.length>0){
    		 var obj = gridData[0];

             $("#RISK_CATG1_C_NM"   ).val(obj.RISK_CATG1_C_NM   ); 
             $("#RISK_VAL_ITEM_NM"  ).val(obj.RISK_VAL_ITEM_NM  );
             $("#RISK_ELMT_NM"      ).val(obj.RISK_ELMT_NM      );
             $("#RISK_SCR"          ).val(obj.RISK_SCR          );
             $("#RA_SN_CCD_NM"      ).val(obj.RA_SN_CCD_NM      );
             $("#RISK_RSN_DESC"     ).val(obj.RISK_RSN_DESC     );
             $("#RISK_RMRK"         ).val(obj.RISK_RMRK         );
            
             form1.RISK_HRSK_YN.value = obj.RISK_HRSK_YN;
            
             $("#RISK_INDI"         ).prop("checked", obj.RISK_CORP == "Y"         );
             $("#RISK_CORP"         ).prop("checked", obj.RISK_CORP == "Y"         );
             $("#RISK_APPL_MODEL_I" ).prop("checked", obj.RISK_APPL_MODEL_I == "Y" );
             $("#RISK_APPL_MODEL_B" ).prop("checked", obj.RISK_APPL_MODEL_B == "Y" );
    	}
    }
    
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){
    	clickedRowIndex = rowIdx;
    	if(obj && obj.SEQ){
			form1.FACT_SEQ.value = obj.SEQ;
			doSearch2();
       }
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
	     		    {dataField: "SEQ"		    ,caption: "변경시퀀스"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "HNDL_REG_ID"	,caption: "변경자(최초결재자)"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	      	{dataField: "HNDL_P_NM"		,caption: "변경자(최초결재자)"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true },
	      	    	{dataField: "HNDL_DY_TM"	,caption: "변경일시(결재완료일시)"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true },
	      	    	{dataField: "RSN_CNTNT"		,caption: "변경 사유(최초 결재 의견)"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true },
	      	    	{dataField: "SN_CCD"		,caption: "결재상태코드"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	    	{dataField: "SN_CCD_NM"		,caption: "결재상태"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:true }
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

    

</script>

<style>
	.basic-table .title {
		/* min-width: 130px; */
		text-align: center;
	}

}
</style>

<form name=form1 method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	<input type="hidden" name="FACT_SEQ" >

<div class="tab-content">
	<div class="row" style="padding-top: 8px">
		<h4 class="tab-content-title">변경 이력</h4>
	</div>
	<div class="panel-footer" >
        <div id = "GTDataGrid1_Area"></div>
    </div>

	<div class="row" style="padding-top: 8px">
		<h4 class="tab-content-title">변경 사항 명세</h4>
	</div>

	<table class="basic-table" style="table-layout:fixed;">
		<tbody>
			<tr>
	            <th class="title">위험분류</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_CATG1_C_NM" id="RISK_CATG1_C_NM" value="" style="text-align:center" readonly>
	            </td>

	        	<th class="title">평가항목</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_VAL_ITEM_NM" id="RISK_VAL_ITEM_NM" value="" style="text-align:center" readonly>
	            </td>
            </tr>
            <tr>
	            <th class="title">위험요소<span style="color:red;">*</span></th>
	            <td colspan="3">
	            <input type="text" class="cond-input-text" name="RISK_ELMT_NM" id="RISK_ELMT_NM" value="" readonly>
	            </td>
            </tr>
            <tr >
	            <th class="title">적용대상</th>
	            <td>
	            	<input type="checkbox" id="RISK_INDI" name="RISK_INDI" class="div-cont-box-checkbox" ${"Y".equals(RISK_INDI) ? "checked='checked'":""} disabled>
					<label for="RISK_INDI" readonly></label>&nbsp;&nbsp;개인(개인사업자 포함)
				</td>
				<td>
					<input type="checkbox" id="RISK_CORP" name="RISK_CORP" class="div-cont-box-checkbox" ${"Y".equals(RISK_CORP) ? "checked='checked'":""} disabled>
					<label for="RISK_CORP" readonly></label>&nbsp;&nbsp;법인
	            </td>
            </tr>
            <tr>
	            <th class="title">위험점수<span style="color:red;">*</span></th>
	            <td style="text-align: center;">
	            <input type="text" class="cond-input-text" name="RISK_SCR" id="RISK_SCR" value="" style="text-align:center"/ readonly>
	            </td>

	        	<th class="title">당연EDD 여부<span style="color:red;">*</span></th>
	            <td>
	            	${radioel.getRadioBtns('{radioBtnID:"RISK_HRSK_YN",cdID:"N002",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <th class="title">적용모델</th>
	            <td>
	            	<input type="checkbox" id="RISK_APPL_MODEL_I" name="RISK_APPL_MODEL_I" class="div-cont-box-checkbox"  ${"Y".equals(RISK_APPL_MODEL_I) ? "checked='checked'":""} disabled>
					<label for="RISK_APPL_MODEL_I"></label>&nbsp;&nbsp;I모델&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" id="RISK_APPL_MODEL_B" name="RISK_APPL_MODEL_B" class="div-cont-box-checkbox"  ${"Y".equals(RISK_APPL_MODEL_B) ? "checked='checked'":""} disabled>
					<label for="RISK_APPL_MODEL_B"></label>&nbsp;&nbsp;B모델
				</td>
	        	<th class="title">결재상태</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RA_SN_CCD_NM" id="RA_SN_CCD_NM" value="" style="text-align:center" readonly>
	            </td>
            </tr>
            <tr>
	            <th class="title">위험 사유</th>
	            <td colspan="3"><textarea name="RISK_RSN_DESC" id="RISK_RSN_DESC" rows="9" cols="10" style="width:100%;height:100px;" readonly></textarea><br></td>
            </tr>
            <tr>
	            <th class="title">비고(메모)</th>
	            <td colspan="3"><textarea name="RISK_RMRK" id="RISK_RMRK" rows="9" cols="10" style="width:100%;height:100px;" readonly></textarea><br></td>
            </tr>
		</tbody>
	</table>
	<br>
	<div class="button-area" style="float:right; margin-bottom:30px;" >
    	${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
	</div>
	<br>
	<br>
</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />