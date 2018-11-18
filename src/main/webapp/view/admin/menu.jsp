<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="../css2/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="../js/layer/layer.js"></script>
<script type="text/javascript" src="../UEditor/ueditor.config.js"></script>
<script type="text/javascript" src="../UEditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="../UEditor/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="../js/common_check.js"></script>
	<script src="http://webapi.amap.com/maps?v=1.3&key=9b2c5c13a6501227c97613b559324a12"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".btn").click(function(){
			$.ajax({
				type:"post",			
				url:"menuModify",
				data:$("#modify_form").serialize(),
				dataType:"json",
				success: function(data){
					OperateResult(data,"修改");
				}
			});
		});
	});
</script>
<style>
.forminfo li label {
    width: 86px;
    line-height: 34px;
    display: block;
    float: left;
    text-align: right;
    margin-right: 15px;
}
</style>
	<style type="text/css">
		#container{
			/*margin-left:500px;*/
			/*margin-top:50px;*/
			width:800px;
			height:500px;
		}
	</style>
</head>

<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
	<li><a href="#">栏目管理</a></li>
    <li><a href="#">${menu.getMenutitle() }管理</a></li>
    </ul>
    </div>


    <div class="formbody">
    <div class="formtitle"><span>${menu.getMenutitle() }修改</span></div>
	<form id="modify_form" action="menuModify" method="post">
	<div><input type="hidden" name="menuID" value="${menu.getMenuid()}"/>
	</div>
    <ul class="forminfo">
	    <li><label>栏目内容：</label></li>
	    <li><label>&nbsp;</label>
	    	<!-- 加载编辑器的容器 --> 
			<script id="content" name="content" type="text/plain" style="margin-left:85px;"></script>
			<script type="text/javascript">
			    var ue = UE.getEditor('content',{
			    	initialFrameWidth:1200,
			    	initialFrameHeight:300,
			    	scaleEnabled:true,
			    	maximumWords:100000,
			    	enterTag:''
			    });
			    ue.addListener("ready",function(){
			    	// editor准备好之后才可以使用
			    	ue.setContent('${menu.getMenucontent()}');
			    });
			</script>
	    </li>
	    <li><label>&nbsp;</label><input type="button" class="btn" value="确认"/></li>
    </ul>
    </form>

    </div>

<script>
	//创建地图,设定地图的中心点和级别
	var map = new AMap.Map('container', {
		resizeEnable: true,
		zoom:1,
		center: [120.2, 30.3]

	});

	/*  AMap.plugin(['AMap.ToolBar','AMap.Scale'],function(){
	 //TODO  创建控件并添加
	 alert("dddd");
	 }) */
	//信息窗体的创建与设定
	var infowindow = new AMap.InfoWindow({
		offset: new AMap.Pixel(0, -30),
		size:new AMap.Size(230,0)
	});
	//点标记的创建与添加
	var marker = new AMap.Marker({
		position: [120.2, 30.3],
		map:map
	});

</script>
</body>
</html>