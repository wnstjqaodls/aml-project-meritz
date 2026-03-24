<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_05_01_06.jsp
* Description     : 위험수기평가 첨부파일 다운로드 팝업창
* Group           : GTONE
* Author          : CSH
* Since           : 2018. 6. 22.
********************************************************************************************************************************************
--%>
<%@page import="java.util.*"                                                        %>
<%@page import="com.gtone.aml.basic.jspeed.base.el.MsgEL"                           %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%
	DataObj output = (DataObj)request.getAttribute("output");
	String ATTCH_FILE_NO = Util.nvl(request.getParameter("ATTCH_FILE_NO"));
	
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

    // Initial function
    function init() { 
    	initPage(); 
    }
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
/*         GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_08_04_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(90vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : '교육계획및 현황관리'
           ,completedEvent  : function(){               
               }
        }); */
        
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 height	:"calc(90vh - 100px)",
			 elementAttr: { class: "grid-table-type" },
			 "allowColumnReordering": true
			   ,"allowColumnResizing"  : true
			   ,"cacheEnabled"         : false
			   ,"cellHintEnabled"      : true
			   ,"columnAutoWidth"      : true
			   ,"columnFixing" : {"enabled": true},
			   pager: {
			       visible: true,
			       showNavigationButtons: true,
			       showInfo: true
			   },
			   paging: {
			       enabled: true,
			       pageSize: 20
			   },
			   scrolling: {
			       mode: "standard",
			       preloadEnabled: false
			   },
			   "editing" : {
			        "mode"          : "batch"
			       ,"allowUpdating" : true
			       ,"allowAdding"   : true
			       ,"allowDeleting" : false
			    }
			   ,"export" : {
			        "allowExportSelectedData"   : true
			       ,"excelFilterEnabled"        : true
			       ,"fileName"                  : "교육계획및 현황관리"
			    }
			   ,"filterRow" : {"visible": false}
			   ,"hoverStateEnabled"     : true
			   ,"loadPanel"             : {"enabled": false}
			   ,"remoteOperations"      : {
			        "filtering" : false
			       ,"grouping"  : false
			       ,"paging"    : false
			       ,"sorting"   : false
			       ,"summary"   : false
			    }
			   ,"rowAlternationEnabled" : true
			   ,"searchPanel"           : {
			        "visible" : false
			       ,"width"   : 250
			    }
			   ,"selection"             : {
			        "allowSelectAll"    : true
			       ,"deferred"          : false
			       ,"mode"              : "single"   /*none, single, multiple*/
			       ,"selectAllMode"     : "allPages"
			       ,"showCheckBoxesMode": "always"  /*'onClick' | 'onLongTap' | 'always' | 'none'*/
			    }
			   ,"showBorders"           : true
			   ,"showColumnLines"       : true
			   ,"showRowLines"          : true
			   ,"sorting"               : {"mode": "multiple"}
			   ,"width"                 : "inherit"
			   ,"wordWrapEnabled"       : false
			   ,"columns" : [
			        {
			            "dataField": "SEQ",
			            "caption": '${msgel.getMsg("RBA_50_05_01_06_100","번호")}',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "fixed"       : true
			            
			        },{
			            "dataField": "EDU_SDT",
			            "caption": '${msgel.getMsg("RBA_50_08_04_02_002","교육시작일")}',
			            "cellTemplate" : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "cssClass": "link",
			            "fixed"       : true
			        },{
			            "dataField": "EDU_EDT",
			            "caption": '${msgel.getMsg("RBA_50_08_04_02_003","교육종료일")}',
			            "cellTemplate" : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            "alignment": "left",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "fixed"       : true
			        },{
			            "dataField": "EDU_DT",
			            "caption": '교육일자',
			            "cssClass": "link",
			            "cellTemplate" : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "SNO",
			            "caption": '순번',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "EDU_CHNL_G_NM",
			            "caption": '${msgel.getMsg("RBA_50_08_04_01_003","교육채널")}',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "EDU_CHNL_G_C",
			            "caption": '교육채널구분코드',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "EDU_MAIN_BRNO",
			            "caption": '교육주관부서',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "EDU_MAIN_BRNM",
			            "caption": '교육주관부서',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "EDU_TGT_G_NM",
			            "caption": '${msgel.getMsg("RBA_50_08_04_01_002","교육대상")}',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "EDU_TGT_G_C",
			            "caption": '교육대상구분코드',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "EDU_SUBJ_NM",
			            "caption": '${msgel.getMsg("RBA_50_08_04_01_004","교육과목명")}',
			            "alignment": "left",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "EDU_PGM_C",
			            "caption": '교육프로그램코드',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "EDU_HOUR",
			            "caption": '${msgel.getMsg("RBA_50_05_01_06_101","교육시간")}',
			            "alignment": "right",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "EDU_TGT_PCNT",
			            "caption": '${msgel.getMsg("RBA_50_05_01_06_102","계획인원")}',
			            "alignment": "right",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "FNSH_PCNT",
			            "caption": '${msgel.getMsg("RBA_50_05_01_06_103","이수인원")}',
			            "alignment": "right",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "ATTCH_FILE_NO",
			            "caption": '첨부파일',
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "ATTCH_FILE_YN",
			            "caption": '${msgel.getMsg("RBA_50_08_03_02_001","첨부파일")}',
			            "cssClass": "link",
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "DR_OP_JKW_NO",
			            "caption": '작성부서',
			            "alignment": "left",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "DR_OP_JKW_NO",
			            "caption": '작성자ID',
			            "alignment": "left",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "DR_OP_JKW_NM",
			            "caption": '작성자',
			            "alignment": "left",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "CHG_DT",
			            "caption": '${msgel.getMsg("RBA_50_05_01_106","변경일자")}',
			            "cellTemplate" : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
			            "alignment": "center",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "CHG_OP_JKW_NO",
			            "caption": '변경자ID',
			            "alignment": "center",
			            "dataType" : "string",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        },{
			            "dataField": "CHG_OP_JKW_NM",
			            "caption": '${msgel.getMsg("RBA_50_05_01_107","변경자")}',
			            "alignment": "center",
			            "dataType" : "string",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true
			        },{
			            "dataField": "EDU_JKW_NM",
			            "caption": '교육직원명',
			            "alignment": "center",
			            "dataType" : "string",
			            "allowResizing": true,
			            "allowSearch": true,
			            "allowSorting": true,
			            "visible": false
			        }
			    ]
			   ,"onCellClick" : function(e) {
			        if (e.data) {
			            clickGrid1Cell('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    }
       }).dxDataGrid("instance");
    }

    function doClose()
    {
        window.close();
    }

    //첨부파일 다운로드
    function downloadFile( FILE_SER )
    {
        $("input[name=FILE_SER]").val(FILE_SER);
        form1.target = "_self";
        form1.action = "Package/RBA/common/fileDown/fileDownload.jsp";
        form1.method = "post";  
        form1.submit();
    }    

</script>

<form name="form1" id="form1" method="post">
    <input type="hidden" name="pageID"          id="pageID"         />
    <input type="hidden" name="classID"         id="classID"        />
    <input type="hidden" name="methodID"        id="methodID"       />
    <input type="hidden" name="ATTCH_FILE_NO" value="${ATTCH_FILE_NO}" >
<div class="popup-cont-box" style="margin-top:1px;">
    <div class="table-box">
        <table>
        <tr>
            <td colspan="4">
							<table style="width:100%">
								<tr>
									<td width="100%" >
									<!------------------------------------------------------------>
										<table id="NotiAttachTable" style="width:100%; border:0; cellpadding:2; cellspacing:1; bgcolor:''" >
											<script language="javascript">

											</script> 
									        <tr>
									            <th height="22" align="center" style="width:45%">${msgel.getMsg('uploadFile','새로올릴 파일')}</th>
									        </tr>  
<%
   if(output.getCount("FILE_SER") != 0) {
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
           </tr>
<%
    	}
    }
%>

			</table>
		</td>
	</tr>
</table>
			</td>
        </tr>
        </table>
    </div>
</div>

<div class="popup-cont-box">
    <div class="cond-btn-row" style="text-align:right;margin-top:10px;">
        <span id ="sbtn_03" >
        </span>
        ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
    </div>
</div>
    <div class="panel panel-primary" style="display: none">
        <div class="panel-footer" >
            <div id="GTDataGrid1_Area"></div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" /> 