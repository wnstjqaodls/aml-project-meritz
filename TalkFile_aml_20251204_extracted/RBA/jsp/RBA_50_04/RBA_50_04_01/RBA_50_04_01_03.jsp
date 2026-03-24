<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_04_01_03.jsp
* Description     : 배부통제 부서 선택
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-09
--%>
<%

    String BAS_YYMM     = Util.nvl(request.getParameter("BAS_YYMM")			, "");
	String CNTL_CATG1_C = Util.nvl(request.getParameter("CNTL_CATG1_C")			, "");
	String CNTL_CATG2_C = Util.nvl(request.getParameter("CNTL_CATG2_C")			, "");
	String CNTL_ELMN_C = Util.nvl(request.getParameter("CNTL_ELMN_C")			, "");
	String CNTL_CATG1_C_NM = Util.nvl(request.getParameter("CNTL_CATG1_C_NM")			, "");
	String CNTL_CATG2_C_NM = Util.nvl(request.getParameter("CNTL_CATG2_C_NM")			, "");
	String CNTL_ELMN_C_NM = Util.nvl(request.getParameter("CNTL_ELMN_C_NM")			, "");
	String BRNO_NM = Util.nvl(request.getParameter("BRNO_NM")			, "");

	request.setAttribute("BAS_YYMM", BAS_YYMM);
	request.setAttribute("CNTL_CATG1_C", CNTL_CATG1_C);
	request.setAttribute("CNTL_CATG2_C", CNTL_CATG2_C);
	request.setAttribute("CNTL_ELMN_C", CNTL_ELMN_C);
	request.setAttribute("CNTL_CATG1_C_NM", CNTL_CATG1_C_NM);
	request.setAttribute("CNTL_CATG2_C_NM", CNTL_CATG2_C_NM);
	request.setAttribute("CNTL_ELMN_C_NM", CNTL_ELMN_C_NM);
	request.setAttribute("BRNO_NM", BRNO_NM);

%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
	<script language="JavaScript">
	var GridObj1 = null;
	var GridObj2 = null;
	var overlay = new Overlay();
	var classID  = "RBA_50_04_01_03";
	var pageID   = "RBA_50_04_01_03";

	$(document).ready(function(){
		setupConditions();
		setupGrids1();
		setupGrids2();
		setupFilter1("init");
        setupFilter2("init");

		doSearch();
		doSearch2();
		$(".dx-texteditor-input").css("ime-mode","active");
	});

	function setupFilter1(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridObj.title = "${msgel.getMsg('RBA_50_01_02_002','등록지점')}";
    	gridArrs[0] = gridObj;

    	setupGridFilter2(gridArrs,FLAG);
    }

    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridObj.title = "${msgel.getMsg('RBA_50_01_02_003','미등록지점')}";
    	gridArrs[1] = gridObj;


    	setupGridFilter2(gridArrs,FLAG);
    }


    // Initial function
    function init(){
        initPage();
    }


    // 그리드 초기화 함수 셋업
    function setupGrids1(){
    	 GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
 			elementAttr: { class: "grid-table-type" },
			 height	:"calc(75vh - 60px)",
			 "hoverStateEnabled": true,
			 "wordWrapEnabled": false,
			 "allowColumnResizing": true,
			 "columnAutoWidth": true,
			 "allowColumnReordering": true,
			 "cacheEnabled": false,
			 "cellHintEnabled": true,
			 "showBorders": true,
			 "showColumnLines": true,
			 "showRowLines": true,
			 "export":                  {
			     "allowExportSelectedData": false,
			     "enabled": false,
			     "excelFilterEnabled": false,
			     "fileName": "gridExport"
			 },
			 "sorting": {"mode": "multiple"},
			 "remoteOperations":                  {
			     "filtering": false,
			     "grouping": false,
			     "paging": false,
			     "sorting": false,
			     "summary": false
			 },
			 "editing":                  {
			     "mode": "batch",
			     "allowUpdating": true,
			     "allowAdding": false,
			     "allowDeleting": false
			 },
			 "filterRow": {"visible": false},
			 "rowAlternationEnabled": false,
			 "columnFixing": {"enabled": true},
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
			 "searchPanel":                  {
			     "visible": true,
			     "width": 250
			 },
			 "selection":                  {
			     "allowSelectAll": true,
			     "deferred": false,
			     "mode": "multiple",
			     "selectAllMode": "allPages",
			     "showCheckBoxesMode": "always"
			 },
			onContentReady: function (e) {
			    e.component.columnOption("command:select", "width", 30);
			},
			onToolbarPreparing: function (e) {
			    var toolbarItems = e.toolbarOptions.items;
			    $.each(toolbarItems, function(_, item) {
			        if(item.name == "saveButton" || item.name == "revertButton") {
			            item.options.visible = false;
			        }
			    });
			},
			editCellTemplate : function(cellElement, cellInfo) {
			    $("<div>").appendTo(cellElement).dxCheckBox({
			       visible : true
			    })
			  },
			 "columns":
			 [
			      {
			         "dataField": "HGRK_BRNO",
			         "caption": '본부부서',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false,
			         "visible": false
			     },{
			         "dataField": "HGRK_BRNO_NM",
			         "caption": '본부명',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false,
			         "visible": false
			     },{
			         "dataField": "BRNO",
			         "caption": '${msgel.getMsg("RBA_50_01_02_01_003","부서코드")}',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false
			     },{
			         "dataField": "BRNO_NM",
			         "caption": '${msgel.getMsg("RBA_50_01_02_01_004","부서명")}',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false
			     }, {
			            dataField    : "TONGJE_FLD_C",
			            caption      : '통제영역코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false,
			    },  {
			            dataField    : "TONGJE_LGDV_C",
			            caption      : '통제대분류코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			    },  {
			            dataField    : "TONGJE_MDDV_C",
			            caption      : '통제중분류코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			    },  {
			            dataField    : "TONGJE_SMDV_C",
			            caption      : '통제소분류코드',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }


			 ],
			 onToolbarPreparing   : makeToolbarButtonGrids
        }).dxDataGrid("instance");
    }
    function setupGrids2(){
    	 GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
 			elementAttr: { class: "grid-table-type" },
			 height	:"calc(75vh - 60px)",
			 "hoverStateEnabled": true,
			 "wordWrapEnabled": false,
			 "allowColumnResizing": true,
			 "columnAutoWidth": true,
			 "allowColumnReordering": true,
			 "cacheEnabled": false,
			 "cellHintEnabled": true,
			 "showBorders": true,
			 "showColumnLines": true,
			 "showRowLines": true,
			 "export":                  {
			     "allowExportSelectedData": false,
			     "enabled": false,
			     "excelFilterEnabled": false,
			     "fileName": "gridExport"
			 },
			 "sorting": {"mode": "multiple"},
			 "remoteOperations":                  {
			     "filtering": false,
			     "grouping": false,
			     "paging": false,
			     "sorting": false,
			     "summary": false
			 },
			 "editing":                  {
			     "mode": "batch",
			     "allowUpdating": true,
			     "allowAdding": false,
			     "allowDeleting": false
			 },
			 "filterRow": {"visible": false},
			 "rowAlternationEnabled": false,
			 "columnFixing": {"enabled": true},
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
			 "searchPanel":                  {
			     "visible": true,
			     "width": 250
			 },

			 "selection":                  {
			     "allowSelectAll": true,
			     "deferred": false,
			     "mode": "multiple",
			     "selectAllMode": "allPages",
			     "showCheckBoxesMode": "always"
			 },
			onContentReady: function (e) {
			    e.component.columnOption("command:select", "width", 30);
			},
			onToolbarPreparing: function (e) {
			    var toolbarItems = e.toolbarOptions.items;
			    $.each(toolbarItems, function(_, item) {
			        if(item.name == "saveButton" || item.name == "revertButton") {
			            item.options.visible = false;
			        }
			    });
			},
			 "columns":                  [
			      {
			         "dataField": "HGRK_BRNO",
			         "caption": '본부부서',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false,
			         "visible": false
			     },{
			         "dataField": "HGRK_BRNO_NM",
			         "caption": '본부명',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false,
			         "visible": false
			     },{
			         "dataField": "BRNO",
			         "caption": '${msgel.getMsg("RBA_50_01_02_01_003","부서코드")}',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false
			     },{
			         "dataField": "BRNO_NM",
			         "caption": '${msgel.getMsg("RBA_50_01_02_01_004","부서명")}',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false
			     },{
			         "dataField": "AML_TJ_BRNO_YN",
			         "caption": 'AML통제부서여부',
			         "alignment": "center",
			         "allowResizing": true,
			         "allowSearch": true,
			         "allowSorting": true,
			         "allowEditing": false,
			         "visible"      : false
			     }
			 ],
			 onToolbarPreparing   : makeToolbarButtonGrids
        }).dxDataGrid("instance");
    }

    // 검색조건 셋업
    function setupConditions(){
        try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(50, 100, 0);
        } catch (e) {
        	showAlert(e.message,'ERR');
        }
    }
	function doSearch() {
		overlay.show(true, true);
		GridObj1.clearSelection();
		GridObj1.option('dataSource', []);

        var classID  = "RBA_50_04_01_03";
        var methodID = "doSearchBrno";
        var params = new Object();
        params.pageID		 = "RBA_50_04_01_03";
        params.BAS_YYMM 	 = "${BAS_YYMM}";
        params.CNTL_CATG1_C  = "${CNTL_CATG1_C}";
        params.CNTL_CATG2_C  = "${CNTL_CATG2_C}";
        params.CNTL_ELMN_C   = "${CNTL_ELMN_C}";

        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}

	function doSearch_success(gridData, data){
    	try {
    		GridObj1.refresh();
    		GridObj1.option("dataSource",gridData);
   		} catch (e) {
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }

	function doSearch_fail() {
		overlay.hide();
	}

	function doSearch2() {
		overlay.show(true, true);
		GridObj2.clearSelection();
		GridObj2.option('dataSource', []);

 		 var classID  = "RBA_50_04_01_03";
         var methodID = "doSearchBrno2";
         var params = new Object();
         params.pageID		 = "RBA_50_04_01_03";
         params.BAS_YYMM 	 = "${BAS_YYMM}";
         params.CNTL_CATG1_C = "${CNTL_CATG1_C}";
         params.CNTL_CATG2_C = "${CNTL_CATG2_C}";
         params.CNTL_ELMN_C  = "${CNTL_ELMN_C}";

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
	  function remove_data(){
			var rowsData = GridObj1.getSelectedRowsData();

	        var selSize = rowsData.length;
	        if (selSize==0) {
	            showAlert("${msgel.getMsg('AML_10_09_01_01_004','선택된 건이 없습니다.')}", 'WARN');
	            return;
	        }

	        var rowsData2 = GridObj2.getSelectedRowsData();

	        var dataSource2 = GridObj2.getDataSource();
	        var dataSource1 = GridObj1.getDataSource();

	        var brnoArr = new Array();
	        for(var i = 0; i < rowsData2.length; i++) {
				brnoArr[i] = rowsData2[i]["BRNO"];
			}

	        var item = dataSource1.items();
			for(var i=0; i<selSize; i++){

				if(brnoArr.indexOf(rowsData[i].BRNO) >= 0) {
					showAlert('${msgel.getMsg("RBA_50_01_02_01_010","이미등록된 지점이 포함되어 있습니다 부서코드 : ")}' + rowsData[i].BRNO, 'WARN');
					return;
				}else{
					dataSource2.store().insert(rowsData[i]);

					var keyIndex =GridObj1.getRowIndexByKey(rowsData[i]);
					var key  = item[keyIndex];
					dataSource1.store().remove(key);

				}
			}

			dataSource1.reload();
			dataSource2.reload();

			GridObj1.clearSelection();
		}

		function move_data(){
			var rowsData = GridObj2.getSelectedRowsData();
	        var selSize = rowsData.length;
	        if (selSize==0) {
	            showAlert("${msgel.getMsg('AML_10_09_01_01_004','선택된 건이 없습니다.')}", 'WARN');
	            return;
	        }

	        var rowsData1 = GridObj1.getSelectedRowsData();

	        var dataSource1 = GridObj1.getDataSource();
	        var dataSource2 = GridObj2.getDataSource();

	        var brnoArr = new Array();
	        for(var i = 0; i < rowsData1.length; i++) {
				brnoArr[i] = rowsData1[i]["BRNO"];
			}

	       var item = dataSource2.items();
			for(var i=0; i<rowsData.length; i++){

				if(brnoArr.indexOf(rowsData[i].BRNO) >= 0) {
					showAlert('${msgel.getMsg("RBA_50_01_02_01_010","이미등록된 지점이 포함되어 있습니다 부서코드 : ")}' + rowsData[i].BRNO, 'WARN');
					return;
				}else{

					dataSource1.store().insert(rowsData[i]);

					var keyIndex =GridObj2.getRowIndexByKey(rowsData[i]);
					var key  = item[keyIndex];
					dataSource2.store().remove(key);

				}
			}

			dataSource1.reload();
			dataSource2.reload();

			GridObj2.clearSelection();
		}

		function chk_selected(GridObj)
		{

			var selectedRows = GridObj.getSelectedRowsData();
			var selSize      = selectedRows.length;

			for(var i = 0; i < selectedRows.length; i++)
			{
				var selObj; selObj = GridObj.getKeyByRowIndex(i);
				if(selSize > 0)
				{
					return true;
				}
			}
			return false;
		}

	function doSaveBrno(){
	     /* var rowsData;
	     rowsData = GridObj1.getDataSource().items();
	     opener.setTjBRNO(rowsData) ;
	     window.close(); */



/* 	    var rowsData = GridObj1.getDataSource().items();
		var gobj; gobj = $('#GTDataGrid1_Area').dxDataGrid('instance');
		gobj.saveEditData();

		var classID  = "RBA_50_04_01_03";

		var params   = new Object();
    	var methodID = "doSave";

    	params.pageID 	     = "RBA_50_04_01_03";
    	params.BAS_YYMM      = "${BAS_YYMM}";
    	params.CNTL_ELMN_C   = "${CNTL_ELMN_C}";
    	params.gridData      = rowsData;	//obj2;

    	alert( "call doSaveBrno()4 classID : " + classID + " [[ ]]" + params.CNTL_ELMN_C ); */

		var rowsData = GridObj1.getDataSource().items();
		var gobj; gobj = $('#GTDataGrid1_Area').dxDataGrid('instance');
		gobj.saveEditData();


	    showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){
	    	//overlay.show(true, true);
	    	var classID  = "RBA_50_04_01_03";
        	var params   = new Object();
        	var methodID = "doSave2";

        	params.pageID 	     = "RBA_50_04_01_03";
        	params.BAS_YYMM      = "${BAS_YYMM}";
        	params.CNTL_ELMN_C   = "${CNTL_ELMN_C}";
        	params.gridData      = rowsData;	//obj2;

        	//alert( "call doSave()4 ");
        	sendService(classID, methodID, params, doSaveBrnoEnd, doSaveBrnoEnd);
        });


	}

	function doSaveBrnoEnd () {
		var rowsData; rowsData = GridObj1.getDataSource().items();
	    opener.doSearch();
	    window.self.close();

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
	            "locateInMenu"      : "auto",
	            "location"         : "after",
	            "widget"         : "dxButton",
	            "name"            : "filterButton",
	            "showText"         : "inMenu",
	            "options"         :
	            {
	               "icon"         : "" ,
	               "elementAttr"   : { class: "btn-28 filter popupFilter" },
	               "text"         : "",
	               "hint"         : '필터',
	               "disabled"      : false,
	               "onClick"      :
	                  function(){
	                     if(gridID=="GTDataGrid1_Area"){
	                        setupFilter1();
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
	            if (authC=="Y") {
	                $.each(toolbarItems, function(i, item) {
	                    if (item.name === "saveButton") {
	                        item.visible           =  false;

	                    }
	                });
	            }
	            if (authC=="Y"||authD=="Y") {
	                $.each(toolbarItems, function(i, item) {
	                    if (item.name === "revertButton") {
	                    	item.visible           =  false;
	                    }
	                });
	            }
	      }
	   }
</script>
<body>
<form name="form1">
<input type="hidden" name="pageID" >
<input type="hidden" name="classID" >
<input type="hidden" name="methodID" >
<input type="hidden" name="ROLE_ID" value="${ROLE_ID}">
<input type="hidden" name="BDPT_CD" value="${BDPT_CD}">
<input type="hidden" name="AML_LOGIN_ID" value="${ID}">
<input type="hidden" name="CNTL_CATG1_C" id="CNTL_CATG1_C">
<input type="hidden" name="CNTL_CATG2_C" id="CNTL_CATG2_C">
<input type="hidden" name="CNTL_ELMN_C" id="CNTL_ELMN_C">
<input type="hidden" name="CNTL_CATG1_C_NM" id="CNTL_CATG1_C_NM">
<input type="hidden" name="CNTL_CATG2_C_NM" id="CNTL_CATG2_C_NM">
<input type="hidden" name="CNTL_ELMN_C_NM" id="CNTL_ELMN_C_NM">
	<div class="panel panel-primary">
	    <div class="panel-footer" >
            <div class="table-box" >
                <table class="basic-table">
                    <tr>
                        <th class="title required" style="text-align: center;">${msgel.getMsg('RBA_50_04_01_02_001','통제분류Lv1')}</th>
                        	<td style="text-align: center;">${CNTL_CATG1_C_NM}</td>
                        <th class="title required" style="text-align: center;">${msgel.getMsg('RBA_50_04_01_02_002','통제분류Lv2')}</th>
                        	<td style="text-align: center;">${CNTL_CATG2_C_NM}</td>
                        <th class="title required" style="text-align: center;">${msgel.getMsg('RBA_50_04_01_02_003','통제요소')}</th>
                        	<td style="text-align: center;">${CNTL_ELMN_C_NM}</td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="margin-top: 8px"> </div>
		<div class="panel-footer" >
			<div class="table-box">
				<table class="tab-content-bottom">
				<tr>
					<td style="width:49%;height: 40vh;">
						<div id="GTDataGrid2_Area"></div>
					</td>
					<td style="width:2%" align="center">
						<button type="button" style="height:28px;"><img src="<c:url value='/'/>Package/design/images/icons/Button_Right.png" alt="[등록지점]의 선택 된 건을 [미등록지점]으로 이동시킵니다" style="display:block;" onclick="move_data()"/></button>
						<br />
						<br />
						<button type="button" style="height:28px;"><img src="<c:url value='/'/>Package/design/images/icons/Button_left.png" alt="[미등록지점]]의 전체 건을 삭제합니다" style="display:block;" onclick="remove_data()"/></button>
					</td>
					<td style="width:49%;height: 40vh;">
						<div id="GTDataGrid1_Area"></div>
					</td>
				</tr>
				</table>
			</div>
		</div>

	<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSaveBrno", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')}
        </div>
	</div>
</form>
</body>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />