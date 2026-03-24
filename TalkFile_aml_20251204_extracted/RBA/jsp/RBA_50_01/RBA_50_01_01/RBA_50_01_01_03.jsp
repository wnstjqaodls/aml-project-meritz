<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_01_03.jsp
* Description     : 일정복사
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-23
--%>

<%@ include file="/WEB-INF/Kernel/express/header.jsp"%>
<%
%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>

<%
	String Year = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
	request.setAttribute("Year", Year);
%>
<style>
input[type=checkbox]:checked + label::before {
	background-color: rgba(17, 152, 173, 0.5);
    border: 1px solid rgba(17, 152, 173, 0);
}
</style>

<script language="JavaScript">

    var GridObj1;
    var classID = "RBA_50_01_01_01";
    var overlay = new Overlay();
    // Initialize
    $(document).ready(function(){
        setupGrids();
    });

    // Initial function
    function init() { initPage(); }

    // 그리드 초기화 함수 셋업
    function setupGrids() {

    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 		height	:"calc(90vh - 100px)",
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
				    },onInitialized : function(e) {
				    	doSearch1();
		            }
   		}).dxDataGrid("instance");
    }

    // 일정 복사년도
    function doSearch(){
    	var nextYear = parseInt(form.BAS_YYMM.value) + 1;
        var str = "";
        str = from.Year.value;
        var YYYYMM = str.substr(0,4);
        var NEXT = form.BAS_YYMM.value;

        //alert( "YYYYMM : " + nextYear );

        if( YYYYMM == NEXT(0,4)) {
        	form.COPY_YYMM.value = nextYear;
        } else {
        	form.COPY_YYMM.value = YYYYMM + "01";
        }

    }

    // 20171011 로딩시 조회 함수 추가
    function doSearch1(){

        if(form.BAS_YYMM.value != ""){



            form.FNL_BAS_YYMM.value = form.BAS_YYMM.value;

            var str = "";
            str = form.Year.value;
            var YYYYMM = str.substr(0,4);
            var NEXT = form.BAS_YYMM.value;
            var nextYear = parseInt(form.BAS_YYMM.value) + 1;

            if( YYYYMM == NEXT.substr(0,4)) {
            	form.COPY_YYMM.value = nextYear;
            } else {
            	form.COPY_YYMM.value = YYYYMM + "01";
            }
            //form.COPY_YYMM.value = nextYear;
        }

        /* GridObj1.refresh({
            actionParam: {
                "pageID"  : pageID,
                "classID" : classID,
                "methodID": methodID,
                "BAS_YYMM": form.BAS_YYMM.value //기준연도
            },
            completedEvent: doSearch_end
        }); */

        var params   = new Object();
        var methodID = "doSearch";
        var classID  = "RBA_50_01_01_01";

        params.pageID 	= pageID;
        params.BAS_YYMM = form.BAS_YYMM.value; //기준연도3

        sendService(classID, methodID, params, doSearch1_success, doSearch1_fail);
    }

    function doSearch1_success(gridData, data){
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

    function doSearch1_fail(){
    	overlay.hide();
    }


    // 일정복사 저장
    function doSave() {

        var COPY_YYMM = form.COPY_YYMM.value; //기준년도

        //alert( "yymm : " + COPY_YYMM);

        if(yearCheck(COPY_YYMM)){

            showConfirm("${msgel.getMsg('RBA_50_01_01_035','일정을 복사 하시겠습니까?')}", "저장",function(){
            	$("button[id='btn_01']").prop('disabled', true);

                var methodID = "docopy";
                var params   = new Object();
                var methodID = "docopy";
                var classID  = "RBA_50_01_01_01";

                params.pageID 	= pageID;
                params.BAS_YYMM = form.BAS_YYMM.value; //기준연도3
                params.COPY_YYMM= form.COPY_YYMM.value;                 //복사연도
                params.RISK1    = (form.RISK1.checked==true ? "1":"0"); //위험평가 일정
                params.RISK2    = (form.RISK2.checked==true ? "1":"0"); //조직정보
                params.RISK3    = (form.RISK3.checked==true ? "1":"0"); //모델 기준정보
                params.RISK4    = (form.RISK4.checked==true ? "1":"0"); //위험/통제 정보 및 매핑정보
                /* params.RISK5    = (form.RISK5.checked==true ? "1":"0"); //프로세스정보 */

                sendService(classID, methodID, params, appro_end, appro_end);
            });

        }
    }

    // 연도체크
    function yearCheck(c_year){

        if(isNaN(c_year)){
            showAlert('${msgel.getMsg("RBA_50_01_01_036","기준년월은 숫자만 입력 가능합니다.")}','WARN');
            return false;
        }

        //4자리 체크
        if(c_year.length != 6){
            showAlert('${msgel.getMsg("RBA_50_01_01_037","6자리의 기준년월을 넣어주세요.(YYYYMM)")}','WARN');
            return false;
        }

        //엉뚱한 년도 호출 체크
        /* if("20" != c_year.substring(0,2)){
            showAlert('${msgel.getMsg("RBA_50_01_01_038","기준년월의 앞 두자리는 20으로 시작해야 합니다.")}','WARN');
            return false;
        }

        if(parseInt(form.COPY_YYMM.value) <= parseInt(form.FNL_BAS_YYMM.value)){
                 showAlert('${msgel.getMsg("RBA_50_01_01_039","기준년월이 복사년도보다 작을수  없습니다.")}','WARN');
                 return false;
         } */

        return true;
    }

    // 일정복사 저장 end
    function appro_end() {
        opener.doSearch('copy');
        window.close();
    }

</script>
<form name="form" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="FNL_BAS_YYMM" id="FNL_BAS_YYMM">
    <input type="hidden" name="copyYN" id="copyYN">
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
                <table width="100%" class="basic-table">
                    <tr>
                        <th width="15%" class="title" stlye="text-align:center;">${msgel.getMsg('RBA_50_01_01_054','신규회차')}</th>
                        <td width="25%" align="left" >
                            <input name="COPY_YYMM" type="text" value="" class="cond-input-text" size="20" maxlength="6" style="IME-MODE:disabled"
                                onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;"/>
                        </td>
                        <th width="15%" class="title" stlye="text-align:center;">${msgel.getMsg('RBA_50_01_01_028','복사년월')}</th>
                        <td width="25%" align="left" >
                        	<%-- ${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'doSearch()')} --%>
                        	<RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="Y" eventFunction='setupGrids()'/>
                        </td>
                    </tr>
                    <tr>
                        <th rowspan="6" class="title" stlye="text-align:center;">${msgel.getMsg('RBA_50_01_01_029','복사항목')}</th>
                        <td colspan="3">
                            <input type="checkbox" checked="checked" id="checkbox1" name="RISK1" disabled>
                        	<label for="checkbox1"></label>
                        	&nbsp;${msgel.getMsg('RBA_50_01_01_030','위험평가 일정')}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <input type="checkbox" checked="checked" id="checkbox2" name="RISK2" disabled>
                            <label for="checkbox2"></label>
                            &nbsp;${msgel.getMsg('RBA_50_01_01_031','부점대상목록')}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <input type="checkbox" checked="checked" id="checkbox3" name="RISK3" disabled>
                        	<label for="checkbox3"></label>
                        	&nbsp;${msgel.getMsg('RBA_50_01_01_032','위험요소/위험가중치')}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <input type="checkbox" checked="checked" id="checkbox4" name="RISK4" disabled>
                        	<label for="checkbox4"></label>
                        	&nbsp;${msgel.getMsg('RBA_50_01_01_033','평가항목/부점매핑정보')}
                        </td>
                    </tr>
                    <%-- <tr>
                        <td colspan="3">
                            <input type="checkbox" checked="checked" id="checkbox5" name="RISK5" disabled>
                        	<label for="checkbox5"></label>
                        	&nbsp;${msgel.getMsg('RBA_50_01_01_034','프로세스 정보')}
                        </td>
                    </tr> --%>
                </table>
            </div>
        </div>

        <table border="0" align="right" class="btn_area" style="margin-top: 10px;">
            <tr>
                <td>
                <input type="text" class="cond-input-text" name="Year" id="Year" value="${Year}" style="border: 0px;background-color:white;color:white" readonly="readonly"></input>
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