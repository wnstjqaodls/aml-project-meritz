<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_02_01_02.jsp
* Description     : 업무프로세스관리 등록/수정 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-02
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%
	
	String BAS_YYMM  = Util.nvl(request.getParameter("BAS_YYMM"));
	String PROC_FLD_C  = Util.nvl(request.getParameter("PROC_FLD_C"));
	String PROC_LGDV_C   = Util.nvl(request.getParameter("PROC_LGDV_C"));
	String PROC_MDDV_C = Util.nvl(request.getParameter("PROC_MDDV_C"));
	String PROC_SMDV_C = Util.nvl(request.getParameter("PROC_SMDV_C"));
	String GUBN     = request.getParameter("P_GUBN");
	
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    request.setAttribute("PROC_FLD_C",PROC_FLD_C);
    request.setAttribute("PROC_LGDV_C",PROC_LGDV_C);
    request.setAttribute("PROC_MDDV_C",PROC_MDDV_C);
    request.setAttribute("PROC_SMDV_C",PROC_SMDV_C);
    request.setAttribute("GUBN",GUBN);
    
 // 세션결재자정보
    String ROLEID = sessionAML.getsAML_ROLE_ID();
    String ROLENAME = sessionAML.getsAML_ROLE_NAME();
    request.setAttribute("ROLEID",ROLEID);
    request.setAttribute("ROLENAME",ROLENAME);
    
%>
<script>
    
    var GridObj1;
    var classID = "RBA_50_02_01_02";
    var pageID = "RBA_50_02_01_02";
    var overlay  = new Overlay();
    
    // Initialize
    $(document).ready(function(){
        $('.popup-contents').css({overflow:"auto"});
        $("#RSK_CATG").attr("style","width:150px;");
        $("#RSK_FAC") .attr("style","width:200px;");
        $("#FRQ_C") .attr("style","width:150px;");
        $("th").attr("style","text-align:left;");
        setupGrids();
        
    });
    
    // Initial function
    function init() { initPage();}
    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
        // 그리드1(Code Head) 초기화
        
        GridObj1 = $("#GTDataGrid3_Area").dxDataGrid({
			 height	:"calc(50vh - 100px)",
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
			    sorting         : {mode   : "multiple"},
			    loadPanel       : {enabled: false},
			    remoteOperations: {
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
			    searchPanel          : {
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
			            dataField    : "BAS_YYMM",
			            caption      : '기준년월',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            visible      : false,
			            width : 50
			        }, {
			            dataField    : "PROC_FLD_C",
			            caption      : '프로세스영역코드',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "PROC_FLD_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_01_017","영역")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 100
			        },{
			            dataField    : "PROC_LGDV_C",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_011","코드1")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 50
			        }, {
			            dataField    : "PROC_LGDV_NM",
			            caption      : '${msgel.getMsg("RBA_50_04_01_001","대분류")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            cssClass     : "link"
			        }, {
			            dataField    : "PROC_MDDV_C",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_013","코드2")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 80
			        }, {
			            dataField    : "PROC_MDDV_NM",
			            caption      : '${msgel.getMsg("RBA_50_03_02_003","중분류")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        },  {
			            dataField    : "PROC_SMDV_C",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_015","코드3")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 80
			        }, {
			            dataField    : "PROC_SMDV_NM",
			            caption      : '${msgel.getMsg("RBA_50_03_03_003","소분류")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        },{
			            dataField    : "RSK_CAUS_CTNT",
			            caption      : '위험원인내용',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "USYN",
			            caption      : '운영여부코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "USYN_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_01_001","운영여부")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 50
			        }, {
			            dataField    : "VALT_METH_C",
			            caption      : '평가방식코드',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "VALT_METH_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_01_01_103","총위험평가방식")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 100
			        },{
			            dataField    : "NOTE_CTNT",
			            caption      : '비고내용',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_DT",
			            caption      : '등록일자',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_TIME",
			            caption      : '등록시간',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_OP_JKW_NO",
			            caption      : '등록조작자번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_DT",
			            caption      : '변경일자',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_TIME",
			            caption      : '변경일시',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_OP_JKW_NO",
			            caption      : '변경조작자번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_OP_JKW_NM",
			            caption      : '등록자',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }
			    ],
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
	        }).dxDataGrid("instance");	
        
        if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
            doSearch();
            $("#PROC_FLD_C").attr("disabled","disabled");
            $("#PROC_LGDV_C").prop("disabled","disabled");
            $("#PROC_MDDV_C").prop("disabled","disabled");
        }
        
        if ( !(${ROLEID}=="4"||${ROLEID}=="104")) {
        	 $("#USYN").prop("disabled","disabled");
             $("#VALT_METH_C").prop("disabled","disabled");
             $("#PROC_SMDV_NM").prop("disabled","disabled");
             $("#RSK_CAUS_CTNT").prop("disabled","disabled");
             $("#NOTE_CTNT").prop("disabled","disabled");
        }
    }
    
    //위험평가지표관리 상세 조회
    function doSearch(){
    	overlay.show(true, true);
        
        var classID  = "RBA_50_02_01_01";
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= pageID;
        params.BAS_YYMM  	= "${BAS_YYMM}";
        params.PROC_LGDV_C  = "${PROC_LGDV_C}";
        params.PROC_MDDV_C  = "${PROC_MDDV_C}";
        params.PROC_SMDV_C 	= "${PROC_SMDV_C}";
     
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
        
    }
    
    //위험평가지표관리 상세 완료
    function doSearch_end(){
        var selObj = GridObj1.getRow(0);
        setData(selObj);
    }
    
    function doSearch_success(gridData, data){
        try {
        	var selObj = gridData[0];
            setData(selObj);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
    
    function doSearch_fail(){    	 
    	overlay.hide();
    }
    
    
    //위험평가지표관리 상세 HTML에 데이타 삽입
    function setData(selObj){ 
        form1.PROC_FLD_C.value  	= (selObj.PROC_FLD_C    	   == undefined)?"":selObj.PROC_FLD_C; 		//프로세스영역코드
        form1.PROC_LGDV_C.value    	= (selObj.PROC_LGDV_C   	   == undefined)?"":selObj.PROC_LGDV_C; 	//대분류 코드
    	form1.PROC_MDDV_C.value     = (selObj.PROC_MDDV_C          == undefined)?"":selObj.PROC_MDDV_C; 	//중분류 코드
    	form1.PROC_SMDV_C.value    	= (selObj.PROC_SMDV_C          == undefined)?"":selObj.PROC_SMDV_C; 	//소분류 코드
    	form1.PROC_SMDV_NM.value    = (selObj.PROC_SMDV_NM         == undefined)?"":selObj.PROC_SMDV_NM; 	//소분류명
    	form1.USYN.value   			= (selObj.USYN                 == undefined)?"":selObj.USYN; 			//사용여부
    	form1.VALT_METH_C.value     = (selObj.VALT_METH_C          == undefined)?"":selObj.VALT_METH_C; 	//평가방식
    	form1.RSK_CAUS_CTNT.value   = (selObj.RSK_CAUS_CTNT        == undefined)?"":selObj.RSK_CAUS_CTNT; 	//위험내용
    	form1.NOTE_CTNT.value    	= (selObj.NOTE_CTNT            == undefined)?"":selObj.NOTE_CTNT; 		//비고
    	
    }
    
    //위험평가지표관리 상세 저장
    function doSave(){
    	/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}','WARN'); return;};
       
        if($("#PROC_FLD_C").val()==""){
        	showAlert('${msgel.getMsg("RBA_50_02_01_002","영역은 필수 값 입니다.")}','WARN');
            return false;
        }
        
        if($("#PROC_LGDV_C").val()==""){
        	showAlert('${msgel.getMsg("RBA_50_02_01_003","대분류는 필수 값 입니다.")}','WARN');
            return false;
        }
        
        if($("#PROC_MDDV_C").val()==""){
        	showAlert('${msgel.getMsg("RBA_50_02_01_008","중분류는 필수 값 입니다.")}','WARN');
            return false;
        }
        if($("#PROC_SMDV_NM").val()==""){
        	showAlert('${msgel.getMsg("RBA_50_02_01_009","소분류는 필수 값 입니다.")}','WARN');
            return false;
        }
        if($("#USYN").val()==""){
        	showAlert('${msgel.getMsg("RBA_50_02_01_006","사용여부는 필수 값 입니다.")}','WARN');
            return false;
        } 
        
        if($("#USYN").val()=="Y"){
	        if($("#VALT_METH_C").val()==""){
	        	showAlert('${msgel.getMsg("RBA_50_02_01_007","평가방식은 필수 값 입니다.")}','WARN');
	            return false;
	        } 
        }
        
        showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){

        	var params   = new Object();
        	var methodID = "doSave";
        	var classID  = "RBA_50_02_01_02";
        	 		
        	params.pageID 	= pageID;
        	params.PROC_FLD_C 		= $("#PROC_FLD_C").val();
        	params.PROC_LGDV_C  	= $("#PROC_LGDV_C").val();
        	params.PROC_MDDV_C    	= $("#PROC_MDDV_C").val();
        	params.PROC_SMDV_C 		= $("#PROC_SMDV_C").val();
        	params.PROC_SMDV_NM     = $("#PROC_SMDV_NM").val();
        	params.USYN   			= $("#USYN").val();
        	params.VALT_METH_C    	= $("#VALT_METH_C").val();
        	params.RSK_CAUS_CTNT 	= $("#RSK_CAUS_CTNT").val();
        	params.NOTE_CTNT   		= $("#NOTE_CTNT").val();
        	params.BAS_YYMM			= "${BAS_YYMM}";
        	params.GUBN              = "${GUBN}"; //구분이 0이면 등록 아니면 수정
        	params.ORG_PROC_FLD_C    = "${PROC_FLD_C}"; // 수정전 분류
        	params.ORG_PROC_LGDV_C   = "${PROC_LGDV_C}"; // 수정전 대분류
        	params.ORG_PROC_MDDV_C   = "${PROC_MDDV_C}"; //수정전 중분류
        	params.ORG_PROC_SMDV_C   = "${PROC_SMDV_C}"; //수정전 중분류

        	sendService(classID, methodID, params, doSaveEnd, doSaveEnd); 
        });
        
    }
  
    //위험평가지표관리 상세 완료
    function doSaveEnd() {
		showAlert('${msgel.getMsg("AML_00_04_01_01_001","저장되었습니다.")}','WARN');
        opener.doSearch();
        window.close();
    }
  
    //중부류 선택에 따라 소분류 코드 셋팅
    function setRSK_INDCT_CD(obj){
     	var param = new Object();
    	param.GRP_C = $("#PROC_MDDV_C").val();
    	param.GUBN="PROC";
    	param.BAS_YYMM = "${BAS_YYMM}";

    	goAjaxWidthReturn("com.gtone.rba.common.action.GetSRBAIndcCd", param, "onAfterSetRSK_INDCT");
    }
    
    //중부류 선택에 따라 소분류 코드 셋팅
    function onAfterSetRSK_INDCT(jsonObj, paramdata){
    	var cnt = jsonObj.RESULT.length;
    	if( cnt > 0 ) {$("#PROC_SMDV_C").val(jsonObj.RESULT[0].RESULT_CD);}
    	else{$("#PROC_SMDV_C").val($("#PROC_MDDV_C").val()+"01") }
    }
    
    
    function chkCommValidation(CHK_GUBN){
    	//전사업무 프로세스 관리의 코드값 
    	var RBA_VALT_SMDV_C = "B01"
    	
    	var callbackfunc = "chkMaxBasYYMM_end";
		var actionName = "com.gtone.rba.common.action.CommonValidationCheckAction";
    	var paramdata = new Object();
    	paramdata.BAS_YYMM = "${BAS_YYMM}";
    	paramdata.CHK_GUBN = CHK_GUBN;
    	paramdata.RBA_VALT_SMDV_C = RBA_VALT_SMDV_C;
    	
    	if(chkValidationSync(actionName,paramdata,callbackfunc)){
    		return true;
    	}else {
    		return false;
    	}
    }
    
</script>
<!-- 저장용 iframe -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top"><iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe></td>
    </tr>
</table>


<form name="form3" method="post" >
    <input type="hidden" name="pageID" > 
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="SEND_3_BAS_YYMM" id="SEND_3_BAS_YYMM">
    <input type="hidden" name="SEND_3_RSK_CATG" id="SEND_3_RSK_CATG">
    <input type="hidden" name="SEND_3_RSK_FAC" id="SEND_3_RSK_FAC">
    <input type="hidden" name="SEND_3_RSK_INDCT" id="SEND_3_RSK_INDCT">
    <input type="hidden" name="SEND_3_GYLJ_ID" id="SEND_3_GYLJ_ID">
    <input type="hidden" name="SEND_3_FLAG" id="SEND_3_FLAG">
    <input type="hidden" name="SEND_3_GYLJ_G_C" id="SEND_3_GYLJ_G_C">
</form>

<form name="form1" id="form1" method="post">
<input type="hidden" name="pageID">
<input type="hidden" name="classID"> 
<input type="hidden" name="methodID">
<input type="hidden" name="GUBN">
<input type="hidden" name="BAS_YYMM" value="${BAS_YYMM}">
<input type="hidden" name="mode">
    <div class="panel panel-primary" >
        <div class="panel-footer" >
            <div class="table-box" >
                <table width="100%" class="basic-table">
                    <tr>
                    	<th class="title required">${msgel.getMsg('RBA_50_02_01_017','영역')}</th>
                        <td style="width: 40px !important; padding:1px 4px !important;">
                        	${SRBACondEL.getSRBASelect('PROC_FLD_C','' ,'' ,'R303' ,'','ALL','nextSelectChangeSRBA("PROC_LGDV_C", "FA", this,"")','','','')}
                        </td>
                        <th class="title required">${msgel.getMsg('RBA_50_02_01_013','사용여부')}</th>
                        <td style="text-align:left; width: 40px !important; padding:1px 4px !important;">
                            <select id='USYN' name='USYN' class="dropdown">
			                     <option class="dropdown-option" value='' SELECTED >::전체::</option> 
			                     <option class="dropdown-option" value='1' >Y</option> 
			                     <option class="dropdown-option" value='0' >N</option> 
			                 </select>
                        </td>
                        <th class="title required">${msgel.getMsg('RBA_50_04_01_015','평가방식')}</th>
                        <td style="width: 40px !important; padding:1px 4px !important;">
                        	${SRBACondEL.getSRBASelect('VALT_METH_C','' ,'' ,'R307' ,'','ALL','','','','')}
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg('RBA_50_04_01_001','대분류')}</th>
                        <td style="padding:1px 4px !important;">
                        	${SRBACondEL.getSRBASelect('PROC_LGDV_C','' ,'' ,'R304' ,'','ALL','nextSelectChangeSRBA("PROC_MDDV_C", "FA", this,"")','','','')}
                        </td>
                        <th class="title required">${msgel.getMsg('RBA_50_03_02_003','중분류')}</th>
                        <td style="text-align:left; width: 40px !important; padding:1px 4px !important;">
							${SRBACondEL.getSRBASelect('PROC_MDDV_C','' ,'' ,'R305' ,'','ALL','setRSK_INDCT_CD(this)','','','')}
                        </td>
                        <th class="title">${msgel.getMsg('RBA_50_03_02_006','소분류코드')}</th>
                        <td style="text-align:center; width: 40px !important; padding:1px 4px !important;"> 
                            <input type="text" name="PROC_SMDV_C" id="PROC_SMDV_C" style="text-align:left; width: 100%" readOnly />
                        </td>
                    </tr>
                    <tr>
                        <th class="title required">${msgel.getMsg('RBA_50_03_03_003','소분류')}</th>
                        <td style="text-align:center; padding:1px 4px !important;" colspan="5"> 
                            <input type="text" name="PROC_SMDV_NM" id="PROC_SMDV_NM" style="text-align:left; width: 100%" />
                        </td>
                    </tr>
                    <tr>
                        <th class="title">${msgel.getMsg('RBA_50_05_02_003','위험범주')}<br>${msgel.getMsg('RBA_50_02_01_005','상세설명')}
                        </th>
                        <td style="text-align:center; padding:5px 4px !important;" colspan="5"> 
                            <textarea name="RSK_CAUS_CTNT" id="RSK_CAUS_CTNT" class="textarea-box" style="width:100%;" rows=6 maxlength="1000"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th class="title">${msgel.getMsg('RBA_50_02_01_004','업무')}<br>${msgel.getMsg('RBA_50_02_01_005','상세설명')}
                        </th>
                        <td style="text-align:center; padding:5px 4px !important;" colspan="5"> 
                            <textarea name="NOTE_CTNT" id="NOTE_CTNT" style="width:100%;" class="textarea-box" rows=6 maxlength="1000"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <table border="0" align="right" class="btn_area" style="margin-top: 8px;">
			<tr>
				<td>
				 	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
            		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')}
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