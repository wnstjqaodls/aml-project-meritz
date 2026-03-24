<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_02_02_02.jsp
* Description     : 도움말 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-02
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%
    
%>
<style type="text/css">
    * { white-space: nowrap; }
</style>
<script language="JavaScript">
    
    // Initialize
    $(document).ready(function(){
    
    });
    
    // Initial function
    function init() { initPage(); }
    
    
</script>


<form name="form1" method="post">
	<input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
                <table  border="2" width="100%" class="grid-table one-row">
                	<thead class="table-head">
                    <tr>
                        <th>${msgel.getMsg('RBA_50_05_01_06_100','번호')}</th>
                        <th>${msgel.getMsg('RBA_50_01_01_218','AML 프로세스 구분 기준 평가 항목')}</th>
                        <th>${msgel.getMsg('RBA_50_08_02_02_004','상세내용')}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td align="center">Q1</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_219','자금(실물자산포함)의 유출입이 발생하는가?')}</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_220','금융거래가 자금세탁에 악용되는 경우 대부분 자금 유출입을 수반하므로 AML 관련 업무로 식별')}</td>
                    </tr> 
                    <tr>
                        <td align="center">Q2</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_221','고객확인의무 대상 업무인가?')}</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_222','자금세탁관련 법규에서 “계좌 신규” 및 “일회성 금융거래” 등 고객확인의무 대상으로 포함시켜야 하는 경우에 해당')}</td>
                    </tr>
                    <tr>
                        <td align="center">Q3</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_223','제3자 계약이 발생하는 업무인가?')}</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_224','금융회사의 업무를 계약관계에 있는 제3자에게 위탁, 아웃소싱 하는 등으로 인해, \\r\\n해당 제3자가 금융회사의 자금세탁방지 업무를 일정 부분 수행해야 하는 경우')}</td>
                    </tr>
                    <tr>
                        <td align="center">Q4</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_225','비대면형태로 업무가 이루어지는가?')}</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_226','비대면 거래는 대면 거래에 비해 자금세탁 고위험으로 식별해야 할 가능성이 높으므로  \\r\\n특정 업무의 비대면 형태 수행 여부를 확인')}
                        </td>
                    </tr>
                    <tr>
                        <td align="center">Q5</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_227','STR Rule이 존재하는가?')}</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_228','자금세탁 위험이 존재한다고 판단되어 STR Rule 운영 대상이 되는 업무')}</td>
                    </tr>
                    <tr>
                        <td align="center">Q6</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_229','내·외부 금융사고 이력이 있는가?')}</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_230','자금세탁과 관련된 금융사고 발생과 관련된 업무 식별')}</td>
                    </tr>   
                    <tr>
                        <td align="center">Q7</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_231','규정 및 지침을 통해 요구되는 자금세탁관련 통제활동인가?')}</td>
                        <td style="text-align: left;">${msgel.getMsg('RBA_50_01_01_232','자금세탁관련 법규에서 요구하는 자금세탁방지와 관련된 금융회사의 내부통제 활동 목록을 포함')}</td>
                    </tr>
                    </tbody>                                 
                </table>
            </div>
        </div>
        <div align="right" style="margin-top: 10px">
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')}
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />