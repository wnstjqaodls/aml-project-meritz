<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_01_04.jsp
* Description     : 첨부파일 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-25
--%>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_01.RBA_50_05_01_03"    %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
	request.setAttribute("uploadFile",uploadFile);

    String BAS_YYMM = Util.nvl(request.getParameter("P_BAS_YYMM"));
    String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
    String VALT_BRNO = Util.nvl(request.getParameter("VALT_BRNO"));
    String PROC_FLD_C = Util.nvl(request.getParameter("PROC_FLD_C"));
    String PROC_LGDV_C = Util.nvl(request.getParameter("PROC_LGDV_C"));
    String PROC_MDDV_C = Util.nvl(request.getParameter("PROC_MDDV_C"));
    String PROC_SMDV_C = Util.nvl(request.getParameter("PROC_SMDV_C"));
    String RSK_VALT_PNT = Util.nvl(request.getParameter("RSK_VALT_PNT"));

    request.setAttribute("BAS_YYMM",BAS_YYMM);
    request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);
    request.setAttribute("VALT_BRNO",VALT_BRNO);
    request.setAttribute("PROC_FLD_C",PROC_FLD_C);
    request.setAttribute("PROC_LGDV_C",PROC_LGDV_C);
    request.setAttribute("PROC_MDDV_C",PROC_MDDV_C);
    request.setAttribute("PROC_SMDV_C",PROC_SMDV_C);
    request.setAttribute("RSK_VALT_PNT",RSK_VALT_PNT);
    
    DataObj in = new DataObj();										 
    in.put("BAS_YYMM", BAS_YYMM);
    in.put("VALT_BRNO", VALT_BRNO);	
    in.put("PROC_SMDV_C", PROC_SMDV_C);	
    DataObj output = RBA_50_05_01_03.getInstance().getSearchF(in);
    
    if(output.getCount("FILE_SER") > 0) {                               
		request.setAttribute("FILES",output.getRowsToMap());
	}	
%>

<script language="JavaScript">

    var File_Count=0;
    var flag=0;

    function doSave(){

        showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){

        	var option = {
    				url : '${ctx}/rba/RBA_50_05_01_03doSave.do',
    				dataType : 'json',				
    				success : function(data){		
    					if(data.status == 'success')
    					{
    						showAlert(data.serviceMessage,"INFO",doSave_end);
    						//doSave_end();
    					}	
    					else
    					{
    						showAlert(data.serviceMessage,"ERR");
    					}	
    				}				 
    		};
        	
    		$('#form1').ajaxSubmit(option);
    		return false;
        });
    }

    function doSave_end(){
        opener.doSearch2();
        window.close();
    }
 
 $(function(){
		var allowedFileExtensions = "${uploadFile}";
		var fileUploader = gtFileUploader("file-uploader",allowedFileExtensions,doSubmit_end,true,false);
		
 });
 
 function doSubmit_end(fileData)
 {
	 var addLine;
     var divId = fileData.storedFileNm.substring(0,fileData.storedFileNm.lastIndexOf("."));
    	
    	if(fileData != undefined)
    	{
    		addLine	= "<div id='"+divId+"'>"
    				+"<i class='fa fa-floppy-o' style='font-size: 14px;margin-left: 3px;' aria-hidden='true'></i>"
    				+fileData.origFileNm
    				+"&nbsp;&nbsp;&nbsp;"
    				+"<a onclick=\"tempFileDel('"+divId+"','/upload/attachTmp/','"+fileData.storedFileNm+"');\" >"
    				+"<input type='hidden' name='fileSizes' id='fileSizes' class='fileSize' value='"+fileData.fileSize+"' />"
    				+"<input type='hidden' name='origFileNms' id='origFileNms' class='origFileNm' value='"+fileData.origFileNm+"' />"
    				+"<input type='hidden' name='storedFileNms' id='storedFileNms' class='storedFileNm' value='"+fileData.storedFileNm+"' />"
    				+"<input type='hidden' name='filePaths' id='filePaths' class='filePath' value='"+fileData.filePath+"' />"
    				+"<div class='dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon' role='button' aria-hidden='true' aria-label='close'>"
    				+"	<div class='dx-button-content'>&nbsp;<i class='dx-icon dx-icon-close'></i></div>"
    				+"</div>"
    				+"</a>"
    				+"</div>";
    		$("#fileBox").append(addLine);		      		 
    	}
 }
 
 function downloadFile(f,o,e)
 {
 	$("#downFileName").val(f);
 	$("#orgFileName").val(o); 	
 	$("#downFilePath").val($("#filePaths").val());
 	$("#FILE_SEQ").val(e);
 	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
 	$("#fileFrm").submit();
 }
 
</script>
 <form name="fileFrm" id="fileFrm" method="POST">
<input type="hidden" name="downFileName" id="downFileName" value="" />
<input type="hidden" name="orgFileName" id="orgFileName" value="" />
<input type="hidden" name="downFilePath" id="downFilePath" value="" />
<input type="hidden" name="downType" id="downType" value="RBA" />
<input type="hidden" name="FILE_SEQ" 	id="FILE_SEQ" value= ""/>
</form> 
<form name="form1" id="form1" method="post">
    <input type="hidden" name="pageID" />
    <input type="hidden" name="classID"  />
    <input type="hidden" name="methodID"  />
    <!-- <input type="hidden" name="FIU_RPT_GJDT"  /> -->
    <input type="hidden" id="methodID" name="methodID"/>
    <input type="hidden" id="flag" name="flag"/>
    <input type="hidden" id="afterClose" name="afterClose"/>
    <input type="hidden" name="VALT_BRNO" value="${VALT_BRNO}" >
    <input type="hidden" name="ATTCH_FILE_NO" value="${ATTCH_FILE_NO}" >
    <input type="hidden" name="RSK_VALT_PNT" value="${RSK_VALT_PNT}" >
    <input type="hidden" name="PROC_FLD_C" value="${PROC_FLD_C}" >
    <input type="hidden" name="PROC_LGDV_C" value="${PROC_LGDV_C}" >
    <input type="hidden" name="PROC_MDDV_C" value="${PROC_MDDV_C}" >
    <input type="hidden" name="PROC_SMDV_C" value="${PROC_SMDV_C}" >
    <input type="hidden"  name="BAS_YYMM" value="${BAS_YYMM}"/>
    <input type="hidden" name="mode" value="insert" />
    
    <div class="tab-content-bottom">
	 	<div class="statistics-table">
	 		<table class="basic-table">
	 			<colgroup>
	 				<col width="130px">
	 				<col width="">
	 			</colgroup>
	 			
	 			<tbody>
					<tr>
						<th class="title">${msgel.getMsg('RBA_50_08_03_02_001','첨부파일')}</th>
						<td colspan="3" valign="middle" align="center">
                    <div style="height:150px;overflow-y:auto;">
		                 <table id="NotiAttachTable" width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#F5F9F8" style="border-right:solid 1px #CCCCCC;">
							<tr>
								<td style="border: 1px solid #ccc">
									<div class="widget-container" style="height: 100%; -ms-overflow-y: auto;">
										<div id="file-uploader" style="margin-top:10px;"></div>
										<div class="content" id="selected-files">
											<div>
						                        <h4>※&nbsp;${msgel.getMsg('RBA_50_01_01_233','업로드 된 파일 목록')}</h4>
						                    </div>    
						                    <div id="fileBox">
					                 			<c:forEach items="${FILES }" var="result" varStatus="status">
									                <c:set var="i" value="${status.index}" />
												    <div id="file${i}" class="tx dx-fileuploader-button-container">
												    	<i class="fa fa-floppy-o" style="font-size: 14px;margin-left: 3px;" aria-hidden="true"></i>
												    	<a href="javascript:void(0);" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}','${result.FILE_SER}')" >
												    		<c:out value="${result.LOSC_FILE_NM }"/>
												    	</a>								    	
												    	<a onclick="viewDelete(this);" > 
													    	<input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.FILE_SIZE }"/>"/>
												    		<input name="origFileNms" class="origFileNms" type="hidden" value="<c:out value="${result.LOSC_FILE_NM }"/>"/>
												    		<input name="storedFileNms" class="storedFileNms" type="hidden" value="<c:out value="${result.PHSC_FILE_NM }"/>"/>
												    		<input name="filePaths" id="filePaths" class="filePaths" type="hidden" value="<c:out value="${result.FILE_POS }"/>"/>
											    			<div class="dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon" style="margin-left: 10px;"  role="button" aria-hidden="true" aria-label="close">
						                  						<div class="dx-button-content" style="padding-left: 0.2em;">&nbsp;<i class="dx-icon dx-icon-close" ></i></div>
						                  					</div>
											    		</a>							    		
												    </div>
												    <br/>
										       </c:forEach>
										   </div>	    
										</div>
									</div>
								</td>
							</tr>
		                 </table>
		                 </div>
                    </td>
					</tr>	 					
	 			</tbody> 			
	 		</table>
	 	</div> 	
	 </div>

 <div style="margin-top: 8px">
            <table width="100%" border="0" >
                <tr>
                    <td>
                        <table border="0" align="right" class="btn_area">
                            <tr>
                                <td>
                                    ${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
        							${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
</form>

<iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>

<!-- <table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
        <td valign="top"> 
            <iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
        </td>
    </tr>
</table> -->
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />