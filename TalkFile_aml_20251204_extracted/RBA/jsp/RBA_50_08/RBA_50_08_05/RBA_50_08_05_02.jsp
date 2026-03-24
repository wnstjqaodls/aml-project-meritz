<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_05_02.jsp
* Description     : 지점점검 관리 상세
* Group           : GTONE
* Author          : KDO
* Since           : 2018. 5. 10.
********************************************************************************************************************************************
--%>
<%@ page import="java.text.ParseException" %>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String isptDt   = Util.nvl(request.getParameter("isptDt"));
    String isptDtb   = "";   // 화면에 표시하기 위한 값
    String ACTN_DT   = Util.nvl(request.getParameter("ACTN_DT"));
    String ACTN_DTB   = "";   // 화면에 표시하기 위한 값
    String sNo       = Util.nvl(request.getParameter("sNo"    ));
    String GUBN       = Util.nvl(request.getParameter("P_GUBN"    )); //구분이 0이면 등록 아니면 수정
    
    try{
    //if(GUBN.equals("0")){  //등록시 발생일자(포맷 : yyyy-MM-dd)에 당일 데이터 셋팅하기 위해
    if("0".equals(GUBN) == true){  //등록시 발생일자(포맷 : yyyy-MM-dd)에 당일 데이터 셋팅하기 위해
    	isptDtb = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
    	ACTN_DTB = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
    } else {
    	isptDtb = jspeed.base.util.DateHelper.format(isptDt, "yyyyMMdd", "yyyy-MM-dd");
    	ACTN_DTB = jspeed.base.util.DateHelper.format(ACTN_DT, "yyyyMMdd", "yyyy-MM-dd");
    }
    }catch(ParseException e){
    	Log.logAML(Log.ERROR, e);
    }

    request.setAttribute("ISPT_DT"   ,isptDt            );
    request.setAttribute("ISPT_DTB"  ,isptDtb           );
    request.setAttribute("ACTN_DT"   ,ACTN_DT           );
    request.setAttribute("ACTN_DTB"  ,ACTN_DTB          );
    request.setAttribute("SNO"       ,sNo      );
    request.setAttribute("GUBN"      ,GUBN     );
%>
<script>
    var GridObj1    = null;
   
    /** Initial function */
    $(document).ready( function() {
    	$('.popup-contents').css({overflow:"auto"});
    	
    	// 지점점검 관리내역 수정시 점검일자 수정불가
/*         if(form.GUBN.value == "0"){
        	$(ISPT_DT).dxDateBox("instance").option("disabled", false);
        }else{
        	$(ISPT_DT).dxDateBox("instance").option("disabled", true);            
        }
 */    	
        form.DEP_TITLE.value = "전체";
        
    	setupGrids();
    });

  
    // 그리드 초기화 함수 셋업
    function setupGrids() {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_08_05_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : '지점점검 내역관리 - 상세'
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
    /* do */
    
    //지점점검 관리 조회
    function doSearch(){
        
        GridObj1.refresh({
            actionParam: {
                "pageID"  : "RBA_50_08_05_02",
                "classID" : "RBA_50_08_05_02",
                "methodID": "getBrnoIsptInfo",
                "isptDt"  : "${ISPT_DT}",
                "sNo"     : "${SNO}"
            },
            completedEvent: doSearch_end
        });
    }
    
    //지점점검 관리 조회 end
    function doSearch_end(){
    	var selObj = GridObj1.getRow(0);
        setData(selObj);
    }

    //지점점검 관리 HTML에 데이타 삽입
    function setData(selObj){
    	var drdt; drdt = "";
    	
    	form.SNO.value             = (selObj.SNO              == undefined)?"":selObj.SNO;
        form.BRNO_G_C.value        = (selObj.BRNO_G_C         == undefined)?"":selObj.BRNO_G_C;
        form.SEARCH_DEP_ID.value   = (selObj.BRNO             == undefined)?"":selObj.BRNO;
        form.DEP_TITLE.value       = (selObj.BRNM             == undefined)?"":selObj.BRNM;
        form.IMPRV_G_C.value       = (selObj.IMPRV_G_C        == undefined)?"":selObj.IMPRV_G_C;
        form.INDI_CNT.value        = (selObj.INDI_CNT         == undefined)?"":selObj.INDI_CNT;
        form.IMPRV_RSK_GD_C.value  = (selObj.IMPRV_RSK_GD_C   == undefined)?"":selObj.IMPRV_RSK_GD_C;
        form.MAIN_ISPT_CTNT.value  = (selObj.MAIN_ISPT_CTNT   == undefined)?"":selObj.MAIN_ISPT_CTNT;
        form.MAIN_INDI_ITM.value   = (selObj.MAIN_INDI_ITM    == undefined)?"":selObj.MAIN_INDI_ITM;
        form.ACTN_DTL.value        = (selObj.ACTN_DTL         == undefined)?"":selObj.ACTN_DTL;
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
        
        if ( getDxDateVal("ISPT_DT",true) == "" || getDxDateVal("ISPT_DT",true) == null ) {
        	alert("${msgel.getMsg('RBA_50_08_05_02_011','점검일자는 필수 입력항목입니다.')}");
        	return;
        }

        if ( frm.SEARCH_DEP_ID.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_05_02_012','지점명은 필수 입력항목입니다.')}");
        	return;
        }
        
        if ( frm.INDI_CNT.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_05_02_013','지적건수는 필수 입력항목입니다.')}");
        	return;
        }
        
        isNumChk = chkNum( frm.INDI_CNT.value );
        if ( isNumChk == "F") {
        	alert("${msgel.getMsg('RBA_50_08_05_02_014','지적건수항목에는 숫자를 입력해야 합니다.')}");
        	return;
        }

        if(!confirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}")) return;
		
		GridObj1.save({
            actionParam     : {
                "pageID"           : "RBA_50_08_05_02",
                "classID"          : "RBA_50_08_05_02",
                "methodID"         : "doSave",
                "ISPT_DT"          : getDxDateVal("ISPT_DT", true),    //점검일자
                "BRNO_G_C"         : frm.BRNO_G_C.value,
                "BRNO"             : frm.SEARCH_DEP_ID.value,
                "IMPRV_G_C"        : frm.IMPRV_G_C.value,
                "INDI_CNT"         : frm.INDI_CNT.value,
                "IMPRV_RSK_GD_C"   : frm.IMPRV_RSK_GD_C.value,
                "MAIN_ISPT_CTNT"   : frm.MAIN_ISPT_CTNT.value,
                "MAIN_INDI_ITM"    : frm.MAIN_INDI_ITM.value,
                "ACTN_DTL"         : frm.ACTN_DTL.value,
                "ACTN_DT"          : getDxDateVal("ACTN_DT", true)
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
        var frm = document.form;

        if ( frm.SEARCH_DEP_ID.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_05_02_012','지점명은 필수 입력항목입니다.')}");
        	return;
        }
        
        if ( frm.INDI_CNT.value == "") {
        	alert("${msgel.getMsg('RBA_50_08_05_02_013','지적건수는 필수 입력항목입니다.')}");
        	return;
        }
        
        isNumChk = chkNum( frm.INDI_CNT.value );
        if ( isNumChk == "F") {
        	alert("${msgel.getMsg('RBA_50_08_05_02_014','지적건수항목에는 숫자를 입력해야 합니다.')}");
        	return;
        }

        if(!confirm("${msgel.getMsg('RBA_50_08_03_02_015','저장하시겠습니까?')}")) return;
		
		var obj = new Object();
        obj.pageID          = "RBA_50_08_05_02";
        obj.classID         = "RBA_50_08_05_02";
        obj.methodID        = "doUpdate";
        //obj.ISPT_DT         = getDxDateVal("ISPT_DT", true);
        obj.SNO             = frm.SNO.value;        
        obj.BRNO_G_C        = frm.BRNO_G_C.value;    
        obj.BRNO            = frm.SEARCH_DEP_ID.value;           
        obj.IMPRV_G_C       = frm.IMPRV_G_C.value;    
        obj.INDI_CNT        = frm.INDI_CNT.value;
        obj.IMPRV_RSK_GD_C  = frm.IMPRV_RSK_GD_C.value;
        obj.ACTN_DT         = getDxDateVal("ACTN_DT", true);
        obj.MAIN_ISPT_CTNT  = frm.MAIN_ISPT_CTNT.value;
        obj.MAIN_INDI_ITM   = frm.MAIN_INDI_ITM.value;
        obj.ACTN_DTL        = frm.ACTN_DTL.value;
        
        obj.ISPT_DT_NEW = getDxDateVal("ISPT_DT", true);
        obj.ISPT_DT_ORG = "${ISPT_DT}";
        
        
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
        var frm; frm = document.form;

		if(!confirm("${msgel.getMsg('RBA_50_08_03_02_014','삭제하시겠습니까?')}")) return;

		var obj = new Object();
        obj.pageID          = "RBA_50_08_05_02";
        obj.classID         = "RBA_50_08_05_02";
        obj.methodID        = "doDelete";
        obj.ISPT_DT        = getDxDateVal("ISPT_DT", true); // 점검일자
        obj.SNO             = form.SNO.value;        // 상세구분
        
        new GTActionRun().run({
            actionParam     : obj
           ,completedEvent  : function(actionParam, jsonResultData){
        	   doUpdate_end(actionParam, jsonResultData);
            }
        });

    }    
    
    
    function doRBASelectInputPopup50(pageId, width, height, searchName, afterFunction){
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
    	form.action = "/0001.do?searchName="+searchName+"&afterFunction="+afterFunction+"&amlActiveView=D";
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
    
    
</script>

<form name="form" id="form" method="post">
    <input type="hidden" name="pageID"          id="pageID"     value="RBA_50_08_05_02"    />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="GUBN"            id="GUBN"    value="${GUBN}"   />
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_01_001','점검일자')}*</th>
            <td>${condel.getInputDateDx('ISPT_DT', ISPT_DTB)}</td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_02_001','순번')}*</th>
            <td><input name="SNO" id="SNO" type="text" value="${SNO}" size="5" readonly></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_01_002','지점구분')}*</th>
            <td>
                <RBATag:selectBoxJipyo name="BRNO_G_C" cssClass="cond-select" groupCode="C0013"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:100px;"/>
            </td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_02_002','지점명')}*</th>
            <td>
            	<RBATag:searchRbaInput searchName="SEARCH_DEP_ID" searchClass="cond-select" searchStyle="width: 60px;" text1Name="DEP_ID" 
					text1Hidden="true" text1Class="cond-select" text2Name="DEP_TITLE"  text2Class="cond-select" sessionAML="<%=sessionAML%>" 
					searchFunction='doRBASearchInput(this, "com.gtone.rba.common.action.GetRBADepInfoByCd", "setDepName2")' 
					popupFunction='doRBASelectInputPopup50("searchRbaDepPopup", 480, 580, "SEARCH_DEP_ID", "setRBASearchInputPopup(searchName, searchInfo)")' 
					searchValue="" text1Value="" text2Value=""/>
            </td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_01_003','개선구분')}*</th>
            <td>
                <RBATag:selectBoxJipyo name="IMPRV_G_C" cssClass="cond-select" groupCode="C0048"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:100px;"/>
            </td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_02_003','지적건수')}*</th>
            <td><input name="INDI_CNT" id="INDI_CNT" type="text" value="" size="5" maxlength="3"></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_02_005','주요점검내용')}</th>
            <td colspan="4"><textarea name="MAIN_ISPT_CTNT" style="width:100%;" rows=3 maxlength="500"></textarea></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_02_004','주요지적사항')}</th>
            <td colspan="4"><textarea name="MAIN_INDI_ITM" style="width:100%;" rows=3 maxlength="500"></textarea></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_02_006','조치내역')}</th>
            <td colspan="4"><textarea name="ACTN_DTL" style="width:100%;" rows=3 maxlength="500"></textarea></td>
        </tr>
        <tr>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_02_007','완료(예정)일')}*</th>
            <td>${condel.getInputDateDx('ACTN_DT', ACTN_DTB)}</td>
            <th style="text-align:left;">${msgel.getMsg('RBA_50_08_05_02_008','위험등급')}*</th>
            <td>
                <RBATag:selectBoxJipyo name="IMPRV_RSK_GD_C" cssClass="cond-select" groupCode="C0014"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:100px;"/>
            </td>
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
            <td><font color=blue> - 02O2050101 (2.5.1) 평가일 기준 최근1년간 지점수(해외지점 및 해외자회사 포함)대비 AML 운영실태 점검을 수행한 지점 비율</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O2050101, 02O2050201 (2.5.2) 평가일 기준 최근1년간 AML 관련 지점(해외지점 및 해외자회사 포함) 운영실태 지적사항에 대한 개선 비율</font></td>
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