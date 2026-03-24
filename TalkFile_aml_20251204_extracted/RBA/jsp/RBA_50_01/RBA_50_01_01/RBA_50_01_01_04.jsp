<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_01_04.jsp
* Description     : 종료처리
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-23
--%>
<%@ page import="java.text.ParseException" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp"%>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>

<%
String BAS_YYMM     = request.getParameter("P_BAS_YYMM");
String RBA_VALT_LGDV_C = request.getParameter("P_RBA_VALT_LGDV_C");
String RBA_VALT_SMDV_C           = request.getParameter("P_RBA_VALT_SMDV_C");
String RBA_VALT_LGDV_C_NM = request.getParameter("P_RBA_VALT_LGDV_C_NM");
String RBA_VALT_SMDV_C_NM           = request.getParameter("P_RBA_VALT_SMDV_C_NM");
String REAL_EDT           = request.getParameter("P_REAL_EDT");
String VALT_SDT           = request.getParameter("P_VALT_SDT");
String VALT_EDT           = request.getParameter("P_VALT_EDT");


try{
if("".equals(REAL_EDT)){
    REAL_EDT = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
}else{
	REAL_EDT = jspeed.base.util.DateHelper.format(REAL_EDT, "yyyyMMdd", "yyyy-MM-dd");
}

if("".equals(VALT_SDT)){
	VALT_SDT = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
}else{
	VALT_SDT = jspeed.base.util.DateHelper.format(VALT_SDT, "yyyyMMdd", "yyyy-MM-dd");
}

if("".equals(VALT_EDT)){
	VALT_EDT = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
}else{
	VALT_EDT = jspeed.base.util.DateHelper.format(VALT_EDT, "yyyyMMdd", "yyyy-MM-dd");
}
}catch(ParseException e){
	Log.logAML(Log.ERROR, e);
}

request.setAttribute("BAS_YYMM",BAS_YYMM);
request.setAttribute("RBA_VALT_LGDV_C",RBA_VALT_LGDV_C);
request.setAttribute("RBA_VALT_SMDV_C",RBA_VALT_SMDV_C);
request.setAttribute("RBA_VALT_LGDV_C_NM",RBA_VALT_LGDV_C_NM);
request.setAttribute("RBA_VALT_SMDV_C_NM",RBA_VALT_SMDV_C_NM);
request.setAttribute("REAL_EDT",REAL_EDT);               //대상종료일
request.setAttribute("VALT_SDT",VALT_SDT);
request.setAttribute("VALT_EDT",VALT_EDT);
%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>

<script language="JavaScript">

    var GridObj1;
    var classID = "RBA_50_01_01_01";
    
    // Initialize
    $(document).ready(function(){
        setupGrids();
    });
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
       /*  GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_01_01_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : '일정복사'
           ,completedEvent  : function(){
               setupGridFilter([GridObj1]);
              // doSearch1();
            }
        }); */
        

        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        			 height	:"calc(50vh - 50px)",
        				 hoverStateEnabled    : true,
        				    wordWrapEnabled      : false,
        				    allowColumnResizing  : true,
        				    columnAutoWidth      : false,
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
        				        var columnName         = e.column.dataField;
        				        var dataGrid           = e.component;
        				        var rowIndex           = dataGrid.getRowIndexByKey(e.key);
        				        var realEdt            = dataGrid.cellValue(rowIndex, 'REAL_EDT');
        				        var valtEdt            = dataGrid.cellValue(rowIndex, 'VALT_EDT');
        				        var rba_valt_smdv_c_nm = dataGrid.cellValue(rowIndex, 'RBA_VALT_SMDV_C_NM'); 
        				        if(rowIndex != -1){
        				            if(realEdt == ''){
        				                if((valtEdt !='') 
        				                && (columnName == 'RBA_VALT_LGDV_C_NM' 
        				                 || columnName == 'RBA_VALT_SMDV_C_NM' 
        				                 || columnName == 'VALT_SDT' 
        				                 || columnName == 'VALT_EDT'
        				                 || columnName == 'REAL_EDT' 
        				                 || columnName == 'ROWNUM' 
        				                 || columnName == 'EXP_TRM')){
        				                    e.cellElement.css('background-color', '#CEFBC9');
        				                }
        				            } 
        				            if((rba_valt_smdv_c_nm == '▶부점별 AML 업무 프로세스 관리 (TodoList 실행)') && (columnName == 'RBA_VALT_SMDV_C_NM')) { 
        				            	e.cellElement.css('color', '#FF4848');	
        				            }
        				            if((rba_valt_smdv_c_nm == '▶전사 AML 내부통제 점검항목 관리 (배치 STEP1)(매월)')  && (columnName == 'RBA_VALT_SMDV_C_NM')) { 
        				            	//e.cellElement.css('color', '#FF4848');	
        				            }
        				            if((rba_valt_smdv_c_nm == '▶ML/TF 총위험평가 (배치 STEP2)(반기or분기)') && (columnName == 'RBA_VALT_SMDV_C_NM')) { 
        				            	e.cellElement.css('color', '#FF4848');	
        				            }
        				            if((rba_valt_smdv_c_nm == '▶AML 통제평가 (배치 STEP3)(반기or분기)') && (columnName == 'RBA_VALT_SMDV_C_NM')) { 
        				            	e.cellElement.css('color', '#FF4848');	
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
        				        mode              : "multiple",
        				        selectAllMode     : "allPages",
        				        showCheckBoxesMode: "onClick"
        				    },
        				    columns: [
        				        {
        				            dataField    : "ROWNUM",
        				            caption      : '${msgel.getMsg("RBA_50_05_04_007","순번")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "60px",
        				            fixed        : true
        				        }, {
        				            dataField    : "RBA_VALT_LGDV_C",
        				            caption      : '${msgel.getMsg("RBA_50_04_01_001","대분류")}',
        				            alignment    : "left",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "100px",
        				            visible      : false
        				        }, {
        				            dataField    : "RBA_VALT_LGDV_C_NM",
        				            caption      : '${msgel.getMsg("RBA_50_04_01_001","대분류")}',
        				            alignment    : "left",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "160px",
        				            fixed        : true
        				        }, {
        				            dataField    : "RBA_VALT_SMDV_C",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_011","구분")}',
        				            alignment    : "left",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "50px",
        				            visible      : false
        				        }, {
        				            dataField    : "RBA_VALT_SMDV_C_NM",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_011","구분")}',
        				            alignment    : "left",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "350px",
        				            fixed        : true
        				        }, {
        				            dataField    : "EXP_TRM",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_100","예상소요시간(주)")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "100px"
        				        }, {
        				            dataField    : "VALT_SDT",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_016","업무시작일")}',
        				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "80px"
        				        }, {
        				            dataField    : "VALT_EDT",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_017","업무종료일")}',
        				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "80px"
        				        }, {
        				            dataField    : "REAL_EDT",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_015","배치처리일")}',
        				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "80px"
        				        }, {
        				            caption      : '${msgel.getMsg("RBA_50_05_01_101","대상거래")}',
        				            alignment    : "center",
        				            columns      : [
        				            	{            
        						            dataField    : "TGT_TRN_SDT",
        						            caption      : '${msgel.getMsg("RBA_50_05_01_102","시작일")}',
        						            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
        						            alignment    : "center",
        						            allowResizing: true,
        						            allowSearch  : true,
        						            allowSorting : true,
        						            width        : "110px"
        						        }, {
        						            dataField    : "TGT_TRN_EDT",
        						            caption      : '${msgel.getMsg("RBA_50_05_01_103","종료일")}',
        						            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
        						            alignment    : "center",
        						            allowResizing: true,
        						            allowSearch  : true,
        						            allowSorting : true,
        						            width        : "110px"
        						        }
        						    ]    
        					    }, {
        				            dataField    : "EXEC_B_BRNO_YN",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_104","AML주관부서")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "100px",
        				            visible      : false
        				        }, {
        				            dataField    : "EXEC_B_BRNO_YN_NM",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_104","AML주관부서")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "100px"
        				        }, {
        				            dataField    : "EXEC_S_BRNO_YN",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_105","현업부서")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "80px",
        				            visible      : false
        				        }, {
        				            dataField    : "EXEC_S_BRNO_YN_NM",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_105","현업부서")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "80px"
        				        }, {
        				            dataField    : "CHG_DT",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_106","변경일자")}',
        				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "80px"
        				        }, {
        				            dataField    : "CHG_OP_JKW_NO",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_107","변경자")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "7%"
        				        }, {
        				            dataField    : "FIX_YN",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_001","확정여부")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "7%",
        				            visible      : false
        				        },{
        				            dataField    : "ING_STEP",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_002","배치여부")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "7%",
        				            visible      : false
        				        },{
        				            dataField    : "ING_STEP_NM",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_044","배치상태")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "7%",
        				            visible      : false
        				        },{
        				            dataField    : "ATTCH_FILE_NO",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_108","첨부파일번호")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "7%",
        				            visible      : false
        				        },{
        				            dataField    : "BAT_STATE",
        				            caption      : '${msgel.getMsg("RBA_50_01_01_044","배치상태")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "7%",
        				            visible      : false
        				        },{
        				            dataField    : "BAT_ING_STEP",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_109","배치")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "7%",
        				            visible      : false
        				        }, {
        				            dataField    : "REAL_BAS_YN",
        				            caption      : '${msgel.getMsg("RBA_50_05_01_110","RBA 실제 평가 기준년월 여부")}',
        				            alignment    : "center",
        				            allowResizing: true,
        				            allowSearch  : true,
        				            allowSorting : true,
        				            width        : "7%",
        				            visible      : false
        				        }
        				    ],
        				    onCellClick: function(e){
        				        if(e.data){
        				            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
        				        }
        				    }
            	}).dxDataGrid("instance");	
    }
    
    //종료처리
    function doSave() {
        
        if($("button[id='btn_01']") == null) return;
        if(getDxDateTxt("REAL_EDT", true) != null){
	        if(form.VALT_SDT.value.replaceAll("-","").length==8 && getDxDateTxt("REAL_EDT", true).length==8){
	            //if(getDxDateTxt("REAL_EDT", true) < form.VALT_SDT.value.replaceAll("-","") || getDxDateTxt("REAL_EDT", true) == form.VALT_SDT.value.replaceAll("-","")){
	           if(getDxDateTxt("REAL_EDT", true) < form.VALT_SDT.value.replaceAll("-","")){
	                showAlert('${msgel.getMsg("RBA_50_01_01_203","실제종료일은 업무시작일보다 같거나 작을 수 없습니다.")}','WARN');
	                return false;
	            }
	        }
    	}
        //if(!confirm("${msgel.getMsg('RBA_50_01_01_041','종료처리 하시겠습니까?')}")) return;
        $("button[id='btn_01']").prop('disabled', true);
        
        var  ING_STEP = "";
        var  FIX_YN   = "";  /*확정처리*/ 
        if(form.RBA_VALT_SMDV_C.value == "D01"){
        	ING_STEP = "10";
        	FIX_YN = "1";
        }else if(form.RBA_VALT_SMDV_C.value == "E01"){
        	ING_STEP = "20";
        	FIX_YN = "1";
        }else if(form.RBA_VALT_SMDV_C.value == "E02"){
        	ING_STEP = "30";
        	FIX_YN = "1";
        }
        
        var params   = new Object();
        var methodID = "doEnd";
        var classID  = "RBA_50_01_01_01";
         		
        params.pageID 	= pageID;
        params.BAS_YYMM = form.BAS_YYMM.value; 
        params.RBA_VALT_LGDV_C = form.RBA_VALT_LGDV_C.value;
        params.RBA_VALT_SMDV_C = form.RBA_VALT_SMDV_C.value;
        params.REAL_EDT		   = getDxDateTxt("REAL_EDT", true);
        params.ING_STEP 	   = ING_STEP;
        params.FIX_YN		   = FIX_YN;
         		
        sendService(classID, methodID, params, appro_end, appro_end); 
    }
    
    // 날짜 NULL에 대한 VALUE -> TEXT 처리
    function getDxDateTxt(elementID, isOnlyNumber){
        $("#"+elementID).dxDateBox("instance").option("displayFormat", "yyyy-MM-dd");
        var dxDate = $("#"+elementID).dxDateBox("instance").option("text");
        return isOnlyNumber?(dxDate?extractNumber(dxDate):dxDate):dxDate;
    }
    // 일정복사 저장 end
    function appro_end() {
        $("button[id='btn_01']").prop('disabled', false);
        opener.doSearch();
        window.close();
    }
    
</script>
<form name="form" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="RBA_VALT_LGDV_C" value="${RBA_VALT_LGDV_C}">
    <input type="hidden" name="RBA_VALT_SMDV_C" value="${RBA_VALT_SMDV_C}">
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
                <table width="100%" class="basic-table">
                    <tr>
                        <th class="title">${msgel.getMsg('RBA_50_10_01_01_001','기준년월')}</th> 
                        <td align="left" colspan="3">
                            <input type="text"  class="cond-input-text" name="BAS_YYMM" value="${BAS_YYMM}" style="border: 0px;" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="title" >${msgel.getMsg('RBA_50_01_01_010','대분류')}</th>
                        <td align="left" colspan="3">
                            <input type="text" class="cond-input-text" name="RBA_VALT_LGDV_C_NM" value="${RBA_VALT_LGDV_C_NM}" style="border: 0px; " readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="title" >${msgel.getMsg('RBA_50_01_01_011','구분')}</th>
                        <td align="left" colspan="3">
                            <input type="text" class="cond-input-text" name="RBA_VALT_SMDV_C_NM" value="${RBA_VALT_SMDV_C_NM}" style="border: 0px;" readonly="readonly" />
                        </td>
                    </tr>
                    <tr>
                        <th class="title" >${msgel.getMsg("RBA_50_01_01_016","업무시작일")}</th>
                        <td  align="left" colspan="3">
                            <input type="text" class="cond-input-text" name="VALT_SDT" value="${VALT_SDT}" style="border: 0px;" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="title" >${msgel.getMsg("RBA_50_01_01_017","업무시작일")}</th>
                        <td align="left" colspan="3">
                            <input type="text" class="cond-input-text" name="VALT_EDT" value="${VALT_EDT}" style="border: 0px;" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="title"  >${msgel.getMsg('RBA_50_01_01_015','실제종료일')}</th>
                        <td  align="left" >
                        	${condel.getInputDateDx('REAL_EDT', REAL_EDT)}
                        </td>
                    </tr> 
                </table>
            </div>
        </div>
        
        <table border="0" align="right" class="btn_area" style="margin-top: 10px;">
        	<tr>
        		<td>
        			${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
            		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
        		</td>
        	</tr>
		</table>
	
    </div>
    
    
    
    
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />