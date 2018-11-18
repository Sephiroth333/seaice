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
						layer.confirm("Your registration is successful!Please verification it with your emailbox",{icon:0},function(){window.location.href="index";});						
					}else{
						if(data.code==201){
							layer.alert("Sorry,the username or email has been registered!",{icon:2});
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
	
     <!-- 主体 -->
    <div class="container">
        <div class="regWrap">
        <form id="reg">
        	<div class="group">
                <span>Login name:</span>
                <input type="text" id="loginname" name="loginname" placeholder="Please enter your login name" />
            </div>
            <div class="group">
                <span>Login email:</span>
                <input type="text" id="loginemail" name="loginemail" placeholder="Please enter your email address" />
            </div>
            <div class="group">
                <span>Password:</span>
                <input type="password" id="pwd" name="pwd" placeholder="Please enter your Password" />
            </div>
            <div class="group">
                <span>rePassword:</span>
                <input type="password" id="pwd2" name="pwd2" placeholder="Please enter your Password again" />
            </div>
            <div class="group">
                <span>RealName:</span>
                <input type="text" name="realname" placeholder="Please enter your RealName" />
            </div>
            <div class="group">
                <span>Country(Area):</span>
                <select class="" name="country">
                	<c:forEach var="cc" items="${countrylist }">
                		<c:if test="${cc.getId()==44}">
                			<option value="${cc.getId()}" selected="selected">${cc.getEnname()}</option>
                		</c:if>
                		<c:if test="${cc.getId()!=44}">
                			<option value="${cc.getId()}">${cc.getEnname()}</option>
                		</c:if>
                	</c:forEach>
                </select>
            </div>
            <div class="group">
                <span></span>
                <input type="button" class="submit" value="Register">
            </div>
        </form>
        </div>
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /底部 -->
</div>
</body>
</html>