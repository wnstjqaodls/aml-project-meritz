<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_04_01_02.jsp
- Author     : 권얼
- Comment    : 통제요소 등록 팝업
- Version    : 1.0
- history    : 1.0 20250707
--%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true"/>

<%
    String BAS_YYMM     = Util.nvl(request.getParameter("BAS_YYMM")			, "");
    String GYLJ_S_C_NM  = Util.nvl(request.getParameter("GYLJ_S_C_NM")			, "");
	/* String CNTL_CATG1_C = Util.nvl(request.getParameter("CNTL_CATG1_C")			, "");
	String CNTL_CATG2_C = Util.nvl(request.getParameter("CNTL_CATG2_C")			, "");
	String CNTL_ELMN_C = Util.nvl(request.getParameter("CNTL_ELMN_C")			, "");
	String CNTL_CATG1_C_NM = Util.nvl(request.getParameter("CNTL_CATG1_C_NM")			, "");
	String CNTL_CATG2_C_NM = Util.nvl(request.getParameter("CNTL_CATG2_C_NM")			, "");
	String CNTL_ELMN_C_NM = Util.nvl(request.getParameter("CNTL_ELMN_C_NM")			, "");
 	String USE_YN1 = Util.nvl(request.getParameter("USE_YN1")			, "");
 	String CNTL_ELMN_CTNT = Util.nvl(request.getParameter("CNTL_ELMN_CTNT")			, "");
	String CNTL_RSK_CTNT = Util.nvl(request.getParameter("CNTL_RSK_CTNT")			, "");
	String EVAL_MTHD_CTNT = Util.nvl(request.getParameter("EVAL_MTHD_CTNT")			, "");
	String EVAL_TYPE_CD = Util.nvl(request.getParameter("EVAL_TYPE_CD")			, "");
	String PROOF_DOC_LIST = Util.nvl(request.getParameter("PROOF_DOC_LIST")			, "");
	String BRNO_NM = Util.nvl(request.getParameter("BRNO_NM")			, "");
     */
	
	
	
    request.setAttribute("BAS_YYMM", BAS_YYMM);
    request.setAttribute("GYLJ_S_C_NM",GYLJ_S_C_NM);	
    /* 
	request.setAttribute("CNTL_CATG1_C", CNTL_CATG1_C);
	request.setAttribute("CNTL_CATG2_C", CNTL_CATG2_C);
	request.setAttribute("CNTL_ELMN_C", CNTL_ELMN_C);
	request.setAttribute("CNTL_CATG1_C_NM", CNTL_CATG1_C_NM);
	request.setAttribute("CNTL_CATG2_C_NM", CNTL_CATG2_C_NM);
	request.setAttribute("CNTL_ELMN_C_NM", CNTL_ELMN_C_NM);
 	request.setAttribute("USE_YN1", USE_YN1);
  	request.setAttribute("CNTL_ELMN_CTNT1", CNTL_ELMN_CTNT);
	request.setAttribute("CNTL_RSK_CTNT1", CNTL_RSK_CTNT);
	request.setAttribute("EVAL_MTHD_CTNT1", EVAL_MTHD_CTNT);
	request.setAttribute("EVAL_TYPE_CD1", EVAL_TYPE_CD);
	request.setAttribute("PROOF_DOC_LIST1", PROOF_DOC_LIST);
	request.setAttribute("DEP_LIST", BRNO_NM); */

%>

<script language="JavaScript">
	/**
	 * Initial function
	 */
// 	var GridObj1 	= new GTActionRun();
	var classID 	= "RBA_50_04_01_02";
    var _sno        = 0;
    var GYLJ_S_C_NM = "${GYLJ_S_C_NM}";

    $(document).ready(function() {
    	form1.BAS_YYMM.value     = '<%= BAS_YYMM %>';
    	<%-- form1.CNTL_CATG1_C.value = '<%= CNTL_CATG1_C %>';
        form1.CNTL_CATG2_C.value = '<%= CNTL_CATG2_C %>';
        form1.CNTL_ELMN_C.value = '<%= CNTL_ELMN_C %>';
        form1.CNTL_CATG1_C_NM.value = '<%= CNTL_CATG1_C_NM %>';
        form1.CNTL_CATG2_C_NM.value = '<%= CNTL_CATG2_C_NM %>';
        form1.CNTL_ELMN_C_NM.value = '<%= CNTL_ELMN_C_NM %>'; --%>

        

        //doSearch();

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

    // Initial function
    function init() { initPage(); }

	/**
	 *  보고지표관리 상세내역 조회
	 */
 	function doSearch() {

		var methodID   	  = "doSearch";
		var obj			  = new Object();
		obj.pageID		  = pageID;
	    obj.classID 	  = classID;
		obj.BAS_YYMM	  = "${BAS_YYMM}";
		obj.CNTL_ELMN_C   = "${CNTL_ELMN_C}";

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
		//alert( "selObj.BRNO_NM :::: " + selObj.BRNO_NM + " ,,," + form1.BRNO_NM.value);

  	 	$("#USE_YN1").val(selObj.USE_YN);
 		$("#CNTL_ELMN_CTNT1").val(selObj.CNTL_ELMN_CTNT);
 		$("#CNTL_RSK_CTNT1").val(selObj.CNTL_RSK_CTNT);
 		$("#EVAL_MTHD_CTNT1").val(selObj.EVAL_MTHD_CTNT);
 		$("#EVAL_TYPE_CD1").val(selObj.EVAL_TYPE_CD);
 		$("#PROOF_DOC_LIST1").val(selObj.PROOF_DOC_LIST);
 		$("#DEP_LIST").val(selObj.BRNO_NM);

 	}


	/**
	 *  통제요소 상세내역 저장
	 */
	function doSave() {

		if( GYLJ_S_C_NM != "미입력" && GYLJ_S_C_NM != "반려") {
    		showAlert("결재상태 미입력 또는 반려 일때만 수정, 삭제 가능합니다.",'WARN');
    		return;
    	}

		 showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>', '${msgel.getMsg("AML_00_00_01_01_025","저장")}', doSave_Action);
    }

    function doSave_Action(){
        var form1 				= document.form1;
        form1.pageID.value 		= "RBA_50_04_01_06";
        form1.classID.value 	= "RBA_50_04_01_02";
        form1.methodID.value 	= "doAdd";
        form1.trCnt.value 		= $("#EvalInputTable tr").length-1;
        form1.target 			= "submitFrame";
        form1.action 			= "<c:url value='/'/>0001.do";

        form1.BAS_YYMM          = "${BAS_YYMM}";
        form1.CNTL_CATG1_C      = "${CNTL_CATG1_C}";
        form1.CNTL_CATG2_C      = "${CNTL_CATG2_C}";
        form1.CNTL_ELMN_C       = "${CNTL_ELMN_C}";

        var option = {
            type: "POST",
            success: function() {
                showAlert('${msgel.getMsg("RBA_90_01_02_03_201", "정상 처리 되었습니다.")}', "INFO");
                //doSearch();
                self.close();
                opener.doSearch();
            },
            error: function(xhr, textStatus) {showAlert(textStatus,'ERR');}
        };
        $('#form1').ajaxSubmit(option);
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
		               "pageID"     		: "RBA_50_04_01_06"
		              ,"classID"    		: "RBA_50_04_01_02"
		              ,"methodID"   		: "getSearchCntlElmnList"
		              ,"BAS_YYMM"			: "${BAS_YYMM}"
		              ,"CNTL_ELMN_C"	    : "${CNTL_ELMN_C}"
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



    function doSetUseDepInfo(){
    	/*최근 형가일정인지 체크  */
/*     	if(!chkCommValidation("CHK_BAS_YYMM")) {showAlert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}','WARN'); return;};

        if($("#TONGJE_LGDV_C").val()==""){
        	showAlert('${msgel.getMsg("RBA_50_02_01_003","대분류는 필수 값 입니다.")}','WARN');
            return false;
        }
        if($("#TONGJE_MDDV_C").val()==""){
        	showAlert('${msgel.getMsg("RBA_50_02_01_008","중분류는 필수 값 입니다.")}','WARN');
	        return false;
    	} */


    	//alert( $("#CNTL_CATG1_C option:selected").text() );

        form2.pageID.value     		   =  "RBA_50_04_01_03";
        form2.BAS_YYMM.value   		   =  "${BAS_YYMM}";
        form2.CNTL_CATG1_C.value       =  $("#CNTL_CATG1_C").val();
        form2.CNTL_CATG2_C.value 	   =  $("#CNTL_CATG2_C").val();
        form2.CNTL_ELMN_C.value        =  $("#CNTL_ELMN_C").val();
        //form2.BRNO_NM.value            =  $("#BRNO_NM").val();

        form2.CNTL_CATG1_C_NM.value    =  $("#CNTL_CATG1_C_NM").val();
        form2.CNTL_CATG2_C_NM.value    =  $("#CNTL_CATG2_C_NM").val();
        form2.CNTL_ELMN_C_NM.value     =  $("#CNTL_ELMN_C_NM").val();

        var win;                win = window_popup_open("RBA_50_04_01_03",  1350, 650, '','no');
        form2.target                = "RBA_50_04_01_03";
        form2.action                = '<c:url value="/"/>0001.do';
        form2.submit();
    }


</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
    <input type="hidden" name="GUBN">
    <input type="hidden" name="CNTL_CATG1_C" >
    <input type="hidden" name="CNTL_CATG2_C" >
    <input type="hidden" name="CNTL_ELMN_C" >
    <input type="hidden" name="CNTL_CATG1_C_NM" >
    <input type="hidden" name="CNTL_CATG2_C_NM" >
    <input type="hidden" name="CNTL_ELMN_C_NM" >
</form>

<form name="form1" id="form1" name="form1" method="post">
<input type="hidden" name="pageID">
<input type="hidden" name="classID">
<input type="hidden" name="methodID">
<input type="hidden" name="BAS_YYMM" value="${BAS_YYMM}"/>
<!-- <input type="hidden" name="CNTL_CATG1_C" id="CNTL_CATG1_C">
<input type="hidden" name="CNTL_CATG2_C" id="CNTL_CATG2_C"> -->
<!-- <input type="hidden" name="CNTL_ELMN_C" id="CNTL_ELMN_C"> -->
<!-- <input type="hidden" name="CNTL_CATG1_C_NM" id="CNTL_CATG1_C_NM">
<input type="hidden" name="CNTL_CATG2_C_NM" id="CNTL_CATG2_C_NM">
<input type="hidden" name="CNTL_ELMN_C_NM" id="CNTL_ELMN_C_NM"> -->
<input type="hidden" name="USE_YN" id="USE_YN"/>
<input type="hidden" name="CNTL_ELMN_CTNT" id="CNTL_ELMN_CTNT"/>
<input type="hidden" name="CNTL_RSK_CTNT"  id="CNTL_RSK_CTNT"/>
<input type="hidden" name="EVAL_MTHD_CTNT" id="EVAL_MTHD_CTNT"/>
<input type="hidden" name="EVAL_TYPE_CD" id="EVAL_TYPE_CD"/>
<input type="hidden" name="PROOF_DOC_LIST" id="PROOF_DOC_LIST"/>
<input type="hidden" name="BRNO_NM" />
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
			   <tbody>
			        <tr>
                    	<th class="title required">${msgel.getMsg('RBA_50_04_01_02_001','통제분류Lv1')}</th>
                    	<%-- <td style="text-align: center;">${CNTL_CATG1_C_NM}</td> --%>
                    	     <td style="text-align: left;">
		                		${RBACondEL.getKRBASelect('CNTL_CATG1_C','' ,'' ,'P001' ,'' ,'ALL' ,'nextSelectChange2_2("CNTL_CATG2_C", "P002", this)','','','')}
		                	</td>
                        <th class="title required">${msgel.getMsg('RBA_50_04_01_02_002','통제분류Lv2')}</th>
	                        <td style="text-align: left;">
	                        	${RBACondEL.getKRBASelect('CNTL_CATG2_C','' ,'' ,'P002' ,'' ,'ALL' ,'nextSelectChange2_2("CNTL_ELMN_C", "P003", this)','','','')}
	                        </td>
                    </tr>
                     <tr>
                    	<th class="title required">${msgel.getMsg('RBA_50_04_01_02_003','통제요소')}</th>
                    		<td style="text-align: left;">
	                        	${RBACondEL.getKRBASelect('CNTL_ELMN_C','' ,'' ,'P003' ,'' ,'ALL' ,'','','','')}
	                        </td>
                        <th class="title required">${msgel.getMsg('RBA_50_04_01_02_004','사용여부')}</th>
						<td>
                        	<div class="content" >
								<select name="USE_YN1" id="USE_YN1" value="${USE_YN1}" class="dropdown" onChange='' >
					                <option value='1' >Y</option>
					                <option value='0' >N</option>
					            </select>
							</div>
						</td>
                    </tr>
                    <tr>
	                	<th class="title">${msgel.getMsg('RBA_50_04_01_02_005','통제요소설명')}</th>
	                	<td style="text-align: left;" colspan="5">
	                		<input type="text" name="CNTL_ELMN_CTNT1" id="CNTL_ELMN_CTNT1"  class="cond-input-text"  value="${CNTL_ELMN_CTNT1}" style="text-align: left; width: 100%" />
	                	</td>
	                </tr>
	                <tr>
	                	<th class="title">${msgel.getMsg('RBA_50_04_01_02_006','통제위험')}</th>
	                	<td style="text-align: left;" colspan="5">
	                		<input type="text" name="CNTL_RSK_CTNT1" id="CNTL_RSK_CTNT1" class="cond-input-text" value="${CNTL_RSK_CTNT1}" style="text-align: left; width: 100%" />
	                	</td>
	                </tr>
	                <input type="text" name="BAS_YYMM" id="BAS_YYMM" class="cond-input-text" style="visibility:hidden;" />


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
	<div class="panel-footer" >
		<div class="table-box">
			<table class="basic-table" >
			   <tbody>
			   <tr>
			   		<th class="title required" style="width:155;">${msgel.getMsg('RBA_50_04_01_02_007','평가유형')}</th>
                   	<td>
                       	<div class="content" >
							<select name="EVAL_TYPE_CD1" id="EVAL_TYPE_CD1" class="dropdown" onChange="onSelectChange(this)" style="width:160px" >
				                <option value='1' >단일 Y/N</option>
				                <option value='2' >복수 Y/N</option>
				                <option value='3' >실적입력</option>
				            </select>
						</div>
					</td>
			   </tr>
			   <%-- <tr>
                	<th class="title required">${msgel.getMsg('RBA_50_04_01_02_008','평가대상부점')}</th>
                	<td style="text-align: left;" colspan="5">
                		<input type="text"  class="cond-input-text" name="DEP_LIST" id="DEP_LIST" value="${DEP_LIST}" style="text-align: left;" readonly/>
                	</td>
                	<td id="DEP_MODI_BTN_AREA">
                        	${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"updateBtn", defaultValue:"수정", mode:"U", function:"doSetUseDepInfo", cssClass:"btn-36"}')}
                    </td>
                </tr> --%>
                <tr>
                	<th class="title">${msgel.getMsg('RBA_50_04_01_02_009','평가방법')}</th>
                	<td style="text-align: left;" colspan="5">
                		<input type="text"  class="cond-input-text" name="EVAL_MTHD_CTNT1" id="EVAL_MTHD_CTNT1" value="${EVAL_MTHD_CTNT1}" style="text-align: left;"/>
                	</td>
                </tr>
                <tr>
                	<th class="title">${msgel.getMsg('RBA_50_04_01_02_010','관련증빙')}</th>
                	<td style="text-align: left;" colspan="5">
                		<input type="text"  class="cond-input-text" name="PROOF_DOC_LIST1" id="PROOF_DOC_LIST1"  value="${PROOF_DOC_LIST1}" style="text-align: left;"/>

                	</td>
                </tr>

				</tbody>
			</table>
		</div>
	</div>
</div>

	<div class="panel panel-primary">
	    <div class="panel-footer" style="width:100%;">
				<div style="height:200;overflow-y:scroll;">
					<jsp:include page="/0001.do?pageID=RBA_50_04_01_05" >
						<jsp:param name="BAS_YYMM"   		value='${BAS_YYMM}'/>
						<jsp:param name="CNTL_ELMN_C" 		value='${CNTL_ELMN_C}'/>
						<jsp:param name="classID"   		value='RBA_50_04_01_02'/>
						<jsp:param name="methodID"  		value='getSearchCntlElmnList'/>
					</jsp:include>
				</div>
				<div style="font-family: SpoqB;font-size:0.8rem;color:blue;">
	    			※ ${msgel.getMsg("RBA_90_01_02_03_200","저장 시 체크박스와 관계없이 일괄 저장됩니다.")}
		   		</div>
  	    </div>
	</div>
	<div class="tab-content-top">
		<div class="button-area" style="margin-top:5px;">
			${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"self.close", cssClass:"btn-36"}')}
			<%-- ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')} --%>
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />