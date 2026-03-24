<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 결재실행
* Group           : GTONE, R&D센터/개발2본부
* Project         : 메일전송
* Author          : JYT
* Since           : 2025. 09. 18.
********************************************************************************************************************************************
--%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ page import="org.springframework.web.util.HtmlUtils"%> 
<%

String BAS_YYMM           = request.getParameter("BAS_YYMM");
String BAS_YYYY           = request.getParameter("P_BAS_YYYY");
String VALT_TRN           = request.getParameter("P_VALT_TRN");

String BRNO               = request.getParameter("BRNO");    
String MOFC_BRN_NAME      = request.getParameter("MOFC_BRN_NAME");
String BRNO_NM            = request.getParameter("BRNO_NM");
String AML_TJ_BRNO_YN     = request.getParameter("AML_TJ_BRNO_YN");
String RNM                = request.getParameter("RNM");
String RUSER_ID           = request.getParameter("RUSER_ID");
String REMAIL             = request.getParameter("REMAIL");
String BNM                = request.getParameter("BNM");
String BUSER_ID           = request.getParameter("BUSER_ID");
String BEMAIL             = request.getParameter("BEMAIL");

String VALT_SDT           = request.getParameter("VALT_SDT");
String VALT_EDT           = request.getParameter("VALT_EDT");
String TGT_TRN_SDT        = request.getParameter("TGT_TRN_SDT");
String TGT_TRN_EDT        = request.getParameter("TGT_TRN_EDT");
String GYLJ_S_C_NM        = request.getParameter("GYLJ_S_C_NM");



request.setAttribute("VALT_SDT",VALT_SDT        );
request.setAttribute("VALT_EDT",VALT_EDT        );
request.setAttribute("TGT_TRN_SDT",TGT_TRN_SDT        );
request.setAttribute("TGT_TRN_EDT",TGT_TRN_EDT        );
request.setAttribute("GYLJ_S_C_NM",GYLJ_S_C_NM        );

request.setAttribute("BAS_YYMM",BAS_YYMM); 
request.setAttribute("BAS_YYYY",BAS_YYYY);                     //기준년도
request.setAttribute("VALT_TRN",VALT_TRN );

request.setAttribute("BRNO",BRNO          );
request.setAttribute("BRNO_NM",BRNO_NM       );
request.setAttribute("AML_TJ_BRNO_YN",AML_TJ_BRNO_YN);
request.setAttribute("RNM",RNM           );
request.setAttribute("RUSER_ID",RUSER_ID      );
request.setAttribute("REMAIL",REMAIL        );
request.setAttribute("BNM",BNM           );
request.setAttribute("BUSER_ID",BUSER_ID      );
request.setAttribute("BEMAIL",BEMAIL        );

%>
<script>
	var overlay       = new Overlay();
	var pageID        = "RBA_50_04_04_02";
	var classID       = "RBA_50_04_04_02";
	
	//var BAS_YYYY = "${BAS_YYYY}";
	var BRNO = "${BRNO}";
	var BRNO_NM = "${BRNO_NM}";
	var AML_TJ_BRNO_YN = "${AML_TJ_BRNO_YN}";
	var RNM = "${RNM}";
	var RUSER_ID = "${RUSER_ID}";
	var REMAIL = "${REMAIL}";
	var BUSER_ID = "${BUSER_ID}";
	var BEMAIL = "${BEMAIL}";
	
	var VALT_SDT = "${VALT_SDT}";
	var VALT_EDT = "${VALT_EDT}";
	var TGT_TRN_SDT = "${TGT_TRN_SDT}";
	var TGT_TRN_EDT = "${TGT_TRN_EDT}";
	var GYLJ_S_C_NM = "${GYLJ_S_C_NM}";
	
	
	// Initialize
    $(document).ready(function(){
    	form1.DATA1.value = form1.BAS_YYYY.value + "년 " + form1.VALT_TRN.value + "회차";  //평가회차
    	//form1.DATA3.value = BRNO_NM;  //대상부서
        //form1.DATA4.value = RNM;      //평가직원
        
        /* form1.DATA5.value = TGT_TRN_SDT.substring(0,4) + "/" + TGT_TRN_SDT.substring(4,6) + "/" +  TGT_TRN_SDT.substring(6,8) + "~"
                          + TGT_TRN_EDT.substring(0,4) + "/" + TGT_TRN_EDT.substring(4,6) + "/" +  TGT_TRN_EDT.substring(6,8) ;  //대상기간  
        form1.DATA2.value = VALT_SDT.substring(0,4) + "/" + VALT_SDT.substring(4,6) + "/" +  VALT_SDT.substring(6,8) + "~"
                          + VALT_EDT.substring(0,4) + "/" + VALT_EDT.substring(4,6) + "/" +  VALT_EDT.substring(6,8) ;  //평가기간
         */                  
                          
         form1.DATA5.value = TGT_TRN_SDT.substring(0,4) + "/" + TGT_TRN_SDT.substring(4,6) + "/" +  TGT_TRN_SDT.substring(6,8) + "~"
         + TGT_TRN_EDT.substring(0,4) + "/" + TGT_TRN_EDT.substring(4,6) + "/" +  TGT_TRN_EDT.substring(6,8) ;  //대상기간 
        form1.DATA2.value = VALT_SDT + "~" + VALT_EDT ;  //평가기간
                          
    });
	
$(function(){
    	
    	$('.popup-contents').css({overflow:"auto"});
    	$(".chgTerm").prop("readonly",true);
    	
    	$("#A_UMS_SVC_ID").change(function(){
        	var chk = $(this).val();
        	
        	//마감
        	if(chk == '902013')
        	{
        		
        		$(".chgTerm").prop("readonly",true);
        		$(".chgDisa").prop("readonly",true);
        		$("#DATA2").val("");
        		$("#DATA3").val("");
        		$("#DATA4").val("");
        		$("#DATA5").val("");
        		$("#DATA6").val("");
        	}else if(chk == '902012'){ //독력
        		$(".chgTerm").prop("readonly",false);
        		$(".chgDisa").prop("readonly",false);
        	}else{
        		$(".chgTerm").prop("readonly",true);
        		$(".chgDisa").prop("readonly",false);
        	}	
        	
        });
    	
    	//메일 전송
    	$("button[id='btn_01']").click(function(){

    		if( GYLJ_S_C_NM != "결재완료") {    		
    			alert( "통제요소 결제완료 후, 수행 가능합니다.");
    			return;
    		}
    		
    		var param = $("form[name=form1]").serialize();
    		
    		$.ajax ( { type:'POST',
    			url: '/JSONServlet?Action@@@=com.gtone.rba.common.action.MailAction' ,
    			dataType:'text',					
    			//processData:true,
    			data: param,
    			success : function ( jsonData )
    			{
    				resultJson = JSON.parse(jsonData);
    				if(resultJson.ERRCODE != "00000"){
    					alert("메일발송이 실패하였습니다. \r\n["+resultJson.ERRMSG+"]");
    					//showAlert("메일발송이 실패하였습니다. \r\n["+resultJson.ERRMSG+"]","INFO");
    					return;
    				}else{
    					alert("메일발송이 완료되었습니다.");
    					//showAlert("메일발송이 완료되었습니다.","INFO");
    					self.close();
    				}
    			},
    			error : function(xhr, textStatus)
    			{
    				alert("Error" + textStatus);
    			}
    		});
            
    	});
});     
 
    // Initial function
    function init() { initPage(); }
       
 	// 팝업 close
    function appro_end() {
        $("button[id='btn_01']").prop('disabled', false);
        window.close();
    }
 	
</script>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top"><iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe></td>
    </tr>
</table>

<form name="form1" method="post">
    <input type="hidden" name="pageID"> 
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID"> 
    <input type="hidden" name="BAS_YYYY" value="${BAS_YYYY}">
    <input type="hidden" name="VALT_TRN" value="${VALT_TRN}">
    <input type="hidden" name="BAS_YYMM" value="${BAS_YYMM}">
    <div class="panel panel-primary" >
        <div class="panel-footer" >
            <div class="table-box" >
                <table width="100%" class="basic-table">
                	<tbody>
				        <tr>
	                    	<th class="title" style="width:120;">E-mail 안내</th>
	                    	<td>
	                        	<div class="content" >
									<select name="A_UMS_SVC_ID" id="A_UMS_SVC_ID" value="${A_UMS_SVC_ID}" class="dropdown" onChange='' >
						                <option value="902011">개시공지</option>
		                            	<option value="902012">독려</option>
		                            	<option value="902013">마감공지</option>
						            </select>
								</div>
							</td>
	                     </tr>
	                     <tr>
	                    	<th class="title">대상자</th>
	                    	<td>
	                        	<div class="content" >
									<select name="TGT_TYPE" id="TGT_TYPE" value="${TGT_TYPE}" class="dropdown" onChange='' >
						                <option value="1">RBA 담당자</option>
		                            	<option value="2">RBA 책임자</option>
		                            	<option value="3">RBA 담당자 + 책임자</option>
						            </select>
								</div>
							</td>
	                    </tr>
	                    <tr>
		                	<th class="title">평가 회차</th>
		                	<td align="left" >
	                            <input type="text" class="cond-input-text" name="DATA1" id="DATA1" value="" maxlength="20" style="width: 100%;" />
	                        </td>
		                </tr>
		                <tr>
		                	<th class="title">기간</th>
		                	<td align="left" >
	                            <input type="text" class="cond-input-text" name="DATA2" id="DATA2" value="" maxlength="20" style="width: 100%;" />
	                        </td>
		                </tr>
		                
		                
		                <tr>
	                        <th  class="title">대상 부서</th>
	                        <td align="left" >
	                            <input type="text" class="cond-input-text chgDisa" name="DATA3" id="DATA3" value="" maxlength="100" style="width: 100%;" />
	                        </td>
	                    </tr>
	                    <tr>
	                        <th  class="title">평가 직원</th>
	                        <td align="left" >
	                            <input type="text" class="cond-input-text chgDisa" name="DATA4" id="DATA4" value="" maxlength="100" style="width: 100%;" />
	                        </td>
	                    </tr>
	                    <tr>
	                        <th  class="title">평가 일시</th>
	                        <td align="left" >
	                            <input type="text" class="cond-input-text" name="DATA5" id="DATA5" value="" maxlength="100" style="width: 100%;" />
	                        </td>
	                    </tr>
		                <tr>
	                        <th class="title">기타사항</th>
	                        <td style="text-align:left;" colspan="5"> 
	                            <textarea name="DATA6" id="DATA6" class="textarea-box" style="width:100%;" rows=6 maxlength="1000" ></textarea>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="title">문의사항</th>
	                        <td style="text-align:left;" colspan="5"> 
	                            <textarea name="DATA7" id="DATA7" class="textarea-box" style="width:100%;" rows=6 maxlength="1000"></textarea>
	                        </td>
	                    </tr>
					</tbody>
                </table>
            </div>
        </div>

        
        <div align="right" style="margin-top: 8px">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"sendMailBtn", defaultValue:"메일전송", mode:"U", cssClass:"btn-36"}')}
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