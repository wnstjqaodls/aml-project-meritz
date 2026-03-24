<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_01_02.jsp
* Description     : 지표목록 상세 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-05-10
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String PROC_SMDV_C   = request.getParameter("PROC_SMDV_C");
	String VALT_BRNO     = request.getParameter("VALT_BRNO");
	String RSK_INDCT     = request.getParameter("RSK_INDCT");
	String BAS_YYMM     = request.getParameter("BAS_YYMM");
	
    request.setAttribute("PROC_SMDV_C",PROC_SMDV_C);
    request.setAttribute("VALT_BRNO",VALT_BRNO);
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    request.setAttribute("RSK_INDCT",RSK_INDCT);
     
%>
<style>

.table-title {
	font-family: SpoqB;
	font-size: 16px;
	line-height: 24px;
	color: #444;
	letter-spacing: -0.32px;
	margin-bottom: 8px;
}
</style>
<script language="JavaScript">
    
    var GridObj1;
    var GridObj2;
    var GridObj3;
    var GridObj4;
    var GridObj5;
    var overlay = new Overlay();
    var classID  = "RBA_50_05_01_07";
    
    var pageSize = 30;
    var pageNumber = 0;
    var objParam= null;
    
    // Initialize
    $(document).ready(function(){
    	setupGrids();
    	setupFilter1("init");
    	
    	doSearch(); 
    });
    
    function setupFilter1(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }
    
    // Initial function
    function init() {
    	initPage(); 
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 elementAttr: { class: "grid-table-type" },
			 height	:"calc(52vh)",
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
			    sorting              : {mode: "multiple"},
			    loadPanel            : {enabled: false},
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
			    rowAlternationEnabled: false,
			    onCellPrepared       : function(e){
			        var columnName = e.column.dataField;
			        var dataGrid   = e.component;
			        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
			        var valt_yymm  = dataGrid.cellValue(rowIndex, 'VALT_YYMM'); 
			        if(rowIndex != -1){
			            if(valt_yymm == '평균'){
			                
			                    e.cellElement.css('background-color', '#90e090');
			                 
			            }
			        }
			    },
			    searchPanel: {
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
			    columns: [
			           {
			            "caption": '${msgel.getMsg("RBA_50_05_01_07_100","RBA 월별 빈도평가 결과")} ',
			            "alignment": "center",
			            "columns" : [
			               {
				               "dataField": "VALT_YYMM",
				               "caption": '${msgel.getMsg("RBA_50_05_01_07_101","월")}',
				               "width" : 100,
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "VALT_CNT",
				               "caption": '${msgel.getMsg("RBA_50_05_01_07_102","빈도")}',
				               "width" : "80",
				               "alignment": "center",
				               "height":"200px",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }, {
				               "dataField": "RSK_VALT_PNT",
				               "caption": '${msgel.getMsg("RBA_50_05_03_01_017","위험점수")}',
				               "width" : "80",
				               "alignment": "center",
				               "allowResizing": true,
				               "allowSearch": true,
				               "allowSorting": true
				           }
				           ]
			        }
			    ],
			    onToolbarPreparing   : makeToolbarButtonGrids,
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
       }).dxDataGrid("instance");	

    }
    function doSearch(){
       
    	var classID  = "RBA_50_05_01_07";
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= "RBA_50_05_01_07";
        params.BAS_YYMM     = form2.BAS_YYMM.value;
        params.VALT_BRNO    = form2.VALT_BRNO.value;
        params.PROC_SMDV_C  = form2.PROC_SMDV_C.value;
        params.RSK_INDCT    = form2.RSK_INDCT.value;
     
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }
    
    function doSearch_success(gridData, data) {
	   	var gridCnt = gridData.length;
    	var selObj = gridData[0];
    	var selObj_lst = gridData[gridCnt-1];
    	 
    	if(gridCnt>0) {
    		var lCd = selObj.PROC_LGDV_C;
    		var lNm = selObj.PROC_LGDV_NM;
    		var mCd = selObj.PROC_MDDV_C;
    		var mNm = selObj.PROC_MDDV_NM;
    		var sCd = selObj.PROC_SMDV_C;
    		var sNm = selObj.PROC_SMDV_NM;
    		var CCd = selObj.RSK_CATG;
    		var CNm = selObj.RSK_CATG_NM;
    		var ICd = selObj.RSK_INDCT;
    		var INm = selObj.RSK_INDCT_NM;
    		var PNT = selObj_lst.RSK_VALT_PNT; 
    		$('#t01').text(lCd);
    		$('#t02').text(lNm);
    		$('#t03').text(mCd);
    		$('#t04').text(mNm);
    		$('#t05').text(sCd);
    		$('#t06').text(sNm);
    		$('#t07').text(CCd);
    		$('#t08').text(CNm);
    		$('#t09').text(ICd);
    		$('#t10').text(INm);
    		$('#t11').text(PNT); 
    	} 
    	
    	//chart그리기
    	initChart3(gridData); 
    	
    	overlay.hide();
    }
    
    function doSearch_fail(){    	 
    	overlay.hide();
    }
    
    function initChart3(gridData)
    { 
   		var yymm; yymm = new Array();
   		var cnt; cnt = new Array();
   		var pnt; pnt = new Array();
   		var index2 = 0;
   		for (var i = 0; i < gridData.length; i++) {
		
   			yymm[index2] = gridData[i].VALT_YYMM;
   			cnt[index2]  = gridData[i].VALT_CNT;
   			pnt[index2]  = gridData[i].RSK_VALT_PNT;
			index2++;
		} 
			
        $("#chart3").dxChart({
            "dataSource" : [{
                "day"   : yymm[0]
               ,"cnt"   : Number(cnt[0])
               ,"pnt"   : Number(pnt[0])
            },{
                "day"   : yymm[1]
               ,"cnt"   : Number(cnt[1])
               ,"pnt"   : Number(pnt[1])
            },{
                "day"   : yymm[2]
	            ,"cnt"  : Number(cnt[2])
	            ,"pnt"  : Number(pnt[2])
        	},{
                "day"   : yymm[3]
	            ,"cnt"  : Number(cnt[3])
	            ,"pnt"  : Number(pnt[3])  
         	},{
                "day"   : yymm[4]
	         	,"cnt"  : Number(cnt[4])
	            ,"pnt"  : Number(pnt[4]) 
        	 },{
                 "day"  : yymm[5]
	             ,"cnt" : Number(cnt[5])
	             ,"pnt" : Number(pnt[5]) 
         	 },{
                 "day"  : yymm[6]
	             ,"cnt" : Number(cnt[6])
	             ,"pnt" : Number(pnt[6]) 
         	 },{
                 "day"  : yymm[7]
	             ,"cnt" : Number(cnt[7])
	             ,"pnt" : Number(pnt[7]) 
         	 },{
                 "day"  : yymm[8]
	             ,"cnt" : Number(cnt[8])
	             ,"pnt" : Number(pnt[8]) 
         	 },{
                 "day"  : yymm[9]
	             ,"cnt" : Number(cnt[9])
	             ,"pnt" : Number(pnt[9]) 
         	 },{
                 "day"  : yymm[10]
	             ,"cnt" : Number(cnt[10])
	             ,"pnt" : Number(pnt[10]) 
         	 },{
                 "day"  : yymm[11]
	             ,"cnt" : Number(cnt[11])
	             ,"pnt" : Number(pnt[11]) 
         	 },{
                 "day"  : yymm[12]
	             ,"cnt" : Number(cnt[12])
	             ,"pnt" : Number(pnt[12]) 
         	 }]
            
           ,"commonSeriesSettings" : {
                "argumentField" : "day"
               ,"type"          : "bar"
               ,"hoverMode"     : "allArgumentPoints"
               ,"selectionMode" : "allArgumentPoints"
               ,"label" : {
                    "visible"   : true
                   ,"format"    : {
                        "type"      : "fixedPoint"
                       ,"precision" : 0
                    }
                }
            },
            series: [{
                "valueField": "cnt", "name": "빈도", "type":"bar"
            },{ "valueField": "pnt", "name": "위험점수", "type":"line"
            } ]
           , 
           "legend": {
                "verticalAlignment"     : "bottom"
               ,"horizontalAlignment"   : "center"
            }
           ,"export" : {
                "enabled": false
            }
           ,"onPointClick": function (e) {
                e.target.select();
            }
        });
    	
    }
    
    // 팝업 close
    function appro_end() {
        $("button[id='btn_01']").prop('disabled', false);
        opener.doSearch();
        window.close();
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
        }
     }
     
</script>
 
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="PROC_SMDV_C" value="${PROC_SMDV_C}">
    <input type="hidden" name="RSK_INDCT" value="${RSK_INDCT}">
    <input type="hidden" name="VALT_BRNO" value="${VALT_BRNO}">
    <input type="hidden" name="BAS_YYMM"  value="${BAS_YYMM}">
</form>
<form name="form">
    <div class="panel panel-primary">
        <div class="panel-footer" >
        
        <div class="table-title">${msgel.getMsg('RBA_50_05_01_011','지표목록')}</div>
 
            <div class="table-box11">
			  <table class="grid-table division">
			  	<thead>
			  	  <tr style="text-align:center;background-color: #eaeaea;">
	                  <th width="10%"  rowspan="2" style="border-right: 1px solid white;">${msgel.getMsg('RBA_50_05_01_016','AML업무')}<br>${msgel.getMsg('RBA_50_05_01_017','프로세스')}</th>
	                  <th width="7%" style="border-right: 1px solid white;">L1</th>
	                  <th width="20%" style="border-right: 1px solid white;" >${msgel.getMsg('RBA_50_05_01_012','대분류(L1)')}</th>
	                  <th width="7%" style="border-right: 1px solid white;">L2</th>
	                  <th width="20%" style="border-right: 1px solid white;">${msgel.getMsg('RBA_50_05_01_013','중분류(L2)')}</th>
	                  <th width="7%" style="border-right: 1px solid white;">L3</th>
	                  <th width="30%" >${msgel.getMsg('RBA_50_05_01_014','소분류(L3)')}</th>
	              </tr>
	              <tr style="text-align:center;background-color: #eaeaea;">
	                  <th width="7%"  style="background-color: white;" height="30" id="t01"></th>
	                  <th width="20%"  style="background-color: white;" id="t02"></th>
	                  <th width="7%"  style="background-color: white;" id="t03"></th>
	                  <th width="20%"  style="background-color: white;" id="t04"></th>
	                  <th width="7%"  style="background-color: white;" id="t05"></th>
	                  <th width="20%"  style="background-color: white;" id="t06"></th>
	              </tr>
	            </thead>
	          </table>
	          <table class="grid-table division" style="margin-top: 8px;">
	          	<thead>  
	              <tr style="text-align:center;background-color: #eaeaea;">
	                  <th width="10%" style="border-right: 1px solid white;" rowspan="2">ML/TF<br>Risk Indicator</th>
	                  <th width="7%" style="border-right: 1px solid white;">Co.1</th>
	                  <th width="20%" style="border-right: 1px solid white;">Lv.1</th>
	                  <th width="7%" style="border-right: 1px solid white;">Co.2</th>
	                  <th width="20%" style="border-right: 1px solid white;">Lv.2</th>
	                  <th width="37%"colspan=2>${msgel.getMsg('RBA_50_01_01_242','ML/TF 위험평가 평균점수')}</th> 
	              </tr>
	              <tr style="text-align:center;background-color: #eaeaea;">
	                  <th width="7%" style="background-color: white;" height="30" id="t07"></th>
	                  <th width="20%"  style=" background-color: white;" id="t08"></th>
	                  <th width="7%" id="t09" style="background-color: white;"></th>
	                  <th width="20%" style=" background-color: white;" id="t10"></th>
	                  <th width="37%" id="t11" style="background-color: white;" colspan=2></th>
	              </tr>
	              </thead>
			   </table>
			</div>

	           <table width="100%" border="0" cellspacing="0" cellpadding="0" >
		       		<tr><div class="table-title" style="margin-top: 8px">${msgel.getMsg('RBA_50_05_01_015','ML/TF 위험평가 상세내역')}</div></tr>
		       		<tr>
			          	<td	width="40%" align=left>
			          		<div  id="GTDataGrid1_Area" style="margin-top:-5px; vertical-align: middle; " ></div>  
			          	</td>
					
						<td width="60%">
				            <div style="display:inline-block;width:calc(100% - 2px);height:calc(100% - 3px); overflow:hidden; margin-left: 20px; vertical-align: middle; padding:0;text-align:center;">
			        	       <div id="chart3" style="width:95%;height:100%;text-align:center;margin-left:2px;"></div>
				            </div> 
			            </td>
		            </tr>   	
	           </table>


        </div>
		<div class="cond-btn-row" style="text-align:right; margin-top:8px;">
        	${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"appro_end", cssClass:"btn-36"}')}
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />
