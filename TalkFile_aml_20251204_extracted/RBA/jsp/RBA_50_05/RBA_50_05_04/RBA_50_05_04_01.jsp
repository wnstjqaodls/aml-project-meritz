<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_04_01.jsp
* Description     : 잔여위험 등급임계치 관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-05-15
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
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
    var classID= "RBA_50_05_04_01";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
    });
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	
        // 그리드1(Code Head) 초기화
        /* GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_05_04_01_Grid1'
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
		    		           {"dataField": "SNO","caption": '${msgel.getMsg("RBA_50_08_01_02_001","순번")}',"width": 150,"alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}, 
		    		           {"dataField": "GD_S_SECT","caption": '${msgel.getMsg("RBA_50_05_04_01_001","시작점수")}',"width": "150","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}, 
		    		           {"dataField": "SGD_G_C","caption": '${msgel.getMsg("RBA_50_05_04_01_002","시작코드")}',"width": "300","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true},
		    		           {"dataField": "GD_E_SECT","caption": '${msgel.getMsg("RBA_50_05_04_01_003","종료점수")}',"width": 150,"alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}, 
		    		           {"dataField": "EGD_G_C","caption": '${msgel.getMsg("RBA_50_05_04_01_004","종료코드")}',"width": "150","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}, 
		    		           {"dataField": "REMDR_RSK_GD_C","caption": '${msgel.getMsg("RBA_50_05_04_01_005","등급코드")}',"width" : "300","alignment": "left","allowResizing": true,"allowSearch": true,"allowSorting": true,"fixed": true}
    		           
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
        var methodID = "doSearch";
        /* GridObj1.refresh({
            actionParam: {
            	"classID"      : classID,
            	"pageID"       : "RBA_50_05_04_01",
                "methodID"     : methodID,
                "BAS_YYMM" : form.BAS_YYMM.value
            },
            completedEvent: doSearch_end
        }); */

        var params = new Object();
        var methodID = "doSearch";
		var classID  = "RBA_50_05_04_01";
		overlay.show(true, true);
		params.pageID 	= "RBA_50_05_04_01";
		params.BAS_YYMM   = form.BAS_YYMM.value;//기준연도
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
    }
    
    //잔여위험 등급임계치 조회 end
    function doSearch_end(gridData,data) {
        overlay.hide();
        GridObj1.refresh();
        GridObj1.option("dataSource", gridData);  
        setData(gridData);
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
	    		if(i == 0){
	    			form.GD_S_SECT1.value   = (cellData.GD_S_SECT      == undefined) ? "" : cellData.GD_S_SECT;
	    			form.SGD_G_C1.value     = (cellData.SGD_G_C    	   == undefined) ? "" : cellData.SGD_G_C;
	    			
	    		}
	    		if(i == 1){
	    			form.GD_S_SECT2.value   = (cellData.GD_S_SECT      == undefined) ? "" : cellData.GD_S_SECT;
	    			form.GD_E_SECT1.value   = (cellData.GD_E_SECT      == undefined) ? "" : cellData.GD_E_SECT;
	    			form.SGD_G_C2.value     = (cellData.SGD_G_C    	   == undefined) ? "" : cellData.SGD_G_C;
	    			form.EGD_G_C1.value     = (cellData.EGD_G_C    	   == undefined) ? "" : cellData.EGD_G_C;
	    			
	    		}
	    		if(i == 2){
	    			form.GD_E_SECT2.value   = (cellData.GD_E_SECT      == undefined) ? "" : cellData.GD_E_SECT;
	    			form.EGD_G_C2.value     = (cellData.EGD_G_C    	   == undefined) ? "" : cellData.EGD_G_C;
	    			
	    		} 
	    	}
    	}
    }
    
    //잔여위험 등급임계치 저장
	function doSave(){ 
		/*최근 평가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}','WARN'); return;};
    	    	
	   	showConfirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}", "저장", doSave_Action);
	   	
			  /* GridObj1.save({
			    actionParam     : obj
			   ,sendFlag        : "USERDATA"
			   ,completedEvent  : setupGrids
			  }); */
	}

	function doSave_Action(){
		
		var obj = new Object();
		var methodID    = "doSave";
		var classID     = "RBA_50_05_04_01"; 
		obj.pageID      = "RBA_50_05_04_01";
		obj.BAS_YYMM 	= form.BAS_YYMM.value;
		obj.GD_S_SECT1 	= form.GD_S_SECT1.value;
		obj.SGD_G_C1 	= form.SGD_G_C1.value;
		obj.GD_S_SECT2 	= form.GD_S_SECT2.value;
		obj.SGD_G_C2 	= form.SGD_G_C2.value;
		obj.GD_E_SECT1 	= form.GD_E_SECT1.value;
		obj.EGD_G_C1 	= form.EGD_G_C1.value;
		obj.GD_E_SECT2 	= form.GD_E_SECT2.value;
		obj.EGD_G_C2 	= form.EGD_G_C2.value;

		if(!chkPosCon(obj))return;
		
		sendService(classID, methodID, obj, doSave_end, doSave_fail);

	}

	function doSave_end (){
		setupGrids();
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
        if(obj.SGD_G_C1 == "" || obj.SGD_G_C1 == null){
        	showAlert("RED ${msgel.getMsg('RBA_50_05_04_002','등급 시작임계치구분은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_S_SECT2 == "" || obj.GD_S_SECT2 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_001','등급 시작구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.SGD_G_C2 == "" || obj.SGD_G_C2 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_002','등급 시작임계치구분은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_E_SECT1 == "" || obj.GD_E_SECT1 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_003','등급 종료구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.EGD_G_C1 == ""  || obj.EGD_G_C1 == null){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_004','등급 종료임계치구분은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.GD_E_SECT2 == "" || obj.GD_E_SECT2 == null){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_003','등급 종료구간은 필수 값 입니다.')}","WARN");
            return false;
        }
        if(obj.EGD_G_C2 == ""  || obj.EGD_G_C2 == null){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_004','등급 종료임계치구분은 필수 값 입니다.')}","WARN");
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
        if(isNaN(obj.GD_E_SECT1)){
        	showAlert("Yellow ${msgel.getMsg('RBA_50_05_04_006','등급 종료구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        if(isNaN(obj.GD_E_SECT2)){
        	showAlert("Green ${msgel.getMsg('RBA_50_05_04_006','등급 종료구간은 숫자만 입력 가능합니다.')}","WARN");
            return false;
        }
        
        return true;
    }
	 
    function doSetNum(val){
    	if(val == 1){
    		form.GD_E_SECT1.value = form.GD_S_SECT1.value;
    	}
    	if(val == 2){
    		form.GD_E_SECT2.value = form.GD_S_SECT2.value;
    	}
    	if(val == 3){
    		form.GD_S_SECT1.value = form.GD_E_SECT1.value;
    	}
    	if(val== 4){
    		form.GD_S_SECT2.value = form.GD_E_SECT2.value;
    	}
    	
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
    
</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
</form>
<form name="form" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">
     <div class="inquiry-table type1" id='condBox1'>
     	<div class="table-row">
           <div class="table-cell">
	           <div class="title">
	           		<div class="txt">
		           		${msgel.getMsg('RBA_50_10_01_01_001','기준년월')}
	           		</div>
	   			</div>
	      	 	<div class="content">
	      	 		${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'setupGrids()')}
	   	 		</div>
           </div>
     	</div>
    </div>
    <div class="button-area" style="text-align:right">
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn5_035", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
    </div>
    <div class="panel panel-primary" style="margin-top: 10px;">
        <div class="panel-footer" >
            	 <div class="table-box11" >
                	<table width="100%" class="basic-table">
	                    <tr>
	                        <th width="5%" style="text-align:center;">${msgel.getMsg('RBA_50_05_04_007','순번')}</th>
	                        <th width="30%" style="text-align:center;" colspan="2">${msgel.getMsg('RBA_50_05_04_008','등급시작구간')}</th>
	                        <th width="30%" style="text-align:center;" colspan="2">${msgel.getMsg('RBA_50_05_04_009','등급종료구간')}</th>
	                        <th width="15%" style="text-align:center;">${msgel.getMsg('RBA_50_05_04_010','등급')}</th>
	                    </tr>
	                    <tr>
	                        <td width="5%" style="text-align:center; background-color: #dcdcdc; height: 40px; border-bottom: solid 1px #ccc;">1</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_S_SECT1" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(1);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;">
	                        	${SRBACondEL.getSRBASelect('SGD_G_C1','' ,'' ,'R317' ,'','','','','','')}
	                        </td>
	                        <td width="15%" style="text-align:center;" bgcolor="#dcdcdc">100</td>
	                        <td width="15%" style="text-align:center;" bgcolor="#dcdcdc">${msgel.getMsg('RBA_50_05_04_011','이하')}</td>
	                        <td width="15%" style="text-align:center;" bgcolor="red"><b>Red</b></td>
	                    </tr>
	                    <tr>
	                        <td width="5%" style="text-align:center; background-color: #dcdcdc; height: 40px; border-bottom: solid 1px #ccc;">2</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_S_SECT2" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(2);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;">
	                       	 	${SRBACondEL.getSRBASelect('SGD_G_C2','' ,'' ,'R317' ,'','','','','','')}
	                        </td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_E_SECT1" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(3);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;">
	                        	${SRBACondEL.getSRBASelect('EGD_G_C1','' ,'' ,'R317' ,'','','','','','')}
	                        </td>
	                        <td width="15%" style="text-align:center;" bgcolor="yellow"><b>Yellow</b></td>
	                    </tr>
	                    <tr>
	                        <td width="5%" style="text-align:center; background-color: #dcdcdc; height: 40px; border-bottom: solid 1px #ccc;">3</td>
	                        <td width="15%" style="text-align:center;" bgcolor="#dcdcdc">0</td>
	                        <td width="15%" style="text-align:center;" bgcolor="#dcdcdc">${msgel.getMsg('RBA_50_05_04_012','이상')}</td>
	                        <td width="15%" style="text-align:center;">
	                        	<input type="text" class="cond-input-text" name="GD_E_SECT2" value="" style="border: slid 1px #eaeaea; text-align: center;" maxlength="2" onblur ="doSetNum(4);"/>
	                        </td>
	                        <td width="15%" style="text-align:center;">
	                        	${SRBACondEL.getSRBASelect('EGD_G_C2','' ,'' ,'R317' ,'','','','','','')}
	                        </td>
	                        <td width="15%" style="text-align:center;" bgcolor="green"><b>Green</b></td>
                    </table>
                 </div>
        </div>
    </div>
</form>
 <div class="panel panel-primary" style="display: none">
     <div class="panel-footer" >
         <div id="GTDataGrid1_Area"></div>
     </div>
 </div>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />