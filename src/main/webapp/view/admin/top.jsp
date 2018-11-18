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
<script type="text/javascript">
$(function(){
	//顶部导航切换
	$(document).ready(function(){
		$(".nav li a").each(function(){
			if($(this).attr("id")==$("#TagID").val()){
				$(this).attr("target","rightFrame");
				$(this).attr("href","index?id="+$(this).attr("id"));
			}else{
				$(this).attr("target","_parent");
				$(this).attr("href","main?id="+$(this).attr("id"));
			}
		});
	});
})
</script>
</head>
<body style="background:url(../images/topbg.gif) repeat-x;">
	<div><input type="hidden" id="TagID" name="TagID" value="${TagID}" /></div>
    <div class="topleft">
    <a href="main" target="_parent">
    	后台管理系统
    </a>
    </div>
    <ul class="nav">
    <li><a id="0" href="index?id=0" target="rightFrame"><img src="../images/icon01.png" title="" /><h2>数据管理</h2></a></li>
    <li><a id="1" href="main?id=1" target="_parent"><img src="../images/icon06.png" title="" /><h2>系统管理</h2></a></li>
    <li><a id="2" href="main?id=2" target="_parent"><img src="../images/icon03.png" title="" /><h2>帮助</h2></a></li>
    </ul>

    <div class="topright">
	<ul>
	<li>${serverDate}</li>
    <li>欢迎您，<c:if test="${UserType == 1 }">【管理员】</c:if><c:if test="${UserType == 2 }">【超级管理员】</c:if>
    ${UseName}</li>
    <li><a href="logout" target="_parent">退出</a></li>
    </ul>

    <!-- <div class="user">
    <span>admin</span>
    <i>消息</i>
    <b>5</b>
    </div> -->

    </div>

</body>
</html>
