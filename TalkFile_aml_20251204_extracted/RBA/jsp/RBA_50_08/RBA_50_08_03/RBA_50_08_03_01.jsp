<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : RBA_50_08_03_01.jsp
* Description     : AML활동보고및 조치관리
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 4. 26.
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
    var classID= "RBA_50_08_03_01";
    
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
                "pageID"            : $("input[name=pageID]","form[name=form1]").val()
               ,"classID"           : "RBA_50_08_03_01"
               ,"methodID"          : "doSearch"
               ,"stDate"            : getDxDateVal("stDate",true)
               ,"edDate"            : getDxDateVal("edDate",true)
               ,"RSLT_G_C"          : form1.RSLT_G_C.value
               ,"RPT_G_C"           : form1.RPT_G_C.value
               ,"DOC_TITE"          : form1.DOC_TITE.value
               ,"DCS_RQST_BRNO"     : form1.DCS_RQST_BRNO.value
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
        if(columnId == "DCS_DT" ) {
            form2.pageID.value = 'RBA_50_08_03_02';
            form2.classID.value    	  = classID;
            form2.methodID.value      = "getSearchFileInfo";
            form2.dcsDt.value  = obj.DCS_DT;
            form2.sNo.value      = obj.SNO;
            form2.DP_SEND_DT.value      = obj.DP_SEND_DT;
            form2.ACTN_DT.value      = obj.ACTN_DT;
            form2.P_GUBN.value = '1';               //구분:0 등록 1:수정
            form2.RSLT_ATTCH_FILE_NO.value = obj.RSLT_ATTCH_FILE_NO;  //첨부파일번호
            form2.ACTN_ATTCH_FILE_NO.value = obj.ACTN_ATTCH_FILE_NO;  //첨부파일번호
            form2.ACTN_PLAN_YN.value = obj.ACTN_PLAN_YN;  //조치계획여부
            form2.ACT_PRGR_S_C.value = obj.ACT_PRGR_S_C;  //진행상태
            form2.ACTN_PLAN_G_C.value = obj.ACTN_PLAN_G_C;  //계획구분
            window_popup_open(form2, 800, 770, '');
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }
        
        if(columnId == "RSLT_ATTCH_FILE_YN" ) {
        	form2.pageID.value = 'RBA_50_08_03_04';
            form2.classID.value    	  = classID;
            form2.methodID.value      = "getSearchFileInfo2";
            form2.ATTCH_FILE_NO.value = obj.RSLT_ATTCH_FILE_NO;  //ATTCH_FILE_NO : 첨부파일 리스트팝업용 첨부파일번호
            window_popup_open(form2, 500, 300, '');
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }        
        
        if(columnId == "ACTN_ATTCH_FILE_YN" ) {
            form2.pageID.value = 'RBA_50_08_03_04';
            form2.classID.value    	  = classID;
            form2.methodID.value      = "getSearchFileInfo2";
            form2.ATTCH_FILE_NO.value = obj.ACTN_ATTCH_FILE_NO;  //form2.ATTCH_FILE_NO : 첨부파일 리스트팝업용 첨부파일번호
            window_popup_open(form2, 500, 300, '');
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }
    }

	function doRegister(){
		
		form2.classID.value    		 = classID;
        form2.pageID.value  		= "RBA_50_08_03_02";
    	form2.methodID.value         = "getSearchFileInfo";
		form2.dcsDt.value  = '';
		form2.sNo.value      = '';
		form2.P_GUBN.value = '0';         //구분:0 등록 1:수정
        form2.RSLT_ATTCH_FILE_NO.value = 0;  //첨부파일번호
		form2.ACTN_ATTCH_FILE_NO.value = 0;  //조치첨부파일번호
		var win;                win = window_popup_open(form2, 800, 800, '');
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
        
    }
    
    function setupGrids()
    {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid01'
           ,headerId        : 'RBA_50_08_03_01_Grid1'
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
    <input type="hidden" name="classID"   />
    <input type="hidden" name="methodID"   />
    <input type="hidden" name="dcsDt"  />
    <input type="hidden" name="sNo"      />
    <input type="hidden" name="P_GUBN" >
    <input type="hidden" name="DP_SEND_DT"  />
    <input type="hidden" name="ACTN_DT"  />
    <input type="hidden" name="ATTCH_FILE_NO" >
    <input type="hidden" name="RSLT_ATTCH_FILE_NO" >
    <input type="hidden" name="ACTN_ATTCH_FILE_NO" >
    <input type="hidden" name="ACTN_PLAN_YN" >
    <input type="hidden" name="ACT_PRGR_S_C" >
    <input type="hidden" name="ACTN_PLAN_G_C" >
    <input type="hidden" name="ATTCH_FILE_GUBN" >
</form>
<!-- Main Body Start -->
<form name="form1" method="post">
    <input type="hidden" name="pageID" value="RBA_50_08_03_01"  />
    <div class="cond-box" id="condBox1">
        <div class="cond-row" style="visibility:hidden">
            <!-- 결정일자[ -->
            <div class="cond-item">
                ${condel.getInputDateDxPair('RBA_50_08_03_01_001','결정일자','stDate',stDate,'edDate',edDate)}
            </div>
            <!-- ]결정일자 -->
            <!-- 의사결정구분코드[ -->
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_08_03_01_003','의사결정구분')}</span>
                <RBATag:selectBoxJipyo name="RSLT_G_C" cssClass="cond-select" groupCode="C0045"
                mapGroupCode="" firstComboWord="ALL" rptGjdt="MAX" eventFunction="" selectStyle="width:150px;"/>
            </div>
            <!-- ]의사결정구분코드 -->
        </div>
        <div class="cond-row" style="visibility:hidden">
            <!-- 보고구분[ -->
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_08_03_01_002','보고구분')}</span>
                <RBATag:selectBoxJipyo name="RPT_G_C" cssClass="cond-select" groupCode="C0003"
                mapGroupCode="" firstComboWord="ALL" rptGjdt="MAX" eventFunction="" selectStyle="width:150px;"/>
            </div>
            <!-- ]보고구분 -->
        </div>
        <div class="cond-row" style="visibility:hidden">
            <!-- 문서제목[ -->
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_08_03_01_004','문서제목')}</span>
                <input type="text" class="cond-input-text" id="DOC_TITE" name="DOC_TITE" size="35"  />
            </div>
            <!-- ]문서제목 -->
            <!-- 관련/의사결정요청부서[ -->
            <div class="cond-item">
                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;${msgel.getMsg('RBA_50_08_03_01_005','관련/의사결정요청부서')}</span>
                ${SRBACondEL.getSRBASelect("DCS_RQST_BRNO","", "", "R352", "", "ALL", "", "", "", "")}
            </div>
            <!-- ]관련/의사결정요청부서 -->
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