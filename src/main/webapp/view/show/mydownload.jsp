<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/strutil.tld" prefix="str" %>
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
						layer.alert("Your password has been changed successfully!",{icon:0});
						window.location.href="index";
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
                    <li><cite></cite><a href="perinfo">Person Info</a></li>
                    <li  class="selected"><cite></cite><a href="changepwd">Change Password</a></li>
                    <li><cite></cite><a href="mydownload">Download the application</a></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->
        <div class="main">
            <div class="downwrap">
             <div class="mt15">
                <table class="tablelist">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>DataCount</th>
                            <th>Content</th>
                            <th>TotalDataSize</th>
                            <th>OrderTime</th>
                            <th>CheckedStatus</th>
                            <th>PackingStatus</th>
                            <th>ExpireTime</th>                            
                            <th>Download</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach var="item" items="${datalist}">
	                    <tr>
                            <td>${item.getUdid() }</td>
                            <td>${item.getDatacount() }</td>
                            <td><div title="${item.getContent()}">${str:bSubstring2(item.getContent(),18,4) }</div></td>
                            <td>${str:StrSize(item.getTotaldatasize())}</td>
                            <td><fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${item.getOrderdatetime() }" /></td>
                            <td>${item.getCheckedstatus()?"checked":"unchecked" }</td>
                            <td>${item.getZipstatus()?"packed":"to be packed" }</td>
                            <td><fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${item.getDownloadendtime() }" /></td>
                            <td>
                            <c:set var="nowDate" value="<%=System.currentTimeMillis()%>"></c:set> 
                            <c:if test="${item.getZipstatus() && item.getDownloadendtime().getTime() > nowDate}">           
                            	<a href="download2?id=${item.getUdid()}&iu=${user!=null?user.getUserid():0}" class="check">download</a>
                            </c:if></td>
                        </tr>
	                    </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!--  分页-->
          <div class="paging">
            <div class="page">
            <ul class="clearfix">
	            <li class="prev">
	           	<c:choose>
					<c:when test="${page.pageNow == 1 }">
						<a href="#">pre</a>
					</c:when>
					<c:otherwise>
						<a href='javascript:pagejump(${page.pageNow-1 });'>pre</a>
					</c:otherwise>
				</c:choose>
				</li>
			
			<c:choose>
				<c:when test="${page.totalPageCount <= 5 }">
					<c:forEach begin="1" end="${page.totalPageCount }" varStatus="obj">
						<c:choose>
							<c:when test="${obj.index == page.pageNow }">
								<li class="on"><a href="#">${obj.index}</a></li>
							</c:when>
							<c:otherwise>
								<li>
									<a href='javascript:pagejump(${obj.index});'>${obj.index}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="1" end="${page.totalPageCount}" varStatus="obj">
						<c:choose>
							<c:when test="${page.pageNow <= 3 }">
								<c:if test="${obj.index <= 5 }">
									<c:choose>
										<c:when test="${obj.index == page.pageNow }">
											<li class="on"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li>
												<a href='javascript:pagejump(${obj.index});'>${obj.index}</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:when>
							<c:when test="${page.totalPageCount-3 < page.pageNow }">
								<c:if test="${obj.index > page.totalPageCount-5 }">
									<c:choose>
										<c:when test="${obj.index == page.pageNow }">
											<li class="on"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li>
												<a href='javascript:pagejump(${obj.index});'>${obj.index}</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${page.pageNow-2 <= obj.index && obj.index <= page.pageNow+2}">
									<c:choose>
										<c:when test="${obj.index == page.pageNow }">
											<li class="on"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li>
												<a href='javascript:pagejump(${obj.index});'>${obj.index}</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
			<li class="next">
           	<c:choose>
				<c:when test="${page.pageNow == page.totalPageCount }">
					<a href="#">next</a>
				</c:when>
				<c:otherwise>
					<a href='javascript:pagejump(${page.pageNow+1 });'>next</a>
				</c:otherwise>
			</c:choose>
			</li>			

            </ul>
            </div>
        </div>
        <script type="text/javascript">
        function pagejump(nowpage){
    		window.location.href="mydownload?pageNow="+nowpage;
    	}
        </script>
        </div>        
        <!--/主体2-->
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /底部 -->
</div>
</body>
</html>