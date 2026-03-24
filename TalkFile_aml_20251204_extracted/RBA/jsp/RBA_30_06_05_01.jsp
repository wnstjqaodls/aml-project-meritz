<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_30_06_05_01.jsp
- Author     : 권얼
- Comment    : KRI 후속조치 현황 > KRI 개선조치 관리
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
<script language="JavaScript">
    
	var GridObj1;
	var overlay = new Overlay();
	var classID= "RBA_30_06_05_01";
	
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
			 		height	:"calc(90vh - 110px)",
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
		            export               : {allowExportSelectedData: true, enabled : true, excelFilterEnabled : true, fileName : "${pageTitle}"},
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
		                mode: "virtual"
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
		    	    	{dataField: "CNT", 					caption: '${msgel.getMsg("RBA_30_06_01_01_001","순번")}' , alignment: "center"}, 
		    	        {dataField: "RSK_CATG1_C",			caption: '${msgel.getMsg("RBA_30_06_05_01_002","위험분류 Lv.1")}',		alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, visible:false},
		    	        {dataField: "RSK_CATG1_C_NM",		caption: '${msgel.getMsg("RBA_30_06_05_01_002","위험분류 Lv.1")}',		alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true},
		    	        
		    	        {dataField: "RSK_CATG2_C",			caption: '${msgel.getMsg("RBA_30_06_05_01_003","위험분류 Lv.2")}',		alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true , visible:false}, 
		    	        {dataField: "RSK_CATG2_C_NM",		caption: '${msgel.getMsg("RBA_30_06_05_01_003","위험분류 Lv.2")}',		alignment: "center",allowResizing: true,allowSearch  : true,allowSorting : true },

		    	        {dataField: "RSK_ELMT_C",			caption: '${msgel.getMsg("RBA_30_06_05_01_005","위험요소")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, visible:false}, 
		    	        {dataField: "RSK_ELMT_C_NM",		caption: '${msgel.getMsg("RBA_30_06_05_01_005","위험요소")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting : true, "cssClass": "link"}, 
		    	        {dataField: "MSUR_FRQ",				caption: '${msgel.getMsg("RBA_30_06_05_01_019","평가산출 기준")}',
		    	        	lookup : {
		    	        		dataSource : [
		    	        			{ code : "1" , name : "해당 고객 수" },
		    	        			{ code : "2" , name : "해당 거래금액" },
		    	        		],
		    	        		valueExpr : "code",
		    	        		displayExpr : "name"
		    	        	},
		    	        	alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true
		    	        }, 
		    	        {dataField: "APPLY_STD",			caption: '${msgel.getMsg("RBA_30_06_05_01_020","적용기준")}',		
		    	        	lookup : {
		    	        		dataSource : [
		    	        			{ code : "1" , name : "발생 규모" },
		    	        			{ code : "2" , name : "상승률" },
		    	        		],
		    	        		valueExpr : "code",
		    	        		displayExpr : "name"
		    	        	},
		    	        	alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true
		    	        }, 
		    	        {dataField: "MONITOR_CYCLE",				caption: '${msgel.getMsg("RBA_30_06_01_01_010","모니터링 주기")}',	
		    	        	lookup : {
		    	        		dataSource : [
		    	        			{ code : "6" , name : "반기" },
		    	        		],
		    	        		valueExpr : "code",
		    	        		displayExpr : "name"
		    	        	},
		    	        	alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true
		    	        }, 
		    	        {dataField: "BRNO_NM",				caption: '${msgel.getMsg("RBA_30_06_05_01_012","대상부점")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true },
		    	        {dataField: "BAS_YYMM_LONG",				caption: '${msgel.getMsg("RBA_30_06_05_01_010","한도초과발생기간")}',	
		    	        	calculateCellValue : function(rowData){
		    	        		return rowData.BAS_YYMM + " / " + rowData.BAS_LONG_NM;
		    	        	},alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true
		    	        },
		    	        {dataField: "IMPRV_STRG_DT",		caption: '${msgel.getMsg("RBA_30_06_02_02_002","조치요청일자")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true },
		    	        {dataField: "IMPRV_RSLT_DT",		caption: '${msgel.getMsg("RBA_30_06_02_02_003","조치이행일자")}',			alignment: "center",allowResizing: true,allowSearch: true,allowSorting: true },
		    	        {dataField:'GYLJ_ID', visible:false, allowSearch:false},
		    	        {dataField: "GYLJ_S_C_NM",			caption: '${msgel.getMsg("RBA_30_06_05_01_011","결재상태")}', alignment: "center",allowResizing: true, allowSearch: true, allowSorting: true,cssClass:"link" }
// 		    	        {dataField: "CHECK_YN",				caption: '${msgel.getMsg("RBA_30_06_05_01_015","결재현황")}',			alignment: "left",allowResizing: true,allowSearch: true,allowSorting: true}
		    	    ],
			 	    summary: {
			 	        totalItems: [
			 	            {
			 	                column     : "CNT",
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
			 	   ,"summary" :{totalItems: [{column: 'CNT', summaryType: 'count', valueFormat: "fixedPoint"}],
   					texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}}
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
    
    // KRI 후속조치 현황 조회
    function doSearch() {
        overlay.show(true, true);
        
        var params = new Object();
        var methodID = "getSearch";
        var classID  = "RBA_30_06_05_01";
		params.pageID 	= "RBA_30_06_05_01"; 

		params.stDate1 = getDxDateVal("stDate1",true);
	    params.edDate1 = getDxDateVal("edDate1",true);
		params.stDate2 = getDxDateVal("stDate2",true);
	    params.edDate2 = getDxDateVal("edDate2",true);
		params.BAS_YYMM  = form.BAS_YYMM.value;				// 한도초과 발생기간(연도)
		params.BAS_LONG  = form.BAS_LONG.value;				// 한도초과 발생기간(반기)
		params.RPR_PRGRS_CCD = form.RPR_PRGRS_CCD.value;	// 결재상태
		
		
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
    
    function doSearchDetail(){
    	var selData  = GridObj1.getSelectedRowsData();

        if(selData == null || selData == ""){
        	showAlert('${msgel.getMsg("RBA_30_06_02_02_004","상세조회할 대상을 선택해주세요.")}','WARN');
        }else{	
        	var rowdata = selData[0];	//한 건만 선택
	        	 var form2              	= document.form2;
	             form2.pageID.value     	= "RBA_30_06_05_02";
	             form2.classID.value   		= "RBA_30_06_05_02";
	             form2.RSK_CATG1_C_NM.value = rowdata.RSK_CATG1_C_NM;		// 위험분류 Lv.1
                 form2.RSK_CATG2_C_NM.value = rowdata.RSK_CATG2_C_NM;		// 위험분류 Lv.2
                 form2.RSK_ELMT_C_NM.value  = rowdata.RSK_ELMT_C_NM;			// 위험요소
                 form2.BAS_YYMM.value  		= rowdata.BAS_YYMM;
                 form2.BRNO_NM.value 		= rowdata.BRNO_NM;						// 대상부점
                 form2.GYLJ_ID.value 		= rowdata.GYLJ_ID;						// 대상부점
	             form2.target           	= form2.pageID.value;
	             //var win                = window_popup_open(form2.pageID.value, 700, 580, '','yes');
	             var win; win          		= window_popup_open(form2.pageID.value, 1230, 560, '','yes');  //보안취약성 보완
	             form2.action           	= '<c:url value="/"/>0001.do';
	             form2.submit();
        }
        
    }
    
    // 그리드 클릭 - KRI 지표별 이력(RBA_30_06_05_02) 팝업 호출
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId) {
        
        if(colId == "RSK_ELMT_C_NM"){
            var form2              = document.form2;
            form2.pageID.value     = "RBA_30_06_05_02";
            form2.classID.value    = "RBA_30_06_05_02";
            form2.GYLJ_ID.value = obj.GYLJ_ID;		// 결재id
            form2.RSK_CATG1_C_NM.value = obj.RSK_CATG1_C_NM;		// 위험분류 Lv.1
            form2.RSK_CATG2_C_NM.value = obj.RSK_CATG2_C_NM;		// 위험분류 Lv.2
            form2.RSK_ELMT_C_NM.value = obj.RSK_ELMT_C_NM;			// 위험요소
            form2.BAS_YYMM.value  = obj.BAS_YYMM;
            form2.BRNO_NM.value = obj.BRNO_NM;						// 대상부점
            form2.target           = form2.pageID.value;
            
            //var win                = window_popup_open(form2.pageID.value, 700, 580, '','yes');
            var win; win          = window_popup_open(form2.pageID.value, 1230, 560, '','yes');  //보안취약성 보완
            form2.action           = '<c:url value="/"/>0001.do';
            form2.submit();
        
        }else if(colId == "GYLJ_S_C_NM") {
        	var form2              = document.form2;
        	form2.pageID.value = 'RBA_30_06_05_04';				// 결재이력 팝업
       		window_popup_open(form2.pageID.value, 1260, 400, '');
       		form2.RSK_CATG1_C_NM.value = obj.RSK_CATG1_C_NM;		// 위험분류 Lv.1
            form2.RSK_CATG2_C_NM.value = obj.RSK_CATG2_C_NM;		// 위험분류 Lv.2
            form2.RSK_ELMT_C_NM.value = obj.RSK_ELMT_C_NM;			// 위험요소
            form2.BRNO_NM.value = obj.BRNO_NM;						// 대상부점
            form2.GYLJ_ID.value = obj.GYLJ_ID;						// 대상부점
//             if(form2.GYLJ_ID.value == "0"){
//     			showAlert("${msgel.getMsg('RBA_90_01_04_01_108','결재이력이 없습니다.')}", "WARN");
//     			return;
//     		}
            
            form2.GYLJ_ID.value = obj.GYLJ_ID;						// 결재ID
//             alert(form2.GYLJ_ID.value);
            
    		form2.target            = form2.pageID.value;
            form2.action            = "<c:url value='/'/>0001.do";
            form2.submit();
        }
    }
    
</script>
<style>
	.inquiry-table .table-cell .title {
	    min-width: 140px;
	}
</style>
<form name="form2" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="ROLE_ID">
    <input type="hidden" name="RSK_CATG1_C_NM">
    <input type="hidden" name="RSK_CATG2_C_NM">
    <input type="hidden" name="RSK_ELMT_C_NM">
    <input type="hidden" name="BAS_YYMM">
    <input type="hidden" name="BRNO_NM" >
    <input type="hidden" name="BRNO2">
    <input type="hidden" name="GYLJ_ID"/>		<!-- 결재ID -->
   	<input type="hidden" name="GYLJ_S_C"/>		<!-- 결재상태코드 -->
   	<input type="hidden" name="GYLJ_S_C_NM"/>	<!-- 결재상태 -->
</form>

<form name="form" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
    <div class="inquiry-table type1" id='condBox1'>
        <div class="table-row">
				<div class="table-cell">
	            	${condel.getLabel("RBA_30_06_05_01_010","한도초과 발생기간")}
	            	<div class="content">
		            	${RBACondEL.getKRBASelect('BAS_YYMM','' ,'RBA_KRI_common_getComboData_BasYear' ,'' ,'' ,'' ,'doSearch()','','','ALL')}
				          	<select name='BAS_LONG' id='BAS_LONG' class="dropdown">
					           <option class="dropdown-option" value='01' selected>${msgel.getMsg('RBA_30_06_05_01_023','상반기')}</option> 
					           <option class="dropdown-option" value='02' >${msgel.getMsg('RBA_30_06_05_01_024','하반기')}</option>
				       		</select>
	            	</div>
	            </div>
				<div class="table-cell">
		    		${condel.getLabel("RBA_30_06_05_01_013","조치요청일자")}
					<div class="content">
						<div class='calendar'>
							${condel.getInputDateDx('stDate1',stDate1)} ~ ${condel.getInputDateDx('edDate1',edDate1)}
						</div>
					</div>
				</div>
		</div>
        <div class="table-row">
				 <div class="table-cell">
		           ${condel.getLabel('RBA_30_06_05_01_030','결재상태')}
		           <div class="content">
		             <select name="RPR_PRGRS_CCD" id="RPR_PRGRS_CCD" class="dropdown">
		                ${condel.getSelectOption('','K001','','ALL','ALL')}
		            </select>
		           </div>
		        </div>
				<div class="table-cell">
		    		${condel.getLabel("RBA_30_06_05_01_014","조치완료일자")}
					<div class="content">
						<div class='calendar'>
							${condel.getInputDateDx('stDate2',stDate2)} ~ ${condel.getInputDateDx('edDate2',edDate2)}
						</div>
					</div>
				</div>
	     </div>
	 	<div class="table-row">
			<div class="table-cell">
	        	${condel.getLabel('RBA_30_06_05_01_001','대상부점')} 	
				${condel.getBranchSearch('SEARCH_DEP_ID','ALL')}
            </div>
	         <div class="table-cell">
			</div>
	 	</div>
    </div>
    <div class="button-area">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA_Detail_Search", defaultValue:"상세조회", mode:"R", function:"doSearchDetail", cssClass:"btn-36"}')}        
	</div>
	<div class="tab-content-bottom" style="margin-top: 8px;">
            <div id="GTDataGrid1_Area"></div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />