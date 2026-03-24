<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_99_03_01_01.jsp
- Author     : mjh
- Comment    : 자격 보유 현황 관리
- Version    : 1.0
- history    : 1.0 2025-04-29
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ page import="java.text.DateFormat"  %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file.x");
	request.setAttribute("uploadFile",uploadFile);
	
	
	//현 시점 기준 지표 점수에 포함되는 자격취득(전반기말 이전) or 교육이수 날짜 계산(전반기말 기준 1년)
	String toDay = DateUtil.getShortDateString();
	
	Calendar today = Calendar.getInstance();
    Calendar lastHalfYearEnd = Calendar.getInstance();
    
    if (today.get(Calendar.MONTH) < 6) {
        lastHalfYearEnd.set(today.get(Calendar.YEAR) - 1, Calendar.DECEMBER, 31);
    } else {
        lastHalfYearEnd.set(today.get(Calendar.YEAR), Calendar.JUNE, 30);
    }
    
    Calendar startDate = (Calendar) lastHalfYearEnd.clone();
    startDate.add(Calendar.YEAR, -1);
    
    DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
    String preStartDateStr = DateUtil.addDays(dateFormat.format(startDate.getTime()), 1, "yyyyMMdd");
    String preEndDateStr = dateFormat.format(lastHalfYearEnd.getTime());
	
	request.setAttribute("toDay", toDay);
	request.setAttribute("preStartDateStr", preStartDateStr);
	request.setAttribute("preEndDateStr",preEndDateStr);
	
%>
<script language="JavaScript">
	var overlay = new Overlay();  
    var GridObj1 = null;
    var pageID = "RBA_99_03_01_01";
    var classID = "RBA_99_03_01_01";
    var preStartDateStr = "${preStartDateStr}";
    var preEndDateStr = "${preEndDateStr}";

	$(document).ready(function(){
		setDxDateVal("standardDate", "${toDay}")
		setupGrids();
		setupFilter("init");
		doSearch();
	});
	
   	function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";    	
    	gridArrs[0] = gridObj;
    	setupGridFilter2(gridArrs,FLAG);	
    }
	function setupGrids()
	{
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 "gridId"          : "GTDataGrid1"
       	   ,"height" : "calc(90vh - 210px)"
		 ,elementAttr: { class: "grid-table-type" } 
       	,"hoverStateEnabled"    : true
        ,"wordWrapEnabled"      : false
        ,"allowColumnResizing"  : true
        ,"columnAutoWidth"      : true
        ,"allowColumnReordering": true
        ,"cacheEnabled"         : false
        ,"cellHintEnabled"      : true
        ,"showBorders"          : true
        ,"showColumnLines"      : true
        ,"showRowLines"         : true
        ,"loadPanel" : { enabled: false }
        ,"sorting"           : {"mode": "single"}
        ,"remoteOperations"  : {
             "filtering" : false
            ,"grouping"  : false
            ,"paging"    : false
            ,"sorting"   : false
            ,"summary"   : false
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
        }
        ,"editing" : {
             "mode"          : "batch"
			       ,allowUpdating   : true
			       ,allowAdding     : true
         }
        ,"filterRow"             : {"visible": false}
        ,"rowAlternationEnabled" : true
        ,"columnFixing"          : {"enabled": true}
        ,"selection"         : {
             "allowSelectAll"    : true
            ,"deferred"          : false
            ,"mode"              : "multiple"
            ,"selectAllMode"     : "page"
            ,"showCheckBoxesMode": "always"
         }
        ,"scrolling"   : {
             mode            : "standard"
            ,preloadEnabled  : false
         }
        ,"columns" : [
             {
                 "dataField"     : "SEQ"
                ,"dataType"      : "number"
                ,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_107","순번")}'
                ,"alignment"     : "center"
                ,"allowResizing" : true
                ,"allowSearch"   : true
                ,"allowSorting"  : true
                ,"allowEditing"  : false
             },{
                 "dataField"     : "JKW_NM"
                ,"dataType"      : "string"
                ,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_108","성명")}'
                ,"alignment"     : "center"
                ,"allowResizing" : true
                ,"allowSearch"   : true
                ,"allowSorting"  : true
                ,"allowEditing"  : false
             },{
                 "dataField"     : "JKW_NO"
                ,"dataType"      : "string"
                ,"caption"       : 'JKW_NO'
                ,"alignment"     : "center"
                ,"allowResizing" : true
                ,"allowSearch"   : true
                ,"allowSorting"  : true
                ,"allowEditing"  : false
                ,"visible"		 : false
             },{	
                 "dataField"     : "DPRT_NM"
                ,"dataType"      : "string"
                ,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_109","부서")}'
                ,"alignment"     : "center"
                ,"allowResizing" : true
                ,"allowSearch"   : true
                ,"allowSorting"  : true
                ,"allowEditing"  : false
             },{
				"dataField"     : "QUAL_ACQ_DT"
                ,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_110","자격 취득 일자")}'
                ,"columns"      : [
                	{
			            dataField    : "CAMS"
						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_114","CAMS")}'
						,"width"         : 250
						,"alignment"     : "center"
						,"allowResizing" : true
						,"allowSearch"   : true
						,"allowSorting"  : true
						,"allowEditing"  : false
						,cellTemplate: function(cellElement,cellInfo){
							cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
							if(cellInfo.value != "" && cellInfo.value != "-"){
								if(cellInfo.value > preEndDateStr){
									cellElement.css("color","red");
								}
							}
						}
					}, {
			            dataField    : "KCAMS"
						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_111","KCAMS")}'
						,"width"         : 250
						,"alignment"     : "center"
						,"allowResizing" : true
						,"allowSearch"   : true
						,"allowSorting"  : true
						,"allowEditing"  : false
						,cellTemplate: function(cellElement,cellInfo){
							cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
							if(cellInfo.value != "" && cellInfo.value != "-"){
								if(cellInfo.value > preEndDateStr){
									cellElement.css("color","red");
								}
							}
						}
					}, {
						dataField    : "TPAC1"
						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_123","TPAC(1+,1) 등급")}'
						,"width"         : 250
						,"alignment"     : "center"
						,"allowResizing" : true
						,"allowSearch"   : true
						,"allowSorting"  : true
						,"allowEditing"  : false
						,cellTemplate: function(cellElement,cellInfo){
							cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
							if(cellInfo.value != "" && cellInfo.value != "-"){
								if(cellInfo.value > preEndDateStr){
									cellElement.css("color","red");
								}
							}
						}
					}, {
						dataField    : "TPAC2"
						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_124","TPAC(2,3) 등급")}'
						,"width"         : 250
						,"alignment"     : "center"
						,"allowResizing" : true
						,"allowSearch"   : true
						,"allowSorting"  : true
						,"allowEditing"  : false
						,cellTemplate: function(cellElement,cellInfo){
							cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
							if(cellInfo.value != "" && cellInfo.value != "-"){
								if(cellInfo.value > preEndDateStr){
									cellElement.css("color","red");
								}
							}
						}
					}, {
			            dataField    : "ANTI_LANDER_AG_PRO"
						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_112","자금세탁방지 핵심요원(전문)")}'
						,"width"         : 250
						,"alignment"     : "center"
						,"allowResizing" : true
						,"allowSearch"   : true
						,"allowSorting"  : true
						,"allowEditing"  : false
						,cellTemplate: function(cellElement,cellInfo){
							cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
							if(cellInfo.value != "" && cellInfo.value != "-"){
								if(cellInfo.value > preEndDateStr){
									cellElement.css("color","red");
								}
							}
						}
					}, {
			            dataField    : "ANTI_LANDER_AG_FU"
						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_113","자금세탁방지 핵심요원(기초)")}'
						,"width"         : 250
						,"alignment"     : "center"
						,"allowResizing" : true
						,"allowSearch"   : true
						,"allowSorting"  : true
						,"allowEditing"  : false
						,cellTemplate: function(cellElement,cellInfo){
							cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
							if(cellInfo.value != "" && cellInfo.value != "-"){
								if(cellInfo.value > preEndDateStr){
									cellElement.css("color","red");
								}
							}
						}
					}, {
			            dataField    : "BRAN_COMP_OFFI"
						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_115","영업점 컴플라이언스 오피서")}'
						,"width"         : 250
						,"alignment"     : "center"
						,"allowResizing" : true
						,"allowSearch"   : true
						,"allowSorting"  : true
						,"allowEditing"  : false
						,cellTemplate: function(cellElement,cellInfo){
							cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
							if(cellInfo.value != "" && cellInfo.value != "-"){
								if(cellInfo.value > preEndDateStr){
									cellElement.css("color","red");
								}
							}
						}
					}					
				]    
             },
             {
                 "dataField"     : "APL_PNT"
                ,"dataType"      : "number"
                ,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_116","인정 점수")}'
                ,"alignment"     : "center"
                ,"allowResizing" : true
                ,"allowSearch"   : true
                ,"allowSorting"  : true
                ,"allowEditing"  : false
             },
             {
 				"dataField"     : "EDU_COMP_DT"
                 ,"caption"       : '전문 교육 이수 일자'
                 ,"columns"      : [
	                	 {
	 			            dataField    : "SKK_UNI_FIN_LEAD"
	 						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_120","성균관대학교 금융지도자(AML전문가)과정")}'
	 						,"width"         : 250
	 						,"alignment"     : "center"
	 						,"allowResizing" : true
	 						,"allowSearch"   : true
	 						,"allowSorting"  : true
	 						,"allowEditing"  : false
							,cellTemplate: function(cellElement,cellInfo){
								cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
								if(cellInfo.value != "" && cellInfo.value != "-"){
									if(cellInfo.value > preEndDateStr || cellInfo.value < preStartDateStr){
										cellElement.css("color","red");
									}
								}
							}
	 					},
	 					{
	 			            dataField    : "E_MK_ANTI_LANDER_COURSE"
	 						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_121","이화-매경 자금세탁방지전문가 과정")}'
	 						,"width"         : 250
	 						,"alignment"     : "center"
	 						,"allowResizing" : true
	 						,"allowSearch"   : true
	 						,"allowSorting"  : true
	 						,"allowEditing"  : false
	 						,cellTemplate: function(cellElement,cellInfo){
								cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
								if(cellInfo.value != "" && cellInfo.value != "-"){
									if(cellInfo.value > preEndDateStr || cellInfo.value < preStartDateStr){
										cellElement.css("color","red");
									}
								}
							}
	 					},
	 					{
	 			            dataField    : "DK_UNI_MASTER_COURSE"
	 						,"caption"       : '${msgel.getMsg("RBA_90_03_01_01_122","동국대학교 석사과정-금융정보조사전공")}'
	 						,"width"         : 250
	 						,"alignment"     : "center"
	 						,"allowResizing" : true
	 						,"allowSearch"   : true
	 						,"allowSorting"  : true
	 						,"allowEditing"  : false
	 						,cellTemplate: function(cellElement,cellInfo){
								cellElement.text(displayGTDataGridDate_GTONE(cellInfo.text,"DATE"));
								if(cellInfo.value != "" && cellInfo.value != "-"){
									if(cellInfo.value > preEndDateStr || cellInfo.value < preStartDateStr){
										cellElement.css("color","red");
									}
								}
							}
	 					}
                	 ]
             }
         ],
        export:
        {
            allowExportSelectedData : true,
            enabled                 : true,
            excelFilterEnabled      : true
        },
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
        }
        ,"onEditorPreparing": function(e) {
        	 if (e.parentType === "dataRow") {
        		 
        		 e.editorOptions.onFocusOut = function(args) {
        			var rowData = e.row.data;
     				var score = 0.0 ;
     				if ("-" != rowData.TPAC1 && "" != rowData.TPAC1 && rowData.TPAC1 < preEndDateStr) {
   						score = 4.0 ;	
     				} else if ("-" != rowData.TPAC2 && "" != rowData.TPAC2 && rowData.TPAC2 < preEndDateStr) {
   						score = 3.0 ;
     				} else if ("-" != rowData.CAMS && "" != rowData.CAMS && rowData.CAMS < preEndDateStr) {
   						score = 3.0 ;
     				} else if ("-" != rowData.KCAMS && "" != rowData.KCAMS && rowData.KCAMS < preEndDateStr) {
   						score = 3.0 ;
     				} else if ("-" != rowData.ANTI_LANDER_AG_PRO && "" != rowData.ANTI_LANDER_AG_PRO && rowData.ANTI_LANDER_AG_PRO < preEndDateStr) {
   						score = 2.5 ;
     				} else if ("-" != rowData.ANTI_LANDER_AG_FU && "" != rowData.ANTI_LANDER_AG_FU && rowData.ANTI_LANDER_AG_FU < preEndDateStr) {
   						score = 2.0 ;
     				} else if ("-" != rowData.BRAN_COMP_OFFI && "" != rowData.BRAN_COMP_OFFI && rowData.BRAN_COMP_OFFI < preEndDateStr) {
   						score = 1.0 ;
     				} else {
     					score = 0.0 ;
     				}
					var rowIndex = e.row.rowIndex;
					var columnIndex = e.component.columnOption("APL_PNT").index-1;
					
					e.component.cellValue(rowIndex, columnIndex, score);
					e.component.refresh();
        		 }
        	 }        	 
         }
        ,"onToolbarPreparing": makeToolbarButtonGrids
        ,"onRowInserting" : function(e) {
             e.data.SEQ  = e.component.totalCount() + 1;
             e.data.IDU      = "I";             
         }
        ,"onCellClick" : function(e) {
	         if (e.component.isRowSelected(e.key) && (e.column.dataField != "SEQ" && e.column.dataField != "APL_PNT")) {
	             e.component.editCell(e.rowIndex,e.columnIndex);
	         }
	     }
	 }).dxDataGrid("instance");
    }
	
	function doSearch() {
		
		overlay.show(true, true);
		
		GridObj1.cancelEditData();
		GridObj1.clearSelection();
		GridObj1.option('dataSource', []);
		
		calcDate();
		
		var params = new Object();
		var methodID = "doSearch";
		
		params.pageID =pageID;
		
		params.QUA_NAME = $("#QUA_NAME","form[name=form1]").val();	//이름
		params.branchCode = $("input[name=branchCode]","form[name=form1]").val();
		params.CERT_CCD = $("#CERT_CCD","form[name=form1]").val();	//자격
		
		sendService(classID, methodID, params, doSearch_success, doSearch_fail);
	}
	
	/*Search Success CallBack*/	
    function doSearch_success(gridData, data)
    {
        GridObj1.refresh().done(function() {
        	calcScore(gridData);
        });
        
        overlay.hide();
    }
    /*Search Fail CallBack*/
	function doSearch_fail(){
		overlay.hide();
	}
    
    function calcDate(){
    	
    	var standardDate = new Date(getDateFormat($("#standardDate input")[0].value.replaceAll("-",""), '-'));
    	
    	var month = standardDate.getMonth();
    	if(month < 6) {
    		var year = standardDate.getFullYear() - 1;
    		var date = "1231";
    	} else {
    		var year = standardDate.getFullYear();
    		var date = "0630";
    	}
    	
    	var preStartDate = new Date(getDateFormat(year + date, '-'));
    	preStartDate.setFullYear(preStartDate.getFullYear() - 1);
    	preStartDate.setDate(preStartDate.getDate() + 1);
    	
    	preEndDateStr = year + date;
    	preStartDateStr = preStartDate.getFullYear().toString() + (preStartDate.getMonth() + 1).toString().padStart(2,'0') + preStartDate.getDate().toString().padStart(2,'0');
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
            toolbarItems.splice(0, 0, {
                "locateInMenu"  : "auto"
                ,"location"     : "after"
                ,"widget"       : "dxButton"
                ,"name"         : "refreshButton"
                ,"showText"     : "inMenu"
                ,"options"      : {
                         "icon"      : "pulldown"   
                        ,"hint"      : '새로고침'
                        ,"disabled"  : false
                        ,"onClick"   : function(){
                        	doSearch();
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
                	   		"elementAttr": { class: "btn-28" }
//                             "icon"      : "remove"  
                           ,"text"      : "${msgel.getMsg('AML_00_00_01_01_071','행삭제')}"
                           ,"hint"      : '행을 삭제'
                           ,"disabled"  : false
                           ,"onClick"   : function(){
                        	   doDelete1();
                           }
                     }
                });
            }
            if (authC=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "saveButton") {
                        item.options.elementAttr = { class: "btn-28" };
                        item.locateInMenu		= "auto";
                        item.location			= "after";
                        item.showText           = "always";
                        item.widget             = "dxButton";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_025','저장')}";
                        item.options.icon		= "";
                        item.options.disabled   = false;
                        item.visible   = false;
                        item.options.onClick    = function(){
                   //     	doSave(cmpnt);
                        }
                    } else if (item.name === "addRowButton") {
                        item.showText           = "always";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_070','행추가')}";
                        item.options.icon		= "";
                        item.options.disabled   = false;
                        item.options.onClick    = function(){
                        	searchPerson();
                        	addRowGrid1(cmpnt);                        	
                        }
                        item.options.elementAttr = { class: "btn-28" };
                    }
                });
            }
            if (authC=="Y"||authD=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "revertButton") {
                        item.showText           = "always";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_026','취소')}";
                        item.options.elementAttr = { class: "btn-28" };
                        item.options.icon		= "";
                        item.options.disabled   = false;
                        item.visible   = false;
                        return;
                    }
                });
            }
        }
        
    }
    
    function enterKeyPress() {
        if(event.keyCode == 13) {
        	doSearch();
        }
    }
    
    function addRowGrid1(cmpnt){
		 try {            
			  cmpnt.addRow();
			  cmpnt.saveEditData();
			  cmpnt.columnOption('SEQ', 'sortOrder', 'desc'); //  CAMS
             setTimeout(function(){            	  
           	  cmpnt.selectRowsByIndexes([0]);
           	  cmpnt.editCell(0,2);            	  
              },200);
        } catch (e) {
            showAlert(e, "ERR");
        } finally {
            overlay.hide();
        }
   }
    
    function searchPerson(){
    	window_popup_open("search_popup_chrg_p_nm", 500, 620, '','No');
        form1.pageID.value = "search_popup_chrg_p_nm";
        form1.target       = form1.pageID.value;
        form1.action       = '<c:url value="/"/>0001.do';
        form1.submit();        
    }
    
    function infoPerson(deptitle, chrgPNm, chrgPId){
    	var allRowsData = GridObj1.getDataSource().items();
    	
    	for(var i = 0; i < allRowsData.length; i++){
    		if(allRowsData[i].JKW_NO == chrgPId){
    			showAlert("${msgel.getMsg('RBA_90_03_01_01_126','선택한 직원의 데이터가 존재합니다.')}", "WARN");
    			doSearch();
                return;
    		}
    	}
        GridObj1.getSelectedRowsData()[0].DPRT_NM = deptitle;
        GridObj1.getSelectedRowsData()[0].JKW_NO = chrgPId;
        GridObj1.getSelectedRowsData()[0].JKW_NM = chrgPNm;
        GridObj1.getSelectedRowsData()[0].APL_PNT = 0;
        GridObj1.refresh();
    }
    
    function doDelete1() {
        var selectedRows = GridObj1.getSelectedRowsData();
        var size         = selectedRows.length;

        if(size <= 0){
        	showAlert("${msgel.getMsg('AML_10_01_01_01_006','삭제할 데이타를 선택하십시오.')}", "WARN");
            return;
        }

        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}","${msgel.getMsg('AML_20_03_01_01_006','삭제')}", function(){
	        var methodID 	    = "doDelete";
	        var params            = new Object();
	        params.pageID         = pageID;
	        params.gridData = selectedRows;
	        
	        sendService(classID, methodID, params, doSearch, doSearch);
            
        });   

    }
    
  //템플릿 다운로드
    function downloadFile()
    {   
    	gtTemplateDownloadFile("form3","CERTTemplateFile.xlsx","CERTTemplateFile.xlsx","TEMPLATE","/");
    }
  
  //파일업로드
    function certFileUpload() {
    	var allowedFileExtensions = "${uploadFile}";
    	var fileUploader = gtFileUploader("certFile", allowedFileExtensions, doSubmit_end);
    }
    
    function doSubmit_end(fileData){    	
    	overlay.show(true, true);
        var captionList = new Array();
        var gridOrg; gridOrg = $('#GTDataGrid1_Area').dxDataGrid('instance');
        
        for (var i=0; i < gridOrg.columnCount(); i++){
            var input = new Object();
            input.dataField = gridOrg.columnOption(i).dataField;
            input.caption   = gridOrg.columnOption(i).caption;            
            captionList.push(input);
        }
       
        var fileValue = fileData.storedFileNm;   

        var params = new Object();
        params.captionName = JSON.stringify(captionList);
        params.fileName = fileValue;
        params.actionName = "com.gtone.aml.server.AML_10.AML_10_22.AML_10_22_01.AML_10_22_01_04";
        sendService(null, null, params, calcScore, calcScore);
    }
    
    function calcScore(data){
        overlay.hide();
        
        var dataSource = [];
        
        for (item in data) {    
        	var rowData = data[item];	
			var score = 0.0 ;
			if ("-" != rowData.TPAC1 && "" != rowData.TPAC1 && rowData.TPAC1 < preEndDateStr) {
				score = 4.0 ;	
			} else if ("-" != rowData.TPAC2 && "" != rowData.TPAC2 && rowData.TPAC2 < preEndDateStr) {
				score = 3.0 ;
			} else if ("-" != rowData.CAMS && "" != rowData.CAMS && rowData.CAMS < preEndDateStr) {
				score = 3.0 ;
			} else if ("-" != rowData.KCAMS && "" != rowData.KCAMS && rowData.KCAMS < preEndDateStr) {
				score = 3.0 ;
			} else if ("-" != rowData.ANTI_LANDER_AG_PRO && "" != rowData.ANTI_LANDER_AG_PRO && rowData.ANTI_LANDER_AG_PRO < preEndDateStr) {
				score = 2.5 ;
			} else if ("-" != rowData.ANTI_LANDER_AG_FU && "" != rowData.ANTI_LANDER_AG_FU && rowData.ANTI_LANDER_AG_FU < preEndDateStr) {
				score = 2.0 ;
			} else if ("-" != rowData.BRAN_COMP_OFFI && "" != rowData.BRAN_COMP_OFFI && rowData.BRAN_COMP_OFFI < preEndDateStr) {
				score = 1.0 ;
			} else {
				score = 0.0 ;
			}
			
			rowData.APL_PNT = score ;
        	datsSource = dataSource.push(rowData);
        }
        GridObj1.refresh();
    	GridObj1.option("dataSource", dataSource);
    }
    
	function doSave() {
		var grid1    = $('#GTDataGrid1_Area').dxDataGrid('instance');
		grid1.saveEditData();
     	     
		if (GridObj1.getDataSource() == null) {
			showAlert('${msgel.getMsg("AML_10_22_00_01_007","저장할 내역이 없습니다.")}','WARN');
			return;
		}
		
		var allGridData = getDataSource(GridObj1);
		var allSize = allGridData.length;
		
		for(var i = 0; i < allSize; i++) {
			if(allGridData[i].JKW_NM == "" || allGridData[i].JKW_NM == null){
				showAlert("${msgel.getMsg('RBA_99_03_01_01_001','이름을 입력하십시오.')}", "WARN");
				return false;
			}
			if(allGridData[i].DPRT_NM == "" || allGridData[i].DPRT_NM == null){
				showAlert("${msgel.getMsg('RBA_99_03_01_01_002','부서를 입력하십시오.')}", "WARN");
				return false;
			}
		}
		
		showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}","${msgel.getMsg('AML_20_01_01_20_012','저장')}", function(){
			overlay.show(true, true);
			
			var obj      = new Object();
			obj.pageID   = "RBA_99_03_01_01";
			obj.classID  = "RBA_99_03_01_01";
			obj.methodID = "doSave";
			
			var gridData; gridData = GridObj1.getDataSource().items();
			var maxcnt; maxcnt = 300;
			var savecnt; savecnt  = Math.ceil(gridData.length / maxcnt);
			var gridDataArr; gridDataArr = [];
			for ( var ii = 0; ii < savecnt; ii++) {
				gridDataArr[ii] = gridData.splice(0, gridData.length < maxcnt? gridData.length:maxcnt);
            }
			var i; i = 0;
			(window.doSaveCont = function() {
				obj['GRID_DATA'] = gridDataArr[i];
				jQuery.ajax({
					type        : 'POST'
                   ,url         : '/JSONServlet?Action@@@=com.gtone.aml.common.action.DispatcherAction'
                   ,dataType    : 'json'
                   ,processData : true
                   ,async       : true
                   ,data        : obj
                   ,success     : function(data) {
                       if(data&&data.PARAM_DATA[1].VALUE=="0001"){
                    	   showAlert(data.PARAM_DATA[0].VALUE,'ERR');
                           overlay.hide();
                           return;
                       }
                       if(++i==savecnt) {
                           doSave_end(data);
                       } 
                   }
                   ,error       : function(xhr, textStatus) {
                      showAlert("Error" + textStatus,'ERR');
                      overlay.hide();
                      return;
                   }
                })
            })();
		});
   }
    
    function doSave_end(data)
    {
        overlay.hide();
        if(data&&data.PARAM_DATA[2].VALUE=="00000"){
            showAlert(data.PARAM_DATA[0].VALUE,'INFO');
        }
        if(data&&data.PARAM_DATA[1].VALUE=="99999"){
            showAlert(data.PARAM_DATA[2].VALUE,'ERR');
        }

        doSearch();
    }

</script>

<form name="form3" id="form3">
  <input type="hidden" name="pageID">
  <input type="hidden" name="classID">
  <input type="hidden" name="methodID"> 
  <input type="hidden" name="FILE_SER">
  <input type="hidden" name="ATTCH_FILE_NO">
  <input type="hidden" name="downType" id="downType">   
  <input type="hidden" name="downFileName" id="downFileName">  
  <input type="hidden" name="orgFileName" id="orgFileName">    
  <input type="hidden" name="downFilePath" id="downFilePath">    
</form>

<form name="form1" method="post" onkeydown="enterKeyPress();">
    <input type="hidden" name="pageID"   id = "pageID"  >
    <input type="hidden" name="manualID"   id = "manualID"  >
    <input type="hidden" name="classID"  id = "classID" >
    <input type="hidden" name="methodID" id = "methodID">
<div class="inquiry-table type4">
	<div class="table-row">
		<div class="table-cell">
	            <div class="title">
	                <div class="txt">${msgel.getMsg('RBA_90_01_01_02_001','보고기준일자')}</div>
	            </div>
	            <div class="content">
					<div class='calendar'>
	                    ${condel.getInputDateDx('standardDate', standardDate)}
	                </div>
	            </div>
			</div>
	</div>
	<div class="table-row">
		<div class="table-cell">
			${condel.getBranchSearch('{msgID:"AML_00_00_01_01_013", defaultValue:"지점", name:"branchCode", firstComboWord:"ALL"}')}
       	</div>
	</div>
	<div class="table-row">
		<div class="table-cell">
			<div class="title">
				<div class="txt">
					${msgel.getMsg('RBA_90_03_01_01_104','이름')}
				</div>
			</div>
			<div class="content">
				<input type="text" id="QUA_NAME" name="QUA_NAME" size="20" maxlength="30">
			</div>
		</div>
	</div>
	<div class="table-row">
		<div class="table-cell">		
			${condel.getSelect('RBA_90_03_01_01_106','자격/전문교육','CERT_CCD','200','','A404','','ALL','ALL')}
		</div>		
	</div>	
</div>
	<div class="button-area">
	    ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
	    ${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
	    ${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"templateDownload", defaultValue:"템플릿다운로드", mode:"C", function:"downloadFile", cssClass:"btn-36 outlined"}')}
	    ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"uploadBtn", defaultValue:"파일 Upload", mode:"U", function:"certFileUpload", cssClass:"btn-36 upload"}')}
	</div>
	<div id="certFile" style="display:none;"> </div>
	<div id="GTDataGrid1_Area" style="padding-top:8px;"></div>
	<table class="basic-table" style="width:100%; margin-top:8px; margin-bottom:0px;">
		<tr>
			<td>
				※ ${msgel.getMsg('RBA_99_03_01_01_003','평가시 자격증은 1인 최고 인정점수 1건만(최대 4.0점) 인정 (관련지표 O.12.02.04)')}<br>
				※ ${msgel.getMsg('RBA_99_03_01_01_009','자격 점수 : TPAC(1+,1)등급-4.0점, CAMS/KCAMS/TPAC(2,3)등급-3.0점, 자금세탁방지 핵심요원-2.5점(전문)/2.0점(기초), 영업점 컴플라이언스 오피서-1.0점')}<br>
				※ ${msgel.getMsg('RBA_99_03_01_01_004','평가시 교육실적 유무에 따라 기관점수 2점 인정 (관련지표 O.12.02.05)')}<br>
				※ ${msgel.getMsg('RBA_99_03_01_01_005','그리드 편집/파일 업로드시 점수는 자동 입력됩니다.')}<br>
				※ ${msgel.getMsg('RBA_99_03_01_01_006','보고기준일자 시점의 지표상 인정되지 않는 자격 취득 일자 및 전문 교육 이수 일자는')} <p style="color:red;display:inline-block;font-weight:bold"><b>${msgel.getMsg('RBA_99_03_01_01_007','빨간색')}</b></p>${msgel.getMsg('RBA_99_03_01_01_008','으로 표기되며 점수 계산시 적용되지 않습니다.')}
			</td>
		</tr>
	</table>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />
</body>