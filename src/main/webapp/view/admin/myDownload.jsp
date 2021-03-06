<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="js/layer/layer.js"></script>
<script type="text/javascript" src="js/common_check.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="js/select-ui.min.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<style>
.uploadLoad{margin-bottom: 20px;}
.uploadLoad .btn{float: right;}
.dfinput{height: 25px;}
.tablelinkShow .group label{text-align: left;width: auto;}
.formTitle{text-align: center;}
.plusBtn{ width: 70px; height: 28px; line-height: 28px; }
.tipright .editorWrap >table{display: inline-block;vertical-align: top;}
.tablelist a{color: #056dae;}
.tablelist a:hover { color: #00a4ac; text-decoration: none; }
.searchTr{height: 40px;}
.searchTr input{width: auto;}
.tablelist a.clearKeyWord{margin-left: 4px;    font-size: 12px; color: #999;}
</style>
</head>


<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">我的下载</a></li>
    <li><a href="#">我的下载</a></li>
    </ul>
    </div>

    <div class="mainindex">
	<div class="uploadLoad clearfix">
        <!-- <input name="" type="button" class="btn" value="上传数据"> -->
    </div>

    <table class="tablelist">
    	<thead>
    	<tr>
    	<th>序号</th>
    	<th>数据类型</th>
    	<th>数据内容</th>
        <th>申请数据总数</th>        
        <th>申请数据大小</th>
        <th>申请时间</th>
        <th>审核状态</th>
		<th>审核时间</th>		
        <th>打包状态</th>
        <th>打包数</th>
        <th>Zip包大小</th>
        <th>链接有效期</th>
		<th>下载</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${dtlist }">
        <tr>
	        <td>${item.getId()}</td>
	        <td>${item.getDataType().getDtnameson()}</td>
	    	<td>${item.getContent() }</td>
	        <td>${item.getDatacount() }</td>        
	        <td>${item.getTotaldatasize() }</td>
	        <td><fmt:formatDate value="${item.getOrderdatetime()}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	        <td>${item.getCheckedstatus()==0?"待审核":item.getCheckedstatus()==1?"已审核":"不通过" }</td>
			<td><c:if test="${item.getCheckedtime()!=null}">
	        	<fmt:formatDate value="${item.getCheckedtime()}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
	        </c:if></td>	
	        <td>${item.getZipstatus()?"已打包":"待打包"}</td>
	        <td>${item.getZipcount()}</td>
	        <td>${item.getZipsize()}</td>
	        <td><c:if test="${item.getDownloadendtime()!=null}">
	        	<fmt:formatDate value="${item.getDownloadendtime()}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
	        </c:if></td>
			<td><c:if test="${item.getZipstatus()}">
				<a href="downloadFile?id=${item.getId()}&zid=0">下载</a>
			</c:if></td>
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
    	window.location.href="myDownload?&pageNow="+nowpage;
    }
    function pagejump2(){
    	var a=Number($("#userpage").val());
    	if(!isNaN(a)){
    		pagejump(a);
    	}    	
    }
    </script>
    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>
</body>
</html>
