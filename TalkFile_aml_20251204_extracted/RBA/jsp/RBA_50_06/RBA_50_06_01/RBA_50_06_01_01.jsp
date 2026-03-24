<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : RBA_50_06_01_01.jsp
* Description     : KRI 지표관리
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 24.
********************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
String dvTabID = Util.nvl(jspeed.base.xml.XMLHelper.normalize(request.getParameter("dvTabID" )), "");
request.setAttribute("dvTabID", dvTabID );
%>
<script>
    var GridObj1 = null; 
    var overlay = new Overlay();
    var output ="";
    var tabID 	 	= null;
	var tabPanelID  = null;
	
    // [ Initialize ]
    $(document).ready(function(){ 
    	setupGrids();
    	setupFilter("init");
    });
    
	function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    //	gridObj.title = "${msgel.getMsg('RBA_50_06_01_01_008','주요위험지표 목록')}";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
    }
  	  
  	function setupGrids() {  
  		GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
  			elementAttr: { class: "grid-table-type" },
  	  			"width" 						: "100%",
        		"height"						:"calc(70vh)",
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
        	     "loadPanel"                    : {"enabled": false},
        	     "export": {"allowExportSelectedData" : true, "enabled" : true, "excelFilterEnabled" : true, "fileName" : "${msgel.getMsg('RBA_50_06_01_01_003','전사주요위험지표목록')}"},
        	     "sorting": {"mode" : "multiple"},
        	     "remoteOperations": {"filtering" : false, "grouping" : false, "paging" : false, "sorting" : false, "summary" : false},
        	     "editing":{ "mode" : "batch", "allowUpdating" : false, "allowAdding" : false, "allowDeleting" : false},
        	     "filterRow": {"visible"        : false},
        	     "rowAlternationEnabled"        : true,
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
        	     "searchPanel": {"visible" : false, "width" : 250},
        	     "selection":{"allowSelectAll" : true, "deferred" : false, "mode" : "single", "selectAllMode" : "allPages", "showCheckBoxesMode" : "always"},
        	     "columns": [
        	        {"dataField": "SEQ", "caption" : '${msgel.getMsg("RBA_50_08_01_02_001","순번")}', "alignment" : "center", "allowResizing": true, "allowSearch"  : true, "allowSorting" : true}, 
        	        {"dataField": "", "caption": '${msgel.getMsg("RBA_50_06_01_02_100","주요위험지표(전사KRI)")}', "alignment": "center",
        	            "columns" : [
        	               {"dataField": "KRI_NO", "caption": '${msgel.getMsg("RBA_50_06_01_02_001","ID")}', "cssClass": "link",  "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true}, 
        	               {"dataField": "REF_RSK_INDCT_NM", "caption": '${msgel.getMsg("RBA_50_06_01_02_101","분류")}', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true}, 
        	               {"dataField": "KRI_NM", "caption": '${msgel.getMsg("RBA_50_06_01_02_002","지표명")}', "alignment": "left", "allowResizing": true, "allowSearch": true, "allowSorting": true}
        		        ]}, 
        		    {"dataField": "", "caption": '${msgel.getMsg("RBA_50_06_01_02_102","지표 모니터링")}', "alignment": "center",
        	            "columns" : [
        	               {"dataField": "KRI_CTNT", "caption": '${msgel.getMsg("RBA_50_06_01_02_003","지표산식")}', "alignment": "left", "allowResizing": true, "allowSearch": true, "allowSorting": true}, 
        	               {"dataField": "FRQ_NM", "caption": '${msgel.getMsg("RBA_50_06_01_02_004","주기")}', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true}, 
        	               {"dataField": "FRQ_C", "caption": '${msgel.getMsg("RBA_50_06_01_02_103","주기코드")}', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true, "visible": false}, 
        	               {"dataField": "UNIT_NM", "caption": '${msgel.getMsg("RBA_50_06_01_02_005","단위")}', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true}, 
        	               {"dataField": "UNIT_C", "caption": '${msgel.getMsg("RBA_50_06_01_02_104","단위코드")}', "alignment": "center", "allowResizing": true, "allowSearch": true, "allowSorting": true, "visible": false}
        		        ]}, 
        		    {"dataField": "REF_RSK_INDCT", "caption": '${msgel.getMsg("RBA_50_06_01_01_009","Risk Factor 코드")}', "alignment": "center", "allowResizing": true, "cssClass": "link", "allowSearch": true, "allowSorting": true}
        	    ]
        	    ,"onToolbarPreparing"   : makeToolbarButtonGrids
        	    ,"onCellClick" : function(e) {
        	        if (e.data) {
        	            clickGrid1Cell('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
        	        }
        	    }
    	}).dxDataGrid("instance");
  		setTimeout('doSearch()','200');
    }

	function doSearch()
    {		doSearchKRI();	
    }

	function doSearchKRI()
    {
        overlay.show(true, true);
        GridObj1.clearSelection();
        GridObj1.option('dataSource', []);

        var params = new Object();
		var methodID = "doSearchKRI";
		var classID  = "RBA_50_06_01_01";
		params.pageID 	= $("input[name=pageID]","form[name=form1]").val();
		params.KRI_NO   = form1.KRI_NO.value;
		params.KRI_NM   = form1.KRI_NM.value;
		params.RSK_CATG = $("#RSK_CATG").val(); 

		sendService(classID, methodID, params, doSearchKRI_end, doSearchKRI_fail);
    }

    function doSearchKRI_end(dataSource, data)
    {        
    	GridObj1.refresh();
	    GridObj1.option("dataSource", dataSource);
		var row = dataSource.length;
		if(row > 0){
			$.each(data.GRID_DATA,function(i,o){o.ROW_NUM=i;});
			GridObj1.selectRowsByIndexes(0);
		}
        overlay.hide();
    }

    function doSearchKRI_fail(){
		console.log("doSearchKRI_fail");
    }
      
   
    function clickGrid1Cell(id, obj, selectData, rowIdx, colIdx, columnId, colId)
    {   
    	if(columnId == "KRI_NO" ) {
        	form2.pageID.value = 'RBA_50_06_01_02';
            window_popup_open('RBA_50_06_01_02', 650, 670, '');
            form2.KRI_NO.value  = obj.KRI_NO;
            form2.P_GUBN.value = '1';               //구분:0 등록 1:수정
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }  
        
        if(columnId == "REF_RSK_INDCT" ) {
        	parent.goMenu("RBA_50_03_02"); //호출화면의 부모창아이디
        } 
    }

	function doRegister() { 
		doRegisterKRI(); 
	}
	
	function doRegisterKRI(){
		form2.pageID.value  		= "RBA_50_06_01_02";
		window_popup_open(form2, 650, 670, '');
		form2.KRI_NO.value  = '';
		form2.P_GUBN.value = '0';         //구분:0 등록 1:수정
		form2.target 				= form2.pageID.value;
		form2.action 				= '<c:url value="/"/>0001.do';
		form2.submit();		
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
							if(gridID=="GTDataGrid1_Area"){
								setupFilter();
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
<form name="form2" method="post">
    <input type="hidden" name="pageID"   />
    <input type="hidden" name="KRI_NO"  />
    <input type="hidden" name="RULE_NO"  />
    <input type="hidden" name="P_GUBN" >
</form>
<!-- Main Body Start -->
<form name="form1" method="post" onSubmit="return false;" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID" id="pageID" value="RBA_50_06_01_01"/>
	
	<div class="inquiry-table type1" id='condBox1'>
        <div class="table-row">
            <div class="table-cell" id="con1">
	            <div class="title">
					<div class="txt">${msgel.getMsg('RBA_50_06_01_01_001','KRI ID')}</div>
				</div>
				<div class="content">
					<input type="text" class="cond-input-text" id="KRI_NO" name="KRI_NO" size="20" maxlength="10" />
				</div>
	        </div>	       
	    </div>
	    <div class="table-row">
	    	<div class="table-cell" id="con2">
		    	<div class="title">
					<div class="txt">${msgel.getMsg('RBA_50_06_01_01_002','KRI 명')}</div>
				</div>
				<div class="content">
					<input type="text" class="cond-input-text" id="KRI_NM" name="KRI_NM" size="20"  />
				</div>
            </div>
	    </div>
	    <div class="table-row">
	    	<div class="table-cell" id="con5">
	    		<div class="title">
					<div class="txt">${msgel.getMsg('RBA_50_06_01_02_101','분류')}</div>
				</div>
				<div class="content">
					${SRBACondEL.getSRBASelect('RSK_CATG','' ,'' ,'R309' ,'','ALL','nextSelectChangeSRBA("RSK_FAC", "FA", this,"")','','','')}
				</div>
            </div>
	    </div>
	</div>
	<div id="con8" class="button-area" style="text-align:right">
		${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
        ${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"RBA004", defaultValue:"등록", mode:"C", function:"doRegister", cssClass:"btn-36"}')}
    </div> 
 	<div class="tab-content-bottom" style="padding-top: 8px; ">
			<div title="${msgel.getMsg('RBA_50_06_01_01_008','주요위험지표 목록')}" margin-left:10px; margin-right:10px;"></div>

		<div id="GTDataGrid1_Area" style="width:96vw"></div>
	</div>		
     
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />