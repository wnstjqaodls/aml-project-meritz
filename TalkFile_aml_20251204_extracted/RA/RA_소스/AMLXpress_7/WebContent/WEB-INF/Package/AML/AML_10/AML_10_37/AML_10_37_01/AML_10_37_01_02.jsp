<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : AML_10_37_01_02.jsp
* Description     : 국가 평가기준수정
* Group           : GTONE, R&D센터/개발2본부
* Author          :
* Since           : 2025-06-30
********************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
  String ra_item_cd   = Util.nvl(request.getParameter("RA_ITEM_CD")     );
  String ra_item_code = Util.nvl(request.getParameter("RA_ITEM_CODE")      );
  String ra_seq       = Util.nvl(request.getParameter("RA_SEQ") );
  String ra_ref_snccd = Util.nvl(request.getParameter("RA_REF_SN_CCD") );
  String ra_snccd     = Util.nvl(request.getParameter("RA_SN_CCD") );
  String ROLEID       = sessionAML.getsAML_ROLE_ID();

  request.setAttribute("ra_item_cd"         ,ra_item_cd     );
  request.setAttribute("ra_item_code"       ,ra_item_code   );
  request.setAttribute("ra_seq"      , ra_seq   );
  request.setAttribute("ra_ref_snccd", ra_ref_snccd );
  request.setAttribute("ra_snccd"    , ra_snccd );
  request.setAttribute("ROLEID",ROLEID);
%>
<style>
.basic-table .title {
    background-color: #eff1f5;
    padding: 12px 12px 12px 16px;
    font-family: SpoqR;
    font-size: 14px;
    line-height: 2px;
    color: #444;
    letter-spacing: -0.28px;
}
</style>
<script>

    var GridObj1     = null;
    var classID      = "AML_10_37_01_02";
    var pageID       = "AML_10_37_01_02";
    var overlay      = new Overlay();
	var ra_item_cd   = "${ra_item_cd}";
	var ra_item_code = "${ra_item_code}";
	var ra_seq       = "${ra_seq}";
	var ra_ref_snccd = "${ra_ref_snccd}";
	var ra_snccd     = "${ra_snccd}";
	var ROLEID       = "${ROLEID}";

    $(document).ready(function(){
    	doSearch();
    	doSearch2();
    	
    	if(ra_snccd == "S") {
    		$("#btn_01").hide();
    		$("#btn_02").hide();
        }else {
        	$("#btn_01").show();
        	$("#btn_02").hide();
		}
    });

    function doSearch()
    {
    	var classID              = "AML_10_37_01_02";
        var methodID             = "getSearch";
        var params               = new Object();
        var CalSave              = form1.CalSave.vlaue;

        if(CalSave == "Y") {
        	params.pageID            = pageID;
            params.RA_ITEM_CD        = ra_item_cd;
            params.RA_ITEM_CODE      = ra_item_code;
            params.CalSave           = CalSave;
        }else {
        	params.pageID            = pageID;
            params.RA_ITEM_CD        = ra_item_cd;
            params.RA_ITEM_CODE      = ra_item_code;
        }
        sendService(classID, methodID, params, doSearch_success, doSearch_success);
    }

    function doSearch_success(gridData, data)
    {
        overlay.hide();
        if(gridData.length>0){
            var obj = gridData[0];

            $("#RA_ITEM_CODE"       ).val(obj.RA_ITEM_CODE   );
            $("#RA_ITEM_NM"         ).val(obj.RA_ITEM_NM     );
            $("#RA_ITEM_SCR"        ).val(obj.RA_ITEM_SCR    );
            $("#TICPI_CPI_IDX"      ).val(obj.TICPI_CPI_IDX      );
            $("#TICPI_CPI_IDX_SCR"  ).val(obj.TICPI_CPI_IDX_SCR  );
            $("#BASEL_RIK_IDX"      ).val(obj.BASEL_RIK_IDX      );
            $("#BASEL_RIK_IDX_SCR"  ).val(obj.BASEL_RIK_IDX_SCR  );

            form1.ABS_HRSK_YN.value        = obj.ABS_HRSK_YN;
            form1.FATF_BLACK_LIST_YN.value = obj.FATF_BLACK_LIST_YN;
            form1.FATF_GREY_LIST_YN.value  = obj.FATF_GREY_LIST_YN;
            form1.FINCEN_LIST_YN.value     = obj.FINCEN_LIST_YN;
            form1.UN_SANTIONS_YN.value     = obj.UN_SANTIONS_YN;
            form1.OFAC_SANTIONS_YN.value   = obj.OFAC_SANTIONS_YN;
            form1.OECD_YN.value            = obj.OECD_YN;
            form1.INCRS_PROD_YN.value      = obj.INCRS_PROD_YN;
            form1.INCRS_CHEM_YN.value      = obj.INCRS_CHEM_YN;
            form1.EU_SANTIONS_YN.value     = obj.EU_SANTIONS_YN;
            form1.EU_HRT_YN.value          = obj.EU_HRT_YN;

        }
        
        
        
    }

    function doSearch2()
    {
    	var classID             = "AML_10_37_01_02";
        var methodID            = "getSearchGubun";
        var params              = new Object();

        params.pageID           = pageID;
        sendService(classID, methodID, params, doSearch2_success, doSearch2_success);
    }

    function doSearch2_success(gridData, data)
    {
    	overlay.hide();
        if(gridData.length>0){
            var obj = gridData[0];

            $("#RISK_ELMT_NM1"   ).val(obj.RISK_ELMT_NM1   );
            $("#RISK_ELMT_NM2"   ).val(obj.RISK_ELMT_NM2   );
            $("#RISK_ELMT_NM3"   ).val(obj.RISK_ELMT_NM3   );
            $("#RISK_ELMT_NM4"   ).val(obj.RISK_ELMT_NM4   );
            $("#RISK_ELMT_NM5"   ).val(obj.RISK_ELMT_NM5   );
            $("#RISK_ELMT_NM6"   ).val(obj.RISK_ELMT_NM6   );
            $("#RISK_ELMT_NM7"   ).val(obj.RISK_ELMT_NM7   );
            $("#RISK_ELMT_NM8"   ).val(obj.RISK_ELMT_NM8   );
            $("#RISK_ELMT_NM9"   ).val(obj.RISK_ELMT_NM9   );
            $("#RISK_ELMT_NM10"  ).val(obj.RISK_ELMT_NM10  );
            $("#RISK_ELMT_NM11"  ).val(obj.RISK_ELMT_NM11  );
            $("#RISK_ELMT_NM12"  ).val(obj.RISK_ELMT_NM12  );

            $("#RISK_SCR_NM1"    ).val(obj.RISK_SCR_NM1    );
            $("#RISK_SCR_NM2"    ).val(obj.RISK_SCR_NM2    );
            $("#RISK_SCR_NM3"    ).val(obj.RISK_SCR_NM3    );
            $("#RISK_SCR_NM4"    ).val(obj.RISK_SCR_NM4    );
            $("#RISK_SCR_NM5"    ).val(obj.RISK_SCR_NM5    );
            $("#RISK_SCR_NM6"    ).val(obj.RISK_SCR_NM6    );
            $("#RISK_SCR_NM7"    ).val(obj.RISK_SCR_NM7    );
            $("#RISK_SCR_NM8"    ).val(obj.RISK_SCR_NM8    );
            $("#RISK_SCR_NM9"    ).val(obj.RISK_SCR_NM9    );
            $("#RISK_SCR_NM10"   ).val(obj.RISK_SCR_NM10   );
            $("#RISK_SCR_NM11"   ).val(obj.RISK_SCR_NM11   );
            $("#RISK_SCR_NM12"   ).val(obj.RISK_SCR_NM12   );
        }
    }

    function doSave() {

    	var classID               = "AML_10_37_01_02";
    	var methodID              = "doSave";
        var params                = new Object();
        showConfirm('${msgel.getMsg("AML_10_02_01_01_002","저장 하시겠습니까?")}', "저장",function(){
	    params.pageID             = pageID;
	    params.RA_ITEM_CD         = ra_item_cd;
        params.RA_ITEM_CODE       = $("#RA_ITEM_CODE").val();
        params.RA_ITEM_NM         = $("#RA_ITEM_NM").val();
        params.FATF_BLACK_LIST_YN = getCheckedRadio("FATF_BLACK_LIST_YN");
        params.FATF_GREY_LIST_YN  = getCheckedRadio("FATF_GREY_LIST_YN");
        params.FINCEN_LIST_YN     = getCheckedRadio("FINCEN_LIST_YN");
        params.UN_SANTIONS_YN     = getCheckedRadio("UN_SANTIONS_YN");
        params.OFAC_SANTIONS_YN   = getCheckedRadio("OFAC_SANTIONS_YN");
        params.OECD_YN            = getCheckedRadio("OECD_YN");
        params.TICPI_CPI_IDX      = $("#TICPI_CPI_IDX").val();
        params.INCRS_PROD_YN      = getCheckedRadio("INCRS_PROD_YN");
        params.INCRS_CHEM_YN      = getCheckedRadio("INCRS_CHEM_YN");
        params.EU_SANTIONS_YN     = getCheckedRadio("EU_SANTIONS_YN");
        params.EU_HRT_YN          = getCheckedRadio("EU_HRT_YN");
        params.BASEL_RIK_IDX      = $("#BASEL_RIK_IDX").val();

        sendService(classID, methodID, params, doSave_end, doSave_end);
        });
    }

    function doSave_end() {
    	overlay.hide();
    	form1.CalSave.vlaue = "Y";
    	doSearch();
    	opener.doSearch2();
    	$("#btn_02").show();
    }

    function popupClose() {
        self.close();
    }

    function reCalcul() {
    	showConfirm('${msgel.getMsg("AML_10_36_01_01_034","위험평가 재계산 하시겠습니까?")}', "위험평가 재계산",function(){
    	overlay.show(true, true);
    	var classID               = "AML_10_37_01_02";
    	var methodID              = "reCalcul";
        var params                = new Object();
        params.pageID             = pageID;
        params.RA_ITEM_CD         = ra_item_cd;
        params.RA_SEQ             = ra_seq;
        params.RA_REF_SN_CCD      = ra_ref_snccd;
        params.RA_SN_CCD          = ra_snccd;

        sendService(classID, methodID, params, doSave2_end, doSave2_end);

    	});
    }
    
    function doSave2_end() {
    	overlay.hide();
    	form1.CalSave.vlaue = "Y";
    	doSearch_reCalcul();
    	doSearch();
    	opener.doSearch2();
    	$("#btn_02").hide();
    }
    
    function doSearch_reCalcul() {
  		var classID              = "AML_10_37_01_01";
        var methodID             = "getSearch_reCalcul";
        var params               = new Object();

        params.pageID            = pageID;
        params.RA_ITEM_CD        = ra_item_cd;
        
        sendService(classID, methodID, params, doSearch_reCalcul_success, doSearch_reCalcul_success);
  	}
  	
  	function doSearch_reCalcul_success(gridData, data) {
  		overlay.hide();
  		if(gridData.length>0){
            var obj = gridData[0];
            
            form1.recalculCNT1.value = obj.CNT1;
            form1.recalculCNT2.value = obj.CNT2;
            
            var recalculCNT1 = form1.recalculCNT1.value;
            var recalculCNT2 = form1.recalculCNT2.value;
            
            if(recalculCNT1 > 0 || recalculCNT2 > 0){
            	showAlert( "${msgel.getMsg('AML_10_01_01_01_046', '위험점수/당연EDD 여부가 변경되었습니다.')}", "INFO");
            }else {
            	showAlert( "${msgel.getMsg('AML_10_01_01_01_047', '변경사항이 없습니다.')}", "INFO");
            }
        }
  	}
</script>


<style>
	.basic-table .title {
		/* min-width: 130px; */
		text-align: center;
	}

}
</style>
<form name="form1" method="post" onsubmit="return false">
<input type="hidden" name="pageID" >
<input type="hidden" name="classID" >
<input type="hidden" name="methodID" >
<input type="hidden" name="CalSave">
<input type="hidden" name="recalculCNT1" >
<input type="hidden" name="recalculCNT2">



<div class="tab-content" >

    <div class="row" style="padding-top: 8px">
		<h4 class="tab-content-title">평가항목</h4>
	</div>
	<table class="basic-table">
		<tbody>
			<tr>
	            <th class="title">상세코드</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RA_ITEM_CODE" id="RA_ITEM_CODE" value="" style="text-align:center" readonly>
	            </td>

	        	<th class="title">상세코드 내용</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RA_ITEM_NM" id="RA_ITEM_NM" value="" style="text-align:center">
	            </td>
            </tr>
            <tr>
	            <th class="title">위험점수</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RA_ITEM_SCR" id="RA_ITEM_SCR" value="" style="text-align:center" readonly>
	            </td>

	        	<th class="title">당연EDD 여부</th>
	            <td style="text-align: center;">
	            	${radioel.getRadioBtns('{radioBtnID:"ABS_HRSK_YN",cdID:"N002",initValue:""}')}
	            </td>
            </tr>
		</tbody>
	</table>
	<div class="button-area" style="float:right; margin-bottom:10px; margin-top:10px">
		${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"riskrecal", defaultValue:"위험점수 재계산", mode:"U", function:"reCalcul", cssClass:"btn-36 filled"}')}
	</div>

	<div class="row" style="padding-top: 8px">
		<h4 class="tab-content-title">평가기준</h4>
	</div>
	<table class="basic-table" style="table-layout:fixed;">
		<tbody>
			<tr>
				<th class="title" style="width:400px">위험요소</th>
				<th class="title">위험점수</th>
				<th class="title" colspan="2">해당여부</th>
			</tr>
			<tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM1" id="RISK_ELMT_NM1" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM1" id="RISK_SCR_NM1" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"FATF_BLACK_LIST_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM2" id="RISK_ELMT_NM2" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM2" id="RISK_SCR_NM2" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"FATF_GREY_LIST_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM3" id="RISK_ELMT_NM3" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM3" id="RISK_SCR_NM3" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"FINCEN_LIST_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM4" id="RISK_ELMT_NM4" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM4" id="RISK_SCR_NM4" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"UN_SANTIONS_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM5" id="RISK_ELMT_NM5" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM5" id="RISK_SCR_NM5" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"OFAC_SANTIONS_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM6" id="RISK_ELMT_NM6" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM6" id="RISK_SCR_NM6" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"OECD_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM7" id="RISK_ELMT_NM7" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM7" id="RISK_SCR_NM7" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="TICPI_CPI_IDX" id="TICPI_CPI_IDX" value="" style="text-align:center">
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="TICPI_CPI_IDX_SCR" id="TICPI_CPI_IDX_SCR" value="" style="text-align:center"  readonly>
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM8" id="RISK_ELMT_NM8" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM8" id="RISK_SCR_NM8" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"INCRS_PROD_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM9" id="RISK_ELMT_NM9" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM9" id="RISK_SCR_NM9" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"INCRS_CHEM_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM10" id="RISK_ELMT_NM10" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM10" id="RISK_SCR_NM10" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"EU_SANTIONS_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM11" id="RISK_ELMT_NM11" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM11" id="RISK_SCR_NM11" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align:center;" colspan="2">
	            	${radioel.getRadioBtns('{radioBtnID:"EU_HRT_YN",cdID:"N003",initValue:""}')}
	            </td>
            </tr>
            <tr>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_ELMT_NM12" id="RISK_ELMT_NM12" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_SCR_NM12" id="RISK_SCR_NM12" value="" style="text-align:center" readonly>
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="BASEL_RIK_IDX" id="BASEL_RIK_IDX" value="" style="text-align:center">
	            </td>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="BASEL_RIK_IDX_SCR" id="BASEL_RIK_IDX_SCR" value="" style="text-align:center" readonly>
	            </td>
            </tr>
		</tbody>
	</table>

	<div style="color:black;text-align:center;float:left; font-size:15px;">
	 	<span style="color:red;">※ 평가 기준을 수정한 경우, 위험점수 재계산을 수행하여야 합니다.</span>
	</div>
	<div class="button-area" style="float:right; margin-top:10px;">
	<% if ( "4".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
    <% } %>
    	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"popupClose", cssClass:"btn-36"}')}
    </div>
</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />
