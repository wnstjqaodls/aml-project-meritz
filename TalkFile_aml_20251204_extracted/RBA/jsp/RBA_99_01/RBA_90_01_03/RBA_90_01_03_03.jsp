<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_03_03.jsp
- Author     : 권얼
- Comment    : FIU 지표등록관리/증빙자료첨부
- Version    : 1.0
- history    : 1.0 2018-12-26
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %> 
<%@ page import="com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_03.RBA_90_01_03_01"    %>  
<%
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
	request.setAttribute("uploadFile",uploadFile);

	String RPT_GJDT = request.getParameter("RPT_GJDT");

	StringBuffer strGjdt = new StringBuffer(64);
	strGjdt.append(RPT_GJDT.substring(0 , 4));
	strGjdt.append('-');
	strGjdt.append(RPT_GJDT.substring(4 , 6));
	strGjdt.append('-');
	strGjdt.append(RPT_GJDT.substring(6 , 8));
	String RPT_GJDT_TEMP = strGjdt.toString();

	//String RPT_GJDT_TEMP = RPT_GJDT.substring(0,4)+"-"+RPT_GJDT.substring(4,6)+"-"+RPT_GJDT.substring(6,8);
	String JIPYO_IDX = request.getParameter("JIPYO_IDX");
	String JIPYO_NM = request.getParameter("JIPYO_NM");
	String gubun = request.getParameter("gubun");
	String ATTCH_FILE_NO = request.getParameter("ATTCH_FILE_NO");
	if("0".equals(ATTCH_FILE_NO)&&"upload".equals(gubun)){
		System.out.println("gubun=upload");
		ATTCH_FILE_NO = "";
	}
	
    DataObj in = new DataObj();											 
    in.put("RPT_GJDT", RPT_GJDT);											
    in.put("JIPYO_IDX", JIPYO_IDX);											
    
    DataObj output = RBA_90_01_03_01.getInstance().getSearchF(in);
    
    if(output.getCount("FILE_SER") > 0) {                               
		request.setAttribute("FILES",output.getRowsToMap());
	}
	request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);
	request.setAttribute("RPT_GJDT", RPT_GJDT);
	request.setAttribute("RPT_GJDT_TEMP", RPT_GJDT_TEMP);
	request.setAttribute("JIPYO_IDX", JIPYO_IDX);
	request.setAttribute("JIPYO_NM", JIPYO_NM);
	request.setAttribute("gubun", gubun);
	System.out.println("ATTCH_FILE_NO#######"+ATTCH_FILE_NO);
	System.out.println("RPT_GJDT#######"+RPT_GJDT);
	System.out.println("RPT_GJDT_TEMP#######"+RPT_GJDT_TEMP);
	System.out.println("JIPYO_IDX#######"+JIPYO_IDX);
	System.out.println("JIPYO_NM#######"+ATTCH_FILE_NO);
	System.out.println("gubun#######"+gubun);
%>

<script language="JavaScript">

	var GridObj1 = null;
	var classID  = "RBA_90_01_03_03";


	function doSave(){
		form1.pageID.value = 'RBA_90_01_03_03';
		form1.afterClose.value = "N";
		
		var fileCount; 
		if(isNotEmpty(form1.elements["storedFileNms"]))
		{
			fileCount = form1.elements["storedFileNms"].length;
			if(fileCount > 1){
			    showMsgPop('${msgel.getMsg("RBA_90_01_04_02_100","파일을 2개 이상 첨부할 수 없습니다.")}');
	            return false;
	        }	
		} else {showAlert('${msgel.getMsg("RBA_90_01_03_03_201","증빙자료를 선택해주세요")}',"INFO"); return false;}	
		
		showConfirm('${msgel.getMsg("RBA_90_01_06_01_109","저장하시겠습니까")}', "저장", 	function(){
			var option = {
					url : '${ctx}/rba/90_01_03_03_doSaveFile.do',
					dataType : 'json',				
					success : function(data){					
						if(data.status == 'success')
						{
							showAlert(data.serviceMessage, "INFO");	
							doSave_end();
						}	
						else
						{
							showAlert(data.serviceMessage, "ERR");
						}	
					}				 
			};
			$('#form1').ajaxSubmit(option);
			return false;
		});
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
	 function doSave_end(){
		opener.doSearch();
		window.close();
	 }
	
	 //파일 다운
	 function downloadFile(f,o,p)
	 {
		$("[name=pageID]", "#fileFrm").val("RBA_90_01_03_03");
	 	$("#downFileName").val(f);
	 	$("#orgFileName").val(o); 
	 	if("upload"=="${gubun}"){
	 		$("#downFilePath").val($("#filePaths").val()); 	
	 	}else{
	 		$("#downFilePath").val(p);
	 	}
	 	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
	 	$("#fileFrm").submit();
	 }
</script>
<!-- 파일 삭제, 다운로드 -->
<form name="fileFrm" id="fileFrm" method="POST">
<input type="hidden" name="pageID" />
<input type="hidden" name="downFileName" id="downFileName" value="" />
<input type="hidden" name="orgFileName" id="orgFileName" value="" />
<input type="hidden" name="downFilePath" id="downFilePath" value="" />
<input type="hidden" name="downType" id="downType" value="JIPYO" />
</form>

<form name="form1" id ="form1" method="post" >
	<input type="hidden" name="pageID" />
	<input type="hidden" name="classID"  />
	<input type="hidden" name="methodID"  />
	<input type="hidden" id="methodID" name="methodID"/>
	<input type="hidden" id="afterClose" name="afterClose"/>
    <input type="hidden" name="mode" value="insert" />
    <input type="hidden" name="RPT_GJDT" value="${RPT_GJDT}" />
    <input type="hidden" name="JIPYO_IDX" value="${JIPYO_IDX}" />
	<input type="hidden" name="ATTCH_FILE_NO"  value="${ATTCH_FILE_NO}"/>    
    <div class="tab-content-bottom">
        <div class="statistics-table" >
            <table class="basic-table">
				<colgroup>
				    <col width="100px">
				    <col width="">
				    <col width="100px">
				    <col width="">
				</colgroup>
				<tbody>
                <tr>
                    <th class="title" width="20%">${msgel.getMsg("RBA_90_01_01_02_001","보고기준일")}</th>
                    <td width="30%" align="left" colspan="3">${RPT_GJDT_TEMP}</td>
                </tr>
                <tr>
                    <th class="title" width="20%">${msgel.getMsg("RBA_90_01_01_02_002","지표번호")}</th>
                    <td width="30%">${JIPYO_IDX}</td>
                    <th class="title" width="20%">${msgel.getMsg("RBA_90_01_01_02_003","지표명")}</th>
                    <td width="30%">${JIPYO_NM}</td>
                </tr>
                <tr>	
					<th class="title">${msgel.getMsg("RBA_90_01_01_03_200","첨부자료")}</th>	    
				    <td colspan="3" valign="top" style="padding:10 10 10 10;" align="center">
					    <c:choose>
	                    	<c:when test="${'download' eq gubun}">	<!-- 그리드에서 'Y'링크를 누르고 들어온 경우. 삭제,파일등록을 막는다. -->
	                    		<table id="NotiAttachTable" width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#F5F9F8" style="border-right:solid 1px #CCCCCC;">
			                        <tr>
			                            <td height="22" align="center"  width="85%"><fmt:message key="AML_90_01_03_04_001" initVal="업로드 된 파일"/></td>
			                        </tr>  
	<%
					if (output != null) {
							String FILE_SER = "";
							String FILE_POS = "";
							String LOSC_FILE_NM = "";
							String PHSC_FILE_NM = "";
									
								FILE_SER = "1";
								FILE_POS = output.getText("FILE_POS");
								LOSC_FILE_NM = output.getText("LOSC_FILE_NM");
								PHSC_FILE_NM = output.getText("PHSC_FILE_NM");
							System.out.println("LOSC_FILE_NM########"+LOSC_FILE_NM);
							System.out.println("FILE_SER########"+FILE_SER);
							System.out.println("FILE_POS########"+FILE_POS);
							System.out.println("PHSC_FILE_NM########"+PHSC_FILE_NM);
							System.out.println("gubun########"+gubun);
								
								request.setAttribute("FILE_SER",FILE_SER);			
								request.setAttribute("FILE_POS",FILE_POS);		
								request.setAttribute("LOSC_FILE_NM",LOSC_FILE_NM);			
								request.setAttribute("PHSC_FILE_NM",PHSC_FILE_NM);	
								if ("download".equals(gubun)) {
	%>
			                        <tr>
										<td height="22" align="center" bgcolor="#FFFFFF">
			                            	<img src="Package/ext/images/icon/ico_save.gif" width="13" height="13" align="absmiddle">
			                            	<a href="javascript:void(0);" onClick="downloadFile('${PHSC_FILE_NM}','${LOSC_FILE_NM}','${FILE_POS}')" >
												<c:out value="${LOSC_FILE_NM }"/>
											</a>
			                            </td>
			                        </tr>
			                        	<%
								}}
	%>
			                    </table>
	                    	</c:when>
	                    	<c:otherwise>
				    			<div style="height:130px;overflow-y:auto;">
	                    		<table id="NotiAttachTable" width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#F5F9F8" style="border-right:solid 1px #CCCCCC;">
									<tr>
										<td style="border: 1px solid #ccc">
											<div class="widget-container" style="height: 100%; -ms-overflow-y: auto;">
												<div id="file-uploader" style="margin-top:10px;"></div>
												<div class="content" id="selected-files">
													<div>
														<h4>${msgel.getMsg("RBA_90_01_03_03_200","※ 업로드 된 파일 목록")}</h4>
													</div>
													<div id="fileBox" >
														<c:forEach items="${FILES }" var="result" varStatus="status">
														            <c:set var="i" value="${status.index}" />
																    <div id="file${i}" class="tx dx-fileuploader-button-container">
																    	<i class="fa fa-floppy-o" style="font-size: 14px;margin-left: 3px;" aria-hidden="true"></i>
																    	<a href="javascript:void(0);" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" >
																   	 		<c:out value="${result.LOSC_FILE_NM }"/>
																    	</a>								    	
																    	<a onclick="viewDelete(this);" > <input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.fileSize }"/>"/>
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
	                    	</c:otherwise>
	                   	</c:choose>
				    </td>   
				</tr>
				</tbody>
             </table>
        </div>

		<div class="panel-footer" >
			<table border=0 width=100%>
				<tr class="tab-content-top"> 
					<td class="button-area">
						<c:if test="${'upload' eq gubun}">
							${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}	
						</c:if>
						${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", closeBtn:"닫기", mode:"R", function:"doSave_end", cssClass:"btn-36"}')}	
					</td>
				</tr>	
			</table>
		</div>
	</div>		
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		 <tr>
			<td valign="top">
				<iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
			</td>
		</tr>
	</table>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />
