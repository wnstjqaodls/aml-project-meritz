<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_06_01_02.jsp
* Description     : KRI 지표 상세
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 24.
********************************************************************************************************************************************
--%>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String KRI_NO = Util.nvl(request.getParameter("KRI_NO"));
    String GUBN = Util.nvl(request.getParameter("P_GUBN")); //구분이 0이면 등록 아니면 수정
    
    request.setAttribute("KRI_NO",KRI_NO);
    request.setAttribute("GUBN",GUBN);
%>
<script>
    var GridObj1    = null;
   
    /** Initial function */
    $(document).ready( function() {
    	setupGrids();
    });

    // Initial function
    function init() { 
    	initPage(); 
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
        /* GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_06_01_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : 'KRI지표관리 - 상세'
           ,completedEvent  : function(){
               setupGridFilter([GridObj1]);
               if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
                   doSearch();
               }
            }
        }); */
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
	         	  elementAttr: { class: "grid-table-type" },
	    		 "height"						:"calc(90vh - 100px)",
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
	    	     "export": {"allowExportSelectedData" : true, "enabled" : true, "excelFilterEnabled" : true, "fileName" : "전사주요위험지표목록"},
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
	    		    {"dataField": "REF_RSK_INDCT", "caption": '${msgel.getMsg("RBA_50_06_01_02_104","RI지표")}', "alignment": "center", "allowResizing": true, "cssClass": "link", "allowSearch": true, "allowSorting": true}
	    	    ],
	
	    	    "onCellClick" : function(e) {
	    	        if (e.data) {
	    	            clickGrid1Cell('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
	    	        }
	    	    }
		}).dxDataGrid("instance");
    	if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
            doSearch();
        }
    }

    /* do */
    
    //KRI 지표 상세 조회
    function doSearch(){
        
        /* GridObj1.refresh({
            actionParam: {
                "pageID"  : "RBA_50_06_01_02",
                "classID" : "RBA_50_06_01_02",
                "methodID": "getKRIInfo",
                "KRI_NO" : "${KRI_NO}"
            },
            completedEvent: doSearch_end
        }); */
        var params = new Object();
		var methodID = "getKRIInfo";
		var classID  = "RBA_50_06_01_02";
		params.pageID	= "RBA_50_06_01_02";
		params.KRI_NO   = "${KRI_NO}";
		
		sendService(classID, methodID, params, doSearch_end, doSearch_fail);
    }
    
    //KRI 지표 상세 조회 end
    function doSearch_end(gridData,data){
    	var selObj = gridData[0];
        setData(selObj);
    }

    function doSearch_fail(){
    	console.log("doSearch_fail");
    }

    //KRI 지표 상세 조회 HTML에 데이타 삽입
    function setData(selObj){
    	form1.KRI_NO.value           = (selObj.KRI_NO           == undefined)?"":selObj.KRI_NO;
        form1.KRI_NM.value           = (selObj.KRI_NM           == undefined)?"":selObj.KRI_NM;
        form1.KRI_CTNT.value         = (selObj.KRI_CTNT         == undefined)?"":selObj.KRI_CTNT;
        form1.FRQ_C.value            = (selObj.FRQ_C            == undefined)?"":selObj.FRQ_C;
        form1.UNIT_C.value           = (selObj.UNIT_C           == undefined)?"":selObj.UNIT_C;
        form1.REF_RSK_INDCT.value    = (selObj.REF_RSK_INDCT    == undefined)?"":selObj.REF_RSK_INDCT;
    }
    
    function doClose()
    {
        window.close();
    }
    
    function doParentReload()
    {
        window.opener.location.href = window.opener.document.URL;    // 부모창 새로고침
    }
    
    /** Save */
    function doSave()
    {
        var frm = document.form1;
        
        if ( frm.KRI_NO.value == "" ) {
        	showAlert("${msgel.getMsg('RBA_50_06_01_02_007','KRI지표ID는 필수 입력항목입니다.')}","WARN");
        	return;
        }

        if ( frm.KRI_NM.value == "") {
        	showAlert("${msgel.getMsg('RBA_50_06_01_02_008','KRI지표명은 필수 입력항목입니다.')}","WARN");
        	return;
        }
        
        showConfirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}", "저장", doSave_Action);

		/* GridObj1.save({
            actionParam     : {
                "pageID"           : "RBA_50_06_01_02",
                "classID"          : "RBA_50_06_01_02",
                "methodID"         : "doSave",
                "KRI_NO"           : form1.KRI_NO.value,  
                "KRI_NM"           : form1.KRI_NM.value,      
                "KRI_CTNT"         : form1.KRI_CTNT.value,
                "FRQ_C"            : form1.FRQ_C.value,
                "UNIT_C"           : form1.UNIT_C.value,
                "REF_RSK_INDCT"    : form1.REF_RSK_INDCT.value
            }
           ,sendFlag      : "USERDATA"
           ,completedEvent: doSave_end
        }); */
    }

    function doSave_Action(){


    	var params = new Object();
		var methodID = "doSave";
		var classID  = "RBA_50_06_01_02";
		params.pageID	= "RBA_50_06_01_02";
		params.KRI_NO   = form1.KRI_NO.value;
		params.KRI_NM	= form1.KRI_NM.value;
		params.KRI_CTNT = form1.KRI_CTNT.value;
		params.FRQ_C	= form1.FRQ_C.value;
		params.UNIT_C	= form1.UNIT_C.value;
		params.REF_RSK_INDCT = form1.REF_RSK_INDCT.value; 
		
		sendService(classID, methodID, params, doSave_end, doSave_fail);

    }
    
    function doSave_end()
    {
        opener.doSearch();
	 	window.close();	
    }

    function doSave_fail()
    {
        console.log("doSave_fail");	
    }
    
    /** Update */
    function doUpdate()
    {
        var frm = document.form1;

        if ( frm.KRI_NM.value == "") {
        	showAlert("${msgel.getMsg('RBA_50_06_01_02_008','KRI지표명은 필수 입력항목입니다.')}","WARN");
        	return;
        }
        
        showConfirm("${msgel.getMsg('RBA_50_06_01_02_110','수정하시겠습니까?')}", "수정", doUpdate_Action);
		
		
    }

    function doUpdate_Action(){
    	var obj = new Object();
    	var classID         = "RBA_50_06_01_02";
        var methodID        = "doUpdate";
        obj.pageID          = "RBA_50_06_01_02";
        obj.KRI_NO          = form1.KRI_NO.value; 
        obj.KRI_NM          = form1.KRI_NM.value;
        obj.KRI_CTNT        = form1.KRI_CTNT.value;
        obj.FRQ_C           = form1.FRQ_C.value;
        obj.UNIT_C          = form1.UNIT_C.value; 
        obj.REF_RSK_INDCT   = form1.REF_RSK_INDCT.value;
        
        /* new GTActionRun().run({
            actionParam     : obj
           ,completedEvent  : function(actionParam, jsonResultData){
        	   doUpdate_end(actionParam, jsonResultData);
            }
        }); */ 

        sendService(classID, methodID, obj, doUpdate_end, doUpdate_fail);
    	}

    function doUpdate_end(obj, jsonResultData){
        opener.doSearch();
	 	window.close();	
    }

    function doUpdate_fail(){
        console.log("doUpdate_fail");    
    }
    
    function doDelete()
	{
        var frm; frm = document.form1;

		showConfirm("${msgel.getMsg('RBA_50_08_03_02_014','삭제하시겠습니까?')}", "삭제", doDelete_Action);
		
        /* new GTActionRun().run({
            actionParam     : obj
           ,completedEvent  : function(actionParam, jsonResultData){
        	   doUpdate_end(actionParam, jsonResultData);
            }
        }); */
    }
    
    function doDelete_Action(){
    	 var obj = new Object();
 		var classID         = "RBA_50_06_01_02";
         var methodID        = "doDelete";
         obj.pageID          = "RBA_50_06_01_02";        
         obj.KRI_NO          = form1.KRI_NO.value;
         
         sendService(classID, methodID, obj, doDelete_end, doDelete_fail);

    	}

    function doDelete_end(obj, jsonResultData){
        opener.doSearch();
	 	window.close();	
    }

    function doDelete_fail(){
        console.log("doDelete_fail");    
    }    
</script>

<form name="form1" id="form1" method="post">
    <input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="GUBN"            id="GUBN"    value="${GUBN}"   />
    

  <table class="basic-table">
    <% if ( "0".equals(GUBN) ) {%>
    	<tr>
            <th class="title required">
		    	${msgel.getMsg('RBA_50_06_01_02_001','ID')}
            </th>
            <td><input name="KRI_NO" id="KRI_NO" type="text" value="" size="20"></td>
        </tr>
    <% } else { %>
        <tr>
            <th class="title required">${msgel.getMsg('RBA_50_06_01_02_001','ID')}</th>
            <td><input name="KRI_NO" id="KRI_NO" type="text" value="" size="20" readonly></td>
        </tr>    
    <% } %>
        <tr>
            <th class="title required">${msgel.getMsg('RBA_50_06_01_02_002','지표명')}</th>
            <td><input name="KRI_NM" id="KRI_NM" type="text" value="" size="80" maxlength="200"></td>
        </tr>
        <tr>
            <th class="title required">${msgel.getMsg('RBA_50_06_01_02_003','지표산식')}</th>
            <td><textarea name="KRI_CTNT" id="KRI_CTNT" class="textarea-box" value="" cols="30" rows="10" maxlength="2000"></textarea></td> 
            
        </tr>
        <tr>
            <th class="title required">${msgel.getMsg('RBA_50_06_01_02_004','주기')}</th>
            <td>${SRBACondEL.getSRBASelect('FRQ_C','' ,'' ,'R311' ,'','','','','','')}</td>
        </tr>
        <tr>
            <th class="title required">${msgel.getMsg('RBA_50_06_01_02_005','단위')}</th>
            <td>${SRBACondEL.getSRBASelect('UNIT_C','' ,'' ,'R318' ,'','','','','','')}</td>
        </tr>
        <tr>
            <th class="title">${msgel.getMsg('RBA_50_06_01_01_009','Risk Factor 코드')}</th>
            <td>${SRBACondEL.getSRBASelect('REF_RSK_INDCT', '', '', 'R310', '', '', '', '', '', '')}</td>
        </tr>
        </table>

<div class="button-area" style="display: flex;justify-content: flex-end; margin-top : 8px;">
        <span id ="sbtn_03" >
        </span>
        <% if("0".equals(GUBN) ) { %>
           ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
        <% } else if( "1".equals(GUBN) ) { %>
           ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"updateBtn", defaultValue:"수정", mode:"U", function:"doUpdate", cssClass:"btn-36"}')}
           ${btnel.getButton(outputAuth, '{btnID:"sbtn_03", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
        <% } %>
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
</div>
<div class="tab-content-bottom" style="display: none">
      <div id="GTDataGrid1_Area"></div>
</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 