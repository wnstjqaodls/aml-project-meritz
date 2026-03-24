<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_08_01_02.jsp
* Description     : 외부징계내역관리 상세
* Group           : GTONE, R&D센터/개발2본부
* Author          : HHJ
* Since           : 2018-04-20
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    String rprmDt   = Util.nvl(request.getParameter("rprmDt"));
    String rprmDtb   = "";  // 화면에 표시하기 위한 값
    String sNo       = Util.nvl(request.getParameter("sNo"    ));
    String RPRM_G_C  = Util.nvl(request.getParameter("RPRM_G_C"    ));
    String GUBN       = Util.nvl(request.getParameter("P_GUBN"    ));
    
    //if(GUBN.equals("0")){  //등록시 발생일자에 당일 데이터 셋팅
    if("0".equals(GUBN) == true){  //등록시 발생일자에 당일 데이터 셋팅
    	try {
			rprmDtb = jspeed.base.util.DateHelper.format(DateUtil.getDate().substring(0,8), "yyyyMMdd", "yyyy-MM-dd");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    } else {
    	try {
			rprmDtb = jspeed.base.util.DateHelper.format(rprmDt, "yyyyMMdd", "yyyy-MM-dd");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    request.setAttribute("RPRM_DT"  ,rprmDt            );
    request.setAttribute("RPRM_DTB" ,rprmDtb            );
    request.setAttribute("SNO"      ,sNo      );
    request.setAttribute("RPRM_G_C"      ,RPRM_G_C      );
    request.setAttribute("GUBN"     ,GUBN    );
%>
<script>
    var GridObj1    = null;
    var GridObj2    = null;
   
    /** Initial function */
    $(document).ready( function() {
    	$('.popup-contents').css({overflow:"auto"});
        
/*         if("${GUBN}" != "0"){
        	$(RPRM_DT).dxDateBox("instance").option("disabled", true);
        }else{
        	$(RPRM_DT).dxDateBox("instance").option("disabled", false);            
        } */
        
    	setupGrids();
    });
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_08_01_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : '외부징계내역관리 상세'
           ,completedEvent  : function(){
               setupGridFilter([GridObj1]);
               if("${GUBN}" != "0"){ //구분이 0이면 등록 아니면 수정
                   doSearch();
               }
            }
        });
    }
    
    /*====== 20180508 징계구분 SelectBox onChange Start ==================*/
    function rprmSelectChange(nextSelId, GrpObj, v_afterFun) {
    	nextSelectChangeRPRM(nextSelId, GrpObj, v_afterFun);
	}
    
    function nextSelectChangeRPRM(nextSelectId, thisObj, afterFunction, gubun){
        var param = new Object();
        var nextGrpCd;
        
        if ( thisObj.value == '1' ) {
        	nextGrpCd = "C0001";
        } else if ( thisObj.value == '2' ) {
        	nextGrpCd = "C0002";
        } else {
        	nextGrpCd = "";
        }
        
        param.afterFunction = afterFunction;
        param.NEXT_SELECT_ID=nextSelectId;
        param.GRP_CD = nextGrpCd;
        param.gubun = gubun;
        
        goAjaxWidthReturn_RPRM("com.gtone.rba.common.action.SelectSRBACodeAction6", param, "onAfterNextSelectChange_RPRM");

    }


    function goAjaxWidthReturn_RPRM( actionName, paramdata, callbackfunc)
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


    //ajax사용해 select의 option값을 조회 후 option셋팅 :초기값 전체
    function onAfterNextSelectChange_RPRM(jsonObj, paramdata){
    	var cnt = jsonObj.RESULT.length;
    	jQuery("#"+paramdata.NEXT_SELECT_ID).html("");
    	jQuery("#"+paramdata.NEXT_SELECT_ID).attr("groupCode", paramdata.GRP_CD);
    	var html = "";
    	for(var i=0; i<cnt; i++){
    		html += "<option value='" + jsonObj.RESULT[i].CD + "' >" + jsonObj.RESULT[i].CD_NM + "</option>";
    	}
    	jQuery("#"+paramdata.NEXT_SELECT_ID).html(html);
    	if(paramdata.afterFunction!=null && ""!=paramdata.afterFunction){
    		var res; res = ( new Function( 'return ' + paramdata.afterFunction ) )();
    	}
    }
  	/*====== 20180508 징계구분 SelectBox onChange End==================*/


    //외부징계내역관리 조회
    function doSearch(){
        
        GridObj1.refresh({
            actionParam: {
                "pageID"    : "RBA_50_08_01_02",
                "classID"   : "RBA_50_08_01_02",
                "methodID"  : "doSearch",
                "rprmDt"    : "${RPRM_DT}",
                "sNo"       : "${SNO}"
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
    	form1.SNO.value              = (selObj.SNO              == undefined)?"":selObj.SNO;
        form1.RPRM_G_C.value         = (selObj.RPRM_G_C         == undefined)?"":selObj.RPRM_G_C;
        form1.RPRM_ACTN_G_C.value    = (selObj.RPRM_ACTN_G_C    == undefined)?"":selObj.RPRM_ACTN_G_C;
        form1.RPRM_RSN.value         = (selObj.RPRM_RSN         == undefined)?"":selObj.RPRM_RSN;
        form1.RPRM_TGT.value         = (selObj.RPRM_TGT         == undefined)?"":selObj.RPRM_TGT;
        form1.LEV.value              = (selObj.LEV              == undefined)?"":selObj.LEV;
        
        form1.loginId.value          = (selObj.LOGIN_ID         == undefined)?"":selObj.LOGIN_ID;
        form1.DEP_DESC.value         = (selObj.DEP_ID           == undefined)?"":selObj.DEP_ID;
        form1.DEP_ID_NM.value        = (selObj.DEP_TITLE        == undefined)?"":selObj.DEP_TITLE;
        
        
        
        

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
        var frm; frm = document.form1;
        var RPRM_TGT_LENGTH; RPRM_TGT_LENGTH = unescape(encodeURI(form1.RPRM_TGT.value)).length;
        var RPRM_RSN_LENGTH; RPRM_RSN_LENGTH = unescape(encodeURI(form1.RPRM_RSN.value)).length;
        var LEV_LENGTH; LEV_LENGTH = unescape(encodeURI(form1.LEV.value)).length;
        
        if(frm.RPRM_TGT.value == "" && frm.RPRM_G_C.value == "1" ) {
        	alert("${msgel.getMsg('RBA_50_08_01_02_006','징계구분이 임직원외부징계일 경우 징계대상은 필수 입력항목입니다.')}");
            return;
        }
        if(RPRM_RSN_LENGTH > 500){
            alert("${msgel.getMsg('RBA_50_08_01_02_007','입력할 수 있는 징계사유 최대 자리수는 500byte(한글기준 약166자) 입니다.')}")
            return;
        }
        if(frm.RPRM_RSN.value == "" ) {
        	alert("${msgel.getMsg('RBA_50_08_01_02_008','징계사유는 필수 입력항목입니다.')}");
            return;
        }
        //$("button[id='btn_01']").prop('disabled', true);
        if(!confirm('<fmt:message key="RBA_50_08_03_02_015" initVal="저장하시겠습니까?"/>')) return;
        
		GridObj1.save({
            actionParam     : {
                "pageID"           : "RBA_50_08_01_02",
                "classID"          : "RBA_50_08_01_02",
                "methodID"         : "doSave",
                "RPRM_G_C"         : form1.RPRM_G_C.value,          
                "RPRM_ACTN_G_C"    : form1.RPRM_ACTN_G_C.value,      
                "RPRM_RSN"         : form1.RPRM_RSN.value,  
                "RPRM_TGT"         : form1.RPRM_TGT.value, 
                "LEV"              : form1.LEV.value,                 
                "RPRM_DT"          : getDxDateVal("RPRM_DT", true),
                "LOGIN_ID"         :  $("#loginId").val(),
                "DEP_ID"           :  $("#DEP_DESC").val(),
                "DEP_TITLE"        :  $("#DEP_ID_NM").val()
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
        var frm; frm = document.form1;
        var RPRM_TGT_LENGTH; RPRM_TGT_LENGTH = unescape(encodeURI(form1.RPRM_TGT.value)).length;
        var RPRM_RSN_LENGTH; RPRM_RSN_LENGTH = unescape(encodeURI(form1.RPRM_RSN.value)).length;
        var LEV_LENGTH; LEV_LENGTH = unescape(encodeURI(form1.LEV.value)).length;
        
        if(frm.RPRM_TGT.value == "" && frm.RPRM_G_C.value == "1" ) {
        	alert("${msgel.getMsg('RBA_50_08_01_02_006','징계구분이 임직원외부징계일 경우 징계대상은 필수 입력항목입니다.')}");
            return;
        }
        if(RPRM_RSN_LENGTH > 500){
        	alert("${msgel.getMsg('RBA_50_08_01_02_007','입력할 수 있는 징계사유 최대 자리수는 500byte(한글기준 약166자) 입니다.')}")
            return;
        }
        if(frm.RPRM_RSN.value == "" ) {
        	alert("${msgel.getMsg('RBA_50_08_01_02_008','징계사유는 필수 입력항목입니다.')}");
            return;
        }
        
        if(!confirm('<fmt:message key="RBA_50_08_03_02_015" initVal="저장하시겠습니까?"/>')) return;

		var obj = new Object();
        obj.pageID          = "RBA_50_08_01_02";
        obj.classID         = "RBA_50_08_01_02";
        obj.methodID        = "doUpdate";
        //obj.RPRM_DT         = getDxDateVal("RPRM_DT", true); // 발생일자
        obj.SNO             = form1.SNO.value;        // 상세구분
        obj.RPRM_G_C        = form1.RPRM_G_C.value;    // 임직원평가구분코드
        obj.RPRM_ACTN_G_C   = form1.RPRM_ACTN_G_C.value;           // 직원명
        obj.RPRM_RSN        = form1.RPRM_RSN.value;           // 직원명
        obj.RPRM_TGT        = form1.RPRM_TGT.value;           // 직원명
        obj.LEV             = form1.LEV.value;        // 상세구분
        
        
        
        obj.LOGIN_ID = $("#loginId").val();  //사번
        obj.DEP_ID =  $("#DEP_DESC").val();  //부서코드
        obj.DEP_TITLE =  $("#DEP_ID_NM").val(); //부서명
        
        obj.RPRM_DT_ORG =  "${RPRM_DT}";
        obj.RPRM_DT_NEW =  getDxDateVal("RPRM_DT", true);
        
        
        
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
        obj.pageID          = "RBA_50_08_01_02";
        obj.classID         = "RBA_50_08_01_02";
        obj.methodID        = "doDelete";
        obj.RPRM_DT         = getDxDateVal("RPRM_DT", true); // 발생일자
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
            var submit; submit = form.submit;
            for (var i=0; i<form.elements.length; i++) if (form.elements[i].name!="length" && form.elements[i].name!="item" && form.elements[i].name!="namedItem") url += (i==0&&form.action.indexOf("?")<0?"?":"&")+form.elements[i].name+"="+((/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(form.elements[i].value))?encodeURIComponent(form.elements[i].value):form.elements[i].value);
            (win = window.open(url,form.elements["pageID"]?form.elements["pageID"].value:"","left="+getCenter_X(w)+", top="+getCenter_Y(h)+",scrollbars="+(scrollbars?scrollbars:"no")+",resizable="+(resizable?resizable:"yes")+",width="+w+", height="+h+", toolbar=no, menubar=no, status=no ")).focus();
            form.submit = submit;
        }
    	form.submit();
    }
    
    function setRBASearchInputPopup_MZ(searchName, searchInfo){
    	
	   	$("#loginId").val(searchInfo.loginId);
	   	$("#RPRM_TGT").val(searchInfo.userName);
	   	$("#DEP_ID_NM").val(searchInfo.DEP_ID_NM);
	   	$("#LEV").val(searchInfo.POSITION_NM);
	   	$("#DEP_DESC").val(searchInfo.DEP_DESC);
    	
    }
</script>
<form name="form" id="form" method="post">
	<input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="GUBN"            id="GUBN"       />
</form>
<form name="form1" id="form1" method="post">
    <input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="GUBN"            id="GUBN"       />
    <input type="hidden" name="DEP_DESC"            id="DEP_DESC"       />
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
        <tr>
            <th>${msgel.getMsg('RBA_50_08_01_02_005','징계일자')}*</th>
            <td>${condel.getInputDateDx('RPRM_DT', RPRM_DTB)}</td>
            <th>${msgel.getMsg('RBA_50_08_01_02_001','순번')}*</th>
            <td><input name="SNO" id="SNO" type="text" value="" size="5" style="text-align:center;" readonly></td>
        </tr>
        <tr>
            <th>${msgel.getMsg('RBA_50_08_01_01_002','징계구분')}*</th>
            <td>
                ${SRBACondEL.getSRBASelect('RPRM_G_C','100%' ,'' ,'R351' ,'' ,'' ,'rprmSelectChange("RPRM_ACTN_G_C", this)','','','')}
            </td>
            <th>${msgel.getMsg('RBA_50_08_01_01_003','징계조치구분')}*</th>
            <td>
            //<% if ( RPRM_G_C.equals("2")) { %>
            <% if ( "2".equals(RPRM_G_C) == true) { %>
                <RBATag:selectBoxJipyo name="RPRM_ACTN_G_C" cssClass="cond-select" groupCode="C0002"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:100px;"/>
            <% } else { %>
                <RBATag:selectBoxJipyo name="RPRM_ACTN_G_C" cssClass="cond-select" groupCode="C0001"
                mapGroupCode="" firstComboWord="" rptGjdt="MAX" eventFunction="" selectStyle="width:100px;"/>
            <% } %>
            </td>
        </tr>
        <tr>
            <th>${msgel.getMsg('RBA_50_08_01_02_002','징계대상')}(직원명)</th>
            <td><input name="RPRM_TGT" id="RPRM_TGT" type="text" value="" size="20" maxlength="100">
            	<!-- <span class="cond-branch-btn" onclick='javascript:doRBASelectInputPopup("searchRbaDepPopup", 400, 500, "VALT_BRNO", "setRBASearchInputPopup(searchName, searchInfo)") '> -->
            	<span class="cond-branch-btn" onclick='javascript:doRBASelectInputPopup_MZ("searchRbaUserPopup", 400, 500, "MNGR_JKW_NO", "setRBASearchInputPopup_MZ(searchName, searchInfo)") '>
            		<i class="fa fa-search" aria-hidden="true"></i>
            	</span>
            </td>
            <th>사번</th>
            <td><input name="loginId" id="loginId" type="text" value="" size="35" maxlength="20"></td>
        </tr>
        <tr>
            <th>부서명</th>
            <td>
            	<input name="DEP_ID_NM" id="DEP_ID_NM" type="text" value="" size="35" maxlength="20">
            </td>
            <th>${msgel.getMsg('RBA_50_08_01_02_003','직급')}</th>
            <td><input name="LEV" id="LEV" type="text" value="" size="35" maxlength="20"></td>
        </tr>        
        <tr>
            <th>${msgel.getMsg('RBA_50_08_01_02_004','징계사유')}*</th>
            <td colspan="4"><textarea name="RPRM_RSN" style="width:100%;" rows=6 maxlength="500"></textarea></td>
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
        <tr>
            <td><font color=blue>※ 징계구분값이 임직원외부징계일 경우 징계대상에 대상직원명을 필히 입력하셔야 합니다.</font><br><br></td>
        </tr>
        <!-- 유안타증권 - BSL START -->
        <tr>
            <td><font color=blue>※ 관련 KoFIU 보고항목(지표)</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O1010101 (1.1.0) 평가일 기준 최근1년간 자금세탁방지 관련 임직원 외부 징계내역</font></td>
        </tr>
        <tr>
            <td><font color=blue> - 02O1020101 (1.2.0) 평가일 기준 최근1년간 자금세탁방지 관련 금융회사 징계실적</font></td>
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