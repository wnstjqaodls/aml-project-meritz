<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : RBA_50_08_06_01.jsp
* Description     : 내부감사 내역 관리
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 14.
********************************************************************************************************************************************
--%>
<%@ page import="java.text.ParseException" %>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String stDate = Util.nvl(request.getParameter("stDate"));
    String edDate = Util.nvl(request.getParameter("edDate"));
   
    try{
        if("".equals(stDate) == true) {
        	stDate = DateUtil.addDays(DateUtil.getDateString(), -365, "yyyy-MM-dd");
        }
        if("".equals(edDate) == true) {
        	edDate = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
        }
        }catch(ParseException e){
        	Log.logAML(Log.ERROR, e);
        }
    
    request.setAttribute("stDate",stDate);
    request.setAttribute("edDate",edDate);
%>
<script>
    var GridObj1 = null;
    var overlay = new Overlay();
    
    // [ Initialize ]
    $(document).ready(function(){
        setupConditions();
        setupGrids();
    });
    
    // Initial function
    function init(){
        initPage();
    }
    
    function doSearch()
    {
    	overlay.show(true, true);
        GridObj1.removeAll();
        GridObj1.refresh({
            actionParam     : {
                "pageID"            : "RBA_50_08_06_01"
               ,"classID"           : "RBA_50_08_06_01"
               ,"methodID"          : "doSearch"
               ,"stDate"            : getDxDateVal("stDate",true)
               ,"edDate"            : getDxDateVal("edDate",true)
               ,"IMPRV_G_C"         : form.IMPRV_G_C.value
               ,"BRNO"              : form.SEARCH_DEP_ID.value
            }
           ,completedEvent : doSearch_end
           ,failEvent : function(e){overlay.hide();}
        });
    }
    
    function doSearch_end(data)
    {
        overlay.hide();
    }
    
    function clickGrid1Cell(id, obj, selectData, rowIdx, colIdx, columnId, colId)
    {         
        if(columnId == "ISPT_DT" ) {
            form2.pageID.value = 'RBA_50_08_06_02';
            window_popup_open(form2, 750, 550, '');
            form2.isptDt.value  = obj.ISPT_DT;
            form2.ACTN_DT.value  = obj.ACTN_DT;
            form2.sNo.value      = obj.SNO;
            form2.P_GUBN.value = '1';               //구분:0 등록 1:수정
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }
        
    }

	function doRegister(){		
		form2.pageID.value  		= "RBA_50_08_06_02";
		window_popup_open(form2, 750, 550, '');
		form2.isptDt.value  = '';
		form2.sNo.value      = '';
		form2.P_GUBN.value = '0';         //구분:0 등록 1:수정
		form2.target 				= form2.pageID.value;
		form2.action 				= '<c:url value="/"/>0001.do';
		form2.submit();		
	}
    

    /* setup */
    
    /** 검색조건 셋업 */
    function setupConditions()
    {
        try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(320, 75, 0);
        } catch (e) {
            alert(e.message);
        }
        $("#searchBtn").bind("click",function(){
            doSearch();
        });
        
        form.DEP_TITLE.value = "전체";
    }
    
    function setupGrids()
    {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid01'
           ,headerId        : 'RBA_50_08_06_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 140px)'
           ,completedEvent  : function(){doSearch();
               //setupGridFilter([GridObj1]);
            }
        });
    }
</script>
<form name="form2" method="post">
    <input type="hidden" name="pageID"   />
    <input type="hidden" name="isptDt"  />
    <input type="hidden" name="sNo"      />
    <input type="hidden" name="P_GUBN" >
    <input type="hidden" name="ACTN_DT" >
</form>
<!-- Main Body Start -->
<form name="form" method="post">
	<input type="hidden" name="pageID" value="RBA_50_08_06_01">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">

    <div class="cond-box" id="condBox1">
        <div class="cond-row" style="visibility:hidden">
            <!-- 감사일자[ -->
            <div class="cond-item">
                ${condel.getInputDateDxPair('RBA_50_08_06_01_001','감사일자','stDate',stDate,'edDate',edDate)}
            </div>
            <!-- ]감사일자 -->
            <!-- 개선구분코드[ -->
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_08_06_01_002','개선구분')}</span>
                <RBATag:selectBoxJipyo name="IMPRV_G_C" cssClass="cond-select" groupCode="C0048"
                mapGroupCode="" firstComboWord="ALL" rptGjdt="MAX" eventFunction="" selectStyle="width:100px;"/>
            </div>
            <!-- ]개선구분코드 -->            
        </div>
        <div class="cond-row" style="visibility:hidden">
            <!-- 부점번호[ -->
            <div class="cond-item">
            	${condel.getLabel('RBA_50_08_06_01_003','지점명')}
            	<RBATag:searchRbaInput searchName="SEARCH_DEP_ID" searchClass="cond-select" searchStyle="width: 60px;" text1Name="DEP_ID" 
					text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>" 
					searchFunction='doRBASearchInput(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepName2")' 
					popupFunction='doRBASelectInputPopup("searchRbaDepPopup", 480, 580, "SEARCH_DEP_ID", "setRBASearchInputPopup(searchName, searchInfo)")' 
					searchValue="" text1Value="" text2Value=""/>
            </div>
            <!-- ]부점번호 -->
        </div>
        <div class="cond-line"></div>
        <div class="cond-btn-row" style="text-align:right">
            <div>
                ${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')}
                ${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"RBA004", defaultValue:"등록", mode:"C", function:"doRegister", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-plus"}')}
            </div>
        </div>
    </div>
    <div class="panel panel-primary" style="visibility:hidden;">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />