<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/strutil.tld" prefix="str" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Research Center for Sea Ice</title>
<link rel="stylesheet" href="css/style.css"/>
<link rel="shortcut icon" href="img/favicon.ico"/>
<style>
	#express li
	{
	  height:30px;
	  border-bottom:dashed 1px #999;
	  line-height:30px;
	  list-style:none;
	}
	#demo
	{
	  height:300px;
	  overflow:hidden;
	  margin-top:0px;
	}
	#book_class
	{
	margin-top: 12px;
	}
	#book_class div div ul li{
	    font-size: 14px;
	}
	#book_class div div ul li a
	{
	  text-decoration:none;
	}
	#book_class div div ul li a:hover {text-decoration:underline;}
	#book_class div div ul li span{
	    float: right;
	    color: #666;
	}
</style>
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="js/layer/layer.js"></script>
<script type="text/javascript" src="js/echarts.common.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#nav>ul>li").hover(function(){$(this).children("ul").show();},function(){$(this).children("ul").hide();});
    $(".loginin").hide();
});
</script>
</head>
<body>
<div class="wrapper">

	<!-- top include-->
	<%@ include file="top.jsp" %>
	    
    <!-- 主体 -->
    <div class="container">

        <!-- 主体1 -->
        <div class="container1">
            <!-- 幻灯 -->
            <div class="slide">
              <img src="img/slide.jpg" width="595px">
            </div>
            <!-- /幻灯 -->
            <!-- 简介 -->
            <div class="intro">
              <img src="img/satelite.jpg" width="595px">
            </div>
            <!-- /简介 -->
        </div>
        <!-- /主体1 -->

        <!-- 主体2-->
        <div class="container2">
            <!-- 主体2左侧 -->
            <div class="leftc">
                <!-- 内容 -->
                <div class="content">
                  <h1>Goal</h1>
                  ${goal }
                </div>
                <!-- /内容 -->
            </div>
            <!-- /主体2左侧 -->

            <!-- 主体2右侧 -->
            <div class="rightc">
                <!-- 内容 -->
                <div class="content">
                  <h1>News</h1>
                  <div id="book_class">
                    <div id="demo">
                      <div id="demo1">
                        <ul id="express">
                        <c:forEach var="item" items="${newslist }">              
			              <li><a href="news?id=${item.getNewsid()}">${str:forEnglishSub(item.getNewstitle(),40) }</a>
			                  <span><fmt:formatDate pattern="yyyy-MM-dd" value="${item.getUpdatetime() }" /></span>
			              </li>
			            </c:forEach>
                        </ul>
                      </div>
                      <script> 
						function autoScroll(obj){  
							$(obj).find("ul").animate({  
								marginTop : "-30px"  
							}, 500, function(){  
								$(this).css({marginTop : "0px"}).find("li:first").appendTo(this);  
							})  
						}  
						$(function(){
							if($("#express li").length>10){
								setInterval('autoScroll("#demo1")',3000);
							}
						}) 
						</script>
                      <div id="demo2"></div>
                    </div>
                  </div>
                  <div class="moreWrap clearfix">
                      <a href="newslist" class="more">more &gt;&gt;</a>
                  </div>
                </div>
                <!-- /内容 -->
            </div>
            <!-- /主体2右侧 -->
        </div>
        <!-- /主体2 -->

        <!-- 主体3-->
        <div class="container3">
            <!-- 主体3左侧 -->
            <div class="leftc">
                <div class="content">
                  <h1>Group Member</h1>
                  <c:forEach var="item" items="${grouplist }">              
		              <p><a href="member?id=${item.getPid()}">${item.getPname()}</a><c:if test="${item.getPtitle() != null && !item.getPtitle().isEmpty()}">(${item.getPtitle()})</c:if></p>
		            </c:forEach>
		            <div class="moreWrap clearfix">
                      <a href="grouplist" class="more mgt0">more &gt;&gt;</a>
                  </div>
                </div>
            </div>
            <!-- /主体3左侧 -->

            <!-- 主体3右侧 -->
            <div class="rightc">
              <div class="content"><img src="img/heying.jpg" width="360px"></div>
            </div>
            <!-- /主体3右侧 -->
        </div>
        <!-- /主体3 -->

        <!-- 主体4-->
        <div class="container4 tac clearfix">
            <div id="rightCh" class=" rt" style="width: 500px;height:400px;"></div>
            <div class="lt" style="position:relative;">
                <div id="leftCh" style="width: 700px;height:400px;"></div>
                <select name="year" id="year" class="selectCh">
                	<c:forEach begin="<%=new Date().getYear()+1900-5%>" end="<%=new Date().getYear()+1900 %>" step="1" var="ii">
                	 <option value="${ii}">${ii}</option>
                	</c:forEach>
                </select>
            </div>
        </div>
        <!-- /主体4 -->

    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">
    <img style="vertical-align:middle;" src="img/logo33.png" alt="&copy; 2017 Joint Center for Global Change and China Green Development">
	<label style="font-size: 20px">教育部极地环境与气候变化前沿科学中心</label>
    </div>
    <!-- /底部 -->
</div>


<script type="text/javascript">
function setleftCh(year){
	$.ajax({
		type:"get",			
		url:"countByYear?year="+year,
		dataType:"json",
		success: function(data){
			var myChart = echarts.init(document.getElementById('leftCh'));
			var option = {
			    title: {
			        text: 'Data Download'
			    },
			    color: ['#3398DB'],
			    tooltip: {},
			    legend: {
			        data:['Download']
			    },
			    xAxis: {
			        data: ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
			    },
			    yAxis: {
			    	name:'Number of files',
			    	nameLocation:'middle',
			    	nameGap:30
			    },
			    series: [{
			        name: 'Download',
			        type: 'bar',
			        barWidth: '40%',
			        data: data
			    }]
			};
			myChart.setOption(option);
		}
	});
}
function setrightCh(){
	$.ajax({
		type:"get",			
		url:"countByCountry",
		dataType:"json",
		success: function(data){
			var myChart1 = echarts.init(document.getElementById('rightCh'));
			var data1=[];
			var data2=[];
			$.each(data,function(idx,obj){
				data1.push(obj.countryName);
				var item={
						value:obj.dlCount,
						name:obj.countryName
					};
				data2.push(item);
			});
			option = {
			    title : {
			        text: 'Download Area Distribution',
			        x:'center'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        left: 'left',
			        data: data1
			    },
			    series : [
			        {
			            name: 'Download Area',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:data2,
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};
			myChart1.setOption(option);
		}
	});
}

$(document).ready(function(){
	
  $('#year').change(function () {
	  setleftCh($(this).val());
  });
  $('#year').val(new Date().getFullYear());
  setleftCh(new Date().getFullYear());
  setrightCh();
});

</script>
</body>
</html>
	    