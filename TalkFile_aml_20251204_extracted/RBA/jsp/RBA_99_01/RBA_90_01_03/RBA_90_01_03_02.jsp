<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
- File Name  : RBA_90_01_03_02.jsp
- Author     : 권얼
- Comment    : FIU 지표등록관리/MAX값입력
- Version    : 1.0
- history    : 1.0 20181121
--%>

<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	String RPT_GJDT  	= Util.nvl(request.getParameter("RPT_GJDT") , "");
	String MNG_BRNO  	= Util.nvl(request.getParameter("MNG_BRNO") , "");
	
	StringBuffer strGjdt = new StringBuffer(64);
	strGjdt.append(RPT_GJDT.substring(0 , 4));
	strGjdt.append('-');
	strGjdt.append(RPT_GJDT.substring(4 , 6));
	strGjdt.append('-');
	strGjdt.append(RPT_GJDT.substring(6 , 8));
	String VIEW_RPT_GJDT = strGjdt.toString();

	//String VIEW_RPT_GJDT = RPT_GJDT.substring(0,4)+"-"+RPT_GJDT.substring(4,6)+"-"+ RPT_GJDT.substring(6,8);
	String JIPYO_C = "O";			//운영위험
	String VALT_G = "2";			//상대비율평가
	
	request.setAttribute("RPT_GJDT",RPT_GJDT);
	request.setAttribute("VIEW_RPT_GJDT",VIEW_RPT_GJDT);
	request.setAttribute("JIPYO_C",JIPYO_C);
	request.setAttribute("VALT_G",VALT_G);
	request.setAttribute("MNG_BRNO",MNG_BRNO);
	
%>
<script language="JavaScript">

	var overlay = new Overlay();
	var GridObj1 = null;
	var classID = "RBA_90_01_03_02";
	
	
	$(document).ready(function() {
		setupGrids();
		setupConditions();
    });
	
	/** 그리드 셋업 */
	function setupGrids(){
	    GridObj1 = initGrid3({
	         gridId          : 'GTDataGrid1'
	        ,headerId        : 'RBA_90_01_03_02_Grid1'
	        ,gridAreaId      : 'GTDataGrid1_Area'
	        ,height          : 'calc(60vh)'
	        ,useAuthYN       : '${outputAuth.USE_YN}'
	    	,completedEvent  :doSearch
	    });
	}
	
	/** 검색조건 셋업 */
	function setupConditions(){
		try {
			var cbox1; cbox1 = new GtCondBox("condBox1", 2, true);
			cbox1.setItemWidths(185, 75, 0);
            cbox1.setItemWidths(185, 75, 1);			
		} catch (e) {
			showAlert(e.message,'ERR');
		}
	}
	
	/**
	 *  보고지표관리 상세내역 조회
	 */
	function doSearch() {
		overlay.show(true, true);
		
		var obj = new Object();
		
		obj.pageID 		= pageID;
		obj.classID 	= classID;
		obj.methodID 	= "doSearch";
		obj.RPT_GJDT 	= "${RPT_GJDT}";
		obj.JIPYO_C 	= "${JIPYO_C}";
		obj.VALT_G 		= "${VALT_G}";
		obj.MNG_BRNO 	= "${MNG_BRNO}";
		obj.JIPYO_IDX 	= form1.JIPYO_IDX.value.trim();							// 지표번호
		obj.JIPYO_NM  	= form1.JIPYO_NM.value.trim();							// 지표명
		//obj.jsFunction 	= "doSearch_end";
		
		GridObj1.refresh({
            actionParam    : obj
           ,completedEvent : doSearch_end
           ,failEvent : function(e){overlay.hide();}
        });
	}
	
	function doSearch_end() {
		var gridCnt = GridObj1.rowCount();
		if(gridCnt>0) {
			var selObj = GridObj1.getRow(0);
			setData(selObj);
			
			var row; row = GridObj1.rowCount();
// 			for(var i=0;i<row;i++){
// 				GridObj1.setColumnIDColor((i) + '', "RPT_PNT", '0xFF0000');		//red:'0xFF0000',??:'0x00FFFF', green:'0x00FF00'
// 			}
		}
		overlay.hide();
	}

	/**
	 *  보고지표관리 상세내역 값 세팅
	 */
	function setData(selObj){
		$("JIPYO_C").value = selObj.JIPYO_C;
		$("JIPYO_C_NM").value = selObj.JIPYO_C_NM;
		$("VALT_G").value = selObj.VALT_G;	
		$("VALT_G_NM").value = selObj.VALT_G_NM;
	}

	/**
	 *  보고지표관리 상세내역 저장
	 */	
	function doSave() {
		
		if(!CheckValue()){
			return;
		}
		
		if(!showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>','저장')) return;
		
		var obj = new Object();
		
		obj.pageID = "RBA_90_01_03_02";
		obj.classID = classID;
		obj.methodID = "doSave";
		//obj.jsFunction = "doSave_end";
		
		GridObj1.save({
          	actionParam     : obj
         	,sendFlag        : "SELECTED"
         	,userGridData    : GridObj1.getEditingAllRowsData()
         	,completedEvent  : doSave_end
    	});
	    
    }
    		
	function doSave_end() {	
	 	opener.doSearch();
	 	doSearch();
	}

	function CheckValue(){
		GridObj1.getInstance().saveEditData();
		var selectedRows = GridObj1.getSelectedRowsData();
		var size         = selectedRows.length;
		
		//var selectedHead = GridObj1.currentRow();
		
		if(size <= 0 ){
			showAlert("${msgel.getMsg('selectSaveData','저장 할 데이타를 선택하십시오.')}",'WARN');
			return false;
		}
		
		for(i=0; i<size; i++){
			obj = selectedRows[i];
			if(obj.MAX_IN_V=="") {
				showAlert("MAX입력값을 입력하십시오.",'WARN');
				return false;
			}
		}
		return true;
	}

  function onlyNumber1(obj){
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
  
	/**
	 *  보고지표관리 상세
	 */
	function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, columnId, colId) {
		
		if(columnId == "JIPYO_IDX" ) {	//수정 팝업
			var form2 = document.form2;
		  	form2.RPT_GJDT.value 		= obj.RPT_GJDT;
			form2.JIPYO_IDX.value 		= obj.JIPYO_IDX;
			form2.JIPYO_FIX_YN.value	= obj.JIPYO_FIX_YN;
			form2.IN_V_TP_C.value 		= obj.IN_V_TP_C;
			form2.CNCT_JIPYO_C_I.value	= obj.CNCT_JIPYO_C_I;
			
			form2.pageID.value = "RBA_90_01_03_05";
			form2.target ="RBA_90_01_03_05";
			window_popup_open(form2.pageID.value, 800, 530, '');
			form2.action = "<c:url value='/'/>0001.do";
			form2.submit();
			
// 	    } else {	//상세 그리드 조회
// 		 	var selectData = GridObj1.currentRow();
// 		 	var JIPYO_IDX = selectData.JIPYO_IDX;	
	    }
	}
	
</script> 

<form name="form2" method="post">
	<input type="hidden" name="pageID" >
	<input type="hidden" name="classID" >
	<input type="hidden" name="methodID" >
	<input type="hidden" name="RPT_GJDT" >
	<input type="hidden" name="JIPYO_IDX" >
	<input type="hidden" name="IN_V_TP_C" >
	<input type="hidden" name="CNCT_JIPYO_C_I" >
	<input type="hidden" name="JIPYO_FIX_YN" id= "JIPYO_FIX_YN">
	<input type="hidden" name="JIPYO_VIEW" id ="JIPYO_VIEW" value="Y" >
</form>

<form name="form1" method="post" onkeydown="doEnterEvent('doSearch');">
	<input type="hidden" id="pageID" name="pageID">
	
	<div class="cond-box" id="condBox1">
		<div class="cond-row">
	         <div class="cond-item">
          		${condel.getLabel('RBA_90_01_01_02_001','보고기준일')}
				<input type="text" class="input_text" id="VIEW_RPT_GJDT" name="VIEW_RPT_GJDT" maxlength="11" style="width:80px;text-align:center;" disabled="disabled" value="${VIEW_RPT_GJDT}" />
				<input type="hidden" id="RPT_GJDT" name="RPT_GJDT">
			 </div>
             <div class="cond-item">
	         	${condel.getLabel('RBA_90_01_01_02_002','지표번호')}
	            ${condel.getInputCustomerNo('JIPYO_IDX')}
	         </div>
	         <div class="cond-item">
	         	${condel.getLabel('RBA_90_01_01_02_003','지표명')}
	         	${condel.getInputCustomerNo('JIPYO_NM')}
	         </div>         
		</div>
		<div class="cond-row">	
	        <div class="cond-item">
          		${condel.getLabel('RBA_90_01_01_02_004','위험구분')}
	          	<input type="text" class="input_text" id="JIPYO_C_NM" name="JIPYO_C_NM" maxlength="200" value="운영위험" style="width:80px;text-align:center;" disabled="disabled"/>
          		<input type="hidden" id="JIPYO_C" name="JIPYO_C">
			</div>
			<div class="cond-item">
				${condel.getLabel('RBA_90_01_01_02_007','평가구분')}
				<input type="text" class="input_text" id="VALT_G_NM" name="VALT_G_NM" value="상대비율평가" style="width:85px;text-align:center;" disabled="disabled" />
				<input type="hidden" id="VALT_G" name="VALT_G">
			</div>			  
		</div>
		<div class="cond-line"></div>
		<div class="cond-btn-row" style="text-align:right">
			<div class="panel-heading-button" style="margin-bottom: 5px;">
				${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')} 
				${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
				${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", closeBtn:"닫기", mode:"C", function:"self.close", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-close"}')}
     		</div>
    	</div> 
	</div>
	<div class="panel panel-primary">
	    <div class="panel-footer">
	        <div id="GTDataGrid1_Area"></div>
	    </div>
	    <div align="left" style="margin-top: 5px;">
	    	<font color=blue>※ 그리드 (MAX입력값)에 입력하시면 됩니다.</font>
   		</div>
   	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 