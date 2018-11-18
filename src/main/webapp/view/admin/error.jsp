<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
	response.setStatus(HttpServletResponse.SC_OK);
%>
<!DOCTYPE HTML>
<html>
<head>
<title>error page</title>
<script type="text/javascript"> 
 window.parent.location.href="error2?code=${errorcode}"; 	//跳转到 .../seaice/admin/error2?code=xxx
</script> 
</head>
<body>
</body>
</html>
