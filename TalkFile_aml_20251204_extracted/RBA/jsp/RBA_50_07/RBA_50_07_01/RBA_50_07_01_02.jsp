<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_07_01_01_Popup.jsp
* Description     : 개선대응방안 상세
* Group           : GTONE, R&D센터/개발2본부
* Author          : SBJ
* Since           : 2018-04-24
--%>

<%@ page import="java.util.*" %>
<%@ page import="org.omg.CORBA.UserException" %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_01.RBA_50_07_01_02" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%
    
	String GUBN     = request.getParameter("P_GUBN");
	//out.println("GUBN="+GUBN);

	String POOL_SNO="" ;
    String IMPRV_CNFRME; IMPRV_CNFRME = jspeed.base.xml.XMLHelper.normalize(request.getParameter("IMPRV_CNFRME"));
    String MAIN_EXEC_CTNT; MAIN_EXEC_CTNT = jspeed.base.xml.XMLHelper.normalize(request.getParameter("MAIN_EXEC_CTNT"));
    String ADD_INP_CTNT; ADD_INP_CTNT = jspeed.base.xml.XMLHelper.normalize(request.getParameter("ADD_INP_CTNT"));
    
    if(!"0".equals(GUBN)){
    	POOL_SNO = jspeed.base.xml.XMLHelper.normalize(request.getParameter("POOL_SNO"));
    }
    
    DataObj input  = new DataObj();
    input.put("POOL_SNO", POOL_SNO);
    
    /*
    input.put("IMPRV_CNFRME", IMPRV_CNFRME);
    input.put("MAIN_EXEC_CTNT", MAIN_EXEC_CTNT);
    input.put("ADD_INP_CTNT", ADD_INP_CTNT);
    */
    DataObj output = null;
    try{
       output = RBA_50_07_01_02.getInstance().doSearch(input);
    }catch (UserException ex) {
        Log.logAML(Log.ERROR,this,"(UserException)",ex.toString());
    }
    
    request.setAttribute("POOL_SNO"    , output.getText("POOL_SNO"));    // POOL순번
    request.setAttribute("IMPRV_CNFRME"    , output.getText("IMPRV_CNFRME"));    // 개선대응방안
    request.setAttribute("MAIN_EXEC_CTNT" , output.getText("MAIN_EXEC_CTNT")); // 주요수행내용
    request.setAttribute("ADD_INP_CTNT"     , output.getText("ADD_INP_CTNT"));     // 추가입력내용
    
    request.setAttribute("GUBN",GUBN);

%>

<script language="JavaScript">
    
    var GridObj1;
    var classID  = "RBA_50_07_01_02";
    
    // Initialize
    $(document).ready(function(){
        setupGrids();
        doSearch();
    });
    
    function setupGrids(){
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 height	:"calc(90vh - 100px)",
			 "hoverStateEnabled": true,
			    "wordWrapEnabled": false,
			    "allowColumnResizing": true,
			    "columnAutoWidth": true,
			    "allowColumnReordering": true,
			    "cacheEnabled": false,
			    "cellHintEnabled": true,
			    "showBorders": true,
			    "showColumnLines": true,
			    "showRowLines": true,
			    "loadPanel" : { enabled: false },
			    "export":                  {
			        "allowExportSelectedData": true,
			        "enabled": false,
			        "excelFilterEnabled": true,
			        "fileName": "gridExport"
			    },
			    "sorting": {"mode": "multiple"},
			    "remoteOperations":                  {
			        "filtering": false,
			        "grouping": false,
			        "paging": false,
			        "sorting": false,
			        "summary": false
			    },
			    "editing":                  {
			        "mode": "batch",
			        "allowUpdating": false,
			        "allowAdding": true,
			        "allowDeleting": false
			    },
			    "filterRow": {"visible": false},
			    "rowAlternationEnabled": true,
			    "columnFixing": {"enabled": true},
			    "searchPanel":                  {
			        "visible": false,
			        "width": 250
			    },
			    "selection":                  {
			        "allowSelectAll": true,
			        "deferred": false,
			        "mode": "single",
			        "selectAllMode": "allPages",
			        "showCheckBoxesMode": "onClick"
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
			    "columns":[
	       		    
	       		    
   		    		{
   			            "dataField": "POOL_SNO",
   			            "caption": '${msgel.getMsg("RBA_50_08_01_02_001","순번")}',
   			            "width" : 100,
   			            "dataType": "number",
   			            "alignment": "center",
   			            "allowResizing": true,
   			            "allowSearch": true,
   			            "allowSorting": true
   		        	},
   		                           {
   		            "caption": '${msgel.getMsg("RBA_50_07_01_01_001","개선 대응방안 POOL")}',
   		            "alignment": "center",
   		            "columns" : [{
   		               "dataField": "IMPRV_CNFRME",
   		               "caption": '${msgel.getMsg("RBA_50_07_01_01_002","단계별개선대응방안")}',
   		               "cssClass"   : "link",
   		               "width" : 250,
   		               "allowResizing": true,
   		               "allowSearch": true,
   		               "allowSorting": true
   		           },
   		                                {
   		               "dataField": "MAIN_EXEC_CTNT",
   		               "caption": '${msgel.getMsg("RBA_50_07_01_01_003","주요수행내용")}',
   		               "width" : "40%",
   		               "height":"200px",
   		               "allowResizing": true,
   		               "allowSearch": true,
   		               "allowSorting": true
   		           }]
   		        },					{
   		            "caption": '${msgel.getMsg("RBA_50_07_01_01_004","추가입력사항")}',
   		            "alignment": "center",
   		            "columns" :[{
   		              "dataField": "ADD_INP_CTNT",
   		              "caption": '${msgel.getMsg("RBA_50_07_01_01_005","내용(수행계획에 대한 간략한 내용기술)")}',
   		              "width" : "40%",
   		              "allowResizing": true,
   		              "allowSearch": true,
   		              "allowSorting": true
   		               }]
   		        }
   		    ],
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    } 
       }).dxDataGrid("instance");	
    }
    
    // 개선목록 POOL 저장
    function doSave(){
        
        if($("button[id='btn_01']") == null) return;
            
         showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){
	         var classID  = "RBA_50_07_01_02";
	         var methodID = "doSave";
	         var params = new Object();
	         params.pageID	= pageID;
	         params.GUBN            = "${GUBN}";
	         params.POOL_SNO        = form.POOL_SNO.value;
	         params.IMPRV_CNFRME    = form.IMPRV_CNFRME.value;
	         params.MAIN_EXEC_CTNT  = form.MAIN_EXEC_CTNT.value;
	         params.ADD_INP_CTNT    = form.ADD_INP_CTNT.value;
	         
	
	         sendService(classID, methodID, params, save_end, save_end);
         });
    }
    
    // Risk Event상세 저장 end
    function save_end(){
        
        $("button[id='btn_01']").prop('disabled', false);
        
        showAlert('저장되었습니다.','WARN');
        
        opener.doSearch();
        opener.form2.P_GUBN.value = "";
        window.close();
    }
    
    // 닫기
    function doClose(){
    	opener.form2.P_GUBN.value = "";
        window.close();
    }
    
    // 팝업창을 우측상단에 X로 닫았을때 실행되는 펑션 20170324 KEOL
    function closePage( event ){
        if( event.clientY < 0 ){
            doClose();
        }
    }
    
</script>
<body onunload="closePage(event)">
   
<form name="form" method="post">
    <input type="hidden" id="pageID" name="pageID"> 
    <input type="hidden" id="classID" name="classID"> 
    <input type="hidden" id="methodID" name="methodID">
    <input type="hidden" name="POOL_SNO" value="${POOL_SNO}">
   
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
                <table class="basic-table">
                    <tr>
                        <th class="title">${msgel.getMsg("RBA_50_07_01_02_200","단계ID")}</th>
                        <td style="width:200px">${POOL_SNO}</td>
                        <th class="title">${msgel.getMsg("RBA_50_07_01_01_006","단계명")}</th>
                        <td><input type="text" name="IMPRV_CNFRME" id="IMPRV_CNFRME"  value="${IMPRV_CNFRME}"></td>
                    </tr>
                    <tr>
                        <th class="title">${msgel.getMsg("RBA_50_07_01_02_201","대응방안 내용")}</th>
                        <td colspan="3">
                        	<textarea id="MAIN_EXEC_CTNT" class="textarea-box" cols="300" rows="10">${MAIN_EXEC_CTNT}</textarea>
                      	</td>
                    </tr>
                    <tr>
                        <th class="title">${msgel.getMsg("RBA_50_07_01_02_202","추가입력 내용")}</th>
                        <td colspan="3">
                            <textarea id="ADD_INP_CTNT" class="textarea-box" cols="300" rows="10">${ADD_INP_CTNT}</textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
	<div class="button-area" style="display: flex; justify-content: flex-end; margin-top: 8px;">
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
    </div>
    <div class="panel panel-primary" style="visibility:hidden;">
    <div class="panel-footer" style="display:none;">
        <div id="GTDataGrid1_Area" style="display:none;"></div>
    </div>
</div>
</form>
