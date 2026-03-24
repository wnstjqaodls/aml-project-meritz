<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_02_02.jsp
* Description     : 통제평가 수행 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-02
--%>
<%@page import="com.gtone.aml.dao.common.MDaoUtilSingle"   %>
<%@page import="com.gtone.aml.admin.AMLException"   %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>

<%
	
	String BAS_YYMM  = Util.nvl(request.getParameter("BAS_YYMM"));
    String VALT_BRNO  = Util.nvl(request.getParameter("VALT_BRNO"));
	String TONGJE_LGDV_C   = Util.nvl(request.getParameter("TONGJE_LGDV_C"));
	String TONGJE_MDDV_C = Util.nvl(request.getParameter("TONGJE_MDDV_C"));
	String TONGJE_SMDV_C = Util.nvl(request.getParameter("TONGJE_SMDV_C"));
	String TONGJE_NO = Util.nvl(request.getParameter("TONGJE_NO"));
	String GYLJ_S_C  = Util.nvl(request.getParameter("GYLJ_S_C")); 
	String FIRST_GYLJ_YN  = Util.nvl(request.getParameter("FIRST_GYLJ_YN"));
	String GUBN     = request.getParameter("P_GUBN");
	
    request.setAttribute("GUBN",GUBN);
    request.setAttribute("BAS_YYMM",BAS_YYMM); 
    request.setAttribute("VALT_BRNO",VALT_BRNO); 
    request.setAttribute("TONGJE_LGDV_C",TONGJE_LGDV_C);
    request.setAttribute("TONGJE_MDDV_C",TONGJE_MDDV_C);
    request.setAttribute("TONGJE_SMDV_C",TONGJE_SMDV_C);
    request.setAttribute("TONGJE_NO",TONGJE_NO);
    request.setAttribute("GYLJ_S_C",GYLJ_S_C);
    request.setAttribute("FIRST_GYLJ_YN",FIRST_GYLJ_YN);
    
	DataObj input2 = new DataObj();
	DataObj output = new DataObj();
	DataObj output2 = new DataObj();	

	input2.put("PROC_SMDV_C", TONGJE_SMDV_C);
	input2.put("TONGJE_NO", TONGJE_NO);
	input2.put("BAS_YYMM", BAS_YYMM);
	input2.put("VALT_BRNO", VALT_BRNO);
			
	try{
	    output = MDaoUtilSingle.getData("RBA_50_04_01_02_getRbaAttchInfo",input2);
	    output2 = MDaoUtilSingle.getData("RBA_50_04_01_02_getRbaAttchInfo_TONGJE_BRNO",input2);
	}catch (AMLException e){
		Log.logAML(Log.ERROR, e);
	}
	
%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<script language="JavaScript">
    
    var GridObj1;
    var classID = "RBA_50_05_02_02";
    var pageID = "RBA_50_05_02_02";
    
    // Initialize
    $(document).ready(function(){
        $('.popup-contents').css({overflow:"auto"});
        $('th').attr("style","text-align:left");
        $('select').attr("style","width:330px;");
        //등록 창일때 삭제 버튼 안보이도록
        if("${GUBN}" == "0"){
        	$("#btn_02").attr("style","display:none;");
        }
        
        if( "${FIRST_GYLJ_YN}" == "Y" || "${GYLJ_S_C}" == "" || "${GYLJ_S_C}" == null){
        	$('#btn_01').css("display","");
            $('#btn_02').css("display","");
            $('#btn_03').css("display","");
        }else{
        	$('#btn_01').css("display","none");
            $('#btn_02').css("display","none");
            $('#btn_03').css("display","none");
        }
        setupGrids();
    });
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		height				 : "calc(90vh - 100px)",
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
    	    sorting              : {mode: "multiple"},
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
    	    columnFixing         : {enabled: true},
    	    searchPanel          : {
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
    	            dataField    : "TONGJE_FLD_C",
    	            caption      : '${msgel.getMsg("RBA_50_04_01_02_100","통제영역코드")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 80
    	        },  {
    	            dataField    : "TONGJE_LGDV_C",
    	            caption      : '${msgel.getMsg("RBA_50_04_01_02_101","통제대분류코드")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 180
    	        },  {
    	            dataField    : "TONGJE_MDDV_C",
    	            caption      : '${msgel.getMsg("RBA_50_04_01_02_102","통제중분류코드")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 80
    	        },  {
    	            dataField    : "TONGJE_SMDV_C",
    	            caption      : '${msgel.getMsg("RBA_50_04_01_02_103","통제소분류코드")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            cssClass     : "link",
    	            width : 200
    	        }, {
    	            dataField    : "TONGJE_SMDV_NM",
    	            caption      : '${msgel.getMsg("RBA_50_04_01_02_104","통제소분류명")}',
    	            alignment    : "left",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true
    	        },{ 
    	            dataField    : "TONGJE_NO",
    	            caption      : 'TONGJE_NO',
    	            alignment    : "left",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true
    	        },  {
    	            dataField    : "TONGJE_ACT_TITE",
    	            caption      : 'TONGJE_ACT_TITE',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width 		 : 0 
    	        },  {
    	            dataField    : "TONGJE_ISP_STEP",
    	            caption      : '${msgel.getMsg("RBA_50_04_01_02_110","통제점검절차")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 180
    	        },  {
    	            dataField    : "DSGN_VALT_PROF",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_02_100","설계평가증빙자료")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            cssClass     : "link",
    	            width : 200
    	        },  {
    	            dataField    : "DSGN_VALT_TP_C",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_02_101","설계평가유형코드")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width 		 : 0 
    	        },  {
    	            dataField    : "VALD_VALT_METH_C",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_02_102","운영평가 방법")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 200
    	        },  {
    	            dataField    : "VALT_METH_C",
    	            caption      : '${msgel.getMsg("RBA_50_05_02_02_103","운영평가 유형")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width 		 : 0 
    	        },  {
    	            dataField    : "OPR_VALT_JIPYO_NM",
    	            caption      : '운영평가 지표명',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width 		 : 0,
    	            "visible"    : false
    	        },  {
    	            dataField    : "TONGJE_SCOR_OFFR_C",
    	            caption      : '${msgel.getMsg("RBA_50_04_01_031","운영평가값 산정기준")}',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 200
    	        },  {
    	            dataField    : "DPRT_NM",
    	            caption      : 'DPRT_NM',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 200
    	        },  {
    	            dataField    : "DESIGN_VALUE",
    	            caption      : 'DESIGN_VALUE',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 200
    	        },  {
    	            dataField    : "OPERATION_VALUE",
    	            caption      : 'OPERATION_VALUE',
    	            alignment    : "center",
    	            allowResizing: true,
    	            allowSearch  : true,
    	            allowSorting : true,
    	            width : 200
    	        }
    	    ],
    	    onCellClick: function(e){ 
    	        if(e.data ){
    	            Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	    }
    	}).dxDataGrid("instance");
    	
		if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
			doSearch();  
			$("#TONGJE_LGDV_C").prop("disabled","disabled");
			$("#TONGJE_MDDV_C").prop("disabled","disabled");
			$("#TONGJE_SMDV_C").prop("disabled","disabled");
			$("#TONGJE_NO").prop("disabled","disabled");
			$("#DSGN_VALT_TP_C").prop("disabled","disabled");
			$("#VALD_VALT_METH_C").prop("disabled","disabled");
			$("#VALT_METH_C").prop("disabled","disabled");
			$("#OPR_VALT_JIPYO_NM").prop("disabled","disabled");
			$("#TONGJE_SCOR_OFFR_NM").prop("disabled","disabled");
			$("#DESIGN_VAL").prop("disabled","disabled");
			$("#OPERATION_VAL").prop("disabled","disabled");
			$("#TONGJE_ACT_TITE").prop("disabled","disabled");
			$("#TONGJE_ISP_STEP").prop("disabled","disabled");
			$("#DSGN_VALT_PROF").prop("disabled","disabled");
		}
//  }
    }
    
    //통제점검항목 상세 조회
    function doSearch(){ 
        var methodID = "doSearch";
//         GridObj1.refresh({
//             actionParam: {
//                 "pageID"  	: pageID,
//                 "classID" 	: classID,
//                 "methodID"	: methodID,
//                 "BAS_YYMM"  : "${BAS_YYMM}", 
//                 "TONGJE_LGDV_C" : "${TONGJE_LGDV_C}",
//                 "TONGJE_MDDV_C" : "${TONGJE_MDDV_C}",
//                 "TONGJE_SMDV_C" : "${TONGJE_SMDV_C}",
//                 "TONGJE_NO" : "${TONGJE_NO}",
//                 "VALT_BRNO" : "${VALT_BRNO}" 
//             },
//             completedEvent: doSearch_end
//         });
   		var params = new Object();
   		params.pageID 			= pageID;
   		params.classID 			= classID;
   		params.methodID 		= "doSearch";
   		params.BAS_YYMM			= "${BAS_YYMM}"; 
   		params.TONGJE_LGDV_C	= "${TONGJE_LGDV_C}";
   		params.TONGJE_MDDV_C	= "${TONGJE_MDDV_C}";
   		params.TONGJE_SMDV_C	= "${TONGJE_SMDV_C}";
   		params.TONGJE_NO		= "${TONGJE_NO}";
   		params.VALT_BRNO		= "${VALT_BRNO}";
   		sendService(classID, methodID, params, doSearch_end, doSearch_end);
    }
    
    //통제점검항목 상세 완료
    function doSearch_end(dataSource){
    	GridObj1.refresh();
        GridObj1.option("dataSource", dataSource);
    	GridObj1.refresh().then(function() {
    		GridObj1.selectRowsByIndexes(0)
    	});
        var selObj = dataSource[0];
        setData(selObj);
    }
    
    //통제점검항목 상세 HTML에 데이타 삽입
    function setData(selObj){ 
        form1.TONGJE_LGDV_C.value    	= (selObj.TONGJE_LGDV_C   	   == undefined)?"":selObj.TONGJE_LGDV_C; 		 
    	form1.TONGJE_MDDV_C.value      	= (selObj.TONGJE_MDDV_C        == undefined)?"":selObj.TONGJE_MDDV_C; 		 
    	form1.TONGJE_SMDV_C.value     	= (selObj.TONGJE_SMDV_C    	   == undefined)?"":selObj.TONGJE_SMDV_C; 	 
    	form1.TONGJE_NO.value           = (selObj.TONGJE_NO            == undefined)?"":selObj.TONGJE_NO;
    	form1.TONGJE_ACT_TITE.value     = (selObj.TONGJE_ACT_TITE      == undefined)?"":selObj.TONGJE_ACT_TITE;    // 통제활동제목
    	form1.TONGJE_ISP_STEP.value   	= (selObj.TONGJE_ISP_STEP  	   == undefined)?"":selObj.TONGJE_ISP_STEP; 	//통제점검절차
    	form1.DSGN_VALT_PROF.value      = (selObj.DSGN_VALT_PROF       == undefined)?"":selObj.DSGN_VALT_PROF; 		//설계평가 증빙자료
    	form1.DSGN_VALT_TP_C.value    	= (selObj.DSGN_VALT_TP_C       == undefined)?"":selObj.DSGN_VALT_TP_C; 		//설계평가 유형코드
    	form1.VALD_VALT_METH_C.value    = (selObj.VALD_VALT_METH_C     == undefined)?"":selObj.VALD_VALT_METH_C; 	//유효성평가방법코드(운영평가방법)
    	form1.VALT_METH_C.value         = (selObj.VALT_METH_C  	       == undefined)?"":selObj.VALT_METH_C; 	    //평가방식 코드(운영평가유형)
    	form1.OPR_VALT_JIPYO_NM.value   = (selObj.OPR_VALT_JIPYO_NM    == undefined)?"":selObj.OPR_VALT_JIPYO_NM; 	//운영평가지표명
    	form1.TONGJE_SCOR_OFFR_C.value  = (selObj.TONGJE_SCOR_OFFR_C   == undefined)?"":selObj.TONGJE_SCOR_OFFR_C; 	//통제점수산술산식코드(운영평가 값 산정 기준)
    	form1.TONGJE_SCOR_OFFR_NM.value = (selObj.TONGJE_SCOR_OFFR_NM   == undefined)?"":selObj.TONGJE_SCOR_OFFR_NM; 	//통제점수산술산식코드(운영평가 값 산정 기준)
		$('#DPRT_NM').text((selObj.DPRT_NM   == undefined)?"":selObj.DPRT_NM); //부서코드/명 리스트
		//$('#DESIGN_VALUE').text((selObj.DESIGN_VALUE   == undefined)?"":selObj.DESIGN_VALUE); //설계평가 완료 여부
		//$('#OPERATION_VALUE').text((selObj.OPERATION_VALUE   == undefined)?"":selObj.OPERATION_VALUE); //운영평가 완료여부 
		form1.DESIGN_VALUE.value = (selObj.DESIGN_VALUE   == undefined)?"":selObj.DESIGN_VALUE; //설계평가 완료 여부
		form1.OPERATION_VALUE.value = (selObj.OPERATION_VALUE   == undefined)?"":selObj.OPERATION_VALUE; //설계평가 완료 여부
		
		form1.TONGJE_LGDV_NM.value    	= (selObj.TONGJE_LGDV_NM   	   == undefined)?"":selObj.TONGJE_LGDV_NM; 		 
    	form1.TONGJE_MDDV_NM.value      = (selObj.TONGJE_MDDV_NM       == undefined)?"":selObj.TONGJE_MDDV_NM; 		 
    	form1.TONGJE_SMDV_NM.value     	= (selObj.TONGJE_SMDV_NM       == undefined)?"":selObj.TONGJE_SMDV_NM; 	
    	form1.ATTCH_FILE_NO.value 	    = (selObj.ATTCH_FILE_NO        == undefined)?"":selObj.ATTCH_FILE_NO;
    	form1.ATTCH_FILE_NO_R.value 	= (selObj.ATTCH_FILE_NO_R      == undefined)?"":selObj.ATTCH_FILE_NO_R;
    }
    
    //위험평가지표관리 상세 저장
    function doSave(){
    	
    	/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}','WARN'); return;};
    	
        form1.pageID.value 	   = 'RBA_50_05_02_04'; 
        
        form1.PROC_LGDV_C.value      =  $("#TONGJE_LGDV_C").val();
        form1.PROC_MDDV_C.value 	 =  $("#TONGJE_MDDV_C").val();
        form1.PROC_SMDV_C.value      =  $("#TONGJE_SMDV_C").val(); 
        form1.S_TONGJE_NO.value      =  $("#TONGJE_NO").val();  
        form1.S_VALD_VALT_METH_C.value = form1.VALD_VALT_METH_C.value ; // 운영평가방법
        form1.S_VALT_METH_C.value = form1.VALT_METH_C.value ;   // 운영평가유형
        form1.JIPYO_OFF_R.value = form1.TONGJE_SCOR_OFFR_C.value ; //운영평가값산정기준
        
        form1.S_OPR_TP_C_V.value  = form1.OPR_TP_C_V.value  // 운영평가점수코드 
        form1.TONGJE_VALD_PNT.value = form1.OPERATION_VALUE.value == "미완료"?"":form1.OPERATION_VALUE.value ;    //운영평가점수 
        form1.S_DSGN_VALT_TP_C.value = form1.DSGN_VALT_TP_C.value ;  // 설계평가유형 
        form1.S_DSGN_TP_C_V.value = form1.DSGN_TP_C_V.value ;  //설계평가점수코드 
        form1.DSGN_VALT_PNT.value = form1.DESIGN_VALUE.value == "미완료"?"":form1.DESIGN_VALUE.value ;   //설계평가점수   
        form1.ATTCH_FILE_NO    = form1.ATTCH_FILE_NO        
        form1.ATTCH_FILE_NO_R    = form1.ATTCH_FILE_NO_R
        
        form1.VALT_BRNO.value  = "${VALT_BRNO}";  
        form1.BAS_YYMM.value   =  "${BAS_YYMM}";  
        form1.target           = "submitFrame"; 
        form1.action           = "<c:url value='/'/>0001.do";
        form1.encoding         = "multipart/form-data"; 
		form1.submit();
    }
    
  	//위험평가지표관리 상세 end
    function doSaveEnd() {
    	showAlert("${msgel.getMsg('AML_90_01_03_05_001','정상처리되었습니다')}", "WARN");
    	//doSearch();
    	refreshApprovalCount();
    	opener.doSearch();
        window.close();
    } 
  	
  	function doClose(){
  		opener.doSearch();
        window.close();
  	}
  	
  	function doRegister_D(){
  		doRegister("D");
  	}
  	
  	function doRegister_O(){
  		doRegister("O");
  	}
    
    // 수기평가 등록 팝업 호출
    function doRegister(kbn) { 
    	form2.pageID.value     = "RBA_50_05_02_03"; 
        form2.BAS_YYMM.value   =  "${BAS_YYMM}"
        form2.DSGN_VALT_TP_C.value   =  form1.DSGN_VALT_TP_C.value; 
        form2.TONGJE_SCOR_OFFR_C.value   =  form1.TONGJE_SCOR_OFFR_C.value;
        form2.KBN.value        = kbn;
        var win;           win = window_popup_open("RBA_50_05_02_03",  650, 450, '','no');
        form2.target           = form2.pageID.value;
        form2.action           = '<c:url value="/"/>0001.do';
        form2.submit(); 
    }
    
	function chkCommValidation(CHK_GUBN){ 
		//▶전사 AML 내부통제 점검항목 관리  코드값 D01
    	var RBA_VALT_SMDV_C = "D01"
    	
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
	
	//첨부파일 로우 삭제     
	function onDeleteAttachFile( e ) {
		
	    var targEl;
	    if ( !e ) e = window.event;
	    if (e.target) {
	        targEl = e.target;
	    } else if (e.srcElement) {
	        targEl = e.srcElement;
	    }
	                    
	    var pEl = null; 
	    try { pEl = targEl.parentNode.parentNode ; } catch ( e ) {console.log(e); }
	    if ( pEl != null ) {
	        var tbodyObj = pEl.parentNode; 
	        var len = tbodyObj.rows.length; 
	        if ( len == 2 ) {
	            var tabObj = tbodyObj.parentNode;
	            onAddAttachFile( tabObj.id ) ; 
	        }
	                            
	        if ( len < 2 ) {
	            showAlert ( "${msgel.getMsg('lastRowNotDelete','마지막 행은 삭제 할 수 없습니다.')}" , "WARN");
	            return; 
	        }
	        tbodyObj.removeChild( pEl ) ;                                   
	    }
	}
	
	//첨부파일 로우 추가 
	function onAddAttachFile( tabName ) {
	    var tabObj = document.getElementById(tabName);
	    var lastRow = tabObj.rows.item(tabObj.rows.length-1) ;
	    var tr = tabObj.insertRow( tabObj.rows.length ) ;

	         
	    for(i = 0 ; i < lastRow.cells.length ; i ++ ) {
	        var cell = tr.insertCell(i);
	        cell.setAttribute("height","22"); 
	        cell.setAttribute("bgColor","#FFFFFF");
	        cell.setAttribute("align","center");
	        if( i == 0 ) {
	            cell.setAttribute("width","45%");
	            cell.innerHTML =  '<input type="hidden" name="FILE_SER_R" value="0">' 
	                            + '<input type="hidden" name="FILE_POS_temp_R" value="">' 
	                            + '<input type="hidden" name="LOSC_FILE_NM_temp_R" value="">'  
	                            + '<input type="hidden" name="PHSC_FILE_NM_temp_R" value="">' 
	                            + '<input type="hidden" name="FILE_SIZE_temp_R" value="0">' 
	                            + '<input type="hidden" name="DOWNLOAD_CNT_temp_R" value="0">';
	        } else if( i == 1 ) {
	            cell.setAttribute("width","45%");
	            cell.innerHTML ='<input type="file" name="NOTI_ATTACH_R" id="NOTI_ATTACH_R" value="" class="btnS_grey" style="width: 98%;height:22">';
	        } else if( i == 2 ) {							        
				cell.innerHTML = (lastRow.cells[i]).innerHTML;            
	        }
	    }
	}
	
	//첨부파일 다운로드
    function downloadFile( FILE_SER )
    { 
        $("input[name=FILE_SER]").val(FILE_SER);
        form1.target = "_self";
        form1.action = "Package/RBA/common/fileDown/fileDownload.jsp";
        form1.method = "post";  
        form1.submit();
    }
	
    function downloadFile2( FILE_SER_R )
    { 
        $("input[name=FILE_SER_R]").val(FILE_SER_R); 
        
        var copy_ATTCH_FILE_NO = form1.ATTCH_FILE_NO.value; 
        var copy_FILE_SER = form1.FILE_SER.value; 
        
        form1.ATTCH_FILE_NO.value = form1.ATTCH_FILE_NO_R.value;
        form1.FILE_SER.value 	  = form1.FILE_SER_R.value; 
        
        form1.target = "_self";
        form1.action = "Package/RBA/common/fileDown/fileDownload.jsp";
        form1.method = "post";
        form1.submit(); 
         
        form1.ATTCH_FILE_NO.value = copy_ATTCH_FILE_NO;
        form1.FILE_SER.value 	  = copy_FILE_SER; 
    }
    
</script>
<!-- 저장용 iframe -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top"><iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe></td>
    </tr>
</table>
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" > 
    <input type="hidden" name="DSGN_VALT_TP_C" >
    <input type="hidden" name="TONGJE_SCOR_OFFR_C" > 
    <input type="hidden" name="KBN" > 
    
</form>

<form name="form1" id="form1" method="post">
<input type="hidden" name="pageID">
<input type="hidden" name="classID"> 
<input type="hidden" name="methodID">
<input type="hidden" name="GUBN">
<input type="hidden" name="BAS_YYMM" value="${BAS_YYMM}">
<input type="hidden" name="VALT_BRNO" value="${VALT_BRNO}">
<input type="hidden" name="mode">
<input type="hidden" name="TJ_BRNO_CD_LIST" id="TJ_BRNO_CD_LIST">
<input type="hidden" name="ATTCH_FILE_NO">
<input type="hidden" name="ATTCH_FILE_NO_R"> 

<input type="hidden" name="PROC_LGDV_C">
<input type="hidden" name="PROC_MDDV_C">
<input type="hidden" name="PROC_SMDV_C">
<input type="hidden" name="S_TONGJE_NO">
<input type="hidden" name="S_VALD_VALT_METH_C">
<input type="hidden" name="S_VALT_METH_C">
<input type="hidden" name="JIPYO_OFF_R">
<input type="hidden" name="S_OPR_TP_C_V">
<input type="hidden" name="TONGJE_VALD_PNT">
<input type="hidden" name="S_DSGN_VALT_TP_C">
<input type="hidden" name="S_DSGN_TP_C_V">
<input type="hidden" name="DSGN_VALT_PNT">


    
<div class="tab-content-bottom" >
    <table class="basic-table">
        <tr>
        	<th class="title required">${msgel.getMsg('RBA_50_05_01_020','대분류')}</th>
            <td>
            	${SRBACondEL.getSRBASelect('TONGJE_LGDV_C','' ,'' ,'R312' ,'','ALL','nextSelectChangeSRBA("TONGJE_MDDV_C", "FA", this,"")','','','')}
            </td>
            <th class="title required">${msgel.getMsg('RBA_50_05_01_021','중분류')}</th>
            <td style="text-align:left;" colspan="3">
            	${SRBACondEL.getSRBASelect('TONGJE_MDDV_C','' ,'' ,'R313' ,'','ALL','setRSK_INDCT_CD(this)','','','')}
            </td>
        </tr>
        <tr>
        	<th class="title required">${msgel.getMsg('RBA_50_05_01_022','소분류')}</th>
            <td>
            	${SRBACondEL.getSRBASelect('TONGJE_SMDV_C','' ,'' ,'R314' ,'','ALL','','','','')}
            </td>
            <th class="title required">${msgel.getMsg('RBA_50_04_01_021','통제활동코드')}</th>
            <td style="text-align:left;" colspan="3" >
            	<input type="text" name="TONGJE_NO" id="TONGJE_NO" class="cond-input-text" style="text-align:left; width: 100%" readOnly/>
            </td>
        </tr>
        <tr>
        	<th class="title">${msgel.getMsg('RBA_50_04_01_022','통제활동명')}
        	</th>
            <td style="text-align:left;" colspan="4" >
            	<input type="text" name="TONGJE_ACT_TITE" id="TONGJE_ACT_TITE" class="cond-input-text" style="text-align:left; width: 100%"/>
            </td>
        </tr>
        <tr>
            <th class="title">${msgel.getMsg('RBA_50_04_01_005','내부통제')}<br>
            	${msgel.getMsg('RBA_50_04_01_006','점검항목 평가절차')}
            </th>
            <td style="text-align:center;" colspan="4"> 
                <textarea name="TONGJE_ISP_STEP" id="TONGJE_ISP_STEP" style="width:100%;" rows=18 maxlength="1800"></textarea>
            </td>
        </tr>
        <tr> 
            <th  class="title">${msgel.getMsg('RBA_50_04_01_024','설계평가')}<br>
            	${msgel.getMsg('RBA_50_04_01_025','증빙자료')}
            </th>
             <td style="text-align:left;" colSpan="4">
             	<textarea name="DSGN_VALT_PROF" id="DSGN_VALT_PROF" style="width:100%;" rows=7 maxlength="1800"></textarea>
            </td>
        </tr>
		<%
			if(output.getCount("FILE_SER") != 0) {
		%>
		<tr>
			<th style="text-align:left;" >${msgel.getMsg('AML_90_01_03_02_005','첨부파일')}</th>
			<td width="95%" colspan="6">
				<table class="basic-table">
				<!-----------<tr>
				 Add File Start -------->
				<!-- 
				<td valign="top" width="100%" align="right">
					<input type="button" name="fileAdd" id="fileAdd" value='${msgel.getMsg("AML_90_01_03_04_004","파일추가")}' class="flat-btn flat-btn-white" onclick="onAddAttachFile( 'NotiAttachTable' );" title='${msgel.getMsg("AML_90_01_03_04_004","파일추가")}'>
				</td>
				 -->
				<!----------- Add File End 
				</tr>-------->
					<tr>
						<td width="100%" >
							<!------------------------------------------------------------>
							<table class="basic-table" id="NotiAttachTable" style="width:100%; border:0; cellpadding:2; cellspacing:1; bgcolor:''" >
								<tr>
									<th height="22" align="center" style="width:45%">${msgel.getMsg('uploadNewFile','업로드 된 파일')}</th>
									<!-- <th align="center" style="width:50%">${msgel.getMsg('uploadNewFile','업로드 된 파일')}</th> -->
									<!-- <th align="center" style="width:5%">삭제</th>  -->
								</tr>  
							<%
							
							if((output.getCount("FILE_SER") == 0) == false) {
							      String FILE_SER = "";
							      String FILE_POS = "";
							      String LOSC_FILE_NM = "";
							      String PHSC_FILE_NM = "";
							      String FILE_SIZE = "";
							      String DOWNLOAD_CNT = "";
							      
							      for(int i = 0 ; i < output.getCount("FILE_SER") ; i++) {
							          FILE_SER     = output.getText("FILE_SER",i);
							          FILE_POS     = output.getText("FILE_POS",i);
							          LOSC_FILE_NM = output.getText("LOSC_FILE_NM",i);
							          PHSC_FILE_NM = output.getText("PHSC_FILE_NM",i);
							          FILE_SIZE    = output.getText("FILE_SIZE",i);
							          DOWNLOAD_CNT = output.getText("DOWNLOAD_CNT",i);
							          
							          request.setAttribute("FILE_SER",FILE_SER);
							          request.setAttribute("FILE_POS",FILE_POS);
							          request.setAttribute("LOSC_FILE_NM",LOSC_FILE_NM);
							          request.setAttribute("PHSC_FILE_NM",PHSC_FILE_NM);
							          request.setAttribute("FILE_SIZE",FILE_SIZE);
							          request.setAttribute("DOWNLOAD_CNT",DOWNLOAD_CNT);  
							%>
							                       <tr>
							                           <td height="22" align="left" bgcolor="#FFFFFF" >
							                               <img src="Package/ext/images/icon/ico_save.gif" width="13" height="13" align="absmiddle">
							                               <a class="file" href='javascript:downloadFile("${FILE_SER}");'><c:out value='${LOSC_FILE_NM}'/></a>
							                               <input type="hidden" name="FILE_SER"                value="${FILE_SER}">
							                               <input type="hidden" name="FILE_POS_temp"           value="${FILE_POS}">
							                               <input type="hidden" name="LOSC_FILE_NM_temp"       value="${LOSC_FILE_NM}">
							                               <input type="hidden" name="PHSC_FILE_NM_temp"       value="${PHSC_FILE_NM}">
							                               <input type="hidden" name="FILE_SIZE_temp"          value="${FILE_SIZE}">
							                               <input type="hidden" name="DOWNLOAD_CNT_temp"       value="${DOWNLOAD_CNT}">
							                               <input type="hidden" name="FILE_POS${FILE_SER}"     value="${FILE_POS}${PHSC_FILE_NM}">
							                               <input type="hidden" name="LOSC_FILE_NM${FILE_SER}" value="${LOSC_FILE_NM}"> 
							                           </td>
							                           <!-- 
							                           <td align="center" bgcolor="#FFFFFF">
							                               <input type="file" name="NOTI_ATTACH"  id="NOTI_ATTACH" class="btnS_grey" style='width: 98%;height: 22' >
							                           </td>
							                           <td align="center" bgcolor="#FFFFFF">
							                           	<input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('deletebtn','삭제')}" class="flat-btn flat-btn-white" 
							                               onclick="onDeleteAttachFile( event );" title="${msgel.getMsg('deletebtn','삭제')}" style="align:left;">
							                           </td>
							                            -->
							                       </tr>
							<%
							   	}
							}else{
							%>
		                       <tr>
		                           <td height="22" align="left" bgcolor="#FFFFFF">
		                               <input type="hidden" name="FILE_SER" id="FILE_SER" value="0">
		                           </td>
		                           <!-- 
		                           <td align="center" bgcolor="#FFFFFF">
		                               <input type="file" name="NOTI_ATTACH" id="NOTI_ATTACH" class="btnS_grey" style='width:98%;height: 22'>
		                           </td>
		                           <td align="left" bgcolor="#FFFFFF">
		                               <input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('deletebtn','삭제')}" class="flat-btn flat-btn-white" 
		                               onclick="onDeleteAttachFile( event );" title="${msgel.getMsg('deletebtn','삭제')}" style="align:left;">
		                           </td>
		                            -->
		                       </tr>
							<%
							}
							%>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<%
			}
		%>
		<tr>
			<th class="title">${msgel.getMsg('RBA_50_04_01_026','설계평가유형')}</th>
			<td style="text-align:left;">
				${SRBACondEL.getSRBASelect('DSGN_VALT_TP_C','' ,'' ,'R328' ,'','ALL','','','','')} 
			</td>
			<th class="title">${msgel.getMsg('RBA_50_04_01_028','설계/운영평가 부서')}</th>
			<td style="text-align:left;" >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr style="border-bottom: 0px;">
						<td id="DPRT_NM"></td>
					</tr>
				</table> 
			</td>
		</tr>
		<tr>
			<th class="title">${msgel.getMsg('RBA_50_04_01_029','운영평가방법')}</th>
			<td style="text-align:left;">
				${SRBACondEL.getSRBASelect('VALD_VALT_METH_C','' ,'' ,'R329' ,'','ALL','','','','')}
			</td>
			<th class="title">${msgel.getMsg('RBA_50_04_01_027','운영평가유형')}</th>
			<td style="text-align:left;"  >
				${SRBACondEL.getSRBASelect('VALT_METH_C','' ,'' ,'R330' ,'','ALL','','','','')}
			</td>
		</tr>
		<tr>
			<th class="title">${msgel.getMsg('RBA_50_04_01_030','운영평가지표명')}</th>
			<td style="text-align:left;" colspan="4">
				<input type="text" name="OPR_VALT_JIPYO_NM" id="OPR_VALT_JIPYO_NM" class="cond-input-text" style="text-align:left; width: 100%" />
			</td>
		</tr>
		<tr>
			<th class="title">${msgel.getMsg('RBA_50_04_01_031','운영평가값 산정기준')}</th>
			<td style="text-align:left; display:none;" >
				<input type="text" name="TONGJE_SCOR_OFFR_C" id="TONGJE_SCOR_OFFR_C" class="cond-input-text" style="text-align:left; width: 0px">
			</td> 
			<td style="text-align:left;" colspan="4">
				<input type="text" name="TONGJE_SCOR_OFFR_NM" id="TONGJE_SCOR_OFFR_NM" class="cond-input-text" style="text-align:left; width: 100%;">
			</td> 
		</tr>
		<tr>
			<th class="title">${msgel.getMsg('RBA_50_04_01_024','설계평가')}</th> 
			<td style="text-align:left;" >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr style="border-bottom: 0px;">
						<td id="DESIGN_VAL"><input type="text" name="DESIGN_VALUE" id="DESIGN_VALUE" class="cond-input-text" style="text-align:left; width: 100%;  color:red" readonly></td>
						<td id="DESIGN_MODI_BTN_AREA">${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"updateBtn_D", defaultValue:"설계", mode:"U", function:"doRegister_D", cssClass:"btn-36"}')}</td>
					</tr>
				</table> 
			</td>
			<th  class="title">${msgel.getMsg('RBA_50_01_01_244','운영평가값')}</th>   
			<td style="text-align:left;" >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr style="border-bottom: 0px;">
						<td id="OPERATION_VAL"><input type="text" name="OPERATION_VALUE" id="OPERATION_VALUE" class="cond-input-text" style="text-align:left; width: 100%;  color:red" readonly></td></td>
						<td id="OPERATION_MODI_BTN_AREA">${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"updateBtn_O", defaultValue:"운영", mode:"U", function:"doRegister_O", cssClass:"btn-36"}')}</td>
					</tr>
				</table> 
			</td>
		</tr>
		<tr>
			<td style="text-align:left; display:none;" >
				<input type="text" name="TONGJE_LGDV_NM" id="TONGJE_LGDV_NM" class="cond-input-text" style="text-align:left; width: 100%">
			</td> 
			<td style="text-align:left; display:none;" >
				<input type="text" name="TONGJE_MDDV_NM" id="TONGJE_MDDV_NM" class="cond-input-text" style="text-align:left; width: 100%">
			</td> 
			<td style="text-align:left; display:none;" >
				<input type="text" name="TONGJE_SMDV_NM" id="TONGJE_SMDV_NM" class="cond-input-text" style="text-align:left; width: 100%">
			</td>  
			<td style="text-align:left; display:none;" >
				<input type="text" name="DSGN_TP_C_V" id="DSGN_TP_C_V" class="cond-input-text" style="text-align:left; width: 100%">
			</td>
			<td style="text-align:left; display:none;" >
				<input type="text" name="OPR_TP_C_V" id="OPR_TP_C_V" class="cond-input-text" style="text-align:left; width: 100%">
			</td>
		</tr>
              
		<tr style="  height: 200px;">
			<th class="title" style="text-align:left; " >${msgel.getMsg("RBA_50_01_01_243","통제근거 첨부파일")}</th>
			<td width="95%" colspan="6">
				<table style="width:100%">
					<tr style="border-bottom: 0px;">
					<!----------- Add File Start -------->
						<td valign="top" width="100%" align="right">
							<input type="button" name="fileAdd" id="fileAdd" value='${msgel.getMsg("AML_90_01_03_04_004","파일추가")}' class="btn-36" onclick="onAddAttachFile( 'NotiAttachTable_R' );" title='${msgel.getMsg("AML_90_01_03_04_004","파일추가")}'>
						</td>
					<!----------- Add File End -------->
					</tr>
					<tr>
						<td style="width:100% " >
						<!------------------------------------------------------------>
							<table class="basic-table" style="border-top: 0px;">
								<tr style="border-top: 1px solid #ccc;">
									<td class="title" type="hidden" style="border-right: 1px solid #ccc; border-left: 1px solid #ccc;">${msgel.getMsg('RBA_50_01_01_245','업로드 된 파일')}</th>
									<td class="title" style="border-right: 1px solid #ccc;">${msgel.getMsg('RBA_50_01_01_246','새로올릴 파일')}</th>
									<td class="title" style="border-right: 1px solid #ccc;">${msgel.getMsg('RBA_50_01_01_247','삭제')}</th>
								</tr>  
								<%
									if((output2.getCount("FILE_SER") == 0) == false) {
      									String FILE_SER_R = "";
      									String FILE_POS_R = "";
      									String LOSC_FILE_NM_R = "";
      									String PHSC_FILE_NM_R = "";
      									String FILE_SIZE_R = "";
      									String DOWNLOAD_CNT_R = "";
      
										for(int i = 0 ; i < output2.getCount("FILE_SER") ; i++) {
											FILE_SER_R     = output2.getText("FILE_SER",i);
											FILE_POS_R     = output2.getText("FILE_POS",i);
											LOSC_FILE_NM_R = output2.getText("LOSC_FILE_NM",i);
											PHSC_FILE_NM_R = output2.getText("PHSC_FILE_NM",i);
											FILE_SIZE_R    = output2.getText("FILE_SIZE",i);
											DOWNLOAD_CNT_R = output2.getText("DOWNLOAD_CNT",i);
											
											request.setAttribute("FILE_SER_R",FILE_SER_R);
											request.setAttribute("FILE_POS_R",FILE_POS_R);
											request.setAttribute("LOSC_FILE_NM_R",LOSC_FILE_NM_R);
											request.setAttribute("PHSC_FILE_NM_R",PHSC_FILE_NM_R);
											request.setAttribute("FILE_SIZE_R",FILE_SIZE_R);
											request.setAttribute("DOWNLOAD_CNT_R",DOWNLOAD_CNT_R);  
								%>
								<tr style="border-bottom: 0px;"> 
									<td height="22" align="left" bgcolor="blue" style="display: none;" > 
										<input type="hidden" name="FILE_SER" id="FILE_SER" value="0" >
									</td>
									<td style="height: 22px; text-align: left; background-color: #fff; border-right: 1px solid gray;">
										<img src="Package/ext/images/icon/ico_save.gif" width="13" height="13" align="absmiddle">
										<a class="file" href='javascript:downloadFile2("${FILE_SER_R}");'><c:out value='${LOSC_FILE_NM_R}'/></a>
										<input type="hidden" name="FILE_SER_R"                value="${FILE_SER_R}">
										<input type="hidden" name="FILE_POS_temp_R"           value="${FILE_POS_R}">
										<input type="hidden" name="LOSC_FILE_NM_temp_R"       value="${LOSC_FILE_NM_R}">
										<input type="hidden" name="PHSC_FILE_NM_temp_R"       value="${PHSC_FILE_NM_R}">
										<input type="hidden" name="FILE_SIZE_temp_R"          value="${FILE_SIZE_R}">
										<input type="hidden" name="DOWNLOAD_CNT_temp_R"       value="${DOWNLOAD_CNT_R}">
										<input type="hidden" name="FILE_POS_R${FILE_SER_R}"     value="${FILE_POS_R}${PHSC_FILE_NM_R}">
										<input type="hidden" name="LOSC_FILE_NM_R${FILE_SER_R}" value="${LOSC_FILE_NM_R}"> 
									</td>
									<td style="text-align: center; background-color: #fff; border-right: 1px solid gray;">
									    <input type="file" name="NOTI_ATTACH_R"  id="NOTI_ATTACH_R" class="btnS_grey" style='width: 98%;height: 30px' >
									</td>
									<td style="background-color: #fff; border-right: 1px solid gray;">
										<input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('RBA_50_01_01_247','삭제')}" class="btn-36" 
										onclick="onDeleteAttachFile( event );" title="${msgel.getMsg('RBA_50_01_01_247','삭제')}" style="align:left;">
									</td>
								</tr>
								<%
									}
								}else{
								%>
								<tr style="border-bottom: 0px; height: 140px;"> 
									<td height="22" align="left" bgcolor="#FFFFFF" style="border: 1px solid #ccc; border-top: 0px;">
									    <input type="hidden" name="FILE_SER_R" id="FILE_SER_R" value="0">
									</td>
									<td align="center" bgcolor="#FFFFFF" style="border: 1px solid #ccc;  border-top: 0px;">
									    <input type="file" name="NOTI_ATTACH_R" id="NOTI_ATTACH_R" class="btnS_grey" style='width:98%;height: 30px'>
									</td>
									<td bgcolor="#FFFFFF" style="border: 1px solid #ccc;  border-top: 0px;">
									    <input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('RBA_50_01_01_247','삭제')}" class="btn-36" 
										onclick="onDeleteAttachFile( event );" title="${msgel.getMsg('RBA_50_01_01_247','삭제')}" style="align:left;">
									</td>
								</tr>
								<%
									}
								%>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
        
        <div align="right" style="margin-top: 10px">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
            <!-- ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-minus"}')} -->
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
        </div>
    
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />