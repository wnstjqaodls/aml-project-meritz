<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
- File Name  : RBA_99_02_01_01.jsp
- Author     : mjh
- Comment    : 임직원별 교육/연수 실적관리
- Version    : 1.0
- history    : 1.0 2025-03-06
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ page import="java.text.DateFormat"  %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp"%>
<%
	
	// 날짜
	String stDate = Util.nvl(request.getParameter("stDate"));
	String edDate = Util.nvl(request.getParameter("edDate"));
    
	Calendar today = Calendar.getInstance();
    Calendar lastHalfYearEnd = Calendar.getInstance();
    
    if (today.get(Calendar.MONTH) < 6) {
        lastHalfYearEnd.set(today.get(Calendar.YEAR) - 1, Calendar.DECEMBER, 31);
    } else {
        lastHalfYearEnd.set(today.get(Calendar.YEAR), Calendar.JUNE, 30);
    }
    
    Calendar startDate = (Calendar) lastHalfYearEnd.clone();
    startDate.add(Calendar.YEAR, -1);
    
    DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
    String preStartDateStr = DateUtil.addDays(dateFormat.format(startDate.getTime()), 1, "yyyyMMdd");
    String preEndDateStr = dateFormat.format(lastHalfYearEnd.getTime());


	if(("").equals(stDate)) { stDate = DateUtil.addDays(DateUtil.getDateString(), -365, "yyyy-MM-dd"); }
	if(("").equals(edDate)) { edDate = DateUtil.addDays(DateUtil.getDateString(), 0, "yyyy-MM-dd"); }
	
	request.setAttribute("stDate", stDate); 
	request.setAttribute("edDate", edDate);
	request.setAttribute("preStartDateStr", preStartDateStr);
	request.setAttribute("preEndDateStr", preEndDateStr);
%>
<script language="JavaScript">
	var overlay = new Overlay();  
    var GridObj1 = null;
    var pageID = "RBA_99_02_01_01";
    var classID = "RBA_99_02_01_01";
    
    $(document).ready(function(){
    	 setupGrids();
         setupFilter("init");
         
//          $("#edDate").on('change', function(){
//         	 doChangeStDate();
//          });
    });
    
 	// c-util.js 에서 여기을 호출 할 수 도 있음.
    function doChangeStDate() {    	
    	var edDate = getDxDateVal("edDate", true);   	
    	var stDate = new Date(getDateFormat(edDate, '-'));
    	var strStDate = stDate.setFullYear(stDate.getFullYear() - 1);
    	stDate = new Date(strStDate);
    	var y = stDate.getFullYear();
    	var m = stDate.getMonth() + 1 ;
    	var d = stDate.getDate();
    	if (m < 10)  {
    		m = '0' + m
    	}
    	setDxDateVal("stDate", y+'-'+m+'-'+d);		
    }
 	
    function setupGrids(){
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
            elementAttr                 : { class: "grid-table-type" },
            height                      : "calc(90vh - 250px)",
            gridId          			: "GTDataGrid01",	
            allowColumnReordering       : true,
            allowColumnResizing         : true,
            cacheEnabled                : false,
            cellHintEnabled             : true,
            columnAutoWidth             : true,
            columnFixing                : { enabled : true},
            editing                     :                  
            {
            	allowAdding             : false,
            	allowDeleting           : false,
            	allowUpdating           : false
            },
            filterRow                   : { visible : false },
            hoverStateEnabled           : true,
            loadPanel                   : { enabled : false },
            
            onToolbarPreparing          : makeToolbarButtonGrids,
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
            remoteOperations            :
            {
                filtering               : false,
                grouping                : false,
                paging                  : false,
                sorting                 : false,
                summary                 : false
            },
            rowAlternationEnabled       : true,
            selection                   :
            {
                allowSelectAll          : false,
                deferred                : false,
                mode                    : "single",
                selectAllMode           : "allPages",
                showCheckBoxesMode      : "always"
            },
            showBorders                 : true,
            showColumnLines             : true,
            showRowLines                : true,
            sorting                     : { mode : "multiple" },
            wordWrapEnabled             : false,           
            export 					: {allowExportSelectedData : false ,enabled : false ,excelFilterEnabled : false},
    	    onExporting: function (e) {
    	    	var workbook = new ExcelJS.Workbook();
    	    	var worksheet = workbook.addWorksheet("Sheet1");
    		    DevExpress.excelExporter.exportDataGrid({
    		        component: e.component,
    		        worksheet: worksheet,
    		        autoFilterEnabled: true,
    		    }).then(function(){
    		        workbook.xlsx.writeBuffer().then(function(buffer){
    		            saveAs(new Blob([buffer], { type: "application/octet-stream" }), "${pageTitle}.xlsx");
    		        });
    		    });
    		    e.cancel = true;
            },
            columns                     :                  
                [{
                     "dataField"         : "CNT",
                     "caption"           : 'No.',
                     "dataType"			 : "number",
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                      
                 },
                 {
                     "dataField"         : "EDU_ID",
                     "caption"           : '교육ID',
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false,
                     visible			: false
                 },
                 {
                     "dataField"         : "DPRT_NM",
                     "caption"           : '${msgel.getMsg("RBA_90_01_01_03_115","소속 부점")}',
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                 },
                {
                     "dataField"         : "JKW_NO",
                     "caption"           : '${msgel.getMsg("RBA_90_01_01_03_116","직원번호")}',
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                      "allowEditing"     : false
                 },
                 {
                     "dataField"         : "JKW_NM",
                     "caption"           : '${msgel.getMsg("RBA_90_01_01_03_117","직원명")}',
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                 },
                 {
                     "dataField"         : "EDU_TGT",
                     "caption"           : '${msgel.getMsg("RBA_90_01_01_03_108","교육 대상")}',
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                 },
                 {
                     "dataField"         : "EDU_NM",
                     "caption"           : '${msgel.getMsg("RBA_90_01_01_03_103","교육 과정명")}',
                     "alignment"         : "left",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                 },
                 {
                     "dataField"         : "ING_YN",
                     "caption"           : '${msgel.getMsg("RBA_90_01_01_03_118","이수 여부")}',
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                 },
                 {
                     "dataField"         : "EDU_SUM_HH",
                     "caption"           : '${msgel.getMsg("RBA_99_02_01_01_001","합산 교육 시간")}',
                     "dataType"			 : "number",
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                 },
                 {
                     "dataField"         : "EDU_START_DT",
                     "caption"           : '${msgel.getMsg("RBA_90_01_01_03_104","교육 시작일")}',
                     "cellTemplate"      : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                 },
                 {
                     "dataField"         : "EDU_END_DT",
                     "caption"           : '${msgel.getMsg("RBA_90_01_01_03_105","교육 종료일")}',
                     "cellTemplate"      : function(cellElement,cellInfo){ cellElement.text(displayGTDataGridDate(cellInfo.text)); },
                     "alignment"         : "center",
                     "allowResizing"     : true,
                     "allowSearch"       : true,
                     "allowSorting"      : true,
                     "allowEditing"     : false
                 }
             ]
             ,onInitialized : function(e) {
          	 	  doSearch();
             }, "onCellClick" : function(e) { }
        }).dxDataGrid("instance");
    }
     
    function setupFilter(FLAG){
        var gridArrs = new Array();
        var gridObj = new Object();
        gridObj.gridID = "GTDataGrid1_Area";
        gridObj.title  = "";
        gridArrs[0] = gridObj;
        
        setupGridFilter2(gridArrs, FLAG);    
    }
    
    function makeToolbarButtonGrids(e){
        var cmpnt; cmpnt = e.component;
        var useYN = "${ outputAuth.USE_YN }";  // 사용 유무
        var authC = "${ outputAuth.C      }";  // 추가,수정 권한
        var authD = "${ outputAuth.D      }";  // 삭제 권한
        if (useYN == "Y") {
            var gridID       = e.element.attr("id");    // 그리드 아이디
            var toolbarItems = e.toolbarOptions.items;
            toolbarItems.splice(0, 0, {
                locateInMenu    : "auto",
                location        : "after",
                widget          : "dxButton",
                name            : "filterButton",
                showText        : "inMenu",
                options         : {
                    icon        : "" ,
                    elementAttr : { class : "btn-28 filter" },
                    text        : "",
                    hint        : "필터",
                    disabled    : false,
                    onClick     : function(){
                        setupFilter();
                    }
                }
            });
        }
    }
    
    function doSearch(){
    	
    	if(!fromToDateChechk("stDate", "edDate"))return;
    	
        var params = new Object();
		var methodID = "doSearch";
		
		overlay.show(true, true);
		params.pageID =pageID;
		
		params.branchCode = $("input[name=branchCode]","form[name=form1]").val();
		params.stDate = getDxDateVal("stDate",true);
		params.edDate = getDxDateVal("edDate",true);
		
		/* 
		소속부점 branchCode
		교육일자 
		교육과정명 EDU_NM
		교육대상 EDU_TGT_CCD
		직원명 JKW_NM 
		직원번호 JKW_NO
		이수여부 ING_YN
		*/
		params.EDU_NM = $("#EDU_NM","form[name=form1]").val();	//교육과정명
		params.EDU_TGT_CCD = $("#EDU_TGT_CCD", "form[name=form1]").val();	//교육대상
		params.JKW_NO = $("#JKW_NO","form[name=form1]").val().replace('-','');	//직원번호
		params.JKW_NM = $("#JKW_NM","form[name=form1]").val();	//직원명
		params.ING_YN		 = $("#ING_YN").val();	//이수여부
		
		sendService(classID, methodID, params, doSearch_success, doSearch_fail);
		
    }
    
    /*Search Success CallBack*/	
    function doSearch_success(gridData, data)
    {
        GridObj1.refresh();
        GridObj1.option("dataSource", gridData);
		
        overlay.hide();
    }
    /*Search Fail CallBack*/
	function doSearch_fail(){
		overlay.hide();
	}
    
    function preYearFunction() {
    	if ( $("#preYear")[0].checked)	{	//직전 1년
    		setDxDateVal("stDate", "${preStartDateStr}");
    		setDxDateVal("edDate", "${preEndDateStr}");
    	}
    	else {
    		setDxDateVal("stDate", "${stDate}");
    		setDxDateVal("edDate", "${edDate}");
    	}
    	doSearch();
    }
    
    function enterKeyPress() {
        if(event.keyCode == 13) {
        	doSearch();
        }
    }   
    
</script>
<form name="form2" id="form2" method="post">
	<input type="hidden" name="pageID">
	<input type="hidden" name="classID">
	<input type="hidden" name="methodID"> 
	<input type="hidden" name="EDU_ID" id="EDU_ID"  >
 
</form>

<form name="form1" id="form1" method="post" onkeydown="enterKeyPress();">
    <input type="hidden" name="pageID"   id = "pageID"  >
    <input type="hidden" name="manualID"   id = "manualID"  >
    <input type="hidden" name="classID"  id = "classID" >
    <input type="hidden" name="methodID" id = "methodID">

	<div class="inquiry-table">
		<div class="table-row">
			<div class="table-cell">
                ${condel.getBranchSearch('{msgID:"AML_00_00_01_01_013", defaultValue:"지점", name:"branchCode", firstComboWord:"ALL"}')}
        	</div>
			<div class="table-cell">
				${condel.getSelect('RBA_90_01_01_03_108', '교육 대상','EDU_TGT_CCD','200','','A403','','ALL','ALL')}
			</div>
		</div>
		<div class="table-row">
			<div class="table-cell">
				<div class="title">
					<div class="txt">${msgel.getMsg('RBA_90_01_01_03_103','교육 과정명')}</div>
				</div>
				<div class="content">
	                <input type="text" id="EDU_NM" name="EDU_NM" size="20" maxlength="30">
				</div>
			</div>
			<div class="table-cell">
				<div class="title">
					<div class="txt">${msgel.getMsg('RBA_90_01_01_03_117','직원명')}</div>
				</div>
				<div class="content">
					<input type="text" id="JKW_NM" name="JKW_NM" size="20" maxlength="30">
				</div>
			</div>
		</div>
		<div class="table-row">
			<div class="table-cell">
	            <div class="title">
	                <div class="txt">${msgel.getMsg('RBA_99_01_01_01_003','교육 일자')}</div>
	            </div>
	            <div class="content">
					<div class='calendar'>
	                    ${condel.getInputDateDx('stDate', stDate)}~${condel.getInputDateDx('edDate', edDate)}
	                </div>
	            </div>
			</div>
			<div class="table-cell">
				<div class="title">
					<div class="txt">${msgel.getMsg('RBA_90_01_01_03_116','직원번호')}</div>
				</div>
				<div class="content">
					<input type="text" id="JKW_NO" name="JKW_NO" size="20" maxlength="30">
				</div>
			</div>
		</div>
		<div class="table-row">
			<div class="table-cell">
				<div class="all">
                	<input type="checkbox" id="preYear" name="preYear" value="" onclick="preYearFunction()">
	        		<label for="preYear">${msgel.getMsg('RBA_99_02_01_01_002','전반기말 기준 직전 1년')}</label>
                </div>
			</div>
			<div class="table-cell">
				<div class="title">
					<div class="txt">${msgel.getMsg('RBA_90_01_01_03_118','이수 여부')}</div>
				</div>
				<div class="content">
		          	<select name='ING_YN' id='ING_YN' class="dropdown">
			           <option class="dropdown-option" value='ALL' selected>::${msgel.getMsg('AML_10_05_01_01_015','전체')}::</option>
			           <option class="dropdown-option" value='Y' >${msgel.getMsg('AML_10_03_01_01_014','Y')}</option> 
			           <option class="dropdown-option" value='N' >${msgel.getMsg('AML_10_03_01_01_013','N')}</option>
		       		</select>
		          </div>
			</div>
		</div>
	</div>
	
	<div class="button-area">
	    ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
	</div>
	
	<div id="GTDataGrid1_Area" style="margin-top: 8px;"></div>
	
	<table class="basic-table" style="width:100%; margin-top:8px; margin-bottom:0px;">
		<tr>
			<td>
				※ ${msgel.getMsg('RBA_99_01_01_01_029','교육 대상별 연간* 필수 이수 시간: 전담부서 및 감사부서 12시간, 그 외 대상 6시간(이수 시간 미충족 시 KoFIU 운영위험 지표 실적 미인정)')}<br>
				※ ${msgel.getMsg('RBA_99_01_01_01_030','KoFIU 운영위험 지표 보고 시점의')} <u>${msgel.getMsg('RBA_99_01_01_01_031','전반기말 기준 직전 1년 간을')}</u> ${msgel.getMsg('RBA_99_01_01_01_032','대상으로 함')}<br>
				※ ${msgel.getMsg('RBA_99_01_01_01_033','제도이행평가 관련지표 : (O.12.02.01)이사회 교육 실적, (O.12.02.02)경영진 교육 실적, (O.12.02.03)직원 교육 실적')}<br>
	        </td>
		</tr>
	</table>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />
</body>