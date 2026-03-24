<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_06_01_03.jsp
* Description     : RULE 지표 상세
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 25.
********************************************************************************************************************************************
--%>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String RULE_NO   = Util.nvl(request.getParameter("RULE_NO"));
    String GUBN       = Util.nvl(request.getParameter("P_GUBN"    )); //구분이 0이면 등록 아니면 수정
    
    request.setAttribute("RULE_NO"              ,RULE_NO            );
    request.setAttribute("GUBN"      ,GUBN    );
%>
<script>
    var GridObj1    = null;
   
    /** Initial function */
    $(document).ready( function() {
    	
    	setupGrids();
    	 if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
             doSearch();
         }
    });

    function setupFilter(){
        	var gridArrs = new Array();
        	var gridObj = new Object();
        	gridObj.gridID = "GTDataGrid1_Area";
        	gridObj.title = "RULE지표관리 - 상세";
        	gridArrs[0] = gridObj;
        	
        	setupGridFilter2(gridArrs);	
        }
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	 GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
         	elementAttr: { class: "grid-table-type" },
			 height	:"calc(90vh - 100px)",
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
		     "export":                  
		     {
		         "allowExportSelectedData"  : true,
		         "enabled"                  : true,
		         "excelFilterEnabled"       : true,
		         "fileName"                 : "TMS 룰 모니터링 목록"
		     },
		     "sorting": {"mode"             : "multiple"},
		     "remoteOperations":                  
		     {
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
		     "searchPanel":                  
		     {
		         "visible"                  : false,
		         "width"                    : 250
		     },
		     "selection":                  
		     {
		         "allowSelectAll"           : true,
		         "deferred"                 : false,
		         "mode"                     : "single",
		         "selectAllMode"            : "allPages",
		         "showCheckBoxesMode"       : "always"
		     }
		   ,"columns": [
		        {
		            "dataField"    : "SEQ",
		            "caption"      : '${msgel.getMsg("RBA_50_05_04_007","순번")}',
		            "alignment"    : "center",
		            "allowResizing": true,
		            "allowSearch"  : true,
		            "allowSorting" : true
		        }, {
		        	"dataField": "",
		            "caption": '${msgel.getMsg("RBA_50_06_01_03_009","TMS 룰")}',
		            "alignment": "center",
		            "columns" : [
		               {
			               "dataField": "RULE_NO",
			               "caption": 'RULE ID',
			               "cssClass": "link",
			               "alignment": "center",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           }, {
			               "dataField": "RULE_NM",
			               "caption": '${msgel.getMsg("RBA_50_06_01_03_002","지표명")}',
			               "alignment": "left",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           }, {
			               "dataField": "RULE_CTNT",
			               "caption": '${msgel.getMsg("RBA_50_06_01_03_003","지표설명")}',
			               "alignment": "left",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true,
			               "width" : 300
			           }
			        ]
		        }, {
		        	"dataField": "",
		            "caption": '${msgel.getMsg("RBA_50_06_01_02_102","지표 모니터링")}',
		            "alignment": "center",
		            "columns" : [
		               {
			               "dataField": "JIPYO_OFFR",
			               "caption": '${msgel.getMsg("RBA_50_06_01_02_003","지표산식")}',
			               "alignment": "left",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           }, {
			               "dataField": "FRQ_C",
			               "caption": '주기',
			               "alignment": "center",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true,
			               "visible": false
			           }, {
			               "dataField": "FRQ_NM",
			               "caption": '${msgel.getMsg("RBA_50_06_01_02_004","주기")}',
			               "alignment": "center",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           }, {
			               "dataField": "UNIT_C",
			               "caption": '단위',
			               "alignment": "center",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true,
			               "visible": false
			           }, {
			               "dataField": "UNIT_NM",
			               "caption": '${msgel.getMsg("RBA_50_06_01_02_005","단위")}',
			               "alignment": "center",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true
			           }, {
			               "dataField": "JIPYO_OFFR",
			               "caption": '지표산식',
			               "alignment": "center",
			               "allowResizing": true,
			               "allowSearch": true,
			               "allowSorting": true,
			               "visible": false
			           }
			        ]
		        }
		    ]
		    ,"onCellClick" : function(e) {
		        if (e.data) {
		            clickGrid1Cell('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
		        }
		    }
        }).dxDataGrid("instance");	
    }

    /* do */
    
    //KRI 지표 상세 조회
    function doSearch(){
        
/*         GridObj1.refresh({
            actionParam: {
                "pageID"  : "RBA_50_06_01_03",
                "classID" : "RBA_50_06_01_03",
                "methodID": "getRULEInfo",
                "RULE_NO" : "${RULE_NO}"
            },
            completedEvent: doSearch_end
        });
         */
        var classID  = "RBA_50_06_01_03"; 
        var methodID = "getRULEInfo";
        var params = new Object();
        params.pageID		= "RBA_50_06_01_03";
        params.RULE_NO		= "${RULE_NO}";
        
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }
    
    //KRI 지표 상세 조회 end
    function doSearch_success(gridData, data){
    	var selObj = gridData[0];
        setData(selObj);
    }

    //KRI 지표 상세 조회 HTML에 데이타 삽입
    function setData(selObj){
    	form1.RULE_NO.value           = (selObj.RULE_NO           == undefined)?"":selObj.RULE_NO;
        form1.RULE_NM.value           = (selObj.RULE_NM           == undefined)?"":selObj.RULE_NM;
        form1.RULE_CTNT.value         = (selObj.RULE_CTNT         == undefined)?"":selObj.RULE_CTNT;
        form1.FRQ_C.value             = (selObj.FRQ_C             == undefined)?"":selObj.FRQ_C;
        form1.UNIT_C.value            = (selObj.UNIT_C            == undefined)?"":selObj.UNIT_C;
        form1.JIPYO_OFFR.value        = (selObj.JIPYO_OFFR        == undefined)?"":selObj.JIPYO_OFFR;
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
        
        if ( frm.RULE_NO.value == "" ) {
        	showAlert('${msgel.getMsg("RBA_50_06_01_03_007","RULE지표ID는 필수 입력항목입니다.")}','WARN');
        	return;
        }

        if ( frm.RULE_NM.value == "") {
        	showAlert('${msgel.getMsg("RBA_50_06_01_03_008","RULE지표명은 필수 입력항목입니다.")}','WARN');
        	return;
        }
        showConfirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}", "저장",function(){
        	
        	var params   = new Object();
         	var methodID = "doSave";
         	var classID  = "RBA_50_06_01_03";
         	 		
         	params.pageID 	= "RBA_50_06_01_03";
         	params.RULE_NO          = form1.RULE_NO.value;  
         	params.RULE_NM          = form1.RULE_NM.value;      
         	params.RULE_CTNT        = form1.RULE_CTNT.value;
         	params.FRQ_C            = form1.FRQ_C.value;
         	params.UNIT_C           = form1.UNIT_C.value;
         	params.JIPYO_OFFR       = form1.JIPYO_OFFR.value;
         	
         	sendService(classID, methodID, params, doSave_end, doSave_end); 
        });
		/* if(!confirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}")) return;
		
		GridObj1.save({
            actionParam     : {
                "pageID"           : "RBA_50_06_01_03",
                "classID"          : "RBA_50_06_01_03",
                "methodID"         : "doSave",
                "RULE_NO"          : form1.RULE_NO.value,  
                "RULE_NM"          : form1.RULE_NM.value,      
                "RULE_CTNT"        : form1.RULE_CTNT.value,
                "FRQ_C"            : form1.FRQ_C.value,
                "UNIT_C"           : form1.UNIT_C.value,
                "JIPYO_OFFR"       : form1.JIPYO_OFFR.value
            }
           ,sendFlag      : "USERDATA"
           ,completedEvent: doSave_end
        }); */
    }

    function doSave_end()
    {
        opener.doSearch();
	 	window.close();	
    }
    
    /** Update */
    function doUpdate()
    {
        var frm = document.form1;

        if ( frm.RULE_NM.value == "") {
        	showAlert('${msgel.getMsg("RBA_50_06_01_03_008","RULE지표명은 필수 입력항목입니다.")}','WARN');
        	return;
        }
        showConfirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}", "저장",function(){
        	var params   = new Object();
         	var methodID = "doUpdate";
         	var classID  = "RBA_50_06_01_03";
         	 		
         	params.pageID 	= "RBA_50_06_01_03";
         	params.RULE_NO          = form1.RULE_NO.value;  
         	params.RULE_NM          = form1.RULE_NM.value;      
         	params.RULE_CTNT        = form1.RULE_CTNT.value;
         	params.FRQ_C            = form1.FRQ_C.value;
         	params.UNIT_C           = form1.UNIT_C.value;
         	params.JIPYO_OFFR       = form1.JIPYO_OFFR.value;
         	
         	sendService(classID, methodID, params, doUpdate_end, doUpdate_end); 
        });
    }

    function doUpdate_end(gridData, data)
    {
        opener.doSearch();
	 	window.close();	
    }
    
    function doDelete()
	{
        var frm; frm = document.form1;
        showConfirm("${msgel.getMsg('RBA_50_08_03_02_014','삭제하시겠습니까?')}", "삭제",function(){
        	 var classID  = "RBA_50_06_01_03"; 
             var methodID = "doDelete";
             var params = new Object();
             params.pageID		= "RBA_50_06_01_03"; 
             params.RULE_NO		= form1.RULE_NO.value; 
             
             sendService(classID, methodID, params, doUpdate_end, doUpdate_end);
        });


    }    
</script>

<form name="form1" id="form1" method="post">
    <input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="GUBN"            id="GUBN"    value="${GUBN}"   />
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
    <% if ( "0".equals(GUBN) ) {%>
        <tr>
            <th style="text-align:left; width:25%">${msgel.getMsg('RBA_50_06_01_03_001','ID')}*</th>
            <td style="width:75%"><input name="RULE_NO" id="RULE_NO" type="text" value="" size="5"></td>
        </tr>
    <% } else { %>
        <tr>
            <th style="text-align:left; width:25%">${msgel.getMsg('RBA_50_06_01_03_001','ID')}*</th>
            <td style="width:75%"><input name="RULE_NO" id="RULE_NO" type="text" value="" size="5" readonly></td>
        </tr>    
    <% } %>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_06_01_03_002','지표명')}*</th>
            <td><input name="RULE_NM" id="RULE_NM" type="text" value="" size="80" maxlength="200"></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_06_01_03_003','지표설명')}</th>
            <td><textarea name="RULE_CTNT" id="RULE_CTNT" value="" rows="3" maxlength="1000"></textarea></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_06_01_03_004','지표산식')}</th>
            <td><textarea name="JIPYO_OFFR" id="JIPYO_OFFR" value="" rows="3" maxlength="1000"></textarea></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_06_01_03_005','주기')}</th>
            <td>${SRBACondEL.getSRBASelect('FRQ_C','' ,'' ,'R311' ,'','','','','','')}</td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_06_01_03_006','단위')}</th>
            <td>${SRBACondEL.getSRBASelect('UNIT_C','' ,'' ,'R318' ,'','','','','','')}</td>
        </tr>
        </table>
    </div>
</div>

<div class="popup-cont-box">
    <div class="cond-btn-row" style="text-align:right;margin-top:10px;">
        <span id ="sbtn_03" >
        </span>
        <% if("0".equals(GUBN) ) { %>
           ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-save"}')}
        <% } else if( "1".equals(GUBN) ) { %>
           ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doUpdate", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-save"}')}
           ${btnel.getButton(outputAuth, '{btnID:"sbtn_03", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-minus"}')}
        <% } %>
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-power-off", show:"N"}')}
    </div>
</div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid2_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 