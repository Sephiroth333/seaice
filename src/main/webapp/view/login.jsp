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
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7;IE=Edge;chrome=1" />
<title>欢迎登录后台管理系统</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="js/jquery-1.11.1.min.js"></script>
<script src="js/cloud.js" type="text/javascript"></script>
<script src="js/layer.js" type="text/javascript"></script>
<script language="javascript">
	$(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	$(window).resize(function(){  
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    });
});  
</script> 
<script language="JavaScript"> 
	if (window != top) 
	top.location.href = location.href; 
</script>
<script>
	$(document).ready(function(){
		$("#sub").click(function(){
			login();
		});
		function login(){
			var flag = true;
			var admin = $("input[name='adminName']").val();
			var pwd = $("input[name='adminPwd']").val();
			var code = $("input[name='code']").val();
			if(admin == ""){
				layer.alert('请填写用户名！', {
					icon: 2,
				});
				flag = false;
				return;
			}
			if(pwd == ""){
				layer.alert('请填写密码！', {
					icon: 2,
				});
				flag = false;
				return;
			}
			if(code == ""){
				layer.alert('请填写验证码！', {
					icon: 2,
				});
				flag = false;
				return;
			}
			if(flag){
				$("#login_form").submit();
			}
		}
	});
	//刷新验证码
    function changeImg(){
        document.getElementById("validateCodeImg").src="DrawImageServlet?"+Math.random();
    }
	</script>
	
</head>

<body style="background-color:#1c77ac; background-image:url(images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
    <div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>  

<div class="logintop"> 
    <span>欢迎登录后台管理界面平台</span> 
    <div id="switch" style="float:right;margin-right:50px;margin-top:5px;">
	</div>    
    </div>
    
    <div class="loginbody">
    
    <span class="systemlogo"></span> 
       
    <div class="loginbox">
    	${msg }
    <form id="login_form" action="admin/tologin" method="post">
    <ul>
    <li><input name="adminName" type="text" class="loginuser" value="${adminName == null?'':adminName}" placeholder="用户名" maxlength="16" style="font-size:10px;font-family:微软雅黑;font-weight: 500;" onclick="JavaScript:this.value=''"/></li>
    <li><input name="adminPwd" type="password" class="loginpwd" value="${adminPwd == null?'':adminPwd}" placeholder="密码" maxlength="16" style="font-size:10px;font-family:微软雅黑;font-weight: 500;" onclick="JavaScript:this.value=''"/></li>
    <li><table><tr><td><input name="code" type="text" value="${code == null?'':code }" class="logincode" placeholder="验证码" maxlength="4" style="font-size:10px;font-family:微软雅黑;font-weight: 500;" onclick="JavaScript:this.value=''"/></td><td><label><img alt="验证码看不清，换一张" src="DrawImageServlet" id="validateCodeImg" onclick="changeImg()" /></label></td></tr></table></li>
    <li><input id="sub"  type="button" class="loginbtn" value="登录" />
    </ul>
    </form>
    
    </div>
    
    </div>
    
    
    
    <div class="loginbm"> 版权所有   2016 <b>诺滨科技有限公司</b> <a href="javascript:void(0);"></a></div>
	
</body>
</html>
