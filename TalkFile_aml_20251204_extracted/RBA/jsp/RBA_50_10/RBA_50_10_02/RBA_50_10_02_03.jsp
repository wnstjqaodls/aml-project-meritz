<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_10_02_02.jsp
- Comment    : 고유위험 지표 상세 정의_고객특성
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
		tag+= 					"<td align='center' colspan='4'><strong>AML 취약국가 국적 고객 현황</strong></td>";
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
					tag+=	 "1. 데이터 산출 기준 : 평가일 기준 (2016.06.30)<br/>";
					tag+=    "2. 데이터 설명<br/>";
					tag+=    "1) 「2.2 외국인 현황」에서 분류된 고객 중 AML 취약국가에 해당되는 고객수<br/>";
					tag+=    "2) 국가코드는 [별첨1. 국가코드] Sheet의 'FATF 관리국가'와 '조세회피처' 컬럼의 'O' 표시된 국가들을 적용함(총 73개국)<br/>";
					tag+=    "(1) FATF 관리국가는 미이행국가 및 취약국가 11개국 적용<br/>";
					tag+=    "    - High-risk and non-cooperative Jurisdictions - June 2016<br/>";
					tag+=    "      ① Public Statement(이란, 북한 2개국)<br/>";
					tag+=    "      ② Improving Global AML/CFT Compliance: on-going processs(9개국)<br/>";
					tag+=    "(2) 조세회피처는 관세청 관리대상국가 62개국 적용 (기준일자: 2011.02.25)<br/>";
					tag+=    "3) 개인 고객의 경우 국적이 해당 국가일 경우 적용<br/>";
					tag+=    "4) 개인사업자 고객의 경우 대표자 국적이 해당 국가일 경우 적용<br/>"; 
					tag+=	 "5) 법인 고객의 경우 소재지(해외지사의 경우 본사 소재지)가 해당 국가인 경우 적용<br/>";
					tag+=	 "[거래금액 산출기준]<br/>";
					tag+=	 "1. 데이터 산출 기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>";
					tag+=	 "2. 데이터 설명<br/>";
					tag+=	 "1) 개인 고객 거래금액 :  해당 국가의 국적을 가진 고객들의 수신, 여신 거래의 합으로 산출<br/>";
					tag+=    "→ [별첨2. 상품분류]에 명시된 '영역' 중 수신, 여신 계정에 해당하는 상품을 보유한 고객을 기준으로 산정<br/>";
					tag+=    "→ 추출거래 : 입금, 출금, 입고(입고거래량*단가), 출고(출고 거래량 * 단가) 거래 추출 <br/>"; 
					tag+=    "2) 개인사업자 고객 거래금액 :   해당 국가의 국적을 가진 고객들의 수신, 여신 거래의 합으로 산출<br/>";
					tag+=    "→ [별첨2. 상품분류]에 명시된 '영역' 중 수신, 여신 계정에 해당하는 상품을 보유한 고객을 기준으로 산정<br/>";
					tag+=    "→ 추출거래 : 입금, 출금, 입고(입고거래량*단가), 출고(출고 거래량 * 단가) 거래 추출   <br/>";
					tag+=    "3) 법인 고객 거래금액 :  해당 국가의 국적을 가진 고객들의 수신, 여신 거래의 합으로 산출 <br/>";
					tag+=    "→ [별첨2. 상품분류]에 명시된 '영역' 중 수신, 여신 계정에 해당하는 상품을 보유한 고객을 기준으로 산정<br/>";
					tag+=    "→ 추출거래 : 입금, 출금, 입고(입고거래량*단가), 출고(출고 거래량 * 단가) 거래 추출  <br/>";
					tag+=    "2) 월평균 금액으로 산정 = (거래금액의 합)/12</td>";
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


<div style="overflow:scroll; width:98vw; height:90vh;">
<div class="table-box11">
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                             
<tr><td align="center" colspan="2"><strong>고객특성</strong></td>
	<td align="center" colspan="3"><strong>거래자 유형별 현황</strong></td>
</tr>
<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">개인 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
	<td align="left" rowspan= "3">1. 데이터 산출 기준 : 평가일 기준 (2016.06.30)<br/>
							 	  2. 데이터 설명  <br/>
									1) CDD 이행대상 거래자 유형별 고객수<br/>
									2) 금융회사 자체의 거래자 유형 분류기준이 있는 경우, 해당 분류기준에 따라 데이터를 산출함<br/>
									3) 금융회사 자체의 거래자 유형 분류기준이 없거나 애매한 경우, 거래자 유형(개인, 개인사업자, 법인)은 아래의 기준에 따라 분류<br/>
   									(1) 사업자등록번호 10자리 中 4/5번째 자리(예: 123-45-67890)가 <br/>
       								'01'~'79' 또는 '90'~'99'이면 '개인사업자'([참고1]), <br/>
       								나머지는 '법인'([참고2]와 [참고3])으로 분류<br/>
   									(2) 사업자등록번호가 아닌 '고유번호증' 또는 '납세번호증'이 있는 경우, '법인'으로 분류<br/>
   									(3) 사업자등록번호, 고유번호증, 납세번호증이 없는 경우 '개인'으로 분류<br/>
   									(4) 금융회사를 포함하며, '법인'으로 분류<br/>
									※ [참고1] 사업자등록번호 4/5번째 기준 개인사업자<br/>
									   01~79: 개인사업자<br/>
									   90~99: 개인면세사업<br/>
									※ [참고2] 사업자등록번호 4/5번째 기준 영리법인<br/>
									   81,86,87,88: 법인사업자 중 영리법인<br/>
							     	   84: 외국법인의 본, 지점 및 연락사업소<br/>
   									   85: 지점법인<br/>
									※ [참고3] 사업자등록번호 4/5번째 기준 비영리법인<br/>
   									   80: 소득세법 제1조3항(3) 이외의 자 및 다단계판매업자 등<br/>
   									   82: 비영리법인, 법인격이 없는 사단/재단/기타단체<br/>
   									   83: 학교법인, 지자체<br/>
   									   89: 법인이 아닌 종교단체(소득세법 제1조 제3항)</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">개인사업자 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">법인 고객수</td>
	<td align="center">개</td>
	<td align="center"></td>
</tr>

</table>
<br><br><br>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>고객특성</strong></td>
	<td align="center" colspan="3"><strong>외국인 현황</strong></td>
</tr>
<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">외국인 개인 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
	<td align="left" rowspan= "3">1. 데이터 산출 기준 : 평가일 기준 (2016.06.30) <br/>
								  2. 데이터 설명<br/>
									1) 외국인 개인 고객은 「2.1 거래자 유형별 현황」에서 개인으로 분류된 고객 중에 국적이 한국('KR')이 아닌 경우로 STR 서식의 <br/>
									   실명번호구분이 다음에 해당하는 경우 적용<br/>
    									① '여권번호', ② '외국인등록번호', ③ '국내거소신고번호', ④ '투자등록번호',<br/>
    									⑤ 'HIC코드',  ⑥ '해당국가법인번호'<br/>
									2) 외국인 개인사업자 고객은 「2.1 거래자 유형별 현황」에서 개인사업자로 분류된 고객 중에 대표자의 실명번호구분이 <br/>
										① '여권번호' ~ ⑥ '해당국가법인번호'에 해당하는 경우<br/>
									3) 외국인 법인 고객은 「2.1 거래자 유형별 현황」에서 법인으로 분류된 고객 중에 소재지가 한국('KR')이 아닌 경우에 해당, <br/>
									    해외지점 등은 본사 소재지 기준으로 함(FATCA 기준 준용)<br/> </td>
</tr>
<tr><td align="center">2</td>
	<td align="left">외국인 개인사업자 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
</tr>
<tr><td align="center">3</td>
	<td align="left">외국인 법인 고객수</td>
	<td align="center">개</td>
	<td align="center"></td>
</tr>
</table>
<br><br><br>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>고객특성</strong></td>
	<td align="center" colspan="3"><strong>비거주자 현황</strong></td>
</tr>
<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">비거주 내국인 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
	<td align="left" rowspan= "3">1. 데이터 산출 기준 : 평가일 기준 (2016.06.30) <br/>
2. 데이터 설명<br/>
1) 「2.1 거래자 유형별 현황」에서 개인으로 분류된 고객을 대상으로 함<br/>
2) 금융회사 자체의 거래자 유형 분류기준이 있는 경우, 해당 분류기준에 따라 데이터를 산출함<br/>
3) 금융회사 자체의 거래자 유형 분류기준이 없거나 애매한 경우, 아래의 기준을 참고하여 구분함<br/>
※ [참고1] 비거주자의 구분 - 「외국환거래법시행령」 제10조(거주자와 비거주자와의 구분)<br/>
- 비거주 내국인<br/>
① 외국에서 영업활동에 종사하고 있는 자<br/>
② 외국에 있는 국제기구에서 근무하고 있는 자<br/>
③ 2년이상 외국에 체재하고 있는 자<br/>
④ 그 밖에 영업형태, 주요 체재지 등을 고려하여 비거주자로 판단할 필용성이 인정되는자로서 기획재정부장관이 정하는 자<br/>
- 비거주 외국인<br/>
① 국내에 있는 외국정부의 공관 또는 국제기구에서 근무하는 외교관, 영사 또는 그 수행원이나 사용인<br/>
② 외국정부 또는 국제기구의 공무로 입국하는 자<br/>
③ 거주자였던 외국인으로서 출구하여 외국에서 3개월 이상 체재 중인 자</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">비거주 외국인 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
</tr>
</table>
<br><br><br>
<div id="GTDataGrid3_Area" style="display:none;"></div>
<div class="table-subBox" id="C1_BOX">
</div>
<br><br><br>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>고객특성</strong></td>
	<td align="center" colspan="3"><strong>고액자산가 고객수</strong></td>
</tr>
<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">고액자산가 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
	<td align="left" colspan= "2">1. 데이터 산출 기준 : 평가일 기준 (2016.06.30) <br/>
2. 데이터 설명<br/>
1) 고액자산가로 등록된 고객수<br/>
2) 금융회사에서 강화된 고객확인(EDD)을 위해 고위험군으로 분류된 일정금액 이상 금융자산을 보유한 고액자산가를 의미하며, <br/>
금융회사 자체의 분류기준을 따름 <br/>※ 고액자산가를 관리하지 않을 경우는 작성 제외</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">고액자산가 거래금액</td>
	<td align="center">백만원</td>
	<td align="center"></td>
	<td align="left" colspan= "2">1. 데이터 산출 기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>
2. 데이터 설명 : 고액자산가에 의해 발생한 수신, 여신 거래의 합으로 산출<br/>
→ [별첨2. 상품분류]에 명시된 '영역' 중 수신, 여신 계정에 해당하는 상품을 보유한 고객을 기준으로 산정<br/>
→ 추출거래 : 입금, 출금, 입고(입고거래량*단가), 출고(출고 거래량 * 단가) 거래 추출  <br/>
3. 월평균 금액으로 산정 = (거래금액의 합)/12</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">고액자산가 분류기준</td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left" colspan= "2">1. 현재 금융회사에 적용 중인 고액자산가 분류기준 기술<br/>
(고액자산가에 대한 분류기준이 없고, 고액자산가에 대한 별도 관리를 하지 않는 경우에는 '해당없음'으로 명시)</td>
</tr>
</table>
<br><br><br>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>고객특성</strong></td>
	<td align="center" colspan="3"><strong>PEP 현황</strong></td>
</tr>
<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">PEP 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
	<td align="left" colspan= "2">1. 데이터 산출 기준 : 평가일 기준 (2016.06.30) <br/>
2. 데이터 설명<br/>
1) PEP 고객수 : 평가일 기준 PEP로 분류된 고객수<br/>
2) PEP List에 포함된 총 PEP 수 : PEP Filtering을 위해 적용 중인 List에 포함된 PEP의 총 수</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">PEP List에 포함된 총 PEP 수</td>
	<td align="center">명</td>
	<td align="center"></td>
	<td align="left" colspan= "2">1. 데이터 산출 기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>
2. 데이터 설명 : 고액자산가에 의해 발생한 수신, 여신 거래의 합으로 산출<br/>
→ [별첨2. 상품분류]에 명시된 '영역' 중 수신, 여신 계정에 해당하는 상품을 보유한 고객을 기준으로 산정<br/>
→ 추출거래 : 입금, 출금, 입고(입고거래량*단가), 출고(출고 거래량 * 단가) 거래 추출  <br/>
3. 월평균 금액으로 산정 = (거래금액의 합)/12</td>
</tr>
</table>
<br><br><br>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>고객특성</strong></td>
	<td align="center" colspan="3"><strong>비영리단체/법인현황</strong></td>
</tr>
<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">비영리법인(단체) 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
	<td align="left" colspan= "2">1. 데이터 산출 기준 : 평가일 기준 (2016.06.30) <br/>
2. 데이터 설명 <br/>
1) 평가일 기준 (2015.06.30) 비영리단체(법인) 고객수<br/>
2) 금융회사 자체의  비영리단체(법인) 분류기준이 있는 경우, 해당 분류기준에 따라 데이터를 산출함<br/>
3) 금융회사 자체의 비영리단체(법인) 분류기준이 없거나 애매한 경우, 아래의 기준에 따라 분류<br/>
(1) 「2.1 거래자 유형별 현황」에서 법인으로 분류된 고객 중에 사업자등록번호 10자리 中 4/5번째 자리<br/>
(예: 123-45-67890)가 '80', '82', '89' 이거나<br/>
(2) 금융감독원 업무보고서의 비영리단체 정의에 해당하는 경우<br/>
※ [참고] 비영리단체 정의 (보험 업무보고서 기준)<br/>
조사 및 과학연구기관, 교육기관, 의료 및 기타서비스, 복지서비스, 오락 및 문화서비스, 종교단체, 전문직업단체  <br/>
및 노동단체와 시민단체 등의 비금융활동에 종사하는 협회, 조합, 재단법인 및 비영리사단법인을 말함 </td>
</tr>
<tr><td align="center">2</td>
	<td align="left">비영리법인(단체) 거래금액</td>
	<td align="center">백만원</td>
	<td align="center"></td>
	<td align="left" colspan= "2">1. 데이터 산출 기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>
2. 데이터 설명<br/>
1) 비영리법인(단체) 고객들이 동 기간동안 발생시킨 수신, 여신,거래의 합으로 산출<br/>
→ [별첨2. 상품분류]에 명시된 '영역' 중 수신, 여신 계정에 해당하는 상품을 보유한 고객을 기준으로 산정<br/>
→ 추출거래 : 입금, 출금, 입고(입고거래량*단가), 출고(출고 거래량 * 단가) 거래 추출  <br/>
2) 월평균 금액으로 산정 = (거래금액의 합)/12</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">비영리법인(단체) 분류기준</td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left" colspan= "2">1. 현재 금융회사에서 CDD 이행을 위해 비영리법인(단체)을 분류하는 기준에 대해 구체적으로 기술</td>
</tr>
</table>
<br/><br/>
</div>
</div>
		<div class="cond-btn-row" style="text-align:right">
			 	${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"closeBtn", closeBtn:"닫기", mode:"R", function:"self.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
		</div>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />