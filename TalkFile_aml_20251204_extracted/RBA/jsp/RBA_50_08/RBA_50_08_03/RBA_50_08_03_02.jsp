<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_03_02.jsp
* Description     : AML활동 보고및 조치 관리
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 4. 20.
********************************************************************************************************************************************
--%>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<%@page import="java.text.ParseException"                                           %>
<%-- <%@page import="com.gtone.aml.dao.common.MDaoUtilSingle"                            %> --%>
<%-- <%@page import="com.gtone.rba.server.type03.RBA_50.RBA_50_08.RBA_50_08_03.RBA_50_08_03_01" %> --%>
<%-- <%@page import="com.gtone.rba.server.type03.RBA_50.RBA_50_08.RBA_50_08_03.RBA_50_08_03_02" %> --%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	DataObj output = (DataObj)request.getAttribute("output");
	DataObj outputRslt = output.getChild("outputRslt", 0);
	DataObj outputActn = output.getChild("outputActn", 0);
    String dcsDt   = Util.nvl(request.getParameter("dcsDt"));
    String dcsDtb   = "";   // 화면에 표시하기 위한 값
    String DP_SEND_DT   = Util.nvl(request.getParameter("DP_SEND_DT"));
    String DP_SEND_DTB   = "";   // 화면에 표시하기 위한 값
    String ACTN_DT   = Util.nvl(request.getParameter("ACTN_DT"));
    String ACTN_DTB   = "";   // 화면에 표시하기 위한 값
    String sNo       = Util.nvl(request.getParameter("sNo"    ));
    String GUBN       = Util.nvl(request.getParameter("P_GUBN"    )); //구분이 0이면 등록 아니면 수정
    String RSLT_ATTCH_FILE_NO = Util.nvl(request.getParameter("RSLT_ATTCH_FILE_NO"));
    String ACTN_ATTCH_FILE_NO = Util.nvl(request.getParameter("ACTN_ATTCH_FILE_NO"));
    
    String ACTN_PLAN_YN = ( "".equals(Util.nvl(request.getParameter("ACTN_PLAN_YN"))) ? "1" : Util.nvl(request.getParameter("ACTN_PLAN_YN")) );
    String ACT_PRGR_S_C = ( "".equals(Util.nvl(request.getParameter("ACT_PRGR_S_C"))) ? "0" : Util.nvl(request.getParameter("ACT_PRGR_S_C")) );
    String ACTN_PLAN_G_C = ( "".equals(Util.nvl(request.getParameter("ACTN_PLAN_G_C"))) ? "M" : Util.nvl(request.getParameter("ACTN_PLAN_G_C")) );
    
    
    try{
    if(("0").equals(GUBN)){  //등록시 발생일자에 당일 데이터 셋팅
    	dcsDtb = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
    	DP_SEND_DTB = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
    	ACTN_DTB = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
    } else {
    	dcsDtb = jspeed.base.util.DateHelper.format(dcsDt, "yyyyMMdd", "yyyy-MM-dd");
    	DP_SEND_DTB = jspeed.base.util.DateHelper.format(DP_SEND_DT, "yyyyMMdd", "yyyy-MM-dd");
    	ACTN_DTB = jspeed.base.util.DateHelper.format(ACTN_DT, "yyyyMMdd", "yyyy-MM-dd");
    }
    }catch(ParseException e){
    	Log.logAML(Log.ERROR, e);
    }

    request.setAttribute("DCS_DT"              ,dcsDt            );
    request.setAttribute("DCS_DTB"              ,dcsDtb            );
    request.setAttribute("DP_SEND_DTB"              ,DP_SEND_DTB            );
    request.setAttribute("ACTN_DTB"              ,ACTN_DTB            );
    request.setAttribute("SNO"        ,sNo      );
    request.setAttribute("GUBN"      ,GUBN    );
    request.setAttribute("RSLT_ATTCH_FILE_NO"      ,RSLT_ATTCH_FILE_NO    );
    request.setAttribute("ACTN_ATTCH_FILE_NO"      ,ACTN_ATTCH_FILE_NO    );
%>
<script>
    var GridObj1    = null;
    var classID = "RBA_50_08_03_02";
    var Combo1 = null;
	var Combo2 = null;
    var submit_flag = null;
    /** Initial function */
    $(document).ready( function() {

    	$('.popup-contents').css({overflow:"auto"});
    	
    	// AML활동 보고및 조치내역 수정시 결정일자 수정불가
        if(form.GUBN.value == "0"){
        	$(DCS_DT).dxDateBox("instance").option("disabled", false);
        }else{
        	$(DCS_DT).dxDateBox("instance").option("disabled", true);            
        }
      	//유안타증권 - BSL
        form.DEP_TITLE.value = "전체";
        
    	setupGrids();
    });

    // Initial function
    function init() { 
    	initPage(); 
    }
    
    function doevent(thisObj){
    	Combo1 = $("#RSLT_G_C").val();        //설계평가등급
    	Combo2 = $('input:radio[name="ACTN_PLAN_YN"]:checked').val();
    	
    	if(Combo1!="" || Combo2==0){
    		$("#table2").hide();
    		$("#table3").hide(); 
        	$("#table4").hide(); 
    	}else{
    		$("#table2").show();
    		$("#table3").show(); 
        	$("#table4").show(); 
    	}
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_08_03_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : 'AML활동보고및 조치관리'
           ,completedEvent  : function(){
               setupGridFilter([GridObj1]);
               if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
            	   doSearch();
               }
            }
        });
    }

    /* do */
    
    //AML활동 보고및 조치내역 조회
    function doSearch(){
        
    	GridObj1.refresh({
            actionParam: {
                "pageID"  : pageID,
                "classID" : "RBA_50_08_03_01",
                "methodID": "getActRptInfo",
                "DCS_DT"  : "${DCS_DT}",
                "SNO"     : "${SNO}"
            },
            completedEvent: doSearch_end
        });
    }
    
    //AML활동 보고및 조치내역 조회 end
    function doSearch_end(){
    	var selObj = GridObj1.getRow(0);
        setData(selObj);
    }

    //AML활동 보고및 조치내역 HTML에 데이타 삽입
    function setData(selObj){
    	
    	form.SNO.value              = (selObj.SNO              == undefined)?"":selObj.SNO;    	
    	form.DOC_TITE.value         = (selObj.DOC_TITE    == undefined)?"":selObj.DOC_TITE;
    	form.DCS_RQST_BRNO.value    = (selObj.DCS_RQST_BRNO           == undefined)?"":selObj.DCS_RQST_BRNO;
    	form.RPT_G_C.value          = (selObj.RPT_G_C        == undefined)?"":selObj.RPT_G_C;
    	form.RSLT_G_C.value         = (selObj.RSLT_G_C        == undefined)?"":selObj.RSLT_G_C;
    	form.NOTE_CTNT.value        = (selObj.NOTE_CTNT        == undefined)?"":selObj.NOTE_CTNT;
    	form.ACTN_PLAN_YN.value     = (selObj.ACTN_PLAN_YN        == undefined)?"":selObj.ACTN_PLAN_YN;
    	form.ACT_PRGR_S_C.value     = (selObj.ACT_PRGR_S_C        == undefined)?"":selObj.ACT_PRGR_S_C;
    	form.ACTN_PLAN_TITE.value   = (selObj.ACTN_PLAN_TITE        == undefined)?"":selObj.ACTN_PLAN_TITE;
    	form.ACTN_PLAN_CTNT.value   = (selObj.ACTN_PLAN_CTNT        == undefined)?"":selObj.ACTN_PLAN_CTNT;
    	form.ACTN_PLAN_G_C.value    = (selObj.ACTN_PLAN_G_C        == undefined)?"":selObj.ACTN_PLAN_G_C;
    	
    	//유안타증권 - BSL
    	form.SEARCH_DEP_ID.value   = (selObj.BRNO             == undefined)?"":selObj.BRNO;
    	form.DEP_TITLE.value       = (selObj.BRNM             == undefined)?"":selObj.BRNM;
    	
    	Combo1 = $("#RSLT_G_C").val();        //설계평가등급
    	Combo2 = form.ACTN_PLAN_YN.value; 
    	    
    	if(Combo1!="" || Combo2==0){
    		$("#table2").hide();  
    	    $("#table3").hide(); 
    	    $("#table4").hide(); 
    	}else{
    		$("#table2").show();
    		$("#table3").show(); 
    	   	$("#table4").show(); 
    	}
    }
    
    function doClose()
    {
        window.close();
    }
    
    function doParentReload()
    {
        window.opener.location.href = window.opener.document.URL;    // 부모창 새로고침
    }
    
    /** Save */
    function doSave()
    {
        var frm = document.form;
        
        if ( getDxDateVal("DCS_DT",true) == "" || getDxDateVal("DCS_DT",true) == null ) {
        	alert("${msgel.getMsg('RBA_50_08_03_02_013','결정일자는 필수 입력항목입니다.')}");
        	return;
        }
        
        if ( form.DOC_TITE.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_03_02_016','문서제목은 필수 입력항목입니다.')}");
        	return;
        }
        
        //유안타증권 - BSL
        if ( frm.SEARCH_DEP_ID.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_03_02_021','보고부서값는 필수 입력항목입니다.')}");
        	return;
        }

        if ( form.RPT_G_C.value == "" && form.RSLT_G_C.value == "" ) {
        	alert("${msgel.getMsg('RBA_50_08_03_02_019','보고구분, 의사결정구분 두개 항목중 한개 이상 항목은 필히 입력해야 합니다.')}");
        	return;
        }

        if ( form.NOTE_CTNT.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_03_02_018','상세내용(요청내용)은 필수 입력항목입니다.')}");
        	return;
        }
        
        form.pageID.value     = 'RBA_50_08_03_03';
        form.methodID.value   = "doSave";
        form.GUBN.value       = "${GUBN}"; //0이면 등록 1이면 수정
        form.DCS_DT.value     = getDxDateVal("DCS_DT", true);
        form.DP_SEND_DT.value = getDxDateVal("DP_SEND_DT", true);
        form.ACTN_DT.value    = getDxDateVal("ACTN_DT", true);
        
        //유안타증권 - BSL
        form.BRNO.value = form.SEARCH_DEP_ID.value; 
        
        form.target           = "submitFrame";
        form.action           = "<c:url value='/'/>0001.do";
        form.encoding         = "multipart/form-data";
        //첨부파일
        
        if(submit_flag!=null){
        	form.submit = submit_flag;
        }
        
		if(!confirm('<fmt:message key="RBA_50_08_03_02_015" initVal="저장하시겠습니까?"/>')) return;
		form.submit();
    }

    function doSave_end(){
        opener.doSearch();
	 	window.close();	
    }
    
    
    function doDelete()
	{
        var frm; frm = document.form;

		if(!confirm("${msgel.getMsg('RBA_50_08_03_02_014','삭제하시겠습니까?')}")) return;

		var obj = new Object();
        obj.pageID          = pageID;
        obj.classID         = classID;
        obj.methodID        = "doDelete";
        obj.DCS_DT        = getDxDateVal("DCS_DT", true); // 발생일자
        obj.SNO             = form.SNO.value;        // 상세구분
        
        new GTActionRun().run({
            actionParam     : obj
           ,completedEvent  : function(actionParam, jsonResultData){
        	   doDeleteEnd(actionParam, jsonResultData);
            }
        });
    }
    
    
    //삭제 후 팝업 close
    function doDeleteEnd() {
        opener.doSearch();
        window.close();
    }

    //첨부파일 다운로드
    function downloadFile( FILE_SER, ATTCH_FILE_NO )
    {
        $("input[name=FILE_SER]").val(FILE_SER);
        $("input[name=ATTCH_FILE_NO]").val(ATTCH_FILE_NO);
        form.target = "_self";
        form.action = "Package/RBA/common/fileDown/fileDownload.jsp";
        form.method = "post";  
        form.submit();
    }
    
    //첨부파일 로우 삭제 
	function onDeleteAttachFile_RSLT( e ) {
		
	    var targEl;
	    if ( !e ) e = window.event;
	    if (e.target) {
	        targEl = e.target;
	    } else if (e.srcElement) {
	        targEl = e.srcElement;
	    }
	                    
	    var pEl = null; 
	    try { pEl = targEl.parentNode.parentNode ; } catch ( e ) {console.log(e); }
	    if ( pEl != null ) {
	        var tbodyObj = pEl.parentNode; 
	        var len = tbodyObj.rows.length; 
	        if ( len == 2 ) {
	            var tabObj = tbodyObj.parentNode;
	            onAddAttachFile( tabObj.id ) ; 
	        }
	                            
	        if ( len < 2 ) {
	            alert ( "${msgel.getMsg('lastRowNotDelete','마지막 행은 삭제 할 수 없습니다.')}");
	            return; 
	        }
	        tbodyObj.removeChild( pEl ) ;                                   
	    }
	}
    
	function onDeleteAttachFile_ACTN( e ) {
		
	    var targEl;
	    if ( !e ) e = window.event;
	    if (e.target) {
	        targEl = e.target;
	    } else if (e.srcElement) {
	        targEl = e.srcElement;
	    }
	                    
	    var pEl = null; 
	    try { pEl = targEl.parentNode.parentNode ; } catch ( e ) { console.log(e);}
	    if ( pEl != null ) {
	        var tbodyObj = pEl.parentNode; 
	        var len = tbodyObj.rows.length; 
	        if ( len == 2 ) {
	            var tabObj = tbodyObj.parentNode;
	            onAddAttachFile_Actn( tabObj.id ) ; 
	        }
	                            
	        if ( len < 2 ) {
	            alert ( "${msgel.getMsg('lastRowNotDelete','마지막 행은 삭제 할 수 없습니다.')}");
	            return; 
	        }
	        tbodyObj.removeChild( pEl ) ;                                   
	    }
	}
	
	//첨부파일 로우 추가 
	function onAddAttachFile( tabName ) {
	    var tabObj = document.getElementById(tabName);
	    var lastRow = tabObj.rows.item(tabObj.rows.length-1) ;
	    var tr; tr = tabObj.insertRow( tabObj.rows.length ) ;

	         
	    for(i = 0 ; i < lastRow.cells.length ; i ++ ) {
	        var cell = tr.insertCell(i);
	        cell.setAttribute("height","22"); 
	        cell.setAttribute("bgColor","#FFFFFF");
	        cell.setAttribute("align","center");
	        if( i == 0 ) {
	            cell.setAttribute("width","45%");
	            cell.innerHTML =  '<input type="hidden" name="FILE_SER_RSLT" value="0">' 
	                            + '<input type="hidden" name="FILE_POS_RSLT_temp" value="">' 
	                            + '<input type="hidden" name="LOSC_FILE_NM_RSLT_temp" value="">'  
	                            + '<input type="hidden" name="PHSC_FILE_NM_RSLT_temp" value="">' 
	                            + '<input type="hidden" name="FILE_SIZE_RSLT_temp" value="0">' 
	                            + '<input type="hidden" name="DOWNLOAD_CNT_RSLT_temp" value="0">';
	        } else if( i == 1 ) {
	            cell.setAttribute("width","45%");
	            cell.innerHTML ='<input type="file" name="NOTI_ATTACH_RSLT" id="NOTI_ATTACH_RSLT" value="" class="btnS_grey" style="width: 98%;height:22">';
	        } else if( i == 2 ) {							        
				cell.innerHTML = (lastRow.cells[i]).innerHTML;            
	        }
	    }
	}
	
	//첨부파일 로우 추가(조치계획)
	function onAddAttachFile_Actn( tabName ) {
	    var tabObj = document.getElementById(tabName);
	    var lastRow = tabObj.rows.item(tabObj.rows.length-1) ;
	    var tr; tr = tabObj.insertRow( tabObj.rows.length ) ;

	         
	    for(i = 0 ; i < lastRow.cells.length ; i ++ ) {
	        var cell = tr.insertCell(i);
	        cell.setAttribute("height","22"); 
	        cell.setAttribute("bgColor","#FFFFFF");
	        cell.setAttribute("align","center");
	        if( i == 0 ) {
	            cell.setAttribute("width","45%");
	            cell.innerHTML =  '<input type="hidden" name="FILE_SER_ACTN" value="0">' 
	                            + '<input type="hidden" name="FILE_POS_ACTN_temp" value="">' 
	                            + '<input type="hidden" name="LOSC_FILE_NM_ACTN_temp" value="">'  
	                            + '<input type="hidden" name="PHSC_FILE_NM_ACTN_temp" value="">' 
	                            + '<input type="hidden" name="FILE_SIZE_ACTN_temp" value="0">' 
	                            + '<input type="hidden" name="DOWNLOAD_CNT_ACTN_temp" value="0">';
	        } else if( i == 1 ) {
	            cell.setAttribute("width","45%");
	            cell.innerHTML ='<input type="file" name="NOTI_ATTACH_ACTN" id="NOTI_ATTACH_ACTN" value="" class="btnS_grey" style="width: 98%;height:22">';
	        } else if( i == 2 ) {							        
				cell.innerHTML = (lastRow.cells[i]).innerHTML;            
	        }
	    }
	}
	
	// HTTP 400 ERROR 관련 조치
	// URL주소를 다음 페이지로 넘기지 못해서 encodeURI처리 
	function DO_OPEN_POP(){
		
		var temp="";
		if(form.FILE_SER_RSLT.length != null && form.FILE_SER_RSLT.value==""){
			for(i=0 ; i<form.FILE_SER_RSLT.length ; i++){
				form.FILE_POS_RSLT_temp[i].value = encodeURI(form.FILE_POS_RSLT_temp[i].value);
				temp = "form.FILE_POS_RSLT"+(i+1)+".value = encodeURI(form.FILE_POS_RSLT"+(i+1)+".value)"
				eval(temp);
			}
		}else if(form.FILE_SER_RSLT.value==1){
			form.FILE_POS_RSLT_temp.value = encodeURI(form.FILE_POS_RSLT_temp.value);
			form.FILE_POS_RSLT1.value = encodeURI(form.FILE_POS_RSLT1.value);
		}
		
		temp="";
		if(form.FILE_SER_ACTN.length != null && form.FILE_SER_ACTN.value==""){
			for(i=0 ; i<form.FILE_SER_ACTN.length ; i++){
				form.FILE_POS_ACTN_temp[i].value = encodeURI(form.FILE_POS_ACTN_temp[i].value);
				temp = "form.FILE_POS_ACTN"+(i+1)+".value = encodeURI(form.FILE_POS_ACTN"+(i+1)+".value)"
				eval(temp);
			}
		}else if(form.FILE_SER_ACTN.value==1){
			form.FILE_POS_ACTN_temp.value = encodeURI(form.FILE_POS_ACTN_temp.value);
			form.FILE_POS_ACTN1.value = encodeURI(form.FILE_POS_ACTN1.value);
		}
		
		doRBASelectInputPopup("searchRbaDepPopup", 480, 580, "SEARCH_DEP_ID", "setRBASearchInputPopup(searchName, searchInfo)");
	}
	
	function doRBASelectInputPopup(pageId, width, height, searchName, afterFunction){
		submit_flag = form.submit;
		var w; w = width?width:800;
		var h; h = height?height:850;
		var scrollbars; scrollbars = 'yes';
		var resizable; resizable  = 'no';
		form.pageID.value = pageId;
		form.classID.value = "";
		form.methodID.value = "";
		form.method = "post";
		form.target = pageId;
		form.action = "/0001.do?searchName="+searchName+"&afterFunction="+afterFunction+"&amlActiveView=Y";
	    form.submit = function() {
	        url = form.action;
	        var submit = form.submit;
	        for (var i=0; i<form.elements.length; i++) if (form.elements[i].name!="length" && form.elements[i].name!="item" && form.elements[i].name!="namedItem") url += (i==0&&form.action.indexOf("?")<0?"?":"&")+form.elements[i].name+"="+((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(form.elements[i].value))?encodeURIComponent(form.elements[i].value):form.elements[i].value);
	        (win = window.open(url,form.elements["pageID"]?form.elements["pageID"].value:"","left="+getCenter_X(w)+", top="+getCenter_Y(h)+",scrollbars="+(scrollbars?scrollbars:"no")+",resizable="+(resizable?resizable:"yes")+",width="+w+", height="+h+", toolbar=no, menubar=no, status=no ")).focus();
	        form.submit = submit;
	    }
		form.submit();
	}
</script>
<!-- 저장용 iframe -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top"><iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="1" scrolling="yes"></iframe></td>
    </tr>
</table>

<form name="form" method="post" action="001.do">
    <input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="DCS_DT"/>
    <input type="hidden" name="DP_SEND_DT"/>
    <input type="hidden" name="ACTN_DT"/>
    <input type="hidden" name="SNO"            id="SNO"    value="${SNO}"   />
    <input type="hidden" name="GUBN"            id="GUBN"    value="${GUBN}"   />
    <input type="hidden" name="RSLT_ATTCH_FILE_NO" value="${RSLT_ATTCH_FILE_NO}" >
    <input type="hidden" name="ACTN_ATTCH_FILE_NO" value="${ACTN_ATTCH_FILE_NO}" >
    <input type="hidden" name="FILE_SER" value="" >
    <input type="hidden" name="ATTCH_FILE_NO" value="" >
    
    <!- 유안타증권 - BSL -->
    <input type="hidden" name="BRNO">
    <input type="hidden" name="submit_temp">
    
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_01_004','문서 제목')}*</th>
            <td colspan="4"><input name="DOC_TITE" id="DOC_TITE" type="text" value="" size="100" maxlength="100"></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_022','의사결정구분(부서)')}*</th>
            <td >${SRBACondEL.getSRBASelect("DCS_RQST_BRNO","", "", "R352", "", "", "", "", "", "")}</td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_01_001','결정일자')}*</th>
            <td>${condel.getInputDateDx('DCS_DT', DCS_DTB)}</td>
        </tr>
        <!-- 유안타증권 - BSL -START -->
        <tr>
        	<th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_020','보고부서')}*</th>
            <td colspan="4">
            	<RBATag:searchRbaInput searchName="SEARCH_DEP_ID" searchClass="cond-select" searchStyle="width: 60px;" text1Name="DEP_ID" 
					text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>" 
					searchFunction='doRBASearchInput(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepName2")' 
					popupFunction='DO_OPEN_POP()' 
					searchValue="" text1Value="" text2Value=""/>
            </td>
        </tr>
        <!-- 유안타증권 - BSL - END -->
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_001','첨부파일')}</th>
            <td colspan="4">
							<table style="width:100%">
								<tr>
									<!----------- Add File Start -------->
									<td valign="top" width="100%" align="right">
										<input type="button" name="fileAdd" id="fileAdd" value='${msgel.getMsg("AML_90_01_03_04_004","파일추가")}' class="flat-btn flat-btn-white" onclick="onAddAttachFile( 'NotiAttachTable' );" title='${msgel.getMsg("AML_90_01_03_04_004","파일추가")}'>
									</td>
									<!----------- Add File End -------->
								</tr>
								<tr>
									<td width="100%" >
									<!------------------------------------------------------------>
										<table id="NotiAttachTable" style="width:100%; border:0; cellpadding:2; cellspacing:1; bgcolor:''" >
											<script language="javascript">

											</script> 
									        <tr>
									            <th height="22" align="center" style="width:45%">${msgel.getMsg('uploadFile','새로올릴 파일')}</th>
									            <th align="center" style="width:50%">${msgel.getMsg('uploadNewFile','업로드 된 파일')}</th>
									            <th align="center" style="width:5%"></th>
									        </tr>  
<%
   if((outputRslt.getCount("FILE_SER") == 0) == false) {
       String FILE_SER_RSLT = "";
       String FILE_POS_RSLT = "";
       String LOSC_FILE_NM_RSLT = "";
       String PHSC_FILE_NM_RSLT = "";
       String FILE_SIZE_RSLT = "";
       String DOWNLOAD_CNT_RSLT = "";
       
       for(int i = 0 ; i < outputRslt.getCount("FILE_SER") ; i++) {
           FILE_SER_RSLT     = outputRslt.getText("FILE_SER",i);
           FILE_POS_RSLT     = outputRslt.getText("FILE_POS",i);
           LOSC_FILE_NM_RSLT = outputRslt.getText("LOSC_FILE_NM",i);
           PHSC_FILE_NM_RSLT = outputRslt.getText("PHSC_FILE_NM",i);
           FILE_SIZE_RSLT    = outputRslt.getText("FILE_SIZE",i);
           DOWNLOAD_CNT_RSLT = outputRslt.getText("DOWNLOAD_CNT",i);
           
           request.setAttribute("FILE_SER_RSLT",FILE_SER_RSLT);
           request.setAttribute("FILE_POS_RSLT",FILE_POS_RSLT);
           request.setAttribute("LOSC_FILE_NM_RSLT",LOSC_FILE_NM_RSLT);
           request.setAttribute("PHSC_FILE_NM_RSLT",PHSC_FILE_NM_RSLT);
           request.setAttribute("FILE_SIZE_RSLT",FILE_SIZE_RSLT);
           request.setAttribute("DOWNLOAD_CNT_RSLT",DOWNLOAD_CNT_RSLT);
 %>
			                                <tr>
			                                    <td height="22" align="left" bgcolor="#FFFFFF" >
			                                        <img src="Package/ext/images/icon/ico_save.gif" width="13" height="13" align="absmiddle">
			                                        <a class="file" href='javascript:downloadFile("${FILE_SER_RSLT}", "${RSLT_ATTCH_FILE_NO}");'><c:out value='${LOSC_FILE_NM_RSLT}'/></a>
			                                        <input type="hidden" name="FILE_SER_RSLT"                value="${FILE_SER_RSLT}">
			                                        <input type="hidden" name="FILE_POS_RSLT_temp"           value="${FILE_POS_RSLT}">
			                                        <input type="hidden" name="LOSC_FILE_NM_RSLT_temp"       value="${LOSC_FILE_NM_RSLT}">
			                                        <input type="hidden" name="PHSC_FILE_NM_RSLT_temp"       value="${PHSC_FILE_NM_RSLT}">
			                                        <input type="hidden" name="FILE_SIZE_RSLT_temp"          value="${FILE_SIZE_RSLT}">
			                                        <input type="hidden" name="DOWNLOAD_CNT_RSLT_temp"       value="${DOWNLOAD_CNT_RSLT}">
			                                        <input type="hidden" name="FILE_POS_RSLT${FILE_SER_RSLT}"     value="${FILE_POS_RSLT}${PHSC_FILE_NM_RSLT}">
			                                        <input type="hidden" name="LOSC_FILE_NM_RSLT${FILE_SER_RSLT}" value="${LOSC_FILE_NM_RSLT}"> 
			                                    </td>
			                                    <td align="center" bgcolor="#FFFFFF">
			                                        <input type="file" name="NOTI_ATTACH_RSLT"  id="NOTI_ATTACH_RSLT" class="btnS_grey" style='width: 98%;height: 22' >
			                                    </td>
			                                    <td align="center" bgcolor="#FFFFFF">
			                                    	<input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('deletebtn','삭제')}" class="flat-btn flat-btn-white" 
			                                        onclick="onDeleteAttachFile_RSLT( event );" title="${msgel.getMsg('deletebtn','삭제')}" style="align:left;">
			                                    </td>
			                                </tr>
<%
    	}
    }else{
%>
			                                <tr>
			                                    <td height="22" align="left" bgcolor="#FFFFFF">
			                                        <input type="hidden" name="FILE_SER_RSLT" id="FILE_SER_RSLT" value="0">
			                                    </td>
			                                    <td align="center" bgcolor="#FFFFFF">
			                                        <input type="file" name="NOTI_ATTACH_RSLT" id="NOTI_ATTACH_RSLT" class="btnS_grey" style='width:98%;height: 22'>
			                                    </td>
			                                    <td align="left" bgcolor="#FFFFFF">
			                                        <input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('deletebtn','삭제')}" class="flat-btn flat-btn-white" 
			                                        onclick="onDeleteAttachFile_RSLT( event );" title="${msgel.getMsg('deletebtn','삭제')}" style="align:left;">
			                                    </td>
			                                </tr>
<%
	}
%>
										</table>
									</td>
								</tr>
							</table>
			</td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_002','보고구분')}</th>
            <td>
                <RBATag:selectBoxJipyo name="RPT_G_C" cssClass="cond-select" groupCode="C0003"
                mapGroupCode="" firstComboWord="NONE" rptGjdt="MAX" eventFunction="" selectStyle="width:140px;"/>
            </td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_01_003','의사결정구분')}</th>
            <td>
                <RBATag:selectBoxJipyo name="RSLT_G_C" cssClass="cond-select" groupCode="C0045"
                mapGroupCode="" firstComboWord="NONE" rptGjdt="MAX" eventFunction="doevent(this)" selectStyle="width:140px;"/>
            </td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_003','상세내용(요청내용)')}*</th>
            <td colspan="4"><textarea name="NOTE_CTNT" style="width:100%;" rows=2 maxlength="2000"></textarea></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_004','조치계획여부')}</th>
            <td><input type="radio" name="ACTN_PLAN_YN" id="ACTN_PLAN_YN" value="1" 
            <% if ( "1".equals(ACTN_PLAN_YN) ) { %>checked <% } %> onclick="javascript:doevent(this);" >&nbsp;Y&nbsp;
            <input type="radio" name="ACTN_PLAN_YN" id="ACTN_PLAN_YN" value="0" 
            <% if ( "0".equals(ACTN_PLAN_YN) ) { %>checked <% } %> onclick="javascript:doevent(this);" >&nbsp;N</td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_005','진행상태')}</th>
            <td><input type="radio" name="ACT_PRGR_S_C" id="ACT_PRGR_S_C" value="0" <% if ( "0".equals(ACT_PRGR_S_C) ) { %>checked <% } %>>&nbsp;진행&nbsp;<input type="radio" name="ACT_PRGR_S_C" id="ACT_PRGR_S_C" value="1" <% if ( "1".equals(ACT_PRGR_S_C) ) { %>checked <% } %>>&nbsp;완료</td>
        </tr>
        <tr id="table2">
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_006','조치계획제목')}</th>
            <td colspan="4"><input name="ACTN_PLAN_TITE" id="ACTN_PLAN_TITE" type="text" value="" size="100" maxlength="100"></td>
        </tr>
        <tr id="table3">
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_007','조치계획내용')}</th>
            <td colspan="4"><textarea name="ACTN_PLAN_CTNT" style="width:100%;" rows=2 maxlength="500"></textarea></td>
        </tr>
        <tr id="table4">
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_009','조치첨부파일')}</th>
            <td colspan="4">
            				<table style="width:100%">
								<tr>
									<!----------- Add File Start -------->
									<td valign="top" width="100%" align="right">
										<input type="button" name="fileAdd" id="fileAdd" value='${msgel.getMsg("AML_90_01_03_04_004","파일추가")}' class="flat-btn flat-btn-white" onclick="onAddAttachFile_Actn( 'NotiAttachActnTable' );" title='${msgel.getMsg("AML_90_01_03_04_004","파일추가")}'>
									</td>
									<!----------- Add File End -------->
								</tr>
								<tr>
									<td width="100%" >
									<!------------------------------------------------------------>
										<table id="NotiAttachActnTable" style="width:100%; border:0; cellpadding:2; cellspacing:1; bgcolor:''" >
											<script language="javascript">

											</script> 
									        <tr>
									            <th height="22" align="center" style="width:45%">${msgel.getMsg('uploadFile','새로올릴 파일')}</th>
									            <th align="center" style="width:50%">${msgel.getMsg('uploadNewFile','업로드 된 파일')}</th>
									            <th align="center" style="width:5%"></th>
									        </tr> 
<%
   if((outputActn.getCount("FILE_SER") == 0) == false) {
       String FILE_SER_ACTN = "";
       String FILE_POS_ACTN = "";
       String LOSC_FILE_NM_ACTN = "";
       String PHSC_FILE_NM_ACTN = "";
       String FILE_SIZE_ACTN = "";
       String DOWNLOAD_CNT_ACTN = "";
       
       for(int i = 0 ; i < outputActn.getCount("FILE_SER") ; i++) {
           FILE_SER_ACTN     = outputActn.getText("FILE_SER",i);
           FILE_POS_ACTN     = outputActn.getText("FILE_POS",i);
           LOSC_FILE_NM_ACTN = outputActn.getText("LOSC_FILE_NM",i);
           PHSC_FILE_NM_ACTN = outputActn.getText("PHSC_FILE_NM",i);
           FILE_SIZE_ACTN    = outputActn.getText("FILE_SIZE",i);
           DOWNLOAD_CNT_ACTN = outputActn.getText("DOWNLOAD_CNT",i);
           
           request.setAttribute("FILE_SER_ACTN",FILE_SER_ACTN);
           request.setAttribute("FILE_POS_ACTN",FILE_POS_ACTN);
           request.setAttribute("LOSC_FILE_NM_ACTN",LOSC_FILE_NM_ACTN);
           request.setAttribute("PHSC_FILE_NM_ACTN",PHSC_FILE_NM_ACTN);
           request.setAttribute("FILE_SIZE_ACTN",FILE_SIZE_ACTN);
           request.setAttribute("DOWNLOAD_CNT_ACTN",DOWNLOAD_CNT_ACTN);
 %>
			                                <tr>
			                                    <td height="22" align="left" bgcolor="#FFFFFF" >
			                                        <img src="Package/ext/images/icon/ico_save.gif" width="13" height="13" align="absmiddle">
			                                        <a class="file" href='javascript:downloadFile("${FILE_SER_ACTN}", "${ACTN_ATTCH_FILE_NO}");'><c:out value='${LOSC_FILE_NM_ACTN}'/></a>
			                                        <input type="hidden" name="FILE_SER_ACTN"                value="${FILE_SER_ACTN}">
			                                        <input type="hidden" name="FILE_POS_ACTN_temp"           value="${FILE_POS_ACTN}">
			                                        <input type="hidden" name="LOSC_FILE_NM_ACTN_temp"       value="${LOSC_FILE_NM_ACTN}">
			                                        <input type="hidden" name="PHSC_FILE_NM_ACTN_temp"       value="${PHSC_FILE_NM_ACTN}">
			                                        <input type="hidden" name="FILE_SIZE_ACTN_temp"          value="${FILE_SIZE_ACTN}">
			                                        <input type="hidden" name="DOWNLOAD_CNT_ACTN_temp"       value="${DOWNLOAD_CNT_ACTN}">
			                                        <input type="hidden" name="FILE_POS_ACTN${FILE_SER_ACTN}"     value="${FILE_POS_ACTN}${PHSC_FILE_NM_ACTN}">
			                                        <input type="hidden" name="LOSC_FILE_NM_ACTN${FILE_SER_ACTN}" value="${LOSC_FILE_NM_ACTN}"> 
			                                    </td>
			                                    <td align="center" bgcolor="#FFFFFF">
			                                        <input type="file" name="NOTI_ATTACH_ACTN"  id="NOTI_ATTACH_ACTN" class="btnS_grey" style='width: 98%;height: 22' >
			                                    </td>
			                                    <td align="center" bgcolor="#FFFFFF">
			                                    	<input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('deletebtn','삭제')}" class="flat-btn flat-btn-white" 
			                                        onclick="onDeleteAttachFile_ACTN( event );" title="${msgel.getMsg('deletebtn','삭제')}" style="align:left;">
			                                    </td>
			                                </tr>
<%
    	}
    }else{
%>
			                                <tr>
			                                    <td height="22" align="left" bgcolor="#FFFFFF">
			                                        <input type="hidden" name="FILE_SER_ACTN" id="FILE_SER_ACTN" value="0">
			                                    </td>
			                                    <td align="center" bgcolor="#FFFFFF">
			                                        <input type="file" name="NOTI_ATTACH_ACTN" id="NOTI_ATTACH_ACTN" class="btnS_grey" style='width:98%;height: 22'>
			                                    </td>
			                                    <td align="left" bgcolor="#FFFFFF">
			                                        <input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('deletebtn','삭제')}" class="flat-btn flat-btn-white" 
			                                        onclick="onDeleteAttachFile_ACTN( event );" title="${msgel.getMsg('deletebtn','삭제')}" style="align:left;">
			                                    </td>
			                                </tr>
<%
	}
%>
										</table>
									</td>
								</tr>
							</table>
			</td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_008','수신(발신)일')}</th>
            <td>${condel.getInputDateDx('DP_SEND_DT', DP_SEND_DTB)}</td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_010','조치완료(예정)일')}</th>
            <td>${condel.getInputDateDx('ACTN_DT', ACTN_DTB)}</td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_03_02_011','계획구분')}</th>
            <td colspan="4"><input type="radio" name="ACTN_PLAN_G_C" id="ACTN_PLAN_G_C" value="M" <% if ( "M".equals(ACTN_PLAN_G_C) ) { %>checked <% } %>>&nbsp;단기(3개월)&nbsp;
            <input type="radio" name="ACTN_PLAN_G_C" id="ACTN_PLAN_G_C" value="Q" <% if ( "Q".equals(ACTN_PLAN_G_C) ) { %>checked <% } %>>&nbsp;중기(반기)&nbsp;
            <input type="radio" name="ACTN_PLAN_G_C" id="ACTN_PLAN_G_C" value="Y" <% if ( "Y".equals(ACTN_PLAN_G_C) ) { %>checked <% } %>>&nbsp;장기(반기이상)
            </td>
        </tr>
        </table>
    </div>
</div>

<div class="popup-cont-box">
    <div class="cond-btn-row" style="text-align:right;margin-top:10px;">
        <span id ="sbtn_03" >
        </span>
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-save"}')}
        <% if( "1".equals(GUBN) ) { %>
           ${btnel.getButton(outputAuth, '{btnID:"sbtn_03", cdID:"deleteBtn", defaultValue:"삭제", mode:"D", function:"doDelete", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-minus"}')}
        <% } %>
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-power-off", show:"N"}')}
    </div>
        <table border="0">
        <!-- 유안타증권 - BSL START -->
        <tr>
            <td><font color=blue>※ 관련 KoFIU 보고항목(지표)</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O1030101 (1.3.0) 평가일 기준 최근1년간 자금세탁방지 활동 관련 대표이사에게 보고한 실적 평가</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O1040101 (1.4.0) 평가일 기준 최근1년간 대표이사등이 자금세탁방지 활동과 관련된 의사결정을 수행한 실적평가</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O1070101 (1.7.0) 자금세탁방지 활동 관련 이사회 보고실적평가</font></td>
        </tr>
        <!-- 유안타증권 - BSL END -->
        </table>
</div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 