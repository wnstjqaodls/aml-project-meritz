<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_02_02.jsp
* Description     : RBA 포상 및 징계내역 관리
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 4. 20.
********************************************************************************************************************************************
--%>
<%@ page import="java.text.ParseException" %>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String prizeDt   = Util.nvl(request.getParameter("prizeDt"));
    String prizeDtb   = "";   // 화면에 표시하기 위한 값
    String sNo       = Util.nvl(request.getParameter("sNo"    ));
    String GUBN       = Util.nvl(request.getParameter("P_GUBN"    )); //구분이 0이면 등록 아니면 수정
    
    try{
    //if(GUBN.equals("0")){  //등록시 발생일자에 당일 데이터 셋팅
   	 if("0".equals(GUBN) == true){//등록시 발생일자에 당일 데이터 셋팅
        prizeDtb = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
    } else {
    	prizeDtb = jspeed.base.util.DateHelper.format(prizeDt, "yyyyMMdd", "yyyy-MM-dd");
    }
    }catch(ParseException e){
    	Log.logAML(Log.ERROR, e);
    }

    request.setAttribute("PRIZE_DT"              ,prizeDt            );
    request.setAttribute("PRIZE_DTB"              ,prizeDtb            );
    request.setAttribute("SNO"        ,sNo      );
    request.setAttribute("GUBN"      ,GUBN    );
%>
<script>
    var GridObj1    = null;
   
    /** Initial function */
    $(document).ready( function() {
    	$('.popup-contents').css({overflow:"auto"});
    	
    	// 포상및 징계내역 수정시 발생일자 수정불가
/*         if(form1.GUBN.value == "0"){
        	$(PRIZE_DT).dxDateBox("instance").option("disabled", false);
        }else{
        	$(PRIZE_DT).dxDateBox("instance").option("disabled", true);            
        } */
    	
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
           ,headerId        : 'RBA_50_08_02_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : '포상및 징계내역관리 - 상세'
           ,completedEvent  : function(){
               setupGridFilter([GridObj1]);
               if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
                   doSearch();
               }
            }
        });
    }

    /* do */
    
    //포상및 징계내역관리 조회
    function doSearch(){
        
        GridObj1.refresh({
            actionParam: {
                "pageID"  : "RBA_50_08_02_02",
                "classID" : "RBA_50_08_02_02",
                "methodID": "getPrizeInfo",
                "prizeDt" : "${PRIZE_DT}",
                "sNo"     : "${SNO}"
            },
            completedEvent: doSearch_end
        });
    }
    
    //포상및 징계내역관리 조회 end
    function doSearch_end(){
    	var selObj = GridObj1.getRow(0);
        setData(selObj);
    }

    //포상및 징계내역관리 HTML에 데이타 삽입
    function setData(selObj){
    	form1.SNO.value               = (selObj.SNO               == undefined)?"":selObj.SNO;
        form1.EMPL_VALT_G_C.value     = (selObj.EMPL_VALT_G_C     == undefined)?"":selObj.EMPL_VALT_G_C;
        form1.EMP_NM.value            = (selObj.EMP_NM            == undefined)?"":selObj.EMP_NM;
        form1.NOTE_CTNT.value         = (selObj.NOTE_CTNT         == undefined)?"":selObj.NOTE_CTNT;
        
        form1.loginId.value           = (selObj.LOGIN_ID          == undefined)?"":selObj.LOGIN_ID;
        form1.DEP_ID.value            = (selObj.DEP_ID            == undefined)?"":selObj.DEP_ID;
        form1.DEP_TITLE.value         = (selObj.DEP_TITLE         == undefined)?"":selObj.DEP_TITLE;
        form1.EMPL_JBTT_CODE.value    = (selObj.EMPL_JBTT_CODE    == undefined)?"":selObj.EMPL_JBTT_CODE;
        form1.EMPL_JBTT_CODE_NM.value = (selObj.EMPL_JBTT_CODE_NM == undefined)?"":selObj.EMPL_JBTT_CODE_NM;

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
        var frm = document.form1;
        
        if ( getDxDateVal("PRIZE_DT",true) == "" || getDxDateVal("PRIZE_DT",true) == null ) {
        	alert("${msgel.getMsg('RBA_50_08_02_02_005','발생일자는 필수 입력항목입니다.')}");
        	return;
        }

        if ( frm.EMPL_VALT_G_C.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_02_02_006','임직원 평가구분은 필수 입력항목입니다.')}");
        	return;
        }
        
        if ( frm.EMP_NM.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_02_02_007','직원명은 필수 입력항목입니다.')}");
        	return;
        }
        
        if ( frm.NOTE_CTNT.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_02_02_008','상세내용은 필수 입력항목입니다.')}");
        	return;
        }
        
		if(!confirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}")) return;
		
		GridObj1.save({
            actionParam     : {
                "pageID"           : "RBA_50_08_02_02",
                "classID"          : "RBA_50_08_02_02",
                "methodID"         : "doSave",
                "EMPL_VALT_G_C"    : form1.EMPL_VALT_G_C.value,  
                "EMP_NM"           : form1.EMP_NM.value,      
                "NOTE_CTNT"        : form1.NOTE_CTNT.value,               
                "PRIZE_DT"         : getDxDateVal("PRIZE_DT", true),    //발생일자
                "LOGIN_ID"         : $("#loginId").val(),
                "DEP_ID"           : $("#DEP_ID").val(),
                "DEP_TITLE"        : $("#DEP_TITLE").val(),
                "EMPL_JBTT_CODE"   : $("#EMPL_JBTT_CODE").val(),
                "EMPL_JBTT_CODE_NM": $("#EMPL_JBTT_CODE_NM").val()
            }
           ,sendFlag      : "USERDATA"
           ,completedEvent: doSave_end
        });
    }

    function doSave_end()
    {
        opener.doSearch();
	 	window.close();	
    }
    
    /** Update */
    function doUpdate()
    {
        var frm = document.form1;

        if ( frm.EMPL_VALT_G_C.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_02_02_006','임직원 평가구분은 필수 입력항목입니다.')}");
        	return;
        }
        
        if ( frm.EMP_NM.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_02_02_007','직원명은 필수 입력항목입니다.')}");
        	return;
        }
        
        if ( frm.NOTE_CTNT.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_02_02_008','상세내용은 필수 입력항목입니다.')}");
        	return;
        }

        if(!confirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}")) return;
		
		var obj = new Object();
        obj.pageID          = "RBA_50_08_02_02";
        obj.classID         = "RBA_50_08_02_02";
        obj.methodID        = "doUpdate";
        //obj.PRIZE_DT        = getDxDateVal("PRIZE_DT", true); // 발생일자
        obj.SNO             = form1.SNO.value;        // 상세구분
        obj.EMPL_VALT_G_C   = form1.EMPL_VALT_G_C.value;    // 임직원평가구분코드
        obj.EMP_NM          = form1.EMP_NM.value;           // 직원명
        obj.NOTE_CTNT       = form1.NOTE_CTNT.value;        // 상세구분
        
        obj.LOGIN_ID       = $("#loginId").val();
        obj.DEP_ID         = $("#DEP_ID").val();
        obj.DEP_TITLE      = $("#DEP_TITLE").val();
        obj.EMPL_JBTT_CODE = $("#EMPL_JBTT_CODE").val();
        obj.EMPL_JBTT_CODE_NM = $("#EMPL_JBTT_CODE_NM").val();
        
        
        obj.PRIZE_DT_ORG = "${PRIZE_DT}";
        obj.PRIZE_DT_NEW = getDxDateVal("PRIZE_DT", true);
        
        
        new GTActionRun().run({
            actionParam     : obj
           ,completedEvent  : function(actionParam, jsonResultData){
        	   doUpdate_end(actionParam, jsonResultData);
            }
        });
    }

    function doUpdate_end(actionParam, jsonResultData)
    {
        opener.doSearch();
	 	window.close();	
    }
    
    function doDelete()
	{
        var frm; frm = document.form1;

		if(!confirm("${msgel.getMsg('RBA_50_08_03_02_014','삭제하시겠습니까?')}")) return;

		var obj = new Object();
        obj.pageID          = "RBA_50_08_02_02";
        obj.classID         = "RBA_50_08_02_02";
        obj.methodID        = "doDelete";
        obj.PRIZE_DT        = getDxDateVal("PRIZE_DT", true); // 발생일자
        obj.SNO             = form1.SNO.value;        // 상세구분
        
        new GTActionRun().run({
            actionParam     : obj
           ,completedEvent  : function(actionParam, jsonResultData){
        	   doUpdate_end(actionParam, jsonResultData);
            }
        });

    }    
    
    function doRBASelectInputPopup_MZ(pageId, width, height, searchName, afterFunction){
    	var w; w = width?width:800;
    	var h; h = height?height:850;
    	var scrollbars; scrollbars = 'yes';
    	var resizable; resizable  = 'no';
    	form.pageID.value = pageId;
    	form.classID.value = "";
    	form.methodID.value = "";
    	//window_popup_open(pageId, width, height, '');
    	form.method = "post";
    	form.target = pageId;
    	form.action = "/0001.do?searchName="+searchName+"&afterFunction="+afterFunction;
        window_popup_open(form, width, height, pageId);
        form.submit = function() {
            url = form.action;
            var submit = form.submit;
            for (var i=0; i<form.elements.length; i++) if (form.elements[i].name!="length" && form.elements[i].name!="item" && form.elements[i].name!="namedItem") url += (i==0&&form.action.indexOf("?")<0?"?":"&")+form.elements[i].name+"="+((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(form.elements[i].value))?encodeURIComponent(form.elements[i].value):form.elements[i].value);
            (win = window.open(url,form.elements["pageID"]?form.elements["pageID"].value:"","left="+getCenter_X(w)+", top="+getCenter_Y(h)+",scrollbars="+(scrollbars?scrollbars:"no")+",resizable="+(resizable?resizable:"yes")+",width="+w+", height="+h+", toolbar=no, menubar=no, status=no ")).focus();
            form.submit = submit;
        }
    	form.submit();
    }
    
    function setRBASearchInputPopup_MZ(searchName, searchInfo){
    	
	   	$("#loginId").val(searchInfo.loginId);
	   	$("#EMP_NM").val(searchInfo.userName);
	   	$("#DEP_TITLE").val(searchInfo.DEP_ID_NM);
	   	$("#EMPL_JBTT_CODE_NM").val(searchInfo.POSITION_NM);
	   	$("#DEP_ID").val(searchInfo.DEP_DESC);
	   	$("#EMPL_JBTT_CODE").val(searchInfo.EMPL_JBTT_CODE);
    	
    }
</script>
<form name="form" id="form" method="post">
	<input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
</form>
<form name="form1" id="form1" method="post">
    <input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="EMPL_JBTT_CODE"  id="EMPL_JBTT_CODE"       />
    <input type="hidden" name="DEP_ID"  id="DEP_ID"       />
    <input type="hidden" name="GUBN"            id="GUBN"    value="${GUBN}"   />
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_02_02_009','포상(징계)일자')}*</th>
            <td>${condel.getInputDateDx('PRIZE_DT', PRIZE_DTB)}</td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_02_02_001','순번')}*</th>
            <td><input name="SNO" id="SNO" type="text" value="" size="5" readonly></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_02_02_002','임직원평가구분')}*</th>
            <td colspan="4">
                <RBATag:selectBoxJipyo name="EMPL_VALT_G_C" cssClass="cond-select" groupCode="C0046"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:500px;"/>
            </td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_02_02_003','직원명')}*</th>
            <td ><input name="EMP_NM" id="EMP_NM" type="text" value="" size="30" maxlength="20">
            	<span class="cond-branch-btn" onclick='javascript:doRBASelectInputPopup_MZ("searchRbaUserPopup", 400, 500, "MNGR_JKW_NO", "setRBASearchInputPopup_MZ(searchName, searchInfo)") '>
            		<i class="fa fa-search" aria-hidden="true"></i>
            	</span>
            </td>
            <th style="text-align:left;">사번</th>
            <td ><input name="loginId" id="loginId" type="text" value="" size="35" maxlength="20"></td>
        </tr>
        <tr>
            <th style="text-align:left;">부서명</th>
            <td ><input name="DEP_TITLE" id="DEP_TITLE" type="text" value="" size="30" maxlength="20"></td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_01_02_003','직급')}</th>
            <td ><input name="EMPL_JBTT_CODE_NM" id="EMPL_JBTT_CODE_NM" type="text" value="" size="35" maxlength="20"></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_02_02_004','상세내용')}*</th>
            <td colspan="4"><textarea name="NOTE_CTNT" style="width:100%;" rows=6 maxlength="2000"></textarea></td>
        </tr>
        </table>
    </div>
</div>

<div class="popup-cont-box">
    <div class="cond-btn-row" style="text-align:right;margin-top:10px;">
        <span id ="sbtn_03" >
        </span>
        <% if("0".equals(GUBN) ) { %>
           ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-save"}')}
        <% } else if( "1".equals(GUBN) ) { %>
           ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doUpdate", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-save"}')}
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
            <td><font color=blue> - 02O1050101 (1.5.0) 평가일 기준 최근1년간 임직원에 대한 업무포상, 내부징계및 인센티브 실적 인원수</font></td>
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
