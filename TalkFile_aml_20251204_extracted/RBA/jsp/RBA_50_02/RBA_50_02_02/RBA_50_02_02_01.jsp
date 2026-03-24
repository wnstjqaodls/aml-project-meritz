<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_02_02_01.jsp
* Description     : 부서별업무포르세스 관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-03
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID(); 
	request.setAttribute("ROLE_IDS",ROLE_IDS);
%>
<style type="text/css">
    * { white-space: nowrap;}
</style>
<script>
    
    var GridObj1;
    var overlay = new Overlay();
    var classID  = "RBA_50_02_02_01";
    var pageID  = "RBA_50_02_02_01";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids1();
        setupGrids2();
        
        setupFilter("init");
        setupFilter2("init");
        
        doSearch();
        $("#PROC_MDDV_C").attr("style","width:230px;");
    	$("#btn_04").attr("style","display:none;");
    	$("#btn_05").attr("style","display:none;");
    	$("#btn_06").attr("style","display:none;");
    });
    
    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridObj.title = '${msgel.getMsg("RBA_50_01_01_216","부서목록")}';
    	gridArrs[0] = gridObj;    	
    	
    	setupGridFilter2(gridArrs , FLAG);	
    }
    
    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridObj.title = '${msgel.getMsg("RBA_50_01_01_217","업무프로세스분류")}';
    	gridArrs[1] = gridObj;    	
    	
    	setupGridFilter2(gridArrs , FLAG);	
    }
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids1(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(83vh - 100px)",
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
			    export               : {
			        allowExportSelectedData: true,
			        enabled                : false,
			        excelFilterEnabled     : true,
			        fileName               : "gridExport"
			    },
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
			    onToolbarPreparing   : makeToolbarButtonGrids,
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
			        mode              : "single",
			        selectAllMode     : "allPages",
			        showCheckBoxesMode: "onClick"
			    },
			    /* onToolbarPreparing: function (e) {
			        var toolbarItems = e.toolbarOptions.items;
			        $.each(toolbarItems, function(_, item) {
			            if(item.name == "saveButton" || item.name == "revertButton") {
			                item.options.visible = false;
			            }
			        });
			    }, */
			    columns: [
			        {
			            dataField    : "BAS_YYMM",
			            caption      : '기준년월',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        },{
			            dataField    : "DPRT_CD",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_002","부서코드")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80
			        },  {
			            dataField    : "DPRT_NM",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_003","부서명")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 150
			        },  {
			            dataField    : "AML_TJ_BRNO_YN",
			            caption      : '본점여부코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible      : false
			        }, {
			            dataField    : "TJ_BRNO_YN",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_005","통제부서여부")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80
			        }, {
			            dataField    : "MOFC_BRN_CCD",
			            caption      : '본점/지점코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible      : false,
			            width : 80
			        }, {
			            dataField    : "MOFC_BRN_YN",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_007","본점/지점")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80
			        },  {
			            dataField    : "CNT",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_008","운영개수")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 60
			        },  {
			            dataField    : "GYLJ_S_C",
			            caption      : '결재상태코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            visible : false
			        },  {
			            dataField    : "GYLJ_STEP",
			            caption      : '결재단계',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            width : 80,
			            visible : false
			        },  {
			            dataField    : "GYLJ_S_C_NM",
			            caption      : '결재상태',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            cssClass     : "link",
			            allowSorting : true,
			            width : 80 ,
			            visible : false
			        },  {
			            dataField    : "GYLJ_ID",
			            caption      : '결재ID',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            visible : false 
			        },  {
			            dataField    : "GYLJ_JKW_NM",
			            caption      : '결재자',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            visible : false 
			        },  {
			            dataField    : "GYLJ_G_C",
			            caption      : '결재구분코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            visible : false
			        },  {
			            dataField    : "GYLJ_ROLE_ID",
			            caption      : '결재대상ROLE_ID',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            visible : false
			        },  {
			            dataField    : "FIRST_ROLE_ID",
			            caption      : '결재라인첫번째 결재자',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            visible : false
			        }
			    ],
			    onCellClick: function(e){ 
			        if(e.data ){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }	 
    	}).dxDataGrid("instance");	
    }
    
    function setupGrids2(){
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(83vh - 100px)",
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
			    export               : {
			        allowExportSelectedData: true,
			        enabled                : false,
			        excelFilterEnabled     : true,
			        fileName               : "gridExport"
			    },
			    remoteOperations     : {
			        filtering: false,
			        grouping : false,
			        paging   : false,
			        sorting  : false,
			        summary  : false
			    },
			    editing: {
			        mode         : "batch",
			        allowUpdating: true,
			        allowAdding  : false,
			        allowDeleting: false
			    },
			    onContentReady: function (e) {
			        e.component.columnOption("command:select", "width", 30);
			    },
			    filterRow            : {visible: false},
			    onToolbarPreparing   : makeToolbarButtonGrids,
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
			        mode              : "single",
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
			            allowSorting : true,
			            allowEditing : false,
			            visible      : false
			        },  {
			            dataField    : "PROC_FLD_C",
			            caption      : '영역코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            visible      : false
			        },  {
			            dataField    : "PROC_FLD_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_01_017","영역")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80
			        },  {
			            dataField    : "PROC_LGDV_C",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_011","코드1")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 60 
			        }, {
			            dataField    : "PROC_LGDV_NM",
			            caption      : '${msgel.getMsg("RBA_50_02_02_01_100","대분류명")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80
			        }, {
			            dataField    : "PROC_MDDV_C",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_013","코드2")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80  
			        } , {
			            dataField    : "PROC_MDDV_NM",
			            caption      : '${msgel.getMsg("RBA_50_05_01_021","중분류")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            width : 120 
			        } , {
			            dataField    : "PROC_SMDV_C",
			            caption      : '${msgel.getMsg("RBA_50_05_03_01_015","코드3")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            allowEditing : false,
			            width : 80 
			        }  , {
			            dataField    : "PROC_SMDV_NM",
			            caption      : '${msgel.getMsg("RBA_50_05_01_022","소분류")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowEditing : false,
			            allowSorting : true,
			            width : "80%" 
			        }, {
			            dataField    : "TGT_YN",
			            caption      : '${msgel.getMsg("RBA_50_02_01_001","운영여부")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            lookup: {
			            	dataSource: [{"KEY":"1","VALUE":"Y"},{"KEY":"0","VALUE":"N"}],
			            	displayExpr: "VALUE",
			            	valueExpr: "KEY"
			            },
			            allowEditing    : true,
			            showEditorAlways: true,
			            width        : 80
			            
			        } , {
			            dataField    : "GYLJ_ID",
			            caption      : '결재ID',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible 	 : false
			        } , {
			            dataField    : "GYLJ_S_C",
			            caption      : '결재상태코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible 	 : false
			            
			        }  , {
			            dataField    : "VALT_BRNO",
			            caption      : '부서코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible 	 : false
			            
			        } , {
			            dataField    : "",
			            caption      : '',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width 	 : 10,
			            visible 	 : false
			            
			        }
			    ]
    	}).dxDataGrid("instance");	
    }
    
    // 검색조건 셋업
    function setupConditions() {
    	try {
            var cbox1; cbox1 = new GtCondBox("condBox1",1,true);
            cbox1.setItemWidths(280, 90, 0);
            cbox1.setItemWidths(310, 90, 1);
            cbox1.setItemWidths(220, 90, 2);
            
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
							} else {//gridID=="GTDataGrid3_Area"
								setupFilter2();
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

	        if (authC=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "saveButton") {
	                    item.visible			= false;
                    } 
                });
            }
	        if(gridID=="GTDataGrid2_Area"){
	        	if (authC=="Y"||authD=="Y") {
		            $.each(toolbarItems, function(i, item) {
		                if (item.name === "revertButton") {
		                    item.showText           = "always";
		                  //  item.options.text       = "${msgel.getMsg('AML_00_00_01_01_026','취소')}";
		                    item.options.elementAttr= { class: "btn-28" };
		                    item.options.icon		= "";
		                    item.options.disabled   = false;
		                    return;
		                }
		            });
		        }
		    }
	        
	    }
	}
    
    //Risk Category 조회 
    function doSearch() {
    	var GYLJ_STEPS = $("#GYLJ_STEP").val() ;       //결재단계 
		form.GYLJ_STEP.value = "" ; 
		if (TodoList = parent.getMainsParams("TodoList")){
			var TodoList; TodoList = ""; //초기화 처리 
			parent.setMainsParams(null); // 초기화 처리
			GYLJ_STEPS = "${ROLE_IDS}" ;
			form.GYLJ_STEP.value = GYLJ_STEPS 
		}
		
    	overlay.show(true, true);
    	
    	
    	var classID  = "RBA_50_02_02_01";
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= "RBA_50_02_02_01";
        params.BRNO      	   = $("#SEARCH_DEP_ID").val();     //부서코드
        params.BAS_YYMM        = $("#BAS_YYMM").val();    //평가지준월
        params.AML_TJ_BRNO_YN  = $("#AML_TJ_BRNO_YN").val();  //통제부서여부
        params.MOFC_BRN_CCD    = $("#MOFC_BRN_CCD").val();  //본점/지점여부
        params.GYLJ_STEP       = GYLJ_STEPS;   //결재단계
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
        
    }
    
    //Risk Category end 
    function doSearch_success(gridData, data) {
    	overlay.hide();

        try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
			var row = gridData.length;
			
			 var row = gridData.length;

	            if(row > 0){
	            	GridObj1.refresh().then(function() {
	            		   GridObj1.selectRowsByIndexes(0)
	            	});
	            	Grid1CellClick("GTDataGrid1", gridData[0] );
	            } 	
   		} catch (e) {
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
        function doSearch_fail(){    	 
        	overlay.hide();
        }
    
    //roleID별 버튼 제어
    function setButtonDisplay(P_DPRT_CD,P_GYLJ_ROLE_ID,P_GYLJ_S_C,P_AML_TJ_BRNO_YN,P_FIRST_ROLE_ID,P_SEARCH_YN) {
    	//버튼들 다 보이도록
    	$("#btn_04").attr("style","inline-block;");
    	$("#btn_05").attr("style","inline-block;");
    	$("#btn_06").attr("style","inline-block;");
    	
    	if("Y"== P_SEARCH_YN ) { //조회버튼 눌렀을 때 변수 셋팅
       		var GYLJ_ROLE_ID   =  GridObj1.GRID_DATA[0].GYLJ_ROLE_ID ;
       		var GYLJ_S_C       =  GridObj1.GRID_DATA[0].GYLJ_S_C;
       		var DPRT_CD        =  GridObj1.GRID_DATA[0].DPRT_CD;
       		var AML_TJ_BRNO_YN = GridObj1.GRID_DATA[0].AML_TJ_BRNO_YN;
       		var FIRST_ROLE_ID  = GridObj1.GRID_DATA[0].FIRST_ROLE_ID;
       		var ROLE_ID        = "${ROLE_ID}" ;
       		
    	} else { // 그리드에서 부서 클릭했을 때(gridCellClick했을때) 변수 셋팅
       		var GYLJ_ROLE_ID =  P_GYLJ_ROLE_ID;
       		var GYLJ_S_C     =  P_GYLJ_S_C;
       		var DPRT_CD      =  P_DPRT_CD;
       		var AML_TJ_BRNO_YN = P_AML_TJ_BRNO_YN;
       		var FIRST_ROLE_ID = P_FIRST_ROLE_ID;
       		var ROLE_ID      = "${ROLE_ID}" ;
    	}
    	
    	
    

   		//본점이 아닐때에는 승인관련 버튼 다 삭제
   		if(AML_TJ_BRNO_YN == "0") {
   	    	$("#btn_04").attr("style","display:none;");
   	    	$("#btn_05").attr("style","display:none;");
   	    	$("#btn_06").attr("style","display:none;");
   		}
   		
   		//준법감시부의  지정담당자, 지점책임자 권한이 추가 되었을때에는 승인요청/승인/반려 버튼 disabled되도록 처리
   		//사이트에 맞게 처리
   		if( ("3"== ROLE_ID || "6"== ROLE_ID) && (DPRT_CD=='700' /*준법감시부 코드  */) ){
       		//승인요청버튼 삭제
           	$("#btn_04").attr("style","display:none;");
       		//승인버튼 삭제
           	$("#btn_05").attr("style","display:none;");
           	//반려버튼 삭제
           	$("#btn_06").attr("style","display:none;");
   			
   		}
   		
       		
        //지점담당자 일때 버튼제어 
        if("3"== ROLE_ID ) {
           	//승인버튼 삭제
           	$("#btn_05").attr("style","display:none;");
           	//반려버튼 삭제
           	$("#btn_06").attr("style","display:none;");
           	//결재 roleID가 다르고   결재 상태코드가 없거나  미수행(0),저장(11) 이 아니면 버튼 삭제
           	if( (GYLJ_ROLE_ID != ROLE_ID) && (GYLJ_S_C !="" && GYLJ_S_C !="0" && GYLJ_S_C !="11" ) ) {
           		//승인요청 버튼 삭제
               	$("#btn_04").attr("style","display:none;");	
        	}
           
           	//지점담당자가 들어 왔을때 본점이 아니면 저장바튼 삭제
       		if(AML_TJ_BRNO_YN == "0") {
       	    	$("#btn_02").attr("style","display:none;");
       		}
        //지점책임자 본점책임자 버튼 제어
        } else if("104"== ROLE_ID || "6"== ROLE_ID) {
           	//승인요청 버튼 삭제
           	$("#btn_04").attr("style","display:none;");
           	
           	if(GYLJ_ROLE_ID != ROLE_ID) {
           		//승인버튼 삭제
               	$("#btn_05").attr("style","display:none;");
               	//반려버튼 삭제
               	$("#btn_06").attr("style","display:none;");
        	}
           	
          //지점담당자가 들어 왔을때 본점이 아니면 저장바튼 삭제
       		if("6"== ROLE_ID && AML_TJ_BRNO_YN == "0") {
       	    	$("#btn_02").attr("style","display:none;");
       		}
        //본점담당자
        } else if("4"== ROLE_ID) {
        	
        	/* 본점담당자 승인/반려 버튼 삭제될 경우
        	1.결재단계의 roleID가 자신의 roleID와 다르면 승인/반려버튼 삭제
        	2.결재단계의 roleID와 자신의 roleID 같고 결재 프로세스의 첫번째 roleID가 같으면 승인/반려버튼 삭제   (왜냐하면 결재프로세스 첫단계는 승인요청 버튼만 보여야함)
        	*/
       		if( (GYLJ_ROLE_ID != ROLE_ID) || ((GYLJ_ROLE_ID == ROLE_ID) && (ROLE_ID == FIRST_ROLE_ID))) {
           		//승인버튼 삭제
               	$("#btn_05").attr("style","display:none;");
               	//반려버튼 삭제
               	$("#btn_06").attr("style","display:none;");
           	}
        	
           	// 본점담당자의 부서 (준법감시부) 가 아니거나 결재상태가 '미진행'이나 '저장' 이 아니면 승인요청 버튼 삭제
           	if( (DPRT_CD != "${BDPT_CD}") || (GYLJ_S_C !="" && GYLJ_S_C !="0" && GYLJ_S_C !="11" )) {
           		/* 단 준법결제프로세스인데 반려당한경우는 제외 
           		      --> 결재단계의 roleID와 자신의 roleID 같고 결재 프로세스의 첫번째 roleID가 같은경우
           		*/
           		if( !((GYLJ_ROLE_ID == ROLE_ID) && (ROLE_ID == FIRST_ROLE_ID)) ) {
           			//승인요청 버튼 삭제
                   	$("#btn_04").attr("style","display:none;");	
           		}
           	}
        //나머지 권한들은 다 버튼 없음
        } else {
       		//승인요청버튼 삭제
           	$("#btn_04").attr("style","display:none;");
       		//승인버튼 삭제
           	$("#btn_05").attr("style","display:none;");
           	//반려버튼 삭제
           	$("#btn_06").attr("style","display:none;");
       }
    	
    }
    
    
    //Risk Factor 조회
    function doSearch2() {
    	overlay.show(true, true);
    	
        var classID  = "RBA_50_02_02_01";
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= "RBA_50_02_02_01";
        params.VALT_BRNO    = GridObj1.GRID_DATA[0].DPRT_CD;
        params.BAS_YYMM     = $("#BAS_YYMM").val();    //평가지준월
        params.PROC_FLD_C   = $("#PROC_FLD_C").val();
        params.PROC_LGDV_C  = $("#PROC_LGDV_C").val();
        params.PROC_MDDV_C  = $("#PROC_MDDV_C").val();
        params.TGT_YN  		= $("#TGT_YN").val();
     
        sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
    }
    
    function doSearch2_success(gridData, data){
        try {
        	GridObj2.refresh();
        	GridObj2.option("dataSource",gridData);
        } catch (e) {
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
    function doSave(){
    	/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}','WARN'); return;};
    	
    	var obj1  = GridObj1.getSelectedRowsData()[0];
        if(obj1 == undefined){
        	showAlert('${msgel.getMsg("AML_20_08_04_02_003","지점을 선택해 주세요.")}','WARN');
        	overlay.hide();
        	return;
        }
        
  
		var rowsData = GridObj2.getDataSource().items();
		var gobj; gobj = $('#GTDataGrid2_Area').dxDataGrid('instance');
		gobj.saveEditData();
		showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){

        	var params   = new Object();
        	var methodID = "doSave";
        	var classID  = "RBA_50_02_02_01";
        	 		
        	params.pageID 	= pageID;
        	params.VALT_BRNO  = obj1.DPRT_CD;
        	params.BAS_YYMM   = obj1.BAS_YYMM;
        	params.GYLJ_ID    = obj1.GYLJ_ID;
        	params.GYLJ_G_C   = obj1.GYLJ_G_C ;
        	params.ROLE_ID    = "${ROLE_ID}";
        	params.NOTE_CTNT  = "운영여부 다시 저장 처리";		
        	params.gridData   = rowsData;
        	
        	sendService(classID, methodID, params, doSave_end, doSave_end); 
        });
        
		/* if(!confirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}")) return;

		
		overlay.show(true, true);
		
		var methodID 	= "doSave";
		var obj = new Object();
		
	    obj.pageID     = pageID;
	    obj.classID    = classID;
	    obj.methodID   = methodID;
	    obj.VALT_BRNO  = obj1.DPRT_CD;
	    obj.BAS_YYMM   = obj1.BAS_YYMM;
	    obj.GYLJ_ID    = obj1.GYLJ_ID;
	    obj.GYLJ_G_C   = obj1.GYLJ_G_C ;
	    obj.ROLE_ID    = "${ROLE_ID}";
	    obj.NOTE_CTNT  = "운영여부 다시 저장 처리";

	    GridObj2.save({    
	        actionParam     : obj
	       ,sendFlag        : "ALL" 
	       ,completedEvent  : doSave_end 
	    }); */
    }
    
    function doSave_end(){ 
    	overlay.hide();
    	doSearch();
    }
    
    // 도움말 팝업 호출
    function openHelpPopUp() {
        form2.pageID.value     = "RBA_50_02_02_02";
        var win; win = window_popup_open("RBA_50_02_02_02",  1320, 500, '','yes');
        form2.target           = form2.pageID.value;
        form2.action           = '<c:url value="/"/>0001.do';
        form2.submit();
    }
    
    // 그리드 CellClick function
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){
    	
    	if(colId == "GYLJ_S_C_NM"){                 //결재상태  클릭시 결재상제정보 팝업 호출
            form2.pageID.value     = "RBA_50_02_02_04";
            form2.GYLJ_ID.value    =  obj.GYLJ_ID;
            var win;           win = window_popup_open("RBA_50_02_02_04",  850, 400, '','no');
            form2.target           = form2.pageID.value;
            form2.action           = '<c:url value="/"/>0001.do';
            form2.submit();
        } else {
        	
            overlay.show(true, true);
          
            //setButtonDisplay(obj.DPRT_CD,obj.GYLJ_ROLE_ID,obj.GYLJ_S_C,obj.AML_TJ_BRNO_YN,obj.FIRST_ROLE_ID,"N");
            
           
            var classID  = "RBA_50_02_02_01"; 
            var methodID = "doSearch2";
            var params = new Object();
            params.pageID	= "RBA_50_02_02_01";
            params.RSK_CATG	   = obj.RSK_CATG;
            params.BAS_YYMM    = obj.BAS_YYMM;
            params.VALT_BRNO   = obj.DPRT_CD;
            params.PROC_FLD_C  = $("#PROC_FLD_C").val(); 
            params.PROC_LGDV_C = $("#PROC_LGDV_C").val();
            params.PROC_MDDV_C = $("#PROC_MDDV_C").val();
            params.TGT_YN  = $("#TGT_YN").val();
            sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
        }
    } 
    
    // 승인요청
    function openGyljPopUp0() {
	/* validation 추가 */
        openGyljPopUp(0);
    }
    
 	// 승인
    function openGyljPopUp2() {
   /* validation 추가 */
        openGyljPopUp(2);
    }
    
 	// 반려
    function openGyljPopUp22() {
    /* validation 추가 */
        openGyljPopUp(1);
    }
    
    // 통제활동 운영평가 - 결재(RBA_30_04_03_03) 팝업 호출 function
    function openGyljPopUp(flag) {
        
        form2.pageID.value  = "RBA_50_02_02_03";
        var win; win = window_popup_open("RBA_50_02_02_03", 650, 260, '', 'yes');
        var obj  = GridObj1.getSelectedRowsData()[0];

        if(obj == undefined){
        	showAlert('${msgel.getMsg("AML_20_08_04_02_003","지점을 선택해 주세요.")}','WARN');
        	return;
        }
        
        form2.BAS_YYMM.value    = obj.BAS_YYMM ;       		    //기준년월
        form2.VALT_BRNO.value	= obj.DPRT_CD;
        form2.GYLJ_ID.value     = obj.GYLJ_ID;
        form2.GYLJ_S_C.value    = obj.GYLJ_S_C;
        form2.GYLJ_JKW_NM.value = obj.GYLJ_JKW_NM;
        form2.GYLJ_G_C.value    = obj.GYLJ_G_C;
        form2.FLAG.value    = flag;
        
        form2.target                          = form2.pageID.value;
        form2.action                          = "<c:url value='/'/>0001.do"; 
        form2.submit();
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

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
    <input type="hidden" name="VALT_BRNO" >
    <input type="hidden" name="GYLJ_ID" >
    <input type="hidden" name="GYLJ_S_C" >
    <input type="hidden" name="GYLJ_JKW_NM" >
    <input type="hidden" name="FLAG" >
    <input type="hidden" name="GYLJ_G_C" >
    
</form>
<form name="form">
	<input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="GYLJ_STEP">
    
    
    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row">
            <div class="table-cell">
            	${condel.getLabel('RBA_50_03_02_001','평가기준월')}
	                ${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_ValtYear','','' ,'' ,'doSearch()')}
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
              	${condel.getLabel('RBA_50_01_03_014','부서명')}
            	<div class="content">
            	<%
				  if ("4".equals(ROLE_IDS) || "104".equals(ROLE_IDS) || "7".equals(ROLE_IDS) ) {
				%>
            	<RBATag:searchRbaInput searchName="SEARCH_DEP_ID" searchClass="cond-select" searchStyle="width: 130px;" text1Name="DEP_ID" 
					text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>" 
					searchFunction='doRBASearchInput(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepName2")' 
					popupFunction='doRBASelectInputPopup("searchRbaDepPopup", 480, 580, "SEARCH_DEP_ID", "setRBASearchInputPopup(searchName, searchInfo)")' 
					searchValue="" text1Value="" text2Value='${msgel.getMsg("RBA_50_07_02_01_104","전체")}'/>
				<%
				  } else {
				%>
				<RBATag:searchRbaInput searchName="SEARCH_DEP_ID" searchClass="cond-select" searchStyle="width: 130px;" text1Name="DEP_ID" 
					text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>" 
					searchFunction='doRBASearchInput(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepName2")' 
					popupFunction='doRBASelectInputPopup("searchRbaDepPopup", 480, 580, "SEARCH_DEP_ID", "setRBASearchInputPopup(searchName, searchInfo)")' 
					searchValue="<%=BDPT_CD%>" text1Value="<%=BDPT_CD%>" text2Value="<%=BDPT_CD_NAME%>"/>
				<%
				  }
				%>		
            	</div>
            </div>
            <div class="table-cell">
	          	${condel.getLabel('RBA_50_03_02_003','중분류')}
	          	<div class="content">
		          	${SRBACondEL.getSRBASelect('PROC_MDDV_C','' ,'' ,'R305' ,'','ALL','','','','')}
	          	</div>
          </div>
         </div>
         <div class="table-row">
         	<div class="table-cell"> 
            	${condel.getLabel('RBA_50_02_02_001','통제부서여부')}
            	<div class="content">
	                <select id='AML_TJ_BRNO_YN' name='AML_TJ_BRNO_YN' class="dropdown">
	                     <option value='' SELECTED >::${msgel.getMsg('AML_10_01_01_01_001', '전체')}::</option> 
	                     <option value='1' >Y</option>
	                     <option value='0' >N</option> 
	                 </select>
            	</div>
            </div>
         	<div class="table-cell">
             	${condel.getLabel('RBA_50_02_01_001','운영여부')}
             	<div class="content">
	               <select id='TGT_YN' name='TGT_YN' class="dropdown">
	                   <option value='' SELECTED >::${msgel.getMsg('AML_10_01_01_01_001', '전체')}::</option> 
	                   <option value='1' >Y</option>
	                   <option value='0' >N</option> 
	               </select>
             	</div>
            </div>
         </div>
         <div class="table-row" style="width:100%">
         	<div class="table-cell">
            	${condel.getLabel('RBA_50_02_01_014','본점/지점')}
            	<div class="content">
	                <select id='MOFC_BRN_CCD' name='MOFC_BRN_CCD' class="dropdown">
	                     <option value='' SELECTED >::${msgel.getMsg('AML_10_01_01_01_001', '전체')}::</option> 
	                     <option value='M' >본점</option> 
	                     <option value='B' >지점</option>
	                 </select>
            	</div>
            </div>
            <div class="table-cell"></div>
         </div>
    </div>
        <div class="button-area">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
            <%
				  if ("4".equals(ROLE_IDS) || "104".equals(ROLE_IDS) || "7".equals(ROLE_IDS) ) {
			%>
            ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"reqApprBtn", defaultValue:"승인요청", mode:"U", function:"openGyljPopUp0", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"apprBtn", defaultValue:"승인", mode:"U", function:"openGyljPopUp2", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"denyBtn", defaultValue:"반려", mode:"U", function:"openGyljPopUp22", cssClass:"btn-36"}')} 
            <%
				  }
			%>
            ${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"RBA011", defaultValue:"도움말", mode:"R", function:"openHelpPopUp", cssClass:"btn-36"}')} 
            
        </div>
    </div>
    <!-- <div class="panel panel-primary">
        <div class="panel-footer" >
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
				     <td valign="top" >
				         <div id="GTDataGrid1_Area"  style="width:30vw"></div>
				     </td>
				     <td style="margin-left: 1vw; width: 3vw;" ></td>
				     <td valign="top"  >
				         <div id="GTDataGrid2_Area"  style="width:60vw"></div>
				     </td>
				</tr> 
            </table>
        </div>
    </div> -->
    
    <div class="tab-content-bottom">
		<div class="cont-area3" style="padding-top: 8px;">
			<div class="cont-area3-left" style="width: 35%">
				<div id="GTDataGrid1_Area"></div>
			</div>
			<div class="arrow-area" style="width:2%" align="center"></div>
			<div class="cont-area3-right" style="width: 63%">
				<div id="GTDataGrid2_Area"></div>
			</div>
		</div>	
	</div>
	
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />