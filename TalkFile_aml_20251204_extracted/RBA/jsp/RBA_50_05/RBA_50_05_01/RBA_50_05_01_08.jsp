<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_01_08.jsp
* Description     : 고위험개선영역관리 결재 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : SBJ
* Since           : 2018-04-25
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%

String BAS_YYMM     = request.getParameter("BAS_YYMM");
String VALT_BRNO    = request.getParameter("VALT_BRNO");

String GYLJ_ID      = request.getParameter("GYLJ_ID");
String GYLJ_S_C     = request.getParameter("GYLJ_S_C");
String GYLJ_G_C 	= request.getParameter("GYLJ_G_C");
String FLAG 		= request.getParameter("FLAG");
String GYLJ_GUBN 	= request.getParameter("GYLJ_GUBN");

//out.println("GYLJ_MODE="+GYLJ_MODE);

String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
//String DEPT_CD = sessionAML.getsAML_BDPT_CD();

request.setAttribute("BAS_YYMM", BAS_YYMM);
request.setAttribute("VALT_BRNO", VALT_BRNO);

request.setAttribute("GYLJ_ID", GYLJ_ID);
request.setAttribute("GYLJ_S_C", GYLJ_S_C);
request.setAttribute("GYLJ_G_C",GYLJ_G_C);
request.setAttribute("ROLE_IDS",ROLE_IDS);
request.setAttribute("FLAG",FLAG);
request.setAttribute("GYLJ_GUBN",GYLJ_GUBN);


%>
<script language="JavaScript">
   
    var GridObj1;
    var classID = "RBA_50_05_01_08";
    
    // Initialize
    $(document).ready(function(){
        setupGrids();
        setInfo();
    });
    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
        // 그리드1(Code Head) 초기화
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
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
			    "rowAlternationEnabled": true,
			    "columnFixing": {"enabled": true},
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
    }
    
 // 결재요청자,결재상태 조회 end
    function setInfo(){
	    var GYLJ_S_C_NM = "";
	    var flag        = "${FLAG}";
	    
	    if(flag == "0"){
	        GYLJ_S_C_NM = "승인요청";
	    }else if(flag == "1"){
	        GYLJ_S_C_NM = "반려";
	    }else if(flag == "2"){
	        GYLJ_S_C_NM = "승인";
	    }
	    $("#GYLJ_S_C_NM").text(GYLJ_S_C_NM);
	    
	    if(flag=="0") {
	    	$("#REQ_JKW_NM").text("${USER_NAME}");
	    }else {
	    	$("#REQ_JKW_NM").text("${USER_NAME}");	
	    }
            
    }
    
    // 결재상태 요청자 조회
    function doSearch(){
        var classID  = "RBA_50_05_01_08"; 
        var methodID = "doSearch";
        var params = new Object();
        params.BAS_YYYY		= form.RBA_BAS_YYYY.value;
        params.VALT_BRNO	= form.RBA_VALT_BRNO.value;
        
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }
    
    // 결재상태 요청자 조회 end
    function doSearch_success(gridData, data){
        try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
   		} catch (e) {
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
    
    function doSearch_fail(){
    	 overlay.hide();
    }
    
    // 결재 저장
    function doSave1() {
    	
        var GYLJ_FLAG = "${FLAG}";
        var GYLJ_S_C  = "";
        //결재상태 구분코드   21:	승인요청 22:반려  3: 완료
        
        if(GYLJ_FLAG == "0"){
            showConfirm("${msgel.getMsg('RBA_50_03_02_022','승인요청 하시겠습니까?')}", "승인",function(){
            	 GYLJ_S_C = "21";
            	apprAction(GYLJ_S_C,GYLJ_FLAG);
            });
        } else if(GYLJ_FLAG == "1"){
            if(form.NOTE_CTNT.value == ""){
            	showAlert('${msgel.getMsg("RBA_50_03_02_023","반려 시 사유입력은 필수입니다.")}','WARN');
                return;
            }
            showConfirm("${msgel.getMsg('RBA_50_03_02_024','반려하시겠습니까?')}", "반려",function(){
	           	 GYLJ_S_C = "22";
	           	apprAction(GYLJ_S_C,GYLJ_FLAG);
           });
        }else if(GYLJ_FLAG == "2"){
            showConfirm("${msgel.getMsg('RBA_50_03_02_025','반려하시겠습니까?')}", "반려",function(){
	           	 GYLJ_S_C = "3";
	           	apprAction(GYLJ_S_C,GYLJ_FLAG);
          });
        }
        
        
        

    }
    
    function apprAction(GYLJ_S_C,GYLJ_FLAG){
    	
    	if("${GYLJ_GUBN}" == "MLTF"){
    		methodID = "doSave";
    	}else{
    		methodID = "doSave2";
    	}
    	
    	var params   = new Object();
     	var methodID = methodID;
     	var classID  = "RBA_50_05_01_08";
     	 		
     	params.pageID 	= "RBA_50_05_01_08";
     	params.BAS_YYMM          = "${BAS_YYMM}";
     	params.VALT_BRNO   		= "${VALT_BRNO}";
     	params.GYLJ_ID           = "${GYLJ_ID}";
     	params.NOTE_CTNT         = $("#NOTE_CTNT").val();
     	params.GYLJ_FLAG         = GYLJ_FLAG;
     	params.GYLJ_S_C			= GYLJ_S_C;
     	params.GYLJ_G_C			= "${GYLJ_G_C}";
     	
     	sendService(classID, methodID, params, doSave_end, doSave_end); 
    }
    
    // 결재 저장 end
    function doSave_end(){
        window.close();
        refreshApprovalCount();
        opener.doSearch();
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
                       <th class="title">${msgel.getMsg('RBA_50_02_02_04_100','결재단계')}</th>
                       <td class="content"><span id="GYLJ_S_C_NM" class="font_s"></span></td>
                       
                       <th class="title">${msgel.getMsg('RBA_50_01_01_240','요청자')}</th>
                       <td class="content"><span id="REQ_JKW_NM" class="font_s"></span></td>
                   </tr>
                   <tr>
                       <th class="title">${msgel.getMsg('RBA_50_01_01_241','사유')}</th>
                       <td class="content" colspan="3">
                           <textarea id="NOTE_CTNT" name="NOTE_CTNT" class="textarea-box" maxlength="2000" style="height:100px; vertical-align: middle; "></textarea>
                       </td>
                   </tr>
               </table>
           </div>
       </div>
     	<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px; ">
             ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave1", cssClass:"btn-36"}')}
             ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
       </div>
   </div>
   <div class="panel panel-primary" style="display: none">
       <div class="panel-footer" >
           <div id="GTDataGrid1_Area"></div>
       </div>
   </div>
   
    
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 