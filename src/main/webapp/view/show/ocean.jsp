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
    <!-- å¤´é¨ -->
    <div class="header"></div>
    <!-- /å¤´é¨ -->
    <!-- å¯¼èª -->
    <div id="nav">
        <ul>
          <li><a href="index.html">Home</a></li>
          <li>
            <a href="#">Sea Ice</a>
            <ul>
              <li><a href="sea-ice-concentration.html">Sea Ice Concentration</a></li>
              <li><a href="sea-ice-thickness.html">Sea Ice Thickness</a></li>
              <li><a href="melt-ponds.html">Melt Ponds</a></li>
              <li><a href="leads.html">LEADS</a></li>
              <li><a href="sea-ice-drift.html">Sea Ice Drift</a></li>
            </ul>
          </li>
          <li>
            <a href="ocean.html">Ocean</a>
            <ul>
              <li><a href="sea-surface-temperature.html">Sea Surface Temperature</a></li>
              <li><a href="sea-surface-winds.html">Sea Surface Winds</a></li>
            </ul>
          </li>
          <li><a href="ice-sheet.html">Ice Sheet</a></li>
          <li><a href="data">Data Archive</a></li>
          <li><a href="news.html">News</a></li>
          <li><a href="publication.html">Publication</a></li>
          <li><a href="contact.html">Contact</a></li>
        </ul>
    </div>
    <!-- /å¯¼èª -->
    <!-- /ä¸»ä½ -->
    <div class="container">
        <!--è¾¹æ -->
        <div class="sidebar">
            <dl class="side-nav">
                <dt>Ocean</dt>
                <dd>
                    <ul>
                    <li><a href="#">&middot; Sea surface temperature</a></li>
                    <li><a href="#">&middot; Sea surface winds</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/è¾¹æ -->
        <!--ä¸»ä½-->
        <div class="main">
<h1>SSMIS</h1>
<img src="data/SSMIS-1.png" width="450px">
<img src="data/SSMIS-2.png" width="450px">
<h1>AMSR-2</h1>
<img src="data/AMSR-2-1.png" width="450px">
<img src="data/AMSR-2-2.png" width="450px">
        </div>
        <!--/ä¸»ä½-->
    </div>
    <!-- /ä¸»ä½ -->
    <!-- åºé¨ -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /åºé¨ -->
</div>
</body>
</html>