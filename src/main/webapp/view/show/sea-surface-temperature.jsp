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
				 $("#data1").val("id="+data.dataindex+"&");
				 $("#img1").attr('src',data.img);
				 $("#img1").attr('title',data.imgtitle);
				 $("#down1").attr('href','download?id='+data.dataid+'&iu=${user!=null?user.getUserid():0}');
			}else{
				 $("#data2").val("id="+data.dataindex+"&");
				 $("#img2").attr('src',data.img);
				 $("#img2").attr('title',data.imgtitle);
				 $("#down2").attr('href','download?id='+data.dataid+'&iu=${user!=null?user.getUserid():0}');
			}
		}
	});
}

function play1(){
	load_data($("#data1").val()+"dtid2=11&opt=1",1)
}
function play2(){
	load_data($("#data2").val()+"dtid2=12&opt=1",2)
}
$(document).ready(function() {
	
	var url1="dtid2=11&opt=";
	var url2="dtid2=12&opt=";
	var timeInterval=1500;
	load_data(url1+"0",1);
	load_data(url2+"0",2);
	$("#prev1").click(function(){load_data($("#data1").val()+url1+"-1",1);});
	$("#next1").click(function(){load_data($("#data1").val()+url1+"1",1);});
	$("#prev2").click(function(){load_data($("#data2").val()+url2+"-1",2);});
	$("#next2").click(function(){load_data($("#data2").val()+url2+"1",2);});
	$("#play1").click(function(){ $("#play1").hide(); $("#pause1").show(); play1(); int1=setInterval('play1()',timeInterval); });
	$("#pause1").click(function(){ clearInterval(int1); $("#pause1").hide(); $("#play1").show(); });
	$("#play2").click(function(){ $("#play2").hide(); $("#pause2").show(); play2(); int2=setInterval('play2()',timeInterval); });
	$("#pause2").click(function(){ clearInterval(int2); $("#pause2").hide(); $("#play2").show(); });
	
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
                    <li class="selected"><cite></cite><a href="temperature">Sea surface temperature</a></li>
                    <li><cite></cite><a href="winds">Sea surface winds</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->
        <div class="main">
		<h1>Advanced Very High Resolution Radiometer (AVHRR)</h1>
		<div class="">
		  <div class="dataImg">
		    <div><img id="img1" src="" width="450px" /></div>
		    <div class="control">
		      <input type="hidden" id="data1" value=""/>
		      <span id="prev1"><img src="img/btn1.jpg" alt="prev"></span>
		      <span id="play1"><img src="img/btn3.jpg" alt="play"></span>
		      <span id="pause1" class="dn"><img src="img/btn4.jpg" alt="pause"></span>
		      <span id="next1"><img src="img/btn2.jpg" alt="next"></span>
		      <a id="down1" href=""><img src="img/btn5.jpg" alt="Download"></a>
		    </div>
		  </div>
		  <div class="dataImg ml20">
		    <div><img id="img2" src="" width="450px"></div>
		    <div class="control">
		      <input type="hidden" id="data2" value=""/>
		      <span id="prev2"><img src="img/btn1.jpg" alt="prev"></span>
		      <span id="play2"><img src="img/btn3.jpg" alt="play"></span>
		      <span id="pause2" class="dn"><img src="img/btn4.jpg" alt="pause"></span>
		      <span id="next2"><img src="img/btn2.jpg" alt="next"></span>
		      <a id="down2" href=""><img src="img/btn5.jpg" alt="Download"></a>
		    </div>
		  </div>
		</div>
		<div class="cl"></div>
		<div class="mt20">The daily sea surface temperature is obtained from the National Oceanic and Atmospheric Administration (NOAA) Comprehensive Large Array-Data Stewardship System (CLASS). It is derived from the Advanced Very High Resolution Radiometer (AVHRR) multiple earth emission bands using the National Environmental Satellite, Data, and Information Service (NESDIS) system (https://www.ncei.noaa.gov/thredds/catalog/OisstBase/NetCDF/AVHRR/catalog.html ). Here we provide sea surface temperature in 6.25 km Polar Stereographic and EASE-Grid2.0 projection.
		</div>
        <div class="mt20">Key reference: Reynolds, R. W., Smith, T. M., Liu, C., Chelton, D. B., Casey, K. S., & Schlax, M. G. (2010). Daily high-resolution-blended analyses for sea surface temperature. Journal of Climate, 20(22), 5473-5496.
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