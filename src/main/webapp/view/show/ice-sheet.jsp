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
<script src="lib/jquery-ui-1.12.1/external/jquery/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#nav>ul>li").hover(function(){$(this).children("ul").show();},function(){$(this).children("ul").hide();});
});
</script>
</head>
<body>
<div class="wrapper">

    <!-- top include-->
	<%@ include file="top.jsp" %>
	
    <!-- 主体 -->
    <div class="container">
        <!--边栏-->
        <div class="sidebar">
            <dl class="side-nav">
                <dt>Ice Sheet</dt>
                <dd>
                    <ul>
                    <li><cite></cite><a href="velocity">Ice Velocity</a></li>
                    <li class="selected"><cite></cite><a href="icesheet">Ice Sheet Balance</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->
        <div class="main">
			<h1>Ice Sheet Balance</h1>
			<img src="upload/IceSheet MassBalance-Antarctic-PNAS-YanLiu.png" height="400px">
			<img src="upload/IceSheet MassBalance-Greenland-RoPiP-Khan.png" height="400px" style="margin-left:80px;">
			<div class="cl"></div>
			<div class="mt20">The Antarctica and Greenland ice sheet balance are obtained from Liu et. al. and Khan et. al. published article. The Antarctic ice sheet balance is derived from 2005 and 2011 Envisat Advanced Synthetic Aperture Radar (ASAR) images using a direct empirical estimate method and the Greenland ice sheet balance is integrated from the ice velocity which is derived from 2000 and 2005 RADARSAT-1 synthetic aperture radar data.
			</div>
			<div class="mt20">Key reference: Liu, Y., Moore, J. C., Cheng, X., Gladstone, R. M., Bassis, J. N., & Liu, H., et al. (2015). Ocean-driven thinning enhances iceberg calvingand retreat of antarctic ice shelves. Science Foundation in China, 112(3), 3263.
				<br />
				Khan, S. A., Aschwanden, A., Bjørk, A. A., Wahr, J., Kjeldsen, K. K., & Kjær, K. H. (2015). Greenland ice sheet mass balance: a review. Reports on Progress in Physics Physical Society, 78(4), 046801.
			</div>
      </div>
        <!--/主体2-->
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /底部 -->
</div>
</body>
</html>