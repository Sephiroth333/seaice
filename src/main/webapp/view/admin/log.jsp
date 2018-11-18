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
<link type="text/css" rel="stylesheet" href="../css2/style.css"/>
<link href="../css2/common.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="img/favicon.ico"/>
<style>
.applyDown{margin-top: 20px;}
.ft {
    float: right !important;
}
.applyDown .btn {
    width: 155px;
    height: 35px;
    background: #3d96c9;
    font-size: 14px;
    font-weight: bold;
    color: #fff;
    cursor: pointer;
    border: none;
    border-radius: 3px;
}
.applyDown .btn:hover{
  opacity: 0.8;
}
input {
    outline: none;
}
.applyDown{margin-top: 20px;}
.tipinfo {padding: 30px 28px 0px; margin-left: 0; }
.datainp{ width:188px; height:30px; border:1px #ccc solid; padding-left: 10px;}
.jedatebox .jedateym .next:before,.jedatebox .jedateym .prev:before{margin-top: 11px;}
.dataGroup{margin-top: 15px;}
.clearfix {zoom:1;}
.clearfix:after {content:"";display:block;height:0;clear:both;visibility:hidden;}
.clearfix span{display:inline;font:14px/1.14 arial;}
.clearfix select{display:inline;font:14px/1.14 arial;border:1px #ccc solid;}
.lt{float:left !important;}
.ft{float:right !important;}

</style>
<script type="text/javascript" src="../js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="../js/layer/layer.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
	<li><a href="#">数据管理</a></li>
    <li><a href="#">自处理程序日志</a></li>
    </ul>
    </div>
    
    <div class="mainindex">	   
    		<table class="tablelist">
                    <thead>
                        <tr>
                        	<th>序号</th>
                            <th>类型</th>
                            <th>代码</th>
                            <th>生成时间</th>
                            <th>内容</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach var="item" items="${datalist}">
	                    <tr>
	                    	<td>${item.getLogid() }</td>
                            <td>${item.getLogtype()<100?"消息":"错误"}</td>
                            <td>${item.getLogtype()}</td>
                            <td><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${item.getLogtime() }" /></td>
                            <td><div title="${item.getLogcontent()}">${str:bSubstring2(item.getLogcontent(),100,20)}</div></td>
                        </tr>
	                    </c:forEach>
                    </tbody>
                </table>
    
      <!--  分页-->
        <div class="pagin">
            <div class="message">共<i class="blue">${page.totalCount }</i>条记录，当前显示第&nbsp;<i class="blue">${page.pageNow}&nbsp;</i>页</div>
            <ul class="paginList">
            <li class="paginItem">
           	<c:choose>
				<c:when test="${page.pageNow == 1 }">
					<a href="#"><span class="pagepre current"></span></a>
				</c:when>
				<c:otherwise>
					<a href='javascript:pagejump(${page.pageNow-1 });'><span class="pagepre"></span></a>
				</c:otherwise>
			</c:choose>
			</li>
			
			<c:choose>
				<c:when test="${page.totalPageCount <= 5 }">
					<c:forEach begin="1" end="${page.totalPageCount }" varStatus="obj">
						<c:choose>
							<c:when test="${obj.index == page.pageNow }">
								<li class="paginItem current"><a href="#">${obj.index}</a></li>
							</c:when>
							<c:otherwise>
								<li class="paginItem">
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
											<li class="paginItem current"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li class="paginItem">
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
											<li class="paginItem current"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li class="paginItem">
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
											<li class="paginItem current"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li class="paginItem">
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
			
			<li class="paginItem">
           	<c:choose>
				<c:when test="${page.pageNow == page.totalPageCount }">
					<a href="#"><span class="pagenxt current"></span></a>
				</c:when>
				<c:otherwise>
					<a href='javascript:pagejump(${page.pageNow+1 });'><span class="pagenxt"></span></a>
				</c:otherwise>
			</c:choose>
			</li>			
            <li class="paginItem gotoPage"> 到第 <input id="userpage" type="text" class="dfinput" /> 页 </li>
            <li class="paginItem"><input onclick="pagejump2()" type="button" class="btn" value="确认" /></li>
            </ul>
        </div>
   </div>
    <script type="text/javascript">
    function pagejump(nowpage){
    	window.location.href="log?pageNow="+nowpage;
    }
    function pagejump2(){
    	var a=Number($("#userpage").val());
    	if(!isNaN(a)){
    		pagejump(a);
    	}    	
   }   
   </script>
</body>
</html>