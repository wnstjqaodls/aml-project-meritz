<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.gtone.rba.server.type03.RBA_50.RBA_50_07.RBA_50_07_03.RBA_50_07_03_01" %>
<%@ page import="com.gtone.aml.basic.common.data.DataObj"                               %>
<%@page import="java.text.DecimalFormat"%>
<%
    String BAS_YYMM = request.getParameter("BAS_YYMM");
    
	RBA_50_07_03_01 RBA5007 = new RBA_50_07_03_01();
    DataObj input = new DataObj();
    input.put("BAS_YYMM", BAS_YYMM);

    DataObj output = new DataObj();
    try{
        output = RBA5007.getSearch9(input);
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
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/fonts/fonts.css"                                 />
<link rel="stylesheet" type="text/css" media="screen" href="${path}/Kernel/ext/jquery/themes/base/jquery-ui.css"/>
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
        if(output.getCount("RANK") == 0){
		    %>
		    var items = [{
		        "통제점수"	: -100,
		        "위험점수"	: -100,
		        "tag"		: ''
		    }];
		    <%
        }else{
		    %>
		    var items = [
		    <%
		    DecimalFormat df = new DecimalFormat("#.##");
            for( int i = 0; i < output.getCount("RANK"); i++){
                //DecimalFormat df = new DecimalFormat("#.##");
                String tongjeEffRt = df.format(output.getDouble("TONGJE_VALT_PNT" , i));
                String mltfRskScor = df.format(output.getDouble("RSK_VALT_PNT" , i));
                
                if(i == output.getCount("PROC_SMDV_NM") - 1){
				    %>
				        { 
				            "통제점수": "<c:out value='<%=tongjeEffRt %>'/>",
				            "위험점수"  : "<c:out value='<%=mltfRskScor %>'/>",
				            "tag"       :"<c:out value='<%=output.getText("PROC_SMDV_NM" , i) %>'/>"
				        },
				    <%
                }else{
				    %>
				        {
				        	"통제점수": "<c:out value='<%=tongjeEffRt %>'/>",
				            "위험점수"  : "<c:out value='<%=mltfRskScor %>'/>",
				            "tag"       :"<c:out value='<%=output.getText("PROC_SMDV_NM" , i) %>'/>"
				        }
				    <%
                }
            }
        }
    %>
    ];
    
    $(document).ready(function(){
        ScatterChart();
    });
    
    function ScatterChart(){
        
        try{
            /*
            var chart1 = new cfx.Chart();
            chart1.getAnimations().getLoad().setEnabled(true);
            chart1.setGallery(cfx.Gallery.Scatter);
            chart1.getAxisY().setMax(5);
            chart1.getAxisY().setMin(0);
            chart1.getAxisX().setMax(100);
            chart1.getAxisX().setMin(0);
            chart1.getAxisX().setForceZero(false);
            chart1.getAxisY().setForceZero(false);
            
            chart1.create(document.getElementById("ChartDiv"));
            PopulatePatientSamples(chart1);
            var titles = chart1.getTitles();
            var title = new cfx.TitleDockable();
            title.setText("부점별 분포도");
            titles.add(title);
            chart1.getAxisX().getTitle().setText("통제효과성");
            chart1.getAxisY().getTitle().setText("잔여위험");
            chart1.getLegendBox().setVisible(false);
            */
            
            $("#chart").dxChart({
                dataSource: items,
                commonSeriesSettings: {
                    type: "scatter"
                },
                series: [{ 
                    argumentField: "위험점수",
                    valueField: "통제점수"
                }],
                argumentAxis:{
                    grid:{
                        visible: true
                    },
                    tickInterval: 10,
                    minorGrid: {
                        visible: true 
                    }, 
                    //title: '통제효과성 (%)',
                    max: 100,
                    maxValueMargin:0,
                    min: 0,
                    minValueMargin:0
                },
                valueAxis: {
                    tickInterval: 10,
                    //title: '잔여위험 (0~5)',
                    max: 100,
                    maxValueMargin:0,
                    min: 0,
                    minValueMargin:0
                },
                legend: {
                    visible: false
                },
                commonPaneSettings: {
                    border:{
                        visible: true
                    }
                },
                tooltip: {
                    enabled: true,
                    location: "edge",
                    customizeTooltip: function (arg) {
                        return {
                            html: "<div><div class='tooltip-header'>" +
                            arg.point.tag + "</div>" +
                            "<div class='tooltip-body'>" + 
                            "<div class='series-name'>위험점수 : </div><div class='value-text'>" +
                            arg.argumentText +
                            "% </div><div class='series-name'>통제점수 : </div><div class='value-text'>" +
                            arg.valueText +
                            "</div></div></div>"
                        };
                    }
                },
                "export": {
                    enabled: false
                },
                title: {
                    text: "※ 상위 Top 5 AML위험 업무 프로세스",
                    font: {
                        size: 13
                    }
                }
            });
            
        } catch (e) {
            alert(e);
        }
        
    }
    /*
    function PopulatePatientSamples(chart1){
        <%
            if(output.getCount("RANK") == 0){
        %>
        var items = [{
            "통제점수"	: '',
            "위험점수"	: '',
            "소구분(L3)"	: ''
        }
        <%
            }else{
        %>
        var items = [
        <%
                DecimalFormat df = new DecimalFormat("#.##");
                for( int i = 0; i < output.getCount("RANK"); i++){
                    //DecimalFormat df = new DecimalFormat("#.##");
                    String tongjeEffRt = df.format(output.getDouble("TONGJE_VALT_PNT" , i));
                    String mltfRskScor = df.format(output.getDouble("RSK_VALT_PNT" , i));
                    
                    if(i == output.getCount("PROC_SMDV_NM") - 1){
        %>
            {
                
                "통제점수": "<c:out value='<%=tongjeEffRt %>'/>",
                "위험점수"  : "<c:out value='<%=mltfRskScor %>'/>",
                "소구분(L3)"      :"<c:out value='<%=output.getText("PROC_SMDV_NM" , i) %>'/>"
            }, {
        },
        <%
                    }else{
        %>
            {
            	"통제점수": "<c:out value='<%=tongjeEffRt %>'/>",
                "위험점수"  : "<c:out value='<%=mltfRskScor %>'/>",
                "소구분(L3)"      :"<c:out value='<%=output.getText("PROC_SMDV_NM" , i) %>'/>"
            }
        <%
                    }
                }
            }
        %>
        ];
        
        var fields = chart1.getDataSourceSettings().getFields();
        
        var fieldWeight = new cfx.FieldMap();
        fieldWeight.setName("위험점수");
        fieldWeight.setUsage(cfx.FieldUsage.Value);
        fields.add(fieldWeight);
        
        var fieldHeight = new cfx.FieldMap();
        fieldHeight.setName("통제점수");
        fieldHeight.setUsage(cfx.FieldUsage.XValue);
        fields.add(fieldHeight);
        
        var fieldTest = new cfx.FieldMap();
        fieldTest.setName("소구분(L3)");
        fieldTest.setUsage(cfx.FieldUsage.NotUsed);
        fields.add(fieldTest);
        
        chart1.setDataSource(items);
    }
    */
</script>
</head>
<body>
	<div id="chart" style="width:100%;height:98%;text-align:center;"></div>
</body>
</html>