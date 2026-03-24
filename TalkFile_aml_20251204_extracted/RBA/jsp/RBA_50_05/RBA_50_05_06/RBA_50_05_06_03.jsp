<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_06_02.jsp
* Description     : 개선 현황 상세 등록/수정
* Group           : GTONE
* Author          : PJH
********************************************************************************************************************************************
--%>
<%@page import="jspeed.base.util.StringHelper"%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true"/>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@page import="com.itplus.common.server.user.SessionHelper"%>

<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_05.RBA_50_05_06.RBA_50_05_06_01"    %>  

<%
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLE_IDS",ROLE_IDS);
%>

<%
	// 파일업로드
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
	request.setAttribute("uploadFile",uploadFile);
	
    //세션 부서정보
    String depId 				= helper.getDeptId().toString();
    String depNm 				= helper.getDeptName();
	String ROLEID   			= sessionAML.getsAML_ROLE_ID();
	String USER_NM  			= sessionAML.getsAML_USER_NAME();
	String BAS_YYMM 			= Util.nvl(request.getParameter("BAS_YYMM")			, "");
	String LV1 					= Util.nvl(request.getParameter("LV1")				, "");
	String LV3 					= Util.nvl(request.getParameter("LV3")				, "");
	String LV1_NM 				= Util.nvl(request.getParameter("LV1_NM")			, "");
	String LV3_NM 				= Util.nvl(request.getParameter("LV3_NM")			, "");
	String BRNO   				= Util.nvl(request.getParameter("BRNO")				, "");
	String BRNO_NM 				= Util.nvl(request.getParameter("BRNO_NM")			, "");
	String IMPRV_S_C			= Util.nvl(request.getParameter("IMPRV_S_C")		, "");
	String IMPRV_S_C_NM			= Util.nvl(request.getParameter("IMPRV_S_C_NM")		, "");
	String IMPRV_STRG_DT			= Util.nvl(request.getParameter("IMPRV_STRG_DT")		, "");
	String IMPRV_STRG_CTNT			= Util.nvl(request.getParameter("IMPRV_STRG_CTNT")		, "");
	String IMPRV_RSLT_DT			= Util.nvl(request.getParameter("IMPRV_RSLT_DT")		, "");
	String IMPRV_RSLT_CTNT			= Util.nvl(request.getParameter("IMPRV_RSLT_CTNT")		, "");
	
	// 파일업로드
		String gubun = request.getParameter("gubun");
		String ATTCH_FILE_NO = request.getParameter("ATTCH_FILE_NO");
		if("0".equals(ATTCH_FILE_NO)&&"upload".equals(gubun)){
			System.out.println("gubun=upload");
			ATTCH_FILE_NO = "";
		}

		DataObj in = new DataObj();											 
	    in.put("BAS_YYMM", BAS_YYMM);											
	    in.put("BRNO", BRNO);	
	    in.put("LV3", LV3);	
// 		DataObj output = RBA_50_05_06_01.getInstance().getSearchF(in);
	    
// 	    if(output.getCount("FILE_SER") > 0) {                               
// 			request.setAttribute("FILES",output.getRowsToMap());
// 		}
// 		request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);
// 		request.setAttribute("gubun", gubun);
// 		System.out.println("####### ATTCH_FILE_NO #######" + ATTCH_FILE_NO);
// 		System.out.println("####### gubun #######" + gubun);
	
    request.setAttribute("DEP_ID", depId);
    request.setAttribute("DEP_NM", depNm);
	request.setAttribute("ROLEID",ROLEID);
	request.setAttribute("BAS_YYMM",BAS_YYMM);
	
	request.setAttribute("LV1",LV1);
	request.setAttribute("LV1_NM",LV1_NM);
	request.setAttribute("LV3",LV3);
	request.setAttribute("LV3_NM",LV3_NM);
	request.setAttribute("BRNO",BRNO);
	request.setAttribute("BRNO_NM",BRNO_NM);
	request.setAttribute("IMPRV_S_C",IMPRV_S_C);
	request.setAttribute("IMPRV_S_C_NM",IMPRV_S_C_NM);
	request.setAttribute("IMPRV_STRG_DT",IMPRV_STRG_DT);
	request.setAttribute("IMPRV_STRG_CTNT",IMPRV_STRG_CTNT);
	request.setAttribute("IMPRV_RSLT_DT",IMPRV_RSLT_DT);
	request.setAttribute("IMPRV_RSLT_CTNT",IMPRV_RSLT_CTNT);
	request.setAttribute("DR_OP_JKW_NM",USER_NM);
	
	
	
%>

<script language="JavaScript">
    var GridObj1 		= null;
	var overlay  		= new Overlay();
    var classID  		= "RBA_50_05_06_02";
	var ROLEID			= "${ROLEID}";
	var BRNO_NM			= "${BRNO_NM}";
	
    // Initialize
    $(document).ready(function(){
    	form1.BAS_YYMM.value     			 = '<%= BAS_YYMM %>';
    	form1.IMPRV_STRG_DT.value 		 = '<%= IMPRV_STRG_DT %>';
    	form1.IMPRV_STRG_CTNT.value 		 = '<%= IMPRV_STRG_CTNT %>';
    	form1.IMPRV_RSLT_DT.value 		 = '<%= IMPRV_RSLT_DT %>';
    	form1.IMPRV_RSLT_CTNT.value 		 = '<%= IMPRV_RSLT_CTNT %>';
    	
//     	doSaveFile();

    });	
	
	function doSaveDetail_check(){
    	
    	// 위험/통제 분류
    	if ($("#LV1_NM").val() == null || $("#LV1_NM").val() == "") {
            showAlert("${msgel.getMsg('RBA_50_05_06_01_016','위험/통제 분류를 입력하세요.')}",'WARN')&&($("#LV1_NM").focus());
            return false;
        }

    	// 위험/통제 요소
    	if ($("#LV3_NM").val() == null || $("#LV3_NM").val() == "") {
            showAlert("${msgel.getMsg('RBA_50_05_06_01_021','위험/통제 요소를 입력하세요.')}",'WARN')&&($("#LV3_NM").focus());
            return false;
        }

    	// 개선조치 요청사항
    	if ($("#IMPRV_STRG_CTNT").val() == null || $("#IMPRV_STRG_CTNT").val() == "") {
            showAlert("${msgel.getMsg('RBA_50_05_06_01_022','개선조치 요청사항을 입력하세요.')}",'WARN')&&($("#IMPRV_STRG_CTNT").focus());
            return false;
        }

    	// 개선조치 이행사항
    	if ($("#IMPRV_RSLT_CTNT").val() == null || $("#IMPRV_RSLT_CTNT").val() == "") {
            showAlert("${msgel.getMsg('RBA_50_05_06_01_023','개선조치 이행사항을 입력하세요.')}",'WARN')&&($("#IMPRV_RSLT_CTNT").focus());
            return false;
        }
    	
    	
        return true;
    }
    
    
    
    // 개선 현황 상세 등록 및 수정
    function doSaveDetail(){
		if($("button[id='btn_01']") == null) return;
        
		doSaveDetail_check();
		
        showConfirm('${msgel.getMsg("RBA_90_01_06_01_109","저장하시겠습니까?")}','${msgel.getMsg("AML_00_00_01_01_025","저장")}',doSaveDetail_Action, doSaveDetail_fail);
    }
    
    function doSaveDetail_Action()
    {
    	var params = new Object();
		var methodID = "doSaveDetail";
		var classID  = "RBA_50_05_06_01";
		
// 		params.DR_OP_JKW_NM    = form1.DR_OP_JKW_NM.value;				// 요청부점
		params.BAS_YYMM 	   = form1.BAS_YYMM.value;				// 평가회차
// 		params.BRNO 	   	   = form1.BRNO.value;				// 평가회차
		params.BRNO_NM 	  	   = "${BRNO_NM}";
		params.LV1_NM 	   	   = form1.LV1_NM.value;				
		params.LV3_NM 	   	   = form1.LV3_NM.value;				
		params.IMPRV_RSLT_DT = form1.IMPRV_RSLT_DT.value.replace(/-/g,'');		// 개선조치 요청사항
		params.IMPRV_RSLT_CTNT = form1.IMPRV_RSLT_CTNT.value;		// 개선조치 요청사항
		
		sendService(classID, methodID, params, doSaveDetail_end, doSaveDetail_fail);	
    }

    function doSaveDetail_end()
    {
	 	window.close();	
        opener.doSearch();
        
        doSaveFile();
    }

    function doSaveDetail_fail()
    {
        console.log("doSave_fail");	
    }
    
    // 파일업로드
    function doSaveFile(){
		fileFrm.pageID.value = 'RBA_90_01_03_03';
// 		form1.afterClose.value = "N";
		
		var fileCount; 
		if(isNotEmpty(form1.elements["storedFileNms"]))
		{
			fileCount = form1.elements["storedFileNms"].length;
			if(fileCount > 1){
			    showMsgPop('${msgel.getMsg("RBA_90_01_04_02_100","파일을 2개 이상 첨부할 수 없습니다.")}');
	            return false;
	        }	
		}	
		if(fileCount = 1){
			showConfirm('${msgel.getMsg("RBA_90_01_06_01_109","저장하시겠습니까")}', "저장", 	function(){
				var option = {
						url : '/rba/50_05_06_01_doSaveFile.do',
						dataType : 'json',				
						success : function(data){					
							if(data.status == 'success')
							{
								showAlert(data.serviceMessage, "INFO");	
								doSaveFile_end();
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
	 function doSaveFile_end(){
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
     
    // 창닫기
    function doClose(){
        opener.doSearch();
        window.close();
    }
</script>
<style>
	.popup .dropdown {
    /* width: 180px; */
	}
	
	h3 {
    	font-weight: inherit;
    	font-size: 100%;
	}
	.textarea-box {
	    padding: 6px 8px;
	    background-color: #fff;
	    border: 1px solid #ccc;
	    width: 230%;
	}
	textarea:disabled {
		background-color :#f0f0f0;
		color :#666666;
	}
	/* 첨부파일 테이블 */
	.file-table {
	  width: 100%;
	  border-collapse: collapse;
	  margin-top: 10px;
	  margin-bottom: 10px;
	  font-size: 13px;
	}
	
	.file-table th,
	.file-table td {
	  border: 1px solid #ccc;
	  padding: 6px 8px;
	  text-align: left;
	}
	
	.file-table th {
	  background-color: #f0f0f0;
	  text-align: center;
	}
	
	.file-table .actions {
	  text-align: center;
	}
	
	.file-table .download-link {
	  color: blue;
	  text-decoration: underline;
	  cursor: pointer;
	}
	
	.file-table .delete-link {
	  color: red;
	  cursor: pointer;
	}
</style>

<!-- 파일 삭제, 다운로드 -->
<form name="fileFrm" id="fileFrm" method="POST">
	<input type="hidden" name="pageID" />
	<input type="hidden" name="downFileName" id="downFileName" value="" />
	<input type="hidden" name="orgFileName" id="orgFileName" value="" />
	<input type="hidden" name="downFilePath" id="downFilePath" value="" />
	<input type="hidden" name="downType" id="downType" value="JIPYO" />
</form>
<form name="form3" method="post" >
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID">
   	<input type="hidden" name="ROLE_ID" value="${ROLEID}">
   	<input type="hidden" name="GYLJ_LINE_G_C" value="KR04">	<!-- 결재선구분코드 = KR04 : KRI 결재현황 -->
    <input type="hidden" name="GYLJ_ID">
    <input type="hidden" name="GYLJ_ROLE_ID">
    <input type="hidden" name="GYLJ_S_C">
    <input type="hidden" name="GYLJ_S_C_NM">
    <input type="hidden" name="GYLJ_G_C"  value="${GYLJ_G_C}">
<%--     <input type="hidden" name="BAS_YYMM" value="${BAS_YYMM}"> --%>
    <input type="hidden" name="FLAG"/>
</form>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
    <input type="hidden" name="BRNO_NM" >
</form>
<form name="form1"  method="post">

<!-- 	<div id="GTDataGrid1_Area" style="display:none;"></div> -->
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
            <H3>개선 조치 요청</H3>
                <table class="basic-table" width="100%" class="hover">
                  <colgroup>
				    <col width="130px">
				    <col width="">
				   </colgroup>
				   <tbody>
                    <tr>
                        <th class="title" width="20%">${msgel.getMsg("RBA_50_03_02_001","평가회차")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="BAS_YYMM" id="BAS_YYMM" value="${BAS_YYMM}" disabled/>
                        </td>
                    </tr>
                    <tr>
                        <th class="title">${msgel.getMsg("RBA_50_05_06_01_004","요청부점")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" class="input_text" id="DEP_NM" name="DEP_NM" value="${DEP_NM}" disabled/>
				    		<input type="hidden" class="input_text" id="DEP_ID" name="DEP_ID" value="${DEP_ID}"disabled/>
                        </td>
                        <th class="title">${msgel.getMsg("RBA_50_05_06_01_006","요청자")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="DR_OP_JKW_NM" id="DR_OP_JKW_NM" value="${DR_OP_JKW_NM}" disabled/>
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_005","소관 부점")}</th>
                        <td>
<%-- 							${condel.getBranchSearch('SEARCH_DEP_ID','ALL')} --%>
				    		<input type="text" name="BRNO_NM" id="BRNO_NM" value="${BRNO_NM}" disabled/>

                        </td>
                    	<th class="title">${msgel.getMsg("RBA_50_05_06_01_009","개선조치 요청일자")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="IMPRV_STRG_DT" id="IMPRV_STRG_DT" value="${IMPRV_STRG_DT}" disabled/>
				    		
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_007","위험/통제분류")}</th>
                        <td>
<%-- 	      	 				${RBACondEL.getKRBASelect('LV1','' ,'' ,'SP001' ,'${LV1}' ,'ALL' ,'nextSelectChange2_2("CNTL_CATG2_C", "SP003", this)','','','')} --%>
				    		<input type="text" name="LV1_NM" id="LV1_NM" value="${LV1_NM}" disabled/>
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_008","위험/통제요소")}</th>
                        <td width="30%" align="left" >
<%-- 	      	 				${RBACondEL.getKRBASelect('LV3','' ,'' ,'SP003' ,'${LV3}' ,'ALL' ,'','','','')} --%>
				    		<input type="text" name="LV3_NM" id="LV3_NM" value="${LV3_NM}" disabled/>
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required">${msgel.getMsg("RBA_50_05_06_01_014","개선조치 요청사항")}</th>
                        <td colspan="3"><textarea name="IMPRV_STRG_CTNT" id="IMPRV_STRG_CTNT" rows="9" cols="10" style="width:100%;height:100px;" value="${IMPRV_STRG_CTNT}" disabled></textarea><br></td>
                    </tr>
                    
                    </tbody>
                 </table>
            </div>
        </div>
	</div>
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
            <H3>개선 조치 이행</H3>
                <table class="basic-table" width="100%" class="hover">
                  <colgroup>
				    <col width="130px">
				    <col width="">
				   </colgroup>
				   <tbody>
                    <tr>
                    	<th class="title required" width="20%">${msgel.getMsg("RBA_50_05_06_01_005","소관 부점")}</th>
                        <td>
				    		<input type="text" name="BRNO_NM" id="BRNO_NM" value="${BRNO_NM}" disabled/>
                        </td>
                        <th class="title" width="20%">${msgel.getMsg("RBA_50_05_06_01_018","담당자")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="DR_OP_JKW_NM" id="DR_OP_JKW_NM" value="${DR_OP_JKW_NM}" disabled/>
                        </td>
                    	
                    </tr>
                    <tr>
                    	<th class="title required" width="20%">${msgel.getMsg("RBA_50_05_06_01_002","개선이행상태")}</th>
                        <td>
				    		<input type="text" name="IMPRV_S_C_NM" id="IMPRV_S_C_NM" value="${IMPRV_S_C_NM}" disabled/>
                        </td>
                    	<th class="title" width="20%">${msgel.getMsg("RBA_50_05_06_01_017","개선조치 이행일자")}</th>
                        <td width="30%" align="left" >
				    		<input type="text" name="IMPRV_RSLT_DT" id="IMPRV_RSLT_DT" value="${IMPRV_RSLT_DT}" disabled/>
                        </td>
                    </tr>
                    <tr>
                    	<th class="title required" width="20%">${msgel.getMsg("RBA_50_05_06_01_019","개선조치 이행사항")}</th>
                        <td colspan="3"><textarea name="IMPRV_RSLT_CTNT" id="IMPRV_RSLT_CTNT" rows="9" cols="10" style="width:100%;height:100px;" value="${IMPRV_RSLT_CTNT}"></textarea><br></td>
                    </tr>
                    
                    </tbody>
                 </table>
                 
            </div>
        </div>
	</div>
	
	<div class="panel panel-primary">
	<div class="panel-footer" >
		<div class="table-box">
			<table class="basic-table" >
			   <tbody>
		             <tr>
		                <th class="title">${msgel.getMsg('AML_90_01_03_02_005','첨부파일')}</th>
		                <td colspan="3" style="overflow-y: auto; height: 20vh;">
		               		<div class="widget-container fileUploader-position-modifier" style="-ms-overflow-y: auto;">
				                <div id="file-uploader" style="margin-top:10px;"></div>
				                <div class="content" id="selected-files">
				                    <div>
				                        <h4>※ 업로드 된 파일 목록</h4>
				                    </div>
				                    <div id="fileBox" style="border: 1px solid rgb(221, 221, 221); background-color: rgb(255, 255, 255);">
		
		                   			<c:forEach items="${FILES }" var="result" varStatus="status">
							            <c:set var="i" value="${status.index}" />
									    <div id="file${i}" class="tx dx-fileuploader-button-container">
									    	<i class="fa fa-floppy-o" style="font-size: 14px;margin-left: 3px;" aria-hidden="true"></i>
									    	<a href="javascript:void(0);" onClick="fsDown('${result.PHSC_FILE_NM}','${result.USER_FILE_NM}')" >
									    	${result.USER_FILE_NM }
									    	</a>
									    	<a class="btn-36" onclick="viewDelete(this);" >
										    	<input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.FILE_SIZE }"/>"/>
									    		<input name="origFileNms" class="origFileNms" type="hidden" value="<c:out value="${result.USER_FILE_NM }"/>"/>
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
				</tbody>
			</table>
		</div>
	</div>
</div>
               
	<div class="tab-content-top">
		<div class="button-area" style="margin-top:5px;">
			${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSaveDetail", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}		
		</div>
	</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />