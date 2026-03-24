<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : 내부통제 직원 검색
*                   User Popup Search
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 서윤경, 김현일
* Since           : 2010. 9. 30.
********************************************************************************************************************************************
* Modifier        : 박상훈
* Update          : 2017. 6. 12.
* Alteration      : 1. window popup open시 form의 submit을 사용하지 않도록 수정
********************************************************************************************************************************************
* Modifier        : 송지윤
* Update          : 2017. 7. 6.
* Alteration      : 1. 코드 정리
********************************************************************************************************************************************
* Modifier        : 박상훈
* Update          : 2018. 1. 22.
* Breakdown       : 오류수정
* Alteration      : 더블클릭 처리
********************************************************************************************************************************************
--%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp"               %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ page import="com.gtone.rba.server.common.RBA_99.RBA_99_01.RBA_99_01_01.RBA_99_01_01_01"%>

<script>
    var gridUser = null;
	var overlay = new Overlay();

    // [ Initialize ]
    $(document).ready(function(){
    	$('.popup-header > h2').text("${msgel.getMsg('adm.comm.popup.user.title','직원 검색')}");
//         setPageTitle("${msgel.getMsg('adm.comm.popup.user.title','사용자 검색')}",true);
        setupEvents();
        setupConditions();
        setupGrids();
        setupFilter1("init");
        
        $("input[name=txtUSER_NM]").focus();
//         $("input[name=txtLOGIN_ID]").focus();
//         $("input[name=txtDEP_NM]").focus();
    });
    
    function setupFilter1(FLAG){
    	var gridArrs = new Array();
    	var gridObj = new Object();
    	gridObj.gridID = "GTDataGrid1_Area";
    	gridArrs[0] = gridObj;
    	
    	setupGridFilter2(gridArrs,FLAG);	
    }

    /** 검색조건 셋업 */
    function setupConditions() { new GtCondBox("condBox1",1).setItemWidths(220, 70, 0); }
    
    function setupEvents()
    {
        $("input[name=txtUSER_NM]").keyup(function(e){
            if (e.which==13) userSearch();
        });
    }
    
    function setupGrids()
    {
        gridUser = $("#GTDataGrid1_Area").dxDataGrid({
        	 gridId          : "GTDataGrid01",
          	 height : 'calc(90vh - 200px)',
          	elementAttr: { class: "grid-table-type" },
        	"hoverStateEnabled": true,
            "wordWrapEnabled": false,
            "allowColumnResizing": true,
            "columnAutoWidth": true,
            "allowColumnReordering": true,
            "cacheEnabled": false,
            "cellHintEnabled": true,
            "showBorders": true,
            "showColumnLines": true,
            "showRowLines": true,
            "sorting": {"mode": "multiple"},
            "remoteOperations":     {
                "filtering": false,
                "grouping": false,
                "paging": false,
                "sorting": false,
                "summary": false
            },
            "filterRow": {"visible": false},
            "rowAlternationEnabled": true,
            "columnFixing": {"enabled": true},
            pager: {
     	    	visible: true
     	    	,showNavigationButtons: true
     	    	,showInfo: true
    	 	},
    	 	paging: {
    	 	  	enabled : true
    	 		,pageSize : 20
    	 	},
    	 	scrolling : {
    	        mode            : "standard"
    	        ,preloadEnabled  : false
    	    },
            "searchPanel":     {
                "visible": false,
                "width": 250
            },
            "selection":     {
                "allowSelectAll": true,
                "deferred": false,
                "mode": 'single',
                "selectAllMode": "allPages",
                "showCheckBoxesMode": "onClick"
            },
            "columns" : [
                {
                    "dataField": "USER_ID",
                    "caption": '${msgel.getMsg("AML_90_12_01_01_102","로그인ID")}',
                    "alignment": "center",
                    "allowResizing": true,
                    "allowSearch": true,
                    "allowSorting": true
                },{
                    "dataField": "USER_NM",
                    "caption": '${msgel.getMsg("AML_90_03_07_01_202","이름")}',
                    "alignment": "center",
                    "allowResizing": true,
                    "allowSearch": true,
                    "allowSorting": true
                },{
                    "dataField": "DEP_ID",
                    "caption": '${msgel.getMsg("AML_90_03_07_01_106","부서")}',
                    "alignment": "center",
                    "allowResizing": true,
                    "allowSearch": true,
                    "allowSorting": true
//                     "visible":false
                },{
                    "dataField": "DEP_NM",
                    "caption": '${msgel.getMsg("AML_90_03_07_01_106","부서")}',
                    "alignment": "center",
                    "allowResizing": true,
                    "allowSearch": true,
                    "allowSorting": true
                },{
                    "dataField": "POSITION_NM",
                    "caption": '${msgel.getMsg("AML_20_01_01_04_029","직위")}',
                    "alignment": "center",
                    "allowResizing": true,
                    "allowSearch": true,
                    "allowSorting": true
                }
            ],
            onToolbarPreparing   : makeToolbarButtonGrids,
//             "summary": {"totalItems": [{
//                 column: "LOGIN_ID",
//                 summaryType: "count",
//                 valueFormat: "fixedPoint", 
//                 alignment: "center"
//             }],
//             texts: {count: '${msgel.getMsg("AML_90_02_04_01_202","총: {0}건")}'}},
            "onRowClick" : function (e) {
                e.component.clickCount || (e.component.clickCount=0);
                setTimeout(function(){ e.component.clickCount=0; },500);
                if (++e.component.clickCount>1) {
                    e.component.clickCount=0;
                    closeOK();
                }
            }
        }).dxDataGrid("instance");
    }
    
    function closeCancel() { self.close(); }
    
    function closeOK()
    {
        var selectedItem = gridUser.getSelectedRowsData()[0];
        
        if (selectedItem && selectedItem.USER_ID && opener['<c:out value="${param.FUNC_NM}"/>']) {
        	if($.isFunction(opener['<c:out value="${param.FUNC_NM}"/>'])) {
            	var funcRet = opener['<c:out value="${param.FUNC_NM}"/>']({
					'USER_ID':selectedItem.USER_ID,
					'USER_NM':selectedItem.USER_NM, 
					'DEP_ID' :selectedItem.DEP_ID,
					'DEP_NM' :selectedItem.DEP_NM,
					'POSITION_NM' :selectedItem.POSITION_NM
            	});
            	if(typeof(funcRet) == "object") {
            		if(typeof(funcRet.ERROR_MSG) == "string") {
            			showAlert(funcRet.ERROR_MSG,"ERR");
						return ;
            		}
            	}
        	}
        	self.close();  
        }
    }

    function userSearch(){
        var params      = new Object();
        var methodID    = "doSearchJKW";
        var classID  = "RBA_99_01_01_01";

        params.pageID   = "RBA_99_01_01_03";
    	params.USER_NM = $("input[name=txtUSER_NM]").val();
        
        sendService(classID, methodID, params, userSearch_success, doSearch_fail);
    }
    

    function userSearch_success(gridData, data)
    {
        if (data&&data.GRID_DATA&&data.GRID_DATA.length>0) {
        	gridUser.option("dataSource", gridData);
        }
        overlay.hide();
    }
    
    function doSearch_fail(data){
    	overlay.hide();
    }
    
    function makeToolbarButtonGrids(e){
        var cmpnt; cmpnt = e.component;
        var useYN = "${outputAuth.USE_YN  }";  // 사용 유무
        var authC = "${outputAuth.C       }";  // 추가,수정 권한
        var authD = "${outputAuth.D       }";  // 삭제 권한
        if (useYN=="Y") {
           var gridID       = e.element.attr("id");    // 그리드 아이디
           var toolbarItems = e.toolbarOptions.items;
           toolbarItems.splice(0, 0, {
              "locateInMenu"      : "auto",
              "location"         : "after",
              "widget"         : "dxButton",
              "name"            : "filterButton",
              "showText"         : "inMenu",
              "options"         :
              {
                 "icon"         : "" ,
                 "elementAttr"   : { class: "btn-28 filter popupFilter" },
                 "text"         : "",
                 "hint"         : '필터',
                 "disabled"      : false,
                 "onClick"      : 
                    function(){
                       if(gridID=="GTDataGrid1_Area"){
                          setupFilter1();
                       } else if(gridID=="GTDataGrid2_Area") {
                          setupFilter2();
                       } else {//gridID=="GTDataGrid3_Area"
                          setupFilter3();
                       }
                    }
              }
           });
           var btnLastIndex=0;
           for(;btnLastIndex<toolbarItems.length; btnLastIndex++){
              if(toolbarItems[btnLastIndex].widget != "dxButton") {
                 break;
              }
           }
        }
     }
    
</script>

<div class="popup-table">
	<div class="table-row">
        	<div class="table-cell">
                ${condel.getLabel('adm.comm.popup.user.search.nm','이름')}
                <div class="content">
                	<input name="txtUSER_NM" type="text"  maxlength="20" style="width=100"/>
                </div>
                <div class="button-area">
                     ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"userSearch", cssClass:"btn-36 filled"}')}
        		</div>	
            </div>
	</div>
</div>		
	<div id="GTDataGrid1_Area" style="margin-top: 8px;"></div>
		<div class="button-area" style="float:right; margin:8px 0;">
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"AML_10_04_01_02_sbtn_01", defaultValue:"확인", mode:"R", function:"closeOK", cssClass:"btn-36"}')}
        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"closeCancel", cssClass:"btn-36"}')}
    </div> 

    
<%@ include file="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" %>