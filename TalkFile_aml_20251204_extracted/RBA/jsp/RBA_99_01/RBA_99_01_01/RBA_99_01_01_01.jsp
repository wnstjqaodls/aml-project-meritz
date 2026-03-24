<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- 
******************************************************************************************************************************************** 
* Copyright (C) 2008-2018 GTOne. All Right Reserved. 
******************************************************************************************************************************************** 
* Project : RBA 
* File Name : RBA_99_01_01_01.jsp 
* Description : 내부통제 - 교육 및 연수 관리
* Group : GTONE 
* Author : mjh 
* Since : 2025-03-06 
******************************************************************************************************************************************** 
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%
	//calnder
	String stDate = Util.nvl(request.getParameter("stDate"));
	String edDate = Util.nvl(request.getParameter("edDate"));
	
	if(("").equals(stDate)) { stDate = DateUtil.addDays(DateUtil.getDateString(), -365, "yyyy-MM-dd"); }
	if(("").equals(edDate)) { edDate = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd"); }
	
	request.setAttribute("stDate", stDate); 
	request.setAttribute("edDate", edDate);
	
	//세션 결재자 정보
	String ROLEID = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLEID",ROLEID);
%>
<script language="JavaScript">
    var overlay     = new Overlay();
    var GridObj1    = null;
    var pageID      = "RBA_99_01_01_01";
    var classID     = "RBA_99_01_01_01";
    var GridObjArr = [];

    $(document).ready(function(){
        setupGrids();
        setupFilter("init");
    });
    
    function setupGrids(){
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
            elementAttr                 : { class: "grid-table-type" },
            height                      : "calc(90vh - 150px)",
            gridId                      : "GTDataGrid01",	
            allowColumnReordering       : true,
            allowColumnResizing         : true,
            cacheEnabled                : false,
            cellHintEnabled             : true,
            columnAutoWidth             : true,
            columnFixing                : { enabled : true},
            editing                     :                  
            {
                allowAdding             : false,
                allowDeleting           : false,
                allowUpdating           : false,
            },
            filterRow                   : { visible : false },
            hoverStateEnabled           : true,
            loadPanel                   : { enabled : false },
            onToolbarPreparing          : makeToolbarButtonGrids,
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
            remoteOperations            :
            {
                filtering               : false,
                grouping                : false,
                paging                  : false,
                sorting                 : false,
                summary                 : false
            },
            rowAlternationEnabled       : true,
            selection                   :
            {
                allowSelectAll          : true,
                deferred                : false,
                mode                    : "multiple",
                selectAllMode           : "allPages",
                showCheckBoxesMode      : "always"
            },
            showBorders                 : true,
            showColumnLines             : true,
            showRowLines                : true,
            sorting                     : { mode : "multiple" },
            wordWrapEnabled             : false,
            export : {allowExportSelectedData:true, enabled:true},
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
            columns                     :                  
                [{
                    "dataField"        : "EDU_ID",
                    "caption"          : "교육ID",
                    "alignment"        : "center",
                    "allowResizing"    : true,
                    "allowSearch"      : true,
                    "allowSorting"     : true,
                    "allowEditing"     : false,
                    "visible"			: false                     
                },
                {
                    "dataField"        : "EDU_START_DT",
                    "caption"          : "${msgel.getMsg('RBA_90_01_01_03_104','교육 시작일')}",
                    "alignment"        : "center",
                    "allowResizing"    : true,
                    "allowSearch"      : true,
                    "allowSorting"     : true,
                    "allowEditing"     : false,
                    format:function(value){ return value?(value.substr(0,4)+'-'+value.substr(4,2)+'-'+value.substr(6,2)):value;}
                     
                },
                {
                    "dataField"        : "EDU_END_DT",
                    "caption"          : "${msgel.getMsg('RBA_90_01_01_03_105','교육 종료일')}",
                    "alignment"        : "center",
                    "allowResizing"    : true,
                    "allowSearch"      : true,
                    "allowSorting"     : true,
                    "allowEditing"     : false,
                    format:function(value){ return value?(value.substr(0,4)+'-'+value.substr(4,2)+'-'+value.substr(6,2)):value;}
                     
                },
                {
                     "dataField"        : "EDU_NM",
                     "caption"          : "${msgel.getMsg('RBA_90_01_01_03_103','교육 과정명')}",
                     "alignment"        : "left",
                     "allowResizing"    : true,
                     "allowSearch"      : true,
                     "allowSorting"     : true,
                     "allowEditing"     : false,
                     cssClass     : "link"                    
                      
                 },
                 {
                     "dataField"        : "EDU_CCD",
                     "caption"          : "${msgel.getMsg('RBA_90_01_01_03_110','교육 채널')}",
                     "alignment"        : "center",
                     "allowResizing"    : true,
                     "allowSearch"      : true,
                     "allowSorting"     : true,
                     "allowEditing"     : false,
                     "lookup" : {dataSource  : [{"KEY":"A","VALUE":"집합교육"},
                    	 						{"KEY":"B","VALUE":"사이버교육"}],displayExpr : "VALUE",valueExpr:"KEY"}
                      
                 },
                 {
                     "dataField"        : "CRE_OGN_CCD",
                     "caption"          : "${msgel.getMsg('RBA_90_01_01_03_106','교육 기관')}",
                     "alignment"        : "center",
                     "allowResizing"    : true,
                     "allowSearch"      : true,
                     "allowSorting"     : true,
                     "allowEditing"     : false,
                     "customizeText"	: function(cellInfo) {
                    	 if(cellInfo.value == "Y"){
                    		 return "${msgel.getMsg('RBA_99_01_01_02_004','소속 부점 자체 실시')}";
                    	 }
                    	 else return cellInfo.value;
                     }
                 },
	             {
		              "dataField"        : "OGN_NM",
		              "caption"          : "${msgel.getMsg('RBA_99_01_01_02_030','기관명')}",
		              "alignment"        : "center",
		              "allowResizing"    : true,
		              "allowSearch"      : true,
		              "allowSorting"     : true,
		              "allowEditing"     : false
		          },
                 {
                     "dataField"        : "EDU_TGT_CCD_NM",
                     "caption"          : "${msgel.getMsg('RBA_90_01_01_03_108','교육 대상')}",
                     "alignment"        : "center",
                     "allowResizing"    : true,
                     "allowSearch"      : true,
                     "allowSorting"     : true,
                     "allowEditing"     : false
                 },
                 {
                     "dataField"        : "EDU_TGT_CCD",
                     "caption"          : "교육대상 코드",
                     "alignment"        : "left",
                     "allowResizing"    : true,
                     "allowSearch"      : true,
                     "allowSorting"     : true,
                     "allowEditing"     : false,
                     "visible"          : false
                 },
                 {
                     "dataField"        : "EDU_CHK_YN",
                     "caption"          : "${msgel.getMsg('RBA_90_01_01_03_122','이헤도 점검여부')}",
                     "alignment"        : "center",
                     "allowResizing"    : true,
                     "allowSearch"      : true,
                     "allowSorting"     : true,
                     "allowEditing"     : false,
                     "visible"			: true
                 },
                 {
                     "dataField"        : "EDU_HH",
                     "caption"          : "${msgel.getMsg('RBA_90_01_01_03_111','교육 시간')}(h)",
                     "alignment"        : "center",
                     "allowResizing"    : true,
                     "allowSearch"      : true,
                     "allowSorting"     : true,
                     "allowEditing"     : false,
                     format:function(value){ return value?(value+'h'):value;}
                     
                 },
                 {
                     "dataField"        : "EDU_CNT",
                     "caption"          : "${msgel.getMsg('RBA_90_01_01_03_113','이수자')}(명)",
                     "alignment"        : "center",
                     "allowResizing"    : true,
                     "allowSearch"      : true,
                     "allowSorting"     : true,
                     "allowEditing"     : false,
                     format:function(value){ return value?(value+'명'):value;}
                 },
                 {
					 "dataField"		: "GYLJ_ID",
					 "visible"			: false, 
					 "allowSearch"		: false
				 },
                 {
					 "dataField"		: "GYLJ_S_C",
					 "visible"			: false, 
					 "allowSearch"		: false
				 },
                 {
					 "dataField"		: "END_GYLJ",
					 "visible"			: false, 
					 "allowSearch"		: false
				 },
	    	     {
					 "dataField"		: "GYLJ_S_C_NM",
					 "caption"			: '${msgel.getMsg("RBA_30_06_05_01_011","결재상태")}',
					 "alignment"		: "center",
					 "allowResizing"	: true,
					 "allowSearch"		: true, 
					 "allowSorting"		: true,
					 "cssClass"			: "link"
				 }
             ],
             onInitialized : function(e) { doSearch(); },
             onCellClick: function(e){ 
			        
			        if(e.rowType === 'data' && ( e.column.dataField === 'EDU_NM' ) ){
			    		 if(e.data){
			    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		    	         }
		    	         if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
		    	         } else {
		    	            e.component.clearSelection();
		    	            e.component.selectRowsByIndexes(e.rowIndex);
		    	         }
				     } else if(e.rowType === 'data' && ( e.column.dataField === 'GYLJ_S_C_NM' ) ){
			    		 if(e.data){
			    	            Grid1CellClick2('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		    	         }
		    	         if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
		    	         } else {
		    	            e.component.clearSelection();
		    	            e.component.selectRowsByIndexes(e.rowIndex);
		    	         }
				     }
			        
			        
			    }
        }).dxDataGrid("instance");
    }
    
    function setupFilter(FLAG){
        var gridArrs = new Array();
        var gridObj = new Object();
        gridObj.gridID = "GTDataGrid1_Area";
        gridObj.title  = "";
        gridArrs[0] = gridObj;
        
        setupGridFilter2(gridArrs, FLAG);    
    }
    
    function makeToolbarButtonGrids(e){
        var cmpnt; cmpnt = e.component;
        var useYN = "${ outputAuth.USE_YN }";
        var authC = "${ outputAuth.C      }";
        var authD = "${ outputAuth.D      }";
        if (useYN == "Y") {
            var gridID       = e.element.attr("id");
            var toolbarItems = e.toolbarOptions.items;
            toolbarItems.splice(0, 0, {
                locateInMenu    : "auto",
                location        : "after",
                widget          : "dxButton",
                name            : "filterButton",
                showText        : "inMenu",
                options         : {
                    icon        : "" ,
                    elementAttr : { class : "btn-28 filter" },
                    text        : "",
                    hint        : "필터",
                    disabled    : false,
                    onClick     : function(){
                        setupFilter();
                    }
                }
            });
        }
    }
    
    function doSearch(){
        var params      = new Object();
        var methodID    = "doSearch";
        var startDate 	= getDxDateVal("stDate",true);
        var endDate 	= getDxDateVal("edDate",true);
        
        if (startDate == null) {
            showAlert('${msgel.getMsg("AML_60_02_02_01_005","시작일자를 입력해주세요.")}',"WARN");
            return;
        }
        if (endDate == null) {
            showAlert('${msgel.getMsg("AML_60_02_02_01_006","종료일을 입력해주세요.")}',"WARN");
            return;
        }
        if (startDate > endDate) {
            showAlert('${msgel.getMsg("AML_20_02_02_01_042","시작일이 종료일보다 늦을 수 없습니다.")}',"WARN");
            return;
        }
        
        
        overlay.show(true, true);
        params.pageID 		= pageID;
        params.DR_DPRT_CD 	= $("#DR_DPRT_CD").val();
        params.CRE_OGN_CCD 	= $("#CRE_OGN_CCD").val();
        params.EDU_START_DT = getDxDateVal("stDate",true);
        params.EDU_END_DT 	= getDxDateVal("edDate",true);
        params.EDU_TGT_CCD 	= $("#EDU_TGT_CCD").val();
        params.EDU_NM 		= $("#EDU_NM").val().trim(); 
//         params.EDU_STS_CD 	= $("#EDU_STS_CD").val();
        params.GYLJ_S_C 		= form.GYLJ_S_C.value;
        params.GYLJ_ID 		= $("#GYLJ_ID").val();
        params.EDU_ID 		= $("#EDU_ID").val();
        params.EDU_CCD 		= $("#EDU_CCD").val();
        params.EDU_CHK_YN 		= $("#EDU_CHK_YN").val();
        params.END_GYLJ 		= $("#END_GYLJ").val();
        
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }
   
    function doSearch_success(gridData, data){
	    try {

// 	    	if(gridData.length != 0){
// 		         var obj = data.GRID_DATA[0];
// 	            form1.END_GYLJ.value			=	obj.END_GYLJ;			// 마지막결재자
// 	            form1.GYLJ_S_C.value			=	obj.GYLJ_S_C;			// 결재상태코드
// 	    	}
	         GridObj1.refresh();
	         GridObj1.option("dataSource", gridData); 
	         
	     } catch (e) {
	         showAlert(e, "ERR");
	         overlay.hide();
	     } finally {
	         overlay.hide();
	     }
    }
    
    
    
    function doSearch_fail(){
    	overlay.hide();
    }
    
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId) { 
        if(colId == "EDU_NM"){
        	form1.addGubun.value     	=  "N";
        	form1.pageID.value     		=  "RBA_99_01_01_02";
        	form1.classID.value     	=  "RBA_99_01_01_01";
        	form1.methodID.value 		=  "getSearch";
        	form1.EDU_ID.value       	=  obj.EDU_ID;
        	form1.ATTCH_FILE_NO.value   =  obj.ATTCH_FILE_NO;
        	form1.GYLJ_S_C.value 		=  obj.GYLJ_S_C;
        	
            var win;                win = window_popup_open("RBA_99_01_01_02", 935, 900, '','Yes');
            form1.target                = form1.pageID.value;
            form1.action                = '<c:url value="/"/>0001.do';
            form1.submit();
        }
    }
    
	// 그리드 클릭 - 결재이력 호출
	function Grid1CellClick2(id, obj, selectData, rowIdx, colIdx, colId){
		
		var form1              = document.form1;
    	var params = new Object();
    	form1.pageID.value = 'RBA_50_03_02_06';				// 결재이력 팝업

    	var win; win = window_popup_open(form1.pageID.value, 1230, 500, '', '');
        form1.TABLE_NM.value	= "IC_EDU_M";
        form1.BAS_YYMM.value = obj.EDU_START_DT.substring(2);
		form1.BRNO.value = obj.DR_DPRT_CD;
		form1.LV3.value = obj.LV3; 
		
        form1.target		= form1.pageID.value;
        form1.action		= "<c:url value='/'/>0001.do";
        form1.submit();
        
	}
    
    function doRegister(){
    	$("#addGubun").val("Y");
    	window_popup_open("RBA_99_01_01_02", 935, 900, '','Yes');
        form1.pageID.value = "RBA_99_01_01_02";
        form1.target       = form1.pageID.value; 
        form1.EDU_ID.value =  ""; // 등록할때는 초기화 처리 
        form1.action       = '<c:url value="/"/>0001.do';
        form1.submit();
    }
    
    function doDelete(){
        var rows=GridObj1.getSelectedRowsData();
        for(var i=0; i < rows.length ; i++) {
        	if (rows[i].EDU_STS_CD == 'E') {
        		showAlert("${msgel.getMsg('RBA_99_01_01_01_037','완료된 교육은 삭제할 수 없습니다.')}","WARN");
        		return ;
        	}else if(rows[i].GYLJ_S_C != ''){
        		showAlert("${msgel.getMsg('RBA_99_01_01_01_045','결재가 진행중인 교육 및 연수는 삭제할 수 없습니다.')}","WARN");
        		return ;
        	}
        }
        
   		if (rows.length != 0) {
       	
   			showConfirm('${msgel.getMsg("AML_10_03_01_01_002","삭제하시겠습니까?")}', '삭제', doDelete_Action);
   			function doDelete_Action(){

   		    	var params = new Object();
   		        var methodID = "doEduDelete";
   		        var classID = "RBA_99_01_01_01";
   		   		overlay.show(true, true);
   		   		params.pageID = pageID;
   		   		params.EDU_ID = rows[0].EDU_ID;
   		   		params.gridData = rows;
   		   		
   		   		sendService(classID, methodID, params, doDelete_success, doDelete_fail); 
   		 		
   		     }
		 	
		} else {
           showAlert("${msgel.getMsg('AML_90_01_01_01_006','삭제할 데이타를 선택하십시오.')}","WARN");
       	}
   	}
    
    function doDelete_success(){
        doSearch();
        
    }

    function doDelete_fail(){
		console.log("goDelete_fail");
    } 
    
    function doSearchDetail(){
    	var selData  = GridObj1.getSelectedRowsData();

        if(selData == null || selData == ""){
        	showAlert('${msgel.getMsg("RBA_30_06_02_02_004","상세조회할 대상을 선택해주세요.")}','WARN');
        }else{	
        		var rowdata = selData[0];	//한 건만 선택
	        	 var form1              	= document.form1;
		         
	        	 form1.addGubun.value     	=  "N";
		         form1.pageID.value     	=  "RBA_99_01_01_02";
		         form1.classID.value     	=  "RBA_99_01_01_01";
		         form1.methodID.value 		=  "getSearch";
		         form1.EDU_ID.value       	=  rowdata.EDU_ID;
		         form1.ATTCH_FILE_NO.value  =  rowdata.ATTCH_FILE_NO;
	        	 form1.GYLJ_S_C.value 		=  rowdata.GYLJ_S_C;
		        	
	             form1.target           	= form1.pageID.value;
	             //var win                = window_popup_open(form2.pageID.value, 700, 580, '','yes');
	             var win; win          		= window_popup_open("RBA_99_01_01_02", 770, 900, '','Yes');  //보안취약성 보완
	             form1.action           	= '<c:url value="/"/>0001.do';
	             form1.submit();
	             
	             
        }
        
    }
    
    // 결재권한별 CHECK
    function CheckValue(flag){
    	var selData  = GridObj1.getSelectedRowsData();
    	var rowdata 			= selData[i];
    	
		var flag 		= form1.FLAG.value;
		var ROLE_ID 		= form1.ROLE_ID.value;
		var GYLJ_ROLE_ID	= rowdata.GYLJ_ROLE_ID;
		var GYLJ_S_C 		= rowdata.GYLJ_S_C;
		
		var NEXT_GYLJ_ROLE_ID = rowdata.NEXT_GYLJ_ROLE_ID;
		var FIRST_GYLJ 		= rowdata.FIRST_GYLJ;
		var END_GYLJ 		= rowdata.END_GYLJ;
		
		// NEXT_GYLJ_ROLE_ID 
		if (NEXT_GYLJ_ROLE_ID == "") {
			// 첫 결재라서 아무것도 체크하지 않음
			
		}else if(flag == "0"){

			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_112','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}

			if ( END_GYLJ == ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_113','승인요청 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

		//반려
		}else if(flag == "1"){
			if(GYLJ_S_C =="0"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_114','미결재 상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}
			
			if ( FIRST_GYLJ == ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_115','반려 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}
			
			if(GYLJ_S_C =="22"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_119','현재 반려상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}
			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_116','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}

		//승인
		}else if(flag == "2"){
			if ( END_GYLJ != ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_117','승인 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="0"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_118','미결재 상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="22"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_119','현재 반려상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_116','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}
		}

		return true;
	}
    
    
 	// 결재팝업 요청
	function doApproval(flag) {  
		var selData  = GridObj1.getSelectedRowsData();
		
 	 	var form1              	= document.form1;
		form1.FLAG.value = flag;
		
        if(selData == null || selData == ""){
        	showAlert('${msgel.getMsg("RBA_99_01_01_02_032","결재할 대상을 선택해주세요.")}','WARN');
        }else{	
	        	
        		for(var i=0; i<selData.length; i++){
        			var rowdata 			= selData[i];
// 					var FLAG				= form1.FLAG.value;
		   	 		var ROLE_ID; ROLE_ID = rowdata.ROLE_ID;
					var GYLJ_ID; GYLJ_ID = rowdata.GYLJ_ID;
					var GYLJ_ROLE_ID; GYLJ_ROLE_ID = rowdata.GYLJ_ROLE_ID;
					var GYLJ_S_C; GYLJ_S_C = rowdata.GYLJ_S_C;
					
					var GYLJ_S_C_NM; GYLJ_S_C_NM = rowdata.GYLJ_S_C_NM;
					var NEXT_GYLJ_ROLE_ID; NEXT_GYLJ_ROLE_ID = rowdata.NEXT_GYLJ_ROLE_ID;
					var FIRST_GYLJ; FIRST_GYLJ = rowdata.FIRST_GYLJ;
					var END_GYLJ; END_GYLJ = rowdata.END_GYLJ;
					
					var GYLJ_G_C ; GYLJ_G_C = rowdata.GYLJ_G_C;
					var EDU_START_DT ; EDU_START_DT = rowdata.EDU_START_DT
					var EDU_ID ; EDU_ID = rowdata.EDU_ID
					var DR_DPRT_CD ; DR_DPRT_CD = rowdata.DR_DPRT_CD
					
					//결재상태 확인
        			for(var i=0; i<selData.length; i++){
						if(!CheckValue(selData[i])){
							return;
						}
        			}
					
			       form1.GYLJ_ID.value = GYLJ_ID;
			       form1.GYLJ_G_C.value = GYLJ_G_C;
			       form1.GYLJ_S_C.value = GYLJ_S_C;
			       form1.EDU_START_DT.value = EDU_START_DT;
			       form1.EDU_ID.value = EDU_ID;
			       form1.END_GYLJ.value = END_GYLJ;
			       form1.DR_DPRT_CD.value = DR_DPRT_CD;
			       form1.TABLE_NM.value	= "IC_EDU_M";
				   form1.pageID.value  = "RBA_99_01_01_04";
			       form1.target		= form1.pageID.value;
			       form1.action		= "<c:url value='/'/>0001.do";
			       var win; win = window_popup_open(form1.pageID.value, 650, 384, '', 'yes');
			       form1.submit();
        		}
        }
	}
 	
 	
	function doApproval2(MSG) {
		var selData  = GridObj1.getSelectedRowsData();
		var obj   = new Object();
		
		var methodID 	 = "doApproval_RBA99";
       	var classID 	 = "RBA_50_03_02_01";

      	//결재상태 확인
		for(var i=0; i<selData.length; i++){
			if(!CheckValue(selData[i])){
				return;
			}
		}
       	obj.pageID 	     = "RBA_99_01_01_01";
       	obj.TABLE_NM 	 = "IC_EDU_M";
       	obj.FLAG     	 = form1.FLAG.value;
       	obj.GYLJ_ID      = form1.GYLJ_ID.value;
       	obj.GYLJ_G_C     = "RBA99";
       	
       	obj.MSG          = MSG;	
	    obj.gridData     = selData;	//obj2;
	    
        sendService(classID, methodID, obj, doSearch_success2, doSearch_fail);
				
	}
 	
	function doSearch_success2(gridData, data) {
        GridObj1.refresh();
        doSearch();
	} 	
 	
 	</script>
<form name="form3" id="form3" method="post">
	<input type="hidden" name="pageID"      	id="pageID"  >
	<input type="hidden" name="manualID"    	id="manualID"  >
	<input type="hidden" name="classID"     	id="classID" >
	<input type="hidden" name="methodID"    	id="methodID">
	<input type="hidden" name="EDU_ID" 			id="EDU_ID">
	<input type="hidden" name="S_EDU_STS_CD"   	id="S_EDU_STS_CD">
	<input type="hidden" name="S_EDU_TGT_CCD"  	id="S_EDU_TGT_CCD">
</form>
<form name="form1" id="form1" method="post">
	<input type="hidden" name="gdReq"  	id="gdReq">
	<input type="hidden" name="pageID"      	id="pageID"  >
	<input type="hidden" name="manualID"    	id="manualID"  >
	<input type="hidden" name="classID"     	id="classID" >
	<input type="hidden" name="methodID"    	id="methodID">
	<input type="hidden" name="stDate"      	id="${stDate}"/>
	<input type="hidden" name="edDate"      	id="${edDate}"/>
	<input type="hidden" name="addGubun"     	id="addGubun"/>
	<input type="hidden" name="ROLE_ID" value="${ROLEID}">
	
	<input type="hidden" name="EDU_ID" 			value="${EDU_ID}">
	<input type="hidden" name="ATTCH_FILE_NO" 	id="ATTCH_FILE_NO">
	<input type="hidden" name="GYLJ_ID" 		id="GYLJ_ID">
	<input type="hidden" name="GYLJ_LINE_G_C" value="RBA99">	<!-- 결재선구분코드 = RBA99 : 내부통제 -->
<%--     <input type="hidden" name="GYLJ_ID" value="${GYLJ_ID}"> --%>
    <input type="hidden" name="GYLJ_ROLE_ID">
    <input type="hidden" name="GYLJ_S_C">
    <input type="hidden" name="GYLJ_S_C_NM">
    <input type="hidden" name="GYLJ_G_C"  value="${GYLJ_G_C}">
    <input type="hidden" name="NEXT_GYLJ_ROLE_ID">
    <input type="hidden" name="FIRST_GYLJ">
    <input type="hidden" name="END_GYLJ" value="${END_GYLJ}">
    <input type="hidden" name="stDate" >
    <input type="hidden" name="FLAG"/>
    <input type="hidden" name="EDU_START_DT" value="${stDate}"/>
    <input type="hidden" name="TABLE_NM"/>
    <input type="hidden" name="DR_DPRT_CD"/>
    <input type="hidden" name="BAS_YYMM"/>
    <input type="hidden" name="BRNO" value="${DR_DPRT_CD}"/>
    <input type="hidden" name="LV3"  value="${LV3}"/>
    <input type="hidden" name="gdReq"/>
    <input type="hidden" name="GRID_DATA" >
</form>
<form name="form" id="form" method="post">
	<div class="inquiry-table">
		<div class="table-row">
			<div class="table-cell">
	            <div class="title">
	                <div class="txt">${msgel.getMsg('RBA_99_01_01_01_003','교육 일자')}</div>
	            </div>
	            <div class="content">
	                <div class='calendar'>
	                    ${condel.getInputDateDx('stDate', stDate)}~${condel.getInputDateDx('edDate', edDate)}
	                </div>
	            </div>
			</div>
			<div class="table-cell">
				<div class="title">
					<div class="txt">${msgel.getMsg('RBA_90_01_01_03_103','교육 과정명')}</div>
				</div>
				<div class="content">
	                <input type="text" id="EDU_NM" name="EDU_NM" size="20" maxlength="30">
				</div>
			</div>
	<!-- 		<div class="table-cell">        -->
	<%-- 				${condel.getLabel('AML_00_00_01_01_013','지점')}          --%>
	<%--                 ${condel.getBranchSearch('branchCode','ALL')} --%>
	<!--         </div> -->
		</div>
		<div class="table-row">
			<div class="table-cell">
				<div class="title">
					<div class="txt">${msgel.getMsg('RBA_90_01_01_03_110','교육 채널')}</div>
				</div>			
				${condel.getSelect('EDU_CCD','' ,'' , 'A402','', 'ALL', 'ALL')}		
			</div>
	        <div class="table-cell">
	            <div class="title">
	                <span class="txt">${msgel.getMsg('RBA_90_01_01_03_106','교육 기관')}</span>
	            </div>            
	            ${condel.getSelect('CRE_OGN_CCD','' ,'' , 'A401','', 'ALL', 'ALL')}
	        </div>
		</div>
		<div class="table-row">
			<div class="table-cell">
				<div class="title">
					<div class="txt">${msgel.getMsg('RBA_90_01_01_03_108','교육 대상')}</div>
				</div>			
				${condel.getSelect('EDU_TGT_CCD','' ,'' , 'A403','', 'ALL', 'ALL')}			
			</div>
			<div class="table-cell">
				${condel.getLabel('RBA_30_06_05_01_030','결재상태')}
	           <div class="content">
					${condel.getSelect('GYLJ_S_C','' ,'' , 'K001','', 'ALL', 'ALL')}
	           </div>
			</div>
			
		</div>
		<div class="table-row">
			<div class="table-cell">
				<div class="title">
					<div class="txt">${msgel.getMsg('RBA_90_01_01_03_122','이해도 점검여부')}</div>
				</div>			
				${condel.getSelect('EDU_CHK_YN','' ,'' , 'A405','', 'ALL', 'ALL')}
			</div>
			<div class="table-cell">
			</div>
		</div>
	</div>
	<div class="button-area">
	    ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA_Detail_Search", defaultValue:"상세조회", mode:"R", function:"doSearchDetail", cssClass:"btn-36"}')}
		<% if ( "4".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
			${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
	    <% } %>
		<% if ( "104".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
			${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"apprBtn", defaultValue:"승인", mode:"C", function:"doApproval(2)", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"denyBtn", defaultValue:"반려", mode:"C", function:"doApproval(1)", cssClass:"btn-36"}')}
	    <% } %>
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"registerBtn", defaultValue:"등록", mode:"C", function:"doRegister", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
	</div>
	<div id="GTDataGrid1_Area" style="margin-top: 8px;"></div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />
</body>