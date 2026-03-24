<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_03_03_02.jsp
* Description     : RA가중치 불러오기 POPUP
* Group           : GTONE, R&D센터/개발2본부
* Author          : JYT
* Since           : 2025-07-17
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
request.setAttribute("ROLE_IDS",ROLE_IDS);

String BAS_YYMM        = request.getParameter("BAS_YYMM");
request.setAttribute("BAS_YYMM",BAS_YYMM);

%>
<style type="text/css">
    * { white-space: nowrap; }
	.inquiry-table .table-cell .title {
		min-width: 90px;
	}
</style>
<script>

    var GridObj1;
    var overlay = new Overlay();
    var pageID  =  "RBA_50_03_03_02";
    var classID  = "RBA_50_03_03_02";
	var ingStepNm = "";
	var ingStep = "0";
	var doConfirmYn = false;
    var ROLE_ID =  '${ROLE_IDS}';

    // Initialize
    $(document).ready(function(){
        //setupConditions();
        //setupGrids();
        //setupFilter("init");

        doSearch();
    });

    // Initial function
    function init() { initPage(); }

    // 그리드 초기화 함수 셋업
    function setupGrids() {
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
			             dataField    : "MODEL_NM",
			             caption      : '적용모델',
			             alignment    : "center",
			             allowResizing: true,
			             allowSearch  : true,
			             allowSorting : true,
			             width : 80
			         },{
			             dataField    : "RSK_CATG_NM",
			             caption      : '위험CATEGORY명',
			             alignment    : "center",
			             allowResizing: true,
			             allowSearch  : true,
			             allowSorting : true,
			             width : 80
			         },
			         {
			             dataField    : "RSK_FAC",
			             caption      : '위험FACTOR',
			             alignment    : "center",
			             allowResizing: true,
			             allowSearch  : true,
			             allowSorting : true,
			             width : 80
			         },  {
			             dataField    : "RSK_FAC_NM",
			             caption      : '위험FACTOR명',
			             alignment    : "center",
			             allowResizing: true,
			             allowSearch  : true,
			             allowSorting : true,
			             width : 180
			         },  {
			             dataField    : "RSK_INDCT",
			             caption      : '위험INDICATOR',
			             alignment    : "center",
			             allowResizing: true,
			             allowSearch  : true,
			             allowSorting : true,
			             width : 80
			         },  {
			             dataField    : "RSK_INDCT_NM",
			             caption      : '위험INDICATOR명',
			             alignment    : "center",
			             allowResizing: true,
			             allowSearch  : true,
			             allowSorting : true,
			             cssClass     : "link",
			             width : 200
			         }, {
			             dataField    : "JIPYO_ALLT",
			             caption      : '지표배점',
			             alignment    : "left",
			             allowResizing: true,
			             allowSearch  : true,
			             allowSorting : true
			         }
			     ],
		     summary: {
		         totalItems: [
		             {
		                 column     : "RSK_CATG",
		                 summaryType: "count"
		             }
		         ]
		     },
		     onCellClick: function(e){
		         if(e.data ){
		             Grid2CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		         }
		     }
    	}).dxDataGrid("instance");
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
    	gridObj.title = '${msgel.getMsg("RBA_50_03_03_01_101","위험평가 배점관리")}';
    	gridArrs[0] = gridObj;

    	setupGridFilter2(gridArrs, FLAG);
    }

    // 검색조건 셋업
    function setupConditions() {
    	try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(220, 90, 0);
            cbox1.setItemWidths(220, 90, 1);
            cbox1.setItemWidths(280, 90, 2);
        } catch (e) {
            alert(e.message);
        }
        $('#BAS_YYMM').css('width', 100);

    }

    //위험평가 배점 관리 조회
    function doSearch() {
    	//overlay.show(true, true);
        var methodID = "doSearchRA";
        var params = new Object();
        params.pageID		= pageID,					//RBA_50_03_03_02
        params.classID		= classID,					//RBA_50_03_03_02

        sendService(classID, methodID, params, doSearch_end, doSearch_fail);
    }
    //위험평가 배점 관리 조회 end
    function doSearch_end(gridData, data) {
        setData(gridData);
        overlay.hide();
    	//doSearchStepInfo();
    }
    function doSearch_fail(){
    	overlay.hide();
    	doClose();
    }


    //데이터 셋팅
    function setData(gridData) {
    	deleteRows();

    	var cnt = gridData.length;	//GridObj1.rowCount();
    	//console.log("cnt["+cnt+"]");
    	var JIPYO_ALLT = 0;

    	var SUM_RBA_WEIGHT = 0;
    	var SUM_RBA_FIN_WEIGHT = 0;

    	//alert( "cnt : " + cnt );

    	for( i=0; i < cnt ; i++ ) {
    		var cellData =  gridData[i];	//GridObj1.getRow(i);
    		//JIPYO_ALLT = Number(cellData.RBA_FIN_WEIGHT);
    		SUM_RBA_WEIGHT = SUM_RBA_WEIGHT + Number(cellData.RBA_WEIGHT);
    		//SUM_RBA_FIN_WEIGHT = SUM_RBA_FIN_WEIGHT + Number(cellData.RBA_FIN_WEIGHT);


    		$('#mergeTable > tbody:last').append('<tr><td style="text-align:center;border-right: 1px solid #CCCCCC;">'+cellData.MODEL_NM+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" >'+cellData.RA_RISK_CATG2+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" >'+cellData.RSK_VALT_ITEM+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;">'+cellData.RSK_VALT_ITEM_NM+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;">'+cellData.RA_FIN_WEIGHT_INDV+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;">'+cellData.RA_FIN_WEIGHT_CORP+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" >'+cellData.RA_FIN_WEIGHT_MAX+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" >'+cellData.RBA_WEIGHT+'</td>'
    											+'</tr>'

    											)
    	}
    	// 중분류 ,대분류 같은 위험평가 배점 합산해서 셋팅
    	if(cnt > 0) {
    		//mergeData();

    		textmerge();

    		$('#mergeTable > tbody:last').append('<tr  height="45px"><th style="text-align:center;border-right: 1px solid #CCCCCC;background-color:#ffe5d9; font-weight:bold" colSpan="7">SUM</th>'
    				                            +'<th style="text-align:center;border-right: 1px solid #CCCCCC;background-color:#ffcd91; font-weight:bold" colSpan="1">RBA가중치(안):'+SUM_RBA_WEIGHT.toFixed(2)+'</th></tr>');
    	}
    }

    function textmerge() {

    	var tabObj = document.getElementById("mergeTable");

    	textmergeCol(tabObj, 1);
    	textmergeCol(tabObj, 0);


    }

    function textmergeCol(tObj,col){



    	var maxRow = tObj.rows.length;
    	//2row로 초기값 셋팅
    	var compareData = tObj.rows[2].cells[col].innerText;
    	//var num = Number(tObj.rows[2].cells[col+2].innerText);

    	var currentData ="";
    	var mergeCount=1;

    	/* 0~1 row 헤어
    	   2 row는 초기값
    	   3 row부터 for문시작
    	*/

    	//alert( "currentData : " + compareData );

    	for(var i=3; i<maxRow; i++) {
    		//currentData 은  코드값
    		currentData = tObj.rows[i].cells[col].innerText;
    		//currentDataNum은 소분류의 배점
    		//currentDataNum = tObj.rows[i].cells[col+2].innerText;

    		//중분류 코드값 같으면 소분류 배점을 더함
    		if(currentData == compareData) {
    			mergeCount ++;
    			//num = Number(num) + Number(currentDataNum);
    		} else {
    			tmerge(tObj, col, i-mergeCount, mergeCount,compareData);
    			compareData = currentData;
    			mergeCount=1;
    			//num = Number(currentDataNum);
    		}
    	}

    	tmerge(tObj, col, maxRow-mergeCount, mergeCount, compareData);
    }

    function tmerge(tObj, col, start,len,text) {
    	if(1 < len) {

    		tObj.rows[start].cells[col].innerText = text;
    		tObj.rows[start].cells[col].rowSpan = len;
    		tObj.rows[start].cells[col].align = "center";
    		for(var j=start + 1 ; j <start + len; j++) {
    			tObj.rows[j].deleteCell(col);
    		}
    	}
    	if(len == 1){
    		tObj.rows[start].cells[col].innerText = text;
    	}
    }



 // 분류가 같은 데이터 병합
    function merge(tObj, col, start,len,num) {
    	if(1 < len) {

    		tObj.rows[start].cells[col+2].innerText = Number(num).toFixed(2);
    		tObj.rows[start].cells[col+2].rowSpan = len;
    		tObj.rows[start].cells[col+2].align = "center";
    		for(var j=start + 1 ; j <start + len; j++) {
    			tObj.rows[j].deleteCell(col+2);
    		}
    	}
    	if(len == 1){
    		tObj.rows[start].cells[col+2].innerText = Number(num).toFixed(2);
    	}
    }


    // 분류가 같은 데이터 병합
    function mergeData() {
    	var tabObj = document.getElementById("mergeTable");
    	//배점2 병합
    	mergeCol(tabObj,3);
    	//배점1 병합
    	//mergeCol(tabObj,0);
    }

    // 분류가 같은 데이터 병합
    function mergeCol(tObj,col){
    	var maxRow = tObj.rows.length;
    	//2row로 초기값 셋팅
    	var compareData = tObj.rows[2].cells[col].innerText;
    	var num = Number(tObj.rows[2].cells[col+2].innerText);

    	var currentData ="";
    	var mergeCount=1;

    	/* 0~1 row 헤어
    	   2 row는 초기값
    	   3 row부터 for문시작
    	*/

    	for(var i=3; i<maxRow; i++) {
    		//currentData 은  코드값
    		currentData = tObj.rows[i].cells[col].innerText;
    		//currentDataNum은 소분류의 배점
    		currentDataNum = tObj.rows[i].cells[col+2].innerText;

    		//중분류 코드값 같으면 소분류 배점을 더함
    		if(currentData == compareData) {
    			mergeCount ++;
    			num = Number(num) + Number(currentDataNum);
    		} else {
    			merge(tObj, col, i-mergeCount, mergeCount,num);
    			compareData = currentData;
    			mergeCount=1;
    			num = Number(currentDataNum);
    		}
    	}

    	merge(tObj, col, maxRow-mergeCount, mergeCount, num);
    }



 	// 화면에 있는 tableRow 삭제(헤더테이블 2row 제외)
    function deleteRows() {
        var tbl = document.getElementById('mergeTable');
            lastRow = tbl.rows.length - 1;
        for (i = lastRow; 1 < i; i--) {
            tbl.deleteRow(i);
        }
    }

    //Risk Factor 조회
    function doSave() {
    	showConfirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}", "저장",function(){
        	overlay.show(true, true);
    		var methodID    = "doSave";
    		var obj = new Object();
    		obj.pageID      = pageID;					//"RBA_50_03_03_02";
    		obj.BAS_YYMM 	= $("#BAS_YYMM").val()		//평가년월

    		sendService(classID, methodID, obj, doSave_end, doSave_fail);
            return true;
        })

    }
    //배점저장 end
    function doSave_end() {
		//setupGrids();
        overlay.hide();


    }
	function doSave_fail(){
        overlay.hide();
		console.log("doSave_fail");
    	if(doConfirmYn) {
    		//doConfirm();
    		doConfirmYn = false;
    	}
        doSearch();
	}
    // 배점합계구하기
    function mergeDataTot() {
    	var tabObj = document.getElementById("mergeTable");
    	var maxRow = tabObj.rows.length;
    	var num = "";
    	var numTot = 0;
    	var RSK_INDCT="";
    	var JIPYO_ALLT="";
    	var rowLength=0;

    	/* 0~1 row 헤더
    	   2 row부터 for문시작
    	*/
    	//alert( "call tot 1: " + tabObj.rows[2].cells[1].innerText + " : " + tabObj.rows[2].cells[2].innerText + " : " + tabObj.rows[3].cells[2].innerText+ " : " + $("#" + "R34201").val());
    	//alert( "call tot 2: " + tabObj.rows[3].cells[1].innerText + " : " + tabObj.rows[3].cells[2].innerText + " : " + tabObj.rows[3].cells[3].innerText+ " : " + $("#R34202").val());

    	for(var i=2; i<maxRow-1; i++) {
    		rowLength   = tabObj.rows.item(i).cells.length;
    		RSK_INDCT   = tabObj.rows[i].cells[rowLength-7].innerText;

    		//alert( "RSK_INDCT : " + RSK_INDCT);
    		//alert( "RSK_INDCT.toString()).val() : " + $("#"+RSK_INDCT).val());

    		JIPYO_ALLT  =  $("#"+RSK_INDCT.toString()).val();


    		if(JIPYO_ALLT ==  "") {
    			overlay.hide();
    			alert(RSK_INDCT + "배점을 입력해야 합니다.");
    			$("#"+RSK_INDCT).focus();
    			return false;
    		}else {
    			//alert( "JIPYO_ALLT : " + JIPYO_ALLT );
    		}

    		if(JIPYO_ALLT.indexOf(".") > -1 && JIPYO_ALLT.length - JIPYO_ALLT.indexOf(".") > 3) {
    			overlay.hide();
    			alert("${msgel.getMsg('RBA_50_03_03_009','배점은 소수점 2자리까지만 입력됩니다.')}");
    			return false;
    		}
    		num = parseFloat(JIPYO_ALLT).toFixed(2);
			numTot = numTot + Number(num);
    		//console.log("currentData_"+i+"["+RSK_INDCT+"]/"+JIPYO_ALLT+"/"+num+'/'+numTot);
    	}
    	form1.JIPYO_ALLT_SUM.value = Number(parseFloat(numTot).toFixed(2));

    	//alert( "call tot JIPYO_ALLT_SUM : " + form1.JIPYO_ALLT_SUM.value );

		//console.log("Total:"+form1.JIPYO_ALLT_SUM.value);
		return true;
    }

	// 엑셀 다운로드 function
    function doDownload() {
        if(!confirm('${msgel.getMsg("RBA_50_03_03_002","다운로드 하시겠습니까?")}')) {
            return;
        }

        form2.BAS_YYMM.value         = $("#BAS_YYMM").val();
        form2.RSK_CATG.value         = $("#RSK_CATG").val();
        form2.RSK_FAC.value          = $("#RSK_FAC").val();
        form2.target                 = "_self";
        form2.action                 = "Package/RBA/common/fileDown/sRbaExcelFileDownload.jsp";
        form2.method                 = "post";
        form2.submit();

    }

    //배점기준관리  업로드(RBA_50_03_03_02.jsp) 팝업 호출 function
    function openTjInfoUploadPopUp() {

    	/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {alert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}'); return;};
    	/*업무 실제 종료일자 확인  */
    	if(!chkCommValidation("CHK_MODIFY_POSSI_REAL_DT")) {alert('${msgel.getMsg("RBA_50_02_01_011","해당 업무단계의 실제종료일이 작성되어 있어 수정 불가능 합니다.")}'); return;};

        form2.pageID.value    = "RBA_50_03_03_02";
        form2.BAS_YYMM.value  = $("#BAS_YYMM").val();
        var win;          win = window_popup_open(form2, 400, 180, '', 'yes');
        form2.method          = "post";
        form2.target          = form2.pageID.value;
        form2.action          = "<c:url value='/'/>0001.do";
        form2.submit();
    }


    function chkCommValidation(CHK_GUBN){
    	//전사 위험평가(ML/TF) 배점관리 코드값 C02
    	var RBA_VALT_SMDV_C = "C02";
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

	function scrollX() {
	    document.all.mainTable.scrollLeft = document.all.bottomLine.scrollLeft;
	    document.all.topTable.scrollLeft = document.all.bottomLine.scrollLeft;
	}

	function scrollY() {
	    //document.all.leftTable.scrollTop = document.all.mainTable.scrollTop;
	    //document.all.mainTable.scrollTop = document.all.leftTable.scrollTop;
	}


	function doRApopup() {
		alert( "팝업창 구현중입니다");
	}

    //ING_STEP정보 가져오기..
    function doSearchStepInfo() {
    	overlay.show(true, true);
        var params = new Object();
        var methodID	= "doSearchStepNm";		//RBA_50_01_01_01.RBA_50_01_01_01_getStepNm
		params.pageID 	= "RBA_50_05_04_01";
		params.BAS_YYMM	=  $("#BAS_YYMM").val();		//평가지준월	//form1.BAS_YYMM.value;	//기준연도

		sendService("RBA_50_01_01_01", methodID, params, doSearchStepInfo_end, doSearchStepInfo_fail);
    }
    function doSearchStepInfo_end(gridData,data) {
		var rowCount = gridData.length;
		var sfyn = "N";
		ingStep = "0";
		if(rowCount > 0) {
	        //진행상태display
            sfyn = (gridData[0].MLTF_FIX_YN == "0") ? "N":"Y";
            ingStep = gridData[0].ING_STEP;
            ingStepNm = gridData[0].ING_STEP_NM;
	        form1.mltfFixyn.value = sfyn;
	        form1.ingStep.value = ingStep;
	        form1.ingStepNm.value = ingStepNm;
		} else {
            ingStepNm = "RBA회차별 업무준비";
	        form1.ingStep.value = ingStep;
	        form1.ingStepNm.value = ingStepNm;
		}
        overlay.hide();
        //alert(ROLE_ID);
        if (ROLE_ID == '7') {
        	$("button[id='btn_02']").prop('disabled', false);	//저장
			$("button[id='btn_04']").prop('disabled', false);	//확정/취소
        } else {
            if (parseInt(form1.ingStep.value) < 10) {		//위험평가배점 확정
            	$("button[id='btn_02']").prop('disabled', true);	//저장
            	$("button[id='btn_04']").prop('disabled', true);	//저장
    		} else {
    			if (parseInt(form1.ingStep.value) >= 25) {	//부점관리 확정(25)
    	        	$("button[id='btn_02']").prop('disabled', true);	//저장
    				$("button[id='btn_04']").prop('disabled', true);	//확정/취소
    			} else {
    	        	$("button[id='btn_02']").prop('disabled', false);	//저장
    				$("button[id='btn_04']").prop('disabled', false);	//확정/취소
    			}
    		}
        }

    }
    function doSearchStepInfo_fail(){
		console.log("RBA_50_05_04_01.doSearchStepInfo_fail");
		ingStep = "0";
        ingStepNm = "RBA회차별 업무준비";
        form1.ingStep.value = ingStep;
        form1.ingStepNm.value = ingStepNm;
        overlay.hide();
        if (ROLE_ID == '7') {
        	$("button[id='btn_02']").prop('disabled', false);	//저장
			$("button[id='btn_04']").prop('disabled', false);	//확정/취소
        } else {
            if (parseInt(form1.ingStep.value) < 10) {		//위험평가배점 확정
            	$("button[id='btn_02']").prop('disabled', true);	//저장
            	$("button[id='btn_04']").prop('disabled', true);	//저장
    		} else {
    			if (parseInt(form1.ingStep.value) >= 25) {	//부점관리 확정(25)
    	        	$("button[id='btn_02']").prop('disabled', true);	//저장
    				$("button[id='btn_04']").prop('disabled', true);	//확정/취소
    			} else {
    	        	$("button[id='btn_02']").prop('disabled', false);	//저장
    				$("button[id='btn_04']").prop('disabled', false);	//확정/취소
    			}
    		}
        }
    }



    function doConfirm() {

		//alert( "step : " + form1.ING_STEP.value);

		if(form1.ING_STEP.value == "30"){

            showConfirm("${msgel.getMsg('RBA_50_01_01_006','확정을 하시겠습니까?')}", "확정",function(){
                     var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = form1.BAS_YYMM.value;
                     params.FIX_YN = "1";
                     params.ING_STEP = "40";  //confirmState
                     params.RBA_VALT_SMDV_C = "2.3";

                     sendService(classID, methodID, params, doConfirm_end, doConfirm_end);

            });


        }else{
        	if(form1.ING_STEP.value == "40"){

	            showConfirm("${msgel.getMsg('RBA_50_01_01_007','확정을 취소하시겠습니까?')}", "취소",function(){
	            	// $("button[id='btn_07']").prop('disabled', true);

	                 var params   = new Object();
                     var methodID = "doConfirm";
                     var classID  = "RBA_50_01_01_01";
                     params.pageID 	= "RBA_50_01_01_01";
                     params.BAS_YYMM = form1.BAS_YYMM.value;
                     params.FIX_YN = "0";
                     params.ING_STEP = "30";  //confirmState
                     params.RBA_VALT_SMDV_C = "2.3";

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


    // 확정 체크 스크립트
    function chkPosCon(){
        var flag = "0";
        //rCnt = GridObj1.rowCount();	//오류..hanayc
        for (var i = 0; i < rCnt; i++) {
            var rowobj = GridData[i];
            //수행시작일&수행종료일 체크 시작
            if(rowobj.VALT_SDT.length != 8 || rowobj.VALT_EDT.length != 8){
                flag = "1";
                form2.P_BAS_YYMM.value           = rowobj.BAS_YYMM;
                form2.P_RBA_VALT_LGDV_C.value    = rowobj.RBA_VALT_LGDV_C;
                form2.P_RBA_VALT_SMDV_C.value    = rowobj.RBA_VALT_SMDV_C;
                form2.P_RBA_VALT_LGDV_C_NM.value = rowobj.RBA_VALT_LGDV_C_NM;
                form2.P_RBA_VALT_SMDV_C_NM.value = rowobj.RBA_VALT_SMDV_C_NM;
                form2.P_EXP_TRM.value  			 = rowobj.EXP_TRM;

                form2.P_EXEC_B_BRNO_YN.value     = rowobj.EXEC_B_BRNO_YN;
                form2.P_EXEC_S_BRNO_YN.value     = rowobj.EXEC_S_BRNO_YN;
                form2.P_VALT_SDT.value           = (rowobj.VALT_SDT == undefined)?"":rowobj.VALT_SDT;        //수행시작일
                form2.P_VALT_EDT.value           = (rowobj.VALT_EDT == undefined)?"":rowobj.VALT_EDT;        //수행종료일
                form2.P_TGT_TRN_SDT.value        = (rowobj.TGT_TRN_SDT  == undefined)?"":rowobj.TGT_TRN_SDT; //대상시작일
                form2.P_TGT_TRN_EDT.value        = (rowobj.TGT_TRN_EDT  == undefined)?"":rowobj.TGT_TRN_EDT; //대상종료일
                form2.P_REAL_EDT.value        	 = (rowobj.REAL_EDT  == undefined)?"":rowobj.REAL_EDT; //대상종료일
                return flag;
            }

            //대상시작일&대상종료일 체크 시작
            if(rowobj.RBA_VALT_SMDV_C == "D01"){
                if(rowobj.TGT_TRN_SDT.length != 8 || rowobj.TGT_TRN_EDT.length != 8){
                    flag = "2";
                    form2.P_BAS_YYMM.value           = rowobj.BAS_YYMM;
                    form2.P_RBA_VALT_LGDV_C.value    = rowobj.RBA_VALT_LGDV_C;
                    form2.P_RBA_VALT_SMDV_C.value    = rowobj.RBA_VALT_SMDV_C;
                    form2.P_RBA_VALT_LGDV_C_NM.value = rowobj.RBA_VALT_LGDV_C_NM;
                    form2.P_RBA_VALT_SMDV_C_NM.value = rowobj.RBA_VALT_SMDV_C_NM;
                    form2.P_EXP_TRM.value  			 = rowobj.EXP_TRM;

                    form2.P_EXEC_B_BRNO_YN.value     = rowobj.EXEC_B_BRNO_YN;
                    form2.P_EXEC_S_BRNO_YN.value     = rowobj.EXEC_S_BRNO_YN;
                    form2.P_VALT_SDT.value           = (rowobj.VALT_SDT == undefined)?"":rowobj.VALT_SDT;        //수행시작일
                    form2.P_VALT_EDT.value           = (rowobj.VALT_EDT == undefined)?"":rowobj.VALT_EDT;        //수행종료일
                    form2.P_TGT_TRN_SDT.value        = (rowobj.TGT_TRN_SDT  == undefined)?"":rowobj.TGT_TRN_SDT; //대상시작일
                    form2.P_TGT_TRN_EDT.value        = (rowobj.TGT_TRN_EDT  == undefined)?"":rowobj.TGT_TRN_EDT; //대상종료일
                    form2.P_REAL_EDT.value        	 = (rowobj.REAL_EDT  == undefined)?"":rowobj.REAL_EDT; //대상종료일
                    return flag;
                }
            }
        }
        return flag;
    }

    function doClose() {
        opener.doSearch();
        window.close();
    }

    // 확정/취소 end
    /* function doConfirm_end() {
        $("button[id='btn_04']").prop('disabled', false);
        doSearch();
    } */

</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
</form>

<form name="form1" method="post">
	<input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="ingStep" >
    <input type="hidden" name="JIPYO_ALLT_SUM" >


    <div class="panel panel-primary" style="padding-top: 8px;">
        <div class="panel-footer" >
            <div class="table-box" style="overflow-y:scroll;overflow-x:hidden;width:100%;height:72vh;table-layout:Fixed;" onscroll="scrollY()">
                <table width="100%" class="basic-table" id="mergeTable">
                    <tr height="35px" >
                        <th colspan="7" style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ffe5d9; font-weight:bold">${msgel.getMsg('RBA_50_03_03_01_001','RA')}</th>
                        <th colspan="1" style="text-align:center;border-right: 1px solid #CCCCCC; background-color:#ffcd91; font-weight:bold">${msgel.getMsg('RBA_50_03_03_01_002','RBA')}</th>
                    </tr>
                    <tr height="35px" >
                        <th style="text-align:center;border-right: 1px solid #CCCCCC; width:6%; font-weight:bold">${msgel.getMsg("RBA_50_03_03_01_003","적용모델")}</th>
                        <th style="text-align:center;border-right: 1px solid #CCCCCC; width:8%; font-weight:bold">${msgel.getMsg("RBA_50_03_03_01_004","위험분류")}</th>
                        <th style="text-align:center;border-right: 1px solid #CCCCCC; font-weight:bold">${msgel.getMsg("RBA_50_03_03_01_013","항목코드")}</th>
                        <th style="text-align:center;border-right: 1px solid #CCCCCC; width:20%; font-weight:bold">${msgel.getMsg("RBA_50_03_03_01_005","평가항목")}</th>
                        <th style="text-align:center;border-right: 1px solid #CCCCCC; width:12%; font-weight:bold">${msgel.getMsg("RBA_50_03_03_01_007","개인")}</th>
                        <th style="text-align:center;border-right: 1px solid #CCCCCC; width:12%; font-weight:bold">${msgel.getMsg("RBA_50_03_03_01_008","법인")}</th>
                        <th style="text-align:center;border-right: 1px solid #CCCCCC; width:12%; font-weight:bold">${msgel.getMsg("RBA_50_03_03_01_009","MAX(최종가중치)")}</th>
                        <th style="text-align:center;border-right: 1px solid #B0C4DE; width:15%; background-color:#ffcd91; font-weight:bold">${msgel.getMsg("RBA_50_03_03_01_014","B모델RBA가중치(안)")}</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="tab-content-bottom" style="display: none">
		<div class="cont-area3" style="padding-top: 8px;">
			<div class="cont-area3-left" style="width: 100%">
				<div id="GTDataGrid1_Area"></div>
			</div>
		</div>
	</div>
	<div class="button-area">
    	<input type="text" class="cond-input-text" name="BAS_YYMM" id="BAS_YYMM" value="${BAS_YYMM}" style="border: 0px;background-color:white;color:white" readonly="readonly"></input>
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
    </div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />