<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.gtone.aml.server.util.AMLMenu"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_05_01.jsp
* Description     : 부서별 위험평가 현황관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-05-17
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    request.setAttribute("ROLE_IDS",ROLE_IDS);
    
    DataObj input = new DataObj();
    input.add("ROLE_ID" ,ROLE_ID);
    input.add("LANG_CD" ,request.getAttribute("LANG_CD"));
    input.add("GROUP_ID",GROUP_ID);
    String menuarr = AMLMenu.getInstance().getMenuArrayStr(input);
    request.setAttribute("menudata", menuarr);
%>
<script src="${path}/Kernel/ext/jannex/js/util/c-util.js"></script>
<script language="JavaScript">
    
    var GridObj1;
    var GridObj2;
    var classID = "RBA_50_05_05_01";
    var overlay = new Overlay();
    
    var menu;
    var mdata = ${menudata};
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        setupFilter("init");
    });

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }
    
    // Initial function
    function init(){
        initPage();
    }
    
    // 검색조건 셋업
    function setupConditions(){
        try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(150, 100, 0);
            cbox1.setItemWidths(100, 70, 1);
            cbox1.setItemWidths(100, 140, 2);
            cbox1.setItemWidths(140, 120, 3);
        } catch (e) {
            showAlert(e.message,'ERR');
        }
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
    	/* GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_05_05_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 150px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           //,gridHeadTitle   : '부서별 위험평가 현황관리'
           ,completedEvent  : function(){
               setupGridFilter([GridObj1]);
               doSearch();
               
               //첨부파일 그리드
        	   GridObj2 = initGrid3({
                   gridId          : 'GTDataGrid1'
                  ,headerId        : 'RBA_50_01_01_01_Grid1'
                  ,gridAreaId      : 'GTDataGrid2_Area'
                  ,height          : 'calc(90vh - 150px)'
                  ,useAuthYN       : '${outputAuth.USE_YN}'
                  ,gridHeadTitle   : ''
                  ,completedEvent  : function(){
                      setupGridFilter([GridObj1, GridObj2]);
                      if(form.BAS_YYMM.value != ''){
                    	  doSearch2(); 
                      }
                      
                   }
               }); 
            }
        });*/
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
        	"width" 						: "100%",
    		"height"						:"calc(89vh - 150px)",
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
    	    export               : {allowExportSelectedData: true,enabled: true,excelFilterEnabled: true,fileName: "gridExport"},
    	    sorting              : {mode: "multiple"},
    	    loadPanel            : {enabled: false},
    	    remoteOperations     : {filtering: false, grouping : false, paging   : false,sorting  : false,summary  : false},
    	    editing: { mode: "batch",allowUpdating: false,allowAdding  : false,allowDeleting: false},
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
    	        var columnName = e.column.dataField;
    	        var dataGrid   = e.component;
    	    },
    	    searchPanel: {visible: false,width  : 250},
    	    selection: {allowSelectAll: true, deferred: false, mode: "single", selectAllMode: "allPages",showCheckBoxesMode: "onClick"},
    	    columns: [
    	        {dataField: "ROWNUM",caption: '${msgel.getMsg("RBA_50_08_01_02_001","순번")}',alignment: "center", allowResizing: true, allowSearch: true,allowSorting : true, width: "60",fixed: true}, 
    	        {dataField: "BRNO",caption: '${msgel.getMsg("RBA_50_05_05_01_001","부서")}',alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,width: "100",visible: false, fixed: true}, 
    	        {dataField: "VALT_BRNM",caption: '${msgel.getMsg("RBA_50_05_05_01_002","부서명")}',alignment: "center",allowResizing: true, allowSearch: true, allowSorting: true, width: "120",fixed: true},  
    	        {"dataField": "","caption": '${msgel.getMsg("RBA_50_05_05_01_003","총위험(수기)평가")}',"alignment": "center",
    	         "columns" : [
    	               {"dataField": "VALT01","caption": '${msgel.getMsg("RBA_50_05_05_01_004","대상")}',"width": "8%","alignment": "right","allowResizing": true,"allowSearch": true,"allowSorting": true}, 
    		           {"dataField": "VALT02","caption": '${msgel.getMsg("RBA_50_05_05_01_005","완료")}',"width" : "8%","alignment": "right","allowResizing": true,"allowSearch": true,"allowSorting": true}, 
    		           {"dataField": "VALT03","caption": '${msgel.getMsg("RBA_50_05_05_01_006","미완료")}',"width" : "8%","cssClass": "link","alignment": "right","allowResizing": true,"allowSearch": true,"allowSorting": true}, 
    		           {"dataField": "VALT04","caption": '${msgel.getMsg("RBA_50_05_05_01_007","진행상태")}',"width" : "10%","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true}]},  
    		    {"dataField": "","caption": '${msgel.getMsg("RBA_50_05_05_01_008","통제(유효성)평가")}',"alignment": "center",
    	         "columns" : [
    	               {"dataField": "VALT11","caption": '${msgel.getMsg("RBA_50_05_05_01_004","대상")}',"width" : "8%","alignment": "right","allowResizing": true,"allowSearch": true, "allowSorting": true}, 
    		           {"dataField": "VALT12","caption": '${msgel.getMsg("RBA_50_05_05_01_005","완료")}',"width" : "8%", "alignment": "right","allowResizing": true,"allowSearch": true,"allowSorting": true}, 
    		           {"dataField": "VALT13","caption": '${msgel.getMsg("RBA_50_05_05_01_006","미완료")}',"width" : "8%","cssClass": "link","alignment": "right","allowResizing": true,"allowSearch": true,"allowSorting": true}, 
    		           {"dataField": "VALT14","caption": '${msgel.getMsg("RBA_50_05_05_01_007","진행상태")}',"width" : "10%","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true}
    		           ]},  
    		     {"dataField": "","caption": '${msgel.getMsg("RBA_50_05_05_01_009","개선방안수립")}',"alignment": "center",
    		      "columns" : [
    	               {"dataField": "VALT21","caption": '${msgel.getMsg("RBA_50_05_05_01_004","대상")}', "width" : "8%","alignment": "right","allowResizing": true,"allowSearch": true,"allowSorting": true}, 
    		           {"dataField": "VALT22","caption": '${msgel.getMsg("RBA_50_05_05_01_005","완료")}',"width" : "8%","alignment": "right","allowResizing": true,"allowSearch": true,"allowSorting": true}, 
    		           {"dataField": "VALT23","caption": '${msgel.getMsg("RBA_50_05_05_01_006","미완료")}',"width" : "8%","cssClass": "link","alignment": "right","allowResizing": true,"allowSearch": true,"allowSorting": true}, 
    		           {"dataField": "VALT24","caption": '${msgel.getMsg("RBA_50_05_05_01_007","진행상태")}',"width" : "10%","alignment": "center","allowResizing": true,"allowSearch": true,"allowSorting": true}
    		           ]}, 
    	         {dataField: "MAIL_SEND",caption: '${msgel.getMsg("RBA_50_05_05_01_010","담당자 메일전송")}',alignment: "center",allowResizing: true,"cssClass": "link",allowSearch: true,allowSorting: true,width: "14%",visible: false}
    	    ],
    	    onToolbarPreparing   : makeToolbarButtonGrids,
    	    onCellClick: function(e){
    	        if(e.data){
    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    	        }
    	    }
    		
        }).dxDataGrid("instance");

        GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
           	"width" 						: "100%",
       		"height"						:"calc(90vh - 150px)",
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
       	    export               : {allowExportSelectedData: true,enabled: true,excelFilterEnabled: true,fileName: "gridExport"},
       	    sorting              : {mode: "multiple"},
       	    loadPanel            : {enabled: false},
       	    remoteOperations     : { filtering: false,grouping : false, paging   : false, sorting  : false, summary  : false},
       	    editing: { mode: "batch",allowUpdating: false, allowAdding  : false, allowDeleting: false},
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
       	        var realEdt            = dataGrid.cellValue(rowIndex, 'REAL_EDT');
       	        var valtEdt            = dataGrid.cellValue(rowIndex, 'VALT_EDT');
       	        var rba_valt_smdv_c_nm = dataGrid.cellValue(rowIndex, 'RBA_VALT_SMDV_C_NM'); 
       	        if(rowIndex != -1){
       	            if(realEdt == ''){
       	                if((valtEdt !='') 
       	                && (columnName == 'RBA_VALT_LGDV_C_NM' 
       	                 || columnName == 'RBA_VALT_SMDV_C_NM' 
       	                 || columnName == 'VALT_SDT' 
       	                 || columnName == 'VALT_EDT'
       	                 || columnName == 'REAL_EDT' 
       	                 || columnName == 'ROWNUM' 
       	                 || columnName == 'EXP_TRM')){
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
       	    searchPanel: { visible: false,width: 250},
       	    selection: {allowSelectAll: true,deferred: false,mode: "multiple",selectAllMode: "allPages",showCheckBoxesMode: "onClick"},
       	    columns: [
       	        {dataField: "ROWNUM",caption: '${msgel.getMsg("RBA_50_08_01_02_001","순번")}',alignment: "center",allowResizing: true,allowSearch: true, allowSorting : true, width: "60px",fixed: true}, 
       	        {dataField: "RBA_VALT_LGDV_C", caption: '${msgel.getMsg("RBA_50_05_01_020","대분류")}',alignment: "left",allowResizing: true,allowSearch: true,allowSorting : true,width: "100px",visible: false}, 
       	        {dataField: "RBA_VALT_LGDV_C_NM",caption: '${msgel.getMsg("RBA_50_05_01_020","대분류")}',alignment: "left",allowResizing: true,allowSearch: true,allowSorting : true,width: "160px",fixed: true}, 
       	        {dataField: "RBA_VALT_SMDV_C",caption: '${msgel.getMsg("RBA_50_01_01_011","구분")}',alignment: "left",allowResizing: true,allowSearch: true,allowSorting : true,width: "50px",visible: false}, 
       	        {dataField: "RBA_VALT_SMDV_C_NM",caption: '${msgel.getMsg("RBA_50_01_01_011","구분")}', alignment: "left",allowResizing: true,allowSearch: true,allowSorting : true,width: "350px",fixed: true}, 
       	        {dataField: "EXP_TRM",caption: '${msgel.getMsg("RBA_50_01_01_011","예상소요시간(주)")}',alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true,width: "100px"}, 
       	        {dataField: "VALT_SDT",caption: '${msgel.getMsg("RBA_50_01_01_016","업무시작일")}', cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
       	            		alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true,width: "80px"},
       	        {dataField: "VALT_EDT",caption: '${msgel.getMsg("RBA_50_01_01_017","업무종료일")}',cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
       	            		alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, width: "80px"}, 
       	        {dataField: "REAL_EDT",caption: '${msgel.getMsg("RBA_50_01_01_015","배치처리일")}',cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
       	            alignment: "center",allowResizing: true,allowSearch  : true,allowSorting : true,width: "80px"}, 
       	        {caption: '${msgel.getMsg("RBA_50_05_01_101","대상거래")}',alignment: "center",
               	           columns: [{ dataField: "TGT_TRN_SDT",caption: '${msgel.getMsg("RBA_50_05_01_102","시작일")}',cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
       			            		   alignment: "center",allowResizing: true,allowSearch  : true,allowSorting : true,width: "110px"}, 
       			        			 {dataField: "TGT_TRN_EDT",caption: '${msgel.getMsg("RBA_50_05_01_103","종료일")}',cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
         			              alignment: "center", allowResizing: true,allowSearch: true, allowSorting : true, width: "110px"}]  }, 
     		{dataField: "EXEC_B_BRNO_YN",caption: '${msgel.getMsg("RBA_50_05_01_104","AML주관부서")}', alignment: "center",allowResizing: true, allowSearch: true,allowSorting : true,width: "100px",visible: false}, 
       	        {dataField: "EXEC_B_BRNO_YN_NM",caption: '${msgel.getMsg("RBA_50_05_01_104","AML주관부서")}',alignment: "center",allowResizing: true,allowSearch  : true, allowSorting : true,width: "100px"}, 
       	     	{dataField: "EXEC_S_BRNO_YN",caption: '${msgel.getMsg("RBA_50_05_01_104","AML주관부서")}',alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,width: "80px",visible: false}, 
       	        {dataField: "EXEC_S_BRNO_YN_NM",caption: '${msgel.getMsg("RBA_50_05_01_105","현업부서")}',alignment: "center",allowResizing: true,allowSearch  : true,allowSorting : true,width: "80px"}, 
       	        {dataField: "CHG_DT",caption: '${msgel.getMsg("RBA_50_05_01_106","변경일자")}',cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
       	            		alignment: "center",allowResizing: true,allowSearch: true, allowSorting : true,width: "80px"}, 
       	        {dataField: "CHG_OP_JKW_NO", caption: '${msgel.getMsg("RBA_50_05_01_107","변경자")}',alignment: "center",allowResizing: true,allowSearch  : true,allowSorting : true,width: "7%"}, 
       	        {dataField: "FIX_YN",caption: '${msgel.getMsg("RBA_50_01_01_001","확정여부")}',alignment: "center", allowResizing: true,allowSearch: true,allowSorting : true,width: "7%",visible: false},
       	        {dataField: "ING_STEP",caption: '${msgel.getMsg("RBA_50_01_01_002","배치여부")}',alignment: "center", allowResizing: true,allowSearch: true,allowSorting : true, width: "7%", visible: false},
       	        {dataField: "ING_STEP_NM",caption: '${msgel.getMsg("RBA_50_01_01_044","배치상태")}',alignment: "center",allowResizing: true,allowSearch: true, allowSorting : true, width: "7%", visible: false},
       	        {dataField: "ATTCH_FILE_NO",caption: '${msgel.getMsg("RBA_50_05_01_108","첨부파일번호")}',alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true,width: "7%",visible: false},
       	        {dataField: "BAT_STATE",caption: '${msgel.getMsg("RBA_50_01_01_044","배치상태")}',alignment: "center",allowResizing: true,allowSearch: true, allowSorting : true,width: "7%",visible: false},
       	        {dataField: "BAT_ING_STEP",caption: '${msgel.getMsg("RBA_50_05_01_109","배치")}',alignment: "center", allowResizing: true,allowSearch: true,allowSorting : true,width: "7%", visible: false}, 
       	        {dataField: "REAL_BAS_YN", caption: '${msgel.getMsg("RBA_50_05_01_110","RBA 실제 평가 기준년월 여부")}',alignment: "center",allowResizing: true,allowSearch  : true, allowSorting : true, width: "7%",visible: false	}
       	    ],
       	 	onToolbarPreparing   : makeToolbarButtonGrids,
       	    onCellClick: function(e){
       	        if(e.data){
       	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
       	        }
       	    }
       		
        }).dxDataGrid("instance"); 
        doSearch();		
        if(form.BAS_YYMM.value != ''){
         	  doSearch2(); 
        }  
    }
    
    // 부서별 위험평가 현황관리 조회
    function doSearch(type){
        /* GridObj1.refresh({
            actionParam: {
                "pageID"  : pageID,
                "classID" : classID,
                "methodID": methodID,
                "BAS_YYMM"  : form.BAS_YYMM.value,
                "VALT_BRNO"  : form.VALT_BRNO.value
            },
            completedEvent:    doSearch_end
            ,failEvent:doSearch_end
        }); */

        GridObj1.clearSelection();
        GridObj1.option('dataSource', []);
        
        var params = new Object();
        var methodID = "doSearch";
		var classID  = "RBA_50_05_05_01";
		overlay.show(true, true);
		params.pageID 	= pageID;
		params.BAS_YYMM   = form.BAS_YYMM.value;
		params.VALT_BRNO   = form.VALT_BRNO.value;

		/* console.log("1"+methodID);
		console.log("2"+classID);
		console.log("3"+pageID);
		console.log("4"+BAS_YYMM);
		console.log("5"+VALT_BRNO);
		 */
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
    }
    
    // 부서별 위험평가 현황관리 end 
    function doSearch_end(gridData, data){
        overlay.hide();
        GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
        
    }

    function doSearch_fail(){
		console.log("doSearch_fail");
    } 
    
    
    //그리드 Grid1CellClick function
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){
		menu = new GtMenu({"isadmin":true});
        menu.makeMenu(mdata, "#left-menu-root", "type1");
        
        parent.setMainsParams({"BRNO":obj['BRNO'],"tabID":1,"BAS_YYMM":form.BAS_YYMM.value});     //넘겨줄 파라미터값
        
    	if(colId == "VALT03"){
    		if(obj.VALT03 > 0){
    	         parent.goMenu("RBA_50_05_01"); //호출화면의 부모창아이디
    		}
    	}
    	if(colId == "VALT13"){
    		if(obj.VALT13 > 0){
    			parent.goMenu("RBA_50_05_02"); //호출화면의 부모창아이디
    		}
    	}
     	if(colId == "VALT23"){
    		if(obj.VALT23 > 0){
    			parent.goMenu("RBA_50_07_02"); //호출화면의 부모창아이디
    		}
    	}

     	if(colId == "MAIL_SEND"){ 
            form2.DPRT_CD.value    = obj.BRNO;                 //구분:0 등록 1:수정
            form2.pageID.value     = "RBA_50_05_05_03";
            var win; win = window_popup_open(form2,  950, 800, '','no');
            form2.target           = form2.pageID.value;
            form2.action           = '<c:url value="/"/>0001.do';
            form2.submit();
    	}
     	
     	
    }
    
    function goMenu(menuID) {
        try {
            $("#"+menuID).click();
            return menu.selMenu(menuID);
        } catch (e) {
            showAlert(e,'ERR');
        }
    }
    
    // params 객체 값이 널이면 form2 히든값을을 모두 지우고, 값이 있으면 해당 값들을 입력한다.
    function setMainsParams(params) {
        if (params) {
            for (var key in params){
            	$("#"+key,"#form2").length?$("#"+key,"#form2").val(params[key]):$("#form2").append($("<input type='hidden' id='"+key+"' name='"+key+"' value='"+params[key]+"'></input>"))
            }
        } else {
            $("input[type=hidden]","#form2").each(function(idx,obj){
                $(obj).val("");
            });
        }
    }
    
    // 마감처리
    function doEnd(val){
        
        var rowsData = GridObj1.getDataSource().items();
        var ING_STEP = val;
        var methodID = "doEnd";
        var REAL_EDT = "";
        
        if(val == '20'){
            if(form.rskyn.value == 'N'){
            	REAL_EDT = "Y";
            }
        }else{
            if(form.tongyn.value == 'N'){
            	REAL_EDT = "Y";
            }
        }
        
        if(val =='20'  && GridObj2.getKeyByRowIndex(5).REAL_EDT == ''){
            showAlert("${msgel.getMsg('RBA_50_05_05_01_013','전사 AML 내부통제 점검항목 관리 종료처리를 해야 마감처리 할 수 있습니다.')}","WARN");
         }else if(val =='30' && GridObj2.getKeyByRowIndex(9).REAL_EDT == ''){
            showAlert("${msgel.getMsg('RBA_50_05_05_01_014','총위험평가 마감처리를 먼저 하세요.')}","WARN");
         }else if(val =='20' && GridObj2.getKeyByRowIndex(10).REAL_EDT != ''){
            showAlert("${msgel.getMsg('RBA_50_05_05_01_015','통제평가가 마감처리되어 마감처리를 취소 할 수 없습니다.')}","WARN");
          }else{
        	
	        if(!showConfirm("${msgel.getMsg('RBA_50_05_05_01_016','처리 하시겠습니까?')}")) return;
	        
	        var cpc = chkPosCon(val);
	        if(cpc == "0"){
	               /* GridObj1.save({
	                   actionParam: {
	                       "pageID"     : pageID,
	                       "classID"    : classID,
	                       "methodID"   : methodID,
	                       "BAS_YYMM"   : form.BAS_YYMM.value,
	                       "ING_STEP"   : ING_STEP,
	                       "REAL_EDT"   : REAL_EDT,
	                       "FIX_YN"     : "1"
	                   },
	                   sendFlag      : "USERDATA",
	                   userGridData  : rowsData,
	                   completedEvent: doEnd_end
	               }); */

	            
	            var params = new Object();
	            var methodID = methodID;
	    		var classID  = classID;
	    		overlay.show(true, true);
	    		params.pageID 	= pageID;
	    		params.BAS_YYMM   = form.BAS_YYMM.value;
	    		params.ING_STEP   = ING_STEP;
	    		params.REAL_EDT   = REAL_EDT;
	    		params.GRID_DATA	= rowsData;
	    		params.FIX_YN   = "1";
	    		
	    		sendService(classID, methodID, params, doEnd_end, doEnd_fail);
	               
	            
	          }else{
				if(val == 20){
					showAlert("${msgel.getMsg('RBA_50_05_05_002','부서별 총위험평가가 완료된 후 마감이 가능합니다.')}","WARN");
				}else if(val == 30){
					showAlert("${msgel.getMsg('RBA_50_05_05_003','부서별 통제평가가 완료된 후 마감이 가능합니다.')}","WARN");
				}
	        } 
        }
    }
    
    function doEnd_end(){
        overlay.hide();
        doSearch2();
    }

    function doEnd_fail(){
        console.log("doEnd_fail");
    }
    // 마감 체크 스크립트
    function chkPosCon(val){
        var flag = "0";
        if(val =="20"){
        	//위험평가 마감처리 확인
        	for (var i = 0; i < GridObj1.rowCount(); i++) {
                var rowobj = GridObj1.getRow(i);
                if(rowobj.VALT03 > 0){
                    flag = "1";
                    return flag;
                }
            }	
        } else if(val=="30"){
        	//통제평가 마감처리 확인
        	for (var i = 0; i < GridObj1.rowCount(); i++) {
                var rowobj = GridObj1.getRow(i);
                if(rowobj.VALT13 > 0){
                    flag = "1";
                    return flag;
                }
            }        	
        }
        
        return flag;
    }
    
    
    // 위험평가 일정관리 조회
    function doSearch2(){
    	
        overlay.show(true, true);

        /* GridObj2.refresh({
            actionParam: {
                "pageID"  : pageID,
                "classID" : "RBA_50_01_01_01",
                "methodID": methodID,
                "BAS_YYMM": form.BAS_YYMM.value //기준연도
            },
            completedEvent:    doSearch2_end
            ,failEvent:doSearch2_end
        }); */
        
        var params = new Object();
        var methodID = "doSearch";
		var classID  = "RBA_50_01_01_01";
		overlay.show(true, true);
		params.pageID 	= pageID;
		params.BAS_YYMM   = form.BAS_YYMM.value;

		sendService(classID, methodID, params, doSearch2_end, doSearch2_fail);
        
       
    }
    
    // 위험평가 일정관리 조회 end
    function doSearch2_end(gridData, data){
    	 overlay.hide();
    	 
    	GridObj2.refresh();
    	GridObj2.option("dataSource", gridData);
		    	
         var rskyn = "";
         var tongyn = "";
         var jiyn = "";
         jiyn = (data.GRID_DATA[5].REAL_EDT == "") ? "N":"Y";
         rskyn = (data.GRID_DATA[9].REAL_EDT == "") ? "N":"Y";
         tongyn = (data.GRID_DATA[10].REAL_EDT == "") ? "N":"Y";
         form.rskyn.value = rskyn;
         form.tongyn.value = tongyn;
         form.jiyn.value = jiyn; 
         

    } 

    function doSearch2_fail(){
		console.log("doSearch2_fail");
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
<!-- MAIN FORM -->
<form name="form2" id="form2">
	<input type="hidden" name="DPRT_CD" id="DPRT_CD">
	<input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
</form>

<form name="goform" id="goform">
	<input type="hidden" name="BRNO" id="BRNO">
</form>
<form name="form" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
    <input type="hidden" name= "jiyn">
    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row">
            <div class="table-cell">
	            <div class="title" style="min-width: 165px;">
					<div class="txt">${msgel.getMsg('RBA_50_10_01_01_001','기준년월')}</div>
				</div>
				<div class="content">
					<RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="Y" eventFunction='setupGrids()'/>
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
			         	<RBATag:searchRbaInput searchName="VALT_BRNO" searchClass="cond-select" searchStyle="width: 130px;" text1Name="DEP_ID" 
					text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>" 
					searchFunction='doRBASearchInput(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepName2")' 
					popupFunction='doRBASelectInputPopup("searchRbaDepPopup", 480, 580, "VALT_BRNO", "setRBASearchInputPopup(searchName, searchInfo)")' 
					searchValue="" text1Value="" text2Value="${msgel.getMsg('RBA_50_07_02_01_104','전체')}"/>
				<%
				  } else {
				%>
				<RBATag:searchRbaInput searchName="VALT_BRNO" searchClass="cond-select" searchStyle="width: 130px;" text1Name="DEP_ID" 
					text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>" 
					searchFunction='doRBASearchInput(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepName2")' 
					popupFunction='doRBASelectInputPopup("searchRbaDepPopup", 480, 580, "VALT_BRNO", "setRBASearchInputPopup(searchName, searchInfo)")' 
					searchValue="<%=BDPT_CD%>" text1Value="<%=BDPT_CD%>" text2Value="<%=BDPT_CD_NAME%>"/>
				<%
				  }
				%>
				</div>	
            </div>
	    </div>
	    <div class="table-row">
	    	<div class="table-cell">
	    		<div class="title" style="min-width: 270px;">
					<div class="txt">${msgel.getMsg('RBA_50_05_05_01_011','총위험평가마감여부')}</div>
				</div>
				<div class="content">
					<input type="text" name= "rskyn" size="2" class="cond-input-text" style="text-align:center" readonly="readonly" />
				</div>
            </div>
	    </div>
	    <div class="table-row">
	    	<div class="table-cell">
	    		<div class="title">
					<div class="txt">${msgel.getMsg('RBA_50_05_05_01_012','통제평가 마감여부')}</div>
				</div>
				<div class="content">
					<input type="text" name= "tongyn" size="2" class="cond-input-text" style="text-align:center" readonly="readonly" />
				</div>
            </div>
	    </div>
	</div>
	<div class="button-area" style="text-align:right">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		<%
			if ("4".equals(ROLE_IDS) || "104".equals(ROLE_IDS) || "7".equals(ROLE_IDS) ) {
		%>
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA024", defaultValue:"총위험평가 마감", mode:"U", function:"doEnd(20)", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA025", defaultValue:"통제평가 마감", mode:"U", function:"doEnd(30)", cssClass:"btn-36"}')}
		<%
			}
		%>
	</div>
    <div class="tab-content-bottom" style="margin-top: 8px;">
            <div id="GTDataGrid1_Area"></div>
        <div style="margin-top: 8px">
        	<p style="color:blue; font-size:14px;">
        		※ ${msgel.getMsg('RBA_50_05_05_01_200','총위험평가 마감')} : ${msgel.getMsg('RBA_50_05_05_01_202','각 부서의 위험 수기평가가 모두 완료된 것을 확인 한 후에 진행합니다.')}<br>
        		※ ${msgel.getMsg('RBA_50_05_05_01_201','통제평가 마감')}  : ${msgel.getMsg('RBA_50_05_05_01_203','각 부서의 통제 수기평가가 모두 완료된 것을 확인 한 후에 진행합니다.')}
        	</p>
<!-- 	        <table class="basic-table" >
	        	<tr><td style="text-align: left; height: 20px; color: blue;">※ '총위험평가 마감': 각 부서의 위험 수기평가가 모두 완료된 것을 확인 한 후에 진행합니다.</td></tr>
		        <tr><td style="text-align: left; height: 20px; color: blue;">※ '통제평가 마감'  : 각 부서의 통제 수기평가가 모두 완료된 것을 확인 한 후에 진행합니다.</td></tr>
	        </table> -->
   		 </div>
    </div> 
             
    <div id="GTDataGrid2_Area" style="display: none;"></div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />