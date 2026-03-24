<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>

<%--
- File Name  : 
- Author     : 
- Comment    : 
- Version    : 
- history    : 
--%>

<%
	HashMap map = (HashMap) request.getAttribute("output");
	List EvalDetails; EvalDetails = (List) map.get("EvalDetails");	//평가기준데이터
	List EvalCmprCalC; EvalCmprCalC = (List) map.get("EvalCmprCalC");	//산식코드(A009)
	List EvalCmprV; EvalCmprV = (List) map.get("EvalCmprV");		//비교값
%>
<script>

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
</script>
<style type="text/css">
.table-box table tr th, .table-box2 table tr th, .table-box3 table tr th{
border-right: 1px solid #CCCCCC;
padding: 5px 5px;
width: auto; 
background-color: #F3F6FC;
font-weight: 700;
vertical-align: top;
}
.table-box table tr td input[readonly], .table-box2 table tr td input[readonly],  .table-box3 table tr td input[readonly]{
	width: 100%;
	padding: 0 5px;
}
.grid-table.one-row .table-head th:first-of-type {
    width: 10px;
}
.grid-table.one-row .table-head th {
	width: 200px;
}
</style>
<div class="table-box"  >
	<table class="grid-table one-row" id="EvalInputTable" name="EvalInputTable" style="border-top:1px solid #444;">
		<thead class="table-head">
		<tr>
            <th style="width:5%;">
            <input type="checkbox" id="EVAL_DATE_HEARDER" name="EVAL_DATE_HEARDER" /><label for="EVAL_DATE_HEARDER"></label>
            </th>
			<th style="width:20%;">${msgel.getMsg("RBA_90_01_05_01_101","점수")}</th>
			<th style="width:20%;">${msgel.getMsg("RBA_90_01_02_05_200","산식코드")}</th>
			<th style="width:55%;">${msgel.getMsg("RBA_90_01_02_05_201","비교값")}</th>
	  	</tr>
	  	</thead>
	  	<tbody id="_tbody">
	  	<c:choose>
	  		<c:when test="${ fn:length( output.EvalDetails  ) > 0 }">
		  		<c:forEach items="${output.EvalDetails }"   var="evalDetails" >
				  	<tr>
				  		<td style="border-right:1px solid #CCCCCC" align="center">
							<input type="checkbox" class="cond-input-text" id="EVAL_DATE_SEL${evalDetails}" name="EVAL_DATE_SEL"/><label for="EVAL_DATE_SEL${evalDetails}"></label>
						</td>
						<td style="border-right:1px solid #CCCCCC" align="center" >
							<input type="text" class="input_text" id="CAL_PNT" name="CAL_PNT"  onkeyup="onlyNumber1(this);" onkeypress="onlyNumber1(this);" value="<c:out value='${evalDetails.CAL_PNT }'/>" style="width: 100%;"/>
						</td>
						<td style="border-right:1px solid #CCCCCC" align="center">
							<select id="JIPYO_CMPR_CAL_C" name="JIPYO_CMPR_CAL_C" style="width: 100%" class="dropdown" >
								<c:forEach items="${output.EvalCmprCalC }" var="cmprCalcDetails">
								 	<option value="${cmprCalcDetails.DTL_CD}" <c:if test = "${ evalDetails.JIPYO_CMPR_CAL_C eq cmprCalcDetails.DTL_CD }" >selected="selected"</c:if>><c:out value="${cmprCalcDetails.DTL_NM}"/></option>
								</c:forEach>
							</select>
						</td>
						<td style="border-right:1px solid #CCCCCC" align="center">
							<c:choose>
								<c:when test="${'C' eq evalDetails.IN_V_TP_C }">
									<select id="CMPR_V" name="CMPR_V" style="width: 100%" class="dropdown" >
										<c:forEach items="${output.EvalCmprV }" var="evalCmprVDetails">
										 	<option value="${evalCmprVDetails.DTL_CD}" <c:if test = "${ evalDetails.CMPR_V eq evalCmprVDetails.DTL_CD }" >selected="selected"</c:if>><c:out value="${evalCmprVDetails.DTL_NM}"/></option>
										</c:forEach>
									</select>
								</c:when>
								<c:when test="${'N' eq evalDetails.IN_V_TP_C }">
									<input type="text" class="input_text" id="CMPR_V" name="CMPR_V" style="width: 100%" onkeyup="onlyNumber1(this);" onkeypress="onlyNumber1(this);" value="<c:out value='${evalDetails.CMPR_V }' />" />
								</c:when>
								<c:when test="${'T' eq evalDetails.IN_V_TP_C }">
									<input type="text" class="input_text" id="CMPR_V" name="CMPR_V" style="width: 100%" value="<c:out value='${evalDetails.CMPR_V }'/>" />
								</c:when>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
	  		</c:when>
	  		<c:otherwise>
	  		<tr>
  				<td style="border-right:1px solid #CCCCCC" align="center"><input type="checkbox" id="EVAL_DATE_SEL${evalDetails}" name="EVAL_DATE_SEL" /><label for="EVAL_DATE_SEL${evalDetails}"></label></td>
				<td style="border-right:1px solid #CCCCCC" align="center">
					<input type="text" class="input_text" id="CAL_PNT" name="CAL_PNT" style="width: 100%;" onkeyup="onlyNumber1(this);" onkeypress="onlyNumber1(this);" />
				</td>
				<td style="border-right:1px solid #CCCCCC" align="center">
					<select id="JIPYO_CMPR_CAL_C" name="JIPYO_CMPR_CAL_C" style="width: 100%" class="dropdown">
						<c:forEach items="${output.EvalCmprCalC }" var="cmprCalcDetails">
						 	<option value="${cmprCalcDetails.DTL_CD}" <c:if test = "${ evalDetails.JIPYO_CMPR_CAL_C eq cmprCalcDetails.DTL_CD }" >selected="selected"</c:if>><c:out value="${cmprCalcDetails.DTL_NM}"/></option>
						</c:forEach>
					</select>
				</td>
				<td style="border-right:1px solid #CCCCCC" align="center"><input type="text" class="input_text" id="CMPR_V" name="CMPR_V"  style="width: 100%;"/></td>
			</tr>
			</c:otherwise>
	  	</c:choose>
	  	</tbody>
	</table>  
</div>    