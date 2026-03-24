<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_90_01_04_02.jsp
- Author     : SuengRok
- Comment    : FIU 첨부파일 팝업
- Version    : 1.0
- history    : 1.0 2016-12-16
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%
	String uploadFileXls = PropertyService.getInstance().getProperty("aml.config","upload.file.xls");
	request.setAttribute("uploadFileXls",uploadFileXls);

	String RPT_GJDT = Util.nvl(request.getParameter("RPT_GJDT"),"");
	StringBuffer strGjdt = new StringBuffer(64);
		strGjdt.append(RPT_GJDT.substring(0 , 4));
		strGjdt.append('-');
		strGjdt.append(RPT_GJDT.substring(4 , 6));
		strGjdt.append('-');
		strGjdt.append(RPT_GJDT.substring(6 , 8));
	String VIEW_RPT_GJDT = strGjdt.toString();
	//String VIEW_RPT_GJDT = RPT_GJDT.substring(0 , 4)+"-"+ RPT_GJDT.substring(4 , 6)+"-"+RPT_GJDT.substring(6 , 8);

	if (RPT_GJDT == null) {
		  return;
	} else {
		RPT_GJDT = RPT_GJDT.replaceAll("<","&lt;");
		RPT_GJDT = RPT_GJDT.replaceAll(">","&gt;");
	}

	request.setAttribute("RPT_GJDT", RPT_GJDT);
	request.setAttribute("VIEW_RPT_GJDT", VIEW_RPT_GJDT);

%>
<script language="JavaScript">
	var overlay     = new Overlay();
	var File_Count=0;
	var flag=0;

	function init(){
		initPage();
	}

	function doSave(){
		if (!CHK_Value()) {
			return;
		}
		showConfirm("${msgel.getMsg('doSave','저장하시겠습니까?')}", "저장", doSave_Action);
	}

	function doSave_Action(){
		overlay.show(true, true);
		form1.pageID.value = 'RBA_90_01_03_06';
		form1.afterClose.value = "N";

		var option = {
				url : '${ctx}/rba/90_01_03_06_doSaveFile.do',
				dataType : 'json',
				success : function(data){
					if(data.status == 'success')
					{
						overlay.hide();
						showAlert(data.serviceMessage, "INFO");
						doSave_end();
					}
					else
					{
						overlay.hide();
						showAlert(data.serviceMessage, "ERR");
					}
				}
		};
		$('#form1').ajaxSubmit(option);
		return false;
	}

	function CHK_Value(){

		if (form1.RPT_GJDT.value=="") {
		   	showAlert('보고기준일을 입력하세요', "WARN");
		    return  false;
		}

		var fileCount;
		if(isNotEmpty(form1.elements["storedFileNms"]))
		{
			fileCount = form1.elements["storedFileNms"].length;
			if(fileCount > 1){
				showAlert('파일을 2개이상 첨부할수 없습니다.', 'WARN');
	            return false;
	        }
			if (fileCount == 2||fileCount == 1) {
	 			for (var i=0; i<fileCount; i++) {
	 				if (form1.storedFileNms[i].value=="") {
	 					showAlert("파일을 첨부하지 않았습니다.", "WARN");
	 					return false;
	 				}
	 			}
	 		} else {
	 			if (form1.storedFileNms.value=="") {
	 				showAlert("파일을 첨부하지 않았습니다.", "WARN");
	 				return false;
	 			}
	 		}
		} else { showAlert ("업로드할 파일을 선택하세요.", "WARN"); return false; }

    	return true;
	}

	$(function(){
		//var allowedFileExtensions = [".xls"];
		var allowedFileExtensions = "${uploadFileXls}";
		var fileUploader = gtFileUploader("file-uploader",allowedFileExtensions,doSubmit_end,false,false);

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

	function doError_end(){
		opener.doSearch();
		//window.close();
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

<form name="form1" id = "form1" method="post">
	<input type="hidden" name="pageID" />
	<input type="hidden" name="classID"  />
	<input type="hidden" name="methodID"  />
	<input type="hidden" id="methodID" name="methodID"/>
	<input type="hidden" id="flag" name="flag"/>
	<input type="hidden" id="afterClose" name="afterClose"/>
    <input type="hidden" name="mode" value="insert" />

	<div class="tab-content-bottom">
        <div class="statistics-table" >
			<table class="basic-table" >
				<colgroup>
				    <col width="130px">
				    <col width="">
				</colgroup>
			   <tbody>
				<tr>
                    <th class="title" width="5%">${msgel.getMsg('RBA_90_01_01_02_001','보고기준일')}</th>
	                    <td width="30%" align="left" >
					     	<input type="text" class="input_t_dis" name="VIEW_RPT_GJDT" value="${VIEW_RPT_GJDT}";  readOnly />
					     	<input type="hidden" name="RPT_GJDT" id="RPT_GJDT" value="${RPT_GJDT}" />
	                    </td>
                </tr>
                <tr>
                    <th class="title">${msgel.getMsg('AML_90_01_03_02_005','첨부파일')}</th>
                    <td colspan="3" valign="top" style="padding:10 10 10 10;" align="center">
                    <div style="height:150px;overflow-y:auto;">
		                 <table id="NotiAttachTable" width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#F5F9F8" style="border-right:solid 1px #CCCCCC;">
							<tr>
								<td style="border: 1px solid #ccc">
									<div class="widget-container" style="height: 100%; -ms-overflow-y: auto;">
										<div id="file-uploader" style="margin-top:10px;"></div>
										<div class="content" id="selected-files">
											<div>
												<h4>${msgel.getMsg('AML_90_01_02_06_201','※ 업로드 된 파일 목록')}</h4>
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

		<div class="panel-footer">
			<table border=0 width=100%>
				<tr class="tab-content-top">
					<td align="left" style="font-family: SpoqB;font-size:0.8rem;color:blue;">
						${msgel.getMsg('RBA_90_01_05_01_202','※업로드시 확정된 지표번호는 저장 되지 않습니다.')}
					</td>
					<td class="button-area" align="right">
						${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
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