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
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="js/layer/layer.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#nav>ul>li").hover(function(){$(this).children("ul").show();},function(){$(this).children("ul").hide();});
    
    $(".submit").click(function(){
    	if($("#pwd").val()!=$("#pwd2").val()){
    		layer.alert("The two password input is inconsistent!",{icon:2});
    	}else if($("#pwd0").val()==""){
    		layer.alert("You need input old password!",{icon:2});
    	}else if($("#pwd").val()==""){
    		layer.alert("You need input new password!",{icon:2});
    	}else{
    		$.ajax({
    			type:"post",			
				url:"changepwd",
				data:$("#changepwd").serialize(),
				dataType:"json",
				success: function(data){
					if(data.success){
						layer.alert("Your password has been changed successfully!",{icon:0},function(){window.location.href="index";});
					}else{
						if(data.code==302){
							layer.alert("Sorry,the old password you input is wrong!",{icon:2});
						}else{
							layer.alert(data.code,{icon:2});
						}
					}
				}
    		});
    	}
    });
});
</script>
</head>
<body>
<div class="wrapper">

    <!-- top include-->
	<%@ include file="top.jsp" %>
	
     <!-- /主体 -->
    <div class="container">
        <!--边栏-->
        <div class="sidebar">
            <dl class="side-nav">
                <dt>Person-center</dt>
                <dd>
                    <ul>
                    <li><cite></cite><a href="perinfo">Person Info</a></li>
                    <li  class="selected"><cite></cite><a href="changepwd">Change Password</a></li>
                    <li><cite></cite><a href="mydownload">Download the application</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体-->
        <div class="main">
            <div class="mt20">
                <div class="groupWrap">
                <form id="changepwd">
                    <div class="group">
                        <span>Password:</span>
                        <input id="pwd0" name="pwd0" type="password" placeholder="Please enter your Password">
                    </div>
                    <div class="group">
                        <span>newPassword:</span>
                        <input id="pwd" name="pwd" type="password" placeholder="Please enter your new password">
                    </div>
                    <div class="group">
                        <span>rePassword:</span>
                        <input id="pwd2" name="pwd2"  type="password" placeholder="Please enter your new password">
                    </div>
                    <div class="group">
                        <span></span>
                        <input type="button" class="submit" value="submit">
                    </div>
                </form>
                </div>
            </div>
        </div>
        <!--/主体-->
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /底部 -->
</div>
</body>
</html>