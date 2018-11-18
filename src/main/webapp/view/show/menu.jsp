<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<title>Research Center for Sea Ice</title>
<link rel="stylesheet" href="css/style.css"/>
<link rel="shortcut icon" href="img/favicon.ico"/>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>

    <script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
    <!-- 这里要配置参数key,将其值设置为高德官网开发者获取的key -->
    <script src="http://webapi.amap.com/maps?v=1.3&key=9b2c5c13a6501227c97613b559324a12"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#nav>ul>li").hover(function(){$(this).children("ul").show();},function(){$(this).children("ul").hide();});
});
</script>
    <style type="text/css">
        #container{
            margin-left:150px;
            margin-top:210px;
            width:800px;
            height:400px;
        }
    </style>
</head>
<body>
<div class="wrapper">

    <!-- top include-->
	<%@ include file="top.jsp" %>
	
    <!-- /主体 -->
    <div class="container">
    <div class="main2" >
    <p>${menu.getMenucontent()}</p>
    </div>
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /底部 -->
</div>

<script>
    //创建地图,设定地图的中心点和级别
    var map = new AMap.Map('container', {
        resizeEnable: true,
        zoom:18,
        center: [116.365347,39.957519]

    });

    /*  AMap.plugin(['AMap.ToolBar','AMap.Scale'],function(){
     //TODO  创建控件并添加
     alert("dddd");
     }) */
    //信息窗体的创建与设定
    var infowindow = new AMap.InfoWindow({
        offset: new AMap.Pixel(0, -30),
        size:new AMap.Size(230,0)
    });
    //点标记的创建与添加
    var marker = new AMap.Marker({
        position: [116.365347,39.957519],
        map:map
    });

</script>
</body>
</html>