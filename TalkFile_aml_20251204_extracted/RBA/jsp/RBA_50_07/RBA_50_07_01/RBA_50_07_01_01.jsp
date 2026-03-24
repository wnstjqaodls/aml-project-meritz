<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_07_01_01.jsp
* Description     : 개선목록  POOL관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : SBJ
* Since           : 2018-04-23
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>

<!-- Function Script -->
<script language="JavaScript">
    var GridObj1 = null;
    
    var GridObj1 ;
    var classID  = "RBA_50_07_01_01";
    var overlay  = new Overlay();

    // [ Initialize ]
    $(document).ready(function(){
        setupGrids();
        setupFilter("init");
        doSearch();
    });

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }

    // 그리드 초기화 함수 셋업
    function setupGrids(){
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
       			 height	:"calc(85vh - 100px)",
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
       		        showCheckBoxesMode: "always"
       		        
       		    },
       		    "columns":[
       		    
       		    
       		    		{
       			            "dataField": "POOL_SNO",
       			            "caption": '${msgel.getMsg("RBA_50_08_01_02_001","순번")}',
       			            "width" : 100,
       			            "dataType": "number",
       			            "alignment": "center",
       			            "allowResizing": true,
       			            "allowSearch": true,
       			            "allowSorting": true
       		        	},
       		                           {
       		            "caption": '${msgel.getMsg("RBA_50_07_01_01_001","개선 대응방안 POOL")}',
       		            "alignment": "center",
       		            "columns" : [{
       		               "dataField": "IMPRV_CNFRME",
       		               "caption": '${msgel.getMsg("RBA_50_07_01_01_002","단계별개선대응방안")}',
       		               "cssClass"   : "link",
       		               "width" : 230,
       		               "allowResizing": true,
       		               "allowSearch": true,
       		               "allowSorting": true
       		           },
       		                                {
       		               "dataField": "MAIN_EXEC_CTNT",
       		               "caption": '${msgel.getMsg("RBA_50_07_01_01_003","주요수행내용")}',
       		               "width" : "40%",
       		               "height":"200px",
       		               "allowResizing": true,
       		               "allowSearch": true,
       		               "allowSorting": true
       		           }]
       		        },					{
       		            "caption": '${msgel.getMsg("RBA_50_07_01_01_004","추가입력사항")}',
       		            "alignment": "center",
       		            "columns" :[{
       		              "dataField": "ADD_INP_CTNT",
       		              "caption": '${msgel.getMsg("RBA_50_07_01_01_005","내용(수행계획에 대한 간략한 내용기술)")}',
       		              "width" : "40%",
       		              "allowResizing": true,
       		              "allowSearch": true,
       		              "allowSorting": true
       		               }]
       		        }
       		    ],
       		 	onToolbarPreparing   : makeToolbarButtonGrids,
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
        
        if($("button[id='btn_01']") == null) return;
        
        var params   = new Object();
    	var methodID = "doSearch";
    	var classID  = "RBA_50_07_01_01";
    	 		
    	params.pageID 	= "RBA_50_07_01_01";
    	params.IMPRV_CNFRME 	=  form.IMPRV_CNFRME.value;
    
    	sendService(classID, methodID, params, doSearch_success, doSearch_fail);  
        
    }
    
    //기본조회 end
    function doSearch_success(gridData, data) {//console.log(gridData);
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
            
            form2.pageID.value     = "RBA_50_07_01_02";
            var win;           win = window_popup_open(form2, 700, 700, '', 'yes');
            form2.POOL_SNO.value   = obj.POOL_SNO;
            form2.IMPRV_CNFRME.value   = obj.IMPRV_CNFRME;
           
            form2.target           = form2.pageID.value;
            form2.action           = '<c:url value="/"/>0001.do';
            form2.submit();
        }
    }
    
 	
  //개선목록 등록 팝업 호출                                                                                                                                                                     
    function doRegister() {                                                                                                                                                                       
    	                                                                                                                                                                                            
        form2.P_GUBN.value     = "0";                 //구분:0 등록 1:수정                                                                                                                        
        form2.pageID.value     = "RBA_50_07_01_02";                                                                                                                                               
        var win;          win  = window_popup_open(form2,  700, 700, '','yes');                                                                                                      
        form2.target           = form2.pageID.value;                                                                                                                                              
        form2.action           = '<c:url value="/"/>0001.do';                                                                                                                                     
        form2.submit();                                                                                                                                                                           
    }    
  
   //개선목록 POOL 삭제
    function doDelete() {

    	
		var selectedItem = GridObj1.getSelectedRowsData()[0]; 

        if(selectedItem == null) {
            showAlert('${msgel.getMsg("AML_20_08_02_01_001","선택된 데이터가 없습니다.")}','WARN');
			return;
		}
        
        var rowsData =  GridObj1.getSelectedRowsData(); 
        
        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

        	var params   = new Object();
        	var methodID = "doDelete";
        	var classID  = "RBA_50_07_01_01";
        	 		
        	params.pageID 		= pageID;
        	params.gridData 	= rowsData; 		
        	
        	sendService(classID, methodID, params, doSearch, doSearch); 
        });
    }
   
	//엔터키 입력시 조회(공통함수 적용안되어 직접 작성)
    function enterkey() {
        if (window.event.keyCode == 13) {
             // 엔터키가 눌렸을 때 실행할 내용
             doSearch();
        }
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
	                   	,"elementAttr": { class: "btn-28 filter" }
	        			,"text"      : ""       
	                    ,"hint"      : '필터'
	                    ,"disabled"  : false
	                    ,"onClick"   : function(){
							if(gridID=="GTDataGrid1_Area"){
								setupFilter();
							} else if(gridID=="GTDataGrid2_Area") {
								setupFilter2();
							} else {//gridID=="GTDataGrid3_Area"
								setupFilter3();
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
<form name="form" method="post" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">
<input type="hidden" name="pageID">
<input type="hidden" name="classID"> 
<input type="hidden" name="methodID">
    <div class="inquiry-table type1" id='condBox1'>
    <div class="table-row">
        <div class="table-cell">
        	<div class="title">
        		<div class="txt">${msgel.getMsg("RBA_50_07_01_01_006","단계명")}</div>
        	</div>
			<div class="content">
				<input name="IMPRV_CNFRME" type="text" value="" class="cond-input-text" size="30" >
			</div>
        </div>
    </div>
</div>
    <div class="button-area">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA004", defaultValue:"등록", mode:"R", function:"doRegister", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
    </div>      

<div class="tab-content-bottom" style="margin-top: 8px;">		
        <div id="GTDataGrid1_Area"></div>
</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />
