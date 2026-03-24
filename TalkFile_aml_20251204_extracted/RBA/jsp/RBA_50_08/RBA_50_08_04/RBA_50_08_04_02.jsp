<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_04_02.jsp
* Description     : 교육계획및 현황
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 9.
********************************************************************************************************************************************
--%>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<%@page import="java.text.ParseException"                                           %>
<%-- <%@page import="com.gtone.aml.dao.common.MDaoUtilSingle"                            %> --%>
<%-- <%@page import="com.gtone.rba.server.type03.RBA_50.RBA_50_08.RBA_50_08_04.RBA_50_08_04_01" %> --%>
<%-- <%@page import="com.gtone.rba.server.type03.RBA_50.RBA_50_08.RBA_50_08_04.RBA_50_08_04_02" %> --%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	DataObj output = (DataObj)request.getAttribute("output");
	String eduDt   = Util.nvl(request.getParameter("eduDt"));  // 작성일자
    String eduSdt   = Util.nvl(request.getParameter("EDU_SDT"));
    String eduSdtb   = "";   // 화면에 표시하기 위한 값
	String eduEdt   = Util.nvl(request.getParameter("EDU_EDT"));
    String eduEdtb   = "";   // 화면에 표시하기 위한 값
    String sNo       = Util.nvl(request.getParameter("sNo"    ));
    String GUBN       = Util.nvl(request.getParameter("P_GUBN"    )); //구분이 0이면 등록 아니면 수정
    String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
    
    
    try{
    //if(GUBN.equals("0")){  //등록시 발생일자에 당일 데이터 셋팅
    if("0".equals(GUBN) == true){  //등록시 발생일자에 당일 데이터 셋팅
    	eduDt = DateUtil.getDate().substring(0,8);
    	eduSdtb = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
    	eduEdtb = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
    } else {
    	eduSdtb = jspeed.base.util.DateHelper.format(eduSdt, "yyyyMMdd", "yyyy-MM-dd");
    	eduEdtb = jspeed.base.util.DateHelper.format(eduEdt, "yyyyMMdd", "yyyy-MM-dd");
    }
    }catch(ParseException e){
    	Log.logAML(Log.ERROR, e);
    }

    request.setAttribute("EDU_DT"              ,eduDt            );
    request.setAttribute("EDU_SDT"              ,eduSdt            );
    request.setAttribute("EDU_SDTB"              ,eduSdtb            );
    request.setAttribute("EDU_EDT"              ,eduEdt            );
    request.setAttribute("EDU_EDTB"              ,eduEdtb            );
    request.setAttribute("SNO"        ,sNo      );
    request.setAttribute("GUBN"      ,GUBN    );
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
               setupGridFilter([GridObj1]);
               if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
            	   doSearch();
               }
            }
        });
    }

    function chkNum( targetVal ) {
    	var isNum = "T";
    	    	
    	for ( var i = 0; i < targetVal.length; i++) {
    		if ( targetVal.charAt(i) < '0' || targetVal.charAt(i) > '9' ) {
    			return isNum = "F";
    		}
    	}
    	
    	return isNum;
    }
    
    function chkNum2( targetVal ) {
    	var isNum = "T";
    	
    	if ( isNaN(targetVal) ) {
    		isNum = "F";
    	}
    	
    	return isNum;
    }
    
    /* do */
    
    //AML활동 보고및 조치내역 조회
    function doSearch(){
        
    	GridObj1.refresh({
            actionParam: {
                "pageID"  : pageID,
                "classID" : "RBA_50_08_04_01",
                "methodID": "getEduInfo",
                "EDU_DT"  : "${EDU_DT}",
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
    	var frmDep; frmDep = document.formDep;
    	
    	form.SNO.value              = (selObj.SNO              == undefined)?"":selObj.SNO;    	
    	form.EDU_SUBJ_NM.value      = (selObj.EDU_SUBJ_NM      == undefined)?"":selObj.EDU_SUBJ_NM;
    	form.EDU_MAIN_BRNO.value    = (selObj.EDU_MAIN_BRNO    == undefined)?"":selObj.EDU_MAIN_BRNO;
    	//form.SEARCH_DEP_ID.value    = (selObj.EDU_MAIN_BRNO    == undefined)?"":selObj.EDU_MAIN_BRNO;
    	//form.DEP_ID.value    = (selObj.EDU_MAIN_BRNO    == undefined)?"":selObj.EDU_MAIN_BRNO;
    	//form.DEP_TITLE.value    = (selObj.EDU_MAIN_BRNM    == undefined)?"":selObj.EDU_MAIN_BRNM;
    	form.EDU_CHNL_G_C.value     = (selObj.EDU_CHNL_G_C     == undefined)?"":selObj.EDU_CHNL_G_C;
    	form.EDU_SDT.value          = (selObj.EDU_SDT          == undefined)?"":selObj.EDU_SDT;
    	form.EDU_EDT.value          = (selObj.EDU_EDT          == undefined)?"":selObj.EDU_EDT;
    	form.EDU_PGM_C.value		= (selObj.EDU_PGM_C        == undefined)?"":selObj.EDU_PGM_C;
    	form.EDU_HOUR.value         = (selObj.EDU_HOUR         == undefined)?"":selObj.EDU_HOUR;
    	form.EDU_JKW_NM.value       = (selObj.EDU_JKW_NM       == undefined)?"":selObj.EDU_JKW_NM;
    	form.EDU_TGT_PCNT.value     = (selObj.EDU_TGT_PCNT     == undefined)?"":selObj.EDU_TGT_PCNT;
    	form.FNSH_PCNT.value        = (selObj.FNSH_PCNT        == undefined)?"":selObj.FNSH_PCNT;
    	
    	//frmDep.SEARCH_DEP_ID1.value    = (selObj.EDU_MAIN_BRNO    == undefined)?"":selObj.EDU_MAIN_BRNO;
    	//frmDep.DEP_ID1.value    = (selObj.EDU_MAIN_BRNO    == undefined)?"":selObj.EDU_MAIN_BRNO;
    	//frmDep.DEP_TITLE1.value    = (selObj.EDU_MAIN_BRNM    == undefined)?"":selObj.EDU_MAIN_BRNM;    	
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
        var isNumChk = "";
        
        if ( frm.EDU_SUBJ_NM.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_04_02_013','교육과목명은 필수 입력항목입니다.')}");
        	return;
        }
        
        if ( getDxDateVal("EDU_SDT", true) == "" || getDxDateVal("EDU_SDT", true).length != 8 ) {        	
        	alert("${msgel.getMsg('RBA_50_08_04_02_014','교육시작일은 필수 입력항목입니다.')}");
        	return;
        }

        if ( getDxDateVal("EDU_EDT", true) == "" || getDxDateVal("EDU_EDT", true).length != 8 ) {
        	alert("${msgel.getMsg('RBA_50_08_04_02_015','교육종료일은 필수 입력항목입니다.')}");
        	return;
        }
        
        //if ( form.EDU_MAIN_BRNO.value == "" ) {
        	//alert("${msgel.getMsg('RBA_50_08_04_02_018','교육주관부서는 필수 입력항목입니다.')}");
        	//return;
        //}

        if ( frm.EDU_HOUR.value == "" ) {
        	alert("${msgel.getMsg('RBA_50_08_04_02_019','교육시간은 필수 입력항목입니다.')}");
        	return;
        }
        
        isNumChk = chkNum2( frm.EDU_HOUR.value );
        if ( isNumChk == "F") {
        	alert("${msgel.getMsg('RBA_50_08_04_02_023','교육시간항목에는 숫자를 입력해야 합니다.')}");
        	return;
        }

        if ( frm.EDU_JKW_NM.value == "" ) {
        	alert("${msgel.getMsg('RBA_50_08_04_02_020','강사명은 필수 입력항목입니다.')}");
        	return;
        }

        if ( frm.EDU_TGT_PCNT.value == "" ) {
        	alert("${msgel.getMsg('RBA_50_08_04_02_021','계획(대상)인원은 필수 입력항목입니다.')}");
        	return;
        }

        isNumChk = chkNum( frm.EDU_TGT_PCNT.value );
        if ( isNumChk == "F") {
        	alert("${msgel.getMsg('RBA_50_08_04_02_024','계획(대상)인원항목에는 숫자를 입력해야 합니다.')}");
        	return;
        }
        
        if ( frm.FNSH_PCNT.value == "" ) {
        	alert("${msgel.getMsg('RBA_50_08_04_02_022','이수인원은 필수 입력항목입니다.')}");
        	return;
        }

        isNumChk = chkNum( frm.FNSH_PCNT.value );
        if ( isNumChk == "F") {
        	alert("${msgel.getMsg('RBA_50_08_04_02_025','이수인원항목에는 숫자를 입력해야 합니다.')}");
        	return;
        }
        
        frm.pageID.value     = 'RBA_50_08_04_03';
        frm.methodID.value   = "doSave";
        frm.GUBN.value       = "${GUBN}"; //0이면 등록 1이면 수정
        frm.EDU_SDT.value    = getDxDateVal("EDU_SDT", true);
        frm.EDU_EDT.value    = getDxDateVal("EDU_EDT", true);
        //frm.EDU_MAIN_BRNO.value = frm.DEP_ID.value;
        frm.target           = "submitFrame";
        frm.action           = "<c:url value='/'/>0001.do";
        frm.encoding         = "multipart/form-data";
        
		if(!confirm('<fmt:message key="RBA_50_08_04_02_016" initVal="저장하시겠습니까?"/>')) return;
		
		frm.submit();
		
    }

    function doSave_end()
    {
        opener.doSearch();
	 	window.close();	
    }
    
    function doDelete()
	{
        var frm = document.form;

		if(!confirm("${msgel.getMsg('RBA_50_08_04_02_017','삭제하시겠습니까?')}")) return;

		var obj = new Object();
        obj.pageID          = pageID;
        obj.classID         = classID;
        obj.methodID        = "doDelete";
        obj.EDU_DT          = frm.EDU_DT.value; // 발생일자
        obj.SNO             = frm.SNO.value;        // 순번
        
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
    function downloadFile( FILE_SER )
    {
        $("input[name=FILE_SER]").val(FILE_SER);
        form.target = "_self";
        form.action = "Package/RBA/common/fileDown/fileDownload.jsp";
        form.method = "post";  
        form.submit();
    }
    
    //첨부파일 로우 삭제 
	function onDeleteAttachFile( e ) {
		
	    var targEl;
	    if ( !e ) e = window.event;
	    if (e.target) {
	        targEl = e.target;
	    } else if (e.srcElement) {
	        targEl = e.srcElement;
	    }
	                    
	    var pEl = null; 
	    try { pEl = targEl.parentNode.parentNode ; } catch ( e ) {console.log(e);}
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
	            cell.innerHTML =  '<input type="hidden" name="FILE_SER" value="0">' 
	                            + '<input type="hidden" name="FILE_POS_temp" value="">' 
	                            + '<input type="hidden" name="LOSC_FILE_NM_temp" value="">'  
	                            + '<input type="hidden" name="PHSC_FILE_NM_temp" value="">' 
	                            + '<input type="hidden" name="FILE_SIZE_temp" value="0">' 
	                            + '<input type="hidden" name="DOWNLOAD_CNT_temp" value="0">';
	        } else if( i == 1 ) {
	            cell.setAttribute("width","45%");
	            cell.innerHTML ='<input type="file" name="NOTI_ATTACH" id="NOTI_ATTACH" value="" class="btnS_grey" style="width: 98%;height:22">';
	        } else if( i == 2 ) {							        
				cell.innerHTML = (lastRow.cells[i]).innerHTML;            
	        }
	    }
	}
	
	//RBATag:searchInput를 사용한 팝업 검색
	//popup pageId, popup width, popup height, searchInput의 id, text1과 text2에 데이터 셋팅 function
	function doRBASelectInputPopupL(pageId, width, height, searchName, afterFunction){
		var frmDep = document.formDep;
		var frm; frm = document.form;
		var w; w = width?width:800;
		var h; h = height?height:850;
		var scrollbars; scrollbars = 'yes';
		var resizable; resizable  = 'no';
		
		frmDep.pageID.value = pageId;
		frmDep.classID.value = "";
		frmDep.methodID.value = "";
		//window_popup_open(pageId, width, height, '');
		frmDep.method = "post";
		frmDep.target = pageId;
		frmDep.action = "/0001.do?searchName="+searchName+"&afterFunction="+afterFunction;
	    //window_popup_open(form, width, height, pageId);
	    frmDep.submit = function() {
	        url = frmDep.action;
	        var submit = frmDep.submit;
	        for (var i=0; i<frmDep.elements.length; i++) if (frmDep.elements[i].name!="length" && frmDep.elements[i].name!="item" && frmDep.elements[i].name!="namedItem") url += (i==0&&frmDep.action.indexOf("?")<0?"?":"&")+frmDep.elements[i].name+"="+((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(frmDep.elements[i].value))?encodeURIComponent(frmDep.elements[i].value):frmDep.elements[i].value);
	        (win = window.open(url,frmDep.elements["pageID"]?frmDep.elements["pageID"].value:"","left="+getCenter_X(w)+", top="+getCenter_Y(h)+",scrollbars="+(scrollbars?scrollbars:"no")+",resizable="+(resizable?resizable:"yes")+",width="+w+", height="+h+", toolbar=no, menubar=no, status=no ")).focus();
	        frmDep.submit = submit;
	    }
	    frmDep.submit();
	}


	//RBATag:searchInput를 사용한 팝업 검색 후 데이터 셋팅
	function setRBASearchInputPopupL(searchName, searchInfo){
		jQuery("#"+searchName).val(searchInfo.searchValue);
		jQuery("#"+jQuery("#"+searchName).attr("text1Name")).val(searchInfo.text1Value);
		jQuery("#"+jQuery("#"+searchName).attr("text2Name")).val(searchInfo.text2Value);
	}
	
	//RBATag:searchInput를 사용한 검색
	//이벤트 객체, action class, ajax 호출 후 수행할 function
	//doRBASearchInputL(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepNameL2")
	function doRBASearchInputL(obj, action, afterFunction){
		
		var param = new Object();
		param.searchName = jQuery(obj).attr("id");
		param.text1Name = jQuery(obj).attr("text1Name");
		param.text2Name = jQuery(obj).attr("text2Name");
		param.SEARCH_VALUE = jQuery(obj).val();
		
		if(jQuery(obj).val()=='') {
			/*alert('검색조건을 입력하세요.');*/
			jQuery("#"+param.searchName).val("");
			jQuery("#"+param.text1Name).val("");
			jQuery("#"+param.text2Name).val("전체");
			return;
		}

		goAjaxWidthReturnL(action, param, afterFunction);
	}
	
	function goAjaxWidthReturnL( actionName, paramdata, callbackfunc)
	{
		var resultJson;
		jQuery.ajax ( { type:'POST',
				url: '/JSONServlet?Action@@@=' + actionName,
				dataType:'text',					
				processData:true,
				data: paramdata,
				success : function ( jsonData )
				{
					resultJson = JSON.parse(jsonData);
					if(resultJson.ERROR && resultJson.ERRCODE != "00000"){
						var msg = resultJson.ERROR[0].ERRMSG;
						alert(msg);
						return;
					}else{
						eval(callbackfunc + "(  resultJson, paramdata  )");
					}
				},
				error : function(xhr, textStatus)
				{
					alert("Error" + textStatus);
				}
			}
		)
		return resultJson;
	}
	
	//RBATag:searchInput를 사용한 검색 후 부서명 셋팅
	function setDepNameL2(jsonObj, paramdata){
		var cnt = jsonObj.RESULT.length;
		
		if (cnt > 0) {
			//document.form.SEARCH_DEP_ID.value = jsonObj.RESULT[0].DPRT_CD;
			//alert(document.form.SEARCH_DEP_ID.value);
			jQuery("#"+paramdata.searchName).val(jsonObj.RESULT[0].DPRT_CD);
			jQuery("#"+paramdata.text1Name).val(jsonObj.RESULT[0].DPRT_CD);
			jQuery("#"+paramdata.text2Name).val(jsonObj.RESULT[0].DPRT_NM);
		} else {	
			alert(jsonObj.ERROR[0].ERRMSG);
			jQuery("#"+paramdata.searchName).val("");
			jQuery("#"+paramdata.text1Name).val("");
			jQuery("#"+paramdata.text2Name).val("");
		}
	}

</script>
<!-- 저장용 iframe -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top"><iframe name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="1" scrolling="yes"></iframe></td>
    </tr>
</table>

<form name="formDep" id="formDep" method="post">
    <input type="hidden" name="pageID"          id="pageID"     />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="SEARCH_DEP_ID1"   id="SEARCH_DEP_ID1"       />
    <input type="hidden" name="DEP_ID1"          id="DEP_ID1"       />
    <input type="hidden" name="DEP_TITLE1"       id="DEP_TITLE1"       />
</form>
<form name="form" id="form" method="post">
    <input type="hidden" name="pageID"          id="pageID"     value="RBA_50_08_04_02"    />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="EDU_DT"          value="${EDU_DT}"/>
    <input type="hidden" name="EDU_SDT"         value=""/>
    <input type="hidden" name="EDU_EDT"         value=""/>
    <input type="hidden" name="GUBN"            value="${GUBN}"   />
    <input type="hidden" name="ATTCH_FILE_NO" value="${ATTCH_FILE_NO}" >
    <input type="hidden" name="EDU_MAIN_BRNO" id="EDU_MAIN_BRNO">
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_01_004','교육과목명')}*</th>
            <td><input name="EDU_SUBJ_NM" id="EDU_SUBJ_NM" type="text" value="" size="30" maxlength="100"></td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_001','순번')}*</th>
            <td><input name="SNO" id="SNO" type="text" value="${SNO}" size="10" readonly></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_01_002','교육대상')}*</th>
            <td>
                <RBATag:selectBoxJipyo name="EDU_TGT_G_C" cssClass="cond-select" groupCode="C0004"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:140px;"/>
            </td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_01_003','교육채널')}*</th>
            <td>
                <RBATag:selectBoxJipyo name="EDU_CHNL_G_C" cssClass="cond-select" groupCode="C0006"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:140px;"/>
            </td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_002','교육시작일')}*</th>
            <td>${condel.getInputDateDx('EDU_SDT', EDU_SDTB)}</td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_003','교육종료일')}*</th>
            <td>${condel.getInputDateDx('EDU_EDT', EDU_EDTB)}</td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_004','첨부파일')}</th>
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
									        <tr>
									            <th height="22" align="center" style="width:45%">${msgel.getMsg('uploadFile','업로드 된 파일')}</th>
									            <th align="center" style="width:50%">${msgel.getMsg('uploadNewFile','새로올릴 파일')}</th>
									            <th align="center" style="width:5%"></th>
									        </tr>  
<%
   if((output.getCount("FILE_SER") == 0) == false) {
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
			                                    <td align="center" bgcolor="#FFFFFF">
			                                        <input type="file" name="NOTI_ATTACH"  id="NOTI_ATTACH" class="btnS_grey" style='width: 98%;height: 22' >
			                                    </td>
			                                    <td align="center" bgcolor="#FFFFFF">
			                                    	<input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('deletebtn','삭제')}" class="flat-btn flat-btn-white" 
			                                        onclick="onDeleteAttachFile( event );" title="${msgel.getMsg('deletebtn','삭제')}" style="align:left;">
			                                    </td>
			                                </tr>
<%
    	}
    }else{
%>
			                                <tr>
			                                    <td height="22" align="left" bgcolor="#FFFFFF">
			                                        <input type="hidden" name="FILE_SER" id="FILE_SER" value="0">
			                                    </td>
			                                    <td align="center" bgcolor="#FFFFFF">
			                                        <input type="file" name="NOTI_ATTACH" id="NOTI_ATTACH" class="btnS_grey" style='width:98%;height: 22'>
			                                    </td>
			                                    <td align="left" bgcolor="#FFFFFF">
			                                        <input type="button" name="fileDelete" id="fileDelete"  value="${msgel.getMsg('deletebtn','삭제')}" class="flat-btn flat-btn-white" 
			                                        onclick="onDeleteAttachFile( event );" title="${msgel.getMsg('deletebtn','삭제')}" style="align:left;">
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
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_005','교육프로그램')}*</th>
            <td>
            <RBATag:selectBoxJipyo name="EDU_PGM_C" cssClass="cond-select" groupCode="C0005"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:140px;"/>
            </td>            
        </tr>
        <tr>
 <%--            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_006','교육주관부서')}</th>
            <td>
            	<RBATag:searchRbaInput searchName="SEARCH_DEP_ID" searchClass="cond-select" searchStyle="width: 60px;" text1Name="DEP_ID" 
					text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>" 
					searchFunction='doRBASearchInputL(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepNameL2")' 
					popupFunction='doRBASelectInputPopupL("RBA_50_08_04_05", 400, 500, "SEARCH_DEP_ID", "setRBASearchInputPopupL(searchName, searchInfo)")' 
					searchValue="" text1Value="" text2Value=""/>                 --%>
			<th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_008','강사명')}*</th>
            <td ><input name="EDU_JKW_NM" id="EDU_JKW_NM" type="text" value="" size="10" maxlength="100"></td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_007','교육시간(H)')}*</th>
            <td><input name="EDU_HOUR" id="EDU_HOUR" type="text" value="" size="10" maxlength="5"></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_009','계획(대상)인원')}*</th>
            <td><input name="EDU_TGT_PCNT" id="EDU_TGT_PCNT" type="text" value="" size="10" maxlength="5"></td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_04_02_010','이수인원(명)')}*</th>
            <td><input name="FNSH_PCNT" id="FNSH_PCNT" type="text" value="" size="10" maxlength="5"></td>
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
        <tr>
            <td><font color=blue>※ 관련 KoFIU 보고항목(지표)</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O2060101 (1.6.0) 평가일 기준 최근1년간 이사회 구성원 1인당 평균 교육시간 평가</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O2060101 (1.8.0) 평가일 기준 최근1년간 자금세탁방지 관련 부점잠(지점장 및 부서장 직급)상위자에 대한 1인당 평균 교육시간 평가</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O2060101 (2.6.0) 평가일 기준 최근1년간 직원 1인당 평균 교육시간 평가</font></td>
        </tr> 
        </table>
</div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 