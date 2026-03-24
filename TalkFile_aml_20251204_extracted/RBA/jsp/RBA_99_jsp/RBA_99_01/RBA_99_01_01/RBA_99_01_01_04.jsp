<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_04_05.jsp
- Author     : SuengRok
- Comment    : 결재요청
- Version    : 1.0
- history    : 1.0 2016-12-16
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>

<%
	String GYLJ_ID 		= request.getParameter("GYLJ_ID");
	String GYLJ_S_C 	= request.getParameter("GYLJ_S_C");			// 결재상태코드 = 0 : 미결재, 12 : 결재요청, 22 : 반려, 3 : 완료
	String GYLJ_G_C 	= request.getParameter("GYLJ_LINE_G_C");	// 결재선구분코드 = W99 : FIU지표결과관리
	String FLAG 		= request.getParameter("FLAG");				// 결재FLAG (0:결재요청, 1:반려, 2:결재)
	String RPT_GJDT		= request.getParameter("RPT_GJDT");
	String EDU_START_DT	= request.getParameter("EDU_START_DT");
	String EDU_ID		= request.getParameter("EDU_ID");
	String TABLE_NM		= request.getParameter("TABLE_NM");
	String DR_DPRT_CD	= request.getParameter("DR_DPRT_CD");
	
	String ROLE_IDS 	= sessionAML.getsAML_ROLE_ID();
	String DEPT_CD 		= sessionAML.getsAML_BDPT_CD();
	String GYLJ_JKW_NM  = sessionAML.getsAML_USER_NAME();
	
	request.setAttribute("RPT_GJDT", RPT_GJDT);
	request.setAttribute("GYLJ_ID", GYLJ_ID);
	request.setAttribute("GYLJ_S_C", GYLJ_S_C);
	request.setAttribute("GYLJ_JKW_NM", GYLJ_JKW_NM);
	request.setAttribute("ROLE_IDS",ROLE_IDS);
	request.setAttribute("DEPT_CD",DEPT_CD);
	request.setAttribute("FLAG",FLAG);
	request.setAttribute("GYLJ_G_C",GYLJ_G_C);
	request.setAttribute("EDU_START_DT",EDU_START_DT);
	request.setAttribute("EDU_ID",EDU_ID);
	request.setAttribute("TABLE_NM",TABLE_NM);
	request.setAttribute("DR_DPRT_CD",DR_DPRT_CD);
%>
<script language="JavaScript">
	/** 
	 * Initial function 
	 */ 
	var classID 	= "RBA_50_03_02_01";
	
	$(document).ready(function(){
		setInfo();
	});
	
   
    function setInfo(){
	    var GYLJ_S_C_NM = "";
	    var flag        = "${FLAG}";
	    var EDU_ID      = "${EDU_ID}";
	    var TABLE_NM    = "IC_EDU_M";
	    var BRNO      = "${DR_DPRT_CD}";
	    
	    if (flag == "0") {
	        GYLJ_S_C_NM = "${msgel.getMsg('RBA_90_01_04_05_100','결재요청')}";
	    } else if (flag == "1") {
	        GYLJ_S_C_NM = "${msgel.getMsg('RBA_90_01_04_05_101','반려')}";
	    } else if (flag == "2") {
	        GYLJ_S_C_NM = "${msgel.getMsg('RBA_90_01_04_05_102','결재')}";
	    }

    	form.GYLJ_S_C_NM.value = GYLJ_S_C_NM;
	    
	    if (flag == "0") {
	    	form.GYLJ_JKW_NM.value = "${USER_NAME}";
	    } else {
	    	form.GYLJ_JKW_NM.value = "${GYLJ_JKW_NM}";
	    }
            
    }
    
    // 결재 저장
    function doSave() {
    	
        var GYLJ_FLAG = "${FLAG}";
        var GYLJ_S_C = "";//결재상태 구분코드   12:	결재요청 22:반려  3: 완료
        
        // 결재FLAG (0:결재요청, 1:반려, 2:결재)
        if (GYLJ_FLAG == "0") {
            !showConfirm("${msgel.getMsg('RBA_90_01_04_05_103','결재요청 하시겠습니까?')}","${msgel.getMsg('RBA_90_01_04_05_102','결재')}", function() {
                return;
            });
            
            GYLJ_S_C = "12";
        } else if (GYLJ_FLAG == "1") {
            if (form.NOTE_CTNT.value == "") {
            	showAlert("${msgel.getMsg('RBA_90_01_04_05_104','반려 시 사유입력은 필수입니다.')}",'WARN');
                return;
            }
            
            !showConfirm("${msgel.getMsg('RBA_90_01_04_05_105','반려 하시겠습니까?')}","${msgel.getMsg('RBA_90_01_04_05_101','반려')}", function() {
                return;
            });
            
            GYLJ_S_C = "22";
        } else if(GYLJ_FLAG == "2") {
        	!showConfirm("${msgel.getMsg('RBA_90_01_04_05_106','결재 하시겠습니까?')}","${msgel.getMsg('RBA_90_01_04_05_102','결재')}", function() {
                return;
            });
        	
            GYLJ_S_C = "3";
        }
        
	    var obj = new Object();
	    opener.doApproval2( $("#NOTE_CTNT").val());
	    window.close();
        
        opener.doSearch();
    }
    
</script> 
    
<form name="form" method="post" action="001.do">
	<input type="hidden" name="pageID" />
	<input type="hidden" name="classID"  />
	<input type="hidden" name="methodID"  />
    
            <table class="basic-table">
				<colgroup>
					    <col width="100px">
					    <col width="">
					    <col width="100px">
					    <col width="">
				</colgroup>
				<tbody>
	                <tr>
						<th class="title">${msgel.getMsg("RBA_90_01_04_06_100","결재단계")}</th>
						<td>                        
	                        <input type="text" class="input_text" id="GYLJ_S_C_NM" name="GYLJ_S_C_NM" style="width:100%;" readOnly />
	                    </td>			
	                    <th class="title">${msgel.getMsg("RBA_90_01_04_05_200","요청자")}</th>
						<td>
						 	<input type="text" class="input_text" id="GYLJ_JKW_NM" name="GYLJ_JKW_NM" style="width:100%;" readOnly/>
						</td>									
					</tr>																
					<tr>
						<th class="title">${msgel.getMsg("RBA_90_01_04_05_201","사유")}</th>
						<td colspan="3">
							<textarea id="NOTE_CTNT" name="NOTE_CTNT" class="textarea-box" maxlength="2000" rows=5 style="height: 100;IME-MODE: active;"></textarea> 
						</td>
					</tr>
				</tbody>
             </table>
	<div class="tab-content-top"> 	
		<div class="button-area" style="margin-top:10px;">
				${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
				${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />