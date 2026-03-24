<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_05_06_01.jsp
- Author     : 권얼
- Comment    : 개선현황
- Version    : 1.0
- history    : 1.0 2017-05-29
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String stDate1 = Util.nvl(request.getParameter("stDate1"));
    String edDate1 = Util.nvl(request.getParameter("edDate1"));
    String stDate2 = Util.nvl(request.getParameter("stDate2"));
    String edDate2 = Util.nvl(request.getParameter("edDate2"));

    try{
        if(("").equals(stDate1) || ("").equals(stDate2)) {
        	stDate1 = DateUtil.addDays(DateUtil.getDateString(), -30, "yyyy-MM-dd");
        	stDate2 = DateUtil.addDays(DateUtil.getDateString(), -30, "yyyy-MM-dd");
        }
        if(("").equals(edDate1) || ("").equals(edDate2)) {
        	edDate1 = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
        	edDate2 = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
        }
    }catch(Exception e){
    	Log.logAML(Log.ERROR, e);
    }
    request.setAttribute("stDate1",stDate1);
    request.setAttribute("edDate1",edDate1);
    request.setAttribute("stDate2",stDate2);
    request.setAttribute("edDate2",edDate2);
%>
<%
	//세션결재자정보
	String ROLEID 			= sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLEID"			,ROLEID			);
%>
<script language="JavaScript">
    
	var GridObj1;
	var overlay = new Overlay();
	var classID= "RBA_50_05_06_01";
	
	// Initialize
	$(document).ready(function(){
	    setupConditions();
	    setupGrids();
	    setupFilter("init");
	    
	    doSearch();
	});
	
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
								setupFilter();
                        }
                 }
            });
        }
    }  

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }
    
    // 그리드 셋업
    function setupGrids() {
        // 그리드1(Code Head) 초기화
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
		        	elementAttr: { class: "grid-table-type" },
					width: "100%", 
			 		height	:"calc(85vh - 110px)",
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
		            export               : {allowExportSelectedData: true, enabled : true, excelFilterEnabled : true, fileName : "gridExport"},
		            sorting              : {mode: "multiple"},
		            loadPanel            : {enabled: false},
		            pager: {
		                visible: false,
		                showNavigationButtons: true,
		                showInfo: true
		            },
		            paging: {
		                enabled: false,
		                pageSize: 20
		            },
		            scrolling: {
		                mode: "standard",
		                preloadEnabled: false
		            },
		            remoteOperations     : {filtering: false, grouping : false, paging : false, sorting : false, summary : false},
		            editing: {mode : "batch", allowUpdating: false, allowAdding : false, allowDeleting : false},
		            filterRow            : {visible: false},
		            rowAlternationEnabled: false,
//		             onCellPrepared   : function(e){
//		 							                var columnName = e.column.dataField;
//		 							                var dataGrid   = e.component;
//		 							                var rowIndex   = dataGrid.getRowIndexByKey(e.key); 
									                
//		 									        var MONITOR_RST_NEW            = dataGrid.cellValue(rowIndex, 'MONITOR_RST_NEW');
									                
//		 									        if(rowIndex != -1){
//		 									        	if(columnName == 'MONITOR_RST_NEW' || columnName == 'MONITOR_RST_OLD'){
//		 													 e.cellElement.css('background-color', 'rgb(247 255 128)');
//		 								        	}	
//		 								}
//		 			},
		            searchPanel: {visible: false, width : 250},
		            selection: {
				        allowSelectAll    : true,
				        deferred          : false,
				        mode              : "multiple",
				        selectAllMode     : "allPages",
				        showCheckBoxesMode: "always"
				    },
			 	   columns: [
			 		  	 {
				             dataField            : "BAS_YYMM",
				             caption              : '${msgel.getMsg("RBA_50_03_02_01_001","평가회차")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false
				         },
				         {
				             dataField            : "LV1",
				             caption              : '${msgel.getMsg("RBA_50_05_06_01_007","위험/통제분류")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             visible              : false
				         },
				    	 {
				             dataField            : "LV1_NM",
				             caption              : '${msgel.getMsg("RBA_50_05_06_01_007","위험/통제분류")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             visible              : true
				         },
				         {
				             dataField            : "LV3",
				             caption              : '${msgel.getMsg("RBA_50_05_06_01_008","위험/통제요소")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             visible              : false
				         },
				    	 {
				             dataField            : "LV3_NM",
				             caption              : '${msgel.getMsg("RBA_50_05_06_01_008","위험/통제요소")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             visible              : true,
				             width			 	  : "200px"
				         },
				    	 {
				             dataField            : "MOFC_BRN_CCD",
				             caption              : '${msgel.getMsg("RBA_50_04_03_01_006","부점구분")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             visible			  : false
				    	 },
				    	 {
				             dataField            : "MOFC_BRNO_NM",
				             caption              : '${msgel.getMsg("RBA_50_04_03_01_006","부점구분")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false
				         },
				         {
				             dataField            : "BRNO",
				             caption              : '${msgel.getMsg("RBA_50_05_06_01_005","소관부점")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             visible              : false
				         },	
				         {
				             dataField            : "BRNO_NM",
				             caption              : '${msgel.getMsg("RBA_50_05_06_01_005","소관부점")}',
				             alignment            : "center",
				             allowResizing        : true,
				             allowSearch          : true,
				             allowSorting         : true,
				             allowEditing         : false,
				             visible              : true
				         },		    	
				         {
				             dataField    		  : "IMPRV_STRG_DT",
				             alignment    		  : "left",
				             allowResizing		  : true,
				             allowSearch  		  : true,
				             allowSorting 		  : true,
				             visible              : false
				         },
				         {
				             dataField    		  : "IMPRV_STRG_CTNT",
				             caption      		  : '${msgel.getMsg("RBA_50_05_06_01_003","개선요청사항")}',
				             alignment    		  : "left",
				             allowResizing		  : true,
				             allowSearch  		  : true,
				             allowSorting 		  : true
				         },
				         {
				             dataField    		  : "IMPRV_RSLT_DT",
				             alignment    		  : "left",
				             allowResizing		  : true,
				             allowSearch  		  : true,
				             allowSorting 		  : true,
				             visible              : false
				         },
				         {
				             dataField    		  : "IMPRV_RSLT_CTNT",
				             caption      		  : '${msgel.getMsg("RBA_50_05_06_01_019","개선이행사항")}',
				             alignment    		  : "left",
				             allowResizing		  : true,
				             allowSearch  		  : true,
				             allowSorting 		  : true
				         },
				         {
				             dataField    		  : "IMPRV_S_C",
				             caption      		  : '${msgel.getMsg("RBA_50_05_06_01_002","개선이행상태")}',
				             cssClass     	 	  : "link",
				             alignment    		  : "center",
				             allowResizing		  : true,
				             allowSearch  		  : true,
				             allowSorting 		  : true,
				             visible              : false

				         },
				         {
				             dataField    		  : "IMPRV_S_C_NM",
				             caption      		  : '${msgel.getMsg("RBA_50_05_06_01_002","개선이행상태")}',
				             cssClass     	 	  : "link",
				             alignment    		  : "center",
				             allowResizing		  : true,
				             allowSearch  		  : true,
				             allowSorting 		  : true,
 		                     cssClass     		  : "link"
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
							 dataField		: "NEXT_GYLJ_ROLE_ID",
				             caption      	: '${msgel.getMsg("RBA_50_05_06_01_018","담당자")}',
							 visible		: true, 
							 allowSearch	: false,
							 lookup			: {
												dataSource : [
													{ code : 105, name : "RBA 담당자" }, 
													{ code : 6,   name : "RBA 책임자" }, 
													{ code : 4,   name : "자금세탁사기예방팀 담당자" }, 
													{ code : 104, name : "보고책임자" }, 
												],
												valueExpr   : "code",
												displayExpr : "name"
							 				   }
						 },
		                 {
							 "dataField"		: "END_GYLJ",
							 "visible"			: false, 
							 "allowSearch"		: false
						 },
				         {
				             dataField    		  : "GYLJ_S_C_NM",
				             caption      		  : '${msgel.getMsg("RBA_50_07_02_01_002","결재상태")}',
				             cssClass     	 	  : "link",
				             alignment    		  : "center",
				             allowResizing		  : true,
				             allowSearch  		  : true,
				             allowSorting 		  : true
				         }
		    	    ],
			 	    summary: {
			 	        totalItems: [
			 	            {
			 	                column     : "BAS_YYMM",
			 	                summaryType: "count"
			 	            }
			 	        ]
			 	    },
			 	   	onCellClick: function(e){
		    	        if(e.data){
		    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		    	        }
		    	        if (e.component.isRowSelected(e.key) && (e.columnIndex>=1 && e.columnIndex<=8)) {
		    	        } else {
		    	            e.component.clearSelection();
		    	            e.component.selectRowsByIndexes(e.rowIndex);
		    	        }
		    	    }
        }).dxDataGrid("instance");
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
    
    function doSearch() {
        overlay.show(true, true);
        
        var params = new Object();
        var methodID = "doSearch";
        var classID  = "RBA_50_05_06_01";
		params.pageID 	= "RBA_50_05_06_01"; 

		params.BAS_YYMM  = form.BAS_YYMM.value;						// 한도초과 발생기간(연도)
		params.LV1 = form.LV1.value;
		params.LV3_NM  = form.LV3_NM.value;				// 한도초과 발생기간(연도)
		params.IMPRV_S_C  = form.IMPRV_S_C.value;				// 한도초과 발생기간(연도)
		params.GYLJ_S_C  = form.GYLJ_S_C.value;				// 결재상태코드
		
		params.BRNO		 = $("#SEARCH_DEP_ID").val()=="99999"?"99999":$("#SEARCH_DEP_ID").val();     //부서코드
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
		
    }
    
    function doSearch_end(gridData, data) {
        overlay.hide();
        GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    }
    
    function doSearch_fail() {
        console.log("doSearch_fail");
    }
    
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId) {
        
        if(colId == "IMPRV_S_C_NM"){
            var form2              = document.form2;
            form2.pageID.value     = "RBA_50_05_06_03";
            form2.classID.value    = "RBA_50_05_06_03";
            form2.BAS_YYMM.value  = obj.BAS_YYMM;
            form2.LV1.value  = obj.LV1;
            form2.LV1_NM.value  = obj.LV1_NM;
            form2.LV3.value  = obj.LV3;
            form2.LV3_NM.value  = obj.LV3_NM;
            form2.BRNO.value  = obj.BRNO;
            form2.BRNO_NM.value  = obj.BRNO_NM;
            form2.IMPRV_STRG_DT.value  = obj.IMPRV_STRG_DT;
            form2.IMPRV_STRG_CTNT.value  = obj.IMPRV_STRG_CTNT;
            form2.IMPRV_RSLT_DT.value  = obj.IMPRV_RSLT_DT;
            form2.IMPRV_RSLT_CTNT.value  = obj.IMPRV_RSLT_CTNT;
            form2.IMPRV_S_C_NM.value  = obj.IMPRV_S_C_NM;
            
            form2.target           = form2.pageID.value;
            
            //var win                = window_popup_open(form2.pageID.value, 700, 580, '','yes');
            var win; win          = window_popup_open(form2.pageID.value, 900, 500, '','yes');  //보안취약성 보완
            form2.action           = '<c:url value="/"/>0001.do';
            form2.submit();
        
        }else if(colId == "GYLJ_S_C_NM") {
        	var form2              = document.form2;
        	var params = new Object();
        	form1.pageID.value = 'RBA_50_05_61_02';				// 결재이력 팝업

        	var win; win = window_popup_open(form1.pageID.value, 900, 500, '', '');
            form1.TABLE_NM.value	= "SRBA_TJACT_IMPRV_I";
            form1.BAS_YYMM.value = obj.BAS_YYMM;
    		form1.BRNO.value =  obj.BRNO;
//     		form1.LV3.value = obj.LV3; 
    		
            form1.target		= form1.pageID.value;
            form1.action		= "<c:url value='/'/>0001.do";
            form1.submit();
        }
    }
    
    // 개선 조치 요청 팝업 호출
    function doRegister() {
    	form2.addGubun.value     	=  "N";
        form2.BAS_YYMM.value = form.BAS_YYMM.value;            //평가회차
        form2.pageID.value     = "RBA_50_05_06_02";
        var win;           win = window_popup_open(form2.pageID.value,  900, 500, '','no');
        form2.target           = form2.pageID.value;
        form2.action           = '<c:url value="/"/>0001.do';
        form2.submit();
    }
    
 	// 개선현황 삭제
    function doDelete() {
		var selectedItem = GridObj1.getSelectedRowsData();  
        var selSize = selectedItem.length;
        if (selSize==0) {
            showAlert("${msgel.getMsg('AML_10_01_01_01_006','삭제할 데이타를 선택하십시오.')}", "WARN");
            return;
        } else if(selectedItem[i].GYLJ_S_C != ''){
    		showAlert("${msgel.getMsg('RBA_50_05_06_01_024','결재가 진행중인 개선현황은 삭제할 수 없습니다.')}","WARN");
    		return ;
    	}
        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

        	var params   = new Object();
        	var methodID = "doDelete";
        	var classID  = "RBA_50_05_06_01";
        	 		
        	params.pageID 		= pageID;
        	params.gridData 	= selectedItem;

        	sendService(classID, methodID, params, doDelete_End, doDelete_fail); 
        });
   }
	
   function doDelete_End(){
       overlay.hide();
       GridObj1.refresh();
       
       doSearch();
   }

   function doDelete_fail(){
		console.log("doDelete fail");
   }
   
   // 결재권한별 CHECK
   function CheckValue(flag){
	    var selData  	= GridObj1.getSelectedRowsData();
	   	var rowdata 	= selData[i];
	   	
	   	var FLAG 			= form1.FLAG.value;
	   	var ROLE_ID 		= form1.ROLE_ID.value;
		var GYLJ_ROLE_ID	= rowdata.GYLJ_ROLE_ID;
		var GYLJ_S_C 		= rowdata.GYLJ_S_C;
		var NEXT_GYLJ_ROLE_ID = rowdata.NEXT_GYLJ_ROLE_ID;
		var FIRST_GYLJ 		= rowdata.FIRST_GYLJ;
		var END_GYLJ 		= rowdata.END_GYLJ;
		var MOFC_BRN_CCD 		= rowdata.MOFC_BRN_CCD;
		//결재 FLAG (0:결재요청, 1:반려, 2:승인)
		//결재상태코드 GYLJ_S_C (0 : 미결재 , 12 : 결재요청 , 22 : 반려, 3 : 완료  )
		
		if ( GYLJ_S_C != 0 && ROLE_ID == GYLJ_ROLE_ID ) {
			showAlert("${msgel.getMsg('RBA_90_01_04_01_111','현재 결재가 실행 되었습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
			return;

		//결재 FLAG (0:결재요청, 1:반려, 2:승인)
		//결재상태코드 GYLJ_S_C (0 : 미결재 , 12 : 결재요청 , 22 : 반려, 3 : 완료  )

		//결재요청
		}else if(FLAG == "0"){
			
			if(MOFC_BRN_CCD == "B"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_122','영업점의 최초 결재자는 RBA 담당자 입니다.\\r\\n 결재선을 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}
			
			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_112','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}

			if ( NEXT_GYLJ_ROLE_ID != "" && NEXT_GYLJ_ROLE_ID != ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_113','승인요청 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

		//반려
		}else if(FLAG == "1"){

			if(GYLJ_S_C =="0" || GYLJ_S_C == ""){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_114','미결재 상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if ( NEXT_GYLJ_ROLE_ID != ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_115','반려 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_116','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}

		//승인
		}else if(FLAG == "2"){
			if ( NEXT_GYLJ_ROLE_ID != ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_117','승인 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="0" || GYLJ_S_C ==""){
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
//        		  		var methodID 	= "doApproval";
//       				var classID  = "RBA_50_03_02_01";
		   	 		var form1              	= document.form1;
					var BAS_YYMM; BAS_YYMM = rowdata.BAS_YYMM;
		   	 		var ROLE_ID; ROLE_ID = "${ROLEID}";
					var GYLJ_ID; GYLJ_ID = rowdata.GYLJ_ID;
					var GYLJ_ROLE_ID; GYLJ_ROLE_ID = rowdata.GYLJ_ROLE_ID;
					var GYLJ_S_C; GYLJ_S_C = rowdata.GYLJ_S_C;
					var GYLJ_S_C_NM; GYLJ_S_C_NM = rowdata.GYLJ_S_C_NM;
					var NEXT_GYLJ_ROLE_ID; NEXT_GYLJ_ROLE_ID = rowdata.NEXT_GYLJ_ROLE_ID;
					var FIRST_GYLJ; FIRST_GYLJ = rowdata.FIRST_GYLJ;
					var MOFC_BRN_CCD; MOFC_BRN_CCD = rowdata.MOFC_BRN_CCD;
					var LV1; LV1 = rowdata.LV1;
					var LV3; LV3 = rowdata.LV3;
					var IMPRV_S_C; IMPRV_S_C = rowdata.IMPRV_S_C;
					
					var END_GYLJ; END_GYLJ = rowdata.END_GYLJ;
					var BRNO; BRNO = rowdata.BRNO;
					var GYLJ_G_C ; GYLJ_G_C = rowdata.GYLJ_G_C;
					
					//결재상태 확인
	       			for(var i=0; i<selData.length; i++){
						if(!CheckValue(selData[i])){
							return;
						}
	       			}
					
			       form1.BAS_YYMM.value = BAS_YYMM;
			       form1.GYLJ_ID.value = GYLJ_ID;
			       
			       if(rowdata.MOFC_BRN_CCD == 'B'){
				       form1.GYLJ_G_C.value = "RBA03";
			       }else {
				       form1.GYLJ_G_C.value = "RBA01";
			       }
			       
				   if(flag == 0){			// 결재요청
				       if(form1.GYLJ_S_C.value == '' && (ROLE_ID == '4' || ROLE_ID == '104')){
				    	   form1.GYLJ_S_C.value = '120';	
				       }else if(form1.GYLJ_S_C.value != '' && (ROLE_ID == '4' || ROLE_ID == '104')) {
					       form1.GYLJ_S_C.value = GYLJ_S_C;
				       }
				   }else if(flag == 1){		// 반려
					   if(form1.GYLJ_S_C.value == '' && (ROLE_ID == '4' || ROLE_ID == '104')){
				    	   form1.GYLJ_S_C.value = '220'; 	
				       }else if(form1.GYLJ_S_C.value != '' && (ROLE_ID == '4' || ROLE_ID == '104')) {
					       form1.GYLJ_S_C.value = GYLJ_S_C;
				       }
				   }else if(flag == 2){		// 승인
					   if(form1.GYLJ_S_C.value == '' && (ROLE_ID == '4' || ROLE_ID == '104')){
				    	   form1.GYLJ_S_C.value = '30';		
				       }else if(form1.GYLJ_S_C.value != '' && (ROLE_ID == '4' || ROLE_ID == '104')) {
					       form1.GYLJ_S_C.value = GYLJ_S_C;
				       }
				   }			       
			       
			       form1.LV1.value = LV1;
			       form1.LV3.value = LV3;
			       form1.IMPRV_S_C.value = IMPRV_S_C;
			       form1.END_GYLJ.value = END_GYLJ;
			       form1.BRNO.value = BRNO;
			       form1.TABLE_NM.value	= "SRBA_TJACT_IMPRV_I";
				   form1.pageID.value  = "RBA_50_05_61_03";
			       form1.target		= form1.pageID.value;
			       form1.action		= "<c:url value='/'/>0001.do";
			       var win; win = window_popup_open(form1.pageID.value, 842, 666, '', 'yes');
			       form1.submit();
       		}
       }
	}
	
</script>
<style>
	.inquiry-table .table-cell .title {
	    min-width: 140px;
	}
</style>
<form name="form1" method="post" >
	<input type="hidden" name="gdReq"  	id="gdReq">
	<input type="hidden" name="pageID"      	id="pageID"  >
	<input type="hidden" name="manualID"    	id="manualID"  >
	<input type="hidden" name="classID"     	id="classID" >
	<input type="hidden" name="methodID"    	id="methodID">
	<input type="hidden" name="ROLE_ID" value="${ROLEID}">
	<input type="hidden" name="BAS_YYMM">
	<input type="hidden" name="LV1">
	<input type="hidden" name="LV3">
	<input type="hidden" name="IMPRV_S_C">
	<input type="hidden" name="GYLJ_ROLE_ID">
	<input type="hidden" name="GYLJ_S_C">
    <input type="hidden" name="GYLJ_S_C_NM">
    <input type="hidden" name="GYLJ_G_C"  value="${GYLJ_G_C}">
    <input type="hidden" name="NEXT_GYLJ_ROLE_ID">
    <input type="hidden" name="FIRST_GYLJ">
    <input type="hidden" name="END_GYLJ" value="${END_GYLJ}">
    <input type="hidden" name="FLAG"/>
   	<input type="hidden" name="GYLJ_ID" 		id="GYLJ_ID">
   	<input type="hidden" name="BRNO" 		id="BRNO">
   	<input type="hidden" name="TABLE_NM"/>
</form>
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
	<input type="hidden" name="LV1" >
	<input type="hidden" name="LV1_NM" >
	<input type="hidden" name="LV3" >
	<input type="hidden" name="LV3_NM" >
	<input type="hidden" name="BRNO" >
	<input type="hidden" name="BRNO_NM" >
	<input type="hidden" name="IMPRV_S_C" >
	<input type="hidden" name="IMPRV_S_C_NM" >
	<input type="hidden" name="IMPRV_STRG_DT" >
	<input type="hidden" name="IMPRV_STRG_CTNT" >
	<input type="hidden" name="IMPRV_RSLT_DT" >
	<input type="hidden" name="IMPRV_RSLT_CTNT" >
	<input type="hidden" name="addGubun"     	id="addGubun"/>
	
</form>
<!-- 기존 값 조회시 Parameter를 넘긴다 -->

<form name="form" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row">
            <div class="table-cell">
	            ${condel.getLabel("RBA_50_03_02_001","평가회차")}
	            <div class="content">
					${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'doSearch()')}
				</div>
	        </div>
			<div class="table-cell">
				${condel.getLabel('RBA_50_05_06_01_005','소관부점')} 	
				${condel.getBranchSearch('SEARCH_DEP_ID','ALL')}
            </div>		</div>
		<div class="table-row">
	    	<div class="table-cell">
	    		${condel.getLabel('RBA_50_05_06_01_007','위험/통제분류')}
<%--       	 		${JRBACondEL.getSRBASelect('','LV1' ,'P001' ,'160px' ,'' ,'' ,'ALL','doSearch()')} --%>
				<div class="content" >
					${RBACondEL.getKRBASelect('LV1','' ,'' ,'SP001' ,'' ,'ALL' ,'','','','')}
				</div>
            </div>
            <div class="table-cell">
	                ${condel.getLabel('RBA_50_05_06_01_002','개선이행상태')}
	 			<div class="content">
	 				<!-- 기준코드관리 : R561 추가 -->
	                ${SRBACondEL.getSRBASelect('IMPRV_S_C','300' ,'' ,'R561' ,'','ALL','','','','')}
	 			</div>       
        	</div>
       </div>
       <div class="table-row">
            <div class="table-cell">
				${condel.getLabel("RBA_50_05_06_01_008","위험/통제요소")}
				<div class="content">
					<input type="text" name="LV3_NM" size="30" class="cond-input-text" style="text-align: left" />
				</div>
			</div>
			<div class="table-cell">
		           ${condel.getLabel('RBA_30_06_05_01_030','결재상태')}
		           <div class="content">
						${condel.getSelect('GYLJ_S_C','' ,'' , 'K001','', 'ALL', 'ALL')}
		           </div>
		    </div>
        </div>    
          
    </div>
    <div class="button-area">
   		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
   		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"addBtn", defaultValue:"추가", mode:"C", function:"doRegister", cssClass:"btn-36 "}')}
   		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
   		<% if ( "4".equals(ROLEID) || "7".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
			${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"apprBtn", defaultValue:"승인", mode:"C", function:"doApproval(2)", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"denyBtn", defaultValue:"반려", mode:"C", function:"doApproval(1)", cssClass:"btn-36"}')}
    	<% } %>
   		<% if ( "104".equals(ROLEID) || "7".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
			${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"apprBtn", defaultValue:"승인", mode:"C", function:"doApproval(2)", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"denyBtn", defaultValue:"반려", mode:"C", function:"doApproval(1)", cssClass:"btn-36"}')}
    	<% } %>
	</div>
	<div class="tab-content-bottom" style="margin-top: 8px;">
            <div id="GTDataGrid1_Area"></div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />