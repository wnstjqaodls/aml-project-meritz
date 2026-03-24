<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.gtone.aml.basic.common.data.DataObj"  %>
<%@ page import="com.gtone.aml.basic.jspeed.base.el.*" %>
<%@ page import="com.gtone.rba.server.common.RBA_90.RBA_90_01.RBA_90_01_05.RBA_90_01_05_01" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://www.gtone.co.kr/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<%--
- File Name  : RBA_90_01_05_02.jsp
- Author     : SeungRok
- Comment    : 점수변동추이
- Version    : 1.0
- history    : 1.0 2018-12-17
--%>

<%
	//[ EL 셋업 ]
	MsgEL.setup(pageContext);

	RBA_90_01_05_01 svr = RBA_90_01_05_01.getInstance();

	DataObj inParam = new DataObj();

	String RPT_GJDT = request.getParameter("RPT_GJDT");
	String JIPYO_IDX = request.getParameter("JIPYO_IDX");

	inParam.put("RPT_GJDT",RPT_GJDT );
	inParam.put("JIPYO_IDX",JIPYO_IDX );

	DataObj output = svr.getSearchRslt(inParam);

	String SCORE1 = output.getText("SCORE1");
	String SCORE2 = output.getText("SCORE2");
	String SCORE3 = output.getText("SCORE3");

	request.setAttribute("score1", SCORE1);
    request.setAttribute("score2", SCORE2);
    request.setAttribute("score3", SCORE3);
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta content="text/html; charset=utf-8"  >
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
<%-- <script src="${path}/Kernel/ext/devx/20.2/js/localization/dx.messages${NTN_CD}.js"></script>  --%>

<script src="${path}/Package/ext/js/common.js"                                  ></script>
<script src="${path}/Kernel/ext/jquery/ui/minified/jquery-ui.min.js"            ></script>
<script src="${path}/Package/ext/js/rba_common.js"                              ></script>
<script src="${path}/Package/ext/js/validate.js"                                ></script>
<script src="${path}/Package/ext/js/GToneGrid_Util.js"                          ></script>
<script src="${path}/Kernel/ext/PapaParse-master/papaparse.min.js"              ></script>
<script src="${path}/Kernel/ext/download-master/download.min.js"                ></script>
<style type="text/css">
#chart {
    height: 100%;
}
</style>
<script language="JavaScript" type="text/javascript">
	var dataSource = [{
	    day: "${msgel.getMsg('RBA_90_01_05_01_106','전전회차')}",
	    oranges: ${score3}
	}, {
	    day: "${msgel.getMsg('RBA_90_01_05_01_104','직전회차')}",
	    oranges: ${score2}
	},{
	    day: "${msgel.getMsg('RBA_90_01_05_01_100','최근회차')}",
	    oranges: ${score1}
	}];


	function chart(){
		$("#chart").dxChart({
            dataSource: dataSource,
            "commonSeriesSettings" : {
                "argumentField" : "day"
               ,"type"          : "bar"
               ,"hoverMode"     : "allArgumentPoints"
               ,"selectionMode" : "allArgumentPoints"
               ,"label" : {
                    "visible"   : true
                   ,"format"    : {
                        "type"      : "fixedPoint"
                       ,"precision" : 2
                    }
                }
            },
            series: [{
                valueField: "oranges",
                name: "${msgel.getMsg('RBA_90_01_05_01_101','점수')}",
                color: '#ffaa66'
            }]
        });
	}

    $(document).ready(function(){
    	 chart();
	 	//DevExpress.viz.currentTheme("generic.light");
    });
</script>
</head>
<body>
        <div id="chart"></div>
</body>
</html>
