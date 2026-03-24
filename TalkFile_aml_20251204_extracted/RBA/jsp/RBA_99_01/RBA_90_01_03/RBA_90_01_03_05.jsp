<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_03_05.jsp
- Author     : 권얼
- Comment    : FIU 지표상세팝업
- Version    : 1.0
- history    : 1.0 20181121
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %> 
<%
	 
	String RPT_GJDT           = Util.nvl(request.getParameter("RPT_GJDT")			, "");
	String JIPYO_IDX		  = Util.nvl(request.getParameter("JIPYO_IDX") 			, "");
	String JIPYO_FIX_YN 	  = Util.nvl(request.getParameter("JIPYO_FIX_YN") 		, "");
	String IN_V_TP_C 	  = Util.nvl(request.getParameter("IN_V_TP_C") 		, "");
	String CNCT_JIPYO_C_I 	  = Util.nvl(request.getParameter("CNCT_JIPYO_C_I") 		, "");
	
	request.setAttribute("RPT_GJDT", RPT_GJDT);
	request.setAttribute("JIPYO_IDX",JIPYO_IDX);
	request.setAttribute("JIPYO_FIX_YN", JIPYO_FIX_YN); 		//JIPYO_FIX_YN 1 확정 0 미확정
	request.setAttribute("IN_V_TP_C",IN_V_TP_C);				//입력값 타입
	request.setAttribute("CNCT_JIPYO_C_I",CNCT_JIPYO_C_I);
%>
<script language="JavaScript">

	var classID 	= "RBA_90_01_02_02";
	var RN			= "\r\n";
	
	
	$(document).ready(function(){
		$("#EVAL_DATE_HEARDER").click(function() {
   			if($("#EVAL_DATE_HEARDER")[0].checked == true){
   				$("input[name=EVAL_DATE_SEL]:checkbox").each(function() {
   					$(this).attr("checked", true);
   				});
       		}
   			if($("#EVAL_DATE_HEARDER")[0].checked == false){
   				$("input[name=EVAL_DATE_SEL]:checkbox").each(function() {
   					$(this).attr("checked", false);
   				});
       		}
		});
		doSearch();
	});

	/**
	 *  보고지표관리 상세내역 조회
	 */
 	function doSearch() {
 		var methodID = "doDetail";
 		var obj = new Object();
 		
 		obj.pageID =  pageID;
 		obj.classID = classID;
 		obj.methodID = "doDetail";
 		obj.RPT_GJDT = "<c:out value='${param.RPT_GJDT}'/>";
		obj.CHECK_JIPYO_IDX = "<c:out value='${param.JIPYO_IDX}'/>";
		obj.JIPYO_FIX_YN = "<c:out value='${param.JIPYO_FIX_YN}'/>";
		
 		//obj.jsFunction 	= "doSearch_end";
 		
 		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
 	}
	
 	function doSearch_end(dataSource) {		
 		var cnt = dataSource.length;
 		if(cnt>0) {
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
		
 		var JIPYO_DESC  = selObj.JIPYO_DESC.trim() != "" ?"[지표내용]"+RN+selObj.JIPYO_DESC : "";
		var JIPYO_BIGO_CTNT = selObj.JIPYO_BIGO_CTNT.trim() != "" ?RN+"[지표설명]"+RN+selObj.JIPYO_BIGO_CTNT : "";
		var EST_BAS_SCOP = selObj.EST_BAS_SCOP.trim() != "" ?RN+"[산정기준/범위]"+RN+selObj.EST_BAS_SCOP : "";
		var CAL_METH = selObj.CAL_METH.trim() != "" ?RN+"[산출방법]"+RN+selObj.CAL_METH : "";
		var ANEX_CTNT = selObj.ANEX_CTNT.trim() != "" ?RN+"[부가설명]"+RN+selObj.ANEX_CTNT : "";
		
		$("#RPT_GJDT").val(selObj.RPT_GJDT);					//보고기준일자_HIDDEN
 		$("#JIPYO_C").val(selObj.JIPYO_C);						//위험구분_HIDDEN
 		$("#RSK_CATG").val(selObj.RSK_CATG);					//카테고리_HIDDEN
 		$("#RSK_FAC").val(selObj.RSK_FAC);						//항목_HIDDEN

 		$("#JIPYO_IDX_VIEW").val(selObj.JIPYO_IDX);				//지표번호
 		$("#VIEW_RPT_GJDT").val(selObj.VIEW_RPT_GJDT);			//보고기준일자
 		$("#JIPYO_C_NM").val(selObj.JIPYO_C_NM);				//위험구분
		$("#RSK_CATG_NM").val(selObj.RSK_CATG_NM);				//카테고리
 		$("#RSK_FAC_NM").val(selObj.RSK_FAC_NM);				//항목
 		$("#JIPYO_NM").val(selObj.JIPYO_NM);					//지표명

		$("#FRMG_MABD_C").val(selObj.FRMG_MABD_C);				//작성주체
		$("#FRMG_MABD_C_NM").val(selObj.FRMG_MABD_C_NM);		//작성주체
		$("#ALLT_PNT").val(selObj.ALLT_PNT);					//배점
		$("#VALT_G").val(selObj.VALT_G);						//평가구분
		$("#VALT_G_NM").val(selObj.VALT_G_NM);					//평가구분
		$("#IN_V_TP_C").val(selObj.IN_V_TP_C);					//입력값타입
		$("#IN_V_TP_C_NM").val(selObj.IN_V_TP_C_NM);			//입력값타입
		$("#WEGHT").val(selObj.WEGHT);							//가중치
		$("#CNCT_JIPYO_C_I").val(selObj.CNCT_JIPYO_C_I);		//연결코드방법
		$("#INP_UNIT_C").val(selObj.INP_UNIT_C);				//입력단위
		$("#INP_UNIT_C_NM").val(selObj.INP_UNIT_C_NM);			//입력단위
		$("#BAS_V").val(selObj.BAS_V);							//기본값
		$("#IN_METH_C").val(selObj.IN_METH_C);					//입력방식
		$("#IN_METH_C_NM").val(selObj.IN_METH_C_NM);			//입력방식
		$("#JIPYO_USYN").val(selObj.JIPYO_USYN);				//사용여부
		$("#JIPYO_USYN_NM").val(selObj.JIPYO_USYN_NM);			//사용여부
		$("#CAL_FRML").val(selObj.CAL_FRML);					//산출식
		$("#INP_ITEM").val(selObj.INP_ITEM);					//입력항목
		$("#REF_INFO").val(JIPYO_DESC+JIPYO_BIGO_CTNT+EST_BAS_SCOP+CAL_METH+ANEX_CTNT);//참조정보
		
 	}
	
</script> 
<form name="form1">
<input type="hidden" name="pageID" >
<input type="hidden" name="classID" >
<input type="hidden" name="methodID" >
<input type="hidden" id="RPT_GJDT" name="RPT_GJDT" value= "<c:out value='${RPT_GJDT}'/>">
<input type="hidden" id="JIPYO_IDX" name="JIPYO_IDX" value= "<c:out value='${JIPYO_IDX}'/>">
<input type="hidden" id="JIPYO_C" name="JIPYO_C">
<input type="hidden" id="RSK_CATG" name="RSK_CATG">
<input type="hidden" id="RSK_FAC" name="RSK_FAC">
<input type="hidden" id="JIPYO_FIX_YN" name="JIPYO_FIX_YN" value = "<c:out value='${JIPYO_FIX_YN}'/>">
<input type="hidden" id="trCnt" name="trCnt">
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
	                        <input type="text" class="input_text" id="JIPYO_IDX_VIEW" name="JIPYO_IDX_VIEW" maxlength="200" readonly="readonly" />
	                    </td>			
	                    <th class="title required">${msgel.getMsg('RBA_90_01_01_02_003','지표명')}</th>
						<td colspan="3">
						 	<input type="text" class="input_text" id="JIPYO_NM" name="JIPYO_NM"  maxlength="200" style="width:100%;" readonly="readonly"/>
						</td>									
					</tr>																
					<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_004','위험구분')}</th>
						<td>
							<input type="text" class="input_text" id="JIPYO_C_NM" name="JIPYO_C_NM" maxlength="200" readonly="readonly" />
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_005','카테고리')}</th>
						<td>
						 	<input type="text" class="input_text" id="RSK_CATG_NM" name="RSK_CATG_NM" maxlength="200" readonly="readonly"/>
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_006','항목')}</th>
						<td>
							<input type="text" class="input_text" id="RSK_FAC_NM" name="RSK_FAC_NM" maxlength="200" readonly="readonly" />	
						</td>
					</tr>
					<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_014','입력항목')}</th>
						<td>
						 	<input type="text" class="input_text" id=INP_ITEM name="INP_ITEM" readonly="readonly" />
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_015','작성주체')}</th>
						<td>
							<input type="text" class="input_text" id="FRMG_MABD_C_NM" name="FRMG_MABD_C_NM" readonly="readonly"/>
							<input type="hidden" id="FRMG_MABD_C" name="FRMG_MABD_C">
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_016','배점')}</th>
						<td>
						 	<input type="text" class="input_text" id=ALLT_PNT name="ALLT_PNT" style="text-align: right;" readonly="readonly"/>
						</td>																												
					</tr>
					<tr>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_007','평가구분')}</th>
						<td>
							<input type="text" class="input_text" id="VALT_G_NM" name="VALT_G_NM" readonly="readonly" />
							<input type="hidden" id="VALT_G" name="VALT_G">  
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_017','입력값타입')}</th>
						<td>
						 	<input type="text" class="input_text" id="IN_V_TP_C_NM" name="IN_V_TP_C_NM"  readonly="readonly" />
							<input type="hidden" id="IN_V_TP_C" name="IN_V_TP_C">
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_018','가중치')}</th>
						<td>
						 	<input type="text" class="input_text" id=WEGHT name="WEGHT" style="text-align: right;" readonly="readonly" />
						</td>
					</tr>	
					<tr>
						<th class="title">${msgel.getMsg('RBA_90_01_01_02_019','연결코드정보')}</th>
						<td>
						 	<input type="text" class="input_text" id="CNCT_JIPYO_C_I" name="CNCT_JIPYO_C_I" readonly="readonly" />
						</td>
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_020','입력단위')}</th>
						<td>
							<input type="text" class="input_text" id="INP_UNIT_C_NM" name="INP_UNIT_C_NM"  readonly="readonly" />
							<input type="hidden" id="INP_UNIT_C" name="INP_UNIT_C">	
						</td> 
						<th class="title">${msgel.getMsg('RBA_90_01_01_02_021','기본값')}</th>
						<td>
						 	<input type="text" class="input_text" id=BAS_V name="BAS_V" readonly="readonly" />
						</td>																												
					</tr>
					<tr>	
						<th class="title required">${msgel.getMsg('RBA_90_01_01_02_024','입력방식')}</th>
						<td>
							<input type="text" class="input_text" id="IN_METH_C_NM" name="IN_METH_C_NM"  readonly="readonly"/>
							<input type="hidden" id="IN_METH_C" name="IN_METH_C">	
		   				</td>					
				    	<th class="title required">${msgel.getMsg('RBA_90_01_01_02_008','사용여부')}</th>
						<td >
							<input type="text" class="input_text" id="JIPYO_USYN_NM" name="JIPYO_USYN_NM"  readonly="readonly" />
							<input type="hidden" id="JIPYO_USYN" name="JIPYO_USYN">
		   				</td>	
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_001','보고기준일자')}</th>
						<td > 
							<input type="text" class="input_text" id="VIEW_RPT_GJDT" name="VIEW_RPT_GJDT" maxlength="11" style="text-align: right; width:100%;" readonly="readonly" />	
		   				</td>	    	
				    </tr>				    
				    <tr>
				    	<th class="title">${msgel.getMsg('RBA_90_01_01_02_023','산출식')}</th>
				    	<td colspan="5">
				    		<input type="text" class="input_text" id="CAL_FRML" name="CAL_FRML" maxlength="250" style="width:100%;" readonly="readonly"/>
				    	</td>				    
				    </tr>
					<tr>
						<th class="title"><br>${msgel.getMsg('RBA_90_01_01_02_200','참조정보')}</th>
						<td colspan="5">
							<textarea type="textarea" class="textarea-box" name="REF_INFO" id="REF_INFO" class="input_text" rows="12" maxlength="2000" readonly="readonly"></textarea>
						</td>
					</tr>
					</tbody>
				</table>
        	</div>
		</div>

		<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">  
	    	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", closeBtn:"닫기", mode:"C", function:"self.close", cssClass:"btn-36"}')}
	    </div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />