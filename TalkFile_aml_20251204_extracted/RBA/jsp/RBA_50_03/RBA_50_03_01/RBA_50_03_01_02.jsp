<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_03_01_02.jsp
* Description     : 자금세탁 사례관리 등록/수정 팝업
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-04-23
--%>
<%@ page import="java.text.ParseException"  %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_03.RBA_50_03_01.RBA_50_03_01_02"    %>
<%@ page import="jspeed.base.property.PropertyService" %>  
<%
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
	request.setAttribute("uploadFile",uploadFile);

	DataObj output = (DataObj)request.getAttribute("output");
	String stDate = Util.nvl(request.getParameter("stDate"));
	//if(stDate.equals("")) 
	if("".equals(stDate) == true){  
		try{
		    stDate  = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd");
		}
		catch(ParseException e){
			Log.logAML(Log.ERROR, e);
		}
	}
	String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
    String GUBN = request.getParameter("P_GUBN");
    String SNO = "";
    String IN_DT = "";
    
	//등록이 아닐때
    if(!"0".equals(GUBN)){
        SNO = request.getParameter("P_SNO");
        IN_DT = request.getParameter("P_IN_DT");
        String P_edDate = request.getParameter("P_edDate");
        String P_stDate = request.getParameter("P_stDate");
    	
        request.setAttribute("P_stDate",P_stDate);
        request.setAttribute("P_edDate",P_edDate);
        
    }
	if("0".equals(ATTCH_FILE_NO)){
		ATTCH_FILE_NO = "";
	}
    request.setAttribute("GUBN",GUBN);
    request.setAttribute("SNO",SNO);
    request.setAttribute("IN_DT",IN_DT);
    request.setAttribute("stDate",stDate);
    request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);
    System.out.println("##########SNO"+SNO);
    DataObj in = new DataObj();											 
    in.put("SNO", SNO);											
    
    DataObj output2 = RBA_50_03_01_02.getInstance().doSearch2(in);
    
    System.out.println("##########output2"+output2);
    System.out.println("#########output2.getRowsToMap()"+output2.getRowsToMap());
    if(output2.getCount("FILE_SER") > 0) {                               
		request.setAttribute("FILES",output2.getRowsToMap());
	}	
    
%>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<script language="JavaScript">
    
    var GridObj1;
    var classID = "RBA_50_03_01_02";
    var overlay  = new Overlay();
    // Initialize
    $(document).ready(function(){
        $('.popup-contents').css({overflow:"auto"});
        $("#stDate").attr("style","width:150px;");
        setupGrids();
        if("${GUBN}" == "0"){ //구분이 0이면 등록 아니면 수정
        	$("button[id='btn_02']").attr('style', "display:none");
        }
        
    });
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids(){
        // 그리드1(Code Head) 초기화
        GridObj1 = $("#GTDataGrid3_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
			 height	:"calc(90vh - 100px)",
			 hoverStateEnabled    : true,
			    wordWrapEnabled      : false,
			    allowColumnResizing  : true,
			    columnAutoWidth      : true,
			    allowColumnReordering: true,
			    cacheEnabled         : false,
			    cellHintEnabled      : true,
			    showBorders          : true,
			    showColumnLines      : true,
			    showRowLines         : true,
			    export               : {
			        allowExportSelectedData: true,
			        enabled                : true,
			        excelFilterEnabled     : true,
			        fileName               : "gridExport"
			    },
			    sorting         : {mode   : "multiple"},
			    loadPanel       : {enabled: false},
			    remoteOperations: {
			        filtering: false,
			        grouping : false,
			        paging   : false,
			        sorting  : false,
			        summary  : false
			    },
			    editing: {
			        mode         : "batch",
			        allowUpdating: false,
			        allowAdding  : false,
			        allowDeleting: false
			    },
			    filterRow            : {visible: false},
			    pager: {
			        visible: true,
			        showNavigationButtons: true,
			        showInfo: true
			    },
			    paging: {
			        enabled: true,
			        pageSize: 20
			    },
			    scrolling: {
			        mode: "standard",
			        preloadEnabled: false
			    },
			    rowAlternationEnabled: false,
			    searchPanel          : {
			        visible: false,
			        width  : 250
			    },
			    selection: {
			        allowSelectAll    : true,
			        deferred          : false,
			        mode              : "single",
			        selectAllMode     : "allPages",
			        showCheckBoxesMode: "onClick"
			    },
			    columns: [
			    	{
			            dataField    : "SNO",
			            caption      : 'NO',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            width : 50
			        }, {
			            dataField    : "SRC_INFO_C",
			            caption      : '출처정보코드',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "SRC_INFO_NM",
			            caption      : '${msgel.getMsg("RBA_50_03_01_01_100","출처정보")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 100
			        },{
			            dataField    : "NEWS_TITE",
			            caption      : '${msgel.getMsg("RBA_50_03_01_01_101","기사제목")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            cssClass     : "link",
			            width : 400
			        }, {
			            dataField    : "NEWS_DT",
			            caption      : '${msgel.getMsg("RBA_50_03_01_005","기사일자")}',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            width : 80
			        }, {
			            dataField    : "IN_DT",
			            caption      : '${msgel.getMsg("RBA_50_01_04_01_117","등록일자")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            cellTemplate : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            width : 80
			        }, {
			            dataField    : "INDV_CORP_NM",
			            caption      : '${msgel.getMsg("RBA_50_03_01_009","개인/법인명")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "URL",
			            caption      : 'URL',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "NEWS_CTNT",
			            caption      : '기사내용',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_RSN",
			            caption      : '등록사유',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CUST_G_C",
			            caption      : '고객구분코드',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "REL_P_CNT",
			            caption      : '관련자수',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "STR_RPT_NO",
			            caption      : 'STR보고번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "STR_RPT_DT",
			            caption      : 'STR보고일자',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "ATTCH_FILE_NO",
			            caption      : '첨부파일번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_DT",
			            caption      : '등록일자',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_TIME",
			            caption      : '등록시간',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "DR_OP_JKW_NO",
			            caption      : '등록조작자번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_DT",
			            caption      : '변경일자',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_TIME",
			            caption      : '변경일시',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_OP_JKW_NO",
			            caption      : '변경조작자번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }, {
			            dataField    : "CHG_OP_JKW_NM",
			            caption      : '${msgel.getMsg("RBA_50_01_04_01_107","등록자")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true
			        }, {
			            dataField    : "ATTATCH_YN",
			            caption      : '${msgel.getMsg("RBA_50_03_01_01_102","첨부여부")}',
			            alignment    : "center",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            width : 70
			        }, {
			            dataField    : "ATTCH_FILE_NO",
			            caption      : '첨부파일번호',
			            alignment    : "left",
			            allowResizing: true,
			            allowSearch  : true,
			            allowSorting : true,
			            visible      : false
			        }
			    ],
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }	 
        }).dxDataGrid("instance");	
        
        if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
            doSearch();
        }
        
    }
    
    //자금세탁 사례관리 조회
    function doSearch(){
    	overlay.show(true, true);
        var params   = new Object();
    	var methodID = "doSearch";
    	var classID  = "RBA_50_03_01_01";
    	 		
    	params.pageID 	= pageID;
    	params.SNO     = "${SNO}";
    	params.IN_DT   = "${IN_DT}";
    	params.stDate  = "${P_stDate}";
    	params.edDate  = "${P_edDate}";
    
    	sendService(classID, methodID, params, doSearch_success, doSearch_fail); 
    }
    //자금세탁 사례관리 조회 end
    function doSearch_success(gridData, data){
        try {
        	var selObj = gridData[0];
            setData(selObj);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
    
    function doSearch_fail(){    	 
    	overlay.hide();
    }
    
    
    //자금세탁 사례관리 HTML에 데이타 삽입
    function setData(selObj){
    	
        form1.NEWS_TITE.value  	    = (selObj.NEWS_TITE     == undefined)?"":selObj.NEWS_TITE; 		//기자제목
        form1.SRC_INFO_C.value      = (selObj.SRC_INFO_C    == undefined)?"":selObj.SRC_INFO_C; 	//출처구분코드 
    	form1.URL.value      		= (selObj.URL      		== undefined)?"":selObj.URL; 			//URL
    	form1.NEWS_CTNT.value     	= (selObj.NEWS_CTNT     == undefined)?"":selObj.NEWS_CTNT; 		//기사내용
    	form1.DR_RSN.value      	= (selObj.DR_RSN      	== undefined)?"":selObj.DR_RSN; 		//등록사유
    	form1.INDV_CORP_NM.value    = (selObj.INDV_CORP_NM  == undefined)?"":selObj.INDV_CORP_NM; 	//개인/법인명
    	form1.CUST_G_C.value      	= (selObj.CUST_G_C      == undefined)?"":selObj.CUST_G_C; 		//고객구분코드
    	form1.REL_P_CNT.value    	= (selObj.REL_P_CNT    	== undefined)?"":selObj.REL_P_CNT; 		//관련자수
    	form1.STR_RPT_NO.value     	= (selObj.STR_RPT_NO    == undefined)?"":selObj.STR_RPT_NO; 	//STR보고번호
    	//form1.STR_RPT_DT.value     	= (selObj.STR_RPT_DT    == undefined)?"":selObj.STR_RPT_DT; 	//STR보고일자
    	setDxDateVal("NEWS_DT"		,(selObj.NEWS_DT        == undefined || selObj.NEWS_DT== ""    )?"${stDate}":getDateFormat(selObj.NEWS_DT,"-")); 		//기사일자
    	setDxDateVal("STR_RPT_DT"		,(selObj.STR_RPT_DT        == undefined || selObj.STR_RPT_DT== ""    )?"":getDateFormat(selObj.STR_RPT_DT,"-")); 		//기사일자

    }
    
    //자금세탁사례관리저장
    function doSave(){

        if($("#NEWS_TITE").val()==""){
            showAlert('${msgel.getMsg("RBA_50_03_01_014","제목은 필수 값 입니다.")}','WARN');
            return false;
        }

        if(isNaN($("#REL_P_CNT").val())){
            showAlert('${msgel.getMsg("RBA_50_03_01_016","관려자수는 숫자만 입력 가능합니다.")}','WARN');
            return false;
        }
        
        if(""==$("#REL_P_CNT").val()){
        	$("#REL_P_CNT").val(0);
        }
        form1.pageID.value     = 'RBA_50_03_01_03';
        form1.methodID.value   = "doSave";
        form1.GUBN.value       = "${GUBN}"; //0이면 등록 1이면 수정
		form1.NEWS_DT.value    = getDxDateVal("NEWS_DT",true);
        form1.STR_RPT_DT.value = getDxDateVal("STR_RPT_DT",true);
        var fileCount; 
		if(isNotEmpty(form1.elements["storedFileNms"]))
		{
			fileCount = form1.elements["storedFileNms"].length;
			if(fileCount > 10){
			    showAlert('파일을 10개이상 첨부할수 없습니다.','WARN');
	            return false;
	        }	
		}	
		showConfirm("${msgel.getMsg('doSave','저장하시겠습니까?')}", "저장",function(){
			var option = {
					url : '${ctx}/rba/AMLdoSave.do',
					dataType : 'json',				
					success : function(data){					
						
						if(data.status == 'success')
						{
							showAlert(data.serviceMessage, 'INFO');
							doDeleteEnd();
//	 						showMsgPop(data.serviceMessage);	
						}	
						else
						{
							showAlert(data.serviceMessage,'INFO');
//	 						showMsgPop(data.serviceMessage);
						}	
						
					}				 
			};
			$('#form1').ajaxSubmit(option);
			return false;
		});
    }
    
    //자금세탁사례관리 삭제
    function doDelete(){
        
    	 showConfirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}", "삭제",function(){
    		$("button[id='btn_02']").prop('disabled', true);
         	var params   = new Object();
         	var methodID = "doDeleteOne";
         	var classID  = "RBA_50_03_01_02";
         	 		
         	params.pageID 	= pageID;
         	params.SNO      = "${SNO}";
         	params.IN_DT    = "${IN_DT}";
         	
         	sendService(classID, methodID, params, doDeleteEnd, doDeleteEnd); 
         });
    }
    
    //삭제 후 팝업 close
    function doDeleteEnd() {
        opener.doSearch();
        window.close();
    }
    
    // 날짜 NULL에 대한 VALUE -> TEXT 처리
    function getDxDateTxt(elementID, isOnlyNumber){
        $("#"+elementID).dxDateBox("instance").option("displayFormat", "yyyy-MM-dd");
        var dxDate = $("#"+elementID).dxDateBox("instance").option("text");
        return isOnlyNumber?(dxDate?extractNumber(dxDate):dxDate):dxDate;
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

    function downloadFile(f,o)
    {
    	$("[name=pageID]", "#fileFrm").val("RBA_50_03_01_02");
    	$("#downFileName").val(f);
    	$("#orgFileName").val(o); 	
    	$("#downFilePath").val($("#filePaths").val()); 	
    	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
    	$("#fileFrm").submit();
    }
</script>  

<style>
	.popup .thisClass1 .dropdown {
		width: 100% !important;
	}
</style>

<!-- 파일 삭제, 다운로드 -->
<form name="fileFrm" id="fileFrm" method="POST">
<input type="hidden" name="pageID" />
<input type="hidden" name="downFileName" id="downFileName" value="" />
<input type="hidden" name="orgFileName" id="orgFileName" value="" />
<input type="hidden" name="downFilePath" id="downFilePath" value="" />
<input type="hidden" name="downType" id="downType" value="RBA" />
</form> 
<!-- 저장용 iframe -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top"><iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe></td>
    </tr>
</table>

<form name="form1" id="form1" method="post">
<input type="hidden" name="pageID">
<input type="hidden" name="classID"> 
<input type="hidden" name="methodID">
<input type="hidden" name="GUBN">
<input type="hidden" name="mode">
<input type="hidden" name="NEWS_DT">
<input type="hidden" name="STR_RPT_DT">
<input type="hidden" name="SNO" value="${SNO}">
<input type="hidden" name="IN_DT" value="${IN_DT}">
<input type="hidden" name="ATTCH_FILE_NO"  value="${ATTCH_FILE_NO}"/>

<div class="statistics-table">
	<table width="100%" class="basic-table">
		<tr>
			<th class="title required" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_004','제목')}</th>
			<td style="text-align:center; padding: 3px 0px !important;" colspan="5"> 
				<textarea name="NEWS_TITE" id ="NEWS_TITE" class="textarea-box" style="width:99%;" rows=2 maxlength="200"></textarea>
			</td>
		</tr>
		<tr>
			<th class="title required" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_005','기사일자')}</th>
			<td style="padding: 0px 3px !important;">
				${condel.getInputDateDx('NEWS_DT',stDate)}
			</td>
			<th class="title required" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_002','출처')}<%-- (기준코드에서 '출처'로 검색하여 추가합니다) --%></th>
			<td class="thisClass1" style="text-align:center; padding: 3px 3px !important;" colspan="3">
				${SRBACondEL.getSRBASelect('SRC_INFO_C','' ,'' ,'R320' ,'','','','','','')}
			</td>
		</tr>
		<tr>
			<th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_006','URL')} </th>
			<td style="text-align:center; padding: 3px 3px !important;"  colspan="5"> 
				<input type="text" name="URL" id="URL" style="text-align:left; width: 100%" class="cond-input-text" maxlength="100" />
			</td>
		</tr>
		<tr>
			<th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_007','기사내용')}</th>
			<td style="text-align:center; padding: 3px 3px !important;" colspan="5"> 
				<textarea name="NEWS_CTNT" id="NEWS_CTNT" class="textarea-box" style="width:100%;" rows=5 maxlength="1500"></textarea>
			</td>
		</tr>
		<tr>
			<th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_008','등록사유')}</th>
			<td style="text-align:center; padding: 3px 3px !important;" colspan="5"> 
				<textarea name="DR_RSN" id="DR_RSN" class="textarea-box" style="width:100%;" rows=3 maxlength="240"></textarea>
			</td>
		</tr>
		<tr>
			<th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_009','개인/법인명')}</th>
			<td style="text-align:center; padding: 3px 3px !important;" colspan="5">
				<input type="text" name="INDV_CORP_NM" id="INDV_CORP_NM" style="text-align:left;width:100%" class="cond-input-text"  maxlength="33" />
			</td>
		</tr>
		<tr>
			<th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_010','당사 고객구분')}</th>
			<td class="thisClass1" style="text-align:center; padding: 3px 3px !important;" > 
				<select name="CUST_G_C" id="CUST_G_C" class="dropdown" onChange='ccdChange(this)'><!--onChange='ccdChange(this)'  -->
					${condel.getSelectOption('','M006','','ALL','ALL')}
				</select> 
			</td>
			<th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_011','관련자수')}</th>
			<td style="text-align:center; padding: 3px 3px !important;" colspan="2" >
				<input type="text" name="REL_P_CNT" id="REL_P_CNT" class="cond-input-text" style="text-align:left; width: 100%" maxlength="5" />
			</td>
		</tr>
		<tr>
			<th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_018','STR보고일자')}</th>
			<td style="text-align:center; padding: 3px 3px !important;" >
				${condel.getInputDateDx('STR_RPT_DT','')}
				<!-- <input type="text" name="STR_RPT_DT" id="STR_RPT_DT" class="cond-input-text" style="text-align:left; width: 100%" class="cond-input-text" maxlength="8" /> -->
			</td>
			<th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_013','STR보고번호')}</th>
			<td style="text-align:center; padding: 3px 3px !important;" colspan="2">
				<input type="text" name="STR_RPT_NO" id="STR_RPT_NO" class="cond-input-text" style="text-align:left; width: 100%" maxlength="20" />
			</td>
		</tr>
		<tr>
			<th class="title" style="text-align:left;">${msgel.getMsg('AML_90_01_03_02_005','첨부파일')}</th>
			<td style="width: 95%"; colspan="6">
			<!-----------------------------파일 첨부---------------------------->
				
				<div id="file-uploader" style="margin-top: 10px;"></div>
				<table id="NotiAttachTable" width="80%" border="0" cellpadding="2" cellspacing="1" bgcolor="#F5F9F8" style="border:solid 1px #CCCCCC;  min-height:100px; margin:10px; ">
					<tr>
						<td height="22" style="text-align: center"  width="20%">${msgel.getMsg('RBA_50_01_01_233','업로드 된 파일 목록')}</td>
						<td class="thisClass2" height="22" bgcolor="#FFFFFF" style="vertical-align: top;">
							<div id="fileBox" >
								<c:forEach items="${FILES }" var="result" varStatus="status">
									<c:set var="i" value="${status.index}" />
									<div id="file${i}" class="tx dx-fileuploader-button-container">
										<i class="fa fa-floppy-o" style="font-size: 14px;margin-left: 3px;" aria-hidden="true"></i>
										<a href="javascript:void(0);" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')">
											<c:out value="${result.LOSC_FILE_NM }"/>
										</a>								    	
										<a onclick="viewDelete(this);"> 
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
			</td>
		</tr>
	</table>
</div>
<div class="button-area" style="margin-top: 8px; display: flex; justify-content: flex-end;">
	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
	${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')}
	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')}
</div>
<div class="panel panel-primary" style="display: none">
	<div class="panel-footer" >
		<div id="GTDataGrid1_Area"></div>
	</div>
</div>

<!--     <div class="panel panel-primary" > -->
<!--         <div class="panel-footer" > -->
<!--             <div class="table-box" > -->
<!--                 <table width="100%" class="basic-table"> -->
<!--                      <tr> -->
<%--                         <th class="title" style="text-align:left;" width="11%">${msgel.getMsg('RBA_50_03_01_004','제목')} *</th> --%>
<!--                         <td style="text-align:center;" colspan="5">  -->
<!--                             <textarea name="NEWS_TITE" id ="NEWS_TITE" class="textarea-box" style="width:100%;" rows=2 maxlength="333"></textarea> -->
<!--                         </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<%--                     	<th class="title" style="text-align:left;" >${msgel.getMsg('RBA_50_03_01_005','기사일자')} *</th> --%>
<!--                         <td> -->
<%--                         	${condel.getInputDateDx('NEWS_DT',stDate)} --%>
<!--                         </td> -->
<%--                         <th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_002','출처')} * (기준코드에서 '출처'로 검색하여 추가합니다)</th> --%>
<!--                         <td style="text-align:left;" colspan="3"> -->
<%--                             ${SRBACondEL.getSRBASelect('SRC_INFO_C','' ,'' ,'R320' ,'','','','','','')} --%>
<!--                         </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<%--                         <th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_006','URL')} </th> --%>
<!--                         <td style="text-align:center;"  colspan="5">  -->
<!--                             <input type="text" name="URL" id="URL" style="text-align:left; width: 100%" class="cond-input-text" maxlength="100" /> -->
<!--                         </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<%--                         <th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_007','기사내용')}</th> --%>
<!--                         <td style="text-align:center;" colspan="5">  -->
<!--                             <textarea name="NEWS_CTNT" id="NEWS_CTNT" class="textarea-box" style="width:100%;" rows=5 maxlength="1500"></textarea> -->
<!--                         </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<%--                         <th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_008','등록사유')}</th> --%>
<!--                         <td style="text-align:center;" colspan="5">  -->
<!--                             <textarea name="DR_RSN" id="DR_RSN" class="textarea-box" style="width:100%;" rows=3 maxlength="240"></textarea> -->
<!--                         </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<%--                         <th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_009','개인/법인명')}</th> --%>
<!--                         <td style="text-align:center;" colspan="5"> -->
<!--                             <input type="text" name="INDV_CORP_NM" id="INDV_CORP_NM" style="text-align:left;width:100%" class="cond-input-text"  maxlength="33" /> -->
<!--                         </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<%--                         <th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_010','당사 고객구분')}</th> --%>
<!--                         <td width="200" style="text-align:left;" >  -->
<!--                         	<select name="CUST_G_C" id="CUST_G_C" class="dropdown" onChange='ccdChange(this)'>onChange='ccdChange(this)'  -->
<%-- 				                ${condel.getSelectOption('','M006','','ALL','ALL')} --%>
<!-- 				            </select>  -->
<!--                         </td> -->
<%--                         <th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_011','관련자수')}</th> --%>
<!--                         <td style="text-align:center;" colspan="2" > -->
<!--                             <input type="text" name="REL_P_CNT" id="REL_P_CNT" class="cond-input-text" style="text-align:left; width: 100%" maxlength="5" /> -->
<!--                         </td> -->
<!--                     </tr> -->
<!--                     <tr> -->
<!--                         <th class="title" style="text-align:left;"> -->
<%--                         	${msgel.getMsg('RBA_50_03_01_018','STR보고일자')} --%>
<!--                         </th> -->
<!--                         <td style="text-align:left;" > -->
<%--                         	${condel.getInputDateDx('STR_RPT_DT','')} --%>
<!--                         	<input type="text" name="STR_RPT_DT" id="STR_RPT_DT" class="cond-input-text" style="text-align:left; width: 100%" class="cond-input-text" maxlength="8" /> -->
<!--                         </td> -->
<%--                         <th class="title" style="text-align:left;">${msgel.getMsg('RBA_50_03_01_013','STR보고번호')}</th> --%>
<!--                         <td style="text-align:center;" colspan="2"> -->
<!--                             <input type="text" name="STR_RPT_NO" id="STR_RPT_NO" class="cond-input-text" style="text-align:left; width: 100%" maxlength="20" /> -->
<!--                         </td> -->
<!--                     </tr> -->
<!-- 					<tr> -->
<%-- 						<th class="title" style="text-align:left;" width="5%">${msgel.getMsg('AML_90_01_03_02_005','첨부파일')}</th> --%>
<!-- 						<td width="95%" colspan="6"> -->
<!-- 						-------------------------------------------------------- -->
<!-- 							<div id="file-uploader" style="margin-top:14px; "></div> -->
<!-- 							<table id="NotiAttachTable" width="80%" border="0" cellpadding="2" cellspacing="1" bgcolor="#F5F9F8" style="border:solid 1px #CCCCCC;  min-height:100px; margin:10px; "> -->
<!-- 		                        <tr> -->
<!-- 		                            <td height="22" align="center"  width="20%">업로드 된 파일 목록</td> -->
<!-- 									<td height="22" bgcolor="#FFFFFF" style="vertical-align: top;"> -->
<!-- 										<div id="fileBox" > -->
<%-- 			                    			<c:forEach items="${FILES }" var="result" varStatus="status"> --%>
<%-- 									            <c:set var="i" value="${status.index}" /> --%>
<%-- 											    <div id="file${i}" class="tx dx-fileuploader-button-container"> --%>
<!-- 											    	<i class="fa fa-floppy-o" style="font-size: 14px;margin-left: 3px;" aria-hidden="true"></i> -->
<%-- 											    	<a href="javascript:void(0);" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" > --%>
<%-- 											    	<c:out value="${result.LOSC_FILE_NM }"/> --%>
<!-- 											    	</a>								    	 -->
<!-- 											    	<a onclick="viewDelete(this);" >  -->
<%-- 												    	<input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.fileSize }"/>"/> --%>
<%-- 											    		<input name="origFileNms" class="origFileNms" type="hidden" value="<c:out value="${result.LOSC_FILE_NM }"/>"/> --%>
<%-- 											    		<input name="storedFileNms" class="storedFileNms" type="hidden" value="<c:out value="${result.PHSC_FILE_NM }"/>"/> --%>
<%-- 											    		<input name="filePaths" id="filePaths" class="filePaths" type="hidden" value="<c:out value="${result.FILE_POS }"/>"/> --%>
<!-- 										    			<div class="dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon" style="margin-left: 10px;"  role="button" aria-hidden="true" aria-label="close"> -->
<!-- 			                    							<div class="dx-button-content" style="padding-left: 0.2em;">&nbsp;<i class="dx-icon dx-icon-close" ></i></div> -->
<!-- 			                    						</div> -->
<!-- 										    		</a>							    		 -->
<!-- 											    </div> -->
<!-- 											    <br/> -->
<%-- 											</c:forEach> --%>
<!-- 										</div> -->
<!-- 		                            </td> -->
<!-- 		                        </tr> -->
<!-- 							</table> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<!--                 </table> -->
<!--             </div> -->
<!--         </div> -->
<!--         <div align="right" style="margin-top: 10px"> -->
<%--             ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')} --%>
<%--             ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"btn-36"}')} --%>
<%--             ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')} --%>
<!--         </div> -->
<!--     </div> -->

<!--     <div class="panel panel-primary" style="display: none"> -->
<!--         <div class="panel-footer" > -->
<!--             <div id="GTDataGrid1_Area"></div> -->
<!--         </div> -->
<!--     </div> -->
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />