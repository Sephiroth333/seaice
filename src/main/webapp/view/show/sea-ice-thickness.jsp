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
<script src="js/jquery-ui-1.12.1/jquery.js"></script>
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
	load_data($("#data1").val()+"dtid2=5&opt=1",1)
}
function play2(){
	load_data($("#data2").val()+"dtid2=6&opt=1",2)
}
$(document).ready(function() {
	
	var url1="dtid2=5&opt=";
	//var url2="dtid2=6&opt=";
	var timeInterval=1500;
	load_data(url1+"0",1);
	//load_data(url2+"0",2);
	$("#prev1").click(function(){load_data($("#data1").val()+url1+"-1",1);});
	$("#next1").click(function(){load_data($("#data1").val()+url1+"1",1);});
	//$("#prev2").click(function(){load_data($("#data2").val()+url2+"-1",2);});
	//$("#next2").click(function(){load_data($("#data2").val()+url2+"1",2);});
	$("#play1").click(function(){ $("#play1").hide(); $("#pause1").show(); play1(); int1=setInterval('play1()',timeInterval); });
	$("#pause1").click(function(){ clearInterval(int1); $("#pause1").hide(); $("#play1").show(); });
	//$("#play2").click(function(){ $("#play2").hide(); $("#pause2").show(); play2(); int2=setInterval('play2()',timeInterval); });
	//$("#pause2").click(function(){ clearInterval(int2); $("#pause2").hide(); $("#play2").show(); });
	
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
                    <li><cite></cite><a href="concentration">Sea Ice Concentration</a></li>
                    <li  class="selected"><cite></cite><a href="thickness">Sea Ice Thickness</a></li>
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
		<h1>Soil Moisture Ocean Salinity (SMOS)</h1>
		<div class="">
		  <div class="dataImg mlauto" style="float:none;">
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
		  <div class="cl"></div>
		  <div class="mt20">The daily Arctic sea ice thickness is obtained from the Integrated Climate Data Center, University of Hamburg. It is derived from the Soil Moisture Ocean Salinity (SMOS) payload Microwave Imaging Radiometer with Aperture Synthesis (MIRAS) 1.4GHz L3 brightness temperature, using a single layer emissivity model (https://seaice.uni-bremen.de/thin-ice-thickness/ ). Here we provide sea ice thickness in 6.25 km Polar Stereographic and EASE-Grid2.0 projection.
		  </div>
		  <div class="mt20">Key reference: Huntemann, M., Heygster, G., Kaleschke, L., Krumpen, T., Mäkynen, M., & Drusch, M. (2013). Empirical sea ice thickness retrieval during the freeze-up period from smos high incident angle observations. Cryosphere Discussions, 7(4), 4379-4405.
		  </div>
	   </div>
	   <h1>CryoSat2</h1>
	   <div>	   	  
		  <div class="dataImg mlauto" style="float:none;">
		    <div><img id="img2" src="upload/N_CryoSat2_20110304_IceThickness_PS.png" width="450px"></div>
		    <div class="control">
		      <input type="hidden" id="data2" value=""/>
		      <span id="prev2"><img src="img/btn1.jpg" alt="prev"></span>
		      <span id="play2"><img src="img/btn3.jpg" alt="play"></span>
		      <span id="pause2" class="dn"><img src="img/btn4.jpg" alt="pause"></span>
		      <span id="next2"><img src="img/btn2.jpg" alt="next"></span>
		      <a id="down2" href="javascrpit:;"><img src="img/btn5.jpg" alt="Download"></a>
		    </div>
		  </div>
		</div>
		 <div class="cl"></div>
		 <div class="mt20">The quarterly Arctic sea ice thickness is obtained from the Centre for Polar Observation and Modelling, University College of London. It is derived from CryoSat-2 payload SAR/Interferometric Radar Altimeters(SIRAL) (http://www.cpom.ucl.ac.uk/csopr/seaice.html). Here we provide sea ice thickness in 6.25 km Polar Stereographic and EASE-Grid2.0 projection.
		  </div>
		  <div class="mt20">Key reference: to be announced</div>		
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