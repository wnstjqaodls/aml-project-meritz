<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_07_02_02.jsp
* Description     : 고위험영역개선관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : SBJ
* Since           : 2018-04-25
--%>

<%@ page import="java.util.*" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true" />
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_02.RBA_50_07_02_02" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="org.omg.CORBA.UserException" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>


<%    
 
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLE_IDS",ROLE_IDS);
	String GUBN     	= request.getParameter("P_GUBN");
    
    String BAS_YYMM     = "";
    String PROC_FLD_C   = "";
    String PROC_LGDV_C  = "";
    String PROC_MDDV_C  = "";
    String PROC_SMDV_C  = "";
    String VALT_BRNO    = "";
    String N_YYMM_TITLE  = "";
    String O_YYMM_TITLE  = "";
    String C_YYMM_TITLE  = "";
    String POOL_SNO      = "";
    String GYLJ_S_C      = "";
    String GYLJ_S_C_NM; GYLJ_S_C_NM   = "";
    String GYLJ_ID   = "";
    String GYLJ_ROLE_ID   = "";
    String GYLJ_DT = "";
    
   	 BAS_YYMM     = request.getParameter("BAS_YYMM");
   	 PROC_FLD_C   = request.getParameter("PROC_FLD_C");
   	 PROC_LGDV_C  = request.getParameter("PROC_LGDV_C");
   	 PROC_MDDV_C  = request.getParameter("PROC_MDDV_C");
   	 PROC_SMDV_C  = request.getParameter("PROC_SMDV_C");
   	 VALT_BRNO    = request.getParameter("VALT_BRNO");
 	 POOL_SNO     = request.getParameter("POOL_SNO"); //개선관리번호
   	 GYLJ_S_C     = request.getParameter("GYLJ_S_C"); //결재상태코드
   	 GYLJ_ID      = request.getParameter("GYLJ_ID"); //결재ID
   	 GYLJ_ROLE_ID = request.getParameter("GYLJ_ROLE_ID"); //결재ROLE ID
   	
   	 //if(GYLJ_S_C == "") 
   	 if("".equals(GYLJ_S_C) == true)
   	 {		GYLJ_S_C = "0";  	 }
   
    
    DataObj input  = new DataObj();
    input.put("BAS_YYMM", BAS_YYMM);
    input.put("PROC_FLD_C", PROC_FLD_C);
    input.put("PROC_LGDV_C", PROC_LGDV_C);
    input.put("PROC_MDDV_C", PROC_MDDV_C);
    input.put("PROC_SMDV_C", PROC_SMDV_C);
    input.put("VALT_BRNO", VALT_BRNO);
    
    DataObj output = null;
    DataObj output3 = null;
    DataObj output4 = null;
    DataObj output5 = null;
    DataObj output21 = null;
    DataObj output22 = null;
    DataObj output23 = null;
    DataObj output33 = null;
    
    try{
   
     output = RBA_50_07_02_02.getInstance().doSearch1(input);
    
    request.setAttribute("BAS_YYMM"       , BAS_YYMM);        //기준년월
    request.setAttribute("PROC_FLD_C"     , PROC_FLD_C);      //업무영역
    request.setAttribute("POOL_SNO"       , POOL_SNO);      //개선관리번호
    
    request.setAttribute("VALT_BRNO"      , output.getText("VALT_BRNO"));        //부서코드
    request.setAttribute("IMPRV_BRNO"     , BDPT_CD);        //개선부점번호
    request.setAttribute("BDPT_CD"        , BDPT_CD);        //부점번호
    request.setAttribute("DPRT_NM"        , output.getText("DPRT_NM"));        //부서명
    request.setAttribute("USER_NM"        , output.getText("USER_NM"));        //RBA담당자
    request.setAttribute("DR_DT"          , output.getText("DR_DT"));        //등록일자
    request.setAttribute("GYLJ_S_C"       , output.getText("GYLJ_S_C"));        //결재상탴코드
    
    //out.println("GYLJ_S_C11="+output.getText("GYLJ_S_C"));
    
    request.setAttribute("GYLJ_S_C_NM"    , output.getText("GYLJ_S_C_NM"));        //결재상태
    request.setAttribute("GYLJ_ID"        , output.getText("GYLJ_ID"));        //결재상탴코드
    request.setAttribute("GYLJ_ROLE_ID"   , output.getText("GYLJ_ROLE_ID"));        //결재ROLE ID
    
    StringBuffer strDt = new StringBuffer(128);
  
    //if(!output.getText("GYLJ_DT").equals("") && output.getText("GYLJ_DT") != null){    
    if (output.getText("GYLJ_DT") != null) // 보안취약성 보완
    {
    	if("".equals(output.getText("GYLJ_DT")) == false)  { 
    		strDt.append(output.getText("GYLJ_DT").substring(0, 4));
    		strDt.append('-');
    		strDt.append(output.getText("GYLJ_DT").substring(4, 6));
    		strDt.append('-');
    		strDt.append(output.getText("GYLJ_DT").substring(6, 8));
  
    		 GYLJ_DT = strDt.toString();
    		 //GYLJ_DT = output.getText("GYLJ_DT").substring(0, 4)+"-"+output.getText("GYLJ_DT").substring(4, 6)+"-"+output.getText("GYLJ_DT").substring(6, 8);
    }
    }
    
    request.setAttribute("GYLJ_DT"   ,GYLJ_DT);        //결재(요청)일자
  
    request.setAttribute("PROC_LGDV_C"    , output.getText("PROC_LGDV_C"));        //대분류코드
    request.setAttribute("PROC_LGDV_C_NM" , output.getText("PROC_LGDV_C_NM"));        //대분류명
    request.setAttribute("PROC_MDDV_C"    , output.getText("PROC_MDDV_C"));        //중분류코드
    request.setAttribute("PROC_MDDV_C_NM" , output.getText("PROC_MDDV_C_NM"));     //중분류명
    request.setAttribute("PROC_SMDV_C"    , output.getText("PROC_SMDV_C"));        //소분류코드
    request.setAttribute("PROC_SMDV_NM"   , output.getText("PROC_SMDV_NM"));       //소분류명
    
     output5 = RBA_50_07_02_02.getInstance().doSearch5(input);
    
    request.setAttribute("N_YYMM"    , output5.getText("N_YYMM"));        
    request.setAttribute("O_YYMM"    , output5.getText("O_YYMM"));         
    request.setAttribute("C_YYMM"    , output5.getText("C_YYMM"));    
    
    input.put("N_YYMM", output5.getText("N_YYMM"));
    input.put("O_YYMM", output5.getText("O_YYMM"));
    
    StringBuffer strTitle = new StringBuffer(128);
   
    if( !StringUtils.isEmpty(output5.getText("N_YYMM")) ){
    	strTitle.append(output5.getText("N_YYMM").substring(0, 4));
    	strTitle.append("년&nbsp;");
    	strTitle.append(output5.getText("N_YYMM").substring(5, 6));
    	strTitle.append('월');

    	N_YYMM_TITLE = strTitle.toString();
   		//N_YYMM_TITLE = output5.getText("N_YYMM").substring(0, 4)+"년&nbsp;"+output5.getText("N_YYMM").substring(5, 6)+"월";
    }
   	
    if( !StringUtils.isEmpty(output5.getText("O_YYMM")) ){
    	strTitle.append(output5.getText("O_YYMM").substring(0, 4));
    	strTitle.append("년&nbsp;");
    	strTitle.append(output5.getText("O_YYMM").substring(5, 6));
    	strTitle.append('월');

    	O_YYMM_TITLE = strTitle.toString();
   		//O_YYMM_TITLE = output5.getText("O_YYMM").substring(0, 4)+"년&nbsp;"+output5.getText("O_YYMM").substring(5, 6)+"월";
    }
   	
    if( !StringUtils.isEmpty(output5.getText("C_YYMM")) ){
    	strTitle.append(output5.getText("C_YYMM").substring(0, 4));
    	strTitle.append("년&nbsp;");
    	strTitle.append(output5.getText("C_YYMM").substring(5, 6));
    	strTitle.append('월');

    	C_YYMM_TITLE = strTitle.toString();
   		//C_YYMM_TITLE = output5.getText("C_YYMM").substring(0, 4)+"년&nbsp;"+output5.getText("C_YYMM").substring(5, 6)+"월";
    }
    
    
    
    request.setAttribute("N_YYMM_TITLE", N_YYMM_TITLE); 
    request.setAttribute("O_YYMM_TITLE", O_YYMM_TITLE); 
    request.setAttribute("C_YYMM_TITLE", C_YYMM_TITLE); 
       
     output21 = RBA_50_07_02_02.getInstance().doSearch21(input);
    
    request.setAttribute("RSK_VALT_PNT"    , output21.getText("RSK_VALT_PNT"));        //총위험점수 
    request.setAttribute("TONGJE_VALT_PNT" , output21.getText("TONGJE_VALT_PNT"));     // 통제위험점수
    request.setAttribute("REMDR_RSK_PNT"   , output21.getText("REMDR_RSK_PNT"));      // 통제위험백분위
    request.setAttribute("REMDR_RSK_GD_C_NM1"     , output21.getText("REMDR_RSK_GD_C_NM1"));  // 잔여위험등급
    
     output22 = RBA_50_07_02_02.getInstance().doSearch22(input);
    request.setAttribute("RSK_VALT_PNT2"    , output22.getText("RSK_VALT_PNT2"));        //총위험점수 
    request.setAttribute("TONGJE_VALT_PNT2" , output22.getText("TONGJE_VALT_PNT2"));     // 통제위험점수
    request.setAttribute("REMDR_RSK_PNT2"   , output22.getText("REMDR_RSK_PNT2"));      // 통제위험백분위
    request.setAttribute("REMDR_RSK_GD_C_NM2"     , output22.getText("REMDR_RSK_GD_C_NM2"));  // 잔여위험등급
    
     output23  = RBA_50_07_02_02.getInstance().doSearch23(input);
    request.setAttribute("REMDR_RSK_GD_C_NM3"     , output23.getText("REMDR_RSK_GD_C_NM3"));  // 잔여위험등급
 
     output3 = RBA_50_07_02_02.getInstance().doSearch3(input);  //Top5 Risk Factor
    
    String cnt = output3.getText("CNT");
    int mltfCnt = 0;
    
    //DataObj output32 = RBA_50_07_02_02.getInstance().doSearch32(input);
    
     output33 = RBA_50_07_02_02.getInstance().doSearch33(input);
    
    request.setAttribute("LVL1"    , output33.getText("LVL1"));        //총위험점수 
    request.setAttribute("LVL2"    , output33.getText("LVL2"));     // 통제위험점수
    request.setAttribute("LVL3"    , output33.getText("LVL3"));      // 통제위험백분위
    request.setAttribute("LST_TONGJE_VALT_PNT1"     , output33.getText("LST_TONGJE_VALT_PNT1"));  // 잔여위험등급
    request.setAttribute("LST_TONGJE_VALT_PNT2"     , output33.getText("LST_TONGJE_VALT_PNT2"));  // 잔여위험등급
    request.setAttribute("LST_TONGJE_VALT_PNT3"     , output33.getText("LST_TONGJE_VALT_PNT3"));  // 잔여위험등급
    request.setAttribute("TONGJE_NO"     , output33.getText("TONGJE_ACT_TITE"));  // 잔여위험등급
    
    if(("0").equals(cnt)){
    	mltfCnt = 0;
    	
    } else {
    	mltfCnt =  output3.getCount();
    }
    
   
   
    output4 = RBA_50_07_02_02.getInstance().doSearch4(input);
    
    request.setAttribute("IMPRV_CNFRME"    , output4.getText("IMPRV_CNFRME"));  
    request.setAttribute("IMPRV_STRG_CTNT" , output4.getText("IMPRV_STRG_CTNT"));  
    request.setAttribute("IMPRV_STRG_CTNT2" , output4.getText("IMPRV_STRG_CTNT"));  
    request.setAttribute("MAIN_EXEC_CTNT"  , output4.getText("MAIN_EXEC_CTNT"));        
    request.setAttribute("IMPRV_RSLT_CTNT" , output4.getText("IMPRV_RSLT_CTNT"));     
    
    request.setAttribute("GUBN",GUBN);
    request.setAttribute("DR_OP_JKW_NO",sessionAML.getsAML_LOGIN_ID()); // 등록조작자번호
    request.setAttribute("CHG_OP_JKW_NO",sessionAML.getsAML_LOGIN_ID()); // 등록조작자번호
    
    request.setAttribute("MLTF_CNT",mltfCnt); // 등록조작자번호
    
    String TONJE_BRNO_YN     	= request.getParameter("TONJE_BRNO_YN");
    request.setAttribute("TONJE_BRNO_YN",TONJE_BRNO_YN); // 등록조작자번호
    
    }catch(UserException e){
    	Log.logAML(Log.ERROR,this,"(Exception)",e.toString());
    }
   
%>

<style>
.table-title {
	font-family: SpoqB;
	font-size: 16px;
	line-height: 24px;
	color: #444;
	letter-spacing: -0.32px;
}
</style>

    <script language="JavaScript">
    var GridObj1; 
    var classID   = "RBA_50_07_02_02";
    var GYLJ_S_C  = "${GYLJ_S_C}";
    var ROLE_ID   = '${ROLE_IDS}';
    var GYLJ_ROLE_ID =  '${GYLJ_ROLE_ID}';
    var BDPT_CD =  '${BDPT_CD}';
    var IMPRV_BRNO =  '${IMPRV_BRNO}';
    var MLTF_CNT = '${MLTF_CNT}';
    var TONJE_BRNO_YN = '${TONJE_BRNO_YN}'; 
    
    // Initialize
    $(document).ready(function(){
        setupGrids();
        setButtonDisplay(); 

		if(TONJE_BRNO_YN=="Y"){
			document.getElementById("MLTF_DIV").style.display = "none";
			document.getElementById("MLTF_TITLE_DIV").style.display = "none";

			document.getElementById("TJ_DIV").style.display = "block";
			document.getElementById("TJ_TITLE_DIV").style.display = "block";
			document.getElementById("TJ_DIV_DETAIL").style.display = "block";
			
		} else {
			document.getElementById("TJ_DIV").style.display = "none";
			document.getElementById("TJ_TITLE_DIV").style.display = "none";
			document.getElementById("TJ_DIV_DETAIL").style.display = "none";

			document.getElementById("MLTF_DIV").style.display = "block";
			document.getElementById("MLTF_TITLE_DIV").style.display = "block"; 

		}
			
        
        form.POOL_SNO.value = "${POOL_SNO}";
       
        if(form.POOL_SNO.value=="0"){
        	document.getElementById("IMPRV_CNFRME").readOnly = true;
        	document.getElementById("MAIN_EXEC_CTNT").readOnly = true;
        }
     
    });
    
    // Initial function
    function init() { initPage(); }
    
    function setupGrids(){
   GridObj1 = $("#GTDataGrid1_Area").dxDataGrid({
			 height	:"calc(90vh - 100px)",
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
			    "loadPanel" : { enabled: false },
			    "export":                  {
			        "allowExportSelectedData": true,
			        "enabled": false,
			        "excelFilterEnabled": true,
			        "fileName": "gridExport"
			    },
			    "sorting": {"mode": "multiple"},
			    "remoteOperations":                  {
			        "filtering": false,
			        "grouping": false,
			        "paging": false,
			        "sorting": false,
			        "summary": false
			    },
			    "editing":                  {
			        "mode": "batch",
			        "allowUpdating": false,
			        "allowAdding": true,
			        "allowDeleting": false
			    },
			    "filterRow": {"visible": false},
			    "rowAlternationEnabled": true,
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
			    "searchPanel":                  {
			        "visible": false,
			        "width": 250
			    },
			    "selection":                  {
			        "allowSelectAll": true,
			        "deferred": false,
			        "mode": "single",
			        "selectAllMode": "allPages",
			        "showCheckBoxesMode": "onClick"
			    },
			    "columns":[
			    
			            {
				            "dataField": "BAS_YYMM",
				            "caption": '${msgel.getMsg("RBA_50_08_07_001","기준년월")}',
				            "visible": false,
				            "alignment": "right",
				            "allowResizing": true,
				            "allowSearch": true,
				            "allowSorting": true
			        	}
			        
			    ],
			     onCellPrepared       : function(e){
			        var columnName = e.column.dataField;
			        var dataGrid   = e.component;
			        var rowIndex   = dataGrid.getRowIndexByKey(e.key);
			        var remdrRskGdcNm1       = dataGrid.cellValue(rowIndex, 'REMDR_RSK_GD_C_NM1');
			        if(rowIndex != -1){
			                if((remdrRskGdcNm1 =='Yellow') && (columnName == 'REMDR_RSK_GD_C_NM1')){
			                    e.cellElement.css('background-color', '#FFFF00');
			                }
			        }
			    },
			    onCellClick: function(e){
			        if(e.data){
			            Grid1CellClick('gridId', e.data, e.data, e.rowIndex, e.columnIndex, e.column.dataField);
			        }
			    } 
       }).dxDataGrid("instance");
    }
     
    function setButtonDisplay() {
    
    	if("3"== ROLE_ID ) { //지점담당자일 경우 승인, 반려버튼 삭제
    		
    		if(GYLJ_S_C=="0"){	//미수행
    			$("#btn_03").attr("style","display:none;");//승인요청버튼
    			$("#btn_05").attr("style","display:none;");//승인버튼
            	$("#btn_06").attr("style","display:none;");//반려버튼
    		} else if(GYLJ_S_C=="11"){//저장
    			
    			
    			$("#btn_03").attr("style","inline-block;");//승인요청버튼	
    			$("#btn_05").attr("style","display:none;");//승인버튼
            	$("#btn_06").attr("style","display:none;");//반려버튼
    		} else if(GYLJ_S_C=="21"){//진행중	
        		$("#btn_01").attr("style","display:none;");//저장버튼
    			$("#btn_03").attr("style","display:none;");//승인요청버튼
            	$("#btn_05").attr("style","display:none;");//승인버튼
            	$("#btn_06").attr("style","display:none;");//반려버튼
    		} else if(GYLJ_S_C=="22"){//반려	
    			$("#btn_05").attr("style","display:none;");//승인버튼
            	$("#btn_06").attr("style","display:none;");//반려버튼
    		}  
    	
        	
    	} else if("4"== ROLE_ID ) { //본점담당자일 경우 
    	
    	    if(GYLJ_S_C=="0"){	//미수행이면
    	    	
    	    
	    		$("#btn_03").attr("style","display:none;");//승인요청 삭제 
    	       	$("#btn_05").attr("style","display:none;");//승인버튼
            	$("#btn_06").attr("style","display:none;");//반려버튼	
            	
			} else if(GYLJ_S_C=="11"){//저장
				
		
				if(BDPT_CD==IMPRV_BRNO) { //본점건이면
					$("#btn_05").attr("style","display:none;");//승인버튼
	            	$("#btn_06").attr("style","display:none;");//반려버튼
				} else { //지점건이면
					$("#btn_03").attr("style","display:none;");//승인요청 삭제 
					$("#btn_05").attr("style","display:none;");//승인버튼
	            	$("#btn_06").attr("style","display:none;");//반려버튼
				}
				
				
					
    		} else if(GYLJ_S_C=="21"){//진행중	
    			
    			$("#btn_01").attr("style","display:none;");//저장버튼
    			$("#btn_03").attr("style","display:none;");//승인요청버튼
    			
    			if(ROLE_ID == GYLJ_ROLE_ID){
                   
	            	$("#btn_05").attr("style","display:inline-block;");//승인버튼
	            	$("#btn_06").attr("style","display:inline-block;");//반려버튼
    			} else {
    				$("#btn_05").attr("style","display:none;");//승인버튼
                	$("#btn_06").attr("style","display:none;");//반려버튼
    			}
    			
			} else if(GYLJ_S_C=="22"){//반려	
				
				if(ROLE_ID == GYLJ_ROLE_ID){
					$("#btn_01").attr("style","display:none;");//저장버튼 삭제 
					//$("#btn_03").attr("style","display:inline-block;");//승인요청버튼
			 		//$("#btn_03").attr("style","display:none;");//승인요청버튼
	    			$("#btn_05").attr("style","display:none;");//승인버튼
	    			if(BDPT_CD==IMPRV_BRNO) {
	    				$("#btn_06").attr("style","display:none;");//반려버튼 
	    	  		}else{	
	    				$("#btn_06").attr("style","display:inline-block;");//반려버튼 
	    			}
			 	} else {
			 		
			 		$("#btn_01").attr("style","display:none;");//저장버튼 삭제 
			 		$("#btn_03").attr("style","display:none;");//승인요청버튼
	    			$("#btn_05").attr("style","display:none;");//승인버튼
	            	$("#btn_06").attr("style","display:none;");//반려버튼
			 	}
    		}   
        	
	    } else if("104"== ROLE_ID ) { // 본점책임자 버튼 제어
	    	
	    	
			if(GYLJ_S_C=="0"){	//미수행
    			$("#btn_03").attr("style","display:none;");//승인요청버튼
    			$("#btn_05").attr("style","display:none;");//승인버튼
            	$("#btn_06").attr("style","display:none;");//반려버튼
			} else if(GYLJ_S_C=="11"){ //저장
				
				$("#btn_03").attr("style","display:none;");//승인요청버튼
	    	 	$("#btn_05").attr("style","display:none;");//승인버튼
            	$("#btn_06").attr("style","display:none;");//반려버튼
	    	} else if(GYLJ_S_C=="21"){ //진행중
	    	
    			$("#btn_01").attr("style","display:none;");//저장버튼 삭제 
    	       	$("#btn_03").attr("style","display:none;");//승인요청 삭제 
    	       	
    	       	if(ROLE_ID == GYLJ_ROLE_ID){
	            	$("#btn_05").attr("style","display:inline-block;");//승인버튼
	            	$("#btn_06").attr("style","display:inline-block;");//반려버튼
    			} else {
    				$("#btn_05").attr("style","display:none;");//승인버튼
                	$("#btn_06").attr("style","display:none;");//반려버튼
    			}	
			} else if(GYLJ_S_C=="22"){//반려	
				$("#btn_01").attr("style","display:none;");//저장버튼 삭제 
    			$("#btn_03").attr("style","display:none;");//승인요청버튼 삭제
            	$("#btn_05").attr("style","display:none;");//승인버튼 삭제
            	$("#btn_06").attr("style","display:none;");//반려버튼 삭제
    		}   
	    } else if( "6"== ROLE_ID) { //지점책임자 버튼 제어
	    	
	    	if(GYLJ_S_C=="0"){	//미수행이면
	    		$("#btn_03").attr("style","display:none;");//승인요청 삭제 
    	       	$("#btn_05").attr("style","display:none;");//승인버튼 삭제
            	$("#btn_06").attr("style","display:none;");//반려버튼 삭제
    		} else if(GYLJ_S_C=="11"){
    			
    			$("#btn_03").attr("style","display:none;");//승인요청버튼 삭제
    		 	$("#btn_05").attr("style","display:none;");//승인버튼 삭제
            	$("#btn_06").attr("style","display:none;");//반려버튼 삭제
    		
    		} else if(GYLJ_S_C=="21"){ //진행중
    			$("#btn_01").attr("style","display:none;");//저장버튼 삭제 
    	       	$("#btn_03").attr("style","display:none;");//승인요청 삭제 
    	       	
    	       	if(ROLE_ID == GYLJ_ROLE_ID){
	            	$("#btn_05").attr("style","display:inline-block;");//승인버튼
	            	$("#btn_06").attr("style","display:inline-block;");//반려버튼
    			} else {
    				$("#btn_05").attr("style","display:none;");//승인버튼
                	$("#btn_06").attr("style","display:none;");//반려버튼
    			}
    	       	
    	      
			} else if(GYLJ_S_C=="22"){//반려	
			 	if(ROLE_ID == GYLJ_ROLE_ID){
			 		
			 		$("#btn_03").attr("style","display:none;");//승인요청버튼
	    			$("#btn_05").attr("style","display:none;");//승인버튼
	    			$("#btn_06").attr("style","display:inline-block;");//반려버튼 
			 	} else {
			 		
			 		$("#btn_01").attr("style","display:none;");//저장버튼 삭제 
			 		$("#btn_03").attr("style","display:none;");//승인요청버튼
	    			$("#btn_05").attr("style","display:none;");//승인버튼
	            	$("#btn_06").attr("style","display:none;");//반려버튼
			 	}
				
    		} 
    
        } else { //나머지 권한들은 다 버튼 없음
        	
        	//저장버튼 삭제
        	$("#btn_01").attr("style","display:none;");
       		//승인요청버튼 삭제
           	$("#btn_03").attr("style","display:none;");
       		//승인버튼 삭제
           	$("#btn_05").attr("style","display:none;");
           	//반려버튼 삭제
           	$("#btn_06").attr("style","display:none;");
       } 
    	    	
    	if(GYLJ_S_C=="3"){//완료	 	
        	//저장버튼 삭제
        	$("#btn_01").attr("style","display:none;");
       		//승인요청버튼 삭제
           	$("#btn_03").attr("style","display:none;");
       		//승인버튼 삭제
           	$("#btn_05").attr("style","display:none;");
           	//반려버튼 삭제
           	$("#btn_06").attr("style","display:none;");
    	}
    }	
   
    //개선방안 선택입력, 직접입력 display설정
    function setContDisplay(flag) {
    	
       if(flag=='S'){
    		
        	 form.INP_MODE.value = 'S';
        	
       } else if(flag=='D'){
    	   document.getElementById("IMPRV_CNFRME").readOnly = true;
       	   document.getElementById("MAIN_EXEC_CTNT").readOnly = true;
   		   form.INP_MODE.value = 'D';
   		   form.IMPRV_CNFRME.value = "";
    	   form.MAIN_EXEC_CTNT.value ="" ;
    	   form.IMPRV_RSLT_CTNT.focus();
       }
    	
    }
    
 	// 개선관리 저장
    function doSave(){
 		
        var IMPRV_RSLT_CTNT="";

        if(form.POOL_SNO.value == ""){
        	form.POOL_SNO.value = 0;
        }
        
        var IMPRV_STRG_CTNT = "";
        if(MLTF_CNT=="0"){
        	IMPRV_STRG_CTNT  = form.IMPRV_STRG_CTNT2.value;
        } else {
        	IMPRV_STRG_CTNT  = form.IMPRV_STRG_CTNT.value;
        }
        

         showConfirm("${msgel.getMsg('AML_10_01_01_01_004','저장하시겠습니까?')}", "저장",function(){
         	var params   = new Object();
         	var methodID = "doSave";
         	var classID  =  "RBA_50_07_02_02";
         	 		
         	params.pageID 	=  "RBA_50_07_02_02";
         	params.GUBN        = "${GUBN}";
         	params.BAS_YYMM    = "${BAS_YYMM}";
         	params.PROC_FLD_C  = "${PROC_FLD_C}";
         	params.PROC_LGDV_C = "${PROC_LGDV_C}";
         	params.PROC_MDDV_C = "${PROC_MDDV_C}";
         	params.PROC_SMDV_C = "${PROC_SMDV_C}";
         	params.VALT_BRNO   = "${VALT_BRNO}";
         	params.IMPRV_CMPT_YN   = 0;
         	params.IMPRV_BRNO  = "${IMPRV_BRNO}";
         	params.POOL_SNO    = form.POOL_SNO.value;
        	 //"ATTCH_FILE_NO    = form.ATTCH_FILE_NO.value;
        	params.ATTCH_FILE_NO    = 0;
        	params.GYLJ_S_C         = "11";
        	params.GYLJ_ID         = 0;
        	params.GYLJ_ROLE_ID    = 0;
        	params.IMPRV_STRG_CTNT = IMPRV_STRG_CTNT;
        	params.IMPRV_RSLT_CTNT = form.IMPRV_RSLT_CTNT.value;
        	
         	
         	sendService(classID, methodID, params, doSave_end, doSave_end); 
         });
	}

	// Risk Event상세 저장 end
	function doSave_end(){
		
		
	   $("button[id='btn_01']").prop('disabled', false);
	   
	   showAlert('저장되었습니다.','WARN');
	   window.close();
	   
	   opener.doSearch();
	   opener.form2.P_GUBN.value = "";
	  
	}
	
	// 닫기
	function doClose(){
		opener.form2.P_GUBN.value = "";
	   window.close();
	}
 	
 	
    // 고위험영역개선관리 승인요청
    function openGyljPopUp0() {
 		
        openGyljPopUp(0);
    }
 	
 	
    // 승인
    function openGyljPopUp2() {
   		/* validation 추가 */
   		//ROLE_ID 체크
   		
        openGyljPopUp(2);
    }
    
 	// 반려
    function openGyljPopUp22() {
    /* validation 추가 */
    
        openGyljPopUp(1);
    }
    
    // 고위험영역개선관리 반려
    function openGyljPopUp1() {
        openGyljPopUp(1);
    }
    
    // 고위험영역개선관리 - 결재(RBA_50_07_02_04) 팝업 호출 function
    function openGyljPopUp(flag) {
    	
    	
        form3.pageID.value  = "RBA_50_07_02_04";
        
        var win = window_popup_open(form3, 650, 260, '', 'yes');
        
        form3.BAS_YYMM.value    = "${BAS_YYMM}" ;       		    //기준년월
		form3.PROC_FLD_C.value  = "${PROC_FLD_C}";
        form3.PROC_LGDV_C.value = "${PROC_LGDV_C}";
        form3.PROC_MDDV_C.value = "${PROC_MDDV_C}";
        form3.PROC_SMDV_C.value = "${PROC_SMDV_C}";
        form3.VALT_BRNO.value   = "${VALT_BRNO}";        
        form3.GYLJ_ID.value     = "${GYLJ_ID}";
        
        
        if(flag == "0"){
    		form3.GYLJ_S_C.value  = "21";
    	} else {
    		form3.GYLJ_S_C.value = "${GYLJ_S_C}";
    	}
        
        form3.GYLJ_JKW_NM.value = "${GYLJ_JKW_NM}";
        form3.GYLJ_G_C.value    = "${GYLJ_G_C}";
        form3.FLAG.value    	= flag;
        form3.GYLJ_MODE.value   = "S";

        form3.target            = form3.pageID.value;
        form3.action            = "<c:url value='/'/>0001.do"; 
        form3.submit();
      
    }
    
 	// 개선방안선택 팝업
    function PopImpPool() {
    		var win;      win = window_popup_open(form2, 960, 645, '', 'yes');
            
    		form2.pageID.value     = "RBA_50_07_01_01_Popup";
    		form2.target           = form2.pageID.value;
    		form2.action           = '<c:url value="/"/>0001.do';
    		form2.submit();
    }
  
    
</script>

<form name="form3" method="post" >
    <input type="hidden" name="pageID" > 
    <input type="hidden" name="classID" > 
    <input type="hidden" name="methodID" >
	<input type="hidden" name="BAS_YYMM">
	<input type="hidden" name="PROC_FLD_C">
	<input type="hidden" name=PROC_LGDV_C>
	<input type="hidden" name="PROC_MDDV_C">
	<input type="hidden" name="PROC_SMDV_C">
	<input type="hidden" name="VALT_BRNO">
    <input type="hidden" name="GYLJ_ID" >
    <input type="hidden" name="GYLJ_S_C" >
    <input type="hidden" name="GYLJ_JKW_NM" >
    <input type="hidden" name="FLAG" >
    <input type="hidden" name="GYLJ_G_C" >
    <input type="hidden" name="GYLJ_MODE" >
</form>

<form name="form2" method="post">
    <input type="hidden" id="pageID" name="pageID"> 
    <input type="hidden" id="classID" name="classID"> 
    <input type="hidden" id="methodID" name="methodID">
</form>    

<form name="form" method="post" >
<input type="hidden" name="pageID" >
<input type="hidden" name="classID">
<input type="hidden" name="methodID">

<input type="hidden" name="POOL_SNO">
<input type="hidden" name="GYLJ_S_C">
<input type="hidden" name="GYLJ_ROLE_ID">
<input type="hidden" name="INP_MODE">

<div id="cust_info" class="" style="overflow-y  : auto; height : calc(100vh - 140px);">
    <div class="table-title">
        ${msgel.getMsg('RBA_50_70_02_02_001','AML업무프로세스')}
    </div>
 
    <div class="table-box4" >
        <table class="basic-table">
           <tr>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_002','부서코드')}</th>
                <td style="text-align: center;"><span id="VALT_BRNO" class="font_s">${VALT_BRNO}</span></td>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_003','부서명')}</th>
                <td><span id="DPRT_NM" class="font_s">${DPRT_NM}</span></td>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_004','RBA담당자')}</th>
                <td><span id="USER_NM" class="font_s">${USER_NM}</span></td>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_039','결재일자')}</th>
                <td style="text-align: right;"><span id="GYLJ_DT" class="font_s">${GYLJ_DT}</span></td>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_038','결재상태')}</th>
                <td style="text-align: center;"><span id="GYLJ_S_C_NM" class="font_s">${GYLJ_S_C_NM}</span></td> 
            </tr>
            
           <tr>
                <th class="title" rowspan="2" style="text-align: center;">업무  Process</th>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_007','L1')}</th>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_008','대분류(L1)')}</th>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_009','L2')}</th>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_010','중분류(L2)')}</th>
                <th class="title" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_011','L3')}</th>
                <th class="title" colspan="4" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_012','소분류(L3)')}</th>  
            </tr>
            <tr>
                <td style="text-align: center;">&nbsp;${PROC_LGDV_C}</td>
                <td style="text-align: center;">&nbsp;${PROC_LGDV_C_NM}</td>
                <td style="text-align: center;">&nbsp;${PROC_MDDV_C}</td>
                <td style="text-align: center;">&nbsp;${PROC_MDDV_C_NM}</td>
                <td style="text-align: center;">&nbsp;${PROC_SMDV_C}</td>
                <td colspan='4' style="text-align: center;">&nbsp;${PROC_SMDV_NM}</td>
            </tr>  
          
        </table>
    </div>

    <div class="table-title" style="margin-top:8px;">
       ${msgel.getMsg('RBA_50_70_02_02_013','RBA 위험평가')}
    </div>
     
    <div class="table-box4" >
        <table class="basic-table">
            <tr style="width:100%">
                <th class="title" rowspan="3" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_013','RBA<br>위험평가<br>결과')}</th>
                <th class="title" colspan="4" align="center">${O_YYMM_TITLE}</th>
                <th class="title" colspan="4" align="center">${C_YYMM_TITLE}</th>
                <th class="title" colspan="3" align="center">${msgel.getMsg('RBA_50_70_02_02_014','잔여등급위험등급 추세')}</th>
            </tr>
            <tr style="width:100%">
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_015','총위험점수')}</b></td> 
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_017','통제위험점수')}</b></td> 
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_044','잔여위험점수')}</b></td> 
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_019','잔여위험등급')}</b></td>
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_020','총위험점수')}</b></td> 
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_022','통제위험점수')}</b></td> 
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_044','잔여위험점수')}</b></td> 
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_019','잔여위험등급')}</b></td> 
                <td style="background-color: #eff1f5;" align="center">&nbsp;<b>${N_YYMM_TITLE}</b></td>
                <td style="background-color: #eff1f5;" align="center">&nbsp;<b>${O_YYMM_TITLE}</b></td>
                <td style="background-color: #eff1f5;" align="center">&nbsp;<b>${C_YYMM_TITLE}</b></td>
            </tr>
          
             <tr style="width:100%">
                <td align="right">&nbsp;${RSK_VALT_PNT}</td>
                <td align="right">&nbsp;${TONGJE_VALT_PNT}</td>
                <td align="right">&nbsp;${REMDR_RSK_PNT}</td>
                
                <% 
                   if(("Green").equals( output21.getText("REMDR_RSK_GD_C_NM1"))) {                	   
                %>
                <td style="background-color:#00FF00" align="center">&nbsp;${REMDR_RSK_GD_C_NM1}</td>
                <% 
                   } else if(("Yellow").equals( output21.getText("REMDR_RSK_GD_C_NM1"))) {
                %>
                <td style="background-color:yellow" align="center">&nbsp;${REMDR_RSK_GD_C_NM1}</td>
                <% 
                  } else if( ("Red").equals(output21.getText("REMDR_RSK_GD_C_NM1"))) {
                 %>
                 <td style="background-color:red" align="center">&nbsp;${REMDR_RSK_GD_C_NM1}</td>
                 <% 
                  } else {
                 %>
                 <td  align="center">&nbsp;${REMDR_RSK_GD_C_NM1}</td>
                 <%
                   }
                 %>
                 
                <td align="right">&nbsp;${RSK_VALT_PNT2}</td>
                <td align="right">&nbsp;${TONGJE_VALT_PNT2}</td>
                <td align="right">&nbsp;${REMDR_RSK_PNT2}</td>
                <% 
                   if( ("Green").equals(output22.getText("REMDR_RSK_GD_C_NM2"))) {
                %>
                <td style="background-color:#00FF00" align="center">&nbsp;${REMDR_RSK_GD_C_NM2}</td>
                <% 
                   } else if( ("Yellow").equals(output22.getText("REMDR_RSK_GD_C_NM2"))) {
                %>
                <td style="background-color:yellow" align="center">&nbsp;${REMDR_RSK_GD_C_NM2}</td>
                <% 
                    } else if( ("Red").equals(output22.getText("REMDR_RSK_GD_C_NM2"))) {
                 %>
                 <td style="background-color:red" align="center">&nbsp;${REMDR_RSK_GD_C_NM2}</td>
                 <% 
                    }  else {
                 %>
                 <td  align="center">&nbsp;${REMDR_RSK_GD_C_NM2}</td>
                 <%
                    }
                 %>
                 
                <% 
                   if( ("Green").equals(output23.getText("REMDR_RSK_GD_C_NM3"))) {
                %>
                <td style="background-color:green" align="center">&nbsp;${REMDR_RSK_GD_C_NM3}</td>
                <% 
                   } else if( ("Yellow").equals(output23.getText("REMDR_RSK_GD_C_NM3"))) {
                %>
                <td style="background-color:yellow" align="center">&nbsp;${REMDR_RSK_GD_C_NM3}</td>
                <% 
                  }  else if(("Red").equals(output23.getText("REMDR_RSK_GD_C_NM3"))) {
                 %>
                 <td style="background-color:red" align="center">&nbsp;${REMDR_RSK_GD_C_NM3}</td>
                <% 
                  } else {
                 %>
                 <td  align="center">&nbsp;${REMDR_RSK_GD_C_NM3}</td>
                 <%
                   }
                 %>
                 
                <% 
                   if( ("Green").equals(output21.getText("REMDR_RSK_GD_C_NM1"))) {
                %>
                <td style="background-color:#00FF00" align="center">&nbsp;${REMDR_RSK_GD_C_NM1}</td>
                <% 
                   } else if( ("Yellow").equals(output21.getText("REMDR_RSK_GD_C_NM1"))) {
                %>
                <td style="background-color:yellow" align="center">&nbsp;${REMDR_RSK_GD_C_NM1}</td>
                 <% 
                   } else if(("Red").equals(output21.getText("REMDR_RSK_GD_C_NM1"))) {
                %>
                <td style="background-color:red" align="center">&nbsp;${REMDR_RSK_GD_C_NM1}</td>
                <% 
                  } else {
                 %>
                 <td  align="center">&nbsp;${REMDR_RSK_GD_C_NM1}</td>
                 <%
                   }
                 %>
                 
                <% 
                   if(("Green").equals(output22.getText("REMDR_RSK_GD_C_NM2"))) {
                %>
                <td style="background-color:green" align="center">&nbsp;${REMDR_RSK_GD_C_NM2}</td>
                <% 
                   } else if(("Yellow").equals(output22.getText("REMDR_RSK_GD_C_NM2"))) {
                %>
                <td style="background-color:yellow" align="center">&nbsp;${REMDR_RSK_GD_C_NM2}</td>
                <% 
                   } else if(("Red").equals(output22.getText("REMDR_RSK_GD_C_NM2"))) {
                %>
                <td style="background-color:red" align="center">&nbsp;${REMDR_RSK_GD_C_NM2}</td>
                <% 
                  } else {
                 %>
                 <td align="center">&nbsp;${REMDR_RSK_GD_C_NM2}</td>
                 <%
                   }
                 %>
            </tr>
        </table>
    </div>


    <div class="table-title" style="margin-top:8px;" id="MLTF_TITLE_DIV">
     	${msgel.getMsg('RBA_50_70_02_02_035','Top5 ML')}/${msgel.getMsg('RBA_50_70_02_02_036','TF Risk Factor')}
    </div>
  
    <div class="table-box4" id="MLTF_DIV">
	  <table class="basic-table">
	  <tr>
	    <td rowspan="6" style="background-color: #eff1f5;width:5.75%;" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_035','Top5 ML')}/${msgel.getMsg('RBA_50_70_02_02_036','TF Risk Factor')}</b><br><b>${msgel.getMsg('RBA_50_70_02_02_037','모니터링')}</b></td>
	    <td style="background-color: #eff1f5;width:5.75%;" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_026','지표')}</b></td>
	    <td style="background-color: #eff1f5;width:15.25%;" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_035','Top5 ML')}/</b><b>${msgel.getMsg('RBA_50_70_02_02_036','TF Risk Factor')}</b>
	    <td style="background-color: #eff1f5;width:6%;" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_027','평가점수')}</b></td> 
	    <td style="background-color: #eff1f5;" rowspan='6' align="center"><b>${msgel.getMsg('RBA_50_70_02_02_029','검토내용')}</b></td>
	    <td style="background-color: #eff1f5;" align="center"><b>부서 및 업무 특성에 따라 ML/TF Risk Factor가 높이 노출된 상위 5개의 위험요소를 검토</b></td>
	  </tr>
	  <tr style="100%">
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT",0));%></td>
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT_NM",0));%></td>
	    <td align="right">&nbsp;<% out.println(output3.getText("RSK_VALT_PNT",0));%></td> 
	    <td rowspan="5"><textarea id="IMPRV_STRG_CTNT" class="textarea-box" rows="10" maxlength="1000" style="vertical-align:middle;" >${IMPRV_STRG_CTNT}</textarea></td>
	  </tr>
	  
	  <tr style="100%">
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT",1));%></td>
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT_NM",1));%></td>
	    <td align="right">&nbsp;<% out.println(output3.getText("RSK_VALT_PNT",1));%></td> 
	   </tr>  
	   <tr style="100%"> 
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT",2));%></td>
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT_NM",2));%></td>
	    <td align="right">&nbsp;<% out.println(output3.getText("RSK_VALT_PNT",2));%></td> 
	   </tr>  
	   <tr style="100%">  
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT",3));%></td>
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT_NM",3));%></td>
	    <td align="right">&nbsp;<% out.println(output3.getText("RSK_VALT_PNT",3));%></td> 
	   </tr>  
	   <tr style="100%"> 
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT",4));%></td>
	    <td align="center">&nbsp;<% out.println(output3.getText("RSK_INDCT_NM",4));%></td>
	    <td align="right">&nbsp;<% out.println(output3.getText("RSK_VALT_PNT",4));%></td> 
	   </tr> 
	</table>
    </div>
    
    <div class="table-title" id="TJ_TITLE_DIV" style="margin-top:8px;">
      ${msgel.getMsg('RBA_50_70_02_02_040','Top5 내부통제 Factor')}
    </div>  
    
    <div class="table-box4" id="TJ_DIV_DETAIL">
        <table class="basic-table">
    
    
<%-- 		    <tr style="width:100%">
		                <th class="title" rowspan="3">${msgel.getMsg('RBA_50_70_02_02_013','RBA<br>위험평가<br>결과')}</th>
		                <th class="title" colspan="4" align="center">${O_YYMM_TITLE}</th>
		                <th class="title" colspan="4" align="center">${C_YYMM_TITLE}</th>
		                <th class="title" colspan="3" align="center">${msgel.getMsg('RBA_50_70_02_02_014','잔여등급위험등급 추세')}</th>
		            </tr>
		            <tr style="width:100%">
		                <td style="background-color: #F3F6FC;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_015','총위험점수')}</b></td> 
		                <td style="background-color: #F3F6FC;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_017','통제위험점수')}</b></td> 
		                <td style="background-color: #F3F6FC;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_044','잔여위험점수')}</b></td> 
		                <td style="background-color: #F3F6FC;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_019','잔여위험등급')}</b></td>
		                <td style="background-color: #F3F6FC;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_020','총위험점수')}</b></td> 
		                <td style="background-color: #F3F6FC;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_022','통제위험점수')}</b></td> 
		                <td style="background-color: #F3F6FC;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_044','잔여위험점수')}</b></td> 
		                <td style="background-color: #F3F6FC;" width="" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_019','잔여위험등급')}</b></td> 
		                <td style="background-color: #F3F6FC;" align="center">&nbsp;<b>${N_YYMM_TITLE}</b></td>
		                <td style="background-color: #F3F6FC;" align="center">&nbsp;<b>${O_YYMM_TITLE}</b></td>
		                <td style="background-color: #F3F6FC;" align="center">&nbsp;<b>${C_YYMM_TITLE}</b></td>
		            </tr>
		     --%>
 
    
            <tr style="width:100%">
                <th class="title" rowspan="7" style="text-align: center; width:160px;">${msgel.getMsg('RBA_50_70_02_02_045','RBA<br>통제평가<br>결과')}</th>
                <th class="title" colspan="2" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_203','내부통제점검항목')}</th>
                <th class="title" colspan="2">&nbsp;${O_YYMM_TITLE}</th>
                <th class="title" colspan="2">&nbsp;${C_YYMM_TITLE}</th>
                <th class="title" colspan="3" style="text-align: center;">${msgel.getMsg('RBA_50_70_02_02_204','통제점수등급 추세')}</th>
            </tr>
            <tr style="width:100%">
                <td style="background-color: #eff1f5;" width="60vw" align="center"><b>${msgel.getMsg('RBA_50_03_03_005','코드')}</b></td> 
                <td style="background-color: #eff1f5;" width="220vw" align="center"><b>${msgel.getMsg('RBA_50_04_01_004','내부통제 평가지표')}</b></td> 
                <td style="background-color: #eff1f5;" width="80vw" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_022','통제위험점수')}</b></td> 
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_05_04_010','등급')}</b></td>
                <td style="background-color: #eff1f5;" width="80vw" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_022','통제위험점수')}</b></td> 
                <td style="background-color: #eff1f5;" width="" align="center"><b>${msgel.getMsg('RBA_50_05_04_010','등급')}</b></td>  
                <td style="background-color: #eff1f5;" width="80vw" align="center">&nbsp;<b>${N_YYMM_TITLE}</b></td>
                <td style="background-color: #eff1f5;" width="80vw" align="center">&nbsp;<b>${O_YYMM_TITLE}</b></td>
                <td style="background-color: #eff1f5;" width="80vw" align="center">&nbsp;<b>${C_YYMM_TITLE}</b></td>
            </tr> 
            
            <tr style="width:100%">
			    <td align="center">&nbsp;<% out.println(output33.getText("TONGJE_NO",0));%></td>
			    <td align="left">&nbsp;<% out.println(output33.getText("TONGJE_ACT_TITE",0));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT2",0));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",0));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT1",0));%></td> 
			    <td align="center">&nbsp;<% out.println(output33.getText("LVL1",0));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL3",0));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",0));%></td>
			    <td align="center">&nbsp;<% out.println(output33.getText("LVL1",0));%></td>
			</tr>
			
			<tr style="width:100%">
			    <td align="center">&nbsp;<% out.println(output33.getText("TONGJE_NO",1));%></td>
			    <td align="left">&nbsp;<% out.println(output33.getText("TONGJE_ACT_TITE",1));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT2",1));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",1));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT1",1));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL1",1));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL3",1));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",1));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL1",1));%></td>
			</tr>
			
			<tr style="width:100%">
			    <td align="center">&nbsp;<% out.println(output33.getText("TONGJE_NO",2));%></td>
			    <td align="left">&nbsp;<% out.println(output33.getText("TONGJE_ACT_TITE",2));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT2",2));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",2));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT1",2));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL1",2));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL3",2));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",2));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL1",2));%></td>
			</tr>
			
			<tr style="width:100%">
			    <td align="center">&nbsp;<% out.println(output33.getText("TONGJE_NO",3));%></td>
			    <td align="left">&nbsp;<% out.println(output33.getText("TONGJE_ACT_TITE",3));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT2",3));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",3));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT1",3));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL1",3));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL3",3));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",3));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL1",3));%></td>
			</tr>
			
			<tr style="width:100%">
			    <td align="center">&nbsp;<% out.println(output33.getText("TONGJE_NO",4));%></td>
			    <td align="left">&nbsp;<% out.println(output33.getText("TONGJE_ACT_TITE",4));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT2",4));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",4));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LST_TONGJE_VALT_PNT1",4));%></td> 
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL1",4));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL3",4));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL2",4));%></td>
			    <td align="right">&nbsp;<% out.println(output33.getText("LVL1",4));%></td>
			</tr>
		  
        </table>
    </div>
  
    <div class="table-box4" id="TJ_DIV">
      <table class="basic-table">
   	  <tr style="width:100%">
	    <td style="background-color: #eff1f5; width:160px;" rowspan='4' align="center"><b>${msgel.getMsg('RBA_50_70_02_02_029','검토내용')}</b></td>
	    <td style="background-color: #eff1f5;" align="center" ><b>"${msgel.getMsg('RBA_50_70_02_02_202','부서 및 업무 특성에 따라 통제 Factor가 높이 노출된 상위 5개의 통제요소를 검토')}"</b></td>
	  </tr>
	  <tr style="width:100%">
	    <td rowspan="3"><textarea id="IMPRV_STRG_CTNT2" class="textarea-box" style="height:100px; vertical-align:middle;">${IMPRV_STRG_CTNT}</textarea></td>
	  </tr>
	  </table>
	</div>

  
   <%--  <div class="table-box4" id="TJ_DIV">
      
	  
	  <table class="hover">
	  <tr>
	    <td style="background-color: #F3F6FC;width:10.5%;" rowspan="6"><b>${msgel.getMsg('RBA_50_70_02_02_040','Top5 내부통제 Factor')}<br><b>${msgel.getMsg('RBA_50_70_02_02_037','모니터링')}</b></td>
	    <td style="background-color: #F3F6FC;width:8%;" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_026','CODE')}</b></td>
	    <td style="background-color: #F3F6FC;width:13%;" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_042','RI-ID')}</b>
	    <td style="background-color: #F3F6FC;width:6%;" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_043','지표값')}</b></td>
	    <td style="background-color: #F3F6FC;width:6%;" align="center"><b>${msgel.getMsg('RBA_50_70_02_02_027','평가점수')}</b></td>
	    <td style="background-color: #F3F6FC;" rowspan='6' align="center"><b>${msgel.getMsg('RBA_50_70_02_02_029','검토내용')}</b></td>
	    <td style="background-color: #F3F6FC;" align="center"><b>부서 및 업무 특성에 따라 통제 Factor가 높이 노출된 상위 5개의 통제요소를 검토</b></td>
	  </tr>
	  <tr>
	    <td align="center">&nbsp;<% out.println(output32.getText("PROC_SMDV_C",0));%></td>
	    <td align="center">&nbsp;<% out.println(output32.getText("PROC_SMDV_NM",0));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("JIPYO_V",0));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("TONGJE_VALT_PNT",0));%></td>
	    <td rowspan="5"><textarea id="IMPRV_STRG_CTNT2" style="height:100px;">${IMPRV_STRG_CTNT}</textarea></td>
	  </tr>
	  
	  <tr>
	    <td align="center">&nbsp;<% out.println(output32.getText("TONGJE_SMDV_C",1));%></td>
	    <td align="center">&nbsp;<% out.println(output32.getText("TONGJE_SMDV_NM",1));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("JIPYO_V",1));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("TONGJE_VALT_PNT",1));%></td>
	   </tr>  
	   <tr> 
	    <td align="center">&nbsp;<% out.println(output32.getText("TONGJE_SMDV_C",2));%></td>
	    <td align="center">&nbsp;<% out.println(output32.getText("TONGJE_SMDV_NM",2));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("JIPYO_V",2));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("TONGJE_VALT_PNT",2));%></td>
	   </tr>  
	   <tr>  
	    <td align="center">&nbsp;<% out.println(output32.getText("TONGJE_SMDV_C",3));%></td>
	    <td align="center">&nbsp;<% out.println(output32.getText("TONGJE_SMDV_NM",3));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("JIPYO_V",3));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("TONGJE_VALT_PNT",3));%></td>
	   </tr>  
	   <tr> 
	    <td align="center">&nbsp;<% out.println(output32.getText("TONGJE_SMDV_C",4));%></td>
	    <td align="center">&nbsp;<% out.println(output32.getText("TONGJE_SMDV_NM",4));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("JIPYO_V",4));%></td>
	    <td align="right">&nbsp;<% out.println(output32.getText("TONGJE_VALT_PNT",4));%></td>
	   </tr>
	</table>
    </div> --%>
  
     <div class="table-title" style="margin-top:8px; margin-bottom: 8px;">
       ${msgel.getMsg('RBA_50_70_02_02_030','개선방안')}
 		 <input type="button" value="${msgel.getMsg('RBA_50_70_02_02_200','개선방안선택')}" class="btn-36" style="margin-left: 8px; margin-right: 8px;" onclick="setContDisplay('S');PopImpPool();">
 		 <input type="button" value="${msgel.getMsg('RBA_50_70_02_02_201','직접입력')}" class="btn-36" onclick="setContDisplay('D');">
 		 
    </div>
    

    <div id="selCont" class="table-box4" >
        <table class="basic-table">
            <tr style="width:100%">
                <td style="background-color:#eff1f5; width: 100px; text-align: center;" rowspan="2"><b>${msgel.getMsg('RBA_50_70_02_02_030','개선방안')}</b></td>
                <td style="background-color:#eff1f5; width: 100px; "><b>${msgel.getMsg('RBA_50_70_02_02_031','단계')}</b></td>
                <td ><input type="text" id="IMPRV_CNFRME" readonly="readonly" class="cond-input-text" value="${IMPRV_CNFRME}" size="15"></td>
                <td style="background-color:#eff1f5; width: 100px;" ><b>${msgel.getMsg('RBA_50_70_02_02_032','내용')}</b></td>
                <td style="height: 100"><textarea id="MAIN_EXEC_CTNT" class="textarea-box" readonly="readonly" style="height:100; vertical-align: middle;" >${MAIN_EXEC_CTNT}</textarea></td>
            </tr>
            <tr style="width:100%">
                <td style="background-color:#eff1f5;"><b>${msgel.getMsg('RBA_50_70_02_02_033','수행계획')}</b></td>
                <td colspan='3' style="height: 100"><textarea id="IMPRV_RSLT_CTNT" class="textarea-box" style="height: 100; vertical-align: middle;">${IMPRV_RSLT_CTNT}</textarea></td>
            </tr>
        </table>
    </div>
     
    <div class="panel-footer" style="display:none;">
	  
        <div id="GTDataGrid1_Area" style="display:none;"></div>
    </div>
</div>
<div class="button-area" style="display: flex;justify-content: flex-end; margin-top: 8px;">  
      ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"U", function:"doSave", cssClass:"btn-36"}')}
      ${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"reqApprBtn", defaultValue:"승인요청", mode:"U", function:"openGyljPopUp0", cssClass:"btn-36"}')}
      ${btnel.getButton(outputAuth, '{btnID:"btn_05", cdID:"apprBtn", defaultValue:"승인", mode:"U", function:"openGyljPopUp2", cssClass:"btn-36"}')}
   	  ${btnel.getButton(outputAuth, '{btnID:"btn_06", cdID:"denyBtn", defaultValue:"반려", mode:"U", function:"openGyljPopUp22", cssClass:"btn-36"}')}
      ${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}
</div>	 
</form>   
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />      
 
