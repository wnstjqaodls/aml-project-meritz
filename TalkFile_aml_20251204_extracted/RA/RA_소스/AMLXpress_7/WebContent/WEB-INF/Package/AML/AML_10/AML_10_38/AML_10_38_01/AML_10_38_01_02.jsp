<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : AML_10_38_01_02.jsp
* Description     : 위험등급별 구간수정
* Group           : GTONE, R&D센터/개발2본부
* Author          :
* Since           : 2025-06-30
********************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
  String cs_typ_cd     = Util.nvl(request.getParameter("CS_TYP_CD")   );
  String new_old_gbncd = Util.nvl(request.getParameter("NEW_OLD_GBN_CD") );
  String ROLEID        = sessionAML.getsAML_ROLE_ID();

  request.setAttribute("cs_typ_cd"    , cs_typ_cd   );
  request.setAttribute("new_old_gbncd", new_old_gbncd );
  request.setAttribute("ROLEID"       , ROLEID       );
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
    var classID       = "AML_10_38_01_01";
    var pageID        = "AML_10_38_01_02";
    var overlay       = new Overlay();
	var cs_typ_cd     = "${cs_typ_cd}";
	var new_old_gbncd = "${new_old_gbncd}";
	var ROLEID        = "${ROLEID}";

    $(document).ready(function(){
    	setupGrids();
    	doSearch();
    });

    function doSearch()
    {
    	var classID           = "AML_10_38_01_01";
        var methodID          = "getSearch";
        var params            = new Object();

        params.pageID         = pageID;
        params.CS_TYP_CD      = cs_typ_cd;
        params.NEW_OLD_GBN_CD = new_old_gbncd;

        sendService(classID, methodID, params, doSearch_success, doSearch_success);
    }

    function doSearch_success(gridData, data) {
    	if(gridData.length > 0) {
        	var obj = gridData[0];
        	form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
        	form1.RA_SEQ.value        = obj.RA_SEQ;
        	form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
        	form1.RA_GRD_CD.value     = obj.RA_GRD_CD;
        }

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

    function doSave() {
    	GridObj1.saveEditData();
    	showConfirm('${msgel.getMsg("AML_10_02_01_01_002","저장 하시겠습니까?")}', "저장",function(){
    	var allRowsData       = getDataSource(GridObj1);
    	var classID		      = "AML_10_38_01_01";
        var methodID	      = "doSave";
        var RA_SN_CCD         = form1.RA_SN_CCD.value;
        var RA_SEQ            = form1.RA_SEQ.value;
        var RA_REF_SN_CCD     = form1.RA_REF_SN_CCD.value;
        var RA_GRD_CD         = form1.RA_GRD_CD.value;
        var params            = new Object();

        params.CS_TYP_CD      = cs_typ_cd;
    	params.NEW_OLD_GBN_CD = new_old_gbncd;
    	params.RA_GRD_CD      = RA_GRD_CD;
    	params.RA_SN_CCD      = RA_SN_CCD;
    	params.RA_SEQ         = RA_SEQ;
		params.RA_REF_SN_CCD  = RA_REF_SN_CCD;

        params.gridData       = allRowsData;

    	sendService(classID, methodID, params, doSave_end, doSearch_fail);
    	});
    }

    function doSave_end() {
		overlay.hide();
    	doSearch();
    	opener.doSearch();
	}
    function doSearch_fail(){ overlay.hide(); }

    function setupGrids()
    {
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
     	     gridId       			: "GTDataGrid1"
            ,width		 			: "100%"
            ,height		 			: "calc(100vh - 150px)"
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
            ,sorting         		: { mode: "none"}
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
     	        {dataField: "CS_TYP_CD"			,caption: "CS_TYP_CD"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
      	        {dataField: "NEW_OLD_GBN_CD"	,caption: "NEW_OLD_GBN_CD"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
      	      	{dataField: "RA_GRD_NM"			,caption: "위험등급"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
      	    	{dataField: "RA_GRD_CD"			,caption: "RA_GRD_CD"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
      	  		{dataField: "RA_GRD_SCR_MIN"	,caption: "시작값"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
      			{dataField: "GUGAN1"			,caption: "구간1"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
      	  	    {dataField: "RA_GRD_SCR_MAX"	,caption: "종료값"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
      			{dataField: "GUGAN2"			,caption: "구간2"				,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false},
      			{dataField: "RA_REF_SN_CCD"		,caption: "RA_REF_SN_CCD"	,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
      			{dataField: "RA_SN_CCD"			,caption: "RA_SN_CCD"		,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false},
      			{dataField: "RA_SEQ"			,caption: "RA_SEQ"			,alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: false, visible:false}
      	    ]
            ,onCellPrepared : function(e){
        		   if(e.rowType === 'data' &&
              		     ( e.column.dataField === 'RA_GRD_SCR_MIN' || e.column.dataField === 'RA_GRD_SCR_MAX')){
              		       e.cellElement.css("color", "blue");
              		     }
		     	}
            ,onCellClick: function(e){
            	if(e.rowType != "header" && e.rowType != "filter" && e.rowType != "totalFooter"){
                    if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=1) || (e.columnIndex>=3 && e.columnIndex<=3)){
                        e.component.editCell(e.rowIndex,e.columnIndex);
                    }
                }
            }
     }).dxDataGrid("instance");

    }

    function popupClose() {
        self.close();
    }


</script>


<style>
	.basic-table .title {
		/* min-width: 130px; */
		text-align: center;
	}

}
</style>
<form name="form1" method="post" onsubmit="return false;">
<input type="hidden" name="pageID" >
<input type="hidden" name="classID" >
<input type="hidden" name="methodID" >
<input type="hidden" name="RA_SN_CCD">
<input type="hidden" name="RA_SEQ">
<input type="hidden" name="RA_REF_SN_CCD">
<input type="hidden" name="RA_GRD_CD">

<div class="tab-content-bottom" style="margin-top:10px;">
	<div class="panel-footer" >
        <div id = "GTDataGrid1_Area"></div>
    </div>
</div>
<div class="button-area" style="float:right; margin-top:10px;">
	<% if ( "4".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
    <% } %>
    	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"popupClose", cssClass:"btn-36"}')}
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />
