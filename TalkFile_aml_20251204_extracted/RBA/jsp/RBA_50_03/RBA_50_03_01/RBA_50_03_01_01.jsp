<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_03_01_01.jsp
* Description     : 자금세탁 사례관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-04-23
--%>
<%@ page import="java.text.ParseException" %>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String stDate = Util.nvl(request.getParameter("stDate"));
    String edDate = Util.nvl(request.getParameter("edDate"));
    try{
    //if(stDate.equals("")) 
    if("".equals(stDate) == true){
    	stDate = DateUtil.addDays(DateUtil.getDateString(), -365, "yyyy-MM-dd");
    }
    //if(edDate.equals("")) 
    if("".equals(edDate) == true){
    	edDate = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
    }
    }catch(ParseException e){
    	Log.logAML(Log.ERROR, e);
    }
    
    request.setAttribute("stDate",stDate);
    request.setAttribute("edDate",edDate);
%>
<style type="text/css">
    * { white-space: nowrap;}
</style>
<script language="JavaScript">
    
    var GridObj1;
    var overlay = new Overlay();
    var classID= "RBA_50_03_01_01";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        doSearch();
        setupFilter("init");
    });

    function setupFilter(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs, FLAG);	
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
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	
        // 그리드1(Code Head) 초기화
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
			 height	:"calc(85vh - 150px)",
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
			    onToolbarPreparing   : makeToolbarButtonGrids ,
			    export               : {
			        allowExportSelectedData: true,
			        enabled                : true,
			        excelFilterEnabled     : true,
			        fileName               : "gridExport"
			    },
			    sorting         : {mode   : "multiple"},
			    loadPanel       : {enabled: false},
			    remoteOperations: {
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
			    rowAlternationEnabled: false,
			    searchPanel          : {
			        visible: false,
			        width  : 250
			    },
			    selection: {
			        allowSelectAll    : true,
			        deferred          : false,
			        mode              : "multiple",
			        selectAllMode     : "allPages",
			        showCheckBoxesMode: "always"
			    },
			    columns: [
			    	{
			            dataField    : "NO",
			            caption      : 'NO',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            width : "80px"
			        }, {
			            dataField    : "NEWS_DT",
			            caption      : '${msgel.getMsg("RBA_50_03_01_005","기사일자")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            cssClass     : "link",
			            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            width : "100px"
			        }, {
			            dataField    : "SRC_INFO_C",
			            caption      : '출처정보코드',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "SRC_INFO_NM",
			            caption      : '${msgel.getMsg("RBA_50_03_01_01_100","출처정보")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : "100px"
			        },{
			            dataField    : "NEWS_TITE",
			            caption      : '${msgel.getMsg("RBA_50_03_01_01_101","기사제목")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : "600px"
			        }, {
			            dataField    : "IN_DT",
			            caption      : '${msgel.getMsg("RBA_50_01_04_01_117","등록일자")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            width : "100px"
			        }, {
			            dataField    : "INDV_CORP_NM",
			            caption      : '${msgel.getMsg("RBA_50_03_01_009","개인/법인명")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : "100px"
			        }, {
			            dataField    : "URL",
			            caption      : 'URL',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "NEWS_CTNT",
			            caption      : '기사내용',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_RSN",
			            caption      : '등록사유',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CUST_G_C",
			            caption      : '고객구분코드',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "REL_P_CNT",
			            caption      : '관련자수',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "STR_RPT_NO",
			            caption      : 'STR보고번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "STR_RPT_DT",
			            caption      : 'STR보고일자',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "ATTCH_FILE_NO",
			            caption      : '첨부파일번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_DT",
			            caption      : '등록일자',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_TIME",
			            caption      : '등록시간',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_OP_JKW_NO",
			            caption      : '등록조작자번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_DT",
			            caption      : '변경일자',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_TIME",
			            caption      : '변경일시',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_OP_JKW_NO",
			            caption      : '변경조작자번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_OP_JKW_NM",
			            caption      : '${msgel.getMsg("RBA_50_01_04_01_107","등록자")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "ATTATCH_YN",
			            caption      : '${msgel.getMsg("RBA_50_03_01_01_102","첨부여부")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : "70px"
			        }/*, {
			            dataField    : "ATTCH_FILE_NO",
			            caption      : '첨부파일번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }*/
			    ],
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
        }).dxDataGrid("instance");		 
    }
    
    //자금세탁 사례관리 조회 
    function doSearch() {
    	if(!fromToDateChechk("stDate", "edDate"))return;
    	overlay.show(true, true);
    	
        var classID  = "RBA_50_03_01_01";
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= "RBA_50_03_01_01";
        params.stDate       = getDxDateVal("stDate", true);
        params.edDate       = getDxDateVal("edDate", true);
        params.SRC_INFO_C   = $("#SRC_INFO_C").val();  //출처
        params.NEWS_TITE    = $("#NEWS_TITE").val();  //기사제목
        params.NEWS_CTNT    = $("#NEWS_CTNT").val();  //기사내용
        params.DR_RSN       = $("#DR_RSN").val();  //등록사유
  
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }
    
    function doSearch_success(gridData, data){
        try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
        	
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
    
    //자금세탁 사례관리 조회 end
    function doSearch_fail() {
        overlay.hide();
    }
    
    // 자금세탁 사례 등록 팝업 호출
    function doRegister() {
    	form2.classID.value    		 = classID;
        form2.pageID.value      	 = "RBA_50_03_01_02";
        form2.methodID.value         = "getSearchInfo";
    	form2.P_GUBN.value      	 = "0";                 //구분:0 등록 1:수정
        form2.P_SNO.value       	 = 0;                   //20171013 변경 GridObj1.getRow(0).SNO -> 0
        form2.ATTCH_FILE_NO.value 	 = 0;  //첨부파일번호
        var win;                 win = window_popup_open(form2,  850, 700, '','yes');
        form2.target           		 = form2.pageID.value;
        form2.action           		 = '<c:url value="/"/>0001.do';
        form2.submit();
    }
    
    //그리드 클릭 이벤트
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId) {
        
        if(colId == "NEWS_DT"){
            form2.classID.value    	  = classID;
            form2.pageID.value        = "RBA_50_03_01_02";
            form2.methodID.value      = "getSearchInfo";
            form2.P_GUBN.value        = "1";                            //구분:0 등록 1:수정
            form2.P_SNO.value         = obj.SNO;                        //순번
            form2.P_IN_DT.value    	  = obj.IN_DT;                        //입력일자
            form2.ATTCH_FILE_NO.value = obj.ATTCH_FILE_NO;  //첨부파일번호
            form2.P_stDate.value      = getDxDateVal("stDate",true);
            form2.P_edDate.value      = getDxDateVal("edDate",true);
            var win;              win = window_popup_open(form2, 850, 700, '','no');
            form2.target              = form2.pageID.value;
            form2.action              = '<c:url value="/"/>0001.do';
            form2.submit();
        }
    }
    
    //자금세탁사례삭제
    function doDelete() {
    	
    	if(GridObj1.getSelectedRowsData()[0] == null || GridObj1.getSelectedRowsData()[0] == "") {
    		showAlert('${msgel.getMsg("RBA_50_03_01_01_103","삭제할 대상을 먼저 선택하세요.")}','WARN');
    	}
    	
    	var selectedRows = GridObj1.getSelectedRowsData();
        showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){

        	var params   = new Object();
        	var methodID = "doDelete";
        	var classID  = "RBA_50_03_01_01";
        	 		
        	params.pageID 	= pageID;
        	params.gridData = selectedRows; 		
        	
        	sendService(classID, methodID, params, doSearch, doSearch); 
        });
        
    }
    
    // 검색조건 셋업
    function setupConditions() {
    	try {
            var cbox1 =  new GtCondBox2("condBox2",0);
        } catch (e) {
        	showAlert(e.message,'ERR');
        }
    }
    
</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="NEXT_SNO" >
    <input type="hidden" name="P_GUBN" >
    <input type="hidden" name="P_IN_DT" >
    <input type="hidden" name="P_SNO" >
    <input type="hidden" name="P_stDate" >
    <input type="hidden" name="P_edDate" >
    <input type="hidden" name="ATTCH_FILE_NO" >
</form>
<form name="form">

    <div class="inquiry-table type1" id="condBox2">

       <div class="table-row" style="width:40%" >    
          
          <div class="table-cell" >
             ${condel.getLabel('RBA_50_03_01_001','기사 일자')}
             <div class="content">
	           <div class='calendar'>
	         	  ${condel.getInputDateDx('stDate', stDate)}  ~  ${condel.getInputDateDx('edDate', edDate)}
	           </div>
             </div>
          </div>
          
          <div class="table-cell" >
            ${condel.getLabel('RBA_50_03_01_002','출처')}
            <div class="content">
       	       ${SRBACondEL.getSRBASelect('SRC_INFO_C','' ,'' ,'R320' ,'ALL','ALL','','','','')}
            </div>
		 </div>

          <div class="table-cell" >
             ${condel.getLabel('RBA_50_03_01_007','기사내용')}
             <div class="content">
                <input type="text" class="cond-input-text" id="NEWS_CTNT" name="NEWS_CTNT" size="100"  />
             </div>
          </div>
             
          <div class="table-cell">
	         ${condel.getLabel('RBA_50_03_01_008','등록사유')}
	         <div class="content">
	            <input type="text" class="cond-input-text" id="DR_RSN" name="DR_RSN" size="100"  />
              </div>
          </div>
       
       </div>      
         
       <div class="table-row">
         <div class="table-cell" ></div>
         <div class="table-cell"  >
             ${condel.getLabel('RBA_50_03_01_003','기사 제목')}
             <div class="content">
               <input type="text" class="cond-input-text" id="NEWS_TITE" name="NEWS_TITE" size="60"  />
             </div>
          </div>
         <div class="table-cell" ></div>
         <div class="table-cell" ></div>
       </div>
       
    </div>
        
    <div class="button-area">
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA004", defaultValue:"등록", mode:"C", function:"doRegister", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
    </div>
    
    <div class="tab-content-bottom" style="margin-top: 8px;">
        <div id="GTDataGrid1_Area"></div>        
    </div>
    
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />