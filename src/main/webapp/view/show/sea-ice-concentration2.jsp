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
	
	var downloadlink='download?iu=${user!=null?user.getUserid():0}&id=';
	
	var arrID1=new Array();
	
	for(var i in )
	
	
	var arrID2=new Array();
	var arrID3=new Array();
	var arrID4=new Array();
	
	var url1="dtid2=1&opt=";
	var url2="dtid2=2&opt=";
	var url3="dtid2=3&opt=";
	var url4="dtid2=4&opt=";
	
	load_data(url1+"0",1);
	load_data(url2+"0",2);
	load_data(url3+"0",3);
	load_data(url4+"0",4);
	
	$("#prev1").click(function(){load_data($("#data1").val()+url1+"-1",1);});
	$("#next1").click(function(){load_data($("#data1").val()+url1+"1",1);});
	$("#play1").click(function(){ $("#play1").hide(); $("#pause1").show(); play1(); int1=setInterval('play1()',1000); });
	$("#pause1").click(function(){ clearInterval(int1); $("#pause1").hide(); $("#play1").show(); });
	
	$("#prev2").click(function(){load_data($("#data2").val()+url2+"-1",2);});
	$("#next2").click(function(){load_data($("#data2").val()+url2+"1",2);});	
	$("#play2").click(function(){ $("#play2").hide(); $("#pause2").show(); play2(); int2=setInterval('play2()',1000); });
	$("#pause2").click(function(){ clearInterval(int2); $("#pause2").hide(); $("#play2").show(); });
	
	$("#prev3").click(function(){load_data($("#data3").val()+url3+"-1",3);});
	$("#next3").click(function(){load_data($("#data3").val()+url3+"1",3);});
	$("#play3").click(function(){ $("#play3").hide(); $("#pause3").show(); play3(); int3=setInterval('play3()',1000); });
	$("#pause3").click(function(){ clearInterval(int3); $("#pause3").hide(); $("#play3").show(); });
	
	$("#prev4").click(function(){load_data($("#data4").val()+url4+"-1",4);});
	$("#next4").click(function(){load_data($("#data4").val()+url4+"1",4);});	
	$("#play4").click(function(){ $("#play4").hide(); $("#pause4").show(); play4(); int4=setInterval('play4()',1000); });
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
                    <li><a href="concentration">&middot; Sea Ice Concentration</a></li>
                    <li><a href="thickness">&middot; Sea Ice Thickness</a></li>
                    <li><a href="meltponds">&middot; Melt Ponds</a></li>
                    <li><a href="leads">&middot; Sea Ice Leads</a></li>
                    <li><a href="drift">&middot; Sea Ice Drift</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->
        <div class="main">
		<h1>SSMIS</h1>
		<div class="">
		  <div class="dataImg">
		    <div><c:forEach var="item" items="${imglist1}" varStatus="status">
		    	<img id="img1_${status.index +1}" src="${item.getImg() }" title="${item.getImgtitle() }" width="450px" />
		    	<input type="hidden" id="data1" value=""/>
		    </c:forEach></div>
		    <div class="control">		      
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
		<div class="mt20">The daily Arctic sea ice concentration is obtained from the National Snow and Ice Data Center, which is derived from the Special Sensor Microwave Imager/Sounder (SSMIS), processed by the bootstrap algorithm (Comiso 2000). Here sea ice concentration is remapped on 12.5 km EASE grid. </div>
		<div class="mt20">How to cite: Spreen, G., L. Kaleschke, and G.Heygster (2008), Sea ice remote sensing using AMSR-E 89 GHz channels . J. Geophys. Res., vol. 113, C02S03, doi: 10.1029/2005JC003384.
		</div>
		<div class="sic-line"></div>
		<h1>AMSR-2</h1>
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
		<div class="mt20">The polar regions, including the Arctic and Antarctic, are changing rapidly. Our capabilities to remotely monitor the state of the polar regions are increasing greatly. Satellite and airborne technologies have been deployed and further improvements are underway. </div>
		<div class="mt20">This date set is generated from Advanced Microwave Scanning Radiometer Earth Observing System (AMSRE) - Advanced Microwave Scanning Radiometer 2 (AMSR2) brightness temperature data using ARTIST sea ice (ASI) algorithm. The data derived from AMSRE and AMSR2 are provided daily from 1 June 2002 to 4 October 2011 and 2 July 2012 to present, respectively, with 6.25km spatial resolution.<br />
		How to cite: Spreen, G., L. Kaleschke, and G.Heygster (2008), Sea ice remote sensing using AMSR-E 89 GHz channels . J. Geophys. Res., vol. 113, C02S03, doi: 10.1029/2005JC003384.
		</div>
        </div>
        <!--/主体2-->
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Jointobal  Center for GlChange and China Green Development</div>
    <!-- /底部 -->
</div>
</body>
</html>