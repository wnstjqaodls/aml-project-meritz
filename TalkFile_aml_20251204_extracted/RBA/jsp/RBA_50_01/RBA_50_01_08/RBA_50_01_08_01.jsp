<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Project         : RBA
* File Name       : RBA_50_01_08_01.jsp
* Description     : 결재선관리
* Group           : GTONE, R&D센터/개발2본부
* Author          : HHJ
* Since           : 2018-04-20
--%>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_top.jsp" flush="true" />
<%@ include file="/WEB-INF/Package/AML/common/common.jsp" %>

<script language="JavaScript">

    var GridObj1 ;
    var GridObj2 ;
    var classID  = "RBA_50_01_08_01";
    var overlay  = new Overlay();
    var addCD    = "";
    var addCDNM  = "";
    var curRow   = -1;
    
    var pCCD     = "1";
    var firtsCnt = 0;
    
    var overlay  = new Overlay();
    
    /** Initialize */
    $(document).ready(function(){
        setupConditions();
        setupGrids();
    });
    
    /** Initial function */
    function init() { initPage(); }
    
    /** 검색조건 셋업 */
    function setupConditions(){
        try {
            var cbox1; cbox1 = new GtCondBox("condBox1",0,false);
            cbox1.setItemWidths(100, 70, 0);
            cbox1.setItemWidths(100, 70, 1);
        } catch (e) {
            alert(e.message);
        }
    }
    
    /** 그리드 초기화 함수 셋업 */
    function setupGrids(){
        /** 그리드1(Code Head) 초기화 */
        GridObj1 = initGrid3({
            gridId          : 'GTDataGrid1'
           ,headerId        : 'RBA_50_01_08_01_Grid1'
           ,gridAreaId      : 'GTDataGrid1_Area'
           ,height          : 'calc(40vh - 100px)'
           ,useAuthYN       : '${outputAuth.USE_YN}'
           ,gridHeadTitle   : '결재선'
           ,completedEvent  : function(){
        	   doSearch();
        	   
               /** 그리드2(Code Head) 초기화 */
        	   GridObj2 = initGrid3({
                   gridId          : 'GTDataGrid2'
                  ,headerId        : 'RBA_50_01_08_01_Grid2'
                  ,gridAreaId      : 'GTDataGrid2_Area'
                  ,height          : 'calc(45vh - 100px)'
                  ,useAuthYN       : '${outputAuth.USE_YN}'
                  ,gridHeadTitle   : '결재선상세'
                  ,completedEvent  : function(){
                      setupGridFilter([GridObj1, GridObj2]);
                   }
               });
            }
        });
    }
    
    /** Grid1 행 추가 */
    function addRowGrid1(cmpnt){

          cmpnt.addRow();
          cmpnt.saveEditData();
    }
     /** Grid2 행 추가 */
    function addRowGrid2(e){

    var selectedRows = GridObj1.getSelectedRowsData();
  
    curRow = selectedRows.length -1
        if (curRow>-1) {
            var grid1; grid1 = $('#GTDataGrid1_Area').dxDataGrid('instance');
            var data = grid1.getDataSource().items()[curRow];

            if (data.GRP_CD=="") {
                // 선택 된 Code Head 가 아직 생성중임
                alert('선택 된 Code Head 가 아직 생성중임');
            } else {
                var selkeys = $('#GTDataGrid1_Area').dxDataGrid('instance').getSelectedRowKeys();
                
                if (selkeys&&selkeys.length>0) {
                    var gobj; gobj = $('#GTDataGrid2_Area').dxDataGrid('instance');
                    gobj.addRow();
                    gobj.saveEditData();
                } else {
                    // 선택 된 Code Head 없음
                    alert('선택 된 Code Head 없음1');
                    
                }
            } 
        } else {
            // 선택 된 Code Head 없음
            alert('선택 된 Code Head 없음2');
        }
        $(".dx-button-text").css("display","inline-block").css("margin-left","3px");
    }

// [ make ]
    var saveitemobj;
        /** 툴바 버튼 설정 */
    function makeToolbarButtonGrids(e){

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
                        ,"onClick"   : gridID=="GTDataGrid1_Area"?doSearch:doSearch2
                 }
            });
            var btnLastIndex=0;
            for(;btnLastIndex<toolbarItems.length; btnLastIndex++){
                if(toolbarItems[btnLastIndex].widget != "dxButton") {
                    break;
                }
            }
            if (authD=="Y") {
                toolbarItems.splice(btnLastIndex, 0, {
                    "locateInMenu" : "auto"
                   ,"location"     : "after"
                   ,"widget"       : "dxButton"
                   ,"name"         : "removeButton"
                   ,"showText"     : "always"
                   ,"options"      : {
                            "icon"      : "remove"   
                           ,"text"      : '삭제'
                           ,"hint"      : '행을 삭제'
                           ,"disabled"  : false
                           ,"onClick"   : gridID=="GTDataGrid1_Area"?doDelete1:doDelete2
                     }
                });
            }
            if (authC=="Y") {
                $.each(toolbarItems, function(i, item) {
                    if (item.name === "saveButton") {
                        item.showText           = "always";
                        item.widget             = "dxButton";
                        item.options.text       = '저장';
                        item.options.disabled   = false;
                        item.options.onClick    = function(){
                            if (gridID=="GTDataGrid1_Area") {
                                doSave1(cmpnt);
                            } else {
                                doSave2(cmpnt);
                            }
                        }
                    } else if (item.name === "addRowButton") {
                    	if (gridID=="GTDataGrid1_Area") {
                    		item.options.visible = false;
                    	}
                        item.showText           = "always";
                        item.options.text       = '추가';
                        item.options.disabled   = false;
                        item.options.onClick    = function(){
                            if (gridID=="GTDataGrid1_Area") {
                                addRowGrid1(cmpnt);
                            } else {
                                addRowGrid2(cmpnt);
                            }
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
        
        
    
    /** Search CODE Head */
    var doSearch = function() {
        
        if($("button[id='btn_01']") == null) return;
        
        $("button[id='btn_01']").prop('disabled', true);
        
        GridObj1.refresh({
            actionParam: {
                "pageID"	: pageID,
                "classID"	: classID,
                "methodID"	: "doSearch",
            },
            completedEvent	: doSearch_end
        });
    }
    
    /** Search CODE Head end */
    var doSearch_end = function() {
        
        $("button[id='btn_01']").prop('disabled', false);
        
        var row = GridObj1.rowCount();
        
        if(row > 0){
            obj = GridObj1.selectRow(0, true).getRowNew(0, function(data){ Grid1CellClick("GTDataGrid1", data); });
            
        }else{
            form.GRP_CD_1.value = "";
        }
    }
    
    /** Click Code Head */
    var Grid1CellClick = function(id, obj, selectData, rowIdx, colIdx, columnId, colId){

        if (curRow!=rowIdx) {
            curRow                = rowIdx;
            addCD                 = obj.GYLJ_LINE_G_C;
            addCDNM               = obj.GYLJ_LINE_NM;
            doSearch2();
        }
    }
    
    /** Search CODE Detail */
   
    var doSearch2 = function() {
        if(GridObj2 == null){
            return;
        }
        GridObj2.removeAll();
        
        GridObj2.refresh({
            actionParam: {
                "pageID"	    : pageID,
                "classID"	    : classID,
                "methodID"	    : "doSearch2",
                "GYLJ_LINE_G_C"	: addCD
            },
            completedEvent	: doSearch2_end
        });
    }
    
    /** Search CODE Detail */
    var doSearch2_end = function (){
        
    }

    var doSave1 = function() {

        var selectedRows = GridObj1.getSelectedRowsData();
        var size         = selectedRows.length;
        var rowsData     = GridObj1.getEditingAllRowsData();
        var selectedHead = GridObj1.currentRow();

        if(size <= 0 ){
            alert("${msgel.getMsg('selectSaveData','저장 할 데이타를 선택하십시오.')}"); 
            return;
        }
        if(size > 0){
            if(selectedHead.GYLJ_LINE_G_C == "" || selectedHead.GYLJ_LINE_G_C == null){
                alert("${msgel.getMsg('setCode','코드를 입력하십시오.')}");
                return false;
            }else if(selectedHead.GYLJ_LINE_NM == "" || selectedHead.GYLJ_LINE_NM == null){
                alert("${msgel.getMsg('setCodeNM','코드명을 입력하십시오.')}");
                return false;
            }else if(selectedHead.USYN == "" || selectedHead.USYN == null){
                alert("${msgel.getMsg('setUSYN','사용여부를 입력하십시오.')}");
                return false;
            }
            
        }
        if(!confirm("${msgel.getMsg('doSave','저장하시겠습니까?')}")) return;

        var obj = new Object();      
        obj.pageID      = "RBA_50_01_08_01";
        obj.classID     = "RBA_50_01_08_01";
        obj.methodID    = "doSave";
        obj.CON_YN      = "0";

        GridObj1.save({
          actionParam     : obj
         ,sendFlag        : "USERDATA"
         ,userGridData    : rowsData
         ,completedEvent  : doSave1_end
        });
        
    }
    
    var doSave1_end = function() {
        doSearch();
    }   
    
    var doSave2 = function() {

        var selectedRows = GridObj2.getSelectedRowsData();
        var size         = selectedRows.length;
        var selectedHead = GridObj2.currentRow();
        var rowsData     = GridObj2.getEditingAllRowsData();

        if(size <= 0 ){
            alert("${msgel.getMsg('selectSaveData','저장 할 데이타를 선택하십시오.')}"); 
            return;
        }
        if(size > 0){
            if(selectedHead.SNO == "" || selectedHead.SNO == null){
                 alert("순번을 입력하십시오.");
                return false;
            }
           
        }
        
        if(!confirm("${msgel.getMsg('doSave','저장하시겠습니까?')}")) return;
        
        var obj2      = new Object();
        obj2.pageID   = pageID;
        obj2.classID  = classID;
        obj2.methodID = "doSave2";
        obj2.SNO      = selectedHead.SNO;
        obj2.GYLJ_ROLE_ID = selectedHead.GYLJ_ROLE_ID;
        obj2.NEXT_GYLJ_ROLE_ID = selectedHead.NEXT_GYLJ_ROLE_ID;
        obj2.RTN_ROLE_ID = selectedHead.RTN_ROLE_ID;
        

        GridObj2.save({
          actionParam     : obj2
         ,sendFlag        : "USERDATA"
         ,userGridData    : rowsData
         ,completedEvent  : doSave2_end
        });
    }
    
    var doSave2_end = function (){
        doSearch2();
    }
    
    var doDelete1 = function() {

        var selectedRows = GridObj1.getSelectedRowsData();
        var size         = selectedRows.length;
        var selectedHead = GridObj1.currentRow();

        if(size <= 0){
            alert("${msgel.getMsg('dataDeleteSelect','삭제할 데이타를 선택하십시오.')}"); 
            return;
        }

        if(!confirm("${msgel.getMsg('doDelete','삭제하시겠습니까?')}")) return;
        var methodID 	    = "doDelete";
        var objd            = new Object();
        objd.pageID         = pageID;
        objd.classID        = classID;
        objd.methodID       = methodID;      
        objd.GRP_C          = selectedHead.GRP_C;
        objd.GYLJ_LINE_G_C  = selectedHead.GYLJ_LINE_G_C;
        GridObj1.save({    
            actionParam     : objd
            ,sendFlag        : "SELECTED"
            ,completedEvent  : doSave1_end      
        });
    }
    
    var doDelete2 = function() {

        var obj = new Object();
        var methodID; methodID    = "doDelete2";
        var selectedHead = GridObj2.currentRow();
        var selectedRows = GridObj2.getSelectedRowsData();
        var size         = selectedRows.length;
        
        
        if(size <= 0){
            alert("${msgel.getMsg('dataDeleteSelect','삭제할 데이타를 선택하십시오.')}"); 
            return;
       }

        if(!confirm("${msgel.getMsg('doDelete','삭제하시겠습니까?')}")) return;
        
        obj.pageID          = pageID;
        obj.classID         = classID;
        obj.methodID        = "doDelete2";
        obj.GYLJ_LINE_G_C   = selectedHead.GYLJ_LINE_G_C;
        obj.SNO             = selectedHead.SNO;
        
        GridObj2.save({    
            actionParam      : obj
            ,sendFlag        : "SELECTED"
            ,completedEvent  : doSave2_end      
        });

    }
    
    var CheckCnt = function(gObj) {
        for(i=0; i<gObj.rowCount(); i++){
            obj = gObj.getRow(i);
            if(obj.SELECTED == "1"){
                return true;
            }
        }
        return false;
    }
    
</script>

<form name="form" onkeydown="doEnterEvent('doSearch');">
	<input type="hidden" name="pageID">
	<input type="hidden" name="GRP_CD_1">
	<input type="text" name="temp" style="display: none;">
	<div class="cond-box" id="condBox1">
        <div class="cond-btn-row" style="text-align:right; padding-top:4px">
			${btnel.getButton(outputAuth, '{btnID:"btn_01", cdID:"queryBtn", defaultValue:"조회", mode:"R", function:"doSearch", cssClass:"flat-btn flat-btn-jean", icssClass:"fa fa-search"}')}
		</div>
	</div>
	<div class="panel panel-primary">
		<div class="panel-footer" >
			<div id="GTDataGrid1_Area"></div>
		</div>
	</div>
	<div class="panel panel-primary">
		<div class="panel-footer" >
			<div id="GTDataGrid2_Area"></div>
		</div>
		<div align="left">
	        <font color="blue"> 
	         	  ※ 결재선 설명 <br>
	         	  W01 : 부서별 업무프로세스관리 화면의 법규준수팀 프로세스 운영여부에 대한 결재선<br>
	         	  W02 : 부서별 업무프로세스관리 화면의 법규준수팀 제외한 본부부서의 프로세스 운영여부에 대한 결재선<br>
	         	  W03 : 위험평가지표관리 화면의   ML/TF위험지표 사용에 대한 결재선<br>
	         	  W04 : 고위험영역개선관리 화면의  법규준수팀 개선결과 결재선<br>
	         	  W05 : 위험평가지표관리 화면의  법규준수팀 제외한 본사부서,영업점 개선결과 결재선
	         	  
	        </font>
    	</div>
	</div>

</form>
<jsp:include page="/WEB-INF/Package/AML/common/main_common_bottom.jsp" flush="true" />