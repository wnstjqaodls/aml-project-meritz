<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_10_02_04.jsp
- Comment    : 고유위험 지표 상세 정의_국가특성
- Version    : 1.0
- history    : 1.0 2018. 07.27
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>

<style>
.table-box11 {
    margin  : 0;
    padding : 1px;
    display : inline-table;
    width   : 100%;
}
.table-box11 table{
    outline : 1px solid #CCCCCC;
    width   : 100%;
}
.table-box11 table tr+tr{
    border-top : 1px solid #CCCCCC;
}

.table-box11 table tr th{
    border-right    : 1px solid #CCCCCC;
    padding         : 5px 5px;
    background-color: #E0ECF8;
    font-weight     : 700;
    vertical-align  : top;
}
.table-box11 table tr td {
    padding : 5px 5px;
    border-right    : 1px solid #CCCCCC;
}

</style>

<!-- Function Script -->
<script language="JavaScript"src="${Path}/Package/ext/js/state_validate.js"></script>
<script language="JavaScript">

	var GridObj3 = null;

	var classID = "RBA_50_10_02_04"; 
	var pageID = "RBA_50_10_02_04";

	$(document).ready(function() {
		GridObj3 = initGrid3({
            gridId          : 'GTDataGrid3'
           ,headerId        : 'RBA_50_10_02_04_Grid1'
           ,gridAreaId      : 'GTDataGrid3_Area'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,completedEvent  : function(){
        	   setupGridFilter([GridObj3]);
        	   doSearch3();
            }
        });
	});

	function doSearch3() {
		var obj = new Object();
		obj.pageID = pageID;
		obj.classID = classID;
		obj.methodID = "doSearch3";
		//obj.RPT_GJDT = "20180801";
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
		tag+=		"<div>";
		tag+= 			"<table>"
		tag+=				"<tr><td align='center' colspan='4' bgcolor='#E0ECF8'><strong>영역</strong></td>";
		tag+=					"<td align='center' colspan='4' bgcolor='#E0ECF8'><strong>구분</strong></td>";
		tag+= 				"</tr>";                                                                                   
		tag+= 				"<tr><td align='center' colspan='4'><strong>국가특성</strong></td>";
		tag+= 					"<td align='center' colspan='4'><strong>AML 취약국가 거래 고객 현황</strong></td>";
		tag+=				"</tr>";
		tag+=				"<tr>";
		tag+=	            	"<td align='center' bgcolor='#E0ECF8'><strong>No</strong></td>";
		tag+=	            	"<td align='center' bgcolor='#E0ECF8'><strong>국가코드</td>"; 
		tag+=	            	"<td align='center' bgcolor='#E0ECF8'><strong>개인 고객수(명)</td>"; 
		tag+=	            	"<td align='center' bgcolor='#E0ECF8'><strong>개인 사업자고객수(명)</td>"; 
		tag+=	            	"<td align='center' bgcolor='#E0ECF8'><strong>법인 고객수(개)</td>"; 
		tag+=	            	"<td align='center' bgcolor='#E0ECF8'><strong>개인 고객<br>거래금액(백만원)</td>";  
		tag+=	            	"<td align='center' bgcolor='#E0ECF8'><strong>개인사업자 고객<br>거래금액(백만원)</td>"; 
		tag+=	            	"<td align='center' bgcolor='#E0ECF8'><strong>법인 고객<br>거래금액(백만원)</td>";  
		tag+=				"</tr>"; 
		if (gridCnt > 0) {
			for(i=0 ; i < gridCnt ; i++){
				var selObj = GridObj3.getRow(i);
					tag+="<tr>";	
					tag+=	"<td align='center'>"+selObj.NUM+"</td>";
					tag+=   "<td align='center'>"+selObj.NTN_CD+"</td>";
					tag+=  	"<td align='center'></td>";
					tag+=  	"<td align='center'></td>";
					tag+=  	"<td align='center'></td>";
					tag+=  	"<td align='center'></td>";
					tag+=  	"<td align='center'></td>";
					tag+=  	"<td align='center'></td>";
					tag+="</tr>";
			}
					tag+="<tr><td align='center' colspan='2'>결과값 산출기준</td>";
					tag+= 	 "<td align='left' colspan='6'>[고객수 산출기준]<br/>";
					tag+=	 "1. 데이터 산출 기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>";
					tag+=	 "2. 데이터 설명<br/>";
					tag+=	 "1) 국가코드는 [별첨1. 국가코드] Sheet의 'FATF 관리국가'와 '조세회피처' 컬럼의 'O' 표시된 국가들을 적용함(총 73개국)<br/>";
					tag+=    "(1) FATF 관리국가는 미이행국가 및 취약국가 11개국 적용<br/>";
					tag+=    "- High-risk and non-cooperative Jurisdictions - June 2016<br/>";
					tag+=    "① Public Statement(이란, 북한 2개국)<br/>";
					tag+=    "② Improving Global AML/CFT Compliance : on-going processs (9개국)<br/>";
					tag+=    "(2) 조세회피처는 관세청 관리대상국가 62개국 적용 (기준일자: 2011.02.25)<br/>";
					tag+=	 "2) 개인 고객수 : 해당 국가와 1건 이상 외환거래 ( 해외 주식, 선물 등의 매입/매도 계약체결과 당타발 거래포함 ) 를 한 개인 고객수  (최종고객 기준)<br/>";
					tag+=	 "3) 개인사업자 고객수 : 해당 국가와 1건 이상 외환거래 ( 해외 주식, 선물 등의 매입/매도 계약체결과 당타발 거래포함 ) 를 한 개인사업자 고객수  (최종고객 기준)<br/>";
					tag+=	 "4) 법인 고객수 : 해당 국가와 1건 이상 외환거래 ( 해외 주식, 선물 등의 매입/매도 계약체결과 당타발 거래포함 ) 를 한 법인 고객수  (최종고객 기준)<br/>";
					tag+=	 "5) 월평균 거래고객수로 산정 = (월별 거래고객수 합계)/12<br/>";
					tag+=	 "→ 한고객이 매월 거래를 발생시켰다면 매월 고객수에 (중복적으로) 포함<br/><br/>";
					tag+=	 "[거래금액 산출기준]<br/>";
					tag+=	 "1. 데이터 산출 기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>";
					tag+=	 "2. 데이터 설명<br/>";
					tag+=	 "1) 개인 고객 거래금액 : 개인 고객들이 동 기간동안 발생시킨 외환거래 ( 해외 주식, 선물 등의 매입/매도 계약체결과 당타발 거래포함 ) 중 <br/> 거래 상대국가가 해당 국가인 거래의 거래금액 총합<br/>";
					tag+=	 "2) 개인사업자 고객 거래금액 : 개인사업자 고객들이 동 기간동안 발생시킨 외환거래 ( 해외 주식, 선물 등의 매입/매도 계약체결과 당타발 거래포함 ) 중 <br/> 거래 상대 국가가 해당국가인 거래의 거래금액 총합<br/>";
					tag+=	 "3) 법인 고객 거래금액 : 법인 고객들이 동 기간동안 발생시킨 외환거래 ( 해외 주식, 선물 등의 매입/매도 계약체결과 당타발 거래포함 ) 중 <br/> 거래 상대국가가 해당 국가인 거래의 거래금액 총합<br/>";
					tag+=	 "4) 월평균 거래금액으로 산정 = (동 기간동안 거래금액 총합)/12<br/>";
					tag+=	 "5) 환율은 각 금융기관 시스템 기준으로 적용</td>";
					tag+="</tr>";
		} 
		tag+=			"</table>";
		tag+=		"</div>";
		tag+=	"</td>";
		tag+="</tr>";
		tag+="</table>";
		$("#C1_BOX").html(tag);
	}

</script>
<div id="GTDataGrid3_Area" style="display:none;"></div>

<div style="overflow:scroll; width:98vw; height:90vh;">
<div class="table-subBox" id="C1_BOX">
</div>
<br><br>
</div>
		<div class="cond-btn-row" style="text-align:right">
			 	${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"closeBtn", closeBtn:"닫기", mode:"R", function:"self.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
		</div>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />