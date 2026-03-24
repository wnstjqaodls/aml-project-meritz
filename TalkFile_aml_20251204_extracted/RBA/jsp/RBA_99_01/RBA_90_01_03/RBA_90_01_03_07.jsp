<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_03_07.jsp
- Author     : 권얼
- Comment    : 메모 등록
- Version    : 1.0
- history    : 1.0 2019-03-04
--%>
 
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %> 
<%
	String RPT_GJDT = Util.nvl(request.getParameter("RPT_GJDT"),"");
	String JIPYO_IDX = Util.nvl(request.getParameter("JIPYO_IDX"),"");
	String JIPYO_NM = Util.nvl(request.getParameter("JIPYO_NM"),"");
	String CAL_FRML = Util.nvl(request.getParameter("CAL_FRML"),"");
	String BIGO_CTNT = Util.nvl(request.getParameter("BIGO_CTNT"),"");
	
	StringBuffer strGjdt = new StringBuffer(64);
		strGjdt.append(RPT_GJDT.substring(0 , 4));
		strGjdt.append('-');
		strGjdt.append(RPT_GJDT.substring(4 , 6));
		strGjdt.append('-');
		strGjdt.append(RPT_GJDT.substring(6 , 8));
    String VIEW_RPT_GJDT = strGjdt.toString();
	//String VIEW_RPT_GJDT = RPT_GJDT.substring(0 , 4)+"-"+ RPT_GJDT.substring(4 , 6)+"-"+RPT_GJDT.substring(6 , 8);
	
	request.setAttribute("RPT_GJDT", RPT_GJDT);
	request.setAttribute("JIPYO_IDX", JIPYO_IDX);
	request.setAttribute("JIPYO_NM", JIPYO_NM);
	request.setAttribute("CAL_FRML", CAL_FRML);
	request.setAttribute("BIGO_CTNT", BIGO_CTNT);
	request.setAttribute("VIEW_RPT_GJDT", VIEW_RPT_GJDT);
%>
<script language="JavaScript">

	var overlay = new Overlay();
	var GridObj1 = null;
	var classID  = "RBA_90_01_03_07";
	
	$(document).ready(function() {
		setupGrids();
		doSearch();
	});
	
	/** 그리드 셋업 */
	function setupGrids(){
		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
	  		  elementAttr: { class: "grid-table-type" },
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
		         "allowExportSelectedData"  : false,
		         "enabled"                  : false,
		         "excelFilterEnabled"       : false,
		         "fileName"                 : "gridExport"
		     },
		     "sorting": {"mode"             : "multiple"},
		     "remoteOperations":                  {
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
		     "filterRow"                    : {"visible": false},
		     "rowAlternationEnabled"        : true,
		     "columnFixing": {"enabled"     : true},
		     "searchPanel":                  
		     {
		         "visible"                  : false,
		         "width"                    : 250
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
		     onContentReady: function (e) 
		     {
		        e.component.columnOption("command:select", "width", 30);
		     },
		     "columns":                  
		     [
		         {
		             "dataField"            : "RPT_GJDT",
		             "caption"              : "${msgel.getMsg('RBA_90_01_01_02_001','보고기준일')}",
		             "cellTemplate"      	: function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },             
		             "alignment"            : "center",
		             "width"                : 150
		         },     
		         {
		             "dataField"            : "BIGO_CTNT",
		             "caption"              : "${msgel.getMsg('RBA_90_01_03_07_100','내용')}",
		             "alignment"            : "left",
		             "width"                : 200
		         }
		     ]
		}).dxDataGrid("instance");
	}
	
	function doSearch() {
		overlay.show(true, true);
		
		var methodID = "doSearch";
		var obj = new Object();
		
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "doSearch";
		obj.RPT_GJDT 	= "${RPT_GJDT}";
		obj.JIPYO_IDX 	= "${JIPYO_IDX}";
		
		
		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
// 		GridObj1.refresh({
//             actionParam    : obj
//            ,completedEvent : doSearch_end
//            ,failEvent : function(e){overlay.hide();}
//         });
	}
	
	function doSearch_end(dataSource) {
		overlay.hide();
		GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
	}

	function doSave() {
		var BIGO_CTNT = form1.BIGO_CTNT.value;
		if (BIGO_CTNT.length == 0) {
			showAlert('내용을 입력해주세요.', "WARN");
			return;
		}
		
		var methodID = "doSave";
		var obj = new Object();
	    obj.pageID 		  = pageID;
	    obj.classID 	  = classID;
	    obj.methodID 	  = "doSave";
	    obj.RPT_GJDT 	  = "${RPT_GJDT}";
	    obj.JIPYO_IDX 	  = "${JIPYO_IDX}";
	    obj.BIGO_CTNT 	  = BIGO_CTNT;
	    obj.gridData	  = GridObj1.getSelectedRowsData();
	    
// 	    GridObj1.save({    
//           	actionParam      : obj
//          	,sendFlag        : "SELECTED"
//         	,completedEvent  : doSave_end
//     	});

	    sendService(classID, methodID, obj, doSave_end, doSave_end);
	}
	
	function doSave_end() {
		doSearch();
		opener.doSearch();
	}
	
	function doClose(){
		opener.doSearch();
		window.close();
	}
</script>

<form name="form1" method="post" action="001.do">
	<input type="hidden" name="pageID" />
	<input type="hidden" name="classID"  />
	<input type="hidden" name="methodID"  />
    
	<div class="panel panel-primary">
        <div class="table-box" >
			<table class="basic-table">
			<colgroup>
			    <col width="100px">
			    <col width="">
			    <col width="100px">
			    <col width="">
			</colgroup>
			<tbody>
				<tr>
                    <th class="title" width="15%">${msgel.getMsg('RBA_90_01_01_02_001','보고기준일')}</th>
                    <td width="30%">${VIEW_RPT_GJDT}</td>
                </tr>
                <tr>
                    <th class="title" width="15%">${msgel.getMsg('RBA_90_01_01_02_002','지표번호')}</th>
                    <td width="30%">${JIPYO_IDX}</td>
                    <th class="title" width="15%">${msgel.getMsg('RBA_90_01_01_02_003','지표명')}</th>
                    <td width="30%">${JIPYO_NM}</td>
                </tr>
                <tr>
                    <th class="title" width="15%">${msgel.getMsg('RBA_90_01_01_02_023','산출식')}</th>
                    <td colspan="3" width="30%">${CAL_FRML}</td>
                </tr>
                <tr>
                    <th class="title required" width="15%">${msgel.getMsg('RBA_90_01_03_07_100','내용')}</th>
                	<td colspan="3">
                		<textarea name="BIGO_CTNT" id="BIGO_CTNT" class="textarea-box" rows="7" maxlength="2000">${BIGO_CTNT}</textarea>
                    </td>
                </tr>
                </tbody>
			</table>
		</div>
		<div class="tab-content-bottom" style="padding-top:10px">
	        <div style="width:100%" id="GTDataGrid1_Area"></div>
		</div>
		<table border=0 width=100%>
			<tr class="tab-content-top"> 
				<td class="button-area" height="40" align="right">
					${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}	
					${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", closeBtn:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}	
				</td>
			</tr>	
		</table>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />