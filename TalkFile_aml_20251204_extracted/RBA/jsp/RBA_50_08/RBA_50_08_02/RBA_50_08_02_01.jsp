<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : RBA_50_08_02_01.jsp
* Description     : RBA 포상 및 징계내역 관리
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 4. 20.
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
        $('#condBox1').find('span').css('width','120px')
        
    });
    
    function doSearch()
    {
        overlay.show(true, true);
        GridObj1.removeAll();
        GridObj1.refresh({
            actionParam     : {
                "pageID"            : $("input[name=pageID]","form[name=form1]").val()
               ,"classID"           : "RBA_50_08_02_01"
               ,"methodID"          : "doSearch"
               ,"stDate"            : getDxDateVal("stDate",true)
               ,"edDate"            : getDxDateVal("edDate",true)
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
        if(columnId == "PRIZE_DT" ) {
            form2.pageID.value = 'RBA_50_08_02_02';
            window_popup_open(form2, 750, 400, '');
            form2.prizeDt.value  = obj.PRIZE_DT;
            form2.sNo.value      = obj.SNO;
            form2.P_GUBN.value = '1';               //구분:0 등록 1:수정
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }
        
    }

	function doRegister(){
		
		form2.pageID.value  		= "RBA_50_08_02_02";
		window_popup_open(form2, 750, 400, '');
		form2.prizeDt.value  = '';
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
    }
    
    function setupGrids()
    {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid01'
           ,headerId        : 'RBA_50_08_02_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 140px)'
           ,completedEvent  : function(){doSearch();
               //setupGridFilter([GridObj1]);
            }
        });
    }
    
    //포상및징계내역 삭제
    function doDelete() {
    	
		var selectedItem = GridObj1.currentRow();

        if(selectedItem == null) {
            alert("${msgel.getMsg('AML_20_08_02_01_001','선택된 데이터가 없습니다.')}");
			return;
		}
        
    	if(!confirm('${msgel.getMsg("AML_10_01_01_01_007","삭제하시겠습니까?")}')) return;
    	
        var obj = new Object();
        obj.classID     = "RBA_50_08_02_01";
        obj.pageID      = "RBA_50_08_02_01";
        obj.methodID    = "doMultiDelete";
        
        GridObj1.save({    
            actionParam     : obj
            ,sendFlag        : "SELECTED"
            ,completedEvent  : doSearch      
        });
    }
</script>
<form name="form2" method="post">
    <input type="hidden" name="pageID"   />
    <input type="hidden" name="prizeDt"  />
    <input type="hidden" name="sNo"      />
    <input type="hidden" name="P_GUBN" >
</form>
<!-- Main Body Start -->
<form name="form1" method="post">
    <input type="hidden" name="pageID" value="RBA_50_08_02_01"  />

    <div class="cond-box" id="condBox1">
        <div class="cond-row" style="visibility:hidden">
            <!-- 발생일자[ -->
            <div class="cond-item">
                ${condel.getInputDateDxPair('RBA_50_08_02_02_009','포상(징계)일자','stDate',stDate,'edDate',edDate)}
            </div>
            <!-- ]발생일자 -->
        </div>
        <div class="cond-line"></div>
        <div class="cond-btn-row" style="text-align:right">
            <div>
                ${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')}
                ${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"RBA004", defaultValue:"등록", mode:"C", function:"doRegister", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-plus"}')}
                ${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-minus"}')}
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