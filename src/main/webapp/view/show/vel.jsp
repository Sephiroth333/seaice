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
                    <li class="selected"><cite></cite><a href="velocity">Ice Velocity</a></li>
                    <li><cite></cite><a href="icesheet">Ice Sheet Balance</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->
        <div class="main">
			<h1>Velocity</h1>
			<img src="upload/Velocity-Antarctic.png" height="400px">
			<img src="upload/Velocity-Greenland.png" height="400px">
			<div class="cl"></div>
			<div class="mt20">The Antarctic and Greenland ice velocity is obtained from the National Snow and Ice Data Center. They are both derived from assembled and mosaic multiple satellite platforms’ product using interferometry synthetic-aperture radar (InSAR)systems (https://nsidc.org/data/nsidc-0484, http://nsidc.org/data/NSIDC-0481，). 
			</div>
			<div class="mt20">Key reference: Rignot, E., J. Mouginot, and B. Scheuchl. 2017. MEaSUREs InSAR-Based Antarctica Ice Velocity Map, Version 2. [Indicate subset used]. Boulder, Colorado USA. NASA National Snow and Ice Data Center Distributed Active Archive Center. http://dx.doi.org/10.5067/D7GK8F5J8M8R. [Date Accessed].
				<br />
				Joughin, I., I. Howat, B. Smith, and T. Scambos. 2011, updated 2016. MEaSUREs Greenland Ice Velocity: Selected Glacier Site Velocity Maps from InSAR, Version 1. [Indicate subset used]. Boulder, Colorado USA. NASA National Snow and Ice Data Center Distributed Active Archive Center. doi: http://dx.doi.org/10.5067/MEASURES/CRYOSPHERE/nsidc-0481.001. [Date Accessed].
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