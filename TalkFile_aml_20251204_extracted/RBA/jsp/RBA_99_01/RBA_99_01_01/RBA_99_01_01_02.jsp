<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_99_01_01_02.jsp
- Author     : 
- Comment    : 내부통제 교육/연수 정보 상세 관리
- Version    : 1.0
- history    : 1.0 2024-02-05
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ page import="com.gtone.rba.server.common.RBA_99.RBA_99_01.RBA_99_01_01.RBA_99_01_01_01"%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
	request.setAttribute("uploadFile",uploadFile);
	
  String uploadFileX = PropertyService.getInstance().getProperty("aml.config","upload.file.x");
  request.setAttribute("uploadFileX",uploadFileX);

	DataObj output = (DataObj)request.getAttribute("output");
	
	String EDU_ID      = StringHelper.evl(request.getParameter("EDU_ID"),"");
	String addGubun = StringHelper.evl(request.getParameter("addGubun"  ),"");
	String GYLJ_S_C = StringHelper.evl(request.getParameter("GYLJ_S_C"  ),"");
	
	
	// calnder
	String stDay = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
	String edDay = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
	String toDay    = jspeed.base.util.DateHelper.currentTime(PropertyService.getInstance().getProperty("aml.config","dateFormat"));	
	
	/*RBA_99_01_01_02 수정 화면 소스 추가*/
	String EDU_NM			="";
	String CRE_OGN_CCD		="";
	String OGN_NM			="";
	String EDU_CCD			="";
	String EDU_TGT_CCD		="";
	String EDU_POS			="";
	String EDU_STS_CD		="";
	String START_DT			="";
	String END_DT			="";
	String EDU_HH			="";
	String TCHR_NM			="";
	String TCHR_HIST		="";
	String EDU_OBJ_CTNT		="";
	String DR_DT			="";
	String ATTCH_FILE_NO	="";
	String EDU_STD_CNT		="";
	String EDU_ESTD_CNT		="";
	String ISDIREC			="";
	String ISMNG			="";
	String ISDEDIC			="";
	String ISAUDIT			="";
	String ISSALES			="";
	String ISNEWEMP			="";
	String ISNOMAL			="";
	String ISSELF			="";
	String ISPERSONAL		="";
	String TCHR_CERT_CCD	="";
	
	
	if (output != null) {
		EDU_NM			= output.getText("EDU_NM"); 
		CRE_OGN_CCD		= output.getText("CRE_OGN_CCD");
		OGN_NM			= output.getText("OGN_NM");
		EDU_CCD			= output.getText("EDU_CCD");
		EDU_TGT_CCD		= output.getText("EDU_TGT_CCD");
		EDU_POS			= output.getText("EDU_POS");
		EDU_STS_CD		= output.getText("EDU_STS_CD");
        START_DT		= DateUtil.dashDate(output.getText("EDU_START_DT"));
        END_DT			= DateUtil.dashDate(output.getText("EDU_END_DT"));          
        EDU_HH			= output.getText("EDU_HH"); 
        TCHR_NM			= output.getText("TCHR_NM");
        TCHR_HIST		= output.getText("TCHR_HIST");
        EDU_OBJ_CTNT	= output.getText("EDU_OBJ_CTNT"); 
        EDU_STD_CNT		= output.getText("EDU_STD_CNT"); 
        EDU_ESTD_CNT	= output.getText("EDU_ESTD_CNT"); 
        DR_DT			= output.getText("DR_DT");
        ATTCH_FILE_NO	= output.getText("ATTCH_FILE_NO");
        TCHR_CERT_CCD	= output.getText("TCHR_CERT_CCD");
    }
	
	if("Y".equals(CRE_OGN_CCD)){
		CRE_OGN_CCD = "1001";
		ISSELF ="Y";
	}
	
	
	request.setAttribute("EDU_ID", EDU_ID);
	request.setAttribute("stDay", stDay); 
	request.setAttribute("edDay", edDay);
	request.setAttribute("toDay", toDay);
	request.setAttribute("ADDGUBUN" ,addGubun);
	request.setAttribute("GYLJ_S_C" ,GYLJ_S_C);
	request.setAttribute("DR_DPRT_CD", sessionAML.getsAML_BDPT_CD());
	
	/*AML_90_01_01_04 수정 화면 소스 추가*/
    request.setAttribute("EDU_NM",EDU_NM);
    request.setAttribute("CRE_OGN_CCD",CRE_OGN_CCD);
    request.setAttribute("OGN_NM",OGN_NM);
    request.setAttribute("EDU_CCD",EDU_CCD);
    request.setAttribute("EDU_TGT_CCD",EDU_TGT_CCD);
    request.setAttribute("EDU_POS",EDU_POS);
    request.setAttribute("EDU_STS_CD",EDU_STS_CD);
    request.setAttribute("START_DT",START_DT);
    request.setAttribute("END_DT", END_DT);
    request.setAttribute("EDU_HH", EDU_HH);
    request.setAttribute("TCHR_NM",TCHR_NM);
    request.setAttribute("TCHR_HIST",TCHR_HIST);
    request.setAttribute("EDU_OBJ_CTNT",EDU_OBJ_CTNT);
    request.setAttribute("DR_DT",DR_DT);
    request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);
    request.setAttribute("EDU_STD_CNT",EDU_STD_CNT);
    request.setAttribute("EDU_ESTD_CNT",EDU_ESTD_CNT);
    request.setAttribute("TCHR_CERT_CCD",TCHR_CERT_CCD);
	
	DataObj in = new DataObj();											 
	in.put("EDU_ID", EDU_ID);
	
	DataObj output2 = RBA_99_01_01_01.getInstance().getSearchFile(in);
	
	Log.logAML(Log.DEBUG, "files...................." + output2.getCount("FILE_SER"));
			
	if(output2.getCount("FILE_SER") > 0) {
		Log.logAML(Log.DEBUG, "files...................." + output2.getRowsToMap());
		request.setAttribute("filepath",Constants._UPLOAD_EDU_DIR);
		request.setAttribute("FILES",output2.getRowsToMap());
	}
	
	DataObj output3 = RBA_99_01_01_01.getInstance().getSearchTGT(in);
	
	System.out.println("##########output3"+output3);
	if(output3.getCount("EDU_TGT_CCD") > 0){
		 String getTGTS = output3.toString();		 
		  String[] TGTS = getTGTS.split("\\[")[1].split("\\]")[0].split(",");
		 
	     for (String TGT : TGTS) {
	        int TGT_CCD = Integer.parseInt(TGT.trim());

	        if (TGT_CCD == 1003) {			// 이사회
	        	ISDIREC	= "Y";
	        } else if (TGT_CCD == 1004) {	// 경영진
	        	ISMNG   = "Y";
	        } else if (TGT_CCD == 1001) {	// 전담부서
	        	ISDEDIC	= "Y";
	        } else if (TGT_CCD == 1002) {	// 감사부서
	        	ISAUDIT	= "Y";
	        } else if (TGT_CCD == 1005) {	// 영업부점
	        	ISSALES	= "Y";
	        } else if (TGT_CCD == 1006) {	// 신입 직원
	        	ISNEWEMP = "Y";
	        } else if (TGT_CCD == 1007) {	// 일반 직원
	        	ISNOMAL	= "Y";
	        } else if (TGT_CCD == 1008) {	// 기타
	        	ISPERSONAL = "Y";
	        }
				
	    }  

	}
	
	request.setAttribute("ISDIREC", ISDIREC);
    request.setAttribute("ISMNG",ISMNG);
    request.setAttribute("ISDEDIC",ISDEDIC);
    request.setAttribute("ISAUDIT",ISAUDIT);
    request.setAttribute("ISSALES",ISSALES);
    request.setAttribute("ISNEWEMP",ISNEWEMP);
    request.setAttribute("ISNOMAL",ISNOMAL);
    request.setAttribute("ISSELF",ISSELF);
    request.setAttribute("ISPERSONAL",ISPERSONAL);
	
%>
<script language="JavaScript">
	var overlay = new Overlay();
    var pageID = "RBA_99_01_01_02";
    var classID = "RBA_99_01_01_02";
    var GridObjArr = [];
    var GridObj1;
    var dataSource1 = [];
    var fileSeq ="";
    
	
    $(document).ready(function(){
    	setupGrids();
    	
    	if( form1.EDU_ID.value != "" ) {
    		doSearchUser();
    	}
    	
    	
    	setupFileUploader();
    	setupForm();
    	clickISSELF();
    	
    	$("#EDU_HH").keyup(function(event){
        	var locEXP_TRM = $(this).val().replace(/[^0-9]/g,"");
        	if(locEXP_TRM != 0 ){
        		$(this).val(locEXP_TRM );	
        	}else{
        		$(this).val('' );
        	}
        	
        });
    	
    });
    
    
    // 교육 기관이 외부기관(02) 인 경우 disabled 처리.
    function applyOrgNameState(val){
		if(val === "01"){
			$('[name="OGN_NM"]').prop('disabled',true).val("");
		}else{
			$('[name="OGN_NM"]').prop('disabled',false);
		}
    }
    
    // 교육 대상의 직접 입력 체크박스 TCHR_CERT_CCD 가 'Y' 인 경우에만 input 박스 활성화
    // 직접입력에 대한 대상을 테이블내 안쓰는 컬럼을 활용하여 개발
    function applyPersonalState(val){
		if(val === "N"){
			$('[name="TCHR_CERT_CCD"]').prop('disabled',true).val("");
		}else{
			$('[name="TCHR_CERT_CCD"]').prop('disabled',false);
		}
    }

    $(function(){
		$(document).on("change" , "#CRE_OGN_CCD" , function(){
			applyOrgNameState($(this).val());
		});
		
		applyOrgNameState($("#CRE_OGN_CCD").val());
		
		$(document).on("change" , "#ISPERSONAL" , function(){
			applyPersonalState($(this).prop("checked") ? "Y" : "N");
		});
		
		applyPersonalState($("#ISPERSONAL").prop("checked") ? "Y" : "N");
		
		
		///// 임시 소스 : 테이블 컬럼 추가되면 삭제할 소스 ///////
		$('[name="TCHR_CERT_CCD"]').on("input" , function(){
			var maxlength = 5;
			var value = $(this).val();
			
			if(value.length > maxlength){
				showAlert("${msgel.getMsg('RBA_99_01_01_02_036','교육대상 [기타] 항목은 최대 5자리까지 입력 가능합니다.(임시)')}", 'WARN');
				return false;
			}
		})
		////////////////////////////////////////////////
    });
    
    function setupFilter(FLAG){
    	
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;    	
    	
    }
    
    function setupGrids(){
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    		elementAttr: { class: "grid-table-type" },
			 height	:"calc(60vh - 80px)",
			 hoverStateEnabled      : true
	     	   ,wordWrapEnabled        : false
	     	   ,allowColumnResizing     : true
	     	   ,columnAutoWidth        : true
	     	   ,allowColumnReordering : true
	     	   ,columnResizingMode    : "widget"
	     	   ,cacheEnabled             : false
	     	   ,cellHintEnabled           : true
	     	   ,showBorders              : true
	     	   ,showColumnLines        : true
	     	   ,showRowLines            : true
	     	   ,loadPanel                  : { enabled: false }
    		   ,editing: {mode : "batch", allowUpdating: true, allowAdding  : true, allowDeleting: false }
        	   ,export : {allowExportSelectedData: true,enabled: true,excelFilterEnabled: true}
	     	   ,onExporting: function (e) {
					var workbook = new ExcelJS.Workbook();
					var worksheet = workbook.addWorksheet("Sheet1");
				    DevExpress.excelExporter.exportDataGrid({
				        component: e.component,
				        worksheet : worksheet,
				        autoFilterEnabled: true,
				    }).then(function() {
				        workbook.xlsx.writeBuffer().then(function(buffer) {
				            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "EDU_JKW_Sample.xls");
				        });
				    });
				    e.cancel = true;
	            }
	     	   ,filterRow: { visible: false }
	     	   ,hoverStateEnabled: true
	     	   ,loadPanel: { enabled: false }
	     	   ,pager: {
		   	    	visible: true
		   	    	,showNavigationButtons: true
		   	    	,showInfo: true
		   	    }
		   	   ,paging: {
		   	    	enabled : true
		   	    	,pageSize : 20
		   	    }
		   	   ,onToolbarPreparing   : makeToolbarButtonGrids
	     	   ,remoteOperations : {filtering: false,grouping: false,paging: false,sorting: true,summary: false}
	     	   ,rowAlternationEnabled : true
	     	   ,scrolling : {mode: "standard",preloadEnabled: false}
	     	   ,searchPanel : {visible : false,width: 250}
	     	   ,selection: {
			        allowSelectAll    : true,
			        deferred          : false,
			        mode              : "multiple",
			        selectAllMode     : "allPages",
			        showCheckBoxesMode: "always"
			   }
	     	   ,showBorders     : true
	     	   ,showColumnLines : true
	     	   ,showRowLines    : true
	     	   ,sorting         : { mode: "single"}
	     	   ,wordWrapEnabled : false
	     	   ,columns: [
// 	     	        {
// 						dataField: "NUM",
// 						caption: "No.",
// 						alignment: "center",
// 						allowResizing: false,
// 						allowSorting: false,
// 						allowEditing: false,
// 						cellTemplate: function(container, options){
// 							container.text(options.row.rowIndex + 1);
// 						}
// 					},
	      	      	{
			             dataField            : "JKW_NO",
			             caption              : '${msgel.getMsg("RBA_99_01_01_01_038","사번")}',
			             alignment            : "center",
			             allowResizing        : true,
			             allowSearch          : true,
			             allowSorting         : true,
			             allowEditing         : false,
			             cellTemplate : function(cellElement,cellInfo){ 
		                             if(!cellInfo.value) {
												$("<span>").text("🔍")
														   .css({ cursor : "pointer" , color : "blue" })
														   .on("click" , function(){
																cellInfo.component.editCell(cellInfo.rowIndex , cellInfo.column.dataField);
														   })
														   .appendTo(cellElement);
											}
		                             else {
												cellElement.text(cellInfo.value);
		                             }
		                  },
		          		  cssClass     : "link"
			        },
	 	      	    {dataField: "USER_NM",caption: "${msgel.getMsg('RBA_90_03_01_01_108','성명')}",alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: true},
	 	      	    {dataField: "POSITION_NM",caption: "${msgel.getMsg('AML_20_01_01_04_029','직위')}",alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: true},
	      	        {dataField: "DEP_ID",caption: "${msgel.getMsg('AML_90_03_07_01_101','부서코드')}",alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: true , visible: false},
	      	        {dataField: "DEP_NM",caption: "${msgel.getMsg('AML_90_03_07_01_106','부서')}",alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true,allowEditing: true},
	      	        {
			             dataField            : "ING_YN",
			             caption              : '${msgel.getMsg("RBA_99_01_01_01_041","수료여부")}',
			             lookup:
			             {
			                 dataSource:
			                 [
			                     {
			                         "KEY"      : "Y",
			                         "VALUE"    : "Y"
			                     },
			                     {
			                         "KEY"      : "N",
			                         "VALUE"    : "N"
			                     }
			                 ],
			                 displayExpr      : "VALUE",
			                 valueExpr        : "KEY"
			             },
			             alignment            : "center",
			             allowResizing        : true,
			             allowSearch          : true,
			             allowSorting         : true
// 			             allowEditing         : true
			         },
	      	        {
						dataField: "ING_DT",
// 						dataType : "String",
						caption: "${msgel.getMsg('RBA_99_01_01_01_042','수료일자')}",
						alignment: "left",
						allowResizing: true,
						allowSearch: true,
						allowSorting: true,
						allowEditing: true,
						customizeText : function(e){
// 							return e.value ;
							return e.value ? e.value.replace(/(\d{4})(\d{2})(\d{2})/, "$1-$2-$3") : ""\;
						}
// 	                    format:function(value){ return value?(value.substr(0,4)+'-'+value.substr(4,2)+'-'+value.substr(6,2)):value;}

					},
	      	    ]
	     	   ,onCellClick: function(e){
	     		   if(e.rowType != "header" && e.rowType != "filter"){
// 	     			  e.component.editCell(e.rowIndex,e.columnIndex);
	     			  Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
	     		   }

                }
 			,"onRowInserting" : function(e) {
        	        var mycols = e.component.option("columns");
        	        for (var i=0; i<mycols.length; i++) {
        	            var mycolobj = mycols[i];
        	            var colname  = mycolobj["dataField"];
        	        }
        	    }
//  			, keyExpr : "JKW_NO"
 			, onContentReady : function(e){
				if(e.component.totalCount > 0){
					e.component.selectAll();
 				}
 			}
 				
	  	}).dxDataGrid("instance");
    }
    
    // [ make ]
    var saveitemobj;

	/** 툴바 버튼 설정 */
    function makeToolbarButtonGrids(e)
    {
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
                        ,"hint"      : '새로고침'
                        ,"disabled"  : true
//                         ,"onClick"   : gridID=="GTDataGrid1_Area"?doSearch:doSearch2
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
	                    ,"hint"      : '필터'
	                    ,"disabled"  : false
	                    ,"onClick"   : function(){
							if(gridID=="GTDataGrid1_Area"){
								setupFilter();
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
            if (authD=="Y") {
                toolbarItems.splice(btnLastIndex, 0, {
                    "locateInMenu" : "auto"
                   ,"location"     : "after"
                   ,"widget"       : "dxButton"
                   ,"name"         : "removeButton"
                   ,"showText"     : "always"
                   ,"options"      : {
                	   		"elementAttr": { class: "btn-28" }
                           ,"text"      : "${msgel.getMsg('AML_00_00_01_01_027','삭제')}"
                           ,"hint"      : '행을 삭제'
                           ,"disabled"  : false
                           ,"onClick"   : function(){
								var selectedRow = GridObj1.getSelectedRowsData();
								var selectedKey = GridObj1.getSelectedRowKeys();
								
								if(selectedKey.length === 0){
					                showAlert('${msgel.getMsg("RBA_99_01_01_02_031","삭제 할 행을 선택하세요.")}','WARN');

									return;
								}else if("${ADDGUBUN}" == "Y"){
									selectedKey.forEach(function(key){
	 									GridObj1.getDataSource().store().remove(key);
	 								});
									GridObj1.refresh();
								}else{
					                doDeleteEmp();
					                
					                selectedKey.forEach(function(key){
	 									GridObj1.getDataSource().store().remove(key);
	 								});
									GridObj1.refresh();
								}
								
                           }
                     }
                });
            }
            if (authC=="Y") {
                $.each(toolbarItems, function(i, item) {
                	
                    if (item.name === "addRowButton") {
                        item.showText           = "always";
                        item.options.text       = "${msgel.getMsg('AML_00_00_01_01_024','추가')}";
                        item.options.icon		= "";
                        item.options.disabled   = false;
                        item.options.onClick    = function(){
                        	overlay.show(true, true);
                            if (gridID=="GTDataGrid1_Area") {
                                addRowGrid1(cmpnt);
                            } 
                        }
                        item.options.elementAttr = { class: "btn-28" };
                    }
                });
            }
        }
    }
    var search_window = null;

	function Grid1CellClick(id, obj, selectData, row, col,colId){
//	 	   if (curRow!=row) {
        curRow  = row;
        LOGIN_ID   = obj.LOGIN_ID;
        addCDNM = obj.CD_NM;
        $("#scd"    ).val(obj.LOGIN_ID        );
        $("#srtb"   ).val(obj.TBL_NM    );
        $("#srcd"   ).val(obj.STND_CD_NM);
        $("#sccd"   ).val(obj.CCD       );
        if (!obj.CD_LNGTH) { obj.CD_LNGTH = 0; }
        $("#sclen").val(obj.CD_LNGTH);
        if (!obj.MDFY_F) { obj.MDFY_F = "Y"; }
        $("#scupt_yn").val(obj.MDFY_F);

//		 }
        if(colId == "JKW_NO"){
        	 zip_window = null;        
             if (search_window != null) search_window.close();
             search_window        =  window_popup_open(form2, 700, 650, '');
             form2.pageID.value   = 'RBA_99_01_01_03';         
             form2.viewName.value = 'RBA_99_01_01_03';
             form2.target         = 'RBA_99_01_01_03';
             form2.action         = "<c:url value='/'/>0001.do";  
             form2.IS_MNG.value   = 'N';
             form2.FUNC_NM.value  = "changeWorker"            
             form2.submit();
             form2.target = '';
        }
	}

    /** Grid1 행 추가 */
    function addRowGrid1(){
		try {
	    		var grid = $("#GTDataGrid1_Area").dxDataGrid("instance");

				if(!grid.option('dataSource') || grid.option('dataSource').length === 0){
					grid.option('dataSource', []);
				}
				
          		grid.addRow();
          		grid.saveEditData();
//           		grid.columnOption('No.', 'sortOrder', 'asc');
    	        setTimeout(function(){
                 var arr = new Array;
	                 for(i=0; i<grid.totalCount(); i++){
	                    var obj; obj = grid.getDataSource().items()[i];
	                    if(obj.JKW_NO == undefined || obj.JKW_NO == null || obj.JKW_NO == ''){
	                       arr.push(i);
	                    }
	                 }
                grid.selectRowsByIndexes(arr);
				},100);

        } catch (e) {
        	showAlert(e,'ERR');
        } finally {
               overlay.hide();
        }
    }
    
    // [ check ]
        function doSaveEmp(){
    	var grid = $("#GTDataGrid1_Area").dxDataGrid("instance");
        grid.saveEditData();
        
        var rowsData = GridObj1.getSelectedRowsData();
		
        var allRowsData = GridObj1.getDataSource().items();
        var keyArr = new Array();
        
        for (var i=0;i<allRowsData.length; i++) {
            keyArr.push(allRowsData[i].DTL_C);
        }

        for (var i=0; i<rowsData.length; i++) {
            var obj = rowsData[i];
            if (obj.ING_YN=="") {
                showAlert('${msgel.getMsg("RBA_10_09_01_01_003","수료여부를 입력하십시오.")}','WARN');
                return false;
            }
            if (obj.ING_DT=="") {
                showAlert('${msgel.getMsg("AML_10_01_01_01_024","수료일자를 입력하십시오.")}','WARN');
                return false;
            }
        } 

        var params   = new Object();
        var methodID = "doSaveEmp";
        var classID  = "RBA_99_01_01_01";

        params.pageID   	= "RBA_99_01_01_02";
        params.CON_YN   	= "0";
        params.EDU_ID 		= form1.EDU_ID2.value;

        params.gridData = rowsData;
        
        sendService(classID, methodID, params, doSave1_end, doSave1_end);

    }

    var doSave1_end = function() {
        //doSearch();
        window.close();
         opener.doSearch();
    }
    
    
    function doSave(){
    	$("#EDU_START_DT").val(getDxDateVal("START_DT",true));    	
        $("#EDU_END_DT"  ).val(getDxDateVal("END_DT"  ,true));
        $("#S_ISDIREC" ).val($("#ISDIREC")[0].checked?$("#ISDIREC").val():"");
        $("#S_ISMNG" ).val($("#ISMNG")[0].checked?$("#ISMNG").val():"");
        $("#S_ISDEDIC" ).val($("#ISDEDIC")[0].checked?$("#ISDEDIC").val():"");
        $("#S_ISAUDIT" ).val($("#ISAUDIT")[0].checked?$("#ISAUDIT").val():"");
        $("#S_ISSALES" ).val($("#ISSALES")[0].checked?$("#ISSALES").val():"");
        $("#S_ISNEWEMP" ).val($("#ISNEWEMP")[0].checked?$("#ISNEWEMP").val():"");
        $("#S_ISNOMAL" ).val($("#ISNOMAL")[0].checked?$("#ISNOMAL").val():""); 
        $("#S_ISPERSONAL" ).val($("#ISPERSONAL")[0].checked?$("#ISPERSONAL").val():""); 
        
        $("#EDU_STS_CD").val("S");
        $("#pageID"    ).val("RBA_99_01_01_02");
        $("#classID"    ).val("RBA_99_01_01_02");
        $("#methodID"   ).val("doSave");
        
    	var fileCount; 
		if(isNotEmpty(form1.elements["storedFileNms"])) {
			fileCount = form1.elements["storedFileNms"].length;
			if(fileCount > 5){
			    showAlert('${msgel.getMsg("AML_90_01_02_02_012","파일을 5개이상 첨부할수 없습니다.")}','WARN');
	            return false;
	        }	
		}
		if( !doSave_check()){
			return;
		}
		showConfirm("${msgel.getMsg('AML_90_05_04_01_002','저장하시겠습니까?')}", "${msgel.getMsg('AML_00_00_01_01_025','저장')}",doSave_Action);
		
    }
    
    function doSave_Action(){
    	
		var option = {
				url : '${ctx}/rba/doEDUSave.do',
				dataType : 'json',				
				success : function(data){		
					if(data.status == 'success')
					{
						
						form1.EDU_ID2.value = data.EDU_ID;
						showAlert(data.serviceMessage,"INFO");

						doSave_end();
					}	
					else
					{
						showAlert(data.serviceMessage,"ERR");
						
					}	
					
				}				 
		};
		
		$('#form1').ajaxSubmit(option);
		
		return false;		
	}
    
    function doSave_check(){
    	
    	// 교육 과정명
    	if ($("#EDU_NM").val() == null || $("#EDU_NM").val() == "") {
            showAlert("${msgel.getMsg('RBA_99_01_01_02_022','교육 과정명을 입력하세요.')}",'WARN')&&($("#EDU_NM").focus());
            return false;
        }
    	
    	// 교육 시작일자 & 교육 종료일자
	   	if ( ($("#EDU_START_DT").val()  == null  || $("#EDU_END_DT").val() == "") ){
	   		showAlert("${msgel.getMsg('RBA_99_01_01_02_020','교육 기간을 입력하세요.')}","WARN");
	   		return false; 
	   	}else if ($("#EDU_START_DT").val() > $("#EDU_END_DT").val()) {
	        showAlert("${msgel.getMsg('AML_10_04_01_01_020','시작일이 종료일보다 늦을 수 없습니다.')}","WARN");
	        return false ;
	   	}
	   	
	   	// 교육 대상
	   	if (!($("#ISDIREC")[0].checked || $("#ISMNG")[0].checked || $("#ISDEDIC")[0].checked || $("#ISAUDIT")[0].checked || $("#ISSALES")[0].checked || $("#ISNEWEMP")[0].checked || $("#ISNOMAL")[0].checked || $("#ISPERSONAL")[0].checked)) {
	   	    showAlert("${msgel.getMsg('RBA_99_01_01_02_021','교육 대상을 체크하세요.')}", 'WARN');
	   	    return false;
	   	}
	   	
	   	// 교육대상 직접입력 항목
	   	if($("#ISPERSONAL")[0].checked && ($("#TCHR_CERT_CCD").val() == null || $("#TCHR_CERT_CCD").val() == "")){
	   	    showAlert("${msgel.getMsg('RBA_99_01_01_02_035','교육대상 [기타] 항목을 입력하세요.')}", 'WARN');
	   	    return false;
	   	}
	   	
	   	// 교육 시간
    	if ($("#EDU_HH").val() == null || $("#EDU_HH").val() == "") {
    		showAlert("${msgel.getMsg('RBA_99_01_01_02_002','교육 시간을 입력하세요.')}",'WARN')&&($("#EDU_HH").focus());
    		return false;
        }
    	
    	var regExp = /^[0-9]+$/;
		var bool = regExp.test($("#EDU_HH").val() );
		
		if(!bool){
			showAlert("${msgel.getMsg('RBA_99_01_01_02_003','교육 시간은 숫자만 입력 가능합니다.')}",'WARN')&&($("#EDU_HH").focus());
			return false;
		}
    	
	   var isAll = $("#ISSELF").is(':checked')?'Y':'N';
    	if(isAll == "Y"){
            $("#CRE_OGN_CCD").val("Y");
        }
    	
    	// 교육 대상자 수 , 교육 수료자 수
    	if ($("#EDU_STD_CNT").val() == null || $("#EDU_STD_CNT").val() == "") {
            showAlert("${msgel.getMsg('RBA_99_01_01_02_022','교육 과정명을 입력하세요.')}",'WARN')&&($("#EDU_NM").focus());
            return false;
        }
    	
    	
        return true;
    }
    
    
    // 교육이수자 명세
    function doDeleteEmp() {

        var grid = $("#GTDataGrid1_Area").dxDataGrid("instance");
        grid.saveEditData();
        
        var rowsData = GridObj1.getSelectedRowsData();
        var allRowsData = GridObj1.getDataSource().items();
        
        if(rowsData <= 0){
            showAlert('${msgel.getMsg("AML_10_01_01_01_006","삭제할 데이타를 선택하십시오.")}','WARN');
            return;
        }

        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

        	var params   = new Object();
        	var methodID = "doDeleteEmp";
        	var classID  = "RBA_99_01_01_02";
        	 		
			params.EDU_ID = form1.EDU_ID.value;
            params.gridData = rowsData;
            params.JKW_NO   = rowsData.map( r => r.JKW_NO ).join(',');
            
        	sendService(classID, methodID, params, doDeleteEmp_end, doDeleteEmp_fail); 
        });
        
    }
    
    function clickISSELF(){
        if( $("input:checkbox[id='ISSELF']").is(":checked") == true ) {         	
            document.getElementById("CRE_OGN_CCD").disabled = true;
        } else {
        	document.getElementById("CRE_OGN_CCD").disabled = false;
        }
    }
    
    function doSave_end()
    {
     	doSaveEmp();
    }
    
    function doSave1_end() {
//         doSearch();
//         GridObj1.refresh();
    }   

    function doUpdate_end() {
    	doUpdateEmp();
    }   

    function doDeleteEmp_end() {
		console.log("doDeleteEmp end");	
    }   

    function doDeleteEmp_fail() {
		console.log("doDeleteEmp fail");	
 	}   

    function Popup_Close() {
    	 window.close();
         opener.doSearch();
    }
    
    
    // 첨부파일
    function setupFileUploader(){
		var allowedFileExtensions = "${uploadFile}";
        fileUploader = gtFileUploader("file-uploader",allowedFileExtensions,doSubmit_end,true,false);
    }
    
    function prdViewDelete(org){
        
    	$(org).closest(".tx").remove();

    	if( isEmpty($("#fileBox > tr > td").html()) ){

    		var child = "<tr><td colspan=\"4\" style=\"text-align: center;\" >&nbsp;</td></tr>";
   			$("#fileBox").append(child);
        }
    }
    
    function prdTempFileDel(id,p,f){
        
    	var form = document.fileFrm;
     	fileFrm.downFilePath.value =p;
     	fileFrm.downFileName.value = f;
     	
     	var option = {
     		url : '/file/fileDel.do',
     		dataType : 'json'
     	};

     	$('#fileFrm').ajaxSubmit(option);
    	$("#"+id).remove();	

    	if( isEmpty($("#fileBox > tr > td").html()) ){

    		var child = "<tr><td colspan=\"4\" style=\"text-align: center;\" >&nbsp;</td></tr>";
   			$("#fileBox").append(child);
        }
        
     	return false;
    }
     
    function doSubmit_end(fileData)
    {
         var addLine;
         var divId = fileData.storedFileNm.substring(0,fileData.storedFileNm.lastIndexOf("."));
            
         if(fileData != undefined){

        		if( $("#fileBox > tr > td").html() == '&nbsp;'){

        			$("#fileBox").children().first().remove();
             }
        		
       		addLine	= "<tr id='"+divId+"'>"
       				+"<td style=\"text-align: center;\"></td>"
       				+"<td class=\"file-name\">"+fileData.origFileNm+"</td>"
       				+"<td style=\"text-align:center;\">"+fileData.fileSize+"&nbsp;kb</td>"
       				+"<td style=\"text-align: center;\">"
       				+" <a onclick=\"prdTempFileDel('"+divId+"','/upload/attachTmp/','"+fileData.storedFileNm+"');\" >"
       				+"  <input type='hidden' name='fileSizes' id='fileSizes' class='fileSize' value='"+fileData.fileSize+"' />"
       				+"  <input type='hidden' name='origFileNms' id='origFileNms' class='origFileNm' value='"+fileData.origFileNm+"' />"
       				+"  <input type='hidden' name='storedFileNms' id='storedFileNms' class='storedFileNm' value='"+fileData.storedFileNm+"' />"
       				+"  <input type='hidden' name='filePaths' id='filePaths' class='filePath' value='"+fileData.filePath+"' />"
       				+"  <div class='dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon' role='button' aria-hidden='true' aria-label='close'>"
       				+"	 <div class='dx-button-content'><span class=\"delete-link\">${msgel.getMsg('AML_10_25_02_02_035', '삭제')}</span></div>"
       				+"  </div>"
       				+" </a>"
       				+" </td>"
       				+"</tr>";
       				
       		$("#fileBox").append(addLine);
       	}
    }
     
    function doUpdate(){
    	$("#EDU_START_DT").val(getDxDateVal("START_DT",true));    	
        $("#EDU_END_DT"  ).val(getDxDateVal("END_DT"  ,true));
        $("#S_ISDIREC" ).val($("#ISDIREC")[0].checked?$("#ISDIREC").val():"");
        $("#S_ISMNG" ).val($("#ISMNG")[0].checked?$("#ISMNG").val():"");
        $("#S_ISDEDIC" ).val($("#ISDEDIC")[0].checked?$("#ISDEDIC").val():"");
        $("#S_ISAUDIT" ).val($("#ISAUDIT")[0].checked?$("#ISAUDIT").val():"");
        $("#S_ISSALES" ).val($("#ISSALES")[0].checked?$("#ISSALES").val():"");
        $("#S_ISNEWEMP" ).val($("#ISNEWEMP")[0].checked?$("#ISNEWEMP").val():"");
        $("#S_ISNOMAL" ).val($("#ISNOMAL")[0].checked?$("#ISNOMAL").val():""); 
        $("#S_ISPERSONAL" ).val($("#ISPERSONAL")[0].checked?$("#ISPERSONAL").val():""); 
        $("#EDU_STS_CD").val("S");
        $("#pageID"    ).val("RBA_99_01_01_02");
        $("#classID"    ).val("RBA_99_01_01_02");
        $("#methodID"   ).val("doUpdate");
        
    	var fileCount; 
		if(isNotEmpty(form1.elements["storedFileNms"])) {
			fileCount = form1.elements["storedFileNms"].length;
			if(fileCount > 5){
			    showAlert('${msgel.getMsg("AML_90_01_02_02_012","파일을 5개이상 첨부할수 없습니다.")}','WARN');
	            return false;
	        }	
		}
		if( !doSave_check()){
			return;
		}
		showConfirm("${msgel.getMsg('AML_90_05_04_01_002','저장하시겠습니까?')}", "${msgel.getMsg('AML_00_00_01_01_025','저장')}",doUpdate_Action);
		
    }
    
    function doUpdate_Action(){
    	
		var option = {
				url : '${ctx}/rba/doEDUUpdate.do',
				dataType : 'json',				
				success : function(data){		
					if(data.status == 'success')
					{
						
						form1.EDU_ID2.value = data.EDU_ID;
						showAlert(data.serviceMessage,"INFO");

						doUpdate_end();
					}	
					else
					{
						showAlert(data.serviceMessage,"ERR");
						
					}	
					
				}				 
		};
		
		$('#form1').ajaxSubmit(option);
		
		return false;		
	}
    
 // [ check ]
    function doUpdateEmp(){
	var grid = $("#GTDataGrid1_Area").dxDataGrid("instance");
    grid.saveEditData();
    
    var rowsData = GridObj1.getSelectedRowsData();

//     var allRowsData = GridObj1.getDataSource().items();
    var allRowsData       = getDataSource(GridObj1);
    var keyArr = new Array();
    
    for (var i=0;i<allRowsData.length; i++) {
        keyArr.push(allRowsData[i].DTL_C);
    }

    for (var i=0; i<rowsData.length; i++) {
        var obj = rowsData[i];
        if (obj.ING_YN=="") {
            showAlert('${msgel.getMsg("RBA_10_09_01_01_003","수료여부를 입력하십시오.")}','WARN');
            return false;
        }
        if (obj.ING_DT=="") {
            showAlert('${msgel.getMsg("AML_10_01_01_01_024","수료일자를 입력하십시오.")}','WARN');
            return false;
        }
    } 
//     showConfirm("${msgel.getMsg('RBA_99_01_01_01_044','저장하시겠습니까?')}", "저장",function(){

        var params   = new Object();
        var methodID = "doUpdateEmp";
        var classID  = "RBA_99_01_01_02";

        params.pageID   = "RBA_99_01_01_02";
        params.CON_YN   = "0";
        params.EDU_ID = form1.EDU_ID.value;
//         params.JKW_NO = form1.JKW_NO.value;
        params.gridData = allRowsData;
        
        console.log(params.gridData);
        
        sendService(classID, methodID, params, doSave1_end, doSave1_end);
//     });

}
    
    
    function downloadFile(f,o,e)
    {
     	$("[name=pageID]", "#fileFrm").val("RBA_99_01_01_02");
     	$("#downFileName").val(f);
     	$("#orgFileName").val(o); 	
     	$("#FILE_SER").val(e);
     	$("#downFilePath").val($("#filePaths").val()); 	
     	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
     	$("#fileFrm").submit();
    }
    
    function TemplateDownload()
    {   
        //gtTemplateDownloadFile("form3","RA_NTN_TemplateFile.xlsx","RA_NTN_TemplateFile.xlsx","TEMPLATE","/RA");
    	var workbook = new ExcelJS.Workbook();
    	var worksheet = workbook.addWorksheet('Sheet1');
    	DevExpress.excelExporter.exportDataGrid({
    		component: GridObj1,
    		worksheet: worksheet,
    		autoFilterEnabled: true,
    	}).then(function() {
    		workbook.xlsx.writeBuffer().then(function(buffer) {
    			saveAs(new Blob([buffer], { type: 'application/octet-stream' }), '${pageTitle}.xlsx');
    		});
    	});
    }
    function setupForm(){
    	 if("${ADDGUBUN}" != "Y"){
    		 form1.EDU_STS_CD.value			= "${EDU_STS_CD}";
    		 form1.CRE_OGN_CCD.value		= "${CRE_OGN_CCD}";
    		 form1.EDU_CCD.value			= "${EDU_CCD}";
    		 form1.TCHR_HIST.value			= "${TCHR_HIST}";
    		 form1.EDU_OBJ_CTNT.value		= "${EDU_OBJ_CTNT}";
    		 
   	     	$('[name="EDU_CCD"]').prop('disabled',true);
   	     	$('[name="EDU_CHK_YN"]').prop('disabled',true);	
   	     	$('[name="CRE_OGN_CCD"]').prop('disabled',true);	

   	     	$('[name="START_DT"]').prop('disabled',true);	
   	     	$('[name="END_DT"]').prop('disabled',true);	
       	 	
    	 }
//     	 document.getElementById("EDU_STS_CD").disabled = true;
    }
     
     
     var search_window = null;

     function findWorker()
     {
         zip_window = null;        
         if (search_window != null) search_window.close();
         search_window        =  window_popup_open(form2, 700, 650, '');
         form2.pageID.value   = 'RBA_99_01_01_03';         
         form2.viewName.value = 'RBA_99_01_01_03';
         form2.target         = 'RBA_99_01_01_03';
         form2.action         = "<c:url value='/'/>0001.do";  
//          form2.IS_MNG.value   = 'N';
         form2.FUNC_NM.value  = "changeWorker"            
         form2.submit();
         form2.target = '';
         
     }
     
     function changeWorker(usrInfo)
     {
         $("#USER_ID").val(usrInfo.USER_ID);
         $("#USER_NM" ).val(usrInfo.USER_NM);
         $("#DEP_ID" ).val(usrInfo.DEP_ID);
         $("#DEP_NM" ).val(usrInfo.DEP_NM);
         $("#POSITION_NM" ).val(usrInfo.POSITION_NM);
         
         var grid = $("#GTDataGrid1_Area").dxDataGrid("instance");
         
         var rowIndex = grid.option("focusedRowIndex");
         if(rowIndex == null || rowIndex < 0){
			var key = (grid.getSelectedRowKeys && grid.getSelectedRowKeys()[0]) || null;
			if(key != null) rowIndex = grid.getRowIndexByKey(key);
         }
         
         grid.cellValue(rowIndex, "JKW_NO", usrInfo.USER_ID);
         grid.cellValue(rowIndex, "USER_NM", usrInfo.USER_NM);
         grid.cellValue(rowIndex, "DEP_ID", usrInfo.DEP_ID);
         grid.cellValue(rowIndex, "DEP_NM", usrInfo.DEP_NM);
         grid.cellValue(rowIndex, "POSITION_NM", usrInfo.POSITION_NM);
     }
     
     
     function doSearchUser() {
//      	GridObj1.cancelEditData();
     	var methodID = "doSearchUser";
         var classID  = "RBA_99_01_01_01";
         var params = new Object();
         params.pageID   = "RBA_99_01_01_02";
         params.EDU_ID = form1.EDU_ID.value;
         
         sendService(classID, methodID, params, doSearchUser_end, doSearchUser_fail);
     	
 	}
     
     function doSearchUser_end ( gridData, data ) {
     	try {
             GridObj1.refresh();
             GridObj1.option("dataSource",gridData);

             $("button[id='btn_01']").prop('disabled', false);

              var row = gridData.length;

              if(row > 0){
                 GridObj1.refresh().then(function() {
                        GridObj1.selectRowsByIndexes(0)
                 });
                 Grid1CellClick("GTDataGrid1", gridData[0] );
              }
//               else{
//                   form.GRP_CD_1.value = "";
//               }
             } catch (e) {
                 showAlert(e,'ERR');
                 overlay.hide();
             } finally {
                 overlay.hide();
             }
 	}
     
     function doSearchUser_fail () {}
     
    function setGridFromExcel(gridData){
		var grid = $("#GridObj1").dxDataGrid("instance");
		grid.option("dataSource",gridData);
		grid.refresh();
    }
    
    function downloadFile()
    {   
        //gtTemplateDownloadFile("form3","RA_NTN_TemplateFile.xlsx","RA_NTN_TemplateFile.xlsx","TEMPLATE","/RA");
    	var workbook = new ExcelJS.Workbook();
    	var worksheet = workbook.addWorksheet('Sheet1');
    	DevExpress.excelExporter.exportDataGrid({
    		component: GridObj1,
    		worksheet: worksheet,
    		autoFilterEnabled: true,
    	}).then(function() {
    		workbook.xlsx.writeBuffer().then(function(buffer) {
    			saveAs(new Blob([buffer], { type: 'application/octet-stream' }), '${pageTitle}.xlsx');
    		});
    	});
    }
    
    function clearGridObj1() {
		GridObj1.cancelEditData();
		GridObj1.clearSelection();
		GridObj1.option('dataSource', []);
	}
    
    function raFileUpload() {
    	clearGridObj1();
    	var allowedFileExtensions = "${uploadFileX}";
    	var fileUploader = gtFileUploader("JKWListFile",allowedFileExtensions,doSubmit_end2);
    }

    function doSubmit_end2(fileData) {
    	overlay.show();
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
		params.actionName = "com.gtone.aml.server.AML_10.AML_10_37.AML_10_37_01.AML_10_37_01_01_Action";
		sendService(null, null, params, doUpload_Success, doUpload_fail);
    }

    function doUpload_Success(dataSource) {
    	overlay.hide();
//     	dataSource = dataSource.filter(function(item) {
//     	    return item.RA_ITEM_CD !== null && item.RA_ITEM_CD !== "" && item.RA_ITEM_CD !== undefined;
//     	});

    	GridObj1.option("dataSource", dataSource);
    	GridObj1.refresh();
    }

    function doUpload_fail(dataSource) {
        overlay.hide();
    }

</script>
<style>
.title {
    width: 157px;
}

/* 첨부파일 테이블 */
.file-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
  margin-bottom: 10px;
  font-size: 13px;
}

.file-table th,
.file-table td {
  border: 1px solid #ccc;
  padding: 6px 8px;
  text-align: left;
}

.file-table th {
  background-color: #f0f0f0;
  text-align: center;
}

.file-table .actions {
  text-align: center;
}
.file-table .download-link {
  color: blue;
  text-decoration: underline;
  cursor: pointer;
}

.file-table .delete-link {
  color: red;
  cursor: pointer;
}

</style>

<form name="fileFrm" id="fileFrm" method="POST">
<input type="hidden" name="pageID" />
<input type="hidden" name="downFileName" id="downFileName" value="" />
<input type="hidden" name="orgFileName" id="orgFileName" value="" />
<input type="hidden" name="downFilePath" id="downFilePath" value="" />
<input type="hidden" name="downType" id="downType" value="EDU" />
<input type="hidden" name="FILE_SER"    id="FILE_SER" value= "${FILE_SER}"/>
</form> 
<form name="form4" method="post">
	<input type="hidden"  name="pageID"/>
   	<input type="hidden"  name="classID"/>
   	<input type="hidden"  name="methodID"/>
   	<input type="hidden"  name="mode"/>
   	<input type="hidden"  name="SNO" />
   	<input type="hidden"  name="FILE_SER" />
   	<input type="hidden"  name="ROLE_ID" value="${ROLE_ID}">
</form>
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
<form name="form2" method="post" >
    <input type="hidden" name="pageID"  id="pageID"     />
    <input type="hidden" name="viewName" id="viewName"  />  
    <input type="hidden" name="classID"  id="classID"   />
    <input type="hidden" name="methodID" id="methodID"  />
    <input type="hidden" name="IS_MNG"   id="IS_MNG"    />
    <input type="hidden" name="FUNC_NM"  id="FUNC_NM"   />
    <input type="hidden" name="TRNS_OGN_CD"  id="TRNS_OGN_CD"   />
</form>
<form name="form1" id="form1" method="post"> 
    <input type="hidden" name="pageID"   		id = "pageID"  >
    <input type="hidden" name="classID"  		id = "classID" >
    <input type="hidden" name="methodID" 		id = "methodID">
<!--     <input type="hidden" name="EDU_STS_CD" 	id="EDU_STS_CD"> -->
    <input type="hidden" name="EDU_START_DT" 	id="EDU_START_DT">
	<input type="hidden" name="EDU_END_DT"		id="EDU_END_DT">
	<input type="hidden" name="S_ISDIREC"		id="S_ISDIREC">
	<input type="hidden" name="S_ISMNG"			id="S_ISMNG" >
	<input type="hidden" name="S_ISDEDIC"		id="S_ISDEDIC">
	<input type="hidden" name="S_ISAUDIT"		id="S_ISAUDIT">
	<input type="hidden" name="S_ISSALES"		id="S_ISSALES">
	<input type="hidden" name="S_ISNEWEMP"		id="S_ISNEWEMP">
	<input type="hidden" name="S_ISNOMAL"		id="S_ISNOMAL">
	<input type="hidden" name="S_ISPERSONAL"	id="S_ISPERSONAL">
	<input type="hidden" name="EDU_ID2"		    id="EDU_ID2">
	<input type="hidden" name="USER_NM"		    id="JKW_NO" value="${output.USER_NM}">
	<input type="hidden" name="JKW_NO"		    id="JKW_NO" value="${output.JKW_NO}">
	<input type="hidden" name="EDU_ID"      id="EDU_ID"    value="${output.EDU_ID}">
	<input type="hidden" name="ATTCH_FILE_NO"   id ="ATTCH_FILE_NO" value="${ATTCH_FILE_NO}"/>
	<input type="hidden" name="DR_DPRT_CD"  	id ="DR_DPRT_CD" 	value="${DR_DPRT_CD}"/>
	<input type="hidden" name="EDU_STS_CD"  	id ="EDU_STS_CD" 	value="${EDU_STS_CD}"/>

	<div class="tab-content-bottom">	    	
	    <h4 class="tab-content-title">${msgel.getMsg('RBA_99_01_01_02_001','교육 및 연수 상세 정보')}</h4>
		
		<table class="basic-table">
			<%
				if(("Y").equals(addGubun)){
			%>
					<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_03_103','교육과정명')}</th>
						<td colspan="3">
							<input type="text" class="cond-input-text" name="EDU_NM" id="EDU_NM"/>
						</td>
					</tr>
					<tr>	
						<th class="title">${msgel.getMsg('RBA_90_01_01_03_106','교육 기관')}</th>
						<td>					
							${condel.getSelect('CRE_OGN_CCD','' ,'' , 'A401','', '', '')}		
						</td>
						<th >${msgel.getMsg('RBA_99_01_01_02_030','기관명')}</th>
						<td>
							<input type="text" class="cond-input-text" name="OGN_NM" id="OGN_NM"/>
						</td>
					</tr>
					<tr>
						<th class="title">${msgel.getMsg('RBA_99_01_01_02_013','강사명')}</th>
						<td>
							<input type="text" class="cond-input-text" name="TCHR_NM" id="TCHR_NM"/>
						</td>	
					</tr>
					<tr>
						<th class="title">${msgel.getMsg('RBA_99_01_01_02_023','강사 약력')}</th>
						<td>
							<textarea class="textarea-box" style="width: 262%;" id="TCHR_HIST" name="TCHR_HIST"></textarea>
							<h5>* 5개 전문자격증 보유여부 등 AML, 전문성 입증 내용</h5>
						</td>	
					</tr>
					
					<tr>
						<th class="title">${msgel.getMsg('RBA_90_01_01_03_110','교육 채널')}</th>			
						<td>
							${condel.getSelect('EDU_CCD','' ,'' , 'A402','', 'ALL', 'ALL')}		
						</td>
					</tr>
					<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_03_104','교육 시작일')}</th>
						<td>
						<div class='calendar'>
							${condel.getInputDateDx('START_DT', stDay)}
						</div>
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_03_105','교육 종료일')}</th>
						<td>
							<div class='calendar'>
								${condel.getInputDateDx('END_DT', edDay)}
							</div>				
						</td>	
					</tr>
					
					<th class="title required">${msgel.getMsg('RBA_99_01_01_02_024','과정별 교육 시간')}</th>
						<td>
							<input type="text" class="cond-input-text" name="EDU_HH" id="EDU_HH" style="width:50px;" value="${EDU_HH}"/>
							&nbsp;${msgel.getMsg('RBA_99_01_01_02_018','시간')}					
						</td>	
					
					<tr>
						<th class="title">${msgel.getMsg('RBA_99_01_01_02_015','교육 목적')}</th>
						<td colspan="3">				
							<textarea class="textarea-box" style="height : 80px; width: 100%;" id="EDU_OBJ_CTNT" name="EDU_OBJ_CTNT"></textarea>
						</td>
					</tr>
					<tr>
						<th class="title">${msgel.getMsg('RBA_99_01_01_02_012','교육 장소')}</th>
						<td colspan="3"><input type="text" class="cond-input-text" name="EDU_POS" id="EDU_POS"/></td>
					</tr>
					
					<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_03_108','교육 대상')}</th>
						<td colspan="3">
							<table>
								<tr	style="border-bottom:0;">
								<td>
									<input type="checkbox" id="ISDIREC" name="ISDIREC" value="Y" class="div-cont-box-checkbox">
				                    <label for="ISDIREC"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_005','이사회')}
								</td>
								<td>
									<input type="checkbox" id="ISMNG" name="ISMNG" value="Y" class="div-cont-box-checkbox">
				                    <label for="ISMNG"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_006','경영진')}		                    
								</td>
								<td>
									<input type="checkbox" id="ISDEDIC" name="ISDEDIC" value="Y" class="div-cont-box-checkbox">
				                    <label for="ISDEDIC"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_007','전담부서')}		                    
								</td>
								<td>
									<input type="checkbox" id="ISAUDIT" name="ISAUDIT" value="Y" class="div-cont-box-checkbox">
				                    <label for="ISAUDIT"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_008','감사부서')}		                    
								</td>
								</tr>						
								<tr style="border-bottom:0;">
								<td>
									<input type="checkbox" id="ISSALES" name="ISSALES" value="Y" class="div-cont-box-checkbox">
				                    <label for="ISSALES"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_009','영업부점')}
				                    
								</td>
								<td>
									<input type="checkbox" id="ISNEWEMP" name="ISNEWEMP" value="Y" class="div-cont-box-checkbox">
				                    <label for="ISNEWEMP"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_010','신입 직원')}
				                    
								</td>
		 						<td>
									<input type="checkbox" id="ISNOMAL" name="ISNOMAL" value="Y" class="div-cont-box-checkbox">
				                    <label for="ISNOMAL"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_011','일반 직원')}		                    
								</td>
		 						<td>
									<input type="checkbox" id="ISPERSONAL" name="ISPERSONAL" value="Y" class="div-cont-box-checkbox">
				                    <label for="ISPERSONAL"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_034','기타')}		
								</td>
								<td>
									<!-- 직접입력에 대한 대상을 테이블내 안쓰는 컬럼을 활용하여 개발 -->
				                    <input type="text" class="cond-input-text" name="TCHR_CERT_CCD" id="TCHR_CERT_CCD" maxlength="5" style="width: min-content;"/>
								</td>
								</tr>
							</table>                           
						</td>
					</tr>
					<tr>
						<th class="title required">${msgel.getMsg('RBA_99_01_01_02_027','교육 대상자 수')}</th>
						<td>
							<input type="text" class="cond-input-text" name="EDU_STD_CNT" id="EDU_STD_CNT" />
						</td>
						<th class="title required">${msgel.getMsg('RBA_99_01_01_02_028','교육 수료자 수')}</th>
						<td>
							<input type="text" class="cond-input-text" name="EDU_ESTD_CNT" id="EDU_ESTD_CNT"/>
						</td>	
					</tr>
					<tr>
						<th class="title">${msgel.getMsg('RBA_99_01_01_02_026','이해도 점검 포함여부')}</th>
						<td style="text-align: center;">${radioel.getRadioBtns('{radioBtnID:"EDU_CHK_YN",cdID:"A405"}')}</td>
					</tr>
					<tr>
						<table class="file-table">
						     <thead>
						      <tr>
						        <th colspan="4" style="padding: 0;">
						        
						          <table style="border-collapse: collapse; width: 100%; border:none;" >
						           <tr>
						             <td style="width:65%;border: none;text-align: center;">
						               <span style="font-weight: bold;">${msgel.getMsg('RBA_99_01_01_02_033', '교육 증빙 관리')}</span>
						                <br>
						               <span style="font-size: 11px; color: gray;">
						               	 <p> 교육자료 , 수강증빙자료 , 자체교육/이해도 점검 교육 증빙자료를 첨부하세요. </p>
						               </span>
	<!-- 					               <span style="font-size: 11px; color: gray;"> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">교육자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*교육에 활용된 일체의 전자ㆍ비전자 문서</p><br> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">수강증빙자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*수강생 서명, 수강확인증 등 수강 증빙 자료</p><br> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">자체교육/이해도 점검 교육 증빙자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*자체교육/이해도 점검 교육의 각 요건 충족여부 등을 증빙할 수 있는 자료</p><br> -->
	<!-- 					               </span> -->
						             </td>
						             <td style="border: none; text-align: right; padding-top: 10px;">
						               <div id="file-uploader" style="margin-left: auto;"></div>
						             </td>
						           </tr>
						          </table>
						          
						        </th>
						      </tr>
						      <tr>
						        <th style="width:5%;" >${msgel.getMsg('AML_10_25_02_02_018', 'No.')}</th>
						        <th class="file-name">${msgel.getMsg('AML_10_25_02_02_019', '파일명')}</th>
						        <th style="width:10%;" >${msgel.getMsg('AML_10_25_02_02_020', '파일크기')}</th>
						        <th style="width:10%;" >${msgel.getMsg('AML_10_25_02_02_021', 'Action')}</th>
						      </tr>
						     </thead>
						     <tbody id="fileBox">
						     
							     <c:choose>
							      <c:when test="${ fn:length( FILES ) == 0 }">
							      
							        <tr>
							         <td colspan="4" style="text-align: center;" >&nbsp;</td>
							        </tr>
							        
							      </c:when>
							      <c:otherwise>
							      
								       <c:forEach items="${FILES}" var="result" varStatus="status">
								         <c:set var="i" value="${status.index}" />
								         <tr id="file${i}" class="tx">
								           <td style="text-align: center;" >${i+1}</td>
								           <td class="file-name">
										   	 <a href="javascript:void(0);" class="link" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" ><c:out value="${result.LOSC_FILE_NM }"/></a>
										   </td>
										   <td style="text-align: center;"><c:out value="${result.FILE_SIZE}"/>&nbsp;kb</td>   	
										   <td style="text-align: center;">
										   
										   <% if( ("N").equals(addGubun)  && ( !("3").equals(GYLJ_S_C) || !("12").equals(GYLJ_S_C) || !("22").equals(GYLJ_S_C))  ) { %>
									             <a onclick="prdViewDelete(this);" > 
										              <input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.FILE_SIZE }"/>"/>
												 	  <input name="origFileNms" class="origFileNms" type="hidden" value="<c:out value="${result.LOSC_FILE_NM }"/>"/>
													  <input name="storedFileNms" class="storedFileNms" type="hidden" value="<c:out value="${result.PHSC_FILE_NM }"/>"/>
													  <input name="filePaths" id="filePaths" class="filePaths" type="hidden" value="<c:out value="${result.FILE_POS }"/>"/>
													  <div class="dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon" role="button" aria-hidden="true" aria-label="close">
													    <div class="dx-button-content"><span class="delete-link">${msgel.getMsg('AML_10_25_02_02_035', '삭제')}</span></div>
													  </div>
												 </a>
										   <% } %>
								           </td>			    	
										 </tr>
									   </c:forEach>
								   
								  </c:otherwise>
								 </c:choose>
							   
						     </tbody>
						   </table>
					 </tr>
            <% } else if(("N").equals(addGubun) && ( ("3").equals(GYLJ_S_C) || ("12").equals(GYLJ_S_C) || ("22").equals(GYLJ_S_C))) { %>
				            <tr>
								<th class="title required">${msgel.getMsg('RBA_90_01_01_03_103','교육 과정명')}</th>
								<td colspan="3">
									<input type="text" class="cond-input-text" name="EDU_NM" id="EDU_NM" value="${EDU_NM}" disabled/>
								</td>
							</tr>
							<tr>	
								<th class="title">${msgel.getMsg('RBA_90_01_01_03_106','교육 기관')}</th>
								<td>					
									${condel.getSelect('CRE_OGN_CCD','' ,'' , 'A401','', '', '')}		
								</td>
								<th >${msgel.getMsg('RBA_99_01_01_02_030','기관명')}</th>
								<td>
									<input type="text" class="cond-input-text" name="OGN_NM" id="OGN_NM" value="${OGN_NM}" disabled/>
								</td>
							</tr>
							
							
							<tr>
								<th class="title">${msgel.getMsg('RBA_99_01_01_02_013','강사명')}</th>
								<td>
									<input type="text" class="cond-input-text" name="TCHR_NM" id="TCHR_NM" value="${TCHR_NM}" disabled/>
								</td>	
							</tr>
							<tr>
								<th class="title">${msgel.getMsg('RBA_99_01_01_02_023','강사 약력')}</th>
								<td>
									<textarea class="textarea-box" style="width: 262%;" id="TCHR_HIST" name="TCHR_HIST" value="${TCHR_HIST}" disabled></textarea>
									<h5>* 5개 전문자격증 보유여부 등 AML, 전문성 입증 내용</h5>
								</td>	
							</tr>
							
							<tr>
								<th class="title">${msgel.getMsg('RBA_90_01_01_03_110','교육 채널')}</th>			
								<td>
									${condel.getSelect('EDU_CCD','' ,'' , 'A402','${EDU_CCD}', 'ALL', 'ALL')}		
								</td>
							</tr>
							<tr>
								<th class="title required">${msgel.getMsg('RBA_90_01_01_03_104','교육 시작일')}</th>
								<td>
								<div class='calendar'>
									${condel.getInputDateDx('START_DT', stDay)}
								</div>
								</td>
								<th class="title required">${msgel.getMsg('RBA_90_01_01_03_105','교육 종료일')}</th>
								<td>
									<div class='calendar'>
										${condel.getInputDateDx('END_DT', edDay)}
									</div>				
								</td>	
							</tr>
							
							<th class="title required">${msgel.getMsg('RBA_99_01_01_02_024','과정별 교육 시간')}</th>
								<td>
									<input type="text" class="cond-input-text" name="EDU_HH" id="EDU_HH" style="width:50px;" value="${EDU_HH}" disabled/>
									&nbsp;${msgel.getMsg('RBA_99_01_01_02_018','시간')}					
								</td>	
							
							<tr>
								<th class="title">${msgel.getMsg('RBA_99_01_01_02_015','교육 목적')}</th>
								<td colspan="3">				
									<textarea class="textarea-box" style="height : 80px; width: 100%;" id="EDU_OBJ_CTNT" name="EDU_OBJ_CTNT" value="${EDU_OBJ_CTNT}" disabled></textarea>
								</td>
							</tr>
							<tr>
								<th class="title">${msgel.getMsg('RBA_99_01_01_02_012','교육 장소')}</th>
								<td colspan="3"><input type="text" class="cond-input-text" name="EDU_POS" id="EDU_POS" value="${EDU_POS}" disabled/></td>
							</tr>
							
							<tr>
								<th class="title required">${msgel.getMsg('RBA_90_01_01_03_108','교육 대상')}</th>
								<td colspan="3">
									<table>
										<tr	style="border-bottom:0;">
											<td>
												<input type="checkbox" id="ISDIREC" name="ISDIREC" class="div-cont-box-checkbox" ${"Y".equals(ISDIREC) ? "checked='checked'":""} disabled>
							                    <label for="ISDIREC"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_005','이사회')}
											</td>
											<td>
												<input type="checkbox" id="ISMNG" name="ISMNG" class="div-cont-box-checkbox" ${"Y".equals(ISMNG) ? "checked='checked'":""} disabled>
							                    <label for="ISMNG"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_006','경영진')}		                    
											</td>
											<td>
												<input type="checkbox" id="ISDEDIC" name="ISDEDIC" class="div-cont-box-checkbox" ${"Y".equals(ISDEDIC) ? "checked='checked'":""} disabled>
							                    <label for="ISDEDIC"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_007','전담부서')}		                    
											</td>
											<td>
												<input type="checkbox" id="ISAUDIT" name="ISAUDIT" class="div-cont-box-checkbox" ${"Y".equals(ISAUDIT) ? "checked='checked'":""} disabled>
							                    <label for="ISAUDIT"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_008','감사부서')}		                    
											</td>
										</tr>						
										<tr style="border-bottom:0;">
											<td>
												<input type="checkbox" id="ISSALES" name="ISSALES" class="div-cont-box-checkbox" ${"Y".equals(ISSALES) ? "checked='checked'":""} disabled>
							                    <label for="ISSALES"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_009','영업부점')}
							                    
											</td>
											<td>
												<input type="checkbox" id="ISNEWEMP" name="ISNEWEMP" class="div-cont-box-checkbox" ${"Y".equals(ISNEWEMP) ? "checked='checked'":""} disabled>
							                    <label for="ISNEWEMP"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_010','신입 직원')}
							                    
											</td>
											<td>
												<input type="checkbox" id="ISNOMAL" name="ISNOMAL" class="div-cont-box-checkbox" ${"Y".equals(ISNOMAL) ? "checked='checked'":""} disabled>
							                    <label for="ISNOMAL"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_011','일반 직원')}		                    
											</td>
											<td>
							                    <input type="checkbox" id="ISPERSONAL" name="ISPERSONAL" class="div-cont-box-checkbox" ${"Y".equals(ISPERSONAL) ? "checked='checked'":""} disabled>
							                    <label for="ISPERSONAL"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_034','기타')}		 	
											</td>
											<td>
												<!-- 직접입력에 대한 대상을 테이블내 안쓰는 컬럼을 활용하여 개발 -->
							                    <input type="text" class="cond-input-text" name="TCHR_CERT_CCD" id="TCHR_CERT_CCD" value="${TCHR_CERT_CCD}" maxlength="5" disabled/>  		                  
											</td>
										</tr>
									</table>                           
								</td>
							</tr>
							<tr>
								<th class="title required">${msgel.getMsg('RBA_99_01_01_02_027','교육 대상자 수')}</th>
								<td>
									<input type="text" class="cond-input-text" name="EDU_STD_CNT" id="EDU_STD_CNT" value="${EDU_STD_CNT}" disabled/>
								</td>
								<th class="title required">${msgel.getMsg('RBA_99_01_01_02_028','교육 수료자 수')}</th>
								<td>
									<input type="text" class="cond-input-text" name="EDU_ESTD_CNT" id="EDU_ESTD_CNT" value="${EDU_ESTD_CNT}" disabled/>
								</td>	
							</tr>
							<tr>
								<th class="title">${msgel.getMsg('RBA_99_01_01_02_026','이해도 점검 포함여부')}</th>
								<td style="text-align: center;">${radioel.getRadioBtns('{radioBtnID:"EDU_CHK_YN",cdID:"A405"}')}</td>
							</tr>
							<tr>
						<table class="file-table">
						     <thead>
						      <tr>
						        <th colspan="4" style="padding: 0;">
						        
						          <table style="border-collapse: collapse; width: 100%; border:none;" >
						           <tr>
						             <td style="width:65%;border: none;text-align: center;">
						               <span style="font-weight: bold;">${msgel.getMsg('RBA_99_01_01_02_033', '교육 증빙 관리')}</span>
						                <br>
						               <span style="font-size: 11px; color: gray;">
						               	 <p> 교육자료 , 수강증빙자료 , 자체교육/이해도 점검 교육 증빙자료를 첨부하세요. </p>
						               </span>
	<!-- 					               <span style="font-size: 11px; color: gray;"> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">교육자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*교육에 활용된 일체의 전자ㆍ비전자 문서</p><br> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">수강증빙자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*수강생 서명, 수강확인증 등 수강 증빙 자료</p><br> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">자체교육/이해도 점검 교육 증빙자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*자체교육/이해도 점검 교육의 각 요건 충족여부 등을 증빙할 수 있는 자료</p><br> -->
	<!-- 					               </span> -->
						             </td>
						             <td style="border: none; text-align: right; padding-top: 10px;">
						               <div id="file-uploader" style="margin-left: auto;"></div>
						             </td>
						           </tr>
						          </table>
						          
						        </th>
						      </tr>
						      <tr>
						        <th style="width:5%;" >${msgel.getMsg('AML_10_25_02_02_018', 'No.')}</th>
						        <th class="file-name">${msgel.getMsg('AML_10_25_02_02_019', '파일명')}</th>
						        <th style="width:10%;" >${msgel.getMsg('AML_10_25_02_02_020', '파일크기')}</th>
						        <th style="width:10%;" >${msgel.getMsg('AML_10_25_02_02_021', 'Action')}</th>
						      </tr>
						     </thead>
						     <tbody id="fileBox">
						     
							     <c:choose>
							      <c:when test="${ fn:length( FILES ) == 0 }">
							      
							        <tr>
							         <td colspan="4" style="text-align: center;" >&nbsp;</td>
							        </tr>
							        
							      </c:when>
							      <c:otherwise>
							      
								       <c:forEach items="${FILES}" var="result" varStatus="status">
								         <c:set var="i" value="${status.index}" />
								         <tr id="file${i}" class="tx">
								           <td style="text-align: center;" >${i+1}</td>
								           <td class="file-name">
										   	 <a href="javascript:void(0);" class="link" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" ><c:out value="${result.LOSC_FILE_NM }"/></a>
										   </td>
										   <td style="text-align: center;"><c:out value="${result.FILE_SIZE}"/>&nbsp;kb</td>   	
										   <td style="text-align: center;">
								             <a onclick="prdViewDelete(this);" > 
									              <input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.FILE_SIZE }"/>"/>
											 	  <input name="origFileNms" class="origFileNms" type="hidden" value="<c:out value="${result.LOSC_FILE_NM }"/>"/>
												  <input name="storedFileNms" class="storedFileNms" type="hidden" value="<c:out value="${result.PHSC_FILE_NM }"/>"/>
												  <input name="filePaths" id="filePaths" class="filePaths" type="hidden" value="<c:out value="${result.FILE_POS }"/>"/>
												  <div class="dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon" role="button" aria-hidden="true" aria-label="close">
												    <div class="dx-button-content"><span class="delete-link">${msgel.getMsg('AML_10_25_02_02_035', '삭제')}</span></div>
												  </div>
											 </a>
								           </td>			    	
										 </tr>
									   </c:forEach>
								   
								  </c:otherwise>
								 </c:choose>
							   
						     </tbody>
						   </table>
					 </tr>
            <% } else if( ("N").equals(addGubun)  ) { %>
	            			<tr>
									<th class="title required">${msgel.getMsg('RBA_90_01_01_03_103','교육 과정명')}</th>
									<td colspan="3">
										<input type="text" class="cond-input-text" name="EDU_NM" id="EDU_NM" value="${EDU_NM}"/>
									</td>
								</tr>
								<tr>	
									<th class="title">${msgel.getMsg('RBA_90_01_01_03_106','교육 기관')}</th>
									<td>					
										${condel.getSelect('CRE_OGN_CCD','' ,'' , 'A401','', '', '')}		
									</td>
									<th >${msgel.getMsg('RBA_99_01_01_02_030','기관명')}</th>
									<td>
										<input type="text" class="cond-input-text" name="OGN_NM" id="OGN_NM" value="${OGN_NM}"/>
									</td>
								</tr>
								
								
								<tr>
									<th class="title">${msgel.getMsg('RBA_99_01_01_02_013','강사명')}</th>
									<td>
										<input type="text" class="cond-input-text" name="TCHR_NM" id="TCHR_NM" value="${TCHR_NM}"/>
									</td>	
								</tr>
								<tr>
									<th class="title">${msgel.getMsg('RBA_99_01_01_02_023','강사 약력')}</th>
									<td>
										<textarea class="textarea-box" style="width: 262%;" id="TCHR_HIST" name="TCHR_HIST" value="${TCHR_HIST}"></textarea>
										<h5>* 5개 전문자격증 보유여부 등 AML, 전문성 입증 내용</h5>
									</td>	
								</tr>
								
								<tr>
									<th class="title">${msgel.getMsg('RBA_90_01_01_03_110','교육 채널')}</th>			
									<td>
										${condel.getSelect('EDU_CCD','' ,'' , 'A402','${EDU_CCD}', 'ALL', 'ALL')}		
									</td>
								</tr>
								<tr>
									<th class="title required">${msgel.getMsg('RBA_90_01_01_03_104','교육 시작일')}</th>
									<td>
									<div class='calendar'>
										${condel.getInputDateDx('START_DT', stDay)}
									</div>
									</td>
									<th class="title required">${msgel.getMsg('RBA_90_01_01_03_105','교육 종료일')}</th>
									<td>
										<div class='calendar'>
											${condel.getInputDateDx('END_DT', edDay)}
										</div>				
									</td>	
								</tr>
								
								<th class="title required">${msgel.getMsg('RBA_99_01_01_02_024','과정별 교육 시간')}</th>
									<td>
										<input type="text" class="cond-input-text" name="EDU_HH" id="EDU_HH" style="width:50px;" value="${EDU_HH}"/>
										&nbsp;${msgel.getMsg('RBA_99_01_01_02_018','시간')}					
									</td>	
								
								<tr>
									<th class="title">${msgel.getMsg('RBA_99_01_01_02_015','교육 목적')}</th>
									<td colspan="3">				
										<textarea class="textarea-box" style="height : 80px; width: 100%;" id="EDU_OBJ_CTNT" name="EDU_OBJ_CTNT" value="${EDU_OBJ_CTNT}"></textarea>
									</td>
								</tr>
								<tr>
									<th class="title">${msgel.getMsg('RBA_99_01_01_02_012','교육 장소')}</th>
									<td colspan="3"><input type="text" class="cond-input-text" name="EDU_POS" id="EDU_POS" value="${EDU_POS}"/></td>
								</tr>
								
								<tr>
									<th class="title required">${msgel.getMsg('RBA_90_01_01_03_108','교육 대상')}</th>
									<td colspan="3">
										<table>
											<tr	style="border-bottom:0;">
												<td>
													<input type="checkbox" id="ISDIREC" name="ISDIREC" class="div-cont-box-checkbox" ${"Y".equals(ISDIREC) ? "checked='checked'":""}>
								                    <label for="ISDIREC"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_005','이사회')}
												</td>
												<td>
													<input type="checkbox" id="ISMNG" name="ISMNG" class="div-cont-box-checkbox" ${"Y".equals(ISMNG) ? "checked='checked'":""}>
								                    <label for="ISMNG"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_006','경영진')}		                    
												</td>
												<td>
													<input type="checkbox" id="ISDEDIC" name="ISDEDIC" class="div-cont-box-checkbox" ${"Y".equals(ISDEDIC) ? "checked='checked'":""}>
								                    <label for="ISDEDIC"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_007','전담부서')}		                    
												</td>
												<td>
													<input type="checkbox" id="ISAUDIT" name="ISAUDIT" class="div-cont-box-checkbox" ${"Y".equals(ISAUDIT) ? "checked='checked'":""}>
								                    <label for="ISAUDIT"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_008','감사부서')}		                    
												</td>
											</tr>						
											<tr style="border-bottom:0;">
												<td>
													<input type="checkbox" id="ISSALES" name="ISSALES" class="div-cont-box-checkbox" ${"Y".equals(ISSALES) ? "checked='checked'":""}>
								                    <label for="ISSALES"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_009','영업부점')}
								                    
												</td>
												<td>
													<input type="checkbox" id="ISNEWEMP" name="ISNEWEMP" class="div-cont-box-checkbox" ${"Y".equals(ISNEWEMP) ? "checked='checked'":""}>
								                    <label for="ISNEWEMP"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_010','신입 직원')}
								                    
												</td>
												<td>
													<input type="checkbox" id="ISNOMAL" name="ISNOMAL" class="div-cont-box-checkbox" ${"Y".equals(ISNOMAL) ? "checked='checked'":""}>
								                    <label for="ISNOMAL"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_011','일반 직원')}		                    
												</td>
												<td>
								                    <input type="checkbox" id="ISPERSONAL" name="ISPERSONAL" class="div-cont-box-checkbox" ${"Y".equals(ISPERSONAL) ? "checked='checked'":""}>
								                    <label for="ISPERSONAL"></label>&nbsp;${msgel.getMsg('RBA_99_01_01_02_034','기타')}		
												</td>
												<td>
													<!-- 직접입력에 대한 대상을 테이블내 안쓰는 컬럼을 활용하여 개발 -->
								                    <input type="text" class="cond-input-text" name="TCHR_CERT_CCD" id="TCHR_CERT_CCD"  value="${TCHR_CERT_CCD}" maxlength="5"/>  		                  
												</td>
											</tr>
										</table>                           
									</td>
								</tr>
								<tr>
									<th class="title required">${msgel.getMsg('RBA_99_01_01_02_027','교육 대상자 수')}</th>
									<td>
										<input type="text" class="cond-input-text" name="EDU_STD_CNT" id="EDU_STD_CNT" value="${EDU_STD_CNT}"/>
									</td>
									<th class="title required">${msgel.getMsg('RBA_99_01_01_02_028','교육 수료자 수')}</th>
									<td>
										<input type="text" class="cond-input-text" name="EDU_ESTD_CNT" id="EDU_ESTD_CNT" value="${EDU_ESTD_CNT}"/>
									</td>	
								</tr>
								<tr>
									<th class="title">${msgel.getMsg('RBA_99_01_01_02_026','이해도 점검 포함여부')}</th>
									<td style="text-align: center;">${radioel.getRadioBtns('{radioBtnID:"EDU_CHK_YN",cdID:"A405"}')}</td>
								</tr>
								<tr>
						<table class="file-table">
						     <thead>
						      <tr>
						        <th colspan="4" style="padding: 0;">
						        
						          <table style="border-collapse: collapse; width: 100%; border:none;" >
						           <tr>
						             <td style="width:65%;border: none;text-align: center;">
						               <span style="font-weight: bold;">${msgel.getMsg('RBA_99_01_01_02_033', '교육 증빙 관리')}</span>
						                <br>
						               <span style="font-size: 11px; color: gray;">
						               	 <p> 교육자료 , 수강증빙자료 , 자체교육/이해도 점검 교육 증빙자료를 첨부하세요. </p>
						               </span>
	<!-- 					               <span style="font-size: 11px; color: gray;"> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">교육자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*교육에 활용된 일체의 전자ㆍ비전자 문서</p><br> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">수강증빙자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*수강생 서명, 수강확인증 등 수강 증빙 자료</p><br> -->
	<!-- 					               	<p style="text-align: left;font-weight: bold;">자체교육/이해도 점검 교육 증빙자료</p><br> -->
	<!-- 					               	<p style="text-align: left;">*자체교육/이해도 점검 교육의 각 요건 충족여부 등을 증빙할 수 있는 자료</p><br> -->
	<!-- 					               </span> -->
						             </td>
						             <td style="border: none; text-align: right; padding-top: 10px;">
						               <div id="file-uploader" style="margin-left: auto;"></div>
						             </td>
						           </tr>
						          </table>
						          
						        </th>
						      </tr>
						      <tr>
						        <th style="width:5%;" >${msgel.getMsg('AML_10_25_02_02_018', 'No.')}</th>
						        <th class="file-name">${msgel.getMsg('AML_10_25_02_02_019', '파일명')}</th>
						        <th style="width:10%;" >${msgel.getMsg('AML_10_25_02_02_020', '파일크기')}</th>
						        <th style="width:10%;" >${msgel.getMsg('AML_10_25_02_02_021', 'Action')}</th>
						      </tr>
						     </thead>
						     <tbody id="fileBox">
						     
							     <c:choose>
							      <c:when test="${ fn:length( FILES ) == 0 }">
							      
							        <tr>
							         <td colspan="4" style="text-align: center;" >&nbsp;</td>
							        </tr>
							        
							      </c:when>
							      <c:otherwise>
							      
								       <c:forEach items="${FILES}" var="result" varStatus="status">
								         <c:set var="i" value="${status.index}" />
								         <tr id="file${i}" class="tx">
								           <td style="text-align: center;" >${i+1}</td>
								           <td class="file-name">
										   	 <a href="javascript:void(0);" class="link" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" ><c:out value="${result.LOSC_FILE_NM }"/></a>
										   </td>
										   <td style="text-align: center;"><c:out value="${result.FILE_SIZE}"/>&nbsp;kb</td>   	
										   <td style="text-align: center;">
								             <a onclick="prdViewDelete(this);" > 
									              <input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.FILE_SIZE }"/>"/>
											 	  <input name="origFileNms" class="origFileNms" type="hidden" value="<c:out value="${result.LOSC_FILE_NM }"/>"/>
												  <input name="storedFileNms" class="storedFileNms" type="hidden" value="<c:out value="${result.PHSC_FILE_NM }"/>"/>
												  <input name="filePaths" id="filePaths" class="filePaths" type="hidden" value="<c:out value="${result.FILE_POS }"/>"/>
												  <div class="dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon" role="button" aria-hidden="true" aria-label="close">
												    <div class="dx-button-content"><span class="delete-link">${msgel.getMsg('AML_10_25_02_02_035', '삭제')}</span></div>
												  </div>
											 </a>
								           </td>			    	
										 </tr>
									   </c:forEach>
								   
								  </c:otherwise>
								 </c:choose>
							   
						     </tbody>
						   </table>
					 </tr>
            <% } %>
		</table>
	</div>
	
        <div class="tab-content-bottom">
	      <h3 class="tab-content-title">${msgel.getMsg('RBA_99_01_01_02_029', '교육 이수자 명세')}</h3>
	      <p class="guide-text" style="font-size: small;color: crimson;">※ [사번] 필드의 돋보기 아이콘을 클릭하여 직접 사번을 입력하거나 [사번] 필드를 클릭하여 "사용자 검색" 팝업을 호출할 수 있습니다.</p>
	      <div id="GTDataGrid1_Area"></div>
	    </div>
	
	<div class="tab-content-top">
		<div class="button-area" style="margin-top:5px;">
			<%if(("Y").equals(addGubun)) { %>
				${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
			<% } else if( ("N").equals(addGubun)  && ( ("3").equals(GYLJ_S_C) || ("12").equals(GYLJ_S_C) || ("22").equals(GYLJ_S_C))  ) { %>
<%-- 				${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doUpdate", cssClass:"btn-36"}')} --%>
			<% } else if(("N").equals(addGubun)) { %>
				${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doUpdate", cssClass:"btn-36"}')}
			<% } %>
 			${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"templateDownload", defaultValue:"템플릿다운로드", mode:"C", function:"TemplateDownload", cssClass:"btn-36 outlined"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"uploadBtn", defaultValue:"파일 Upload", mode:"U", function:"raFileUpload", cssClass:"btn-36 upload"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"Popup_Close", cssClass:"btn-36"}')}
		</div>
	</div>
	<div id="JKWListFile" style="display:none;" />
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 