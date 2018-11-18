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
    <script src="http://webapi.amap.com/maps?v=1.3&key=9b2c5c13a6501227c97613b559324a12"></script>
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
    <div class="contain"  id="container">
    <div class="main2">
    <h1>Contact</h1>
    <p>The polar regions, including the Arctic and Antarctic, are changing rapidly. Our capabilities to remotely monitor the state of the polar regions are increasing greatly. Satellite and airborne technologies have been deployed and further improvements are underway. Meanwhile, algorithms have been developed to retrieve important parameters and further improvements are underway to maximize the effectiveness of available remote sensing data. These technologies and algorithms promise to greatly increase our understanding of variations in sea ice, ocean and ice sheet. However, so much information is scattered out there. It is challenging to find exactly what you are looking for by just Googling it. A group of scientists from Beijing Normal University and University at Albany developed this web site as a "one-stop shop" for the current state of Polar sea ice, ocean and ice sheet. This website provides real-time (or near real-time) key parameters derived from a variety of operational satellites in an understandable, accessible and credible way. To achieve this, we remap and reprocess currently well-calibrated parameters, and/or improve and develop algorithms to retrieve new parameters. The image and data provided here delivers information for decision-making communities and supports polar predictions.</p>
    </div>
    </div>
    <!-- /ä¸»ä½ -->
    <!-- åºé¨ -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /åºé¨ -->
</div>


</body>
</html>