<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%--
- File Name  : RBA_10_05_00_01.jsp
- Author     : 
- Comment    : 보고항목 데이터등록 입력 화면 제어
- Version    : 
- history    : 
--%>

<script>
	function setSelectVal(nextColumn, obj) {
		if (nextColumn != "") {
			var index = jQuery("select[name='" + obj.name + "']").index(obj);
			rbanextSelChg(nextColumn, obj.mapGroupCode, obj, index,"onAfterRbaCdList");
		}
		
	}

	function rbanextSelChg(nextSelectId, nextGrpCd, thisObj, nextEqId, afterFunction) {
		var param = new Object();
		param.NEXT_SELECT_ID = nextSelectId;
		param.NEXT_EQ_ID = nextEqId;
		param.GRP_CD = nextGrpCd;
		param.HRNK_RBA_RSK_C_V = jQuery(thisObj).val();
		param.HRNK_RBA_RSK_C = jQuery(thisObj).attr("groupCode");
		alert(param.HRNK_RBA_RSK_C);
		goAjaxWidthReturn("com.gtone.rba.common.action.SelectJIPYOCodeAcion", param, afterFunction);
	}

	function onAfterRbaCdList(jsonObj, paramdata) {
		var cnt = jsonObj.RESULT.length;

		jQuery("select[name='" + paramdata.NEXT_SELECT_ID + "']").eq(paramdata.NEXT_EQ_ID).attr("groupCode", paramdata.GRP_CD);
		var html = "<option value='' >" + "::선택::" + "</option>";
		for (var i = 0; i < cnt; i++) {
			html += "<option value='" + jsonObj.RESULT[i].CD + "' >"+ jsonObj.RESULT[i].CD_NM + "</option>";
		}
		jQuery("select[name='" + paramdata.NEXT_SELECT_ID + "']").eq(paramdata.NEXT_EQ_ID).html(html);

	}

	function allcheck() {
		if (jQuery("#check").prop("checked")) {
			jQuery("input[type=checkbox]").prop("checked", true);
		} 
		else {
			jQuery("input[type=checkbox]").prop("checked", false);
		}
		

	}


	function onlyNumber1(obj){
		var val = obj.value;
		var len = val.length;
		var rt_val = "";

		for(var i = 0; i < len ; i++){
			var chr = val.charAt(i);
			var ch = chr.charCodeAt();
			
			if ((ch < 48 || ch > 57) && (ch != 46)){
				rt_val = rt_val;
			}else{
				rt_val = rt_val + chr;
			}
		}
		obj.value = rt_val;
		obj.focus();
		
	}
	function maxLengthCheck(object){
	    if (object.value.length > object.maxLength){
	        object.value = object.value.slice(0, object.maxLength);
	    }    
	}
</script>
<style type="text/css">
.table-box table tr th, .table-box2 table tr th, .table-box3 table tr th{
border-right: 1px solid #CCCCCC;
padding: 5px 5px;
width: 1%;
background-color: #F3F6FC; 
font-weight: 700;
vertical-align: top;
}
.table-box table tr td input[readonly], .table-box2 table tr td input[readonly],  .table-box3 table tr td input[readonly]{
	width: 100%;
	padding: 0 5px;
}
.table-box table tr td, .table-box2 table tr td, .table-box3 table tr td {
    padding : 5px 5px;
    width   : 2%; 
}
</style>
<div class="table-box">
	<%
	HashMap map1 = (HashMap) request.getAttribute("output");
	int sizValue = 0;
	List ReportDetails = (List) map1.get("ReportDetails");
	for (int i = 0;i < ReportDetails.size(); i++ ) {
			HashMap mapTemp=(HashMap) ReportDetails.get(i);

			if("1".equals( mapTemp.get("COL_HIDE_YN"))){
			sizValue +=1;
		}		
	}
	if( sizValue > 8){
	%>
	<table class="hover" id="HMInputTable" name="HMInputTable" style="width: 1600px;">
	<%}else{%>
	<table class="hover" id="HMInputTable" name="HMInputTable">
	<%}%>
		<tr>
			<th style="width: 1%">
				<input type="checkbox" class="cond-input-text" id="check" name="check" onclick="allcheck()" /> <!-- 체크박스  class 추가-->
			</th>
			<th style="width: 1%">상태</th>
			<c:forEach items="${output.ReportDetails }" var="details">
				<c:if test="${details.COL_HIDE_YN == '1'}">
					<th style="width: 7.1%">${details.SCR_TIT_NM }</td>
				</c:if>
			</c:forEach>
		</tr>
		<%
			HashMap map = (HashMap) request.getAttribute("output");
			List datalist = (List) map.get("ReportDataList");
			List itemlist = (List) map.get("ReportDetails");

			for (int i = 0; i < datalist.size(); i++) {
				HashMap dataMap = (HashMap) datalist.get(i);
		//		request.setAttribute("HM_DATA_NM", dataMap.get("HM_DATA_NM").toString());
				String HM_DATA_NM = dataMap.get("HM_DATA_NM").toString();
		%>
		<!--DB data-->
		<tr>
			<td style="border-right:1px solid #CCCCCC" align="center" style="width: 15px;">
			 	<input type="checkbox" id="dateSaveCk" name="dateSaveCk" value="Y" class="cond-input-text" style="width: 15px;" />	<!-- 체크박스  class 추가-->
			</td>
			<td style="border-right:1px solid #CCCCCC" align="center">
				<input type='text' style="width: 100%;" class="cond-input-text" size="10" name="HM_DATA_NM" id="HM_DATA_NM" value="<%=HM_DATA_NM%>" readOnly />
				<!-- ${condel.getInputCustomerNo('HM_DATA_NM','${HM_DATA_NM}','','','')} -->
				<input type="hidden" name="HM_DATA_S" id="HM_DATA_S" value='<%=dataMap.get("HM_DATA_S")%>' />
			</td>
			<%
				for (int j = 0; j < itemlist.size(); j++) {
					HashMap itemMap = (HashMap) itemlist.get(j);
					String columnNm = itemMap.get("MAP_COLUMN_NM").toString();
					String TVALUE; TVALUE = itemMap.get("TVALUE").toString();
					request.setAttribute("TVALUE_VALUE", itemMap.get("TVALUE").toString());
					request.setAttribute("GRP_MAP_COLUMN", itemMap.get("GRP_MAP_COLUMN_NM").toString());
					String grpcd; grpcd = itemMap.get("GRP_CD").toString();

					//if (itemMap.get("COL_HIDE_YN").equals("1")) {
					if ("1".equals(itemMap.get("COL_HIDE_YN")) == true) {
			%>
						<td style="border-right:1px solid #CCCCCC" align="center">
							<%
							//if (dataMap.get("HM_DATA_NM").equals("HM_DATA_NM")) {
							if ("HM_DATA_NM".equals(dataMap.get("HM_DATA_NM")) == true) {
							%> 
								<input type='text' style="width: 100%;" class="cond-input-text" id="HM_DATA_NM" name="HM_DATA_NM" value="<%=HM_DATA_NM%>" readOnly /> 
							<%
			 				}
			 				//if (itemMap.get("INPUT_TYPE").equals("TEXT")) {
			 					//if (itemMap.get("MAP_COLUMN_NM").equals("GJDT")) {
			 				if ("TEXT".equals(itemMap.get("INPUT_TYPE")) == true) {
			 					if ("GJDT".equals(itemMap.get("MAP_COLUMN_NM")) == true) {
			 				}
			 				%> 
			 						<input type='text' class="cond-input-text" style="width: 100%;" id="GJDT" name="<%=columnNm%>" value="<%=dataMap.get(columnNm)%>" readOnly />
							<%
								//}else if (itemMap.get("MAP_COLUMN_NM").equals("IMPT_CTNT1")) {
								}else if ("IMPT_CTNT1".equals(itemMap.get("MAP_COLUMN_NM")) == true) {
							%> 
									<input type='text' class="cond-input-text" style="width: 100%;" id="IMPT_CTNT1" name="<%=columnNm%>" value="<%=dataMap.get(columnNm)%>" readOnly />
								    <input type="hidden" id="IMPT_CTNT11" name="<%=columnNm%>1" value="<%=dataMap.get(columnNm)%>" readOnly />
			 	 	 	 	<%
			 	 	 	 		}else{
			 	 	 	  	%> 		
			 	 	 	  			<input type='text' class="cond-input-text" name="<%=columnNm%>" style="width: 100%;" value="<%=dataMap.get(columnNm)%>" />
			 	 	 	  	<%		
			 	 	 	  			//if(itemMap.get("MAP_COLUMN_NM").equals("IMPT_CTNT2")){
			 	 	 	  			if("IMPT_CTNT2".equals(itemMap.get("MAP_COLUMN_NM")) == true){
			 	 	 	  	%>
			 	 	 	  				<input type="hidden" name="<%=columnNm%>2" value="<%=dataMap.get(columnNm)%>" />
			 	 	 	  	<%
			 	 	 	  			}
			 	 	 	  	%>
			 	 	 	  	<%
			 	 	 	  		}
							} else if ("SELECT".equals(itemMap.get("INPUT_TYPE")) || "SELECT_V".equals(itemMap.get("INPUT_TYPE")) ) {
								int aa = Integer.parseInt(columnNm.substring(columnNm.length() - 1, columnNm.length())) + 1;
								String temp = columnNm.substring(0, columnNm.length() - 1) + aa;
								String scptStr; scptStr = "nextSelectChange(\"" + temp + ":eq(1)\",\"" + itemMap.get("GRP_MAP_CD").toString() + "\", this)";
			
							//			System.out.println("데이터 확인 ===============>"  +  columnNm + ", " + itemMap.get("GRP_CD").toString()+ ", "  + itemMap.get("GRP_MAP_CD").toString() 
							//									+ ", "  + dataMap.get(columnNm).toString());
								if("IMPT_CTNT1".equals(columnNm)){
							//			System.out.println("IMPT_CTNT1_IF문");
							%>													
									<input type="hidden" id="IMPT_CTNT11" name="<%=columnNm%>1" value="<%=dataMap.get(columnNm)%>" readOnly style="width: 100%" />
							<%				 
								}else if("IMPT_CTNT2".equals(columnNm)){
							//				System.out.println("IMPT_CTNT2_IF문");
							%>
									<input type="hidden" id="IMPT_CTNT22" name="<%=columnNm%>2" value="<%=dataMap.get(columnNm)%>" readOnly style="width: 100%" />
							<%				 														
								}
							%> <!-- //다음 select의 id, 다음 select의 GRP_CD, select 객체, 수행 후 시행할 function  -->
								<!-- <table width="150" border="0" > -->
									<RBATag:selectBoxJipyo name="<%=columnNm%>" cssClass="cond-select" groupCode='<%=itemMap.get("GRP_CD").toString()%>' mapGroupCode='<%=itemMap.get("GRP_MAP_CD").toString().trim()%>' rptGjdt='<%=itemMap.get("RPT_GJDT").toString()%>' initValue="<%=dataMap.get(columnNm).toString()%>" eventFunction='setReal("${TVALUE_VALUE}",this)'  selectStyle="width: 100%;"  />
								<!-- </table>  -->
							<%
			 				//} else if (itemMap.get("INPUT_TYPE").equals("TEXT_V")) {
			 				} else if ("TEXT_V".equals(itemMap.get("INPUT_TYPE")) == true) {
			 				%> 
			 					<!-- <textarea name="<%=columnNm%>" id="STR_CTNT1" class="cond-input-text" rows="1" cols="" style="width: 100%"; height: 18px;><%=dataMap.get(columnNm).toString().trim()%></textarea> -->
			 					<input type='text' id="<%=columnNm%>" name="<%=columnNm%>" class="cond-input-text" value="<%=dataMap.get(columnNm).toString().trim()%>" readOnly  style="width: 100%" />
			 				<%
							//} else if (itemMap.get("INPUT_TYPE").equals("TEXTAREA")) {
							} else if ("TEXTAREA".equals(itemMap.get("INPUT_TYPE")) == true) {
							%> 
								<textarea name="<%=columnNm%>" id="STR_CTNT1" class="cond-input-text" rows="1" cols="" style="width: 100%"; height: 18px;><%=dataMap.get(columnNm).toString().trim()%></textarea>
							<%
							//} else if (itemMap.get("INPUT_TYPE").equals("VIEW")) {
							} else if ("VIEW".equals(itemMap.get("INPUT_TYPE")) == true ) {
							%> 
								<%=dataMap.get(columnNm)%> 
							<%
			 				//} else if (itemMap.get("INPUT_TYPE").equals("NUMBER")) {
			 				} else if ("NUMBER".equals(itemMap.get("INPUT_TYPE")) == true) {
			 				%> <input type='text' id="NUMBER" name="<%=columnNm%>" class="cond-input-text" value="<%=dataMap.get(columnNm)%>" maxlength="18" oninput="maxLengthCheck(this)" style="width: 100%" />
							<%
							}
							%>
						</td>
						<%	
						}
						%> 
				<%
 				}
 				%>
		</tr>
		<!--DB data END-->
		<!-- 입력부분 -->
		<c:if test="${param.ROW_ADD_YN=='Y'}">
			<tr id="inputTr" name="inputTr">
				<td style="border-right:1px solid #CCCCCC" align="center">	<!-- 체크박스 -->
					<input type="checkbox" id="dateSaveCk1" name="dateSaveCk" value="Y"  style="width: 15px"  />
				</td>
				<td style="border-right:1px solid #CCCCCC" align="center">	<!-- 상태컬럼 -->
					<input type='text' name="${datalist.HM_DATA_NM}" readOnly  style="width: 100%"  />
				</td>
			<c:forEach items="${output.ReportDetails }" var="details">
				<c:if test="${details.COL_HIDE_YN == '1'}">
					<td style="border-right:1px solid #CCCCCC" align="center"><!-- 보고일자 -->
					<c:choose>
						<c:when test="${details.INPUT_TYPE == 'TEXT'}">
							<c:if test="${details.MAP_COLUMN_NM == 'GJDT'}">
								<input type='text' class="cond-input-text" style="width: 100%" id="GJDT1" name="${details.MAP_COLUMN_NM}" maxlength="8" onkeyup="onlyNumber1(this);" onkeypress="onlyNumber1(this);" />
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'IMPT_CTNT1'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'IMPT_CTNT2'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'CALC_DESC'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT1'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT2'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT3'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT4'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT5'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT6'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT7'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT8'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
							<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT9'}">
								<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" > 
							</c:if>
						</c:when>
						<c:when test="${details.INPUT_TYPE == 'SELECT'}">
							<!-- <table width="150" border="0" > -->
								<RBATag:selectBoxJipyo name="${details.MAP_COLUMN_NM}" cssClass="cond-select" groupCode="${details.GRP_CD}"	mapGroupCode="${details.GRP_MAP_CD}" firstComboWord="CHOICE" rptGjdt="${details.RPT_GJDT}"	eventFunction='setSelectVal("${details.GRP_MAP_COLUMN_NM}",this);' selectStyle="width:100%;" />
							<!-- </table> -->
						</c:when>
						<c:when test="${details.INPUT_TYPE == 'TEXTAREA'}">
							<textarea rows="1" name="${details.MAP_COLUMN_NM}" class="cond-input-text" style="width: 100%; height: 18px;"></textarea>
						</c:when>
						<c:when test="${details.INPUT_TYPE == 'VIEW'}">
						</c:when>
						<c:when test="${details.INPUT_TYPE == 'NUMBER'}">
							<input type="number" name="${details.MAP_COLUMN_NM}" class="cond-input-text" maxlength="18" oninput="maxLengthCheck(this)" style="width: 100%" >
						</c:when>
						<c:when test="${details.INPUT_TYPE == 'SELECT_V'}">
								<RBATag:selectBoxJipyo name="${details.MAP_COLUMN_NM}" cssClass="cond-select" groupCode='${details.GRP_CD}' mapGroupCode='${details.GRP_MAP_CD}' firstComboWord="CHOICE" rptGjdt='${details.RPT_GJDT}' eventFunction='setSelectVal("${details.GRP_MAP_COLUMN}",this);setReal("${details.TVALUE}",this);'  selectStyle="width: 100%;"  />
						</c:when>
						<c:when test="${details.INPUT_TYPE == 'TEXT_V'}">
							<input type="text" name="${details.MAP_COLUMN_NM}" id="${details.MAP_COLUMN_NM}"  class="cond-input-text" value="" style="width: 100%" >
						</c:when>
					</c:choose>
					</td>
				</c:if>
			</c:forEach>
			</tr>
			</tr>
		</c:if>
		
		<% if  (datalist.size() == 0 ) { %>
		<c:if test="${param.ROW_ADD_YN=='N'}">	
			<tr id="inputTr" name="inputTr">
				<tr>
					<td style="border-right:1px solid #CCCCCC" align="center">
						<input type="checkbox" class="cond-input-text" id="dateSaveCk1" name="dateSaveCk" value="Y" style="width: 15px;" />
					</td>
					<td style="border-right:1px solid #CCCCCC" align="center">
												<input type='text' class="cond-input-text" name="${datalist.HM_DATA_NM}" readOnly style="width: 100%" />
					</td>
					<c:forEach items="${output.ReportDetails }" var="details">
						<c:if test="${details.COL_HIDE_YN == '1'}">
							<td style="border-right:1px solid #CCCCCC" align="center">
								<c:choose>
									<c:when test="${details.INPUT_TYPE == 'TEXT'}">
										<c:if test="${details.MAP_COLUMN_NM == 'GJDT'}">
											<input type='text' class="cond-input-text" id="GJDT1" name="${details.MAP_COLUMN_NM}" maxlength="8" onkeyup="onlyNumber1(this);" onkeypress="onlyNumber1(this);" style="width: 100%" />
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'IMPT_CTNT1'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500"  style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'IMPT_CTNT2'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500"  style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'CALC_DESC'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500"  style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT1'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500"  style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT2'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT3'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT4'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT5'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT6'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT7'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT8'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" >
										</c:if>
										<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT9'}">
											<input type='text' class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="500" style="width: 100%" >
										</c:if>
									</c:when>
									<c:when test="${details.INPUT_TYPE == 'SELECT'}">
										 <!-- <table width="150" border="0" >  -->
											<RBATag:selectBoxJipyo name="${details.MAP_COLUMN_NM}" cssClass="cond-select" groupCode="${details.GRP_CD}"
												mapGroupCode="${details.GRP_MAP_CD}" firstComboWord="CHOICE" rptGjdt="${details.RPT_GJDT}"
												eventFunction='setSelectVal("${details.GRP_MAP_COLUMN_NM}",this)' selectStyle="width:100%;"/>
										 <!-- </table> -->
									</c:when>
									<c:when test="${details.INPUT_TYPE == 'TEXTAREA'}">
										<textarea rows="1" class="cond-input-text" name="${details.MAP_COLUMN_NM}" style="width: 100%; height: 18px;"></textarea>
									</c:when>
									<c:when test="${details.INPUT_TYPE == 'VIEW'}">
									</c:when>
									<c:when test="${details.INPUT_TYPE == 'NUMBER'}">
										<input type="number" class="cond-input-text" name="${details.MAP_COLUMN_NM}" maxlength="18" oninput="maxLengthCheck(this)" style="width: 100%">
									</c:when>
									<c:when test="${details.INPUT_TYPE == 'SELECT_V'}">
											<RBATag:selectBoxJipyo name="${details.MAP_COLUMN_NM}" cssClass="cond-select" groupCode='${details.GRP_CD}' mapGroupCode='${details.GRP_MAP_CD}' firstComboWord="CHOICE" rptGjdt='${details.RPT_GJDT}' eventFunction='setSelectVal("${details.GRP_MAP_COLUMN}",this);setReal("${details.TVALUE}",this)'  selectStyle="width: 100%;"  />
									</c:when>
									<c:when test="${details.INPUT_TYPE == 'TEXT_V'}">
										<input type="text" name="${details.MAP_COLUMN_NM}" id="${details.MAP_COLUMN_NM}"  class="cond-input-text" value="" style="width: 100%" >
									</c:when>
								</c:choose>
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</tr>
		</c:if>
		<%} %>
		<!-- 입력부분 END-->
	</table>
</div>
	<c:forEach items="${output.ReportDetails }" var="details">
		<c:if test="${details.COL_HIDE_YN == '0'}">
			<input type="hidden" name="${details.MAP_COLUMN_NM}"
				value="${details.COL_DEF_V}" />
		</c:if>
	</c:forEach>