<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_05_09_01.jsp
- Author     : hikim
- Comment    : 자금세탁 사례관리
- Version    : 1.0
- history    : 1.0 2017-06-08
--%>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<script language="JavaScript">
    
    var GridObj1;
    var GridObj2;
    var overlay = new Overlay();
    
    // Initialize
    $(document).ready(function(){
        setupConditions();
        setupGrids();
        
        doSearch();
    });
    
    // 그리드 초기화 함수 셋업
    function setupGrids() {
    	
        // 그리드1(Code Head) 초기화
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
        	"width" 						: "100%",
    		"height"						:"calc(95vh - 200px)",
    		"hoverStateEnabled": true,
    		 "wordWrapEnabled": false,
    		 "allowColumnResizing": true,
    		 "columnAutoWidth": true,
    		 "allowColumnReordering": true,
    		 "cacheEnabled": false,
    		 "cellHintEnabled": true,
    		 "showBorders": true,
			 "onToolbarPreparing"	: makeToolbarButtonGrids,
    		 "showColumnLines": true,
    		 "showRowLines": true,
    		 "export":{
    		     "allowExportSelectedData": false,
    		     "enabled": false,
    		     "excelFilterEnabled": false,
    		     "fileName": "gridExport"
    		 },
    		 "sorting": {"mode": "multiple"},
    		 "remoteOperations":{
    		     "filtering": false,
    		     "grouping": false,
    		     "paging": false,
    		     "sorting": false,
    		     "summary": false
    		 },
    		 "editing":{
    		     "mode": "batch",
    		     "allowUpdating": false,
    		     "allowAdding": false,
    		     "allowDeleting": false
    		 },
    		 "filterRow": {"visible": false},
    		 "rowAlternationEnabled": false,
    		 "columnFixing": {"enabled": true},
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
    		 "searchPanel":{
    		     "visible": false,
    		     "width": 250
    		 },
    		 columns: [
    		        {
    		            dataField    : "BAS_YYYY",
    		            caption      : '기준연도',
    		            alignment    : "center",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "SNO",
    		            caption      : 'No',
    		            alignment    : "center",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            width        : 80,
    		            fixed        : false
    		        }, {
    		            caption: '자금세탁사례',
    		            columns: [
    		                {
    		                    dataField    : "SRC_TP_C_NM",
    		                    caption      : '출처유형',
    		                    alignment    : "left",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 100
    		                }, {
    		                    dataField    : "ML_EXP_TITE",
    		                    caption      : '제목',
    		                    cssClass     : "link",
    		                    alignment    : "left",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 200
    		                }
    		            ],
    		            fixed: false
    		        }, {
    		            dataField    : "RSK_CAUS_CTNT",
    		            caption      : '위험원인',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            width        : 300
    		        }, {
    		            caption: '국가',
    		            columns: [
    		                {
    		                    dataField    : "REL_NAT_RSK_TP_C_NM",
    		                    caption      : '관련국가위험유형',
    		                    alignment    : "center",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 120
    		                }
    		            ]
    		        }, {
    		            caption: '고객',
    		            columns: [
    		                {
    		                    dataField    : "CUST_OCP_G_C_NM",
    		                    caption      : '직업구분',
    		                    alignment    : "center",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 100
    		                }, {
    		                    dataField    : "CUST_UPSL_G_C_NM",
    		                    caption      : '업종구분',
    		                    alignment    : "center",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 100
    		                }, {
    		                    dataField    : "CUST_INDV_PCUL_C_NM",
    		                    caption      : '고객특성(개인)',
    		                    alignment    : "center",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 100
    		                }, {
    		                    dataField    : "CUST_CORP_PCUL_C_NM",
    		                    caption      : '고객특성(법인)',
    		                    alignment    : "center",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 120
    		                }
    		            ]
    		        }, {
    		            dataField    : "PROD_TRN_PCUL_C_NM",
    		            caption      : '상품 및 서비스(거래특성)',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            width        : 150
    		        }, {
    		            caption: '채널',
    		            columns: [
    		                {
    		                    dataField    : "ENTR_CHNL_INSU_C_NM",
    		                    caption      : '가입채널',
    		                    alignment    : "center",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 100
    		                }
    		                /* {
    		                    dataField    : "ENTR_CHNL_LN_C_NM",
    		                    caption      : '가입채널(여신)',
    		                    alignment    : "center",
    		                    allowResizing: true,
    		                    allowSearch  : true,
    		                    allowSorting : true,
    		                    width        : 100
    		                }*/
    		            ]
    		        }, {
    		            dataField    : "REL_F_CRIM_C_NM",
    		            caption      : '관련전제범죄',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            width        : 110
    		        }, {
    		            dataField    : "SSPS_TRN_TP_C_NM",
    		            caption      : '의심거래유형',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            width        : 160
    		        }, {
    		            dataField    : "SRC_TP_C",
    		            caption      : '출처유형코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "SRC_DTL_INFO",
    		            caption      : '출처상세',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "ML_EXP_CTNT",
    		            caption      : '자금세탁사례내용',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "REL_NAT_NM",
    		            caption      : '관련국가명',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "REL_NAT_RSK_TP_C",
    		            caption      : '관련국가유형코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "CUST_DWL_TP_C",
    		            caption      : '주거유형코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "CUST_ASS_SCAL_C",
    		            caption      : '고객자산규모코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "CUST_OCP_G_C",
    		            caption      : '직업코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "CUST_UPSL_G_C",
    		            caption      : '업종코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "CUST_INDV_PCUL_C",
    		            caption      : '고객특성(개인)',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "CUST_CORP_PCUL_C",
    		            caption      : '고객특성(법인)',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "CUST_RELR_TP_C",
    		            caption      : '관련자유형',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "PROD_LN_C",
    		            caption      : '상품여신코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "PROD_INSU_C",
    		            caption      : '상품보험코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "PROD_INV_C",
    		            caption      : '상품투자코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "PROD_RDAMT_G_C",
    		            caption      : '상품입출금구분코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "PROD_TRN_SCAL",
    		            caption      : '상품거래규모',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "PROD_TRN_PCUL_C",
    		            caption      : '상품거래특성코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "ENTR_CHNL_INSU_C",
    		            caption      : '가입채널보험코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "ENTR_CHNL_LN_C",
    		            caption      : '가입채널여신코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "PAY_CHNL_C",
    		            caption      : '납입채널코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "REL_F_CRIM_C",
    		            caption      : '관련전제범죄코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "REL_FNCO_C",
    		            caption      : '관련금융회사코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "SSPS_TRN_TP_C",
    		            caption      : '의심거래유형코드',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            visible      : false
    		        }, {
    		            dataField    : "DR_DT",
    		            caption      : '등록일자',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            width        : 100
    		        }, {
    		            dataField    : "CHG_DT",
    		            caption      : '수정일자',
    		            alignment    : "left",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true,
    		            width        : 100
    		        }
    		    ],
    		    summary: {
    		        totalItems: [
    		            {
    		                column     : "SNO",
    		                summaryType: "count"
    		            }
    		        ]
    		    },
    		    onCellClick: function(e){
    		        if(e.data){
    		            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    		        }
    		    }
        }).dxDataGrid("instance");
        
        
    	GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
        	elementAttr: { class: "grid-table-type" },
        	"width" 						: "100%",
    		"height"						:"calc(95vh - 250px)",
    		"hoverStateEnabled": true,
    		 "wordWrapEnabled": false,
    		 "allowColumnResizing": true,
    		 "columnAutoWidth": true,
    		 "allowColumnReordering": true,
    		 "cacheEnabled": false,
    		 "cellHintEnabled": true,
    		 "showBorders": true,
			 "onToolbarPreparing"	: makeToolbarButtonGrids,
    		 "showColumnLines": true,
    		 "showRowLines": true,
    		 "export":{
    		     "allowExportSelectedData": false,
    		     "enabled": false,
    		     "excelFilterEnabled": false,
    		     "fileName": "gridExport"
    		 },
    		 "sorting": {"mode": "multiple"},
    		 "remoteOperations":{
    		     "filtering": false,
    		     "grouping": false,
    		     "paging": false,
    		     "sorting": false,
    		     "summary": false
    		 },
    		 "editing":{
    		     "mode": "batch",
    		     "allowUpdating": false,
    		     "allowAdding": false,
    		     "allowDeleting": false
    		 },
    		 "filterRow": {"visible": false},
    		 "rowAlternationEnabled": false,
    		 "columnFixing": {"enabled": true},
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
    		 "searchPanel":{
    		     "visible": false,
    		     "width": 250
    		 },
    		 "selection":{
    		     "allowSelectAll": true,
    		     "deferred": false,
    		     "mode": "multiple",
    		     "selectAllMode": "allPages",
    		     "showCheckBoxesMode": "always"
    		 },
    		 columns: [
    		        {
    		            dataField    : "BAS_YYYY",
    		            caption      : '기준연도',
    		            alignment    : "center",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true
    		        }, {
    		            dataField    : "SCHD_FIX_YN",
    		            caption      : '확정여부',
    		            alignment    : "center",
    		            allowResizing: true,
    		            allowSearch  : true,
    		            allowSorting : true
    		        }
    		    ],
    		    summary: {
    		        totalItems: [
    		            {
    		                column     : "SNO",
    		                summaryType: "count"
    		            }
    		        ]
    		    },
    		    onCellClick: function(e){
    		        if(e.data){
    		            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
    		        }
    		    }
        }).dxDataGrid("instance");
    }
    
    // 검색조건 셋업
    function setupConditions() {
        $('#BAS_YYYY').css("width","60%")
    	try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,true);
            cbox1.setItemWidths(280, 90, 0);
            cbox1.setItemWidths(300, 90, 1);
            cbox1.setItemWidths(100, 70, 2);
        } catch (e) {
            alert(e.message);
        }
    }
    
    //그리드 클릭 이벤트
    function Grid1CellClick(id, obj, selectData, rowIdx, colIdx, colId) {
        
        if(colId == "ML_EXP_TITE"){
            
            form2.P_GUBN.value     = "1";                            //구분:0 등록 1:수정
            form2.P_SNO.value      = obj.SNO;                        //순번
            form2.P_BAS_YYYY.value = form.BAS_YYMM.value;            //기준년도
            form2.P_FIXYN.value    = form.fixyn.value == "Y" ? "1" : "0"; //확정여부
            form2.pageID.value     = "RBA_50_05_09_02";
            var win;           win = window_popup_open(form2.pageID.value, 1250, 975, '','no');
            form2.target           = form2.pageID.value;
            form2.action           = '<c:url value="/"/>0001.do';
            form2.submit();
        }
    }
    
    function setupFilter1(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	setupGridFilter2(gridArrs, FLAG);
    }
    
    function setupFilter2(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid2_Area";
    	gridArrs[0] = gridObj;
    	setupGridFilter2(gridArrs, FLAG);
    }
    
    /** 툴바 버튼 설정 */
    function makeToolbarButtonGrids(e)
    {
        var useYN  = "${outputAuth.USE_YN  }";  // 사용 유무
        var authC  = "${outputAuth.C       }";  // 추가,수정 권한
        var authD  = "${outputAuth.D       }";  // 삭제 권한
        if (useYN=="Y") {
            var gridID       = e.element.attr("id");    // 그리드 아이디
            var toolbarItems = e.toolbarOptions.items;

            toolbarItems.splice(0, 0, {
                "locateInMenu"  : "auto"
                ,"location"     : "after"
                ,"widget"       : "dxButton"
                ,"name"         : "filterButton"
                ,"showText"     : "inMenu"
                ,"options"      : {
                         "icon"      : ""
                       	,"elementAttr": { class: "btn-28 filter" }
            			,"text"      : ""
                        ,"hint"      : '필터'
                        ,"disabled"  : false
                        ,"onClick"   : gridID=="GTDataGrid1_Area"?setupFilter1:setupFilter2
                 }
            });
        }
    }
    
    //자금세탁 사례관리 조회 
    function doSearch() {
        
        overlay.show(true, true);
        
        var params = new Object();
        var classID  = "RBA_50_05_09_01";
        var methodID = "doSearch";
        
		params.pageID 	= "RBA_50_05_09_01"; 
		params.REL_CRIME = form.relCrime.value;
		params.SUS_RTAN_CATE = form.susTranCate.value;
		params.SRC_TP_C = form.SRC_TP_C.value;
		params.BAS_YYMM = form.BAS_YYMM.value;
		
		sendService(classID, methodID, params, doSearch_end, doSearch_end);

    }
    
    //자금세탁 사례관리 조회 end
    function doSearch_end(gridData, data) {
        overlay.hide();
        GridObj1.refresh();
    	GridObj1.option("dataSource", gridData);
    	
    	doSearch2();
    }
    
    //20171013 자금세탁 사례관리 확정여부조회
    function doSearch2() {
        
        var params = new Object();
        var classID  = "RBA_50_05_09_01";
        var methodID = "doSearch2";
        
		params.pageID 	= "RBA_50_05_09_01"; 
		params.BAS_YYYY = form.BAS_YYMM.value;
		
		sendService(classID, methodID, params, doSearch2_end, doSearch2_end);
        
    }
    
    //20171013 자금세탁 사례관리 확정여부조회 end
    function doSearch2_end(gridData, data) {

		const row = gridData && gridData.length ? gridData[0] : null;
		const v = row ? (row.SCHD_FIX_YN ?? row.SCHD_FIX_YN) : null;
		
		form.fixyn.value = (String(v) === "0")? "N" : (v ==null ? "" : "Y");
    }
    
    // 자금세탁 사례 확정
    function doConfirm() {
        
        if($("button[id='btn_03']") == null) return;
        
        var confirmState = "";
        
        if(form.fixyn.value == "N"){
            confirmState = "1";
            showConfirm("${msgel.getMsg('RBA_50_01_01_006','확정을 하시겠습니까?')}", "확정",function(){
            	var classID  = "RBA_50_05_09_01";
                var methodID = "doConfirm";
                var params   = new Object();
                params.pageID 	= "RBA_50_05_09_01";
                params.BAS_YYYY = form.BAS_YYMM.value;
                params.SCHD_FIX_YN = confirmState;

                sendService(classID, methodID, params, doConfirm_end, doConfirm_end);
      		});
        }else{
            confirmState = "0";
            showConfirm("${msgel.getMsg('RBA_50_01_01_007','확정을 취소하시겠습니까?')}", "확정",function(){
            	var classID  = "RBA_50_05_09_01";
                var methodID = "doConfirm";
                var params   = new Object();
                params.pageID 	= "RBA_50_05_09_01";
                params.BAS_YYYY = form.BAS_YYMM.value;
                params.SCHD_FIX_YN = confirmState;

                sendService(classID, methodID, params, doConfirm_end, doConfirm_end);
      		});

        }
        
// 		var classID  = "RBA_50_05_09_01";
//         var methodID = "doConfirm";
//         var params   = new Object();
//         params.pageID 	= "RBA_50_05_09_01";
//         params.BAS_YYYY = form.BAS_YYMM.value;
//         params.SCHD_FIX_YN = confirmState;

//         sendService(classID, methodID, params, doConfirm_end, doConfirm_end);
    }
    
    // 자금세탁 사례 확정 end
    function doConfirm_end() {
        doSearch();
    }
    
    // 자금세탁 사례 등록 팝업 호출
    function doRegister() {
        if(form.fixyn.value == "Y"){
    		showAlert('${msgel.getMsg("RBA_50_05_09_01_006","사례가 확정이 된 상태에서 등록이 불가능합니다.")}','WARN');

            return;
        }
        form2.P_GUBN.value     = "0";                 //구분:0 등록 1:수정
        form2.P_BAS_YYYY.value = form.BAS_YYMM.value;            //기준년도
        form2.P_SNO.value      = 0;                   //20171013 변경 GridObj1.getRow(0).SNO -> 0
        form2.pageID.value     = "RBA_50_05_09_02";
        var win;           win = window_popup_open(form2.pageID.value,  1010, 665, '','no');
        form2.target           = form2.pageID.value;
        form2.action           = '<c:url value="/"/>0001.do';
        form2.submit();
    }
    
</script>
<style>
	.inquiry-table .table-cell .title {
	    min-width: 170px;
	}
</style>
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
    <input type="hidden" name="NEXT_SNO" >
    <input type="hidden" name="P_GUBN" >
    <!-- 기존 값 조회시 Parameter를 넘긴다 -->
    <input type="hidden" name="P_BAS_YYYY" >
    <input type="hidden" name="P_SNO" >
    <input type="hidden" name="P_FIXYN" >
</form>
<form name="form">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID">
    <div class="inquiry-table type4">
		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel("RBA_30_07_01_02_001","기준연도")}
<%--                 ${RBACondEL.getKRBASelect('BAS_YYMM','' ,'RBA_common_getComboData_BasYear' ,'' ,'' ,'' ,'doSearch()','','','')} --%>
                ${RBACondEL.getKRBASelect('BAS_YYMM','' ,'RBA_common_getComboData_BasYear_SARE' ,'' ,'' ,'' ,'doSearch()','','','ALL')}
			</div>
			<div class="table-cell">
				${condel.getLabel("RBA_50_05_09_01_002","출처유형")}
                ${RBACondEL.getKRBASelect('SRC_TP_C','' ,'' ,'R311' ,'' ,'ALL' ,'doSearch()','','','')}
            </div>
        </div>
		<div class="table-row">
			<div class="table-cell">
                ${condel.getLabel("RBA_50_05_09_01_004","관련전제범죄")}
                ${RBACondEL.getKRBASelect('relCrime','150px' ,'' ,'R317' ,'' ,'ALL' ,'doSearch()','','','')}
            </div>
			<div class="table-cell">
                ${condel.getLabel("RBA_50_05_09_01_005","의심거래유형")}
                ${RBACondEL.getKRBASelect('susTranCate','150px' ,'' ,'R319' ,'' ,'ALL' ,'doSearch()','','','')}
            </div>
        </div>
        <div class="table-row">
	        <div class="table-cell">
                ${condel.getLabel("RBA_50_05_09_01_003","확정여부")}
                <div class="content">
                	<input type="text" name= "fixyn" size="1" class="cond-input-text" readonly="readonly" />
                </div>
            </div>
	        <div class="table-cell"></div>
        </div>
        
    </div>
		<div class="button-area">
   			${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"RBA004", defaultValue:"등록", mode:"R", function:"doRegister", cssClass:"btn-36"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"RBA001", defaultValue:"확정/취소", mode:"R", function:"doConfirm", cssClass:"btn-36"}')}
        </div>
    <div class="tab-content-bottom" style="padding-top: 8px;">
		<div id="GTDataGrid1_Area"></div>
<!--         <div style="margin-top: 10px;"> -->
<!--             <font style="margin-top: 10px; color: blue;">※확정이 된 이후에는 수정 및 등록이 불가능합니다. 확정 취소 이후에 수정 및 등록을 해주세요.</font> -->
<!--         </div> -->
	</div>
    <div class="tab-content-bottom" style="padding-top: 8px;">
            <div id="GTDataGrid1_Area"></div>
    </div>
    <div class="tab-content-bottom"  style="display: none">
            <div id="GTDataGrid2_Area"></div>
    </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />