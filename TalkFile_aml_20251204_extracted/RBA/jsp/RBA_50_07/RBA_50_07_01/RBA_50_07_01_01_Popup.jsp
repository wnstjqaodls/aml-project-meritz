<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_07_01_01_Popup.jsp
* Description     : 개선목록  POOL관리 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : SBJ
* Since           : 2018-04-23
--%>

<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %> 
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />

<!-- Function Script -->
<script language="JavaScript">
    var GridObj1 = null;
    
    var GridObj1 ;
    var classID  = "RBA_50_07_01_01";
    var overlay  = new Overlay();

    // [ Initialize ]
    $(document).ready(function(){
        setupGrids();
        doSearch();
    });

    // 그리드 초기화 함수 셋업
    function setupGrids(){
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        		elementAttr: { class: "grid-table-type" },
       			height	:"calc(90vh)",
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
       		    sorting              : {mode: "multiple"},
       		    remoteOperations     : {
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
       		    rowAlternationEnabled: false,
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
       		    "columns":[
       		    
       		    
       		    		{
       			            "dataField": "POOL_SNO",
       			            "caption": "${msgel.getMsg('RBA_50_07_01_01_300','순번')}",
       			            "width" : 100,
       			            "dataType": "number",
       			            "alignment": "center",
       			            "allowResizing": true,
       			            "allowSearch": true,
       			            "allowSorting": true
       		        	},
       		                           {
       		            "caption": "${msgel.getMsg('RBA_50_07_01_01_001','개선 대응방안 POOL')}",
       		            "alignment": "center",
       		            "columns" : [{
       		               "dataField": "IMPRV_CNFRME",
       		               "caption": "${msgel.getMsg('RBA_50_07_01_01_002','단계별개선대응방안')}",
       		               "cssClass"   : "link",
       		               "width" : 250,
       		               "allowResizing": true,
       		               "allowSearch": true,
       		               "allowSorting": true
       		           },
       		                                {
       		               "dataField": "MAIN_EXEC_CTNT",
       		               "caption": "${msgel.getMsg('RBA_50_07_01_01_003','주요수행내용')}",
       		               "width" : "40%",
       		               "height":"200px",
       		               "allowResizing": true,
       		               "allowSearch": true,
       		               "allowSorting": true
       		           }]
       		        },					{
       		            "caption": "${msgel.getMsg('RBA_50_07_01_01_004','추가입력사항')}",
       		            "alignment": "center",
       		            "columns" :[{
       		              "dataField": "ADD_INP_CTNT",
       		              "caption": "${msgel.getMsg('RBA_50_07_01_01_005','내용(수행계획에 대한 간략한 내용기술)')}",
       		              "width" : "40%",
       		              "allowResizing": true,
       		              "allowSearch": true,
       		              "allowSorting": true
       		               }]
       		        }
       		    ],
       		    onCellClick: function(e){
       		        if(e.data){
       		            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
       		        }
       		    }
               }).dxDataGrid("instance");
    }

    //기본 조회 함수
    function doSearch() {
        
        overlay.show(true, true);
        
        var params   = new Object();
    	var methodID = "doSearch";
    	var classID  = "RBA_50_07_01_01";
    	 		
    	params.pageID 		= "RBA_50_07_01_01";
    	params.IMPRV_CNFRME 	= form1.IMPRV_CNFRME.value; 		
    	
    	sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
        
    }
    
    //기본조회 end
    function doSearch_success(gridData, data) {
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
    
 	// Risk Event상세 팝업
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId) {
        if(columnId == "IMPRV_CNFRME") {
            
            var obj                = GridObj1.getRow(rowIdx);
            
            opener.form.POOL_SNO.value  = obj.POOL_SNO;
            opener.form.IMPRV_CNFRME.value  = obj.IMPRV_CNFRME;
            opener.form.MAIN_EXEC_CTNT.value  = obj.MAIN_EXEC_CTNT;
            opener.form.IMPRV_RSLT_CTNT.value  = obj.ADD_INP_CTNT;
            window.close();
            
        }
    }
 	
 	
 	// Risk Event상세 팝업
    function doApply() {
    	
          var obj  = GridObj1.getSelectedRowsData()[0];
          
          opener.form.POOL_SNO.value  = obj.POOL_SNO;
          opener.form.IMPRV_CNFRME.value  = obj.IMPRV_CNFRME;
          opener.form.MAIN_EXEC_CTNT.value  = obj.MAIN_EXEC_CTNT;
          opener.form.IMPRV_RSLT_CTNT.value  = obj.ADD_INP_CTNT;
          window.close();
    }
    
 	
    //개선목록 등록 팝업 호출                                                                                                                                                                     
    function doRegister() {                                                                                                                                                                       
    	                                                                                                                                                                                            
        form2.P_GUBN.value     = "0";                 //구분:0 등록 1:수정                                                                                                                        
        form2.pageID.value     = "RBA_50_07_01_02";                                                                                                                                               
        var win;           win = window_popup_open(form2,  700, 375, '','yes');                                                                                                      
        form2.target           = form2.pageID.value;                                                                                                                                              
        form2.action           = '<c:url value="/"/>0001.do';                                                                                                                                     
        form2.submit();                                                                                                                                                                           
    }   
    
    // 닫기
	function doClose(){
    	
	   window.close();
	}
    
</script>
<form name="form2" method="post" >
<input type="hidden" name="pageID" >
<input type="hidden" name="classID">
<input type="hidden" name="methodID">
<input type="hidden" name="POOL_SNO">
<input type="hidden" name="IMPRV_CNFRME">
<input type="hidden" name="P_GUBN" >
 <!-- 기존 값 조회시 Parameter를 넘긴다 -->
</form>
<!-- Main Body Start -->
<form name="form1" method="post" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">
<input type="hidden" name="pageID">

    <div class="inquiry-table type1" id='condBox1'>
	        <div class="table-row">
	            <div class="table-cell">
            		<div class="title">
            				<div class="txt">${msgel.getMsg('RBA_50_07_01_01_006','단계명')}</div>
            		</div>
           			<div class="content">
						<input name="IMPRV_CNFRME" type="text" value="" class="cond-input-text" size="30" />
           			</div>
        		</div>
        	</div>
	</div>
    	
    <div class="cond-btn-row" style="text-align:right; margin-top: 8px;">
    	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
    </div>
   

<div class="panel panel-primary">
    <div class="panel-footer">
        <div id="GTDataGrid1_Area" style="margin-top: 8px; "></div>
    </div>
</div>
<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">  
	   ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"deployBtn", defaultValue:"적용", mode:"R", function:"doApply", cssClass:"btn-36"}')}
	   ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
</div>	
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />
