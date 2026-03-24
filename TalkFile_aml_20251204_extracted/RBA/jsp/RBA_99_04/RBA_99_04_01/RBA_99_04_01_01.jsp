<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : AML 서약서
* Group           : GTONE, R&D센터/개발2본부
* Author          : 손영우
* Since           : 2024.06.14.
********************************************************************************************************************************************
--%>
<%@ page import="com.itplus.common.server.user.SessionHelper"   %>
<%@ page import="java.util.HashMap"                             %>
<%@ page import="jspeed.base.http.MultipartRequest"             %>
<%@ page import="jspeed.websvc.ActionHelper4Java"               %>
<%@ page import="com.gtone.aml.dao.common.JDaoUtilSingle"        %>
<%@ page import="com.gtone.webadmin.util.DBHelper"              %>
<%@ page import="java.text.SimpleDateFormat"              %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"           %>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<script src="${path}/Kernel/webadmin/js/common.js"  ></script>
<script src="${path}/Kernel/webadmin/js/userInfo.js"></script>

<%
	String todayDate = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
	request.setAttribute("todayDate", todayDate);
	
	request.setCharacterEncoding("utf-8") ;
	MultipartRequest req; req = new MultipartRequest(request);
	SessionHelper sessionHelper = new SessionHelper(session);
	String userId               = sessionHelper.getUserId().toString();
	String DEP_ID				= sessionHelper.getDeptId().toString();
	
	HashMap inHash = new HashMap();
    inHash.put("SESS_LANG_TYPE",LANG_CD);

    String actClass=null;
    HashMap outHash = null;
    ActionHelper4Java ws = new ActionHelper4Java();
    
    Integer iUserId = new Integer(userId);
    HashMap userHash = new HashMap();
    inHash.put("USER_ID",iUserId);
    actClass = "com.itplus.common.actions.user.CUserGetAction";
    outHash = ws.execute(actClass,inHash);
    
    if(outHash !=null){
        userHash = DBHelper.cacheResultSet2HashMap((jspeed.base.jdbc.CacheResultSet)outHash.get("RESULT"));
    }
    
    actClass = "com.itplus.common.actions.user.CUserDetailListByUserIdGetAction";
    outHash = ws.execute(actClass,inHash);
    HashMap detailMap = new HashMap();
    
    if(outHash !=null){
        jspeed.base.jdbc.CacheResultSet detailRs = (jspeed.base.jdbc.CacheResultSet)outHash.get("RESULT");
        while(detailRs.next())
        {
            detailMap.put("D"+ detailRs.getString("DETAIL_CD"),detailRs.getString("DETAIL"));
        }
    }
    String POSITION_CODE = StringHelper.evl(userHash.get("POSITION_CODE"),"");

	request.setAttribute("DEP_ID"          ,DEP_ID        );
	request.setAttribute("POSITION_CODE"   ,POSITION_CODE );
	
	DataObj check_user_pledge = JDaoUtilSingle.getData("common.CpledgeDAO.checkUserPledge",new Object[]{ID});
    
    if(!check_user_pledge.isEmpty()) {
        request.setAttribute("PRE_PLEDGE_DT", check_user_pledge.get("PLEDGE_DT"));
    } else {
    	request.setAttribute("PRE_PLEDGE_DT", check_user_pledge.get("PLEDGE_DT"));
    }
    String toDate = todayDate.replace("-", "");
	request.setAttribute("toDate", toDate);
%>

<script>
	$(document).ready(function(){
	});
</script>
<style>
.basic-table tr {
    border-bottom: 1px solid black;
}
</style>
<form>
<div class="content">
	<div class="inquiry-table type1" id='condBox1'>
		<div class="table-row" style="width:20%;">
			<div class="table-cell">
			 ${condel.getLabel('AML_10_03_05_01_102','고객관리번호')}
				<div class="content">
					<input type="text" class="cond-input-text" name="JKW_NO" value="${ID}" style="border: 0px;background-color:white;" readonly="readonly"></input>
				</div>
			</div>	       
		</div>
		<div class="table-row" style="width:24%;">
			<div class="table-cell">
			${condel.getLabel('AML_00_01_01_01_007','사용자')}
				<div class="content">
					<input type="text" class="cond-input-text" name="JKW_NM" value="${USER_NAME}" style="border: 0px;background-color:white;" readonly="readonly"></input>
				</div>
			</div>
		</div>
		<div class="table-row" style="width:28%;">
			<div class="table-cell">
			${condel.getLabel('AML_10_20_01_01_034','부서')}
				<div class="content">
					<input type="text" class="cond-input-text" name="VALT_BRNM" value="${BDPT_CD_NAME}" style="border: 0px;background-color:white;" readonly="readonly"></input>
				</div>
			</div>
		</div>
		<div class="table-row" style="width:28%;">
			<div class="table-cell">
			${condel.getLabel('AML_10_30_12_01_006','등록일자')}
				<div class="content">
					<input type="text" class="cond-input-text" name="CHG_DT" value="<%= request.getAttribute("todayDate") %>" style="border: 0px;background-color:white;" readonly="readonly"></input>
				</div>
			</div>
		</div>
	</div>
		<table class="basic-table" style="width:100%; margin-top: 40px; table-layout:fixed">
			<tr>
				<td colspan="2" style="padding: 16px 0px;">
					<span style="font-weight:bold; font-size:24px;">자금세탁방지 준수 서약서</span><br><br>
					<span style="font-weight:bold;">본인은 자금세탁방지업무와 관련하여 다음사항을 준수할 것을 서약합니다.</span><br><br>
					<div style="margin:0px 8px;">
					<span>1. 본인은 재직시 자금세탁방지법령(특정 금융거래정보의 보고 및 이용 등에 관한 법률(시행령, 규정 포함), 공중 등 협박목적을 위한 자금 조달행위의 금지에 관한 법률(시행령, 규정 포함), 범죄수익은닉의 규제 및 처벌 등에 관한 법률, 자금세탁방지 및 공중협박자금조달금지에 관한 업무규정)과 당행 내규인 자금세탁방지업무취급준칙과 자금세탁방지업무방법을 금융기관 임직원으로서 성실히 준수하겠습니다.</span><br><br>
					<span>2. 자금세탁방지업무 수행중 인지하게 된 고객정보는 외부에 유출하지 않도록 하겠습니다.</span><br><br>
					<span>3. 금융기관 임직원으로서 항상 청렴하고 건전하게 업무를 처리하겠으며 불법적으로 재산을 취득하거나 탈세목적으로 재산을 취득하지 않도록 하겠습니다.</span><br><br>
					<span>4. 상기와 같이 본인은 자금세탁행위에 직·간접적으로 일체 관여하지 않겠습니다.</span><br><br>
					</div>
					<div id="PLEDGE_CTNT" style="display: none;">
						1. 본인은 재직시 자금세탁방지법령(특정 금융거래정보의 보고 및 이용 등에 관한 법률(시행령, 규정 포함), 공중 등 협박목적을 위한 자금 조달행위의 금지에 관한 법률(시행령, 규정 포함), 범죄수익은닉의 규제 및 처벌 등에 관한 법률, 자금세탁방지 및 공중협박자금조달금지에 관한 업무규정)과 당행 내규인 자금세탁방지업무취급준칙과 자금세탁방지업무방법을 금융기관 임직원으로서 성실히 준수하겠습니다. 
						2. 자금세탁방지업무 수행중 인지하게 된 고객정보는 외부에 유출하지 않도록 하겠습니다. 
						3. 금융기관 임직원으로서 항상 청렴하고 건전하게 업무를 처리하겠으며 불법적으로 재산을 취득하거나 탈세목적으로 재산을 취득하지 않도록 하겠습니다. 
						4. 상기와 같이 본인은 자금세탁행위에 직·간접적으로 일체 관여하지 않겠습니다.
					</div>
				</td>
			</tr>
			<tr style="border-bottom:0px;">
				<td style="padding:6px 0px;">
					<span style="font-size:12px;font-weight:bold;">서약한 내용이 사실과 다름이 없음을 확인합니다.</span>
				</td>
				<td>
					<div class ="content" style="text-align:right">
						<div class="radio-list">
							<div class="radio-item">
								<input type="radio" id="Y" name="YN" value="Y" style="margin-left:0"><label for="Y">예</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="N" name="YN" value="N" style="margin-left:0"><label for="N">아니오</label>
							</div>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<div class="button-area" style="display:flex; justify-content:flex-end;">
					${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn" , defaultValue:"저장", mode:"R", function:"onSubmit"   , cssClass:"btn-36"}')}
				</div>
				</td>
			</tr>
		</table>
</form>
<script>
var PLEDGE_CTNT = document.getElementById('PLEDGE_CTNT').textContent;
function onSubmit() {
    const yes = document.getElementById('Y');
    const no = document.getElementById('N');

     if (yes.checked) {
    	
		showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){

			if("${toDate}" == "${PRE_PLEDGE_DT}") {
				showAlert("${msgel.getMsg('RBA_99_04_01_01_001','금일 이미 동의 절차를 완료하였음을 알려드립니다.')}", 'INFO', function(){location.reload();});
				return;
			}
        	var params   = new Object();
        	params.pageID = "userPledge";
        	params.USER_ID = "${ID}";
        	params.DEP_ID = "${DEP_ID}";
        	params.POSITION_CODE = "${POSITION_CODE}";
        	params.USER_NM = "${USER_NAME}";
        	params.LOGIN_ID = "${LOGIN_ID}";
        	params.PLEDGE_CTNT = PLEDGE_CTNT;
        	params.CRE_ID = "${ID}";
        	params.PRE_PLEDGE_DT = "${PRE_PLEDGE_DT}";
        	params.actionName =  "com.gtone.aml.server.action.admin.user.AMLUserPledge";
        	
        	console.log(params);
        	
        	sendService(null, null, params, doSave_success, doSave_fail); 
        });
    	
	} else if (no.checked) {
		showAlert("${msgel.getMsg('RBA_99_04_01_01_002','서약서에 동의하시기 바랍니다.')}","WARN");
	} else {
		showAlert("${msgel.getMsg('RBA_99_04_01_01_002','서약서에 동의하시기 바랍니다.')}","WARN");
	}
}

function doSave_success(data){
showAlert("${msgel.getMsg('adm.message.ok.execute','정상 처리되었습니다.')}", 'INFO', function(){self.close();});
}
function doSave_fail(){    	 
	overlay.hide();
}
</script>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />