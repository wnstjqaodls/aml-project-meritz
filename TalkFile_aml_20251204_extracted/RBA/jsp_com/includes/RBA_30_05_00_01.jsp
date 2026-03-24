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
<div style="overflow: scroll; width: 950px; height: 100%;">
	<table width="100%" border="0"  class="tbl_info" id="HMInputTable" name="HMInputTable">
		<!--td header  -->
		<tr>
			<td class="tbl_Top" style="width: 1%"><input type="checkbox" id="check" name="check" onclick="allcheck()" /></td>
			<td class="tbl_Top" style="width: 40">상태</td>
			<c:forEach items="${output.ReportDetails }" var="details">
				<c:if test="${details.COL_HIDE_YN == '1'}">
					<td class="tbl_Top" style="width: 30%">${details.SCR_TIT_NM }</td>
				</c:if>
			</c:forEach>
		</tr>
		<!--td header END-->
		<%
			HashMap map = (HashMap) request.getAttribute("output");
			List datalist = (List) map.get("ReportDataList");
			List itemlist = (List) map.get("ReportDetails");

			for (int i = 0; i < datalist.size(); i++) {
				HashMap dataMap = (HashMap) datalist.get(i);
		%>
		<!--DB data-->
		<tr>
			<td class='tbl_info_w' align="center">
			 	<input type="checkbox" id="dateSaveCk" name="dateSaveCk" value="Y" />
			</td>
			<td class='tbl_info_w' style='width: 3%;'>
				<input type='text'size="10" class="input_t_dis01" name="HM_DATA_NM" id="HM_DATA_NM" value="<%=dataMap.get("HM_DATA_NM")%>" readOnly />
				<input type="hidden"name="HM_DATA_S" id="HM_DATA_S" value="<%=dataMap.get("HM_DATA_S")%>"/>
			</td>
			<%
				for (int j = 0; j < itemlist.size(); j++) {
						HashMap itemMap = (HashMap) itemlist.get(j);
						String columnNm = itemMap.get("MAP_COLUMN_NM").toString();

						request.setAttribute("GRP_MAP_COLUMN", itemMap.get("GRP_MAP_COLUMN_NM").toString());
						String grpcd; grpcd = itemMap.get("GRP_CD").toString();

						//if (itemMap.get("COL_HIDE_YN").equals("1")) {
						if ("1".equals(itemMap.get("COL_HIDE_YN")) == true) {
			%>

								<td class='tbl_info_w' style='width: 7%;'>
									<%
										//if (dataMap.get("HM_DATA_NM").equals("HM_DATA_NM")) {
										if ("HM_DATA_NM".equals(dataMap.get("HM_DATA_NM"))) {
									%> <input type='text' class="input_t_dis01" id="HM_DATA_NM" name="HM_DATA_NM" value="<%=dataMap.get("HM_DATA_NM")%>" readOnly /> 
									
									<%
					 					}
					 				//if (itemMap.get("INPUT_TYPE").equals("TEXT")) {
					 					//if (itemMap.get("MAP_COLUMN_NM").equals("GJDT")) {
			 						if ("TEXT".equals(itemMap.get("INPUT_TYPE")) == true) {
			 							if ("GJDT".equals(itemMap.get("MAP_COLUMN_NM")) == true) {			 						
					 				%> <input type='text' class="input_t_dis" id="GJDT" name="<%=columnNm%>" value="<%=dataMap.get(columnNm)%>" readOnly />
									<%
										//}else if (itemMap.get("MAP_COLUMN_NM").equals("IMPT_CTNT1")) {
										}else if ("IMPT_CTNT1".equals(itemMap.get("MAP_COLUMN_NM")) == true) {
									%> <input type='text' class="input_t_dis01" id="IMPT_CTNT1" name="<%=columnNm%>" value="<%=dataMap.get(columnNm)%>" readOnly />
					 	 	 	 	<%
					 	 	 	 		}else{
					 	 	 	  	%> <input type='text'name="<%=columnNm%>" value="<%=dataMap.get(columnNm)%>" />
					 	 	 	  	<%
					 	 	 	  		}
									//} else if (itemMap.get("INPUT_TYPE").equals("SELECT")) {
									} else if ("SELECT".equals(itemMap.get("INPUT_TYPE")) == true) {
										        int aa =0;
										        try{
												     aa = Integer.parseInt(columnNm.substring(columnNm.length() - 1, columnNm.length())) + 1;
										        }catch(NumberFormatException e){
										        	Log.logAML(Log.ERROR, e);
										        }
										        	
												String temp = columnNm.substring(0, columnNm.length() - 1) + aa;
												String scptStr; 
												StringBuffer strScpt = new StringBuffer(256);
												    strScpt.append("nextSelectChange(\"");
												    strScpt.append(temp);
												    strScpt.append(":eq(1)\",\"");
												    strScpt.append(itemMap.get("GRP_MAP_CD").toString());
												    strScpt.append("\", this)");
												     
												scptStr = strScpt.toString();
												//scptStr = "nextSelectChange(\"" + temp + ":eq(1)\",\"" + itemMap.get("GRP_MAP_CD").toString() + "\", this)";
					
														//		System.out.println("데이터 확인 ===============>"  +  columnNm + ", " + itemMap.get("GRP_CD").toString()+ ", "  + itemMap.get("GRP_MAP_CD").toString() 
														//				+ ", "  + dataMap.get(columnNm).toString());
									%> <!-- //다음 select의 id, 다음 select의 GRP_CD, select 객체, 수행 후 시행할 function  -->
									<table width="150" border="0" >
										<RBATag:selectBoxJipyo name="<%=columnNm%>" cssClass="select_box" groupCode='<%=itemMap.get("GRP_CD").toString()%>'
											mapGroupCode='<%=itemMap.get("GRP_MAP_CD").toString().trim()%>' rptGjdt='<%=itemMap.get("RPT_GJDT").toString()%>'
											initValue="<%=dataMap.get(columnNm).toString()%>" eventFunction='setSelectVal("${GRP_MAP_COLUMN}",this)' />
									</table> 
									<%
					 				//} else if (itemMap.get("INPUT_TYPE").equals("TEXTAREA")) {
					 				} else if ("TEXTAREA".equals(itemMap.get("INPUT_TYPE")) == true) {
					 				%> <textarea name="<%=columnNm%>" id="STR_CTNT1" rows="" cols=""><%=dataMap.get(columnNm).toString().trim()%></textarea>
					
									<%
									//} else if (itemMap.get("INPUT_TYPE").equals("VIEW")) {
									} else if ("VIEW".equals(itemMap.get("INPUT_TYPE")) == true) {
									%> <%=dataMap.get(columnNm)%> 
									<%
					 				//} else if (itemMap.get("INPUT_TYPE").equals("NUMBER")) {
					 				} else if ("NUMBER".equals(itemMap.get("INPUT_TYPE")) == true) {
					 				%> <input type='text' id="NUMBER" name="<%=columnNm%>" value="<%=dataMap.get(columnNm)%>" maxlength="18" oninput="maxLengthCheck(this)"/>
									<%
									}

						}
						%> 
						<%
 				}
 				%>
		</tr>
		<!--DB data END-->
			<%
			}
			%>
		<!-- 입력부분 -->
		<c:if test="${param.ROW_ADD_YN=='Y'}">
		<tr id="inputTr" name="inputTr">
			<td class='tbl_info_w' align="center"><input type="checkbox"
				id="dateSaveCk1" name="dateSaveCk" value="Y" /></td>

			<td class="tbl_info_w"><input type='text' class="input_t_dis"
				name="${datalist.HM_DATA_NM}" readOnly /></td>
			
			<c:forEach items="${output.ReportDetails }" var="details">
					<c:if test="${details.COL_HIDE_YN == '1'}">
						<td class="tbl_info_w"><c:choose>
								<c:when test="${details.INPUT_TYPE == 'TEXT'}">
									<c:if test="${details.MAP_COLUMN_NM == 'GJDT'}">
										<input type='text' id="GJDT1" name="${details.MAP_COLUMN_NM}" maxlength="8" onkeyup="onlyNumber1(this);" onkeypress="onlyNumber1(this);" />
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'IMPT_CTNT1'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'IMPT_CTNT2'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'CALC_DESC'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="2000">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT1'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT2'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT3'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT4'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT5'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT6'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT7'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT8'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT9'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
								</c:when>
								<c:when test="${details.INPUT_TYPE == 'SELECT'}">
									<%-- 	<RBATag:selectBoxJipyo name="${details.MAP_COLUMN_NM}" cssClass="select_box" groupCode="${details.GRP_CD}"
								mapGroupCode="${details.GRP_MAP_CD}" firstComboWord="CHOICE" rptGjdt="${details.RPT_GJDT}"
								eventFunction='setSelectVal("${details.GRP_MAP_COLUMN_NM}",this)' /> --%>
									<table width="150" border="0" >
										<RBATag:selectBoxJipyo name="${details.MAP_COLUMN_NM}" cssClass="select_box" groupCode="${details.GRP_CD}"
											mapGroupCode="${details.GRP_MAP_CD}" firstComboWord="CHOICE" rptGjdt="${details.RPT_GJDT}"
											eventFunction='setSelectVal("${details.GRP_MAP_COLUMN_NM}",this)' />
									</table>
								</c:when>
								<c:when test="${details.INPUT_TYPE == 'TEXTAREA'}">
									<textarea rows="3" name="${details.MAP_COLUMN_NM}"></textarea>
								</c:when>
								<c:when test="${details.INPUT_TYPE == 'VIEW'}">
								</c:when>
								<c:when test="${details.INPUT_TYPE == 'NUMBER'}">
									<input type="number" name="${details.MAP_COLUMN_NM}" maxlength="18" oninput="maxLengthCheck(this)">
								</c:when>
								
							</c:choose>
						</td>
					</c:if>
			</c:forEach>
		</tr>
		</tr>
		</c:if>
		
	
		<% if  (datalist.size() == 0 ) { 
		%>
		<c:if test="${param.ROW_ADD_YN=='N'}">	
			<tr id="inputTr" name="inputTr">
			<tr>
			<td class='tbl_info_w' align="center"><input type="checkbox"
				id="dateSaveCk1" name="dateSaveCk" value="Y" /></td>

			<td class="tbl_info_w"><input type='text' class="input_t_dis"
				name="${datalist.HM_DATA_NM}" readOnly /></td>
			
			<c:forEach items="${output.ReportDetails }" var="details">
					<c:if test="${details.COL_HIDE_YN == '1'}">
						<td class="tbl_info_w"><c:choose>
								<c:when test="${details.INPUT_TYPE == 'TEXT'}">
									<c:if test="${details.MAP_COLUMN_NM == 'GJDT'}">
										<input type='text' id="GJDT1" name="${details.MAP_COLUMN_NM}" maxlength="8" onkeyup="onlyNumber1(this);" onkeypress="onlyNumber1(this);" />
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'IMPT_CTNT1'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'IMPT_CTNT2'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'CALC_DESC'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="2000">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT1'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT2'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT3'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT4'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT5'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT6'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT7'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT8'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
									<c:if test="${details.MAP_COLUMN_NM == 'STR_CTNT9'}">
										<input type='text' name="${details.MAP_COLUMN_NM}" maxlength="500">
									</c:if>
								</c:when>
								<c:when test="${details.INPUT_TYPE == 'SELECT'}">
									<%-- 	<RBATag:selectBoxJipyo name="${details.MAP_COLUMN_NM}" cssClass="select_box" groupCode="${details.GRP_CD}"
								mapGroupCode="${details.GRP_MAP_CD}" firstComboWord="CHOICE" rptGjdt="${details.RPT_GJDT}"
								eventFunction='setSelectVal("${details.GRP_MAP_COLUMN_NM}",this)' /> --%>
									<table width="150" border="0" >
										<RBATag:selectBoxJipyo name="${details.MAP_COLUMN_NM}" cssClass="select_box" groupCode="${details.GRP_CD}"
											mapGroupCode="${details.GRP_MAP_CD}" firstComboWord="CHOICE" rptGjdt="${details.RPT_GJDT}"
											eventFunction='setSelectVal("${details.GRP_MAP_COLUMN_NM}",this)' />
									</table>
								</c:when>
								<c:when test="${details.INPUT_TYPE == 'TEXTAREA'}">
									<textarea rows="3" name="${details.MAP_COLUMN_NM}"></textarea>
								</c:when>
								<c:when test="${details.INPUT_TYPE == 'VIEW'}">
								</c:when>
								<c:when test="${details.INPUT_TYPE == 'NUMBER'}">
									<input type="number" name="${details.MAP_COLUMN_NM}" maxlength="18" oninput="maxLengthCheck(this)">
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

