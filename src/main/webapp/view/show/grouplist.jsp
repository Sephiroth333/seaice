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
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#nav>ul>li").hover(function(){$(this).children("ul").show();},function(){$(this).children("ul").hide();});
});
</script>
</head>
<body>
<div class="wrapper">
    <!-- top include-->
	<%@ include file="top.jsp" %>
		
    <!-- /主体 -->
    <div class="container">
        <div class="newsWrap">
            <ul class="newsList">
            <c:forEach var="item" items="${grouplist }">              
              <li><a href="member?id=${item.getPid()}">${item.getPname()}</a>
                  <span><fmt:formatDate pattern="yyyy-MM-dd" value="${item.getUpdatetime() }" /></span>
              </li>
            </c:forEach>
            </ul>
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
    		window.location.href="grouplist?&pageNow="+nowpage;
    	}
        </script>
        </div>
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">
    <img src="img/logo33.png" alt="&copy; 2017 Joint Center for Global Change and China Green Development">
    </div>
    <!-- /底部 -->
</div>

</body>
</html>