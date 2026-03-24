<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_07_03_01.jsp
* Description     : RBA 위험평가결과 보고
* Group           : GTONE, R&D센터/개발2본부
* Author          : 권얼
* Since           : 2018-05-03
********************************************************************************************************************************************
--%>

<%@page import="java.util.Locale"%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<% 
    String filePath = ServerConfig.getInstance().getProperty("RBA_KPMG_FILE_PATH");
    String fileName = ServerConfig.getInstance().getProperty("RBA_KPMG_COMP_FILE");
    boolean isWin = System.getProperty("os.name").toLowerCase(Locale.ROOT).startsWith("windows");

	/* 
	 * 로컬에서 express.properties에 'RBA_KPMG_FILE_PATH'경로가 절대경로로 되어있을경우 에러방지... 완벽한건 아님
	 * 서버의 OS를 체크해서 윈도우일 경우에만 체크하도록 변경
	 */
	 System.out.println("isWin : " +isWin);
	if (filePath.contains("WebContent") && isWin) {
		
		filePath = filePath.substring(filePath.indexOf("WebContent")+10);
	}else if (filePath.contains("itpweb") && !isWin){
		filePath = filePath.substring(filePath.indexOf("itpweb")+6);
		
	}
    request.setAttribute("filePath", filePath);
    request.setAttribute("fileName", fileName);
%>

<script>
    var GridObj1;
    var GridObj2;
    var GridObj3;
    var GridObj4;
    var GridObj5;
    var GridObj6;
    var GridObj7;
    var GridObj8;
    var GridObj9;
    var GridObj10;
    var GridObj11;
    var GridObj12;
    var GridObj13;
    var GridObj14;
    var GridObj15;
    var GridObj16;
    var GridObj17;
    
    var tabID   = 0;
    var pageID  = "RBA_50_07_03_01";
    var classID = "RBA_50_07_03_01";
    var overlay = new Overlay();

    var intervalResult = "";
        
    /** Initialize */
    $(document).ready(function(){
        setupTabPanel(0);
    });
    
 	// 탭1 그리드 초기화 함수 셋업
    function setupGrids(){
 		GridObj17 = initGrid3({
            gridId          : 'GTDataGrid17'
           ,headerId        : 'RBA_50_07_03_01_Grid17'
           ,gridAreaId      : 'GTDataGrid17_Area'
           ,height          : 'calc(83vh - 1000px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,completedEvent  : function(){
               GridObj1 = initGrid3({
                   gridId          : 'GTDataGrid1'
                  ,headerId        : 'RBA_50_07_03_01_Grid1'
                  ,gridAreaId      : 'GTDataGrid1_Area'
                  ,height          : 'calc(83vh - 100px)'
                  ,useAuthYN       : '${outputAuth.USE_YN}'
               });
           }
 		});
 		
 		
 		

    }
 	
    /** 탭2 그리드 초기화 */
 	function setupGrids2() {
 		GridObj2 = initGrid3({
            gridId          : 'GTDataGrid2'
           ,headerId        : 'RBA_50_07_03_01_Grid2'
           ,gridAreaId      : 'GTDataGrid2_Area'
           ,height          : 'calc(83vh - 1000px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,completedEvent  : function(){
               GridObj3 = initGrid3({
                   gridId          : 'GTDataGrid3'
                  ,headerId        : 'RBA_50_07_03_01_Grid3'
                  ,gridAreaId      : 'GTDataGrid3_Area'
                  ,height          : 'calc(83vh - 1000px)'
                  ,useAuthYN       : '${outputAuth.USE_YN}'
                  ,completedEvent  : function(){
                      setupGridFilter([GridObj2, GridObj3]);
                   }
               });
            }
        });
 	}
    
 	/** 탭3 그리드 초기화 */
    function setupGrids3(){
        GridObj4 = initGrid3({
            gridId          : 'GTDataGrid4'
           ,headerId        : 'RBA_50_07_03_01_Grid4'
           ,gridAreaId      : 'GTDataGrid4_Area'
           ,height          : 'calc(83vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
        });
    }
 	
    /** 탭4 그리드 초기화 */
 	function setupGrids4() {
 		GridObj5 = initGrid3({
            gridId          : 'GTDataGrid5'
           ,headerId        : 'RBA_50_07_03_01_Grid5'
           ,gridAreaId      : 'GTDataGrid5_Area'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,completedEvent  : function(){
        	   GridObj6 = initGrid3({
                   gridId          : 'GTDataGrid6'
                  ,headerId        : 'RBA_50_07_03_01_Grid6'
                  ,gridAreaId      : 'GTDataGrid6_Area'
                  ,useAuthYN       : '${outputAuth.USE_YN}'
                  ,completedEvent  : function(){
                      GridObj7 = initGrid3({
                          gridId          : 'GTDataGrid7'
                         ,headerId        : 'RBA_50_07_03_01_Grid7'
                         ,gridAreaId      : 'GTDataGrid7_Area'
                         ,useAuthYN       : '${outputAuth.USE_YN}'
                         ,completedEvent  : function(){
                             setupGridFilter([GridObj5, GridObj6, GridObj7]);
                          }
                      });
                   }
               });
            }
        });
 	}
    
 	/** 탭5 그리드 초기화 */
 	function setupGrids5() {
 		GridObj8 = initGrid3({
            gridId          : 'GTDataGrid8'
           ,headerId        : 'RBA_50_07_03_01_Grid8'
           ,gridAreaId      : 'GTDataGrid8_Area'
           ,useAuthYN       : '${outputAuth.USE_YN}'
       	   ,completedEvent  : function(){
       		   GridObj9 = initGrid3({
                    gridId          : 'GTDataGrid9'
                   ,headerId        : 'RBA_50_07_03_01_Grid9'
                   ,gridAreaId      : 'GTDataGrid9_Area'	
                   ,useAuthYN       : '${outputAuth.USE_YN}'
                   ,completedEvent  : function(){
                       GridObj10 = initGrid3({
                           gridId          : 'GTDataGrid10'
                          ,headerId        : 'RBA_50_07_03_01_Grid10'
                          ,gridAreaId      : 'GTDataGrid10_Area'
                          ,useAuthYN       : '${outputAuth.USE_YN}'
                          ,completedEvent  : function(){
                              setupGridFilter([GridObj8, GridObj9, GridObj10]);
                           }
                       });
                    }
				});
			}
        });
 	}
 	
 	/** 탭6 그리드 초기화 */
 	function setupGrids6() {
 		GridObj11 = initGrid3({
            gridId          : 'GTDataGrid11'
           ,headerId        : 'RBA_50_07_03_01_Grid11'
           ,gridAreaId      : 'GTDataGrid11_Area'
           ,useAuthYN       : '${outputAuth.USE_YN}'
       	   ,completedEvent  : function(){
	       		setupGridFilter(GridObj11);
			}
        });
 		
 		GridObj12 = initGrid3({
            gridId          : 'GTDataGrid12'
           ,headerId        : 'RBA_50_07_03_01_Grid12'
           ,gridAreaId      : 'GTDataGrid12_Area'	
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,completedEvent  : function(){
        	   GridObj13 = initGrid3({
                   gridId          : 'GTDataGrid13'
                  ,headerId        : 'RBA_50_07_03_01_Grid13'
                  ,gridAreaId      : 'GTDataGrid13_Area'
                  ,useAuthYN       : '${outputAuth.USE_YN}'
                  ,completedEvent  : function(){
                	  GridObj14 = initGrid3({
                           gridId          : 'GTDataGrid14'
                          ,headerId        : 'RBA_50_07_03_01_Grid14'
                          ,gridAreaId      : 'GTDataGrid14_Area'
                          ,useAuthYN       : '${outputAuth.USE_YN}'
                          ,completedEvent  : function(){
                              setupGridFilter([GridObj12, GridObj13, GridObj14]);
                           }
                       });
					}
               });
            }
		});
 	}
 	
 	/** 탭7 그리드 초기화 */
    function setupGrids7(){
        GridObj15 = initGrid3({
            gridId          : 'GTDataGrid15'
           ,headerId        : 'RBA_50_07_03_01_Grid15'
           ,gridAreaId      : 'GTDataGrid15_Area'
           ,useAuthYN       : '${outputAuth.USE_YN}'
       	   ,completedEvent  : function(){
               GridObj16 = initGrid3({
                   gridId          : 'GTDataGrid16'
                  ,headerId        : 'RBA_50_07_03_01_Grid16'
                  ,gridAreaId      : 'GTDataGrid16_Area'
                  ,useAuthYN       : '${outputAuth.USE_YN}'
                  ,completedEvent  : function(){
                      setupGridFilter([GridObj15, GridObj16]);
                   }
               });
            }
        });
    }
 	
    /** 탭8 그리드 초기화 */
    function setupGrids8(){
    	GridObj17 = initGrid3({
            gridId          : 'GTDataGrid17'
           ,headerId        : 'RBA_50_07_03_01_Grid17'
           ,gridAreaId      : 'GTDataGrid17_Area'
           ,useAuthYN       : '${outputAuth.USE_YN}'
       	   ,completedEvent  : function(){
       		   setupGridFilter(GridObj17);
            },failEvent : function(){
            	overlay.hide();
            }
        });
    }
 	
    /** 탭 셋업 */
    function setupTabPanel(defTabIdx){
        tabPanelID = setupDxTab({
            "tabContID" : "tabCont1",
            "height"    : "72vh",
            "onTabClick": function(e){
                dvTab(e.itemData.tabIdx);
            },
            "onInit"    : function(e){dvTab(0);},
            "defTabIdx" : defTabIdx
        });
    }
    
    function dvTab(pageNum){
        tabID = pageNum;
        if (pageNum == 0) {        	// Executive Summary
        	setupGrids();
        } else if (pageNum == 1) { 	// 자금세탁위험평가개요
        	setupGrids2();
        } else if (pageNum == 2) { 	// 회사현황
        	setupGrids3();
        } else if (pageNum == 3) { 	// 자금세탁위험평가방법론
        	setupGrids4();
        } else if (pageNum == 4) {	// 자금세탁위험평가
        	setupGrids5();
        } else if (pageNum == 5) {	// 결과
        	setupGrids6();
        } else if (pageNum == 6) {	// 주요발견사항 및 개선사항
        	setupGrids7();
        } else if (pageNum == 7) {	// 별첨
        	setupGrids8();
        }
        setTimeout('doSearch()', 1000);
    }
    
    function doSearch(){
        overlay.show(true, true);
        doSearchSC();
        existFile();
        if (tabID == 0) { 		 // Executive Summary 
            doSearch1();
        } else if (tabID == 1) { // 자금세탁위험평가개요
            doSearch1();
            doSearch2();
            doSearch3();
        } else if (tabID == 2) { // 회사현황
        	var year = form.BAS_YYMM.value.substring(0,4);
        	var month = form.BAS_YYMM.value.substring(4,6);
        	var date; date = new Date(year, month);
        	
            form.FY1.value = year;
            form.FY2.value = date.getFullYear() - 1;
            form.FY3.value = date.getFullYear() - 2;
        	doSearch4();
        } else if (tabID == 3) { // 자금세탁위험평가방법론
        	doSearch5();
        	doSearch6();
        	doSearch7();
        } else if (tabID == 4) { // 자금세탁위험평가
        	doSearch8();
        	doSearch9();
        	doSearch10();
        } else if (tabID == 5) { // 결과
        	doSearch11();
        	doSearch12();
        	doSearch13();
        	doSearch14();
        } else if (tabID == 6) { // 주요발견사항 및 개선사항
        	doSearch15();
        	doSearch16();
        } else if (tabID == 7) { // 별첨
        	doSearch17();
        }
    }
    
    function initChart1() {
 		var url = "<c:url value='/'/>Package/RBA/type03/RBA_50/RBA_50_07/RBA_50_07_03/RBA_50_07_03_chart1.jsp";
	    form2.BAS_YYMM.value = form.BAS_YYMM.value;
		form2.action = url;
		form2.target = 'Chart1_Area'; 
		form2.submit();
    }
    function initChart2() {
    	var url = "<c:url value='/'/>Package/RBA/type03/RBA_50/RBA_50_07/RBA_50_07_03/RBA_50_07_03_chart2.jsp";
	    form2.BAS_YYMM.value = form.BAS_YYMM.value;
		form2.action = url;
		form2.target = 'Chart2_Area'; 
		form2.submit();
    }
    function initChart3(gridCnt) {
 		var url;
 		if (gridCnt > 0) {
			url = "<c:url value='/'/>Package/RBA/type03/RBA_50/RBA_50_07/RBA_50_07_03/RBA_50_07_03_chart3.jsp";
	    	form2.BAS_YYMM.value = form.BAS_YYMM.value;
 		} else {
 			url = "<c:url value='/'/>Package/RBA/type03/RBA_50/RBA_50_07/RBA_50_07_03/RBA_50_07_03_chart3_null.jsp";
 		}
		form2.action = url;
		form2.target = 'Chart3_Area'; 
		form2.submit();
    }
    
    function existFile(){
    	var filePath = '${filePath}';
    	var fileName = form.BAS_YYMM.value + '_' + '${fileName}';
    	
        $.ajax({
            url: filePath + fileName,
            type:'HEAD',
            error: function() {
                //alert("file not exists");
                form.existFile.value = 'N';
                form.existFile.style.color = 'red';
            },
            success: function() {
                //alert("file exists");
                form.existFile.value = 'Y';
                form.existFile.style.color = 'blue';
            }
        });
	}

    function doSearchSC(){
    	GridObj17.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "doSearchSC"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearchSC_end1
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearchSC_end1() {
    	var gridCnt   = GridObj17.rowCount();
    	if(gridCnt>0) {
            var selObj = GridObj17.getRow(0);
            jQuery("#RBA_RPT_MK_S_C_NM").val(selObj.RBA_RPT_MK_S_C_NM);
            
            if("진행중"==selObj.RBA_RPT_MK_S_C_NM){
            	clearInterval(intervalResult);
            	intervalResult = setInterval(function(){
            		doSearchSC();
            	},5000);
            }
        }
    }
    
        
    function doSearch1(){
    	GridObj1.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end1
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end1() {
        var gridCnt   = GridObj1.rowCount();
        var arrColIds; arrColIds = GridObj1.getColumnIDs();
    	
    	if (tabID == 0) {
	    	jQuery("#R1_IMPRV_PLAN").text("");
	        if(gridCnt>0) {
	            var selObj = GridObj1.getRow(0);
	            jQuery("#R1_AIM").html(selObj.R1_AIM);
	            jQuery("#R1_VALT_RSLT").html(selObj.R1_VALT_RSLT);
	            jQuery("#R1_IMPRV_PLAN").text(selObj.R1_IMPRV_PLAN);
	        } else {
	            jQuery("#R1_AIM").text("");
	            jQuery("#R1_VALT_RSLT").text("");
	            jQuery("#R1_IMPRV_PLAN").text("");
	        }
    	} else if (tabID == 1) {
	        if(gridCnt>0) {
	            var selObj = GridObj1.getRow(0);
	            jQuery("#R2_AIM").html(selObj.R2_AIM);
	        } else {
	            jQuery("#R2_AIM").text("");
	        }
    	}
    	overlay.hide();
    }
    
    function doSearch2(){
    	GridObj2.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch2"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end2
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end2() {
    	overlay.hide();
    }
    
    function doSearch3(){
    	GridObj3.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch3"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end3
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end3() {
    	overlay.hide();
    }
    
    function doSearch4(){
    	GridObj4.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch4"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end4
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end4() {
    	jQuery("#FY1_Col").text("FY"+form.FY1.value);
    	jQuery("#FY2_Col").text("FY"+form.FY2.value);
    	jQuery("#FY3_Col").text("FY"+form.FY3.value);
    	
    	var gridCnt   = GridObj4.rowCount();
        var arrColIds; arrColIds = GridObj4.getColumnIDs();
    	
        if(gridCnt>0) {
            var selObj = GridObj4.getRow(0);
            jQuery("#R3_HIST").html(selObj.R3_HIST);
            jQuery("#R3_TOTAS1").html(selObj.R3_TOTAS1);
            jQuery("#R3_TOTAS2").text(selObj.R3_TOTAS2);
            jQuery("#R3_TOTAS3").text(selObj.R3_TOTAS3);
            jQuery("#R3_EQCT1").text(selObj.R3_EQCT1);
            jQuery("#R3_EQCT2").text(selObj.R3_EQCT2);
            jQuery("#R3_EQCT3").text(selObj.R3_EQCT3);
            jQuery("#R3_FLLBT1").text(selObj.R3_FLLBT1);
            jQuery("#R3_FLLBT2").text(selObj.R3_FLLBT2);
            jQuery("#R3_FLLBT3").text(selObj.R3_FLLBT3);
            jQuery("#R3_FIX_LLBT1").text(selObj.R3_FIX_LLBT1);
            jQuery("#R3_FIX_LLBT2").text(selObj.R3_FIX_LLBT2);
            jQuery("#R3_FIX_LLBT3").text(selObj.R3_FIX_LLBT3);
            jQuery("#R3_FLAST1").text(selObj.R3_FLAST1);
            jQuery("#R3_FLAST2").text(selObj.R3_FLAST2);
            jQuery("#R3_FLAST3").text(selObj.R3_FLAST3);
            jQuery("#R3_NPRFIT1").text(selObj.R3_NPRFIT1);
            jQuery("#R3_NPRFIT2").text(selObj.R3_NPRFIT2);
            jQuery("#R3_NPRFIT3").text(selObj.R3_NPRFIT3);
            jQuery("#R3_COS1").text(selObj.R3_COS1);
            jQuery("#R3_COS2").text(selObj.R3_COS2);
            jQuery("#R3_COS3").text(selObj.R3_COS3);
            jQuery("#R3_TSLAMT1").text(selObj.R3_TSLAMT1);
            jQuery("#R3_TSLAMT2").text(selObj.R3_TSLAMT2);
            jQuery("#R3_TSLAMT3").text(selObj.R3_TSLAMT3);
            jQuery("#R3_ECPRT1").text(selObj.R3_ECPRT1);
            jQuery("#R3_ECPRT3").text(selObj.R3_ECPRT3);
            jQuery("#R3_ECPRT2").text(selObj.R3_ECPRT2);
            jQuery("#R3_DBTRT1").text(selObj.R3_DBTRT1);
            jQuery("#R3_DBTRT2").text(selObj.R3_DBTRT2);
            jQuery("#R3_DBTRT3").text(selObj.R3_DBTRT3);
            jQuery("#R3_FLRT1").text(selObj.R3_FLRT1);
            jQuery("#R3_FLRT2").text(selObj.R3_FLRT2);
            jQuery("#R3_FLRT3").text(selObj.R3_FLRT3);
            jQuery("#R3_PSON1").text(selObj.R3_PSON1);
            jQuery("#R3_PSON2").text(selObj.R3_PSON2);
            jQuery("#R3_PSON3").text(selObj.R3_PSON3);
            jQuery("#R3_PSON4").text(selObj.R3_PSON4);
            jQuery("#R3_PSON5").text(selObj.R3_PSON5);
            jQuery("#R3_PSON6").text(selObj.R3_PSON6);
            jQuery("#R3_PSON7").text(selObj.R3_PSON7);
            jQuery("#R3_PSON8").text(selObj.R3_PSON8);
            jQuery("#R3_PSON9").text(selObj.R3_PSON9);
            jQuery("#R3_PSON10").text(selObj.R3_PSON10);
            jQuery("#R3_PSON11").text(selObj.R3_PSON11);
            jQuery("#R3_PSON12").text(selObj.R3_PSON12);
            jQuery("#R3_PSON13").text(selObj.R3_PSON13);
            jQuery("#R3_AML_PSCN011").text(selObj.R3_AML_PSCN011);
            jQuery("#R3_AML_PSCN012").text(selObj.R3_AML_PSCN012);
            jQuery("#R3_AML_PSCN013").text(selObj.R3_AML_PSCN013);
            jQuery("#R3_AML_PSCN021").text(selObj.R3_AML_PSCN021);
            jQuery("#R3_AML_PSCN022").text(selObj.R3_AML_PSCN022);
            jQuery("#R3_AML_PSCN023").text(selObj.R3_AML_PSCN023);
            jQuery("#R3_AML_PSCN031").text(selObj.R3_AML_PSCN031);
            jQuery("#R3_AML_PSCN032").text(selObj.R3_AML_PSCN032);
            jQuery("#R3_AML_PSCN041").text(selObj.R3_AML_PSCN041);
            jQuery("#R3_AML_PSCN042").text(selObj.R3_AML_PSCN042);
            jQuery("#R3_AML_PSCN043").text(selObj.R3_AML_PSCN043);
            jQuery("#R3_AML_PSCN051").text(selObj.R3_AML_PSCN051);
            jQuery("#R3_AML_PSCN052").text(selObj.R3_AML_PSCN052);
            jQuery("#R3_AML_PSCN061").text(selObj.R3_AML_PSCN061);
            jQuery("#R3_AML_PSCN062").text(selObj.R3_AML_PSCN062);
            jQuery("#R3_AML_PSCN063").text(selObj.R3_AML_PSCN063);
            jQuery("#R3_AML_PSCN064").text(selObj.R3_AML_PSCN064);
            jQuery("#R3_AML_PSCN071").text(selObj.R3_AML_PSCN071);
            jQuery("#R3_AML_PSCN072").text(selObj.R3_AML_PSCN072);
            jQuery("#R3_AML_PSCN073").text(selObj.R3_AML_PSCN073);
            jQuery("#R3_AML_PSCN074").text(selObj.R3_AML_PSCN074);
            jQuery("#R3_AML_PSCN081").text(selObj.R3_AML_PSCN081);
            jQuery("#R3_AML_PSCN082").text(selObj.R3_AML_PSCN082);
            jQuery("#R3_AML_PSCN083").text(selObj.R3_AML_PSCN083);
            jQuery("#R3_AML_PSCN084").text(selObj.R3_AML_PSCN084);
            jQuery("#R3_AML_PSCN091").text(selObj.R3_AML_PSCN091);
            jQuery("#R3_AML_PSCN092").text(selObj.R3_AML_PSCN092);
            jQuery("#R3_AML_PSCN093").text(selObj.R3_AML_PSCN093);
            jQuery("#R3_AML_PSCN101").text(selObj.R3_AML_PSCN101);
            jQuery("#R3_AML_PSCN102").text(selObj.R3_AML_PSCN102);
            jQuery("#R3_AML_PSCN111").text(selObj.R3_AML_PSCN111);
            jQuery("#R3_AML_PSCN121").text(selObj.R3_AML_PSCN121);
            jQuery("#R3_AML_PSCN122").text(selObj.R3_AML_PSCN122);
            jQuery("#R3_AML_PSCN131").text(selObj.R3_AML_PSCN131);
        } else {
            jQuery("#R3_HIST").text("");
            jQuery("#R3_TOTAS1").text("");
            jQuery("#R3_TOTAS2").text("");
            jQuery("#R3_TOTAS3").text("");
            jQuery("#R3_EQCT1").text("");
            jQuery("#R3_EQCT2").text("");
            jQuery("#R3_EQCT3").text("");
            jQuery("#R3_FLLBT1").text("");
            jQuery("#R3_FLLBT2").text("");
            jQuery("#R3_FLLBT3").text("");
            jQuery("#R3_FIX_LLBT1").text("");
            jQuery("#R3_FIX_LLBT2").text("");
            jQuery("#R3_FIX_LLBT3").text("");
            jQuery("#R3_FLAST1").text("");
            jQuery("#R3_FLAST2").text("");
            jQuery("#R3_FLAST3").text("");
            jQuery("#R3_NPRFIT1").text("");
            jQuery("#R3_NPRFIT2").text("");
            jQuery("#R3_NPRFIT3").text("");
            jQuery("#R3_COS1").text("");
            jQuery("#R3_COS2").text("");
            jQuery("#R3_COS3").text("");
            jQuery("#R3_TSLAMT1").text("");
            jQuery("#R3_TSLAMT2").text("");
            jQuery("#R3_TSLAMT3").text("");
            jQuery("#R3_ECPRT1").text("");
            jQuery("#R3_ECPRT3").text("");
            jQuery("#R3_ECPRT2").text("");
            jQuery("#R3_DBTRT1").text("");
            jQuery("#R3_DBTRT2").text("");
            jQuery("#R3_DBTRT3").text("");
            jQuery("#R3_FLRT1").text("");
            jQuery("#R3_FLRT2").text("");
            jQuery("#R3_FLRT3").text("");
            jQuery("#R3_PSON1").text("");
            jQuery("#R3_PSON2").text("");
            jQuery("#R3_PSON3").text("");
            jQuery("#R3_PSON4").text("");
            jQuery("#R3_PSON5").text("");
            jQuery("#R3_PSON6").text("");
            jQuery("#R3_PSON7").text("");
            jQuery("#R3_PSON8").text("");
            jQuery("#R3_PSON9").text("");
            jQuery("#R3_PSON10").text("");
            jQuery("#R3_PSON11").text("");
            jQuery("#R3_PSON12").text("");
            jQuery("#R3_PSON13").text("");
            jQuery("#R3_AML_PSCN011").text("");
            jQuery("#R3_AML_PSCN012").text("");
            jQuery("#R3_AML_PSCN013").text("");
            jQuery("#R3_AML_PSCN021").text("");
            jQuery("#R3_AML_PSCN022").text("");
            jQuery("#R3_AML_PSCN023").text("");
            jQuery("#R3_AML_PSCN031").text("");
            jQuery("#R3_AML_PSCN032").text("");
            jQuery("#R3_AML_PSCN041").text("");
            jQuery("#R3_AML_PSCN042").text("");
            jQuery("#R3_AML_PSCN043").text("");
            jQuery("#R3_AML_PSCN051").text("");
            jQuery("#R3_AML_PSCN052").text("");
            jQuery("#R3_AML_PSCN061").text("");
            jQuery("#R3_AML_PSCN062").text("");
            jQuery("#R3_AML_PSCN063").text("");
            jQuery("#R3_AML_PSCN064").text("");
            jQuery("#R3_AML_PSCN071").text("");
            jQuery("#R3_AML_PSCN072").text("");
            jQuery("#R3_AML_PSCN073").text("");
            jQuery("#R3_AML_PSCN074").text("");
            jQuery("#R3_AML_PSCN081").text("");
            jQuery("#R3_AML_PSCN082").text("");
            jQuery("#R3_AML_PSCN083").text("");
            jQuery("#R3_AML_PSCN084").text("");
            jQuery("#R3_AML_PSCN091").text("");
            jQuery("#R3_AML_PSCN092").text("");
            jQuery("#R3_AML_PSCN093").text("");
            jQuery("#R3_AML_PSCN101").text("");
            jQuery("#R3_AML_PSCN102").text("");
            jQuery("#R3_AML_PSCN111").text("");
            jQuery("#R3_AML_PSCN121").text("");
            jQuery("#R3_AML_PSCN122").text("");
            jQuery("#R3_AML_PSCN131").text("");
        }
    	overlay.hide();
    }
    
    function doSearch5(){
    	GridObj5.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch5"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end5
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end5() {
    	//overlay.hide();
    }
    function doSearch6(){
    	GridObj6.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch6"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end6
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end6() {
    	//overlay.hide();
    }
    function doSearch7(){
    	GridObj7.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch7"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end7
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end7() {
    	overlay.hide();
    }
    
    function doSearch8(){
    	GridObj8.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch8"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end8
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end8() {
    	//overlay.hide();
    }
    function doSearch9(){
    	GridObj9.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch9"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end9
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end9() {
    	initChart1();
    }
    function doSearch10(){
    	var BAS_YYMM = form.BAS_YYMM.value;
    	var date; date = new Date(BAS_YYMM.substring(0,4), BAS_YYMM.substring(4,6));
    	
       /*
    	*	date타입에서 month의 인덱스는 1월이 0이므로 한달전의 값을 원하면 -2해줘야함 (663라인)
    	*	위와 같은이유로 날짜계산이후 +1해준다 (664라인)
    	*	==> 이렇게 변환하는 이유는 String으로 받은 날짜값을 date타입으로 변환해서 한달을 빼고 다시 String으로 바꾸기때문. 
    	*/
    	date.setMonth(date.getMonth() - 2);
    	var month = String(date.getMonth() + 1);
    	if (month.length == 1) {
    		month = '0' + month;
    	}
    	var BAS_YYMM2 = date.getFullYear() + month;
    	
    	GridObj10.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch10"
               ,"BAS_YYMM"  : BAS_YYMM
               ,"BAS_YYMM2" : BAS_YYMM2
            }
           ,completedEvent : doSearch_end10
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end10() {
    	initChart2();
    	overlay.hide();
    }
    
    function doSearch11(){
    	GridObj11.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch11"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end11
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end11() {
    	var gridCnt = GridObj11.rowCount();
	   	var gridInstance; gridInstance = $("#GTDataGrid11_Area").dxDataGrid('instance');
	   	if(gridCnt>0) {
			var selObj = GridObj11.getRow(0);
			
			if(selObj.BAS_YYMM3 == selObj.BAS_YYMM1)
				gridInstance.columnOption('TAB3', 'caption','NO-DATA');
			else
				gridInstance.columnOption('TAB3', 'caption',selObj.BAS_YYMM3 +'월');
			
			if(selObj.BAS_YYMM2 == selObj.BAS_YYMM1)
				gridInstance.columnOption('TAB2', 'caption','NO-DATA');
			else
			    gridInstance.columnOption('TAB2', 'caption',selObj.BAS_YYMM2 +'월');
			
	        gridInstance.columnOption('TAB1', 'caption',selObj.BAS_YYMM1 +'월(금년)');
		}else{
			gridInstance.columnOption('TAB3', 'caption','NO-DATA');
	        gridInstance.columnOption('TAB2', 'caption','NO-DATA');
	        gridInstance.columnOption('TAB1', 'caption','NO-DATA');
	        
		}
        overlay.hide();
    }
    function doSearch12(){
    	GridObj12.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch12"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end12
           ,failEvent : function(e){overlay.hide();}
        });
    }
    
    function doSearch_end12() {
    	var gridCnt = GridObj12.rowCount();
	   	var gridInstance; gridInstance = $("#GTDataGrid12_Area").dxDataGrid('instance');
	   	
	   	if(gridCnt>0) {
			var selObj = GridObj12.getRow(0);

			if(selObj.BAS_YYMM3 == selObj.BAS_YYMM1)
				gridInstance.columnOption('TAB3', 'caption','NO-DATA');
			else
				gridInstance.columnOption('TAB3', 'caption',selObj.BAS_YYMM3 +'월');
			
			if(selObj.BAS_YYMM2 == selObj.BAS_YYMM1)
				gridInstance.columnOption('TAB2', 'caption','NO-DATA');
			else
			    gridInstance.columnOption('TAB2', 'caption',selObj.BAS_YYMM2 +'월');
			
	        gridInstance.columnOption('TAB1', 'caption',selObj.BAS_YYMM1 +'월(금년)');
		}else{
			gridInstance.columnOption('TAB3', 'caption','NO-DATA');
	        gridInstance.columnOption('TAB2', 'caption','NO-DATA');
	        gridInstance.columnOption('TAB1', 'caption','NO-DATA');
		}
        overlay.hide();
    }
    function doSearch13(){
    	GridObj13.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch13"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end13
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end13() {
    	var gridCnt = GridObj13.rowCount();
	   	var gridInstance; gridInstance = $("#GTDataGrid13_Area").dxDataGrid('instance');
	   	if(gridCnt>0) {
			var selObj = GridObj13.getRow(0);
			
			if(selObj.BAS_YYMM3 == selObj.BAS_YYMM1)
				gridInstance.columnOption('TAB3', 'caption','NO-DATA');
			else
				gridInstance.columnOption('TAB3', 'caption',selObj.BAS_YYMM3 +'월');
			
			if(selObj.BAS_YYMM2 == selObj.BAS_YYMM1)
				gridInstance.columnOption('TAB2', 'caption','NO-DATA');
			else
			    gridInstance.columnOption('TAB2', 'caption',selObj.BAS_YYMM2 +'월');
			
	        gridInstance.columnOption('TAB1', 'caption',selObj.BAS_YYMM1 +'월(금년)');
		}else{
			gridInstance.columnOption('TAB3', 'caption','NO-DATA');
	        gridInstance.columnOption('TAB2', 'caption','NO-DATA');
	        gridInstance.columnOption('TAB1', 'caption','NO-DATA');
		}
        overlay.hide();
    }
    function doSearch14(){
    	GridObj14.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch14"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end14
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end14() {
    	var gridCnt = GridObj14.rowCount();
	   	var gridInstance; gridInstance = $("#GTDataGrid14_Area").dxDataGrid('instance');
	   	
	   	if(gridCnt>0) {
	   		var BAS_YYMM; BAS_YYMM = form.BAS_YYMM.value;
	    	var date; date = new Date(BAS_YYMM.substring(0,4), BAS_YYMM.substring(4,6));
	    	
	       /*
	    	*	date타입에서 month의 인덱스는 1월이 0이므로 한달전의 값을 원하면 -2해줘야함
	    	*	위와 같은이유로 날짜계산이후 +1해준다
	    	*	==> 이렇게 변환하는 이유는 String으로 받은 날짜값을 date타입으로 변환해서 한달을 빼고 다시 String으로 바꾸기때문. 
	    	*/
	    	date.setMonth(date.getMonth() - 2);
	    	var month = String(date.getMonth() + 1);
	    	if (month.length == 1) {
	    		month = '0' + month;
	    	}
	    	
	    	var year1 = date.getFullYear();
	    	var year2 = year1 - 1;
	    	
		   	var months = ["01","02","03","04","05","06","07","08","09","10","11","12"];
		   	var temp; temp = new Array();
			var index = 0;
			for (var i = 0; i < months.length; i++) {
				if (month == months[i]) {
					index = i;
				}
			}
			
			// 선택한 평가기준월에 따라 그리드에 보여지는 컬럼값 셋팅
			var index2 = 0;
			for (var i = index; i >= 0; i--) {
				if (i == index) {
					temp[index2] = year1+'年 '+parseInt(months[i]);
				} else {
					temp[index2] = parseInt(months[i]);
				}
				index2++;
			}
			for (var i = months.length-1; i > index; i--) {
				if (i == months.length-1) {
					temp[index2] = year2+'年 '+parseInt(months[i]);
				} else {
					temp[index2] = parseInt(months[i]);
				}
				index2++;
			}
			
			gridInstance.columnOption('TAB1', 'caption', temp[0]+'月');
			gridInstance.columnOption('TAB2', 'caption', temp[1]+'月');
			gridInstance.columnOption('TAB3', 'caption', temp[2]+'月');
			gridInstance.columnOption('TAB4', 'caption', temp[3]+'月');
			gridInstance.columnOption('TAB5', 'caption', temp[4]+'月');
			gridInstance.columnOption('TAB6', 'caption', temp[5]+'月');
			gridInstance.columnOption('TAB7', 'caption', temp[6]+'月');
			gridInstance.columnOption('TAB8', 'caption', temp[7]+'月');
			gridInstance.columnOption('TAB9', 'caption', temp[8]+'月');
			gridInstance.columnOption('TAB10','caption', temp[9]+'月');
			gridInstance.columnOption('TAB11','caption', temp[10]+'月');
			gridInstance.columnOption('TAB12','caption', temp[11]+'月');
			
		}else{
			gridInstance.columnOption('TAB1', 'caption', '1月');
			gridInstance.columnOption('TAB2', 'caption', '2月');
			gridInstance.columnOption('TAB3', 'caption', '3月');
			gridInstance.columnOption('TAB4', 'caption', '4月');
			gridInstance.columnOption('TAB5', 'caption', '5月');
			gridInstance.columnOption('TAB6', 'caption', '6月');
			gridInstance.columnOption('TAB7', 'caption', '7月');
			gridInstance.columnOption('TAB8', 'caption', '8月');
			gridInstance.columnOption('TAB9', 'caption', '9月');
			gridInstance.columnOption('TAB10','caption', '10月');
			gridInstance.columnOption('TAB11','caption', '11月');
			gridInstance.columnOption('TAB12','caption', '12月');
		}
	   	
	   	initChart3(gridCnt); // 차트3 화면셋팅
    	overlay.hide();
    }
    
    function doSearch15(){
    	GridObj15.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch15"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end15
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end15() {
    	//overlay.hide();
    }
    
    function doSearch16(){
    	GridObj16.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch16"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end16
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end16() {
    	var gridCnt; gridCnt   = GridObj16.rowCount();
        var arrColIds; arrColIds = GridObj16.getColumnIDs();
    	
        if(gridCnt>0) {
            var selObj = GridObj16.getRow(0);
            jQuery("#R3_SUMMY").html(selObj.R3_SUMMY);
            jQuery("#R7_TASK").html(selObj.R7_TASK);
            jQuery("#R7_PLAN").text(selObj.R7_PLAN);
            jQuery("#R7_DIREC").text(selObj.R7_DIREC);
        } else {
            jQuery("#R3_SUMMY").text("");
            jQuery("#R7_TASK").text("");
            jQuery("#R7_PLAN").text("");
            jQuery("#R7_DIREC").text("");
        }
    	overlay.hide();
    }
    
    function doSearch17(){
    	GridObj17.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "getSearch17"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
            }
           ,completedEvent : doSearch_end17
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSearch_end17() {
    	var gridCnt   = GridObj17.rowCount();
        var arrColIds; arrColIds = GridObj17.getColumnIDs();

       	form.R8_ETC_LIST.value = '';
        if(gridCnt>0) {
            var selObj = GridObj17.getRow(0);
            form.R8_ETC_LIST.value = selObj.R8_ETC_LIST;
        }
    	overlay.hide();
    }
    
    function doSave() {
    	overlay.show(true, true);
    	GridObj1.save({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "doSave"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
               ,"R1_AIM"	: form.R1_AIM.value
               ,"R1_VALT_RSLT"	: form.R1_VALT_RSLT.value
               ,"R1_IMPRV_PLAN"	: form.R1_IMPRV_PLAN.value
            }
           ,completedEvent : doSave_end
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doSave_end() {
    	doSearch();
    }
    
    function doSave2() {
    	overlay.show(true, true);
    	GridObj1.save({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "doSave2"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
               ,"R2_AIM"	: form.R2_AIM.value
            }
           ,completedEvent : doSave_end
           ,failEvent : function(e){overlay.hide();}
        });
    }

    function doSave3() {
    	overlay.show(true, true);
    	GridObj1.save({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "doSave3"
               ,"BAS_YYMM"  : form.BAS_YYMM.value
               ,"R3_HIST"		 :	form.R3_HIST.value	
           	   ,"R3_TOTAS1"		 :	form.R3_TOTAS1.value	
           	   ,"R3_TOTAS2"		 :	form.R3_TOTAS2.value	
           	   ,"R3_TOTAS3"		 :	form.R3_TOTAS3.value	
           	   ,"R3_EQCT1"		 :	form.R3_EQCT1.value	
           	   ,"R3_EQCT2"		 :	form.R3_EQCT2.value	
           	   ,"R3_EQCT3"		 :	form.R3_EQCT3.value	
           	   ,"R3_FLLBT1"		 :	form.R3_FLLBT1.value	
           	   ,"R3_FLLBT2"		 :	form.R3_FLLBT2.value	
           	   ,"R3_FLLBT3"		 :	form.R3_FLLBT3.value	
           	   ,"R3_FIX_LLBT1"	 :	form.R3_FIX_LLBT1.value	
           	   ,"R3_FIX_LLBT2"	 :	form.R3_FIX_LLBT2.value	
           	   ,"R3_FIX_LLBT3"	 :	form.R3_FIX_LLBT3.value	
           	   ,"R3_FLAST1"		 :	form.R3_FLAST1.value	
           	   ,"R3_FLAST2"		 :	form.R3_FLAST2.value	
           	   ,"R3_FLAST3"		 :	form.R3_FLAST3.value	
           	   ,"R3_NPRFIT1"	 :	form.R3_NPRFIT1.value	
           	   ,"R3_NPRFIT2"	 :	form.R3_NPRFIT2.value	
           	   ,"R3_NPRFIT3"	 :	form.R3_NPRFIT3.value	
           	   ,"R3_COS1"	 	 :	form.R3_COS1.value	
           	   ,"R3_COS2"	 	 :	form.R3_COS2.value	
           	   ,"R3_COS3"	 	 :	form.R3_COS3.value	
           	   ,"R3_TSLAMT1"	 :	form.R3_TSLAMT1.value	
           	   ,"R3_TSLAMT2"	 :	form.R3_TSLAMT2.value	
           	   ,"R3_TSLAMT3"	 :	form.R3_TSLAMT3.value	
           	   ,"R3_ECPRT1"		 :	form.R3_ECPRT1.value	
           	   ,"R3_ECPRT3"		 :	form.R3_ECPRT3.value	
           	   ,"R3_ECPRT2"		 :	form.R3_ECPRT2.value	
           	   ,"R3_DBTRT1"		 :	form.R3_DBTRT1.value	
           	   ,"R3_DBTRT2"		 :	form.R3_DBTRT2.value	
           	   ,"R3_DBTRT3"		 :	form.R3_DBTRT3.value	
           	   ,"R3_FLRT1"		 :	form.R3_FLRT1.value	
           	   ,"R3_FLRT2"		 :	form.R3_FLRT2.value	
           	   ,"R3_FLRT3"		 :	form.R3_FLRT3.value	
           	   ,"R3_PSON1"		 :	form.R3_PSON1.value	
           	   ,"R3_PSON2"		 :	form.R3_PSON2.value	
           	   ,"R3_PSON3"		 :	form.R3_PSON3.value	
           	   ,"R3_PSON4"		 :	form.R3_PSON4.value	
           	   ,"R3_PSON5"		 :	form.R3_PSON5.value	
           	   ,"R3_PSON6"		 :	form.R3_PSON6.value	
           	   ,"R3_PSON7"		 :	form.R3_PSON7.value	
           	   ,"R3_PSON8"		 :	form.R3_PSON8.value	
           	   ,"R3_PSON9"		 :	form.R3_PSON9.value	
           	   ,"R3_PSON10"		 :	form.R3_PSON10.value	
           	   ,"R3_PSON11"		 :	form.R3_PSON11.value	
           	   ,"R3_PSON12"		 :	form.R3_PSON12.value	
           	   ,"R3_PSON13"		 :	form.R3_PSON13.value	
           	   ,"R3_AML_PSCN011" :	form.R3_AML_PSCN011.value	
           	   ,"R3_AML_PSCN012" :	form.R3_AML_PSCN012.value	
           	   ,"R3_AML_PSCN013" :	form.R3_AML_PSCN013.value	
           	   ,"R3_AML_PSCN021" :	form.R3_AML_PSCN021.value	
           	   ,"R3_AML_PSCN022" :	form.R3_AML_PSCN022.value	
           	   ,"R3_AML_PSCN023" :	form.R3_AML_PSCN023.value	
           	   ,"R3_AML_PSCN031" :	form.R3_AML_PSCN031.value	
           	   ,"R3_AML_PSCN032" :	form.R3_AML_PSCN032.value	
           	   ,"R3_AML_PSCN041" :	form.R3_AML_PSCN041.value	
           	   ,"R3_AML_PSCN042" :	form.R3_AML_PSCN042.value	
           	   ,"R3_AML_PSCN043" :	form.R3_AML_PSCN043.value	
           	   ,"R3_AML_PSCN051" :	form.R3_AML_PSCN051.value	
           	   ,"R3_AML_PSCN052" :	form.R3_AML_PSCN052.value	
           	   ,"R3_AML_PSCN061" :	form.R3_AML_PSCN061.value	
           	   ,"R3_AML_PSCN062" :	form.R3_AML_PSCN062.value	
           	   ,"R3_AML_PSCN063" :	form.R3_AML_PSCN063.value	
           	   ,"R3_AML_PSCN064" :	form.R3_AML_PSCN064.value	
           	   ,"R3_AML_PSCN071" :	form.R3_AML_PSCN071.value	
           	   ,"R3_AML_PSCN072" :	form.R3_AML_PSCN072.value	
           	   ,"R3_AML_PSCN073" :	form.R3_AML_PSCN073.value	
           	   ,"R3_AML_PSCN074" :	form.R3_AML_PSCN074.value	
           	   ,"R3_AML_PSCN081" :	form.R3_AML_PSCN081.value	
           	   ,"R3_AML_PSCN082" :	form.R3_AML_PSCN082.value	
           	   ,"R3_AML_PSCN083" :	form.R3_AML_PSCN083.value	
           	   ,"R3_AML_PSCN084" :	form.R3_AML_PSCN084.value	
           	   ,"R3_AML_PSCN091" :	form.R3_AML_PSCN091.value	
           	   ,"R3_AML_PSCN092" :	form.R3_AML_PSCN092.value	
           	   ,"R3_AML_PSCN093" :	form.R3_AML_PSCN093.value	
           	   ,"R3_AML_PSCN101" :	form.R3_AML_PSCN101.value	
           	   ,"R3_AML_PSCN102" :	form.R3_AML_PSCN102.value	
           	   ,"R3_AML_PSCN111" :	form.R3_AML_PSCN111.value	
           	   ,"R3_AML_PSCN121" :	form.R3_AML_PSCN121.value	
           	   ,"R3_AML_PSCN122" :	form.R3_AML_PSCN122.value	
           	   ,"R3_AML_PSCN131" :	form.R3_AML_PSCN131.value	
            }
           ,completedEvent : doSave_end
           ,failEvent : function(e){overlay.hide();}
        });
    }
    
    function doSave4() {
    	overlay.show(true, true);
    	GridObj1.save({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "doSave4"
			   ,"BAS_YYMM"  : form.BAS_YYMM.value
               ,"R3_SUMMY"  : form.R3_SUMMY.value
               ,"R7_TASK"	: form.R7_TASK.value
               ,"R7_PLAN"	: form.R7_PLAN.value
               ,"R7_DIREC"	: form.R7_DIREC.value
            }
           ,completedEvent : doSave_end
           ,failEvent : function(e){overlay.hide();}
        });
    }
    
    function doSave5() {
    	overlay.show(true, true);
    	GridObj1.save({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "doSave5"
			   ,"BAS_YYMM"  : form.BAS_YYMM.value
               ,"R8_ETC_LIST"  : form.R8_ETC_LIST.value
            }
           ,completedEvent : doSave_end
           ,failEvent : function(e){overlay.hide();}
        });
    }
    
    /** 툴바 버튼 설정 */
    function makeToolbarButtonGrids(e)
    {
        var cmpnt; cmpnt = e.component;
        var useYN = "${outputAuth.USE_YN  }";  // 사용 유무
        var authC = "${outputAuth.C       }";  // 추가,수정 권한
        var authD = "${outputAuth.D       }";  // 삭제 권한
        
        if (useYN=="Y") {
            var gridID       = e.element.attr("id");    // 그리드 아이디
            var toolbarItems = e.toolbarOptions.items;
            toolbarItems.splice(0, 0, {
                "locateInMenu"  : "auto"
                ,"location"     : "after"
                ,"widget"       : "dxButton"
                ,"name"         : "refreshButton"
                ,"showText"     : "inMenu"
                ,"options"      : {
                         "icon"      : "pulldown"   
                        ,"hint"      : '새로고침'
                        ,"disabled"  : false
                        ,"onClick"   : doSearch2
                 }
            });
            var btnLastIndex=0;
            for(;btnLastIndex<toolbarItems.length; btnLastIndex++){
                if(toolbarItems[btnLastIndex].widget != "dxButton") {
                    break;
                }
            }
            if (authD=="Y") {
            	if (gridID=="GTDataGrid2_Area") {
	                toolbarItems.splice(btnLastIndex, 0, {
	                    "locateInMenu" : "auto"
	                   ,"location"     : "after"
	                   ,"widget"       : "dxButton"
	                   ,"name"         : "removeButton"
	                   ,"showText"     : "always"
	                   ,"options"      : {
	                            "icon"      : "remove"   
	                           ,"text"      : '행삭제'
	                           ,"hint"      : '행을 삭제'
	                           ,"disabled"  : false
	                           ,"onClick"   : doDelete
	                     }
	                });
            	} else if (gridID=="GTDataGrid3_Area") {
            		toolbarItems.splice(btnLastIndex, 0, {
	                    "locateInMenu" : "auto"
	                   ,"location"     : "after"
	                   ,"widget"       : "dxButton"
	                   ,"name"         : "removeButton"
	                   ,"showText"     : "always"
	                   ,"options"      : {
	                            "icon"      : "remove"   
	                           ,"text"      : '행삭제'
	                           ,"hint"      : '행을 삭제'
	                           ,"disabled"  : false
	                           ,"onClick"   : doDelete2
	                     }
	                });
            	}
            }
            if (authC=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "saveButton") {
                        item.showText           = "always";
                        item.widget             = "dxButton";
                        item.options.text       = '저장';
                        item.options.disabled   = false;
                        item.options.onClick    = function(){
                        	if (gridID=="GTDataGrid2_Area") {
	                        	gridSave(cmpnt);
                            } else if (gridID=="GTDataGrid3_Area") {
	                        	gridSave2(cmpnt);
                            } else if (gridID=="GTDataGrid15_Area") {
	                        	gridSave3(cmpnt);
                            }
                        }
                    } else if (item.name === "addRowButton") {
                        item.showText           = "always";
                        item.options.text       = '행추가';
                        item.options.disabled   = false;
                        item.options.onClick    = function(){
                        	overlay.show(true, true);
                            addRowGrid(cmpnt);
                        }
                    }
                });
            }
            if (authC=="Y"||authD=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "revertButton") {
                        item.showText           = "always";
                        item.options.text       = '취소';
                        item.options.disabled   = false;
                        return;
                    }
                });
            }
        }
    }
    
    function addRowGrid(cmpnt) {
        try {
            cmpnt.pageIndex(0);
            cmpnt.addRow();
            cmpnt.saveEditData();
            cmpnt.columnOption('SNO', 'sortOrder', 'desc');
            setTimeout(function(){cmpnt.selectRowsByIndexes([0]);cmpnt.editCell(0,1);},100);
        } catch (e) {
            alert(e);
        } finally {
            overlay.hide();
            //GridObj2.removeAll()
        }
    }
    function doDelete() {
        var selectedRows = GridObj2.getSelectedRowsData();
        var selSize = selectedRows.length;
        if (selSize==0) {
            alert("${msgel.getMsg('AML_10_01_01_01_006','삭제할 데이타를 선택하십시오.')}"); 
            return;
        }
        if (!confirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}")) return;
        
        GridObj2.save({    
            actionParam     : {
                "pageID"    : pageID
               ,"classID"   : classID
               ,"BAS_YYMM"  : form.BAS_YYMM.value
               ,"methodID"  : "doDelete"
            }
           ,sendFlag        : "SELECTED"
           ,completedEvent  : doSearch
        });
    }
    function doDelete2() {
        var selectedRows = GridObj3.getSelectedRowsData();
        var selSize = selectedRows.length;
        if (selSize==0) {
            alert("${msgel.getMsg('AML_10_01_01_01_006','삭제할 데이타를 선택하십시오.')}"); 
            return;
        }
        if (!confirm("${msgel.getMsg('AML_10_01_01_01_007','삭제하시겠습니까?')}")) return;
        
        GridObj3.save({    
            actionParam     : {
                "pageID"    : pageID
               ,"classID"   : classID
               ,"BAS_YYMM"  : form.BAS_YYMM.value
               ,"methodID"  : "doDelete2"
            }
           ,sendFlag        : "SELECTED"
           ,completedEvent  : doSearch
        });
    }
    function gridSave(gi) {
        gi.saveEditData();
        var rowsData = GridObj2.getSelectedRowsData();
        if (rowsData.length==0) {
            alert("${msgel.getMsg('AML_10_01_01_01_003','저장할 데이타를 선택하십시오.')}");
            return;
        }
        if(confirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}")) {
            GridObj2.save({
                actionParam     : {
                    "pageID"    : pageID
                   ,"classID"   : classID
                   ,"BAS_YYMM"  : form.BAS_YYMM.value
                   ,"methodID"  : "gridSave"
                }
               ,sendFlag        : "USERDATA"
               ,userGridData    : rowsData
               ,completedEvent  : doSearch
            });
        }
    }
    function gridSave2(gi) {
        gi.saveEditData();
        var rowsData = GridObj3.getSelectedRowsData();
        if (rowsData.length==0) {
            alert("${msgel.getMsg('AML_10_01_01_01_003','저장할 데이타를 선택하십시오.')}");
            return;
        }
        if(confirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}")) {
            GridObj3.save({
                actionParam     : {
                    "pageID"    : pageID
                   ,"classID"   : classID
                   ,"BAS_YYMM"  : form.BAS_YYMM.value
                   ,"methodID"  : "gridSave2"
                }
               ,sendFlag        : "USERDATA"
               ,userGridData    : rowsData
               ,completedEvent  : doSearch
            });
        }
    }
    function gridSave3(gi) {
        gi.saveEditData();
        var rowsData = GridObj15.getSelectedRowsData();
        if (rowsData.length==0) {
            alert("${msgel.getMsg('AML_10_01_01_01_003','저장할 데이타를 선택하십시오.')}");
            return;
        }
        if(confirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}")) {
        	GridObj15.save({
                actionParam     : {
                    "pageID"    : pageID
                   ,"classID"   : classID
                   ,"BAS_YYMM"  : form.BAS_YYMM.value
                   ,"methodID"  : "gridSave3"
                }
               ,sendFlag        : "USERDATA"
               ,userGridData    : rowsData
               ,completedEvent  : doSearch
            });
        }
    }
    
    function doExcelMake() {
    	if (form.existFile.value == 'Y') {
    		if (!confirm("이미 생성된 파일이 존재합니다. 계속 진행하겠습니까?")) {
	    		return;
    		}
    	}
    	if (!confirm("보고파일을 생성 하시겠습니까 ? 생성시간은 20 ~ 30분 소요됩니다.")) return;    	
    	var BAS_YYMM = form.BAS_YYMM.value;
    	var date; date = new Date(BAS_YYMM.substring(0,4), BAS_YYMM.substring(4,6));
    	
    	var month = String(date.getMonth() - 1);
    	if (month.length == 1) {
    		month = '0' + month;
    	}
    	var BAS_YYMM2 = date.getFullYear() + month;

    	clearInterval(intervalResult);
    	
    	intervalResult = setInterval(function(){
    		doSearchSC();
    	},5000);
    	  	
    	GridObj1.refresh({
            actionParam : {
            	"pageID"  	: pageID
               ,"classID" 	: classID
               ,"methodID"	: "makeExcelFile"
               ,"BAS_YYMM"  : BAS_YYMM
               ,"BAS_YYMM2"  : BAS_YYMM2
            }
           ,completedEvent : doExcelMake_end
           ,failEvent : function(e){overlay.hide();}
        });
    }
    function doExcelMake_end() {
    	alert("${msgel.getMsg('RBA_50_07_03_002','엑셀 파일생성이 완료되었습니다.')}");
    	doSearch();
    }
    
    function doExcelDown() {
    	if (form.existFile.value == 'N') {
    		alert("${msgel.getMsg('RBA_50_07_03_003','선택하신 평가기준월은 보고파일생성 후에 다운로드가 가능합니다.')}");
    		return;
    	}
    	
    	var url  = "<c:url value='/'/>Package/RBA/common/fileDown/RBA_50_07_03_01_ExcelFileDownload.jsp";
    	form2.BAS_YYMM.value	= form.BAS_YYMM.value;
		form2.action 			= url;
		form2.target 			= '_self';
		form2.method    		= "post";  
		form2.submit();
    }

</script>

<form name="form2" method="post">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID">
    <input type="hidden" name="methodID">
    <input type="hidden" name="BAS_YYMM">
    <input type="hidden" name="GRID_CNT">
</form>

<form name="form">
    <input type="hidden" name="pageID">
    <input type="hidden" name="classID"> 
    <input type="hidden" name="methodID"> 
    <input type="hidden" name="FY1"> 
    <input type="hidden" name="FY2"> 
    <input type="hidden" name="FY3"> 

    <div class="panel panel-primary" style="visibility:hidden;">
	    <div class="panel-footer" style="display:none;">
	        <div id="GTDataGrid1_Area" style="display:none;"></div>
	    </div>
	</div>
    <div class="panel panel-primary" style="visibility:hidden;">
	    <div class="panel-footer" style="display:none;">
	        <div id="GTDataGrid4_Area" style="display:none;"></div>
	    </div>
	</div>
    <div class="panel panel-primary" style="visibility:hidden;">
	    <div class="panel-footer" style="display:none;">
	        <div id="GTDataGrid16_Area" style="display:none;"></div>
	    </div>
	</div>
    <div class="panel panel-primary" style="visibility:hidden;">
	    <div class="panel-footer" style="display:none;">
	        <div id="GTDataGrid17_Area" style="display:none;"></div>
	    </div>
	</div>
    
    <div class="cond-box" id='condBox1' style="width:98%;">
        <div class="cond-row">
            <div class="cond-item">
                ${condel.getLabel('RBA_50_03_02_001','평가기준월')}
                ${RBACondEL.getRBASelect('BAS_YYMM','' ,'RBAS_common_getComboData_BasYear','','' ,'' ,'doSearch()')}
            </div>
	        <div class="cond-item">
	            ${condel.getLabel('RBA_50_07_03_001','보고파일생성여부')}
	            <input name="existFile" id="existFile" type="text" style="text-align:center" class="cond-input-text" size="3" readonly />
	        </div>
	        <div class="cond-item">
	            ${condel.getLabel('RBA_50_07_03_004','파일생성 진행상태')}
	            <input name="RBA_RPT_MK_S_C_NM" id="RBA_RPT_MK_S_C_NM" type="text" style="text-align:center" class="cond-input-text" size="15" readonly />
	        </div>
        </div>
        <div class="cond-line"></div>
        <div class="cond-btn-row" style="text-align:right">
            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"excelMakeBtn", defaultValue:"보고파일생성", mode:"C", function:"doExcelMake", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
            ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"excelDownBtn", defaultValue:"보고파일다운로드", mode:"C", function:"doExcelDown", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
        </div>
    </div>
    <div class="popup-cont-box tab-cont-box" style="height:72vh; width:98%; margin-left:13px;">
        <div id="tabCont1" style="margin: 5px;">
        
        
<!--------------------------- 1번째탭  Executive Summary --------------------------->
            <div id="div0" title="Executive Summary" style="height:98%; width:98%; margin-left:10px; margin-right:10px;">
	        	<div class="cond-btn-row" style="height:98%; width:98%; margin-left:10px; margin-right:10px; text-align:right">
		            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
		        </div>
                <font size=3 style="font-weight:bold;color:#757575;"> ■ 자금세탁 위험평가 배경 및 목적 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:10px;">
                    <table width="98%" border="0" class="hover" style="width:94vw">
                        <tr>
                            <th width="10%" style="border-right:1px solid #cccccc;"><b>내용</b></th>
                        </tr>
                        <tr>
                            <td width="10%" align="left">
                            	<b>
                            	<span style="color:blue">[샘플]</span> 2012년 강화된 자금세탁방지 국제기준(FATF의 40권고안) 발표 및 2019년 FATF 국가 상호평가에 대비하여 2017년 6월 금융정보분석원은 금융투자회사의 새로운 관점의 AML 위험식별 및 평가체계인 위험기반접근(RBA)기반의 AML을 도입, 이행을 제시하였습니다. 위험기반접근(RBA)도입에 따라 금융기관은 기존의 모든 AML 관리영역(내부통제, 고객확인, 모니터링 등)에서 체계적으로 위험을 인식, 평가하고 이에 대하여 사전/사후적으로 대응 할 수 있는 정교화된 위험관리체계를 갖추도록 요구되었습니다.<br><br> 
								이에 <span style="color:red">[###증권]</span>은 위험기반접근(RBA)기반 자금세탁 위험평가체계를 구축하여 사후 모니터링중심에서 ML/TF 발생위험을 사전에 인식하는 위험사건 발생원인에 초점을 맞춰 리스크를 식별 및 관리하고 고위험 영역 집중 관리를 통한 리스크 관리 자원의 선택과 집중을 목표로 합니다. 이를 통해 ‘금융회사 AML/CFT 위험기반 접근법(RBA) 처리기준’의 금융당국 요구사항을 준수하고 최고  경영진이 주기적으로  ML/TF 리스크 정보를 요약 보고 받아 리스크 측면에서 Business 의사결정을 실질적으로 지원하고 있습니다.
								</b>
							</td>
                        </tr>
                        <tr>
                        	<td>
								<textarea style="resize:none;" id="R1_AIM" rows="5"></textarea>
                        	</td>
                        </tr>
                    </table>
                </div>
                <br>
                <font size=3 style="font-weight:bold;color:#757575;">■ 자금세탁 평가 대상 및 평가결과 요약</font>
                <div class="table-box" style="margin-top:5px; margin-bottom:10px;">
                    <table width="98%" border="0" class="hover" style="width:94vw">
                        <tr>
                            <th width="10%" style="border-right:1px solid #cccccc;"><b>내용</b></th>
                        </tr>
                        <tr>
                            <td width="10%" align="left">
                            	<b>
                            	<span style="color:blue">[샘플]</span> 당사는 직제 및 업무 규정 등을 통해 업무 및 거래특성을 감안하여 발생될 수 있는 ML/TF 위험을 빠짐없이 고려하였으며, <span style="color:red">[보고일]</span> 기준으로 총 <span style="color:red">[##]</span> 개의 AML 업무 프로세스를 도출하였습니다. 해당 AML 업무 프로세스와 관련된 ML/TF 위험을 현업 업무 부서가 스스로 식별, 분석, 평가하도록 하는 자발적 리스크관리 문화를 제도화하기 위하여, <span style="color:red">[보고년도]</span> 년도 전사의 RBA 위험평가를 총 <span style="color:red">[RBA위험평가 횟수]</span> 회 실시하였습니다.<br><br> 
								자금세탁방지 전담부서를 포함한 총 <span style="color:red">[RBA 위험평가 참여 부서 개수]</span> 개의 업무 부서가 RBA 위험평가에 참여하였으며, 전사 기준으로 <span style="color:red">[고위험 최다 발생 업무 프로세스]</span>에서 가장 많은 ML/TF 위험이 높은 것으로 분석되었습니다. 따라서, 해당 AML 업무 프로세스가 고위험으로 모니터링된 <span style="color:red">[업무 프로세스 고위험 대상 부서 수]</span>개의 부서로부터 대응방안을 수립하는 등 ML/TF 위험을 효과적으로 관리하거나 완화하기 위한 정책, 통제활동 및 절차를 수행하였습니다.
								</b>
							</td>
                        </tr>
                        <tr>
                        	<td>
                            	<textarea style="resize:none;" id="R1_VALT_RSLT" rows="5"></textarea>
                        	</td>
                       	</tr>
                    </table>
                </div>
                <font size=3 style="font-weight:bold;color:#757575;">■ 자금세탁 평가 대상 및 평가결과 요약</font>
                <div class="table-box" style="margin-top:5px; margin-bottom:10px;">
                    <table width="98%" class="hover" style="width:94vw">
                        <tr>
                            <th width="10%" style="border-right:1px solid #cccccc;"><b>내용</b></th>
                        </tr>
                        <tr>
                            <td width="10%" align="left">
                            	<span style="color:red">[당사의 RBA 위험평가 결과 및 수행 내역에 따른 주요 발견사항 및 향후 개선 계획 요약하여 작성]</span>
							</td>
                        </tr>
                        <tr>
                        	<td>
                            	<textarea style="resize:none;" id="R1_IMPRV_PLAN" rows="5"></textarea>
                        	</td>
                       	</tr>
                    </table>
                </div>
            </div>
<!--------------------------- 2번째탭  자금세탁위험평가개요 --------------------------->
            <div id="div1" title="자금세탁위험평가개요" style="height:98%; margin-left:10px; margin-right:10px;">
                <div class="cond-btn-row" style="height:98%; width:98%; margin-left:10px; margin-right:10px; text-align:right">
		            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave2", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
		        </div>
                <font size=3 style="font-weight:bold;color:#757575;"> ■ 자금세탁 위험평가 배경 및 목적 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:10px;">
                    <table width="98%" border="0" class="hover" style="width:94vw">
                        <tr>
                            <th width="10%" style="border-right:1px solid #cccccc;"><b>내용</b></th>
                        </tr>
                        <tr>
                            <td width="10%" align="left">
                            	<b>
	                            <span style="color:blue">[샘플]</span> 2012년 강화된 FATF 국제기준 내에 "금융회사가 위험기반(Risk-Based Approach) 내부통제 프로그램을 갖출 것"을 명시하고 있으며, 이로 인해 미국 등 감독당국은 자금세탁방지의무 위반 및 관련 내부통제에 대한 감독을 강화하고 위반 시 엄격한 제재를 부과하고 있습니다. 실제로 2017년 기준, NH농협은행, BNP Paribas, 크레딧스위스 등 다수의 상업은행 및 투자금융회사가 자금세탁방지 관련 규정 위반으로 벌금이 부과된 사례를 찾아 볼 수 있었습니다. 따라서, 자금세탁방지 및 테러자금조달 차단을 위한 국제사회 공동의 노력과 상호협력이 강조되었으며, 2017년 7월 G20 정상회의에서 테러자금조달 차단을 위한 구체적인 이행방안이 제시되고 FATF 기준 이행의 중요성에 대한 국제적 의식이 고조되어 왔습니다.<br><br> 
								국내에서도 FATF 회원국 상호평가(2018년 11~2019년 10월)를 위해 범 국가적 차원에서 다양한 대비가 진행되고 있으며, 2017년 10월 금융회사 지배구조 감독규정 내에 RBA 위험평가 관리체계에 대한 내부통제 핵심사항을 금융회사 「내부통제 기준」에 포함되도록 개정이 되면서 국내 자금세탁방지 관련 규정이 강화되고 있습니다. 당사 또한 금융기관의 ML/TF 위험에 대한 관리체계 강화에 대한 필요성을 인지하여 RBA 기반 자금세탁 위험평가를 수행하여 ML/TF 위험을 최소화 하고 감독당국과의 협조를 유지하기 위해 노력하고 있습니다.
								</b>
							</td>
                        </tr>
                        <tr>
                        	<td>
	                            <textarea style="resize:none;" id="R2_AIM" rows="5"></textarea>
                        	</td>
                       	</tr>
                    </table>
                </div>
                <font size=3 style="font-weight:bold;color:#757575;"> ■ 자금세탁위험평가 수행을 위한 FATF 및 국내 규정 </font>
               	<div id="GTDataGrid2_Area" style="width:94vw"></div>
				<br><br><br><br><br><br><br><br><br><br><br><br><br>
                <font size=3 style="font-weight:bold;color:#757575;"> ■ 자금세탁 위험평가 대상 및 수행절차, 일정정리 </font>
               	<div id="GTDataGrid3_Area" style="width:94vw"></div>
               	<br><br><br>
            </div>
<!--------------------------- 3번째탭  회사현황 --------------------------->
            <div id="div2" title="회사현황" style="height:98%; margin-left:10px; margin-right:10px;">
                <div class="cond-btn-row" style="height:98%; width:98%; margin-left:10px; margin-right:10px; text-align:right">
		            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave3", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
		        </div>
                <font size=3 style="font-weight:bold;color:#757575;"> ■ 당사 재무현황 및 영업현황 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:10px;">
                    <table width="98%" border="0" class="hover" style="width:94vw">
                    	<colgroup>
							<col style="width:5%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
                        <tr>
                            <th width="10%" colspan="5" style="border-right:1px solid #cccccc;" align="left"><b>1. 회사 연혁</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="5"><textarea style="resize:none;" id="R3_HIST" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="5" style="border-right:1px solid #cccccc;" align="left"><b>2. 재무현황</b></th>
                        </tr>
                        <tr>
                        	<th width="10%" colspan="2"><b>구분</b></th>
                            <th width="10%"><b><span id="FY1_Col" class="font_s"></span></b></th>
                            <th width="10%"><b><span id="FY2_Col" class="font_s"></span></b></th>
                            <th width="10%"><b><span id="FY3_Col" class="font_s"></span></b></th>
                        </tr>
                        <tr>
                        	<th width="10%"><b>1</b></th>
                        	<th width="10%"><b>총자산</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_TOTAS1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_TOTAS2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_TOTAS3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>2</b></th>
                        	<th width="10%"><b>자기자본</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_EQCT1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_EQCT2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_EQCT3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>3</b></th>
                        	<th width="10%"><b>유동부채</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLLBT1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLLBT2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLLBT3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>4</b></th>
                        	<th width="10%"><b>고정부채</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FIX_LLBT1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FIX_LLBT2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FIX_LLBT3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>5</b></th>
                        	<th width="10%"><b>유동자산</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLAST1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLAST2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLAST3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>6</b></th>
                        	<th width="10%"><b>당기순이익</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_NPRFIT1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_NPRFIT2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_NPRFIT3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>7</b></th>
                        	<th width="10%"><b>매출원가</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_COS1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_COS2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_COS3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>8</b></th>
                        	<th width="10%"><b>총매출액</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_TSLAMT1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_TSLAMT2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_TSLAMT3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>9</b></th>
                        	<th width="10%"><b>자기자본이익율</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_ECPRT1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_ECPRT2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_ECPRT3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>10</b></th>
                        	<th width="10%"><b>부채율</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_DBTRT1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_DBTRT2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_DBTRT3" rows="1"></textarea></td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>11</b></th>
                        	<th width="10%"><b>유동비율</b></th>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLRT1" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLRT2" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_FLRT3" rows="1"></textarea></td>
                        </tr>
					</table>
	                <table class="hover" style="width:94vw; table-layout:fixed">
						<colgroup>
							<col style="width:5%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:5%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:5%">
							<col style="width:20%">
							<col style="width:20%">
							<col style="width:5%">
							<col style="width:20%">
							<col style="width:20%">
						</colgroup>
                        <tr>
                            <th colspan="12" style="border-right:1px solid #cccccc;" align="left"><b>3. 국내외 지점 및 인원 현황</b></th>
                        </tr>
                        <tr>
                        	<th><b><br>1</b></th>
                        	<th><b>본부부서<br>임직원수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON1" rows="2"></textarea></td>
                        	<th><b><br>5</b></th>
                        	<th><b>해외사무소<br>임직원수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON5" rows="2"></textarea></td>
                        	<th><b><br>9</b></th>
                        	<th><b>국내영업소<br>부서수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON9" rows="2"></textarea></td>
                        	<th><b><br>13</b></th>
                        	<th><b>퇴직<br>임직원수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON13" rows="2"></textarea></td>
                        </tr>
                        <tr>
                        	<th><b><br>2</b></th>
                        	<th><b>국내지점<br>임직원수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON2" rows="2"></textarea></td>
                        	<th><b><br>6</b></th>
                        	<th><b>해외현지법인<br>임직원수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON6" rows="2"></textarea></td>
                        	<th><b><br>10</b></th>
                        	<th><b>해외지점<br>부서수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON10" rows="2"></textarea></td>
                        	<th><b></b></th>
                        	<th><b></b></th>
                        	<td></td>
                        </tr>
                        <tr>
                        	<th><b><br>3</b></th>
                        	<th><b>국내영업소<br>임직원수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON3" rows="2"></textarea></td>
                        	<th><b><br>7</b></th>
                        	<th><b>본부부서<br>부서수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON7" rows="2"></textarea></td>
                        	<th><b><br>11</b></th>
                        	<th><b>해외사무소<br>부서수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON11" rows="2"></textarea></td>
                        	<th><b></b></th>
                        	<th><b></b></th>
                        	<td></td>
                        </tr>
                        <tr>
                        	<th><b><br>4</b></th>
                        	<th><b>해외지점<br>임직원수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON4" rows="2"></textarea></td>
                        	<th><b><br>8</b></th>
                        	<th><b>국내지점<br>부서수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON8" rows="2"></textarea></td>
                        	<th><b><br>12</b></th>
                        	<th><b>해외현지법인<br>부서수</b></th>
                        	<td><textarea style="resize:none;" id="R3_PSON12" rows="2"></textarea></td>
                        	<th><b></b></th>
                        	<th><b></b></th>
                        	<td></td>
                        </tr>
                    </table>
                </div>
                <font size=3 style="font-weight:bold;color:#757575;"> ■ 자금세탁방지제도 운영현황 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:10px;">
                    <table width="98%" border="0" class="hover" style="width:94vw">
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>1. 임직원 및 AML 전담인력 현황</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 보고책임자의 지시에 따라 자금세탁방지 수행하는 전담인력을 보유하고 있습니다. 자금세탁방지 전담인력의 경우 1) 실무경험이 2년 이상으로 자금세탁방지 업무에 필요
                            	한 지식과 경험이 있는자, 2) 보고책임자가 자금세탁방지 업무에 적합하다고 인정하는 자로 임명 되어 자금세탁방지업무에 필요한 업무지식과 도덕성을 겸비하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>총 임직원 수 1)</b></th>
                        	<th width="10%"><b>자금세탁방지 전담인력수 2)</b></th>
                        	<th width="10%"><b>자금세탁방지 전담인력<br>평균 근무기간 3)</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN011" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN012" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN013" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 평가기준일 현재 정규직, 비정규직, 계약직 포함 전체임직원 수<br>
                            	2) 자금세탁방지 업무를 전담하는 본부의 자금세탁방지 부서 인력 보유실적으로 다른 업무를 겸업하는 인력 제외<br>
                            	3) 자금세탁방지 전담인력의 평균근무기간 = (∑ 자금세탁방지 분야 근무 기간(월) ÷ 자금세탁방지 전담인력 수) X100
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>2. 고객확인의무 이행 현황</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 고객과의 금융거래 시에 신원확인 및 검증, 거래목적 및 실소유자 확인 등 고객에 대해 합당한 주의를 기울이는 고객확인의무(이하 CDD)를 이행하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>활동 고객수 1)</b></th>
                        	<th width="10%"><b>고객확인의무 이행고객수 2)</b></th>
                        	<th width="10%"><b>지속적인 고객확인비율 3)</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN021" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN022" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN023" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 평가기준일 현재 과거 1년 동안 서래 실적이 있는 고객수(명)<br>
                            	2) 평가기준일 현재 총 고객 중 고객확인의무 이행 고객수(명)<br>
                            	3) 평가기간 동안 전체 CDD이행고객 중 CDD 중도 확인 건수(재이행 주기 도래 고객 수) = (중도확인건수 ÷CDD이행고객 수)X100
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>3. 강화된 고객확인의무 이행 및 고객확인의무 검증</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 자금세탁 등의 위험이 높은 것으로 평가된 고객 또는 상품 및 서비스에 대해 그 신원확인 및 검증정보 이외에 고객에 대해 추가정보를 확인하는 강화된 고객확인의무(이하 EDD)를 수행하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>EDD 이행비율 1)</b></th>
                        	<th width="10%"><b>CDD 고객에 대한 검증비율 2)</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN031" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN032" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 평가기간 동안 전체 CDD이행고객 중 EDD를 수행한 비율 = (EDD이행고객 수 ÷ CDD이행고객 수)X100<br>
								2) 평가기간 동안 전체 CDD이행고객 중 정부가 발행한 2종 이상의 문서로 검증한 비율 = (정부 발행 2종 이상의 문서로 검증한 고객 수 ÷ CDD이행고객 수)X100
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>4. 교육, 전문가 양성</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 자금세탁방지제도에 대한 교육프로그램을 수립하여 임직원을 대상으로 연 1회 이상 교육 및 연수를 실시하고 있으며 그 교육내용 등을 기록·관리하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>직원 1인당 평균 교육연수 시간 1)</b></th>
                        	<th width="10%"><b>교육의 적정성 측정 2)</b></th>
                        	<th width="10%"><b>자금세탁방지 전문가<br>양성실적 건수 3)</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN041" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN042" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN043" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 자금세탁방지 교육(집합+문서+사이버+연수+외부강사+기타)에 대한 전체 1인당 평균 교육시간<br>
                            	2) FIU 교육 권고과목 이수율 =(교육과목 총 이수 횟수 ÷ 대상 직원 수)X100<br>
                            	3) 국내외 우수교육기관에서 실시하는 자금세탁방지 전문가 교육이수 이원 = 성대 등 3개월 이상 국내 외 전문교과 이수 인원(횟수) +국내외 자금세탁방지 전문자격증 취득 인원(횟수)
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>5. 경영진에 대한 보고</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 자금세탁방지업무를 수행하기 위하여 “자금세탁방지(AML) 협의회를 구성하여 매년 1회 이상 개최하고 있으며 협의회에서 결의·보고된 사항을 대표이사에게 보고하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>경영진 보고실적 1)</b></th>
                        	<th width="10%"><b>경영진 지시 2)</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN051" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN052" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 평가기간 중 자금세탁방지/테러자금조달금지 주요 활동 관련 경영진(대표이사)에 보고한 횟수<br>
                            	2) 평가기간 중 자금세탁방지/테러자금조달금지 활동에 대해 경영진(대표이사)이 개선 요구한 횟수
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>6. 요주의 리스트 관리(Watch List)</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 요주의리스트(이하 Watch List) 에 대해 DB화 하여 관리하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>금융거래제한대상자 DB건수 1)</b></th>
                        	<th width="10%"><b>UN 등 테러리스트 DB 건수 2)</b></th>
                        	<th width="10%"><b>고위험국가 DB건수 3)</b></th>
                        	<th width="10%"><b>외국의 정치적 주요인물<br>DB 건수 4)</b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN061" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN062" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN063" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN064" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 금융회사에서 관리하는 FIU 지정 금융거래제한 대상자 DB 건수<br>
                            	2) 금융회사에서 관리하는 UN 등 테러리스트 DB 건수<br>
                            	3) FATF권고사항 이행 취약국 등 금융회사에서 관리하는 고위험국가 DB건수<br>
                            	4) 금융회사에서 관리하는 외국의 정치적 주요인물에 대한 DB건수
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>7. 독립적 감사</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 자금세탁방지 등의 업무를 수행하는 부서와는 독립적으로 AML 전문성을 갖춘 독립적 감사조직을 운영하여 자금세탁방지 업무수행의 적절성, 효과성을 검토·평가하고 있으며 이에 따른 문제점 등을 개선하기 위한 절차를 수행하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>AML전문성을 갖춘 독립적 감사<br>조직운영여부 1)</b></th>
                        	<th width="10%"><b>감사 실적 2)</b></th>
                        	<th width="10%"><b>감사지적사항 3)</b></th>
                        	<th width="10%"><b>감사결과 이사회 보고 실적 4)</b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN071" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN072" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN073" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN074" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 독립적 감사조직에 1년 이상 경력의 AML전담인력을 보유해야 인정<br>
                            	2) 독립적 감사 횟수, 증빙자료 별도 제출: 감사일자, 감사대상<br>
                            	3) 감사지적건수<br>
                            	4) 감사결과 이사회 보고횟수
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>8. 직원알기제도 운영</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 임직원이 자금세탁 등에 이용되지 않도록 하기 위해 채용 시 또는 재직중인 임직원에 대해 신원사항을 확인하는 직원알기제도를 수행하고 있으며 세부 절차와 방법을 규정화 하고 있습니다. 또한 통제 및 별도의 모니터링 룰을 통해 재직중인 임직원의 자금세탁 위험을 확인하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>임직원 채용 시 자금세탁<br>위험 확인 여부 1)</b></th>
                        	<th width="10%"><b>재직중인 임직원의 자금세탁<br>위험 확인 여부 2)</b></th>
                        	<th width="10%"><b>자점감사 및 상시감사와 연계하여 자금세탁<br>위험 확인 여부</b></th>
                        	<th width="10%"><b>직원알기제도 이행과 관련하여<br>세부 절차와 방법 규정화 여부</b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN081" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN082" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN083" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN084" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 인사부서에서 임직원 채용 시 자금세탁위험을 실제 확인하는지 여부 측정<br>
                            	2) 별도 모니터링 룰 운영 및 통제 업무 시행 여부
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>9. 신상품 및 서비스에 대한 자금세탁 위험 검토 실적</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 신규 금융상품 및 서비스를 이용한 ML/TF의 위험을 예방하기 위해 신규상품 및 서비스를 제공하기 전 자금세탁 위험을 평가 할 수 있는 체크리스트를 운영하여 평가하고 있습니다. 이에 대해 자금세탁방지 전담부서에서는 최종 승인 절차를 마련하여 신상품 및 서비스에 대한 자금세탁 위험을 승인하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>신규 상품 및 서비스에 대한<br>자금세탁방지 부서의 승인절차 마련 여부</b></th>
                        	<th width="10%"><b>신규상품에 대해 세부 위험검토<br>절차 마련 여부 1)</b></th>
                        	<th width="10%"><b>신규 상품 및 서비스 검토 실적</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN091" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN092" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN093" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 신규상품 및 서비스에 대해 4가지 관점에서 위험을 검토하는 절차 마련 여부<br>
                            	- 사람: 상품을 취급하거나 이용할 사람(Person)에 대한 위험 평가<br>
                            	- 조직 및 환경: 해당 상품과 관련된 조직 및 업무환경(Environment)에 대한 위험 평가<br>
                            	- 업무 절차: 신규 상품 및 서비스의 업무절차(Procedure)에 대한 위험평가<br>
                            	- IT시스템: 신규 상품 및 서비스를 처리할 IT시스템에 대한 위험평가
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>10. 지속적인 룰 관리</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 비정상적인 거래행위 또는 유형을 정형화 한 룰을 통해 지속적으로 고객의 거래를 모니터링 하고 있으며 지속적으로 룰을 신규 생성 및 수정·삭제 하여 개선하고 개선 전후 결과에 대한 효과성을 확인하고 있습니다. 이러한 룰에 대한 검토 절차를 규정화하고 검토 및 개선여부에 대해 관리하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>신규 룰 생성 개수<br>(전년대비 비율)</b></th>
                        	<th width="10%"><b>룰 수정·삭제 개수<br>(전년대비 비율)</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN101" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN102" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>11. 위험평가 모델의 지속적인 관리</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 고객의 고유한 특성에 의한 자금세탁속성으로 고객의 위험을 평가하고 있으며 고위험군에 대한 비율을 매월 기록하고 적정하게 유지토록 관리하고 있습니다. 새로운 상품, 고객(직업 및 업종), 위험국가에 대한 지속적인 위험을 평가하고 관리하고 있으며 이러한 위험평가 모델에 대한 검토절차를 규정화 하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>고위험군(EDD대상) 비율<br>(전년대비 비율)</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN111" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>12. 룰별 관리기준 마련</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	당사는 의심스러운 거래(이하 STR) 룰을 운영측면에서 세부 관리지침 즉, 룰별로 검색 조건이나 임계치를 설정하여 특정범위를 초과하는 거래는 STR로 보고하고 특정 범주내에 속한 거래는 여신부점 확인을 거치는 등의 내부 룰 운영기준을 마련하여 운영하고 있습니다. 이러한 룰 운영지침에 따라 룰에 의한 적발 대상 별로 “FIU보고”, “보고 제외”로 구분하여 운영지침에 따라 성실히 시행하고 있습니다.
                            </td>
                        </tr>
                        <tr>
                        	<th width="10%"><b>FIU 보고 건수 1)</b></th>
                        	<th width="10%"><b>보고제외 보존 건수 2)</b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        	<th width="10%" rowspan="2"><b></b></th>
                        </tr>
                        <tr>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN121" rows="1"></textarea></td>
                        	<td width="10%"><textarea style="resize:none;" id="R3_AML_PSCN122" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	1) 평가기간 동안 FIU 보고 건수<br>
                            	2) 평가기간 동안 보고제외 처리 및 보존 건수
                            </td>
                        </tr>
                        <tr>
                            <th width="10%" colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>13. 보안관리</b></th>
                        </tr>
                        <tr>
                            <td width="10%" colspan="4">
                            	<b>
                            	<span style="color:blue">[샘플]</span> 당사는 1) 의심되는 거래 보고서(사본 또는 결재 양식) 및 보고대상이 된 금융거래 자료, 2) 의심되는 합당한 근거를 기록한 자료, 3) 의심되는 거래 미보고 대상에 대해 자금세탁 등의 가능성과 관련하여 조사하였던 기록 및 기타자료, 4) 자금세탁방지업무 보고책임자의 경영진 보고서 등 내·외부 보고와 관련한 자료에 대해 5년 이상 보존하고 있습니다.<br> 
								STR보고 자료 보안관리는 금융정보분석원 보고자료 보안관리기준을 통해 마련하여 특정금융정보 보안 관리책임자 및 담당자를 지정하였으며 보안조치 대상 정보에 관한 관리적/기술적 규정에 대해 문서화를 실시하고 이행점검 여부를 확인토록 하고 있습니다. 또한 STR 보고 후 관련자료에 대해 삭제 전문 프로그램을 사용하여 자동 삭제하고 있으며 이관을 위한 시스템을 보유하여 안전한 내부망에 보관하고 있습니다. STR 추가자료 요청 시에는 문서 및 전송 메일에 암호화를 적용하여 메일을 발송하고 있습니다.
								</b>
                            </td>
                        </tr>
                        <tr>
                        	<td width="10%" colspan="4"><textarea style="resize:none;" id="R3_AML_PSCN131" rows="5"></textarea></td>
                        </tr>
					</table>
				</div>
            </div>
<!--------------------------- 4번째탭  자금세탁위험평가방법론 --------------------------->
            <div id="div3" title="자금세탁위험평가방법론" style="height:98%; margin-left:10px; margin-right:10px;">
                <font size=3 style="font-weight:bold;color:#757575;"> ■ 금융회사 자금세탁 위험평가 방법론에 대한 모델 구조 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:0px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>1. 위험평가 방법론 전체 도식도</b></th>
                        </tr>
                        <tr>
                        	<td align="center">
				                <img src="/WEB-INF/Package/ext/images/RBA_type03/RBA_50_07_03_01/RBA_50_07_03_01_img01.png" width="90%">
                        	</td>
                        </tr>
					</table>
				</div>
                <div class="table-box" style="margin-top:px; margin-bottom:10px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
						<colgroup>
							<col style="width:3%">
							<col style="width:20%">
							<col style="width:3%">
							<col style="width:20%">
							<col style="width:80%">
						</colgroup>
                        <tr>
                            <th colspan="5" style="border-right:1px solid #cccccc;" align="left"><b>2. 위험평가 방법론 단계별 구분</b></th>
                        </tr>
                        <tr>
                            <td colspan="2" align="center"><b>대구분</b></td>
                            <td colspan="2" align="center"><b>소구분</b></td>
                            <td align="center"><b>주요 활동</b></td>
                        </tr>
                        <tr>
                            <td rowspan="3" align="center"><b>I</b></td>
                            <td rowspan="3" align="center"><b>자금세탁 위험 및<br>내부통제 (취약점) 식별</b></td>
                            <td align="center">1</td>
                            <td align="center">AML 업무 프로세스 정의</td>
                            <td>전사 업무 프로세스 중 자금세탁 관련 업무 영역을 식별하여 "AML 프로세스"로 정의하였습니다.</td>
                        </tr>
                        <tr>
                            <td align="center">2</td>
                            <td align="center">자금세탁 위험요소 식별</td>
                            <td>국내외 규정, 자금세탁 사례, 의심거래보고 및 상품/서비스 분석을 통해 자금세탁 위험범주와 요소 식별하였습니다.</td>
                        </tr>
                        <tr>
                            <td align="center">3</td>
                            <td align="center">내부통제 점검항목 식별</td>
                            <td>RBA 처리기준, KoFIU 운영위험지표 등에서 제시한 통제 항목을 고려하여, 전사의 자금세탁 위험을 예방·저감할 수 있는 통제 영역과 내부통제 점검항목 식별하였습니다.</td>
                        </tr>
                        <tr>
                            <td align="center" rowspan="2"><b>II</b></td>
                            <td align="center" rowspan="2"><b>자금세탁 위험 및<br>내부통제 (취약점) 평가</b></td>
                            <td align="center">4</td>
                            <td align="center">총 위험 평가</td>
                            <td>위험요소의 발생 빈도와 위험의 영향도 수준을 반영하여 총위험 평가를 수행하였습니다.</td>
                        </tr>
                        <tr>
                            <td align="center">5</td>
                            <td align="center">통제 평가</td>
                            <td>내부통제 점검항목을 평가하여 자금세탁위험을 경감시킬 수 있는 유효한 통제 여부를 파악하였습니다.</td>
                        </tr>
                        <tr>
                            <td align="center"><b>III</b></td>
                            <td align="center"><b>잔여위험등급 산출 및<br>결과 모니터링</b></td>
                            <td align="center">6</td>
                            <td align="center">잔여위험등급 산출 및<br>결과 모니터링</td>
                            <td>위험 및 통제평가를 통해 산출된 잔여위험 정도를 파악하여 전사의 자금세탁 위험 모니터링 및 고위험 영역에 대한 통제 개선활동 수행하였습니다.</td>
                        </tr>
					</table>
				</div>
				<font size=3 style="font-weight:bold;color:#757575;"> ■ 금융회사 자금세탁 위험평가 시 주요 구성요소에 대한 설명 </font>
				<div class="table-box" style="margin-top:5px; margin-bottom:0px;">
					<table class="hover" style="width:94vw; table-layout:fixed">
						<colgroup>
							<col style="width:25%">
							<col style="width:40%">
							<col style="width:3%">
							<col style="width:50%">
						</colgroup>
                        <tr>
                            <th colspan="4" style="border-right:1px solid #cccccc;" align="left"><b>1. AML 업무 프로세스 정의</b></th>
                        </tr>
                        <tr>
                        	<td colspan="4">
                       			당사는 전사 업무 프로세스를 위험 인식 및 평가의 대상으로 설정하였으며, 직제 및 업무분장, 업무 매뉴얼, 거래화면 등을 참조하여 전사 업무 프로세스를 우선적으로 파악하였습니다. 이후, 전사 업무 프로세스를 대상으로 아래의 체크리스트를 활용해 "AML 업무 프로세스"를 도출하였고, 관련된 ML/TF 위험을 인식하고 평가합니다.
                        	</td>
                        </tr>
                        <tr>
                            <td align="center">기준</td>
                            <td align="center">설명</td>
                            <td align="center" colspan="2">체크리스트</td>
                        </tr>
                        <tr>
                            <td align="center" rowspan="4">AML 거래특성</td>
                            <td align="center" rowspan="4">자금세탁 및 테러자금 조달 의심거래 대상자들이 금융기관을 통해 일으키는 거래 프로세스</td>
                            <td align="center">1</td>
                            <td>자금(실물자산 포함)의 유출입이 발생하는가?</td>
                        </tr>
                        <tr>
                            <td align="center">2</td>
                            <td>고객확인의무(CDD/EDD) 수행 대상인가?</td>
                        </tr>
                        <tr>
                            <td align="center">3</td>
                            <td>제3자 계약 발생 거래인가? (환거래 계약 등)</td>
                        </tr>
                        <tr>
                            <td align="center">4</td>
                            <td>비대면 거래이거나 비대면 거래 활성화 하는가?</td>
                        </tr>
                        <tr>
                            <td align="center" rowspan="3">자금세탁 사고 발생 이력</td>
                            <td align="center" rowspan="3">실제 자금세탁 사고 및 사고의심 사례 발생 이력 보유 프로세스</td>
                            <td align="center">5</td>
                            <td>STR 룰이 존재하는가?</td>
                        </tr>
                        <tr>
                            <td align="center">6</td>
                            <td>STR 자체선정 보고 이력이 존재하는가?</td>
                        </tr>
                        <tr>
                            <td align="center">7</td>
                            <td>내 외부 금융사고 거래 발생 이력이 있는가?</td>
                        </tr>
                        <tr>
                            <td align="center">AML 통제활동</td>
                            <td align="center">자금세탁 방지 계획 수립 및 운영 프로세스</td>
                            <td align="center">8</td>
                            <td>지침에 정의된 내부통제 항목인가?</td>
                        </tr>
					</table>
                </div>
                <div class="table-box" style="margin-top:0px; margin-bottom:0px;">
					<table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>2. 총 위험 평가</b></th>
                        </tr>
                        <tr>
                        	<td>
                       			총 위험 평가는 ML/TF 위험요소 別 위험 수준을 정량적으로 평가하기 위하여, ML/TF 위험에 대한 영향도(영향평가)와 발생 빈도를 정량적으로 측정(빈도평가)하여 금융회사의 위험 노출 정도와 주요 관리 대상 고위험 리스크를 식별하도록 했습니다. 기 식별한 위험요소의 자금세탁위험 영향도를 구분하기 위해 위험요소 별 평가배점을 설정하며, 평가배점 가중치는 「RBA 처리기준」의  ‘고유위험 지표 (금융투자업)’ 배점 배분방식을 준용하여 설정하였습니다. 또한 위험요소의 빈도평가를 위한 위험 발생 빈도 수집은 시스템 화면, 위험평가모델(RA 모델), 시스템 DB, Rule Alert 등을 통하여 전산 추출하였습니다. 각 부서는 관련 AML 업무 프로세스에 발생한 "ML/TF 위험요소 및 평가" 결과에 따라 위험 평가 점수를 확인할 수 있습니다.
                        	</td>
                        </tr>
                        <tr>
                        	<th style="border-right:1px solid #cccccc;" align="center"><b>총 위험평가 및 위험 평가 점수 산출 예시</b></th>
                        </tr>
                        <tr>
                        	<td align="center">
                        		<img src="/WEB-INF/Package/ext/images/RBA_type03/RBA_50_07_03_01/RBA_50_07_03_01_img02.png" width="90%">
                        	</td>
                        </tr>
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>3. 통제 평가</b></th>
                        </tr>
                        <tr>
                        	<td>
                       			통제 평가는 통제 영역 및 요소의 위험 · 저감 효과성 수준을 평가하는 설계 평가와 각 내부통제 점검항목의 효과적인 수행 활동 정도를 리커트 척도로 평가하는 운영 평가의 결과를 바탕으로 최종적인 각 부서의 통제 수행 활동의 수준을 평가하고 있습니다. 통제점검항목별 배점은 RBA 처리기준의 KoFIU 운영위험 지표 배점표를 활용하여, 내부통제 요소별 평가배점 가중치를 배분하였습니다. 통제 효과성 평가는 아래 예시에서 보는 것과 같이 각 점검항목 별 통제평가 지표를 보조적인 기준으로 활용하여, 통제 활동이 적절하게 수행되었는지 리커트 척도를 통해 평가를 수행하였습니다. 결과적으로, 각 부서에서 평가한 유효성 평가 수행 결과를 취합하여 업무 프로세스 별 통제 점수를 산출하게 됩니다.
                        	</td>
                        </tr>
                        <tr>
                        	<th style="border-right:1px solid #cccccc;" align="center"><b>통제 유효성 평가 수행 방법 예시</b></th>
                        </tr>
                        <tr>
                        	<td align="center">
                        		<img src="/WEB-INF/WEB-INF/Package/ext/images/RBA_type03/RBA_50_07_03_01/RBA_50_07_03_01_img03.png" width="90%">
                        	</td>
                        </tr>
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>4. 잔여위험 평가 및 등급 모니터링</b></th>
                        </tr>
                        <tr>
                        	<td>
                       			잔여위험 평가 및 등급 산정은 ML/TF 위험 업무 프로세스를 보유한 부서를 기준으로 산출이 되며, 주로 자금의 유출입 및 계약 체결 등이 수행되는 영업점 및 IB 관련 부서가 모니터링의 대상으로 선정이 되게 됩니다. 각 부서에서 총 위험평가 결과 값이 3년간 수행되었던 AML 업무 프로세스 別 위험도의 증감도에 따라 백분위 점수로 변환이 되어 해당 값을 기준으로 위험도를 산정하게 됩니다. 마찬가지로 해당 부서의 통제 활동의 예방 · 저감 활동의 유효성을 백분위 점수로 변환하여 모니터링 하게 됩니다. 마지막으로 총 위험평가 백분위 점수와 통제 유효성평가의 백분위 점수를 "고위험(RED)", "중위험(Yellow)", "저위험(Green)"으로 구분하기 위하여, 아래 예시에 보이는 등급표에 좌표화하여, 각 부서의 위험도를 모니터링하게 됩니다.
                        	</td>
                        </tr>
                        <tr>
                        	<td align="center">
                        		<img src="/WEB-INF/Package/ext/images/RBA_type03/RBA_50_07_03_01/RBA_50_07_03_01_img04.png" width="90%">
                        	</td>
                        </tr>
					</table>
				</div>
				<div class="table-box" style="margin-top:5px; margin-bottom:0px;">
					<table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>[별첨 1] AML 업무 프로세스 목록</b></th>
                        </tr>
                    </table>
				</div>
				<div id="GTDataGrid5_Area" style="width:94vw"></div>
				<div class="table-box" style="margin-top:0px; margin-bottom:0px;">
					<table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>[별첨 2] 자금세탁 위험요소 목록</b></th>
                        </tr>
                        <tr>
                        	<td>
                       			당사는 전사 업무 프로세스를 위험 인식 및 평가의 대상으로 설정하였으며, 직제 및 업무분장, 업무 매뉴얼, 거래화면 등을 참조하여 전사 업무 프로세스를 우선적으로 파악하였습니다. 이후, 전사 업무 프로세스를 대상으로 아래의 체크리스트를 활용해 "AML 업무 프로세스"를 도출하였고, 관련된 ML/TF 위험을 인식하고 평가합니다.
                        	</td>
                        </tr>
					</table>
				</div>
				<div id="GTDataGrid6_Area" style="width:94vw"></div>
				<div class="table-box" style="margin-top:0px; margin-bottom:0px;">
					<table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>[별첨 3] 내부통제 점검항목 목록</b></th>
                        </tr>
                        <tr>
                        	<td>
                       			당사는 KoFIU의 'RBA 기반 AML 처리지침'에서 정의한 통제활동을 고려하여, 당사의 자금세탁 위험을 예방 · 저감 할 수 있는 내부통제 요소를 다음과 같이 식별하였습니다. 전사통제, 내부통제, 고객확인, 위험관리, 모니터링 및 보고관리 등 5개의 내부통제 영역(Control Category)과 통제환경, 정보 및 의사소통, 모니터링, 위험관리 전략수립 등 총 58개의 세부 내부통제 요소를 도출하였습니다. 또한 내부통제 요소 별 내부통제 (취약점) 수준을 평가할 수 있는 점검항목을 159개 설계하여, 정량적인 내부통제 효과성에 대한 파악을 할 수 있도록 하였습니다.
                        	</td>
                        </tr>
					</table>
				</div>
				<div id="GTDataGrid7_Area" style="width:94vw"></div>
            </div>
<!--------------------------- 5번째탭  자금세탁위험평가 --------------------------->
            <div id="div4" title="자금세탁위험평가" style="height:98%; margin-left:10px; margin-right:10px;">
            	<font size=3 style="font-weight:bold;color:#757575;"> ■ 자금세탁 위험평가 결과 정리 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:0px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>1. RBA 위험평가 수행 내역 개요</b></th>
                        </tr>
					</table>
				</div>
            	<div id="GTDataGrid8_Area" style="width:94vw"></div>
            	<div class="table-box" style="margin-top:5px; margin-bottom:10px;">
	                <table class="hover" style="width:94vw;">
                        <tr>
                            <th colspan="2" style="border-right:1px solid #cccccc;" align="left"><b>2. 부서 별 고위험 영역 Mapping</b></th>
                        </tr>
                        <tr>
                        	<td align="center"><iframe name="Chart1_Area" width="94%" height="400px;"></iframe></td>
                        	<td align="center" valign="top"><iframe name="Chart2_Area" width="94%" height="400px;"></iframe></td>
                        </tr>
                        <tr>
                            <th style="border-right:1px solid #cccccc;"><b>상위 Top 5 AML 위험 업무 프로세스</b></th>
                            <th style="border-right:1px solid #cccccc;"><b>상위 Top 5 AML 위험도 부서</b></th>
                        </tr>
                        <tr>
                        	<td align="center"><div id="GTDataGrid9_Area" style="width:46vw"></div></td>
                        	<td align="center" valign="top"><div id="GTDataGrid10_Area" style="width:46vw"></div></td>
                        </tr>
					</table>
				</div>
            </div>
<!--------------------------- 6번째탭  결과 --------------------------->
            <div id="div5" title="결과" style="height:98%; margin-left:10px; margin-right:10px;">
            	<font size=3 style="font-weight:bold;color:#757575;"> ■ 자금세탁 위험평가 상세결과 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:0px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>1. AML 업무 프로세스 別 상위 Top10 RBA 총 위험평가 내역 </b></th>
                        </tr>
                        <tr>
                        	<td>
                        		AML 업무 프로세스 別 위험평가 결과 과거의 거래 규모 및 유입된 당사 고객의 특성에 비해 ML/TF 위험이 상대적으로 많이 노출된 업무 영역이 어떠한지 아래의 결과를 통해 확인할 수 있으며, <span style="color:red">[Top 1 AML 업무 프로세스]</span> 관련 거래 및 고객에 대해 지속적인 모니터링을 통해 ML/TF 위험 정도를 경감시키기 위해 노력할 것입니다.
                        	</td>
                        </tr>
					</table>
				</div>
            	<div id="GTDataGrid11_Area" style="width:94vw"></div>
                <div class="table-box" style="margin-top:5px; margin-bottom:0px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>2. AML 업무 프로세스 別 상위 Top10 RBA 통제 유효성 평가 결과 </b></th>
                        </tr>
                        <tr>
                        	<td>
                        		AML 업무 프로세스 別 통제 유효성 평가 결과 과거의 수준보다 ML/TF 위험을 경감시키기 위한 내부통제 활동이 상대적으로 취약하게 수행된 업무 영역이 어떠한지 아래의 결과를 통해 확인할 수 있으며, <span style="color:red">[Top 1 AML 업무 프로세스]</span> 관련 내부통제 활동에 대한 강화된 모니터링 및 점검을 통해 ML/TF 위험 정도를 더욱더 경감시키기 위해 노력할 것입니다.
                        	</td>
                        </tr>
					</table>
				</div>
            	<div id="GTDataGrid12_Area" style="width:94vw"></div>
            	<div class="table-box" style="margin-top:5px; margin-bottom:0px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>3. 잔여위험 평가 및 등급 상위 Top 10 부서 (위험도) </b></th>
                        </tr>
                        <tr>
                        	<td>
                        		당사는 총 위험평가 결과와 통제 유효성 평가 결과를 활용하여, 부서별로 자금세탁 위험의 노출된 정도에 비해 얼마나 효과적인 자금세탁 방지 활동을 수행하는지를 정성적, 정량적 방법을 통해 평가 한 뒤 잔여위험 평가 점수와 등급을 산출하게 됩니다. 금년도 RBA 위험평가 수행 결과 <span style="color:red">[Top 1 부서]</span> 에서 가장 높은 자금세탁 위험에 노출되어 있는 것으로 평가되었습니다.
                        	</td>
                        </tr>
					</table>
				</div>
				<div id="GTDataGrid13_Area" style="width:94vw"></div>
				<div class="table-box" style="margin-top:5px; margin-bottom:0px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>4. 주요 위험지표 (KRI : Key Risk Indicator) 상위 Top5 위험 모니터링 결과 </b></th>
                        </tr>
                        <tr>
                        	<td>
                        		당사는 ML/TF 위험지표의 거래 발생 규모 및 변화 정도를 모니터링하기 위하여, "ML/TF 위험지표(RI: Risk Indicator)의 전사 기준의 월별 발생 건수"를 주요 위험지표(KRI: Key Risk Indicator)로 정의하였습니다. 전사 주요 위험지표는 관련 TMS Rule의 Alert 발생 빈도와 상호 비교 모니터링 하여, RBA 위험평가 체계를 기존 AML 기능과 유기적으로 연계 개선하기 위하여 운영하고 있습니다.
                        	</td>
                        </tr>
					</table>
				</div>
				<div id="GTDataGrid14_Area" style="width:94vw; margin-bottom:5px"></div>
				<div class="table-box" style="margin-top:5px">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                        	<th><b>월평균 주요 위험지표 거래 변화량</b></th>
                        </tr>
					</table>
					<iframe name="Chart3_Area" width="100%" height="400px;"></iframe>
				</div>
            </div>
<!--------------------------- 7번째탭  주요발견사항 및 개선사항 --------------------------->
            <div id="div6" title="주요 발견사항 및 개선사항" style="height:98%; margin-left:10px; margin-right:10px;">
            	<font size=3 style="font-weight:bold;color:#757575;"> ■ 주요 발견사항 및 개선사항 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:0px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>1. AML 업무 프로세스 別 개선사항 수립 내역 </b></th>
                        </tr>
                        <tr>
                        	<td>
                        		당사는 과거 고위험으로 인식된 위험 영역 중 위험이 실제 제거 또는 저감되었는지 결과값을 지속적으로 모니터링 하였으며, 그 결과 대부분의 위험요소의 위험 수준이 경감된 것으로 확인되었습니다. 일부 저감되지 않거나 효과가 미비하거나 위험에 대해서는 지속적으로 모니터링 하고 있으며, 해당 위험을 제거/저감 하기 위함 보다 효율적인 대응방안을 수립하였습니다.
                        	</td>
                        </tr>
					</table>
				</div>
            	<div id="GTDataGrid15_Area" style="width:94vw; margin-bottom:15px;"></div>
            	
            	<div class="cond-btn-row" style="height:98%; width:98%; margin-left:10px; margin-right:10px; text-align:right">
		            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave4", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
		        </div>
            	<div class="table-box" style="margin-top:0px; margin-bottom:10px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>2. 향후 추진과제 및 발전방향 </b></th>
                        </tr>
                        <tr>
                            <td style="border-right:1px solid #cccccc;" align="left">2.1 개요</td>
						</tr>
						<tr>
                        	<td>
                        		<span style="color:red" align="left">[RBA 위험평가 및 기존 자금세탁방지활동 관련 추진과제 및 발전방향에 대한 개요 작성]</span>
                        		<textarea style="resize:none;" id="R3_SUMMY" rows="1"></textarea>
                        	</td>
                        </tr>
                        <tr>
                            <td style="border-right:1px solid #cccccc;" align="left">2.2 상세 추진 과제</td>
						</tr>
						<tr>
                        	<td>
                        		<span style="color:red" align="left">[상세 추진 과제에 대한 내용 입력]</span>
                        		<textarea style="resize:none;" id="R7_TASK" rows="1"></textarea>
                        	</td>
                        </tr>
                        <tr>
                            <td style="border-right:1px solid #cccccc;" align="left">2.3 추진 계획</td>
						</tr>
						<tr>
                        	<td>
                        		<span style="color:red" align="left">[상세 추진 과제에 대한 각 부서의 역할 및 상세한 계획 입력]</span>
                        		<textarea style="resize:none;" id="R7_PLAN" rows="1"></textarea>
                        	</td>
                        </tr>
                        <tr>
                            <td style="border-right:1px solid #cccccc;" align="left">2.3 발전 방향</td>
						</tr>
						<tr>
                        	<td>
                        		<span style="color:red" align="left">[추진과제 및 개선사항에 대한 회사의 효익 작성]</span>
                        		<textarea style="resize:none;" id="R7_DIREC" rows="1"></textarea>
                        	</td>
                        </tr>
					</table>
				</div>
            </div>
<!--------------------------- 8번째탭  별첨 --------------------------->
            <div id="div7" title="별첨" style="height:98%; margin-left:10px; margin-right:10px;">
            	<div class="cond-btn-row" style="height:98%; width:98%; margin-left:10px; margin-right:10px; text-align:right">
		            ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave5", cssClass:"flat-btn flat-btn-white", icssClass:"fa fa-floppy-o"}')}
		        </div>
            	<font size=3 style="font-weight:bold;color:#757575;"> ■ 별첨 </font>
                <div class="table-box" style="margin-top:5px; margin-bottom:10px;">
	                <table class="hover" style="width:94vw; table-layout:fixed">
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>1. 자금세탁 관련 주요 용어 정리 </b></th>
                        </tr>
                        <tr>
                        	<td>
                        		AML : Anti-Money Laundering, 자금세탁방지<br>
                        		CTF : Countering Terrorist Financing, 테러자금조달 금지<br>
                        		CML : Criminalization of Money Laundering, 자금세탁 범죄화제도<br>
								CTR : Currency Transaction Report, 고액현금거래보고<br>
								CDD : Customer Due Diligence, 고객확인제도<br>
								EDD : Enhanced Due Diligence, 강화된 고객확인제도<br>
								FATF : Financial Action Task Force on Money Laundering, 국제자금세탁방지기구<br>
								KYC : Know Your Customer, 고객알기제도<br>
								KYE : Know Your Employee, 직원알기제도<br>
								KoFIU : Korea Financial Intelligence Unit, 금융정보분석원<br>
								ML : Money Laundering, 자금세탁<br>
								NCCT : Non-Cooperative Countries and Territories, 자금세탁방지 비협조 국가<br>
								OFAC : Office of Foreign Assets Control, 해외자산통제국<br>
								PEPs :Politically Exposed Persons, 정치적 주요인물<br>
								RA : Risk Assessment, AML 위험평가 모델<br>
								RBA : Risk Based Approach, 위험기반접근법<br>
								SDNs : Specially Designated Nationals or Blocked Persons, 중점관리 대상인물<br> 
								SP : Strategic Prioritization, 경영진 중점관리대상위험<br>
								STR : Suspicious Transaction Report, 의심스러운거래보고<br>
								TF : Terrorist Financing, 테러자금 조달<br>
								TMS : Transaction Monitoring System, 거래모니터링<br>
								WLF : Watch List Filtering, 요주의 리스트 필터링
                        	</td>
                        </tr>
                        <tr>
                            <th style="border-right:1px solid #cccccc;" align="left"><b>2. 기타 첨부 자료 </b></th>
                        </tr>
                        <tr>
                        	<td>
                        		<span style="color:red" align="left">[RBA 위험평가 관련 주요 의결사항 및 관련 자료 첨부]</span>
                        	</td>
                        </tr>
                        <tr>
                        	<td>
                            	<textarea style="resize:none;" id="R8_ETC_LIST" rows="5"></textarea>
                        	</td>
                       	</tr>
					</table>
				</div>
            </div>
        </div>
    </div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />