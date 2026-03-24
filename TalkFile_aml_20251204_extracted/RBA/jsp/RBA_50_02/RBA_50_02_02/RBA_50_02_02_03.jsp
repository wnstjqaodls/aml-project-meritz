<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_02_02_03.jsp
* Description     : 프로세스 결재 요청팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-04
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%

    String BAS_YYMM = request.getParameter("BAS_YYMM");
    String VALT_BRNO = request.getParameter("VALT_BRNO");
    String GYLJ_ID = request.getParameter("GYLJ_ID");
    String GYLJ_S_C = request.getParameter("GYLJ_S_C");
    String GYLJ_JKW_NM = request.getParameter("GYLJ_JKW_NM");
    String FLAG = request.getParameter("FLAG");
    String GYLJ_G_C = request.getParameter("GYLJ_G_C");
    
    String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    String DEPT_CD = sessionAML.getsAML_BDPT_CD();
    
    request.setAttribute("BAS_YYMM", BAS_YYMM);
    request.setAttribute("VALT_BRNO", VALT_BRNO);
    request.setAttribute("GYLJ_ID", GYLJ_ID);
    request.setAttribute("GYLJ_S_C", GYLJ_S_C);
    request.setAttribute("GYLJ_JKW_NM", GYLJ_JKW_NM);
    request.setAttribute("ROLE_IDS",ROLE_IDS);
    request.setAttribute("DEPT_CD",DEPT_CD);
    request.setAttribute("FLAG",FLAG);
    request.setAttribute("GYLJ_G_C",GYLJ_G_C);
    
%>
<script language="JavaScript">
    
    var GridObj1;
    var classID = "RBA_50_02_02_03";
    
    // Initialize
    $(document).ready(function(){
        setupGrids();
        setInfo();
    });
    
    // Initial function
    function init(){
        initPage();
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
        // 그리드1(Code Head) 초기화
        
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 height	:"calc(90vh - 100px)",
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
			    sorting         : {mode: "multiple"},
			    remoteOperations: {
			        filtering: false,
			        grouping : false,
			        paging   : false,
			        sorting  : false,
			        summary  : false
			    },
			    editing: {
			        mode         : "batch",
			        allowUpdating: true,
			        allowAdding  : true,
			        allowDeleting: false
			    },
			    filterRow            : {visible: false},
			    rowAlternationEnabled: true,
			    columnFixing         : {enabled: true},
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
			    searchPanel          : {
			        visible: true,
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
			            dataField    : "BAS_YYMM",
			            caption      : '${msgel.getMsg("RBA_50_01_01_027","기준년월")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "RSK_CATG",
			            caption      : '${msgel.getMsg("RBA_50_02_02_03_100","위험CATEGORY")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "RSK_FAC",
			            caption      : '${msgel.getMsg("RBA_50_02_02_03_101","위험FACTOR")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "RSK_INDCT",
			            caption      : '${msgel.getMsg("RBA_50_02_02_03_102","위험INDICATOR")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "RSK_INDCT_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_02_03_103","위험INDICATOR명")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "GYLJ_S_C",
			            caption      : '${msgel.getMsg("RBA_50_02_02_03_104","결재상태코드")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "GYLJ_S_C_NM",
			            caption      : '결재상태명',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "REQ_JKW_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_02_03_105","요청직원명")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "GYLJ_ID",
			            caption      : '${msgel.getMsg("RBA_50_02_02_03_106","결재ID")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "GYLJ_DT",
			            caption      : '결재일자',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "GYLJ_ROLE_ID",
			            caption      : '결재ROLE_ID',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }
			    ]	 
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
	    	$("#GYLJ_JKW_NM").text("${USER_NAME}");
	    }else {
	    	$("#GYLJ_JKW_NM").text("${GYLJ_JKW_NM}");	
	    }
            
    }
    
    // 결재 저장
    function doSave() {
        
        var GYLJ_FLAG = "${FLAG}";
        var GYLJ_S_C = "";//결재상태 구분코드   21:	승인요청 22:반려  3: 완료
        
        if(GYLJ_FLAG == "0"){
        	showConfirm("${msgel.getMsg('RBA_50_03_02_022','승인요청 하시겠습니까?')}", "승인",function(){
	           	 GYLJ_S_C = "21";
	           	apprAction(GYLJ_S_C,GYLJ_FLAG);
	           });
        }else if(GYLJ_FLAG == "1"){
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
    	
    	var params   = new Object();
     	var methodID = "doSave";
     	var classID  = "RBA_50_02_02_03";
     	 		
     	params.pageID 	= "RBA_50_02_02_03";
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
                <table width="100%" class="hover">
                    <tr>
                        <th width="20%">${msgel.getMsg("AML_20_02_10_01_003","결재단계")}</th>
                        <td width="30%"><span id="GYLJ_S_C_NM" class="font_s"></span></td>
                        <th width="20%">${msgel.getMsg("AML_10_14_01_04_001","요청자")}</th>
                        <td width="30%"><span id="GYLJ_JKW_NM" class="font_s"></span></td>
                    </tr>
                    <tr>
                        <th>사유</td>
                        <td colspan="3">
                            <textarea id="NOTE_CTNT" name="NOTE_CTNT" maxlength="2000" rows=5 style="height: 150;IME-MODE: active;"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div align="right" style="margin-top: 10px">
            <span align="right">
                ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
                ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
            </span>
        <div>
    </div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 