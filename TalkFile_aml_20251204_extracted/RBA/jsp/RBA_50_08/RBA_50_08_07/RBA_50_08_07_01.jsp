<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_07_01.jsp
* Description     : 사고 발생금액 관리
* Group           : GTONE
* Author          : BSL
* Since           : 2018. 6. 22.
********************************************************************************************************************************************
--%>
<%@ page import="java.text.ParseException" %>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
   String startDate = "";
   String endDate = "";  
   try{
   if("".equals(startDate)) {
     startDate = DateUtil.addDays(DateUtil.getDateString(), -365, "yyyy-MM-dd");
   }
   if("".equals(endDate)) {
     endDate = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
     //try { endDate = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd"); }   catch(NumberFormatException e){System.out.println("날자 형식 오류");}
   }
   }catch(ParseException e){
	   Log.logAML(Log.ERROR, e);
   }
   request.setAttribute("startDate",startDate);
   request.setAttribute("endDate",endDate);
%>
<script>

    var GridObj1 = null;
    var pageID = "RBA_50_08_07_01";
    var classID  = "RBA_50_08_07_01";
    var curRow   = -1;
    
    $(document).ready(function(){
    	initSizeGTDataGrid3('GTDataGrid1_Area', '100%','calc(50vh - 100px)','GTDataGrid1', '<c:url value="/"/>GTDataGridServlet',initGTDataGrid1);
    	$("input[name=startDate]").attr("style","width:85px;");
        $("input[name=endDate]").attr("style","width:85px;");
    });
    
    function init() { initPage(); }
    
 	// Init Grid
    function initGTDataGrid1(){
        GridObj1 = initGrid3("GTDataGrid1", "RBA_50_08_07_01_Grid1", null,"", "GTDataGrid1_Area", "calc(75vh - 100px)", "${outputAuth.USE_YN}");
        doSearch();
    }

	 // [ dpSearch ] 
    function doSearch(){

	 	var startDate  = getDxDateVal("startDate").replaceAll("-","");
   		var endDate    = getDxDateVal("endDate").replaceAll("-","");
        
   		if (startDate > endDate){
     	   alert('종료일은 시작일보다 빠를 수 없습니다.');
           setupCalendarDx("startDate", "${startDate}");
           setupCalendarDx("endDate", "${endDate}");
    	   startDate   = getDxDateVal("startDate").replaceAll("-","");
     	   endDate     = getDxDateVal("endDate").replaceAll("-","");
   	 	}
   		
        //달력 선택 후 / 제거
        if(startDate.indexOf('/') == -1){
        } else{
           startDate   = getDxDateVal("startDate").replaceAll("/","");
        }
        
        if(endDate.indexOf('/')   == -1){
        } else{
           endDate     = getDxDateVal("endDate").replaceAll("/","");
        }
        
        startDate = startDate.substring(0,6);
        endDate = endDate.substring(0,6);
        
        GridObj1.getInstance().cancelEditData();
        GridObj1.clearSelection();
        GridObj1.refresh({
            actionParam     : {
                "pageID"    : pageID
               ,"classID"   : classID
               ,"methodID"  : "doSearch"
               ,"startDate" : startDate
               ,"endDate"   : endDate 
               ,"ACD_OCC_G_C" : form1.ACD_OCC_G_C.value
            }
        ,completedEvent	: doSearch_end
        });
    }

	var doSearch_end = function() {
        $("button[id='btn_01']").prop('disabled', false);
    }
	
    function clickGrid1Cell(id, obj, selectData, rowIdx, colIdx, columnId, colId)
    {         
        if(columnId == "BAS_YYYYMM" ) {
            form2.pageID.value = 'RBA_50_08_07_02';
            window_popup_open(form2, 750, 250, '');
            form2.BAS_YYYYMM.value  = obj.BAS_YYYYMM;
            form2.ACD_OCC_G_C.value  = obj.ACD_OCC_G_C;
            form2.ACD_OCC_AMT.value      = obj.ACD_OCC_AMT;
            form2.P_GUBN.value = '1';               //구분:0 등록 1:수정
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }
        
    }
    
	function doRegister(){		
		form2.pageID.value  		= "RBA_50_08_07_02";
		window_popup_open(form2, 750, 250, '');
        form2.BAS_YYYYMM.value      = "";
        form2.ACD_OCC_G_C.value     = "";
        form2.ACD_OCC_AMT.value     = "";
        form2.P_GUBN.value          = '0';               //구분:0 등록 1:수정
		form2.target 				= form2.pageID.value;
		form2.action 				= '<c:url value="/"/>0001.do';
		form2.submit();		
	}


    //사고발생금액
    function doDelete() {
    	
		var selectedItem = GridObj1.currentRow();

        if(selectedItem == null) {
            alert("${msgel.getMsg('AML_20_08_02_01_001','선택된 데이터가 없습니다.')}");
			return;
		}
        
    	if(!confirm('${msgel.getMsg("AML_10_01_01_01_007","삭제하시겠습니까?")}')) return;
    	
        var obj = new Object();
        obj.classID     = "RBA_50_08_07_01";
        obj.pageID      = "RBA_50_08_07_01";
        obj.methodID    = "doDelete";
        
        GridObj1.save({    
            actionParam     : obj
            ,sendFlag        : "SELECTED"
            ,completedEvent  : doSearch      
        });
    }
    
  
</script>

<form name="form2" method="post">
    <input type="hidden" name="pageID"   />
    <input type="hidden" name="BAS_YYYYMM"  />
    <input type="hidden" name="ACD_OCC_G_C"      />
    <input type="hidden" name="ACD_OCC_AMT" >
    <input type="hidden" name="P_GUBN" >
    
    
</form>

<form name="form1" onkeydown="doEnterEvent('doSearch');">

<input type="hidden" name="pageID"      id="pageID"     value=""    />
<input type="hidden" name="mode"        id="mode"       value=""    />
<input type="hidden" name="scd"         id="scd"        value=""    />  <!-- Code Type          -->
    
<div class="cond-box" id="condBox1">
    <div class="cond-row" style="visibility:visibility">
        <div class="cond-item">
              ${condel.getLabel('RBA_50_08_07_001','보고기준일')}
              ${condel.getInputDateDx('startDate',startDate)} ~ ${condel.getInputDateDx('endDate',endDate)}
          </div>
        <div class="cond-item">
            ${condel.getLabel('RBA_50_08_07_002','코드구분')}
            <select name="ACD_OCC_G_C" id="ACD_OCC_G_C" class="cond-select" style="width:100px" >
                <option value="" selected>::${msgel.getMsg('AML_10_01_01_01_001','전체')}::</option>    
                <option value="A">금융사고</option>
                <option value="B">소송</option>
                <option value="C">민원</option>
            </select>
        </div>
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
<div class="panel panel-primary">
    <div class="panel-footer" >
        <div id="GTDataGrid1_Area"></div>
    </div>
</div>
</form>
</body>
</html>