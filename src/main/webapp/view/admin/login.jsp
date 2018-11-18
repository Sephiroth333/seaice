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
<title>欢迎登录后台管理系统</title>
<link href="../css2/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="../js/cloud.js" ></script>
<script type="text/javascript" src="../js/layer/layer.js" ></script>
<script type="text/javascript" >
	$(function(){
    $('.loginbox,.systemlogo').css({'position':'absolute','left':($(window).width()-692)/2});
	$(window).resize(function(){
    $('.loginbox,.systemlogo').css({'position':'absolute','left':($(window).width()-692)/2});
    })
});
	/*
	$(function () {  
        //兼容不支持placeholder的浏览器[ie浏览器，并且10以下均采用替代方式处理]  
        if ((navigator.appName == "Microsoft Internet Explorer") && (document.documentMode < 10 || document.documentMode == undefined)) {  
            var $placeholder = $("input[placeholder]");  
            for (var i = 0; i < $placeholder.length; i++) {  
                if ($placeholder.eq(i).attr("type") == "password") {  
                    $placeholder.eq(i).siblings("label").text($placeholder.eq(i).attr("placeholder")).show()  
                } else {  
                    $placeholder.eq(i).val($placeholder.eq(i).attr("placeholder")).css({"color": "#ccc"})  
                }  
            }  
            $placeholder.focus(function () {  
                if ($(this).attr("type") == "password") {  
                    $(this).siblings("label").hide()  
                } else {  
                    if ($(this).val() == $(this).attr("placeholder")) {  
                        $(this).val("").css({"color": "#333"})  
                    }  
                }  
            }).blur(function () {  
                if ($(this).attr("type") == "password") {  
                    if ($(this).val() == "") {  
                        $(this).siblings("label").text($(this).attr("placeholder")).show()  
                    }  
                } else {  
                    if ($(this).val() == "") {  
                        $(this).val($(this).attr("placeholder")).css({"color": "#ccc"})  
                    }  
                }  
            });  
            $(".clone_input_text").live("focus", function () {  
                $(this).siblings("label").hide()  
            }).live("blur", function () {  
                if ($(this).val() == "") {  
                    $(this).siblings("label").text($(this).attr("placeholder")).show()  
                }  
            });  
            $placeholder.siblings("label").click(function () {  
                if ($(this).parent("div").siblings(".see_pwd_btn").attr("data-flag") == "1") {  
                    $(this).hide().next("input").next("input").focus()  
                } else {  
                    $(this).hide().next("input").focus()  
                }  
            })  
        }
	});
	*/
</script>
<script type="text/javascript" >	
	$(document).ready(function(){
		var loginCode=${loginCode};
		if(loginCode==-2){
			layer.alert("登陆失败,用户名或密码错误!",{icon:2});
		}else if(loginCode==-3){
			layer.alert("验证码不正确!",{icon:2});
		}
		else if(loginCode==-4){
			layer.alert("用户尚未通过验证，请登陆邮箱验证或联系管理员!",{icon:2});
		}else if(loginCode==-5){
			layer.alert("用户已被管理员禁用，请联系管理员!",{icon:2});
		}
		
		$("#sub").click(function(){
			login();
		});
		function login(){
			var flag = true;
			var admin = $("input[name='userAdmin']").val();
			var pwd = $("input[name='userPwd']").val();
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
			$("#login_form").submit();
		}
	});
	
	//刷新验证码
    function changeImg(){
        document.getElementById("validateCodeImg").src="../DrawImageServlet?"+Math.random();
    }
</script>
<style>
.yzm{
	vertical-align: middle;
	height: 33px;
	position: relative;
	top: -1px;
    margin: 0 5px;
}
.hyz{
	color: #056dae;
}
.hyz:hover {
    color: #3d96c9;
}
</style>
</head>

<body style="background-color:#1c77ac; background-image:url(../images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">



    <div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>


<div class="logintop">
    <span>后台管理系统</span>
    <!-- <ul>
    <li><a href="#">回首页</a></li>
    <li><a href="#">帮助</a></li>
    <li><a href="#">关于</a></li>
    </ul> -->
    </div>

    <div class="loginbody">

    <div class="systemlogo">后台管理系统</div>

    <div class="loginbox">
	<form id="login_form" action="tologin" method="post">
    <ul>
    <li><input name="userAdmin" type="text" class="loginuser" placeholder="请输入登录用户名/邮箱"/></li>
    <li><input name="userPwd" type="password" class="loginpwd" placeholder="请输入登录密码"/></li>
    <li>
		<input name="code" type="text" class="loginyzm" placeholder="请输入验证码"/>
		<!-- <input type="button" value="获取验证码" class="loginyzmBtn"> -->
		<img src="../DrawImageServlet" class="yzm" width="79" alt="" id="validateCodeImg" />
		<a href="javascript:changeImg()" class="hyz">换一张</a>
	</li>
    <li><input id="sub" type="button" class="loginbtn" value="登录"  />
		<label><a href="#">重置密码</a></label></li>
    </ul>
	</form>

    </div>

    </div>



    <!-- <div class="loginbm">版权所有  2013  <a href="http://www.uimaker.com">uimaker.com</a>  仅供学习交流，勿用于任何商业用途</div> -->


</body>

</html>
