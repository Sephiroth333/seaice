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
<style>
.conItem{border: 1px solid #cbcbcb;position:relative;margin-bottom: 15px; }
.conleft{ width: 58%; padding: 20px; min-height: 310px;}
.sltPic{width: 400px; height: 350px; border-left: solid 1px #cbcbcb; position: absolute;right: 0;text-align: center;line-height: 350px;}
.group label{text-align: left;width: auto;}
.textShowArea { line-height: 20px; color: #666;}
.textShowArea a{color: #f00;margin-left: 10px;}
.textShowArea a:hover{text-decoration: underline;}
.formTitle{text-align: center;}
</style>
</head>


<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
	<li><a href="#">首页</a></li>
	<li><a href="#">${dt.getDtnamefather() }</a></li>
    <li><a href="#">${dt.getDtnameson() }</a></li>
    </ul>
    <input id="dtid" type="hidden" value="${dt.getDtid() }" />
    </div>

    <div class="mainindex">
    <c:forEach var="item" items="${datalist }">
    	<div class="conItem clearfix">
    		<div class="conleft lt">
				<div class="group">
					<label>数据名称：</label>
					<div class="textShowArea">${item.getDataname()}</div>
				</div>
				<div class="group">
					<label>上传人：</label>
					<div class="textShowArea">${item.getUpdateid()}</div>
				</div>
				<div class="group">
					<label>上传时间：</label>
					<div class="textShowArea"><fmt:formatDate value="${item.getUpdatetime()}" type="date" pattern="yyyy-MM-dd"/></div>
				</div>
				<div class="group">
					<label>数据简介：</label>
					<div class="textShowArea">${item.getDataintroduce() }</div>
				</div>
				<div class="group">
					<div class="textShowArea">
					<!--<a href="javascript:;" class="detaillBtn">[详情]</a>-->
					<a href="javascript:applydownload(${item.getId() })" class="applydownBtn">[申请下载]</a>
					</div>
				</div>
    		</div>
			<div class="conright lt">
				<div class="sltPic">
					<c:if test="${item.getDatathumbnail()!='' }">
					<img src="${item.getDatathumbnail()}" height="350" width="400"/>
					</c:if>
				</div>
			</div>
    	</div>
	</c:forEach>
			
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


		<!--  申请下载弹出-->
		<div class="tip checkShow">
			<div class="tiptop"><span>提示信息</span><a></a></div>
		  <div class="tipinfo">
			<div class="tipright">
				<div class="formTitle">确认申请下载数据？</div>
				<div><input type="hidden" id="dataid" value="" /></div>
			</div>
			</div>
			<div class="tipbtn">
			<input id="applybtn" type="button"  class="sure" value="申请下载" />&nbsp;
			<input name="" type="button"  class="cancel" value="取消" />
			</div>
		</div>
    </div>
    
    <script type="text/javascript">
    function pagejump(nowpage){
    	window.location.href="dataList?id="+$("#dtid").val()+"&pageNow="+nowpage;
    }
    function pagejump2(){
    	var a=Number($("#userpage").val());
    	if(!isNaN(a)){
    		pagejump(a);
    	}    	
    }function applydownload(id){
    	$("#dataid").val(id);
    	$(".checkShow").fadeIn(200);
    }
    </script>
    
	<script type="text/javascript">
	$(document).ready(function(){
	  $("#applybtn").click(function(){
		  $.ajax({
				type:"get",
				url:"applyDownload2?id="+$("#dataid").val()+"&dtid="+$("#dtid").val(),
				dataType:"json",
				success: function(data){
					if(data.success){
						layer.alert("已提交申请成功!",{icon:1});
					}else{
						layer.alert("提交申请失败.",{icon:5});
					}
					$(".tip").fadeOut(100);		//关闭界面
				}
		  });
	  });

	  $(".tiptop a").click(function(){
	  $(".tip").fadeOut(200);
	});

	  $(".sure").click(function(){
	  $(".tip").fadeOut(100);
	});

	  $(".cancel").click(function(){
	  $(".tip").fadeOut(100);
	});

	});
	</script>
</body>

</html>
