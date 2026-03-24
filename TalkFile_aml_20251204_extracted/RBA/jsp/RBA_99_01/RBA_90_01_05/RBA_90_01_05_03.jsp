<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_05_03.jsp
- Author     : 
- Comment    : FIU지표 상세
- Version    : 
- history    : 
********************************************************************************************************************************************
* Modifier        : 백승록
* Update          : 2018. 12. 17
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
	var GridObj1 = null;
	var pageID 		= "RBA_90_01_02_02";
	var classID 	= "RBA_90_01_02_02";
	
	$(document).ready(function(){		
	   init();
	   setupGrids();
	   $('.popup-contents').css({overflow:"auto"});
	});	
	
	function init() {
		var date; date = "<c:out value='${param.RPT_GJDT}'/>";  //보안취약성 보완

	    var year = date.substring(0,4);
		var month = date.substring(4,6);
		var day = date.substring(6,8);
		var RPT_GJDT = year+"-"+month+"-"+day;
	   	form1.RPT_GJDT.value = RPT_GJDT;
	   	
		if 	("<c:out value='${param.MODIFY}'/>" == "Y"){
			form1.JIPYO_IDX.readOnly= true;
		}	   	
	}

	/** 그리드 초기화 함수 셋업 */
	function setupGrids(){
	    GridObj1 = initGrid3({
	        gridId          : 'GTDataGrid1'
	       ,headerId        : 'RBA_90_01_02_02_Grid1'
	       ,gridAreaId      : 'GTDataGrid1_Area'
	       ,height          : 'calc(20vh - 100px)'
	       ,useAuthYN       : '${outputAuth.USE_YN}'
	       //,gridHeadTitle   : '보고지표 등록'
	       ,completedEvent  : function(){
	    	   doSearch();
	        }
	    });
	}	
	
	/**
	 *  보고지표관리 상세내역 조회
	 */
	function doSearch() {		
		var obj = new Object();
		obj.pageID =  pageID;
		obj.classID = classID;
		obj.methodID = "doSearch";
		obj.RPT_GJDT = "<c:out value='${param.RPT_GJDT}'/>";
		obj.JIPYO_IDX = "<c:out value='${param.JIPYO_IDX}'/>";
		
		GridObj1.refresh({
	    	actionParam     : obj
	    	,completedEvent  : doSearch_end    
		});
	}
	
	function doSearch_end() {		
		var gridCnt = GridObj1.rowCount();
		
		if(gridCnt>0) {
			var selObj = GridObj1.getRow(0);
			setData(selObj);
		}		
	}	
	
	/**
	 *  보고지표관리 상세내역 값 세팅
	 */
	function setData(selObj){

		var form1 = document.form1;
		
		form1.JIPYO_IDX.value 	    	= selObj.JIPYO_IDX;
		form1.JIPYO_NM.value 	    	= selObj.JIPYO_NM;
		form1.INP_ITEM.value			= selObj.INP_ITEM;
		form1.ALLT_PNT.value			= selObj.ALLT_PNT;
		form1.WEGHT.value				= selObj.WEGHT;
		form1.CNCT_JIPYO_C_I.value		= selObj.CNCT_JIPYO_C_I;
		form1.BAS_V.value				= selObj.BAS_V;
		form1.JIPYO_DESC.value			= selObj.JIPYO_DESC;
		form1.JIPYO_BIGO_CTNT.value		= selObj.JIPYO_BIGO_CTNT;
		form1.JIPYO_USYN.value			= selObj.JIPYO_USYN;		
		form1.CAL_FRML.value			= selObj.CAL_FRML;
		form1.EST_BAS_SCOP.value		= selObj.EST_BAS_SCOP;
		form1.CAL_METH.value			= selObj.CAL_METH;
		form1.ANEX_CTNT.value			= selObj.ANEX_CTNT;
		
		form1.A001.value				= selObj.JIPYO_C;
		form1.A002.value				= selObj.RSK_CATG;
		form1.A003.value				= selObj.RSK_FAC;
		form1.FRMG_MABD_C.value			= selObj.FRMG_MABD_C;
		form1.VALT_G.value 				= selObj.VALT_G;
		form1.IN_V_TP_C.value			= selObj.IN_V_TP_C;
		form1.INP_UNIT_C.value			= selObj.INP_UNIT_C;
		form1.IN_METH_C.value			= selObj.IN_METH_C;
		form1.JIPYO_USYN.value			= selObj.JIPYO_USYN;
		
		form1.JIPYO_BIGO_CTNT.title = form1.JIPYO_BIGO_CTNT.value;
		form1.EST_BAS_SCOP.title = form1.EST_BAS_SCOP.value;
		form1.CAL_METH.title = form1.CAL_METH.value;
		form1.ANEX_CTNT.title = form1.ANEX_CTNT.value;
		
		$('input').prop('disabled',true);
		$('textarea').prop('disabled',true);
		$('select').prop('disabled',true);
	}	
	
	  
</script>

<form name="form2" method="post" >
	<input type="hidden" name="pageID" >
	<input type="hidden" name="JIPYO_IDX" value="<c:out value='${param.JIPYO_IDX}'/>">
	<input type="hidden" name="RPT_GJDT" value="<c:out value='${param.RPT_GJDT}'/>">
</form>

<form name="form1">
	<input type="hidden" name="pageID" >

	<div class="panel panel-primary">
		<div class="panel-footer" >
			<div class="table-box">
				<table class="hover">
					<tr>
						<th>${msgel.getMsg('RBA_90_01_01_02_002','지표번호')}*</th>
				    	<td>
				    		<input type="text" class="input_text" id="JIPYO_IDX" name="JIPYO_IDX" onkeyup="textArea_maxLength(this);" maxlength="10" style="width:100%;"/>
				    	</td>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_003','지표명')}*</th>
				    	<td colspan="3">
				    		<input type="text" class="input_text" id="JIPYO_NM" name="JIPYO_NM" onkeyup="textArea_maxLength(this);" maxlength="100" style="width:100%;"/>
				    	</td>
					</tr>
				  	<tr>
						<th>${msgel.getMsg('RBA_90_01_01_02_004','위험구분')}*</th>
					    <td>
							<select id="A001" name="A001"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="I" >고유위험</option>												    
								<option value="O" >운영위험</option>
							</select>
						</td>
						<th>${msgel.getMsg('RBA_90_01_01_02_005','카테고리')}*</th>
						<td>
							<select id="A002" name="A002"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="1" >1.전사통제정책</option>												    
								<option value="2" >2.내부통제</option>
								<option value="3" >3.고객확인</option>
								<option value="4" >4.위험관리</option>
								<option value="5" >5.모니터링 및 보고관리</option>
							</select>
						</td>
						<th>${msgel.getMsg('RBA_90_01_01_02_006','항목')}*</th>
						<td>
							<select id="A003" name="A003"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="101" >101.통제환경</option>												    
								<option value="201" >201.전담조직의 독립성 및 전문성</option>
								<option value="202" >202.교육 및 연수</option>
								<option value="203" >203.직원알기제도</option>
								<option value="204" >204.독립적 감사체계</option>
								<option value="205" >205.보안절차</option>
							</select>
						</td>
					</tr>
					<tr>	
				    	<th>${msgel.getMsg('RBA_90_01_01_02_014','입력항목')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="INP_ITEM" name="INP_ITEM" onkeyup="textArea_maxLength(this);" maxlength="50" style="width:100%;"/>
				    	</td>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_015','작성주체')}</th>
				    	<td>
							<select id="FRMG_MABD_C" name="FRMG_MABD_C"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="1" >금융회사</option>												    
								<option value="2" >KoFIU</option>
							</select>
				    	</td>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_016','배점')}*</th>
				    	<td>
				    		<input type="text" class="input_text" id="ALLT_PNT" name="ALLT_PNT" onkeyup="textArea_maxLength(this);" maxlength="10" style="width:100%;"/>
				    	</td>				    					    	
				    </tr>	
					<tr>	
				    	<th>${msgel.getMsg('RBA_90_01_01_02_007','평가구분')}</th>
				    	<td>
							<select id="VALT_G" name="VALT_G"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="1" >Range 평가</option>												    
								<option value="2" >상대비율평가</option>
								<option value="4" >여부평가</option>
							</select>
				    	</td>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_017','입력값타입')}</th>
				    	<td>
							<select id=IN_V_TP_C name="IN_V_TP_C"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="C" >CODE</option>												    
								<option value="N" >NUMBER</option>
								<option value="T" >TEXT</option>
							</select>
				    	</td>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_018','가중치')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="WEGHT" name="WEGHT" onkeyup="textArea_maxLength(this);" maxlength="10" style="width:100%;"/>
				    	</td>				    					    	
				    </tr>
					<tr>	
				    	<th>${msgel.getMsg('RBA_90_01_01_02_019','연결코드정보')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="CNCT_JIPYO_C_I" name="CNCT_JIPYO_C_I" onkeyup="textArea_maxLength(this);" maxlength="10" style="width:100%;"/>
				    	</td>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_020','입력단위')}</th>
				    	<td>
							<select id=INP_UNIT_C name="INP_UNIT_C"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="11" >개수</option>												    
								<option value="12" >건수</option>
								<option value="13" >횟수</option>
								<option value="14" >비율</option>												    
								<option value="15" >명</option>
								<option value="17" >카드수</option>
								<option value="18" >회원수</option>												    
								<option value="22" >예금금액(확인필요)</option>
								<option value="23" >백만원</option>
								<option value="24" >천원</option>												    
								<option value="25" >천달러</option>
								<option value="31" >시간</option>																
								<option value="33" >개월수</option>
								<option value="41" >여부</option>
								<option value="42" >구분</option>
							</select>
				    	</td>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_021','기본값')}</th>
				    	<td>
				    		<input type="text" class="input_text" id="BAS_V" name="BAS_V" onkeyup="textArea_maxLength(this);" maxlength="10" style="width:100%;"/>
				    	</td>				    					    	
				    </tr>
					<tr>	
				    	<th>${msgel.getMsg('RBA_90_01_01_02_024','입력방식')}</th>
						<td>
							<select id="IN_METH_C" name="IN_METH_C"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionAll','전체')}::</option>	
								<option value="1" >자동</option>												    
								<option value="2" >수동</option>
							</select>	
	    				</td>					
				    	<th>${msgel.getMsg('RBA_90_01_01_02_008','사용여부')}</th>
						<td>
					    	<select id="JIPYO_USYN" name="JIPYO_USYN"  class="cond-select" >
								<option value="">::${msgel.getMsg('optionSelect','선택')}::</option>	
								<option value="1" selected>Y</option>												    
								<option value="0" >N</option>
							</select>	
	    				</td>	
				    	<th>${msgel.getMsg('RBA_90_01_01_02_001','보고기준일')}</th>
						<td>
							<input type="text" class="input_text" id="RPT_GJDT" name="RPT_GJDT" onkeyup="textArea_maxLength(this);" maxlength="10" style="width:100%;" disabled />	
	    				</td>	    	
				    </tr>				    
				    <tr>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_022','지표내용')}*</th>
				    	<td colspan=5>
				    		<input type="text" class="input_text" id="JIPYO_DESC" name="JIPYO_DESC" onkeyup="textArea_maxLength(this);" maxlength="100" style="width:100%;"/>
				    	</td>				    
				    </tr>
				    <tr>
				    	<th>${msgel.getMsg('RBA_90_01_01_02_023','산출식')}</th>
				    	<td colspan=5>
				    		<input type="text" class="input_text" id="CAL_FRML" name="CAL_FRML" onkeyup="textArea_maxLength(this);" maxlength="250" style="width:100%;"  />
				    	</td>				    
				    </tr>				    			    					    				    				    							
				    <tr>
						<th><br>${msgel.getMsg('RBA_90_01_01_02_010','지표설명')}</th>
				    	<td colspan="5">
				    		<textarea type="textarea" name="JIPYO_BIGO_CTNT" id="JIPYO_BIGO_CTNT" class="input_text" rows="3" maxlength="1000" onkeyup="textArea_maxLength(this);"></textarea>
				    	</td>
				    </tr>
				    <tr>
						<th><br>${msgel.getMsg('RBA_90_01_01_02_011','산정기준/범위')}</th>
				    	<td colspan="5">
				    		<textarea type="textarea" name="EST_BAS_SCOP" id="EST_BAS_SCOP" class="input_text" rows="3" maxlength="1000" onkeyup="textArea_maxLength(this);"></textarea>
				    	</td>
				    </tr>	
				    <tr>
						<th><br>${msgel.getMsg('RBA_90_01_01_02_012','산출방법')}</th>
				    	<td colspan="5">
				    		<textarea type="textarea" name="CAL_METH" id="CAL_METH" class="input_text" rows="3" maxlength="500" onkeyup="textArea_maxLength(this);" ></textarea>
				    	</td>
				    </tr>
				    <tr>
						<th><br>${msgel.getMsg('RBA_90_01_01_02_013','부가설명')}</th>
				    	<td colspan="5">
				    		<textarea type="textarea" name="ANEX_CTNT" id="ANEX_CTNT" class="input_text" rows="3" maxlength="2000" onkeyup="textArea_maxLength(this);"></textarea>
				    	</td>
				    </tr>	
				</table>
			</div>
		</div>

	    <div class="panel panel-primary" style="display: none;">
		    <div class="panel-footer">
		        <div id="GTDataGrid1_Area"></div>
		    </div>
	    </div>
	    
	    <div class="panel-heading-button"  style="margin-top: 10px;">
			${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}		
		</div>	
	</div>		
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />
