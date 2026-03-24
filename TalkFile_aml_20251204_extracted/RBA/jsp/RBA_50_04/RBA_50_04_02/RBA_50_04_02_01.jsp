<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_04_02_01.jsp
* Description     : 통제평가 배점관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : LCJ
* Since           : 2018-05-02
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
    
%>
<style type="text/css">
    * { white-space: nowrap; }
</style>
<script>
    
    var GridObj1;
    var overlay = new Overlay();
    var pageID  =  "RBA_50_04_02_01";
    var classID  = "RBA_50_04_02_01";
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        $("#BAS_YYMM").attr("style","width:100px;");
        $("#TONGJE_FLD_C").attr("style","width:100px;text-align:center;");
        $("#TONGJE_LGDV_C").attr("style","width:100px;text-align:center;");
        
    });
    
    // Initial function
    function init() { initPage(); }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	
        // 그리드1(Code Head) 초기화
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_04_02_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(83vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,completedEvent  :doSearch
           ,failEvent : doSearch_end
        });
    }
    
    // 검색조건 셋업
    function setupConditions() {
    	try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(220, 90, 0);
            cbox1.setItemWidths(220, 90, 1);
            cbox1.setItemWidths(280, 90, 2);
            
        } catch (e) {
            alert(e.message);
        }
    }
    
    //통제평가 배점 관리 조회
    function doSearch() {
    	overlay.show(true, true);
    	
        var methodID = "doSearch";
        
        GridObj1.refresh({
            actionParam: {
                "pageID"       	: pageID,
                "classID"      	: classID,
                "methodID"     	: methodID,
                "TONGJE_FLD_C"  : $("#TONGJE_FLD_C").val(),  
                "TONGJE_MDDV_C" : $("#TONGJE_MDDV_C").val(), 
                "TONGJE_LGDV_C" : $("#TONGJE_LGDV_C").val(), 
                "BAS_YYMM"      : $("#BAS_YYMM").val()    
                
            },
            completedEvent: doSearch_end
        });
    }
    
    //통제평가 배점 관리 조회 end
    function doSearch_end() {
        setData(); 
        overlay.hide();
        
    }
    //데이터 셋팅
    function setData() {
    	deleteRows();
    	
    	var cnt = GridObj1.rowCount();
    	var TONGJE_ALLT = 0;
    	for( i=0; i < cnt ; i++ ) {
    		var cellData =  GridObj1.getRow(i);
    		TONGJE_ALLT = Number(cellData.TONGJE_ALLT);
    		
    		$('#mergeTable > tbody:last').append('<tr><td style="text-align:center;border-right: 1px solid #CCCCCC;">'+cellData.TONGJE_FLD_C+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" >'+cellData.TONGJE_FLD_NM+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;">'+cellData.TONGJE_ALLT+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;">'+cellData.TONGJE_LGDV_C+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;">'+cellData.TONGJE_LGDV_NM+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" >'+cellData.TONGJE_ALLT+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" >'+cellData.TONGJE_MDDV_C+'</td>'
    											+'<td style="text-align:center;border-right: 1px solid #CCCCCC;" >'+cellData.TONGJE_MDDV_NM+'</td>'
    				                            +'<td style="text-align:center;border-right: 1px solid #CCCCCC;">'
    				                            +'   <input type="text" id="'+cellData.TONGJE_MDDV_C+'" style="text-align:center; width: 100%" value ="'+TONGJE_ALLT+'"/></td></tr>')
    	}
    	
    	if(cnt > 0) { 
    		mergeData();
    		$('#mergeTable > tbody:last').append('<tr><th style="text-align:right;border-right: 1px solid #CCCCCC;" colSpan="3">영역 배점 합계  : '+GridObj1.getRow(0).TONGJE_ALLT_SUM+'</th>'
					+'<th style="text-align:right;border-right: 1px solid #CCCCCC;" colSpan="3">대분류 배점 합계  : '+GridObj1.getRow(0).TONGJE_ALLT_SUM+'</th>'
					+'<th style="text-align:right;border-right: 1px solid #CCCCCC;" colSpan="3">중분류 배점 합계  : '+GridObj1.getRow(0).TONGJE_ALLT_SUM+'</th></tr>');
    	}
    	
    }
    
    // 분류가 같은 데이터 병합
    function mergeData() {
    	var tabObj = document.getElementById("mergeTable");
    	//배점2 병합
    	mergeCol(tabObj,3);
    	//배점1 병합
    	mergeCol(tabObj,0);
    }
 	
    // 분류가 같은 데이터 병합
    function mergeCol(tObj,col){
    	var maxRow = tObj.rows.length;
    	//2row로 초기값 셋팅
    	var compareData = tObj.rows[2].cells[col].innerText;
    	var num = Number(tObj.rows[2].cells[col+2].innerText);
    	var currentData ="";
    	var mergeCount=1;
    	
    	/* 0~1 row 헤어 
 	   		2 row는 초기값
 	  	 	3 row부터 for문시작
 		*/
    	for(var i=3; i<maxRow; i++) {
    		//currentData 은  코드값
    		currentData = tObj.rows[i].cells[col].innerText;
    		//currentDataNum은 소분류의 배점
    		currentDataNum = tObj.rows[i].cells[col+2].innerText;
    		
    		//중분류 코드값 같으면 소분류 배점을 더함
    		if(currentData == compareData) {
    			mergeCount ++;
    			num = Number(num) + Number(currentDataNum);
    		} else {
    			merge(tObj, col, i-mergeCount, mergeCount,num);
    			compareData = currentData;
    			mergeCount=1;
    			num = Number(currentDataNum);
    		}
    	}
    	
    	merge(tObj, col, maxRow-mergeCount, mergeCount, num);
    }
 	
    // 분류가 같은 데이터 병합
    function merge(tObj, col, start,len,num) {
    	if(1 < len) {
    		
    		tObj.rows[start].cells[col+2].innerText = Number(num).toFixed(2);
    		tObj.rows[start].cells[col+2].rowSpan = len;
    		tObj.rows[start].cells[col+2].align = "center";
    		for(var j=start + 1 ; j <start + len; j++) {
    			tObj.rows[j].deleteCell(col+2);
    		}
    	}
    	if(len == 1){
    		tObj.rows[start].cells[col+2].innerText = Number(num).toFixed(2);
    	}
    }
 	
    // 화면에 있는 tableRow 삭제(헤더테이블 2row 제외)
    function deleteRows() {
        var tbl = document.getElementById('mergeTable');
            lastRow = tbl.rows.length - 1;           
        for (i = lastRow; 1 < i; i--) {
            tbl.deleteRow(i);
        }
    }
    
    
    //배점 저장
    function doSave() {
    	
    	/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {alert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}'); return;};
    	/*업무 실제 종료일자 확인  */
    	if(!chkCommValidation("CHK_MODIFY_POSSI_REAL_DT")) {alert('${msgel.getMsg("RBA_50_02_01_011","해당 업무단계의 실제종료일이 작성되어 있어 수정 불가능 합니다.")}'); return;};    	
    	
    	overlay.show(true, true);
    	
    	var tabObj = document.getElementById("mergeTable");
    	var maxRow = tabObj.rows.length;
    	var rowArr; rowArr = new Array();
    	var arr2; arr2=[];
    	var TONGJE_FLD_C ="";
    	var TONGJE_MDDV_C="";
    	var TONGJE_ALLT="";
    	var rowLength=0;
    	var num; num = 0;
    	var dataStr ="";
    	
    	for(var i=2; i<maxRow-1; i++) {
    		rowLength   = tabObj.rows.item(i).cells.length;
    		TONGJE_FLD_C    = tabObj.rows[i].cells[0].innerText;
    		TONGJE_MDDV_C   = tabObj.rows[i].cells[rowLength-3].innerText;
    		TONGJE_ALLT  = $("#"+TONGJE_MDDV_C).val();
    		
    		if(TONGJE_ALLT == "") {
    			overlay.hide();
    			alert(TONGJE_MDDV_C + "배점을 입력해야 합니다.");
    			$("#"+TONGJE_MDDV_C).focus();
    			return false;			
    		}
    		
    		if(TONGJE_ALLT.indexOf(".") > -1 && TONGJE_ALLT.length - TONGJE_ALLT.indexOf(".") > 3) {
    			overlay.hide();
    			alert("${msgel.getMsg('RBA_50_03_03_009','배점은 소수점 2자리까지만 입력됩니다.')}");
    			return false;			
    		} 
    		
    		dataStr += TONGJE_FLD_C+"&&"+TONGJE_MDDV_C+"&&"+TONGJE_ALLT;
    		dataStr += ",";
    	}
    	dataStr = dataStr.substring(0,dataStr.length-1)
        var methodID = "doSave";
        
        GridObj1.save({
            actionParam: {
            	"pageID"    : pageID,
                "classID"   : classID,
                "methodID"  : methodID,
                "dataArr"   	: dataStr,
                "BAS_YYMM"  : $("#BAS_YYMM").val()    //평가지준월
            },
            sendFlag      : "USERDATA",
            completedEvent: doSaveEnd,
            failEvent : doSaveEnd
        });
    }
    
    //배점저장 end
    function doSaveEnd() {
        overlay.hide();
        doSearch();
        
    }
    // 엑셀 다운로드 function
    function doDownload() {
        
    	if(!confirm('${msgel.getMsg("RBA_50_03_03_002","다운로드 하시겠습니까?")}')) {
            return;
        }
        
        form2.BAS_YYMM.value         = $("#BAS_YYMM").val();
        form2.TONGJE_FLD_C.value     = $("#TONGJE_FLD_C").val();
        form2.TONGJE_LGDV_C.value    = $("#TONGJE_LGDV_C").val();
        form2.target                 = "_self";
        form2.action                 = "Package/RBA/common/fileDown/sRbaExcelFileDownload2.jsp";
        form2.method                 = "post";
        form2.submit();
    
    }
    
    //배점기준관리  업로드(RBA_50_04_02_02.jsp) 팝업 호출 function
    function openTjInfoUploadPopUp() {
        
    	/*최근 형가일정인지 체크  */
    	if(!chkCommValidation("CHK_BAS_YYMM")) {alert('${msgel.getMsg("RBA_50_02_01_010","최근 평가기준월 데이터만 등록,수정,삭제 가능합니다.")}'); return;};
    	/*업무 실제 종료일자 확인  */
    	if(!chkCommValidation("CHK_MODIFY_POSSI_REAL_DT")) {alert('${msgel.getMsg("RBA_50_02_01_011","해당 업무단계의 실제종료일이 작성되어 있어 수정 불가능 합니다.")}'); return;};    	
    	
        form2.pageID.value   = "RBA_50_04_02_02";
        form2.BAS_YYMM.value = $("#BAS_YYMM").val();
        var win;         win = window_popup_open(form2, 400, 180, '', 'yes');
        form2.method         = "post";
        form2.target         = form2.pageID.value;
        form2.action         = "<c:url value='/'/>0001.do";
        form2.submit();
    }
    
    function chkCommValidation(CHK_GUBN){
    	//▶통제평가 배점 관리 D02
    	var RBA_VALT_SMDV_C = "D02"
    	
    	var callbackfunc = "chkMaxBasYYMM_end";
		var actionName = "com.gtone.rba.common.action.CommonValidationCheckAction";
    	var paramdata = new Object();
    	paramdata.BAS_YYMM = $("#BAS_YYMM").val();
    	paramdata.CHK_GUBN = CHK_GUBN;
    	paramdata.RBA_VALT_SMDV_C = RBA_VALT_SMDV_C;
    	
    	
    	if(chkValidationSync(actionName,paramdata,callbackfunc)){
    		return true;
    	}else {
    		return false;
    	}
    }


    
    
</script>

<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
    <input type="hidden" name="TONGJE_FLD_C" >
    <input type="hidden" name="TONGJE_LGDV_C" >
</form>
<form name="form1" method="post">
	<input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <div class="cond-box" id="condBox1">
        <div class="cond-row">
        	<div class="cond-item">
            	${condel.getLabel('RBA_50_03_02_001','평가기준월')}
                ${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'doSearch()')}
            </div>
            <div class="cond-item">
            	${condel.getLabel('RBA_50_04_02_001','통제영역')}
            	${SRBACondEL.getSRBASelect('TONGJE_FLD_C','' ,'' ,'R312' ,'','ALL','nextSelectChangeSRBA("TONGJE_LGDV_C", "FA", this,"")','','','')}
            </div>
            <div class="cond-item">
            	${condel.getLabel('RBA_50_04_01_001','대분류')}
            	${SRBACondEL.getSRBASelect('TONGJE_LGDV_C','' ,'' ,'R313' ,'','ALL','','','','')}
            </div>
        </div>
        <div class="cond-line"></div>
        <div class="cond-btn-row" style="text-align:right">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')}
            ${btnel.getButton(outputAuth, '{btnID:"sbtn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"RBA009", defaultValue:"파일 Upload", mode:"C", function:"openTjInfoUploadPopUp", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-upload"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"RBA010", defaultValue:"파일 Download", mode:"C", function:"doDownload", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-download"}')}
        </div>
    </div>
    <div class="panel panel-primary">
        <div class="panel-footer" >
            <div class="table-box" >
                <table  border="5" width="100%" class="hover" id="mergeTable" boder="2">
                    <tr>
                        <th colspan="3">${msgel.getMsg('RBA_50_04_02_002','통제영역(Control Category)')}</th>
                        <th colspan="6">${msgel.getMsg('RBA_50_04_02_003','내부통제요소(Control Factor)')}</th>
                    </tr>
                    <tr>
                        <th>${msgel.getMsg("RBA_50_03_03_005","코드")}</th>
                        <th>${msgel.getMsg("RBA_10_05_01_012","영역")}</th>
                        <th>${msgel.getMsg("RBA_50_03_03_006","배점1(%)")}</th>
                        <th>${msgel.getMsg("RBA_50_03_03_005","코드")}</th>
                        <th>${msgel.getMsg("RBA_50_04_01_001","대분류")}</th>
                        <th>${msgel.getMsg("RBA_50_03_03_007","배점2(%)")}</th>
                        <th>${msgel.getMsg("RBA_50_03_03_004","RI-ID")}</th>
                        <th>${msgel.getMsg("RBA_50_03_02_003","중분류")}</th>
                        <th>${msgel.getMsg("RBA_50_03_03_008","배점3(%)")}</th>
                    </tr>                                     
                </table>
            </div>
        </div>
    </div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />