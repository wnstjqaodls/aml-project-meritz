<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_10_02_06.jsp
- Comment    : 고유위험 지표 상세 정의_채널특성
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
<tr><td align="center" colspan=2 bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan=3 bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan=2><strong>채널특성</strong></td>
	<td align="center" colspan=3><strong>인원 및 점포 현황</strong></td></tr>
<tr>
	<td align="center" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>임직원수</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>결과값 산출기준</strong></td>
</tr>
<tr><td align=center>1</td>
 <td align=left>본부부서 임직원수</td>
 <td align=center>명</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 본부부서인 인원수를 기입함"</td>
</tr>
<tr><td align=center>2</td>
 <td align=left>국내지점 임직원수</td>
 <td align=center>명</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 국내지점인 인원수를 기입함"</td>
</tr>
<tr><td align=center>3</td>
 <td align=left>국내영업소 임직원수 </td>
 <td align=center>명</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 국내지점인 인원수를 기입함"</td>
</tr>
<tr><td align=center>4</td>
 <td align=left>해외지점 임직원수</td>
 <td align=center>명</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 해외지점인 인원수를 기입함"</td>
</tr>
<tr><td align=center>5</td>
 <td align=left>해외사무소 임직원수 </td>
 <td align=center>명</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 해외사무소인 인원수를 기입함"</td>
</tr>
<tr><td align=center>6</td>
 <td align=left>해외현지법인 임직원수</td>
 <td align=center>명</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 국내지점인 인원수를 기입함"</td>
</tr>
<tr><td align=center>7</td>
 <td align=left>본부부서 부서수</td>
 <td align=center>개</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 본부부서인 부서수를 기입함"</td>
</tr>
<tr><td align=center>8</td>
 <td align=left>국내지점 부서수</td>
 <td align=center>개</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 국내지점인 부서수를 기입함"</td>
</tr>
<tr><td align=center>9</td>
 <td align=left>국내영업소 부서수</td>
 <td align=center>개</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 국내영업소인 부서수를 기입함"</td>
</tr>
<tr><td align=center>10</td>
 <td align=left>해외지점 부서수</td>
 <td align=center>개</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 해외지점인 부서수를 기입함"</td>
</tr>
<tr><td align=center>11</td>
 <td align=left>해외사무소 부서수</td>
 <td align=center>개</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 해외사무소인 부서수를 기입함"</td>
</tr>
<tr><td align=center>12</td>
 <td align=left>해외현지법인 부서수</td>
 <td align=center>개</td>
 <td></td>
 <td align=left>"조직기구 현황(GA140)" 보고서의 구분이 해외현지법인인 부서수를 기입함"</td>
</tr>
<tr><td align=center>13</td>
 <td align=left>퇴직임직원수</td>
 <td align=center>명</td>
 <td></td>
 <td align=left>1) 최근 1년 (2015.07.01 ~ 2016.06.30) 임직원 퇴직자 수 (정년퇴직자 제외)</td>
</tr>
<tr><td align=center>결과값 산출기준(공통)</td>
 <td align=left colspan="4">1. 데이터 산출기준 :  평가일 기준 (2016.06.30)<br/>
2. 데이터 설명<br/>
1) 평가일기준 인원 및 점포현황 정보<br/>
2) 금융감독원 업무보고서 조직기구 현황(GA140)' 기준으로 함<br/></td>
</tr>
</table>
<br><br><br>
<table>
<tr><td align="center" colspan="2"  bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3"  bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>채널특성</strong></td>
	<td align="center" colspan="3"><strong>전자금융서비스 가입자수 현황</strong></td></tr>
<tr>
	<td align="center" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>결과값 산출기준 (개별)</strong></td>
</tr>
<tr><td align=center>1</td>
 <td align=left>HTS 가입자수</td>
 <td align=center>천명</td>
 <td></td>
 <td align=left>평가일 기준 (2016.06.30) 금융사의 총 HTS 가입자 수</td>
</tr>
<tr><td align=center>2</td>
 <td align=left>MTS 가입자수</td>
 <td align=center>천명</td>
 <td></td>
 <td align=left>평가일 기준 (2016.06.30) 금융사의 총 MTS 가입자 수</td>
</tr>
<tr><td align=center>결과값 산출기준(공통)</td>
 <td align=left colspan="4">1. 데이터 산출기준 :  평가일 기준 (2016.06.30)<br/>
2. 데이터 설명<br/>
1) 가입자수는 평가일 기준 해당서비스 이용을 위한 총 등록고객수를 기재<br/></td>
</tr>
</table>
<br><br><br>

<table>
<tr><td align="center" colspan="2"  bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3"  bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>채널특성</strong></td>
	<td align="center" colspan="3"><strong>전자금융경로를 이용한 거래 현황</strong></td></tr>
<tr>
	<td align="center" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>이용건수(천건)</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>이용금액(백만원)</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>결과값 산출기준 (개별)</strong></td>
</tr>
<tr><td align=center>1</td>
 <td align=left>HTS 이용 건수</td>
 <td></td>
 <td></td>
 <td align=left>최근 1년 (2015.07.01 ~ 2016.06.30)간 HTS 거래 총 이용 건수 및 금액을 기입함</td>
</tr>
<tr><td align=center>2</td>
 <td align=left>MTS 이용 건수</td>
 <td></td>
 <td></td>
 <td align=left>최근 1년 (2015.07.01 ~ 2016.06.30)간 MTS 거래 총 이용 건수 및 금액을 기입함</td>
</tr>
<tr><td align=center>3</td>
 <td align=left>전화거래 이용 건수</td>
 <td></td>
 <td></td>
 <td align=left>최근 1년 (2015.07.01 ~ 2016.06.30)간 전화 거래 총 이용 건수 및 금액을 기입함</td>
</tr>
<tr><td align=center>4</td>
 <td align=left>창구거래</td>
 <td></td>
 <td></td>
 <td align=left>최근 1년간 (2015.07.01~2016.06.30) 창구거래 이용건수, 이용금액을 기입함 </td>
</tr>
<tr><td align=center>결과값 산출기준(공통)</td>
 <td align=left colspan="4">1. 데이터 산출기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>
2. 데이터 설명<br/>
1) 거래는 자금의 이동을 수반하는 모든 거래를 포함 (단순 조회 등 제외)하며, 해당서비스를 이용한 건수 및 금액을 기재<br/></td>
</tr>
</table>
<br><br><br>
<table>
<tr><td align="center" colspan="2"  bgcolor="#E0ECF8"><strong>영역</strong></td>
	<td align="center" colspan="3"  bgcolor="#E0ECF8"><strong>구분</strong></td>
</tr>                                                                                                            
<tr><td align="center" colspan="2"><strong>채널특성</strong></td>
	<td align="center" colspan="3"><strong>전담투자상담사 현황</strong></td></tr>
<tr>
	<td align="center" bgcolor="#E0ECF8"><strong>No</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>데이터명</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>단위</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>결과값</strong></td>
	<td align="center" bgcolor="#E0ECF8"><strong>결과값 산출기준 (개별)</strong></td>
</tr>
<tr><td align=center>1</td>
 <td align=left>전담투자상담사 수</td>
 <td align=center>명</td>
 <td></td>
 <td align=left>일반현황(GA142)" 보고서의 구분이 직원_전담투자상담사인 국내+해외 인원수 기입함</td>
</tr>
<tr><td align=center>결과값 산출기준(공통)</td>
 <td align=left colspan="4">1. 데이터 산출기준 : 최근 1년 (2015.07.01 ~ 2016.06.30)<br/>
2. 데이터 설명<br/>
1) 평가일 기준 증권감독원에 등록된 전담투자 상담사 수<br/></td>
</tr>
</table>
<br/><br/>
</div>
</div>
		<div class="cond-btn-row" style="text-align:right">
			 	${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"closeBtn", closeBtn:"닫기", mode:"R", function:"self.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
		</div>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />