<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_90_01_03_01.jsp
- Author     : 권얼
- Comment    : FIU 지표등록관리
- Version    : 1.0
- history    : 1.0 20181121
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
	var classID  = "RBA_90_01_03_01";

	$(document).ready(function() {
		setupGrids();
		setting();
	 	doSearch();
    });

	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
		     "hoverStateEnabled"            : true,
		     "wordWrapEnabled"              : false,
		     "allowColumnResizing"          : true,
		     "columnAutoWidth"              : true,
		     "allowColumnReordering"        : true,
		     "cacheEnabled"                 : false,
		     "cellHintEnabled"              : true,
		     "showBorders"                  : true,
		     "showColumnLines"              : true,
		     "showRowLines"                 : true,
		     "export":
		     {
		         "allowExportSelectedData"  : true,
		         "enabled"                  : true,
		         "excelFilterEnabled"       : false,
		         "fileName"                 : "gridExport"
		     },
		     "sorting": {"mode"             : "multiple"},
		     "remoteOperations":                  {
		         "filtering"                : false,
		         "grouping"                 : false,
		         "paging"                   : false,
		         "sorting"                  : false,
		         "summary"                  : false
		     },
		     "editing":
		     {
		         "mode"                     : "batch",
		         "allowUpdating"            : false,
		         "allowAdding"              : false,
		         "allowDeleting"            : false
		     },
		     "filterRow"                    : {"visible": false},
		     "rowAlternationEnabled"        : true,
		     "columnFixing": {"enabled"     : true},
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
		     "searchPanel":
		     {
		         "visible"                  : false,
		         "width"                    : 250
		     },
		     onContentReady: function (e)
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
		     "selection":
		     {
		         "allowSelectAll"           : true,
		         "deferred"                 : false,
		         "mode"                     : "multiple",
		         "selectAllMode"            : "allPages",
		         "showCheckBoxesMode"       : "onClick"
		     },
		     "columns":
		     [
		         {
		             "dataField"            : "JIPYO_IDX",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_002","지표번호")}',
		             "cssClass"         	: "link",
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		         {
		             "dataField"            : "JIPYO_C_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_004","위험구분")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 80
		         },
		         {
		             "dataField"            : "RSK_CATG_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_005","카테고리")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 150
		         },
		         {
		             "dataField"            : "RSK_FAC_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_006","항목")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 150
		         },
		         {
		             "dataField"            : "JIPYO_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_003","지표명")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 200
		         },
		         {
		             "dataField"            : "CAL_FRML",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_023","산출식")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 200
		         },
		         {
		             "dataField"            : "INP_ITEM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_014","입력항목")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 100
		         },
		         {
		             "dataField"            : "VALT_G_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_007","평가구분")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 100
		         },
		         {
		             "dataField"            : "ALLT_PNT",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_016","배점")}',
		             "alignment"            : "right",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 50
		         },
		         {
		             "dataField"            : "CAL_METH",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_012","산출방법")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 200
		         },
		         {
		             "dataField"            : "CAL_METH_VIEW",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_012","산출방법")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 200
		         },
		         {
		             "dataField"            : "IN_METH_C_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_024","입력방식")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 100
		         },
		         {
		             "dataField"            : "MNG_BRNO_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_009","관리지점")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 100
		         },
		         {
		             "dataField"            : "JIPYO_USYN_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_008","사용여부")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 70
		         },
		         {
		             "dataField"            : "CHG_DT",
		             "caption"              : '${msgel.getMsg("RBA_90_01_02_01_100","변경일자")}',
		             "cellTemplate"      	: function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 100
		         },
		         {
		             "dataField"            : "CHG_OP_JKW_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_02_01_101","변경자")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "width"                : 100
		         },
		         {
		             "dataField"            : "RPT_GJDT",
		             "caption"              : 'null',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "ROW_ADD_YN",
		             "caption"              : 'null',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         },
		         {
		             "dataField"            : "NA_YN",
		             "caption"              : '해당없음여부',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "visible"              : false
		         }
		     ],
		     "onCellClick": function(e)
		     {
		        if(e.data )
		        {
		            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		        }
		     }
		}).dxDataGrid("instance");
	}

	function setting() {
		form1.JIPYO_NM.style.width="200px";
		var RPT_GJDT = form1.RPT_GJDT.value;
		var year 	= RPT_GJDT.substring(0,4) + '${msgel.getMsg("RBA_90_01_03_01_202","년")} ';
		var month 	= RPT_GJDT.substring(4,6) + '${msgel.getMsg("RBA_90_01_03_01_203","월")} ';
		var day 	= RPT_GJDT.substring(6,8) + '${msgel.getMsg("RBA_90_01_03_01_204","일")}';
		$("#RPT_GJDT_TEMP").text(year + month + day);

		if("99991231" == RPT_GJDT){
			$('#fixData').hide();
		}
	}

	/*
	 * KoFIU지표 코드관리 (위험구분 - 카테고리 - 항목)
	 */
	function jipyoSelectChange(v_gubun, nextGrp, GrpObj, v_afterFun) {
		nextSelectChangeReportIndex(v_gubun, form1.RPT_GJDT.value, nextGrp, GrpObj, v_afterFun , gubun);
	}

	function onAftreRptGjdtCdList() {
		nextSelectChangeReportIndex("RSK_CATG",form1.RPT_GJDT.value, "A002" ,"" ,"","INIT");
		nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
		nextSelectChangeReportIndex("VALT_G", form1.RPT_GJDT.value, "A007" ,"" ,"","");
		nextSelectChangeReportIndex("ITEM_S_C", form1.RPT_GJDT.value, "A010" ,"" ,"","");
		nextSelectChangeReportIndex("IN_METH_C", form1.RPT_GJDT.value, "A013" ,"" ,"","");

		form1.JIPYO_IDX.value = '';
		form1.JIPYO_NM.value = '';
		form1.RSK_CATG.value = '';
		form1.RSK_FAC.value = '';
		form1.VALT_G.value = '';
		form1.ITEM_S_C.value = '';
		form1.IN_METH_C.value = '';

	    doSearch();
	}

	function onAftreJipyoCCdList() {
		nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
	}

	function doSearch() {
		overlay.show(true, true);

		var methodID = "doSearch";
		var obj = new Object();
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "doSearch";
		obj.RPT_GJDT 	= form1.RPT_GJDT.value;
		obj.JIPYO_IDX 	= form1.JIPYO_IDX.value;
		obj.JIPYO_NM 	= form1.JIPYO_NM.value;
		obj.JIPYO_C 	= form1.JIPYO_C.value;
		obj.RSK_CATG 	= form1.RSK_CATG.value;
		obj.RSK_FAC 	= form1.RSK_FAC.value;
		obj.IN_METH_C 	= form1.IN_METH_C.value;
		obj.VALT_G 		= form1.VALT_G.value;
		obj.ITEM_S_C 	= form1.ITEM_S_C.value;
		obj.MNG_BRNO  	= $("#v_BRN_CD").val().trim() != "99999" ? $("#v_BRN_CD").val().trim(): "";			//관리점
		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
		
	}
	function doSearch_end(dataSource) {
		setData(dataSource);			//화면에 사용될 데이터 및 테이블을 셋팅
		checkFixJipyo();	//지표확정여부 및 결재상태코드 조회해서 값 셋팅
		setJQuery();
		overlay.hide();
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

    		cellData.JIPYO_IDX 		= cellData.JIPYO_IDX 	== "" ? "-" : cellData.JIPYO_IDX    ;
    		cellData.JIPYO_NM 		= cellData.JIPYO_NM 	== "" ? "-" : cellData.JIPYO_NM     ;
    		cellData.INP_ITEM 		= cellData.INP_ITEM 	== "" ? "-" : cellData.INP_ITEM     ;
    		cellData.VALT_G_NM 		= cellData.VALT_G_NM 	== "" ? "-" : cellData.VALT_G_NM    ;
    		cellData.INP_UNIT_C_NM 	= cellData.INP_UNIT_C_NM== "" ? "-" : cellData.INP_UNIT_C_NM;
    		cellData.ALLT_PNT 		= cellData.ALLT_PNT 	== "" ? "-" : cellData.ALLT_PNT     ;
    		cellData.NA_YN 			= cellData.NA_YN 		== "" ? "-" : cellData.NA_YN     	;
    		cellData.RPT_PNT 		= cellData.RPT_PNT 		== "" ? "-" : cellData.RPT_PNT      ;
    		cellData.ITEM_S_C_NM 	= cellData.ITEM_S_C_NM 	== "" ? "-" : cellData.ITEM_S_C_NM  ;
    		cellData.CAL_FRML 		= cellData.CAL_FRML 	== "" ? "-" : cellData.CAL_FRML     ;
    		cellData.CAL_METH_VIEW  = cellData.CAL_METH 	== "" ? "" : "...";
    		cellData.CAL_METH 		= cellData.CAL_METH 	== "" ? "-" : cellData.CAL_METH     ;
    		cellData.JIPYO_C_NM 	= cellData.JIPYO_C_NM 	== "" ? "-" : cellData.JIPYO_C_NM   ;
    		cellData.RSK_CATG_NM 	= cellData.RSK_CATG_NM 	== "" ? "-" : cellData.RSK_CATG_NM  ;
    		cellData.RSK_FAC_NM 	= cellData.RSK_FAC_NM 	== "" ? "-" : cellData.RSK_FAC_NM   ;
    		cellData.CHG_DT 		= cellData.CHG_DT 		== "" ? "-" : cellData.CHG_DT       ;
    		cellData.CHG_OP_JKW_NO 	= cellData.CHG_OP_JKW_NO== "" ? "-" : cellData.CHG_OP_JKW_NO;

    		if (cellData.IN_V_TP_C == 'N') {			//숫자 input - only number
	    		cellData.IN_V = cellData.IN_V == "" ? "0" : cellData.IN_V;
    			str = "<input type='text' onblur='checkChangeBox("+i+")' onkeydown='return checkNum(event)' id='IN_V_TP_C_"+i+"' style='text-align:center;width:100%' value ='"+addComma(cellData.IN_V)+"'/></td>";

    		} else if (cellData.IN_V_TP_C == 'C') {		//코드 select box
    			var tmp; tmp = cellData.CD_LST.split('@@');
   				var cdList = tmp[0].split('##');
   				var valList; valList = tmp[1].split('##');

   				var selBox = '';
   				if (cellData.IN_V == '') {
	   				selBox = "<option value='all'>::선택::</option>";
	   				for( j=0; j<cdList.length ; j++ ) {
	   					selBox += "<option value="+cdList[j]+">"+valList[j]+"</option>";
	   				}
   				} else {
   					var jj;
   					for( j=0; j<cdList.length ; j++ ) {
   						if (cellData.IN_V == cdList[j]) {
		   					selBox = "<option value="+cellData.IN_V+">"+valList[j]+"</option>";
		   					jj = j;
   						}
   					}
   					for( j=0; j<cdList.length ; j++ ) {
   						if (j != jj) {
   							selBox += "<option value="+cdList[j]+">"+valList[j]+"</option>";
   						}
   					}
   				}
   				str = "<select id='IN_V_TP_C_"+i+"' onblur='checkChangeBox("+i+")' class='cond-select' style='width:100%'>'"+selBox+"'</select></td>";

    		} else {	//'T'텍스트 포함 숫자, 코드가 아닌 모든 경우
    			cellData.IN_V = cellData.IN_V == "" ? "-" : cellData.IN_V;
    			str = "<input type='text' id='IN_V_TP_C_"+i+"' onblur='checkChangeBox("+i+")' style='text-align:center; width: 100%' value ='"+cellData.IN_V+"'/></td>";
    		}
    		if(cellData.NA_YN == "Y"){
	    		cellData.IN_V = "0";
	    		str = "<input type='text' id='IN_V_TP_C_"+i+"' onblur='checkChangeBox("+i+")' style='text-align:center; width: 100%' value ='해당없음'/ disabled></td>";
			}
			var suitColor = '';
			if (cellData.ITEM_S_C == '2') {		// 'A010', 0:미확정, 1:저장, 2:확정
				confirmCnt++;
				suitColor = "<font color=blue>"+cellData.ITEM_S_C_NM+"</font>";
    		} else {
				suitColor = cellData.ITEM_S_C_NM;
    		}

    		// 조회된 데이터를 html로 만드는 부분
    		$('#jipyoTable > tbody:last').append('<tr><td style="text-align:center;border-right: 1px solid #CCCCCC;width:1.35%;"><input type="checkbox" id="SELECTED'+i+'" name="SELECTED" value="'+i+'" /><label for="SELECTED'+i+'"></label></td>'
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:3%;">'			//지표번호
				+	'<a id="JIPYO_IDX_'+i+'" onclick="popDetail('+i+')" style="color:blue;text-decoration:underline;cursor:pointer" onmouseover="this.style.color=\'red\';" onmouseout="this.style.color=\'blue\';">'+cellData.JIPYO_IDX+'</a></td>'
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:6%;" id="JIPYO_NM_'+i+'">'+cellData.JIPYO_NM+'</td>'			//위험지표명
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:3%;" id="INP_ITEM_'+i+'">'+cellData.INP_ITEM+'</td>'			//입력항목
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:4%;" id="VALT_G_NM_'+i+'">'+cellData.VALT_G_NM+'</td>'			//평가구분
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" id="INP_UNIT_C_NM_'+i+'">'+cellData.INP_UNIT_C_NM+'</td>'	//입력단위
				+'<td style="text-align:right; padding-right: 5px; border-right: 1px solid #CCCCCC;width:2%;" id="ALLT_PNT_'+i+'">'+cellData.ALLT_PNT+'</td>'			//배점
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:3%;" id="NA_YN'+i+'">'+cellData.NA_YN+'</td>'					//해당없음여부
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:3%;" id="LAST_IN_V_'+i+'">'+addComma(cellData.LAST_IN_V)+'</td>'			//직전입력값
                   +'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:5%;">'														//입력값
                   + str
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" id="CAL_METH_'+i+'"data-full="'+cellData.CAL_METH+'"onmouseover="showTooltip(this)"><span class="ellipsis">'+cellData.CAL_METH_VIEW+'</span></td>'				//지표점수
// 				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" >'			//메모
// 				+	'<a id="BIGO_CTNT_'+i+'" onclick="doRegisterNote('+i+')" style="color:blue;text-decoration:underline;cursor:pointer" onmouseover="this.style.color=\'red\';" onmouseout="this.style.color=\'blue\';">'+cellData.BIGO_CTNT_F+'</a></td>'
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" >'			//증빙파일
				+	'<a id="ATTCH_FILE_YN_'+i+'" onclick="downloadFile('+i+')" style="color:blue;text-decoration:underline;cursor:pointer" onmouseover="this.style.color=\'red\';" onmouseout="this.style.color=\'blue\';">'+cellData.ATTCH_FILE_YN+'</a></td>'
				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:2%;" id="ITEM_S_C_NM_'+i+'">'+suitColor+'</td>'			//항목상태
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="CAL_FRML_'+i+'">'+cellData.CAL_FRML+'</td>'				//산출식
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="CAL_METH_'+i+'">'+cellData.CAL_METH+'</td>'				//산출방법
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="JIPYO_C_NM_'+i+'">'+cellData.JIPYO_C_NM+'</td>'			//위험구분
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="RSK_CATG_NM_'+i+'">'+cellData.RSK_CATG_NM+'</td>'		//카테고리
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="RSK_FAC_NM_'+i+'">'+cellData.RSK_FAC_NM+'</td>'			//항목
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="CHG_DT_'+i+'">'+cellData.CHG_DT+'</td>'					//변경일
				//+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" id="CHG_OP_JKW_NO_'+i+'">'+cellData.CHG_OP_JKW_NO+'</td>'		//변경자
				+'</tr>');
    	}

    	$("#ITEM_S_C_CNT").text(confirmCnt);
    }
    function checkFixJipyo() {
    	var methodID = "checkFixJipyo";
		var obj = new Object();
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "checkFixJipyo";
		obj.RPT_GJDT 	= form1.RPT_GJDT.value;

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
					} 
					else {
// 				    	showAlert("${msgel.getMsg('RBA_90_01_03_01_004','입력값')}( "+IN_V+" )${msgel.getMsg('AML_20_01_10_32_027','은 저장할 수 없습니다.')} \n${msgel.getMsg('AML_20_01_10_32_030','입력값은 10,000,000,000(10억)미만의 숫자로 입력가능합니다.')}", 'WARN');
				    	IN_V_length = 20;
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
		var JIPYO_IDX = cellData.JIPYO_IDX;
		var IN_V_TP_C = form1['IN_V_TP_C_' + id].value;

		var CNCT_JIPYO_C_I = cellData.CNCT_JIPYO_C_I;

		form2.pageID.value  = 'RBA_90_01_03_05';
		var	win; win = window_popup_open(form2.pageID.value, 1060, 825, '');

		form2.RPT_GJDT.value 		= form1.RPT_GJDT.value;
		form2.JIPYO_IDX.value 	  	= JIPYO_IDX;
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

		var JIPYO_IDX_arr = '';		//보고지표인덱스
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
			JIPYO_IDX_arr += cellData.JIPYO_IDX+',';
			IN_V_TP_C_arr += IN_V_TP_C+',';
			IN_V_TP_C_TYPE_arr += cellData.IN_V_TP_C+',';
			MAX_IN_V_arr += cellData.MAX_IN_V+',';
		}

		JIPYO_IDX_arr = JIPYO_IDX_arr.substring(0, JIPYO_IDX_arr.length-1);
		IN_V_TP_C_arr = IN_V_TP_C_arr.substring(0, IN_V_TP_C_arr.length-1);
		MAX_IN_V_arr = MAX_IN_V_arr.substring(0, MAX_IN_V_arr.length-1);
		IN_V_TP_C_TYPE_arr = IN_V_TP_C_TYPE_arr.substring(0, IN_V_TP_C_TYPE_arr.length-1);
		showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>', '저장', function(){
			var obj = new Object();
			obj.pageID 		  = pageID;
			obj.classID 	  = classID;
			obj.methodID 	  = "doSave";
			obj.RPT_GJDT 	  = form1.RPT_GJDT.value;
			obj.JIPYO_IDX_arr = JIPYO_IDX_arr;
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
		form4.RPT_GJDT.value=form1.RPT_GJDT.value;
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
		    obj.RPT_GJDT 	  = form1.RPT_GJDT.value;
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

		var JIPYO_IDX_arr = '';

	    for ( i=0; i < indexArr.length; i++ ) {
	 	   index = parseInt(indexArr[i]);
	 	   cellData =  GridObj1.getKeyByRowIndex(index);

	 	   if (cellData.ITEM_S_C == '2') {	//확정
	 		  showAlert('${msgel.getMsg("RBA_90_01_03_01_213","확정된 지표데이터의 입력값을 변경할 수 없습니다.")}\n${msgel.getMsg("RBA_90_01_03_01_214","[확정/취소]버튼으로 저장상태에서는 변경가능합니다.")}', 'WARN');
	 	   	  return;
	 	   }

	 	   JIPYO_IDX_arr += cellData.JIPYO_IDX+',';
	    }
	    JIPYO_IDX_arr = JIPYO_IDX_arr.substring(0, JIPYO_IDX_arr.length-1);

	    var methodID 	= "getLastData";
		var obj = new Object();
		
		overlay.show(true, true);
		
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "getLastData";
		obj.RPT_GJDT 	= form1.RPT_GJDT.value;
		obj.JIPYO_IDX 	= JIPYO_IDX_arr;


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
		var JIPYO_IDX = cellData.JIPYO_IDX;
		var JIPYO_NM = cellData.JIPYO_NM;
		var ATTCH_FILE_NO = cellData.ATTCH_FILE_NO;

      	form5.pageID.value  = "RBA_90_01_03_03";
      	var win; win = window_popup_open(form5.pageID.value, 605, 435, '');

      	form5.RPT_GJDT.value = form1.RPT_GJDT.value;
      	form5.JIPYO_IDX.value = JIPYO_IDX;
      	form5.JIPYO_NM.value = JIPYO_NM;
      	form5.ATTCH_FILE_NO.value = ATTCH_FILE_NO;
      	form5.gubun.value = 'upload'
      	form5.target = form5.pageID.value;
      	form5.action = '<c:url value="/"/>0001.do';
      	form5.submit();
	}


	function doConfirm() {
		if ( !checkCnt() ) {
	 	   showAlert('${msgel.getMsg("RBA_90_01_03_01_217","데이터를 선택하십시오.")}', 'WARN');
	       return;
	    }
		if ( !checkVal() ) return;

		var index;
	    var cellData;
		var indexArr = form1.selRowIndex.value.split(",");

		var JIPYO_IDX_arr = '';
	    var ITEM_S_C_arr = '';

	    for ( i=0; i < indexArr.length; i++ ) {
	 	   index = parseInt(indexArr[i]);
	 	   cellData =  GridObj1.getKeyByRowIndex(index);

	 	   if (cellData.ITEM_S_C == '0') {	//미확정
	 		   showAlert('['+cellData.ITEM_S_C_NM+'] ${msgel.getMsg("RBA_90_01_03_01_219","상태의 데이터를 확정처리할 수 없습니다.")}', 'WARN');
	 		   return;
	       } else if (cellData.ITEM_S_C == '1') {	//저장
	    	   ITEM_S_C_arr += '2,';
	 	   } else if (cellData.ITEM_S_C == '2') {	//확정
	 		   ITEM_S_C_arr += '1,';
	 	   }

	 	   JIPYO_IDX_arr += cellData.JIPYO_IDX + ',';
	    }
	    ITEM_S_C_arr = ITEM_S_C_arr.substring(0, ITEM_S_C_arr.length-1);
	    JIPYO_IDX_arr = JIPYO_IDX_arr.substring(0, JIPYO_IDX_arr.length-1);

	    overlay.show(true, true);
	    var methodID = "doConfirm";
	    var obj = new Object();
	    obj.pageID 		  = pageID;
	    obj.classID 	  = classID;
	    obj.methodID 	  = "doConfirm";
	    obj.RPT_GJDT 	  = form1.RPT_GJDT.value;
	    obj.JIPYO_IDX_arr = JIPYO_IDX_arr;
	    obj.ITEM_S_C_arr  = ITEM_S_C_arr;

	    sendService(classID, methodID, obj, doSearch, doSearch);
	}

	function downloadFile(id) {
		var cellData = GridObj1.getKeyByRowIndex(id);
		var ATTCH_FILE_YN = cellData.ATTCH_FILE_YN;

		if (ATTCH_FILE_YN == 'Y') {
			form5.pageID.value  = "RBA_90_01_03_03";
	      	var win; win = window_popup_open(form5.pageID.value, 605, 435, '');

	      	form5.RPT_GJDT.value = form1.RPT_GJDT.value;
	      	form5.JIPYO_IDX.value = cellData.JIPYO_IDX;
	      	form5.JIPYO_NM.value = cellData.JIPYO_NM;
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

      	form6.RPT_GJDT.value = form1.RPT_GJDT.value;
      	form6.JIPYO_IDX.value = cellData.JIPYO_IDX;
      	form6.JIPYO_NM.value = cellData.JIPYO_NM;
      	form6.CAL_FRML.value = cellData.CAL_FRML;
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
			form7.RPT_GJDT.value     = form1.RPT_GJDT.value;
			form7.JIPYO_IDX.value    = form1.JIPYO_IDX.value;
			form7.JIPYO_NM.value     = form1.JIPYO_NM.value;
			form7.JIPYO_C.value      = form1.JIPYO_C.value;
			form7.JIPYO_C_NM.value   = $("#JIPYO_C")[0].options[$("#JIPYO_C")[0].selectedIndex].text;
			form7.RSK_CATG.value     = form1.RSK_CATG.value;
			form7.RSK_CATG_NM.value  = $("#RSK_CATG")[0].options[$("#RSK_CATG")[0].selectedIndex].text;
			form7.RSK_FAC.value      = form1.RSK_FAC.value;
			form7.RSK_FAC_NM.value   = $("#RSK_FAC")[0].options[$("#RSK_FAC")[0].selectedIndex].text;
			form7.IN_METH_C.value    = form1.IN_METH_C.value;
			form7.IN_METH_C_NM.value = $("#IN_METH_C")[0].options[$("#IN_METH_C")[0].selectedIndex].text;
			form7.VALT_G.value       = form1.VALT_G.value;
			form7.VALT_G_NM.value    = $("#VALT_G")[0].options[$("#VALT_G")[0].selectedIndex].text;
			form7.ITEM_S_C.value     = form1.ITEM_S_C.value;
			form7.ITEM_S_C_NM.value  = $("#ITEM_S_C")[0].options[$("#ITEM_S_C")[0].selectedIndex].text;
			form7.MNG_BRNO.value     = form1.v_BRN_CD.value;
			form7.MNG_BRNO_NM.value  = form1.v_BRN_CD_NM.value;

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
	<input type="hidden" name="RPT_GJDT">
	<input type="hidden" name="JIPYO_IDX">
	<input type="hidden" name="JIPYO_NM">
	<input type="hidden" name="JIPYO_C">
	<input type="hidden" name="JIPYO_C_NM">
	<input type="hidden" name="RSK_CATG">
	<input type="hidden" name="RSK_CATG_NM">
	<input type="hidden" name="RSK_FAC">
	<input type="hidden" name="RSK_FAC_NM">
	<input type="hidden" name="IN_METH_C">
	<input type="hidden" name="IN_METH_C_NM">
	<input type="hidden" name="VALT_G">
	<input type="hidden" name="VALT_G_NM">
	<input type="hidden" name="ITEM_S_C">
	<input type="hidden" name="ITEM_S_C_NM">
	<input type="hidden" name="MNG_BRNO">
	<input type="hidden" name="MNG_BRNO_NM">
</form>

<form name="form6" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="RPT_GJDT">
	<input type="hidden" name="JIPYO_IDX">
	<input type="hidden" name="JIPYO_NM">
	<input type="hidden" name="CAL_FRML">
	<input type="hidden" name="BIGO_CTNT">
</form>
<form name="form5" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="RPT_GJDT">
	<input type="hidden" name="JIPYO_IDX">
	<input type="hidden" name="JIPYO_NM">
	<input type="hidden" name="ATTCH_FILE_NO">
	<input type="hidden" name="gubun">
</form>
<form name="form4" method="post">
	<input type="hidden"  name="pageID"/>
   	<input type="hidden"  name="classID"/>
   	<input type="hidden"  name="methodID"/>
   	<input type="hidden"  name="mode"/>
   	<input type="hidden"  name="RPT_GJDT"/>
	<input type="hidden"  name="JIPYO_IDX">
	<input type="hidden"  name="JIPYO_FIX_YN">
   	<input type="hidden"  name="SNO" />
   	<input type="hidden"  name="FILE_SER" />
	<input type="hidden"  name="IN_V_TP_C" >
	<input type="hidden"  name="CNCT_JIPYO_C_I" >
   	<input type="hidden"  name="JIPYO_VIEW"/>
   	<input type="hidden"  name="ROLE_ID" value="${ROLE_ID}">
</form>
<form name="form2" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
	<input type="hidden" name="RPT_GJDT" >
	<input type="hidden" name="JIPYO_IDX" >
	<input type="hidden" name="IN_V_TP_C" >
	<input type="hidden" name="CNCT_JIPYO_C_I" >
	<input type="hidden" name="JIPYO_VIEW" >
	<input type="hidden" name="ATTCH_FILE_NO">
	<input type="hidden" name="FILE_SER" >
</form>

<form name="form1" method="post" >
	<input type="hidden" id="pageID" name="pageID">
	<input type="hidden" id="selRowIndex" name="selRowIndex">
	<input type="hidden" id="JIPYO_FIX_YN" name="JIPYO_FIX_YN">
	<input type="hidden" id="GYLJ_S_C" name="GYLJ_S_C">

	<div class="inquiry-table type4">
    	<div class="table-row" style="width:25%;">
      		<div class="table-cell">
      	 		${condel.getLabel('RBA_90_01_01_02_001','보고기준일')}
				${JRBACondEL.getJRBASelect('','RPT_GJDT' ,'' ,'140px' ,'JRBA_common_getRPT_GJDT' ,'' ,'','jipyoSelectChange("JIPYO_C", "A001", this, "onAftreRptGjdtCdList()")')}
	 		</div>
	      	<div class="table-cell">
		       	${condel.getLabel('RBA_90_01_01_02_004','위험구분')}
		   		${JRBACondEL.getJRBASelect('MAX','JIPYO_C' ,'A001' ,'140px' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_CATG", "A002", this, "onAftreJipyoCCdList()")')}
		 	</div>
	      	<div class="table-cell">
	       		${condel.getLabel('RBA_90_01_01_02_007','평가구분')}
				${JRBACondEL.getJRBASelect('MAX','VALT_G' ,'A007' ,'140px' ,'' ,'' ,'ALL','')}
		 	</div>
		</div>
    	<div class="table-row" style="width:21%;">
      		<div class="table-cell">
      	 		${condel.getLabel('RBA_90_01_01_02_002','지표번호')}
	            ${condel.getInputCustomerNo('JIPYO_IDX')}
	 		</div>
	      	<div class="table-cell">
		 		${condel.getLabel('RBA_90_01_01_02_005','카테고리')}
				${JRBACondEL.getJRBASelect('','RSK_CATG' ,'A002' ,'160px' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_FAC", "A003", this)')}
			</div>
	      	<div class="table-cell">
	      		${condel.getLabel('RBA_90_01_03_01_001','항목상태')}
				${JRBACondEL.getJRBASelect('MAX','ITEM_S_C' ,'A010' ,'160px' ,'' ,'' ,'ALL','')}
		 	</div>
		</div>
    	<div class="table-row" style="width:32%;">
      		<div class="table-cell">
      			${condel.getLabel('RBA_90_01_01_02_003','지표명')}
	         	${condel.getInputCustomerNo('JIPYO_NM')}
	 		</div>
	      	<div class="table-cell">
	      		${condel.getLabel('RBA_90_01_01_02_006','항목')}
				${JRBACondEL.getJRBASelect('','RSK_FAC' ,'A003' ,'' ,'' ,'' ,'ALL','')}
		 	</div>
	      	<div class="table-cell">
	      		${condel.getLabel('RBA_90_01_01_02_009','관리지점')}
				<%if ("7".equals(ROLE_IDS) || "5".equals(ROLE_IDS) || "4".equals(ROLE_IDS)) {%>
					${condel.getBranchSearch('v_BRN_CD','ALL')}
				<%}else{%>
					${condel.getBranchSearch('v_BRN_CD',BDPT_CD,BDPT_CD,'','')}
				<%} %>
		 	</div>
		</div>
    	<div class="table-row" style="width:22%;">
	      	<div class="table-cell">
	       		${condel.getLabel('RBA_90_01_01_02_024','입력방식')}
				${JRBACondEL.getJRBASelect('MAX','IN_METH_C' ,'A013' ,'' ,'' ,'' ,'ALL','')}
		 	</div>
		 	<div class="table-cell">
        	</div>
		 	<div class="table-cell">
        	</div>
		 </div>
	</div>
	<div class="button-area">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"AML_40_03_01_01_btn_06", defaultValue:"파일업로드", mode:"R", function:"doReportFileUpload", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"autoImport", defaultValue:"자동 가져오기", mode:"R", function:"doAutoImport", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"beforeDate", defaultValue:"직전보고가져오기", mode:"C", function:"getLastData", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"fileSave", defaultValue:"증빙자료첨부", mode:"C", function:"doAttachFile", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"rbaConfirmBtn", defaultValue:"확정/취소", mode:"C", function:"doConfirm", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"excelDownBtn2", defaultValue:"Excel 다운로드", mode:"R", function:"doExcelDown", cssClass:"btn-36"}')}
	</div>

	<div id="GTDataGrid1_Area" style="display:none;"></div>
    <div class="panel panel-primary" style="margin-top:8px;">
    	<div id ="fixData" style="margin-top: 5px;font-family: SpoqB;font-size:0.8rem;">
    		<span id="BT_BAS_DT" style="color:blue"></span> ${msgel.getMsg('RBA_90_01_03_01_201','까지의 위험평가 자료를')}
    		<span id="RPT_GJDT_TEMP" style="color:red"></span> ${msgel.getMsg('RBA_90_01_03_01_205','보고입니다.')}
    		( ${msgel.getMsg('RBA_90_01_03_01_206','확정건')}/${msgel.getMsg('RBA_90_01_03_01_207','전체건')} : <span id="ITEM_S_C_CNT" style="color:blue"></span> / <span id="GRID_CNT2"></span> )
   		</div>
        <div class="panel-footer" >
             <div class="table-box" style="display:block;height:calc(100vh - 380px);overflow:auto;">
                <table class="grid-table-type" id="jipyoTable">
	                    <tr>
	                    	<thead>
	                        <th style="width:36px;"><input id="item" type="checkbox" name="allCheck" onclick='checkAll()'/><label for="item"></label></th>
	                        <th>${msgel.getMsg('RBA_90_01_01_02_002','지표번호')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_03_01_002','위험지표명')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_01_02_014','입력항목')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_01_02_007','평가구분')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_01_02_020','입력단위')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_01_02_016','배점')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_03_01_010','해당없음여부')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_03_01_003','직전입력값')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_03_01_004','입력값')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_03_01_005','산출방법')}</th>
<%-- 	                        <th>${msgel.getMsg('RBA_90_01_03_01_007','메모')}</th> --%>
	                        <th>${msgel.getMsg('RBA_90_01_03_01_006','증빙파일')}</th>
	                        <th>${msgel.getMsg('RBA_90_01_03_01_001','항목상태')}</th>
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