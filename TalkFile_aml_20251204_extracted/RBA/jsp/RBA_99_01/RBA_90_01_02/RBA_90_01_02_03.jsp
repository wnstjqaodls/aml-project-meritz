<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_02_03.jsp
- Author     : 권얼
- Comment    : FIU 지표등록관리/등록팝업
- Version    : 1.0
- history    : 1.0 20181121
--%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true"/>

<%
	 
	String RPT_GJDT           = Util.nvl(request.getParameter("RPT_GJDT")			, "");
	String JIPYO_IDX		  = Util.nvl(request.getParameter("JIPYO_IDX") 			, "");
	String JIPYO_FIX_YN 	  = Util.nvl(request.getParameter("JIPYO_FIX_YN") 		, "");
	String IN_V_TP_C 	  	  = Util.nvl(request.getParameter("IN_V_TP_C") 			, "");
	String CNCT_JIPYO_C_I 	  = Util.nvl(request.getParameter("CNCT_JIPYO_C_I") 	, "");
	String JIPYO_VIEW 	  = Util.nvl(request.getParameter("JIPYO_VIEW") 		, "N");		//지표상세팝업만 보여주기 위함
	
	request.setAttribute("RPT_GJDT", RPT_GJDT);
	request.setAttribute("JIPYO_IDX",JIPYO_IDX);
	request.setAttribute("JIPYO_FIX_YN", JIPYO_FIX_YN); //JIPYO_FIX_YN 1 확정 0 미확정
	request.setAttribute("IN_V_TP_C",IN_V_TP_C);		//입력값 타입
	request.setAttribute("CNCT_JIPYO_C_I",CNCT_JIPYO_C_I);
	request.setAttribute("JIPYO_VIEW",JIPYO_VIEW);
	
%>

<script language="JavaScript">
	/** 
	 * Initial function 
	 */ 
// 	var GridObj1 	= new GTActionRun();
	var classID 	= "RBA_90_01_02_02";
    var _sno        = 0;
    
    $(document).ready(function() {
        doSearch();
        
        $("#EVAL_DATE_HEARDER").click(function() {
            if ($("#EVAL_DATE_HEARDER")[0].checked == true) {
                $("input[name=EVAL_DATE_SEL]:checkbox").each(function() {
                    this.checked = true;
                });
            }
            if ($("#EVAL_DATE_HEARDER")[0].checked == false) {
                $("input[name=EVAL_DATE_SEL]:checkbox").each(function() {
                    this.checked = false;
                });
            }
        });
        
        isAllChecked("init");
    });

	/**
	 *  보고지표관리 상세내역 조회
	 */
 	function doSearch() {
 		
		var methodID   	  = "doSearch";
		var obj			  = new Object();
		obj.pageID		  = pageID;
	    obj.classID 	  = classID;	    
		obj.RPT_GJDT	  = "${RPT_GJDT}";
		obj.CHECK_JIPYO_IDX = "${JIPYO_IDX}";
		obj.JIPYO_FIX_YN  = "${JIPYO_FIX_YN}";

		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
 	}
		
	
 	 function doSearch_end(data) {
 		if(data.length>0) {
 			var selObj = data[0];
 			setData(selObj);
 		}
     }
 
	/**
	 *  보고지표관리 상세내역 값 세팅
	 */
 	function setData(selObj){
		
 		$("#RPT_GJDT").val(selObj.RPT_GJDT);					//보고기준일자_HIDDEN
 		$("#JIPYO_C").val(selObj.JIPYO_C);					//위험구분_HIDDEN
 		$("#RSK_CATG").val(selObj.RSK_CATG);					//카테고리_HIDDEN
 		$("#RSK_FAC").val(selObj.RSK_FAC);					//항목_HIDDEN
 		$("#JIPYO_IDX_VIEW").val(selObj.JIPYO_IDX);			//지표번호
 		$("#VIEW_RPT_GJDT").val(selObj.VIEW_RPT_GJDT);		//보고기준일자
 		$("#JIPYO_C_NM").val(selObj.JIPYO_C_NM);				//위험구분
		$("#RSK_CATG_NM").val(selObj.RSK_CATG_NM);			//카테고리
 		$("#RSK_FAC_NM").val(selObj.RSK_FAC_NM);				//항목
 		$("#JIPYO_NM").val(selObj.JIPYO_NM);					//지표명
		$("#CAL_METH").val(selObj.CAL_METH);					//산출방법
		$("#FRMG_MABD_C").val(selObj.FRMG_MABD_C);			//작성주체
		$("#FRMG_MABD_C_NM").val(selObj.FRMG_MABD_C_NM);		//작성주체
		$("#ALLT_PNT").val(selObj.ALLT_PNT);					//배점
		$("#VALT_G").val(selObj.VALT_G);						//평가구분
		$("#VALT_G_NM").val(selObj.VALT_G_NM);				//평가구분
		$("#IN_V_TP_C").val(selObj.IN_V_TP_C);				//입력값타입
		$("#IN_V_TP_C_NM").val(selObj.IN_V_TP_C_NM);			//입력값타입
		$("#WEGHT").val(selObj.WEGHT);						//가중치
		$("#CNCT_JIPYO_C_I").val(selObj.CNCT_JIPYO_C_I);		//연결코드방법
		$("#INP_UNIT_C").val(selObj.INP_UNIT_C);				//입력단위
		$("#INP_UNIT_C_NM").val(selObj.INP_UNIT_C_NM);		//입력단위
		$("#BAS_V").val(selObj.BAS_V);						//기본값
		$("#IN_METH_C").val(selObj.IN_METH_C);				//입력방식
		$("#IN_METH_C_NM").val(selObj.IN_METH_C_NM);			//입력방식
		$("#JIPYO_USYN").val(selObj.JIPYO_USYN);				//사용여부
		$("#JIPYO_USYN_NM").val(selObj.JIPYO_USYN_NM);		//사용여부
		$("#CAL_FRML").val(selObj.CAL_FRML);					//산출식
		$("#INP_ITEM").val(selObj.INP_ITEM);					//입력항목
		
		//$("EST_BAS_SCOP").value = selObj.EST_BAS_SCOP;		//산정기준/범위
		//$("JIPYO_BIGO_CTNT").value = selObj.JIPYO_BIGO_CTNT;	//지표설명
		//$("ANEX_CTNT").value = selObj.ANEX_CTNT;				//부가설명
		//$("JIPYO_DESC").value = selObj.JIPYO_DESC;			//지표내용
		
		
 	}
	

	/**
	 *  보고지표관리 상세내역 저장
	 */	
	function doSave() {
		
		if ("${JIPYO_FIX_YN}"=="1") {
			showAlert('${msgel.getMsg("RBA_90_01_02_03_205","확정된 기준일자의 지표는 저장 할 수 없습니다.")}','WARN');
			return;
		}
		
		if(!CheckValue()){
			 return;
		}
			
		/* var arr = new Array(); 
		var CAL_PNTS = new Array();
		var JIPYO_CMPR_CAL_CS = new Array();
		var CMPR_VS = new Array();
		var obj = new Object();
		
		jQuery("input[id=EVAL_DATE_SEL]").each(function(){
			var Val1 = jQuery(this).parent().next().children("[name=CAL_PNT]").val();
			var Val2 = jQuery(this).parent().next().next().children("[name=JIPYO_CMPR_CAL_C]").val();
			var Val3 = jQuery(this).parent().next().next().next().children("[name=CMPR_V]").val();
			
			obj.CAL_PNT = Val1;
			obj.JIPYO_CMPR_CAL_C = Val2;
			obj.CMPR_VS = Val3;
			arr.push(obj);
   		});
		 */
		 showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>', '${msgel.getMsg("AML_00_00_01_01_025","저장")}', doSave_Action);
    }
	
    function doSave_Action(){
        var form1 				= document.form1;
        form1.pageID.value 		= "RBA_90_01_02_03";
        form1.classID.value 	= "RBA_90_01_02_03";
        form1.methodID.value 	= "doSave";
        form1.trCnt.value 		= $("#EvalInputTable tr").length-1;
        form1.target 			= "submitFrame";
        form1.action 			= "<c:url value='/'/>0001.do";
        
        var option = {
            type: "POST",
            success: function() {
                showAlert('${msgel.getMsg("RBA_90_01_02_03_201", "정상 처리 되었습니다.")}', "INFO");
                doSearch();
                opener.doSearch();
            },
            error: function(xhr, textStatus) {showAlert(textStatus,'ERR');}
        };
        $('#form1').ajaxSubmit(option);
    }
    
	function CheckValue(){
		
		var rst = true;
		
 		var allCalPnts	 = $("#EvalInputTable").find("[name=CAL_PNT]"); // 모든 CAL_PNT 입력 요소 선택
 		var allCmPrv	 = $("#EvalInputTable").find("[name=CMPR_V]"); // 모든 CAL_PNT 입력 요소 선택
 		var allJipyoCalC = $("#EvalInputTable").find("[name=JIPYO_CMPR_CAL_C ]"); // 모든 CAL_PNT 입력 요소 선택

 		for(var i = 0; i < allCalPnts.length; i++) {
 			var calPnts = allCalPnts.eq(i).val();
 			
			  for(var j = i+1; j < allCalPnts.length; j++) {
			    if(calPnts == allCalPnts.eq(j).val()) {
			  	  allCalPnts.eq(j).focus();
			   	  showAlert('${msgel.getMsg("RBA_90_01_02_03_202","중복된 점수가 있습니다. 다시 확인하여 주시기 바랍니다.")}', "WARN");
			      rst = false;
			      break;
			    }
			  }
			  
			  if ( calPnts == null || calPnts.trim() == '' ){
				  showAlert('${msgel.getMsg("RBA_90_01_02_03_203","점수를 입력하여 주시기 바랍니다.")}', "WARN");
				  allCalPnts.eq(i).focus();
				  rst = false;
			      break;
			  }
			  
			  if ( isNaN(parseFloat( calPnts ) ) ) {
					showAlert("점수는 0~100까지의 숫자만 입력 가능합니다.", "WARN");
					allCalPnts.eq(i).focus();
					rst = false;
				    break;
			  }
				
			  if ( parseFloat( calPnts ) < 0 || parseFloat( calPnts ) > 100) {
					showAlert("점수는 0~100까지의 숫자만 입력 가능합니다.", "WARN");
					allCalPnts.eq(i).focus();
					rst = false;
				    break;
				}
			  
 		  if(!rst)  {
 		    break;
 		  }
 		  
 		}
 		for(var i = 0; i < allCmPrv.length; i++) {
 			var range = allCmPrv.eq(i).val() + allJipyoCalC.eq(i).val();
			  for(var j = i+1; j < allCmPrv.length; j++) {
			    if(range === allCmPrv.eq(j).val() + allJipyoCalC.eq(j).val()) {
			    	allCmPrv.eq(j).focus();
			   	  	showAlert('${msgel.getMsg("RBA_90_01_02_03_204","중복된 산식코드 및 비교값이 있습니다. 다시 확인하여 주시기 바랍니다.")}', "WARN");
			      	rst = false;
			      	break;
			    }
			  }
 		  if(!rst)  {
 		    break;
 		  }
 		}
		return rst;
	}
	
  function onlyNumber(obj){
    var val = obj.value;
    var len = val.length;
    var rt_val = "";

    for(var i = 0; i < len ; i++){
      var chr = val.charAt(i);
      var ch = chr.charCodeAt();
      
      if ((ch < 48 || ch > 57) && (ch != 46)){
        rt_val = rt_val;
      }else{
        rt_val = rt_val + chr;
      }
    }
    obj.value = rt_val;
    obj.focus();
    
  }
  
  
	 // 행 추가.
	function addRow(){
		
		if($("#EvalInputTable tr").length == 1){
			
			try {
				
		        $.ajax({
		            url         : "/JSONServlet?Action@@@=com.gtone.aml.common.action.DispatcherAction"
		           ,type        : "POST"
		           ,dataType    : "json"
		           ,processData : true
		           ,data        : {
		               "pageID"     		: "RBA_90_01_02_03"
		              ,"classID"    		: "RBA_90_01_02_03"
		              ,"methodID"   		: "getSearchEvaluationCode"
		              ,"RPT_GJDT"			: "${RPT_GJDT}"
		              ,"JIPYO_IDX"			: "${JIPYO_IDX}"
		              ,"IN_V_TP_C"			: "${IN_V_TP_C}"
		              ,"CNCT_JIPYO_C_I"		: "${CNCT_JIPYO_C_I}"
		           }
		           ,success : function(jsondata) {
		               try {
		                   if (jsondata&&jsondata.GRID_DATA&&jsondata.GRID_DATA.length>0) {
		                	   if (jsondata.GRID_DATA[0]&&jsondata.GRID_DATA[0]["RESULT"]&&jsondata.GRID_DATA[0]["RESULT"].length>0) {
		                		   var res1; res1 = jsondata.GRID_DATA[0]["RESULT"];
		                		   $("#_tbody").append(jsondata.GRID_DATA[0]["RESULT"]);
		                		   isAllChecked("init");
		                	   }
		                   }
		               } catch (e) {showAlert(e.message,'ERR');}
		            }
		           ,error : function(xhr, textStatus) {showAlert(textStatus,'ERR');}
		        });
		    } catch (e) {showAlert(e.message,'ERR');}
		    
		}else{
			var obj; obj 				= new Object();
			var lastItemNo; lastItemNo = $("#EvalInputTable tr:last");
		    var newitem 		= lastItemNo.clone();
			newitem.find("td").find("input").val("");
			newitem.find("td").find("input")[0].checked = false;
			$("#EvalInputTable").append(newitem);
			
			var inputArr = $("input[name = EVAL_DATE_SEL]");
			var targetInput = inputArr[inputArr.length - 1];
			var targetId = targetInput.getAttribute("id");
			var labelArr = $("label[for = '" + targetId + "']");
			var targetLabel = labelArr[labelArr.length - 1];
			targetInput.setAttribute("id", _sno);
			targetLabel.setAttribute("for", _sno++);
			isAllChecked("add");
		}
		$("input:checkbox[id = 'EVAL_DATE_HEARDER']").prop("checked", false);
	}
	 
    // 선택된 행 삭제(DB에서 삭제되진 않는다.)
    function deleteRow() {
        var cnt = $("#EvalInputTable input[name='EVAL_DATE_SEL']").length;
        var selcnt = 0;
        
        if (cnt > 0) {
            for (var i = 0; i < cnt; i++) {
                if ($("#EvalInputTable input[name='EVAL_DATE_SEL']")[i].checked) {
                    selcnt += 1;
                }
            }
        }
        if (selcnt == 0) {
            showAlert('${msgel.getMsg("RBA_90_01_01_01_202", "삭제할 데이타를 선택하십시오.")}', "WARN");
            return;
        }
        $("input[name=EVAL_DATE_SEL]").each(function() {
            if ($(this).is(":checked")) {
                var EvalInputTable = document.getElementById('EvalInputTable');
                $(this).parent().parent().remove();
            }
        });
        $("input:checkbox[id = 'EVAL_DATE_HEARDER']").prop("checked", false);
    }
    
    function isAllChecked(flag) {
        if (flag == "init") {
            $("input[name = EVAL_DATE_SEL]:checkbox").on({
                click: function(e) {
                    var selectAllBox = document.querySelectorAll("input[name=EVAL_DATE_HEARDER]");
                    var allBoxes = document.querySelectorAll("input[name=EVAL_DATE_SEL]");
                    var checkedBoxes = document.querySelectorAll("input[name=EVAL_DATE_SEL]:checked");
                    
                    if (checkedBoxes.length == allBoxes.length) {
                        $("input:checkbox[id = 'EVAL_DATE_HEARDER']").prop("checked", true);
                    } else {
                        $("input:checkbox[id = 'EVAL_DATE_HEARDER']").prop("checked", false);
                    }
                }
            });
        } else if (flag == "add") {
            $("input[id = " + (_sno - 1) + "]:checkbox").on({
                click: function(e) {
                    var selectAllBox = document.querySelectorAll("input[name=EVAL_DATE_HEARDER]");
                    var allBoxes = document.querySelectorAll("input[name=EVAL_DATE_SEL]");
                    var checkedBoxes = document.querySelectorAll("input[name=EVAL_DATE_SEL]:checked");
                    
                    if (checkedBoxes.length == allBoxes.length) {
                        $("input:checkbox[id = 'EVAL_DATE_HEARDER']").prop("checked", true);
                    } else {
                        $("input:checkbox[id = 'EVAL_DATE_HEARDER']").prop("checked", false);
                    }
                }
            });
        }
    }
	 
</script> 

<form name="form1" id="form1" name="form1" method="post">
<input type="hidden" name="pageID" >
<input type="hidden" name="classID" >
<input type="hidden" name="methodID" >
<input type="hidden" id="RPT_GJDT" name="RPT_GJDT" value= "${RPT_GJDT}">
<input type="hidden" id="JIPYO_IDX" name="JIPYO_IDX" value= "${JIPYO_IDX}">
<input type="hidden" id="JIPYO_C" name="JIPYO_C">
<input type="hidden" id="RSK_CATG" name="RSK_CATG">
<input type="hidden" id="RSK_FAC" name="RSK_FAC">
<input type="hidden" id="JIPYO_FIX_YN" name="JIPYO_FIX_YN" value = "${JIPYO_FIX_YN}">
<input type="hidden" id="trCnt" name="trCnt">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr>
		<td valign="top">
			<iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
		</td>
	</tr>
</table>
<div class="panel panel-primary">
	<div class="panel-footer" >
		<div class="table-box">
			<table class="basic-table" >
				<colgroup>
				    <col width="90px">
				    <col width="">
				    <col width="">
				    <col width="90px">
				    <col width="">
				    <col width="">
				    <col width="90px">
				    <col width="">
				    <col width="">
				    <col width="">
				    <col width="">
			   </colgroup>
			   <tbody>
				<tr>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_002","지표번호")}</th>
					<td colspan=2>                        
	                   <input type="text" class="input_text" id="JIPYO_IDX_VIEW" name="JIPYO_IDX_VIEW" maxlength="200" readonly="readonly"/>
	                </td>			
	                <th class="title">${msgel.getMsg("RBA_90_01_01_02_003","지표명")}</th>
					<td colspan=6>
					 	<input type="text" class="input_text" id="JIPYO_NM" name="JIPYO_NM"  maxlength="200" readonly="readonly"/>
					</td>									
				</tr>																
				<tr>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_004","위험구분")}</th>
					<td colspan=2>
						<input type="text" class="input_text" id="JIPYO_C_NM" name="JIPYO_C_NM" maxlength="200" readonly="readonly"/>
					</td>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_005","카테고리")}</th>
					<td colspan=2>
					 	<input type="text" class="input_text" id="RSK_CATG_NM" name="RSK_CATG_NM" maxlength="200" readonly="readonly"/>
					</td>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_006","항목")}</th>
					<td colspan=3>
						<input type="text" class="input_text" id="RSK_FAC_NM" name="RSK_FAC_NM" maxlength="200" readonly="readonly"/>	
					</td>
				</tr>
				<tr>
					<th class="title" >${msgel.getMsg("RBA_90_01_01_02_014","입력항목")}</th>
					<td colspan=2>
					 	<input type="text" class="input_text" id=INP_ITEM name="INP_ITEM" readonly="readonly" />
					</td>
					<th class="title" >${msgel.getMsg("RBA_90_01_01_02_015","작성주체")}</th>
					<td colspan=2>
						<input type="text" class="input_text" id="FRMG_MABD_C_NM" name="FRMG_MABD_C_NM"  readonly="readonly" />
						<input type="hidden" id="FRMG_MABD_C" name="FRMG_MABD_C">
					</td>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_016","배점")}</th>
					<td colspan=2>
					 	<input type="text" class="input_text" id=ALLT_PNT name="ALLT_PNT" style="text-align: right;" readonly="readonly" />
					</td>																												
				</tr>
				<tr>
					<th class="title" >${msgel.getMsg("RBA_90_01_01_02_007","평가구분")}</th>
					<td colspan=2>
						<input type="text" class="input_text" id="VALT_G_NM" name="VALT_G_NM" readonly="readonly" />
						<input type="hidden" id="VALT_G" name="VALT_G">  
					</td>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_017","입력값타입")}</th>
					<td colspan=2>
					 	<input type="text" class="input_text" id="IN_V_TP_C_NM" name="IN_V_TP_C_NM" readonly="readonly" />
						<input type="hidden" id="IN_V_TP_C" name="IN_V_TP_C">
					</td>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_018","가중치")}</th>
					<td colspan=2>
					 	<input type="text" class="input_text" id=WEGHT name="WEGHT" style="text-align: right;" readonly="readonly" />
					</td>
				</tr>	
				<tr>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_019","연결코드정보")}</th>
					<td colspan=2>
					 	<input type="text" class="input_text" id=CNCT_JIPYO_C_I name="CNCT_JIPYO_C_I" readonly="readonly"/>
					</td>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_020","입력단위")}</th>
					<td colspan=2>
						<input type="text" class="input_text" id="INP_UNIT_C_NM" name="INP_UNIT_C_NM"  readonly="readonly" />
						<input type="hidden" id="INP_UNIT_C" name="INP_UNIT_C">	
					</td> 
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_021","기본값")}</th>
					<td colspan=2>
					 	<input type="text" class="input_text" id=BAS_V name="BAS_V" readonly="readonly"/>
					</td>																												
				</tr>
				<tr>	
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_024","입력방식")}</th>
					<td colspan=2>
						<input type="text" class="input_text" id="IN_METH_C_NM" name="IN_METH_C_NM"  readonly="readonly" />
						<input type="hidden" id="IN_METH_C" name="IN_METH_C">	
	   				</td>					
			    	<th class="title">${msgel.getMsg("RBA_90_01_01_02_008","사용여부")}</th>
					<td colspan=2>
						<input type="text" class="input_text" id="JIPYO_USYN_NM" name="JIPYO_USYN_NM"  readonly="readonly" />
						<input type="hidden" id="JIPYO_USYN" name="JIPYO_USYN">
	   				</td>	
			    	<th class="title">${msgel.getMsg("RBA_90_01_01_02_001","보고기준일자")}</th>
					<td> 
						<input type="text" class="input_text" id="VIEW_RPT_GJDT" name="VIEW_RPT_GJDT" maxlength="11" style="text-align: right; width:100%;" readonly="readonly" />	
	   				</td>	    	
			    </tr>				    
			    <tr>
			    	<th class="title">${msgel.getMsg("RBA_90_01_01_02_023","산출식")}</th>
			    	<td colspan=10>
			    		<input type="text" class="input_text" id="CAL_FRML" name="CAL_FRML" maxlength="250" style="width:100%;" readonly="readonly" />
			    	</td>				    
			    </tr>
				<tr>
					<th class="title">${msgel.getMsg("RBA_90_01_01_02_012","산출방법")}</th>
					<td colspan=10>
						<textarea type="textarea" name="CAL_METH" id="CAL_METH" class="textarea-box" rows="7" maxlength="2000" readonly="readonly" style="width:100%"></textarea>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
	</div>
		<div class="tab-content-top" style="text-align:right">
			<div class="button-area" style="margin-top: 5px; margin-bottom: 10px;">
				${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"addRowBtn", defaultValue:"행추가", mode:"R", function:"addRow", cssClass:"btn-36"}')}
 		 	${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteRowBtn", defaultValue:"행삭제", mode:"D", function:"deleteRow", cssClass:"btn-36"}')}
	     	</div>                                      
		</div>
	<div class="panel panel-primary">
	    <div class="panel-footer" style="width:100%;">
				<div style="height:200;overflow-y:scroll;">
					<jsp:include page="/0001.do?pageID=RBA_90_01_02_05" >
						<jsp:param name="RPT_GJDT"   		value='${RPT_GJDT}'/>
						<jsp:param name="JIPYO_IDX" 		value='${JIPYO_IDX}'/>
						<jsp:param name="IN_V_TP_C" 		value='${IN_V_TP_C}'/>
						<jsp:param name="CNCT_JIPYO_C_I" 	value='${CNCT_JIPYO_C_I}'/>
						<jsp:param name="classID"   		value='RBA_90_01_02_05'/>
						<jsp:param name="methodID"  		value='getSearchEvaluationCriteria'/>
					</jsp:include> 
				</div>
				<div style="font-family: SpoqB;font-size:0.8rem;color:blue;">
	    			※ ${msgel.getMsg("RBA_90_01_02_03_200","저장 시 체크박스와 관계없이 일괄 저장됩니다.")}
		   		</div>
			<!-- <tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="1%"></td>
							<td><font color=blue>※ 저장시 체크박스와 관계없이 일괄 저장됩니다.</font></td>                                
						</tr>
					</table>
				</td>
			</tr>  -->
  	    </div>
	</div>
	<div class="tab-content-top"> 	
		<div class="button-area" style="margin-top:5px;">
			${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 