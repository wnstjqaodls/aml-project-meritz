<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 위험요소관리
* File Name       : RBA_50_03_02_01.jsp
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 정연태
* Since           : 2025. 6. 30.
********************************************************************************************************************************************
* Modifier        :
* Update          :
* Alteration      :
********************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%  
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLE_IDS",ROLE_IDS);
%>
<!-- Java Script -->
<script language="JavaScript">

	var overlay = new Overlay();
	var GridObj1 = null;
	var GridObj2 = null;
	var classID  = "RBA_50_03_02_01";
	var pageID   = "RBA_50_03_02_01";
	
	var ROLE_IDS     = "${ROLE_IDS}";

	$(document).ready(function() {
		setupGrids();
		setting();
	 	//doSearch();
        if(form1.BAS_YYMM.value != ''){
             doSearch();
        }

    });

	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			elementAttr: { class: "grid-table-type" },
    		height 				  : "calc(100vh - 200px)",
    		hoverStateEnabled     : true,
    		wordWrapEnabled       : false,
    		allowColumnResizing   : true,
    		allowColumnReordering : true,
    		columnResizingMode    : "widget", /* "widget" "nextColumn" */
    		cacheEnabled          : false,
    		cellHintEnabled       : true,
    		showBorders           : true,
    		showColumnLines       : true,
    		showRowLines          : true,
    		export : {allowExportSelectedData:true, enabled:true},
            onExporting: function (e) {
            	var workbook = new ExcelJS.Workbook();
            	var worksheet = workbook.addWorksheet("Sheet1");
			    DevExpress.excelExporter.exportDataGrid({
			        component: e.component,
			        worksheet : worksheet,
			        autoFilterEnabled: true,
			    }).then(function() {
			        workbook.xlsx.writeBuffer().then(function(buffer) {
			            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}.xlsx");
			        });
			    });
			    e.cancel = true;
            },
    		sorting: { mode: "multiple"},
    		loadPanel : { enabled: false },
    		remoteOperations : {filtering:false, grouping:false, paging:false, sorting:false, summary:false},
    		editing: { mode: 'batch', allowUpdating: true, allowAdding: false, allowDeleting: false, selectTextOnEditStart: true},
    		filterRow: { visible: false },
    		rowAlternationEnabled : true,
    		columnFixing: {	enabled: true},
    		dataSource: new DevExpress.data.ArrayStore({
    		   key: ["RSK_ELMT_C_NM"]
    		}),
    		pager: {
    		    visible: true,
    		    showNavigationButtons: true,
    		    showInfo: true
    		},
    		paging: {
    			enabled: false
    		},
    		scrolling: {
    		    mode: "standard",
    		    preloadEnabled: false
    		},
    	    searchPanel: {
    	           visible: false,
    	           width: 250,
    	           searchVisibleColumnsOnly: true
    	       },
    	    selection: {
    	       	allowSelectAll : true,
    	       	deferred : false,
    	       	mode : "multiple", /*none, single, multiple*/
    	       	selectAllMode : "allPages",  /*: 'page' | 'allPages'*/
    	       	showCheckBoxesMode : "always"  /*'onClick' | 'onLongTap' | 'always' | 'none'*/
    	       },
    	    scrolling   : {
    	        mode    : "virtual"
    	    },
    	    columns:
		     [
		         {
		             dataField            : "RSK_CATG1_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_002","위험분류")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 80
		         },
		         {
		             dataField            : "RSK_CATG1_C",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_002","위험분류")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 80
		         },
		         {
		             dataField            : "RSK_CATG2_C",
		             caption              : '${msgel.getMsg("RBA_50_01_04_01_122","위험분류(Lv2)")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 150
		         },
		         {
		             dataField            : "RSK_CATG2_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_01_04_01_122","위험분류(Lv2)")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 150
		         },
		         {
		             dataField            : "RSK_VALT_ITEM_NM",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_003","평가항목")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 220
		         },
		         {
		             dataField            : "RSK_VALT_ITEM",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_003","평가항목")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false
		         },
		         {
		             dataField            : "RSK_ELMT_C",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_008","위험요소")}',
		             alignment            : "left",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 300
		         },
		         {
		             dataField            : "RSK_ELMT_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_008","위험요소")}',
		             alignment            : "left",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 300
		         },
		         {
		             dataField            : "RA_ITEM_CODE",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_008","구간상세코드")}',
		             alignment            : "left",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 10
		         },
		         {
		             dataField            : "RA_INTV_VAL",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_009","구간값")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 200
		         },
		         {
		             dataField            : "USE_YN",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_007","사용여부")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 60,
		             lookup : { dataSource  : [{"KEY":"1","VALUE":"Y"},{"KEY":"0","VALUE":"N"}] /* {"KEY":"","VALUE":"=선택="}, */
				                                                             ,displayExpr : "VALUE",valueExpr   : "KEY"}
		         },
		         {
		             dataField            : "RSK_VALT_CAL_STD",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_010","지표")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             lookup : { dataSource  : [{"KEY":"1","VALUE":"고객수"},{"KEY":"0","VALUE":"거래금액"}] /* {"KEY":"","VALUE":"=선택="}, */
                     ,displayExpr : "VALUE",valueExpr   : "KEY"},
		             width                : 150
		         },
		         {
			            caption      : '${msgel.getMsg("RBA_50_03_02_01_005","적용대상")}',
			            alignment    : "center",
			            columns      : [
			            	{
					             dataField            : "INDV_YN",
					             caption              : '${msgel.getMsg("RBA_50_03_02_01_011","개인")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false,
					             lookup : { dataSource  : [{"KEY":"1","VALUE":"●"},{"KEY":"0","VALUE":""}] /* {"KEY":"","VALUE":"=선택="}, */
                                                   ,displayExpr : "VALUE",valueExpr   : "KEY"},
					             width                : 50
					         },
					         {
					             dataField            : "CORP_YN",
					             caption              : '${msgel.getMsg("RBA_50_03_02_01_012","법인")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false,
					             lookup : { dataSource  : [{"KEY":"1","VALUE":"●"},{"KEY":"0","VALUE":""}] /* {"KEY":"","VALUE":"=선택="}, */
                                                 ,displayExpr : "VALUE",valueExpr   : "KEY"},
					             width                : 50
					         }
					       ]
			       },
		         {
		             dataField            : "RSK_PNT",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_013","위험점수")}',
		             alignment            : "right",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 100
		         },
		         {
		             dataField            : "EDD_YN",
		             caption              : '${msgel.getMsg("RBA_50_03_02_01_004","당연EDD여부")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             lookup : { dataSource  : [{"KEY":"H","VALUE":"H"},{"KEY":"Y","VALUE":"Y"},{"KEY":"N","VALUE":"N"}] /* {"KEY":"","VALUE":"=선택="}, */
                     ,displayExpr : "VALUE",valueExpr   : "KEY"},
		             width                : 100
		         },
		         {
			            caption      : '${msgel.getMsg("RBA_50_03_02_01_006","적용모델")}',
			            alignment    : "center",
			            columns      : [
			            	{
					             dataField            : "I_MODEL_YN",
					             caption              : '${msgel.getMsg("RBA_50_03_02_01_014","I모델")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false,
					             lookup : { dataSource  : [{"KEY":"1","VALUE":"●"},{"KEY":"0","VALUE":""}] /* {"KEY":"","VALUE":"=선택="}, */
			                     ,displayExpr : "VALUE",valueExpr   : "KEY"},
					             width                : 50
					         },
					         {
					             dataField            : "B_MODEL_YN",
					             caption              : '${msgel.getMsg("RBA_50_03_02_01_015","B모델")}',
					             alignment            : "center",
					             allowResizing        : true,
					             allowSearch          : true,
					             allowSorting         : true,
					             allowEditing         : false,
					             lookup : { dataSource  : [{"KEY":"1","VALUE":"●"},{"KEY":"0","VALUE":""}] /* {"KEY":"","VALUE":"=선택="}, */
			                     ,displayExpr : "VALUE",valueExpr   : "KEY"},
					             width                : 50
					         }
					       ]
			       }

		     ],
		     onCellPrepared : function(e){
		          if(e.rowType === 'data' && ( e.column.dataField == 'RSK_ELMT_C_NM') ){
		           e.cellElement.css("color", "blue");
		          }
	         },
	         onCellClick: function(e){
		    	 if(e.rowType === 'data' && ( e.column.dataField === 'RSK_ELMT_C_NM' ) ){
		    		 if(e.data){
		    	            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
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


	// 그리드 클릭 - KRI 상세정보 팝업 호출
	function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId){

        var pageID  = "RBA_50_03_02_02";
        var classID = "RBA_50_03_02_02";
        var form2  = document.form2;

        //alert( "test popup : " + colId);
        if (colId == "RSK_ELMT_C_NM") {

        	//alert( "call popup ");

            form2.pageID.value    = pageID;
            form2.classID.value   = classID;
            form2.BAS_YYMM.value  = form1.BAS_YYMM.value;
            form2.FLAG.value      = "1";
            form2.RSK_ELMT_C.value     = obj.RSK_ELMT_C;		// 위험코드
            form2.RA_ITEM_CODE.value   = obj.RA_ITEM_CODE;      // 구간상세코드
            form2.RSK_VALT_ITEM.value  = obj.RSK_VALT_ITEM;     // 평가항목
            form2.GYLJ_S_C_NM.value = form1.approvalState.value;  // 결재상태

            //alert( "test popup : " + form2.FLAG.value);

            form2.target          = form2.pageID.value;
            var win               = window_popup_open(form2.pageID.value, 750, 850, '','yes');
            form2.action          = '<c:url value="/"/>0001.do';
            form2.submit();
        }
    }

	function setting() {
/* 		form1.RSK_ELMT_C_NM.style.width="200px";
		var RA_CHG_DT = form1.RA_CHG_DT.value;
		var year 	= RA_CHG_DT.substring(0,4) + '${msgel.getMsg("RBA_90_01_03_01_202","년")} ';
		var month 	= RA_CHG_DT.substring(4,6) + '${msgel.getMsg("RBA_90_01_03_01_203","월")} ';
		var day 	= RA_CHG_DT.substring(6,8) + '${msgel.getMsg("RBA_90_01_03_01_204","일")}';
		$("#RA_CHG_DT_TEMP").text(year + month + day);

		if("99991231" == BAS_YYMM){
			$('#fixData').hide();
		} */
	}

	/*
	 * KoFIU지표 코드관리 (위험구분 - 카테고리 - 항목)
	 */
	function jipyoSelectChange(v_gubun, nextGrp, GrpObj, v_afterFun) {
		nextSelectChangeReportIndex(v_gubun, form1.RA_CHG_DT.value, nextGrp, GrpObj, v_afterFun , gubun);
	}

	function onAftreRptGjdtCdList() {
		nextSelectChangeReportIndex("RSK_CATG",form1.RSK_CATG.value, "A002" ,"" ,"","INIT");
		nextSelectChangeReportIndex("RSK_FAC", form1.RSK_FAC.value, "A003" ,"" ,"","INIT");
		nextSelectChangeReportIndex("RSK_CATG1_C", form1.RSK_CATG1_C.value, "A007" ,"" ,"","");
		nextSelectChangeReportIndex("ITEM_S_C", form1.ITEM_S_C.value, "A010" ,"" ,"","");
		nextSelectChangeReportIndex("IN_METH_C", form1.IN_METH_C.value, "A013" ,"" ,"","");

		form1.RSK_FAC_NM.value = '';
		form1.RSK_ELMT_C_NM.value = '';
		form1.RSK_CATG.value = '';
		form1.RSK_FAC.value = '';
		form1.RSK_CATG1_C.value = '';
		form1.ITEM_S_C.value = '';
		form1.IN_METH_C.value = '';

	    doSearch();
	}

	function onAftreJipyoCCdList() {
		nextSelectChangeReportIndex("RSK_FAC", form1.RA_CHG_DT.value, "A003" ,"" ,"","INIT");
	}

	function doSearch2(type){
        if(type == 'copy'){
        	window.location.href = window.document.URL;
        }
       // overlay.show(true, true);

        var params   = new Object();
 		var methodID = "doSearch";
 		var classID  = "RBA_50_01_01_01";

 		params.pageID 	= "RBA_50_03_02_01";
 		params.BAS_YYMM = form1.BAS_YYMM.value; //기준연도3

 		sendService(classID, methodID, params, doSearch2_end, doSearch2_end);
    }

    // 위험평가 일정관리 조회 end
    function doSearch2_end(gridData, data){
    	overlay.hide();
    	

    }

	function doSearch() {
		//overlay.show(true, true);

		var methodID = "doSearch";
		var obj = new Object();
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "doSearch";
		obj.BAS_YYMM 	= form1.BAS_YYMM.value;
 		obj.RSK_CATG1_C 	= form1.RSK_CATG1_C.value;
		obj.RSK_VALT_ITEM 	= form1.RSK_VALT_ITEM.value;
		obj.USE_YN 	    = form1.use_yn.value;
		obj.EDD_YN 	    = form1.edd_yn.value;
		obj.INDV_YN = '';
		obj.CORP_YN = '';
		obj.I_MODEL_YN = '';
		obj.B_MODEL_YN = '';

		if( form1.indiv_flag.value == '1' ) {
			obj.INDV_YN 	= '1';
		} else if( form1.indiv_flag.value == '2' ) {
			obj.CORP_YN 	= '1';
		}

		if( form1.model_flag.value == 'I' ) {
			obj.I_MODEL_YN 	= '1';
		} else if( form1.model_flag.value == 'B' ) {
			obj.B_MODEL_YN 	= '1';
		}

		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
	}
	function doSearch_end(dataSource) {
		setData(dataSource);			//화면에 사용될 데이터 및 테이블을 셋팅
 		/* checkFixJipyo(); */	//지표확정여부 및 결재상태코드 조회해서 값 셋팅
		/* setJQuery(); */
		/* overlay.hide(); */

		doSearch00();
	}


	function doSearch00() {

	    var params = new Object();
        var methodID 	= "doSearch00";
		var classID  = "RBA_50_01_02_01";

		params.pageID 	= "RBA_50_01_02_01";
		params.BAS_YYMM   = form1.BAS_YYMM.value;//기준연도
		sendService(classID, methodID, params, doSearch00_end, doSearch00_fail);

	}

	function doSearch00_end(gridData, data) {

		//alert( "step : " + data.GRID_DATA[0].ING_STEP );
		form1.ING_STEP.value = data.GRID_DATA[0].ING_STEP;
		form1.ING_STEP_NM.value = data.GRID_DATA[0].ING_STEP_NM;
	}
	function doSearch00_fail(){
		console.log("doSearch00_fail");
    }

	// 화면에 있는 tableRow 삭제(헤더테이블 1row 제외)
    function deleteRows() {
        var tbl = document.getElementById('jipyoTable');
        var lastRow = tbl.rows.length - 1;
        for (i = lastRow; 0 < i; i--) {
            tbl.deleteRow(i);
        }
    }

	function setData(dataSource) {
		deleteRows();
    	GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
    	var cnt = dataSource.length;
    	var confirmCnt = 0;
    	
    	if( cnt > 0 ) {
    		form1.approvalState.value		=	dataSource[0].GYLJ_S_C_NM;		// 결재상태
    		
    		form1.GYLJ_ID.value 			=	dataSource[0].GYLJ_ID;			// 결재ID
            form1.GYLJ_S_C.value			=	dataSource[0].GYLJ_S_C;		// 결재상태코드
            
            form1.GYLJ_ROLE_ID.value			=	dataSource[0].GYLJ_ROLE_ID;	
            form1.NEXT_GYLJ_ROLE_ID.value			=	dataSource[0].NEXT_GYLJ_ROLE_ID;	
            form1.FIRST_GYLJ.value			=	dataSource[0].FIRST_GYLJ;	
            form1.END_GYLJ.value			=	dataSource[0].END_GYLJ;	
            
            //alert( "GYLJ_S_C : " + dataSource[0].GYLJ_S_C + " GYLJ_ID : " + form1.GYLJ_ID.value);
    	}
    	
    	
    	$("#GRID_CNT").text('(' + cnt + ' 항목)');
    	$("#GRID_CNT2").text(cnt);

    	$(":checkbox").prop("checked", false);
    	

    	$("#ITEM_S_C_CNT").text(confirmCnt);
    }
    function checkFixJipyo() {
    	var methodID = "checkFixJipyo";
		var obj = new Object();
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "checkFixJipyo";
		obj.RA_CHG_DT 	= form1.RA_CHG_DT.value;

		sendService(classID, methodID, obj, checkFixJipyo_success, checkFixJipyo_fail)
	}

	function checkFixJipyo_success(dataSource) {
		if(dataSource[0].length != 0 ) {
			form1.JIPYO_FIX_YN.value = dataSource[0].JIPYO_FIX_YN;	//지표확정여부 (0:미확정, 1:확정)
			form1.GYLJ_S_C.value = dataSource[0].GYLJ_S_C;			//지표결재상태코드 ('A014', 0:미결재, 12:승인요청, 22:반려, 3:완료)

			// 보고기준일자값에 맞춰서 배치기준일(데이터기준일)을 가져온다.
			var BT_BAS_DT = dataSource[0].BT_BAS_DT
			if (BT_BAS_DT == '0') {	//확정일자가 null인 경우
				$("#BT_BAS_DT").text('${msgel.getMsg("RBA_90_01_03_01_200","미확정된 일자")}');
			} else {
				var year = BT_BAS_DT.substring(0,4)+'${msgel.getMsg("RBA_90_01_03_01_202","년")} ';
				var month = BT_BAS_DT.substring(4,6)+'${msgel.getMsg("RBA_90_01_03_01_203","월")} ';
				var day = BT_BAS_DT.substring(6,8)+'${msgel.getMsg("RBA_90_01_03_01_204","일")}';
				$("#BT_BAS_DT").text('▶ ' + year + month + day);
			}
		}
	}

	function checkFixJipyo_fail(){
		overlay.hide();
	}

	function setJQuery() {
		//입력값에서 엔터입력시 다음 row에 입력값으로 포커스를 넘겨준다.
		var searchElementsLength; searchElementsLength = $("[id^=IN_V_TP_C_]").length;
		$("[id^=IN_V_TP_C_]").each( function( index, item ) {
 			var tabIndex = ( index + 1 );
 			$( this ).attr( "tabindex", tabIndex );
 			$( this ).keydown( function( e ) {
 				var keyCode = e.keyCode || e.which;

 				if ( keyCode == 13 ) {
 					var IN_V_TP_C; IN_V_TP_C = "IN_V_TP_C_"+tabIndex;
 					$( "#"+IN_V_TP_C).focus();
 				}

 				if ( tabIndex == searchElementsLength ) {
 					if ( keyCode == 9 || keyCode == 13) {
 						e.preventDefault();
 						$("#IN_V_TP_C_0" ).focus();
 					}
 				}
 			});

 			/*
 			 * 입력값의 속성인 input type='number'가 크롬브라우저에서 콤마가 들어간 숫자는 화면에 출력되지 않는 경우 확인.
 			 * 타입체크 강화하고 text 타입으로 변경	20190208
 			 *
 			 * 크롬에서는 onkeyup이벤트가 제대로 동작하지 않는경우 존재.
 			 * 중복된 작업이지만 onkeyup과 onblur를 함께사용 20190219
 			 */
			$(this).blur( function() {
				$(this).val($(this).val().replace(/(?!^-)[^0-9.YN]/gi, ""));

				//입력값에 값을 입력중일때 실시간으로 천단위로 콤마를 찍는다. 20190219
				$(this).val( $(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') );

			});
 			$(this).keyup( function() {
				var IN_V = $(this).val().replace(/[가-힣|ㄱ-ㅎ|ㅏ-ㅣ|,]/gi,"");
				var firstDotIdx = IN_V.indexOf('.');
				var lastDotIdx = IN_V.lastIndexOf('.');

				if (firstDotIdx != lastDotIdx) { //소수점이 2개이상 존재
					showAlert('${msgel.getMsg("RBA_90_01_03_01_212","소수점은 한 개만 사용가능합니다.")}', 'WARN');
					$(this).val( IN_V.replace(/[^0-9]/gi,"") ); //0~9 외 입력불가
				} else {
					$(this).val( IN_V.replace(/(?!^-)[^0-9.]/g, "") );
				}

				//기존 저장버튼 클릭시 doSave에서 하던 입력값 유효값체크를 실시간으로 하도록 변경. 20190222
				IN_V = $(this).val();
				var IN_V_length = IN_V.length - 1;
				var _pattern;
// 				_pattern = /^(\d{1,10}([.]\d{0,2})?)?$/;
				_pattern = /^-?(\d{1,10}([.]\d{0,2})?)?$/;

				if ( !_pattern.test(IN_V) ) {	// 10억미만, 소수점 2째자리인지 체크정규식
					if (lastDotIdx != -1 && (IN_V_length > lastDotIdx+2) ) {	//소수점이 존재하고, 소수점 3째자리 값 입력시 true
				    	showAlert("${msgel.getMsg('RBA_90_01_03_01_004','입력값')}( "+IN_V+" )${msgel.getMsg('AML_20_01_10_32_027','은 저장할 수 없습니다.')} \n${msgel.getMsg('AML_20_01_10_32_028','소수점 둘째자리까지만 입력가능합니다.')}", 'WARN');
				    	IN_V_length = IN_V.indexOf('.')+3;
					} else if (IN_V == '.') {
						showAlert("${msgel.getMsg('RBA_90_01_03_01_004','입력값')}( "+IN_V+" )${msgel.getMsg('AML_20_01_10_32_027','은 저장할 수 없습니다.')} \n${msgel.getMsg('AML_20_01_10_32_029','숫자를 입력하세요.')}", 'WARN');
					} else {
				    	showAlert("${msgel.getMsg('RBA_90_01_03_01_004','입력값')}( "+IN_V+" )${msgel.getMsg('AML_20_01_10_32_027','은 저장할 수 없습니다.')} \n${msgel.getMsg('AML_20_01_10_32_030','입력값은 10,000,000,000(10억)미만의 숫자로 입력가능합니다.')}", 'WARN');
				    	IN_V_length = 10;
					}
			    	$(this).val( IN_V.substring(0, IN_V_length) );
				}

				//입력값에 값을 입력중일때 실시간으로 천단위로 콤마를 찍는다. 20190219
				$(this).val( $(this).val().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,') );
			});
 		});
	}

	function popDetail(id) {
		var cellData = GridObj1.getKeyByRowIndex(id);
		var RSK_FAC_NM = cellData.RSK_FAC_NM;
		var IN_V_TP_C = form1['IN_V_TP_C_' + id].value;

		var CNCT_JIPYO_C_I = cellData.CNCT_JIPYO_C_I;

		form2.pageID.value  = 'RBA_90_01_03_05';
		var	win; win = window_popup_open(form2.pageID.value, 1060, 825, '');

		form2.RA_CHG_DT.value 		= form1.RA_CHG_DT.value;
		form2.RSK_FAC_NM.value 	  	= RSK_FAC_NM;
		form2.IN_V_TP_C.value 		= IN_V_TP_C;
		form2.CNCT_JIPYO_C_I.value	= CNCT_JIPYO_C_I;
		form2.JIPYO_VIEW.value		= "Y";
		form2.target = form2.pageID.value;
		form2.action = '<c:url value="/"/>0001.do';
		form2.submit();
	}


	function doSave() {
		if ( !checkCnt() ) {
			showAlert('${msgel.getMsg("AML_10_01_01_01_003","저장할 데이타를 선택하십시오.")}', 'WARN');
			return;
		}
// 		if ( !checkVal() ) return;

		var index;
		var cellData;

		var RSK_FAC_NM_arr = '';		//보고지표인덱스
		var IN_V_TP_C_arr = '';		//입력값
		var MAX_IN_V_arr  = '';		//MAX값
		var IN_V_TP_C_TYPE_arr = '';		//입력값

		var indexArr = form1.selRowIndex.value.split(",");
		for ( i=0; i < indexArr.length; i++ ) {
			index = parseInt(indexArr[i]);
			cellData =  GridObj1.getKeyByRowIndex(index);

			if (cellData.ITEM_S_C == '2') {	//확정
				showAlert('${msgel.getMsg("RBA_90_01_03_01_213","확정된 지표데이터의 입력값을 변경할 수 없습니다.")}\n${msgel.getMsg("RBA_90_01_03_01_214","[확정/취소]버튼으로 저장상태에서는 변경가능합니다.")}', 'WARN');
				return;
			}

			var IN_V_TP_C = form1['IN_V_TP_C_' + index].value.replace(/[,]/gi,"");

			if (IN_V_TP_C == '') {
				showAlert('${msgel.getMsg("RBA_90_01_03_01_215","잘못된 입력값입니다.")}', 'WARN');
				form1['IN_V_TP_C_' + index].focus();
				return;
			}else if (IN_V_TP_C =='해당없음'){
				IN_V_TP_C = 0;
			}
			RSK_FAC_NM_arr += cellData.RSK_FAC_NM+',';
			IN_V_TP_C_arr += IN_V_TP_C+',';
			IN_V_TP_C_TYPE_arr += cellData.IN_V_TP_C+',';
			MAX_IN_V_arr += cellData.MAX_IN_V+',';
		}

		RSK_FAC_NM_arr = RSK_FAC_NM_arr.substring(0, RSK_FAC_NM_arr.length-1);
		IN_V_TP_C_arr = IN_V_TP_C_arr.substring(0, IN_V_TP_C_arr.length-1);
		MAX_IN_V_arr = MAX_IN_V_arr.substring(0, MAX_IN_V_arr.length-1);
		IN_V_TP_C_TYPE_arr = IN_V_TP_C_TYPE_arr.substring(0, IN_V_TP_C_TYPE_arr.length-1);
		showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>', '저장', function(){
			var obj = new Object();
			obj.pageID 		  = pageID;
			obj.classID 	  = classID;
			obj.methodID 	  = "doSave";
			obj.RA_CHG_DT 	  = form1.RA_CHG_DT.value;
			obj.RSK_FAC_NM_arr = RSK_FAC_NM_arr;
			obj.IN_V_TP_C_arr = IN_V_TP_C_arr;
			obj.MAX_IN_V_arr  = MAX_IN_V_arr;
			obj.IN_V_TP_C_TYPE_arr = IN_V_TP_C_TYPE_arr;
			obj.gridData	  = GridObj1.getSelectedRowsData();
			var methodID = "doSave";

			sendService(classID, methodID, obj, doSearch, doSearch);
		});
	}

	function doReportFileUpload(){
		if ( !checkVal() ) return;

		var form4 = document.form4;
		form4.pageID.value  = "RBA_90_01_03_06";
		form4.RA_CHG_DT.value=form1.RA_CHG_DT.value;
      	var   win; win = window_popup_open(form4.pageID.value, 605,390, '');
      	form4.target = form4.pageID.value;
      	form4.action = '<c:url value="/"/>0001.do';
      	form4.submit();
	}

	function doAutoImport(){
		if ( !checkVal() ) return;

	    showConfirm("${msgel.getMsg('RBA_90_01_03_01_216','자동 가져오기를 하시겠습니까?')}", "가져오기", function(){
			var methodID = "doAutoImport";
		    var obj = new Object();
		    obj.pageID 		  = pageID;
		    obj.classID 	  = classID;
		    obj.methodID 	  = "doAutoImport";
		    obj.RA_CHG_DT 	  = form1.RA_CHG_DT.value;
		    obj.gridData	  = GridObj1.getSelectedRowsData();
		    sendService(classID, methodID, obj, doSearch, doSearch);
		});
	}



	

	function doAttachFile() {
		if ( !checkCnt() ) {
	 	   showAlert('${msgel.getMsg("RBA_90_01_03_01_217","데이터를 선택하십시오.")}', 'WARN');
	       return;
	    }
		if ( !checkVal() ) return;

		var indexArr = form1.selRowIndex.value.split(",");
		if (indexArr.length > 1) {
			showAlert('${msgel.getMsg("RBA_90_01_03_01_218","증빙자료첨부는 단일건 처리만 가능합니다.")}', 'WARN');
			return;
		}

		var cellData;
	    for ( i=0; i < indexArr.length; i++ ) {
	 	    index = parseInt(indexArr[i]);
	 	    cellData =  GridObj1.getKeyByRowIndex(index);

	 	    if (cellData.ITEM_S_C == '2') {	//확정
	 	    	showAlert('${msgel.getMsg("RBA_90_01_03_01_213","확정된 지표데이터의 입력값을 변경할 수 없습니다.")}\n${msgel.getMsg("RBA_90_01_03_01_214","[확정/취소]버튼으로 저장상태에서는 변경가능합니다.")}', 'WARN');
	 	    	return;
	 	    }
	    }

		cellData = GridObj1.getKeyByRowIndex(indexArr[0]);
		var RSK_FAC_NM = cellData.RSK_FAC_NM;
		var RSK_ELMT_C_NM = cellData.RSK_ELMT_C_NM;
		var ATTCH_FILE_NO = cellData.ATTCH_FILE_NO;

      	form5.pageID.value  = "RBA_90_01_03_03";
      	var win; win = window_popup_open(form5.pageID.value, 605, 435, '');

      	form5.RA_CHG_DT.value = form1.RA_CHG_DT.value;
      	form5.RSK_FAC_NM.value = RSK_FAC_NM;
      	form5.RSK_ELMT_C_NM.value = RSK_ELMT_C_NM;
      	form5.ATTCH_FILE_NO.value = ATTCH_FILE_NO;
      	form5.gubun.value = 'upload'
      	form5.target = form5.pageID.value;
      	form5.action = '<c:url value="/"/>0001.do';
      	form5.submit();
	}


	function doConfirm() {

		//alert( "step : " + form1.ING_STEP.value);
		if( form1.approvalState.value != "결재완료" ){
			showAlert('위험요소 결제완료 후, 확정이 가능 합니다.','WARN');
       		return;
		}

		if(form1.ING_STEP.value == "20"){

            showConfirm("${msgel.getMsg('RBA_50_01_01_006','확정을 하시겠습니까?')}", "확정",function(){
                     var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = form1.BAS_YYMM.value;
                     params.FIX_YN = "1";
                     params.ING_STEP = "30";  //confirmState
                     params.RBA_VALT_SMDV_C = "2.2";

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);

            });


        }else{
        	if(form1.ING_STEP.value == "30"){

	            showConfirm("${msgel.getMsg('RBA_50_01_01_007','확정을 취소하시겠습니까?')}", "취소",function(){
	            	// $("button[id='btn_07']").prop('disabled', true);

	                 var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = form1.BAS_YYMM.value;
                     params.FIX_YN = "0";
                     params.ING_STEP = "20";  //confirmState
                     params.RBA_VALT_SMDV_C = "2.2";

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);
	            });
        	}else {
        		// 일정정보관리 확정단계에서만 취소 할수 있습니다. ==> 라고 수정이 필요
        		if( form1.ING_STEP.value > "30") {
        			showAlert('${msgel.getMsg("RBA_50_01_01_01_113","이후 확정된 STEP을 취소후 진행 할수 있습니다.")}','WARN');
        		} else {
        			showAlert('${msgel.getMsg("RBA_50_01_01_01_114","이전 STEP이 확정된 후 진행 할수 있습니다.")}','WARN');
				}
           		return;
            }
        }

	}


	function doConfirm_end() {
        //$("button[id='btn_04']").prop('disabled', false);
        doSearch();
    }

	function downloadFile(id) {
		var cellData = GridObj1.getKeyByRowIndex(id);
		var ATTCH_FILE_YN = cellData.ATTCH_FILE_YN;

		if (ATTCH_FILE_YN == 'Y') {
			form5.pageID.value  = "RBA_90_01_03_03";
	      	var win; win = window_popup_open(form5.pageID.value, 605, 435, '');

	      	form5.RA_CHG_DT.value = form1.RA_CHG_DT.value;
	      	form5.RSK_FAC_NM.value = cellData.RSK_FAC_NM;
	      	form5.RSK_ELMT_C_NM.value = cellData.RSK_ELMT_C_NM;
	      	form5.ATTCH_FILE_NO.value = cellData.ATTCH_FILE_NO;
	      	form5.gubun.value = 'download';
	      	form5.target = form5.pageID.value;
	      	form5.action = '<c:url value="/"/>0001.do';
	      	form5.submit();

		} else {
			showAlert('${msgel.getMsg("RBA_90_01_03_01_222","증빙파일이 없습니다.")}', 'WARN');
		}
	}

	function doRegisterNote(id) {
		var cellData = GridObj1.getKeyByRowIndex(id);

		form6.pageID.value  = "RBA_90_01_03_07";
      	var win; win = window_popup_open(form6.pageID.value, 850, 700, '');

      	form6.RA_CHG_DT.value = form1.RA_CHG_DT.value;
      	form6.RSK_FAC_NM.value = cellData.RSK_FAC_NM;
      	form6.RSK_ELMT_C_NM.value = cellData.RSK_ELMT_C_NM;
      	form6.RSK_ELMT_DTL_CTNT.value = cellData.RSK_ELMT_DTL_CTNT;
      	form6.BIGO_CTNT.value = cellData.BIGO_CTNT;
      	form6.target = form6.pageID.value;
      	form6.action = '<c:url value="/"/>0001.do';
      	form6.submit();
	}

	function doExcelDown() {
		ExcelDownHistorySave();
		return;
   	}

	function ExcelDownHistorySave(){
		 from0.pageID.value = "AML_00_03_01_01";
		 from0.target = from0.pageID.value;
		 from0.action = "<c:url value='/'/>0001.do";
		 window_popup_open(from0.pageID.value, 600, 300, '','yes');
	 	 from0.submit();
	}

	function comletedAction(result){
		if(result =="1"){
			form7.RA_CHG_DT.value     = form1.RA_CHG_DT.value;
			form7.RSK_FAC_NM.value    = form1.RSK_FAC_NM.value;
			form7.RSK_ELMT_C_NM.value     = form1.RSK_ELMT_C_NM.value;
			form7.JIPYO_C.value      = form1.JIPYO_C.value;
			form7.RSK_VALT_ITEM_NM.value   = $("#JIPYO_C")[0].options[$("#JIPYO_C")[0].selectedIndex].text;
			form7.RSK_CATG.value     = form1.RSK_CATG.value;
			form7.RSK_CATG_NM.value  = $("#RSK_CATG")[0].options[$("#RSK_CATG")[0].selectedIndex].text;
			form7.RSK_FAC.value      = form1.RSK_FAC.value;
			form7.RSK_CATG2_C_NM.value   = $("#RSK_FAC")[0].options[$("#RSK_FAC")[0].selectedIndex].text;
			form7.IN_METH_C.value    = form1.IN_METH_C.value;
			form7.CORP_YN.value = $("#IN_METH_C")[0].options[$("#IN_METH_C")[0].selectedIndex].text;
			form7.RSK_CATG1_C.value       = form1.RSK_CATG1_C.value;
			form7.RSK_CATG1_C_NM.value    = $("#RSK_CATG1_C")[0].options[$("#RSK_CATG1_C")[0].selectedIndex].text;
			form7.ITEM_S_C.value     = form1.ITEM_S_C.value;
			form7.ITEM_S_C_NM.value  = $("#ITEM_S_C")[0].options[$("#ITEM_S_C")[0].selectedIndex].text;
			form7.MNG_BRNO.value     = form1.v_BRN_CD.value;
			form7.I_MODEL_YN.value  = form1.v_BRN_CD_NM.value;

			form7.pageID.value = 'RBA_90_01_03_01_ExcelDown';
			form7.target	= "down_frame1";
			form7.action    = "<c:url value='/'/>0001.do";
			form7.submit();
		}
	}

	function showTooltip(el) {
		var text = el.getAttribute('data-full');
		if(text.length>2){
			el.setAttribute('title', text);
		}
	}


	function addComma(num){
    	var regexp = /\B(?=(\d{3})+(?!\d))/g;
    	return num.toString().replace(regexp , ',')
    }

	function checkCnt() {
		var isTrue = false;
		var index; index = parseInt(0);
		var selRowIndex = '';

		$("input[name=SELECTED]:checkbox").each(function() {
			if ($(this).is(":checked")) {
				selRowIndex += index+',';
				isTrue = true;
			}
			index++;
		});

		form1.selRowIndex.value = selRowIndex.substring(0, selRowIndex.length-1);
		return isTrue;
	}

	function checkVal() {
		if (form1.JIPYO_FIX_YN.value == 0) {
	    	showAlert('${msgel.getMsg("RBA_90_01_03_01_220","확정등록되지 않은 지표데이터는 저장할 수 없습니다.")}', 'WARN');
	    	return false;
	    } else if (form1.GYLJ_S_C.value == '12' ||form1.GYLJ_S_C.value == '3' ) {	//지표결재상태코드 ('A014', 0:미결재, 12:승인요청, 22:반려, 3:완료)
			showAlert('${msgel.getMsg("RBA_90_01_03_01_221","결재가 진행중이거나 완료된 지표데이터는 수정할 수 없습니다.")}', 'WARN');
			return false;
		} else {
			return true;
		}
	}

	function checkNum(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 190 || keyID == 110 || keyID == 13 || keyID == 9 || keyID == 189 || keyID == 109 ) {
			return;
		} else {
			return false;
		}
	}

	function checkAll() {
		if ($('input[name="allCheck"]').is(":checked")) {	// 체크 박스 모두 체크
			$("input[name=SELECTED]:checkbox").each(function() {
				$(":checkbox").prop("checked",true);
			});
		} else {	// 체크 박스 모두 해제
			$("input[name=SELECTED]:checkbox").each(function() {
				$(":checkbox").prop("checked",false);
			});
		}
	}

	function checkChangeBox(id) {
		var cellData = GridObj1.getKeyByRowIndex(id);
		var IN_V = cellData.IN_V;								//기존 입력값
		var IN_V_NEW = 'IN_V_TP_C_'+id;
		IN_V_NEW = $('#'+IN_V_NEW).val().replace(/[,]/gi,"");	//수정된 입력값

		/*
		 * IE에서 버전에 따라 onchange이벤트가 정상적으로 발생하지 않는 경우가 존재.
		 * 기존 onchange -> onblur이벤트로 변경하고 기존에 조회된값과 수정된 입력값이 다를경우에만 체크박스가 체크되도록 변경
		 * 즉, 기존 onchage와 동일하게 동작한다. 20190219
		 */
		if (IN_V != IN_V_NEW) {
			var index; index = 0;
			$("input[name=SELECTED]:checkbox").each(function() {
				if (id == index) {
					$(this).attr("checked", true);
				}
				index++;
			});
		}
	}
	
	
	function getLastData() {

		var pageID  = "RBA_50_03_02_03";
        var classID = "RBA_50_03_02_03";
        var form2  = document.form2;

       // alert( "test popup : " + colId);
        if( form1.approvalState.value == "결재완료" ){
			showAlert('위험요소 결제완료후 신규위험요소 적용 불가 합니다.','WARN');
       		return;
		}

        form2.pageID.value    = pageID;
        form2.classID.value   = classID;
        form2.BAS_YYMM.value       = form1.BAS_YYMM.value;


        form2.target          = form2.pageID.value;
        var win               = window_popup_open(form2.pageID.value, 1000, 550, '','yes');
        form2.action          = '<c:url value="/"/>0001.do';
        form2.submit();

		sendService(classID, methodID, obj, doSearch, getLastData_fail);
	}

	function getLastData_fail(){
		overlay.hide();
	}
	
	
	//결재요청
    function doApproval_end() {
    }
    
    function doApproval_fail() {
    }
	
	function doApproval(Flag) {

		var params = new Object();
        var methodID 	= "doApproval";
		var classID  = "RBA_50_03_02_01";
		
		
		//결재상태 확인
		if(!CheckValue(Flag)){
			return;
		}
		
//		alert( "call doApproval :  " + "${ROLE_IDS}");
	   form1.pageID.value  = "RBA_50_03_02_05";
       var win; win = window_popup_open(form1.pageID.value, 900, 680, '', 'yes');
       form1.FLAG.value	= Flag;
       form1.TABLE_NM.value	= "SRBA_RISK_ELMT_M";
       form1.LV3.value   	= " ";
       form1.ADD_CD.value	= " ";
       form1.target		= form1.pageID.value;
       form1.action		= "<c:url value='/'/>0001.do";
       form1.submit();
	}
	
	
	function CheckValue(FLAG){

		var ROLE_ID 		= form1.ROLE_ID.value;
		var GYLJ_ROLE_ID	= form1.GYLJ_ROLE_ID.value;
		var GYLJ_S_C 		= form1.GYLJ_S_C.value;
		var NEXT_GYLJ_ROLE_ID = form1.NEXT_GYLJ_ROLE_ID.value;
		var FIRST_GYLJ 		= form1.FIRST_GYLJ.value;
		var END_GYLJ 		= form1.END_GYLJ.value;
		
		if( FLAG == "0" ) {

			if( form1.approvalState.value != "미입력") {
				if( form1.GYLJ_S_C.value != "22" && form1.GYLJ_S_C.value != "0" ) {
					alert( "승인요청 할수 없는 상태 입니다 " + form1.GYLJ_S_C.value);
					return;
				}
			}
			
			if("7" == "${ROLE_IDS}" ) form1.ROLE_ID.value = "4";
			
		} else if( FLAG == "1" ) {
			if( form1.GYLJ_S_C.value != "12" ) { 
				alert( "반려 할수 없는 상태 입니다"+ form1.GYLJ_S_C.value);
				return;
			}
			
			if("7" == "${ROLE_IDS}"  ) form1.ROLE_ID.value = "104";
			
			//alert( "call doApproval 1:  " + "${ROLE_IDS}");
			
		} else if( FLAG == "2" ) {
			if( form1.GYLJ_S_C.value != "12" ) { 
				alert( "결재 할수 없는 상태 입니다"+ form1.GYLJ_S_C.value);
				return;
			}
			
			if("7" == "${ROLE_IDS}" ) form1.ROLE_ID.value = "104";
			
			
			//alert( "call doApproval 2:  " + "${ROLE_IDS}");
		}


		// 결재 진행중이고 사용자의 권한과 결재이력에 등록된 최종 권한이 같으면 결재 재실행 불가
		if ( NEXT_GYLJ_ROLE_ID != ROLE_ID ) {
/* 			alert( "NEXT_GYLJ_ROLE_ID : " + NEXT_GYLJ_ROLE_ID + " ROLE_ID : " +  ROLE_ID);
			showAlert("${msgel.getMsg('RBA_90_01_04_01_110','결재 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
			return; */
		}

		// 결재 진행중이고 사용자의 권한과 결재이력에 등록된 최종 권한이 같으면 결재 재실행 불가
		if ( GYLJ_S_C != 0 && ROLE_ID == GYLJ_ROLE_ID ) {
/* 			showAlert("${msgel.getMsg('RBA_90_01_04_01_111','현재 결재가 실행 되었습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
			return; */
		}

		//결재 FLAG (0:결재요청, 1:반려, 2:승인)
		//결재상태코드 GYLJ_S_C (0 : 미결재 , 12 : 결재요청 , 22 : 반려, 3 : 완료  )

		//결재요청
		if(FLAG == "0"){

			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_112','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}
			
/* 			if(GYLJ_S_C !="2"){
				if ( FIRST_GYLJ == ROLE_ID ) {
					showAlert("${msgel.getMsg('RBA_90_01_04_01_113','승인요청 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
					return false;
				}
			} */

			

		//반려
		}else if(FLAG == "1"){

			if(GYLJ_S_C =="0"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_114','미결재 상태 입니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if ( FIRST_GYLJ == ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_115','반려 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			}

			if(GYLJ_S_C =="3"){
				showAlert("${msgel.getMsg('RBA_90_01_04_01_116','결재가 완료 되었습니다.')}", "WARN");
				return false;
			}

		//승인
		}else if(FLAG == "2"){
/* 			if ( END_GYLJ != ROLE_ID ) {
				showAlert("${msgel.getMsg('RBA_90_01_04_01_117','승인 권한이 없습니다.\\r\\n결재단계를 확인하여 주시기 바랍니다.')}", "WARN");
				return false;
			} */

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
	
	
	function doSrarchGYLJHistory() {
		
		var params = new Object();
        var methodID 	= "doApproval";
		var classID  = "RBA_50_03_02_01";

	   form1.pageID.value  = "RBA_50_03_02_06";
       var win; win = window_popup_open(form1.pageID.value, 1200, 500, '', '');
       form1.TABLE_NM.value	= "SRBA_RISK_ELMT_M";
       form1.target		= form1.pageID.value;
       form1.action		= "<c:url value='/'/>0001.do";
       form1.submit();

	}
	
	
</script>
<style>
#jipyoTable {
    border-collapse : separate;
    border-spacing:0;
}

#jipyoTable thead th{
   position: sticky;
   top: 0;
   border-right: 1px solid #ccc;
   background-color: #eaeaea;
   border-top: 2px solid #222;
    border-bottom: 1px solid #222;
    z-index:1;
}

#jipyoTable tbody td{
   border-bottom: 1px solid #e9eaeb;
   border-right: 1px solid #e9eaeb;
}

.ellipsis {
  display: inline-block;
  max-width: 50px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: middle;
  font-weight: bold;
/*   cursor: pointer; */

}
</style>
<form name="from0" method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
</form>
<form name="form7" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="RA_CHG_DT">
	<input type="hidden" name="RSK_FAC_NM">
	<input type="hidden" name="RSK_ELMT_C_NM">
	<input type="hidden" name="JIPYO_C">
	<input type="hidden" name="RSK_VALT_ITEM_NM">
	<input type="hidden" name="RSK_CATG">
	<input type="hidden" name="RSK_CATG_NM">
	<input type="hidden" name="RSK_FAC">
	<input type="hidden" name="RSK_CATG2_C_NM">
	<input type="hidden" name="IN_METH_C">
	<input type="hidden" name="CORP_YN">
	<input type="hidden" name="RSK_CATG1_C">
	<input type="hidden" name="RSK_CATG1_C_NM">
	<input type="hidden" name="ITEM_S_C">
	<input type="hidden" name="ITEM_S_C_NM">
	<input type="hidden" name="MNG_BRNO">
	<input type="hidden" name="I_MODEL_YN">
</form>

<form name="form6" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="RA_CHG_DT">
	<input type="hidden" name="RSK_FAC_NM">
	<input type="hidden" name="RSK_ELMT_C_NM">
	<input type="hidden" name="RSK_ELMT_DTL_CTNT">
	<input type="hidden" name="BIGO_CTNT">
</form>
<form name="form5" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="RA_CHG_DT">
	<input type="hidden" name="RSK_FAC_NM">
	<input type="hidden" name="RSK_ELMT_C_NM">
	<input type="hidden" name="ATTCH_FILE_NO">
	<input type="hidden" name="gubun">
</form>
<form name="form4" method="post">
	<input type="hidden"  name="pageID"/>
   	<input type="hidden"  name="classID"/>
   	<input type="hidden"  name="methodID"/>
   	<input type="hidden"  name="mode"/>
   	<input type="hidden"  name="RA_CHG_DT"/>
	<input type="hidden"  name="RSK_FAC_NM">
	<input type="hidden"  name="JIPYO_FIX_YN">
   	<input type="hidden"  name="SNO" />
   	<input type="hidden"  name="FILE_SER" />
	<input type="hidden"  name="IN_V_TP_C" >
	<input type="hidden"  name="CNCT_JIPYO_C_I" >
   	<input type="hidden"  name="JIPYO_VIEW"/>
   	
</form>
<form name="form2" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
	<input type="hidden" name="BAS_YYMM" >
	<input type="hidden" name="RSK_CATG1_C" >
	<input type="hidden" name="FLAG" >
	<input type="hidden" name="RSK_ELMT_C" >
	<input type="hidden" name="RA_ITEM_CODE" >
	<input type="hidden" name="GYLJ_S_C_NM" >
	<input type="hidden" name="RSK_VALT_ITEM" >
</form>

<form name="form1" method="post" >
	<input type="hidden" id="pageID" name="pageID">
	<input type="hidden" id="selRowIndex" name="selRowIndex">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
   	<input type="hidden" name="ATTCH_FILE_NO"/>
   	<input type="hidden" name="FILE_SER"/>
   	<input type="hidden" name="ROLE_ID" value="${ROLE_ID}">
   	<input type="hidden" name="GYLJ_LINE_G_C" value="RBA01">	<!-- 결재선구분코드 = W99 : FIU지표결과관리 -->
   	<input type="hidden" name="GYLJ_ID"/>		<!-- 결재ID -->
   	<input type="hidden" name="GYLJ_S_C"/>		<!-- 결재상태코드 -->
   	<input type="hidden" name="GYLJ_S_C_NM"/>	
   	<input type="hidden" name="FLAG"/>
   	<input type="hidden" name="TABLE_NM"/>
   	<input type="hidden" name="GYLJ_ROLE_ID"/>
   	<input type="hidden" name="NEXT_GYLJ_ROLE_ID"/>
   	<input type="hidden" name="FIRST_GYLJ" />
   	<input type="hidden" name="END_GYLJ" />
   	<input type="hidden" name="LV3" />
   	<input type="hidden" name="ADD_CD" />
   	
	<div class="inquiry-table type4">
    	<div class="table-row" style="width:25%;">
      		<div class="table-cell">
      			${condel.getLabel("RBA_50_03_02_01_001","평가회차")}
            	<div class="content">
            		<RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="" eventFunction='doSearch()' />
            	</div>
            	<%-- ${condel.getLabel('RBA_90_01_01_02_001','보고기준일')}
				${JRBACondEL.getJRBASelect('','BAS_YYMM' ,'' ,'140px' ,'JRBA_common_getBAS_YYMM' ,'' ,'','jipyoSelectChange("JIPYO_C", "A001", this, "onAftreRptGjdtCdList()")')} --%>
	 		</div>
	      	<div class="table-cell">
		       	${condel.getLabel('RBA_50_03_02_01_004','당연EDD여부')}
		       	<div class="content">
					<select name="edd_yn" id="edd_yn" class="dropdown" onChange='doSearch()'>
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='Z' >H+Y</option>
		                <option value='H' >H</option>
		                <option value='Y' >Y</option>
		                <option value='N' >N</option>
		            </select>
				</div>
		 	</div>
	      	<%-- <div class="table-cell">
	       		${condel.getLabel('RBA_50_03_02_01_003','평가항목')}
				${JRBACondEL.getJRBASelect('MAX','VALT_G' ,'A007' ,'140px' ,'' ,'' ,'ALL','')}
		 	</div> --%>
		</div>
    	<div class="table-row" style="width:25%;">
      		<div class="table-cell">
      	 		${condel.getLabel('RBA_50_03_02_01_002','위험분류')}
      	 		${JRBACondEL.getSRBASelect('','RSK_CATG1_C' ,'S001' ,'160px' ,'' ,'' ,'ALL','doSearch()')}
	 		</div>
	 		<div class="table-cell">
      			${condel.getLabel('RBA_50_03_02_01_003','평가항목')}
	         	${JRBACondEL.getSRBASelect('R342','RSK_VALT_ITEM' ,'R342' ,'160px' ,'' ,'' ,'ALL','doSearch()')}
	 		</div>

		</div>
    	<div class="table-row" style="width:25%;">
      		<div class="table-cell">
		 		${condel.getLabel('RBA_50_03_02_01_005','적용대상')}
		 		<div class="content">
				<select name="indiv_flag" id="indiv_flag" class="dropdown" onChange='doSearch()'>
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='1' >개인</option>
		                <option value='2' >법인</option>
		        </select>
		        </div>
			</div>
	      	<div class="table-cell">
	      		${condel.getLabel('RBA_50_03_02_01_006','적용모델')}
	      		<div class="content">
				<select name="model_flag" id="model_flag" class="dropdown" onChange='doSearch()'><!--onChange='ccdChange(this)'  -->
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='I' >I모델</option>
		                <option value='B' >B모델</option>
		        </select>
		        </div>
		 	</div>
		</div>
    	<div class="table-row" style="width:30%;">
	      	<div class="table-cell">
	       		${condel.getLabel('RBA_50_03_02_01_007','사용여부')}
	    		<div class="content">
					<select name="use_yn" id="use_yn" class="dropdown" onChange='doSearch()'><!--onChange='ccdChange(this)'  -->
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='1' >Y</option>
		                <option value='0' >N</option>
		            </select>
				</div>

		 	</div>
		 	<div class="table-cell">
	       		${condel.getLabel("RBA_50_01_01_047","진행상태")}
	    		<div class="content">
            		<input type="text" name= "ING_STEP_NM" size="30" class="cond-input-text" style="text-align:left" readonly="readonly" />
            	</div>

		 	</div>

		 </div>
	</div>
	<div class="inquiry-table type4">
		<div class="table-row" style="width:40%;" >
			<div style="display:flex; justify-content:left; align-items:center; height:44px">
			${condel.getLabel('RBA_90_01_01_01_027','결재상태')}
			&nbsp;&nbsp;<input type="text" style="text-align: center;" class="input_text" id="approvalState" name="approvalState" maxlength="10" readonly />
			&nbsp;${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"apprHistoryBtn", defaultValue:"결재이력", mode:"R", function:"doSrarchGYLJHistory", cssClass:"btn-36"}')}
			</div> 	
		</div>
		<div class="table-row" style="width:60%;">
			<div class="button-area">
				<input type="text" class="cond-input-text" name="ING_STEP" id="ING_STEP" value="${ING_STEP}" style="border: 0px;background-color:white;color:white" readonly="readonly"></input>
				${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
				${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"newRiskGetItem", defaultValue:"신규위험요소불러오기", mode:"C", function:"getLastData", cssClass:"btn-36"}')}
		
				<% if ( "4".equals(ROLE_IDS)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
		        	${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
		        <% } %>
				<% if ( "104".equals(ROLE_IDS)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
		        	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"okBtn", defaultValue:"결재", mode:"U", function:"doApproval(2)", cssClass:"btn-36"}')}
		        	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"refuseBtn", defaultValue:"반려", mode:"U", function:"doApproval(1)", cssClass:"btn-36"}')}
		        <% } %>
		        <% if ( "7".equals(ROLE_IDS)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
		            ${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
		        	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"okBtn", defaultValue:"결재", mode:"U", function:"doApproval(2)", cssClass:"btn-36"}')}
		        	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"refuseBtn", defaultValue:"반려", mode:"U", function:"doApproval(1)", cssClass:"btn-36"}')}
		        <% } %>
				${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"rbaConfirmBtn", defaultValue:"확정/취소", mode:"C", function:"doConfirm", cssClass:"btn-36"}')}
				
			</div>
		</div>
	</div>
	
	

	<div id="GTDataGrid1_Area" ></div>
    <div class="panel panel-primary" style="margin-top:8px;">

        <div class="panel-footer" style="display:none;">
             <div class="table-box" style="display:block;height:calc(100vh - 380px);overflow:auto;" >
                <table class="grid-table-type" id="jipyoTable">
	                    <tr>
	                    	<thead>
	                        <th style="width:36px;"><input id="item" type="checkbox" name="allCheck" onclick='checkAll()'/><label for="item"></label></th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_002','위험분류')}</th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_003','평가항목')}</th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_008','위험요소')}</th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_009','구간값')}</th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_007','사용여부')}</th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_010','지표')}</th>

	                        <th>${msgel.getMsg('RBA_50_03_02_01_011','개인')}</th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_012','법인')}</th>

	                        <th>${msgel.getMsg('RBA_50_03_02_01_013','위험점수')}</th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_014','I모델')}</th>
	                        <th>${msgel.getMsg('RBA_50_03_02_01_015','B모델')}</th>
                    		</thead>
	                    </tr>
                </table>
            </div>
        </div>
        <div align="right" style="margin-top:5px;font-family: SpoqR;font-size:14px;opacity: .6">
        	<span id="GRID_CNT"></span>
   		</div>
    </div>
	<iframe name="down_frame1" width="0" height="0" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"></iframe>
</form>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />