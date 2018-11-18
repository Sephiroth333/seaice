<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript">
$(document).ready(function() {
	$("#loginbtn").click(function(){
		$.ajax({
			type:"post",
			url:"login",
			data:$("#loginform").serialize(),
			dataType:"json",
			success: function(obj){
				if(obj.success){
					window.location.reload();
				}else{
					layer.alert("Login unsuccessfully.",{icon:2});
				}
			}
		});
	})    
});
function loginout(){
	$.ajax({
		type:"get",			
		url:"loginout",
		dataType:"json",
		success: function(data){
			window.location.reload();
		}
	});
}

//刷新验证码
function changeImg(){
    document.getElementById("validateCodeImg").src="DrawImageServlet?"+Math.random();
}
</script>
    <!-- 头部 -->
    <div class="header">
    	<c:if test="${user==null }">    
	   	<div class="login">
	   	<form id="loginform">
	        <lable>Username:</lable><input name="userAdmin" class="in" type="text"> 
	        <lable>Password:</lable><input name="userPwd" class="in" type="password">
	        <!-- <lable>CheckCode:</lable><input name="code" class="in" type="text"/>
	        <img src="DrawImageServlet" class="yzm" width="80" onclick="javascript:changeImg()" alt="Refresh" id="validateCodeImg"  />  -->
	        <input id="loginbtn" class="btn" type="button" value="Sign in">
	        <a href="reg" class="btn">Create account</a>
	    </form>	    
	    </div>
	    </c:if>
	    <c:if test="${user!=null }">
        <div class="loginSuccess">
	        <span>welcome ${user.getRealname()}，Today is <fmt:formatDate pattern="yyyy-MM-dd" value="<%=new java.util.Date() %>" /></span>&nbsp;
	        <a href="percenter" class="btn">person-center</a>
	        <a href="javascript:loginout()" class="btn">Login out</a>
        </div>
      </c:if>

      <div style="margin: 70px">
          <label style="font-size: 30px;color: #221199 ">One stop website for current state of polar,ocean and ice sheet</label>
          <br/>
          <label style="font-size: 30px;color: #221199 ">极地海冰、冰盖与海洋一站式数据服务网站</label>
      </div>
    </div>
    <!-- /头部 -->

    <!-- 导航 -->
    <div id="nav" style="z-index:9999; position:relative;" >
        <ul>
          <li><a href="index">Home</a></li>
          <li>
            <a href="#">Sea Ice</a>
            <ul>
              <li><a href="concentration">Sea Ice Concentration</a></li>
              <li><a href="thickness">Sea Ice Thickness</a></li>
              <li><a href="meltponds">Melt Ponds</a></li>
              <li><a href="leads">LEADS</a></li>
              <li><a href="drift">Sea Ice Drift</a></li>
            </ul>
          </li>
          <li>
            <a href="#">Ocean</a>
            <ul>
              <li><a href="temperature">Sea Surface Temperature</a></li>
              <li><a href="winds">Sea Surface Winds</a></li>
            </ul>
          </li>
          <li>
          	<a href="#">Ice Sheet</a>
          	<ul>
              <li><a href="velocity">Ice Velocity</a></li>
              <li><a href="icesheet">Ice Sheet Balance</a></li>
            </ul>
          </li>
          <li><a href="archive">Data Archive</a></li>
          <li>
          	<a href="#">Publication</a>
          	<ul>
              <li><a href="menu?id=7">Recommended Publication</a></li>
              <li><a href="menu?id=6">Group Publication</a></li>
            </ul>
          </li>
          <li><a href="menu?id=8">Contact</a></li>
        </ul>
    </div>
    <!-- /导航 -->