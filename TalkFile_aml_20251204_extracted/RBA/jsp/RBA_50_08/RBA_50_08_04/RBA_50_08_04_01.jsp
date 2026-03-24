<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : RBA_50_08_04_01.jsp
* Description     : 교육계획및 현황관리
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 8.
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
    var classID= "RBA_50_08_04_01";
    
    // [ Initialize ]
    $(document).ready(function(){
        setupConditions();
        setupGrids();
    });
    
    function doSearch()
    {
        overlay.show(true, true);
        GridObj1.removeAll();
        GridObj1.refresh({
            actionParam     : {
                "pageID"            : $("input[name=pageID]","form[name=form1]").val()
               ,"classID"           : classID
               ,"methodID"          : "doSearch"
               ,"stDate"            : getDxDateVal("stDate",true)
               ,"edDate"            : getDxDateVal("edDate",true)
               ,"EDU_TGT_G_C"       : form1.EDU_TGT_G_C.value
               ,"EDU_CHNL_G_C"      : form1.EDU_CHNL_G_C.value
               ,"EDU_SUBJ_NM"       : form1.EDU_SUBJ_NM.value
            }
           ,completedEvent : doSearch_end
           ,failEvent : function(e){overlay.hide();}
        });
    }
    
    function doSearch_end(data)
    {
        if (data&&data.GRID_DATA&&data.GRID_DATA.length>0) {
            $.each(data.GRID_DATA,function(i,o){o.ROW_NUM=i;});
            GridObj1.selectRow([0]);
        }
        overlay.hide();
    }
    
    function clickGrid1Cell(id, obj, selectData, rowIdx, colIdx, columnId, colId)
    {         
        if(columnId == "EDU_SDT" ) {
            form2.pageID.value = 'RBA_50_08_04_02';
            form2.classID.value    	  = classID;
            form2.methodID.value      = "getSearchFileInfo";
            form2.eduDt.value  = obj.EDU_DT;
            form2.sNo.value      = obj.SNO;
            form2.EDU_SDT.value      = obj.EDU_SDT;
            form2.EDU_EDT.value      = obj.EDU_EDT;
            //유안타증권 - BSL
            form2.EDU_PGM_C.value = obj.EDU_PGM_C;
            form2.P_GUBN.value = '1';               //구분:0 등록 1:수정
            form2.ATTCH_FILE_NO.value = obj.ATTCH_FILE_NO;  //첨부파일번호
            window_popup_open(form2, 800, 600, '');
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }
        
        if(columnId == "ATTCH_FILE_YN" ) {
            form2.pageID.value = 'RBA_50_08_04_04';
            form2.classID.value    	  = classID;
            form2.methodID.value      = "getSearchFileInfo";
            form2.ATTCH_FILE_NO.value = obj.ATTCH_FILE_NO;  //첨부파일번호
            window_popup_open(form2, 500, 300, '');
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }        

    }

	function doRegister(){
		
		form2.classID.value    		 = classID;
        form2.pageID.value  		= "RBA_50_08_04_02";
    	form2.methodID.value         = "getSearchFileInfo";
		form2.eduDt.value  = '';
		form2.sNo.value      = '';
		form2.P_GUBN.value = '0';         //구분:0 등록 1:수정
        form2.ATTCH_FILE_NO.value = 0;  //첨부파일번호
		var win;                win = window_popup_open(form2, 800, 600, '');
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
            cbox1.setItemWidths(320, 90, 1);
        } catch (e) {
            alert(e.message);
        }
        $("#searchBtn").bind("click",function(){
            doSearch();
        });
        
    }
    
    function setupGrids()
    {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid01'
           ,headerId        : 'RBA_50_08_04_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 140px)'
           ,completedEvent  : function(){doSearch();}
        });
    }
</script>
<form name="form2" method="post">
    <input type="hidden" name="pageID"   />
    <input type="hidden" name="classID"   />
    <input type="hidden" name="methodID"   />
    <input type="hidden" name="eduDt"  />
    <input type="hidden" name="sNo"      />
    <input type="hidden" name="P_GUBN" >
    <input type="hidden" name="EDU_SDT" >
    <input type="hidden" name="EDU_EDT" >
    <input type="hidden" name="ATTCH_FILE_NO" >
    
    <!-- 유안타증권 - BSL -->
    <input type="hidden" name="EDU_PGM_C" >        
</form>
<!-- Main Body Start -->
<form name="form1" method="post">
    <input type="hidden" name="pageID" value="RBA_50_08_04_01"  />
    <div class="cond-box" id="condBox1">
        <div class="cond-row" style="visibility:hidden">
            <!-- 교육기간[ -->
            <div class="cond-item">
                ${condel.getInputDateDxPair('RBA_50_08_04_01_001','교육기간','stDate',stDate,'edDate',edDate)}
            </div>
            <!-- ]교육기간 -->
            <!-- 교육대상[ -->
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_08_04_01_002','교육대상')}</span>
                <RBATag:selectBoxJipyo name="EDU_TGT_G_C" cssClass="cond-select" groupCode="C0004"
                mapGroupCode="" firstComboWord="ALL" rptGjdt="MAX" eventFunction="" selectStyle="width:150px;"/>
            </div>
            <!-- ]교육대상 -->
        </div>
        <div class="cond-row" style="visibility:hidden">
            <!-- 교육채널[ -->
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_08_04_01_003','교육채널')}</span>
                <RBATag:selectBoxJipyo name="EDU_CHNL_G_C" cssClass="cond-select" groupCode="C0006"
                mapGroupCode="" firstComboWord="ALL" rptGjdt="MAX" eventFunction="" selectStyle="width:150px;"/>
            </div>
            <!-- ]교육채널 -->
            <!-- 교육과목명[ -->
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_08_04_01_004','교육과목명')}</span>
                <input type="text" class="cond-input-text" id="EDU_SUBJ_NM" name="EDU_SUBJ_NM" size="25"  />
            </div>
            <!-- ]교육과목명 -->
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