<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_04_04.jsp
* Description     : 교육계획및 현황 첨부파일 다운로드 팝업창
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 9.
********************************************************************************************************************************************
--%>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	DataObj output = (DataObj)request.getAttribute("output");
	String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
	
	request.setAttribute("ATTCH_FILE_NO"      ,ATTCH_FILE_NO    );
%>
<script>
    var GridObj1    = null;
    var classID = "RBA_50_08_04_02";
   
    /** Initial function */
    $(document).ready( function() {

    	$('.popup-contents').css({overflow:"auto"});
    	
    	setupGrids();
    });

    // Initial function
    function init() { 
    	initPage(); 
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_08_04_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : '교육계획및 현황관리'
           ,completedEvent  : function(){               
               }
        });
    }

    function doClose()
    {
        window.close();
    }

    //첨부파일 다운로드
    function downloadFile( FILE_SER )
    {
        $("input[name=FILE_SER]").val(FILE_SER);
        form1.target = "_self";
        form1.action = "Package/RBA/common/fileDown/fileDownload.jsp";
        form1.method = "post";  
        form1.submit();
    }    

</script>

<form name="form1" id="form1" method="post">
    <input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="ATTCH_FILE_NO" value="${ATTCH_FILE_NO}" >
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
        <tr>
            <td colspan="4">
							<table style="width:100%">
								<tr>
									<td width="100%" >
									<!------------------------------------------------------------>
										<table id="NotiAttachTable" style="width:100%; border:0; cellpadding:2; cellspacing:1; bgcolor:''" >
											<script language="javascript">

											</script> 
									        <tr>
									            <th height="22" align="center" style="width:45%">${msgel.getMsg('uploadFile','새로올릴 파일')}</th>
									        </tr>  
<%
   if(output.getCount("FILE_SER") != 0) {
       String FILE_SER = "";
       String FILE_POS = "";
       String LOSC_FILE_NM = "";
       String PHSC_FILE_NM = "";
       String FILE_SIZE = "";
       String DOWNLOAD_CNT = "";
       
       for(int i = 0 ; i < output.getCount("FILE_SER") ; i++) {
           FILE_SER     = output.getText("FILE_SER",i);
           FILE_POS     = output.getText("FILE_POS",i);
           LOSC_FILE_NM = output.getText("LOSC_FILE_NM",i);
           PHSC_FILE_NM = output.getText("PHSC_FILE_NM",i);
           FILE_SIZE    = output.getText("FILE_SIZE",i);
           DOWNLOAD_CNT = output.getText("DOWNLOAD_CNT",i);
           
           request.setAttribute("FILE_SER",FILE_SER);
           request.setAttribute("FILE_POS",FILE_POS);
           request.setAttribute("LOSC_FILE_NM",LOSC_FILE_NM);
           request.setAttribute("PHSC_FILE_NM",PHSC_FILE_NM);
           request.setAttribute("FILE_SIZE",FILE_SIZE);
           request.setAttribute("DOWNLOAD_CNT",DOWNLOAD_CNT);
 %>
			                                <tr>
			                                    <td height="22" align="left" bgcolor="#FFFFFF" >
			                                        <img src="Package/ext/images/icon/ico_save.gif" width="13" height="13" align="absmiddle">
			                                        <a class="file" href='javascript:downloadFile("${FILE_SER}");'><c:out value='${LOSC_FILE_NM}'/></a>
			                                        <input type="hidden" name="FILE_SER"                value="${FILE_SER}">
			                                        <input type="hidden" name="FILE_POS_temp"           value="${FILE_POS}">
			                                        <input type="hidden" name="LOSC_FILE_NM_temp"       value="${LOSC_FILE_NM}">
			                                        <input type="hidden" name="PHSC_FILE_NM_temp"       value="${PHSC_FILE_NM}">
			                                        <input type="hidden" name="FILE_SIZE_temp"          value="${FILE_SIZE}">
			                                        <input type="hidden" name="DOWNLOAD_CNT_temp"       value="${DOWNLOAD_CNT}">
			                                        <input type="hidden" name="FILE_POS${FILE_SER}"     value="${FILE_POS}${PHSC_FILE_NM}">
			                                        <input type="hidden" name="LOSC_FILE_NM${FILE_SER}" value="${LOSC_FILE_NM}"> 
			                                    </td>
			                                </tr>
<%
    	}
    }
%>

										</table>
									</td>
								</tr>
							</table>
			</td>
        </tr>
        </table>
    </div>
</div>

<div class="popup-cont-box">
    <div class="cond-btn-row" style="text-align:right;margin-top:10px;">
        <span id ="sbtn_03" >
        </span>
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-power-off", show:"N"}')}
    </div>
</div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 