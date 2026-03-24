<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
- File Name  : RBA_50_04_03_04.jsp
- Author     : 권얼
- Comment    : 통제요소 수행 입력팝업
- Version    : 1.0
- history    : 1.0 20250707
--%>
<%@ include file="/WEB-INF/Kernel/express/header.jsp" %>
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_top.jsp" flush="true"/>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_04.RBA_50_04_03.RBA_50_04_03_02"    %>  
<%
	String ROLE_IDS = sessionAML.getsAML_ROLE_ID();
	request.setAttribute("ROLE_IDS",ROLE_IDS);
%>
<%
	String uploadFile = PropertyService.getInstance().getProperty("aml.config","upload.file");
	request.setAttribute("uploadFile",uploadFile);
	
	String BOARD_CONTENT = "";
    String BAS_YYMM     = Util.nvl(request.getParameter("BAS_YYMM")			, "");
	String CNTL_CATG1_C = Util.nvl(request.getParameter("CNTL_CATG1_C")			, "");
	String CNTL_CATG2_C = Util.nvl(request.getParameter("CNTL_CATG2_C")			, "");
	String CNTL_ELMN_C = Util.nvl(request.getParameter("CNTL_ELMN_C")			, "");
	String CNTL_CATG1_C_NM = Util.nvl(request.getParameter("CNTL_CATG1_C_NM")			, "");
	String CNTL_CATG2_C_NM = Util.nvl(request.getParameter("CNTL_CATG2_C_NM")			, "");
	String CNTL_ELMN_C_NM = Util.nvl(request.getParameter("CNTL_ELMN_C_NM")			, "");
 	String USE_YN1 = Util.nvl(request.getParameter("USE_YN1")			, "");
 	String CNTL_ELMN_CTNT = Util.nvl(request.getParameter("CNTL_ELMN_CTNT")			, "");
	String CNTL_RSK_CTNT = Util.nvl(request.getParameter("CNTL_RSK_CTNT")			, "");
	String EVAL_MTHD_CTNT = Util.nvl(request.getParameter("EVAL_MTHD_CTNT")			, "");
	String EVAL_TYPE_CD = Util.nvl(request.getParameter("EVAL_TYPE_CD")			, "");
	String EVAL_TYPE_CD1_NM = Util.nvl(request.getParameter("EVAL_TYPE_CD1_NM")			, "");
	String PROOF_DOC_LIST = Util.nvl(request.getParameter("PROOF_DOC_LIST")			, "");
	String BRNO_NM = Util.nvl(request.getParameter("BRNO_NM")			, "");
	String BRNO = Util.nvl(request.getParameter("BRNO")			, "");
	String CNTNT = Util.nvl(request.getParameter("CNTNT")			, "");
	String ATTCH_FILE_NO	="";
	
	request.setAttribute("BAS_YYMM", BAS_YYMM);
	request.setAttribute("CNTL_CATG1_C", CNTL_CATG1_C);
	request.setAttribute("CNTL_CATG2_C", CNTL_CATG2_C);
	request.setAttribute("CNTL_ELMN_C", CNTL_ELMN_C);
	request.setAttribute("CNTL_CATG1_C_NM", CNTL_CATG1_C_NM);
	request.setAttribute("CNTL_CATG2_C_NM", CNTL_CATG2_C_NM);
	request.setAttribute("CNTL_ELMN_C_NM", CNTL_ELMN_C_NM);
 	request.setAttribute("USE_YN1", USE_YN1);
  	request.setAttribute("CNTL_ELMN_CTNT1", CNTL_ELMN_CTNT);
	request.setAttribute("CNTL_RSK_CTNT1", CNTL_RSK_CTNT);
	request.setAttribute("EVAL_MTHD_CTNT1", EVAL_MTHD_CTNT);
	request.setAttribute("EVAL_TYPE_CD1", EVAL_TYPE_CD);
	request.setAttribute("EVAL_TYPE_CD1_NM", EVAL_TYPE_CD1_NM);
	request.setAttribute("PROOF_DOC_LIST1", PROOF_DOC_LIST);
	request.setAttribute("DEP_LIST", BRNO_NM);
	request.setAttribute("BRNO", BRNO);
	request.setAttribute("CNTNT", CNTNT);
	request.setAttribute("ATTCH_FILE_NO",ATTCH_FILE_NO);
	
	DataObj in = new DataObj();											 
	 in.put("BRNO", BRNO);	
	 in.put("CNTL_ELMN_C", CNTL_ELMN_C);	
	DataObj output = RBA_50_04_03_02.getInstance().getSearchFile(in); 
	System.out.println("##########output##########" + output);
	Log.logAML(Log.DEBUG, "files...................." + output.getCount("FILE_SER"));
			
	if(output.getCount("FILE_SER") > 0) {
		Log.logAML(Log.DEBUG, "files...................." + output.getRowsToMap());
		request.setAttribute("filepath",Constants._UPLOAD_RBA_DIR);
		request.setAttribute("FILES",output.getRowsToMap());
	}
	
	String ROLE_ID2            = Util.nvl(request.getParameter("ROLE_ID"));
	String GYLJ_ID             = Util.nvl(request.getParameter("GYLJ_ID"));        // 결재ID
	String TABLE_NM            = Util.nvl(request.getParameter("TABLE_NM"));        //
	String GYLJ_ROLE_ID        = Util.nvl(request.getParameter("GYLJ_ROLE_ID"));
	String GYLJ_S_C            = Util.nvl(request.getParameter("GYLJ_S_C"));
	String NEXT_GYLJ_ROLE_ID   = Util.nvl(request.getParameter("NEXT_GYLJ_ROLE_ID"));
	String FIRST_GYLJ          = Util.nvl(request.getParameter("FIRST_GYLJ"));
	String END_GYLJ            = Util.nvl(request.getParameter("END_GYLJ"));
	
	request.setAttribute("ROLE_ID", ROLE_ID2);
	request.setAttribute("GYLJ_ID", GYLJ_ID);
	request.setAttribute("TABLE_NM", TABLE_NM);
	request.setAttribute("GYLJ_ROLE_ID", GYLJ_ROLE_ID);
	request.setAttribute("GYLJ_S_C", GYLJ_S_C);
	request.setAttribute("NEXT_GYLJ_ROLE_ID", NEXT_GYLJ_ROLE_ID);
	request.setAttribute("FIRST_GYLJ", FIRST_GYLJ);
	request.setAttribute("END_GYLJ", END_GYLJ);

%>

<script language="JavaScript">
	/**
	 * Initial function
	 */
// 	var GridObj1 	= new GTActionRun();
	var classID  = "RBA_50_04_03_02";
	var pageID   = "RBA_50_04_03_04";
    var _sno        = 0;
    
    var ROLE_IDS     = "${ROLE_IDS}";
    var GYLJ_S_C     = "${GYLJ_S_C}";
    var fileSeq ="";
    
    $(document).ready(function() {
    	form1.BAS_YYMM.value     = '<%= BAS_YYMM %>';
    	form1.CNTL_CATG1_C.value = '<%= CNTL_CATG1_C %>';
        form1.CNTL_CATG2_C.value = '<%= CNTL_CATG2_C %>';
        form1.CNTL_ELMN_C.value = '<%= CNTL_ELMN_C %>';
        form1.CNTL_CATG1_C_NM.value = '<%= CNTL_CATG1_C_NM %>';
        form1.CNTL_CATG2_C_NM.value = '<%= CNTL_CATG2_C_NM %>';
        form1.CNTL_ELMN_C_NM.value = '<%= CNTL_ELMN_C_NM %>';
        
        
        form1.ROLE_ID.value = '<%= ROLE_ID2 %>';
        form1.GYLJ_ID.value = '<%= GYLJ_ID %>';
        form1.TABLE_NM.value = '<%= TABLE_NM %>';
        form1.GYLJ_ROLE_ID.value = '<%= GYLJ_ROLE_ID %>';
        form1.GYLJ_S_C.value = '<%= GYLJ_S_C %>';
        form1.NEXT_GYLJ_ROLE_ID.value = '<%= NEXT_GYLJ_ROLE_ID %>';
        
        form1.FIRST_GYLJ.value = '<%= FIRST_GYLJ %>';
        form1.END_GYLJ.value = '<%= END_GYLJ %>';
        
        if( ("${BRNO}" != "20500" && "${ROLE_IDS}" == "4")  || "${ROLE_IDS}" == "104"  || "${ROLE_IDS}" == "6" ) {
        	$("#btn_07").hide();
	    } else if( "${ROLE_IDS}" == "105" ) {
	    	$("#btn_03").hide();
	     	$("#btn_04").hide();
	    }
        
        if ( "${BRNO}" == "20500" && "${ROLE_IDS}" == "4" ) {
	    	$("#btn_04").hide();
	    }

        setupFileUploader();

        doSearch();

    });




 	function doSearch() {

		var methodID   	  = "doSearch";
		var obj			  = new Object();
		obj.pageID		  = pageID;
	    obj.classID 	  = classID;
		obj.BAS_YYMM	  = "${BAS_YYMM}";
		obj.CNTL_ELMN_C   = "${CNTL_ELMN_C}";
		obj.BRNO          = "${BRNO}";

		sendService(classID, methodID, obj, doSearch_end, doSearch_end);
 	}


 	function checkNum(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 190 || keyID == 110 || keyID == 13 || keyID == 9 || keyID == 189 || keyID == 109 ) {
			return;
		} else {
			return false;
		}
	}

 	function deleteRows() {
        var tbl = document.getElementById('jipyoTable');
        var lastRow = tbl.rows.length - 1;
        for (i = lastRow; 0 < i; i--) {
            tbl.deleteRow(i);
        }
    }

    function doSearch_end(dataSource) {
		deleteRows();
    	//GridObj1.refresh();
	    //GridObj1.option("dataSource", dataSource);
    	var cnt = dataSource.length;
    	var confirmCnt = 0;
    	var totalscore = 0;
    	var val_1 = 0;
    	var val_2 = 0;

     	$("#GRID_CNT").text('(' + cnt + ' 항목)');
    /*	$("#GRID_CNT2").text(cnt);
    	$(":checkbox").prop("checked", false); */

    	//alert( "form1.EVAL_TYPE_CD1.value : " + "${EVAL_TYPE_CD1}"  );


    	for( i=0; i < cnt ; i++ ) {
    		var str = '';
    		var cellData =  dataSource[i];

    		//실적입력   숫자 input - only number
   			cellData.IN_V = cellData.IN_V == "" ? "0" : cellData.IN_V;
   			str = "<input type='number' id='" + cellData.CNTL_ITEM_DE_C + "'style='text-align:center;width:100%' value ='"+cellData.CNTL_VALUE+"'/></td>";

   			if( i == 0 ) {
   				val_1 = cellData.CNTL_VALUE
   			} else if( i == 1 ) {
   				val_2 = cellData.CNTL_VALUE
   			}

   			$('#jipyoTable > tbody:last').append('<tr><td style="text-align:center;border-right: 1px solid #CCCCCC;width:10%;" id="CNTL_ITEM_DE_C_'+i+'">'+cellData.CNTL_ITEM_DE_C+'</td>'  //통제평가세부코드
   	   				+'<td style="text-align:left;border-right: 1px solid #CCCCCC;width:60%;" id="CNTL_ITEM_DE_CTNT_'+i+'">'+cellData.CNTL_ITEM_DE_CTNT+'</td>'			//통제평가세부내용
   	   				+'<td style="text-align:center;border-right: 1px solid #CCCCCC;width:20%;">'														//입력값
   	                + str+'</tr>');

    	}

    	if(cnt > 0) {

    		if( val_1 == 0 || val_2 == 0 ) {
    			totalscore = 0;
    		} else {
    			var score = val_2 * 100 / val_1;
        		totalscore = score.toFixed(2);
    		}

    		if ( "${ROLE_IDS}" == '7' || "${ROLE_IDS}" == '104' || "${ROLE_IDS}" == '4' ) {
    			$('#jipyoTable > tbody:last').append( '<tr><td colspan="2" style="text-align:center;border-right: 1px solid #CCCCCC;width:10%;">${msgel.getMsg("RBA_50_04_03_01_012","통제효과성")}</td>'
            	        + '<td colspan="1" style="text-align:center;border-right: 1px solid #CCCCCC;width:10%;">' + totalscore + ' %</td>'
                        + '</tr>');
    		}


    	}




    	/* $("#ITEM_S_C_CNT").text(confirmCnt); */
    }




    function addComma(num){
    	var regexp = /\B(?=(\d{3})+(?!\d))/g;
    	return num.toString().replace(regexp , ',')
    }

    function checkVal() {
		if (form1.JIPYO_FIX_YN.value == 0) {
	    	showAlert('${msgel.getMsg("RBA_90_01_03_01_220","확정등록되지 않은 지표데이터는 저장할 수 없습니다.")}', 'WARN');
	    	return false;
	    } else if (form1.GYLJ_S_C.value == '12' ||form1.GYLJ_S_C.value == '3' ) {	//지표결재상태코드 ('A014', 0:미결재, 12:승인요청, 22:반려, 3:완료)
			showAlert('${msgel.getMsg("RBA_90_01_03_01_221","결재가 진행중이거나 완료된 지표데이터는 수정할 수 없습니다.")}', 'WARN');
			return false;
		} else {
			return true;
		}
	}



    function calcount() {

    	//alert( "tbl.CHECK_YN_" + " : " + $("#CHECK_YN_1").val() );

/* 		var tbl = document.getElementById('jipyoTable');
        var lastRow = tbl.rows.length - 1;
        for (i = lastRow; 0 < i; i--) {
            //tbl.deleteRow(i);
            alert( "tbl.CHECK_YN_" + i + " : " + $( "#"+CHECK_YN_0).val() );
            break;
        } */


	}


    function doSave() {

		var GYLJ_S_C 		= form1.GYLJ_S_C.value;
    	
    	if( GYLJ_S_C != "0" && GYLJ_S_C != "5" && GYLJ_S_C != "22" ) {
			alert( "수정 할수 없는 상태 입니다");
			return;
		}
    	
    	// 첨부파일
    	var fileCount; 
        if(isNotEmpty(form1.elements["storedFileNms"]))
         {
             fileCount = form1.elements["storedFileNms"].length;
             if(fileCount > 5){
                 showAlert("${msgel.getMsg('AML_90_01_02_02_012','파일을 5개 이상 첨부할 수 없습니다.')}",'WARN');
                 return false;
             }   
         }
    	
		 showConfirm('<fmt:message key="AML_10_01_01_01_004" initVal="저장하시겠습니까?"/>', '${msgel.getMsg("AML_00_00_01_01_025","저장")}', doSave_Action);
   }

   function doSave_Action(){
	    var tabObj = document.getElementById("jipyoTable");
	   	var maxRow = tabObj.rows.length;
 	   	var rowArr; rowArr = new Array();
	   	var arr2; arr2=[];
	   	var rowLength=0;
	   	var num; num = 0;
	   	var dataStr ="";

	   	var CNTL_ITEM_DE_C;
	   	var CHECK_YN;

	   	for(var i=1; i<maxRow-1; i++) {
	   		//alert( "call : " + tabObj.rows[1].cells[0].innerText + " : " + tabObj.rows[1].cells[1].innerText + " : "+ tabObj.rows[1].cells[2].innerText + " : ");

	   		CNTL_ITEM_DE_C    = tabObj.rows[i].cells[0].innerText;
	   		CHECK_YN   = $("#"+CNTL_ITEM_DE_C).val();

	   		//alert( "call : " + i + " : " + CHECK_YN );

	   		dataStr += CNTL_ITEM_DE_C+"#"+CHECK_YN;
	   		dataStr += ",";

	   	}
	   	dataStr = dataStr.substring(0,dataStr.length-1);


	   	//alert( "str : " + dataStr );



    	//overlay.show(true, true);


 		var methodID    = "doSave";
		var obj = new Object();
		obj.pageID            = "RBA_50_04_03_02";					//"RBA_50_04_03_02";
		obj.BAS_YYMM 	      = "${BAS_YYMM}";		//평가년월
		obj.CNTL_CATG1_C      = "${CNTL_CATG1_C}";
		obj.CNTL_CATG2_C      = "${CNTL_CATG2_C}";
		obj.CNTL_ELMN_C       = "${CNTL_ELMN_C}";
		obj.BRNO              = "${BRNO}";
		obj.EVAL_TYPE_CD1     = "${EVAL_TYPE_CD1}";
		obj.dataArr 	= dataStr;
		if ( "104" == "${ROLE_IDS}" || "7" == "${ROLE_IDS}" ) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자
			obj.CNTNT             = form1.CNTNT.value;
		}
		
		sendService(classID, methodID, obj, doSave_end, doSave_fail);
        
		var option = {
				url : '${ctx}/rba/50_04_03_02_doSaveFile.do',
				dataType : 'json',				
				success : function(data){					
					if(data.status == 'success')
					{
						doSave_end2();
					}	
					else
					{
						doSave_fail2();
					}	
				}				 
		};
		$('#form1').ajaxSubmit(option);
		return false;
		
		
   }


   function doSave_end() {
       doSearch();

   }
	function doSave_fail(){
	   console.log("doSave_fail");
       doSearch();
	}

	function doSave_end2() {
	   console.log("doSave_end2");
    }
	
	function doSave_fail2(){
	   console.log("doSave_fail2");
	}
	
	function doClose() {
		self.close();
        opener.doSearch();
	}


	function setupFileUploader(){
        var allowedFileExtensions = "${uploadFile}";
        fileUploader = gtFileUploader("file-uploader",allowedFileExtensions,doSubmit_end,true,false);
    }

	function doSubmit_end(fileData){
		var addLine;
		var divId = fileData.storedFileNm.substring(0,fileData.storedFileNm.lastIndexOf("."));

    	if(fileData != undefined){
    		addLine	= "<div id='"+divId+"'>"
    				+"<i class='fa fa-floppy-o' style='font-size: 14px;margin-left: 3px;' aria-hidden='true'></i>"
    				+fileData.origFileNm
    				+"&nbsp;&nbsp;&nbsp;"
    				+"<a onclick=\"tempFileDel('"+divId+"','/upload/attachTmp/','"+fileData.storedFileNm+"');\" >"
    				+"<input type='hidden' name='fileSizes' id='fileSizes' class='fileSize' value='"+fileData.fileSize+"' />"
    				+"<input type='hidden' name='origFileNms' id='origFileNms' class='origFileNm' value='"+fileData.origFileNm+"' />"
    				+"<input type='hidden' name='storedFileNms' id='storedFileNms' class='storedFileNm' value='"+fileData.storedFileNm+"' />"
    				+"<input type='hidden' name='filePaths' id='filePaths' class='filePath' value='"+fileData.filePath+"' />"
    				+"<div class='dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon' role='button' aria-hidden='true' aria-label='close'>"
    				+"	<div class='dx-button-content'>&nbsp;<i class='dx-icon dx-icon-close'></i></div>"
    				+"</div>"
    				+"</a>"
    				+"</div>";
    		$("#fileBox").append(addLine);
    	}
	 }
	 
	// 첨부파일 다운로드
	function downloadFile(f,o,e) {
     	$("[name=pageID]", "#fileFrm").val("RBA_50_04_03_02");
     	$("#downFileName").val(f);
     	$("#orgFileName").val(o); 	
     	$("#FILE_SER").val(e);
     	$("#downFilePath").val($("#filePaths").val()); 	
     	$("#fileFrm").attr("action" ,"${ctx}/common/fileDownload.do");
     	$("#fileFrm").submit();
    }
	 
	 
	//결재요청
	function doApproval(Flag) {

			var params = new Object();
	        var methodID 	= "doApproval";
			var classID  = "RBA_50_03_02_01";
			
			
			//결재상태 확인
			if(!CheckValue(Flag)){
				return;
			}
			
//			alert( "call doApproval :  " + "${ROLE_IDS}");
		   form1.pageID.value  = "RBA_50_04_03_05";
	       var win; win = window_popup_open(form1.pageID.value, 900, 680, '', 'yes');
	       form1.FLAG.value	= Flag;
	       form1.TABLE_NM.value	= "SRBA_V_CNTL_ELMN_M";
	       form1.BRNO.value	= "${BRNO}";
	       form1.LV3.value	= "${CNTL_ELMN_C}";
	       form1.target		= form1.pageID.value;
	       form1.action		= "<c:url value='/'/>0001.do";
	       form1.submit();
	       
		}
	    
		function doApproval_end() {
	    	$("#btn_03").hide();
	    	$("#btn_04").hide();
	    	$("#btn_07").hide();
	    	
	    	//doSearch();

	    	opener.doSearch();
	    }
	    
	    function doApproval_fail() {
	    }

		
		

		function CheckValue(FLAG){

			//alert( "call doApproval 1:  " + "${ROLE_IDS}");

			var ROLE_ID 		= form1.ROLE_ID.value;
			var GYLJ_ROLE_ID	= form1.GYLJ_ROLE_ID.value;
			var GYLJ_S_C 		= form1.GYLJ_S_C.value;
			var NEXT_GYLJ_ROLE_ID = form1.NEXT_GYLJ_ROLE_ID.value;
			var FIRST_GYLJ 		= form1.FIRST_GYLJ.value;
			var END_GYLJ 		= form1.END_GYLJ.value;
			var MSG = "";
			/* 
			4	자금세탁사기예방팀 담당자
         5	자금세탁사기예방팀 책임자
         6	RBA/AML 책임자
			105	RBA 담당자 
			
			0 미입력        
			5 저장
			13 미결재
			22 반려
			23 본점미결재
			32 책임자 미결재
			3  결재완료
			*/

			// 본부점 대상 통제활동
			if( "${BRNO}" == "20500" ) {
	
				if(  GYLJ_S_C == "0" || GYLJ_S_C == "5" || GYLJ_S_C == "22" ) {
					MSG = "[본점담당자 순서입니다]";
				} else if(  GYLJ_S_C == "12" ) {
					MSG = "[본점담당자 순서입니다]";
				} else if(  GYLJ_S_C == "22" ) {
					MSG = "[본점담당자 순서입니다]";
				} else if(  GYLJ_S_C == "23" ) {
					MSG = "[본점담당자 순서입니다]";
				} else if(  GYLJ_S_C == "32" ) {
					MSG = "[본점책임자 순서입니다]";
				}
				
				
				
				if( ROLE_ID == "4" ) {
					
					if( FLAG == "0" ) {

						// 결재요청
						if( GYLJ_S_C != "22" && GYLJ_S_C != "0" && GYLJ_S_C != "5" ) {
							alert( "결재요청 할수 없는 상태 입니다 " + MSG);
							return;
						}
						
					} else if( FLAG == "1" ) {
						
						alert( "반려 할수 없는 상태 입니다"+ MSG);
						return;
						
					} else if( FLAG == "2" ) {
						
						if( GYLJ_S_C != "22" && GYLJ_S_C != "23" && GYLJ_S_C != "0" && GYLJ_S_C != "5" ) { 
							alert( "결재 할수 없는 상태 입니다"+ MSG);
							return;
						}
					}
					

				}  else if( ROLE_ID == "104" ) {
					
					/* 
					4	자금세탁사기예방팀 담당자
	                5	자금세탁사기예방팀 책임자
					*/

					if( FLAG == "1" ) {
						
						if( GYLJ_S_C != "12" ) { 
							alert( "반려 할수 없는 상태 입니다"+ MSG);
							return;
						}
						
					} else if( FLAG == "2" ) {
						
						if( GYLJ_S_C != "12" ) { 
							alert( "결재 할수 없는 상태 입니다"+ MSG);
							return;
						}
						
					}


				} else if( ROLE_ID == "7" ) {
					
					/* 
					4	자금세탁사기예방팀 담당자
	                5	자금세탁사기예방팀 책임자
	                6	RBA/AML 책임자
					105	RBA 담당자 
					
					0 미입력        
					5 저장
					13 미결재
					22 반려
					23 본점미결재
					32 책임자 미결재
					3  결재완료
					*/

					if( FLAG == "0" ) {
						// 승인요청
						/* 
							0 미입력        
							5 저장
							13 미결재
							22 반려
							23 본점미결재
							32 책임자 미결재
							3  결재완료
						*/
						if( GYLJ_S_C == "0" || GYLJ_S_C == "5" || GYLJ_S_C == "22") {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "13" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "23" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "32" ) {
							form1.ROLE_ID.value = "104";
						}
						
						
					} else if( FLAG == "1" ) {
						//  반려
						if( GYLJ_S_C == "13" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "23" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "32" ) {
							form1.ROLE_ID.value = "104";
						}
						
					} else if( FLAG == "2" ) {
					    //  승인
						if( GYLJ_S_C == "13" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "23" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "32" ) {
							form1.ROLE_ID.value = "104";
						}
						
					}
					
					//alert( "FLAG, GYLJ_S_C, ROLE_ID : " + FLAG + " : " + GYLJ_S_C + " : " + form1.ROLE_ID.value );


				} 

			} else {

				if(  GYLJ_S_C == "0" || GYLJ_S_C == "5" || GYLJ_S_C == "22" ) {
					MSG = "[RBA담당자 순서입니다]";
				} else if(  GYLJ_S_C == "13" ) {
					MSG = "[RBA/AML 책임자 순서입니다]";
				} else if(  GYLJ_S_C == "22" ) {
					MSG = "[RBA/AML 책임자 순서입니다]";
				} else if(  GYLJ_S_C == "23" ) {
					MSG = "[본점담당자 순서입니다]";
				} else if(  GYLJ_S_C == "32" ) {
					MSG = "[본점책임자 순서입니다]";
				}
				
				
				
				if( ROLE_ID == "6" || ROLE_ID == "105" ) {
					
					/* 
					6	RBA/AML 책임자
					105	RBA 담당자 
					*/

					if( FLAG == "0" ) {

						if( GYLJ_S_C != "22" && GYLJ_S_C != "0" && GYLJ_S_C != "5" ) {
							alert( "결재요청 할수 없는 상태 입니다 " + MSG);
							return;
						}
						
					} else if( FLAG == "1" ) {
						
						if( GYLJ_S_C != "12" && GYLJ_S_C != "13") { 
							alert( "반려 할수 없는 상태 입니다"+ MSG);
							return;
						}
						
					} else if( FLAG == "2" ) {
						
						if( GYLJ_S_C != "12" && GYLJ_S_C != "13" ) { 
							alert( "결재 할수 없는 상태 입니다"+ MSG);
							return;
						}
					}
					

				} else if( ROLE_ID == "4" ) {
					
					/* 
					4	자금세탁사기예방팀 담당자
	                5	자금세탁사기예방팀 책임자
					*/
	                if( FLAG == "1" ) {
						
						if( GYLJ_S_C != "23" ) { 
							alert( "반려 할수 없는 상태 입니다"+ MSG);
							return;
						}
						
					} else if( FLAG == "2" ) {
						
						if( GYLJ_S_C != "23" ) { 
							alert( "결재 할수 없는 상태 입니다"+ MSG);
							return;
						}
						
					}


				} else if( ROLE_ID == "5" ) {
					
					/* 
					4	자금세탁사기예방팀 담당자
	                5	자금세탁사기예방팀 책임자
					*/

					if( FLAG == "1" ) {
						
						if( GYLJ_S_C != "32" ) { 
							alert( "반려 할수 없는 상태 입니다"+ MSG);
							return;
						}
						
					} else if( FLAG == "2" ) {
						
						if( GYLJ_S_C != "32" ) { 
							alert( "결재 할수 없는 상태 입니다"+ MSG);
							return;
						}
						
					}


				} else if( ROLE_ID == "7" ) {
					
					/* 
					4	자금세탁사기예방팀 담당자
	                5	자금세탁사기예방팀 책임자
	                6	RBA/AML 책임자
					105	RBA 담당자 
					
					0 미입력        
					5 저장
					13 미결재
					22 반려
					23 본점미결재
					32 책임자 미결재
					3  결재완료
					*/

					if( FLAG == "0" ) {
						// 승인요청
						/* 
							0 미입력        
							5 저장
							13 미결재
							22 반려
							23 본점미결재
							32 책임자 미결재
							3  결재완료
						*/
						if( GYLJ_S_C == "0" || GYLJ_S_C == "5" || GYLJ_S_C == "22") {
							form1.ROLE_ID.value = "105";
						} else if( GYLJ_S_C == "13" ) {
							form1.ROLE_ID.value = "6";
						} else if( GYLJ_S_C == "23" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "32" ) {
							form1.ROLE_ID.value = "104";
						}
						
						
					} else if( FLAG == "1" ) {
						//  반려
						if( GYLJ_S_C == "13" ) {
							form1.ROLE_ID.value = "6";
						} else if( GYLJ_S_C == "23" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "32" ) {
							form1.ROLE_ID.value = "104";
						}
						
					} else if( FLAG == "2" ) {
					    //  승인
						if( GYLJ_S_C == "13" ) {
							form1.ROLE_ID.value = "6";
						} else if( GYLJ_S_C == "23" ) {
							form1.ROLE_ID.value = "4";
						} else if( GYLJ_S_C == "32" ) {
							form1.ROLE_ID.value = "104";
						}
						
					}
					
					//alert( "FLAG, GYLJ_S_C, ROLE_ID : " + FLAG + " : " + GYLJ_S_C + " : " + form1.ROLE_ID.value );


				} 

			}

			return true;
		}



</script>

<style>
	#jipyoTable {
	    border-collapse : separate;
	    border-spacing:0;
	}
	
	#jipyoTable thead th{
	   position: sticky;
	   top: 0;
	   border-right: 1px solid #ccc;
	   background-color: #eaeaea;
	   border-top: 2px solid #222;
	    border-bottom: 1px solid #222;
	    z-index:1;
	}
	
	#jipyoTable tbody td{
	   border-bottom: 1px solid #e9eaeb;
	   border-right: 1px solid #e9eaeb;
	}
	
	.ellipsis {
	  display: inline-block;
	  max-width: 50px;
	  white-space: nowrap;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  vertical-align: middle;
	  font-weight: bold;
	/*   cursor: pointer; */
	
	}
	

</style>

<form name="fileFrm" id="fileFrm" method="POST">
	<input type="hidden" name="pageID" />
	<input type="hidden" name="downFileName" 	id="downFileName" value="" />
	<input type="hidden" name="orgFileName" 	id="orgFileName"  value="" />
	<input type="hidden" name="downFilePath" 	id="downFilePath" value="" />
	<input type="hidden" name="downType" 		id="downType" 	  value="RBA" />
	<input type="hidden" name="FILE_SER"    	id="FILE_SER" 	  value= "${FILE_SER}"/>
</form> 
<form name="form2" method="post" >
    <input type="hidden" name="pageID" >
    <input type="hidden" name="classID" >
    <input type="hidden" name="methodID" >
    <input type="hidden" name="BAS_YYMM" >
    <input type="hidden" name="GUBN">
    <input type="hidden" name="CNTL_CATG1_C" >
    <input type="hidden" name="CNTL_CATG2_C" >
    <input type="hidden" name="CNTL_ELMN_C" >
    <input type="hidden" name="CNTL_CATG1_C_NM" >
    <input type="hidden" name="CNTL_CATG2_C_NM" >
    <input type="hidden" name="CNTL_ELMN_C_NM" >
    <input type="hidden" name="BRNO" >
</form>

<form name="form1" id="form1" name="form1" method="post">
<input type="hidden" name="pageID">
<input type="hidden" name="classID">
<input type="hidden" name="methodID">
<input type="hidden" name="BAS_YYMM" value="${BAS_YYMM}"/>
<input type="hidden" name="CNTL_CATG1_C" id="CNTL_CATG1_C">
<input type="hidden" name="CNTL_CATG2_C" id="CNTL_CATG2_C">
<input type="hidden" name="CNTL_ELMN_C" id="CNTL_ELMN_C">
<input type="hidden" name="CNTL_CATG1_C_NM" id="CNTL_CATG1_C_NM">
<input type="hidden" name="CNTL_CATG2_C_NM" id="CNTL_CATG2_C_NM">
<input type="hidden" name="CNTL_ELMN_C_NM" id="CNTL_ELMN_C_NM">
<input type="hidden" name="USE_YN" id="USE_YN"/>
<input type="hidden" name="CNTL_ELMN_CTNT" id="CNTL_ELMN_CTNT"/>
<input type="hidden" name="CNTL_RSK_CTNT"  id="CNTL_RSK_CTNT"/>
<input type="hidden" name="EVAL_MTHD_CTNT" id="EVAL_MTHD_CTNT"/>
<input type="hidden" name="PROOF_DOC_LIST" id="PROOF_DOC_LIST"/>
<input type="hidden" name="BRNO_NM" />
<input type="hidden" name="BRNO" value="${BRNO}"/>
<input type="hidden" name="EVAL_TYPE_CD1" id="EVAL_TYPE_CD1" value="${EVAL_TYPE_CD1}"/>
<input type="hidden" name="ROLE_ID" value="${ROLE_ID}">
<input type="hidden" name="GYLJ_LINE_G_C" value="RBA01">	
<input type="hidden" name="GYLJ_ID"/>		<!-- 결재ID -->
<input type="hidden" name="GYLJ_S_C"/>		<!-- 결재상태코드 -->
<input type="hidden" name="GYLJ_S_C_NM"/>	
<input type="hidden" name="FLAG"/>
<input type="hidden" name="TABLE_NM"/>
<input type="hidden" name="LV3"/>
<input type="hidden" name="GYLJ_ROLE_ID"/>
<input type="hidden" name="NEXT_GYLJ_ROLE_ID"/>
<input type="hidden" name="FIRST_GYLJ" />
<input type="hidden" name="END_GYLJ" />   	
<input type="hidden" id="trCnt" name="trCnt">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	 <tr>
		<td valign="top">
			<iframe name="submitFrame" name="submitFrame" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
		</td>
	</tr>
</table>
<div class="panel panel-primary">
	<div class="panel-footer" >
		<div class="table-box">
			<table class="basic-table" >
			   <tbody>
			        <tr>
                    	<th class="title required" style="width:155;">${msgel.getMsg('RBA_50_04_01_02_001','통제분류Lv1')}</th>
                    	<td style="text-align: center; width:300;">${CNTL_CATG1_C_NM}</td>
                        <th class="title required" style="width:155;">${msgel.getMsg('RBA_50_04_01_02_002','통제분류Lv2')}</th>
                        <td style="text-align: center;">${CNTL_CATG2_C_NM}</td>
                    </tr>
                     <tr>
                    	<th class="title required">${msgel.getMsg('RBA_50_04_01_02_003','통제요소')}</th>
                    	<td colspan="3" style="text-align: left;">${CNTL_ELMN_C_NM}</td>

                    </tr>
                    <tr>
	                	<th class="title">${msgel.getMsg('RBA_50_04_01_02_005','통제요소설명')}</th>
	                	<td colspan="3" style="text-align: left;">${CNTL_ELMN_CTNT1}</td>

	                </tr>
	                <tr>
	                	<th class="title">${msgel.getMsg('RBA_50_04_01_02_006','통제위험')}</th>
	                	<td colspan="3" style="text-align: left;">${CNTL_RSK_CTNT1}</td>
	                </tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

		<div class="tab-content-top" style="text-align:right">
			<div class="button-area" style="margin-top: 5px; margin-bottom: 10px;">
				<%-- ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"addRowBtn", defaultValue:"행추가", mode:"R", function:"addRow", cssClass:"btn-36"}')}
 		 	    ${btnel.getButton(outputAuth, '{btnID:"btn_08", cdID:"deleteRowBtn", defaultValue:"행삭제", mode:"D", function:"deleteRow", cssClass:"btn-36"}')} --%>
	     	</div>
		</div>

<div class="panel panel-primary">
	<div class="panel-footer" >
		<div class="table-box">
			<table class="basic-table" >
			   <tbody>
			   <tr>
			   		<th class="title required" style="width:155;">${msgel.getMsg('RBA_50_04_01_02_007','평가유형')}</th>
			   		<td style="text-align: left; width:300;">${EVAL_TYPE_CD1_NM}</td>
					<th class="title required" style="width:155;">${msgel.getMsg('RBA_50_04_01_02_008','평가대상부점')}</th>
					<td style="text-align: center;">${DEP_LIST}</td>
			   </tr>
                <tr>
                	<th class="title">${msgel.getMsg('RBA_50_04_01_02_009','평가방법')}</th>
                	<td colspan="3" style="text-align: left;">${EVAL_MTHD_CTNT1}</td>
                </tr>
                <tr>
                	<th class="title">${msgel.getMsg('RBA_50_04_01_02_010','관련증빙')}</th>
                	<td colspan="3" style="text-align: left;">${PROOF_DOC_LIST1}</td>
                </tr>


				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="panel panel-primary" style="margin-top:8px;">
        <div class="panel-footer" >
             <div class="table-box" style="display:block;height:calc(35vh - 80px);overflow:auto;">
                <table class="grid-table-type" id="jipyoTable">
	                    <tr>
	                    	<thead>
	                        <th>${msgel.getMsg('RBA_50_04_01_02_014','No')}</th>
	                        <th>${msgel.getMsg('RBA_50_04_01_02_011','세부평가항목')}</th>
	                        <th>${msgel.getMsg('RBA_50_04_03_01_011','평가결과')}</th>
                    		</thead>
	                    </tr>
                </table>
            </div>
        </div>
        <div align="right" style="margin-top:5px;font-family: SpoqR;font-size:14px;opacity: .6">
        	<span id="GRID_CNT"></span>
   		</div>
</div>


<div class="panel panel-primary">
	<div class="panel-footer" >
		<div class="table-box">
			<table class="basic-table" >
			   <tbody>
                    <% if ( "104".equals(ROLE_IDS) || "7".equals(ROLE_IDS)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
                    <tr>
	                	<th class="title" style="width:155;">${msgel.getMsg('RBA_50_04_03_01_013','종합의견')}</th>
	                	<td style="text-align: left;" >
	                		<input type="text" name="CNTNT" id="CNTNT"  class="cond-input-text"  value="${CNTNT}" style="text-align: left; width: 100%" />
	                	</td>
	                </tr>
	                <% } %>

	                <!-- PHH 2009.04.08 파일첨부 -->
		             <tr>
		                <th class="title">${msgel.getMsg('AML_90_01_03_02_005','첨부파일')}</th>
		                <td colspan="3" style="overflow-y: auto; height: 20vh;">
		               		<div class="widget-container fileUploader-position-modifier" style="-ms-overflow-y: auto;">
				                <div id="file-uploader" style="margin-top:10px;"></div>
				                <div class="content" id="selected-files">
				                    <div>
				                        <h4>※ 업로드 된 파일 목록</h4>
				                    </div>
				                    <div id="fileBox" style="border: 1px solid rgb(221, 221, 221); background-color: rgb(255, 255, 255);">
		
		                   			<c:forEach items="${FILES }" var="result" varStatus="status">
							            <c:set var="i" value="${status.index}" />
									    <div id="file${i}" class="tx dx-fileuploader-button-container">
									    	<i class="fa fa-floppy-o" style="font-size: 14px;margin-left: 3px;" aria-hidden="true"></i>
									    	<a href="javascript:void(0);" class="link" onClick="downloadFile('${result.PHSC_FILE_NM}','${result.LOSC_FILE_NM}')" ><c:out value="${result.LOSC_FILE_NM }"/></a>
									    	<a class="btn-36" onclick="viewDelete(this);" >
										    	<input name="fileSizes" class="fileSizes" type="hidden" value="<c:out value="${result.FILE_SIZE }"/>"/>
									    		<input name="origFileNms" class="origFileNms" type="hidden" value="<c:out value="${result.USER_FILE_NM }"/>"/>
									    		<input name="storedFileNms" class="storedFileNms" type="hidden" value="<c:out value="${result.PHSC_FILE_NM }"/>"/>
									    		<input name="filePaths" id="filePaths" class="filePaths" type="hidden" value="<c:out value="${result.FILE_POS }"/>"/>
								    			<div class="dx-fileuploader-button dx-fileuploader-cancel-button dx-button dx-button-normal dx-button-mode-contained dx-widget dx-button-has-icon" style="margin-left: 10px;"  role="button" aria-hidden="true" aria-label="close">
		                   							<div class="dx-button-content" style="padding-left: 0.2em;">&nbsp;<i class="dx-icon dx-icon-close" ></i></div>
		                   						</div>
								    		</a>
									    </div>
									    <br/>
									    </c:forEach>
									</div>
		
				                </div>
				            </div>
		                </td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

	<div class="tab-content-top">
		<div class="button-area" style="margin-top:5px;">
			<% if ( ( "4".equals(ROLE_IDS) &&  "20500".equals(BRNO) ) || "105".equals(ROLE_IDS)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
			    ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
		       	${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
		    <% } %>
			<% if ( ( "4".equals(ROLE_IDS) &&  !"20500".equals(BRNO) ) || "104".equals(ROLE_IDS) || "6".equals(ROLE_IDS)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
		       	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"okBtn", defaultValue:"결재", mode:"U", function:"doApproval(2)", cssClass:"btn-36"}')}
		       	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"refuseBtn", defaultValue:"반려", mode:"U", function:"doApproval(1)", cssClass:"btn-36"}')}
		    <% } %>
		    <% if ( "7".equals(ROLE_IDS)) { // 3:AML담당자,4:준법감시팀 담당자.5:준법감시팀 책임자,6:RBA/AML책임자,7:ADMIN,105:RBA 담당자,104:보고책임자 %>
		        ${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"saveBtn", defaultValue:"저장", mode:"C", function:"doSave", cssClass:"btn-36"}')}
		        ${btnel.getButton(outputAuth, '{btnID:"btn_07", cdID:"apprRequestBtn", defaultValue:"결재요청", mode:"U", function:"doApproval(0)", cssClass:"btn-36"}')}
		       	${btnel.getButton(outputAuth, '{btnID:"btn_03", cdID:"okBtn", defaultValue:"결재", mode:"U", function:"doApproval(2)", cssClass:"btn-36"}')}
		       	${btnel.getButton(outputAuth, '{btnID:"btn_04", cdID:"refuseBtn", defaultValue:"반려", mode:"U", function:"doApproval(1)", cssClass:"btn-36"}')}
		    <% } %>
		    ${btnel.getButton(outputAuth, '{btnID:"btn_09", cdID:"closeBtn", defaultValue:"닫기", mode:"R", function:"doClose", cssClass:"btn-36"}')}

		</div>
	</div>
</form>
<jsp:include page="/WEB-INF/Package/AML/common/popUp_common_bottom.jsp" flush="true" />