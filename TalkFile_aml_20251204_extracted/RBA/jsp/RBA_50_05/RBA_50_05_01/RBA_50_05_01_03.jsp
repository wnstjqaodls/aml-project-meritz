<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_01_03.jsp
* Description     : 수기평가 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-05-04
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%

    String PROC_FLD_C     = request.getParameter("PROC_FLD_C");
    String PROC_LGDV_NM     = request.getParameter("PROC_LGDV_NM");
    String PROC_LGDV_C     = request.getParameter("PROC_LGDV_C");
    String PROC_MDDV_NM     = request.getParameter("PROC_MDDV_NM");
    String PROC_MDDV_C     = request.getParameter("PROC_MDDV_C");
    String PROC_SMDV_NM     = request.getParameter("PROC_SMDV_NM");
    String PROC_SMDV_C     = request.getParameter("PROC_SMDV_C");
    String VALT_BRNO     = request.getParameter("VALT_BRNO");
    String VALT_BRNM     = request.getParameter("VALT_BRNM");
    String REG_YN     = request.getParameter("REG_YN");
    String RSK_VALT_PNT     = request.getParameter("R_RSK_VALT_PNT");
    String BAS_YYMM     = request.getParameter("BAS_YYMM");
    String P_GUBN     = request.getParameter("P_GUBN");

    String R_RSK_VALT_PNT; R_RSK_VALT_PNT = request.getParameter("R_RSK_VALT_PNT");

    request.setAttribute("PROC_FLD_C",PROC_FLD_C);
    request.setAttribute("PROC_LGDV_NM",PROC_LGDV_NM);
    request.setAttribute("PROC_LGDV_C",PROC_LGDV_C);
    request.setAttribute("PROC_MDDV_NM",PROC_MDDV_NM);
    request.setAttribute("PROC_MDDV_C",PROC_MDDV_C);
    request.setAttribute("PROC_SMDV_NM",PROC_SMDV_NM);
    request.setAttribute("PROC_SMDV_C",PROC_SMDV_C);
    request.setAttribute("VALT_BRNO",VALT_BRNO);
    request.setAttribute("VALT_BRNM",VALT_BRNM);
    request.setAttribute("REG_YN",REG_YN);
    request.setAttribute("RSK_VALT_PNT",RSK_VALT_PNT);
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    request.setAttribute("P_GUBN",P_GUBN);
%>

<style>
	.table-title {
		font-family: SpoqB;
	font-size: 16px;
	line-height: 24px;
	color: #444;
	letter-spacing: -0.32px;
	}
</style>

<script language="JavaScript">

    var GridObj1;
    var GridObj2;
    var overlay = new Overlay();
    var classID  = "RBA_50_05_01_03";

    // Initialize
    $(document).ready(function(){
        setupGrids1();
        setupGrids2();
        if(form.BAS_YYMM.value != ''){
            doSearch2();
        }
    });

    // Initial function
    function init() { initPage(); }

    // 그리드 초기화 함수 셋업
    function setupGrids1(){
   	 GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 height	:"calc(90vh - 100px)",
			 elementAttr: { class: "grid-table-type" },
			 hoverStateEnabled    : true,
			    wordWrapEnabled      : false,
			    allowColumnResizing  : true,
			    columnAutoWidth      : true,
			    allowColumnReordering: true,
			    cacheEnabled         : false,
			    cellHintEnabled      : true,
			    showBorders          : true,
			    showColumnLines      : true,
			    showRowLines         : true,
			    export               : {
			        allowExportSelectedData: true,
			        enabled                : true,
			        excelFilterEnabled     : true,
			        fileName               : "gridExport"
			    },
			    sorting              : {mode: "multiple"},
			    loadPanel            : {enabled: false},
			    remoteOperations     : {
			        filtering: false,
			        grouping : false,
			        paging   : false,
			        sorting  : false,
			        summary  : false
			    },
			    editing: {
			        mode         : "batch",
			        allowUpdating: false,
			        allowAdding  : false,
			        allowDeleting: false
			    },
			    filterRow            : {visible: false},
			    pager: {
			        visible: true,
			        showNavigationButtons: true,
			        showInfo: true
			    },
			    paging: {
			        enabled: true,
			        pageSize: 20
			    },
			    scrolling: {
			        mode: "standard",
			        preloadEnabled: false
			    },
			    rowAlternationEnabled: false,
			    onCellPrepared       : function(e){
			        var columnName = e.column.dataField;
			        var dataGrid   = e.component;
			        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
			        var realEdt       = dataGrid.cellValue(rowIndex, 'REAL_EDT');
			        var valtEdt       = dataGrid.cellValue(rowIndex, 'VALT_EDT');
			        if(rowIndex != -1){
			            if(realEdt == ''){
			                if((valtEdt !='') && (columnName == 'RBA_VALT_LGDV_C_NM' || columnName == 'RBA_VALT_SMDV_C_NM' || columnName == 'VALT_SDT' || columnName == 'VALT_EDT'
			                    || columnName == 'REAL_EDT' || columnName == 'ROWNUM' || columnName == 'EXP_TRM')){
			                    e.cellElement.css('background-color', '#FF4848');
			                }
			            }
			        }
			    },
			    searchPanel: {
			        visible: false,
			        width  : 250
			    },
			    selection: {
			        allowSelectAll    : true,
			        deferred          : false,
			        mode              : "single",
			        selectAllMode     : "allPages",
			        showCheckBoxesMode: "onClick"
			    },
			    columns: [
			            {
			            "caption": '${msgel.getMsg("RBA_50_05_01_01_103","표준AML업무프로세스")}',
			            "alignment": "center",
			            "columns" : [
			            	{
				               "dataField": "PROC_LGDV_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_03_01_012","대구분")}',
				               "width" : 150,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				            }, {
				               "dataField": "PROC_LGDV_C",
				               "caption": '대구분코드',
				               "width" : 250,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           }, {
				               "dataField": "PROC_MDDV_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_03_01_014","중구분")}',
				               "width" : "150",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "PROC_MDDV_C",
				               "caption": '중구분코드',
				               "width" : 250,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           }, {
				               "dataField": "PROC_SMDV_NM",
				               "caption": '${msgel.getMsg("RBA_50_05_03_01_016","소구분")}',
				               "width" : "250",
				               "allowResizing": true,
				               "allowSorting": true
				           }, {
				               "dataField": "PROC_SMDV_C",
				               "caption": '소구분코드',
				               "width" : 250,
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true,
				               "visible"      : false
				           }
				           ]
			        }, {
			            "dataField": "RSK_VALT_PNT",
			            "caption": '${msgel.getMsg("RBA_50_05_01_01_104","점수")}',
			            "width" : 80,
			            "dataType": "number",
			            "alignment": "right",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "REG_YN",
			            "caption": '${msgel.getMsg("RBA_50_05_01_01_105","총위험평가등록여부")}',
			            "width" : 120,
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "VALT_BRNO",
			            "caption": '부점',
			            "width" : 100,
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible"      : false
			        },{
			            "dataField": "VALT_BRNM",
			            "caption": '부점명',
			            "width" : 100,
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible"      : false
			        },{
			            "dataField": "BAS_YYMM",
			            "caption": '기준년월',
			            "width" : 100,
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible"      : false
			        },{
			            "dataField": "GUBN",
			            "caption": '구분',
			            "width" : 100,
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible"      : false
			        },{
			            "dataField": "PROC_FLD_C",
			            "caption": '영역',
			            "width" : 100,
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible"      : false
			        },{
			            "dataField": "ATTATCH_YN",
			            "caption": '${msgel.getMsg("RBA_50_03_01_01_102","첨부여부")}',
			            "width" : 100,
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "ATTCH_FILE_NO",
			            "caption": '첨부파일번호',
			            "width" : 100,
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible"      : false
			        }
			    ],
			    onCellClick: function(e){
			        if(e.data){
			            Grid3CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
       }).dxDataGrid("instance");
   }

    function setupGrids2(){
    	 GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
			 height	:"calc(30vh)",
			 elementAttr: { class: "grid-table-type" },
			 "hoverStateEnabled"                : true,
		     "wordWrapEnabled"                  : false,
		     "allowColumnResizing"              : true,
		     "columnAutoWidth"                  : true,
		     "allowColumnReordering"            : true,
		     "cacheEnabled"                     : false,
		     "cellHintEnabled"                  : true,
		     "showBorders"                      : true,
		     "showColumnLines"                  : true,
		     "showRowLines"                     : true,
		     "export":                  
		     {
		         "allowExportSelectedData"      : false,
		         "enabled"                      : false,
		         "excelFilterEnabled"           : false,
		         "fileName"                     : "gridExport"
		     },
		     "sorting": 
		     {
		        "mode"                          : "multiple"
		     },
		     "remoteOperations":                  
		     {
		         "filtering"                    : false,
		         "grouping"                     : false,
		         "paging"                       : false,
		         "sorting"                      : false,
		         "summary"                      : false
		     },
		     "editing":                  
		     {
		         "mode"                         : "batch",
		         "allowUpdating"                : false,
		         "allowAdding"                  : false,
		         "allowDeleting"                : false
		     },
		     "filterRow": {"visible"            : false},
		     "rowAlternationEnabled"            : false,
		     "columnFixing": {"enabled"         : true},
		     pager: {
		         visible: true,
		         showNavigationButtons: true,
		         showInfo: true
		     },
		     paging: {
		         enabled: true,
		         pageSize: 20
		     },
		     scrolling: {
		         mode: "standard",
		         preloadEnabled: false
		     },
		     "searchPanel":                  
		     {
		         "visible"                      : false,
		         "width"                        : 250
		     },
		     onContentReady: function (e) 
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
		     "selection":                  
		     {
		         "allowSelectAll"               : true,
		         "deferred"                     : false,
		         "mode"                         : "multiple",
		         "selectAllMode"                : "allPages",
		         "showCheckBoxesMode"           : "onClick"
		     },
		     "columns":                  
		     [
		         {
		             "dataField"                : "CNT",
		             "caption"                  : '${msgel.getMsg("RBA_50_05_04_007","순번")}',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		              width                     : "9%"
		         },
		         {
		             "dataField"                : "LOSC_FILE_NM",
		             "caption"                  : '${msgel.getMsg("RBA_50_01_01_01_100","첨부파일명")}',
		             "cssClass"                 : "link",
		             "alignment"                : "left",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		              width                     : "32%"
		         },
		         {
		             "dataField"                : "DR_DT",
		             "caption"                  : '${msgel.getMsg("RBA_50_05_01_106","변경일자")}',
		             "cellTemplate"             : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		              width                     : "20%"
		         },
		         {
		             "dataField"                : "REG_NM",
		             "caption"                  : '${msgel.getMsg("RBA_50_05_01_107","변경자")}',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		              width                     : "20%"
		         },
		         {
		             "dataField"                : "ATTCH_FILE_NO",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         },
		         {
		             "dataField"                : "FILE_SER",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         },
		         {
		             "dataField"                : "PHSC_FILE_NM",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         },
		         {
		             "dataField"                : "RPT_GJDT",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         }, 
		         {
		             "dataField"                : "FILE_SER",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         }, 
		         {
		             "dataField"                : "FILE_POS",
		             "caption"                  : 'null',
		             "alignment"                : "center",
		             "allowResizing"            : true,
		             "allowSearch"              : true,
		             "allowSorting"             : true,
		             "visible"                  : false
		         }
		     ],
		     "onCellClick": function(e)
		     {
		        if(e.data )
		        {            
		        Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		        }
		     }
        }).dxDataGrid("instance");
    }
    
    //수기평가저장
    function doSave(){
        /*최근 형가일정인지 체크  */

        if(getRadioValue("RSK_VALT_PNT") == ""){
            showAlert('${msgel.getMsg("RBA_50_05_01_018","총위험 평가점수를 선택 하세요.")}','WARN');
            return false;
        }

        showConfirm('<fmt:message key="AML_10_14_01_01_003" initVal="처리하시겠습니까?"/>', "처리",function(){
        	 var rowsData     = GridObj1.getSelectedRowsData(); 
             var pageID      = "RBA_50_05_01_03";
             var classID     = "RBA_50_05_01_03";
             var methodID    = "doSave";
             var GUBN = form2.GUBN.value;
             var gridCnt = GridObj2.getDataSource().items();
             var gridCntt = gridCnt.length;
             if(gridCnt > 0){
                 GUBN = "1";
             }
             
             var params   = new Object();
          	var methodID = methodID;
          	var classID  = "RBA_50_05_01_03";
          	 		
          	params.pageID 	= "RBA_50_05_01_03";
          	params.BAS_YYMM         = form.BAS_YYMM.value;
          	params.PROC_FLD_C       = form2.PROC_FLD_C.value;
          	params.PROC_LGDV_C      = form2.PROC_LGDV_C.value;
          	params.PROC_MDDV_C      = form2.PROC_MDDV_C.value;
          	params.PROC_SMDV_C      = form2.PROC_SMDV_C.value;
          	params.VALT_BRNO        = form2.VALT_BRNO.value;
          	params.GUBN             = GUBN;
          	params.RSK_VALT_PNT     = getRadioValue("RSK_VALT_PNT");
          	params.gridData 		= rowsData
          	
          	sendService(classID, methodID, params, appro_end, appro_end); 
          	
     });
    }

    function closePop() {

        var gridCnt = GridObj2.totalCount();

        if(""=="${RSK_VALT_PNT}" && gridCnt>0 ) {
        	
            var classID  = "RBA_50_05_01_03"; 
            var methodID = "doDelete";
            var params = new Object();
            params.pageID         = "RBA_50_05_01_03";
            params.BAS_YYMM         = form.BAS_YYMM.value;
            params.PROC_FLD_C       = form2.PROC_FLD_C.value;
            params.PROC_LGDV_C      = form2.PROC_LGDV_C.value;
            params.PROC_MDDV_C      = form2.PROC_MDDV_C.value;
            params.PROC_SMDV_C      = form2.PROC_SMDV_C.value;
            params.VALT_BRNO        = form2.VALT_BRNO.value;
            
            sendService(classID, methodID, params, appro_end, appro_end);

        } else{
            appro_end();
        }
    }
    
    // 일정수정 팝업 close
    function appro_end() {
        $("button[id='btn_01']").prop('disabled', false);
        var VALT_BRNO = form2.VALT_BRNO.value
        opener.doSearch2("pop",VALT_BRNO);
        window.close();
    }
    
    function getRadioValue(onm){
        robj = document.form[onm];
        for(i=0;i<robj.length;i++){
            if(robj[i].checked==true) {
                return robj[i].value;
            }
        }
        return "";
    }

    function chkCommValidation(CHK_GUBN){

        var callbackfunc = "chkMaxBasYYMM_end";
        var actionName = "com.gtone.rba.common.action.CommonValidationCheckAction";
        var paramdata = new Object();
        paramdata.BAS_YYMM = form.BAS_YYMM.value;
        paramdata.CHK_GUBN = CHK_GUBN;

        if(chkValidationSync(actionName,paramdata,callbackfunc)){
            return true;
        }else {
            return false;
        }
    }
    
    function doSearch2(){
        if(GridObj2==null) {
           return;
        }

        GridObj2.clearSelection();
        GridObj2.option('dataSource', []);
        
        var classID		= "RBA_50_05_01_03";
    	var methodID	= "getSearchF";
    	var params = new Object();
    	
      	params.pageID 		= "RBA_50_05_01_03";
    	params.BAS_YYMM 	= form.BAS_YYMM.value;
    	params.VALT_BRNO 	= form2.VALT_BRNO.value;
    	params.PROC_SMDV_C 	= form2.PROC_SMDV_C.value;
    
    	sendService(classID, methodID, params, doSearch_end2, doSearch_end2);

     }

     function doSearch_end2(gridData, data){
    	 
         overlay.hide();
         GridObj2.refresh();
         GridObj2.option("dataSource",gridData);
     }

    //첨부파일
    function Grid2CellClick(id, GridObj2, selectData, rowIdx, colIdx, colId) {

        if (colId == "LOSC_FILE_NM") {
           downloadFile(GridObj2);
        }
    }
    
    function downloadFile(obj){
    	$("#downFileName").val(obj.PHSC_FILE_NM);
     	$("#orgFileName").val(obj.LOSC_FILE_NM); 	
     	$("#downFilePath").val(obj.FILE_POS);
     	$("#FILE_SEQ").val(obj.FILE_SER);
     	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
     	$("#fileFrm").submit();
    }
    
    function Filesave_OpenPop() {

        var form2            = document.form2;
        form2.pageID.value   = "RBA_50_05_01_04";
        form2.methodID.value = "getSearchF";
        form2.classID.value  = "RBA_50_05_01_03";
        form2.BAS_YYMM.value = form.BAS_YYMM.value
        form2.P_BAS_YYMM.value = form.BAS_YYMM.value
        form2.RSK_VALT_PNT.value = getRadioValue("RSK_VALT_PNT");
        var win;         win = window_popup_open(form2, 700,365, '');
        form2.target         = form2.pageID.value;
        form2.action         = '<c:url value="/"/>0001.do';
        form2.submit();
    }

    function doFileDelete() {

        var selectedRows  = GridObj2.getSelectedRowsData();
        var selectedHead  = GridObj2.getSelectedRowsData()[0];
        var selSize       = selectedRows.length;

        if(selSize == 0){
              showAlert('${msgel.getMsg("dataDeleteSelect","삭제할 데이타를 선택하십시오.")}','WARN');
              return;
          }
        
        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

            var params   = new Object();
         	var methodID = "doFileDelete";
         	var classID  = "RBA_50_01_01_01";
         	 		
         	params.pageID 		 = "RBA_10_05_01_01";
         	params.ATTCH_FILE_NO = selectedHead.ATTCH_FILE_NO;
         	params.FILE_SER      = selectedHead.FILE_SER;
         	params.BAS_YYMM      = form.BAS_YYMM.value;
         	params.gridData 	 = selectedRows; 
         	
    	sendService(classID, methodID, params, doSearch2, doSearch2); 
        });
    }

    function onlyNumber(obj){
        var val = obj.value;
        var len = val.length;
        var rt_val = "";

        for(var i = 0; i < len ; i++){
            var chr = val.charAt(i);
            var ch = chr.charCodeAt();

            if(ch < 48 || ch > 57 ) {
                rt_val = rt_val;
            }else{
                rt_val = rt_val + chr;
            }
        }
        obj.value = rt_val;
        obj.focus();
    }

</script>
 <form name="fileFrm" id="fileFrm" method="POST">
<input type="hidden" name="downFileName" id="downFileName" value="" />
<input type="hidden" name="orgFileName" id="orgFileName" value="" />
<input type="hidden" name="downFilePath" id="downFilePath" value="" />
<input type="hidden" name="downType" id="downType" value="RBA" />
<input type="hidden" name="FILE_SEQ" 	id="FILE_SEQ" value= ""/>
</form> 
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="PROC_FLD_C" value="${PROC_FLD_C}">
    <input type="hidden" name="PROC_LGDV_C" value="${PROC_LGDV_C}">
    <input type="hidden" name="PROC_MDDV_C" value="${PROC_MDDV_C}">
    <input type="hidden" name="PROC_SMDV_C" value="${PROC_SMDV_C}">
    <input type="hidden" name="VALT_BRNO" value="${VALT_BRNO}">
    <input type="hidden" name="GUBN" value="${P_GUBN}">
    <input type="hidden" name="P_BAS_YYMM">           <!-- 기준년월   -->
    <input type="hidden" name="RSK_VALT_PNT" value="${RSK_VALT_PNT}">
    <input type="hidden" name="ATTCH_FILE_NO" value="${ATTCH_FILE_NO}" >
    <input type="hidden" name="FILE_SER" >
    <input type="hidden" name="BAS_YYMM">           <!-- 기준년월   -->
</form>
<form name="form">
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
	<div class="panel panel-primary">
    	<div class="panel-footer" >
        	<div class="table-box">
            	<table class="basic-table">
              		<colgroup>
            		<col width="">
            		<col width="">
            		<col width="">
            		<col width="">
          			</colgroup>
          			<tbody>
                		<tr>
                    		<th class="title" width="10%"  style="text-align:left;">${msgel.getMsg('RBA_50_01_02_001','평가기준월')}</th>
                    		<td width="20%" align="left"> <input type="text" class="cond-input-text" name="BAS_YYMM" value="${BAS_YYMM}" style="border: 0px;" readonly="readonly"/></td>
                      		<th class="title" width="15%"  style="text-align:left;">${msgel.getMsg('RBA_50_05_01_019','부점명')}</th>
                      		<td width="25%" align="left">  <input type="text" class="cond-input-text" name="VALT_BRNM" value="${VALT_BRNM}" style="border: 0px;" readonly="readonly"/></td>
                  		</tr>
                  		<tr>
                      		<th class="title" width="15%" style="text-align:left;">${msgel.getMsg('RBA_50_05_01_020','대분류')}</th>
                      		<td width="25%" align="left" colspan="3">
                          		<input type="text" class="cond-input-text" name="PROC_LGDV_NM" value="${PROC_LGDV_NM}" style="border: 0px;" readonly="readonly"/>
                      		</td>
                  		</tr>
                  		<tr>
                      		<th class="title" width="15%"  style="text-align:left;">${msgel.getMsg('RBA_50_05_01_021','중분류')}</th>
                      		<td width="25%" align="left" colspan="3">
                          		<input type="text" class="cond-input-text" name="PROC_MDDV_NM" value="${PROC_MDDV_NM}" style="border: 0px;" readonly="readonly"/>
                      		</td>
                  		</tr>
                  		<tr>
                      		<th class="title" width="15%"  style="text-align:left;">${msgel.getMsg('RBA_50_05_01_022','소분류')}</th>
                      		<td width="25%" align="left" colspan="3">
                          		<input type="text" class="cond-input-text" name=PROC_SMDV_NM value="${PROC_SMDV_NM}" style="border: 0px;" readonly="readonly" />
                      		</td>
                  		</tr>
                  	</tbody>
               </table>
            </div>
        </div>

	   	<div class="panel-footer" >
		
			<div class="" style="margin-top: 8px; display: flex;">
				<div class="table-title" style="margin-right: auto; display: inline; vertical-align: middle; margin-top: auto;">${msgel.getMsg('RBA_50_01_01_238','고객확인 및 Due Diligence 관련 서류 업로드')}</div>
				<div class="btn-area" style="margin-left: auto; text-align: right; display: inline;">   
	            	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"attchFileBtn", defaultValue:"첨부파일", mode:"C", function:"Filesave_OpenPop", cssClass:"btn-36"}')}
	            	${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doFileDelete", cssClass:"btn-36"}')}
	            </div>
			</div>
            <div id="GTDataGrid2_Area" style="margin-top: 8px;"></div>
           	<div align="left">
                <p style="color:blue; font-size:13px; margin-top: 3px;">
                      	${msgel.getMsg('RBA_50_01_01_239','※ 파일첨부시 개인신용정보 보호를위해 주민등록번호, 사업자등록번호, 연락처등은 삭제 또는 마스킹 처리 후 첨부하시기 바랍니다.')}
                </p>
            </div>

            <div class="table-title" style="margin-top: 8px; margin-bottom: 8px;">
            	${msgel.getMsg('RBA_50_05_01_023','총위험 평가점수 선택')}
            </div>
            <div class="table-box">
                <table class="basic-table">
                  <tr>
                      <td width="25%" align="left" colspan="3">
                        <div style="text-align: center;">
                            <b style="color: blue; margin-right:40px; vertical-align: middle; ">${msgel.getMsg('RBA_50_05_01_024','저위험')}</b>
                            <div class="radio-list">
                            	<div class="radio-item">
                            		<input class="input" type="radio" id="radio10" name="RSK_VALT_PNT" value="10" ${"10".equals(RSK_VALT_PNT) ? "checked" : ""}>
                            		<label for="radio10"></label>
                            	</div>
                            	<div class="radio-item">
                            		<input class="input" type="radio" id="radio30" name="RSK_VALT_PNT" value="30" ${"30".equals(RSK_VALT_PNT) ? "checked" : ""}>
                            		<label for="radio30"></label>
                            	</div>
                            	<div class="radio-item">
                            		<input class="input" type="radio" id="radio50" name="RSK_VALT_PNT" value="50" ${"50".equals(RSK_VALT_PNT) ? "checked" : ""}>
                            		<label for="radio50"></label>
                            	</div>
                            	<div class="radio-item">
                            		<input class="input" type="radio" id="radio70" name="RSK_VALT_PNT" value="70" ${"70".equals(RSK_VALT_PNT) ? "checked" : ""}>
                            		<label for="radio70"></label>
                            	</div>
                            	<div class="radio-item">
                            		<input class="input" type="radio" id="radio90" name="RSK_VALT_PNT" value="90" ${"90".equals(RSK_VALT_PNT) ? "checked" : ""}>
                            		<label for="radio90"></label>
                            	</div>
                        	</div>
                            <b style="color: blue; margin-left: 31px;  vertical-align: middle;">${msgel.getMsg('RBA_50_05_01_025','고위험')}</b>
	                        <div style="text-align: center; margin-top : 3px; ">
	                            <span ><b style="color: blue;">10</b></span>
	                            <span style="margin-left: 25px;"><b style="color: blue;">30</b></span>
	                            <span style="margin-left: 25px;"><b style="color: blue;">50</b></span>
	                            <span style="margin-left: 25px;"><b style="color: blue;">70</b></span>
	                            <span style="margin-left: 25px; margin-right: 1px; "><b style="color: blue;">90</b></span>
	                        </div>
                       </div>
                      </td>
                  </tr>
               </table>
            </div>
            
        
        <div class="table-box" style="margin-top: 8px;" >
            <table class="grid-table one-row">
            	<thead class="table-head">
                	<tr>
                    	<th style="text-align: left;">${msgel.getMsg('RBA_50_05_01_026','평가기준 예시')}</th>
                	</tr>
                </thead>
                <tbody>
                	<tr>
                		<td>
                    		<div style="float: left;"><b style="color: blue;">90${msgel.getMsg('RBA_50_05_01_036','점')}</b>&nbsp;&nbsp; => &nbsp;&nbsp;*${msgel.getMsg('RBA_50_05_01_027','평가기간 동안 부점 내에서 매우 빈번하게 발생하는 거래 (예: 일 거래량 빈번) ')}</div>
                    		<div style=" float: right;">*${msgel.getMsg('RBA_50_05_01_028','해당 업무로 발생하는 수익인 부점 전체 연간 영업수익의 50% 이상 비중 차지')}</div>
                 		</td>
                	</tr>
                	<tr>
                 		<td>
                    		<div style="float: left;"><b style="color: blue;">70${msgel.getMsg('RBA_50_05_01_036','점')}</b>&nbsp;&nbsp; => &nbsp;&nbsp;*${msgel.getMsg('RBA_50_05_01_029','평가기간 동안 부점 내에서 자주 발생한 거래(예: 일일 거래 발생)')}</div>
                    		<div style=" float: right;">*${msgel.getMsg('RBA_50_05_01_030','해당 업무로 발생하는 수익인 부점 전체 연간 영업수익의 20~50% 비중 차지')}</div>
                 		</td>
                	</tr>
                	<tr>
                 		<td>
                   			<div style="float: left;"><b style="color: blue;">50${msgel.getMsg('RBA_50_05_01_036','점')}</b>&nbsp;&nbsp; => &nbsp;&nbsp;*${msgel.getMsg('RBA_50_05_01_031','평가기간 동안 부점 내에서 종종 발생하는 거래(예: 월 거래 발생)')}</div>
                    		<div style=" float: right;">*${msgel.getMsg('RBA_50_05_01_032','해당 업무로 발생하는 수익인 부점 전체 연간 영업수익의 10~20% 비중 차지')}</div>
                 		</td>
               		</tr>
                	<tr>
                 		<td >
                    		<div style="float: left;"><b style="color: blue;">30${msgel.getMsg('RBA_50_05_01_036','점')}</b>&nbsp;&nbsp; => &nbsp;&nbsp;*${msgel.getMsg('RBA_50_05_01_037','평가기간 동안 거의 발생하지 않는 거래(예: 월 평균 거래량 1건 미만)')}</div>
                    		<div style=" float: right;">*${msgel.getMsg('RBA_50_05_01_033','해당 업무로 발생하는 수익이 부점 전체 연간 영업수익의 5~10% 미만 비중 차지')}</div>
                 		</td>
                	</tr>
                	<tr>
                 		<td>
                 			<div style="float: left;"><b style="color: blue;">10${msgel.getMsg('RBA_50_05_01_036','점')}</b>&nbsp;&nbsp; => &nbsp;&nbsp;*${msgel.getMsg('RBA_50_05_01_034','평가기간 동안  해당 거래 발생하지 않음')}</div>
                 			<div style=" float: right;">*${msgel.getMsg('RBA_50_05_01_035','해당 업무로 발생하는 수익이 부점 전체 연간 영업수익의 5% 미만 비중 차지')}</div>
                 		</td>
                	</tr>
                </tbody>
            </table>
        </div>
        <div style="margin-top: 8px">
            <table width="100%" border="0" >
                <tr>
                    <td>
                        <table border="0" align="right" class="btn_area">
                            <tr>
                                <td>
                                    ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave", cssClass:"btn-36"}')}
                                    ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"closePop", cssClass:"btn-36"}')}
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />