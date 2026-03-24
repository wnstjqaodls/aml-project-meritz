<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_02_02.jsp
- Author     : 
- Comment    : FIU지표등록
- Version    : 
- history    : 
********************************************************************************************************************************************
* Modifier        : 이혁준
* Update          : 2018. 12. 04
* Alteration      : 
*******************************************************************************************************************************************
--%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true"/> 

<script language="JavaScript">

	/** 
	 * Initial function 
	 */ 
	var pageID 		= "RBA_90_01_02_02";
	
	$(document).ready(function(){	
		doSearch();
		setTimeout(nextSelectChangeReportIndex("VALT_G","<c:out value='${param.RPT_GJDT}'/>", "A007" ,"" ,"",""), "2000") ;
		setTimeout(nextSelectChangeReportIndex("IN_METH_C","<c:out value='${param.RPT_GJDT}'/>", "A013" ,"" ,"",""), "3000") ;
		setTimeout(nextSelectChangeReportIndex("FRMG_MABD_C","<c:out value='${param.RPT_GJDT}'/>", "A006" ,"" ,"",""), "4000") ;
		setTimeout(nextSelectChangeReportIndex("IN_V_TP_C","<c:out value='${param.RPT_GJDT}'/>", "A008" ,"" ,"",""), "5000") ;
		setTimeout(nextSelectChangeReportIndex("INP_UNIT_C","<c:out value='${param.RPT_GJDT}'/>", "A012" ,"" ,"",""), "4000") ;
		
	   $('.popup-contents').css({overflow:"auto"});
	    form1.JIPYO_IDX.readOnly		= true;
		form1.VIEW_RPT_GJDT.readOnly	= true;
		form1.JIPYO_C_NM.readOnly		= true;
		form1.RSK_CATG_NM.readOnly		= true;
		form1.RSK_FAC_NM.readOnly		= true;
		
		document.getElementById("JIPYO_IDX").style.background 		= "#e5e5e5";
		document.getElementById("VIEW_RPT_GJDT").style.background 	= "#e5e5e5";
		document.getElementById("JIPYO_C_NM").style.background 		= "#e5e5e5";
		document.getElementById("RSK_CATG_NM").style.background 	= "#e5e5e5";
		document.getElementById("RSK_FAC_NM").style.background 		= "#e5e5e5";
		
	});	
	
	/**
	 *  보고지표관리 상세내역 조회
	 */
	function doSearch() {		
		
		var classID = "RBA_90_01_02_02"; 
		var methodID = "doSearch"; 
		var obj = new Object();
		obj.pageID =  pageID;
		obj.classID = classID;
		obj.methodID = "doSearch";
		obj.RPT_GJDT = "<c:out value='${param.RPT_GJDT}'/>";
		obj.CHECK_JIPYO_IDX = "<c:out value='${param.JIPYO_IDX}'/>";
		obj.JIPYO_FIX_YN = "<c:out value='${param.JIPYO_FIX_YN}'/>";
		
		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
	}
	
	function doSearch_end(dataSource) {		
		var gridCnt = dataSource.length;
		
		if(gridCnt>0) {
			var selObj = dataSource[0];
			setTimeout(function(){
				setData(selObj);
			}, 100);
		}		
	}	
	
	/**
	 *  보고지표관리 상세내역 값 세팅
	 */
	function setData(selObj){
		
		$("#RPT_GJDT").val(selObj.RPT_GJDT);					//보고기준일자_HIDDEN
 		$("#JIPYO_C").val(selObj.JIPYO_C);					//위험구분_HIDDEN
 		$("#RSK_CATG").val(selObj.RSK_CATG);					//카테고리_HIDDEN
 		$("#RSK_FAC").val(selObj.RSK_FAC);					//항목_HIDDEN
 		$("#JIPYO_IDX").val(selObj.JIPYO_IDX);				//지표번호
 		$("#VIEW_RPT_GJDT").val(selObj.VIEW_RPT_GJDT);		//보고기준일자
 		$("#JIPYO_C_NM").val(selObj.JIPYO_C_NM);				//위험구분
		$("#RSK_CATG_NM").val(selObj.RSK_CATG_NM);			//카테고리
 		$("#RSK_FAC_NM").val(selObj.RSK_FAC_NM);				//항목
 		$("#JIPYO_NM").val(selObj.JIPYO_NM);					//지표명
		$("#JIPYO_BIGO_CTNT").val(selObj.JIPYO_BIGO_CTNT);	//지표설명
		$("#EST_BAS_SCOP").val(selObj.EST_BAS_SCOP);			//산정기준/범위
		$("#CAL_METH").val(selObj.CAL_METH);					//산출방법
		$("#ANEX_CTNT").val(selObj.ANEX_CTNT);				//부가설명

		$("#FRMG_MABD_C").val(selObj.FRMG_MABD_C);			//작성주체
		$("#ALLT_PNT").val(selObj.ALLT_PNT);					//배점
		$("#VALT_G").val(selObj.VALT_G);						//평가구분
		$("#IN_V_TP_C").val(selObj.IN_V_TP_C);				//입력값타입
		$("#WEGHT").val(selObj.WEGHT);						//가중치
		$("#CNCT_JIPYO_C_I").val(selObj.CNCT_JIPYO_C_I);		//연결코드방법
		$("#INP_UNIT_C").val(selObj.INP_UNIT_C);				//입력단위
		$("#BAS_V").val(selObj.BAS_V);						//기본값
		$("#IN_METH_C").val(selObj.IN_METH_C);				//입력방식
		$("#JIPYO_USYN").val(selObj.JIPYO_USYN);				//사용여부
		$("#JIPYO_DESC").val(selObj.JIPYO_DESC);				//지표내용
		$("#CAL_FRML").val(selObj.CAL_FRML);					//산출식
		$("#INP_ITEM").val(selObj.INP_ITEM);					//입력항목
	}	
	
	/**
	 *  보고지표관리 상세내역 저장
	 */	
	function doSave() {
		
		if (form1.JIPYO_FIX_YN.value=="1") {
			showAlert("확정된 기준일자의 보고지표는 수정할 수 없습니다.", "WARN");
			return;
		}
		
		if(!CheckValue()){
			return;
		} 
		
		showConfirm("${msgel.getMsg('doSave','저장하시겠습니까?')}", '${msgel.getMsg("AML_00_00_01_01_025","저장")}', doSave_Action)
    }	
	
	function doSave_Action(){
		var classID = "RBA_90_01_02_02"; 
		var methodID = "doSave";
		var obj 			 = new Object();
		obj.pageID           = pageID;
	    obj.classID          = classID;	
	    obj.methodID         = "doSave";	   
	    obj.JIPYO_IDX        = $("#JIPYO_IDX").val();         						// 지표번호
	    obj.RPT_GJDT         = $("#RPT_GJDT").val();          						// 보고기준일
	    obj.JIPYO_NM         = $("#JIPYO_NM").val();          						// 지표명
	    obj.INP_ITEM         = $("#INP_ITEM").val();          						// 입력항목
 	    obj.FRMG_MABD_C      = $("#FRMG_MABD_C option:selected").val();     	// 작성주체
 	    obj.ALLT_PNT         = $("#ALLT_PNT").val();          						// 배점
 	    obj.VALT_G           = $("#VALT_G option:selected").val();          	// 평가구분
 	    obj.IN_V_TP_C        = $("#IN_V_TP_C option:selected").val();        	// 입력값타입
	    obj.WEGHT            = $("#WEGHT").val();             						// 가중치
	    obj.CNCT_JIPYO_C_I   = $("#CNCT_JIPYO_C_I").val();    						// 연결코드정보
 	    obj.INP_UNIT_C       = $("#INP_UNIT_C option:selected").val();      	// 입력단위
	    obj.BAS_V            = $("#BAS_V").val();             						// 기본값
	    obj.IN_METH_C        = $("#IN_METH_C option:selected").val();     		// 입력방식
 	    obj.JIPYO_USYN       = $("#JIPYO_USYN option:selected").val();        	// 사용여부
	    obj.JIPYO_DESC       = $("#JIPYO_DESC").val();        						// 지표내용
	    obj.CAL_FRML         = $("#CAL_FRML").val();          						// 산출식
	    obj.JIPYO_BIGO_CTNT  = $("#JIPYO_BIGO_CTNT").val();   						// 지표설명
	    obj.EST_BAS_SCOP     = $("#EST_BAS_SCOP").val();      						// 산정기준/범위
	    obj.CAL_METH         = $("#CAL_METH").val();          						// 산출방법
	    obj.ANEX_CTNT        = $("#ANEX_CTNT").val();         						// 부가설명
	    obj.JIPYO_ID		 = form1.JIPYO_IDX.value.replaceAll(".", "");			// JIPYO_ID
	    obj.JIPYO_C		 	 = $("#JIPYO_C").val();									// JIPYO_C
	    obj.RSK_CATG		 = $("#RSK_CATG").val();									// RSK_CATG
	    obj.RSK_FAC		 	 = $("#RSK_FAC").val();									// RSK_FAC
	    obj.RPR_CORP_CD		 = $("#RPR_CORP_CD").val();
	    
	    sendService(classID, methodID, obj, doSave_success, doSave_fail);
	}
	
	function doSave_success() {
		setTimeout(function(){
				 	opener.doSearch();
				 	window.close();
				},500);
	}
	function doSave_fail() {
		return;
	}
	
	
	function CheckValue(){
		if ($("#JIPYO_IDX").val() == null || $("#JIPYO_IDX").val()== ""){
			showAlert("지표번호는 필수 입니다.", "WARN");
			$("#JIPYO_IDX").focus();
			return false;
		}
		if ($("#JIPYO_NM").val() == null || $("#JIPYO_NM").val() == ""){
			showAlert("지표명 정보는 필수 입니다.", "WARN");
			$("#JIPYO_NM").focus();
			return false;
		}
		if ($("#INP_ITEM").val() == null || $("#INP_ITEM").val() == ""){
			showAlert("입력항목 정보는 필수 입니다.", "WARN");
			$("#INP_ITEM").focus();
			return false;
		}
		if ($("#JIPYO_DESC").val() == null || $("#JIPYO_DESC").val() == ""){
			showAlert("지표내용 정보는 필수 입니다.", "WARN");
			$("#JIPYO_DESC").focus();
			return false;
		}
	
		if ( $("#VALT_G option:selected").val() == null || $("#VALT_G option:selected").val() == "") {
			showAlert("평가구분은 필수 입니다.", "WARN");
			$("#VALT_G").focus();
			return false;
		}
		
		if ($("#ALLT_PNT").val() == null || $("#ALLT_PNT").val() == ""){
			showAlert("배점 정보는 필수 입니다.", "WARN");
			$("#ALLT_PNT").focus();
			return false;
		}
		
		if ( isNaN(parseFloat( $("#ALLT_PNT").val() ) ) ) {
			showAlert("배점은 0~100까지의 숫자만 입력 가능합니다.", "WARN");
			$("#ALLT_PNT").focus();
			return false;
		}
		
		if ( parseFloat($("#ALLT_PNT").val()) < 0 || parseFloat($("#ALLT_PNT").val()) > 100) {
			showAlert("배점은 0~100까지의 숫자만 입력 가능합니다.", "WARN");
			$("#ALLT_PNT").focus();
			return false;
		}
		
		if ($("#WEGHT").val() == null || $("#WEGHT").val() == ""){
			showAlert("가중치 정보는 필수 입니다.", "WARN");
			$("WEGHT").focus();
			return false;
		}
		
		if ( isNaN(parseFloat( $("#WEGHT").val() ) ) ) {
			showAlert("가중치는 0~100까지의 숫자만 입력 가능합니다.", "WARN");
			$("#WEGHT").focus();
			return false;
		}
		
		if ( parseFloat($("#WEGHT").val()) < 0 || parseFloat($("#WEGHT").val()) > 100) {
			showAlert("가중치는 0~100까지의 숫자만 입력 가능합니다.", "WARN");
			$("#WEGHT").focus();
			return false;
		}
		
		if ( $("#IN_V_TP_C option:selected").val() == "C") {
			if ($("#CNCT_JIPYO_C_I").val()=="") {
				showAlert("입력값타입이 CODE인 경우는 연결코드정보를 입력해주세요.", "WARN");
				$("#CNCT_JIPYO_C_I").focus();
				return;
			}
		}
		
		
		if ($("#FRMG_MABD_C").val() == null || $("#FRMG_MABD_C").val() == ""){
			showAlert("작성주체는 필수 입니다.", "WARN");
			$("#FRMG_MABD_C").focus();
			return false;
		}
		
		if ($("#IN_V_TP_C").val() == null || $("#IN_V_TP_C").val() == ""){
			showAlert("입력값타입은 필수 입니다.", "WARN");
			$("#IN_V_TP_C").focus();
			return false;
		}
		
		if ($("#INP_UNIT_C").val() == null || $("#INP_UNIT_C").val() == ""){
			showAlert("입력단위는 필수 입니다.", "WARN");
			$("#INP_UNIT_C").focus();
			return false;
		}
		
		if ($("#IN_METH_C").val() == null || $("#IN_METH_C").val() == ""){
			showAlert("입력방식는 필수 입니다.", "WARN");
			$("#IN_METH_C").focus();
			return false;
		}
		
		if ($("#JIPYO_USYN").val() == null || $("#JIPYO_USYN").val() == ""){
			showAlert("사용여부는 필수 입니다.", "WARN");
			$("#JIPYO_USYN").focus();
			return false;
		}
		
		
		return true;
	}
	
	function doDelete() { 

		if (form1.JIPYO_FIX_YN.value=="1") {
			showAlert("확정된 기준일자의 보고지표는 삭제 할 수 없습니다.", "WARN");
			return;
		}  
				
		showConfirm("${msgel.getMsg('doDelete','삭제하시겠습니까?')}", '${msgel.getMsg("AML_00_00_01_01_027","삭제")}', doDelete_Action);
		
	}	
	
	function doDelete_Action(){
		var classID = "RBA_90_01_02_02"; 
		var methodID = "doDelete";
		var obj 				= new Object();
	   	obj.pageID 				= "RBA_90_01_02_02";
	   	obj.classID 			= "RBA_90_01_02_02";	
	   	obj.methodID 			= "doDelete";	   
	   	obj.RPT_GJDT 			= form1.RPT_GJDT.value;
		obj.JIPYO_IDX 			= form1.JIPYO_IDX.value;

		sendService(classID, methodID, obj, doDelete_success, doDelete_fail);
	}
	
	function doDelete_success() { 
		opener.doSearch();
		window.close();
	}	  
	function doDelete_fail() { 
		return;
	}	  
	  
	function onlyNumber(obj){
		var val = obj.value;
		var len = val.length;
		var rt_val = "";
		
		for(var i = 0; i < len ; i++){
			var chr = val.charAt(i);
			var ch = chr.charCodeAt();
			if ((ch < 48 || ch > 57) && (ch != 46)){
				rt_val = rt_val;
			}else{
				rt_val = rt_val + chr;
			}
		}
		obj.value = rt_val;
		obj.focus();
	}
	  
</script>

<form name="form1">
	<input type="hidden" name="pageID" >
	<input type="hidden" id="RPT_GJDT" name="RPT_GJDT">
	<input type="hidden" id="JIPYO_C" name="JIPYO_C">
	<input type="hidden" id="RSK_CATG" name="RSK_CATG">
	<input type="hidden" id="RSK_FAC" name="RSK_FAC">
	<input type="hidden" id="JIPYO_FIX_YN" name="JIPYO_FIX_YN" value = "<c:out value='${param.JIPYO_FIX_YN}'/>">

	<div class="panel panel-primary">
		<div class="panel-footer" >
			<div class="table-box">
				<table class="basic-table">
					<colgroup>
					    <col width="130px">
					    <col width="">
					    <col width="130px">
					    <col width="">
					    <col width="130px">
					    <col width="">
				   </colgroup>
				   <tbody>
					<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_002','지표번호')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="JIPYO_IDX" name="JIPYO_IDX" style="width:100%;"/>
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_003','지표명')}</th>
				    	<td colspan="3">
				    		<input type="text" class="input_text" id="JIPYO_NM" name="JIPYO_NM" onkeyup="textArea_maxLength(this);" maxlength="100" style="width:100%;"/>
				    	</td>
					</tr>
				  	<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_004','위험구분')}</th>
					    <td>
					    	<input type="text" class="input_text" id="JIPYO_C_NM" name="JIPYO_C_NM" maxlength="200" style="width:100%;" />
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_005','카테고리')}</th>
						<td>
							<input type="text" class="input_text" id="RSK_CATG_NM" name="RSK_CATG_NM" maxlength="200" style="width:100%;" />
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_006','항목')}</th>
						<td>
							<input type="text" class="input_text" id="RSK_FAC_NM" name="RSK_FAC_NM" maxlength="200" style="width:100%;" />
						</td>
					</tr>
					<tr>	
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_014','입력항목')}</th>
				    	<td>
				    		<input type="text" class="input_text" id=INP_ITEM name="INP_ITEM" />
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_015','작성주체')}</th>
				    	<td>
				    		<select id="FRMG_MABD_C" name="FRMG_MABD_C" class="dropdown" style="width: 100%"></select>
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_016','배점')}</th>
				    	<td>
				    		<input type="text" class="input_text" id=ALLT_PNT name="ALLT_PNT" onkeyup="onlyNumber(this)" onkeypress="onlyNumber(this)" maxlength="10" style="text-align: right; width:100%;"/>
				    	</td>				    					    	
				    </tr>	
					<tr>	
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_007','평가구분')}</th>
				    	<td>
				    		<select id="VALT_G" name="VALT_G" class="dropdown"  style="width: 100%"></select>
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_017','입력값타입')}</th>
				    	<td>
				    		<select id="IN_V_TP_C" name="IN_V_TP_C" class="dropdown"  style="width: 100%"></select>
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_018','가중치')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="WEGHT" name="WEGHT" onkeyup="onlyNumber(this)" onkeypress="onlyNumber(this)" style="text-align: right; width:100%;"/>
				    	</td>				    					    	
				    </tr>
					<tr>	
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_019','연결코드정보')}</th>
				    	<td>
				    		<input type="text" class="input_text" id=CNCT_JIPYO_C_I name="CNCT_JIPYO_C_I" />
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_020','입력단위')}</th>
				    	<td>
				    		<select id="INP_UNIT_C" name="INP_UNIT_C" class="dropdown"  style="width: 100%"></select>
				    	</td>
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_021','기본값')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="BAS_V" name="BAS_V" onkeyup="textArea_maxLength(this);" maxlength="10" style="width:100%;"/>
				    	</td>				    					    	
				    </tr>
					<tr>	
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_024','입력방식')}</th>
						<td>
							<select id="IN_METH_C" name="IN_METH_C" class="dropdown"  style="width: 100%"></select>
	    				</td>					
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_008','사용여부')}</th>
						<td>
					    	<select id="JIPYO_USYN" name="JIPYO_USYN"  class="dropdown" style="width: 100%" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="1" selected>Y</option>												    
								<option value="0" >N</option>
							</select>	
	    				</td>	
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_001','보고기준일자')}</th>
						<td>
							<input type="text" class="input_text" id="VIEW_RPT_GJDT" name="VIEW_RPT_GJDT" maxlength="11" style="text-align: right; width:100%;" />
	    				</td>	    	
				    </tr>				    
				    <tr>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_022','지표내용')}</th>
				    	<td colspan=5>
				    		<input type="text" class="input_text" id="JIPYO_DESC" name="JIPYO_DESC" onkeyup="textArea_maxLength(this);" maxlength="100" style="width:100%;"/>
				    	</td>				    
				    </tr>
				    <tr>
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_023','산출식')}</th>
				    	<td colspan=5>
				    		<input type="text" class="input_text" id="CAL_FRML" name="CAL_FRML" onkeyup="textArea_maxLength(this);" maxlength="250" style="width:100%;"  />
				    	</td>				    
				    </tr>				    			    					    				    				    							
				    <tr>
						<th class="title"><br>${msgel.getMsg('RBA_90_01_01_02_010','지표설명')}</th>
				    	<td colspan="5">
				    		<textarea type="textarea" name="JIPYO_BIGO_CTNT" id="JIPYO_BIGO_CTNT" class="textarea-box" rows="3" maxlength="1000" onkeyup="textArea_maxLength(this);"></textarea>
				    	</td>
				    </tr>
				    <tr>
						<th class="title"><br>${msgel.getMsg('RBA_90_01_01_02_011','산정기준/범위')}</th>
				    	<td colspan="5">
				    		<textarea type="textarea" name="EST_BAS_SCOP" id="EST_BAS_SCOP" class="textarea-box" rows="3" maxlength="1000" onkeyup="textArea_maxLength(this);"></textarea>
				    	</td>
				    </tr>	
				    <tr>
						<th class="title"><br>${msgel.getMsg('RBA_90_01_01_02_012','산출방법')}</th>
				    	<td colspan="5">
				    		<textarea type="textarea" name="CAL_METH" id="CAL_METH" class="textarea-box" rows="3" maxlength="500" onkeyup="textArea_maxLength(this);"></textarea>
				    	</td>
				    </tr>
				    <tr>
						<th class="title"><br>${msgel.getMsg('RBA_90_01_01_02_013','부가설명')}</th>
				    	<td colspan="5">
				    		<textarea type="textarea" name="ANEX_CTNT" id="ANEX_CTNT" class="textarea-box" rows="3" maxlength="2000" onkeyup="textArea_maxLength(this);"></textarea>
				    	</td>
				    </tr>
				    </tbody>	
				</table>   
				<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">  
				    ${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}	
					${btnel.getButton(outputAuth, '{btnID:"btn5_035", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
					${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}		
				</div>	
			</div>
				
		</div>

	    <div class="panel panel-primary" style="display: none;">
		    <div class="panel-footer">
		        <div id="GTDataGrid1_Area"></div>
		    </div>
	    </div>

	</div>		
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />