<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_10_02_02.jsp
- Comment    : 고유위험 지표 상세 정의_회사특성
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
<div style="overflow:scroll; width:98vw; height:80vh;">
<div class="table-box11">
<table>
<tr><td align="center" colspan="2" bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="2" bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>회사특성</strong></td>
	<td align="center" colspan="2"><strong>경영리스크현황</strong></td>
</tr>

<tr><td align="center" colspan="1" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" colspan="1" bgcolor="#E0ECF8"><strong>결과값산정기준</strong></td>
</tr>
<tr><td align="center" >1</td>
	<td align="center" >3년간 금융사고 발생금액</td>
	<td align="center" >백만원</td>
	<td align="left" >"사고발생비율 중(GA039)" 보고서의 구분이 금융사고발생금액을 기준으로 최근 3년간 금융사고 발생 금액<br/>
								★ 최근 3년간 금융사고 발생 금액 총 합산 (2013.7.01 ~ 2016.6.30)<br/>
								★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr><td align="center">2</td>
	<td align="center">5년간 기관 및 임직원 제재 건수</td>
	<td align="center">건</td>
	<td align="left">"기관 및 임직원 제재현황(GA145)" 보고서의 제재내용 건수를 기준으로 최근 5년간 기관 및 임직원 제재 건수<br/>
								     ★ 최근 5년간 기관 및 임직원 제재 건수 총 합산 (2011.7.01~ 2016.6.30)<br/>
							 	     ★ 월(분기별)별 발생분의 합산 (누적/중복 값 제외)</td>
</tr>
<tr><td align="center">3</td>
	<td align="center">해외투자 건수</td>
	<td align="center">건</td>
	<td align="left">"해외투자 현황(GA237)" 보고서의 건수 입력</td>
</tr>
<tr><td align="center" colspan="1">결과값 산출기준 (공통)</td>
	<td align="left" colspan="4">1. 데이터 산출기준 :  최근 5년, 3년, 1년으로 구분<br/>
											2. 데이터 설명<br/>
											1) 금융감독원 업무보고서 '사고발생비율(GA039), 기관 및 임직원 제재현황(GA145), 해외투자 현황(GA237)'을 기준으로 함<br/>
											2) 각 데이터 기간을 기준으로 금액 및 건수 총 합산  (누적/중복 값 제외)<br/></td>
</tr>
</table>
<br><br>
</div>
</div>
		<div class="cond-btn-row" style="text-align:right">
			 	${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"closeBtn", closeBtn:"닫기", mode:"R", function:"self.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
		</div>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />