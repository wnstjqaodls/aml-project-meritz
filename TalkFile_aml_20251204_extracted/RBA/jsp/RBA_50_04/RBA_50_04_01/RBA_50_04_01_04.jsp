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
			<th style="width:5%;">${msgel.getMsg("RBA_50_04_01_02_014","No")}</th>
			<th style="width:80%;">${msgel.getMsg("RBA_50_04_01_02_011","세부평가항목")}</th>
			<th style="width:0%;">${msgel.getMsg("RBA_50_04_01_02_012","자동산출여부")}</th>
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
							<input type="text" class="input_text" id="CNTL_ITEM_DE_C" name="CNTL_ITEM_DE_C"  value="<c:out value='${evalDetails.CNTL_ITEM_DE_C }'/>" style="width: 100%;" readonly/>
						</td>
						<td style="border-right:1px solid #CCCCCC" align="center" >
							<input type="text" class="input_text" id="CNTL_ITEM_DE_CTNT" name="CNTL_ITEM_DE_CTNT" value="<c:out value='${evalDetails.CNTL_ITEM_DE_CTNT }'/>" style="width: 100%;"/>
						</td>
						<td style="border-right:1px solid #CCCCCC; visibility:hidden;" align="center">
							<select id="AUTO_EXT_YN" name="AUTO_EXT_YN" style="width: 100%" class="dropdown" >
								<option value='1' >Y</option>
					            <option value='0' >N</option>
							</select>
						</td>
					</tr>
				</c:forEach>
	  		</c:when>
	  		<c:otherwise>
	  		<tr>
  				<td style="border-right:1px solid #CCCCCC" align="center"><input type="checkbox" id="EVAL_DATE_SEL${evalDetails}" name="EVAL_DATE_SEL" /><label for="EVAL_DATE_SEL${evalDetails}"></label></td>
				<td style="border-right:1px solid #CCCCCC" align="center">
					<input type="text" class="input_text" id="CNTL_ITEM_DE_C" name="CNTL_ITEM_DE_C" style="width: 100%;" readonly />
				</td>
				<td style="border-right:1px solid #CCCCCC" align="center"><input type="text" class="input_text" id="CNTL_ITEM_DE_CTNT" name="CNTL_ITEM_DE_CTNT"  style="width: 100%;"/></td>
				<td style="border-right:1px solid #CCCCCC ; visibility:hidden;" align="center">
					<select id="AUTO_EXT_YN" name="AUTO_EXT_YN" style="width: 100%" class="dropdown">
						<option value='0' >N</option>
						<option value='1' >Y</option>
					</select>
				</td>

			</tr>
			</c:otherwise>
	  	</c:choose>
	  	</tbody>
	</table>
</div>