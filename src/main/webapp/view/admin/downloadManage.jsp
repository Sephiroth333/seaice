<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/strutil.tld" prefix="str" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="../css2/style.css" rel="stylesheet" type="text/css" />
<link href="../css2/common.css" rel="stylesheet" type="text/css" />
<link href="../css2/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="../js/layer/layer.js"></script>
<script type="text/javascript" src="../js/common_check.js"></script>
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
    <li><a href="#">下载管理</a></li>
    <li><a href="#">下载申请管理</a></li>
    </ul>
    </div>

    <div class="mainindex">
	<div class="uploadLoad clearfix">
        <input type="hidden" id="checkallID" value="" name="checkallID"/>
        <input id="checkall_btn" type="button" class="btn" value="批量审核" />
    </div>

    <table class="tablelist">
    	<thead>
    	<tr>
    	<th><input name="checkall" id="checkall" type="checkbox" value="" /></th>
    	<th>序号</th>
    	<th>申请人</th>
    	<th>数据内容</th>
        <th>申请数据总数</th>        
        <th>申请数据大小</th>
        <th>申请时间</th>
        <th>审核状态</th>
        <th>审核人ID</th>
		<th>审核时间</th>		
        <th>打包状态</th>
        <th>链接有效期</th>
		<th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${datalist }">
        <tr>
        	<td><input name="checkxx" type="checkbox" value="${item.getUdid()}" /></td>
	        <td>${item.getUdid()}</td>
	        <td>${item.getApplyUser().getRealname()}</td>
	    	<td>${item.getContent()}</td>
	        <td>${item.getDatacount()}</td>        
	        <td>${str:StrSize(item.getTotaldatasize()) }</td>
	        <td><fmt:formatDate value="${item.getOrderdatetime()}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	        <td>${item.getCheckedstatus()?"已审核":"待审核" }</td>
	        <td>${item.getAdminid()}</td>
	        <!--<td>${item.getCheckUser()!=null?item.getCheckUser().getAdminName():""}</td>-->
			<td><c:if test="${item.getCheckedtime()!=null}">
	        	<fmt:formatDate value="${item.getCheckedtime()}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
	        </c:if></td>	
	        <td>${item.getZipstatus()?"已打包":"待打包"}</td>
	        <td><c:if test="${item.getDownloadendtime()!=null}">
	        	<fmt:formatDate value="${item.getDownloadendtime()}" type="date" pattern="yyyy-MM-dd HH:mm:ss"/>
	        </c:if></td>
			<td><c:if test="${!item.getCheckedstatus()}">
				<a onclick="javascript:check(${item.getUdid()})" href="#" class="check"> 审核</a>
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

	<!--  审核弹出-->
    <div class="tip checkShow">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        <p>您确定要审核所有选中数据吗？</p>
        </div>
        <div class="group">
            <label>下载有效期</label>
            <select id="expireDays" class="typeSelect">
            	<option value="1">1天</option>
            	<option value="5">5天</option>
            	<option value="7">7天</option>
            	<option value="30">1月</option>
            	<option value="182">半年</option>
            	<option value="365">1年</option>
           </select>
        </div>
        </div>
        <div class="tipbtn">
        <input type="hidden" id="checkID" value="" name="checkID"/>        
        <input id="checkbtn" type="button"  class="sure" value="审核通过" />&nbsp;
        <!-- <input id="uncheckbtn" type="button"  class="sure" value="审核不通过" />&nbsp; -->
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    </div>
    
    <!--  批量审核弹出-->
    <div class="tip checkAllShow">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        <p>您确定要审核所有选中数据吗？</p>
        </div>
        <div class="group">
            <label>下载有效期</label>
            <select id="expireDays2" class="typeSelect">
            	<option value="1">1天</option>
            	<option value="5">5天</option>
            	<option value="7">7天</option>
            	<option value="30">1月</option>
            	<option value="182">半年</option>
            	<option value="365">1年</option>
           </select>
        </div>
        </div>
        <div class="tipbtn">        
        <input id="checkallbtn" type="button"  class="sure" value="审核通过" />&nbsp;
        <!--<input id="uncheckallbtn" type="button"  class="sure" value="审核不通过" />&nbsp;-->
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    </div>

    </div>
	
    <script type="text/javascript">
    function pagejump(nowpage){
    	window.location.href="downloadManage?&pageNow="+nowpage;
    }
    function pagejump2(){
    	var a=Number($("#userpage").val());
    	if(!isNaN(a)){
    		pagejump(a);
    	}    	
    }
    function check(id){
    	$("#checkID").val(id);
    	$(".checkShow").fadeIn(200);		//打开审核窗口
    }
    function checkupdate(id,checkstatus,expireDays){
    	$.ajax({
			type:"get",
			url:"downloadCheck?id="+id+"&checkstatus="+checkstatus+"&expireDays="+expireDays,
			dataType:"json",
			success: function(data){
				OperateResult(data,"审核");
				$(".cancelShow").fadeOut(200);		//关闭审核界面
			}
		});
    }
    </script>
    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	$(document).ready(function(){
		$("#checkall_btn").click(function(){
	          $(".checkAllShow").fadeIn(200);			//打开批量审核窗口
	    });
		 $("#checkbtn").click(function(){
		    	checkupdate($("#checkID").val(),1,$("#expireDays").val());	//审核通过
	    });
	    $("#uncheckbtn").click(function(){
	    	checkupdate($("#checkID").val(),2,$("#expireDays").val());	//审核不通过
	    });
	    $("#checkallbtn").click(function(){
	    	checkupdate($("#checkallID").val(),1,$("#expireDays2").val());	//批量审核通过
	    });
	    $("#uncheckallbtn").click(function(){
	    	checkupdate($("#checkallID").val(),2,$("#expireDays2").val());	//批量审核不通过
	    });
	    $(".tiptop a").click(function(){
		      $(".tip").fadeOut(200);
	    });
	
	    $(".cancel").click(function(){
	     	$(".tip").fadeOut(100);
	   	});	    
	});
	</script>
</body>
</html>
