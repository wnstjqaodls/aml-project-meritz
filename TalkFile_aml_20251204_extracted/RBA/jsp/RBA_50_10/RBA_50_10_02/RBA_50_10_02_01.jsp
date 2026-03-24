<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%--
- File Name  : RBA_50_10_02_01.jsp
- Author     : BSL
- Comment    : 고유위험 지표 데이터 관리
- Version    : 5.0
- history    : 5.0 2018-07-25
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>

<%
	String dvTabID = Util.nvl(jspeed.base.xml.XMLHelper.normalize(request.getParameter("dvTabID")), "");
	request.setAttribute("dvTabID", dvTabID);
%>

<!-- Function Script -->
<script language="JavaScript"src="${Path}/Package/ext/js/state_validate.js"></script>
<script language="JavaScript">
	
	var GridObj1 = null;
	var GridObj2 = null;
	var GridObj3 = null;
	var GridObj4 = null;
	var GridObj5 = null;
	
	var tabID = null;
	var tabPanelID = null;
	
	var classID = "RBA_50_10_02_01"; 
	var pageID = "RBA_50_10_02_01";
	var overlay = new Overlay();

	$(document).ready(function() {
		setupTabPanel(0);
	});
	
	function doSearch01() {	
		if(tabID == 0){	
			doSearch1();
		}else if (tabID == 1) {
			doSearch2();
		}else if (tabID == 2) {
			doSearch3();
		}else if (tabID == 3) {
			doSearch4();
		}else if (tabID == 4) {
			doSearch5();
		}
	}
	
	/** 탭 동작 */
	function dvTab(pageNum) {
		tabID = pageNum;

		if (pageNum == 0) {
		//회사특성
			GridObj1 = initGrid3({
	            gridId          : 'GTDataGrid1'
	           ,headerId        : 'RBA_50_10_02_01_Grid1'
	           ,gridAreaId      : 'GTDataGrid1_Area'
	           ,height          : 'calc(1vh - 1px)'
	           ,useAuthYN       : '${outputAuth.USE_YN}'
	           ,completedEvent  : function(){
	        	   doSearch1();
	            }
	        });
		} else if (pageNum == 1) {
		//고객특성
			GridObj2 = initGrid3({
	            gridId          : 'GTDataGrid2'
	           ,headerId        : 'RBA_50_10_02_01_Grid1'
	           ,gridAreaId      : 'GTDataGrid2_Area'
	           ,height          : 'calc(1vh - 1px)'
	           ,useAuthYN       : '${outputAuth.USE_YN}'
	           ,completedEvent  : function(){
	        	   doSearch2();
	            }
	        });
		} else if (pageNum == 2) {
		//국가특성
			GridObj3 = initGrid3({
	            gridId          : 'GTDataGrid3'
	           ,headerId        : 'RBA_50_10_02_01_Grid1'
	           ,gridAreaId      : 'GTDataGrid3_Area'
	           ,height          : 'calc(1vh - 1px)'
	           ,useAuthYN       : '${outputAuth.USE_YN}'
	           ,completedEvent  : function(){
	        	   doSearch3();
	            }
	        });
		} else if (pageNum == 3) {
		//상품및서비스특성
			GridObj4 = initGrid3({
	            gridId          : 'GTDataGrid4'
	           ,headerId        : 'RBA_50_10_02_01_Grid1'
	           ,gridAreaId      : 'GTDataGrid4_Area'
	           ,height          : 'calc(1vh - 1px)'
	           ,useAuthYN       : '${outputAuth.USE_YN}'
	           ,completedEvent  : function(){
	        	   doSearch4();
	            }
	        });
		} else if (pageNum == 4) {
		//채널특성
			GridObj5 = initGrid3({
	            gridId          : 'GTDataGrid5'
	           ,headerId        : 'RBA_50_10_02_01_Grid1'
	           ,gridAreaId      : 'GTDataGrid5_Area'
	           ,height          : 'calc(1vh - 1px)'
	           ,useAuthYN       : '${outputAuth.USE_YN}'
	           ,completedEvent  : function(){
	        	   doSearch5();
	            }
	        });
		}
	}

	/** 탭 셋업 */
	function setupTabPanel(defTabIdx) {
		tabPanelID = setupDxTab({
			"tabContID" : "tabCont1",
			"height" : "70vh",
			"onTabClick" : function(e) {
				dvTab(e.itemData.tabIdx);
			},
			"onInit" : function(e) {
				dvTab(0);
			},
			"defTabIdx" : defTabIdx
		});
	}
	
	//////////////////////////////////////////  회사특성 조회 - START
	function doSearch1() {
		
		overlay.show(true, true);
		
		var obj = new Object();
		obj.pageID = pageID;
		obj.classID = classID;
		obj.methodID = "doSearch1";
		obj.RPT_GJDT = jQuery("#RPT_GJDT option:selected").val();
		GridObj1.refresh({
			actionParam : obj,
			completedEvent : doSearch1_end
		});
	}
	function doSearch1_end() {
		var gridCnt = GridObj1.rowCount();
		if (gridCnt > 0) {
			//회사특성 세팅
			var selObj = GridObj1.getRow(0);
			document.getElementById('A1_1').innerHTML = selObj.A1;
			document.getElementById('A1_2').innerHTML = selObj.A2;
			document.getElementById('A1_3').innerHTML = selObj.A3;
			//회사특성 세팅끝
		}else{
			document.getElementById('A1_1').innerHTML = "";
			document.getElementById('A1_2').innerHTML = "";
			document.getElementById('A1_3').innerHTML = "";
		}
		
		overlay.hide();
	}
	/////////////////////////////////////////회사특성 조회 - END

	//////////////////////////////////////////  고객특성 조회 - START
	function doSearch2() {
		
		overlay.show(true, true);
		
		var obj = new Object();
		obj.pageID = pageID;
		obj.classID = classID;
		obj.methodID = "doSearch2";
		obj.RPT_GJDT = jQuery("#RPT_GJDT option:selected").val();
		GridObj2.refresh({
			actionParam : obj,
			completedEvent : doSearch2_end
		});
	}
	
	function doSearch2_end() {
		var gridCnt = GridObj2.rowCount();
		var tag = null;
		tab ="<table>";
		tag+="<tr>";
		tag+=	"<td>";
		tag+=		"<div class=\"table-subBox\">";
		tag+= 			"<table>";
		tag+=				"<tr>"
		tag+=	            	"<th>국가코드</th>"; 
		tag+=	            	"<th>개인 고객수(명)</th>"; 
		tag+=	            	"<th>개인 사업자고객수(명)</th>"; 
		tag+=	            	"<th>법인 고객수(개)</th>"; 
		tag+=	            	"<th>개인 고객<br>거래금액(백만원)</th>";  
		tag+=	            	"<th>개인사업자 고객<br>거래금액(백만원)</th>"; 
		tag+=	            	"<th>법인 고객<br>거래금액(백만원)</th>";  
		tag+=				"</tr>"; 
		if (gridCnt > 0) {
			for(i=0 ; i < gridCnt ; i++){
				var selObj = GridObj2.getRow(i);
				if(selObj.HM_CD=='02I6020101'){
					document.getElementById('B1_1').innerHTML = selObj.A1;
					document.getElementById('B1_2').innerHTML = selObj.A2;
					document.getElementById('B1_3').innerHTML = selObj.A3;	
				}else if(selObj.HM_CD=='02I6020102'){
					document.getElementById('B2_1').innerHTML = selObj.A1;
					document.getElementById('B2_2').innerHTML = selObj.A2;
					document.getElementById('B2_3').innerHTML = selObj.A3;	
				}else if(selObj.HM_CD=='02I6020103'){
					document.getElementById('B3_1').innerHTML = selObj.A1;
					document.getElementById('B3_2').innerHTML = selObj.A2;
				}else if(selObj.HM_CD=='02I6020104'){	
					tag+="<tr align='center'>"; 
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A1+"</b></td>"						
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A2+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A3+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A4+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A5+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A6+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A7+"</b></td>"
					tag+="</tr>"; 
				}else if(selObj.HM_CD=='02I6020105'){
					document.getElementById('B5_1').innerHTML = selObj.A1;
					document.getElementById('B5_2').innerHTML = selObj.A2;
					form1.B5_3.value = selObj.A3;
				}else if(selObj.HM_CD=='02I6020106'){
					document.getElementById('B6_1').innerHTML = selObj.A1;
					document.getElementById('B6_2').innerHTML = selObj.A2;
				}else if(selObj.HM_CD=='02I6020107'){
					document.getElementById('B7_1').innerHTML = selObj.A1;
					document.getElementById('B7_2').innerHTML = selObj.A2;
					form1.B7_3.value = selObj.A3;
				}
			}
		}else{
					document.getElementById('B1_1').innerHTML = "";
					document.getElementById('B1_2').innerHTML = "";
					document.getElementById('B1_3').innerHTML = "";	
					document.getElementById('B2_1').innerHTML = "";
					document.getElementById('B2_2').innerHTML = "";
					document.getElementById('B2_3').innerHTML = "";	
				    document.getElementById('B3_1').innerHTML = "";
					document.getElementById('B3_2').innerHTML = "";
					document.getElementById('B5_1').innerHTML = "";	
					document.getElementById('B5_2').innerHTML = "";	
					document.getElementById('B5_3').value = "";	
					document.getElementById('B6_1').innerHTML = "";	
					document.getElementById('B6_2').innerHTML = "";	
					document.getElementById('B7_1').innerHTML = "";	
					document.getElementById('B7_2').innerHTML = "";	
					document.getElementById('B7_3').value = "";	

					
		}
		tag+=			"</table>";
		tag+=		"</div>";
		tag+=	"</td>";
		tag+="</tr>";
		tag+="</table>";
		$("#B4_BOX").html(tag);
		
		overlay.hide();
	}
	/////////////////////////////////////////고객특성 조회 - END
	
	//////////////////////////////////////////  국가특성 조회 - START
	function doSearch3() {
		
		overlay.show(true, true);
		
		var obj = new Object();
		obj.pageID = pageID;
		obj.classID = classID;
		obj.methodID = "doSearch3";
		obj.RPT_GJDT = jQuery("#RPT_GJDT option:selected").val();
		GridObj3.refresh({
			actionParam : obj,
			completedEvent : doSearch3_end
		});
	}
	
	function doSearch3_end() {
		var gridCnt = GridObj3.rowCount();
		var tag = null;
		tab ="<table>";
		tag+="<tr>";
		tag+=	"<td>";
		tag+=		"<div class=\"table-subBox\">";
		tag+= 			"<table>";
		tag+=				"<tr>"
		tag+=	            	"<th>국가코드</th>"; 
		tag+=	            	"<th>개인 고객수(명)</th>"; 
		tag+=	            	"<th>개인 사업자고객수(명)</th>"; 
		tag+=	            	"<th>법인 고객수(개)</th>"; 
		tag+=	            	"<th>개인 고객<br>거래금액(백만원)</th>";  
		tag+=	            	"<th>개인사업자 고객<br>거래금액(백만원)</th>"; 
		tag+=	            	"<th>법인 고객<br>거래금액(백만원)</th>";  
		tag+=				"</tr>"; 
		if (gridCnt > 0) {
			for(i=0 ; i < gridCnt ; i++){
				var selObj = GridObj3.getRow(i);
				if(selObj.HM_CD=='02I6030101'){	
					tag+="<tr align='center'>"; 
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A1+"</b></td>"						
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A2+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A3+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A4+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A5+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A6+"</b></td>"
					tag+=	"<td bgcolor='#FFFF99'><b><span style=\"display:block;text-align:center;width:50px;\" class=\"font_s\">"+selObj.A7+"</b></td>"
					tag+="</tr>"; 
				}
			}
		}
		tag+=			"</table>";
		tag+=		"</div>";
		tag+=	"</td>";
		tag+="</tr>";
		tag+="</table>";
		$("#C1_BOX").html(tag);
		overlay.hide();
	}
	/////////////////////////////////////////국가특성 조회 - END
	
	//////////////////////////////////////////  상품및서비스특성 조회 - START
	function doSearch4() {
		
		overlay.show(true, true);
		
		var obj = new Object();
		obj.pageID = pageID;
		obj.classID = classID;
		obj.methodID = "doSearch4";
		obj.RPT_GJDT = jQuery("#RPT_GJDT option:selected").val();
		GridObj4.refresh({
			actionParam : obj,
			completedEvent : doSearch4_end
		});
	}
	
	function doSearch4_end() {
		var gridCnt = GridObj4.rowCount();
		if (gridCnt > 0) {
			for(i=0 ; i < gridCnt ; i++){
				var selObj = GridObj4.getRow(i);
				if(selObj.HM_CD=='02I6040101'){
					document.getElementById('D1_1').innerHTML = selObj.A1;
					document.getElementById('D1_2').innerHTML = selObj.A2;				
				}else if(selObj.HM_CD=='02I6040102'){
					document.getElementById('D2_1').innerHTML = selObj.A1;
					document.getElementById('D2_2').innerHTML = selObj.A2;
				}else if(selObj.HM_CD=='02I6040201'){
					document.getElementById('D3_1').innerHTML = selObj.A1;
					document.getElementById('D3_2').innerHTML = selObj.A2;
					document.getElementById('D3_3').innerHTML = selObj.A3;
					document.getElementById('D3_4').innerHTML = selObj.A4;	
					document.getElementById('D3_5').innerHTML = selObj.A5;	
					document.getElementById('D3_6').innerHTML = selObj.A6;	
					document.getElementById('D3_7').innerHTML = selObj.A7;	
					document.getElementById('D3_8').innerHTML = selObj.A8;	
				}else if(selObj.HM_CD=='02I6040301'){
					document.getElementById('D4_1').innerHTML = selObj.A1;
					document.getElementById('D4_2').innerHTML = selObj.A2;
					document.getElementById('D4_3').innerHTML = selObj.A3;
					document.getElementById('D4_4').innerHTML = selObj.A4;	
					document.getElementById('D4_5').innerHTML = selObj.A5;	
					document.getElementById('D4_6').innerHTML = selObj.A6;	
					document.getElementById('D4_7').innerHTML = selObj.A7;	
					document.getElementById('D4_8').innerHTML = selObj.A8;
					document.getElementById('D4_9').innerHTML = selObj.A9;
					document.getElementById('D4_10').innerHTML = selObj.A10;
					document.getElementById('D4_11').innerHTML = selObj.A11;
					document.getElementById('D4_12').innerHTML = selObj.A12;
					document.getElementById('D4_13').innerHTML = selObj.A13;
					document.getElementById('D4_14').innerHTML = selObj.A14;
					document.getElementById('D4_15').innerHTML = selObj.A15;
					document.getElementById('D4_16').innerHTML = selObj.A16;
				}else if(selObj.HM_CD=='02I6040302'){
					document.getElementById('D5_1').innerHTML = selObj.A1;
					document.getElementById('D5_2').innerHTML = selObj.A2;
					document.getElementById('D5_3').innerHTML = selObj.A3;
					document.getElementById('D5_4').innerHTML = selObj.A4;	
					document.getElementById('D5_5').innerHTML = selObj.A5;	
					document.getElementById('D5_6').innerHTML = selObj.A6;	
					document.getElementById('D5_7').innerHTML = selObj.A7;	
					document.getElementById('D5_8').innerHTML = selObj.A8;
					document.getElementById('D5_9').innerHTML = selObj.A9;
					document.getElementById('D5_10').innerHTML = selObj.A10;
					document.getElementById('D5_11').innerHTML = selObj.A11;
					document.getElementById('D5_12').innerHTML = selObj.A12;
					document.getElementById('D5_13').innerHTML = selObj.A13;
					document.getElementById('D5_14').innerHTML = selObj.A14;
					document.getElementById('D5_15').innerHTML = selObj.A15;
					document.getElementById('D5_16').innerHTML = selObj.A16;
				}else if(selObj.HM_CD=='02I6040501'){
					document.getElementById('D6_1').innerHTML = selObj.A1;
					document.getElementById('D6_2').innerHTML = selObj.A2;
					document.getElementById('D6_3').innerHTML = selObj.A3;
				}else if(selObj.HM_CD=='02I6040601'){
					document.getElementById('D7_1').innerHTML = selObj.A1;
					document.getElementById('D7_2').innerHTML = selObj.A2;
					document.getElementById('D7_3').innerHTML = selObj.A3;
				}else if(selObj.HM_CD=='02I6040801'){
					document.getElementById('D8_1').innerHTML = selObj.A1;
					document.getElementById('D8_2').innerHTML = selObj.A2;
					document.getElementById('D8_3').innerHTML = selObj.A3;
					document.getElementById('D8_4').innerHTML = selObj.A4;
					document.getElementById('D8_5').innerHTML = selObj.A5;
					document.getElementById('D8_6').innerHTML = selObj.A6;
					document.getElementById('D8_7').innerHTML = selObj.A7;
					document.getElementById('D8_8').innerHTML = selObj.A8;
					document.getElementById('D8_9').innerHTML = selObj.A9;
					document.getElementById('D8_10').innerHTML = selObj.A10;
				}else if(selObj.HM_CD=='02I6041001'){
					document.getElementById('D9_1').innerHTML = selObj.A1;
					document.getElementById('D9_2').innerHTML = selObj.A2;
					document.getElementById('D9_3').innerHTML = selObj.A3;
				}
			}
		}else{
					document.getElementById('D1_1').innerHTML = "";
					document.getElementById('D1_2').innerHTML = "";				
					document.getElementById('D2_1').innerHTML = "";
					document.getElementById('D2_2').innerHTML = "";
					document.getElementById('D3_1').innerHTML = "";
					document.getElementById('D3_2').innerHTML = "";
					document.getElementById('D3_3').innerHTML = "";
					document.getElementById('D3_4').innerHTML = "";	
					document.getElementById('D3_5').innerHTML = "";	
					document.getElementById('D3_6').innerHTML = "";	
					document.getElementById('D3_7').innerHTML = "";	
					document.getElementById('D3_8').innerHTML = "";	
					document.getElementById('D4_1').innerHTML = "";
					document.getElementById('D4_2').innerHTML = "";
					document.getElementById('D4_3').innerHTML = "";
					document.getElementById('D4_4').innerHTML = "";	
					document.getElementById('D4_5').innerHTML = "";	
					document.getElementById('D4_6').innerHTML = "";	
					document.getElementById('D4_7').innerHTML = "";	
					document.getElementById('D4_8').innerHTML = "";
					document.getElementById('D4_9').innerHTML = "";
					document.getElementById('D4_10').innerHTML = "";
					document.getElementById('D4_11').innerHTML = "";
					document.getElementById('D4_12').innerHTML = "";
					document.getElementById('D4_13').innerHTML = "";
					document.getElementById('D4_14').innerHTML = "";
					document.getElementById('D4_15').innerHTML = "";
					document.getElementById('D4_16').innerHTML = "";
					document.getElementById('D5_1').innerHTML = "";
					document.getElementById('D5_2').innerHTML = "";
					document.getElementById('D5_3').innerHTML = "";
					document.getElementById('D5_4').innerHTML = "";	
					document.getElementById('D5_5').innerHTML = "";	
					document.getElementById('D5_6').innerHTML = "";	
					document.getElementById('D5_7').innerHTML = "";	
					document.getElementById('D5_8').innerHTML = "";
					document.getElementById('D5_9').innerHTML = "";
					document.getElementById('D5_10').innerHTML = "";
					document.getElementById('D5_11').innerHTML = "";
					document.getElementById('D5_12').innerHTML = "";
					document.getElementById('D5_13').innerHTML = "";
					document.getElementById('D5_14').innerHTML = "";
					document.getElementById('D5_15').innerHTML = "";
					document.getElementById('D5_16').innerHTML = "";
					document.getElementById('D6_1').innerHTML = "";
					document.getElementById('D6_2').innerHTML = "";
					document.getElementById('D6_3').innerHTML = "";
					document.getElementById('D7_1').innerHTML = "";
					document.getElementById('D7_2').innerHTML = "";
					document.getElementById('D7_3').innerHTML = "";
					document.getElementById('D8_1').innerHTML = "";
					document.getElementById('D8_2').innerHTML = "";
					document.getElementById('D8_3').innerHTML = "";
					document.getElementById('D8_4').innerHTML = "";
					document.getElementById('D8_5').innerHTML = "";
					document.getElementById('D8_6').innerHTML = "";
					document.getElementById('D8_7').innerHTML = "";
					document.getElementById('D8_8').innerHTML = "";
					document.getElementById('D8_9').innerHTML = "";
					document.getElementById('D8_10').innerHTML = "";
					document.getElementById('D9_1').innerHTML = "";
					document.getElementById('D9_2').innerHTML = "";
					document.getElementById('D9_3').innerHTML = "";
		}
		
		overlay.hide();
	}
	/////////////////////////////////////////상품및서비스특성 조회 - END
	
	//////////////////////////////////////////  채널특성 조회 - START
	function doSearch5() {
		
		overlay.show(true, true);
		
		var obj = new Object();
		obj.pageID = pageID;
		obj.classID = classID;
		obj.methodID = "doSearch5";
		obj.RPT_GJDT = jQuery("#RPT_GJDT option:selected").val();
		GridObj5.refresh({
			actionParam : obj,
			completedEvent : doSearch5_end
		});
	}
	
	function doSearch5_end() {
		var gridCnt = GridObj5.rowCount();
		if (gridCnt > 0) {
			for(i=0 ; i < gridCnt ; i++){
				var selObj = GridObj5.getRow(i);
				if(selObj.HM_CD=='02I6050101'){
					document.getElementById('E1_1').innerHTML = selObj.A1;
					document.getElementById('E1_2').innerHTML = selObj.A2;
					document.getElementById('E1_3').innerHTML = selObj.A3;
					document.getElementById('E1_4').innerHTML = selObj.A4;	
					document.getElementById('E1_5').innerHTML = selObj.A5;	
					document.getElementById('E1_6').innerHTML = selObj.A6;	
					document.getElementById('E1_7').innerHTML = selObj.A7;	
					document.getElementById('E1_8').innerHTML = selObj.A8;
					document.getElementById('E1_9').innerHTML = selObj.A9;
					document.getElementById('E1_10').innerHTML = selObj.A10;
					document.getElementById('E1_11').innerHTML = selObj.A11;
					document.getElementById('E1_12').innerHTML = selObj.A12;
					document.getElementById('E1_13').innerHTML = selObj.A13;			
				}else if(selObj.HM_CD=='02I6050201'){
					document.getElementById('E2_1').innerHTML = selObj.A1;
					document.getElementById('E2_2').innerHTML = selObj.A2;
				}else if(selObj.HM_CD=='02I6050301'){
					document.getElementById('E3_1').innerHTML = selObj.A1;
					document.getElementById('E3_2').innerHTML = selObj.A2;
					document.getElementById('E3_3').innerHTML = selObj.A3;
					document.getElementById('E3_4').innerHTML = selObj.A4;	
					document.getElementById('E3_5').innerHTML = selObj.A5;	
					document.getElementById('E3_6').innerHTML = selObj.A6;	
					document.getElementById('E3_7').innerHTML = selObj.A7;	
					document.getElementById('E3_8').innerHTML = selObj.A8;	
				}else if(selObj.HM_CD=='02I6050401'){
					document.getElementById('E4_1').innerHTML = selObj.A1;
				}
			}
		}else{
					document.getElementById('E1_1').innerHTML = "";
					document.getElementById('E1_2').innerHTML = "";
					document.getElementById('E1_3').innerHTML = "";
					document.getElementById('E1_4').innerHTML = "";	
					document.getElementById('E1_5').innerHTML = "";	
					document.getElementById('E1_6').innerHTML = "";	
					document.getElementById('E1_7').innerHTML = "";	
					document.getElementById('E1_8').innerHTML = "";
					document.getElementById('E1_9').innerHTML = "";
					document.getElementById('E1_10').innerHTML = "";
					document.getElementById('E1_11').innerHTML = "";
					document.getElementById('E1_12').innerHTML = "";
					document.getElementById('E1_13').innerHTML = "";			
					document.getElementById('E2_1').innerHTML = "";
					document.getElementById('E2_2').innerHTML = "";
					document.getElementById('E3_1').innerHTML = "";
					document.getElementById('E3_2').innerHTML = "";
					document.getElementById('E3_3').innerHTML = "";
					document.getElementById('E3_4').innerHTML = "";	
					document.getElementById('E3_5').innerHTML = "";	
					document.getElementById('E3_6').innerHTML = "";	
					document.getElementById('E3_7').innerHTML = "";	
					document.getElementById('E3_8').innerHTML = "";	
					document.getElementById('E4_1').innerHTML = "";

		}
		
		overlay.hide();
	}
	/////////////////////////////////////////채널특성 조회 - END
	
	function dohelpPop(){
		if(tabID == 0){	
			// 회사특성 도움말
	        form3.pageID.value      = "RBA_50_10_02_02";
	        var win                 = window_popup_open(form3,950,450, '');
	        form3.target            = form3.pageID.value;
	        form3.action            = '<c:url value="/"/>0001.do';
	        form3.submit();	
	        
		}else if (tabID == 1) {
			// 고객특성 도움말
	        form3.pageID.value      = "RBA_50_10_02_03";
	        var win                 = window_popup_open(form3,920,850, '');
	        form3.target            = form3.pageID.value;
	        form3.action            = '<c:url value="/"/>0001.do';
	        form3.submit();
	        
		}else if (tabID == 2) {
			// 국가특성 도움말
	        form3.pageID.value      = "RBA_50_10_02_04";
	        var win                 = window_popup_open(form3,980,800, '');
	        form3.target            = form3.pageID.value;
	        form3.action            = '<c:url value="/"/>0001.do';
	        form3.submit(); 
			
		}else if (tabID == 3) {
			// 상품 및 서비스 도움말
	        form3.pageID.value      = "RBA_50_10_02_05";
	        var win                 = window_popup_open(form3,1000,850, '');
	        form3.target            = form3.pageID.value;
	        form3.action            = '<c:url value="/"/>0001.do';
	        form3.submit(); 
			
		}else if (tabID == 4) {
			// 채널 도움말
	        form3.pageID.value      = "RBA_50_10_02_06";
	        var win;            win = window_popup_open(form3,920,820, '');
	        form3.target            = form3.pageID.value;
	        form3.action            = '<c:url value="/"/>0001.do';
	        form3.submit(); 
		}
	}
</script>

<div id="GTDataGrid1_Area" style="display:none;"></div>
<div id="GTDataGrid2_Area" style="display:none;"></div>
<div id="GTDataGrid3_Area" style="display:none;"></div>
<div id="GTDataGrid4_Area" style="display:none;"></div>
<div id="GTDataGrid5_Area" style="display:none;"></div>

<form name="form3" method="post">
   <input type="hidden"  name="pageID"/>
</form>

<form name="form2" method="post">
	<input type="hidden" name="pageID"> <input type="hidden"
		name="RPT_GJDT"> <input type="hidden" name="BIZ_RPT_ID">
	<input type="hidden" name="BIZ_RPT_NM">

</form>
<form name="form1" method="post" onkeydown="doEnterEvent('doSearch01');">
	<input type="hidden" name="pageID">
	<div class="cond-box" id="condBox1">
		<div class="cond-row">
			<div class="cond-item">
				${condel.getLabel('RBA_10_05_01_001','보고기준일')}
				${RBACondEL.getRBASelect('RPT_GJDT','' ,'RBA_common_getRPT_GJDT' ,'' ,'' ,'' ,'jipyoSelectChange("A0001", "A0001", "", onAftreJipyoCdList)')}
			</div>
		</div>
		<div class="cond-line"></div>
		<div class="cond-btn-row" style="text-align: right"
			style="display: block;">
			<div class="panel-heading-button" style="margin-bottom: 5px;">
				${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch01", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')}
				${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"helpBtn", defaultValue:"도움말", mode:"R", function:"dohelpPop", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')}
			</div>
		</div>
	</div>
	<div class="popup-cont-box tab-cont-box"
		style="height: 72vh; width: 98%; margin-left: 13px;">
		<div id="tabCont1" style="visibility: hidden; overflow: scroll;">

			<!-- 회사특성 TAB - START -->
			<div title="${msgel.getMsg('RBA_50_10_02_01_001','회사특성')}">
				<div class="panel panel-primary">
					<div class="panel-footer">
						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td height="10"></td>
							</tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>1.1 경영관리 리스크 현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>3년간 금융사고 발생 금액</th>
									<th>5년간 기관 및 임직원 제재 건수</th>
									<th>해외 투자 건수</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>백만원</td>
									<td>건</td>
									<td>건</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="A1_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="A1_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="A1_3" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td height="20"></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- 회사특성 TAB - END -->

			<!-- 고객특성 TAB - START -->
			<div title="${msgel.getMsg('RBA_50_10_02_01_002','고객특성')}">
				<div class="panel panel-primary">
					<div class="panel-footer">
						<tr>
							<td height="10"></td>
						</tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>2.1 거래자 유형별 현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>개인 고객 수</th>
									<th>개인사업자 고객 수</th>
									<th>법인 고객 수</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>명</td>
									<td>명</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B1_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B1_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B1_3" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td height="20"></td>
							</tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td height="10"></td>
							</tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>2.2 외국인 현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>외국인 개인 고객 수</th>
									<th>외국인 개인사업자 고객 수</th>
									<th>외국인 법인 고객 수</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>명</td>
									<td>명</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B2_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B2_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B2_3" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td height="20"></td>
							</tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td height="10"></td>
							</tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>2.3 비거주자 현황</div>
								</td>
							</tr>
						</table>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>비거주 내국인 고객수</th>
									<th>비거주 외국인 고객수</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>명</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B3_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B3_2" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td height="20"></td>
							</tr>
						</table>
						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td height="20"></td>
							</tr>
						</table>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>2.4 AML취약국가 국적고객현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-subBox" id="B4_BOX">
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>2.5 고액자산가 고객현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>고액자산가 고객 수</th>
									<th>고액자산가 거래 금액</th>
									<th>고액자산가 분류기준</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>백만원</td>
									<td>서술</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B5_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="B5_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99">
										<textarea type="textarea" id="B5_3" name="B5_3" class="input_text" rows="3" readonly></textarea>
									</td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>2.6 PEP현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>PEP고객 수</th>
									<th>PEP List에 포함된 총 PEP 수</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>명</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B6_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B6_2" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>2.7 비영리단체법인 현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>비영리법인(단체)고객 수</th>
									<th>비영리법인(단체)거래 금액</th>
									<th>비영리법인(단체)분류 기준</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>백만원</td>
									<td>서술</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="B7_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="B7_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99">
										<textarea type="textarea" id="B7_3" name="B7_3" class="input_text" rows="3" readonly></textarea>
									</td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
					</div>
				</div>
			</div>
			<!-- 고객특성 TAB - END -->


			<!-- 국가특성 TAB - START -->
			<div title="${msgel.getMsg('RBA_50_10_02_01_003','국가특성')}">
				<div class="panel panel-primary">
					<div class="panel-footer">
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>AML 취약국가 거래 고객 현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-subBox" id="C1_BOX">
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
					</div>
				</div>
			</div>
			<!-- 국가특성 TAB - END -->

			<!-- 상품및서비스특성 TAB - START -->
			<div title="${msgel.getMsg('RBA_50_10_02_01_004','상품및서비스특성')}">
				<div class="panel panel-primary">
					<div class="panel-footer">
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>4.1수신상품거래현황-1)최근1년간 상품 규모현황</div>
								</td>
							</tr>
						</table>
												
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>수신상품 거래금액</th>
									<th>여신상품 거래금액</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>백만원</td>
									<td>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="D1_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="D1_2" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						
						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>4.1 수신상품거래현황-2)전년1년간 상품 규모현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-box">
							<table>
								<tr>
									<th>데이터명</th>
									<th>수신상품 거래금액</th>
									<th>여신상품 거래금액</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>백만원</td>
									<td>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="D2_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="D2_2" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>4.2 위탁매매수수료</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th>지분증권<br>수수료
									</th>
									<th>채무증권<br>수수료
									</th>
									<th>집합투자증권<br>수수료
									</th>
									<th>투자계약증권<br>수수료
									</th>
									<th>파생결합증권<br>수수료
									</th>
									<th>외화증권<br>수수료
									</th>
									<th>기타증권<br>수수료
									</th>
									<th>파생상품<br>수수료
									</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>백만원</td>
									<td>백만원</td>
									<td>백만원</td>
									<td>백만원</td>
									<td>백만원</td>
									<td>백만원</td>
									<td>백만원</td>
									<td>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D3_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D3_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D3_3" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D3_4" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D3_5" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D3_6" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D3_7" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D3_8" class="font_s"></b></td>
								</tr>
							</table>
						</div>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>4.3 위탁매매현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th colspan='2'>지분증권</th>
									<th colspan='2'>채무증권</th>
									<th colspan='2'>집합투자증권</th>
									<th colspan='2'>투자계약증권</th>
									<th colspan='2'>파생결합증권</th>
									<th colspan='2'>외화증권</th>
									<th colspan='2'>기타증권</th>
									<th colspan='2'>파생상품-선물<br>(국내)
									</th>
								</tr>
								<tr align="center">
									<td>위탁매매현황</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
								</tr>
								<tr align="center">
									<td>데이터명
									</th>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_3" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_4" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_5" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_6" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_7" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_8" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_9" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_10" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_11" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_12" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_13" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_14" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_15" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D4_16" class="font_s"></b></td>
								</tr>
							</table>
						</div>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						
						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th colspan='2'>파생상품-선물<br>(해외)
									</th>
									<th colspan='2'>파생상품-옵션/장내<br>(국내)
									</th>
									<th colspan='2'>파생상품-옵션/장내<br>(해외)
									</th>
									<th colspan='2'>파생상품-옵션/장외<br>(국내)
									</th>
									<th colspan='2'>파생상품-옵션/장외<br>(해외)
									</th>
									<th colspan='2'>파생상품-선도<br>(국내)
									</th>
									<th colspan='2'>파생상품-선도<br>(해외)
									</th>
									<th colspan='2'>기타파생상품</th>
								</tr>
								<tr align="center">
									<td>위탁매매현황</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
									<td>매도</td>
									<td>매수</td>
								</tr>
								<tr align="center">
									<td>데이터명
									</th>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
									<td colspan='2'>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_3" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_4" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_5" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_6" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_7" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_8" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_9" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_10" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_11" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_12" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_13" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_14" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_15" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D5_16" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>4.5 투자자문계약현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th>투자자문 고객수</th>
									<th>투자자문 계약건수</th>
									<th>투자자문 계약자산 총액</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>건</td>
									<td>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값
									</th>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D6_1" class="font_s">해당없음</b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D6_2" class="font_s">해당없음</b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D6_3" class="font_s">해당없음</b></td>
								</tr>
							</table>
						</div>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>4.6 투자일임계약 현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th>투자일임 고객수</th>
									<th>투자일임 계약건수</th>
									<th>투자일임 계약자산 총액<br>(계약금액)
									</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>건</td>
									<td>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값
									</th>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D7_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D7_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D7_3" class="font_s"></b></td>
								</tr>
							</table>
						</div>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>4.8 투기목적 장외 파생상품 거래 현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th colspan="2">파생결합증권</th>
									<th colspan="2">선도 거래</th>
									<th colspan="2">옵션 거래</th>
									<th colspan="2">스왑 거래</th>
									<th colspan="2">기타 거래</th>
								</tr>
								<tr align="center">
									<td>거래현황</td>
									<td>거래건수</td>
									<td>금액</td>
									<td>거래건수</td>
									<td>금액</td>
									<td>거래건수</td>
									<td>금액</td>
									<td>거래건수</td>
									<td>금액</td>
									<td>거래건수</td>
									<td>금액</td>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>건</td>
									<td>백만원</td>
									<td>건</td>
									<td>백만원</td>
									<td>건</td>
									<td>백만원</td>
									<td>건</td>
									<td>백만원</td>
									<td>건</td>
									<td>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값
									</th>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_3" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_4" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_5" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_6" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_7" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_8" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_9" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D8_10" class="font_s"></b></td>
								</tr>
							</table>
						</div>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>4.10 현금거래 규모 현황</div>
								</td>
							</tr>
						</table>
												
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th>현금거래 고객수</th>
									<th>현금거래 건수</th>
									<th>현금거래 거래금액</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>건</td>
									<td>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값
									</th>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D9_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D9_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="D9_3" class="font_s"></b></td>
								</tr>
							</table>
						</div>
						
					</div>
				</div>
			</div>
			<!-- 상품및서비스특성 TAB - END -->

			<!-- 채널특성 TAB - START -->
			<div title="${msgel.getMsg('RBA_50_10_02_01_005','채널특성')}">
				<div class="panel panel-primary">
					<div class="panel-footer">
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>5.1 인원 및 점포현황</div>
								</td>
							</tr>
						</table>
						
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-subBox">
							<table>
								<tr>
									<th>데이터명</th>
									<th>본부부서<br>임직원수
									</th>
									<th>국내지점<br>임직원수
									</th>
									<th>국내영업소<br>임직원수
									</th>
									<th>해외지점<br>임직원수
									</th>
									<th>해외사무소<br>임직원수
									</th>
									<th>해외현지법인<br>임직원수
									</th>
									<th>본부부서<br>부서수
									</th>
									<th>국내지점<br>부서수
									</th>
									<th>국내영업소<br>부서수
									</th>
									<th>해외지점<br>부서수
									</th>
									<th>해외사무소<br>부서수
									</th>
									<th>해외현지법인<br>부서수
									</th>
									<th>퇴직<br>임직원수
									</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
									<td>명</td>
									<td>명</td>
									<td>명</td>
									<td>명</td>
									<td>명</td>
									<td>개</td>
									<td>개</td>
									<td>개</td>
									<td>개</td>
									<td>개</td>
									<td>개</td>
									<td>명</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_3" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_4" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_5" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_6" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_7" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_8" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_9" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_10" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_11" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_12" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E1_13" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>5.2 전자금융서비스 가입자수 현황</div>
								</td>
							</tr>
						</table>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-subBox">
							<table>
								<tr>
									<th>데이터명</th>
									<th>HTS 가입자 수</th>
									<th>MTS 가입자 수</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>천명</td>
									<td>천명</td>
								</tr>
								<tr align="center">
									<td>결과값</td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E2_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E2_2" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>5.3 전자금융경로를 이용한 거래 현황</div>
								</td>
							</tr>
						</table>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>
						
						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th colspan='2'>HTS이용건수</th>
									<th colspan='2'>MTS이용건수</th>
									<th colspan='2'>전화거래이용건수</th>
									<th colspan='2'>창구거래</th>
								</tr>
								<tr align="center">
									<td>거래현황</td>
									<td>이용건수</td>
									<td>이용금액</td>
									<td>이용건수</td>
									<td>이용금액</td>
									<td>이용건수</td>
									<td>이용금액</td>
									<td>이용건수</td>
									<td>이용금액</td>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>천건</td>
									<td>백만원</td>
									<td>천건</td>
									<td>백만원</td>
									<td>천건</td>
									<td>백만원</td>
									<td>천건</td>
									<td>백만원</td>
								</tr>
								<tr align="center">
									<td>결과값
									</th>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E3_1" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="E3_2" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E3_3" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="E3_4" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E3_5" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="E3_6" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E3_7" class="font_s"></b></td>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;" id="E3_8" class="font_s"></b></td>
								</tr>
							</table>
						</div>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>
						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="20"></td></tr>
						</table>

						<table
							style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr>
								<td width="100">
									<div class='grid-title'><i class='fa fa-chevron-circle-down'></i>5.4 전담투자상담사현황</div>
								</td>
							</tr>
						</table>

						<table style="width: 100%; border: 0; cellspacing: 0; cellpadding: 0;">
							<tr><td height="5"></td></tr>
						</table>

						<div class="table-subBox">
							<table border=3>
								<tr>
									<th>데이터명</th>
									<th colspan='2'>전담투자 상담사 수</th>
								</tr>
								<tr align="center">
									<td>단위</td>
									<td>명</td>
								</tr>
								<tr align="center">
									<td>결과값
									</th>
									<td bgcolor="#FFFF99"><b><span style="display:block;text-align:center;width:50px;" id="E4_1" class="font_s"></b></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- 채널특성 TAB - END -->

		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp"
	flush="true" />