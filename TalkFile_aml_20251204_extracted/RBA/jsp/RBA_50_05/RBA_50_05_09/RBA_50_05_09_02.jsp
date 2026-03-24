<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%> 

<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 자금세탁 사례관리-상세팝업
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 김현일
* Since           : 2017. 6. 8.
********************************************************************************************************************************************
* Modifier        : 박상훈
* Update          : 2018. 4. 25.
* Alteration      : AML() 함수제거, 코드정리
********************************************************************************************************************************************
--%>
<%
	String BAS_YYYY = request.getParameter("P_BAS_YYYY");
	String GUBN = request.getParameter("P_GUBN");
	String FIX_YN = request.getParameter("P_FIXYN");
	String SNO = "";
	//20171013 수정 request.getParameter("NEXT_SNO") -> ""
	if (!"0".equals(GUBN)) {
		SNO = request.getParameter("P_SNO");
	}

	request.setAttribute("BAS_YYYY", BAS_YYYY);
	request.setAttribute("GUBN", GUBN);
	request.setAttribute("SNO", SNO);
	request.setAttribute("FIX_YN", FIX_YN);
%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true"/> 

<script>
	var GridObj1;
	var classID = "RBA_50_05_09_01";

	var overlay = new Overlay();

	// Initialize
	$(document).ready(function() {
		$('.popup-contents').css({overflow : "auto"});
		setupGrids();
		
	});

	// Initial function
	function init() {initPage();}

	// 그리드 초기화 함수 셋업
	function setupGrids() {
    	
        // 그리드1(Code Head) 초기화
    	GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
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
// 			 "onToolbarPreparing"	: makeToolbarButtonGrids,
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
    		    },
        }).dxDataGrid("instance");
    	if ("${GUBN}" != "0") { //구분이 0이면 등록 아니면 수정
				doSearch();
		}
    }

	//자금세탁 사례관리 조회
	function doSearch() {
		//확정상태에서 조회시 저장및 삭제 버튼 사라짐
		if ("${FIX_YN}" == 1) {
			$('#btn_01').hide();
			$('#btn_02').hide();
		}
		
		var classID = "RBA_50_05_09_01"; 
		var methodID = "doSearch"; 
		var obj = new Object();
		obj.SNO = "${SNO}"; 
		obj.BAS_YYMM = "${BAS_YYYY}"; 
// 		obj.BAS_YYMM = "2018"; 
		console.log(obj.BAS_YYMM);
		
		sendService(classID, methodID, obj, doSearch_end, doSearch_end);

	}

	//자금세탁 사례관리 조회 end
	function doSearch_end(gridData, data) {
		setData(gridData[0]);
		
	}

	//자금세탁 사례관리 HTML에 데이타 삽입
	function setData(selObj) {
		form.SRC_TP_C.value = (selObj.SRC_TP_C == undefined) ? "": selObj.SRC_TP_C;  //출처유형
		form.SRC_DTL_INFO.value = (selObj.SRC_DTL_INFO == undefined) ? "": selObj.SRC_DTL_INFO; //출처상세
		form.ML_EXP_TITE.value = (selObj.ML_EXP_TITE == undefined) ? "": selObj.ML_EXP_TITE;    //제목
		form.ML_EXP_CTNT.value = (selObj.ML_EXP_CTNT == undefined) ? "": selObj.ML_EXP_CTNT;    //내용
		form.RSK_CAUS_CTNT.value = (selObj.RSK_CAUS_CTNT == undefined) ? "": selObj.RSK_CAUS_CTNT;//위험원인
		form.REL_NAT_NM.value = (selObj.REL_NAT_NM == undefined) ? "": selObj.REL_NAT_NM;        //관련국가명
		form.REL_NAT_RSK_TP_C.value = (selObj.REL_NAT_RSK_TP_C == undefined) ? "": '01' + selObj.REL_NAT_RSK_TP_C;//관련국가 위험유형
		form.CUST_DWL_TP_C.value = (selObj.CUST_DWL_TP_C == undefined) ? "": '01' + selObj.CUST_DWL_TP_C;  //주거유형
		form.CUST_ASS_SCAL_C.value = (selObj.CUST_ASS_SCAL_C == undefined) ? "": '02' + selObj.CUST_ASS_SCAL_C;//자산규모
		/* form.CUST_OCP_G_C.value = (selObj.CUST_OCP_G_C == undefined) ? "": '03' + selObj.CUST_OCP_G_C; */
		form.CUST_UPSL_G_C.value = (selObj.CUST_UPSL_G_C == undefined) ? "": '03' + selObj.CUST_UPSL_G_C;  //업종구분
		form.CUST_INDV_PCUL_C.value = (selObj.CUST_INDV_PCUL_C == undefined) ? "": '04' + selObj.CUST_INDV_PCUL_C;//개인특성	
		form.CUST_CORP_PCUL_C.value = (selObj.CUST_CORP_PCUL_C == undefined) ? "": '05' + selObj.CUST_CORP_PCUL_C;//법인특성
		//form.CUST_RELR_TP_C.value = (selObj.CUST_RELR_TP_C == undefined) ? "": '06' + selObj.CUST_RELR_TP_C;//관련자유형
		form.CUST_RELR_TP_C.value = (selObj.CUST_RELR_TP_C == undefined) ? "": selObj.CUST_RELR_TP_C;//관련자유형
		form.PROD_LN_C.value = (selObj.PROD_LN_C == undefined) ? "": selObj.PROD_LN_C;//계좌상품
		form.PROD_INSU_C.value = (selObj.PROD_INSU_C == undefined) ? "": selObj.PROD_INSU_C;//금융상품
		form.PROD_INV_C.value = (selObj.PROD_INV_C == undefined) ? "": selObj.PROD_INV_C;//금융서비스
		form.PROD_RDAMT_G_C.value = (selObj.PROD_RDAMT_G_C == undefined) ? "": selObj.PROD_RDAMT_G_C;//입출금구분
		form.PROD_TRN_SCAL.value = (selObj.PROD_TRN_SCAL == undefined) ? "": selObj.PROD_TRN_SCAL;  //거래규모
		form.PROD_TRN_PCUL_C.value = (selObj.PROD_TRN_PCUL_C == undefined) ? "": selObj.PROD_TRN_PCUL_C;//거래특성
		form.ENTR_CHNL_INSU_C.value = (selObj.ENTR_CHNL_INSU_C == undefined) ? "": '01' + selObj.ENTR_CHNL_INSU_C;//거래채널
		//form.ENTR_CHNL_LN_C.value = (selObj.ENTR_CHNL_LN_C == undefined) ? "": '02' + selObj.ENTR_CHNL_LN_C;
		//form.PAY_CHNL_C.value = (selObj.PAY_CHNL_C == undefined) ? "" : '03'+ selObj.PAY_CHNL_C;
		form.REL_F_CRIM_C.value = (selObj.REL_F_CRIM_C == undefined) ? "": selObj.REL_F_CRIM_C;//관련전체범죄
		form.REL_FNCO_C.value = (selObj.REL_FNCO_C == undefined) ? "": selObj.REL_FNCO_C;//관련금융회사
		form.SSPS_TRN_TP_C.value = (selObj.SSPS_TRN_TP_C == undefined) ? "": selObj.SSPS_TRN_TP_C;//의심거래유형
	}

	//통제효과성 목표관리 저장함수
	function doSave() {
		
		showConfirm("${msgel.getMsg('doSave','저장하시겠습니까?')}", '${msgel.getMsg("AML_00_00_01_01_025","저장")}', doSave_Action)
    }
	
	function doSave_Action() {
		if ($("button[id='btn_01']")) {
			$("button[id='btn_01']").prop('disabled', true);
			
			var classID = "RBA_50_05_09_01"; 
			var methodID = "doSave";
			var obj 		    	= new Object();
			obj.BAS_YYYY 			=  "${BAS_YYYY}";
			obj.SNO 				=  "${SNO}";
			obj.GUBN 				=  "${GUBN}";
			obj.SRC_TP_C 			=  form.SRC_TP_C.value;
			obj.SRC_DTL_INFO 		=  form.SRC_DTL_INFO.value;
			obj.ML_EXP_TITE 		=  form.ML_EXP_TITE.value;
			obj.ML_EXP_CTNT 		=  form.ML_EXP_CTNT.value;
			obj.RSK_CAUS_CTNT 		=  form.RSK_CAUS_CTNT.value;
			obj.REL_NAT_NM 			=  form.REL_NAT_NM.value;
			
			obj.REL_NAT_RSK_TP_C 	=  form.REL_NAT_RSK_TP_C.value.substr(2, 2);
			obj.CUST_DWL_TP_C 		=  form.CUST_DWL_TP_C.value.substr(2, 2);
			obj.CUST_ASS_SCAL_C 	=  form.CUST_ASS_SCAL_C.value.substr(2, 2);
			obj.CUST_UPSL_G_C 		=  form.CUST_UPSL_G_C.value.substr(2, 2);
			obj.CUST_INDV_PCUL_C 	=  form.CUST_INDV_PCUL_C.value.substr(2, 2);
			obj.CUST_CORP_PCUL_C 	=  form.CUST_CORP_PCUL_C.value.substr(2, 2);
			obj.CUST_RELR_TP_C 		=  form.CUST_RELR_TP_C.value.substr(2, 2);
			obj.PROD_LN_C 			=  form.PROD_LN_C.value;
			obj.PROD_INSU_C 		=  form.PROD_INSU_C.value;
			obj.PROD_INV_C 			=  form.PROD_INV_C.value;
			obj.PROD_RDAMT_G_C 		=  form.PROD_RDAMT_G_C.value;
			obj.PROD_TRN_SCAL 		=  form.PROD_TRN_SCAL.value;
			obj.PROD_TRN_PCUL_C 	=  form.PROD_TRN_PCUL_C.value;
			obj.ENTR_CHNL_INSU_C 	=  form.ENTR_CHNL_INSU_C.value.substr(2, 2);
			obj.REL_F_CRIM_C 		=  form.REL_F_CRIM_C.value;
			obj.REL_FNCO_C 			=  form.REL_FNCO_C.value;
			obj.SSPS_TRN_TP_C 		=  form.SSPS_TRN_TP_C.value;
			
		    sendService(classID, methodID, obj, doSave_success, doSave_fail);

			function doSave_success() {
				setTimeout(function(){
				 	opener.doSearch();
				 	window.close();
				},500);
				appro_end();
			}
			function doSave_fail() {
				return;
			}
			
		}
	}

	//통제효과성 목표관리 삭제함수
	function doDelete() {
		if ($("button[id='btn_02']")) {
			if ("${GUBN}" == "0") { //구분이 0이면 등록 아니면 수정
				alert("등록 창에서는 삭제 할 수 없습니다");
				return;
			}
			$("button[id='btn_02']").prop('disabled', true);

			showConfirm("${msgel.getMsg('doDelete','삭제하시겠습니까?')}", '${msgel.getMsg("AML_00_00_01_01_027","삭제")}', doDelete_Action);

		}
	}

	function doDelete_Action(){
		var classID = "RBA_50_05_09_01"; 
		var methodID = "doDelete";
		var obj 				= new Object();
	   	obj.pageID 				= "RBA_50_05_09_01";
	   	obj.methodID 			= "doDelete";	   
	   	obj.BAS_YYYY 			= "${BAS_YYYY}";
		obj.SNO 				=  "${SNO}";

		sendService(classID, methodID, obj, doDelete_success, doDelete_fail);
	}
	
	function doDelete_success() { 
		opener.doSearch();
		window.close();
	}	  
	function doDelete_fail() { 
		return;
	}	  
	  
	
	function appro_end() {
		$("button[id='btn_01']").prop('disabled', false);
		$("button[id='btn_02']").prop('disabled', false);
		opener.doSearch();
		window.close();
	}
</script>
<style>
	.basic-table .title {
	    background-color: #eff1f5;
	    padding: 12px 12px 12px 16px;
	    font-family: SpoqR;
	    font-size: 14px;
	    line-height: 22px;
	    color: #444;
	    letter-spacing: -0.28px;
	    width: 0;
	}
</style>
<form name="form">
	<input type="hidden" name="pageID" /> 
	<input type="hidden" name="classID" /> 
	<input type="hidden" name="methodID" />
	<div class="panel panel-primary">
		<div class="panel-footer" >
            <div class="table-box" >
                <table class="basic-table">
					<tr>
						<th class="title" rowspan="4">자금세탁사례</th>
						<th class="title">출처유형</th>
						<td width="200px" style="text-align: left;" colspan="3">
							${RBACondEL.getKRBASelect('SRC_TP_C','100%' ,'' ,'R311' ,'' ,'' ,'','','','')}
						</td>
						<th class="title">No.</th>
						<td width="200px" style="text-align: center;">
						    <input type="text" class="input_text" id="SNO" name="SNO" value="${SNO}" style="text-align: center; width:100%;" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th class="title">출처상세</th>
						<td colspan="5">
						   <textarea type="textarea" name="SRC_DTL_INFO" id="SRC_DTL_INFO" class="textarea-box" rows="2" maxlength="666"></textarea>
						</td>
					</tr>
					<tr>
						<th class="title">제목</th>
						<td style="text-align: center;" colspan="5">
						   <textarea type="textarea" name="ML_EXP_TITE" id="ML_EXP_TITE" class="textarea-box" rows="2" maxlength="333"></textarea>
						</td>
					</tr>
					<tr>
						<th class="title">내용</th>
						<td style="text-align: center;" colspan="5">
						   <textarea type="textarea" name="ML_EXP_CTNT" id="ML_EXP_CTNT" class="textarea-box" rows="6" maxlength="1000"></textarea>
						</td>
					</tr>
					<tr>
						<th class="title" colspan="2">위험원인</th>
						<td style="text-align: center;" colspan="5">
						   <textarea type="textarea" name="RSK_CAUS_CTNT" id="RSK_CAUS_CTNT" class="textarea-box" rows="3" maxlength="333"></textarea>
						   
						</td>
					</tr>
					<tr>
						<th class="title">국가</th>
						<th class="title">관련국가명</th>
						<td style="text-align: center;">
						   <input type="text" name="REL_NAT_NM" style="text-align: left; width: 100%" maxlength="33" />
						</td>
						<th class="title">관련국가 위험유형</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('REL_NAT_RSK_TP_C','100%' ,'' ,'EV_SARE' ,'' ,'' ,'','01','1','')}
						</td>
					</tr>
					<tr>
						<th class="title" rowspan="3">고객</th>
						<th class="title">주거유형</th>
						<td style="text-align: left;" width="100px">
							${RBACondEL.getKRBASelect('CUST_DWL_TP_C','100%' ,'' ,'EV_SARE' ,'' ,'' ,'','01','2','')}
						</td>
						<th class="title">자산규모</th>
						<td style="text-align: left;" width="100px">
							${RBACondEL.getKRBASelect('CUST_ASS_SCAL_C','100%' ,'' ,'EV_SARE' ,'' ,'' ,'','02','2','')}
						</td>
					</tr>
					<tr>
						<th class="title">업종구분</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('CUST_UPSL_G_C','100%' ,'' ,'EV_SARE' ,'' ,'' ,'','03','2','')}
						</td>
						<th class="title">개인특성</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('CUST_INDV_PCUL_C','100%' ,'' ,'EV_SARE' ,'' ,'' ,'','04','2','')}
						</td>
						<th class="title">법인특성</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('CUST_CORP_PCUL_C','100%' ,'' ,'EV_SARE' ,'' ,'' ,'','05','2','')}
						</td>
					</tr>
					<tr>
						<th class="title">관련자유형</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('CUST_RELR_TP_C','200%' ,'' ,'R339' ,'' ,'' ,'','','','')}
						</td>
					</tr>
					<tr>
						<th class="title" rowspan="2">상품 및 서비스</th>
						<th class="title">계좌상품</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('PROD_LN_C','100%' ,'' ,'R312' ,'' ,'' ,'','','','')}
						</td>
						<th class="title">금융상품</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('PROD_INSU_C','100%' ,'' ,'R313' ,'' ,'' ,'','','','')}
						</td>
						<th class="title">금융서비스</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('PROD_INV_C','100%' ,'' ,'R314' ,'' ,'' ,'','','','')}
						</td>
					</tr>
					<tr>
						<th class="title">입출금구분</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('PROD_RDAMT_G_C','100%' ,'' ,'R315' ,'' ,'' ,'','','','')}
						</td>
						<th class="title">거래규모</th>
						<td style="text-align: left;">
						   <input type="text" id="PROD_TRN_SCAL" name="PROD_TRN_SCAL" style="text-align: left; width: 100%" maxlength="40" />
						</td>
						<th class="title">거래특성</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('PROD_TRN_PCUL_C','100%' ,'' ,'R316' ,'' ,'' ,'','','','')}
						</td>
					</tr>
					<tr>
						<th class="title">채널</th>
						<th class="title">거래채널</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('ENTR_CHNL_INSU_C','100%' ,'' ,'EV_SARE' ,'' ,'' ,'','01','4','')}
						</td>
					</tr>
					<tr>
						<th class="title">기타</th>
						<th class="title">관련전체범죄</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('REL_F_CRIM_C','100%' ,'' ,'R317' ,'' ,'' ,'','','','')}
						</td>
						<th class="title">관련금융회사</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('REL_FNCO_C','100%' ,'' ,'R318' ,'' ,'' ,'','','','')}
						</td>
						<th class="title">의심거래유형</th>
						<td style="text-align: left;">
							${RBACondEL.getKRBASelect('SSPS_TRN_TP_C','100%' ,'' ,'R319' ,'' ,'' ,'','','','')}
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">  
			${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"R", function:"doSave", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"deleteBtn", defaultValue:"삭제", mode:"R", function:"doDelete", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"window.close", cssClass:"btn-36"}')}
		</div>
	</div>
	<div class="panel panel-primary" style="display: none">
		<div class="panel-footer">
			<div id="GTDataGrid1_Area"></div>
		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />