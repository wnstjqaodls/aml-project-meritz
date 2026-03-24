<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_03.RBA_50_07_03_02" %>
<%@ page import="com.gtone.aml.basic.common.data.DataObj"%>
<%@ page import="com.gtone.aml.basic.common.log.Log"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://www.gtone.co.kr/jstl/fmt" %>
<%@page import="java.text.DecimalFormat"%>
<%!
	DecimalFormat deciFormat(){
		return new DecimalFormat("#.##");
	}
%>
<%
    String BAS_YYMM = request.getParameter("BAS_YYMM");
    
	RBA_50_07_03_02 RBA_50_07_03_02 = new RBA_50_07_03_02();
    DataObj input = new DataObj();
    input.put("BAS_YYMM", BAS_YYMM);

    DataObj output = new DataObj();
    
    try{
        output = RBA_50_07_03_02.doSearch3(input);
    }catch(RuntimeException e){
    	Log.logAML(Log.ERROR, e);
    }catch(Exception e){
    	Log.logAML(Log.ERROR, e);
    }
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<meta content="text/html; charset=utf-8"  >
<!--
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/jquery/themes/base/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/jannex/css/jannex-style.css"     />
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/jChartFX/styles/jchartfx.css"    />
-->
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
<script src="${path}/Package/ext/js/common.js"                                  ></script>
<script src="${path}/Kernel/ext/jquery/ui/minified/jquery-ui.min.js"            ></script>
<script src="${path}/Package/ext/js/rba_common.js"                              ></script>
<script src="${path}/Package/ext/js/validate.js"                                ></script>
<script src="${path}/Package/ext/js/GToneGrid_Util.js"                          ></script>
<script src="${path}/Kernel/ext/PapaParse-master/papaparse.min.js"              ></script>
<script src="${path}/Kernel/ext/gtdatagrid/gtgridbase.js"                       ></script>
<script src="${path}/Kernel/ext/gtdatagrid/gttreebase.js"                       ></script>
<script src="${path}/Kernel/ext/jannex/js/util/c-util.js"                       ></script>
<!--for New grid end-->
<style type="text/css">
#chart {
    height: 440px;
}

.tooltip-header {
    margin-bottom: 5px;
    font-size: 16px;
    font-weight: bold;
    padding-bottom: 5px;
    border-bottom: 1px solid #c5c5c5;
}

.tooltip-body {
    width: 170px;
}

.tooltip-body .series-name {
    font-weight: normal;
    opacity: 0.6;
    display: inline-block;
    line-height: 1.5;
    padding-right: 10px;
    width: 126px;
}

.tooltip-body .value-text {
    display: inline-block;
    line-height: 1.5;
    width: 40px;
}
</style>
<script>
    
<%
    if(output.getCount("RSK_INDCT") == 0){
%>
	var items = [{
		        "day"	: -100,
		        "cnt"	: -100,
		        "pnt"	: ''
		    }];
<%
    } else {
%>
	var items = [
<%
    for( int i = 0; i < output.getCount("RSK_INDCT"); i++){
                //DecimalFormat df; df = new DecimalFormat("#.##");
       DecimalFormat df = deciFormat();
       String CNT; CNT = df.format(output.getDouble("CNT" , i));
       String CNT2; CNT2 = df.format(output.getDouble("CNT2" , i));
                
       if(i == output.getCount("RSK_INDCT") - 1){
%>
		{
			"rskindct": "<c:out value='<%=output.getText("RSK_INDCT" , i) %>'/>",
			"cnt"  :<c:out value='<%=CNT %>'/>,
			"cnt2"  :<c:out value='<%=CNT2 %>'/> 
		},
<%
        } else {
%>
		{ 
			"rskindct": "<c:out value='<%=output.getText("RSK_INDCT" , i) %>'/>",
			"cnt"  :<c:out value='<%=CNT %>'/>,
			"cnt2"  :<c:out value='<%=CNT2 %>'/> 
		},
<%
        }
    }  %>  ]; // end of for
<%    }  // end of else
%>
    
    $(document).ready(function(){
        ScatterChart();
    });
    
    function ScatterChart(){
        
        try{ 
            $("#chart").dxChart({
                dataSource: items 
                ,"commonSeriesSettings" : {
                    "argumentField" : "rskindct"
                   ,"type"          : "bar"
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
                    "valueField": "cnt", "name": "최근회차", "type":"bar"
                },{ "valueField": "cnt2", "name": "직전회차", "type":"bar"
                } ]
               , 
               "legend": {
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
            
        } catch (e) {
            alert(e);
        }
        
    }
     
</script>
</head>
<body>
	<div id="chart" style="width:100%;height:98%;text-align:center;"></div>
</body>
</html>