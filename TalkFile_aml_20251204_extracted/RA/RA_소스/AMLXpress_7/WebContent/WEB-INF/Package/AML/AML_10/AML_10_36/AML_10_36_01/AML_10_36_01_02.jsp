<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : AML
* File Name       : AML_10_36_01_02.jsp
* Description     : 위험요소 상세 정보
* Group           : GTONE, R&D센터/개발2본부
* Author          :
* Since           : 2024-04-29
********************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
  String risk_catg1_c      = Util.nvl(request.getParameter("RISK_CATG1_C")     );
  String risk_elmt_c       = Util.nvl(request.getParameter("RISK_ELMT_C")      );
  String RISK_INDI         = Util.nvl(request.getParameter("RISK_INDI")        );
  String RISK_CORP         = Util.nvl(request.getParameter("RISK_CORP")        );
  String RISK_APPL_MODEL_I = Util.nvl(request.getParameter("RISK_APPL_MODEL_I"));
  String RISK_APPL_MODEL_B = Util.nvl(request.getParameter("RISK_APPL_MODEL_B"));
  String RANKID            = Util.nvl(request.getParameter("RANKID"));

  request.setAttribute("risk_catg1_c"      ,risk_catg1_c      );
  request.setAttribute("risk_elmt_c"       ,risk_elmt_c       );
  request.setAttribute("RISK_INDI"         ,RISK_INDI         );
  request.setAttribute("RISK_CORP"         ,RISK_CORP         );
  request.setAttribute("RISK_APPL_MODEL_I" ,RISK_APPL_MODEL_I );
  request.setAttribute("RISK_APPL_MODEL_B" ,RISK_APPL_MODEL_B );
  request.setAttribute("RANKID" ,RANKID );

  String ROLEID     = sessionAML.getsAML_ROLE_ID();
  request.setAttribute("ROLEID",ROLEID);
%>
<script>

    var GridObj1          = null;
    var classID           = "AML_10_36_01_01";
    var pageID            = "AML_10_36_01_02";
    var overlay           = new Overlay();
	var risk_catg1_c      = "${risk_catg1_c}";
	var risk_elmt_c       = "${risk_elmt_c}";
	var RISK_INDI         = "${RISK_INDI}";
	var RISK_CORP         = "${RISK_CORP}";
	var RISK_APPL_MODEL_I = "${RISK_APPL_MODEL_I}";
	var RISK_APPL_MODEL_B = "${RISK_APPL_MODEL_B}";
	var ROLEID            = "${ROLEID}";
	var RANKID            = "${RANKID}";

    $(document).ready(function(){

    	doSearch();

    });

    function doSearch()
    {
    	var classID         = "AML_10_36_01_01";
        var methodID        = "getSearchCodeDetail";
        var params          = new Object();

        params.pageID       = pageID;
        params.RISK_CATG1_C = risk_catg1_c;
        params.RISK_ELMT_C  = risk_elmt_c;
        params.RANKID       = RANKID;

        sendService(classID, methodID, params, doSearch_success, doSearch_success);
    }

    function doSearch_success(gridData, data)
    {
        overlay.hide();
        if(gridData.length>0){
            var obj = gridData[0];
            var RISK_HRSK_YN      = obj.RISK_HRSK_YN;
            var RISK_CATG1_C      = obj.RISK_CATG1_C;
            var RA_SN_CCD         = obj.RA_SN_CCD;
            
            var APPR_ROLE_ID      = obj.APPR_ROLE_ID;
            var TARGET_ROLE_ID    = obj.TARGET_ROLE_ID;
            
            var BEF_RISK_ELMT_NM  = obj.RISK_ELMT_NM;
            var BEF_RISK_HRSK_YN  = obj.RISK_HRSK_YN;
            var BEF_RISK_SCR      = obj.RISK_SCR;
            var BEF_RISK_RSN_DESC = obj.RISK_RSN_DESC;
            var BEF_RISK_RMRK     = obj.RISK_RMRK;

            $("#RISK_CATG1_C_NM"   ).val(obj.RISK_CATG1_C_NM   );
            $("#RISK_VAL_ITEM_NM"  ).val(obj.RISK_VAL_ITEM_NM  );
            $("#RISK_ELMT_NM"      ).val(obj.RISK_ELMT_NM      );
            $("#RISK_SCR"          ).val(obj.RISK_SCR          );
            $("#RA_SN_CCD_NM"      ).val(obj.RA_SN_CCD_NM      );
            $("#RISK_RSN_DESC"     ).val(obj.RISK_RSN_DESC     );
            $("#RISK_RMRK"         ).val(obj.RISK_RMRK         );
            
            form1.RISK_CATG1_C.value  = obj.RISK_CATG1_C;
            form1.RISK_CATG2_C.value  = obj.RISK_CATG2_C;
            form1.RISK_ELMT_C.value   = obj.RISK_ELMT_C;
            form1.RA_SN_CCD.value     = RA_SN_CCD;
            form1.RISK_HRSK_YN.value  = RISK_HRSK_YN;
            form1.RA_APP_NO.value     = obj.RA_APP_NO;
            form1.RA_APP_DT.value     = obj.RA_APP_DT;
            form1.PRV_APP_NO.value    = obj.PRV_APP_NO;
            form1.RISK_VAL_ITEM.value = obj.RISK_VAL_ITEM;
            form1.RISK_APPL_YN.value  = obj.RISK_APPL_YN;
            form1.RA_SEQ.value        = obj.RA_SEQ;
            form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
            form1.POSITION_NAME.value = obj.POSITION_NAME;
            form1.SNO.value           = obj.SNO;
            
            form3.BEF_RISK_ELMT_NM.value   = BEF_RISK_ELMT_NM;
            form3.BEF_RISK_HRSK_YN.value   = BEF_RISK_HRSK_YN;
            form3.BEF_RISK_SCR.value       = BEF_RISK_SCR;
            form3.BEF_RISK_RSN_DESC.value  = BEF_RISK_RSN_DESC;
            form3.BEF_RISK_RMRK.value      = BEF_RISK_RMRK;
    		
            /* if(RISK_CATG1_C == "R1" || RISK_CATG1_C == "R2") {
            	if(RISK_HRSK_YN == "N") {
            		form1.RISK_SCR.readOnly = false;
            	}else {
            		form1.RISK_SCR.readOnly = true;
            	}
            }else {
            	form1.RISK_SCR.readOnly = true;
            } */
            
            if(risk_elmt_c == "R10601" || risk_elmt_c == "R10701" 
        	|| risk_elmt_c == "R10702" || risk_elmt_c == "R10901"
        	|| risk_elmt_c == "R10801" || risk_elmt_c == "R10802"
        	|| risk_elmt_c == "R20701" || risk_elmt_c == "R20702"
        	|| risk_elmt_c == "R20703" || risk_elmt_c == "R21401"
        	|| risk_elmt_c == "R21403" || risk_elmt_c == "R21404"
        	|| risk_elmt_c == "R20101" || risk_elmt_c == "R21402"
        	|| risk_elmt_c == "R20601" || risk_elmt_c == "R20602"  
        	|| risk_elmt_c == "R20603" || risk_elmt_c == "R20604" 
        	|| risk_elmt_c == "R21001" || risk_elmt_c == "R21405") {
            	form1.RISK_SCR.readOnly = false;
        	}else {
        		$("#RISK_SCR").val("");
        		form1.RISK_SCR.readOnly = true;
        	}

            if(ROLEID == "4") {
            	if(RA_SN_CCD == "S") {
					$("#btn_01").hide();
					$("#sbtn_01").hide();
				}else if(RA_SN_CCD == "E" || RA_SN_CCD == "R") {
					$("#btn_01").show();
					$("#sbtn_01").hide();
				}else if(RA_SN_CCD == "N"){
					$("#btn_01").show();
					$("#sbtn_01").show();
				}else {
					$("#btn_01").show();
					$("#sbtn_01").hide();
				}
   			}else if(ROLEID == "104") {
   				if(RA_SN_CCD == "S") {
					$("#sbtn_03").show();
					$("#btn_04").show();
				}else {
					$("#sbtn_03").hide();
					$("#btn_04").hide();
				}
			}else {
				$("#sbtn_03").hide();
				$("#btn_04").hide();
			}
        }
    }

    function doSearch_fail(data){ overlay.hide(); }

    function doSaveCheck() {
    	var RA_SN_CCD         = form1.RA_SN_CCD.value;
    	
    	//변경후
    	var RISK_ELMT_NM      = $("#RISK_ELMT_NM").val();
    	var RISK_HRSK_YN      = form1.RISK_HRSK_YN.value;
    	var RISK_SCR          = $("#RISK_SCR").val();
    	var RISK_RSN_DESC     = $("#RISK_RSN_DESC").val();
	    var RISK_RMRK         = $("#RISK_RMRK").val();
    	//변경전
    	var BEF_RISK_ELMT_NM  = form3.BEF_RISK_ELMT_NM.value;
    	var BEF_RISK_HRSK_YN  = form3.BEF_RISK_HRSK_YN.value;
        var BEF_RISK_SCR      = form3.BEF_RISK_SCR.value; 
    	var BEF_RISK_RSN_DESC = form3.BEF_RISK_RSN_DESC.value;
        var BEF_RISK_RMRK     = form3.BEF_RISK_RMRK.value;
        
        if(RA_SN_CCD == "S" || RA_SN_CCD == "N" || RA_SN_CCD == "R") {
			return true;
		}else {
			if((BEF_RISK_RSN_DESC != RISK_RSN_DESC) || (BEF_RISK_RMRK != RISK_RMRK)) {
				if((BEF_RISK_ELMT_NM != RISK_ELMT_NM) || (BEF_RISK_HRSK_YN != RISK_HRSK_YN) || (BEF_RISK_SCR != RISK_SCR)) {
					return true;
	            }else {
	            	doSave2();
	            	return false;
				}
			}else if((BEF_RISK_RSN_DESC == RISK_RSN_DESC) || (BEF_RISK_RMRK = RISK_RMRK)){
				if((BEF_RISK_ELMT_NM != RISK_ELMT_NM) || (BEF_RISK_HRSK_YN != RISK_HRSK_YN) || (BEF_RISK_SCR != RISK_SCR)) {
					return true;
	            }else {
	            	doSave2();
	            	return false;
				}
			}
		}
        
        return false;
	}
    
    function doSave2() {
    	var classID          = "AML_10_36_01_02";
    	var methodID         = "doSave2";
    	var params           = new Object();
    	var RISK_ELMT_C      = form1.RISK_ELMT_C.value;   // 위험요소코드
    	var RA_SEQ           = form1.RA_SEQ.value;
    	var RISK_RSN_DESC     = $("#RISK_RSN_DESC").val();
	    var RISK_RMRK         = $("#RISK_RMRK").val();
    	
    	showConfirm('${msgel.getMsg("AML_10_02_01_01_002","저장 하시겠습니까?")}', "저장",function(){
    	
    	params.pageID        = pageID;
    	params.RA_SEQ        = RA_SEQ;
    	params.RISK_ELMT_C   = RISK_ELMT_C;
    	params.RISK_RSN_DESC = RISK_RSN_DESC;
        params.RISK_RMRK     = RISK_RMRK;
        
        sendService(classID, methodID, params, doSave2_end, doSave2_end);
    	});	
	}
    
    function doSave2_end() {
    	overlay.hide();
    	doSearch();
    	opener.doSearch2();
    	
    }
    
    function doSave() {

    	if(!doSaveCheck()) {
			return;
		}
    	
    	var classID          = "AML_10_36_01_02";
    	var methodID         = "doSave";
        var params           = new Object();

        var RA_SEQ            = form1.RA_SEQ.value;
        var RA_REF_SN_CCD     = form1.RA_REF_SN_CCD.value;
    	var RA_SN_CCD         = form1.RA_SN_CCD.value;
    	var RISK_ELMT_C       = form1.RISK_ELMT_C.value;   // 위험요소코드
    	var RISK_CATG1_C      = form1.RISK_CATG1_C.value;  // 위험요소1
        var RISK_CATG2_C      = form1.RISK_CATG2_C.value;  // 위험요소2
 		var RISK_ELMT_NM      = $("#RISK_ELMT_NM").val();  // 위험요소명
        var RISK_SCR          = $("#RISK_SCR").val();      // 위험점수
 		var RISK_HRSK_YN      = form1.RISK_HRSK_YN.value;  // 당연EDD 여부
 		var RISK_RSN_DESC     = $("#RISK_RSN_DESC").val(); // 위험사유
	    var RISK_RMRK         = $("#RISK_RMRK").val();     // 비교(메모)

    	var RISK_VAL_ITEM     = form1.RISK_VAL_ITEM.value;
    	var RISK_APPL_YN      = form1.RISK_APPL_YN.value;
    	
    	if(risk_elmt_c == "R10601" || risk_elmt_c == "R10701" 
    	|| risk_elmt_c == "R10702" || risk_elmt_c == "R10901" 
    	|| risk_elmt_c == "R10801" || risk_elmt_c == "R10802"
    	|| risk_elmt_c == "R20701" || risk_elmt_c == "R20702"
        || risk_elmt_c == "R20703" || risk_elmt_c == "R21401"
        || risk_elmt_c == "R21403" || risk_elmt_c == "R21404"
        || risk_elmt_c == "R20101" || risk_elmt_c == "R21402"
    	|| risk_elmt_c == "R20601" || risk_elmt_c == "R20602"  
    	|| risk_elmt_c == "R20603" || risk_elmt_c == "R20604" 
    	|| risk_elmt_c == "R21001" || risk_elmt_c == "R21405") {
			if(RISK_HRSK_YN == "N" && RISK_SCR == "") {
				showAlert( "${msgel.getMsg('AML_10_03_01_01_051', '당연EDD 여부가 N 입니다. 위험점수를 입력해주세요.')}", "WARN");
			   	return;
			}
    	}
    	

	    showConfirm('${msgel.getMsg("AML_10_02_01_01_002","저장 하시겠습니까?")}', "저장",function(){

	    params.pageID            = pageID;
	    
	    params.RA_SEQ            = RA_SEQ;
	    params.RA_REF_SN_CCD     = RA_REF_SN_CCD;
	    params.RA_SN_CCD         = RA_SN_CCD;
	    
	    params.RISK_ELMT_C       = RISK_ELMT_C;
	    params.RISK_CATG1_C      = RISK_CATG1_C;
        params.RISK_CATG2_C      = RISK_CATG2_C;
        params.RISK_ELMT_NM      = RISK_ELMT_NM;
        params.RISK_SCR          = RISK_SCR;
        
        params.RISK_INDI         = RISK_INDI;  
        params.RISK_CORP         = RISK_CORP;
        params.RISK_VAL_ITEM     = RISK_VAL_ITEM;
        params.RISK_APPL_YN      = RISK_APPL_YN;
        params.RISK_APPL_MODEL_I = RISK_APPL_MODEL_I ;
        params.RISK_APPL_MODEL_B = RISK_APPL_MODEL_B;
        
        params.RISK_HRSK_YN      = RISK_HRSK_YN;
        params.RISK_RSN_DESC     = RISK_RSN_DESC;
        params.RISK_RMRK         = RISK_RMRK;
        sendService(classID, methodID, params, doSave_end, doSave_end);
	    });
    }

    function doSave_end() {
    	overlay.hide();
    	doSearch();
    	opener.doSearch2();
    }

    //결재요청
    function PopKYCPage() {

    	var RA_SEQ         = form1.RA_SEQ.value;
    	var RISK_ELMT_C    = form1.RISK_ELMT_C.value;
        var RA_APP_NO      = form1.RA_APP_NO.value;
        var POSITION_NAME  = form1.POSITION_NAME.value;
		var RA_REF_SN_CCD  = form1.RA_REF_SN_CCD.value;
		
    	form2.pageID.value = 'AML_10_36_01_03';
        window_popup_open(form2.pageID.value, 900, 680, '', '');
        form2.target              = form2.pageID.value;
		
        form2.RA_SEQ.value         = RA_SEQ;
        form2.RISK_ELMT_C.value    = RISK_ELMT_C;
    	form2.RA_REF_SN_CCD.value  = RA_REF_SN_CCD;
    	form2.APP_NO.value         = RA_APP_NO;
		form2.POSITION_NAME.value  = POSITION_NAME;
		form2.searchgubun.value    = "N";
        form2.action              = "<c:url value='/'/>0001.do";
        form2.submit();
    }

  	//반려실행
    function PopKYCPage2() {

    	var RA_SEQ         = form1.RA_SEQ.value;
    	var RISK_ELMT_C    = form1.RISK_ELMT_C.value;
        var RA_APP_NO      = form1.RA_APP_NO.value;
        var POSITION_NAME  = form1.POSITION_NAME.value;		
        
    	form2.pageID.value = 'AML_10_36_01_04';
        window_popup_open(form2.pageID.value, 900, 680, '', '');
        form2.target              = form2.pageID.value;

        form2.RISK_ELMT_C.value    = RISK_ELMT_C;
        form2.RA_SEQ.value         = RA_SEQ;
        form2.POSITION_NAME.value  = POSITION_NAME;
        form2.APP_NO.value         = RA_APP_NO;
        form2.searchgubun.value    = "N";
        form2.action              = "<c:url value='/'/>0001.do";
        form2.submit();

    }
  	
  	//결재완료
    function PopKYCPage3() {

    	var RA_SEQ         = form1.RA_SEQ.value;
    	var RISK_ELMT_C    = form1.RISK_ELMT_C.value;
        var RA_APP_NO      = form1.RA_APP_NO.value;
        var PRV_APP_NO     = form1.PRV_APP_NO.value;
        var POSITION_NAME  = form1.POSITION_NAME.value;
        var RISK_ELMT_NM   = $("#RISK_ELMT_NM").val();
  		
    	form2.pageID.value = 'AML_10_36_01_03';
        window_popup_open(form2.pageID.value, 900, 680, '', '');
        form2.target                  = form2.pageID.value;
        
        form2.RISK_ELMT_C.value    = RISK_ELMT_C;
        form2.RA_SEQ.value     	   = RA_SEQ;
	    form2.APP_NO.value         = RA_APP_NO;
        form2.PRV_APP_NO.value     = PRV_APP_NO;
	    form2.POSITION_NAME.value  = POSITION_NAME;
	    form2.RISK_ELMT_NM.value   = RISK_ELMT_NM;
	    form2.searchgubun.value    = "N";
        form2.action               = "<c:url value='/'/>0001.do";
        form2.submit();

    }

    function popupClose() {
        self.close();
    }

    function riskGubun() {
    	var RISK_HRSK_YN = form1.RISK_HRSK_YN.value;
    	if(RISK_HRSK_YN == "Y" || RISK_HRSK_YN == "H") { 
    		$("#RISK_SCR").val("");
    		form1.RISK_SCR.readOnly = true;
    	}else {
    		if(risk_elmt_c == "R10601" || risk_elmt_c == "R10701" 
    		|| risk_elmt_c == "R10702" || risk_elmt_c == "R10901"
    		|| risk_elmt_c == "R10801" || risk_elmt_c == "R10802"
    		|| risk_elmt_c == "R20701" || risk_elmt_c == "R20702"
            || risk_elmt_c == "R20703" || risk_elmt_c == "R21401"
            || risk_elmt_c == "R21403" || risk_elmt_c == "R21404"
            || risk_elmt_c == "R20101" || risk_elmt_c == "R21402"
    		|| risk_elmt_c == "R20601" || risk_elmt_c == "R20602"  
    		|| risk_elmt_c == "R20603" || risk_elmt_c == "R20604" 
    		|| risk_elmt_c == "R21001" || risk_elmt_c == "R21405") {
        		form1.RISK_SCR.readOnly = false;
    		}else {
    			$("#RISK_SCR").val("");
    			form1.RISK_SCR.readOnly = true;
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

<form name="form3" method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	<input type="hidden" name="BEF_RISK_ELMT_NM" >
	<input type="hidden" name="BEF_RISK_HRSK_YN" >
	<input type="hidden" name="BEF_RISK_SCR" >
	<input type="hidden" name="BEF_RISK_RSN_DESC" >
	<input type="hidden" name="BEF_RISK_RMRK" >
</form>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
    <input type="hidden" name="RISK_ELMT_C">
	<input type="hidden" name="RA_SEQ">
    <input type="hidden" name="APP_NO">
    <input type="hidden" name="PRV_APP_NO">
    <input type="hidden" name="RA_APP_NO">
    <input type="hidden" name="POSITION_NAME">
    <input type="hidden" name="RA_REF_SN_CCD">
    <input type="hidden" name="SNO">
    <input type="hidden" name="popkygubun">
    <input type="hidden" name="RISK_ELMT_NM">
    <input type="hidden" name="searchgubun">
</form>

<form name="form1" method="post" onsubmit="return false;">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	
	<input type="hidden" name="RISK_CATG1_C" >
	<input type="hidden" name="RISK_CATG2_C" >
	<input type="hidden" name="RISK_ELMT_C" >
	<input type="hidden" name="RA_SN_CCD" >
	<input type="hidden" name="RISK_HRSK_YN" >
	<input type="hidden" name="RA_APP_NO" >
	<input type="hidden" name="RA_APP_DT" >
	<input type="hidden" name="RISK_VAL_ITEM" >
	<input type="hidden" name="PRV_APP_NO" >
	<input type="hidden" name="RISK_APPL_YN" >
	<input type="hidden" name="RA_SEQ" >
	<input type="hidden" name="RA_REF_SN_CCD" >
	<input type="hidden" name="POSITION_NAME" >
	<input type="hidden" name="SNO" >
	
<div class="tab-content-bottom">
	<table class="basic-table" style="table-layout:fixed;">
		<tbody>
			<tr>
	            <th class="title">위험분류</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_CATG1_C_NM" id="RISK_CATG1_C_NM" value="" style="text-align:center" readonly>
	            </td>

	        	<th class="title">평가항목</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RISK_VAL_ITEM_NM" id="RISK_VAL_ITEM_NM" value="" style="text-align:center" readonly>
	            </td>
            </tr>
            <tr>
	            <th class="title">위험요소<span style="color:red;">*</span></th>
	            <td colspan="3">
	            <input type="text" class="cond-input-text" name="RISK_ELMT_NM" id="RISK_ELMT_NM" value="">
	            

	            </td>
            </tr>
            <tr >
	            <th class="title">적용대상</th>
	            <td>
	            	<input type="checkbox" id="RISK_INDI" name="RISK_INDI" class="div-cont-box-checkbox" ${"Y".equals(RISK_INDI) ? "checked='checked'":""} disabled>
					<label for="RISK_INDI" readonly></label>&nbsp;&nbsp;개인(개인사업자 포함)
				</td>
				<td>
					<input type="checkbox" id="RISK_CORP" name="RISK_CORP" class="div-cont-box-checkbox" ${"Y".equals(RISK_CORP) ? "checked='checked'":""} disabled>
					<label for="RISK_CORP" readonly></label>&nbsp;&nbsp;법인
	            </td>
            </tr>
            <tr>
	            <th class="title">위험점수<span style="color:red;">*</span></th>
	            <td style="text-align: center;">
	            <input type="text" class="cond-input-text" name="RISK_SCR" id="RISK_SCR" value="" style="text-align:center"/>
	            </td>

	        	<th class="title">당연EDD 여부<span style="color:red;">*</span></th>
	            	<td>
	            	${radioel.getRadioBtns('{radioBtnID:"RISK_HRSK_YN",cdID:"N002",initValue:"",onClick:"riskGubun"}')}
	            	</td>
            </tr>
            <tr>
	            <th class="title">적용모델</th>
	            <td>
	            	<input type="checkbox" id="RISK_APPL_MODEL_I" name="RISK_APPL_MODEL_I" class="div-cont-box-checkbox"  ${"Y".equals(RISK_APPL_MODEL_I) ? "checked='checked'":""} disabled>
					<label for="RISK_APPL_MODEL_I"></label>&nbsp;&nbsp;I모델&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" id="RISK_APPL_MODEL_B" name="RISK_APPL_MODEL_B" class="div-cont-box-checkbox"  ${"Y".equals(RISK_APPL_MODEL_B) ? "checked='checked'":""} disabled>
					<label for="RISK_APPL_MODEL_B"></label>&nbsp;&nbsp;B모델
				</td>
	        	<th class="title">결재상태</th>
	            <td style="text-align: center;">
	            	<input type="text" class="cond-input-text" name="RA_SN_CCD_NM" id="RA_SN_CCD_NM" value="" style="text-align:center" readonly>
	            </td>
            </tr>
            <tr>
	            <th class="title">위험 사유</th>
	            <td colspan="3"><textarea name="RISK_RSN_DESC" id="RISK_RSN_DESC" rows="9" cols="10" style="width:100%;height:100px;"></textarea><br></td>
            </tr>
            <tr>
	            <th class="title">비고(메모)</th>
	            <td colspan="3"><textarea name="RISK_RMRK" id="RISK_RMRK" rows="9" cols="10" style="width:100%;height:100px;"></textarea><br></td>
            </tr>
		</tbody>
	</table>
</div>

	<div style="color:black;text-align:center;float:left; font-size:15px;">
	 	※ 위험 사유 또는 비고(메모)를 수정하는 경우에는 결재를 거치지 않습니다. (수정 사항 즉시 반영)
	</div>
<br>
<br>
<div class="button-area" style="float:right">
	<% if ( "4".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
		${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
    	${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"approvalBtn", defaultValue:"결재", mode:"C", function:"PopKYCPage", cssClass:"btn-36"}')}
    <% } %>
    <% if ( "104".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
    	${btnel.getButton(outputAuth, '{btnID:"sbtn_03", cdID:"approvalBtn", defaultValue:"결재", mode:"C", function:"PopKYCPage3", cssClass:"btn-36"}')}
    	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"denyBtn", defaultValue:"반려", mode:"U", function:"PopKYCPage2", cssClass:"btn-36"}')}
    <% } %>
    	${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"popupClose", cssClass:"btn-36"}')}
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />
