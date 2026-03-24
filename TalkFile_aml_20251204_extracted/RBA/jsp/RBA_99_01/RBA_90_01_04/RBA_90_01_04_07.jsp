<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_04_07.jsp
- Author     : 권얼
- Comment    : FIU보고관리/등록
- Version    : 1.0
- history    : 1.0 20181120
--%>
 <jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ page import="com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_04.RBA_90_01_04_07"  %>
<%
	String RPT_GJDT           = Util.nvl(request.getParameter("RPT_GJDT")			, "");
	String JIPYO_IDX		  = Util.nvl(request.getParameter("JIPYO_IDX") 			, "");
	
	DataObj input  = new DataObj();
    input.put("RPT_GJDT", RPT_GJDT);
    input.put("JIPYO_IDX", JIPYO_IDX);
    
    DataObj output = RBA_90_01_04_07.getInstance().getSearchRslt(input);
    
    String RPT_GJDT1 = Util.nvl(output.getText("RPT_GJDT1") , "");
    String RPT_GJDT2 = Util.nvl(output.getText("RPT_GJDT2") , "");
    String RPT_GJDT3 = Util.nvl(output.getText("RPT_GJDT3") , "");
    
    String SCORE1 = Util.nvl(output.getText("SCORE1") , "");
    String SCORE2 = Util.nvl(output.getText("SCORE2") , "");
    String SCORE3 = Util.nvl(output.getText("SCORE3") , "");
    
    System.out.println("RPT_GJDT1 :: "+RPT_GJDT1);
    
    StringBuffer strGjdt = new StringBuffer(64);
	 
    if(!"".equals(RPT_GJDT1)){
    	strGjdt.setLength(0);
    	strGjdt.append(RPT_GJDT1.substring(0 , 4));
    	strGjdt.append('-');
    	strGjdt.append(RPT_GJDT1.substring(4 , 6));
    	strGjdt.append('-');
    	strGjdt.append(RPT_GJDT1.substring(6 , 8));
    	System.out.println("========RPT_GJDT1==============="+strGjdt.toString());
    	RPT_GJDT1 = strGjdt.toString();
    	//RPT_GJDT1 = RPT_GJDT1.substring(0,4) +"-"+RPT_GJDT1.substring(4,6)+"-"+RPT_GJDT1.substring(6,8);
    }
    
	if(!"".equals(RPT_GJDT2)){
		strGjdt.setLength(0);
    	strGjdt.append(RPT_GJDT2.substring(0 , 4));
    	strGjdt.append('-');
    	strGjdt.append(RPT_GJDT2.substring(4 , 6));
    	strGjdt.append('-');
    	strGjdt.append(RPT_GJDT2.substring(6 , 8));
    	System.out.println("========RPT_GJDT2==============="+strGjdt.toString());
    	RPT_GJDT2 = strGjdt.toString();
		//RPT_GJDT2 = RPT_GJDT2.substring(0,4) +"-"+RPT_GJDT2.substring(4,6)+"-"+RPT_GJDT2.substring(6,8);
	 }
	
	if(!"".equals(RPT_GJDT3)){
		strGjdt.setLength(0);
    	strGjdt.append(RPT_GJDT3.substring(0 , 4));
    	strGjdt.append('-');
    	strGjdt.append(RPT_GJDT3.substring(4 , 6));
    	strGjdt.append('-');
    	strGjdt.append(RPT_GJDT3.substring(6 , 8));
    	System.out.println("========RPT_GJDT3==============="+strGjdt.toString());
    	RPT_GJDT3 = strGjdt.toString();
		//RPT_GJDT3 = RPT_GJDT3.substring(0,4) +"-"+RPT_GJDT3.substring(4,6)+"-"+RPT_GJDT3.substring(6,8);
	}
	
	request.setAttribute("RPT_GJDT", RPT_GJDT);
    request.setAttribute("RPT_GJDT1", RPT_GJDT1);
    request.setAttribute("RPT_GJDT2", RPT_GJDT2);
    request.setAttribute("RPT_GJDT3", RPT_GJDT3);
    
    request.setAttribute("score1", SCORE1);
    request.setAttribute("score2", SCORE2);
    request.setAttribute("score3", SCORE3);
    
	request.setAttribute("JIPYO_IDX",JIPYO_IDX);
	
%>

<script language="JavaScript">

	var pageID = "RBA_90_01_04_07";
 	var classID = "RBA_90_01_04_07";
 	
	$(document).ready(function(){
		initChart2();
	});
	 
	function initChart2(){
	    	
	        $("#chart2").dxChart({
	            "dataSource" : [{
	                "month" 		  : "${msgel.getMsg('RBA_90_01_05_01_106','전전회차')}"
	                    ,"RPT_GJDT"   : ${score3}
	                 },{
	                     "month" 	  : "${msgel.getMsg('RBA_90_01_05_01_104','직전회차')}"
	                    ,"RPT_GJDT"   : ${score2}
	                 },{
	                     "month" 	  : "${msgel.getMsg('RBA_90_01_05_01_100','최근회차')}"
	                    ,"RPT_GJDT"   : ${score1}
	                 }]
	            
	           ,"commonSeriesSettings" : {
	                "argumentField" : "month"
	               ,"type"          : "line"
	               ,"hoverMode"     : "allArgumentPoints"
	               ,"selectionMode" : "allArgumentPoints"
	               ,"label" : {
	                    "visible"   : true
	                   ,"format"    : {
	                        "type"      : "fixedPoint"
	                       ,"precision" : 0
	                    }
	                }
	            },
	            series: [{"valueField": "RPT_GJDT", "name": "${msgel.getMsg('RBA_90_01_03_01_004','입력값')}"}]
	           ,"legend": {
	                "verticalAlignment"     : "bottom"
	               ,"horizontalAlignment"   : "center"
	            }
	           ,"export" : {
	                "enabled": false
	            }
	           ,"onPointClick": function (e) {
	                e.target.select();
	            }
	        });
	    }
</script>
<form name="form1"  method="post">
	<div class="panel panel-primary">
		<div class="panel-footer" >
			<div class="table-box">
				<table class="basic-table" style="width:100%">
					<colgroup>
					    <col width="130px">
					    <col width="">
					</colgroup>
					<tbody>
						<tr>
							<th class="title" id="RPT_GJDT1">${RPT_GJDT1}</th>
							<td >
					  		   <input type="text" class="input_text" id="score1" name="score1" value="${score1}" disabled />
							</td>
						</tr>											
						<tr>
					   		<th class="title" id="RPT_GJDT2">${RPT_GJDT2}</th>
							<td >
					  		    <input type="text" class="input_text" id="score2" name="score2" value="${score2}"  disabled/>
							</td>
				   		</tr>
				   		<tr>
						  <th class="title" id="RPT_GJDT3">${RPT_GJDT3}</th>
							<td>
					  		    <input type="text" class="input_text" id="score3" name="score3" value="${score3}"  disabled/>
							</td>														
						</tr>
					</tbody>
					</table>
					<br/>
					<div class="dash-board-cont-box" style="height:120px;">
						<div style="display:inline-block;width:100%;height:calc(100% - 3px);overflow:hidden;margin:0;padding:0;">
	                           <div id="chart2" style="width:95%;height:100%;text-align:center;"></div>
	                       </div>
					</div>
			</div>	
			<div class="tab-content-top">
			<div class="button-area" style="margin-right:5px;  margin-top:10px;">
				${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}	
			</div>
		</div>	
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 	