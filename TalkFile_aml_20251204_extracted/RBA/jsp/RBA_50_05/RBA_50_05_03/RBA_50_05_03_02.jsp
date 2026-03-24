<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_03_02.jsp
* Description     : 잔여위험 등급별구간설정 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : 
* Since           : 
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	
	String BAS_YYMM   = Util.nvl(request.getParameter("BAS_YYMM"));
	
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    
%>
<style type="text/css">
    * { white-space: nowrap;}
.table-box11, .table-box3, .table-box-file {
    margin  : 0;
    padding : 1px;
    display : inline-table;
    width   : 100%;
}
.table-box11 table, .table-box2 table, .table-box3 table, .table-box4 table, .table-box-file table {
    outline : 1px solid #CCCCCC;
    width   : 100%;
}
.table-box11 table tr+tr, .table-box2 table tr+tr, .table-box3 table tr+tr, .table-box4 table tr+tr, .table-box-file table tr+tr {
    border-top : 1px solid #CCCCCC;
}
.table-box-file table tr th {
    font-weight : 700;
    text-align  : center;
}
.table-box11 table tr th, .table-box2 table tr th, .table-box3 table tr th, .table-box4 table tr th {
    border-right    : 1px solid #CCCCCC;
    padding         : 5px 5px;
    background-color: #F3F6FC;
    font-weight     : 700;
    vertical-align  : top;
}
.table-box11 table tr td, .table-box2 table tr td, .table-box3 table tr td {
    padding : 5px 5px;
    border-right    : 1px solid #CCCCCC;
}
</style>
<script language="JavaScript">
    
    var GridObj1;
    var overlay = new Overlay();
    var classID= "RBA_50_05_03_01";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        doChange();
    });
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	
        // 그리드1(Code Head) 초기화
        /* GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_05_03_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(85vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           //,gridHeadTitle   : '잔여위험 등급임계치 관리'
           ,completedEvent  : doSearch
           ,failEvent : doSearch_end
        }); */

        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
  			elementAttr: { class: "grid-table-type" },
        	"width" 						: "100%",
    		"height"						:"calc(85vh - 100px)",
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
    	        enabled: true,
    	        excelFilterEnabled: true,
    	        fileName: "gridExport"
    	    },
    	    sorting: {mode: "multiple"},
    	    loadPanel: {enabled: false},
    	    remoteOperations: {filtering: false,grouping: false,paging: false,sorting: false,summary: false},
    	    editing: { mode: "batch",allowUpdating: false,allowAdding: false,allowDeleting: false},
    	    filterRow: {visible: false},
    	    rowAlternationEnabled: false,
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
    	    onCellPrepared: function(e){
    	        var columnName = e.column.dataField;
    	        var dataGrid	= e.component;
    	        var rowIndex	= dataGrid.getRowIndexByKey(e.key);
    	        var realEdt		= dataGrid.cellValue(rowIndex, 'REAL_EDT');
    	        var valtEdt		= dataGrid.cellValue(rowIndex, 'VALT_EDT');
    	        if(rowIndex != -1){
    	            if(realEdt == ''){
    	                if((valtEdt !='') && (columnName == 'RBA_VALT_LGDV_C_NM' || columnName == 'RBA_VALT_SMDV_C_NM' || columnName == 'VALT_SDT' || columnName == 'VALT_EDT'
    	                    || columnName == 'REAL_EDT' || columnName == 'ROWNUM' || columnName == 'EXP_TRM')){
    	                    e.cellElement.css('background-color', '#FF4848');
    	                }
    	            }
    	        }
    	    },
    	    searchPanel: {visible: false,width: 250},
    	    selection: {allowSelectAll: true,deferred: false,mode: "single", selectAllMode: "allPages", showCheckBoxesMode: "onClick"},
    	    columns: [
    	            {"caption": '잔여위험임계치', "alignment": "center",
    	             "columns": [
		    	               {"dataField": "BAS_YYMM","caption": '${msgel.getMsg("RBA_50_03_02_001","평가년월")}',"width": 150,"alignment": "left", "allowResizing": true, "allowSearch": true, "allowSorting": true,"fixed": true}, 
		    		           {"dataField": "STEP1","caption": '${msgel.getMsg("RBA_50_08_01_02_001","순번")}',"width": 150,"alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}, 
		    		           {"dataField": "GD_S_SECT","caption": '${msgel.getMsg("RBA_50_05_03_01_001","시작점수")}',"width": "150","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}, 
		    		           {"dataField": "SGD_G_C","caption": '${msgel.getMsg("RBA_50_05_03_01_002","시작코드")}',"width": "300","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true},
		    		           {"dataField": "GD_E_SECT","caption": '${msgel.getMsg("RBA_50_05_03_01_003","종료점수")}',"width": 150,"alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}, 
		    		           {"dataField": "EGD_G_C","caption": '${msgel.getMsg("RBA_50_05_03_01_004","종료코드")}',"width": "150","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}, 
		    		           {"dataField": "REMDR_RSK_GD_C","caption": '${msgel.getMsg("RBA_50_05_03_01_005","등급코드")}',"width" : "300","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}
    		           
    		          ] }
    	    ],
    	    onCellClick: function(e){
    	        if(e.data){
    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	    }
        }).dxDataGrid("instance");
        doSearch();
    }
    
    // 검색조건 셋업
    function setupConditions() {
    	try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(280, 90, 0);
            cbox1.setItemWidths(600, 90, 1);
        } catch (e) {
            showAlert(e.message,'ERR');
        }
    }
    
    //잔여위험 등급임계치 조회 
    function doSearch() {
    	
    	overlay.show(true, true);
        var params = new Object();
        var methodID = "doSearch2";
		var classID  = "RBA_50_05_03_01";
		overlay.show(true, true);
		params.pageID 	= "RBA_50_05_03_01";
		params.BAS_YYMM   = "999912";//기준연도
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
    }
    
    //잔여위험 등급임계치 조회 end
    function doSearch_end(gridData,data) {
        overlay.hide();
/*         GridObj1.refresh();
        GridObj1.option("dataSource", gridData);   */
        setData(gridData);
        
        doSearch3();
    }

    function doSearch_fail(){
		console.log("doSearch_fail");	
    }
    
    // HTML에 데이타 삽입
    function setData(gridData){

        
		var cnt = gridData.length;
		
    	if(cnt > 0){
	    	for( i=0; i < cnt ; i++ ) {
	    		var cellData =  gridData[i];
	    		//alert( "set out : [" + i + "]" + cellData.GD_S_SECT + " : " + cellData.GD_E_SECT + " : " +  cellData.REMDR_RSK_GD_C );
	    		
	    		if( cellData.REMDR_RSK_GD_C == "R1") {
	    			//alert( "set out : [" + i + "]" + cellData.GD_S_SECT + " : " + cellData.GD_E_SECT + " : " +  cellData.REMDR_RSK_GD_C + " : " +  cellData.TOP_ACUM_PER);
	    			//form.GD_S_SECT1.value   = (cellData.GD_S_SECT      == undefined) ? "" : cellData.GD_S_SECT;
	    			form.GD_E_SECT1.value   = (cellData.GD_E_SECT  	   == undefined) ? "" : cellData.GD_E_SECT;
	    			form.TOP_ACUM_PER1.value   = (cellData.TOP_ACUM_PER   == undefined) ? "" : cellData.TOP_ACUM_PER;
				} else if( cellData.REMDR_RSK_GD_C == "R2") {
	    			form.GD_S_SECT2.value   = (cellData.GD_S_SECT      == undefined) ? "" : cellData.GD_S_SECT;
	    			form.GD_E_SECT2.value   = (cellData.GD_E_SECT  	   == undefined) ? "" : cellData.GD_E_SECT;
	    			form.TOP_ACUM_PER2.value   = (cellData.TOP_ACUM_PER   == undefined) ? "" : cellData.TOP_ACUM_PER;
				} else if( cellData.REMDR_RSK_GD_C == "R3") {
	    			form.GD_S_SECT3.value   = (cellData.GD_S_SECT      == undefined) ? "" : cellData.GD_S_SECT;
	    			form.GD_E_SECT3.value   = (cellData.GD_E_SECT  	   == undefined) ? "" : cellData.GD_E_SECT;
	    			form.TOP_ACUM_PER3.value   = (cellData.TOP_ACUM_PER   == undefined) ? "" : cellData.TOP_ACUM_PER;
				} else if( cellData.REMDR_RSK_GD_C == "R4") {
	    			form.GD_S_SECT4.value   = (cellData.GD_S_SECT      == undefined) ? "" : cellData.GD_S_SECT;
	    			form.GD_E_SECT4.value   = (cellData.GD_E_SECT  	   == undefined) ? "" : cellData.GD_E_SECT;
	    			form.TOP_ACUM_PER4.value   = (cellData.TOP_ACUM_PER   == undefined) ? "" : cellData.TOP_ACUM_PER;
				} else if( cellData.REMDR_RSK_GD_C == "R5") {
	    			form.GD_S_SECT5.value   = (cellData.GD_S_SECT      == undefined) ? "" : cellData.GD_S_SECT;
	    			//form.GD_E_SECT5.value   = (cellData.GD_E_SECT  	   == undefined) ? "" : cellData.GD_E_SECT;
	    			form.TOP_ACUM_PER5.value   = (cellData.TOP_ACUM_PER   == undefined) ? "" : cellData.TOP_ACUM_PER;
				}
	    	}
	    	
	    	form.GD_S_SECT2_B.value= form.GD_S_SECT2.value;
			form.GD_S_SECT3_B.value= form.GD_S_SECT3.value;
			form.GD_S_SECT4_B.value= form.GD_S_SECT4.value;
			form.GD_S_SECT5_B.value= form.GD_S_SECT5.value;
			                                            
			form.GD_E_SECT1_B.value= form.GD_E_SECT1.value;
			form.GD_E_SECT2_B.value= form.GD_E_SECT2.value;
			form.GD_E_SECT3_B.value= form.GD_E_SECT3.value;
			form.GD_E_SECT4_B.value= form.GD_E_SECT4.value;
			
			form.TOP_ACUM_PER1_B.value= form.TOP_ACUM_PER1.value;
			form.TOP_ACUM_PER2_B.value= form.TOP_ACUM_PER2.value;
			form.TOP_ACUM_PER3_B.value= form.TOP_ACUM_PER3.value;
			form.TOP_ACUM_PER4_B.value= form.TOP_ACUM_PER4.value;
			form.TOP_ACUM_PER5_B.value= form.TOP_ACUM_PER5.value;
    	}
    }
    
    
    
	function doSearch3() {
    	
    	overlay.show(true, true);
        var params = new Object();
        var methodID = "doSearch_3";
		var classID  = "RBA_50_05_03_01";
		overlay.show(true, true);
		params.pageID 	= "RBA_50_05_03_01";
		params.BAS_YYMM   = "${BAS_YYMM}";//기준연도
		
		sendService(classID, methodID, params, doSearch3_end, doSearch3_fail);
    }
	
	function doSearch3_end(gridData,data) {
        overlay.hide();
        setData3(gridData);
        
    }

    function doSearch3_fail(){
		console.log("doSearch_fail");	
    }
    
    
    
    function setData3(gridData){

        
		var cnt = gridData.length;
		
    	if(cnt > 0){
    		var cellData =  gridData[0];
    		form.VAL_H.value =  (cellData.VAL_H  	   == undefined) ? "" : cellData.VAL_H;
    		form.VAL_L.value =  (cellData.VAL_L  	   == undefined) ? "" : cellData.VAL_L;
    		form.STEP1.value =  (cellData.STEP1  	   == undefined) ? "" : cellData.STEP1;
    		form.STEP2.value =  (cellData.STEP2  	   == undefined) ? "" : cellData.STEP2;
    		form.STEP3.value =  (cellData.STEP3  	   == undefined) ? "" : cellData.STEP3;
    		form.STEP4.value =  (cellData.STEP4  	   == undefined) ? "" : cellData.STEP4;
    		form.STEP5.value =  (cellData.STEP5  	   == undefined) ? "" : cellData.STEP5;
    	}
    }
    
    
    //잔여위험 등급임계치 저장
	function doSave(){ 
		    	
	   	showConfirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}", "저장", doSave_Action);
	   	
			  /* GridObj1.save({
			    actionParam     : obj
			   ,sendFlag        : "USERDATA"
			   ,completedEvent  : setupGrids
			  }); */
	}

	function doSave_Action(){
		
		var obj = new Object();
		var methodID    = "doSave2";
		var classID     = "RBA_50_05_03_01"; 
		obj.pageID      = "RBA_50_05_03_02";
		obj.BAS_YYMM 	= "999912";
		
		obj.REMDR_RSK_GD_C1 = "R1";
		obj.REMDR_RSK_GD_C2 = "R2";
		obj.REMDR_RSK_GD_C3 = "R3";
		obj.REMDR_RSK_GD_C4 = "R4";
		obj.REMDR_RSK_GD_C5 = "R5";
		
		obj.GD_S_SECT1 	= "0";		
		obj.GD_E_SECT1 	= form.GD_E_SECT1.value;
		obj.GD_S_SECT2 	= form.GD_S_SECT2.value;
		obj.GD_E_SECT2 	= form.GD_E_SECT2.value;
		obj.GD_S_SECT3 	= form.GD_S_SECT3.value;
		obj.GD_E_SECT3 	= form.GD_E_SECT3.value;
		obj.GD_S_SECT4 	= form.GD_S_SECT4.value;
		obj.GD_E_SECT4 	= form.GD_E_SECT4.value;
		obj.GD_S_SECT5 	= form.GD_S_SECT5.value;
		obj.GD_E_SECT5 	= "999";
		
		//alert( "1");
		
		obj.TOP_ACUM_PER1 = form.TOP_ACUM_PER1.value;
		obj.TOP_ACUM_PER2 = form.TOP_ACUM_PER2.value;
		obj.TOP_ACUM_PER3 = form.TOP_ACUM_PER3.value;
		obj.TOP_ACUM_PER4 = form.TOP_ACUM_PER4.value;
		obj.TOP_ACUM_PER5 = form.TOP_ACUM_PER5.value;

		
		if(!chkPosCon(obj))return;
		//alert( "2");
		sendService(classID, methodID, obj, doSave_end, doSave_fail);

	}

	function doSave_end (){
		doSearch();
	}

	function doSave_fail(){
		console.log("doSave_fail");
	}
	 // 일정수정 날짜 check
    function chkPosCon(obj){
        if(obj.GD_S_SECT1 == "" || obj.GD_S_SECT1 == null){
            showAlert("RED ${msgel.getMsg('RBA_50_05_04_001','등급 시작구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_S_SECT2 == "" || obj.GD_S_SECT2 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_001','등급 시작구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_S_SECT3 == "" || obj.GD_S_SECT3 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_001','등급 시작구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_S_SECT4 == "" || obj.GD_S_SECT4 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_001','등급 시작구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_S_SECT5 == "" || obj.GD_S_SECT5 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_001','등급 시작구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_E_SECT1 == "" || obj.GD_E_SECT1 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_003','등급 종료구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_E_SECT2 == "" || obj.GD_E_SECT2 == null){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_003','등급 종료구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_E_SECT3 == "" || obj.GD_E_SECT3 == null){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_003','등급 종료구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_E_SECT4 == "" || obj.GD_E_SECT4 == null){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_003','등급 종료구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_E_SECT5 == "" || obj.GD_E_SECT5 == null){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_003','등급 종료구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        
        if(isNaN(obj.GD_S_SECT1)){
        	showAlert("RED ${msgel.getMsg('RBA_50_05_04_005','등급 시작구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_S_SECT2)){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_005','등급 시작구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_S_SECT3)){
        	showAlert("RED ${msgel.getMsg('RBA_50_05_04_005','등급 시작구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_S_SECT4)){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_005','등급 시작구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_S_SECT5)){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_005','등급 시작구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        
        if(isNaN(obj.GD_E_SECT1)){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_006','등급 종료구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_E_SECT2)){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_006','등급 종료구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_E_SECT3)){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_006','등급 종료구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_E_SECT4)){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_006','등급 종료구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_E_SECT5)){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_006','등급 종료구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        
        return true;
    }
	 
    function doSetNum(val){
    	
    	if(val == 2){
    		form.GD_E_SECT1.value = form.GD_S_SECT2.value;
    	}
    	if(val == 3){
    		form.GD_E_SECT2.value = form.GD_S_SECT3.value;
    	}
    	if(val == 4){
    		form.GD_E_SECT3.value = form.GD_S_SECT4.value;
    	}
    	if(val == 5){
    		form.GD_E_SECT4.value = form.GD_S_SECT5.value;
    	}
    	
    	if(val == 11){
    		form.GD_S_SECT2.value = form.GD_E_SECT1.value;
    	}
    	if(val == 12){
    		form.GD_S_SECT3.value = form.GD_E_SECT2.value;
    	}
    	if(val == 13){
    		form.GD_S_SECT4.value = form.GD_E_SECT3.value;
    	}
    	if(val == 14){
    		form.GD_S_SECT5.value = form.GD_E_SECT4.value;
    	}
    	
    }
    
    function appro_end() {
        opener.doSearch();
        window.close();
    }
    
	function chkCommValidation(CHK_GUBN){ 
		//▶전사 AML 내부통제 점검항목 관리  코드값 D01
    	var RBA_VALT_SMDV_C = "D01"
    	
    	var callbackfunc = "chkMaxBasYYMM_end";
		var actionName = "com.gtone.rba.common.action.CommonValidationCheckAction";
    	var paramdata = new Object();
    	paramdata.BAS_YYMM = $("#BAS_YYMM").val();
    	paramdata.CHK_GUBN = CHK_GUBN;
    	paramdata.RBA_VALT_SMDV_C = RBA_VALT_SMDV_C;
    	
    	if(chkValidationSync(actionName,paramdata,callbackfunc)){
    		return true;
    	}else {
    		return false;
    	}
    }
	
	function doChange() {
		//alert( "form.contro_sd : " + form.contro_sd.value );
		if( form.contro_sd.value == 1 ) {
			form.TOP_ACUM_PER1.readOnly= true;
			form.TOP_ACUM_PER2.readOnly= true;
			form.TOP_ACUM_PER3.readOnly= true;
			form.TOP_ACUM_PER4.readOnly= true;
			form.TOP_ACUM_PER5.readOnly= true;
			
			form.TOP_ACUM_PER1.value= form.TOP_ACUM_PER1_B.value;
			form.TOP_ACUM_PER2.value= form.TOP_ACUM_PER2_B.value;
			form.TOP_ACUM_PER3.value= form.TOP_ACUM_PER3_B.value;
			form.TOP_ACUM_PER4.value= form.TOP_ACUM_PER4_B.value;
			form.TOP_ACUM_PER5.value= form.TOP_ACUM_PER5_B.value;
			
			form.GD_S_SECT2.readOnly= false;
			form.GD_S_SECT3.readOnly= false;
			form.GD_S_SECT4.readOnly= false;
			form.GD_S_SECT5.readOnly= false;
			
			form.GD_E_SECT1.readOnly= false;
			form.GD_E_SECT2.readOnly= false;
			form.GD_E_SECT3.readOnly= false;
			form.GD_E_SECT4.readOnly= false;
			
		} else {

			form.TOP_ACUM_PER2.readOnly= false;
			form.TOP_ACUM_PER3.readOnly= false;
			form.TOP_ACUM_PER4.readOnly= false;
			form.TOP_ACUM_PER5.readOnly= false;
			
			form.GD_S_SECT2.readOnly= true;
			form.GD_S_SECT3.readOnly= true;
			form.GD_S_SECT4.readOnly= true;
			form.GD_S_SECT5.readOnly= true;
			
			form.GD_E_SECT1.readOnly= true;
			form.GD_E_SECT2.readOnly= true;
			form.GD_E_SECT3.readOnly= true;
			form.GD_E_SECT4.readOnly= true;
			
			
			form.GD_S_SECT2.value= form.GD_S_SECT2_B.value;
			form.GD_S_SECT3.value= form.GD_S_SECT3_B.value;
			form.GD_S_SECT4.value= form.GD_S_SECT4_B.value;
			form.GD_S_SECT5.value= form.GD_S_SECT5_B.value;
			                                              
			form.GD_E_SECT1.value= form.GD_E_SECT1_B.value;
			form.GD_E_SECT2.value= form.GD_E_SECT2_B.value;
			form.GD_E_SECT3.value= form.GD_E_SECT3_B.value;
			form.GD_E_SECT4.value= form.GD_E_SECT4_B.value;
		}
		
	}
	
	function doSetvalue() {

		if( form.contro_sd.value == 1 ) {
		
 		    form.GD_S_SECT2_B.value= form.GD_S_SECT2.value;
			form.GD_S_SECT3_B.value= form.GD_S_SECT3.value;
			form.GD_S_SECT4_B.value= form.GD_S_SECT4.value;
			form.GD_S_SECT5_B.value= form.GD_S_SECT5.value;
			                                            
			form.GD_E_SECT1_B.value= form.GD_E_SECT1.value;
			form.GD_E_SECT2_B.value= form.GD_E_SECT2.value;
			form.GD_E_SECT3_B.value= form.GD_E_SECT3.value;
			form.GD_E_SECT4_B.value= form.GD_E_SECT4.value;
			

			form.GD_S_SECT2.value= form.STEP2.value;
			form.GD_S_SECT3.value= form.STEP3.value;
			form.GD_S_SECT4.value= form.STEP4.value;
			form.GD_S_SECT5.value= form.STEP5.value;
			
			form.GD_E_SECT1.value= form.STEP2.value;
			form.GD_E_SECT2.value= form.STEP3.value;
			form.GD_E_SECT3.value= form.STEP4.value;
			form.GD_E_SECT4.value= form.STEP5.value;
			
			form.TOP_ACUM_PER1.value= form.TOP_ACUM_PER1_B.value;
			form.TOP_ACUM_PER2.value= form.TOP_ACUM_PER2_B.value;
			form.TOP_ACUM_PER3.value= form.TOP_ACUM_PER3_B.value;
			form.TOP_ACUM_PER4.value= form.TOP_ACUM_PER4_B.value;
			form.TOP_ACUM_PER5.value= form.TOP_ACUM_PER5_B.value;
			
		} else {
			form.TOP_ACUM_PER1_B.value= form.TOP_ACUM_PER1.value;
			form.TOP_ACUM_PER2_B.value= form.TOP_ACUM_PER2.value;
			form.TOP_ACUM_PER3_B.value= form.TOP_ACUM_PER3.value;
			form.TOP_ACUM_PER4_B.value= form.TOP_ACUM_PER4.value;
			form.TOP_ACUM_PER5_B.value= form.TOP_ACUM_PER5.value;
		
			form.TOP_ACUM_PER1.value= 100;
			form.TOP_ACUM_PER2.value= 80;
			form.TOP_ACUM_PER3.value= 60;
			form.TOP_ACUM_PER4.value= 40;
			form.TOP_ACUM_PER5.value= 20;
			
			form.GD_S_SECT2.value= form.GD_S_SECT2_B.value;
			form.GD_S_SECT3.value= form.GD_S_SECT3_B.value;
			form.GD_S_SECT4.value= form.GD_S_SECT4_B.value;
			form.GD_S_SECT5.value= form.GD_S_SECT5_B.value;
			                                              
			form.GD_E_SECT1.value= form.GD_E_SECT1_B.value;
			form.GD_E_SECT2.value= form.GD_E_SECT2_B.value;
			form.GD_E_SECT3.value= form.GD_E_SECT3_B.value;
			form.GD_E_SECT4.value= form.GD_E_SECT4_B.value;
		}
    }
    
</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
</form>
<form name="form" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">
     <input type="hidden" name="BAS_YYMM"   value="${BAS_YYMM}">
     <input type="hidden" name="VAL_H"      value="${VAL_H}">
     <input type="hidden" name="VAL_L"      value="${VAL_L}">
     <input type="hidden" name="STEP1"    value="${STEP1}">
     <input type="hidden" name="STEP2"    value="${STEP2}">
     <input type="hidden" name="STEP3"    value="${STEP3}">
     <input type="hidden" name="STEP4"    value="${STEP4}">
     <input type="hidden" name="STEP5"    value="${STEP5}">
     <input type="hidden" name="GD_S_SECT1_B"      value="${GD_S_SECT1_B}">
     <input type="hidden" name="GD_S_SECT2_B"      value="${GD_S_SECT2_B}">
     <input type="hidden" name="GD_S_SECT3_B"      value="${GD_S_SECT3_B}">
     <input type="hidden" name="GD_S_SECT4_B"      value="${GD_S_SECT4_B}">
     <input type="hidden" name="GD_S_SECT5_B"      value="${GD_S_SECT5_B}">
     <input type="hidden" name="GD_E_SECT1_B"      value="${GD_E_SECT1_B}">
     <input type="hidden" name="GD_E_SECT2_B"      value="${GD_E_SECT2_B}">
     <input type="hidden" name="GD_E_SECT3_B"      value="${GD_E_SECT3_B}">
     <input type="hidden" name="GD_E_SECT4_B"      value="${GD_E_SECT4_B}">
     <input type="hidden" name="GD_E_SECT5_B"      value="${GD_E_SECT5_B}">
     <input type="hidden" name="TOP_ACUM_PER1_B"    value="${TOP_ACUM_PER1_B}">
     <input type="hidden" name="TOP_ACUM_PER2_B"    value="${TOP_ACUM_PER2_B}">
     <input type="hidden" name="TOP_ACUM_PER3_B"    value="${TOP_ACUM_PER3_B}">
     <input type="hidden" name="TOP_ACUM_PER4_B"    value="${TOP_ACUM_PER4_B}">
     <input type="hidden" name="TOP_ACUM_PER5_B"    value="${TOP_ACUM_PER5_B}">
     <div class="inquiry-table type1" id='condBox1'>
     	<div class="table-row">
           <div class="table-cell">
	           <div class="title">
	           		<div class="txt">
		           		${msgel.getMsg('RBA_50_03_03_02_001','구간관리기준')}
	           		</div>
	   			</div>	   	 		
	   	 		<div class="content">
				<select name="contro_sd" id="contro_sd" class="dropdown" onChange='doChange()' style="width:200px">
		                <option value='1' SELECTED >잔여위험 점수 기준</option>
		                <option value='2' >상위 누적 백분위(%)</option>
		        </select>
		        </div>
			</div>
     	</div>
    </div>
    <div class="button-area" style="text-align:right">
        ${btnel.getButton(outputAuth, '{btnID:"btn5_035", cdID:"RBA_50_05_03_02", defaultValue:"구간균등분할", mode:"U", function:"doSetvalue", cssClass:"btn-36 filled"}')}
    </div>
    <div class="panel panel-primary" style="margin-top: 10px;">
        <div class="panel-footer" >
            	 <div class="table-box11" >
                	<table width="100%" class="basic-table">
	                    <tr>
	                        <th width="5%" style="text-align:center;" colspan="2" >${msgel.getMsg('RBA_50_03_03_02_003','위험등급')}</th>
	                        <th width="30%" style="text-align:center;" colspan="2">${msgel.getMsg('RBA_50_03_03_02_005','시작값')}</th>
	                        <th width="30%" style="text-align:center;" colspan="2">${msgel.getMsg('RBA_50_03_03_02_006','종료값')}</th>
	                        <th width="15%" style="text-align:center;">${msgel.getMsg('RBA_50_03_03_02_007','상위누적 백분위(%)')}</th>
	                    </tr>
	                    <tr>
	                    	<td width="5%" style="text-align:center;" bgcolor="red"><b></b></td>
	                        <td width="5%" style="text-align:center; background-color: #dcdcdc; color: red; height: 40px; border-bottom: solid 1px #ccc;">R5</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_S_SECT5" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(5);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;" >${msgel.getMsg('RBA_50_03_03_02_008','이상')}</td>
	                        <td width="15%" style="text-align:center;" bgcolor="#dcdcdc">999</td>
	                        <td width="15%" style="text-align:center;" bgcolor="#dcdcdc">${msgel.getMsg('RBA_50_03_03_02_010','이하')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="TOP_ACUM_PER5" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" />
	                        </td>
	                    </tr>
	                    <tr>
	                    	<td width="5%" style="text-align:center;" bgcolor="orange"><b></b></td>
	                        <td width="5%" style="text-align:center; background-color: #dcdcdc; color: orange; height: 40px; border-bottom: solid 1px #ccc;">R4</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_S_SECT4" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(4);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;" >${msgel.getMsg('RBA_50_03_03_02_008','이상')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_E_SECT4" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(14);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;" >${msgel.getMsg('RBA_50_03_03_02_009','미만')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="TOP_ACUM_PER4" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" />
	                        </td>
	                    </tr>
	                    <tr>
	                    	<td width="5%" style="text-align:center;" bgcolor="yellow"><b></b></td>
	                        <td width="5%" style="text-align:center; background-color: #dcdcdc; color: yellow; height: 40px; border-bottom: solid 1px #ccc;">R3</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_S_SECT3" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(3);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;" >${msgel.getMsg('RBA_50_03_03_02_008','이상')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_E_SECT3" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(13);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;" >${msgel.getMsg('RBA_50_03_03_02_009','미만')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="TOP_ACUM_PER3" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" />
	                        </td>
	                    </tr>
	                    <tr>
	                    	<td width="5%" style="text-align:center;" bgcolor="green"><b></b></td>
	                        <td width="5%" style="text-align:center; background-color: #dcdcdc; color: green; height: 40px; border-bottom: solid 1px #ccc;">R2</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_S_SECT2" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(2);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;" >${msgel.getMsg('RBA_50_03_03_02_008','이상')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_E_SECT2" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(12);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;" >${msgel.getMsg('RBA_50_03_03_02_009','미만')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="TOP_ACUM_PER2" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" />
	                        </td>
	                    </tr>
	                    <tr>
	                    	<td width="5%" style="text-align:center;" bgcolor="blue"><b></b></td>
	                        <td width="5%" style="text-align:center; background-color: #dcdcdc; color: blue; height: 40px; border-bottom: solid 1px #ccc;">R1</td>
	                        <td width="15%" style="text-align:center;" bgcolor="#dcdcdc">0</td>
	                        <td width="15%" style="text-align:center;" bgcolor="#dcdcdc">${msgel.getMsg('RBA_50_03_03_02_008','이상')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_E_SECT1" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(11);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;" >${msgel.getMsg('RBA_50_03_03_02_009','미만')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="TOP_ACUM_PER1" value="" style="border: slid 1px #eaeaea; text-align: center;background-color: #dcdcdc;" maxlength="2" readonly />
	                        </td>
	                    </tr>
                    </table>
                 </div>
        </div>
    </div>
    <div class="button-area" style="text-align:center">
        ${btnel.getButton(outputAuth, '{btnID:"btn5_035", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36 filled"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"appro_end", cssClass:"btn-36"}')}
    </div>
</form>
 <div class="panel panel-primary" style="display: none">
     <div class="panel-footer" >
         <div id="GTDataGrid1_Area"></div>
     </div>
 </div>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />