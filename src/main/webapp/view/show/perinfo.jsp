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
    	}else if($("#loginname").val()==""){
    		layer.alert("You need input login name!",{icon:2});
    	}else if($("#loginemail").val()==""){
    		layer.alert("You need input login email!",{icon:2});
    	}else if($("#pwd").val()==""){
    		layer.alert("You need input password!",{icon:2});
    	}else{
    		$.ajax({
    			type:"post",			
				url:"reg",
				data:$("#reg").serialize(),
				dataType:"json",
				success: function(data){
					if(data.success){
						layer.alert("Your registration is successful!",{icon:0});
						windows.local.herf="index";
					}else{
						layer.alert(data.code,{icon:2});
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
                    <li class="selected"><cite></cite><a href="perinfo">Person Info</a></li>
                    <li><cite></cite><a href="changepwd">Change Password</a></li>
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
                    <div class="group">
                        <span>Login Name:</span>
                        <input type="text" readonly="readonly" value="${user.getLoginname() }">
                    </div>
                    <div class="group">
                        <span>Login Email:</span>
                        <input type="text" readonly="readonly" value="${user.getLoginemail() }">
                    </div>
                    <div class="group">
                        <span>Real Name:</span>
                        <input type="text" readonly="readonly" value="${user.getRealname() }">
                    </div>
                    <div class="group">
                        <span>Country(Area):</span>
                        <input type="text" readonly="readonly" value="${country}">
                    </div>
                    <div class="group">
                        <span>User Status:</span>
                        <input type="text" readonly="readonly" value="${user.getUserstatus()==0?'Pending verification':user.getUserstatus()==1?'Normal':'Administrator Forbidden' }">
                    </div>
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