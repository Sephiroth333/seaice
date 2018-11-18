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
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active")
		$(this).addClass("active");
	});

	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
})
</script>


</head>

<body style="background:#f0f9fd;">
	<div class="lefttop"><span></span>数据管理平台</div>
    <dl class="leftmenu">
    	<c:forEach var="menufather" items="${leftmenulist }">
			<dd>
			    <div class="title">
			    <span><img src="${menufather.getImgUrl()}" width="15"/></span>${menufather.getMenutitle() }
			    </div>
		    	<ul class="menuson" style="display:none;">
		    		<c:forEach var="menuson" items="${menufather.getMenusonlist() }">
				        <li><cite></cite><a href="${menuson.getDturl() }" target="rightFrame">${menuson.getDtnameson() }</a><i></i></li>
					</c:forEach>
		        </ul>
		    </dd>
		</c:forEach>
    </dl>
</body>
</html>
