<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_03_02.jsp
* Description     : 사용자 변경
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-27
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String BRNO     = request.getParameter("BRNO");
	String BRNO_NM = request.getParameter("BRNO_NM");
	
    request.setAttribute("BRNO",BRNO);
    request.setAttribute("BRNO_NM",BRNO_NM);

%>
<style type="text/css">
    * { white-space: nowrap;}
</style>
<script language="JavaScript">
    
    var GridObj1;
    var overlay = new Overlay();
    var classID  = "RBA_50_01_03_02";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        doSearch();
        setupFilter("init");
    });
    
    // Initial function
    function init() { initPage(); }
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
		gridObj.title    = "${msgel.getMsg('RBA_50_01_03_010','사용자')}";    	
    	gridArrs[0] = gridObj;
    	setupGridFilter2(gridArrs,FLAG);	
	}
    
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
	                   	,"elementAttr": { class: "btn-28 filter popupFilter" }
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
	        var btnLastIndex=0;
	        for(;btnLastIndex<toolbarItems.length; btnLastIndex++){
	            if(toolbarItems[btnLastIndex].widget != "dxButton") {
	                break;
	            }
	        }
	    }
	}
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
        // 그리드1(Code Head) 초기화

        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
			 height	:"calc(50vh)",
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
			    onToolbarPreparing   : makeToolbarButtonGrids,
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
			        allowUpdating: false,
			        allowAdding  : false,
			        allowDeleting: false
			    },
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
			    selection: {
			        allowSelectAll    : true,
			        deferred          : false,
			        mode              : "single",
			        selectAllMode     : "allPages",
			        showCheckBoxesMode: "onClick"
			    },
			    columns: [
			        {
			            dataField    : "USER_ID",
			            caption      : 'USER ID',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : true,
			            visible      : false
			        },{
			            dataField    : "LOGIN_ID",
			            caption      : '${msgel.getMsg("RBA_50_01_03_02_100","사번")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : true
			        }, {
			            dataField    : "USER_NM",
			            caption      : '${msgel.getMsg("RBA_50_01_03_010","사용자")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : true
			        }, {
			            dataField    : "POSITION_NM",
			            caption      : '${msgel.getMsg("RBA_50_08_01_02_003","직급")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : true
			        }, {
			            dataField    : "ROLE_ID",
			            caption      : 'ROLE_ID',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : "15%",
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
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(220, 90, 0);
            cbox1.setItemWidths(220, 90, 1);
            cbox1.setItemWidths(280, 90, 2);
            
        } catch (e) {
            showAlert(e.message,'ERR');
        }
    }
    
    //사용자 조회 
    function doSearch() {
    	overlay.show(true, true);
        
        var params   = new Object();
    	var methodID = "doSearch";
    	var classID  = "RBA_50_01_03_02";
    	 		
    	params.pageID 	= "RBA_50_01_03_02";
    	params.DEP_ID 	= form.DEP_ID.value;
    	params.HGRK_DTL_C 	= form.USER_NM.value;
    	params.USER_NM = form.USER_NM.value; 		
    	sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
    }
    
    //사용자 조회 end
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
    
    // 그리드 CellClick function
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId){
		$("input[name='AuthChk']")[0].checked = false;
		$("input[name='AuthChk']")[1].checked = false;
		$("input[name='AuthChk']")[2].checked = false;
		$("input[name='AuthChk']")[3].checked = false;
 		form2.USER_ID.value = obj.USER_ID;
    	if(obj.ROLE_ID != ''){
    		var RCD; RCD = obj.ROLE_ID.split(',');
    		
     		if(RCD[0] == '3'){
     			$("input[name='AuthChk']")[0].checked = true;
    		}else if(RCD[0] == '6'){
    			$("input[name='AuthChk']")[1].checked = true;
    		}else if(RCD[0] == '4'){
    			$("input[name='AuthChk']")[2].checked = true;
    		}else if(RCD[0] == '5'){
    			$("input[name='AuthChk']")[3].checked = true;
    		}
     		if(RCD[1] == '3'){
     			$("input[name='AuthChk']")[0].checked = true;
    		}else if(RCD[1] == '6'){
    			$("input[name='AuthChk']")[1].checked = true;
    		}else if(RCD[1] == '4'){
    			$("input[name='AuthChk']")[2].checked = true;
    		}else if(RCD[1] == '5'){
    			$("input[name='AuthChk']")[3].checked = true;
    		}
     		if(RCD[2] == '3'){
     			$("input[name='AuthChk']")[0].checked = true;
    		}else if(RCD[2] == '6'){
    			$("input[name='AuthChk']")[1].checked = true;
    		}else if(RCD[2] == '4'){
    			$("input[name='AuthChk']")[2].checked = true;
    		}else if(RCD[2] == '5'){
    			$("input[name='AuthChk']")[3].checked = true;
    		}
     		if(RCD[3] == '3'){
     			$("input[name='AuthChk']")[0].checked = true;
    		}else if(RCD[3] == '6'){
    			$("input[name='AuthChk']")[1].checked = true;
    		}else if(RCD[3] == '4'){
    			$("input[name='AuthChk']")[2].checked = true;
    		}else if(RCD[3] == '5'){
    			$("input[name='AuthChk']")[3].checked = true;
    		}
    	}
    }
    
    //사용자 권한 변경
	function doSaveAuth(){
    	
		var HD_MAG_F ="1";
		
		// 2019.10.01 jsw 삭제
		//if($("input[name='AutoYN']")[0].checked ==false ){HD_MAG_F="0";}
				
    	var authVal = '';
    	var pVal01 = '';
    	var pVal02 = '';
    	var pVal03 = '';
    	var pVal04 = '';
		if($("input[name='AuthChk']")[0].checked == true){
			pVal01 = $("input[name='AuthChk']")[0].value;
		}else{
			pVal01 = '0';
		}
		if($("input[name='AuthChk']")[1].checked == true){
			pVal02 = $("input[name='AuthChk']")[1].value;
		}else{
			pVal02 = '0';
		}
		if($("input[name='AuthChk']")[2].checked == true){
			pVal03 = $("input[name='AuthChk']")[2].value;
		}else{
			pVal03 = '0';
		}
		if($("input[name='AuthChk']")[3].checked == true){
			pVal04 = $("input[name='AuthChk']")[3].value;
		}else{
			pVal04 = '0';
		}
		authVal = pVal01+','+pVal02+','+pVal03+','+pVal04;
		
        if(form2.USER_ID.value == ""){
            showAlert('<fmt:message key="RBA_50_01_03_001" initVal="사용자를 선택 해 주세요."/>','WARN');
            return false;
        }
        
        showConfirm('<fmt:message key="AML_10_14_01_01_003" initVal="처리하시겠습니까?"/>', "처리",function(){
        	 var rowsData     = GridObj1.getSelectedRowsData(); 
        	var params   = new Object();
         	var methodID = "doSaveAuth";
         	var classID  = "RBA_50_01_03_02";
         	 		
         	params.pageID 	= "RBA_50_01_03_02";
         	params.authVal          = authVal;
         	params.USER_ID   		= form2.USER_ID.value;
         	params.HD_MAG_F         = HD_MAG_F;
         	params.gridData			= rowsData;
         	
         	sendService(classID, methodID, params, setupGrids, setupGrids); 
        });	

	    
	}
    // 팝업 close
    function appro_end() {
        $("button[id='btn_01']").prop('disabled', false);
        opener.doSearch();
        window.close();
    }
    
</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
  	<input type="hidden" name="USER_ID" >
</form>
<form name="form" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">
	<div class="tab-content-bottom">
		<div class="linear-table" id="condBox1">
			<div class="table-row">
				<div class="table-cell">
					${condel.getLabel('RBA_50_01_03_008','부서')}
					<div class="content" style="padding: 3px 6px !important;">
						<input name="HGRK_BRNO_NM" type="text" value="${BRNO_NM}" class="cond-input-text" size="33" readonly="readonly"/>
						<input name="DEP_ID" type="hidden" value="${BRNO}" class="cond-input-text" size="25"/>
					</div>
				</div>
				<div class="table-cell">
					${condel.getLabel('RBA_50_01_03_009','이름')}
					<div class="content" style="padding: 3px 6px !important;">
						<input name="USER_NM" type="text" value="" class="cond-input-text" size="34"/>
					</div>
				</div>
			</div>  
		</div>
	    
	    <div class="button-area" style="display: flex; justify-content: flex-end; margin-top: 8px; margin-bottom: 8px;">
			${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSaveAuth", cssClass:"btn-36"}')}
		</div>
	
		<div class="grid-half-wrap">
			<div id="GTDataGrid1_Area" style="width: 49%; display: inline-block;"></div>
			<div style="width: 49%; float: right;">
				<h4 class="tab-content-title" style="margin-top: 2px; margin-bottom: 10px;">${msgel.getMsg('RBA_50_01_03_011','권한')}</h4>
				<table class="grid-table-type">
					<thead class="table-head" style="height: 37.4px !important">
						<tr>
							<th>${msgel.getMsg('RBA_50_01_03_002','사용자 권한 선택 유형')}</th>
							<th style="width: 40%;">${msgel.getMsg('RBA_50_01_03_003','권한여부')}</th>
						</tr>  
					</thead>
					<tbody>
						<tr>	                    
							<td style="text-align: center; height: 36.4px !important; border-right: 1px solid #e9eaeb !important;">${msgel.getMsg('RBA_50_01_03_004','지점 담당자')}</td>
							<td style="text-align: center;">
								<input type="checkbox" id="checkbox1" name="AuthChk" value="3">
								<label for="checkbox1"></label>
							</td>
						</tr> 
						<tr>
							<td style="text-align: center; border-right: 1px solid #e9eaeb !important;">${msgel.getMsg('RBA_50_01_03_005','지점 책임자')}</td>
							<td style="text-align: center;">
								<input type="checkbox" id="checkbox2" name="AuthChk" value="6">
								<label for="checkbox2"></label>
							</td>
						</tr>   
						<tr>
							<td style="text-align: center; border-bottom-color: #ddd !important; border-right: 1px solid #e9eaeb !important;">${msgel.getMsg('RBA_50_01_03_006','본점 담당자')}</td>
							<td style="text-align: center;">
								<input type="checkbox" id="checkbox3" name="AuthChk" value="4">
								<label for="checkbox3"></label>
							</td>
						</tr>   
						<tr>
							<td style="text-align: center; border-right: 1px solid #e9eaeb !important; border-bottom: 1px solid #e9eaeb !important;">${msgel.getMsg('RBA_50_01_03_007','본점 책임자')}</td>
							<td style="text-align: center; border-bottom: 1px solid #e9eaeb !important;">
								<input type="checkbox" id="checkbox4" name="AuthChk" value="5">
								<label for="checkbox4"></label>
							</td>
						</tr>   
					</tbody> 
				</table>
			</div>
		</div>
		
		<p style="color: blue; font-size: 12px; margin-top: 8px;white-space:normal;">
			${msgel.getMsg('RBA_50_01_01_212','※ 본점책임자는 준법감시인 , 본점담당자는 법규준수팀의 AML/RBA담당자 , 그 외 본부부서 및 영업점은 지점담당자와 지점책임자 권한 부여')}
		</p>

		<div class="button-area" style="display: flex; justify-content: flex-end; margin-top: 8px;">
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"appro_end", cssClass:"btn-36"}')}
		</div>
	</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />