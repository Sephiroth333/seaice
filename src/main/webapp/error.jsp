<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	response.setStatus(HttpServletResponse.SC_OK);
%>
<!DOCTYPE HTML>
<html>
<head>

<title>error page</title>
</head>

<body>
	<div style="margin:80px;">
		<h2><font color=#DB1260>程序发生了错误.</font></h2>
		<a href="javascript:history.go(-1)" style="color: #000;text-decoration: none;">返回上一页</a>
		<a href="/Pharmacy/admin/login" style="color: #000;text-decoration: none;">重新登陆</a>
		<hr width=100%>
		<h2>
			<font color=#DB1260>JSP Error Page.</font>
		</h2>
		<p>
			An exception was thrown: ${msg == null?"未找到该资源!":msg }<b>
		</p>
		<hr width=100%>
	</div>
</body>
</html>
