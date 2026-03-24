<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_03_02_02.jsp
* Description     : 위험평가 지표관리 등록/수정 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-04-30
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ page import="org.springframework.web.util.HtmlUtils"%> 
<%
	
	String BAS_YYMM   = HtmlUtils.htmlEscape(StringHelper.evl(Util.nvl(request.getParameter("BAS_YYMM")), ""));
	String RSK_ELMT_C = HtmlUtils.htmlEscape(StringHelper.evl(Util.nvl(request.getParameter("RSK_ELMT_C")), ""));
	String FLAG       = HtmlUtils.htmlEscape(StringHelper.evl(Util.nvl(request.getParameter("FLAG")), ""));
	String EDD_YN2    = HtmlUtils.htmlEscape(StringHelper.evl(Util.nvl(request.getParameter("EDD_YN")), ""));
	String RA_ITEM_CODE = HtmlUtils.htmlEscape(StringHelper.evl(Util.nvl(request.getParameter("RA_ITEM_CODE")), ""));
	String GYLJ_S_C_NM  = HtmlUtils.htmlEscape(StringHelper.evl(Util.nvl(request.getParameter("GYLJ_S_C_NM")), ""));
	//String RSK_VALT_ITEM  = HtmlUtils.htmlEscape(StringHelper.evl(Util.nvl(request.getParameter("RSK_VALT_ITEM")), ""));
	
	
    request.setAttribute("BAS_YYMM",BAS_YYMM);
    request.setAttribute("RSK_ELMT_C",RSK_ELMT_C);
    request.setAttribute("FLAG",FLAG);
    request.setAttribute("EDD_YN2",EDD_YN2);
    request.setAttribute("RA_ITEM_CODE",RA_ITEM_CODE);
    request.setAttribute("GYLJ_S_C_NM",GYLJ_S_C_NM);
    //request.setAttribute("RSK_VALT_ITEM",RSK_VALT_ITEM);
%>
<script language="JavaScript">
    
    var GridObj1;
    var classID = "RBA_50_03_02_02";
    var pageID = "RBA_50_03_02_02";
    
    var FIRST_ROLE_ID ="";
    var GYLJ_S_C_NM = "${GYLJ_S_C_NM}";
   // var RSK_VALT_ITEM = "${RSK_VALT_ITEM}";
    
    // Initialize
    $(document).ready(function(){

        $('.popup-contents').css({overflow:"auto"});
        $("#CNTL_CATG1_C").attr("style","width:150px;");
        $("#CNTL_CATG2_C") .attr("style","width:200px;");
        $("#CNTL_ELMN_C") .attr("style","width:150px;");
        doSearch();
        
        
    });
    
    // Initial function
    function init() { initPage();}
    
    
    //위험평가지표관리 상세 조회
    function doSearch(){
    	    
        var classID  = "RBA_50_03_02_02"; 
        var methodID = "doSearch";
        var params = new Object();
        params.pageID	= pageID;
        params.BAS_YYMM  	= "${BAS_YYMM}";
        params.RSK_ELMT_C 	= "${RSK_ELMT_C}";
        params.RA_ITEM_CODE = "${RA_ITEM_CODE}";
        params.TABLE_NM	= "SRBA_RISK_ELMT_M";
        sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }
    //위험평가지표관리 상세 완료
    function doSearch_success(gridData, data){
        var selObj = gridData[0];
        setData(selObj);
    }
    function doSearch_fail(){    	 
    	overlay.hide();
    }
    //위험평가지표관리 상세 HTML에 데이타 삽입
    function setData(selObj){

        form1.RSK_CATG1_C_NM.value  	 = selObj.RSK_CATG1_C_NM; 			
        form1.RSK_VALT_ITEM.value        = selObj.RSK_VALT_ITEM;
    	form1.RSK_ELMT_C_NM.value      	 = selObj.RSK_ELMT_C_NM; 
    	form1.RA_INTV_VAL.value          = (selObj.RA_INTV_VAL  == undefined)?"":selObj.RA_INTV_VAL;
    	form1.RSK_VALT_CAL_STD.value     = (selObj.RSK_VALT_CAL_STD       	   == undefined)?"":selObj.RSK_VALT_CAL_STD;
    	form1.USE_YN1.value    	         = (selObj.USE_YN      == undefined)?"":selObj.USE_YN; 
    	
    	
     	
    	form1.INDV_YN.value    = (selObj.INDV_YN   == undefined)?"":selObj.INDV_YN;
    	form1.CORP_YN.value    = (selObj.CORP_YN   == undefined)?"":selObj.CORP_YN;
    	form1.I_MODEL_YN.value    = (selObj.I_MODEL_YN   == undefined)?"":selObj.I_MODEL_YN;
    	form1.B_MODEL_YN.value    = (selObj.B_MODEL_YN   == undefined)?"":selObj.B_MODEL_YN; 
    	
    	
    	form1.RSK_ELMT_DTL_CTNT.value    = (selObj.RSK_ELMT_DTL_CTNT   == undefined)?"":selObj.RSK_ELMT_DTL_CTNT;
    	form1.COMMENT_CTNT.value    = (selObj.COMMENT_CTNT   == undefined)?"":selObj.COMMENT_CTNT;
    	form1.RSK_PNT.value   = (selObj.RSK_PNT  == undefined)?"":selObj.RSK_PNT;
    	
    	
    	if(form1.FLAG.value == "0"){ //구분이 0이면 RA신규위험요소정보
    		//alert( "test popup2 : " + form1.FLAG.value + "   EDD_YN2 : " + form1.EDD_YN2.value);
    		form1.EDD_YN.value   = form1.EDD_YN2.value;
    		//form1.RSK_PNT.value  = 10;
    		
        } else { //그외는 위험요소관리에서 호출
        	form1.EDD_YN.value    = (selObj.EDD_YN   == undefined)?"":selObj.EDD_YN; 
        	//form1.RSK_PNT.value   = (selObj.RSK_PNT  == undefined)?"":selObj.RSK_PNT;
        }
    	
    }

    
    //위험평가지표관리 상세 저장
    function doSave() {

    	if( GYLJ_S_C_NM != "미입력" && GYLJ_S_C_NM != "반려" && GYLJ_S_C_NM != "") {
    		showAlert("결재상태 미입력 또는 반려 일때만 수정, 삭제 가능합니다.",'WARN');
    		return;
    	}

		 showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>', '${msgel.getMsg("AML_00_00_01_01_025","저장")}', doSave_Action);
    }

    function doSave_Action(){

		var methodID    = "doSave";
		var obj = new Object();
		var classID  = "RBA_50_03_02_02"; 
		
		//alert( "call save : " + form1.BAS_YYMM.value);
		
		obj.pageID            = "RBA_50_03_02_02";					//"RBA_50_04_03_02";
		obj.BAS_YYMM 	      = form1.BAS_YYMM.value; //"${BAS_YYMM}";		//평가년월
		obj.RSK_ELMT_C        = form1.RSK_ELMT_C.value; //"${RSK_ELMT_C}";
		obj.USE_YN            = form1.USE_YN1.value; //"${USE_YN1}";
		obj.RSK_PNT           = form1.RSK_PNT.value; //"${RSK_PNT}";
		obj.RSK_ELMT_DTL_CTNT = form1.RSK_ELMT_DTL_CTNT.value; //"${RSK_ELMT_DTL_CTNT}";
		obj.COMMENT_CTNT      = form1.COMMENT_CTNT.value; //"${COMMENT_CTNT}";
		obj.RA_ITEM_CODE      = form1.RA_ITEM_CODE.value;
		obj.RSK_VALT_ITEM     = form1.RSK_VALT_ITEM.value;
		obj.EDD_YN            = form1.EDD_YN.value;
		obj.RSK_VALT_CAL_STD  = form1.RSK_VALT_CAL_STD.value;
		
		sendService(classID, methodID, obj, doSave_end, doSave_end);
   }
  
    //위험평가지표관리 상세 완료
    function doSave_end() { 
       opener.doSearch();
       window.close();
    }
  
    
	
	
</script>
<!-- 저장용 iframe -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top"><iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe></td>
    </tr>
</table>


<form name="form3" method="post" >
    <input type="hidden" name="pageID" > 
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="SEND_3_BAS_YYMM" id="SEND_3_BAS_YYMM">
    <input type="hidden" name="SEND_3_CNTL_CATG1_C" id="SEND_3_CNTL_CATG1_C">
    <input type="hidden" name="SEND_3_CNTL_CATG2_C" id="SEND_3_CNTL_CATG2_C">
    <input type="hidden" name="SEND_3_RSK_INDCT" id="SEND_3_RSK_INDCT">
    <input type="hidden" name="SEND_3_GYLJ_ID" id="SEND_3_GYLJ_ID">
    <input type="hidden" name="SEND_3_FLAG" id="SEND_3_FLAG">
    <input type="hidden" name="SEND_3_GYLJ_G_C" id="SEND_3_GYLJ_G_C">
</form>

<form name="form1" id="form1" method="post">
<input type="hidden" name="pageID">
<input type="hidden" name="classID"> 
<input type="hidden" name="methodID">
<input type="hidden" name="GUBN">
<input type="hidden" name="BAS_YYMM"   value="${BAS_YYMM}">
<input type="hidden" name="RSK_ELMT_C" value="${RSK_ELMT_C}">
<input type="hidden" name="RA_ITEM_CODE" value="${RA_ITEM_CODE}">
<input type="hidden" name="FLAG"       value="${FLAG}">
<input type="hidden" name="EDD_YN2"    value="${EDD_YN2}">
<input type="hidden" name="mode">

    <div class="panel panel-primary" >
        <div class="panel-footer" >
            <div class="table-box" >
                <table width="100%" class="basic-table">
                	<tbody>
				        <tr>
	                    	<th class="title" style="width:400;">${msgel.getMsg('RBA_50_03_02_01_002','위험분류')}</th>
	                    	<td style="text-align: left;">
		                		<input type="text" name="RSK_CATG1_C_NM" id="RSK_CATG1_C_NM"  class="cond-input-text"  value="${RSK_CATG1_C_NM}" style="text-align: left; width: 100%" readonly />
		                	</td>
	                    	
	                        <th class="title">${msgel.getMsg('RBA_50_03_02_01_003','평가항목')}</th>
	                        <td style="text-align: left;">
	                        	${SRBACondEL.getSRBASelect('RSK_VALT_ITEM', '', '', 'R342', '', '', '', '', '', '')}
		                	</td>
	                    </tr>
	                     <tr>
	                    	<th class="title">${msgel.getMsg('RBA_50_03_02_01_008','위험요소')}</th>
	                    	<td style="text-align: left;">
		                		<input type="text" name="RSK_ELMT_C_NM" id="RSK_ELMT_C_NM"  class="cond-input-text"  value="${RSK_ELMT_C_NM}" style="text-align: left; width: 100%" readonly />
		                	</td>
		                	<%-- <th class="title">${msgel.getMsg('RBA_50_03_02_01_003','평가항목')}</th>
	                        <td style="text-align: left;">
		                		<input type="text" name="RSK_VALT_ITEM_NM" id="RSK_VALT_ITEM_NM"  class="cond-input-text"  value="${RSK_VALT_ITEM_NM}" style="text-align: left; width: 100%" readonly />
		                	</td> --%>
	                    </tr>
	                    <tr>
		                	<th class="title">${msgel.getMsg('RBA_50_03_02_01_009','구간값')}</th>
		                	<td style="text-align: left;">
		                		<input type="text" name="RA_INTV_VAL" id="RA_INTV_VAL"  class="cond-input-text"  value="${RA_INTV_VAL}" style="text-align: left; width: 100%" readonly />
		                	</td>
		                </tr>
		                <tr>
		                	<th class="title">${msgel.getMsg('RBA_50_03_02_01_010','지표')}</th>
		                	<td style="text-align: left;">
		                		<div class="content" >
									<select name="RSK_VALT_CAL_STD" id="RSK_VALT_CAL_STD" value="${RSK_VALT_CAL_STD}" class="dropdown" > <!-- disabled > -->
						                <option value='1' >고객수</option>
						                <option value='0' >거래금액</option>
						            </select>
								</div>
		                	</td>
		                	<th class="title required">${msgel.getMsg('RBA_50_04_01_02_004','사용여부')}</th>
							<td>
	                        	<div class="content" >
									<select name="USE_YN1" id="USE_YN1" value="${USE_YN1}" class="dropdown" onChange='' >
						                <option value='1' >Y</option>
						                <option value='0' >N</option>
						            </select>
								</div>
							</td>
		                </tr>
		                <tr>
	                    	<th class="title required">${msgel.getMsg('RBA_50_03_02_01_013','위험점수')}</th>
	                    	<td style="text-align: left;">
		                		<input type="text" name="RSK_PNT" id="RSK_PNT" class="cond-input-text" value="${RSK_PNT}" style="text-align: left; width: 100%" />
		                	</td>
	                        <th class="title ">${msgel.getMsg('RBA_50_03_02_01_004','당연EDD여부')}</th>
	                        <td style="text-align: left;">
		                		<div class="content" >
									<select name="EDD_YN" id="EDD_YN" value="${EDD_YN}" class="dropdown" disabled >
						                <option value='H' >H</option>
						                <option value='Y' >Y</option>
						                <option value='N' >N</option>
						            </select>
								</div>
		                	</td>
	                    </tr>
		                <tr>
	                    	<th class="title ">${msgel.getMsg('RBA_50_03_02_01_005','적용대상')}</th>
	                    	<td style="text-align: left;" >
		                		<div class="content" >
									<select name="INDV_YN" id="INDV_YN" value="${INDV_YN}" class="dropdown" disabled >
						                <option value='1' >▣ 개인(개인사업자포함)</option>
						                <option value='0' >□ 개인</option>
						            </select>
								</div>
		                	</td>
		                	<td style="text-align: left;" >
		                		<div class="content" >
									<select name="CORP_YN" id="CORP_YN" value="${CORP_YN}" class="dropdown" disabled >
						                <option value='1' >▣ 법인</option>
						                <option value='0' >□ 법인</option>
						            </select>
								</div>
		                	</td>
	                        
	                    </tr>
	                    <tr>
	                    	<th class="title">${msgel.getMsg('RBA_50_03_02_01_006','적용모델')}</th>
		                	<td style="text-align: left;width: 50%" >
		                		<div class="content" >
									<select name="I_MODEL_YN" id="I_MODEL_YN" value="${I_MODEL_YN}" class="dropdown" disabled >
						                <option value='1' >▣ I모델</option>
						                <option value='0' >□ I모델</option>
						            </select>
								</div>
		                	</td>
		                	<td style="text-align: left;" >
		                		<div class="content" >
									<select name="B_MODEL_YN" id="B_MODEL_YN" value="${B_MODEL_YN}" class="dropdown" disabled >
						                <option value='1' >▣ B모델</option>
						                <option value='0' >□ B모델</option>
						            </select>
								</div>
		                	</td>
	                    </tr>
	                   
		                <tr>
	                        <th class="title">${msgel.getMsg('RBA_50_03_02_028','위험사유')}</th>
	                        <td style="text-align:left;" colspan="5"> 
	                            <textarea name="RSK_ELMT_DTL_CTNT" id="RSK_ELMT_DTL_CTNT" class="textarea-box" style="width:100%;" rows=6 maxlength="1000" readonly></textarea>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="title">${msgel.getMsg('RBA_50_03_02_029','비고(메모)')}</th>
	                        <td style="text-align:left;" colspan="5"> 
	                            <textarea name="COMMENT_CTNT" id="COMMENT_CTNT" class="textarea-box" style="width:100%;" rows=6 maxlength="1000"></textarea>
	                        </td>
	                    </tr>
                    
		                
		                
	
	
					</tbody>
				
				
                </table>
            </div>
        </div>

        
        <div align="right" style="margin-top: 8px">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
            <%-- ${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')} --%>
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')}
        </div>
    </div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />