<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project          : AML
* File Name       : AML_10_39_01_01.jsp
* Description     : 위험등급별 구간관리
* Group           : GTONE, 컴플라이언스 개발부
* Author          :
* Since           : 2025-06-27
--%>
<%@page import="jspeed.base.util.StringHelper"%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ page import="com.gtone.aml.admin.AMLException" %>
<%@page import="com.itplus.common.server.user.SessionHelper"%>
<%
	String stDate = jspeed.base.util.DateHelper.currentTime(PropertyService.getInstance().getProperty("aml.config","dateFormat"));
	request.setAttribute("stDate",stDate);
	
	String rstDate = jspeed.base.util.DateHelper.format(jspeed.base.util.DateHelper.addDate(new java.util.Date(),-365),PropertyService.getInstance().getProperty("aml.config","dateFormat"));
    request.setAttribute("rstDate",rstDate);
	
	String RA_APPR_YN = PropertyService.getInstance().getProperty("aml.config", "RA_APPR_YN");
	request.setAttribute("RA_APPR_YN", RA_APPR_YN);
	
	// S 결재정보가져오기
	DataObj inputApr = new DataObj();
	inputApr.put("CD","S104");
	inputApr.put("GUBUN","RA3");
	com.gtone.aml.basic.common.data.DataObj obj = null;
	
	try{
	    obj = com.gtone.aml.dao.common.MDaoUtilSingle.getData("AML_APR_YN",inputApr);
	}catch(AMLException e){
	   Log.logAML(Log.ERROR, e);
	}
	
	// 사용여부
	String APP_YN = obj.getText("APP_YN");
	request.setAttribute("APP_YN",APP_YN);
	
	// 최초결재자ID
	String FIRST_APP_ID = obj.getText("FIRST_APP_ID");
	
	String[] REPLACE_FIRST_APP_ID = FIRST_APP_ID.split("-");
	String FIRST_SNO = "";
	for (int i=0; i<REPLACE_FIRST_APP_ID.length; i++) {
	   if(i==0){
	       FIRST_APP_ID = REPLACE_FIRST_APP_ID[0];
	       System.out.println("FIRST_APP_ID:"+FIRST_APP_ID);
	       request.setAttribute("FIRST_APP_ID",FIRST_APP_ID);
	
	   }else if(i==1){
	       FIRST_SNO = REPLACE_FIRST_APP_ID[1];
	       System.out.println("FIRST_SNO:"+FIRST_SNO);
	       request.setAttribute("FIRST_SNO",FIRST_SNO);
	   }
	}
	
	String USERNAME   = sessionAML.getsAML_USER_NAME();
	String BDPTCDNAME = sessionAML.getsAML_BDPT_CD_NAME();
	String BDPTCD     = sessionAML.getsAML_BDPT_CD();
	String ROLEID     = sessionAML.getsAML_ROLE_ID();
	String ROLENAME   = sessionAML.getsAML_ROLE_NAME();
	String RANKID     = sessionAML.getsAML_RANK_ID();
	
	request.setAttribute("USERNAME",USERNAME);
	request.setAttribute("BDPTCDNAME",BDPTCDNAME);
	request.setAttribute("BDPTCD",BDPTCD);
	request.setAttribute("ROLEID",ROLEID);
	request.setAttribute("ROLENAME",ROLENAME);
	request.setAttribute("RANKID",RANKID);
%>
<script>
    var GridObj1;
    var overlay    = new Overlay();
    var classID    = "AML_10_38_01_01";
    var pageID     = "AML_10_38_01_01";
    var USERNAME   = "${USERNAME}";
    var BDPTCDNAME = "${BDPTCDNAME}";
    var BDPTCD     = "${BDPTCD}";
    var ROLEID     = "${ROLEID}";
    var ROLENAME   = "${ROLENAME}";
    var stDate     = "${stDate}";
    var RANKID     = "${RANKID}";
    
    // [ Initialize ]
    $(document).ready(function(){
    	setupGrids();
        setupGrids2();
        doSearch();
        $("#btn_07").hide();
    	$("#btn_08").hide();
    });

    function doSearch()
    {
    	overlay.show(true, true);
        var params            = new Object();
 		var methodID          = "doSearch";
		var CS_TYP_CD         = form1.CS_TYP_CD.value;
		var NEW_OLD_GBN_CD    = form1.NEW_OLD_GBN_CD.value;

 		params.CS_TYP_CD      = CS_TYP_CD;
		params.NEW_OLD_GBN_CD = NEW_OLD_GBN_CD;
		params.RANKID         = RANKID;

 		sendService(classID, methodID, params, doSearch_success, doSearch_fail);
    }

    function doSearch_success(gridData, data){
    	if(gridData.length>0){
	        var obj = gridData[0];
	        var TARGET_ROLE_ID = obj.TARGET_ROLE_ID;
	        
	        form1.RA_SEQ.value        = obj.RA_SEQ;
			form1.RA_APP_NO.value     = obj.RA_APP_NO;
			form1.POSITION_NAME.value = obj.POSITION_NAME;
			form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
			form1.PRV_APP_NO.value    = obj.PRV_APP_NO;
			form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
			form1.SIMULGUBUN.value    = obj.SIMULGUBUN;
			
			$("#RA_SN_CCD_NM").val(obj.RA_SN_CCD_NM);
	        
			var rasnccd    = form1.RA_SN_CCD.value;
	        var simulgubun = form1.SIMULGUBUN.value;
			
	        if(ROLEID == "4") {
	        	if(rasnccd == "N") {
					$("#btn_03").show();
					$("#btn_06").show();
	        		$("#btn_07").show();
	        		$("#btn_08").show();
		        }else if(rasnccd == "S") {
					$("#btn_03").hide();
					$("#btn_06").hide();
		        	$("#btn_07").hide();
		        	$("#btn_08").hide();
		        }else if(rasnccd == "R") {
		        	$("#btn_06").show();
		        }else {
		        	$("#btn_03").hide();
		        	$("#btn_06").show();
		        	$("#btn_07").hide();
	        		$("#btn_08").hide();
		        }
	        	
	        }else if(ROLEID == "104") {
	        	if(rasnccd == "S") {
	        		$("#btn_04").show();
					$("#btn_05").show();
	        	}else {
	        		$("#btn_04").hide();
					$("#btn_05").hide();
	        	}
	        }
	        doSearch3();
	        
	        if((rasnccd == "N" ||rasnccd == "S" || rasnccd == "R") && simulgubun == "S") {
	        	doSearch2();
	        	$("#chart2").show();
	        }else {
	        	$("#chart2").hide();
	        	clearGridObj();
	        }
    	}
    	try {
        	GridObj1.refresh();
        	GridObj1.option("dataSource",gridData);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	    }
    }
    
    function doSearch3()
    {
    	overlay.show(true, true);
        var params            = new Object();
 		var methodID          = "doSearch3";
		var CS_TYP_CD         = form1.CS_TYP_CD.value;
		var NEW_OLD_GBN_CD    = form1.NEW_OLD_GBN_CD.value;

 		params.CS_TYP_CD      = CS_TYP_CD;
		params.NEW_OLD_GBN_CD = NEW_OLD_GBN_CD;

 		sendService(classID, methodID, params, doSearch3_success, doSearch_fail);
    }
    
    function doSearch3_success(gridData, data){
    	if(gridData.length>0){
	        var obj = gridData[0];	        
	        form3.JSON_RESULT.value = JSON.stringify(obj.JSON_RESULT);
	        
    	}
    	initChart1();
   	    overlay.hide();
    }
    
    function clearGridObj() {
    	GridObj2.cancelEditData();
  	    GridObj2.clearSelection();
  	    GridObj2.option('dataSource', []);
    }

    function doSearch2()
    {
    	overlay.show(true, true);
        var params            = new Object();
 		var methodID          = "doSearch2";
		var CS_TYP_CD         = form1.CS_TYP_CD.value;
		var NEW_OLD_GBN_CD    = form1.NEW_OLD_GBN_CD.value;

 		params.CS_TYP_CD      = CS_TYP_CD;
		params.NEW_OLD_GBN_CD = NEW_OLD_GBN_CD;
		params.RANKID         = RANKID;
		
 		sendService(classID, methodID, params, doSearch2_success, doSearch_fail);
    }

    function doSearch2_success(gridData, data){
    	if(gridData.length>0){
	        var obj = gridData[0];
	        
	        form1.RA_SEQ.value        = obj.RA_SEQ;
			form1.RA_APP_NO.value     = obj.RA_APP_NO;
			form1.POSITION_NAME.value = obj.POSITION_NAME;
			form1.RA_REF_SN_CCD.value = obj.RA_REF_SN_CCD;
			form1.PRV_APP_NO.value    = obj.PRV_APP_NO;
			form1.RA_SN_CCD.value     = obj.RA_SN_CCD;
			
			doSearch4();
    	}
    	try {
        	GridObj2.refresh();
        	GridObj2.option("dataSource",gridData);
   		} catch (e) {
   			showAlert(e,'ERR');
   	        overlay.hide();
   	    } finally {
   	        overlay.hide();
   	     	//initChart2();
   	    }
    }
    
    function doSearch4()
    {
    	overlay.show(true, true);
        var params            = new Object();
 		var methodID          = "doSearch4";
		var CS_TYP_CD         = form1.CS_TYP_CD.value;
		var NEW_OLD_GBN_CD    = form1.NEW_OLD_GBN_CD.value;

 		params.CS_TYP_CD      = CS_TYP_CD;
		params.NEW_OLD_GBN_CD = NEW_OLD_GBN_CD;

 		sendService(classID, methodID, params, doSearch4_success, doSearch_fail);
    }
    
    function doSearch4_success(gridData, data){
    	if(gridData.length>0){
	        var obj = gridData[0];	        
	        form4.JSON_RESULT.value = JSON.stringify(obj.JSON_RESULT);
	        
    	}
    	initChart2();
   	    overlay.hide();

    }

    function doSearch_fail(){ overlay.hide(); }

    function doSimul() {
    	showConfirm('${msgel.getMsg("AML_10_35_01_03_002","시뮬레이션을 실행하시겠습니까?")}', "실행",function(){
        var params            = new Object();
 		var methodID          = "doSave2";
		var CS_TYP_CD         = form1.CS_TYP_CD.value;
		var NEW_OLD_GBN_CD    = form1.NEW_OLD_GBN_CD.value;

 		params.CS_TYP_CD      = CS_TYP_CD;
		params.NEW_OLD_GBN_CD = NEW_OLD_GBN_CD;
 		sendService(classID, methodID, params, doSearch, doSearch_fail);
    	});
    }
    
    function doSave()
    {
    	form1.pageID.value = 'AML_10_38_01_02';
        window_popup_open(form1.pageID.value, 600, 300, '');
        form1.CS_TYP_CD.value      = form1.CS_TYP_CD.value;
		form1.NEW_OLD_GBN_CD.value = form1.NEW_OLD_GBN_CD.value;
        form1.target               = form1.pageID.value;
        form1.action               = "<c:url value='/'/>0001.do";
        form1.submit();
    }

    function doClear() {

    }
    
    /** 그리드 초기셋업 */
    function setupGrids()
    {
        GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
     	     gridId       			: "GTDataGrid1"
            ,width		 			: "100%"
            ,height		 			: "calc(45vh - 80px)"
			,elementAttr: { class: "grid-table-type" }
            ,hoverStateEnabled      : true
            ,wordWrapEnabled        : false
            ,allowColumnResizing    : true
            ,columnAutoWidth        : true
            ,allowColumnReordering  : true
            ,columnResizingMode     :'widget'  /* "widget" "nextColumn" */
            ,cacheEnabled           : false
            ,cellHintEnabled        : true
            ,showBorders            : true
            ,showColumnLines        : true
            ,showRowLines           : true
		    //,onToolbarPreparing   : makeToolbarButtonGrids
            ,loadPanel              : { enabled: false }
            , export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
            ,sorting         		: { mode: "none"}
            ,remoteOperations		: {
                 filtering   : false
                ,grouping    : false
                ,paging      : false
                ,sorting     : false
                ,summary     : false
             }
            ,editing 				: {
                 mode            : 'batch'
                ,allowUpdating   : false
                ,allowAdding     : false
             }
            ,filterRow              : { visible: false }
            ,rowAlternationEnabled  : true
            ,columnFixing           : { enabled: true }
            ,pager: {
	   	    	visible: false
	   	    	,showNavigationButtons: true
	   	    	,showInfo: true
	   	    }
	   	    ,paging: {
	   	    	enabled : false
	   	    	,pageSize : 20
	   	    }
		   	,scrolling : {
                mode            : "standard"
               ,preloadEnabled  : false
            }
            ,searchPanel: {visible : false,width   : 250}
            ,selection: {
                 allowSelectAll      : true
                ,deferred            : false
                ,mode                : 'none'    /* none, single, multiple                       */
                ,selectAllMode       : 'allPages'    /* 'page' | 'allPages'                          */
                ,showCheckBoxesMode  : 'onClick'      /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
             }
            ,columns: [
            	{caption: "현재 적용중",
            		columns : [
            			{dataField: "RA_GRD_NM"		,caption: "위험등급"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true},
            			{dataField: "RA_GRD_SCR"	,caption: "구간 값"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true},
            			{caption:"등급별 통계",
            				columns:[
            					{dataField: "TOTAL_CNT"	,caption: "고객수(A)"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, dataType : "number", visible : true, format: "fixedPoint"},
                        	    {dataField: "STR_CNT"	,caption: "STR 보고건수(B)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, dataType : "number",visible : true, format: "fixedPoint"},
                                {dataField: "STR_PER"	,caption: "STR 보고율(B/A,%)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true},
                                {dataField: "CTR_CNT"	,caption: "CTR 보고건수(C)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, dataType : "number",visible : true, format: "fixedPoint"},
                                {dataField: "CTR_PER"	,caption: "CTR 보고율(C/A,%)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true}
            				]
            			}
            		]
            	}
            ]
     }).dxDataGrid("instance");

    }

	/** 그리드 초기셋업 */
    function setupGrids2()
    {
        GridObj2 = $("#GTDataGrid2_Area").dxDataGrid({
     	     gridId       			: "GTDataGrid2"
            ,width		 			: "100%"
            ,height		 			: "calc(45vh - 80px)" 
			,elementAttr: { class: "grid-table-type" }
            ,hoverStateEnabled      : true
            ,wordWrapEnabled        : false
            ,allowColumnResizing    : true
            ,columnAutoWidth        : true 
            ,allowColumnReordering  : true
            ,columnResizingMode     :'widget'  /* "widget" "nextColumn" */
            ,cacheEnabled           : false
            ,cellHintEnabled        : true
            ,showBorders            : true
            ,showColumnLines        : true
            ,showRowLines           : true
		    //,onToolbarPreparing   : makeToolbarButtonGrids
            ,loadPanel              : { enabled: false }
            , export : {allowExportSelectedData: false,enabled: false,excelFilterEnabled: false}
            ,sorting         		: { mode: "none"}
            ,remoteOperations		: {
                 filtering   : false
                ,grouping    : false
                ,paging      : false
                ,sorting     : false
                ,summary     : false
             }
            ,editing 				: {
                 mode            : 'batch'
                ,allowUpdating   : false
                ,allowAdding     : false
             }
            ,filterRow              : { visible: false }
            ,rowAlternationEnabled  : true
            ,columnFixing           : { enabled: true }
            ,pager: {
	   	    	visible: false
	   	    	,showNavigationButtons: true
	   	    	,showInfo: true
	   	    }
	   	    ,paging: {
	   	    	enabled : false
	   	    	,pageSize : 20
	   	    }
		   	,scrolling : {
                mode            : "standard"
               ,preloadEnabled  : false
            }
            ,searchPanel: {visible : false,width   : 250}
            ,selection: {
                 allowSelectAll      : true
                ,deferred            : false
                ,mode                : 'none'    /* none, single, multiple                       */
                ,selectAllMode       : 'allPages'    /* 'page' | 'allPages'                          */
                ,showCheckBoxesMode  : 'onClick'      /* 'onClick' | 'onLongTap' | 'always' | 'none'  */
             }
            ,columns: [
            	{caption: "변경 예정",
            		columns : [
            			{dataField: "RA_GRD_NM"		,caption: "위험등급"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true},
            			{dataField: "RA_GRD_SCR"	,caption: "구간 값"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true},
            			{caption:"등급별 통계",
            				columns:[
            					{dataField: "TOTAL_CNT"	,caption: "고객수(A)"			,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, dataType : "number", visible : true, format: "fixedPoint"},
                        	    {dataField: "STR_CNT"	,caption: "STR 보고건수(B)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, dataType : "number",visible : true, format: "fixedPoint"},
                                {dataField: "STR_PER"	,caption: "STR 보고율(B/A,%)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true},
                                {dataField: "CTR_CNT"	,caption: "CTR 보고건수(C)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, dataType : "number",visible : true, format: "fixedPoint"},
                                {dataField: "CTR_PER"	,caption: "CTR 보고율(C/A,%)"	,alignment: "center"	,allowResizing: true,allowSorting: true,allowEditing: false, visible : true}
            				]
            			}
            		]
            	}
            ]
     }).dxDataGrid("instance");

    }

    function initChart1() {

    	var dataSource = JSON.parse(form3.JSON_RESULT.value);
    	
    	const maxPercent = Math.max(dataSource.map(d => Math.max(d.STR_PER,d.CTR_PER)));
    	
    	//console.log(dataSource);
    		
		//alert(TOTAL_CNT);
        $("#chart1").dxChart({
              "dataSource": dataSource
        	 ,"commonSeriesSettings": {
            							"argumentField": "RA_GRD_CD",
          							  }
            ,"series": [
		            	 	{
		            	 		valueField : "TOTAL_CNT",
		            	 		name : "고객수",
		            	 		type : "bar",
								axis : "countAxis"
		//						color : "#8BC34A"
							},
            	 			{
								valueField : "STR_PER",
								name : "STR보고율",
								type : "line",
								axis : "rateAxis"
// 								color : "#8BC34A"
							},
							{
								valueField : "CTR_PER",
								name : "CTR보고율",
								type : "line",
								axis : "rateAxis"
// 								color : "#8BC34A"
							},

                        ]
            
             ,"valueAxis" : [
            	 {
 					name : "countAxis",
 					position : "left",
					min:0,
					grid:{visible:true}
             	 },
            	 {
					name:"rateAxis",
					position:"right",
					min:0,
					max: Math.ceil(maxPercent / 100) *100,
					inverted: false,
					grid:{visible: false},
					label : {	
								customizeText: function(arg) {
									return arg.value + "%";
								}             	
					           
             				}
             	    
             	    
             				
				}
            	 
             ]
             ,"legend": {
                          "verticalAlignment": "top"
                         ,"horizontalAlignment": "center"
                        }

        });
    }

    function initChart2() {

	var dataSource = JSON.parse(form4.JSON_RESULT.value);
    	
    	const maxPercent = Math.max(dataSource.map(d => Math.max(d.STR_PER,d.CTR_PER)));
    	
    	//console.log(dataSource);
    		
		//alert(TOTAL_CNT);
        $("#chart2").dxChart({
              "dataSource": dataSource
        	 ,"commonSeriesSettings": {
            							"argumentField": "RA_GRD_CD",
          							  }
            ,"series": [
		            	 	{
		            	 		valueField : "TOTAL_CNT",
		            	 		name : "고객수",
		            	 		type : "bar",
								axis : "countAxis"
		//						color : "#8BC34A"
							},
            	 			{
								valueField : "STR_PER",
								name : "STR보고율",
								type : "line",
								axis : "rateAxis"
// 								color : "#8BC34A"
							},
							{
								valueField : "CTR_PER",
								name : "CTR보고율",
								type : "line",
								axis : "rateAxis"
// 								color : "#8BC34A"
							},

                        ]
            
             ,"valueAxis" : [
            	 {
 					name : "countAxis",
 					position : "left",
					min:0,
					grid:{visible:true}
             	 },
            	 {
					name:"rateAxis",
					position:"right",
					min:0,
					max: Math.ceil(maxPercent / 100) *100,
					inverted: false,
					grid:{visible: false},
					label : {	
								customizeText: function(arg) {
									return arg.value + "%";
								}             	
					           
             				}
             	    
             	    
             				
				}
            	 
             ]
             ,"legend": {
                          "verticalAlignment": "top"
                         ,"horizontalAlignment": "center"
                        }

        });
    }

  	//결재요청
    function PopKYCPage() {
    	var CS_TYP_CD      = form1.CS_TYP_CD.value;
    	var NEW_OLD_GBN_CD = form1.NEW_OLD_GBN_CD.value;
    	
    	var RA_SEQ         = form1.RA_SEQ.value;
		var RA_APP_NO      = form1.RA_APP_NO.value;
		var POSITION_NAME  = form1.POSITION_NAME.value;
		var RA_REF_SN_CCD  = form1.RA_REF_SN_CCD.value;
		
    	form1.pageID.value = 'AML_10_38_01_03';
	    window_popup_open(form1.pageID.value, 900, 680, '', '');
	    form1.target               = form1.pageID.value;
	    form1.CS_TYP_CD.value      = CS_TYP_CD;
    	form1.NEW_OLD_GBN_CD.value = NEW_OLD_GBN_CD; 
    	
    	form1.RA_SEQ.value         = RA_SEQ;
    	form1.RA_REF_SN_CCD.value  = RA_REF_SN_CCD;
    	form1.APP_NO.value         = RA_APP_NO;
		form1.POSITION_NAME.value  = POSITION_NAME;
		
		
	    form1.action           = "<c:url value='/'/>0001.do";
	    form1.submit();
  	}
  	
  	//결재완료
    function PopKYCPage3() {
    	var CS_TYP_CD      = form1.CS_TYP_CD.value;
    	var NEW_OLD_GBN_CD = form1.NEW_OLD_GBN_CD.value;
    	var RA_SEQ         = form1.RA_SEQ.value;
		var RA_APP_NO      = form1.RA_APP_NO.value;
		var PRV_APP_NO     = form1.PRV_APP_NO.value;
		var POSITION_NAME  = form1.POSITION_NAME.value;

    	form1.pageID.value = 'AML_10_38_01_03';
	    window_popup_open(form1.pageID.value, 900, 680, '', '');
	    form1.target               = form1.pageID.value;
	    form1.CS_TYP_CD.value      = CS_TYP_CD;
	    form1.NEW_OLD_GBN_CD.value = NEW_OLD_GBN_CD;
	    form1.RA_SEQ.value     	   = RA_SEQ;
	    form1.APP_NO.value         = RA_APP_NO;
        form1.PRV_APP_NO.value     = PRV_APP_NO;
	    form1.POSITION_NAME.value  = POSITION_NAME;
	    form1.action           = "<c:url value='/'/>0001.do";
	    form1.submit();
  	}
  	
  	//반려실행
    function PopKYCPage2() {
    	var CS_TYP_CD      = form1.CS_TYP_CD.value;
    	var NEW_OLD_GBN_CD = form1.NEW_OLD_GBN_CD.value;
    	
    	var RA_SEQ         = form1.RA_SEQ.value;
		var RA_APP_NO      = form1.RA_APP_NO.value;
		var POSITION_NAME  = form1.POSITION_NAME.value;

    	form1.pageID.value = 'AML_10_38_01_04';
        window_popup_open(form1.pageID.value, 900, 680, '', '');
        form1.target               = form1.pageID.value;
        form1.CS_TYP_CD.value      = CS_TYP_CD;
        form1.NEW_OLD_GBN_CD.value = NEW_OLD_GBN_CD;
        
        form1.RA_SEQ.value         = RA_SEQ;
        form1.POSITION_NAME.value  = POSITION_NAME;
        form1.APP_NO.value         = RA_APP_NO;

        form1.action = "<c:url value='/'/>0001.do";
        form1.submit();
  	}
    
  	//변경이력
    function doHistoryList() {
    	var CS_TYP_CD      = form1.CS_TYP_CD.value;
    	var NEW_OLD_GBN_CD = form1.NEW_OLD_GBN_CD.value;

    	form1.pageID.value = 'AML_10_38_01_05';
        window_popup_open(form1.pageID.value, 900, 680, '', '');
        form1.target = form1.pageID.value;
        form1.CS_TYP_CD.value      = CS_TYP_CD;
		form1.NEW_OLD_GBN_CD.value = NEW_OLD_GBN_CD;

        form1.action = "<c:url value='/'/>0001.do";
        form1.submit();
    }

  	//결재이력
	function PopKYCPage_Hist() {
		var CS_TYP_CD      = form1.CS_TYP_CD.value;
    	var NEW_OLD_GBN_CD = form1.NEW_OLD_GBN_CD.value;

		form1.pageID.value = 'AML_10_38_01_06';
		window_popup_open(form1.pageID.value, 900, 450, '','');
		form1.target               = form1.pageID.value;
		form1.CS_TYP_CD.value      = CS_TYP_CD;
		form1.NEW_OLD_GBN_CD.value = NEW_OLD_GBN_CD;
		form1.action           = "<c:url value='/'/>0001.do";
        form1.submit();
	}
    
  	function initialiZation(){
  		
  		showConfirm('${msgel.getMsg("AML_10_33_01_01_010","초기화 하시겠습니까?")}', "초기화",function(){
  		
  		var classID		      = "AML_10_38_01_01";
  	    var methodID	      = "doInitial";	
  		var CS_TYP_CD         = form1.CS_TYP_CD.value;
    	var NEW_OLD_GBN_CD    = form1.NEW_OLD_GBN_CD.value;
    	var RA_SEQ            = form1.RA_SEQ.value;
    	var params            = new Object();
    	 
    	params.CS_TYP_CD      = CS_TYP_CD;
    	params.NEW_OLD_GBN_CD = NEW_OLD_GBN_CD;
    	params.RA_SEQ         = RA_SEQ;

    	sendService(classID, methodID, params, doSave_end, doSearch_fail);
    	});
    	
  	}
  	
  	function doSave_end() {
		doSearch();
	}
    
    function IBMODELGRID() { doSearch(); }
</script>

<form name="form4">
	<input type="hidden" name="JSON_RESULT">	
</form>
<form name="form3">
	<input type="hidden" name="JSON_RESULT">
</form>

<form name="form1" method="post" onkeydown="doEnterEvent('doSearch');">
    <input type="hidden" name="pageID"              />
    <input type="hidden" name="classID"  id = "classID" >
    <input type="hidden" name="methodID" id = "methodID">
	<input type="hidden" name="POSITION_NAME">
	<input type="hidden" name="RA_REF_SN_CCD">
	<input type="hidden" name="RA_SN_CCD">
	<input type="hidden" name="RA_SEQ">
	<input type="hidden" name="RA_APP_NO">
	<input type="hidden" name="APP_NO">	
	<input type="hidden" name="PRV_APP_NO">
	<input type="hidden" name="SIMULGUBUN">
	<input type="hidden" name="SIMULsearch">
	
	<div class="inquiry-table type1">
		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel('AML_10_01_01_01_042','적용 대상')}
				<div class="content">
					<select name="CS_TYP_CD" id="CS_TYP_CD" class="dropdown" onChange='IBMODELGRID()'>
						<option value="01" cheked>개인</option>
	                	<option value="02">법인</option>
					</select>
				</div>
			</div>
		</div>
		<div class="table-row">
			<div class="table-cell">
				${condel.getLabel('AML_10_01_01_01_043','적용 모델')}
				<div class="content">
					<select name="NEW_OLD_GBN_CD" id="NEW_OLD_GBN_CD" class="dropdown" onChange='IBMODELGRID()'>
						<option value="A" >I모델</option> 
	                	<option value="B" cheked>B모델</option>
					</select>
				</div>
			</div>
		</div>
		<div class="table-row">
			<div class="table-cell">
				<div class="button-area" style="padding-bottom:8px; padding-right:36px; position:absolute; right:0;">
					${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"btn-36 filled"}')}
				</div>
			</div>
		</div>
	</div>


		<div style="display:flex;">

		<div class="button-area"> 
			<label>결재상태</label>
			<input type=text  name="RA_SN_CCD_NM" id="RA_SN_CCD_NM" style="text-align: center; width:100px; margin-left:10px; margin-right:10px;"   readonly>
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"apprHistoryBtn", defaultValue:"결재이력", mode:"R", function:"PopKYCPage_Hist", cssClass:"btn-36"}')}
		</div>

		<div class="button-area" style="width:100%;">
			${btnel.getButton(outputAuth, '{btnID:"btn_02", cdID:"changeHisBtn",defaultValue:"변경이력", 	mode:"R", function:"doHistoryList", cssClass:"btn-36"}')}
			<% if ( "4".equals(ROLEID)) {  %>
			${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"approvalBtn", defaultValue:"결재", 		mode:"R", function:"PopKYCPage", cssClass:"btn-36"}')}
			<% } %>
			<% if ( "104".equals(ROLEID)) {  %>
			${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"approvalBtn", defaultValue:"결재", 		mode:"R", function:"PopKYCPage3", cssClass:"btn-36"}')}
	       	${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"denyBtn", 	defaultValue:"반려", 		mode:"R", function:"PopKYCPage2", cssClass:"btn-36"}')}
	       	<% } %>
		</div>

		</div>

	<div style="display: flex; gap:20px;">
		<div class="tab-content-bottom" style="width:50%;">
	        <div id = "GTDataGrid1_Area" style="padding-top:8px;"></div>
	    </div>
	    <div class="tab-content-bottom" style="width:50%;">
			<div class="dash-board-cont-box" style="height:calc(92vh/2 - 83px);">
                <div style="display:inline-block;width:calc(100%);height:calc(100%); padding-top:8px;">
                    <div style="height:100%;width:100%;">
                    	<div id="chart1" style="width:100%;height:100%;text-align:center;"></div>
                    </div>
                </div>
			</div>
	    </div>
    </div>
    	<div style="color:black;text-align:center;float:left; font-size:10px; padding-right:10px;">
	 		<span>통계 산출 대상 기간 : <%= rstDate %> ~ <%= stDate %></span>
		</div>
		<div class="button-area">
		
		<div style="color:black;text-align:center;float:left; font-size:15px; padding-right:10px;">
	 		<span style="color:red;">※ 무분별한 시뮬레이션 수행은 시스템 운영에 과도한 부하를 줄 수 있으므로, 장중 사용이 불가합니다.(오후 4시 이후로만 사용가능)</span>
		</div>
		<% if ( "4".equals(ROLEID)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
			${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"rankmodify", 	defaultValue:"등급별 구간수정",	mode:"U", function:"doSave", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"RBA006",		defaultValue:"초기화", 		mode:"R", function:"initialiZation", cssClass:"btn-36"}')}
			${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"simulexcute", defaultValue:"시뮬레이션 수행", 	mode:"R", function:"doSimul", cssClass:"btn-36"}')}
		<% } %>
		</div>
    <div style="display: flex; gap:20px;">
		<div class="tab-content-bottom" style="width:50%;">
	        <div id = "GTDataGrid2_Area" style="padding-top:8px"></div>
	        <div style="color:black;text-align:center;float:left; font-size:10px; padding-right:10px; padding-top:5px; ">
	 			<span>통계 산출 대상 기간 : 시뮬레이션 수행시점 기준 최근 1년</span>
			</div>
	    </div>
	    <div class="tab-content-bottom" style="width:50%;">
			<div class="dash-board-cont-box" style="height:calc(92vh/2 - 83px);">
                <div style="display:inline-block;width:calc(100%);height:calc(100%); padding-top:8px;">
                    <div style="height:100%;width:100%;">
                    	<div id="chart2" style="width:100%;height:100%;text-align:center;"></div>
                    </div>
                </div>
			</div>
	    </div>
    </div>

</form>
</body>
</html>

<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />