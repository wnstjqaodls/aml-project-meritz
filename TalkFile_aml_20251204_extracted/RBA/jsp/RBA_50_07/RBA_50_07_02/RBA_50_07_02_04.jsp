<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_07_02_04.jsp
* Description     : 고위험개선영역관리 결재 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : SBJ
* Since           : 2018-04-25
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
   

String BAS_YYMM     = request.getParameter("BAS_YYMM");
String PROC_FLD_C   = request.getParameter("PROC_FLD_C");
String PROC_LGDV_C  = request.getParameter("PROC_LGDV_C");
String PROC_MDDV_C  = request.getParameter("PROC_MDDV_C");
String PROC_SMDV_C  = request.getParameter("PROC_SMDV_C");
String VALT_BRNO    = request.getParameter("VALT_BRNO");
String GYLJ_ID      = request.getParameter("GYLJ_ID");
String GYLJ_S_C     = request.getParameter("GYLJ_S_C");
String GYLJ_JKW_NM  = sessionAML.getsAML_USER_NAME();

String FLAG = request.getParameter("FLAG");
String GYLJ_G_C = request.getParameter("GYLJ_G_C");
String GYLJ_MODE = request.getParameter("GYLJ_MODE");


//out.println("GYLJ_MODE="+GYLJ_MODE);

String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
String DEPT_CD = sessionAML.getsAML_BDPT_CD();

request.setAttribute("BAS_YYMM", BAS_YYMM);
request.setAttribute("PROC_FLD_C"     , PROC_FLD_C);         //영역코드
request.setAttribute("PROC_LGDV_C"    , PROC_LGDV_C);        //대분류코드
request.setAttribute("PROC_MDDV_C"    , PROC_MDDV_C);        //중분류코드
request.setAttribute("PROC_SMDV_C"    , PROC_SMDV_C);        //소분류코드
request.setAttribute("VALT_BRNO", VALT_BRNO);

request.setAttribute("GYLJ_ID", GYLJ_ID);
request.setAttribute("GYLJ_S_C", GYLJ_S_C);
request.setAttribute("GYLJ_JKW_NM", GYLJ_JKW_NM);
request.setAttribute("ROLE_IDS",ROLE_IDS);
request.setAttribute("DEPT_CD",DEPT_CD);
request.setAttribute("FLAG",FLAG);
request.setAttribute("GYLJ_G_C",GYLJ_G_C);
request.setAttribute("GYLJ_MODE",GYLJ_MODE);

/*
out.println("BAS_YYMM="+BAS_YYMM);
out.println("PROC_FLD_C="+PROC_FLD_C);	
out.println("PROC_LGDV_C="+PROC_LGDV_C);	
out.println("PROC_MDDV_C="+PROC_MDDV_C);	
out.println("PROC_SMDV_C="+PROC_SMDV_C);	
out.println("VALT_BRNO="+VALT_BRNO);	
out.println("FLAG="+FLAG);	
*/


%>
<script language="JavaScript">
   
    var GridObj1;
    var classID = "RBA_50_07_02_04";
    
    // Initialize
    $(document).ready(function(){
        setupGrids();
    });
    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 height	:"calc(90vh - 100px)",
			 "hoverStateEnabled": true,
			    "wordWrapEnabled": false,
			    "allowColumnResizing": true,
			    "columnAutoWidth": true,
			    "allowColumnReordering": true,
			    "cacheEnabled": false,
			    "cellHintEnabled": true,
			    "showBorders": true,
			    "showColumnLines": true,
			    "showRowLines": true,
			    "loadPanel" : { enabled: false },
			    "export":                  {
			        "allowExportSelectedData": true,
			        "enabled": false,
			        "excelFilterEnabled": true,
			        "fileName": "gridExport"
			    },
			    "sorting": {"mode": "multiple"},
			    "remoteOperations":                  {
			        "filtering": false,
			        "grouping": false,
			        "paging": false,
			        "sorting": false,
			        "summary": false
			    },
			    "editing":                  {
			        "mode": "batch",
			        "allowUpdating": false,
			        "allowAdding": true,
			        "allowDeleting": false
			    },
			    "filterRow": {"visible": false},
			    "rowAlternationEnabled": true,
			    "columnFixing": {"enabled": true},
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
			    "searchPanel":                  {
			        "visible": false,
			        "width": 250
			    },
			    "selection":                  {
			        "allowSelectAll": true,
			        "deferred": false,
			        "mode": "single",
			        "selectAllMode": "allPages",
			        "showCheckBoxesMode": "onClick"
			    },
			    "columns":[
			    
			            {
				            "dataField": "BAS_YYMM",
				            "caption": '${msgel.getMsg("RBA_50_08_07_001","기준년월")}',
				            "visible": false,
				            "alignment": "right",
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        	}
			        
			    ],
			     onCellPrepared       : function(e){
			        var columnName = e.column.dataField;
			        var dataGrid   = e.component;
			        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
			        var remdrRskGdcNm1       = dataGrid.cellValue(rowIndex, 'REMDR_RSK_GD_C_NM1');
			        if(rowIndex != -1){
			                if((remdrRskGdcNm1 =='Yellow') && (columnName == 'REMDR_RSK_GD_C_NM1')){
			                    e.cellElement.css('background-color', '#FFFF00');
			                }
			        }
			    },
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
       }).dxDataGrid("instance");	
        setInfo();
    }
    
 // 결재요청자,결재상태 조회 end
    function setInfo(){
	    var GYLJ_S_C_NM = "";
	    var flag        = "${FLAG}";
	    
	    if(flag == "0"){
	        GYLJ_S_C_NM = '${msgel.getMsg("RBA_50_01_01_234","승인요청")}';
	    }else if(flag == "1"){
	        GYLJ_S_C_NM = '${msgel.getMsg("RBA_50_01_01_235","반려")}';
	    }else if(flag == "2"){
	        GYLJ_S_C_NM = '${msgel.getMsg("RBA_50_01_01_236","승인")}';
	    }
	    $("#GYLJ_S_C_NM").text(GYLJ_S_C_NM);
	    
	    if(flag=="0") {
	    	$("#REQ_JKW_NM").text("${GYLJ_JKW_NM}");
	    }else {
	    	$("#REQ_JKW_NM").text("${GYLJ_JKW_NM}");	
	    }
            
    }
    
    // 결재상태 요청자 조회
    function doSearch(){
        
        var params   = new Object();
    	var methodID = "doSearch";
    	var classID  = "RBA_50_07_02_04";
    	 		
    	params.pageID 	= "RBA_50_07_02_04";
    	params.BAS_YYYY          = form.RBA_BAS_YYYY.value;
    	params.TONGJE_OPR_VALT_ID= form.RBA_TONGJE_OPR_VALT_ID.value;
    	params.VALT_TRN          = form.RBA_VALT_TRN.value;
    	params.VALT_BRNO         = form.RBA_VALT_BRNO.value;

    	sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
    }
    
    // 결재상태 요청자 조회 end
    function doSearch_success(gridData, data){
        
        var gridCnt = gridData.length;
        
        if(gridCnt > 0) {
            
            var GYLJ_S_C_NM = "";
            var flag        = form.RBA_FLAG.value;
            var selObj      = GridObj1.getSelectedRowsData()[0];
            
    	    if(flag == "0"){
    	        GYLJ_S_C_NM = '${msgel.getMsg("RBA_50_01_01_234","승인요청")}';
    	    }else if(flag == "1"){
    	        GYLJ_S_C_NM = '${msgel.getMsg("RBA_50_01_01_235","반려")}';
    	    }else if(flag == "2"){
    	        GYLJ_S_C_NM = '${msgel.getMsg("RBA_50_01_01_236","승인")}';
    	    }
            
            jQuery("#GYLJ_S_C_NM").text(GYLJ_S_C_NM);
            jQuery("#REQ_JKW_NM").text(selObj.REQ_JKW_NM);
        }
    }
    
    //결재저장
    function doSave() {
    	 
    	var GYLJ_MODE = "${GYLJ_MODE}";
    
    	if(GYLJ_MODE=="M"){ //일괄결재
    		doSave2();
    	} else { //단일결재건
    		doSave1();
    	}
    	
    }
    
    // 결재 저장
    function doSave1() {
        
        var GYLJ_FLAG = "${FLAG}";
        var GYLJ_S_C = "";//결재상태 구분코드   21:	승인요청 22:반려  3: 완료
        var msgTxt = "";
        if(GYLJ_FLAG == "0"){
        	msgTxt = '${msgel.getMsg("RBA_50_03_02_022","승인요청 하시겠습니까?")}'
            GYLJ_S_C = "21";
        } else if(GYLJ_FLAG == "1"){
            if(form.NOTE_CTNT.value == ""){
            	showAlert('${msgel.getMsg("RBA_50_03_02_023","반려 시 사유입력은 필수입니다.")}','WARN');
                return;
            }
            msgTxt = '${msgel.getMsg("RBA_50_03_02_024","반려하시겠습니까?")}'
            GYLJ_S_C = "22";
        }else if(GYLJ_FLAG == "2"){
        	msgTxt = '${msgel.getMsg("RBA_50_03_02_025","반려하시겠습니까?")}'
            GYLJ_S_C = "3";
        }
        
        showConfirm(msgTxt, "저장", function(){doSave1Action(GYLJ_S_C);});
    }
    
    function doSave1Action(GYLJ_S_C) {
    	var params   = new Object();
    	var methodID = "doSave";
    	var classID  = "RBA_50_07_02_04";
    	 		
    	params.pageID 		= "RBA_50_07_02_04";
    	params.BAS_YYMM          = "${BAS_YYMM}";
    	params.PROC_FLD_C  = "${PROC_FLD_C}";
    	params.PROC_LGDV_C = "${PROC_LGDV_C}";
    	params.PROC_MDDV_C = "${PROC_MDDV_C}";
    	params.PROC_SMDV_C = "${PROC_SMDV_C}";
    	params.VALT_BRNO   = "${VALT_BRNO}";
    	params.GYLJ_ID           = "${GYLJ_ID}";
    	params.NOTE_CTNT         = $("#NOTE_CTNT").val();
    	params.GYLJ_FLAG         = GYLJ_FLAG;
    	params.GYLJ_S_C			= GYLJ_S_C;
    	params.GYLJ_G_C			= "${GYLJ_G_C}";
    	
    	sendService(classID, methodID, params, doSave_end, doSave_end); 
    }
    
    // 결재 저장
    function doSave2() {
    	
    	var GYLJ_FLAG = "${FLAG}";
        var GYLJ_S_C = "";//결재상태 구분코드   21:진행중  22:반려  3: 완료
        
        if(GYLJ_FLAG == "0"){
            msgTxt = '${msgel.getMsg("RBA_50_03_02_022","승인요청 하시겠습니까?")}';
            GYLJ_S_C = "21";
        }else if(GYLJ_FLAG == "1"){
            if(form.NOTE_CTNT.value == ""){
            	showAlert('${msgel.getMsg("RBA_50_03_02_023","반려 시 사유입력은 필수입니다.")}','WARN');
                return;
            }
            msgTxt = '${msgel.getMsg("RBA_50_03_02_024","반려하시겠습니까")}';
            GYLJ_S_C = "22";
        }else if(GYLJ_FLAG == "2"){
        	msgTxt = '${msgel.getMsg("RBA_50_03_02_025","반려하시겠습니까")}';
            GYLJ_S_C = "3";
        }
        showConfirm(msgTxt, "저장", function(){doSave2Action(GYLJ_S_C);});
    }
    
    function doSave2Action(GYLJ_FLAG) {
    	opener.doApprove("${GYLJ_S_C}",GYLJ_FLAG,$("#NOTE_CTNT").val());
    	close();
    }
    
    // 결재 저장 end
    function doSave_end(){
        window.close();
        opener.window.close();
        opener.opener.doSearch();
    }
    
</script>

<form name="form" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
                <table class="basic-table">
                    <tr>
                        <th class="title">${msgel.getMsg("RBA_50_02_02_04_100","결재단계")}</th>
                        <td class="content"><span id="GYLJ_S_C_NM" class="font_s"></span></td>
                        <th class="title">${msgel.getMsg("RBA_50_01_01_240","요청자")}</th>
                        <td width="30%"><span id="REQ_JKW_NM" class="font_s"></span></td>
                    </tr>
                    <tr>
                        <th class="title">${msgel.getMsg("RBA_50_01_01_241","사유")}</th>
                        <td colspan="3">
                            <textarea id="NOTE_CTNT" name="NOTE_CTNT" class="textarea-box" maxlength="2000" style="height:100px; vertical-align: middle;"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
   	<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
    </div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 