<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_06_02.jsp
* Description     : 내부감사 관리 상세
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 14.
********************************************************************************************************************************************
--%>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%


	String BAS_YYYYMM    = Util.nvl(request.getParameter("BAS_YYYYMM"  ));
    String ACD_OCC_G_C   = Util.nvl(request.getParameter("ACD_OCC_G_C" ));
    String ACD_OCC_AMT   = Util.nvl(request.getParameter("ACD_OCC_AMT" ));
    String GUBN          = Util.nvl(request.getParameter("P_GUBN"      )); //구분이 0이면 등록 아니면 수정
    
    request.setAttribute("BAS_YYYYMM"   ,BAS_YYYYMM  );
    request.setAttribute("ACD_OCC_G_C"  ,ACD_OCC_G_C );
    request.setAttribute("ACD_OCC_AMT"  ,ACD_OCC_AMT );
    request.setAttribute("GUBN"         ,GUBN        );
%>
<script>
    var GridObj1    = null;
   
    /** Initial function */
    $(document).ready( function() {
    	$('.popup-contents').css({overflow:"auto"});
    	setupGrids();
    });

    // 그리드 초기화 함수 셋업
    function setupGrids() {
         GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_08_07_02_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : ''
           ,completedEvent  : function(){
               if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
            	   setData();
               }
            }
        });
    }
    
    function setData(){
    	form.BAS_YYYYMM.value   = "${BAS_YYYYMM}";
        form.ACD_OCC_G_C.value  = "${ACD_OCC_G_C}";
        form.ACD_OCC_AMT.value  = "${ACD_OCC_AMT}";
    }
    
    function doClose()
    {
        window.close();
    }
    
    /** Save */
    function doSave()
    {
        var frm = document.form;
        var isNumChk; isNumChk = "";
        

        if ( frm.BAS_YYYYMM.value == "") {
        	alert("${msgel.getMsg('RBA_50_01_01_037','6자리의 기준년월을 입력해 주시기 바랍니다..(YYYYMM)')}");
        	return;
        }
        
        if(isNaN(frm.BAS_YYYYMM.value)){
        	alert("기준년월은 숫자만 입력가능합니다.");
            return false;
        } 
        
        if ( frm.ACD_OCC_AMT.value == "") {
        	alert("발생금액을 입력해 주시기 바랍니다.");
        	return;
        }
        
        if(isNaN(frm.ACD_OCC_AMT.value)){
        	alert("사고발생금액은 숫자만 입력가능합니다.");
            return false;
        }  
        
		if(!confirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}")) return;
		
		GridObj1.save({
            actionParam     : {
                "pageID"           : "RBA_50_08_07_02",
                "classID"          : "RBA_50_08_07_01",
                "methodID"         : "doSave",
                "BAS_YYYYMM_NEW"   : $("#BAS_YYYYMM").val(),
                "BAS_YYYYMM_ORG"   : "${BAS_YYYYMM}",
                "ACD_OCC_G_C_NEW"  : $("#ACD_OCC_G_C").val(),
                "ACD_OCC_G_C_ORG"  : "${ACD_OCC_G_C}",
                "ACD_OCC_AMT"      : $("#ACD_OCC_AMT").val(),
                "GUBN"             : "${GUBN}"
            }
           ,sendFlag      : "USERDATA"
           ,completedEvent: doSave_end
        });
    }

    function doSave_end()
    {
        opener.doSearch();
	 	window.close();	
    }
    
  
    function doDelete()
	{
        var frm; frm = document.form;

		if(!confirm("${msgel.getMsg('RBA_50_08_03_02_014','삭제하시겠습니까?')}")) return;

		GridObj1.save({
            actionParam     : {
                "pageID"           : "RBA_50_08_07_02",
                "classID"          : "RBA_50_08_07_01",
                "methodID"         : "doDeleteOne",
                "BAS_YYYYMM"       : $("#BAS_YYYYMM").val(),
                "ACD_OCC_G_C"      : $("#ACD_OCC_G_C").val(),
                "ACD_OCC_AMT"      : $("#ACD_OCC_AMT").val()
            }
           ,sendFlag      : "USERDATA"
           ,completedEvent: doSave_end
        });

    }   

</script>

<form name="form" id="form" method="post">
    <input type="hidden" name="pageID"          id="pageID"     value="RBA_50_08_06_02"    />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="GUBN"            id="GUBN"    value="${GUBN}"   />
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_07_001','기준년월')}(YYYYMM)*</th>
            <td><input name="BAS_YYYYMM" id="BAS_YYYYMM" type="text" value="" size="30" maxlength="6" style="text-align:center;" ></td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_07_002','사고발생구분')}*</th>
            <td>${SRBACondEL.getSRBASelect('ACD_OCC_G_C','100%' ,'' ,'R328' ,'' ,'' ,'','','','')}</td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_07_003','발생금액')}*</th>
            <td colspan="4"><input name="ACD_OCC_AMT" id="ACD_OCC_AMT" type="text" value="" size="60" maxlength="18" style="text-align:right;" ></td>
        </tr>
        </table>
    </div>
</div>

<div class="popup-cont-box">
    <div class="cond-btn-row" style="text-align:right;margin-top:10px;">
        <span id ="sbtn_03" >
        </span>
      	  ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-save"}')}
        <% if("1".equals(GUBN) ) { %>
           ${btnel.getButton(outputAuth, '{btnID:"sbtn_03", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-minus"}')}
        <% } %>
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-power-off", show:"N"}')}
    </div>
        <table border="0">
        <!-- 유안타증권 - BSL START -->
        <tr>
            <td><font color=blue>※ 관련 KoFIU 보고항묵(지표)</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02I6010101 (5.3.1) 회사특성_경영관리리스크현황</font></td>
        </tr>
        <!-- 유안타증권 - BSL END -->
        </table>
</div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 