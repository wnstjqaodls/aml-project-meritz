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
            name    : ''
                ,count   :5
                ,active  : true
             },{
                 name    : ''
                ,count   :5
                ,active  : true
             },{
                 name    : ''
                ,count   :5
                ,active  : true
             },{
                 name    : ''
                ,count   :5
                ,active  : true
             },{
                 name    : ''
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
                "month" : "1월"
               ,"1"   : 0
               ,"2"   : 0
               ,"3"   : 0
               ,"4"   : 0
               ,"5"   : 0
            },{
                "month" : "2월"
               	,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                 "month" : "3월"
                 ,"1"   : 0
                 ,"2"   : 0
                 ,"3"   : 0
                 ,"4"   : 0
                 ,"5"   : 0
            },{
                "month" : "4월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                "month" : "5월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                "month" : "6월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                "month" : "7월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                "month" : "8월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                "month" : "9월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                "month" : "10월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                "month" : "11월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
            },{
                "month" : "12월"
                ,"1"   : 0
                ,"2"   : 0
                ,"3"   : 0
                ,"4"   : 0
                ,"5"   : 0
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
                "valueField": "1", "name": "Rank 1" 
            },{ "valueField": "2", "name": "Rank 2" 
            },{ "valueField": "3", "name": "Rank 3" 
            },{ "valueField": "4", "name": "Rank 4" 
            },{ "valueField": "5", "name": "Rank 5" 
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