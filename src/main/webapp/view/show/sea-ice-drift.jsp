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
			}
		}
	});
}

function play1(){
	load_data($("#data1").val()+"dtid2=13&opt=1",1)
}
$(document).ready(function() {

	var url1="dtid2=13&opt=";
	load_data(url1+"0",1);
	$("#prev1").click(function(){load_data($("#data1").val()+url1+"-1",1);});
	$("#next1").click(function(){load_data($("#data1").val()+url1+"1",1);});
	$("#play1").click(function(){ $("#play1").hide(); $("#pause1").show(); play1(); int1=setInterval('play1()',3000); });
	$("#pause1").click(function(){ clearInterval(int1); $("#pause1").hide(); $("#play1").show(); });

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
                    <li><cite></cite><a href="thickness">Sea Ice Thickness</a></li>
                    <li><cite></cite><a href="meltponds">Melt Ponds</a></li>
                    <li><cite></cite><a href="leads">Sea Ice Leads</a></li>
                    <li class="selected"><cite></cite><a href="drift">Sea Ice Drift</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->

		<div class="main">
			<h1>Extent</h1>
			<div class="dataImg">
				<div class="dataImg mlauto" style="float:none;">
					<div><img id="img1"  src="" width="450px"></div><div class="control">
					<input type="hidden" id="data1" value=""/>
					<span id="prev1"><img src="img/btn1.jpg" alt="prev"></span>
					<span id="play1"><img src="img/btn3.jpg" alt="play"></span>
					<span id="pause1" class="dn"><img src="img/btn4.jpg" alt="pause"></span>
					<span id="next1"><img src="img/btn2.jpg" alt="next"></span>
					<a id="down1" href=""><img src="img/btn5.jpg" alt="Download"></a>
				</div>
				</div>
			</div>
			<div class="dataImg ">
				<div class="dataImg mlauto" style="float:none;">
					<div><img id="img2"  src="img/graph.png" width="450px"></div>
				</div>
			</div>
			<div class="cl"></div>
			<div class="mt20">The perennial average of sea ice extent and decreased/increased sea ice are produced by Beijing Normal University PRSDC team. They are derived from Sea Ice Concentration obtained from the National Snow and Ice Data Center. It is derived from the Special Sensor Microwave Imager/Sounder (SSMIS) and Special Sensor Microwave(SSM). The daily sea ice concentration of 2018 is obtained from the University of Bremen. It is derived from the Advanced Microwave Scanning Radiometer 2 (AMSR2) V-pol and H-pol 18.7, 23.8, 36.5 and 89 GHz brightness temperature using ASI sea ice algorithm (https://seaice.uni-bremen.de/sea-ice-concentration/ ). The sea ice concentration before 2018 is Key reference: Spreen, G., L. Kaleschke, and G.Heygster (2008), Sea ice remote sensing using AMSR-E 89 GHz channels J. Geophys. Res.,vol. 113, C02S03, doi:10.1029/2005JC003384.
				Fetterer, F., K. Knowles, W. Meier, M. Savoie, and A. K. Windnagel. 2017, updated daily. Sea Ice Index, Version 3. [Indicate subset used]. Boulder, Colorado USA. NSIDC: National Snow and Ice Data Center. doi: https://doi.org/10.7265/N5K072F8. [Date Accessed].

			</div>

		</div>

        <%--<div class="main">--%>
			<%--<h1>To be announced</h1>--%>
		<%--</div>--%>
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