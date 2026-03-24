<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
- File Name  : AML_10_25_01_01.jsp
- Author     : 
- Comment    : 신상품·서비스 위험평가 체크리스트
- Version    : 1.0
- history    : 1.0 2025-06
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 신상품·서비스 위험평가 체크리스트
* Comment         : AML7.4 conversion
* Group           : GTONE, AML서비스팀
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 
* Since           : 2025. 06.
********************************************************************************************************************************************
--%>
<%@page import="com.gtone.webadmin.util.JSONUtil,com.gtone.webadmin.util.CodeUtil"%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String sDate = DateUtil.addDays(DateUtil.getDateString(), -90, "yyyy-MM-dd");
    String eDate =DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
    request.setAttribute("stDate",sDate);
    request.setAttribute("edDate",eDate);
    
    //세션 결재자 정보
  	String ROLEID = sessionAML.getsAML_ROLE_ID();
  	request.setAttribute("ROLEID", ROLEID);
%>


<script language="JavaScript"> 

    var GridObj1 = null;
    var overlay = new Overlay();
    var pageID	 = "AML_10_25_01_01";	
	var classID  = "AML_10_25_01_01";
	var ROLEID   = "${ROLEID}";
    var dataSource = [];
    
    // [ Initialize ]
    $(document).ready(function(){
    	
       setupGrids();
       setupFilter("init");
       doSearch();
       
       
       if(ROLEID == '104') {
			$("#btn_02").hide();
       		$("#btn_03").hide();
       }else if(ROLEID == '4') {
    		$("#btn_02").show();
       		$("#btn_03").show();
       }else {
    	    $("#btn_02").hide();
      	    $("#btn_03").hide();
       }
       
    });
    
    function setupGrids(){
    	
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
    	elementAttr: { class: "grid-table-type" },
    	dataSource				: dataSource,
    	gridId          		: "GTDataGrid1",
    	onToolbarPreparing		: makeToolbarButtonGrids,
    	width					:"100%",
    	height					:"calc(-150px + 85vh)",
        hoverStateEnabled 		: true,
        wordWrapEnabled 		: false,
        allowColumnResizing 	: true,
        columnAutoWidth 		: true,
        allowColumnReordering 	: true,
        columnResizingMode 		: 'widget',
        cacheEnabled 			: false,
        cellHintEnabled 		: true,
        showBorders 			: true,
        showColumnLines 		: true,
        showRowLines 			: true,
        sorting					: { mode: "multiple"},
        loadPanel 				: { enabled: false },
        remoteOperations 		: {filtering:false, grouping:false, paging:false, sorting:false, summary:false},
        editing					: { mode: 'cell', allowUpdating: false, allowAdding : false},
        filterRow				: { visible: false },
        rowAlternationEnabled 	: true,
        columnFixing			: {	enabled: true},
        pager: {
   	    	visible: true
   	    	,showNavigationButtons: true
   	    	,showInfo: true
   	    },
   	    paging: {
   	    	enabled : true
   	    	,pageSize : 20
   	    },
	   	scrolling : {
           mode            : "standard"
          ,preloadEnabled  : false
        },
        searchPanel				: {visible: true, width: 250},
        noDataText				: '${msgel.getMsg("AML_20_01_10_01_103","조회된 데이터가 없습니다.")}',
        export 					: {allowExportSelectedData : true ,enabled : false ,excelFilterEnabled : true},
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
        },
        selection : {
        	 allowSelectAll : false
           , deferred : false
           , mode : 'multiple'  /*none, single, multiple*/
           , selectAllMode : 'allPages' /*: 'page' | 'allPages'*/
           , showCheckBoxesMode : 'always' /*'onClick' | 'onLongTap' | 'always' | 'none'*/
        },
        onCellPrepared        : function(e){
 	        var columnName = e.column.dataField;
 	        var dataGrid   = e.component;
 	        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
 	        var snCcd    = dataGrid.cellValue(rowIndex, 'SN_CCD');
 	        if(rowIndex != -1 && snCcd == "N"){
 	           e.cellElement.removeClass("link");
 	        }
 	    }
        , columns: [
              {dataField:'PRD_CK_ID', visible:false, allowSearch:false}
            , {dataField:'APP_NO', visible:false, allowSearch:false}
            , {dataField:'SN_CCD', visible:false, allowSearch:false}
            , {dataField:'VERSION_ID', caption:'${msgel.getMsg("AML_10_25_01_01_001","체크리스트 버전")}', alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, "width": "15%"}
            , {dataField:'TITLE',  caption:'${msgel.getMsg("AML_10_25_01_01_002","체크리스트 개요")}', alignment:'left', allowResizing:true, allowSorting:true, allowEditing:false, allowFiltering: true, cssClass:'link'}
            , {dataField:'APP_FNSH_DT', caption:'${msgel.getMsg("AML_10_25_01_01_003","결재완료 일자")}',alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, allowFiltering: true, "width": "20%"
            	, "cellTemplate": function(cellElement,cellInfo){ 
             	   cellElement.text(displayGTDataGridDate(cellInfo.text)); 
                } 
              }
            , {dataField:'SN_CCD_NM', caption:'${msgel.getMsg("AML_10_25_01_01_004","결재상태")}',	alignment:'center', allowResizing:true, allowSorting:true, allowEditing:false, cssClass:'link', "width": "20%"}
            , {dataField:'GYLJ_LINE_G_C', visible:false, allowSearch:false}
            , {dataField:'NUM_SQ', visible:false, allowSearch:false}
            , {dataField:'REG_DT', visible:false, allowSearch:false}
            , {dataField:'REG_NM', visible:false, allowSearch:false}
            , {dataField:'UPD_DT', visible:false, allowSearch:false}
            , {dataField:'UPD_NM', visible:false, allowSearch:false}
            , {dataField:'TARGET_ROLE_ID', visible:false, allowSearch:false}
        ]
        , onCellClick: function(e){
        	
            if(e.data ){
            	clickCellGrid('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
            }
        }
        , onInitialized : function(e) {
        	//doSearch();
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
    	gridArrs[0] = gridObj;
    	setupGridFilter2(gridArrs, FLAG);
   }
   
    function doSearch(){

        var methodID = "getSearch";
        var classID  = "AML_10_25_01_01";
        
        var ALL_APPR_DATE = ($("#ALL_APPR_DATE").is(":checked")==true ? "Y":"N");
        var APPR_SD_DT = getDxDateVal("APPR_SD_DT", true); //결재완료 일자 시작
        var APPR_ED_DT = getDxDateVal("APPR_ED_DT", true); //결재완료 일자 종료
        var APPR_STATE = $("#wfCodeSts").val();       //결재 상태
        var TITLE = $("#TITLE").val();       //결재 상태
        
        overlay.show(true, true);
        
        var params = new Object();
        params.pageID = "AML_10_25_01_01";
        params.ALL_APPR_DATE = ALL_APPR_DATE;
        params.APPR_SD_DT = APPR_SD_DT;
        params.APPR_ED_DT = APPR_ED_DT;
        params.APPR_STATE = APPR_STATE;
        params.TITLE = TITLE;
        
        sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
    }
    
    function doSearch_success(gridData, data){

    	overlay.hide();
        GridObj1.option("dataSource", gridData);
        GridObj1.refresh();
    }
    
    function doSearch_fail(){        
        overlay.hide();
    }	
    
    function clickCellGrid(id, obj, selectData, rowIdx, colIdx, columnId, colId){
    	
    	if( obj && "TITLE" == columnId ){
    		
 		    form2.PRD_CK_ID.value = obj.PRD_CK_ID;
 		    form2.APP_STATE.value = obj.SN_CCD_NM;
 		    form2.APP_NO.value = obj.APP_NO;
 		    form2.RSN_CNTNT.value = obj.RSN_CNTNT;
 		    form2.SN_CCD.value = obj.SN_CCD;
 		    form2.TARGET_ROLE_ID.value = obj.TARGET_ROLE_ID;
 		    form2.pageID.value = "AML_10_25_01_02";
 			form2.target = 'AML_10_25_01_02';
 			
 		    if( ( "S" == obj.SN_CCD || "E" == obj.SN_CCD ) || ( '4' != '<c:out value="${ROLEID}"/>' )){
 		    	
 		    	form2.APP_NO.value = obj.APP_NO;
 		    	form2.TARGET_ROLE_ID.value = obj.TARGET_ROLE_ID;
  		   	    form2.pageID.value = "AML_10_25_01_03";
  		        form2.target = 'AML_10_25_01_03';
 		    }
 		    
 		    form2.action = '${path}/0001.do';
 		    window_popup_open( form2.pageID.value, 1300, 800, '','');
 		    form2.submit();
    		    
    	}else if( obj && "SN_CCD_NM" == columnId && obj.SN_CCD != "N" ){
    		
 		    form2.APP_NO.value = obj.APP_NO;
 		    form2.pageID.value = "AML_10_25_01_06";
 			form2.target = 'AML_10_25_01_06';
 		    form2.action = '${path}/0001.do';
 		    window_popup_open( form2.pageID.value, 900, 400, '','');
 		    form2.submit();
    	}
    }        
    
   function doRegPopup(){
	   
	   
	   
	   try {
		   if(ROLEID !="4") {
				alert("권한이 불충분합니다.");
				return false;
			   }
		   
		   var gridDatas = getDataSource(GridObj1);
		   var gridDatasLen = gridDatas.length;
		   var ck = false;
		   for( var i =0 ; i < gridDatasLen ; i++ ){
			   
			   if( "E" != gridDatas[i].SN_CCD ){
				   ck = true;
				   break;
			   }
		   }
		   
		   if( ck ){
			   
			   showAlert("${msgel.getMsg('AML_10_25_01_01_020','결재가 진행중인 건이나 임시저장 건이 존재합니다.')}", 'WARN');
			   return;
		   }
		   
		   form3.dis_flag.value = "P";
		   form3.pageID.value = 'AML_10_25_01_02';
		   form3.target = 'AML_10_25_01_02';
		   form3.action = '${path}/0001.do';
		   form3.method = "post";
		   window_popup_open(form3.pageID.value, 1300, 1000, '','yes');
		   form3.submit();
		   form3.target = '';
           return;
           
       } catch (e) {
           showAlert(e, "ERR");
       } finally {
           overlay.hide(); 
       }
   }
   
   function doDelete(){
	   
	   var selectedRows = GridObj1.getSelectedRowsData();
       var selSize = selectedRows.length;

       if(selSize == 0){
    	
    	   showAlert("${msgel.getMsg('AML_10_25_01_01_017','삭제 건을 선택하세요.\\n임시저장 건만 삭제가능합니다.')}", 'WARN');
    	   return;
       }
                  
       for(var i = 0; i< selSize; i++) {
    	   
    	 if( selectedRows[i].SN_CCD != 'N' ) {
    		
    		showAlert("${msgel.getMsg('AML_10_25_01_01_018','임시저장 건만 삭제가능합니다.')}", 'WARN');
			return;
    	 }
	   }
	   
       var classID = "AML_10_25_01_01";
       var methodID = "doDelete";
       var params = new Object();
       params.GRID_DATA = selectedRows;
       
       showConfirm('${msgel.getMsg("AML_10_25_01_01_019","삭제하시겠습니까?")}','삭제', function(){
    	     
		   sendService(classID, methodID, params, doDeleteEnd, doDeleteEnd );
	   });
   }
   
   function doDeleteEnd(gridData, data){

   	   doSearch();
   }
   
   
</script>
    
<form name="form3"  >
    <input type="hidden" name="dis_flag"    />
    <input type="hidden" name="pageID"      />
</form>

<form name="form2" method="post" >
<input type="hidden" name="pageID" > 
<input type="hidden" name="classID" > 
<input type="hidden" name="methodID" >
<input type="hidden" name="dis_flag" >
<input type="hidden" name="APP_NO" >
<input type="hidden" name="PRD_CK_ID" >
<input type="hidden" name="APP_STATE" >
<input type="hidden" name="SN_CCD" >
<input type="hidden" name="TARGET_ROLE_ID" >
<input type="hidden" name="RSN_CNTNT" >
</form>

<form name="form1"  method="post" okeydown="doEnterEvent('doSedarch');" >
<input type="hidden" name="pageID" > 
<input type="hidden" name="manualID" > 
<input type="hidden" name="classID" > 
<input type="hidden" name="methodID" > 

 <div class="inquiry-table type1">
 
	<div class="table-row" >
		<div class="table-cell">
		    ${condel.getLabel("AML_10_25_01_01_003","결재완료 일자")}
			<div class="content">
				<div class='calendar'>
					${condel.getInputDateDx('APPR_SD_DT',stDate)} ~ ${condel.getInputDateDx('APPR_ED_DT',edDate)}
				</div>
				<div class="all">
					<input type="checkbox" id="ALL_APPR_DATE" name="ALL_APPR_DATE" value="Y" checked>
					<label for="ALL_APPR_DATE">${msgel.getMsg('AML_10_25_01_01_021','전체')}</label>
				</div>
	        </div>
	    </div>
	    <div class="table-cell">
		    ${condel.getInputText('{msgID:"AML_10_25_01_01_007", defaultValue:"개요", name:"TITLE", style:"margin-left:15px;", size:"50"}')}
	    </div>
   </div>
   
   <div class="table-row"  >
		<div class="table-cell">
		    ${condel.getSelect('{msgID:"AML_10_25_01_01_006", defaultValue:"결재 상태", selectID:"wfCodeSts", code:"P001", firstComboWord:"ALL"}')}
	    </div>
	    <div class="table-cell">
	    </div>
   </div>
</div>   
	<div class="button-area">
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
		
		<button type='button' id='btn_02' class='btn-36' onClick='doRegPopup()'>${msgel.getMsg('AML_10_25_01_01_008','신규등록')}</button>
		<button type='button' id='btn_03' class='btn-36' onClick='doDelete()'>${msgel.getMsg('AML_10_25_01_01_016','삭제')}</button>
		
	</div>
	<div class="tab-content-bottom">
		<div id = "GTDataGrid1_Area" style="padding-top:8px"></div>
	</div>
</form> 

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" /> 
