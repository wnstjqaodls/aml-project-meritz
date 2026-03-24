<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_10_02_02.jsp
- Comment    : 고유위험 지표 상세 정의_상품 및 서비스특성
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
<div style="overflow:scroll; width:98vw; height:90vh;">
<div class="table-box11">
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="2"><strong>수신상품 거래 현황 1) 최근 1년간 상품규모 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center" >1</td>
	<td align="left" >수신상품 거래금액</td>
	<td align="center" >백만원</td>
	<td align="left" >'재무상태표(GA023)' 보고서 계정이 [별첨2. 상품분류]의  "수신" 영역인 월평균 금액을 기입함<br/>
★ 최근 1년기준으로 수신상품 월평균 금액 산출 <br/>
참고_상품영역별 규모 Sheet의 수신_합계의 월평균 금액 (a/12)</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">여신상품 거래금액</td>
	<td align="center">백만원</td>
	<td align="left">'재무상태표(GA023)' 보고서 계정이 [별첨2. 상품분류]의  "여신" 영역인 월평균 금액을 기입함<br/>
★ 최근 1년기준으로 여신상품 월평균 금액 산출 <br/>
참고_상품영역별 규모 Sheet의 여신_합계의 월평균 금액 (a/12)</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">선불카드 거래금액</td>
	<td align="center">백만원</td>
	<td align="left">'최근 1년간 (2015.07.01 ~ 2016.06.30) 선불카드로 거래된 총 금액  <br/>
★ 최근 1년기준으로 선불카드 거래 월평균 금액 산출 <br/>
참고_상품영역별 규모 Sheet의 선불카드_합계의 월평균 금액 (a/12)</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07.01 ~ 2016.06.30)<br/>
2. 데이터 설명<br/>
1) [별첨2. 상품분류]에 명시된 '상품영역'을 기준의 월평균 거래금액<br/>
2) 금융감독원 업무보고서 '재무상태표(GA023)' 기준으로 함<br/>
★ 2015.7월~2016.6월말  1년간 월평균 금액 산출 (참고_상품영역별 규모 sheet) 최근 1년간 상품규모 현황 참조)<br/></td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="2"><strong>수신상품 거래 현황 2) 전전 1년간 상품규모 현황 </strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center" >1</td>
	<td align="left" >수신상품 거래금액</td>
	<td align="center" >백만원</td>
	<td align="left" >재무상태표(GA023)' 보고서 계정이 [별첨2. 상품분류]의  "수신" 영역인 월평균 금액을 기입함<br/>
★ 전전 1년기준으로 수신상품 월평균 금액 산출 <br/>
참고_상품영역별 규모 Sheet의 수신_합계의 월평균 금액 (a/12)</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">여신상품 거래금액</td>
	<td align="center">백만원</td>
	<td align="left">'재무상태표(GA023)' 보고서 계정이 [별첨2. 상품분류]의  "여신" 영역인 월평균 금액을 기입함<br/>
★ 전전 1년기준으로 여신상품 월평균 금액 산출 <br/>
참고_상품영역별 규모 Sheet의 여신_합계의 월평균 금액 (a/12)</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">선불카드 거래금액</td>
	<td align="center">백만원</td>
	<td align="left">'전전 1년간 (2014.07.01 ~ 2015.06.30) 선불카드로 거래된 총 금액  <br/>
★ 전전 1년기준으로 선불카드 거래 월평균 금액 산출 <br/>
참고_상품영역별 규모 Sheet의 선불카드_합계의 월평균 금액 (a/12)</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  전전 1년 (2014.07.01 ~ 2015.06.30)<br/>
2. 데이터 설명<br/>
1) [별첨2. 상품분류]에 명시된 '상품영역'을 기준의 월평균 거래금액<br/>
2) 금융감독원 업무보고서 '재무상태표(GA023)' 기준으로 함<br/>
★ 2014.7월~2015.6월말 월평균 금액 산출 (참고_상품영역별 규모 sheet) 최근 1년간 상품규모 현황 참조)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="2"><strong>위탁매매 수수료</strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center" >1</td>
	<td align="left" >지분증권 수수료</td>
	<td align="center" >백만원</td>
	<td align="left" >'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 지분증권 - 지분증권합계인 수수료를<br/> 
	기준으로 최근 1년간 지분증권 총 수수료 금액을 합산<br/> 
★ 최근 1년을 기준으로 총 수수료 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 수수료 금액 + 2015.8 당월 총 수수료 금액 + …… + 2016.6 당월 총 수수료 금액</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">채무증권 수수료</td>
	<td align="center">백만원</td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 채무증권 - 채무증권합계인 수수료를 기준으로<br/> 
	 최근 1년간 채무증권 총 수수료 금액을 합산<br/> 
★ 최근 1년을 기준으로 총 수수료 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 수수료 금액 + 2015.8 당월 총 수수료 금액 + …… + 2016.6 당월 총 수수료 금액</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">집합투자증권 수수료</td>
	<td align="center">백만원</td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 집합투자증권인 수수료를 기준으로<br/> 
	 최근 1년간 집합투자증권 총 수수료 금액을 합산<br/> 
★ 최근 1년을 기준으로 총 수수료 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 수수료 금액 + 2015.8 당월 총 수수료 금액 + …… + 2016.6 당월 총 수수료 금액</td>
</tr>
<tr><td align="center">4</td>
	<td align="left">투자계약증권 수수료</td>
	<td align="center">백만원</td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 투자계약증권인 수수료를 기준으로<br/>  최근 1년간 투자계약증권 총 수수료 금액을 합산<br/> 
★ 최근 1년을 기준으로 총 수수료 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 수수료 금액 + 2015.8 당월 총 수수료 금액 + …… + 2016.6 당월 총 수수료 금액</td>
</tr>
<tr><td align="center">5</td>
	<td align="left">파생결합증권 수수료</td>
	<td align="center">백만원</td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 파생결합증권 - 파생결합증권합계인 <br/>수수료를 기준으로  최근 1년간 파생결합증권 총 수수료 금액을 합산<br/> 
★ 최근 1년을 기준으로 총 수수료 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 수수료 금액 + 2015.8 당월 총 수수료 금액 + …… + 2016.6 당월 총 수수료 금액</td>
</tr>
<tr><td align="center">6</td>
	<td align="left">외화증권 수수료</td>
	<td align="center">백만원</td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 외화증권인 수수료를 기준으로<br/>  최근 1년간 외화증권 총 수수료 금액을 합산<br/> 
★ 최근 1년을 기준으로 총 수수료 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 수수료 금액 + 2015.8 당월 총 수수료 금액 + …… + 2016.6 당월 총 수수료 금액</td>
</tr>
<tr><td align="center">7</td>
	<td align="left">기타증권 수수료</td>
	<td align="center">백만원</td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 기타증권인 수수료를 기준으로<br/>  최근 1년간 기타증권 총 수수료 금액을 합산<br/> 
★ 최근 1년을 기준으로 총 수수료 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 수수료 금액 + 2015.8 당월 총 수수료 금액 + …… + 2016.6 당월 총 수수료 금액</td>
</tr>
<tr><td align="center">8</td>
	<td align="left">파생상품 수수료</td>
	<td align="center">백만원</td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 파생상품합계인 수수료를 기준으로<br/>  최근 1년간 파생상품 총 수수료 금액을 합산 <br/>
★ 최근 1년을 기준으로 총 수수료 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 수수료 금액 + 2015.8 당월 총 수수료 금액 + …… + 2016.6 당월 총 수수료 금액</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07~2016.06) 기준<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 기준으로 함<br/>
2) 최근 1년간 수수료 총 합산을 결과값으로 입력  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="3"><strong>위탁매매 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>위탁매매 현황 </strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매수 (백만원) </strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매도 (백만원) </strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">지분증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 지분증권<br/> - 지분증권합계인 매수 및 매도를 기준으로 최근 1년간 지분증권 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">2</td>
	<td align="left">채무증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 채무증권<br/> - 채무증권합계인 매수 및 매도를 기준으로 최근 1년간 채무증권 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">3</td>
	<td align="left">집합투자증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 집합투자증권인 매수 및 매도를 기준으로 최근 1년간 집합투자증권 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 <br/>
	</td>
</tr>
<tr><td align="center">4</td>
	<td align="left">투자계약증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 투자계약증권인 매수 및 매도를 기준으로 최근 1년간 투자계약증권 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 <br/>
	</td>
</tr>
<tr><td align="center">5</td>
	<td align="left">파생결합증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 파생결합증권 <br/>- 파생결합증권합계인 매수 및 매도를 기준으로 최근 1년간 파생결합증권 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">6</td>
	<td align="left">외화증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 외화증권인 매수 및 매도를 기준으로 최근 1년간 외화증권 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">7</td>
	<td align="left">기타증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 기타증권인 매수 및 매도를 기준으로 최근 1년간 기타증권 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">8-1</td>
	<td align="left">파생상품 - 선물(국내) </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 선물 - 국내인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">8-2</td>
	<td align="left">파생상품 - 선물(해외) </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 선물 - 해외인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">8-3</td>
	<td align="left">파생상품 - 옵션/장내(국내) </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 옵션 - 장내 - 국내인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">8-4</td>
	<td align="left">파생상품 - 옵션/장내(해외) </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 옵션 - 장내 - 해외인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">8-5</td>
	<td align="left">파생상품 - 옵션/장외(국내) </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 옵션 - 장외 - 국내인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 
	</td>
</tr>
<tr><td align="center">8-6</td>
	<td align="left">파생상품 - 옵션/장외(해외) </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 옵션 - 장외 - 해외인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>
<tr><td align="center">8-7</td>
	<td align="left">파생상품 - 선도(국내) </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 선도 - 국내인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>

<tr><td align="center">8-8</td>
	<td align="left">파생상품 - 선도(해외) </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 선도 - 해외인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>

<tr><td align="center">8-9</td>
	<td align="left">기타 파생상품 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 보고서의 구분이 기타 파생상품인 매수 및 매도를 기준으로 최근 1년간 총 매수 금액 및 총 매도 금액을 기입<br/>
★ 최근 1년을 기준으로 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 당월 총 매수 금액 + 2015.8 당월 총 매수 금액 +…….+ 2016.6 당월 총 매수금액 </td>
</tr>

<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 : 최근 1년 (2015.07~2016.06) 기준<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '금융투자상품의 위탁매매 및 수수료 현황표(GA054)' 기준으로 함<br/>
2) 최근 1년간 매수 및 매도 금액 총 합산을 결과값으로 입력  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="3"><strong>투자자문 계약 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">투자자문 고객수</td>
	<td align="center">명</td>
	<td align="center"></td>
	<td align="left">'투자자문 계약현황(GA179)' 보고서의 구분이 고객수를 기준으로 최근 1년간 투자자문 고객수의 합<br/>
★ 최근 1년간 총 투자자문 고객 수 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 당월 투자자문 고객 수 + 2015.8 당월 투자자문 고객수 + ….. + 2016.6 월 당월 투자자문 고객 수</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">투자자문 계약건수</td>
	<td align="center">건</td>
	<td align="center"></td>
	<td align="left">'
'투자자문 계약현황(GA179)' 보고서의 구분이 자문계약건수를 기준으로 최근 1년간 투자자문 계약건수의 합<br/>
★ 최근 1년간 총 투자자문 계약건수 ( 2015.7 ~2016.6 ) <br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 당월 투자자문 계약건수 + 2015.8 당월 투자자문 계약건수 + … + 2016.6 월 당월 투자자문 계약건수</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">투자자문 계약자산총액</td>
	<td align="center">백만원</td>
	<td align="center"></td>
	<td align="left">'투자자문 계약현황(GA179)' 보고서의 구분이 자문계약자산총액을 기준으로 최근 1년간 투자자문 계약자산 총액<br/>
★ 최근 1년간 총 투자자문 계약자산총액 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 당월 투자자문 계약자산총액 + 2015.8 당월 투자자문 계약자산총액 + … + 2016.6 당월 투자자문 계약자산총액</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07~2016.06) 기준<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '투자자문 계약현황(GA179)' 기준으로 함<br/>
2) 최근 1년간 고객수, 계약건수 및 금액 총 합산을 결과값으로 입력  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스 특성</strong></td>
	<td align="center" colspan="3"><strong>투자일임 계약현황</strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center" >1</td>
	<td align="left" >투자일임 고객수</td>
	<td align="center" >명</td>
	<td align="center" ></td>
	<td align="left" >'투자일임계약 현황(GA186)' 보고서의 구분이 고객수를 기준으로 최근 1년간 투자일임 고객수의 합<br/>
★ 최근 1년간 총 투자일임 고객 수 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 당월 투자일임 고객 수 + 2015.8 당월 투자일임 고객수 + ….. + 2016.6 월 당월 투자일임 고객 수</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">투자일임 계약건수</td>
	<td align="center">건</td>
	<td align="center" ></td>
	<td align="left">'투자일임계약 현황(GA186)' 보고서의 구분이 일임계약건수를 기준으로 최근 1년간 투자일임 계약건수의 합<br/>
★ 최근 1년간 총 투자일임 계약건수 ( 2015.7 ~2016.6 ) <br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 당월 투자일임 계약건수 + 2015.8 당월 투자일임 계약건수 + … + 2016.6 월 당월 투자일임 계약건수</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">투자일임 계약자산총액(계약금액)</td>
	<td align="center">백만원</td>
	<td align="center" ></td>
	<td align="left">'투자일임계약 현황(GA186)' 보고서의 구분이 일임계약자산총액 (계약금액) 을 기준으로 최근 1년간 투자일임 계약자산 총액<br/>
★ 최근 1년간 총 투자일임 계약자산총액 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 당월 투자일임 계약자산총액 (계약금액) + 2015.8 당월 투자일임 계약자산총액 (계약금액) + … + 2016.6 월 당월 투자자문 계약자산총액 (계약금액)<br/>
	</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07~2016.06) 기준<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '투자일임 계약현황(GA180)' 기준으로 함<br/>
2) 최근 1년간 고객수, 계약건수 및 금액 총 합산을 결과값으로 입력  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="3"><strong>투기목적 장외파생상품 거래 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>거래 현황 </strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>거래 건수 </strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>금액 (백만원)</strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">파생결합증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'거래목적별 장외파생상품 매매실적(GA071)' 보고서의 구분이 파생결합증권_소계 (ELS + ELW + 기타)인 투기 거래수 및 금액을 기준으로 최근 1년간 파생결합증권 거래건수 및 금액<br/>
★ 최근 1년간 파생결합증권의 총 거래건수 및 금액 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 파생결합증권 총 거래건수 + 2015.8 월 당월 파생결합증권 총 거래건수 + …. + 2016.6 월 당월 파생결합증권 총 거래건수  </td>
</tr>
<tr><td align="center">2</td>
	<td align="left">선도 거래 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'거래목적별 장외파생상품 매매실적(GA071)' 보고서의 구분이 선도인 투기 거래수 및 금액을 기준으로 최근 1년간 선도 거래건수 및 금액<br/>
★ 최근 1년간 선도거래의 총 거래건수 및 금액 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 선도거래 총 거래건수 + 2015.8 월 당월 선도거래 총 거래건수 + …. + 2016.6 월 당월 선도거래 총 거래건수 </td>
</tr>
<tr><td align="center">3</td>
	<td align="left">옵션 거래 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'거래목적별 장외파생상품 매매실적(GA071)' 보고서의 구분이 옵션인 투기 거래수 및 금액을 기준으로 최근 1년간 옵션 거래건수 및 금액<br/>
★ 최근 1년간 옵션거래의 총 거래건수 및 금액 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 옵션거래 총 거래건수 + 2015.8 월 당월 옵션거래 총 거래건수 + …. + 2016.6 월 당월 옵션거래 총 거래건수 </td>
</tr>
<tr><td align="center">4</td>
	<td align="left">스왑 거래  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'거래목적별 장외파생상품 매매실적(GA071)' 보고서의 구분이 스왑인 투기 거래수 및 금액을 기준으로 최근 1년간 스왑 거래건수 및 금액<br/>
★ 최근 1년간 스왑거래의 총 거래건수 및 금액 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 스왑거래 총 거래건수 + 2015.8 월 당월 스왑거래 총 거래건수 + …. + 2016.6 월 당월 스왑거래 총 거래건수 </td>
</tr>
<tr><td align="center">5</td>
	<td align="left">기타 거래  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'거래목적별 장외파생상품 매매실적(GA071)' 보고서의 구분이 기타인 투기 거래수 및 금액을 기준으로 최근 1년간 기타 거래건수 및 금액<br/>
★ 최근 1년간 기타거래의 총 거래건수 및 금액 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 기타거래 총 거래건수 + 2015.8 월 당월 기타거래 총 거래건수 + …. + 2016.6 월 당월 기타거래 총 거래건수 </td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 : 최근 1년 (2015.07~2016.06) 기준<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '거래목적별 장외파생상품 매매실적(GA071)' 기준으로 함<br/>
2) 최근 1년간 자문 건수 및 금액 총 합산을 결과값으로 입력  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스 특성</strong></td>
	<td align="center" colspan="3"><strong>투자자 유형별 자문 수수료 수입 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center" >1</td>
	<td align="left" >일반투자자 자문수수료</td>
	<td align="center" >백만원</td>
	<td align="center" ></td>
	<td align="left" >'
'자문수수료 수입 현황(GA180)' 보고서의 구분이 자문수수료_일반투자자를 기준으로 최근 1년간 일반투자자 자문수수료 금액 <br/>
★ 최근 1년간 일반투자자 자문수수료 총 합산 금액<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 일반투자자 자문수수료 금액 + 2015.8 월 당월 일반투자자 자문수수료 금액 + …. + 2016.6 월 당월 일반투자자 자문수수료 금액</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">전문투자자 자문수수료</td>
	<td align="center">백만원</td>
	<td align="center" ></td>
	<td align="left">'자문수수료 수입 현황(GA180)' 보고서의 구분이 자문수수료_전문투자자를 기준으로 최근 1년간 전문투자자 자문수수료 금액<br/> 
★ 최근 1년간 전문투자자 자문수수료 총 합산 금액<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 전문투자자 자문수수료 금액 + 2015.8 월 당월 전문투자자 자문수수료 금액 + …. + 2016.6 월 당월 전문투자자 자문수수료 금액	</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">일반투자자 기타수수료</td>
	<td align="center">백만원</td>
	<td align="center" ></td>
	<td align="left">'자문수수료 수입 현황(GA180)' 보고서의 구분이 기타수수료_일반투자자를 기준으로 최근 1년간 일반투자자 기타수수료 금액<br/> 
★ 최근 1년간 일반투자자 기타수수료 총 합산 금액<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 일반투자자 기타수수료 금액 + 2015.8 월 당월 일반투자자 기타수수료 금액 + …. + 2016.6 월 당월 기타투자자 자문수수료 금액	</td>
</tr>
<tr><td align="center">4</td>
	<td align="left">전문투자자 기타수수료</td>
	<td align="center">백만원</td>
	<td align="center" ></td>
	<td align="left">'자문수수료 수입 현황(GA180)' 보고서의 구분이 기타수수료_전문투자자를 기준으로 최근 1년간 전문투자자 기타수수료 금액<br/> 
★ 최근 1년간 전문투자자 기타수수료 총 합산 금액<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 전문투자자 기타수수료 금액 + 2015.8 월 당월 전문투자자 기타수수료 금액 + …. + 2016.6 월 당월 전문투자자 기타수수료 금액</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07~2016.06) 기준<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '자문수수료 수입 현황(GA180)' 기준으로 함<br/>
2) 최근 1년간 자문 수수료 총 합산을 결과값으로 입력  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스 특성</strong></td>
	<td align="center" colspan="3"><strong>현금거래 규모 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center" >1</td>
	<td align="left" >현금거래 고객수</td>
	<td align="center" >명</td>
	<td align="center" ></td>
	<td align="left" rowspan="3">1. 데이터 산출 기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>
2. 데이터 설명<br/>
1) CTR 보고서를 위한 현금거래 식별기준과 동일하게 적용 (2,000만원 이상이라는 조건에 관계없이<br/>
 CTR 보고서 작성을 위해 추출하는 거래코드로 발생하는 모든 거래 대상)<br/>
2) 월평균 거래고객수로 산정 = (월별 거래고객수 합계)/12<br/>
→ 한고객이 매월 거래를 발생시켰다면 매월 고객수에 (중복적으로) 포함<br/>
3) 월평균 거래건수로 산정 = (동 기간동안 총거래건수 합계)/12<br/>
4) 월평균 거래금액으로 산정 = (동 기간동안 총거래금액 합계)/12</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">현금거래 건수</td>
	<td align="center">건</td>
	<td align="center" ></td>
</tr>
<tr><td align="center">3</td>
	<td align="left">현금거래 거래금액</td>
	<td align="center">백만원</td>
	<td align="center" ></td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="3"><strong>주식매매 거래 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>거래 현황 (금액)</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매수 (백만원) </strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매도 (백만원) </strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">유가증권시장 매수 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'주식매매 거래실적(GA058)' 보고서의 구분이 주식 - 유가증권시장인 매수 및 매도를 기준으로 최근 1년간 유가증권시장 매수 및 매도 금액<br/>
★ 최근 1년간 유가증권시장 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 유가증권시장 총 매수 금액 + 2015.8 월 당월 유가증권시장 총 매수 금액 + …. + 2016.6 월 당월 유가증권시장 총 매수 금액 </td>
</tr>
<tr><td align="center">2</td>
	<td align="left">채무증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'주식매매 거래실적(GA058)' 보고서의 구분이 주식 - 코스닥시장인 매수 및 매도를 기준으로 최근 1년간 코스닥시장 매수 및 매도 금액<br/>
★ 최근 1년간 코스닥시장 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 코스닥시장 총 매수 금액 + 2015.8 월 당월 코스닥시장 총 매수 금액 + …. + 2016.6 월 당월 코스닥시장 총 매수 금액 </td>
</tr>
<tr><td align="center">3</td>
	<td align="left">해외시장 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'주식매매 거래실적(GA058)' 보고서의 구분이 주식 - 해외시장인 매수 및 매도를 기준으로 최근 1년간 해외시장 매수 및 매도 금액 <br/>
★ 최근 1년간 해외시장 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 ) <br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외) <br/>
예시 ) 2015.7 월 당월 해외시장 총 매수 금액 + 2015.8 월 당월 해외시장 총 매수 금액 + …. + 2016.6 월 당월 해외시장 총 매수 금액함 <br/> </td>
</tr>
<tr><td align="center">4</td>
	<td align="left">기타 (유가증권, 코스닥, 해외시장이외에서의 거래)   </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'주식매매 거래실적(GA058)' 보고서의 구분이 주식 - 기타인 매수 및 매도를 기준으로 최근 1년간 기타 매수 및 매도 금액 <br/>
★ 최근 1년간 기타 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 ) <br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외) <br/>
예시 ) 2015.7 월 당월 기타 총 매수 금액 + 2015.8 월 당월 기타 총 매수 금액 + …. + 2016.6 월 당월 기타 총 매수 금액 <br/>
※ 주식-기타 : 유가증권시장, 코스닥시장 및 해외시장이외</td>
</tr>
<tr><td align="center">5</td>
	<td align="left">기타 (신주인수권증서 등)  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'주식매매 거래실적(GA058)' 보고서의 구분이 기타인 매수 및 매도를 기준으로 최근 1년간 기타 매수 및 매도 금액<br/>
★ 최근 1년간 기타 매수 및 매도 금액 합산 ( 2015.7 ~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 기타 총 매수 금액 + 2015.8 월 당월 기타 총 매수 금액 + …. + 2016.6 월 당월 기타 총 매수 금액<br/>
※ 구분-기타 : 신주인수권증서 등</td>
</tr>

<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07~ 2016.06)<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '주식매매 거래실적(GA058)' 기준으로 함<br/>
2) 최근 1년기준으로 총 매수 및 매도 금액을 합산함  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="3"><strong>장외파생상품 매매 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>매매 현황 (금액)</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매수 (백만원) </strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매도 (백만원) </strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">파생결합증권</td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'총괄(GA070)' 보고서의 구분이 파생결합증권_소계인 매수 및 매도를 기준으로 최근 1년간 파생결합증권의 매수 및 매도 금액<br/>
★ 최근 1년간 파생결합증권의 총 매수 및 매도 금액의 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7월 당월 파생결합증권의 총 매수 금액 + …. + 2016.6 당월 파생결합증권의 총 매수금액  </td>
</tr>
<tr><td align="center">2</td>
	<td align="left">선도 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'총괄(GA070)' 보고서의 구분이 선도인 매수 및 매도를 기준으로 최근 1년간 선도의 매수 및 매도 금액<br/>
★ 최근 1년간 선도의 총 매수 및 매도 금액의 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7월 당월 선도의 총 매수 금액 + …. + 2016.6 당월 선도의 총 매수금액 </td>
</tr>
<tr><td align="center">3</td>
	<td align="left">옵션 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'총괄(GA070)' 보고서의 구분이 옵션인 매수 및 매도를 기준으로 최근 1년간 옵션의 매수 및 매도 금액 <br/>
★ 최근 1년간 옵션의 총 매수 및 매도 금액의 합산 <br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외) <br/>
예시) 2015.7월 당월 옵션의 총 매수 금액 + …. + 2016.6 당월 옵션의 총 매수금액 </td>
</tr>
<tr><td align="center">4</td>
	<td align="left">스왑</td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'총괄(GA070)' 보고서의 구분이 스왑인 매수 및 매도를 기준으로 최근 1년간 스왑의 매수 및 매도 금액<br/>
★ 최근 1년간 스왑의 총 매수 및 매도 금액의 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7월 당월 스왑의 총 매수 금액 + …. + 2016.6 당월 스왑의 총 매수금액</td>
</tr>
<tr><td align="center">5</td>
	<td align="left">기타</td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'총괄(GA070)' 보고서의 구분이 기타인 매수 및 매도를 기준으로 최근 1년간 기타의 매수 및 매도 금액<br/>
★ 최근 1년간 기타의 총 매수 및 매도 금액의 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7월 당월 기타의 총 매수 금액 + …. + 2016.6 당월 기타의 총 매수금액 </td>
</tr>

<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07~ 2016.06)<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '총괄(GA070)' 기준으로 함<br/>
2) 최근 1년기준으로 총 매수 및 매도 금액을 합산함  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="7" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="8" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="7"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="8"><strong>집합투자증권 수익자별 판매현황</strong></td>
</tr>

<tr><td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>구분</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>투자신탁 <br/>(백만원)</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>투자회사<br/> (백만원)</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>투자유한회사<br/> (백만원)</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>투자합자회사<br/> (백만원)</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>투자 (백만원)</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>투자익명조합 <br/>(백만원)</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>공모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>사모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>공모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>사모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>공모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>사모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>공모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>사모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>공모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>사모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>공모</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>사모</strong></td>
</tr>
<tr>
	<td align="center" colspan="1">1</td>
	<td align="left" colspan="1">개인- 증권집합투자기구 소계</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 개인_증권집합투자기구_소계인 항목 금액 <br> 
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">2</td>
	<td align="left" colspan="1">개인- 부동산집합투자기구 소계</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 개인_부동산집합투자기구_소계인 항목 금액  <br>
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">3</td>
	<td align="left" colspan="1">개인- 특별자산집합투자기구 소계</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 개인_특별자산집합투자기구_소계인 항목 금액 <br>
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">4</td>
	<td align="left" colspan="1">개인- 혼합자산집합투자기구 소계</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 개인_혼합자산집합투자기구_소계인 항목 금액 <br>
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">5</td>
	<td align="left" colspan="1">개인 - 단기금융집합투자기구</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 개인_단기금융집합투자기구인 항목 금액 <br>
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">6</td>
	<td align="left" colspan="1">일반법인 - 증권집합투자기구 소계</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 일반법인_증권집합투자기구_소계인 항목 금액 <br>
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">7</td>
	<td align="left" colspan="1">일반법인 - 부동산집합투자기구 소계</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 일반법인_부동산집합투자기구_소계인 항목 금액 <br>
★ 최근 1년기준으로 월보고 결과값 합산필요<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">8</td>
	<td align="left" colspan="1">일반법인 - 특별자산집합투자기구 소계</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 일반법인_특별자산집합투자기구_소계인 항목 금액 <br>
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">9</td>
	<td align="left" colspan="1">일반법인 - 혼합자산집합투자기구 소계</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 일반법인_혼합자산집합투자기구_소계인 항목 금액 <br>
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="1">10</td>
	<td align="left" colspan="1">일반법인 - 단기금융집합투자기구</td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="center" colspan="1"></td>
	<td align="left" colspan="1">'수익자별 판매 현황(GA160)' 보고서의 구분이 <br> 일반법인_단기금융집합투자기구_소계인 항목 금액 <br>
★ 최근 1년기준으로 월보고 결과값 합산<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr>
	<td align="center" colspan="2">결과값 산출기준 (공통)</td>
	<td align="left" colspan="13">1. 데이터 산출기준 :  최근 1년 (2015.07 ~ 2016.06)<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '수익자별 판매 현황(GA160)' 기준으로 함<br/>
2) 최근 1년기준으로 월보고 합산  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="3"><strong>장내파생상품을 헤지하기 위한 금융투자상품 매매거래 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>매매거래 현황 </strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매수 (백만원) </strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매도 (백만원) </strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">증권 - 지분증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 증권_지분증권_소계인<br/> 매수 및 매도를 기준으로 최근 1년간 지분증권 매수 및 매도 금액 <br/>
★ 최근 1년간 지분증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 지분증권 총 매수 금액 + ….. + 2016.6월 당월 지분증권 총 매수 금액</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">증권 - 채무증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 증권_채무증권_소계인<br/> 매수 및 매도를 기준으로 최근 1년간 채무증권 매수 및 매도 금액<br/> 
★ 최근 1년간 채무증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 채무증권 총 매수 금액 + ….. + 2016.6월 당월 채무증권 총 매수 금액</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">집합투자증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 집합투자증권인 <br/> 매수 및 매도를 기준으로 최근 1년간 집합투자증권 매수 및 매도 금액<br/> 
★ 최근 1년간 집합투자증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 집합투자증권 총 매수 금액 + ….. + 2016.6월 당월 집합투자증권 총 매수 금액	</td>
</tr>
<tr><td align="center">4</td>
	<td align="left">투자계약증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 투자계약증권인 <br/> 매수 및 매도를 기준으로 최근 1년간 투자계약증권 매수 및 매도 금액 <br/> 
★ 최근 1년간 투자계약증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 ) <br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외) <br/>
예시) 2015.7 월 당월 투자계약증권 총 매수 금액 + ….. + 2016.6월 당월 투자계약증권 총 매수 금액</td>
</tr>
<tr><td align="center">5</td>
	<td align="left">증권예탁증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 증권예탁증권인<br/> 매수 및 매도를 기준으로 최근 1년간 증권예탁증권 매수 및 매도 금액 <br/>
★ 최근 1년간 증권예탁증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 증권예탁증권 총 매수 금액 + ….. + 2016.6월 당월 증권예탁증권 총 매수 금액</td>
</tr>
<tr><td align="center">6</td>
	<td align="left">외화증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 외화증권인<br/> 매수 및 매도를 기준으로 최근 1년간 외화증권 매수 및 매도 금액<br/> 
★ 최근 1년간 외화증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 외화증권 총 매수 금액 + ….. + 2016.6월 당월 외화증권 총 매수 금액</td>
</tr>
<tr><td align="center">7</td>
	<td align="left">기타증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 기타증권인<br/> 매수 및 매도를 기준으로 최근 1년간 기타증권 매수 및 매도 금액<br/> 
★ 최근 1년간 기타증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 기타증권 총 매수 금액 + ….. + 2016.6월 당월 기타증권 총 매수 금액</td>
</tr>
<tr><td align="center">8</td>
	<td align="left">선물 - 국내 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA06)' 보고서의 구분이 선물_국내_국내계인<br/> 매수 및 매도를 기준으로 최근 1년간 선물 국내 매수 및 매도 금액<br/> 
★ 최근 1년간 선물 국내 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 선물 국내 총 매수 금액 + ….. + 2016.6월 당월 선물 국내 총 매수 금액</td>
</tr>
<tr><td align="center">9</td>
	<td align="left">선물 - 해외 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 선물_해외_해외계인<br/> 매수 및 매도를 기준으로 최근 1년간 선물 해외 매수 및 매도 금액<br/> 
★ 최근 1년간 선물 해외 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 선물 해외 총 매수 금액 + ….. + 2016.6월 당월 선물 해외 총 매수 금액 </td>
</tr>
<tr><td align="center">10</td>
	<td align="left">옵션 - 국내  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 옵션_국내_국내계인<br/> 매수 및 매도를 기준으로 최근 1년간 옵션 국내 매수 및 매도 금액<br/> 
★ 최근 1년간 옵션 국내 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 옵션 국내 총 매수 금액 + ….. + 2016.6월 당월 옵션 국내 총 매수 금액 </td>
</tr>
<tr><td align="center">11</td>
	<td align="left">옵션 - 해외 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 옵션_해외_해외계인 <br/>매수 및 매도를 기준으로 최근 1년간 옵션 해외 매수 및 매도 금액<br/> 
★ 최근 1년간 옵션 해외 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 옵션 해외 총 매수 금액 + ….. + 2016.6월 당월 옵션 해외 총 매수 금액 </td>
</tr>
<tr><td align="center">12</td>
	<td align="left">기타</td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 보고서의 구분이 기타_기타계인<br/> 매수 및 매도를 기준으로 최근 1년간 기타 매수 및 매도 금액<br/> 
★ 최근 1년간 기타 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 기타 총 매수 금액 + ….. + 2016.6월 당월 기타 총 매수 금액	</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :   최근 1년 (2015.07 ~ 2016.06)<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '장내파생상품을 헤지하기 위한 금융투자상품 매매거래 실적(GA067)' 기준으로 함<br/>
2) 최근 1년기준으로 총 매수 및 매도 금액을 합산함  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스특성</strong></td>
	<td align="center" colspan="3"><strong>장외파생상품을 헤지하기 위한 금융투자상품 매매거래 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>매매거래 현황 </strong></td>
	<td align="center" colspan="1" rowspan ="2" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매수 (백만원) </strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>매도 (백만원) </strong></td>
</tr>
<tr><td align="center">1</td>
	<td align="left">증권 - 지분증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 증권_지분증권_소계인<br/> 매수 및 매도를 기준으로 최근 1년간 지분증권 매수 및 매도 금액<br/> 
★ 최근 1년간 지분증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 지분증권 총 매수 금액 + ….. + 2016.6월 당월 지분증권 총 매수 금액</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">증권 - 채무증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 증권_채무증권_소계인<br/> 매수 및 매도를 기준으로 최근 1년간 채무증권 매수 및 매도 금액<br/> 
★ 최근 1년간 채무증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 채무증권 총 매수 금액 + ….. + 2016.6월 당월 채무증권 총 매수 금액</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">집합투자증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 집합투자증권인<br/> 매수 및 매도를 기준으로 최근 1년간 집합투자증권 매수 및 매도 금액<br/> 
★ 최근 1년간 집합투자증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 집합투자증권 총 매수 금액 + ….. + 2016.6월 당월 집합투자증권 총 매수 금액</td>
</tr>
<tr><td align="center">4</td>
	<td align="left">투자계약증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 투자계약증권인<br/> 매수 및 매도를 기준으로 최근 1년간 투자계약증권 매수 및 매도 금액<br/> 
★ 최근 1년간 투자계약증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 투자계약증권 총 매수 금액 + ….. + 2016.6월 당월 투자계약증권 총 매수 금액</td>
</tr>
<tr><td align="center">5</td>
	<td align="left">증권예탁증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 증권예탁증권인<br/> 매수 및 매도를 기준으로 최근 1년간 증권예탁증권 매수 및 매도 금액<br/> 
★ 최근 1년간 증권예탁증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 증권예탁증권 총 매수 금액 + ….. + 2016.6월 당월 증권예탁증권 총 매수 금액</td>
</tr>
<tr><td align="center">6</td>
	<td align="left">외화증권  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 외화증권인<br/> 매수 및 매도를 기준으로 최근 1년간 외화증권 매수 및 매도 금액<br/> 
★ 최근 1년간 외화증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 외화증권 총 매수 금액 + ….. + 2016.6월 당월 외화증권 총 매수 금액</td>
</tr>
<tr><td align="center">7</td>
	<td align="left">기타증권 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 금융투자상품 실적(GA072)' 보고서의 구분이 기타증권인<br/> 매수 및 매도를 기준으로 최근 1년간 기타증권 매수 및 매도 금액<br/> 
★ 최근 1년간 기타증권 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 기타증권 총 매수 금액 + ….. + 2016.6월 당월 기타증권 총 매수 금액</td>
</tr>
<tr><td align="center">8</td>
	<td align="left">선물 - 국내 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 선물_국내_국내계인<br/> 매수 및 매도를 기준으로 최근 1년간 선물 국내 매수 및 매도 금액<br/> 
★ 최근 1년간 선물 국내 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 선물 국내 총 매수 금액 + ….. + 2016.6월 당월 선물 국내 총 매수 금액</td>
</tr>
<tr><td align="center">9</td>
	<td align="left">선물 - 해외 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 선물_해외_해외계인<br/> 매수 및 매도를 기준으로 최근 1년간 선물 해외 매수 및 매도 금액<br/> 
★ 최근 1년간 선물 해외 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 선물 해외 총 매수 금액 + ….. + 2016.6월 당월 선물 해외 총 매수 금액</td>
</tr>
<tr><td align="center">10</td>
	<td align="left">옵션 - 국내  </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 옵션_국내_국내계인<br/> 매수 및 매도를 기준으로 최근 1년간 옵션 국내 매수 및 매도 금액<br/> 
★ 최근 1년간 옵션 국내 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 옵션 국내 총 매수 금액 + ….. + 2016.6월 당월 옵션 국내 총 매수 금액 </td>
</tr>
<tr><td align="center">11</td>
	<td align="left">옵션 - 해외 </td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 옵션_해외_해외계인<br/> 매수 및 매도를 기준으로 최근 1년간 옵션 해외 매수 및 매도 금액<br/> 
★ 최근 1년간 옵션 해외 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 옵션 해외 총 매수 금액 + ….. + 2016.6월 당월 옵션 해외 총 매수 금액 </td>
</tr>
<tr><td align="center">12</td>
	<td align="left">기타</td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="left">'장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 보고서의 구분이 기타_기타계인<br/> 매수 및 매도를 기준으로 최근 1년간 기타 매수 및 매도 금액<br/> 
★ 최근 1년간 기타 매수 및 매도 총 합산 금액 ( 2015.7~ 2016.6 )<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시) 2015.7 월 당월 기타 총 매수 금액 + ….. + 2016.6월 당월 기타 총 매수 금액	</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07 ~ 2016.06)<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '장외파생상품을 헤지하기 위한 매매거래 실적(GA072)' 기준으로 함<br/>
2) 최근 1년기준으로 총 매수 및 매도 금액을 합산함  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>상품 및 서비스 특성</strong></td>
	<td align="center" colspan="3"><strong>투자자 유형별 일임 수수료 수입 현황</strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align="center" >1</td>
	<td align="left" >일반투자자 일임수수료</td>
	<td align="center" >백만원</td>
	<td align="center" ></td>
	<td align="left" >'일임수수료 수입 현황(GA187)' 보고서의 구분이 일임수수료_일반투자자를 기준으로 <br/>최근 1년간 일반투자자 일임수수료 금액 
★ 최근 1년간 일반투자자 일임수수료 총 합산 금액 (2015.7~2016.6)<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 일임투자자 자문수수료 금액 + 2015.8 월 당월 일반투자자 일임수수료 금액 + …. <br/>+ 2016.6 월 당월 일임투자자 자문수수료 금액</td>
</tr>
<tr><td align="center">2</td>
	<td align="left">전문투자자 일임수수료</td>
	<td align="center">백만원</td>
	<td align="center" ></td>
	<td align="left">'일임수수료 수입 현황(GA187)' 보고서의 구분이 일임수수료_전문투자자를 기준으로<br/> <br/>최근 1년간 전문투자자 일임수수료 금액 
★ 최근 1년간 전문투자자 일임수수료 총 합산 금액 (2015.7~2016.6)<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 일반투자자 자문수수료 금액 + 2015.8 월 당월 일반투자자 자문수수료 금액 + …. <br/>+ 2016.6 월 당월 일반투자자 자문수수료 금액</td>
</tr>
<tr><td align="center">3</td>
	<td align="left">일반투자자 기타수수료</td>
	<td align="center">백만원</td>
	<td align="center" ></td>
	<td align="left">'일임수수료 수입 현황(GA187)' 보고서의 구분이 기타수수료_일반투자자를 기준으로<br/> 최근 1년간 일반투자자 기타수수료 금액 
★ 최근 1년간 일반투자자 기타수수료 총 합산 금액 (2015.7~2016.6)<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 일반투자자 기타수수료 금액 + 2015.8 월 당월 일반투자자 기타수수료 금액 + …. <br/>+ 2016.6 월 당월 일반투자자 기타수수료 금액
	</td>
</tr>
<tr><td align="center">4</td>
	<td align="left">전문투자자 기타수수료</td>
	<td align="center">백만원</td>
	<td align="center" ></td>
	<td align="left">'일임수수료 수입 현황(GA187)' 보고서의 구분이 기타수수료_전문투자자를 기준으로<br/> 최근 1년간 전문투자자 기타수수료 금액 
★ 최근 1년간 전문투자자 기타수수료 총 합산 금액 (2015.7~2016.6)<br/>
★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)<br/>
예시 ) 2015.7 월 당월 전문투자자 기타수수료 금액 + 2015.8 월 당월 전문투자자 자문수수료 금액 + …. <br/>+ 2016.6 월 당월 전문투자자 자문수수료 금액</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 1년 (2015.07 ~ 2016.06)<br/>
2. 데이터 설명<br/>
1) 금융감독원 업무보고서 '자문수수료 수입 현황(GA187)' 기준으로 함<br/>
2) 최근 1년간 수수료 총 합산을 결과값으로 입력  (누적/중복 값 제외)</td>
</tr>
</table>
<br/><br/>
</div>
</div>
		<div class="cond-btn-row" style="text-align:right">
			 	${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"closeBtn", closeBtn:"닫기", mode:"R", function:"self.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
		</div>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />