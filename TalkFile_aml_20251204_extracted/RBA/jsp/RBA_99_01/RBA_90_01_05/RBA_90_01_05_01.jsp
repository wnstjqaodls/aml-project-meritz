<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_90_01_05_01.jsp
- Author     : SeungRok
- Comment    : 지표결과 보고현황
- Version    : 1.0
- history    : 1.0 2018 - 12 - 17
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<style type="text/css">
	* { white-space: nowrap;	}
</style>
<script language="JavaScript">

	var GridObj1 = null;
	var classID  = "";
	var pageID   = "";
	var overlay = new Overlay();

	$(document).ready(function(){
	 	setupConditions();
		setupGrids();
		doSearch();
		setupFilter("init");
    });

	function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridObj.title  = "";
    	gridArrs[0] = gridObj;

    	setupGridFilter2(gridArrs,FLAG);
    }

	function setupConditions(){
		try {
			var cbox1; cbox1 = new GtCondBox("condBox1",0,true);
			//cbox1.setItemWidths(220, 70, 4);
			cbox1.setItemWidths(195, 75, 0);
            cbox1.setItemWidths(245, 65, 1);

		} catch (e) {
			showAlert(e.message,"ERR");
		}


	}
	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			elementAttr: { class: "grid-table-type" },
			"height"						: "370px",
		    "hoverStateEnabled"             : true,
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
		         "excelFilterEnabled"       : true,
		         "fileName"                 : "gridExport"
		     },
		     "sorting": {"mode"             : "multiple"},
		     "remoteOperations":
		     {
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
		     "filterRow": {"visible"        : false},
		     onToolbarPreparing   : makeToolbarButtonGrids,
		     "rowAlternationEnabled"        : false,
		     "columnFixing": {"enabled"     : true},
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
		     "searchPanel":
		     {
		         "visible"                  : false,
		         "width"                    : 250
		     },
		     "selection":
		     {
		         "allowSelectAll"           : true,
		         "deferred"                 : false,
		         "mode"                     : "single",
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
		             "fixed" 	            : true,
		             "width"                : 90
		         },
		         {
		             "dataField"            : "JIPYO_C_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_004","위험구분")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "fixed" 	            : true,
		             "width"                : 60
		         },
// 		         {
// 		             "dataField"            : "RSK_CATG_NM",
// 		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_005","카테고리")}',
// 		             "alignment"            : "center",
// 		             "allowResizing"        : true,
// 		             "allowSearch"          : true,
// 		             "allowSorting"         : true,
// 		             "fixed" 	            : true,
// 		             "width"                : 80
// 		         },
// 		         {
// 		             "dataField"            : "RSK_FAC_NM",
// 		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_006","항목")}',
// 		             "alignment"            : "center",
// 		             "allowResizing"        : true,
// 		             "allowSearch"          : true,
// 		             "allowSorting"         : true,
// 		             "fixed" 	            : true,
// 		             "width"                : 80
// 		         },
		         {
		             "dataField"            : "JIPYO_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_003","지표명")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "fixed" 	            : true,
		             "width"                : 160
		         },
		         {
		          "dataField"               : "WRT1",
		            caption                 : '${msgel.getMsg("RBA_90_01_05_01_100","최근회차")}',
		            columns:
		            [
		                 {
		                     "dataField"    : "RANK1",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_109","순위")}',
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 50
		                 },
		                 {
		                     "dataField"    : "GRP_AVG_PNT1",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_110","그룹평균")}',
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 60
		                 },
		                 {
		                     "dataField"    : "SCORE1",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_101","점수")}',
		                     "cellTemplate" : function (container, options) {
		                         let value = options.value;
		                         $("<span>")
		                             .text(value)
		                             .css("color", "#ffaa66") // 텍스트 색상 변경
		                             .appendTo(container);
		                     },
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 50
		                 },
		                 {
		                     "dataField"    : "VAL1",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_102","지표값\\n(입력값)")}',
		                     "headerCellTemplate" : function (header, info) {
		 		                $("<div>").html(info.column.caption.replace(/\r\n/g, "<br/>")).appendTo(header);
		 		             },
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                     width          : 65
		                 },
		            ]
		        },
		        {
		            dataField         : "SCOREDR1",
		            caption           : '${msgel.getMsg("RBA_90_01_05_01_103","점수변동\\n(최근-직전)")}',
		            headerCellTemplate: function (header, info) {
		                $("<div>").html(info.column.caption.replace(/\r\n/g, "<br/>")).appendTo(header);
		            },
		            "alignment"    : "center",
		            "allowResizing": true,
		            "allowSearch"  : true,
		            "allowSorting" : true,
		            width          : 70
		        },
		        {
		          "dataField"               : "WRT2",
		            caption                 : '${msgel.getMsg("RBA_90_01_05_01_104","직전회차")}',
		            columns:
		            [
		            	 {
		                     "dataField"    : "RANK2",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_109","순위")}',
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 50
		                 },
		                 {
		                     "dataField"    : "GRP_AVG_PNT2",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_110","그룹평균")}',
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 60
		                 },
		                 {
		                     "dataField"    : "SCORE2",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_101","점수")}',
		                     "cellTemplate" : function (container, options) {
		                         let value = options.value;
		                         $("<span>")
		                             .text(value)
		                             .css("color", "#ffaa66") // 텍스트 색상 변경
		                             .appendTo(container);
		                     },
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 50
		                 },
		                 {
		                     "dataField"    : "VAL2",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_102","지표값\\n(입력값)")}',
		                     "headerCellTemplate" : function (header, info) {
		 		                $("<div>").html(info.column.caption.replace(/\r\n/g, "<br/>")).appendTo(header);
		 		             },
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                     width          : 65
		                 },
		            ]
		        },
		        {
		            dataField         : "SCOREDR2",
		            caption           : '${msgel.getMsg("RBA_90_01_05_01_105","점수변동\\n(직전-전전)")}',
		            headerCellTemplate: function (header, info) {
		                $("<div>").html(info.column.caption.replace(/\r\n/g, "<br/>")).appendTo(header);
		            },
		            "alignment"    : "center",
		            "allowResizing": true,
		            "allowSearch"  : true,
		            "allowSorting" : true,
		            width          : 70
		        },
		        {
		          "dataField"               : "WRT3",
		            caption                 : '${msgel.getMsg("RBA_90_01_05_01_106","전전회차")}',
		            columns:
		            [
		            	{
		                     "dataField"    : "RANK3",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_109","순위")}',
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 50
		                 },
		                 {
		                     "dataField"    : "GRP_AVG_PNT3",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_110","그룹평균")}',
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 60
		                 },
		            	 {
		                     "dataField"    : "SCORE3",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_101","점수")}',
		                     "cellTemplate" : function (container, options) {
		                         let value = options.value;
		                         $("<span>")
		                             .text(value)
		                             .css("color", "#ffaa66") // 텍스트 색상 변경
		                             .appendTo(container);
		                     },
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                      width         : 50
		                 },
		                  {
		                     "dataField"    : "VAL3",
		                     "caption"      : '${msgel.getMsg("RBA_90_01_05_01_102","지표값\\n(입력값)")}',
		                     "headerCellTemplate" : function (header, info) {
		 		                $("<div>").html(info.column.caption.replace(/\r\n/g, "<br/>")).appendTo(header);
		 		             },
		                     "alignment"    : "center",
		                     "allowResizing": true,
		                     "allowSearch"  : true,
		                     "allowSorting" : true,
		                     width          : 65
		                 },
		            ]
		        }
		     ],
		     "summary":
		     {
		        "totalItems":
		        [
		            {
		             "column"               : "JIPYO_IDX",
		             "summaryType"          : "count"
		            	 ,valueFormat: "fixedPoint"
		            }
		        ] ,texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}
	           },
		     "onCellClick": function(e)
		     {
		        if(e.data )
		        {
		            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		        }
		     }
		}).dxDataGrid("instance");
  	}

	function doSearch(){
		var methodID = "doSearch";
		var classID = "RBA_90_01_05_01"
		var obj = new Object();
		obj.pageID = "RBA_90_01_05_01"
		obj.classID = "RBA_90_01_05_01"
		obj.methodID = "doSearch";

		obj.RPT_GJDT 	  = $("#RPT_GJDT option:selected").val();
		obj.JIPYO_IDX 	  = $("#JIPYO_IDX").val();
		obj.JIPYO_NM 	  = $("#JIPYO_NM").val();
		obj.JIPYO_C  	= form1.JIPYO_C.value.trim();							// 위험구분
 		obj.RSK_CATG  	= form1.RSK_CATG.value.trim();							// 카테고리
 		obj.RSK_FAC  	= form1.RSK_FAC.value.trim();							// 항목
 		overlay.show(true, true);

 		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
	}

	function doSearch_end(dataSource){
		GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
		var row = dataSource.length;
		if(row > 0){
			GridObj1.selectRowsByIndexes(0);
			Grid1CellClick("GTDataGrid1", dataSource[0]);
            form1.GYLJ_S_C.value	=	dataSource[0].GYLJ_S_C;		// 결재상태코드
		}
		overlay.hide();
	}


	function Grid1CellClick(id, obj, selectData, row, col,colId){
		if(colId == "JIPYO_IDX" ) {	//수정 팝업

			form2.pageID.value  = 'RBA_90_01_03_05';
			var	win;        win = window_popup_open(form2.pageID.value, 1000, 825, '');

			form2.RPT_GJDT.value 		= form1.RPT_GJDT.value;
			form2.JIPYO_IDX.value 	  	= obj.JIPYO_IDX;
			form2.target = form2.pageID.value;
			form2.action = '<c:url value="/"/>0001.do';
			form2.submit();
	    }else{

	    	form2.pageID.value   = "RBA_90_01_05_02";
			form2.RPT_GJDT.value = obj.RPT_GJDT;
			form2.JIPYO_IDX.value = obj.JIPYO_IDX;

			form2.target = "post_frame";
			form2.action = "0001.do?pageID";
			form2.submit();

	    }

	}

	 function onAftreRptGjdtCdList() {

		 nextSelectChangeReportIndex("RSK_CATG",form1.RPT_GJDT.value, "A002" ,"" ,"","INIT");
		 nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
		 setTimeout("doSearch()","700");
	 }

	 function onAftreJipyoCCdList() {
		 nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
	 }

	 function jipyoSelectChange(v_gubun, nextGrp, GrpObj, v_afterFun) {
		var RPT_GJDT = form1.RPT_GJDT.value;
		var gubun = "";
		nextSelectChangeReportIndex(v_gubun, RPT_GJDT, nextGrp, GrpObj, v_afterFun , gubun);
	}

	function doReportFileUpload(){
		var GYLJ_S_C 		= form1.GYLJ_S_C.value;

		//결재상태코드 GYLJ_S_C (0 : 미결재 , 12 : 승인요청 , 22 : 반려, 3 : 완료  )
        if(GYLJ_S_C != "3"){
			showAlert("${msgel.getMsg('RBA_90_01_05_01_107','결재가 완료상태 되어야 파일업로드가 가능 합니다.')}","WARN");
			return ;
		}

		var form3 = document.form3;
		form3.pageID.value  = "RBA_90_01_05_04";
		form3.RPT_GJDT.value=form1.RPT_GJDT.value;
      	var   win   = window_popup_open(form3.pageID.value, 650,380, '');
      	form3.target = form3.pageID.value;
      	form3.action = '<c:url value="/"/>0001.do';
      	form3.submit();
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

</script>
<style>
#jipyoTable {
	border-collapse: separate;
	border-spacing: 0;
}

#jipyoTable thead th {
	position: sticky;
	top: 0;
	border-right: 1px solid #ccc;
	background-color: #eaeaea;
	border-top: 2px solid #222;
	border-bottom: 1px solid #222;
	z-index: 1;
}

#jipyoTable tbody td {
	border-bottom: 1px solid #e9eaeb;
	border-right: 1px solid #e9eaeb;
}
</style>
<form name="form3" action="post">
	<input type="hidden" name="RPT_GJDT"> <input type="hidden"
		name="pageID">
</form>
<form name="form2" action="post">
	<input type="hidden" name="RPT_GJDT"> <input type="hidden"
		name="JIPYO_IDX"> <input type="hidden" name="pageID">
</form>

<form name="form1">
	<input type="hidden" name="pageID"> <input type="hidden"
		name="GYLJ_S_C" id="GYLJ_S_C">

	<div class="inquiry-table type4" id="condBox1">
		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel('RBA_90_01_01_02_001','보고기준일')}
				${JRBACondEL.getJRBASelect('','RPT_GJDT' ,'' ,'' ,'JRBA_common_getRPT_GJDT' ,'' ,'','jipyoSelectChange("JIPYO_C", "A001", this, "onAftreRptGjdtCdList()")')}
			</div>
			<div class="table-cell">
				${condel.getLabel('RBA_90_01_01_02_004','위험구분')}
				${JRBACondEL.getJRBASelect('MAX','JIPYO_C' ,'A001' ,'' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_CATG", "A002", this, "onAftreJipyoCCdList()")')}
			</div>
		</div>
		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel('RBA_90_01_01_02_002','지표번호')}
				${condel.getInputCustomerNo('JIPYO_IDX')}</div>
			<div class="table-cell">
				${condel.getLabel('RBA_90_01_01_02_005','카테고리')}
				${JRBACondEL.getJRBASelect('','RSK_CATG' ,'A002' ,'' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_FAC", "A003", this)')}
			</div>
		</div>
		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel('RBA_90_01_01_02_003','지표명')}
				${condel.getInputCustomerNo('JIPYO_NM')}</div>
			<div class="table-cell">
				${condel.getLabel('RBA_90_01_01_02_006','항목')}
				${JRBACondEL.getJRBASelect('','RSK_FAC' ,'A003' ,'' ,'' ,'' ,'ALL','')}
			</div>
		</div>
	</div>
	<div class="button-area" style="margin-bottom: 5px;">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"AML_40_03_01_01_btn_06", defaultValue:"파일업로드", mode:"R", function:"doReportFileUpload", cssClass:"btn-36"}')}
	</div>
	<table style="width: 100%">
		<tr>
			<td
				style="width: 75%; padding: 5px; outline: 1px solid rgba(0, 0, 0, 0.2);">
				<div class="tab-content-bottom">
					<div id="GTDataGrid1_Area" style="width: 100%;"></div>
				</div>
			</td>
			<td
				style="width: 25%; padding-left: 10px; outline: 1px solid rgba(0, 0, 0, 0.2)">
				<iframe name="post_frame" frameborder="0" width="100%"
					height="400px;"></iframe>
			</td>
		</tr>
	</table>
	<font color=blue
		style="font-family: SpoqB; font-size: 0.8rem; color: blue;">${msgel.getMsg('RBA_90_01_05_01_200','※ FIU에서 제공한 평가 결과 중 지표별 결과에 대해 최근 3회의 점수 추이를 조회합니다.')}</font>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp"
	flush="true" />