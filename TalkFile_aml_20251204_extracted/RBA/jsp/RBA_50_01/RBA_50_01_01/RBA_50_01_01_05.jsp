<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_01_05.jsp
* Description     : 첨부파일 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : CSH
* Since           : 2018-04-25
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" /> 
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
	request.setAttribute("uploadFile",uploadFile);

	String BAS_YYMM = Util.nvl(request.getParameter("P_BAS_YYMM"));
	String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
	if("0".equals(ATTCH_FILE_NO)){
		ATTCH_FILE_NO = "";
	}
	request.setAttribute("BAS_YYMM",BAS_YYMM);
	request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);
	DataObj output = (DataObj) request.getAttribute("output");
	if(output.getCount("FILE_SER") != 0) {
		request.setAttribute("FILES",output.getRowsToMap());		
	}
	System.out.println("ATTCH_FILE_NO#####"+ATTCH_FILE_NO);
	
%>

<script language="JavaScript">

	var File_Count=0;
	var flag=0;
	
	function init(){
		initPage();
	}
	
	function setupConditions(){
        try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0);
            cbox1.setItemWidths(100, 90, 0);
            cbox1.setItemWidths(100, 100, 1);
        } catch (e) {
        	showAlert(e.message,'ERR');
        }
	}
		
	function doSave(){

		var fileCount; 
		if(isNotEmpty(form1.elements["storedFileNms"]))
		{
			fileCount = form1.elements["storedFileNms"].length;
			if(fileCount > 2){
			    showAlert('파일을 2개이상 첨부할수 없습니다.','WARN');
	            return false;
	        }	
		}	
		
		showConfirm("${msgel.getMsg('doSave','저장하시겠습니까?')}", "저장",function(){
			var option = {
					url : '${ctx}/rba/doSave.do',
					dataType : 'json',				
					success : function(data){					
						
						if(data.status == 'success')
						{
							showAlert(data.serviceMessage,'INFO');
							opener.doSearch();
					        window.close();
						}	
						else
						{
							showAlert(data.serviceMessage,'ERR');
						}	
						
					}				 
			};
			$('#form1').ajaxSubmit(option);
			return false;
		});
		
		
		//form1.FIU_RPT_GJDT.value = FIU_RPT_GJDT_TEMP;
		/* form1.pageID.value 		 = 'RBA_50_01_01_06';
		form1.afterClose.value 	 = "N";
		form1.target 			 = "submitFrame";
		form1.action 			 = "<c:url value='/'/>0001.do"; */
		//form1.encoding 			 = "multipart/form-data";
		//showMsgPop("팝업 테스트");
		//form1.submit();

	}
	
	function doSave_end(){
		opener.doSearch2();
		window.close();
	}

$(function(){
	setupConditions();
	
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

 function downloadFile( FILE_SER){       
     
     form2.FILE_SER.value       = FILE_SER;
     form2.ATTCH_FILE_NO.value  = "${ATTCH_FILE_NO}";
     form2.target               = "_self";
     //form2.action               = "/WEB-INF/Package/RBA/common/fileDown/fileDownload.jsp";
     form2.pageID.value 		 = 'fileDownload';
	 form2.action 			     = "<c:url value='/'/>0001.do";
     form2.method               = "post";  
     form2.submit();
 }
  
 //파일 다운
 function fsDown(f,o)
 {
	$("[name=pageID]"     ,"form[name=fileFrm]").val(pageID);
	$("#downFileName").val(f);
 	$("#orgFileName").val(o); 	
 	$("#downFilePath").val($("#filePaths").val()); 	
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
<input type="hidden" name="downType" id="downType" value="RBA" />
</form>

<form name="form2" method="post" >
	<input type="hidden" name="pageID" />
	<input type="hidden" name="classID"  />
	<input type="hidden" name="methodID"  />
	<input type="hidden" name="FILE_SER"  />
	<input type="hidden" name="ATTCH_FILE_NO"  />
</form>	

<form name="form1" id="form1" method="post">
	<input type="hidden" name="pageID" value="${pageID}" />
	<input type="hidden" name="classID"  />
	<input type="hidden" name="methodID"  />
	<input type="hidden" id="flag" name="flag"/>
	<input type="hidden" id="afterClose" name="afterClose"/>
	<input type="hidden" name="ATTCH_FILE_NO" value="${ATTCH_FILE_NO}" >
    <input type="hidden" name="mode" value="insert" />
 <%--    
<div class="linear-table" id="condBox1">
	<div class="table-row">
    	<div class="table-cell">
      		${condel.getLabel('RBA_50_01_01_027','기준년월')}  
       	 	<div class="content">
       	 		<input type="text" class="cond-input-text" name="BAS_YYMM" value="${BAS_YYMM}" style="border: 0px;" readonly="readonly"/>
       	  		${condel.getInputCustomerNo('RBA_10_05_01_001','보고기준일','RPT_GJDT',RPT_GJDT,'','','','','')}
       		</div>
       </div>
	</div>
</div>

<div class="tab-content-bottom" id="condBox2" style="margin-top:20px;">

	<div class="table-cell">
		<div class="widget-container">
			<div id="file-uploader"></div>
			<div class="content" id="selected-files">
				<table id="NotiAttachTable" border="0" cellpadding="2" cellspacing="1" bgcolor="#F5F9F8" style="border:solid 1px #CCCCCC; margin-left: auto; margin-right: auto; min-height:200px;">
			        <tr>
			            <td height="22" align="center" width="20%">
			            	<div style="text-align:center;">업로드 된 파일 목록</div>
			            </td>

						<td height="22" align="center" bgcolor="#FFFFFF" style="vertical-align: top;">
							<div id="fileBox" >
                    			
                    			<c:forEach items="${FILES }" var="result" varStatus="status">
						            <c:set var="i" value="${status.index}" />
								    <div id="file${i}" class="tx dx-fileuploader-button-container">
								    	<i class="fa fa-floppy-o" style="font-size: 14px;margin-left: 3px;" aria-hidden="true"></i>
								    	<a href="javascript:void(0);" onClick="fsDown('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" >
								    	<c:out value="${result.LOSC_FILE_NM }"/>
								    	</a>								    	
								    	<a onclick="viewDelete(this);" > 
									    	<input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.fileSize }"/>"/>
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
		                </td>
		            </tr>
				</table>
			</div>
		</div>
	
		
	</div>
</div>
	
	 --%>
	 
	 <div class="tab-content-bottom">
	 	<div class="statistics-table">
	 		<table class="basic-table">
	 			<colgroup>
	 				<col width="180px">
	 				<col width="">
	 			</colgroup>
	 			
	 			<tbody>
	 				<tr>
	 					<th class="title">${msgel.getMsg("RBA_50_05_03_01_001","기준년월")}</th>
	 					<td class="content">
			       	 		<input type="text" class="cond-input-text" name="BAS_YYMM" value="${BAS_YYMM}" style="border: 0px;" readonly="readonly"/>
	 					</td>
	 				</tr>
					<tr>
						<th class="title">${msgel.getMsg("RBA_50_08_03_02_001","첨부파일")}</th>
						<td colspan="3" valign="top" style="padding:10 10 10 10;" align="center">
                    <div style="height:150px;overflow-y:auto;">
		                 <table id="NotiAttachTable" width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#F5F9F8" style="border-right:solid 1px #CCCCCC;">
							<tr>
								<td style="border: 1px solid #ccc">
									<div class="widget-container" style="height: 100%; -ms-overflow-y: auto;">
										<div id="file-uploader" style="margin-top:10px;"></div>
										<div class="content" id="selected-files">
											<div>
												<h4>${msgel.getMsg("RBA_50_01_01_204","※ 업로드 할 파일 목록")}</h4>
											</div>
											<div id="fileBox" >
												<c:forEach items="${FILES }" var="result" varStatus="status">
													<c:set var="i" value="${status.index}" />
													<div id="file${i}" class="tx dx-fileuploader-button-container">
														<i class="fa fa-floppy-o" style="font-size: 14px;margin-left: 3px;" aria-hidden="true"></i>
														<a href="javascript:void(0);" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" >
															<c:out value="${result.LOSC_FILE_NM }"/>
														</a> 
														<a onclick="viewDelete(this);" > 
													    	<input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.fileSize }"/>"/>
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


	<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">  
	 	${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
		${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
	</div>
	
</form>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 	