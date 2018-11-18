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
			}else if(imgid==2){
				 $("#data2").val("id="+data.dataindex+"&");
				 $("#img2").attr('src',data.img);
				 $("#img2").attr('title',data.imgtitle);
				 $("#down2").attr('href','download?id='+data.dataid+'&iu=${user!=null?user.getUserid():0}');
			}else if(imgid==3){
				 $("#data3").val("id="+data.dataindex+"&");
				 $("#img3").attr('src',data.img);
				 $("#img3").attr('title',data.imgtitle);
				 $("#down3").attr('href','download?id='+data.dataid+'&iu=${user!=null?user.getUserid():0}');
			}else{
				 $("#data4").val("id="+data.dataindex+"&");
				 $("#img4").attr('src',data.img);
				 $("#img4").attr('title',data.imgtitle);
				 $("#down4").attr('href','download?id='+data.dataid+'&iu=${user!=null?user.getUserid():0}');
			}
		}
	});
}

function play1(){
	load_data($("#data1").val()+"dtid2=1&opt=1",1)
}
function play2(){
	load_data($("#data2").val()+"dtid2=2&opt=1",2)
}
function play3(){
	load_data($("#data3").val()+"dtid2=3&opt=1",3)
}
function play4(){
	load_data($("#data4").val()+"dtid2=4&opt=1",4)
}
$(document).ready(function() {
	
	var url1="dtid2=1&opt=";
	var url2="dtid2=2&opt=";
	var url3="dtid2=3&opt=";
	var url4="dtid2=4&opt=";
	var timeInterval=1500;
	
	load_data(url1+"0",1);
	load_data(url2+"0",2);
	load_data(url3+"0",3);
	load_data(url4+"0",4);
	
	$("#prev1").click(function(){load_data($("#data1").val()+url1+"-1",1);});
	$("#next1").click(function(){load_data($("#data1").val()+url1+"1",1);});
	$("#play1").click(function(){ $("#play1").hide(); $("#pause1").show(); play1(); int1=setInterval('play1()',timeInterval); });
	$("#pause1").click(function(){ clearInterval(int1); $("#pause1").hide(); $("#play1").show(); });
	
	$("#prev2").click(function(){load_data($("#data2").val()+url2+"-1",2);});
	$("#next2").click(function(){load_data($("#data2").val()+url2+"1",2);});	
	$("#play2").click(function(){ $("#play2").hide(); $("#pause2").show(); play2(); int2=setInterval('play2()',timeInterval); });
	$("#pause2").click(function(){ clearInterval(int2); $("#pause2").hide(); $("#play2").show(); });
	
	$("#prev3").click(function(){load_data($("#data3").val()+url3+"-1",3);});
	$("#next3").click(function(){load_data($("#data3").val()+url3+"1",3);});
	$("#play3").click(function(){ $("#play3").hide(); $("#pause3").show(); play3(); int3=setInterval('play3()',timeInterval); });
	$("#pause3").click(function(){ clearInterval(int3); $("#pause3").hide(); $("#play3").show(); });
	
	$("#prev4").click(function(){load_data($("#data4").val()+url4+"-1",4);});
	$("#next4").click(function(){load_data($("#data4").val()+url4+"1",4);});	
	$("#play4").click(function(){ $("#play4").hide(); $("#pause4").show(); play4(); int4=setInterval('play4()',timeInterval); });
	$("#pause4").click(function(){ clearInterval(int4); $("#pause4").hide(); $("#play4").show(); });
	
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
                <dt>Sea Ice</dt>
                <dd>
                    <ul>
                    <li class="selected"><cite></cite><a href="concentration">Sea Ice Concentration</a></li>
                    <li><cite></cite><a href="thickness">Sea Ice Thickness</a></li>
                    <li><cite></cite><a href="meltponds">Melt Ponds</a></li>
                    <li><cite></cite><a href="leads">Sea Ice Leads</a></li>
                    <li><cite></cite><a href="drift">Sea Ice Drift</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->
        <div class="main">
		<h1>Special Sensor Microwave Imager/Sounder (SSMIS)</h1>
		<div class="">
		  <div class="dataImg">
		    <div><img id="img1" src="" width="450px"></div>
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
		<div class="mt20">The daily sea ice concentration is obtained from the National Snow and Ice Data Center. It is derived from the Special Sensor Microwave Imager/Sounder (SSMIS) V-pol and H-pol 19.3 GHz and V-pol 37Hz brightness temperature using the NASA team sea ice algorithm (http://nsidc.org/data/nsidc-0051). Here we provide sea ice concentration in 6.25 km Polar Stereographic and EASE-Grid2.0 projection.</div>
		<div class="mt20">Key reference: Cavalieri, D. J., C. L. Parkinson, P. Gloersen, and H. J. Zwally. 1996, updated yearly. Sea Ice Concentrations from Nimbus-7 SMMR and DMSP SSM/I-SSMIS Passive Microwave Data, Version 1. [Indicate subset used]. Boulder, Colorado USA. NASA National Snow and Ice Data Center Distributed Active Archive Center. dx.doi.org/10.5067/8GQ8LZQVL0VL. [Date Accessed].</div>
		<div class="sic-line"></div>
		<h1>Advanced Microwave Scanning Radiometer 2 (AMSR2)</h1>
		<div>
		  <div class="dataImg">
		    <div><img id="img3" src="" width="450px"></div>
		    <div class="control">
		      <input type="hidden" id="data3" value=""/>
		      <span id="prev3"><img src="img/btn1.jpg" alt="prev"></span>
		      <span id="play3"><img src="img/btn3.jpg" alt="play"></span>
		      <span id="pause3" class="dn"><img src="img/btn4.jpg" alt="pause"></span>
		      <span id="next3"><img src="img/btn2.jpg" alt="next"></span>
		      <a id="down3" href=""><img src="img/btn5.jpg" alt="Download"></a>
		    </div>
		  </div>
		  <div class="dataImg ml20">
		    <div><img id="img4" src="" width="450px"></div>
		    <div class="control">
		      <input type="hidden" id="data4" value=""/>
		      <span id="prev4"><img src="img/btn1.jpg" alt="prev"></span>
		      <span id="play4"><img src="img/btn3.jpg" alt="play"></span>
		      <span id="pause4" class="dn"><img src="img/btn4.jpg" alt="pause"></span>
		      <span id="next4"><img src="img/btn2.jpg" alt="next"></span>
		      <a id="down4" href=""><img src="img/btn5.jpg" alt="Download"></a>
		    </div>
		  </div>
		</div>
		<div class="cl"></div>
		<div class="mt20">The daily sea ice concentration is obtained from the University of Bremen. It is derived from the Advanced Microwave Scanning Radiometer 2 (AMSR2) V-pol and H-pol 18.7, 23.8, 36.5 and 89 GHz brightness temperature using ASI sea ice algorithm (https://seaice.uni-bremen.de/sea-ice-concentration/ ). Here we provide sea ice concentration in 6.25 km Polar Stereographic and EASE-Grid2.0 projection.
		</div>
		<div class="mt20">Key reference: Spreen, G., L. Kaleschke, and G.Heygster(2008), Sea ice remote sensing using AMSR-E 89 GHz channels J. Geophys. Res., 113, C02S03, doi:10.1029/2005JC003384.
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