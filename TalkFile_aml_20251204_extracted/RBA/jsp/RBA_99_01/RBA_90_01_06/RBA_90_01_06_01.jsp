<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_90_01_06_01.jsp
- Author     :
- Comment    : FIU지표기준정보
- Version    :
- history    :
********************************************************************************************************************************************
* Modifier        : 이혁준
* Update          : 2017. 9. 18.
* Alteration      :
*******************************************************************************************************************************************
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />

<script language="JavaScript">

	var GridObj1 ;   // 그룹코드
	var GridObj2 ;   // 상세코드
	var pageID 	= "RBA_90_01_06_01";
	var addCD    = "";
	var addCDNM  = "";
	var curRow   = -1;

	var pCCD     = "1";
	var firtsCnt = 0;

	var overlay = new Overlay();

	$(document).ready(function(){
		setupGrids();
		setupGrids2();
		//setupFilter();
		doSearch();
		setupFilter("init");
        setupFilter2("init");
        $(".dx-datagrid-cancel-button").closest("div.dx-toolbar-button").remove();

        if(form1.RPT_GJDT.value == "99991231"){
			GridObj1.option("editing", { mode: "batch", allowUpdating: false, allowAdding: false});
			GridObj2.option("editing", { mode: "batch", allowUpdating: false, allowAdding: false});
			$(".dx-button").filter(function() { return $(this).attr("title") === "remove";}).closest(".dx-toolbar-item").remove();
        }
    });

	function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;

    	setupGridFilter2(gridArrs,FLAG);
    }

    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridArrs[1] = gridObj;

    	setupGridFilter2(gridArrs,FLAG);
    }

	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height				  : "calc(50vh - 100px)",
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
		      export               : {
		         allowExportSelectedData: true,
		         enabled                : true,
		         excelFilterEnabled     : true,
		         fileName               : "gridExport"
		     },
		      sorting         : {mode: "multiple"},
		      remoteOperations: {
		         filtering: false,
		         grouping : false,
		         paging   : false,
		         sorting  : false,
		         summary  : false
		     },
		      editing: {
		         mode         : "batch",
		         allowUpdating: true,
		         allowAdding  : true,
		         allowDeleting: false
		     },
		      "onToolbarPreparing"               : makeToolbarButtonGrids,
		      "filterRow": {"visible"            : false},
		      "rowAlternationEnabled"            : true,
		      "searchPanel":
		      {
		          "visible"                      : false,
		          "width"                        : 250
		      },
		      onContentReady: function (e)
		      {
		         e.component.columnOption("command:select", "width", 30);
		      },
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
		      selection:{
		          allowSelectAll : true,
		          deferred : false,
		          mode : "multiple",
		          selectAllMode : "allPages",
		          showCheckBoxesMode : "always"
		      },
		      "columns":
		      [
		          {
		              "dataField"                : "GRP_CD",
		              "caption"                  : '${msgel.getMsg("RBA_90_01_06_01_100","그룹코드")}',
		              "alignment"                : "center",
		              "allowResizing"            : true,
		              "allowSearch"              : true,
		              "allowSorting"             : true,
		              "allowEditing"             : false,
		              width                      : "10%"
		          },
		          {
		              "dataField"                : "GRP_NM",
		              "caption"                  : '${msgel.getMsg("RBA_90_01_06_01_101","그룹코드명")}',
		              "alignment"                : "left",
		              "allowResizing"            : true,
		              "allowSearch"              : true,
		              "allowSorting"             : true,
		              width                      : "21%"
		          },
		          {
		              "dataField"                : "UPD_YN",
		              "caption"                  : '${msgel.getMsg("RBA_90_01_06_01_102","수정가능")}',
		              "lookup":
		              {
		                  "dataSource":
		                  [
		                      {
		                          "KEY"          : "1",
		                          "VALUE"        : "Y"
		                      },
		                      {
		                          "KEY"          : "0",
		                          "VALUE"        : "N"
		                      }
		                  ],
		                  "displayExpr"          : "VALUE",
		                  "valueExpr"            : "KEY"
		              },
		              "alignment"                : "center",
		              "allowResizing"            : true,
		              "allowSearch"              : true,
		              "allowSorting"             : true,
		              width                      : "7%",
		              visible      : false
		          },
		          {
		              "dataField"                : "BIGO_CTNT",
		              "caption"                  : '${msgel.getMsg("RBA_90_01_06_01_103","코드설명")}',
		              "alignment"                : "left",
		              "allowResizing"            : true,
		              "allowSearch"              : true,
		              "allowSorting"             : true,
		              width                      : "25%"
		          },
		          {
		              "dataField"                : "CHG_DT",
		              "caption"                  : '${msgel.getMsg("RBA_90_01_06_01_104","변경일자")}',
		              "cellTemplate"             : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
		              "alignment"                : "center",
		              "allowResizing"            : true,
		              "allowSearch"              : true,
		              "allowSorting"             : true,
		              "allowEditing"             : false,
		              width                      : "12%"
		          },
		          {
		              "dataField"                : "CHG_OP_JKW_NM",
		              "caption"                  : '${msgel.getMsg("RBA_90_01_02_01_101","변경자")}',
		              "alignment"                : "center",
		              "allowResizing"            : true,
		              "allowSearch"              : true,
		              "allowSorting"             : true,
		              "allowEditing"             : false,
		              width                      : "15%"
		          }
		      ],
	           onCellClick: function(e){
			    	if (e.component.isRowSelected(e.key) && ((e.data.IDU=="I" && e.columnIndex<=3) || (e.columnIndex>=2 && e.columnIndex<=3))) {
			            e.component.editCell(e.rowIndex,e.columnIndex);
			        } else if (e.rowIndex != undefined){
			            e.component.clearSelection();
			            e.component.selectRowsByIndexes(e.rowIndex);

			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    },
		      "onRowInserting" : function(e) {
		 		e.data["IDU"        ] = "I";
		 		 var mycols = e.component.option("columns");
		         for (var i=0; i<mycols.length; i++) {
		             var mycolobj = mycols[i];
		             var colname  = mycolobj["dataField"];
		             if(colname!="IDU"){
		                 e.data[colname] = "";
		             }
		         }
		      }
		}).dxDataGrid("instance");
	}
	function setupGrids2(){
		GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 "height"		  			    : "calc(50vh - 100px)",
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
		         "mode"                     : "batch"
		         ,allowUpdating             : true
		         ,allowAdding               : true
		         ,allowDeleting             : false
		     },
		     "onToolbarPreparing"           : makeToolbarButtonGrids,
		     "filterRow": {"visible"        : false},
		     "rowAlternationEnabled"        : true,
		     "searchPanel":
		     {
		         "visible"                  : false,
		         "width"                    : 250
		     },
		     onContentReady: function (e)
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
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
		     "selection":
		     {
		         "allowSelectAll"           : true,
		         "deferred"                 : false,
		         "mode"                     : "multiple",
		         "selectAllMode"            : "allPages",
		         "showCheckBoxesMode"       : "always"
		     },
		     "columns":
		     [
		         {
		             "dataField"            : "GRP_CD",
		             "caption"              : '${msgel.getMsg("RBA_90_01_06_01_100","그룹코드")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "allowEditing"         : false,
		             width                  : "10%"
		         },
		         {
		             "dataField"            : "DTL_CD",
		             "caption"              : '${msgel.getMsg("RBA_90_01_06_01_105","상세코드")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "allowEditing"         : false,
		             width                  : "10%"
		         },
		         {
		             "dataField"            : "DTL_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_06_01_106","상세코드명")}',
		             "alignment"            : "left",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "allowEditing"         : false,
		             width                  : "14%"
		         },
		          {
		             "dataField"            : "USYN",
		             "caption"              : '${msgel.getMsg("RBA_90_01_01_02_008","사용여부")}',
		             "lookup":
		             {
		                 "dataSource":
		                 [
		                     {
		                         "KEY"      : "1",
		                         "VALUE"    : "Y"
		                     },
		                     {
		                         "KEY"      : "0",
		                         "VALUE"    : "N"
		                     }
		                 ],
		                 "displayExpr"      : "VALUE",
		                 "valueExpr"        : "KEY"
		             },
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "allowEditing"         : false,
		             width                  : "8%"
		         },
		         {
		             "dataField"            : "HRNK_RBA_RSK_C",
		             "caption"              : '${msgel.getMsg("RBA_90_01_06_01_107","상위그룹코드")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "allowEditing"         : false,
		             width                  : "12%"
		         },
		         {
		             "dataField"            : "HRNK_RBA_RSK_C_V",
		             "caption"              : '${msgel.getMsg("RBA_90_01_06_01_108","상위그룹코드값")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "allowEditing"         : false,
		             width                  : "12%"
		         },
		         {
		             "dataField"            : "CHG_DT",
		             "caption"              : '${msgel.getMsg("RBA_90_01_06_01_104","변경일")}',
		             "cellTemplate"         : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "allowEditing"         : false,
		             width                  : "15%"
		         },
		         {
		             "dataField"            : "CHG_OP_JKW_NM",
		             "caption"              : '${msgel.getMsg("RBA_90_01_02_01_101","변경자")}',
		             "alignment"            : "center",
		             "allowResizing"        : true,
		             "allowSearch"          : true,
		             "allowSorting"         : true,
		             "allowEditing"         : false,
		             width                  : "15%"
		         }
		     ],
		     "onRowInserting" : function(e)
		     {
		        e.data["GRP_CD"     ]       = addCD;
		        e.data["USYN"       ]       = "1";
		        e.data["IDU"        ] = "I";
		        var mycols = e.component.option("columns");
		        for (var i=0; i<mycols.length; i++) {
		            var mycolobj = mycols[i];
		            var colname  = mycolobj["dataField"];
		            if (colname!="GRP_CD" && colname!="USYN" && colname!="IDU") {
		                e.data[colname] = "";
		            }
		        }
		     },
		     "onCellClick" : function(e) {
		        if (e.component.isRowSelected(e.key) && ((e.data.IDU=="I" && e.columnIndex>=2 && e.columnIndex<=6) || (e.data.IDU=="U" && e.columnIndex>=2 && e.columnIndex<=6))) {
		            e.component.editCell(e.rowIndex,e.columnIndex);
		        }
		     },
		     "onEditingStart" : function(info)
		     {
		       if (info.key) {
		           editBlock(info);
		       }
		     }

		}).dxDataGrid("instance");
	}

    function editBlock(info){
    	if("Legacy"==$("#CCD option:selected").text()){
    		info.cancel = true;
    	}
    }

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
                ,"name"         : "refreshButton"
                ,"showText"     : "inMenu"
                ,"options"      : {
                         "icon"      : "pulldown"
                        ,"hint"      : 'refresh'
                        ,"disabled"  : false
                        ,"onClick"   : gridID=="GTDataGrid1_Area"?doSearch:doSearch2
                        ,"elementAttr": { class: "btn-28" }
                 }
            });

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
	                    ,"hint"      : 'filter'
	                    ,"disabled"  : false
	                    ,"onClick"   : function(){
							if(gridID=="GTDataGrid1_Area"){
								setupFilter();
							} else {//gridID=="GTDataGrid2_Area"
								setupFilter2();
							}
							$(".dx-datagrid-cancel-button").closest("div.dx-toolbar-button").remove();
	                    }
	             }
	        });
            var btnLastIndex=0;
            for(;btnLastIndex<toolbarItems.length; btnLastIndex++){
                if(toolbarItems[btnLastIndex].widget != "dxButton") {
                    break;
                }
            }
            if (authD=="Y") {
                toolbarItems.splice(btnLastIndex, 0, {
                    "locateInMenu" : "auto"
                   ,"location"     : "after"
                   ,"widget"       : "dxButton"
                   ,"name"         : "removeButton"
                   ,"showText"     : "always"
                   ,"options"      : {
                            "text"      : "${msgel.getMsg('AML_00_00_01_01_027','삭제')}"
                           ,"hint"      : 'remove'
                           ,"disabled"  : false
                           ,"onClick"   : gridID=="GTDataGrid1_Area"?doDelete1:doDelete2
                           ,"elementAttr": { class: "btn-28" }
                     }
                });
            }
            if (authC=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "saveButton") {
                        item.showText           = "always";
                        item.widget             = "dxButton";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_025','저장')}";
                        item.options.elementAttr= { class: "btn-28" };
                        item.options.icon		= "";
                        item.options.disabled   = false;
                        item.options.onClick    = function(){
                            if (gridID=="GTDataGrid1_Area") {
                                doSave1(cmpnt);
                            } else {
                                doSave2(cmpnt);
                            }
                        }
                    } else if (item.name === "addRowButton") {
                        item.showText           = "always";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_024','추가')}";
                        item.options.elementAttr= { class: "btn-28" };
                        item.options.icon		= "";
                        item.options.disabled   = false;
                        item.options.onClick    = function(){
                            if (gridID=="GTDataGrid1_Area") {
                                addRowGrid1(cmpnt);
                            } else {
                                addRowGrid2(cmpnt);
                            }
                        }
                    }
                });
            }
            if (authC=="Y"||authD=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "revertButton") {
                        item.showText           = "always";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_026','취소')}";
                        item.options.elementAttr= { class: "btn-28" };
                        item.options.icon		= "";
                        item.options.disabled   = false;
                        return;
                    }
                });
            }
        }
    }
    function enterSearch(){
        if (window.event.keyCode == 13) {

             doSearch();
        }
    }

	/**
	 * Search 그룹코드
	 */
	function doSearch(){
		if(!$("btn_01")){
			return;
		}
		GridObj1.cancelEditData();
		var obj 		= new Object();
	    var classID  = "RBA_90_01_06_01";
	    var methodID = "getSearchG"
	    var obj = new Object();
 		obj.pageID 			= "RBA_90_01_06_01";
		obj.classID 		= "RBA_90_01_06_01";
		obj.RPT_GJDT 		= form1.RPT_GJDT.value;
		obj.GRP_CD 			= form1.GRP_CD_N.value;
		obj.GRP_NM 			= form1.GRP_CD_N.value;

		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
	}

	function doSearch_end(dataSource, data){
		GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
		$("button[id='btn_01']").prop('disabled', false);
		curRow = -1;
        var row = dataSource.length;

        if(row > 0){
        	$.each(data.GRID_DATA,function(i,o){o.IDU="U";});
        	Grid1CellClick("GTDataGrid1", data.GRID_DATA[0],null, 0);
        }else{
//         	showAlert('${msgel.getMsg("RBA_90_01_04_01_120","조회결과가 없습니다.")}', "INFO");
			GridObj1.clearSelection();
			GridObj1.option('dataSource', []);
        }
        /*
		row = GridObj1.rowCount();
		if(row > 0){
			$.each(data.GRID_DATA,function(i,o){o.IDU="U";});
			obj = GridObj1.getRow(0);
			Grid1CellClick("GTDataGrid1", obj);
		}else{
			showAlert('${msgel.getMsg("RBA_90_01_04_01_120","조회결과가 없습니다.")}', "INFO");
			GridObj2.removeAll();
		}*/
	}

	/**
	 * Click 그룹코드영역
	 */
	function Grid1CellClick(id, obj, selectData, row, col,colId){
	   if (curRow!=row) {
			curRow  			  = row;
			addCD   			  = obj.GRP_CD;
        	addCDNM 			  = obj.GRP_NM;
			form1.GRP_CD_1.value  = obj.GRP_CD;
			form1.GRP_CD.value 	  = obj.GRP_CD;
			form1.GRP_NM.value 	  = obj.GRP_NM;
			form1.BIGO_CTNT.value = obj.BIGO_CTNT;

			if (obj.UPD_YN == "1") {
				form1.UPD_YN.value = "Y";
			}

			doSearch2();
		 }
	}

	function doSearch2(){
		if(GridObj2==null) {
			return;
		}
		GridObj2.cancelEditData();
		GridObj2.clearSelection();
		GridObj2.option('dataSource', []);
		var methodID	= "getSearchD";
		var classID		= "RBA_90_01_06_01";
	    var obj 		= new Object();
	    obj.pageID 		= "RBA_90_01_06_01";
	    obj.classID 	= "RBA_90_01_06_01";
	    obj.methodID	= "getSearchD";
	    obj.RPT_GJDT 	= form1.RPT_GJDT.value;
	    obj.GRP_CD 		= form1.GRP_CD_1.value;

		sendService(classID, methodID, obj, doSearch2_end, doSearch2_end);
	}

	function doSearch2_end(dataSource, data){
		GridObj2.refresh();
	    GridObj2.option("dataSource", dataSource);
   	  if (data&&data.GRID_DATA) $.each(data.GRID_DATA,function(i,o){o.ROW_NUM=i;o.IDU="U";});
   }


	/**
	 *  그룹코드 저장
	 */
	function doSave1(gi){
    	gi.saveEditData();

		var rowsData = GridObj1.getSelectedRowsData();
		if(rowsData.length==0){
			showAlert("${msgel.getMsg('AML_10_01_01_01_003','저장 할 데이타를 선택하십시오.')}","WARN");
			return;
		}

		var allRowsData = getDataSource(GridObj1);
        var keyArr = new Array();
        for (var i=0;i<allRowsData.length; i++) {
            keyArr.push(allRowsData[i].GRP_CD);
        }

        for (var i=0; i<rowsData.length; i++) {
            var obj = rowsData[i];
            if (obj.GRP_CD=="") {
            	showAlert("${msgel.getMsg('AML_10_01_01_01_024','그룹코드를 입력하십시오.')}","WARN");
                return false;
            }
            if (obj.GRP_NM=="") {
            	showAlert("${msgel.getMsg('AML_10_01_01_01_024','그룹코드명을 입력하십시오.')}","WARN");
                return false;
            }
            if (obj.BIGO_CTNT=="") {
            	showAlert("${msgel.getMsg('AML_10_01_01_01_025','코드설명을 입력하십시오.')}","WARN");
                return false;
            }
            var firstIndex = jQuery.inArray(obj.GRP_CD, keyArr);
            if(obj.IDU=="U" || obj.IDU=="I") firstIndex++;
            if(jQuery.inArray(obj.GRP_CD, keyArr, firstIndex)>-1){
                showAlert("${msgel.getMsg('AML_10_01_01_01_017','동일한 코드가 있어 저장할수 없습니다.')}","WARN");
                return false;
            }
        }

		showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "${msgel.getMsg('RBA_90_01_05_01_108','저장')}", doSave1_Action);
	}

	function doSave1_Action(){
		var rowsData = GridObj1.getSelectedRowsData();
		var classID		= "RBA_90_01_06_01";
		var methodID	= "doSaveG";
		var obj 		= new Object();
	    obj.pageID 		= "RBA_90_01_06_01";
	    obj.classID 	= "RBA_90_01_06_01";
	    obj.methodID 	= "doSaveG";
	    obj.RPT_GJDT 	= AML("RPT_GJDT").value;
	    obj.gridData	= rowsData;
	    sendService(classID, methodID, obj, doSave1_end, doSave1_end);
	}

	function doSave1_end(){
		doSearch();
	}

	/**
	 *  그룹코드 삭제
	 */
	function doDelete1() {

		var selectedRows = GridObj1.getSelectedRowsData();
		var size         = selectedRows.length;
/*
		if (GridObj2.rowCount() > 0) {
			showAlert('상세코드정보가 존재하여 삭제할 수 없습니다.',"WARN");
			return;
		}
*/
		if(size <= 0){
			showAlert("${msgel.getMsg('AML_10_01_01_01_006','삭제할 데이타를 선택하십시오.')}","WARN");
			return;
		}

		showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "${msgel.getMsg('RBA_90_01_04_01_107','삭제')}", doDelete1_Action);
	}

	function doDelete1_Action(){
		var selectedRows = GridObj1.getSelectedRowsData();
		var classID		 = "RBA_90_01_06_01";
		var methodID 	 = "doDeleteG";
		var obj 		 = new Object();

	    obj.pageID 		 = pageID;
	    obj.classID 	 = classID;
	    obj.methodID 	 = methodID;
	    obj.RPT_GJDT 	 = form1.RPT_GJDT.value;
	    obj.GRP_CD 		 = selectedRows.GRP_CD;
	    obj.gridData	 = selectedRows;

	    sendService(classID, methodID, obj, doSave1_end, doSave1_end);
	}

	/**
	 *  상세코드 저장
	 */
	function doSave2(gi){
    	gi.saveEditData();

		var rowsData = GridObj2.getSelectedRowsData();
		if(rowsData.length==0){
			showAlert("${msgel.getMsg('AML_10_01_01_01_003','저장 할 데이타를 선택하십시오.')}","WARN");
			return;
		}

		var allRowsData = getDataSource(GridObj2);
        var keyArr = new Array();
        for (var i=0;i<allRowsData.length; i++) {
            keyArr.push(allRowsData[i].DTL_CD);
        }

        for (var i=0; i<rowsData.length; i++) {
            var obj = rowsData[i];
            if (obj.DTL_CD=="") {
            	showAlert("${msgel.getMsg('RBA_10_09_01_01_003','상세코드를 입력하십시오.')}","WARN");
                return false;
            }
            if (obj.DTL_NM=="") {
            	showAlert("${msgel.getMsg('RBA_10_09_01_01_004','상세코드명을 입력하십시오.')}","WARN");
                return false;
            }
            var firstIndex = jQuery.inArray(obj.DTL_CD, keyArr);
            if(obj.IDU=="U" || obj.IDU=="I") firstIndex++;
            if(jQuery.inArray(obj.DTL_CD, keyArr, firstIndex)>-1){
                showAlert("${msgel.getMsg('AML_10_01_01_01_017','동일한 코드가 있어 저장할수 없습니다.')}","WARN");
                return false;
            }
        }
		showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "${msgel.getMsg('RBA_90_01_05_01_108','저장')}", doSave2_Action);
	}

	function doSave2_Action(){
		var rowsData = GridObj2.getSelectedRowsData();
		var classID 	= "RBA_90_01_06_01";
		var methodID 	= "doSaveD";
		var obj 		= new Object();
	    obj.pageID 		= "RBA_90_01_06_01";
	    obj.classID 	= "RBA_90_01_06_01";
	    obj.methodID 	= "doSaveD";
	    obj.RPT_GJDT 	= AML("RPT_GJDT").value;
	    obj.gridData 	= rowsData;
	    sendService(classID, methodID, obj, doSave2_end, doSave2_end);
	}

	function doSave2_end(){
		doSearch2();
	}

	/**
	 *  상세코드 삭제
	 */
	function doDelete2() {

		var classID 	= "RBA_90_01_06_01";
		var methodID 	= "doDeleteD";
    	var selectedRows = GridObj2.getSelectedRowsData();
		var size         = selectedRows.length;

		if(size <= 0){
			showAlert("${msgel.getMsg('AML_10_01_01_01_006','삭제할 데이타를 선택하십시오.')}","WARN");
			return;
		}

		showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "${msgel.getMsg('RBA_90_01_04_01_107','삭제')}", doDelete2_Action);

	}

	function doDelete2_Action(){
		var obj = new Object();
		var classID 	= "RBA_90_01_06_01";
		var methodID 	= "doDeleteD";
    	var selectedRows = GridObj2.getSelectedRowsData();
		obj.pageID 		 = pageID;
	    obj.classID 	 = classID;
	    obj.methodID 	 = methodID;
	    obj.RPT_GJDT 	 = form1.RPT_GJDT.value;
		obj.GRP_CD 		 = selectedRows.GRP_CD;
		obj.DTL_CD 		 = selectedRows.DTL_CD;
		obj.gridData	 = selectedRows;
		sendService(classID, methodID, obj, doSave2_end, doSave2_end);
	}

    /** Grid1 행 추가 */
    function addRowGrid1(cmpnt){
    	try {
    		GridObj2.cancelEditData();
            GridObj2.clearSelection();
            GridObj2.option('dataSource', []);
	        cmpnt.addRow();
	        cmpnt.saveEditData();
	        cmpnt.columnOption('GRP_CD', 'sortOrder', 'asc');
	        setTimeout(function(){cmpnt.selectRowsByIndexes([0]);cmpnt.editCell(0,1);},100);
    	} catch (e) {
            showAlert(e,"ERR");
        }
    }

    /** Grid2 행 추가 */
    function addRowGrid2(e)
    {
        var rowsData = GridObj1.getSelectedRowsData();
        if(rowsData.length==0){
        	showAlert("${msgel.getMsg('RBA_04_01_05_01_001','그룹코드를 선택하십시오.')}", "WARN");
        	overlay.hide();
            return;
        }
        if (curRow>-1) {

			var data = getDataSource(GridObj1)[curRow];
            if (data.GRP_C=="") {
                // 선택 된 Code Head 가 아직 생성중임
                showAlert("${msgel.getMsg('RBA_04_01_05_01_002','그룹코드를 저장한 후에 추가하십시오.')}", "WARN");
            } else {
                var selkeys = $('#GTDataGrid1_Area').dxDataGrid('instance').getSelectedRowKeys();
                if (selkeys && selkeys.length > 0) {
                    var gobj; gobj = $('#GTDataGrid2_Area').dxDataGrid('instance');
                    gobj.addRow();
                    gobj.saveEditData();

                   	gobj.columnOption('DTL_C', 'sortOrder', 'asc');
                    setTimeout(function(){gobj.selectRowsByIndexes([0]);gobj.editCell(0,2);},100);
//                     }
                } else {
                    // 선택 된 Code Head 없음
                	showAlert("${msgel.getMsg('RBA_04_01_05_01_001','그룹코드를 선택하십시오.')}", "WARN");
                }
            }
        } else {
            // 선택 된 Code Head 없음
        	showAlert("${msgel.getMsg('RBA_04_01_05_01_001','그룹코드를 선택하십시오.')}", "WARN");
        }
        $(".dx-button-text").css("display","inline-block").css("margin-left","3px");
        overlay.hide();
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

</style>
<form name="form1" method="post" onsubmit="return false">
<input type="hidden" name="pageID">
<input type="hidden" name="GRP_CD_1" >
<input type="hidden" name="IDU" >
<input type="hidden" name="GRP_CD"      id="GRP_CD"         value=""    />   	<!-- GRP_CD   -->
<input type="hidden" name="GRP_NM"      id="GRP_NM"       	value=""    />  	<!-- GRP_NM   -->
<input type="hidden" name="UPD_YN"      id="UPD_YN"       	value=""    />  	<!-- 수정가능 -->
<input type="hidden" name="BIGO_CTNT"   id="BIGO_CTNT"      value=""    />  	<!-- 코드설명 -->

	<div class="inquiry-table type1" id="condBox1">
    	<div class="table-row" style="width:25%;">
     		<div class="table-cell">
     			${condel.getLabel('RBA_90_01_01_02_001','보고기준일')}
				${RBACondEL.getRBASelect('RPT_GJDT','' ,'RBA_getRPT_GJDT' ,'' ,'' ,'' ,'doSearch()')}
     		</div>
     	</div>
    	<div class="table-row" style="width:75%;">
     		<div class="table-cell">
				${condel.getLabel('RBA_90_01_06_01_001','KoFIU 보고 그룹코드/명')}
				<div class="content" id="sptitle">
                <input type="text" id="GRP_CD_N" name="GRP_CD_N" value="" class="cond-input-text" onkeyup="enterSearch();">
                </div>
     		</div>
     	</div>
	</div>
	<div class="button-area">
     	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
	</div>
<div class="tab-content-bottom" style="margin-top: 8px;">
	<div class="inner-top">
	        <div id="GTDataGrid1_Area"></div>
	</div>
	<div class="inner-bottom" style="margin-top: 8px;">
	        <div id="GTDataGrid2_Area"></div>
 	</div>
 </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />