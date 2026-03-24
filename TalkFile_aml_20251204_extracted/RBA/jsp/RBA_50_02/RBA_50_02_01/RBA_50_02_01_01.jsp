<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_02_01_01.jsp
* Description     : 업무프로세스관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-04-23
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%

%>
<style type="text/css">
    * { white-space: nowrap;}
</style>
<script>
    
    var GridObj1;
    var overlay = new Overlay();
    var classID= "RBA_50_02_01_01";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        setupFilter("init");
        doSearch();
    });
    
    // Initial function
    function init() { initPage(); }
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;    	
    	
    	setupGridFilter2(gridArrs , FLAG);	
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
        
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
            onToolbarPreparing	: makeToolbarButtonGrids,
			 height	:"calc(80vh - 100px)",
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
			    export 					: {allowExportSelectedData : true ,enabled : true ,excelFilterEnabled : true},
			    onExporting: function (e) {
			    	var workbook = new ExcelJS.Workbook();
			    	var worksheet = workbook.addWorksheet("Sheet1");
				    DevExpress.excelExporter.exportDataGrid({
				        component: e.component,
				        worksheet: worksheet,
				        autoFilterEnabled: true,
				    }).then(function(){
				        workbook.xlsx.writeBuffer().then(function(buffer){
				            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}.xlsx");
				        });
				    });
				    e.cancel = true;
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
			        showCheckBoxesMode: "always"
			    },
			    columns: [
			    	{
			            dataField    : "BAS_YYMM",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_001","기준년월")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            visible      : false
			        }, {
			            dataField    : "PROC_FLD_C",
			            caption      : '${msgel.getMsg("RBA_50_02_01_01_100","프로세스영역코드")}',
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
			            allowSorting : true
			        },{
			            dataField    : "PROC_LGDV_C",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_011","코드1")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "PROC_LGDV_NM",
			            caption      : '${msgel.getMsg("RBA_50_04_01_001","대분류")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "PROC_MDDV_C",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_013","코드2")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
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
			            allowSorting : true
			        }, {
			            dataField    : "PROC_SMDV_NM",
			            caption      : '${msgel.getMsg("RBA_50_03_03_003","소분류")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            cssClass     : "link" 
			        },{
			            dataField    : "RSK_CAUS_CTNT",
			            caption      : '${msgel.getMsg("RBA_50_02_01_01_101","위험 내용")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "USYN",
			            caption      : '사용여부코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "USYN_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_01_013","사용여부")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "VALT_BRNO_CNT",
			            caption      : '${msgel.getMsg("RBA_50_02_01_01_102","사용부서 수")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            cssClass     : "link"
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
			            allowSorting : true
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
    }
    
    // 검색조건 셋업
    function setupConditions() {
    	try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,true);
            cbox1.setItemWidths(280, 90, 0);
            cbox1.setItemWidths(280, 90, 1);
            cbox1.setItemWidths(280, 90, 2);
        } catch (e) {
        	showAlert(e.message,'ERR');
        }
    }
    
 // [ make ]
    var saveitemobj;
        /** 툴바 버튼 설정 */
    function makeToolbarButtonGrids(e){

        var cmpnt; cmpnt = e.component;
        var useYN = "${outputAuth.USE_YN  }";  // 사용 유무
        var authC = "${outputAuth.C       }";  // 추가,수정 권한
        var authD = "${outputAuth.D       }";  // 삭제 권한
        if (useYN=="Y") {
            var gridID       = e.element.attr("id");    // 그리드 아이디
            var toolbarItems = e.toolbarOptions.items;
            
            toolbarItems.splice(0, 0, {
                "locateInMenu"  : "auto"
                ,"location"     : "after"
                ,"widget"       : "dxButton"
                ,"name"         : "filterButton"
                ,"showText"     : "inMenu"
                ,"options"      : {
                         "icon"      : "" 
                       	,"elementAttr": { class: "btn-28 filter" }
            			,"text"      : ""       
                        ,"hint"      : '필터'
                        ,"disabled"  : false
                        ,"onClick"   : function(){
							if(gridID=="GTDataGrid1_Area"){
								setupFilter();
							} 
                        }
                 }
            });
        }
    }
    
    
    //업무프로세스 조회
    function doSearch() {
    	
    	overlay.show(true, true);
        
        var classID  = "RBA_50_02_01_01";
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= "RBA_50_02_01_01";
        params.BAS_YYMM     = $("#BAS_YYMM").val();
        params.PROC_FLD_C   = $("#PROC_FLD_C").val(); 
        params.PROC_LGDV_C  = $("#PROC_LGDV_C").val();
        params.PROC_MDDV_C  = $("#PROC_MDDV_C").val();
        params.USYN         = $("#USYN").val();
        params.VALT_METH_C  = $("#VALT_METH_C").val();
     
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }
    
    //업무프로세스 조회 end
    function doSearch_success(gridData, data){
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
    
    function doSearch_fail(){    	 
    	overlay.hide();
    }
    
    //업무프로세스 등록 팝업 호출
    function doRegister() {
    	/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}','WARN'); return;};
      	
        form2.pageID.value      	 = "RBA_50_02_01_02";
    	form2.P_GUBN.value      	 = "0";                 //구분:0 등록 1:수정
    	form2.BAS_YYMM.value 		 = $("#BAS_YYMM").val();
        var win; win = window_popup_open("RBA_50_02_01_02",  920, 610, '','yes');
        form2.target           		 = form2.pageID.value;
        form2.action           		 = '<c:url value="/"/>0001.do';
        form2.submit();
    }
    
    //그리드 클릭 이벤트
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId) {
        
        if(colId == "PROC_SMDV_NM"){
            form2.pageID.value        = "RBA_50_02_01_02";
            form2.P_GUBN.value        = "1";                            //구분:0 등록 1:수정
            form2.PROC_FLD_C.value    = obj.PROC_FLD_C;
            form2.PROC_LGDV_C.value   = obj.PROC_LGDV_C;
            form2.PROC_MDDV_C.value   = obj.PROC_MDDV_C;
            form2.PROC_SMDV_C.value   = obj.PROC_SMDV_C;
            form2.BAS_YYMM.value      = obj.BAS_YYMM;
            var win                   = window_popup_open("RBA_50_02_01_02", 1120, 610, '','yes');
            form2.target              = form2.pageID.value;
            form2.action              = '<c:url value="/"/>0001.do';
            form2.submit();
        } else if(colId == "VALT_BRNO_CNT"){
            form2.pageID.value        = "RBA_50_02_01_03";
            form2.P_GUBN.value        = "1";                            //구분:0 등록 1:수정
            form2.PROC_FLD_C.value    = obj.PROC_FLD_C;
            form2.PROC_LGDV_C.value   = obj.PROC_LGDV_C;
            form2.PROC_MDDV_C.value   = obj.PROC_MDDV_C;
            form2.PROC_SMDV_C.value   = obj.PROC_SMDV_C;
            form2.BAS_YYMM.value      = obj.BAS_YYMM;
            var win; win = window_popup_open("RBA_50_02_01_03", 1200, 600, '','yes');
            form2.target              = "RBA_50_02_01_03";
            form2.action              = '<c:url value="/"/>0001.do';
            form2.submit();
        }
        
        
    }
    
    //업무프로세스 삭제
    function doDelete() {
    	
    	/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}','WARN'); return;};
    	/*업무 실제 종료일자 확인  */   
    	if(!chkCommValidation("CHK_MODIFY_POSSI_REAL_DT")) {showAlert('${msgel.getMsg("RBA_50_02_01_011","해당 업무단계의 실제종료일이 작성되어 있어 수정 불가능 합니다.")}','WARN'); return;};

		var selectedItem = GridObj1.getSelectedRowsData();  
		
        if(selectedItem.length == 0) {
            showAlert('${msgel.getMsg("AML_20_08_02_01_001","선택된 데이터가 없습니다.")}','WARN');
			return;
		}
        
        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

        	var params   = new Object();
        	var methodID = "doDelete";
        	var classID  = "RBA_50_02_01_01";
        	 		
        	params.pageID 	= pageID;
        	params.gridData 	= selectedItem;
        	console.log(params);
        	sendService(classID, methodID, params, doSearch, doSearch); 
        });
    }
    
    function chkCommValidation(CHK_GUBN){
    	
    	//전사업무 프로세스 관리의 코드값 
    	var RBA_VALT_SMDV_C = "B01"
    	
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
<style>
	.inquiry-table .table-cell .title {
    	min-width: 150px;
}
</style>

<form name="form2">
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="P_GUBN" >
    <input type="hidden" name="PROC_FLD_C" >
    <input type="hidden" name="PROC_LGDV_C" >
    <input type="hidden" name="PROC_MDDV_C" >
    <input type="hidden" name="PROC_SMDV_C" >
    <input type="hidden" name="BAS_YYMM" >
</form>
<form name="form">
    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row">
            <div class="table-cell">
                	${condel.getLabel('RBA_50_03_02_001','평가기준월')}
	            	${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_ValtYear','','' ,'' ,'doSearch()')}
            </div>
            <div class="table-cell">
                ${condel.getLabel('RBA_50_02_01_017','영역')}
                <div class="content">
            		${SRBACondEL.getSRBASelect('PROC_FLD_C','' ,'' ,'R303' ,'','ALL','nextSelectChangeSRBA("PROC_LGDV_C", "FA", this,"")','','','')}
            	</div>
            </div>
        </div>
        <div class="table-row">
            <div class="table-cell">
            	${condel.getLabel('RBA_50_02_01_013','사용여부')}
            	<div class="content">
	                <select id='USYN' name='USYN' class="dropdown">
	                     <option class="dropdown-option" value='' SELECTED >::${msgel.getMsg('AML_10_01_01_01_001', '전체')}::</option> 
	                     <option class="dropdown-option" value='1' >Y</option>
	                     <option class="dropdown-option" value='0' >N</option> 
	                 </select>
            	</div>
            </div>
            <div class="table-cell">
                ${condel.getLabel('RBA_50_04_01_001','대분류')}
                <div class="content">
            		${SRBACondEL.getSRBASelect('PROC_LGDV_C','' ,'' ,'R304' ,'','ALL','nextSelectChangeSRBA("PROC_MDDV_C", "FA", this,"")','','','')}
            	</div>
            </div>
       	</div>
        <div class="table-row">
        	<div class="table-cell">
		        	${condel.getLabel('RBA_50_04_01_015','평가방식')}
        		<div class="content">
		            ${SRBACondEL.getSRBASelect('VALT_METH_C','' ,'' ,'R307' ,'','ALL','','','','')}
        		</div>
        	</div>
        	<div class="table-cell">
            	${condel.getLabel('RBA_50_03_02_003','중분류')}
            	<div class="content">
            		${SRBACondEL.getSRBASelect('PROC_MDDV_C','' ,'' ,'R305' ,'','ALL','','','','')}
            	</div>
            </div>
        </div>
    </div>

    <div class="button-area">
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA004", defaultValue:"등록", mode:"C", function:"doRegister", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
    </div>
	<div class="tab-content-bottom" style="margin-top: 8px;">		
            <div id="GTDataGrid1_Area"></div>
    </div>
	<div style="margin-top: 8px">
		<table class="basic-table" >
			<tr><td style="text-align: left; height: 20px; color: blue;">${msgel.getMsg("RBA_50_01_01_213","※ 총위험 평가 방식(자동평가/수기평가)은 배치가 수행되어야 반영됩니다.")}</td></tr>
			<tr><td style="text-align: left; height: 20px; color: blue;">${msgel.getMsg("RBA_50_01_01_214","※ 총위험 평가 방식이 '수기'에서 '자동'으로 변경할 경우 IT와의 혐의가 필요합니다.")}</td></tr>
			<tr><td style="text-align: left; height: 20px; color: blue;">${msgel.getMsg("RBA_50_01_01_215","※ 업무프로세스 관리 배치처리일 작성 후에는 수정 불가능 합니다.")}</td></tr>
     </table>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />