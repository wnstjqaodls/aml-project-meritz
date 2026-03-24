<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : AML_10_36_01_01.jsp
* Description     : 위험평가 항목점수
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
    inputApr.put("GUBUN","RA1");
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
    var classID  = "AML_10_36_01_01";
    var pageID  = "AML_10_36_01_01";
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
        doSearch();
    });

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
	     	   ,remoteOperations : {filtering: false,grouping: false,paging: false,sorting: true,summary: false}
	     	   ,rowAlternationEnabled : true
	     	   ,scrolling : {mode: "standard",preloadEnabled: false}
	     	   ,searchPanel : {visible : false,width: 250}
	     	   ,selection: {
	     	        allowSelectAll: true
	     	       ,deferred: false
	     	       ,mode: 'multiple'  /* none, single, multiple                       */
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
	      	        {dataField: "SN_CCD_NM_ING",caption: "SN_CCD_NM_ING",alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
	      	        {dataField: "SN_CCD_NM",caption: "SN_CCD_NM",alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
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

 // 그리드 초기화 함수 셋업
    function setupGrids2(){
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
 	   	    	visible: true
 	   	    	,showNavigationButtons: true
 	   	    	,showInfo: true
 	   	    }
 	   	    ,paging: {
 	   	    	enabled : true
 	   	    	,pageSize : 20
 	   	    }
 		   	,scrolling : {
                 mode            : "standard"
                ,preloadEnabled  : false
             }
             ,searchPanel: {visible : false,width   : 250}
             ,selection: {
                  allowSelectAll      : false
                 ,deferred            : false
                 ,mode                : 'multiple'    /* none, single, multiple                       */
                 ,selectAllMode       : 'allPages'    /* 'page' | 'allPages'                          */
                 ,showCheckBoxesMode  : 'always'      /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
              }
               ,columns: [
            	    {dataField: "RISK_CATG1_C"		,caption: "위험분류"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false},
            	    {dataField: "RISK_CATG1_C_NM"	,caption: "위험분류"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true},
            	    {dataField: "RISK_VAL_ITEM"		,caption: "평가항목"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false},
                    {dataField: "RISK_VAL_ITEM_NM"	,caption: "평가항목"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true, "width": "150px"},
                    {dataField: "RISK_ELMT_C"		,caption: "위험요소"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : false},
                    {dataField: "RISK_ELMT_NM"		,caption: "위험요소"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true, "width": "300px", cssClass:"link"},
                    {caption: "적용 대상",
                    	columns : [
                    		{dataField: "RISK_INDI"		,caption: "개인",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false},
                    		{dataField: "RISK_INDI_NM"	,caption: "개인",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false},
                    		{dataField: "RISK_CORP"		,caption: "법인",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false},
                    		{dataField: "RISK_CORP_NM"	,caption: "법인",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false}


                    	],alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: true
                   	},
                    {dataField: "RISK_SCR",caption: "위험점수",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: true},
                    {dataField: "RISK_HRSK_YN",caption: "당연EDD여부",alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: true},
                    {caption: "적용 모델",
                    	columns : [
                    		{dataField: "RISK_APPL_MODEL_I"		,caption: "I모델",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false},
                    		{dataField: "RISK_APPL_MODEL_I_NM"	,caption: "I모델",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false},
                    		{dataField: "RISK_APPL_MODEL_B"		,caption: "B모델",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible:false},
                    		{dataField: "RISK_APPL_MODEL_B_NM"	,caption: "B모델",alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false}


                    	],alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: true
                   	},
                   	{dataField: "RISK_RSN_DESC"	,caption: "위험사유"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RISK_RMRK"		,caption: "비고"	  			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SN_CCD"		,caption: "결재상태코드"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SN_CCD_NM"	,caption: "결재상태"	  		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:true, cssClass:"link"},
                    {dataField: "RA_APP_NO"		,caption: "결재번호"	  		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_APP_DT"		,caption: "결재일자"	  		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_NO"	,caption: "최종결재번호"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_LST_APP_DT"	,caption: "최종결재일자"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD_NM" 	,caption: "결재상태"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SN_CCD"		,caption: "결재코드"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_NO"		,caption: "결재번호"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "GYLJ_LINE_G_C"	,caption: "결재선구분코드"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APP_DT"		,caption: "결재일자"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "SNO"			,caption: "최종순번"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "PRV_APP_NO"	,caption: "이전결재번호"		,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RSN_CNTNT"		,caption: "결재사유"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RISK_CATG2_C"	,caption: "위험분류"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RISK_APPL_YN"	,caption: "적용여부"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_SEQ"		,caption: "RA_SEQ"			,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "RA_REF_SN_CCD"	,caption: "RA_REF_SN_CCD"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "APPR_ROLE_ID"	,caption: "APPR_ROLE_ID"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                    {dataField: "TARGET_ROLE_ID",caption: "TARGET_ROLE_ID"	,alignment: "center",allowResizing: true,allowSorting: true,allowEditing: false,allowFiltering: false,visible:false},
                ]
                // events
               ,"onRowInserting" : function(e) {
                }
               ,onCellPrepared : function(e){
           		   if(e.rowType === 'data' && (e.column.dataField === 'RISK_HRSK_YN')){
						if(e.value === "Y" || e.value === "H")
                 		       e.cellElement.css("color", "red");
                 	}
 		     	}
                ,onCellClick: function(e){
                		//e.component.clearSelection();
        	            //e.component.selectRowsByIndexes(e.rowIndex);
                		Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
                } 
        }).dxDataGrid("instance");
    }

 	// 그리드 CellClick function
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId , colId){}

    // 그리드2 CellClick function
    function Grid2CellClick(id, obj, selectData, rowIdx, colIdx, colId){
    	clickedRowIndex = rowIdx;
       if(colId == "RISK_ELMT_NM" && obj){
   		   form1.pageID.value = 'AML_10_36_01_02';
           window_popup_open(form1.pageID.value, 900, 650, '');
   		   form1.RISK_CATG1_C.value      = obj.RISK_CATG1_C;
   		   form1.RISK_ELMT_C.value       = obj.RISK_ELMT_C;
   		   form1.RISK_INDI.value         = obj.RISK_INDI;
   		   form1.RISK_CORP.value         = obj.RISK_CORP;
   		   form1.RISK_APPL_MODEL_I.value = obj.RISK_APPL_MODEL_I;
   		   form1.RISK_APPL_MODEL_B.value = obj.RISK_APPL_MODEL_B;
   		   form1.RANKID.value            = RANKID;
           form1.target                  = form1.pageID.value;
           form1.action                  = "<c:url value='/'/>0001.do";
           form1.submit();
       }else if(colId == "RA_SN_CCD_NM" && obj) {
   		   form1.pageID.value = 'AML_10_36_01_06';
   		   window_popup_open(form1.pageID.value, 900, 450, '');
   		   form1.RISK_ELMT_C.value = obj.RISK_ELMT_C;
   		   form1.target            = form1.pageID.value;
           form1.action            = "<c:url value='/'/>0001.do";
           form1.submit();
       }
       
       if(ROLEID == "4") {
	   	if(obj.RA_SN_CCD == "N") {
	   		$("#sbtn_01").show();
	   		$("#sbtn_02").hide();
	   		$("#btn_03").hide();
	   		$("#sbtn_03").hide();
	   		$("#btn_04").hide();
		}else {
			$("#sbtn_01").hide();
	   		$("#sbtn_02").hide();
	   		$("#btn_03").hide();
	   		$("#sbtn_03").hide();
	   		$("#btn_04").hide();
        }
       }else if(ROLEID == "5") {
    	if(ROLEID == obj.TARGET_ROLE_ID) {
	    	if(obj.RA_SN_CCD == "S") {
	   			$("#sbtn_01").hide();
	   	   		$("#sbtn_02").show();
	   	   		$("#btn_03").show();
	   	   		$("#sbtn_03").hide();
	   	   		$("#btn_04").hide();
	        }else {
	        	$("#sbtn_01").hide();
	   	   		$("#sbtn_02").hide();
	   	   		$("#btn_03").hide();
	   	   		$("#sbtn_03").hide();
	   	   		$("#btn_04").hide();
	        }
    	}else {
    		$("#sbtn_01").hide();
   	   		$("#sbtn_02").hide();
   	   		$("#btn_03").hide();
   	   		$("#sbtn_03").hide();
   	   		$("#btn_04").hide();
		}
       }else if(ROLEID == "104") {
		if(ROLEID == obj.TARGET_ROLE_ID) {
	    	if(obj.RA_SN_CCD == "S") {
	      		$("#sbtn_01").hide();
	      	   	$("#sbtn_02").hide();
	      	   	$("#btn_03").hide();
	      	   	$("#sbtn_03").show();
	      	   	$("#btn_04").show();
	        }else {
	           	$("#sbtn_01").hide();
	      	   	$("#sbtn_02").hide();
	      	   	$("#btn_03").hide();
	      	   	$("#sbtn_03").hide();
	      	   	$("#btn_04").hide();
	        }
		}else {
			$("#sbtn_01").hide();
      	   	$("#sbtn_02").hide();
      	   	$("#btn_03").hide();
      	   	$("#sbtn_03").hide();
      	   	$("#btn_04").hide();
		}
       }else {
    	   $("#sbtn_01").hide();
  	   	   $("#sbtn_02").hide();
  	   	   $("#btn_03").hide();
  	   	   $("#sbtn_03").hide();
  	   	   $("#btn_04").hide();
       }
    }

    /* Grid1 위험평가항목 검색 */
    function doSearch() {
    	overlay.hide();
        var classID  = "AML_10_36_01_01";
        var methodID = "getSearchMaster";
        var params = new Object();
        params.pageID   = pageID;

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);

    }

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
                    str += '            <td height=25 style="cursor:pointer;" title="'+item.ITEM_NM+'" onclick="showGridSubFrame(\''+item.RA_ITEM_CD+'\',\''+i+'\',\''+gridData+'\',\''+item.ITEM_NM+'\')">';
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
            showGridSubFrame(gridData[0].RA_ITEM_CD, 0, gridData, gridData[0].ITEM_NM);

            //$("#span_0").attr("class","t01-menu-on");
        }
    }

    function showGridSubFrame(RA_ITEM_CD, selectedIndex, gridData, ITEM_NM){
    	GridObj1.selectRowsByIndexes(selectedIndex);
        for (var i=0; i<gridData.length; i++) {
            if (gridData[i]) {
            	$("#span_"+i).attr("class","t01-menu");
            }
        }
        $("#span_"+selectedIndex).attr("class","t01-menu-on");
        //form1.SN_CCD.value       = SN_CCD;
        if (curRow!=selectedIndex) {
            $("#subBizTitle").text(ITEM_NM);

            if(RA_ITEM_CD == "R1") {
            	$("#subBizTitle2").text("※ 위험점수 또는 당연EDD 여부 변경 사항에 대한 결재 완료 시, 국가별 위험점수를 재계산 하여야 합니다.");
            }else if(RA_ITEM_CD == "R2"){
            	$("#subBizTitle2").text("※ 직업 또는 업종(표준산업분류코드) 평가 항목에 대한 위험점수 또는 당연EDD 여부 변경 사항 결재 완료 시, 직업/업종별 위험점수를 재계산 하여야 합니다.");
            }else {
            	$("#subBizTitle2").text("");
            }

             curRow                     = selectedIndex;
             form1.RA_ITEM_CD.value     = RA_ITEM_CD;
             form1.CUR_ROW.value        = selectedIndex;
             form1.SEARCH_GUBUN.value   = "Y";
             form2.RA_ITEM_CD.value     = RA_ITEM_CD;
             doSearch2();
         }
    }

    function doSearch_fail(){
     	overlay.hide();
    }

    function doSearch2re() {
    	form1.SEARCH_GUBUN.value = "N";
    	doSearch2();
    }

    /* Grid1 위험평가항목상세 검색 */
    function doSearch2() {
        setupGrids2();
        if(form1.SEARCH_GUBUN.value == "Y") {
        	var methodID = "getSearchDetail";
            var params = new Object();
            params.pageID         = pageID;
            params.RA_ITEM_CD     = form1.RA_ITEM_CD.value;
            params.MNTN_STNR_CODE = "";
            params.RISK_HRSK_YN   = "ALL";
            params.INDV_CORP_YN   = "ALL";
            params.IB_MODEL_YN    = "ALL";
            params.RANKID         = RANKID;
            sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
        }else {
        	var methodID = "getSearchDetail";
            var params = new Object();
            params.pageID         = pageID;
            params.RA_ITEM_CD     = form1.RA_ITEM_CD.value;
            params.MNTN_STNR_CODE = form1.MNTN_STNR_CODE.value;
            params.RISK_HRSK_YN   = form1.RISK_HRSK_YN.value;
            params.INDV_CORP_YN   = form1.INDV_CORP_YN.value;
            params.IB_MODEL_YN    = form1.IB_MODEL_YN.value; 
            params.RANKID         = RANKID;
            sendService(classID, methodID, params, doSearch2_success, doSearch2_fail);
        }
    }

    function doSearch2_success(gridData, data){
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

    //결재요청
    function PopKYCPage() {
    	var rowsData = GridObj2.getSelectedRowsData();

    	if (rowsData.length == 0) {
            showAlert('${msgel.getMsg("AML_10_03_01_01_001","선택된 데이터가 없습니다")}','WARN');
            return;
        }

    	if (rowsData.length > 1) {
    		showAlert( "${msgel.getMsg('AML_10_25_02_02_056', '1건 이상 입니다. 1건만 선택해주세요.')}", "WARN");
            return;
        }
    	
    	for (var i = 0; i < rowsData.length; i++){  // N:미상신, S:결재중, R:반려, E:결재완료
            var RA_SEQ = rowsData[i].RA_SEQ;
            var RISK_ELMT_C = rowsData[i].RISK_ELMT_C;
            var RA_APP_NO = rowsData[i].RA_APP_NO;
            var POSITION_NAME = rowsData[i].POSITION_NAME;
            var RA_REF_SN_CCD = rowsData[i].RA_REF_SN_CCD;

    		/* if(snccd == "S" || snccd =="E" || !risksnccd.trim()){
                showAlert('${msgel.getMsg("AML_10_03_01_01_050","결재 상태가 미상신인 경우에만 결재 요청이 가능합니다.")}','WARN');
                overlay.hide();             return;
            } */
    	}

    	form2.pageID.value = 'AML_10_36_01_03';
        window_popup_open(form2.pageID.value, 900, 680, '', '');
        form2.target              = form2.pageID.value;

        form2.RA_SEQ.value         = RA_SEQ;
        form2.RISK_ELMT_C.value    = RISK_ELMT_C;
    	form2.RA_REF_SN_CCD.value  = RA_REF_SN_CCD;
    	form2.APP_NO.value         = RA_APP_NO;
		form2.POSITION_NAME.value  = POSITION_NAME;
		
		form2.searchgubun.value    = "Y";
        form2.action               = "<c:url value='/'/>0001.do";
        form2.submit();
    }

  	//결재완료
    function PopKYCPage3() {
    	var rowsData = GridObj2.getSelectedRowsData();

    	if (rowsData.length == 0) {
            showAlert('${msgel.getMsg("AML_10_03_01_01_001","선택된 데이터가 없습니다")}','WARN');
            return;
        }
    	
    	if (rowsData.length > 1) {
    		showAlert( "${msgel.getMsg('AML_10_25_02_02_056', '1건 이상 입니다. 1건만 선택해주세요.')}", "WARN");
            return;
        }

    	for (var i = 0; i < rowsData.length; i++){  // N:미상신, S:결재중, R:반려, E:결재완료
            var RA_SEQ = rowsData[i].RA_SEQ;
            var RISK_ELMT_C = rowsData[i].RISK_ELMT_C;
            var RA_APP_NO = rowsData[i].RA_APP_NO;
            var POSITION_NAME = rowsData[i].POSITION_NAME;
            var PRV_APP_NO = rowsData[i].PRV_APP_NO;
            var RISK_ELMT_NM  = rowsData[i].RISK_ELMT_NM;

    		/* if(snccd == "S" || snccd =="E" || !risksnccd.trim()){
                showAlert('${msgel.getMsg("AML_10_03_01_01_050","결재 상태가 미상신인 경우에만 결재 요청이 가능합니다.")}','WARN');
                overlay.hide();             return;
            } */
    	}
  		
    	form2.pageID.value = 'AML_10_36_01_03';
        window_popup_open(form2.pageID.value, 900, 680, '', '');
        form2.target                  = form2.pageID.value;
        
        form2.RISK_ELMT_C.value    = RISK_ELMT_C;
        form2.RA_SEQ.value     	   = RA_SEQ;
	    form2.APP_NO.value         = RA_APP_NO;
        form2.PRV_APP_NO.value     = PRV_APP_NO;
	    form2.POSITION_NAME.value  = POSITION_NAME;
	    form2.RISK_ELMT_NM.value   = RISK_ELMT_NM;
	    form2.searchgubun.value    = "Y";
        form2.action               = "<c:url value='/'/>0001.do";
        form2.submit();

    }

  	//반려실행
    function PopKYCPage2() {
    	var rowsData = GridObj2.getSelectedRowsData();

    	if (rowsData.length == 0) {
            showAlert('${msgel.getMsg("AML_10_03_01_01_001","선택된 데이터가 없습니다")}','WARN');
            return;
        }
    	
    	if (rowsData.length > 1) {
    		showAlert( "${msgel.getMsg('AML_10_25_02_02_056', '1건 이상 입니다. 1건만 선택해주세요.')}", "WARN");
            return;
        }

    	for (var i = 0; i < rowsData.length; i++){  // N:미상신, S:결재중, R:반려, E:결재완료
            var RA_SEQ = rowsData[i].RA_SEQ;
            var RISK_ELMT_C = rowsData[i].RISK_ELMT_C;
            var RA_APP_NO = rowsData[i].RA_APP_NO;
            var POSITION_NAME = rowsData[i].POSITION_NAME;

    		/* if(snccd == "S" || snccd =="E" || !risksnccd.trim()){
                showAlert('${msgel.getMsg("AML_10_03_01_01_050","결재 상태가 미상신인 경우에만 결재 요청이 가능합니다.")}','WARN');
                overlay.hide();             return;
            } */
    	}
        
        form2.pageID.value = 'AML_10_36_01_04';
        window_popup_open(form2.pageID.value, 900, 680, '', '');
        form2.target              = form2.pageID.value;

        form2.RISK_ELMT_C.value    = RISK_ELMT_C;
        form2.RA_SEQ.value         = RA_SEQ;
        form2.POSITION_NAME.value  = POSITION_NAME;
        form2.APP_NO.value         = RA_APP_NO;
        form2.searchgubun.value    = "Y";
        form2.action              = "<c:url value='/'/>0001.do";
        form2.submit();

    }

  	//변경이력
    function doHistoryList() {
    	var rowsData = GridObj2.getSelectedRowsData();

    	if (rowsData.length == 0) {
            showAlert('${msgel.getMsg("AML_10_03_01_01_001","선택된 데이터가 없습니다")}','WARN');
            return;
        }
    	if (rowsData.length > 1) {
    		showAlert( "${msgel.getMsg('AML_10_25_02_02_056', '1건 이상 입니다. 1건만 선택해주세요.')}", "WARN");
            return;
        }

    	form2.pageID.value = 'AML_10_36_01_05';
        window_popup_open(form2.pageID.value, 900, 1000, '', '');
        form2.target = form2.pageID.value;
        form2.RISK_ELMT_C.value   = rowsData[0].RISK_ELMT_C;

        form2.action = "<c:url value='/'/>0001.do";
        form2.submit();

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
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="RA_ITEM_CD">
    <input type="hidden" name="REFF_COMN_CD">
    <input type="hidden" name="INTV_VAL_YN">
    <input type="hidden" name="RISK_ELMT_C">
    <input type="hidden" name="RISK_ELMT_NM">
    <input type="hidden" name="RISK_SCR">
    <input type="hidden" name="RISK_HRSK_YN">
    <input type="hidden" name="RISK_RSN_DESC">
    <input type="hidden" name="RISK_RMRK">

	<input type="hidden" name="RISK_CATG1_C">
    <input type="hidden" name="RISK_CATG2_C">
    <input type="hidden" name="RISK_INDI">
    <input type="hidden" name="RISK_CORP">
    <input type="hidden" name="RISK_VAL_ITEM">
    <input type="hidden" name="RISK_APPL_YN">

	<input type="hidden" name="RISK_APPL_MODEL_I">
    <input type="hidden" name="RISK_APPL_MODEL_B">

    
	<input type="hidden" name="RA_APP_NO">
	<input type="hidden" name="RA_APP_DT">
	<input type="hidden" name="PRV_APP_NO">
	<input type="hidden" name="RA_SN_CCD">
	<input type="hidden" name="RA_SEQ">
	<input type="hidden" name="POSITION_NAME">
	<input type="hidden" name="RA_REF_SN_CCD">
	<input type="hidden" name="APP_NO">
	<input type="hidden" name="SNO">
	<input type="hidden" name="popkygubun">
	<input type="hidden" name="searchgubun">
</form>

<form name="form1" method="post">
	<input type="hidden" name="pageID">
    <input type="hidden" name="RA_ITEM_CD">
    <input type="hidden" name="REFF_COMN_CD">
    <input type="hidden" name="INTV_VAL_YN">
    <input type="hidden" name="CUR_ROW">
    <input type="hidden" name="SN_CCD">
    <input type="hidden" name="SEARCH_GUBUN">
    <input type="hidden" name="RISK_CATG1_C">
	
	<input type="hidden" name="RISK_INDI">
    <input type="hidden" name="RISK_CORP">
    <input type="hidden" name="RISK_APPL_MODEL_I">
	<input type="hidden" name="RISK_APPL_MODEL_B">
	<input type="hidden" name="RANKID">
	
	<input type="hidden" name="RISK_ELMT_C">
	<input type="hidden" name="RA_APP_NO">
	<input type="hidden" name="RA_APP_DT">
	<input type="hidden" name="PRV_APP_NO">
	<input type="hidden" name="RA_SN_CCD">
	<input type="hidden" name="RA_SEQ">
	<input type="hidden" name="POSITION_NAME">
	<input type="hidden" name="RA_REF_SN_CCD">

    <div id="RAITEMSCRFile" style="display: none;"></div>
    <div class="button-area"></div>
    <div class="tree-conformation-area">
	    <div class="tree-left" style="overflow-y: scroll; width:15%;">
	    	<%-- <h4 class="tree-title">${msgel.getMsg("AML_10_03_01_01_048","위험분류별 위험요소관리")}</h4> --%>
	     <ul class="tree-list" >
	        <li class="tree-item active">
	          <div id="htmlGrid"></div>
	       </li>
	     </ul>
	    </div>

     	<div id="template_right" class="tree-right" style="width:85%;">
        	<div id="subBizTitle" class="title" style="font-family:SpoqB;font-size: 20px;color: #444;letter-spacing: -0.4px;line-height: normal;"></div>
				<%-- <h4 class="tree-title">${msgel.getMsg("AML_10_03_01_01_049","국가 위험요소")}</h4> --%>
				<br>
			<div class="inquiry-table">

				<div class="table-row">
					<div class="table-cell">
	            		${condel.getSelect('AML_10_36_01_01_027','평가항목','MNTN_STNR_CODE','300','MDAO.AML_10_36_01_01_common_getComboData',MNTN_STNR_CODE,'ALL','ALL')}
					</div>

					<div class="table-cell">
						${condel.getLabel('AML_10_36_01_01_029','당연 EDD여부')}
	            		<div class="content">
							<select name="RISK_HRSK_YN" id="RISK_HRSK_YN" class="dropdown">
								<option value="ALL">::전체::</option>
                				<option value="Y">Y</option>
                				<option value="H">H</option>
                				<option value="YH">Y + H</option>
                				<option value="N">N</option>
							</select>
						</div>
					</div>
				</div>
				<div class="table-row">
					<div class="table-cell">
						${condel.getLabel('AML_10_36_01_01_028','적용대상')}
            			<div class="content">
							<select name="INDV_CORP_YN" id="INDV_CORP_YN" class="dropdown">
								<option value="ALL">::전체::</option>
                				<option value="Y">개인(개인사업자)</option>
                				<option value="N">법인</option>
							</select>
						</div>
					</div>
					<div class="table-cell">
						${condel.getLabel('AML_10_03_01_01_047','적용모델')}
	            		<div class="content">
							<select name="IB_MODEL_YN" id="IB_MODEL_YN" class="dropdown">
								<option value="ALL">::전체::</option>
                				<option value="IM">I모델</option>
                				<option value="BM">B모델</option>
							</select>
						</div>
					</div>
				</div>

				<div class="table-row">
					<div class="table-cell">
					</div>

					<div class="table-cell" >
						<div class="button-area" style="padding-bottom:8px; padding-right:36px; position:absolute; right:0;">
							${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch2re", cssClass:"btn-36 filled"}')}
						</div>
					</div>
				</div>
			</div>

			<div id="subBizTitle2" style="padding-top:10px; font-size:15px;"></div>

	        <div class="button-area">
				${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"changeHisBtn", defaultValue:"변경이력", mode:"R", function:"doHistoryList", cssClass:"btn-36"}')}
	        <% if ( "4".equals(ROLEID)) { // 4:컴플라이언스운영팀 담당자,5:컴플라이언스운영팀 책임자,104:보고책임자 %>
	        	${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"approvalBtn", defaultValue:"결재", mode:"R", function:"PopKYCPage", cssClass:"btn-36"}')}
	        <% } %>
	        <% if ( "104".equals(ROLEID)) { // 4:컴플라이언스운영팀 담당자,5:컴플라이언스운영팀 책임자,104:보고책임자 %>
	        	${btnel.getButton(outputAuth, '{btnID:"sbtn_03", cdID:"approvalBtn", defaultValue:"결재", mode:"R", function:"PopKYCPage3", cssClass:"btn-36"}')}
	        	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"denyBtn", defaultValue:"반려", mode:"R", function:"PopKYCPage2", cssClass:"btn-36"}')}
	        <% } %>
	        </div>
	        <br>
            <div id="GTDataGrid2_Area"></div>
        </div>
    </div>
	<div id="GTDataGrid1_Area" style="display : none;"></div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />