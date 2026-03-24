<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_50_10_01_02.jsp
- Author     : 윤영욱
- Comment    : 업무보고서-파입업로드 등록
- Version    : 5.0
- history    : 5.0 2018-05-08
********************************************************************************************************************************************
* Modifier        : 윤영욱
* Update          : 2018. 5. 8
* Alteration      : 1. devex그리드 적용
*******************************************************************************************************************************************
--%>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    
    //String RPT_GJDT   = jspeed.base.util.DateHelper.format(Util.nvl(request.getParameter("RPT_GJDT")), "yyyyMM", "yyyy-MM");    
	String RPT_GJDT   = Util.nvl(request.getParameter("RPT_GJDT"));
    String BIZ_RPT_ID = Util.nvl(request.getParameter("BIZ_RPT_ID"));
    String BIZ_RPT_NM = Util.nvl(request.getParameter("BIZ_RPT_NM"));
    
%>


<script>
    var GridObj1    = null;
    var classID  = "RBA_50_10_01_02";   
    var overlay		= new Overlay();
   
    /** Initial function */
    $(document).ready( function() {
    	
        setupGrids();

    	$('.popup-contents').css({overflow:"auto"});   	    	
        
    	form1.RPT_GJDT.value = "<c:out value='<%=RPT_GJDT%>'/>";
        form1.BIZ_RPT_ID.value = "<c:out value='<%=BIZ_RPT_ID%>'/>";
        form1.BIZ_RPT_NM.value = "<c:out value='<%=BIZ_RPT_NM%>'/>";
        
    });

    function newRpt() {
    	var ischecked = form1.CHK_NEW.checked;
    	
    	if(ischecked) {        		
    		form1.RPT_GJDT.value = "";    		
    		form1.RPT_GJDT.readOnly = false;
    	} else {        		
    		form1.RPT_GJDT.value = "<c:out value='<%=RPT_GJDT%>'/>";
    		form1.RPT_GJDT.readOnly = true;
    	}
    }

    function setupGrids()
    {
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid01'
           ,headerId        : 'RBA_50_10_01_02_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : '400'
           ,completedEvent  : function(){doSearch();}
        });
    }
    
    function doSearch()
    {   
        GridObj1.removeAll(); 
        GridObj1.refresh({
            actionParam         : {
                "pageID"	    : "RBA_50_10_01_02",
                "classID"	    : "RBA_50_10_01_02",
                "methodID"	    : "doSearch"
            },
            completedEvent	: doSearch_end     
        }); 
    }
    
    function doSearch_end(data)
    {
        overlay.hide();
    }

    function  check_value(){
    	
    	var gObj = GridObj1.getSelectedRows();
    	var check_month=null;
    	var flag=null;

		if(gObj.length == 0){
			alert('업로드할 보고서를 선택하여 주십시오.');
			return false;
		}
		
    	for( i=0 ; i<gObj.length ; i++) {
	    	
    		var obj = gObj[i];
	    	check_month = form1.RPT_GJDT.value.substring(4,6);
	    	
	    	if(check_month=="03"||check_month=="06"||check_month=="09"||check_month=="12"){
				flag=1;
	    	}else
	    		flag=0;
	    	
	    	if(obj.FRQ_NM=="분기" && flag==0){
				alert('분기데이터는 3월 6월 9월 12월에만 업로드 할 수 있습니다.');
				return false;
	    	}	    	
	    }
    	return true;
    }
    // file save
    function doSave() {
        
    	var selectedRows = GridObj1.getSelectedRowsData();
        var selSize = selectedRows.length;
        var bizRptId; bizRptId = "";
        
        if(!check_value()) return;
        
        if(form1.NOTI_ATTACH.value == ""){
            alert("파일이 존재하지 않습니다.");
            return;
        }
        
        //alert("doSave");
        if(!confirm("${msgel.getMsg('doSave','저장하시겠습니까?')}")) {
            return;
        }
        
        //overlay.show(true, true);
        for (var i=0; i<selSize; i++) {
            var obj = selectedRows[i];
            if ( obj.BIZ_RPT_ID == 'GA023' ) {
            	form1.GA023.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA039' ) {
            	form1.GA039.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA054' ) {
            	form1.GA054.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA058' ) {
            	form1.GA058.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA067' ) {
            	form1.GA067.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA070' ) {
            	form1.GA070.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA071' ) {
            	form1.GA071.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA072' ) {
            	form1.GA072.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA140' ) {
            	form1.GA140.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA142' ) {
            	form1.GA142.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA145' ) {
            	form1.GA145.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA160' ) {
            	form1.GA160.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA179' ) {
            	form1.GA179.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA180' ) {
            	form1.GA180.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA186' ) {
            	form1.GA186.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA187' ) {
            	form1.GA187.value = "Y";
            } else if ( obj.BIZ_RPT_ID == 'GA237' ) {
            	form1.GA237.value = "Y";
            }
        }
        form1.pageID.value   = 'RBA_50_10_01_02_upload';
        form1.methodID.value = 'doSave';        
        form1.target         = "submitFrame";
        form1.action         = "<c:url value='/'/>0001.do";        
        form1.encoding       = "multipart/form-data";
        form1.submit();
    }
    
    // file save end
    function doSave_end() {
    	overlay.hide();
        opener.doSearch01();
        opener.goAjaxWidthReturn_BASYYMM(form1.RPT_GJDT.value);
        window.close();
    }
    
    // 파일 실제 경로
    function getRealPath(obj) {
        obj.select();
        form.REAL_PATH.value = document.selection.createRangeCollection()[0].text.toString();
    }
    
    function doClose()
    {
        window.close();
    }
    
    
    
</script>    

<form name="form1" id="form1" method="post">
    <input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" id="REAL_PATH" name="REAL_PATH" value="" />
    <input type="hidden" name="GA023"        id="GA023"     value="N"  />
    <input type="hidden" name="GA039"        id="GA039"     value="N"  />
    <input type="hidden" name="GA054"        id="GA054"     value="N"  />
    <input type="hidden" name="GA058"        id="GA058"     value="N"  />
    <input type="hidden" name="GA067"        id="GA067"     value="N"  />
    <input type="hidden" name="GA070"        id="GA070"     value="N"  />
    <input type="hidden" name="GA071"        id="GA071"     value="N"  />
    <input type="hidden" name="GA072"        id="GA072"     value="N"  />
    <input type="hidden" name="GA140"        id="GA140"     value="N"  />
    <input type="hidden" name="GA142"        id="GA142"     value="N"  />
    <input type="hidden" name="GA145"        id="GA145"     value="N"  />
    <input type="hidden" name="GA160"        id="GA160"     value="N"  />
    <input type="hidden" name="GA179"        id="GA179"     value="N"  />
    <input type="hidden" name="GA180"        id="GA180"     value="N"  />
    <input type="hidden" name="GA186"        id="GA186"     value="N"  />
    <input type="hidden" name="GA187"        id="GA187"     value="N"  />
    <input type="hidden" name="GA237"        id="GA237"     value="N"  />
    
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>        	
       			<tr>
            		<th>${msgel.getMsg('RBA_50_10_01_01_001','기준년월')}</th>
            		<td><input name="RPT_GJDT" id="RPT_GJDT" type="text" value="" size="15" maxlength="6" style="width:70px" readOnly></td>
            		<th>${msgel.getMsg('RBA_50_10_01_02_001','신규작성')}</th>
            		<td><input name="CHK_NEW" id="CHK_NEW" type="checkbox" onClick="javascript:newRpt();"></td>
            	</tr>
		<tr>
            <th>${msgel.getMsg('RBA_50_10_01_02_006','첨부파일')}</th>
            <td colspan="3" width="80%">
	            <div class="cond-row">
		            <div class="cond-item">
		                <span><i class="fa fa-chevron-circle-right" ></i>&nbsp;파&nbsp;&nbsp;일&nbsp;</span>
		                <span style="vertical-align:middle"><input type="file" name="NOTI_ATTACH" id="NOTI_ATTACH" onchange="javascript:getRealPath(this);" style='width: "100%";' />(ex:EXCEL.xls)</span>
		                <input type="hidden" id="REAL_PATH" name="REAL_PATH" value="" />
		            </div>
	            </div>            
            </td>
        </tr>
        </table>
    </div>
</div>
<div class="panel panel-primary" style="visibility:hidden;">
   <div class="panel-footer" >
       <div id="GTDataGrid1_Area"></div>
   </div>
</div>
<div class="popup-cont-box">
    <div class="cond-btn-row" style="text-align:right;margin-top:10px;">
        <span id ="sbtn_03" > 
         </span>
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}  
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-power-off", show:"N"}')}
       
    </div>
</div>
</form>
<!------------------------------------------------------------------------------>
<iframe id='submitFrame' name="submitFrame" height='0' width='0'></iframe>
<!------------------------------------------------------------------------------>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 
