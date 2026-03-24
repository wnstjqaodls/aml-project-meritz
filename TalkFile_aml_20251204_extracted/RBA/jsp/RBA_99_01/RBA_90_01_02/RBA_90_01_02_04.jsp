<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_02_04.jsp
- Author     : 권얼
- Comment    : FIU 지표등록관리/등록팝업
- Version    : 1.0
- history    : 1.0 20181121
--%>

<%
	StringBuffer strGjdt = new StringBuffer(64);
	String RPT_GJDT           = Util.nvl(request.getParameter("RPT_GJDT")			, "");
	String JIPYO_FIX_YN 	  = Util.nvl(request.getParameter("JIPYO_FIX_YN") 		, "");
	
	strGjdt.append(RPT_GJDT.substring(0 , 4));
	strGjdt.append('-');
	strGjdt.append(RPT_GJDT.substring(4 , 6));
	strGjdt.append('-');
	strGjdt.append(RPT_GJDT.substring(6 , 8));
	String VIEW_RPT_GJDT = strGjdt.toString();
	//String VIEW_RPT_GJDT = RPT_GJDT.substring(0 , 4)+"-"+ RPT_GJDT.substring(4 , 6)+"-"+RPT_GJDT.substring(6 , 8);
	
	request.setAttribute("RPT_GJDT", RPT_GJDT);
	request.setAttribute("VIEW_RPT_GJDT", VIEW_RPT_GJDT);
	request.setAttribute("JIPYO_FIX_YN", JIPYO_FIX_YN); //JIPYO_FIX_YN 1 확정 0 미확정
	
%>

<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true"/> 

<script language="JavaScript">
	/** 
	 * Initial function 
	 */ 
	var classID 	= "RBA_90_01_02_04";
	
	$(document).ready(function(){		
		form1.VIEW_RPT_GJDT.readOnly	= true;
		document.getElementById("VIEW_RPT_GJDT").style.background 	= "#e5e5e5";
		
		nextSelectChangeReportIndex("JIPYO_C","${RPT_GJDT}", "A001" ,"" ,"","");
		nextSelectChangeReportIndex("VALT_G","${RPT_GJDT}", "A007" ,"" ,"","");
		nextSelectChangeReportIndex("IN_METH_C","${RPT_GJDT}", "A013" ,"" ,"","");
		nextSelectChangeReportIndex("FRMG_MABD_C","${RPT_GJDT}", "A006" ,"" ,"","");
		nextSelectChangeReportIndex("IN_V_TP_C","${RPT_GJDT}", "A008" ,"" ,"","");
		nextSelectChangeReportIndex("INP_UNIT_C","${RPT_GJDT}", "A012" ,"" ,"","");
		nextSelectChangeReportIndex("RSK_CATG","${RPT_GJDT}", "A002" ,"" ,"","INIT");
		nextSelectChangeReportIndex("RSK_FAC", "${RPT_GJDT}", "A003" ,"" ,"","INIT");
		
	});	
	
	/*
	 * KoFIU지표 코드관리 (위험구분 - 카테고리 - 항목)
	 */
	function jipyoSelectChange(v_gubun, nextGrp, GrpObj, v_afterFun) {
		var RPT_GJDT = form1.RPT_GJDT.value;
		var gubun = "";
		nextSelectChangeReportIndex(v_gubun, RPT_GJDT, nextGrp, GrpObj, v_afterFun , gubun);
	}
	
	/**
	 *  보고지표관리 상세내역 저장
	 */	
	 function onAftreJipyoCCdList() {
		nextSelectChangeReportIndex("RSK_FAC", form1.RPT_GJDT.value, "A003" ,"" ,"","INIT");
	}
	
	function doSave() {
		
		if (form1.JIPYO_FIX_YN.value=="1") {
			showAlert("확정된 기준일자의 보고지표는 수정할 수 없습니다.", "WARN");
			return;
		}
		
		if(!CheckValue()){
			return;
		}
		
		try {
			
	        $.ajax({
	            url         : "/JSONServlet?Action@@@=com.gtone.aml.common.action.DispatcherAction"
	           ,type        : "POST"
	           ,dataType    : "json"
	           ,processData : true
	           ,data        : {
	               "pageID"     		: "RBA_90_01_02_04"
	              ,"classID"    		: "RBA_90_01_02_04"
	              ,"methodID"   		: "doCheckJipyoIdx"
	              ,"CHECK_JIPYO_IDX"	: $("#JIPYO_IDX").val().trim()
	              ,"RPT_GJDT"			: $("#RPT_GJDT").val()
	           }
	           ,success : function(jsondata) {
	               try {
	                   if (jsondata&&jsondata.GRID_DATA&&jsondata.GRID_DATA.length>0) {
	                	   
	                	   if(jsondata.GRID_DATA[0]["RESULT"] == "false"){
	                		   showAlert("중복된 지표번호가 있습니다. 다시 확인해 주시기 바랍니다.", "WARN");
	                		   $("#JIPYO_IDX").focus();
	                		   return;
	                	   }else{
								showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>', "저장", doSave_Action);
	                	   }
	                   }
	               } catch (e) {showAlert(e.message, "ERR");}
	            }
	           ,error : function(xhr, textStatus) {showAlert(textStatus, "ERR");}
	        });
	    } catch (e) {showAlert(e.message, "ERR");}
	    
    }
    		
	function doSave_Action(){
		var classID		= "RBA_90_01_02_04";
		var methodID	= "doSave";
		
		var params = new Object();
		params.pageID		 = "RBA_90_01_02_04";
		params.classID		 = "RBA_90_01_02_04";	
		params.methodID		 = "doSave";	   
		params.JIPYO_IDX	 = $("#JIPYO_IDX").val().trim();     					// 지표번호
		params.RPT_GJDT		 = $("#RPT_GJDT").val();          						// 보고기준일
		params.JIPYO_NM		 = $("#JIPYO_NM").val();          						// 지표명
		params.INP_ITEM		 = $("#INP_ITEM").val();          						// 입력항목
		params.FRMG_MABD_C	 = $("#FRMG_MABD_C option:selected").val();     	// 작성주체
		params.ALLT_PNT		 = $("#ALLT_PNT").val();          						// 배점
		params.VALT_G		 = $("#VALT_G option:selected").val();          	// 평가구분
		params.IN_V_TP_C	 = $("#IN_V_TP_C option:selected").val();        	// 입력값타입
		params.WEGHT		 = $("#WEGHT").val().trim() =="" ? "0":$("#WEGHT").val().trim();		// 가중치
		params.CNCT_JIPYO_C_I= $("#CNCT_JIPYO_C_I").val();    						// 연결코드정보
		params.INP_UNIT_C	 = $("#INP_UNIT_C option:selected").val();      	// 입력단위
		params.BAS_V		 = $("#BAS_V").val();             						// 기본값
		params.IN_METH_C	 = $("#IN_METH_C option:selected").val();     		// 입력방식
		params.JIPYO_USYN	 = $("#JIPYO_USYN option:selected").val();        	// 사용여부
		params.JIPYO_DESC	 = $("#JIPYO_DESC").val();        						// 지표내용
		params.CAL_FRML		 = $("#CAL_FRML").val();          						// 산출식
		params.JIPYO_BIGO_CTNT = $("#JIPYO_BIGO_CTNT").val();   						// 지표설명
		params.EST_BAS_SCOP	 = $("#EST_BAS_SCOP").val();      						// 산정기준/범위
		params.CAL_METH		 = $("#CAL_METH").val();          						// 산출방법
		params.ANEX_CTNT	 = $("#ANEX_CTNT").val();         						// 부가설명
		params.JIPYO_ID		 = form1.JIPYO_IDX.value.replaceAll(".", "");			// JIPYO_ID
		params.JIPYO_C		 = $("#JIPYO_C option:selected").val();			// JIPYO_C
		params.RSK_CATG		 = $("#RSK_CATG option:selected").val();		// RSK_CATG
		params.RSK_FAC		 = $("#RSK_FAC option:selected").val();			// RSK_FAC		               		    
		sendService(classID, methodID, params, doSave_end, doSave_end);
	}
	
	function doSave_end() {
	 	opener.doSearch();
	 	window.close();
	}

	/**
	 *  보고지표관리 상세내역 체크
	 */	
	 
	function CheckValue(){
		
		if($("#JIPYO_IDX").val() == null || $("#JIPYO_IDX").val().trim() == ""){
				showAlert("지표번호는 필수 입니다.", "WARN");
				$("#JIPYO_IDX").focus();
				return false;
		}
		
		if($("#JIPYO_IDX").val().trim().length > 10){
			showAlert("지표번호 자릿수는 10자리입니다.", "WARN");
			$("#JIPYO_IDX").focus();
			return false;
		}
		
		var checkVal = $("#JIPYO_IDX").val().trim().replaceAll(".", "");
		var stringRegx; stringRegx = /[~!@\#$%<>^&*\()\-=+_\’]/gi; 
		
		if(stringRegx.test(checkVal)) {
			showAlert("지표번호는 '.'을 제외한 특수기호를 쓰지 않습니다.", "WARN");
			$("#JIPYO_IDX").focus();
			return false;
		}
		
		if ( $("#JIPYO_C option:selected").val() == null || $("#JIPYO_C option:selected").val() == "") {
			showAlert("위험구분은 필수 입니다.", "WARN");
			$("#JIPYO_C").focus();
			return false;
		}
		
		if ( $("#RSK_CATG option:selected").val() == null || $("#RSK_CATG option:selected").val() == "") {
			showAlert("카테고리는 필수 입니다.", "WARN");
			$("#RSK_CATG").focus();
			return false;
		}
		
		if ( $("#RSK_FAC option:selected").val() == null || $("#RSK_FAC option:selected").val() == "") {
			showAlert("항목은 필수 입니다.", "WARN");
			$("#RSK_FAC").focus();
			return false;
		}
		
		if ( $("#VALT_G option:selected").val() == null || $("#VALT_G option:selected").val() == "") {
			showAlert("평가구분은 필수 입니다.", "WARN");
			$("#VALT_G").focus();
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
		if ($("#ALLT_PNT").val() == null || $("#ALLT_PNT").val() == ""){
			showAlert("배점 정보는 필수 입니다.", "WARN");
			$("#ALLT_PNT").focus();
			return false;
		}
		
		if(!isNumber($("#ALLT_PNT").val())) {
			showAlert("배점은 숫자만 입력 가능합니다.", "WARN");
			$("#ALLT_PNT").focus();
			return false;
		}
		
		if ($("#WEGHT").val() == null || $("#WEGHT").val() == ""){
			showAlert("가중치 정보는 필수 입니다.", "WARN");
			$("#WEGHT").focus();
			return false;
		}
		
		if(!isNumber($("#WEGHT").val())) {
			showAlert("가중치는 숫자만 입력 가능합니다.", "WARN");
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
	
	
	function doSave1_end(){
		opener.doSearch();
	 	window.close();
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
<input type="hidden" id="RPT_GJDT" name="RPT_GJDT" value="${RPT_GJDT}">
<input type="hidden" id="JIPYO_FIX_YN" name="JIPYO_FIX_YN" value = "${JIPYO_FIX_YN}">
	<div class="panel panel-primary">
		<div class="panel-footer" >
			<div class="table-box">
				<table class="basic-table">
					<colgroup>
					    <col width="100px">
					    <col width="">
					    <col width="100px">
					    <col width="">
					    <col width="100px">
					    <col width="">
				   </colgroup>
				   <tbody>
					<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_002','지표번호')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="JIPYO_IDX" name="JIPYO_IDX"/>
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_003','지표명')}</th>
				    	<td colspan="3">
				    		<input type="text" class="input_text" id="JIPYO_NM" name="JIPYO_NM" onkeyup="textArea_maxLength(this);" maxlength="100" style="width:100%;min-width:150px;"/>
				    	</td>
					</tr>
				  	<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_004','위험구분')}</th>
					    <td>
					    	<select id="JIPYO_C" name="JIPYO_C" class="dropdown" style="width:100%;min-width:150px;" onchange="jipyoSelectChange('RSK_CATG', 'A002', this, 'onAftreJipyoCCdList()')"  ></select>
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_005','카테고리')}</th>
						<td>
							${JRBACondEL.getJRBASelect('MAX','RSK_CATG' ,'A002' ,'100%' ,'' ,'' ,'ALL','jipyoSelectChange("RSK_FAC", "A003", this)')}
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_006','항목')}</th>
						<td>
 							${JRBACondEL.getJRBASelect('MAX','RSK_FAC' ,'A003' ,'100%' ,'' ,'' ,'ALL','')}
						</td>
					</tr>
					<tr>	
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_014','입력항목')}</th>
				    	<td>
				    		<input type="text" class="input_text" id=INP_ITEM name="INP_ITEM" />
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_015','작성주체')}</th>
				    	<td>
				    		<select id="FRMG_MABD_C" name="FRMG_MABD_C" class="dropdown" style="width:100%;min-width:150px;" ></select>
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_016','배점')}</th>
				    	<td>
				    		<input type="text" class="input_text" id=ALLT_PNT name="ALLT_PNT" onkeyup="onlyNumber(this)" onkeypress="onlyNumber(this)" maxlength="10" style="width:100%;min-width:150px;"/>
				    	</td>				    					    	
				    </tr>	
					<tr>	
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_007','평가구분')}</th>
				    	<td>
				    		<select id="VALT_G" name="VALT_G" class="dropdown" style="width:100%;min-width:150px;"  ></select>
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_017','입력값타입')}</th>
				    	<td>
				    		<select id="IN_V_TP_C" name="IN_V_TP_C" class="dropdown" style="width:100%;min-width:150px;"  ></select>
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_018','가중치')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="WEGHT" name="WEGHT" onkeyup="onlyNumber(this)" onkeypress="onlyNumber(this)" style="width:100%;min-width:150px;"/>
				    	</td>				    					    	
				    </tr>
					<tr>	
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_019','연결코드정보')}</th>
				    	<td>
				    		<input type="text" class="input_text" id=CNCT_JIPYO_C_I name="CNCT_JIPYO_C_I" />
				    	</td>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_020','입력단위')}</th>
				    	<td>
				    		<select id="INP_UNIT_C" name="INP_UNIT_C" class="dropdown" style="width:100%;min-width:150px;"  ></select>
				    	</td>
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_021','기본값')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="BAS_V" name="BAS_V" maxlength="10" style="width:100%;min-width:150px;"/>
				    	</td>				    					    	
				    </tr>
					<tr>	
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_024','입력방식')}</th>
						<td>
							<select id="IN_METH_C" name="IN_METH_C" class="dropdown" style="width:100%;min-width:150px;"  ></select>
	    				</td>					
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_008','사용여부')}</th>
						<td>
					    	<select id="JIPYO_USYN" name="JIPYO_USYN"  class="dropdown" style="width:100%;min-width:150px;"   >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="1" selected>Y</option>												    
								<option value="0" >N</option>
							</select>	
	    				</td>	
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_001','보고기준일')}</th>
						<td>
							<input type="text" class="input_text" id="VIEW_RPT_GJDT" name="VIEW_RPT_GJDT" maxlength="11" style="width:100%;min-width:150px;" value="${VIEW_RPT_GJDT}"/>
	    				</td>	    	
				    </tr>				    
				    <tr>
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_022','지표내용')}</th>
				    	<td colspan=5>
				    		<input type="text" class="input_text" id="JIPYO_DESC" name="JIPYO_DESC" onkeyup="textArea_maxLength(this);" maxlength="100" style="width:100%;min-width:150px;"/>
				    	</td>				    
				    </tr>
				    <tr>
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_023','산출식')}</th>
				    	<td colspan=5>
				    		<input type="text" class="input_text" id="CAL_FRML" name="CAL_FRML" onkeyup="textArea_maxLength(this);" maxlength="250" style="width:100%;min-width:150px;"  />
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
				    		<textarea type="textarea" name="CAL_METH" id="CAL_METH" class="textarea-box" rows="3" maxlength="500" onkeyup="textArea_maxLength(this);" ></textarea>
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
			</div>
		</div>
		<div class="tab-content-top"> 
	    <div class="button-area"  style="margin-top: 10px;">
			${btnel.getButton(outputAuth, '{btnID:"btn5_035", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}		
		</div>	
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />