<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_01_07.jsp
* Description     : 배치수행정보
* Group           : GTONE
* Author          : BSL
* Since           : 2018-07-06
--%>

<%
    String BAS_YYMM =  request.getParameter("BAS_YYMM");
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    
    System.out.println(BAS_YYMM);
%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp"%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />

<script language="JavaScript">
    
    var classID  = "RBA_50_01_01_08";
    var pageID   = "RBA_50_01_01_08"
    var GridObj1;
    
    // Initialize
    $(document).ready(function(){
        $('.popup-contents').css({overflow:"auto"});
        setupGrids();
    });
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	/* GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_01_01_07_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(80vh - 130px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : 'FIU보고서관리'
           ,completedEvent  : function(){
           }
    	}); */
    	
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 		height	:"calc(80vh - 130px)",
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
				    columns: [
				        {
				            dataField    : "RBA_BTCH_DT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_100","RBA배치일자")}',
				            alignment    : "center",
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "BAS_YYMM",
				            caption      : '${msgel.getMsg("RBA_50_05_03_01_001","기준년월")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "ING_STEP_NM",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_101","진행단계")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "20%"
				        },  {
				            dataField    : "ING_STEP",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_102","진행단계코드")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            visible      : false
				        },  {
				            dataField    : "RBA_BTCH_SDT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_103","배치시작일자")}',
				            alignment    : "center",
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "RBA_BTCH_EDT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_104","배치종료일자")}',
				            alignment    : "center",
				            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "RBA_BTCH_S_C",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_105","배치진행상태코드")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "12%",
				            visible      : false
				        },  {
				            dataField    : "RBA_BTCH_S_C_NM",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_106","배치진행상태")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true,
				            width : "10%"
				        },  {
				            dataField    : "ERR_CTNT",
				            caption      : '${msgel.getMsg("RBA_50_01_01_07_107","배치내용")}',
				            alignment    : "center",
				            allowResizing: true,
				            allowSearch  : true,
				            allowSorting : true
				        }
				    ],
				    onCellClick: function(e){ 
				        if(e.data ){
				            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
				        }
				    }
   		}).dxDataGrid("instance");	
    }
    
    // Initial function
    function init() { initPage(); }
    
    //총위험평가 재수행
	function doStart1(){    	
		var NOW_ING_STEP = $("#ING_STEP").val();
		var ING_STEP; ING_STEP=""; 

	
		if(NOW_ING_STEP < 21) {
			showAlert('${msgel.getMsg("RBA_50_01_01_211","총 위험평가 배치가 수행되지 않은 상태에서 수행할 수 없습니다.")}','WARN');
			return;
		}
		
		
          showConfirm("${BAS_YYMM}" + "의 총위험평가 배치를 재수행 하시겠습니까 ?", "저장",function(){
        	  var params   = new Object();
        	  var methodID = "startBatch";
        	  var classID  = "RBA_50_01_01_08";
        	   		
        	  params.pageID   = "RBA_50_01_01_08";
        	  params.ING_STEP = "40";
        	  params.BAS_YYMM = "${BAS_YYMM}";
        	   		
        	  sendService(classID, methodID, params, doStart1_end, doStart1_end); 
          });
	    
    }
    
    function doStart1_end(){
    	
    }
       
    
    //통제평가 재수행
    function doStart2(){
        
       var NOW_ING_STEP = $("#ING_STEP").val();
       
       if(NOW_ING_STEP < 31) {
          showAlert('${msgel.getMsg("RBA_50_01_01_210","잔여위험 배치가 수행되지 않은 상태에서 수행할 수 없습니다.")}','WARN');
          return;
       }
      /*  if(!confirm("${BAS_YYMM}" + "의 통제평가 배치를 재수행 하시겠습니까 ?")) {
          return;;
       } */
       
       showConfirm("${BAS_YYMM}" + "의 통제평가 배치를 재수행 하시겠습니까 ?","배치",function(){
    	   var params   = new Object();
    	   var methodID = "startBatch";
    	   var classID  = "RBA_50_01_01_01";
    	    		
    	   params.pageID 	= pageID;
    	   params.BAS_YYMM  = form.BAS_YYMM.value; //기준연도3
    	   params.ING_STEP  = "50";
    	   params.BAS_YYMM  = "${BAS_YYMM}";
    	   
    	   sendService(classID, methodID, params, doStart2_end, doStart2_end); 
       });
       
       

     }
    
    function doStart2_end(){
    	
    }
    
</script>
<form name="form1" onkeydown="doEnterEvent('doSearch');">

<input type="hidden" name="pageID"      id="pageID"     value=""    />
<input type="hidden" name="mode"        id="mode"       value=""    />
<input type="hidden" name="ING_STEP"    id="ING_STEP"    value="<c:out value='${param.ING_STEP}'/>"    />
    
    <div class="panel panel-primary">
           <div class="table-box" >
               <table class="basic-table">
                   <tr>
                       <th class="title">${msgel.getMsg('RBA_50_01_02_001','평가기준월')}</th>
                       <td class="content">
                           <input type="text" class="cond-input-text" name="BAS_YYMM" value="<c:out value='${param.BAS_YYMM}'/>"  style="border: 0px;" readonly="readonly"/>
                       </td>
                   </tr>
                   <tr>
                       <th class="title">${msgel.getMsg('RBA_50_01_01_044','배치상태')}</th>
                       <td class="content">
                       	<input type="text" class="cond-input-text" name="ING_STEP_NM" value="<c:out value='${param.ING_STEP_NM}'/>"  style="border: 0px;" readonly="readonly"/>
                       </td>
                   </tr>
				<tr>
				    <th class="title">${msgel.getMsg('RBA_50_01_01_042','총위험평가 재수행')}</th>
                       <td class="content">
                       		${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"RBA028", defaultValue:"배치재수행", mode:"C", function:"doStart1", cssClass:"btn-36"}')}
                       </td>
				</tr>
				<tr>
				    <th class="title">${msgel.getMsg('RBA_50_01_01_043','통제평가 재수행')}</th>
                    <td class="content">
                    	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"RBA028", defaultValue:"배치재수행", mode:"C", function:"doStart2", cssClass:"btn-36"}')}
                    </td>
				</tr>
               </table>
           </div>
       </div>
        <table width="100%" border="0" >
	         <tr>
	         	<td align=left  height="20"><p style="color:blue; font-size:12px;">${msgel.getMsg('RBA_50_01_01_206','※총위험평가 수행은 총위험평가 배치실행완료 후에만 재수행 가능합니다.')}</p></td>
	         </tr>
	         <tr>
	         	<td align=left  height="20"><p style="color:blue; font-size:12px;">${msgel.getMsg('RBA_50_01_01_207','※잔여위험평가가 완료된 후 총위험평가 재수행 시는 잔여위험평가까지 재수행 됩니다.')}</p></td>
	         </tr>
	         <tr>
	         	<td align=left  height="20"><p style="color:blue; font-size:12px;">${msgel.getMsg('RBA_50_01_01_208','※통제평가 재수행은 배치실행이 완료되어도 가능하며 잔여위험평가가 다시 재수행됩니다.')}</p></td>
	         </tr>
	         <tr>
	         	<td align=left  height="20"><p style="color:blue; font-size:12px;">${msgel.getMsg('RBA_50_01_01_209','※배치 재수행은 위험수기평가가 변경되거나 통제평가 수기처리가 변경될 때만 수행하시면 됩니다.')}</p></td>
	         </tr>
		</table>
		<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">  
        	${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close()", cssClass:"btn-36"}')}
   		</div>
    
   <div class="tab-content-bottom" style="display: none">      
            <div id="GTDataGrid1_Area"></div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />