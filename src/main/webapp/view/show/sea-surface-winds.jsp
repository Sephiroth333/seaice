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
<script>
function load_data(url,imgid){
	$.ajax({
		type:"get",			
		url:"querydata?"+url,
		dataType:"json",
		success: function(data){
			if(imgid==1){
				 $("#data1").val("id="+data.dataid+"&");
				 $("#img1").attr('src',data.img);
				 $("#img1").attr('title',data.imgtitle);
				 $("#down1").attr('href','download?id='+data.dataid+'&iu=${user!=null?user.getUserid():0}');
			}
		}
	});
}

function play1(){
	load_data($("#data1").val()+"dtid2=11&opt=1",1)
}
$(document).ready(function() {
	/*
	var url1="dtid2=11&opt=";
	load_data(url1+"0",1);
	$("#prev1").click(function(){load_data($("#data1").val()+url1+"-1",1);});
	$("#next1").click(function(){load_data($("#data1").val()+url1+"1",1);});
	$("#play1").click(function(){ $("#play1").hide(); $("#pause1").show(); play1(); int1=setInterval('play1()',3000); });
	$("#pause1").click(function(){ clearInterval(int1); $("#pause1").hide(); $("#play1").show(); });
	*/
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
                <dt>Ocean</dt>
                <dd>
                    <ul>
                    <li><cite></cite><a href="temperature">Sea surface temperature</a></li>
                    <li class="selected"><cite></cite><a href="winds">Sea surface winds</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->
         <!-- 
        <div class="main">
		<h1>MODIS</h1>
		<div class="">
		  <div class="dataImg">
		    <div><img src="" width="450px"></div><div class="control">
		      <input type="hidden" id="data1" value=""/>
		      <span id="prev1"><img src="img/btn1.jpg" alt="prev"></span>
		      <span id="play1"><img src="img/btn3.jpg" alt="play"></span>
		      <span id="pause1" class="dn"><img src="img/btn4.jpg" alt="pause"></span>
		      <span id="next1"><img src="img/btn2.jpg" alt="next"></span>
		      <a id="down1" href=""><img src="img/btn5.jpg" alt="Download"></a>
		    </div>
		  </div>
		 
		  <div class="dataImg ml20">
		    <div><img src="data/MODIS_20170704_MPF_PS.png" width="450px"></div>
		    <div class="mt15">The polar regions, including the Arctic and Antarctic, are changing rapidly. Our capabilities to remotely monitor the state of the polar regions are increasing greatly. Satellite and airborne technologies have been deployed and further improvements are underway. </div>
		    <div class="control">
		      <span id="prev2"><img src="img/btn1.jpg" alt="prev"></span>
		      <span id="play2"><img src="img/btn3.jpg" alt="play"></span>
		      <span id="pause2" class="dn"><img src="img/btn4.jpg" alt="pause"></span>
		      <span id="next2"><img src="img/btn2.jpg" alt="next"></span>
		      <a id="down2" href="data/SSMIS_20170714_SIC_PS.nc"><img src="img/btn5.jpg" alt="Download"></a>
		    </div>
		  </div>
		   
		</div>
		<div class="cl"></div>
		<div class="mt20">This data set is generated from Ice Surface Temperature of MODIS Sea Ice Extent 5-Min L2 Swath (MOD29) product using a non-parameterized global threshold method. The binary sea ice leads distribution map and sea ice leads fraction map are provided daily from 1 January to 30 April during 2003 to present with 1km and 25km spatial resolution respectively.<br />
		How to cite: Not decided
		</div>
        </div>
        -->
        <div class="main">
			<h1>To be announced</h1>
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