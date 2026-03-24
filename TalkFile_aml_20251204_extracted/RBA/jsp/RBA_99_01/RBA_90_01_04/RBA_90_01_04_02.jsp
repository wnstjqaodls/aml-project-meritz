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
<%@ page import="com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_04.RBA_90_01_04_01"  %>
<%
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
	request.setAttribute("uploadFile",uploadFile);

    String toDay = jspeed.base.util.DateHelper.currentTime(PropertyService.getInstance().getProperty("aml.config","dateFormat"));
	String RPT_GJDT 	= Util.nvl(request.getParameter("RPT_GJDT") , "");
	//String RPT_GJDT_F = RPT_GJDT =="" ? "": RPT_GJDT.substring(0,4) +"-"+RPT_GJDT.substring(4,6)+"-"+RPT_GJDT.substring(6,8);	
	String RPT_GJDT_F;	
	
	StringBuffer strGjdt = new StringBuffer(64);
	strGjdt.append(RPT_GJDT.substring(0 , 4));
	strGjdt.append('-');
	strGjdt.append(RPT_GJDT.substring(4 , 6));
	strGjdt.append('-');
	strGjdt.append(RPT_GJDT.substring(6 , 8));
     
	RPT_GJDT_F = "".equals(RPT_GJDT) ? "": strGjdt.toString();
	DataObj input  = new DataObj();
    input.put("RPT_GJDT", RPT_GJDT);
	DataObj output = RBA_90_01_04_01.getInstance().getSearchFList(input);
    String ATTCH_FILE_NO = Util.nvl(output.get("ATTCH_FILE_NO") , "");
    
    request.setAttribute("toDay",toDay);
    request.setAttribute("RPT_GJDT",RPT_GJDT);
    request.setAttribute("RPT_GJDT_F",RPT_GJDT_F);
    
    if("0".equals(ATTCH_FILE_NO)){
		ATTCH_FILE_NO = "";
	}
    request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);
	DataObj output2 = (DataObj) request.getAttribute("output");
	if(output2.getCount("FILE_SER") != 0) {
		request.setAttribute("FILES",output2.getRowsToMap());		
	}
    System.out.println("ATTCH_FILE_NO##############"+ATTCH_FILE_NO);
    
%>

<script language="JavaScript">

	function doSave(){
		if (!CHK_value()) {
			return;		
		}
		var fileCount; 
		if(isNotEmpty(form1.elements["storedFileNms"]))
		{
			fileCount = form1.elements["storedFileNms"].length;
			if(fileCount > 2){
			    showMsgPop('${msgel.getMsg("RBA_90_01_04_01_100","파일을 2개이상 첨부할수 없습니다.")}');
	            return false;
	        }	
		}	
		showConfirm("${msgel.getMsg('doSave','저장하시겠습니까?')}", "저장", doSave_Action)
	}
	
	function doSave_Action(){
		form1.FIU_RPT_GJDT.value = $("#FIU_RPT_GJDT").dxDateBox("instance").option("value").replaceAll("-","");
		var option = {
				url : '${ctx}/rba/90_01_04_03doFileSave.do',
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
	}
	function CHK_value(){
		
		$("#FIU_RPT_GJDT").val($("#FIU_RPT_GJDT").dxDateBox("instance").option("value"));
		
		if (form1.RPT_GJDT.value=="") {
		   	showAlert('${msgel.getMsg("RBA_90_01_04_01_101","보고기준일을 입력하세요")}','WARN');
		    return  false;
		}
	
		if ($("#FIU_RPT_GJDT").val()=="") {
			showAlert('${msgel.getMsg("RBA_90_01_04_01_102","KoFIU보고일자를 입력하세요")}','WARN');
		    return false;
		}
		
		if (form1.RPT_GJDT.value > $("#FIU_RPT_GJDT").val().replaceAll("-","") ) {
			showAlert('${msgel.getMsg("RBA_90_01_04_01_103","KoFIU보고일자는 보고기준일 보다 빠를수 없습니다.")}','WARN');
			return false;
			    
		}

    	return true;
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
	    				+"	<div class='dx-button-content'><i class='dx-icon dx-icon-close'></i></div>"
	    				+"</div>"
	    				+"</a>"
	    				+"</div>";
	    		$("#fileBox").append(addLine);		      		 
	    	}	
	 }
	  
	 //파일 다운
	 function downloadFile(f,o)
	 {
		$("[name=pageID]", "#fileFrm").val("RBA_90_01_04_02");
	 	$("#downFileName").val(f);
	 	$("#orgFileName").val(o); 	
	 	$("#downFilePath").val($("#filePaths").val()); 	
	 	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
	 	$("#fileFrm").submit();
	 }
	function doSave_end(){
		opener.doSearch2();
		window.close();
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
<form name="form1" id="form1" method="post">
	<input type="hidden" name="pageID" />
	<input type="hidden" name="classID"  />
	<input type="hidden" name="methodID"  />
	<input type="hidden" id="methodID" name="methodID"/>
	<input type="hidden" id="afterClose" name="afterClose"/>
    <input type="hidden" name="mode" value="insert" />
    <input type="hidden" name="RPT_GJDT" value="${RPT_GJDT}" />
    <input type="hidden" name="FIU_RPT_GJDT"  />
   	<input type="hidden" name="ATTCH_FILE_NO"  value="${ATTCH_FILE_NO}"/>
<!-- 저장용 iframe -->
    <div class="tab-content-bottom">
        <table class="basic-table">
            <tr>
                <th class="title">${msgel.getMsg('RBA_90_01_01_02_001','보고기준일')}</th>
                <td ><input type="text" class="input_t_dis" name="RPT_GJDT_F" value="${RPT_GJDT_F}" readOnly/></td>
            </tr>
            <tr>
                <th class="title">${msgel.getMsg('RBA_90_01_05_01_203','KoFIU보고일자')}</th>
                <td class="calendar">${condel.getInputDateDx('FIU_RPT_GJDT',toDay)}</td>
            </tr>
            <tr>
                <th class="title">${msgel.getMsg('AML_90_01_03_02_005','첨부파일')}</th>
                <td style="overflow-y: auto;">
                    <div class="widget-container fileUploader-position-modifier" style="-ms-overflow-y: auto;">
                        <div id="file-uploader" style="margin-top:10px;"></div>
                        <div class="content" id="selected-files">
                            <div>
                                <h4>${msgel.getMsg('AML_90_01_02_06_201','※ 업로드 된 파일 목록')}</h4>
                            </div>    
                            <div id="fileBox" style="border: 1px solid rgb(221, 221, 221); background-color: rgb(255, 255, 255);">
                                <c:forEach items="${FILES}" var="result" varStatus="status">
                                    <c:set var="i" value="${status.index}"/>
                                    <div id="file${i}" class="tx dx-fileuploader-button-container">
                                        <i class="fa fa-floppy-o" style="font-size: 14px; margin-left: 3px;" aria-hidden="true"></i>
                                        <a class="file" href="javascript:downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}');">
                                            ${result.LOSC_FILE_NM}
                                        </a>
                                        <a onclick="viewDelete(this);">
                                            <input type="hidden" name="fileSizes" value="<c:out value="${result.FILE_SIZE}"/>"/>
                                            <input type="hidden" name="origFileNms" value="<c:out value="${result.LOSC_FILE_NM}"/>"/>
                                            <input type="hidden" name="storedFileNms" value="<c:out value="${result.PHSC_FILE_NM}"/>"/>
                                            <input type="hidden" name="filePaths" value="<c:out value="${result.FILE_POS}"/>"/>
                                            <div class="dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon" style="margin-left: 10px;"  role="button" aria-hidden="true" aria-label="close">
                                                <div class="dx-button-content"><i class="dx-icon dx-icon-close"></i></div>
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <div class="button-area" style="display: flex; justify-content: flex-end; margin-top: 6px;">
            ${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"sbtn_02", cdID:"closeBtn", closeBtn:"닫기", mode:"R", function:"doSave_end", cssClass:"btn-36"}')}
        </div>
    </div>
    <iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 	