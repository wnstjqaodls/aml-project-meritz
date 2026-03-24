<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_05_03.jsp
* Description     : 메일전송
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-07-31
--%>
<%
	
     String DPRT_CD  = Util.nvl(request.getParameter("DPRT_CD"));
     request.setAttribute("DPRT_CD",DPRT_CD);
    
%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
	<script language="JavaScript">
	var GridObj1 = null;
	var GridObj2 = null;
	var overlay = new Overlay();
	var classID  = "RBA_50_05_05_02";
	var pageID   = "RBA_50_05_05_02";

	$(document).ready(function(){
		setupConditions();
		setupGrids();
	});
    
    // Initial function
    function init(){
        initPage();
    }

    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_05_05_02_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(65vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : '메일대상자'
           ,completedEvent  : function(){
               doSearch();
            }
        });
    }

    // 검색조건 셋업
    function setupConditions(){
        try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(50, 100, 0);
        } catch (e) {
            alert(e.message);
        }
    }
	function doSearch() {
		overlay.show(true, true);
        var methodID    = "doSearch";
        
        GridObj1.refresh({
            actionParam: {
                "pageID"  : pageID,
                "classID" : classID,
                "methodID": methodID,
                "DPRT_CD": "${DPRT_CD}",
            },
            completedEvent:    doSearch_end
            ,failEvent:doSearch_end
        });
	}
	function doSearch_end() {
		overlay.hide();
	}
	
	function doSend() {
		
		if(!chk_selected(GridObj1)){
			alert("메일 보낼 대상을 선택하세요.");
			return;
		};
		
		overlay.show(true, true);
		
	    var methodID 	= "mailSend";
	    GridObj1.save({
            actionParam: {
                "pageID"  : pageID,
                "classID" : classID,
                "methodID": methodID,
                "MAIL_CNTNT" : $("#MAIL_CNTNT").val(),
                "MAIL_SBJ" : $("#MAIL_SBJ").val()
            },
            sendFlag        : "SELECTED",
            completedEvent:doSearch2_end
            ,failEvent:doSearch2_end
        });
	}
	 
	function doSearch2_end() {
		overlay.hide();
	}
	
	function chk_selected(GridObj)
	{	
		var selectedRows = GridObj.getSelectedRows();
		var selSize      = selectedRows.length;
	
		for(var i = 0; i < selectedRows.length; i++)
		{
			var selObj; selObj = GridObj.getRow(i);
			if(selSize > 0)
			{
				return true;
			}
		}
		return false;
	}


</script>
<body>
<form name="form1">
<input type="hidden" name="pageID" >
<input type="hidden" name="classID" >
<input type="hidden" name="methodID" >
    <div class="panel panel-primary" >
        <!-- <div align="right" style="margin-top: 10px"> -->
        <div class="cond-btn-row" style="text-align:right">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"RBA031", defaultValue:"전송", mode:"U", function:"doSend", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
        </div>
        <div class="panel-footer" >
            <div class="table-box" >
                <table width="100%">
               	 <tr>
			  	  	<th style="text-align:center;">${msgel.getMsg('RBA_50_05_05_005','메일 제목')}</th>
	              </tr>
	              <tr>
	                  <td width="90%" align="left">
	                      <textarea name="MAIL_SBJ" id ="MAIL_SBJ" style="width:100%;" rows=2></textarea>
	                  </td>
	              </tr>
			  	  <tr>
			  	  	<th style="text-align:center;">${msgel.getMsg('RBA_50_05_05_004','메일 내용')}</th>
	              </tr>
	              <tr>
	                  <td width="90%" align="left">
	                      <textarea name="MAIL_CNTNT" id ="MAIL_CNTNT" style="width:100%;" rows=10></textarea>
	                  </td>
	              </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />
