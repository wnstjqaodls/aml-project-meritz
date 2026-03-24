<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_01_01.jsp
* Description     : 외부징계내역관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : HHJ
* Since           : 2018-04-20
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

    $(document).ready(function(){
        setupConditions();
        setupGrids();
    });
    
    /*====== 20180508 징계구분 SelectBox onChange Start ==================*/
    function rprmSelectChange(nextSelId, GrpObj, v_afterFun) {
    	nextSelectChangeRPRM(nextSelId, GrpObj, v_afterFun);
	}
    
    function nextSelectChangeRPRM(nextSelectId, thisObj, afterFunction, gubun){
        var param = new Object();
        var nextGrpCd;
        
        if ( thisObj.value == '1' ) {
        	nextGrpCd = "C0001";
        } else if ( thisObj.value == '2' ) {
        	nextGrpCd = "C0002";
        } else {
        	nextGrpCd = "";
        }
        
        param.afterFunction = afterFunction;
        param.NEXT_SELECT_ID=nextSelectId;
        param.GRP_CD = nextGrpCd;
        param.gubun = gubun;
        
        goAjaxWidthReturn_RPRM("com.gtone.rba.common.action.SelectSRBACodeAction6", param, "onAfterNextSelectChange_RPRM");

    }


    function goAjaxWidthReturn_RPRM( actionName, paramdata, callbackfunc)
    {
    	var resultJson;
    	jQuery.ajax ( { type:'POST',
    			url: '/JSONServlet?Action@@@=' + actionName,
    			dataType:'text',					
    			processData:true,
    			data: paramdata,
    			success : function ( jsonData )
    			{
    				resultJson = JSON.parse(jsonData);
    				if(resultJson.ERROR && resultJson.ERRCODE != "00000"){
    					var msg = resultJson.ERROR[0].ERRMSG;
    					alert(msg);
    					return;
    				}else{
    					eval(callbackfunc + "(  resultJson, paramdata  )");
    				}
    			},
    			error : function(xhr, textStatus)
    			{
    				alert("Error" + textStatus);
    			}
    		}
    	)
    	return resultJson;
    }		


    //ajax사용해 select의 option값을 조회 후 option셋팅 :초기값 전체
    function onAfterNextSelectChange_RPRM(jsonObj, paramdata){
    	var cnt = jsonObj.RESULT.length;
    	jQuery("#"+paramdata.NEXT_SELECT_ID).html("");
    	jQuery("#"+paramdata.NEXT_SELECT_ID).attr("groupCode", paramdata.GRP_CD);
    	var html = "<option value='' >" + "::전체::" + "</option>";
    	for(var i=0; i<cnt; i++){
    		html += "<option value='" + jsonObj.RESULT[i].CD + "' >" + jsonObj.RESULT[i].CD_NM + "</option>";
    	}
    	jQuery("#"+paramdata.NEXT_SELECT_ID).html(html);
    	if(paramdata.afterFunction!=null && ""!=paramdata.afterFunction){
    		var res; res = ( new Function( 'return ' + paramdata.afterFunction ) )();
    	}
    }
  	/*====== 20180508 징계구분 SelectBox onChange End==================*/
    
    function doSearch()
    {   
        GridObj1.removeAll(); 
        GridObj1.refresh({
            actionParam         : {
                "pageID"	    : "RBA_50_08_01_01",
                "classID"	    : "RBA_50_08_01_01",
                "methodID"	    : "doSearch",
                "stDate"        : getDxDateVal("stDate",true),
                "edDate"        : getDxDateVal("edDate",true),
                "RPRM_G_C"      : form1.RPRM_G_C.value, 
                "RPRM_ACTN_G_C" : form1.RPRM_ACTN_G_C.value  
            },
            completedEvent	: doSearch_end     
        }); 
    }
    
    function doSearch_end(data)
    {
        overlay.hide();
    }
    
    function clickGrid1Cell(id, obj, selectData, rowIdx, colIdx, columnId, colId)
    {         
        if(columnId == "RPRM_DT" ) {
            form2.pageID.value  = 'RBA_50_08_01_02';
            window_popup_open(form2, 700, 450, '');
            form2.rprmDt.value  = obj.RPRM_DT;
            form2.sNo.value     = obj.SNO;
            form2.RPRM_G_C.value     = obj.RPRM_G_C;
            form2.P_GUBN.value  = '1';               //구분:0 등록 1:수정
            form2.target = form2.pageID.value;
            form2.action = "<c:url value='/'/>0001.do";
            form2.submit();
        }
        
    }

	function doRegister(){
		
		form2.pageID.value = "RBA_50_08_01_02";
		window_popup_open(form2, 700, 450, '');
		form2.rprmDt.value = '';
		form2.sNo.value    = '';
		form2.P_GUBN.value = '0';         //구분:0 등록 1:수정
		form2.target       = form2.pageID.value;
		form2.action 	   = '<c:url value="/"/>0001.do';
		form2.submit();		
	}
    
    function doDelete()
	{
        var selectedRows = GridObj1.getSelectedRowsData();
        var size         = selectedRows.length;
        var selectedHead = GridObj1.currentRow();

        if(size <= 0){
            alert("${msgel.getMsg('dataDeleteSelect','삭제할 데이타를 선택하십시오.')}"); 
            return;
        }

        if(!confirm("${msgel.getMsg('doDelete','삭제하시겠습니까?')}")) return;
        var methodID 	= "doDelete";
        var obj = new Object();
        obj.pageID   = "RBA_50_08_01_01";
        obj.classID  = "RBA_50_08_01_01";
        obj.methodID = methodID;      
        obj.RPRM_DT  = selectedHead.RPRM_DT;
        obj.SNO      = selectedHead.SNO;

        GridObj1.save({    
            actionParam     : obj
            ,sendFlag        : "SELECTED"
            ,completedEvent  : doSearch     
        });
    }

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
           ,headerId        : 'RBA_50_08_01_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : '400'
           ,completedEvent  : function(){doSearch();}
        });
    }
    
    //외부징계내역 삭제
    function doDelete() {
    	
		var selectedItem = GridObj1.currentRow();

        if(selectedItem == null) {
            alert("${msgel.getMsg('AML_20_08_02_01_001','선택된 데이터가 없습니다.')}");
			return;
		}
        
    	if(!confirm('${msgel.getMsg("AML_10_01_01_01_007","삭제하시겠습니까?")}')) return;
    	
        var obj = new Object();
        obj.classID     = "RBA_50_08_01_01";
        obj.pageID      = "RBA_50_08_01_01";
        obj.methodID    = "doMultiDelete";
        
        GridObj1.save({    
            actionParam     : obj
            ,sendFlag        : "SELECTED"
            ,completedEvent  : doSearch      
        });
    }
</script>
<form name="form2" method="post">
    <input type="hidden" name="pageID"/>
    <input type="hidden" name="rprmDt"/>
    <input type="hidden" name="sNo"   />
    <input type="hidden" name="RPRM_G_C"/>
    <input type="hidden" name="P_GUBN"/>
</form>
<!-- Main Body Start -->
<form name="form1" method="post">
    <input type="hidden" name="pageID" value="RBA_50_08_01_01"  />

    <div class="cond-box" id="condBox1">
        <div class="cond-row" style="visibility:hidden">
            <div class="cond-item">
                ${condel.getInputDateDxPair('RBA_50_08_01_02_005','징계일자','stDate',stDate,'edDate',edDate)}
            </div>
        </div>
        <div class="cond-row">
            <div class="cond-item">
                ${condel.getLabel('RBA_50_08_01_01_002','징계구분')}
                ${SRBACondEL.getSRBASelect('RPRM_G_C','' ,'' ,'R351' ,'','ALL','rprmSelectChange("RPRM_ACTN_G_C", this)','','','')}
            </div>
            <div class="cond-item">
                ${condel.getLabel('RBA_50_08_01_01_003','징계조치 구분')}
                <select id='RPRM_ACTN_G_C' name='RPRM_ACTN_G_C' groupCode='' class='cond-select'>
                	<option value='' >::전체::</option> 
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
    <div class="panel panel-primary" style="visibility:hidden;">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />