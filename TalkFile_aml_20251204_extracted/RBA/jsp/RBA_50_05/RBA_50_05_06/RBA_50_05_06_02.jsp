<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_06_02.jsp
* Description     : 개선현황등록
* Group           : GTONE
* Author          : PJH
********************************************************************************************************************************************
--%>
<%@page import="jspeed.base.util.StringHelper"%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %> 
<%@page import="com.itplus.common.server.user.SessionHelper"%>
<%@ page import="com.gtone.rba.server.type03.RBA_30.RBA_30_06.RBA_30_06_05.RBA_30_06_05_01"  %>


<%
	String BAS_YYMM 			= Util.nvl(request.getParameter("BAS_YYMM")			, "");
	
	if(BAS_YYMM.matches("\\d{6}")){
		BAS_YYMM = BAS_YYMM.substring(0, 4) + "-" + BAS_YYMM.substring(4, 6);
	}
		
	String BRNO_NM  			= Util.nvl(request.getParameter("BRNO_NM")			, "");
	String LV1  			= Util.nvl(request.getParameter("RSK_CATG1_C")			, request.getParameter("CNTL_CATG1_C"));
	String LV1_NM  			= Util.nvl(request.getParameter("RSK_CATG1_C_NM")		, request.getParameter("CNTL_CATG1_C_NM"));
	String LV3  			= Util.nvl(request.getParameter("RSK_ELMT_C")			, request.getParameter("CNTL_ELMN_C"));
	String LV3_NM  			= Util.nvl(request.getParameter("RSK_ELMT_C_NM")		, request.getParameter("CNTL_ELMN_C_NM"));
	String addGubun = StringHelper.evl(request.getParameter("addGubun"  ),"");

    //세션 부서정보
    String depId = helper.getDeptId().toString();
    String depNm = helper.getDeptName();
	String ROLEID   			= sessionAML.getsAML_ROLE_ID();
	String USER_NM  			= sessionAML.getsAML_USER_NAME();
	String IMPRV_STRG_DT = "";
	if("".equals(IMPRV_STRG_DT)){
		IMPRV_STRG_DT = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
	}
	String IMPRV_RSLT_DT = "";
	
    request.setAttribute("DEP_ID", depId);
    request.setAttribute("DEP_NM", depNm);
	request.setAttribute("ROLEID",ROLEID);
	request.setAttribute("BAS_YYMM",BAS_YYMM);
	request.setAttribute("IMPRV_STRG_DT",IMPRV_STRG_DT);
	request.setAttribute("IMPRV_RSLT_DT",IMPRV_RSLT_DT);
	request.setAttribute("DR_OP_JKW_NM",USER_NM);
	request.setAttribute("LV1",LV1);
	request.setAttribute("LV1_NM",LV1_NM);
	request.setAttribute("LV3",LV3);
	request.setAttribute("LV3_NM",LV3_NM);
	request.setAttribute("BRNO_NM",BRNO_NM);
	request.setAttribute("ADDGUBUN" ,addGubun);

%>

<script language="JavaScript">
    var GridObj1 		= null;
	var overlay  		= new Overlay();
    var classID  		= "RBA_50_05_06_02";
	var ROLEID			= "${ROLEID}";
	var BAS_YYMM		= "${BAS_YYMM}";
	
    // Initialize
    $(document).ready(function(){
    	
    });	
	
    
	function doSave_check(){
    	
    	// 소관부점
    	if ($("#SEARCH_DEP_ID").val() == null || $("#SEARCH_DEP_ID").val() == "99999") {
            showAlert("${msgel.getMsg('RBA_50_05_06_01_015','소관부점을 입력하세요.')}",'WARN')&&($("#SEARCH_DEP_ID").focus());
            return false;
        }
    	
    	// 위험/통제 분류
    	if ($("#LV1").val() == null || $("#LV1").val() == "") {
            showAlert("${msgel.getMsg('RBA_50_05_06_01_016','RBA_50_05_06_01_016')}",'WARN')&&($("#LV1").focus());
            return false;
        }

    	// 위험/통제 요소
    	if ($("#LV1").val() == null || $("#LV1").val() == "") {
            showAlert("${msgel.getMsg('RBA_50_05_06_01_016','RBA_50_05_06_01_016')}",'WARN')&&($("#LV1").focus());
            return false;
        }
    	
//         return true;
        
        showConfirm('${msgel.getMsg("RBA_90_01_06_01_109","저장하시겠습니까?")}','${msgel.getMsg("AML_00_00_01_01_025","저장")}',doSaveReq_Action, doSaveReq_fail);

    }
    
    
    // 개선 조치 요청
    function doSaveReq(){
		if($("button[id='btn_01']") == null) return;
		doSave_check();
    }
    
    function doSaveReq_Action()
    {
    	var params = new Object();
		var methodID = "doSaveReq";
		var classID  = "RBA_50_05_06_01";
		
		params.DR_OP_JKW_NM    = form1.DR_OP_JKW_NM.value;				// 요청부점
// 		params.DEP_ID 		   = form1.DEP_ID.value;				// 요청부점
		params.BAS_YYMM 	   = form1.BAS_YYMM.value.replace('-','');				// 평가회차
		
// 		params.BRNO_NM   	   = form1.BRNO_NM.value;			// 소관부점
		params.BRNO   	   = form1.SEARCH_DEP_ID.value;			// 소관부점
		
		params.IMPRV_STRG_DT   = form1.IMPRV_STRG_DT.value.replace(/-/g,'');    		// 개선조치 요청일자
		params.IMPRV_STRG_CTNT = form1.IMPRV_STRG_CTNT.value;		// 개선조치 요청사항
		params.LV1 			   = form1.LV1.value;					// 위험/통제분류
		
		
		if(form1.LV3.value == 'ALL'){
			params.LV3 			  	   = "ALL";						// 위험/통제요소
		}else{
			params.LV3 			  	   = form1.LV3.value;		// 위험/통제요소
		}
		
		sendService(classID, methodID, params, doSaveReq_end, doSaveReq_fail);	
    }

    function doSaveReq_end()
    {
	 	window.close();	
        opener.doSearch();
    }

    function doSaveReq_fail()
    {
        console.log("doSave_fail");	
    }
    
   
    // 창닫기
    function doClose(){
        opener.doSearch();
        window.close();
    }
</script>
<style>
	.popup .dropdown {
    /* width: 180px; */
	}
	
	h3 {
    	font-weight: inherit;
    	font-size: 100%;
	}
	.textarea-box {
	    padding: 6px 8px;
	    background-color: #fff;
	    border: 1px solid #ccc;
	    width: 230%;
	}
	textarea:disabled {
		background-color :#f0f0f0;
		color :#666666;
	}
</style>

<form name="form2" method="post" >
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
   	<input type="hidden" name="ROLE_ID" value="${ROLEID}">
   	<input type="hidden" name="GYLJ_LINE_G_C" value="KR04">	<!-- 결재선구분코드 = KR04 : KRI 결재현황 -->
    <input type="hidden" name="GYLJ_ID">
    <input type="hidden" name="GYLJ_ROLE_ID">
    <input type="hidden" name="GYLJ_S_C">
    <input type="hidden" name="GYLJ_S_C_NM">
    <input type="hidden" name="GYLJ_G_C"  value="${GYLJ_G_C}">
    <input type="hidden" name="BRNO_NM" value="${BRNO_NM}">
<%--     <input type="hidden" name="LV3" value="${RSK_ELMT_C}"> --%>
    <input type="hidden" name="FLAG"/>
</form>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
</form>
<form name="form1"  method="post">

	<div id="GTDataGrid1_Area" style="display:none;"></div>
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
                <table class="basic-table" width="100%" class="hover">
                  <colgroup>
				    <col width="130px">
				    <col width="">
				   </colgroup>
				   <tbody>
                    <tr>
                        <th class="title" width="20%">${msgel.getMsg("RBA_50_03_02_001","평가회차")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="BAS_YYMM" id="BAS_YYMM" value="${BAS_YYMM}" disabled/>
                        </td>
                    </tr>
                    <tr>
                        <th class="title">${msgel.getMsg("RBA_50_05_06_01_004","요청부점")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" class="input_text" id="DEP_NM" name="DEP_NM" value="${DEP_NM}" disabled/>
				    		<input type="hidden" class="input_text" id="DEP_ID" name="DEP_ID" value="${DEP_ID}"disabled/>
                        </td>
                        <th class="title">${msgel.getMsg("RBA_50_05_06_01_006","요청자")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="DR_OP_JKW_NM" id="DR_OP_JKW_NM" value="${DR_OP_JKW_NM}" disabled/>
                        </td>
                    </tr>
                    
                    <%
						if(("Y").equals(addGubun) ){
					%>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_005","소관 부점")}</th>
                        <td>
				    		<input type="text" name="BRNO_NM" id="BRNO_NM" value="${BRNO_NM}"/>
                        </td>
                    	<th class="title">${msgel.getMsg("RBA_50_05_06_01_009","개선조치 요청일자")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="BRNO" id="IMPRV_STRG_DT" value="${IMPRV_STRG_DT}" disabled/>
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_007","위험/통제분류")}</th>
                        <td>
				    		<input type="text" name="LV1" id="LV1" value="${LV1 }"style="display:none;"/>
				    		<input type="text" name="LV1_NM" id="LV1_NM" value="${LV1_NM}"/>
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_008","위험/통제요소")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="LV3" id="LV3" value="${LV3}" style="display:none;"/>
				    		<input type="text" name="LV3_NM" id="LV3_NM" value="${LV3_NM}"/>
                        </td>
                    </tr>
                    <% } else if(("N").equals(addGubun)) { %>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_005","소관 부점")}</th>
                        <td>
                        	${condel.getBranchSearch('SEARCH_DEP_ID','ALL')}
                        </td>
                    	<th class="title">${msgel.getMsg("RBA_50_05_06_01_009","개선조치 요청일자")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="BRNO" id="IMPRV_STRG_DT" value="${IMPRV_STRG_DT}" disabled/>
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_007","위험/통제분류")}</th>
                        <td>
	      	 				${RBACondEL.getKRBASelect('LV1','' ,'' ,'SP001' ,'' ,'ALL' ,'nextSelectChange2_2("CNTL_CATG2_C", "SP003", this)','','','')}
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_008","위험/통제요소")}</th>
                        <td width="30%" align="left" >
<%-- 				    		<input type="text" name="LV3" id="LV3" value="${LV3}"/> --%>
	      	 				${RBACondEL.getKRBASelect('LV3','' ,'' ,'SP003' ,'' ,'ALL' ,'','','','')}
                        </td>
                    </tr>
                    <% } %>
                    
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_014","개선조치 요청사항")}</th>
                        <td colspan="3"><textarea name="IMPRV_STRG_CTNT" id="IMPRV_STRG_CTNT" rows="9" cols="10" style="width:100%;height:100px;" value="${RISK_RSN_DESC}"></textarea><br></td>
                        
                    </tr>
                    </tbody>
                 </table>
            </div>
        </div>

		<table border=0; width=100%; style="margin-top: 8px;">
			<tr style="vertical-align: top;">
				<td align="right" >
					${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSaveReq", cssClass:"btn-36"}')}
					${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}		
				</td>
			</tr>
		</table>

	</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />