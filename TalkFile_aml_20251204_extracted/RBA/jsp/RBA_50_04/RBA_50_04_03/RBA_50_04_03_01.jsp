<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_04_03_01.jsp
* Description     : 통제평가수행
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-02
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
    String LOGIN_IDS = sessionAML.getsAML_LOGIN_ID();
    
	request.setAttribute("ROLE_IDS",ROLE_IDS);
	request.setAttribute("LOGIN_IDS",LOGIN_IDS);
%>
<!-- Java Script -->
<script language="JavaScript">

	var overlay = new Overlay();
	var GridObj1 = null;
	var GridObj2 = null;
	var classID  = "RBA_50_04_03_01";
	var pageID   = "RBA_50_04_03_01";
	var LOGIN_IDS = "${LOGIN_IDS}" ;

	$(document).ready(function() {
		
		//$("#btn_03").attr("disabled",true);
        //$("#btn_04").attr("disabled",true);
        
        if( "105"  == "${ROLE_IDS}" ) {
        	$("#btn_04").attr("disabled",true);
	    } 
        
        
        
		setupGrids();
		setting();
	 	doSearch();
	 	
	 	//alert( "LOGIN_IDS : " + "${LOGIN_IDS}" );
        //if(form1.BAS_YYMM.value != ''){
        //     doSearch();
        //}

    });

	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			elementAttr: { class: "grid-table-type" },
    		height 				  : "calc(80vh - 150px)",
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
		             dataField            : "HGRK_BRNO_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_006","부점구분")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 150
		         },
		         {
		             dataField            : "BRNO_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_007","평가대상부점")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 180
		         },
		         {
		             dataField            : "BRNO",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_001","통제분류Lv1")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 100
		         },
		         {
		             dataField            : "CNTL_CATG1_C",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_001","통제분류Lv1")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 100
		         },
		         {
		             dataField            : "CNTL_CATG1_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_001","통제분류Lv1")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 100
		         },
		         {
		             dataField            : "CNTL_CATG2_C",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_002","통제분류Lv2")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 120
		         },
		         {
		             dataField            : "CNTL_CATG2_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_002","통제분류Lv2")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 120
		         },
		         {
		             dataField            : "CNTL_ELMN_C",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_003","통제요소")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 130
		         },
		         {
		             dataField            : "CNTL_ELMN_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_003","통제요소")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             cssClass             : "link",
		             width                : 280
		         },
		         {
		             dataField            : "CNT_PNT",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_012","통제효과성")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             width                : 100
		         },
		         
		         
		         
		         {
		             dataField            : "EVAL_TYPE_CD",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_008","평가유형")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             lookup : { dataSource  : [{"KEY":"1","VALUE":"단일 Y/N"},{"KEY":"2","VALUE":"복수 Y/N"},{"KEY":"3","VALUE":"실적입력"}] /* {"KEY":"","VALUE":"=선택="}, */
                     ,displayExpr : "VALUE",valueExpr   : "KEY"},
		             width                : 130
		         },
		         {
		             dataField            : "EVAL_TYPE_CD_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_008","평가유형")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 130
		         },
		         {
		             dataField            : "WRITEN_YN",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_004","작성여부")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 80
		         },
		         {
		             dataField            : "FILE_YN",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_009","증빙유무")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 80
		         },
		         {
		             dataField            : "ROLEID",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_015","담당자")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             width                : 120
		         },
		         {
		             dataField            : "GYLJ_S_C_NM",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_005","결재상태")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : true,
		             cssClass             : "link",
		             width                : 120
		         },
		         {
		             dataField            : "CNTL_ELMN_CTNT",
		             caption              : '${msgel.getMsg("RBA_50_04_01_02_005","통제요소설명")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 130
		         },
		         {
		             dataField            : "CNTL_RSK_CTNT",
		             caption              : '${msgel.getMsg("RBA_50_04_01_02_006","통제위험")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 130
		         },
		         {
		             dataField            : "EVAL_MTHD_CTNT",
		             caption              : '${msgel.getMsg("RBA_50_04_01_02_009","평가방법")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 130
		         },
		         {
		             dataField            : "CNTNT",
		             caption              : '${msgel.getMsg("RBA_50_04_03_01_013","종합의견")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 130
		         },
		         {
		             dataField            : "PROOF_DOC_LIST",
		             caption              : '${msgel.getMsg("RBA_50_04_01_02_010","관련증빙")}',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 130
		         }
		         ,{
		             dataField            : "GYLJ_ID",
		             caption              : '결재ID',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 0
		         }
		         ,{
		             dataField            : "TABLE_NM",
		             caption              : 'TABLE_NM',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 0
		         }
		         ,{
		             dataField            : "GYLJ_S_C",
		             caption              : 'GYLJ_S_C',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 0
		         }
		         ,{
		             dataField            : "GYLJ_ROLE_ID",
		             caption              : 'GYLJ_ROLE_ID',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 0
		         }
		         ,{
		             dataField            : "NEXT_GYLJ_ROLE_ID",
		             caption              : 'NEXT_GYLJ_ROLE_ID',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 0
		         }
		         ,{
		             dataField            : "FIRST_GYLJ",
		             caption              : 'FIRST_GYLJ',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 0
		         }
		         ,{
		             dataField            : "END_GYLJ",
		             caption              : 'END_GYLJ',
		             alignment            : "center",
		             allowResizing        : true,
		             allowSearch          : true,
		             allowSorting         : true,
		             allowEditing         : false,
		             visible              : false,
		             width                : 0
		         }





		     ],
		     onCellPrepared : function(e){
		          if(e.rowType === 'data' &&
		        		  ( e.column.dataField === 'CNTL_ELMN_C_NM' || e.column.dataField === 'GYLJ_S_C' ) ){
		           e.cellElement.css("color", "blue");
		          }
		     },
		     onCellClick: function(e){
		    	 if(e.rowType === 'data' && ( e.column.dataField === 'CNTL_ELMN_C_NM' ) ){
		    		 if(e.data){
		    	            Grid1CellClick1('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
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

	
	// 그리드 클릭 - 결재이력 호출
	function Grid1CellClick2(id, obj, selectData, rowIdx, colIdx, colId){
		
		var form2  = document.form2;
		var params = new Object();
	    var methodID 	= "doApproval";
		var classID  = "RBA_50_03_02_01";

		form2.pageID.value  = "RBA_50_04_03_06";
        var win; win = window_popup_open(form2.pageID.value, 1200, 500, '', '');
        form2.TABLE_NM.value	= "SRBA_V_CNTL_ELMN_M";
        form2.ROLE_ID.value     = "${ROLE_IDS}";
        form2.BAS_YYMM.value     = obj.BAS_YYMM;
        form2.BRNO.value         = obj.BRNO;
        form2.LV3.value          = obj.CNTL_ELMN_C;
        
        form2.target		= form2.pageID.value;
        form2.action		= "<c:url value='/'/>0001.do";
        form2.submit();
	}

	// 그리드 클릭 - 통제요소 상세정보 팝업 호출
	function Grid1CellClick1(id, obj, selectData, rowIdx, colIdx, colId){

        var pageID  = "RBA_50_04_03_02";
        var classID = "RBA_50_04_03_02";
        var form2  = document.form2;



       // alert( "test popup : " + colId);
        if (colId == "CNTL_ELMN_C_NM") {
        	//alert( "1 : " + obj.EVAL_TYPE_CD_NM);
        	
        	if( obj.EVAL_TYPE_CD == "1" ) { //단순YN팝업
            	form2.pageID.value          =  "RBA_50_04_03_02";
            } else if(obj.EVAL_TYPE_CD == "2") {
            	form2.pageID.value          =  "RBA_50_04_03_03";
            } else {
            	form2.pageID.value          =  "RBA_50_04_03_04";
            }

            

            form2.classID.value   = classID;
            form2.BAS_YYMM.value        = form1.BAS_YYMM.value;
            form2.CNTL_CATG1_C.value    = obj.CNTL_CATG1_C;		// 통제분류Lv1
            form2.CNTL_CATG2_C.value    = obj.CNTL_CATG2_C;		// 통제분류Lv2
            form2.CNTL_ELMN_C.value     = obj.CNTL_ELMN_C;		// 통제요소
            form2.CNTL_CATG1_C_NM.value    = obj.CNTL_CATG1_C_NM;		// 통제분류Lv1
            form2.CNTL_CATG2_C_NM.value    = obj.CNTL_CATG2_C_NM;		// 통제분류Lv2
            form2.CNTL_ELMN_C_NM.value     = obj.CNTL_ELMN_C_NM;		// 통제요소
            //alert( "2 : " + obj.EVAL_TYPE_CD_NM);
            form2.EVAL_TYPE_CD1_NM.value    = obj.EVAL_TYPE_CD_NM;
            form2.EVAL_TYPE_CD.value    = obj.EVAL_TYPE_CD;
            //alert( "3 : " + obj.EVAL_TYPE_CD_NM);

            form2.BRNO_NM.value            = obj.BRNO_NM       ; //평가대상부점
            form2.BRNO.value               = obj.BRNO       ;

            form2.CNTL_ELMN_CTNT.value              = obj.CNTL_ELMN_CTNT       ;
            form2.CNTL_RSK_CTNT.value              = obj.CNTL_RSK_CTNT       ;
            form2.EVAL_MTHD_CTNT.value              = obj.EVAL_MTHD_CTNT       ;
            form2.PROOF_DOC_LIST.value              = obj.PROOF_DOC_LIST       ;

            form2.CNTNT.value              = obj.CNTNT       ;
            
            ////////////////////////////////////////////////////////////////////////
            form2.ROLE_ID.value             =   "${ROLE_IDS}" ;
            form2.GYLJ_ID.value 			=	obj.GYLJ_ID;			// 결재ID
            form2.TABLE_NM.value            =   "SRBA_V_CNTL_ELMN_M";   //
            form2.GYLJ_S_C.value			=	obj.GYLJ_S_C;		// 결재상태코드
            form2.GYLJ_ROLE_ID.value		=	obj.GYLJ_ROLE_ID;	
            form2.NEXT_GYLJ_ROLE_ID.value	=	obj.NEXT_GYLJ_ROLE_ID;	
            form2.FIRST_GYLJ.value			=	obj.FIRST_GYLJ;	
            form2.END_GYLJ.value			=	obj.END_GYLJ;
            //form2.FLAG.value		    	=	;
                
            ////////////////////////////////////////////////////////////////////////

            //alert( "test popup : " + form2.USE_YN1.value);


            form2.target          = form2.pageID.value;
            var win               = window_popup_open(form2.pageID.value, 990, 1050, '','yes');
            form2.action          = '<c:url value="/"/>0001.do';
            form2.submit();
        }
    }

	function setting() {

		if ("${ROLE_IDS}" == '7' || "${ROLE_IDS}" == "104" || "${ROLE_IDS}" == '4') {
			//alert( "ROLE_IDS1 : " + "${ROLE_IDS}" );
			GridObj1.columnOption("CNT_PNT", "visible", true);
			

		} else {

			//alert( "ROLE_IDS2 : " + "${ROLE_IDS}" );
			GridObj1.columnOption("CNT_PNT", "visible", false);

		}
		
		


	}



	function doSearch() {
		//overlay.show(true, true);

	    //alert( "call doSearch : " );

		var methodID = "doSearch";
		var obj = new Object();
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "doSearch";
		obj.BAS_YYMM        = form1.BAS_YYMM.value;
		obj.CNTL_CATG1_C 	= form1.CNTL_CATG1_C.value;
 		obj.CNTL_CATG2_C 	= form1.CNTL_CATG2_C.value;
		obj.CNTL_ELMN_C 	= form1.CNTL_ELMN_C.value;
		obj.WRITEN_YN     	= form1.WRITEN_YN.value;
		obj.BRNO          	= form1.SEARCH_DEP_ID.value;
		obj.GYLJ_S_C     	= form1.status_f.value;

		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
	}
	function doSearch_end(dataSource) {
		setData(dataSource);			//화면에 사용될 데이터 및 테이블을 셋팅

		/* overlay.hide(); */
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

    	$("#GRID_CNT").text('(' + cnt + ' 항목)');
    	$("#GRID_CNT2").text(cnt);

    	$(":checkbox").prop("checked", false);
    	for( i=0; i < cnt ; i++ ) {
    		var str = '';
    		var cellData =  dataSource[i];
    		
    		if( i==0 ) {
				//alert( "step : " + cellData.ING_STEP + " " + cellData.FIX_YN);
    			form1.ING_STEP.value = cellData.ING_STEP;
    		}

    		cellData.RSK_CATG1_C_NM 		= cellData.RSK_CATG1_C_NM 	== "" ? "-" : cellData.RSK_CATG1_C_NM    ;
    		cellData.RSK_CATG2_C_NM 	    = cellData.RSK_CATG2_C_NM 	== "" ? "-" : cellData.RSK_CATG2_C_NM   ;
    		cellData.RSK_VALT_ITEM_NM 	    = cellData.RSK_VALT_ITEM_NM == "" ? "-" : cellData.RSK_VALT_ITEM_NM   ;
    		cellData.RSK_ELMT_C_NM 	    	= cellData.RSK_ELMT_C_NM 	== "" ? "-" : cellData.RSK_ELMT_C_NM     ;
    		cellData.RSK_FAC_NM 		    = cellData.RSK_FAC_NM 	    == "" ? "-" : cellData.RSK_FAC_NM    ;

    		cellData.WRITEN_YN 		        = cellData.WRITEN_YN 	    == "" ? "-" : cellData.WRITEN_YN    ;





    		// 조회된 데이터를 html로 만드는 부분
    		$('#jipyoTable > tbody:last').append('<tr><td style="text-align:center;border-right: 1px solid #CCCCCC;width:1.35%;"><input type="checkbox" id="SELECTED'+i+'" name="SELECTED" value="'+i+'" /><label for="SELECTED'+i+'"></label></td>'
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:3%;">'			//위험분류
				+	'<a id="RSK_CATG1_C_NM_'+i+'" onclick="popDetail('+i+')" style="color:blue;text-decoration:underline;cursor:pointer" onmouseover="this.style.color=\'red\';" onmouseout="this.style.color=\'blue\';">'+cellData.RSK_CATG1_C_NM+'</a></td>'
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:6%;" id="RSK_VALT_ITEM_NM_'+i+'">'+cellData.RSK_VALT_ITEM_NM+'</td>'			//평가항목
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:3%;" id="RSK_ELMT_C_NM_'+i+'">'+cellData.RSK_ELMT_C_NM+'</td>'			        //위험요소
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:4%;" id="RSK_FAC_NM_'+i+'">'+cellData.RSK_FAC_NM+'</td>'			//구간값
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" id="WRITEN_YN_'+i+'">'+cellData.WRITEN_YN+'</td>'	//여부

                /* +'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" id="RSK_VALT_CAL_STD_'+i+'"data-full="'+cellData.RSK_VALT_CAL_STD+'"onmouseover="showTooltip(this)"><span class="ellipsis">'+cellData.INDV_YN+'</span></td>'				//지표점수
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" >'			//메모
				+	'<a id="BIGO_CTNT_'+i+'" onclick="doRegisterNote('+i+')" style="color:blue;text-decoration:underline;cursor:pointer" onmouseover="this.style.color=\'red\';" onmouseout="this.style.color=\'blue\';">'+cellData.BIGO_CTNT_F+'</a></td>'
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" >'			//증빙파일
				+	'<a id="ATTCH_FILE_YN_'+i+'" onclick="downloadFile('+i+')" style="color:blue;text-decoration:underline;cursor:pointer" onmouseover="this.style.color=\'red\';" onmouseout="this.style.color=\'blue\';">'+cellData.ATTCH_FILE_YN+'</a></td>'
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" id="ITEM_S_C_NM_'+i+'">'+suitColor+'</td>'			//항목상태 */
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="RSK_ELMT_DTL_CTNT_'+i+'">'+cellData.RSK_ELMT_DTL_CTNT+'</td>'				//산출식
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="RSK_VALT_CAL_STD_'+i+'">'+cellData.RSK_VALT_CAL_STD+'</td>'				//산출방법
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="RSK_VALT_ITEM_NM_'+i+'">'+cellData.RSK_VALT_ITEM_NM+'</td>'			//위험구분
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="RSK_CATG_NM_'+i+'">'+cellData.RSK_CATG_NM+'</td>'		//카테고리
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="RSK_CATG2_C_NM_'+i+'">'+cellData.RSK_CATG2_C_NM+'</td>'			//항목
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="B_MODEL_YN_'+i+'">'+cellData.B_MODEL_YN+'</td>'					//변경일
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="CHG_OP_JKW_NO_'+i+'">'+cellData.CHG_OP_JKW_NO+'</td>'		//변경자
				+'</tr>');
    	}

    	$("#ITEM_S_C_CNT").text(confirmCnt);
    }


	function popDetail(id) {
		/* var cellData = GridObj1.getKeyByRowIndex(id);
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
		form2.submit(); */
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



	function getLastData() {
		if ( !checkCnt() ) {
	 	   showAlert('${msgel.getMsg("RBA_90_01_03_01_217","데이터를 선택하십시오.")}', 'WARN');
	       return;
	    }
		if ( !checkVal() ) return;

		var index;
	    var cellData;
		var indexArr = form1.selRowIndex.value.split(",");

		var RSK_FAC_NM_arr = '';

	    for ( i=0; i < indexArr.length; i++ ) {
	 	   index = parseInt(indexArr[i]);
	 	   cellData =  GridObj1.getKeyByRowIndex(index);

	 	   if (cellData.ITEM_S_C == '2') {	//확정
	 		  showAlert('${msgel.getMsg("RBA_90_01_03_01_213","확정된 지표데이터의 입력값을 변경할 수 없습니다.")}\n${msgel.getMsg("RBA_90_01_03_01_214","[확정/취소]버튼으로 저장상태에서는 변경가능합니다.")}', 'WARN');
	 	   	  return;
	 	   }

	 	   RSK_FAC_NM_arr += cellData.RSK_FAC_NM+',';
	    }
	    RSK_FAC_NM_arr = RSK_FAC_NM_arr.substring(0, RSK_FAC_NM_arr.length-1);

	    var methodID 	= "getLastData";
		var obj = new Object();
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "getLastData";
		obj.RA_CHG_DT 	= form1.RA_CHG_DT.value;
		obj.RSK_FAC_NM 	= RSK_FAC_NM_arr;


		sendService(classID, methodID, obj, doSearch, getLastData_fail);
	}

	function getLastData_fail(){
		overlay.hide();
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

		//alert( "step 111111: [" + form1.ING_STEP.value + "]");

		if(form1.ING_STEP.value == "60" || form1.ING_STEP.value == "61"){

            showConfirm("${msgel.getMsg('RBA_50_01_01_006','확정을 하시겠습니까?')}", "확정",function(){
                     var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = $("#BAS_YYMM").val();
                     params.FIX_YN = "1";
                     params.ING_STEP = "70";  //confirmState
                     params.RBA_VALT_SMDV_C = "3.4";

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);

            });


        }else{
        	if(form1.ING_STEP.value == "70" || form1.ING_STEP.value == "71"){

	            showConfirm("${msgel.getMsg('RBA_50_01_01_007','확정을 취소하시겠습니까?')}", "취소",function(){
	            	// $("button[id='btn_07']").prop('disabled', true);

	                 var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = $("#BAS_YYMM").val();
                     params.FIX_YN = "0";
                     params.ING_STEP = "60";  //confirmState
                     params.RBA_VALT_SMDV_C = "3.4";

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);
	            });
        	}else {
        		// 일정정보관리 확정단계에서만 취소 할수 있습니다. ==> 라고 수정이 필요
        		showAlert('${msgel.getMsg("RBA_50_01_01_01_113","이후 확정된 STEP을 취소후 진행 할수 있습니다.")}','WARN');
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
	
	
	//배치수행
    function doStartBatch(){
               
       if(form1.ING_STEP.value < 70) {
          showAlert('${msgel.getMsg("RBA_50_01_01_250","통제평가 수행중에는 배치수행 불가 합니다.")}','WARN');
          return;
       } 

       
       showConfirm( $("#BAS_YYMM").val().substring(0,4) + "년 : "+ $("#BAS_YYMM").val().substring(5,6) + "회차의 통제평가 배치를 수행 하시겠습니까 ?","배치",function(){
    	   var params   = new Object();
    	   var methodID = "startBatch";
    	   var classID  = "RBA_50_03_03_01";
    	   
    	   overlay.show(true, true);
    	    		
    	   params.pageID 	= "RBA_50_04_03_01";
    	   params.BAS_YYMM  = $("#BAS_YYMM").val(); //기준연도3
    	   params.ING_STEP  = "3.4";
    	   
    	   
           
    	   
    	   sendService(classID, methodID, params, doStartBatch_end, doStartBatch_end); 
       });
       
       

     }
    
    function doStartBatch_end(){
    	overlay.hide();
    }
    
    
    // 결재팝업 요청
	function doApproval(FLAG) {
		var selData  = GridObj1.getSelectedRowsData();
		
        if(selData == null || selData == ""){
        	showAlert('${msgel.getMsg("RBA_99_01_01_02_032","결재할 대상을 선택해주세요.")}','WARN');
        }else{	

        	//결재상태 확인
			for(var i=0; i<selData.length; i++){
				if(!CheckValue(selData[i])){
					return;
				}
				
 				/* if( i > 0 ) {

					if( selData[0].BRNO != selData[i].BRNO ) {
						showAlert("평가부점 영업점과 본점을 구분하여 결재진행이 가능합니다." , "WARN");
						return;
			    	}

				} */
				
			}
        }
        
        if( "105"  == "${ROLE_IDS}" ) {
        	FLAG  = "0"; // 결재FLAG (0:승인요청,1:반려,2:승인)
		} 
        
        form1.FLAG.value = FLAG;
        
        var obj = selData[0];        
        form2.pageID.value             = "RBA_50_04_03_07";
        form2.FLAG.value               = FLAG;	
        form2.BRNO_NM.value            = obj.BRNO_NM       ; //평가대상부점
        form2.BRNO.value               = obj.BRNO       ;
        form2.ROLE_ID.value            =   "${ROLE_IDS}" ;
        form2.GYLJ_ID.value 		   =	obj.GYLJ_ID ;			// 결재ID
        form2.GYLJ_S_C.value		   =	obj.GYLJ_S_C;		// 결재상태코드
        form2.GYLJ_ROLE_ID.value	   =	obj.GYLJ_ROLE_ID;	
        form2.NEXT_GYLJ_ROLE_ID.value	=	obj.NEXT_GYLJ_ROLE_ID;	
        form2.FIRST_GYLJ.value			=	obj.FIRST_GYLJ;	
        form2.END_GYLJ.value			=	obj.END_GYLJ;
        form2.target          = form2.pageID.value;
        var win               = window_popup_open(form2.pageID.value, 900, 450, '', 'yes');
        form2.action          = '<c:url value="/"/>0001.do';
        form2.submit();
	}
 	
 	
	function doApproval2(MSG) {
		var selData  = GridObj1.getSelectedRowsData();
		var obj = selData[0];
		var params   = new Object();
		
		var methodID 	 = "doApproval_all";
       	var classID 	 = "RBA_50_03_02_01";
       	params.pageID 	     = "RBA_50_04_03_01";
       	
       	params.NOTE_CTNT    = MSG;
       	params.gridData     = selData;	
       	params.TABLE_NM     = "SRBA_V_CNTL_ELMN_M";
       	params.ROLE_IDS     = "${ROLE_IDS}";
       	
		if( obj.BRNO == "20500" ) {
			params.GYLJ_G_C   = "RBA01";  //결재구분코드
			
			if( "4"  == "${ROLE_IDS}" ) {
				params.GYLJ_FLAG  = "0"; // 결재FLAG (0:승인요청,1:반려,2:승인)
			} else {
				params.GYLJ_FLAG  = form1.FLAG.value; // 결재FLAG (0:승인요청,1:반려,2:승인)
			}
				
		} else {
			params.GYLJ_G_C   = "RBA02";  //결재구분코드
			
			if( "105"  == "${ROLE_IDS}" ) {
				params.GYLJ_FLAG  = "0"; // 결재FLAG (0:승인요청,1:반려,2:승인)
			} else {
				params.GYLJ_FLAG  = form1.FLAG.value; // 결재FLAG (0:승인요청,1:반려,2:승인)
			}
		}
		
		//alert( "form1.FLAG.value " + form1.FLAG.value );
   	    
        sendService(classID, methodID, params, doSearch_success2, doSearch_fail);
				
	}
 	
	function doSearch_success2(gridData, data) {
        GridObj1.refresh();
        
        doSearch();
	} 	
	
	function doSearch_fail () {

	}
	
	
	// 결재권한별 CHECK
    function CheckValue(selData){
    	
    	var tmpROLEID = "";
    	if( "${ROLE_IDS}" == "105" ) {
    		tmpROLEID = "RBA 담당자";
    	} else if( "${ROLE_IDS}" == "6" ) {
    		tmpROLEID = "RBA/AML 책임자";
    	} else if( "${ROLE_IDS}" == "4" ) {
    		tmpROLEID = "본점담당자";
    	} else if( "${ROLE_IDS}" == "104" ) {
    		tmpROLEID = "본점책임자";
    	}  
    	
    	
    	if(selData.GYLJ_S_C == "3" ){
			showAlert("결재완료 목록이 존재합니다", "WARN");
			return false;
		}
    	
    	if( "${ROLE_IDS}" != "7" ) {
    		if( selData.ROLEID != tmpROLEID ) {
    			showAlert("처리 담당자가 다른 목록을 선택했습니다 : " + selData.ROLEID , "WARN");
    			return false;
        	}
    	}
    	
    	
    	if( selData.GYLJ_S_C == "0" ) {
    		if( selData.WRITEN_YN == "미작성" ) {
    			showAlert("미작성 목록을 저장후 처리가능합니다" , "WARN");
				return false;
        	}
    	}

		return true;
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
   	<input type="hidden"  name="ROLE_ID"/>
</form>
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
    <input type="hidden" name="CNTL_CATG1_C" >
    <input type="hidden" name="CNTL_CATG2_C" >
    <input type="hidden" name="CNTL_ELMN_C" >
    <input type="hidden" name="CNTL_CATG1_C_NM" >
    <input type="hidden" name="CNTL_CATG2_C_NM" >
    <input type="hidden" name="CNTL_ELMN_C_NM" >
    <input type="hidden" name="USE_YN1" >
    <input type="hidden" name="CNTL_ELMN_CTNT" >
    <input type="hidden" name="CNTL_RSK_CTNT" >
    <input type="hidden" name="EVAL_MTHD_CTNT" >
    <input type="hidden" name="EVAL_TYPE_CD" >
    <input type="hidden" name="EVAL_TYPE_CD1_NM" >
    <input type="hidden" name="PROOF_DOC_LIST" >
    <input type="hidden" name="BRNO_NM" >
    <input type="hidden" name="BRNO" >
    <input type="hidden" name="LV3" >
    <input type="hidden" name="CNTNT" >
    <input type="hidden" name="ROLE_ID" >
    <input type="hidden" name="GYLJ_ID" >
    <input type="hidden" name="TABLE_NM" >
    <input type="hidden" name="GYLJ_S_C" >
    <input type="hidden" name="GYLJ_ROLE_ID" >
    <input type="hidden" name="NEXT_GYLJ_ROLE_ID" >
    <input type="hidden" name="FIRST_GYLJ" >
    <input type="hidden" name="END_GYLJ" >
    <input type="hidden" name="FLAG"/>
</form>
       
<form name="form1" method="post" >
	<input type="hidden" id="pageID" name="pageID">
	<input type="hidden" id="selRowIndex" name="selRowIndex">
	<input type="hidden" id="JIPYO_FIX_YN" name="JIPYO_FIX_YN">
	<input type="hidden" id="GYLJ_S_C" name="GYLJ_S_C">
	<input type="hidden" id="FLAG" name="FLAG"/>

	<div class="inquiry-table type4">
    	<div class="table-row" style="width:25%;">
      		<div class="table-cell">
      			${condel.getLabel("RBA_50_03_02_01_001","평가회차")}
            	<div class="content">
            		<RBATag:selectBoxRba groupCode="" name="BAS_YYMM" initValue="" sqlID="RBAS_common_getComboData_BasYear" cssClass="dropdown" firstComboWord="" filterComboVal="" eventFunction='doSearch()'/>
            	</div>
	 		</div>
	      	<div class="table-cell">
		       	${condel.getLabel('RBA_50_04_03_01_004','작성여부')}
		       	<div class="content">
				<select name="WRITEN_YN" id="WRITEN_YN" class="dropdown" onChange='doSearch()'><!--onChange='ccdChange(this)'  -->
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='0' >미작성</option>
		                <option value='1' >작성완료</option>
		        </select>
		        </div>
		 	</div>
		</div>
    	<div class="table-row" style="width:21%;">
      		<div class="table-cell">
      	 		${condel.getLabel('RBA_50_04_03_01_001','통제분류Lv1')}
      	 		${RBACondEL.getKRBASelect('CNTL_CATG1_C','' ,'' ,'P001' ,'' ,'ALL' ,'nextSelectChange2_2("CNTL_CATG2_C", "P002", this)','','','')}
	 		</div>
	      	<div class="table-cell">
		 		${condel.getLabel('RBA_50_04_03_01_005','결재상태')}
		 		<div class="content" >
					<select name="status_f" id="status_f" class="dropdown" onChange='doSearch()' style="width:160px" >
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='0' >미입력</option>
		                <option value='5' >미상신</option>
		                <option value='12' >결재요청</option>
		                <option value='13' >미결재</option>
		                <option value='22' >반려</option>
		                <option value='23' >본점미결재</option>
		                <option value='32' >책임자미결재</option>
		                <option value='3' >결재완료</option>
		            </select>
				</div>
			</div>
		</div>
    	<div class="table-row" style="width:25%;">
      		<div class="table-cell">
      			${condel.getLabel('RBA_50_04_03_01_002','통제분류Lv2')}
	         	${JRBACondEL.getSRBASelect('','CNTL_CATG2_C' ,'P002' ,'160px' ,'' ,'' ,'ALL','')}
	 		</div>
	      	<div class="table-cell">
		       	${condel.getLabel('RBA_50_04_03_01_009','증빙유무')}
		       	<div class="content" >
					<select name="FILE_YN" id="FILE_YN" class="dropdown" onChange='doSearch()' style="width:160px" >
		            	<option value='ALL' SELECTED >::전체::</option>
		                <option value='1' >Y</option>
		                <option value='0' >N</option>
		            </select>
				</div>
		 	</div>
		</div>
    	<div class="table-row" style="width:30%;">
	      	<div class="table-cell">
	       		${condel.getLabel('RBA_50_04_03_01_003','통제요소')}
	       		<div class="content"><input name="CNTL_ELMN_C" id="CNTL_ELMN_C" type="text" value="" class="cond-input-text" size="30" /></div>
		 	</div>
		 	<div class="table-cell">
            	${condel.getLabel('RBA_30_06_05_01_001','대상부점')}
				<%
					if ("7".equals(ROLE_IDS) || "104".equals(ROLE_IDS) || "4".equals(ROLE_IDS)  || "admin".equals(LOGIN_IDS) || "rbaadmin".equals(LOGIN_IDS) ) {
				%>
				${condel.getBranchSearch('SEARCH_DEP_ID','ALL')}
				<%
					} else {
				%>
				${condel.getBranchSearch('SEARCH_DEP_ID',BDPT_CD,BDPT_CD,'','')}
				<%
					}
				%>
            </div>
		 </div>
	</div>

	<div class="button-area">
		<input type="text" class="cond-input-text" name="ING_STEP" id="ING_STEP" value="${ING_STEP}" style="border: 0px;background-color:white;color:white" readonly="readonly"></input>
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}

		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"okBtn", defaultValue:"결재", mode:"U", function:"doApproval(2)", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"refuseBtn", defaultValue:"반려", mode:"U", function:"doApproval(1)", cssClass:"btn-36"}')}

		${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"rbaConfirmBtn", defaultValue:"확정/취소", mode:"C", function:"doConfirm", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"RBA022", defaultValue:"배치처리", mode:"C", function:"doStartBatch", cssClass:"btn-36"}')}

	</div>
<%-- 	<div id ="fixData" style="margin-top: 5px;font-family: SpoqB;font-size:0.8rem;">
	    ${msgel.getMsg("RBA_50_03_02_01_101","※ 수정가능항목 : 사용여부 , 지표 , 위험점수")}
    </div> --%>

	<div id="GTDataGrid1_Area" ></div>
    <div class="panel panel-primary" style="margin-top:8px;">
    	<%-- <div id ="fixData" style="margin-top: 5px;font-family: SpoqB;font-size:0.8rem;">
    		<span id="BT_BAS_DT" style="color:blue"></span> ${msgel.getMsg('RBA_90_01_03_01_201','까지의 위험평가 자료를')}
    		<span id="RA_CHG_DT_TEMP" style="color:red"></span> ${msgel.getMsg('RBA_90_01_03_01_205','보고입니다.')}
    		( ${msgel.getMsg('RBA_90_01_03_01_206','확정건')}/${msgel.getMsg('RBA_90_01_03_01_207','전체건')} : <span id="ITEM_S_C_CNT" style="color:blue"></span> / <span id="GRID_CNT2"></span> )
   		</div> --%>
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