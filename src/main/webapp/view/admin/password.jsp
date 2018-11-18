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
<script type="text/javascript">
	$(document).ready(function(){
		var code=$("#code").val();
		switch(code){
			case "0":
				break;
			case "1":	
				layer.alert("密码修改成功！",{icon:1});	
				break;
			case "2":	
				layer.alert("旧密码输入错误！",{icon:2});	
				break;
			case "3":	
				layer.alert("密码中必须包含字母、数字、特称字符，至少8个字符，最多30个字符!",{icon:2});
				break;
			case "4":
			default:
				layer.alert("修改失败!",{icon:2});
				break;
		}
		
		$(".btn").click(function(){
			if($("#oldpwd").val()==""){
				layer.alert("请输入旧密码!",{icon:2});
			}else if($("#newpwd2").val()!=$("#newpwd").val()){
				layer.alert("两次输入密码不一致!",{icon:2});
			}else{
				var reg = /^[A-Za-z0-9]{6,20}$/;
				//var reg = /(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,30}/;	//密码中必须包含字母、数字、特称字符，至少8个字符，最多30个字符
				if(!reg.test($("#newpwd").val())){
					layer.alert("密码中必须包含字母、数字、特称字符，至少8个字符，最多30个字符!",{icon:2});
				}else{
					$("#pwdModify").submit();
				}
			}
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
</head>

<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
	<li><a href="#">系统管理</a></li>
    <li><a href="#">密码修改</a></li>
    </ul>
    </div>

    <div class="formbody">
	<div><input type="hidden" id="code" value="${code }"></div>
    <div class="formtitle"><span>密码修改</span></div>
	<form id="pwdModify" action="pwdModify" method="post">
    <ul class="forminfo">
    <li><label>密码：</label><input name="oldpwd" type="text" class="dfinput" placeholder="输入原密码" /><i></i></li>
    <li><label>新密码：</label><input name="newpwd" type="text" class="dfinput" placeholder="输入新密码" /><i></i></li>
    <li><label>确认密码：</label><input name="newpwd2" type="text" class="dfinput" placeholder="再次输入密码" /><i></i></li>
    <li><label>&nbsp;</label><input name="" type="button" class="btn" value="确认"/></li>    
    </ul>
    </form>

    </div>
</body>
</html>