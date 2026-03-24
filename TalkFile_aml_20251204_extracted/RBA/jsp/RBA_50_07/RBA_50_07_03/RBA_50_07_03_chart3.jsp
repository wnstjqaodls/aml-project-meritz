<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--
********************************************************************************************************************************************
* Copyright (C) 2008-2018 GTOne. All Right Reserved.
********************************************************************************************************************************************
* Description     : RBA 위험평가결과 보고, 결과탭, 월평균 주요 위험지표 거래 변화량 차트
* Group           : GTONE, R&D센터/개발2본부
* Project         : AML/RBA/FATCA/CRS/WLF
* Author          : 정성원
* Since           : 2018. 8. 20.
********************************************************************************************************************************************
--%>
<%@ page import="com.gtone.aml.basic.common.data.DataObj"                               %>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_03.RBA_50_07_03_01" %>
<%@ page import="java.text.SimpleDateFormat"                         %>
<%@ page import="java.util.Calendar"                         %>
<%@ page import="java.util.Date"                        %>
<%@ page import="java.text.ParseException"                        %>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>  

<%
	DataObj inParam = new DataObj();

	String BAS_YYMM = request.getParameter("BAS_YYMM"); 
	inParam.put("BAS_YYMM", BAS_YYMM); 
	
	RBA_50_07_03_01 svr = RBA_50_07_03_01.getInstance();
	DataObj output = svr.getSearch14(inParam);
	
	int outcnt = output.getCount();
	//System.out.println(output);
	//System.out.println("output.getCount()"+output.getCount());
	if(outcnt >= -2147483648 || outcnt < 2147483647){
		String[] TAB1 = new String[outcnt];
		String[] TAB2 = new String[outcnt];
		String[] TAB3 = new String[outcnt];
		String[] TAB4 = new String[outcnt];
		String[] TAB5 = new String[outcnt];
		String[] TAB6 = new String[outcnt];
		String[] TAB7 = new String[outcnt];
		String[] TAB8 = new String[outcnt];
		String[] TAB9 = new String[outcnt];
		String[] TAB10 = new String[outcnt];
		String[] TAB11 = new String[outcnt];
		String[] TAB12 = new String[outcnt];
		String[] RSK_INDCT_NM = new String[outcnt];
	}
	
	for (int i = 0; i < output.getCount(); i++) {
		RSK_INDCT_NM[i] = output.getText("RSK_INDCT_NM", i).length() == 0 ? "" :output.getText("RSK_INDCT_NM", i)  ; 
		TAB1[i] = output.getText("TAB1", i).length() == 0 ? "0" :output.getText("TAB1", i)  ;
		TAB2[i] = output.getText("TAB2", i).length() == 0 ? "0" :output.getText("TAB2", i) ;
		TAB3[i] = output.getText("TAB3", i).length() == 0 ? "0" :output.getText("TAB3", i) ;
		TAB4[i] = output.getText("TAB4", i).length() == 0 ? "0" :output.getText("TAB4", i) ;
		TAB5[i] = output.getText("TAB5", i).length() == 0 ? "0" :output.getText("TAB5", i) ;
		TAB6[i] = output.getText("TAB6", i).length() == 0 ? "0" :output.getText("TAB6", i) ;
		TAB7[i] = output.getText("TAB7", i).length() == 0 ? "0" :output.getText("TAB7", i) ;
		TAB8[i] = output.getText("TAB8", i).length() == 0 ? "0" :output.getText("TAB8", i) ;
		TAB9[i] = output.getText("TAB9", i).length() == 0 ? "0" :output.getText("TAB9", i) ;
		TAB10[i] = output.getText("TAB10", i).length() == 0 ? "0" :output.getText("TAB10", i) ;
		TAB11[i] = output.getText("TAB11", i).length() == 0 ? "0" :output.getText("TAB11", i) ;
		TAB12[i] = output.getText("TAB12", i).length() == 0 ? "0" :output.getText("TAB12", i) ;
		
		//System.out.println(output.getText("TAB1", 1));
	}
	 request.setAttribute("TAB1" , TAB1 );
	 request.setAttribute("TAB2" , TAB2 );
	 request.setAttribute("TAB3" , TAB3 );
	 request.setAttribute("TAB4" , TAB4 );
	 request.setAttribute("TAB5" , TAB5 );
	 request.setAttribute("TAB6" , TAB6 );
	 request.setAttribute("TAB7" , TAB7 );
	 request.setAttribute("TAB8" , TAB8 );
	 request.setAttribute("TAB9" , TAB9 );
	 request.setAttribute("TAB10" , TAB10 );
	 request.setAttribute("TAB11" , TAB11 );
	 request.setAttribute("TAB12" , TAB12 );
	 request.setAttribute("RSK_INDCT_NM1" , RSK_INDCT_NM[0] );
	 request.setAttribute("RSK_INDCT_NM2" , RSK_INDCT_NM[1] );
	 request.setAttribute("RSK_INDCT_NM3" , RSK_INDCT_NM[2] );
	 request.setAttribute("RSK_INDCT_NM4" , RSK_INDCT_NM[3] );
	 request.setAttribute("RSK_INDCT_NM5" , RSK_INDCT_NM[4] );
	 
	/*  
	int ctrCnt = 0;
    int strCnt = 0;
    int kycCnt = 0;
    String[] crtDt = new String[3];
    
    crtDt[0] = "01";
    crtDt[1] = "02";
    crtDt[2] = "03";
    request.setAttribute("crtDt" , crtDt ); */
    
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM"); 
    Date date = null; 
    try{
        date = sdf.parse(BAS_YYMM);
    }catch(ParseException e){
    	Log.logAML(Log.ERROR,this,"(ParseException)",e.toString());
    }
	
	Calendar cal = Calendar.getInstance(); 
	cal.setTime(date);
    cal.add(Calendar.MONTH, -1);
    Date date2 = cal.getTime();
	String BAS_YYMM2 = sdf.format(date2);	// 기준년월 -1개월
	
	String year1; year1 = BAS_YYMM2.substring(0, 4);
	String year2; 
	//year2 = String.valueOf(Integer.parseInt(BAS_YYMM2.substring(0, 4))-1);
	try{
		year2 = String.valueOf(Integer.parseInt(BAS_YYMM2.substring(0, 4))-1);
    }catch(NumberFormatException e){
    	Log.logAML(Log.ERROR,this,"(NumberFormatException)",e.toString());
    }
	String month = BAS_YYMM2.substring(4, 6); 
	
	String[] months = {"01","02","03","04","05","06","07","08","09","10","11","12"};
	String[] temp = new String[12];
	int index = 0;
	for (int i = 0; i < months.length; i++) {
		if (month.equals(months[i])) {
			index = i;
			break;
		}
	}

	// 선택한 평가기준월에 따라 그리드에 보여지는 컬럼값 셋팅
	int index2 = 0;
	try{
	for (int i = index; i >= 0; i--) {
		if (i == index) {
			temp[index2] = String.valueOf(Integer.parseInt(months[i]));
		} else {
			temp[index2] = String.valueOf(Integer.parseInt(months[i]));
		}
		index2++;
	}
	for (int i = months.length-1; i > index; i--) {
		if (i == months.length-1) {
			temp[index2] = String.valueOf(Integer.parseInt(months[i]));
		} else {
			temp[index2] = String.valueOf(Integer.parseInt(months[i]));
		}
		index2++;
	}
	
	}catch(NumberFormatException e){
    	Log.logAML(Log.ERROR,this,"(NumberFormatException)",e.toString());
    }
	 
    request.setAttribute("temp" , temp );
%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" />
<title></title>
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/fonts/fonts.css"                                 />
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/jquery/themes/base/jquery-ui.css"                />
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/devx/20.2/css/dx.common.css"                     />
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/devx/20.2/css/dx.light.compact.css"              /> 
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Package/ext/css/main.css"                                   />
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/fonts/font-awesome/css/font-awesome.min.css"     />
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/jannex/css/jannex-style.css"                     />
<script src="${path}/Kernel/ext/devx/20.2/js/jquery.min.js"></script>
<script src="${path}/Kernel/ext/devx/20.2/js/jszip.min.js"></script>
<script src="${path}/Kernel/ext/devx/20.2/js/dx.all.js"></script>
<script src="${path}/Kernel/ext/devx/20.2/js/localization/dx.messages.${NTN_CD}.js"></script> 
<script src="${path}/Package/ext/js/common.js"                                  ></script>
<script src="${path}/Package/ext/js/rba_common.js"                              ></script>
<script src="${path}/Package/ext/js/validate.js"                                ></script>
<script src="${path}/Package/ext/js/GToneGrid_Util.js"                          ></script>
<script src="${path}/Kernel/ext/PapaParse-master/papaparse.min.js"              ></script>
<script src="${path}/Kernel/ext/download-master/download.min.js"                ></script>
<script>
    DevExpress.localization.locale('${NTN_CD}');
</script>
<script src="${path}/Kernel/ext/gtdatagrid/gtgridbase.js"                       ></script>
<script src="${path}/Kernel/ext/gtdatagrid/gttreebase.js"                       ></script>
<script src="${path}/Kernel/ext/jannex/js/util/c-util.js"                       ></script>
<script>

    $(document).ready(function(){
        var products; products = [{
            name    : '${RSK_INDCT_NM1}'
                ,count   :5
                ,active  : true
             },{
                 name    : '${RSK_INDCT_NM2}'
                ,count   :5
                ,active  : true
             },{
                 name    : '${RSK_INDCT_NM3}'
                ,count   :5
                ,active  : true
             },{
                 name    : '${RSK_INDCT_NM4}'
                ,count   :5
                ,active  : true
             },{
                 name    : '${RSK_INDCT_NM5}'
                ,count   :5
                ,active  : true
             }];
        var productsToValues; productsToValues = function (){ 
            return $.map(products, function(item){
                return item.active?item.count:null;
            });
        };
        
        
        $("#chart").dxChart({
            "dataSource" : [{
                "month" : "${temp[0]}월"
               ,"1"   : ${TAB1[0]}
               ,"2"   : ${TAB1[1]}
               ,"3"   : ${TAB1[2]}
               ,"4"   : ${TAB1[3]}
               ,"5"   : ${TAB1[4]}
            },{
                "month" : "${temp[1]}월"
               	,"1"   : ${TAB2[0]}
                ,"2"   : ${TAB2[1]}
                ,"3"   : ${TAB2[2]}
                ,"4"   : ${TAB2[3]}
                ,"5"   : ${TAB2[4]}
            },{
                 "month" : "${temp[2]}월"
                 ,"1"   : ${TAB3[0]}
                 ,"2"   : ${TAB3[1]}
                 ,"3"   : ${TAB3[2]}
                 ,"4"   : ${TAB3[3]}
                 ,"5"   : ${TAB3[4]}
            },{
                "month" : "${temp[3]}월"
                ,"1"   : ${TAB4[0]}
                ,"2"   : ${TAB4[1]}
                ,"3"   : ${TAB4[2]}
                ,"4"   : ${TAB4[3]}
                ,"5"   : ${TAB4[4]}
            },{
                "month" : "${temp[4]}월"
                ,"1"   : ${TAB5[0]}
                ,"2"   : ${TAB5[1]}
                ,"3"   : ${TAB5[2]}
                ,"4"   : ${TAB5[3]}
                ,"5"   : ${TAB5[4]}
            },{
                "month" : "${temp[5]}월"
                ,"1"   : ${TAB6[0]}
                ,"2"   : ${TAB6[1]}
                ,"3"   : ${TAB6[2]}
                ,"4"   : ${TAB6[3]}
                ,"5"   : ${TAB6[4]}
            },{
                "month" : "${temp[6]}월"
                ,"1"   : ${TAB7[0]}
                ,"2"   : ${TAB7[1]}
                ,"3"   : ${TAB7[2]}
                ,"4"   : ${TAB7[3]}
                ,"5"   : ${TAB7[4]}
            },{
                "month" : "${temp[7]}월"
                ,"1"   : ${TAB8[0]}
                ,"2"   : ${TAB8[1]}
                ,"3"   : ${TAB8[2]}
                ,"4"   : ${TAB8[3]}
                ,"5"   : ${TAB8[4]}
            },{
                "month" : "${temp[8]}월"
                ,"1"   : ${TAB9[0]}
                ,"2"   : ${TAB9[1]}
                ,"3"   : ${TAB9[2]}
                ,"4"   : ${TAB9[3]}
                ,"5"   : ${TAB9[4]}
            },{
                "month" : "${temp[9]}월"
                ,"1"   : ${TAB10[0]}
                ,"2"   : ${TAB10[1]}
                ,"3"   : ${TAB10[2]}
                ,"4"   : ${TAB10[3]}
                ,"5"   : ${TAB10[4]}
            },{
                "month" : "${temp[10]}월"
                ,"1"   : ${TAB11[0]}
                ,"2"   : ${TAB11[1]}
                ,"3"   : ${TAB11[2]}
                ,"4"   : ${TAB11[3]}
                ,"5"   : ${TAB11[4]}
            },{
                "month" : "${temp[11]}월"
                ,"1"   : ${TAB12[0]}
                ,"2"   : ${TAB12[1]}
                ,"3"   : ${TAB12[2]}
                ,"4"   : ${TAB12[3]}
                ,"5"   : ${TAB12[4]}
            }]
           ,"commonSeriesSettings" : {
                "argumentField" : "month"
               ,"type"          : "line"
               ,"hoverMode"     : "allArgumentPoints"
               ,"selectionMode" : "allArgumentPoints"
               ,"label" : {
                    "visible"   : true
                   ,"format"    : {
                        "type"      : "fixedPoint"
                       ,"precision" : 0
                    }
                }
            },
            series: [{
                "valueField": "1", "name": "${RSK_INDCT_NM1}" 
            },{ "valueField": "2", "name": "${RSK_INDCT_NM2}" 
            },{ "valueField": "3", "name": "${RSK_INDCT_NM3}" 
            },{ "valueField": "4", "name": "${RSK_INDCT_NM4}" 
            },{ "valueField": "5", "name": "${RSK_INDCT_NM5}" 
            }]
           ,"legend": {
                "verticalAlignment"     : "bottom"
               ,"horizontalAlignment"   : "center"
            }
           ,"export" : {
                "enabled": false
            }
           ,"onPointClick": function (e) {
                e.target.select();
            }
        });
    });
</script>
</head>
<body style="text-align:center;overflow-y:hidden;">
    <div style="width:100%;height:100%;">
  
        <div style="display:inline-block;width:calc(100% - 20px);height:calc(100% - 3px);overflow:hidden;margin:0;padding:0;">
            <div id="chart" style="width:95%;height:100%;text-align:center;"></div>
        </div>
    </div>
</body>
</html>