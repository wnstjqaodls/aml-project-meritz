<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_01_02.jsp
* Description     : 일정수정
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-20
--%>
<%@ page import="java.text.ParseException"%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp"%>
<%@ page import="org.springframework.web.util.HtmlUtils"%> 
<%


    String BAS_YYMM           = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_BAS_YYMM"), "")) ;
	String RBA_VALT_LGDV_C    = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_RBA_VALT_LGDV_C"), "")) ;
    String RBA_VALT_LGDV_C_NM = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_RBA_VALT_LGDV_C_NM"), "")) ;
    String RBA_VALT_SMDV_C    = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_RBA_VALT_SMDV_C"), "")) ;
    String RBA_VALT_SMDV_C_NM = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_RBA_VALT_SMDV_C_NM"), "")) ;
    String VALT_METH_CTNT     = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_VALT_METH_CTNT"), "")) ;
    String EXEC_B_BRNO_YN     = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_EXEC_B_BRNO_YN"), "")) ;
    String EXEC_S_BRNO_YN     = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_EXEC_S_BRNO_YN"), "")) ;
    String VALT_SDT           = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_VALT_SDT"), "")) ;
    String VALT_EDT           = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_VALT_EDT"), "")) ;
    String TGT_TRN_SDT        = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_TGT_TRN_SDT"), "")) ;
    String TGT_TRN_EDT        = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_TGT_TRN_EDT"), "")) ;
    String arrRBA_VALT_LGDV_C_NM = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_arrRBA_VALT_LGDV_C_NM"), "")) ;
    String arrRBA_VALT_SMDV_C_NM = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_arrRBA_VALT_SMDV_C_NM"), "")) ;
    arrRBA_VALT_SMDV_C_NM = HtmlUtils.htmlEscape(StringHelper.evl(arrRBA_VALT_SMDV_C_NM.replace(",","\n"), "")) ;
    String arrRBA_VALT_SMDV_C = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("P_arrRBA_VALT_SMDV_C"), "")) ;
    String p_COUNT            = HtmlUtils.htmlEscape(StringHelper.evl(request.getParameter("p_COUNT"), "")) ;request.getParameter("");
    String Parma_in = "";

   // alert("arrRBA_VALT_SMDV_C ::::" + arrRBA_VALT_SMDV_C);



/*  	String [] array = arrRBA_VALT_SMDV_C.split("','");
 	for (int i = 0; i< array.length; i++) {
 		if( "D03".equals(array[i]) ) {	//hanayc.D01->D03
 			RBA_VALT_SMDV_C = array[i];
 			break;
 		}
 	}; */

    try{
	    if("".equals(VALT_SDT) == false)
	        { VALT_SDT = jspeed.base.util.DateHelper.format(VALT_SDT, "yyyyMMdd", "yyyy-MM-dd");}

	    if("".equals(VALT_EDT) == false)
	        {VALT_EDT = jspeed.base.util.DateHelper.format(VALT_EDT, "yyyyMMdd", "yyyy-MM-dd");}

	    if("".equals(TGT_TRN_SDT) == false)
	        {TGT_TRN_SDT = jspeed.base.util.DateHelper.format(TGT_TRN_SDT, "yyyyMMdd", "yyyy-MM-dd");}

	    if("".equals(TGT_TRN_EDT) == false)
	        { TGT_TRN_EDT = jspeed.base.util.DateHelper.format(TGT_TRN_EDT, "yyyyMMdd", "yyyy-MM-dd");}


    }catch(ParseException e){
    	 Log.logAML(Log.ERROR,this,"(RBA_50_01_01_02)",e.toString());
    }catch(NumberFormatException e){
    	 Log.logAML(Log.ERROR,this,"(RBA_50_01_01_02)",e.toString());
    }

    request.setAttribute("BAS_YYMM",BAS_YYMM);
    request.setAttribute("RBA_VALT_LGDV_C",RBA_VALT_LGDV_C);
    request.setAttribute("RBA_VALT_LGDV_C_NM",RBA_VALT_LGDV_C_NM);
    request.setAttribute("RBA_VALT_SMDV_C",RBA_VALT_SMDV_C);
    request.setAttribute("RBA_VALT_SMDV_C_NM",RBA_VALT_SMDV_C_NM);
    request.setAttribute("VALT_METH_CTNT",VALT_METH_CTNT);  //위험관리활동상세코드
    request.setAttribute("EXEC_B_BRNO_YN",EXEC_B_BRNO_YN);  //기준년도
    request.setAttribute("EXEC_S_BRNO_YN",EXEC_S_BRNO_YN);	//평가회차
    request.setAttribute("VALT_SDT",VALT_SDT);          	//수행종료일
    request.setAttribute("VALT_EDT",VALT_EDT);          	//수행종료일
    request.setAttribute("TGT_TRN_SDT",TGT_TRN_SDT);    	//대상시작일
    request.setAttribute("TGT_TRN_EDT",TGT_TRN_EDT);    	//대상종료일
    request.setAttribute("arrRBA_VALT_LGDV_C_NM",arrRBA_VALT_LGDV_C_NM);        //Arr 선택된 데이터
    request.setAttribute("arrRBA_VALT_SMDV_C_NM",arrRBA_VALT_SMDV_C_NM);        //Arr 선택된 데이터
    request.setAttribute("arrRBA_VALT_SMDV_C",arrRBA_VALT_SMDV_C);         		//Arr 선택된 데이터
    request.setAttribute("p_COUNT", p_COUNT );

%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />

<script language="JavaScript">

    var GridObj1;
    var classID  = "RBA_50_01_01_01";

    // Initialize
    $(document).ready(function(){
        $('.popup-contents').css({overflow:"auto"});

        //alert( "form.p_COUNT.value : " + form.p_COUNT.value );

        if(form.p_COUNT.value == "1") {

        	$('#VALT_METH_CTNT').css("display","");
        }
        else {
        	$('#VALT_METH_CTNT').css("display","none");
        }

        setupGrids();


    });

    // Initial function
    function init() { initPage(); }

    // 그리드 초기화 함수 셋업
    function setupGrids() {
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        			elementAttr: { class: "grid-table-type" },
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
				        var valtEdt            = dataGrid.cellValue(rowIndex, 'VALT_EDT');
				        var rba_valt_smdv_c_nm = dataGrid.cellValue(rowIndex, 'RBA_VALT_SMDV_C_NM');
				        if(rowIndex != -1){
				            if(realEdt == ''){
				                if((valtEdt !='')
				                && (columnName == 'RBA_VALT_LGDV_C_NM'
				                 || columnName == 'RBA_VALT_SMDV_C_NM'
				                 || columnName == 'VALT_SDT'
				                 || columnName == 'VALT_EDT'
				                 || columnName == 'ROWNUM')){
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
				            caption      : '${msgel.getMsg("RBA_50_05_01_110","RBA 실제 평가회차 여부")}',
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

    // 일정수정 저장
    function doSave() {

        if($("button[id='btn_01']") == null) return;

        // E validation 체크
        var methodID 	= "doModify";
        var obj      	= new Object();
        //화면의 값을 get...
        obj.VALT_SDT    = getDxDateTxt("VALT_SDT", true);    //업무 시작일
        obj.VALT_EDT    = getDxDateTxt("VALT_EDT", true);    //업무 시작일
        obj.TGT_TRN_SDT = getDxDateTxt("TGT_TRN_SDT", true); //대상거래 시작일
        obj.TGT_TRN_EDT = getDxDateTxt("TGT_TRN_EDT", true); //대상거래 종료일


        if(chkPosCon(obj)){	//입력값 check...
            $("button[id='btn_01']").prop('disabled', true);
            var params   = new Object();
            var methodID = "doModify";
            var classID  = "RBA_50_01_01_01";
//alert("arrRBA_VALT_SMDV_C : "+ "${arrRBA_VALT_SMDV_C}");
            params.pageID				= pageID;
            params.BAS_YYMM				= form.BAS_YYMM.value;
            params.VALT_SDT         	= getDxDateTxt("VALT_SDT", true);    //수행시작일
            params.VALT_EDT         	= getDxDateTxt("VALT_EDT", true);    //수행종료일
            params.TGT_TRN_SDT      	= getDxDateTxt("TGT_TRN_SDT", true); //대상시작일
            params.TGT_TRN_EDT      	= getDxDateTxt("TGT_TRN_EDT", true);  //대상종료일
            params.arrRBA_VALT_SMDV_C	= "${arrRBA_VALT_SMDV_C}";
            params.VALT_METH_CTNT		= $("#VALT_METH_CTNT").val();

            //alert( "비고 : " + $("#VALT_METH_CTNT").val() )

            sendService(classID, methodID, params, appro_end, appro_end);
        }
    }

    // 날짜 NULL에 대한 VALUE -> TEXT 처리
    function getDxDateTxt(elementID, isOnlyNumber){
        $("#"+elementID).dxDateBox("instance").option("displayFormat", "yyyy-MM-dd");
        var dxDate = $("#"+elementID).dxDateBox("instance").option("text");
        return isOnlyNumber?(dxDate?extractNumber(dxDate):dxDate):dxDate;
    }

    // 일정수정 날짜 check
    function chkPosCon(obj){

        if(obj.VALT_SDT == "" || obj.VALT_SDT == null){
        	showAlert("${msgel.getMsg('RBA_50_01_01_023','업무시작일은 필수 값 입니다.')}");
            return false;
        }

        if(form.RBA_VALT_SMDV_C.value == "D03"){	//hanayc.D01->D03
            if(obj.TGT_TRN_SDT == "" || obj.TGT_TRN_SDT == null){
            	showAlert("구분CD가 'D03'인</br>[프로세스별 통제활동 관리] 가 포함 되어 있으면</br>대상거래시작일은 필수 값 입니다.",'WARN');
                return false;
            }
            if(obj.TGT_TRN_EDT == ""  || obj.TGT_TRN_EDT == null){
            	showAlert("구분CD가 'D03'인</br>[프로세스별 통제활동 관리] 가 포함 되어 있으면</br>대상거래종료일은 필수 값 입니다.",'WARN');
                return false;
            }
            if(obj.TGT_TRN_SDT.length==8 && obj.TGT_TRN_EDT.length==8){
                if(obj.TGT_TRN_SDT > obj.TGT_TRN_EDT || obj.TGT_TRN_SDT == obj.TGT_TRN_EDT){
                	showAlert("${msgel.getMsg('RBA_50_01_01_026','대상거래시작일은 대상거래종료일보다 같거나 작을 수 없습니다.')}",'WARN');
                    return false;
                }
            }
        }

        return true;
    }

    // 일정수정 팝업 close
    function appro_end() {
        $("button[id='btn_01']").prop('disabled', false);
        opener.doSearch("force");
        window.close();
    }

    //날짜 더하기
    function date_add(sDate, nDays) {
        var yy = parseInt(sDate.substr(0, 4), 10);
        var mm = parseInt(sDate.substr(5, 2), 10);
        var dd = parseInt(sDate.substr(8), 10);
        d = new Date(yy, mm - 1, dd + nDays);
        yy = d.getFullYear();
        mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
        dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
        return '' + yy + '-' +  mm  + '-' + dd;
    }


</script>

<form name="form" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="RBA_VALT_LGDV_C" value="${RBA_VALT_LGDV_C}">
    <input type="hidden" name="RBA_VALT_SMDV_C" value="${RBA_VALT_SMDV_C}">
    <input type="hidden" name="p_COUNT" value="${p_COUNT }">

    <div class="tab-content-bottom">
		<div class="" style="padding-top: 8px;">
			<table class="basic-table" style="width:100%;">
				<tr>
                    <th class="title" width="20%">${msgel.getMsg('RBA_50_10_01_01_001','기준년월')}</th>
                    <td width="25%"  colspan="3">
                        <input type="text" class="cond-input-text" name="BAS_YYMM" value="<c:out value='${BAS_YYMM }'/>"  readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <th class="title" width="15%"  >${msgel.getMsg('RBA_50_01_01_051','일정명')}</th>
                    <td width="25%" align="left" colspan="3">
                   		<textarea name="RBA_VALT_SMDV_C_NM" id="RBA_VALT_SMDV_C_NM" cols="10" rows="5" class="textarea-box" readonly="readonly" >${arrRBA_VALT_SMDV_C_NM}</textarea>
                    </td>
                </tr>
                <tr>
                    <th class="title required" width="15%" >${msgel.getMsg('RBA_50_01_01_016','업무시작일')}</th>
                    <td width="25%" align="left" >${condel.getInputDateDx('VALT_SDT', VALT_SDT)}</td>
                    <th class="title required" width="15%" >${msgel.getMsg('RBA_50_01_01_017','업무종료일')}</th>
                    <td width="25%" align="left" >${condel.getInputDateDx('VALT_EDT', VALT_EDT)}</td>
                </tr>
                <tr>
                    <th class="title" width="15%"  style="text-align:left; ">${msgel.getMsg('RBA_50_01_01_018','대상거래시작일')}</th>
                    <td width="25%" align="left">${condel.getInputDateDx('TGT_TRN_SDT', TGT_TRN_SDT)}</td>
                    <th class="title" width="15%"  style="text-align:left; ">${msgel.getMsg('RBA_50_01_01_019','대상거래종료일')}</th>
                    <td width="25%" align="left">${condel.getInputDateDx('TGT_TRN_EDT', TGT_TRN_EDT)}</td>
                </tr>
                <tr>
                    <th class="title" width="15%"  >${msgel.getMsg('RBA_50_01_01_052','비고')}</th>
                    <td width="25%" align="left" colspan="3">
                   		<textarea name="VALT_METH_CTNT" id="VALT_METH_CTNT" cols="10" rows="3" class="textarea-box" >${VALT_METH_CTNT}</textarea>
                    </td>
                </tr>
			</table>
		</div>
	</div>

	<table border=0; width=100%; style="margin-top: 8px;">
		<tr style="vertical-align: top;">
			<td align="left" style=" vertical-align: top; font-size:0.8rem;color:blue;">
				${msgel.getMsg('RBA_50_01_01_201','※ 일정명 항목의 대상전체 일자변경 일괄 반영처리 됩니다.')}<br>
				${msgel.getMsg('RBA_50_01_01_202','※ 비고항목 수정은 1건 선택시 가능합니다.')}
			</td>
			<td align="right" >
				${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
           		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"appro_end", cssClass:"btn-36"}')}
			</td>
		</tr>
	</table>


    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />