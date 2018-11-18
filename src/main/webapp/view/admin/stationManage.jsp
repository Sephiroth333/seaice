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
.uploadLoad{margin-bottom: 20px;}
.uploadLoad .btn{float: right;}
.dfinput{height: 25px;}
.searchTr{height: 40px;}
.searchTr input{width: auto;}
.clearKeyWord{margin-left: 4px;    font-size: 12px; color: #999;}
.group label{width: 96px;}
</style>
</head>
<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">监测数据</a></li>
    <li><a href="#">站点管理</a></li>
    </ul>
    </div>

    <div class="mainindex">
	<div class="uploadLoad clearfix">
        <input name="" type="button" class="btn" value="添加站点" />
    </div>

    <table class="tablelist">
    	<thead>
    	<tr>
	        <!-- <th><input name="" type="checkbox" value="" checked="checked"/></th> -->
	        <th>序号<i class="sort"><img src="images/px.gif" /></i></th>
	        <th>站点数据类型</th>
	        <th>站点名称</th>
	        <th>经度</th>
	        <th>纬度</th>
	        <th>数据开始时间</th>
	        <th>数据结束时间</th>
	        <th>已有数据记录条数</th>
	        <th>站点说明</th>
	        <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr class="searchTr">
			<td></td>
			<td></td>
        	<td><input type="text" class="search dfinput" placeholder="输入关键词" /><a href="javascript:;" class="clearKeyWord">X</a></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
        </tr>
        <c:forEach var="dt" items="${WqStationList }">
	       <tr>
	         <!-- <td><input name="" type="checkbox" value="" /></td> -->
	        <td>${dt.getStationid() }</td>
	        <td>${dt.getDataType().getDtnameson() }</td>
	        <td>${dt.getStationname() }</td>
	        <td>${dt.getLongitude() }</td>
	        <td>${dt.getLatitude() }</td>
	        <c:choose>	        
		        <c:when test="${dt.getWqS().getDataCount()> 0 }">
		        	<td><fmt:formatDate value="${dt.getWqS().getStartDate()}" type="date" pattern="yyyy-MM-dd"/></td>
		        	<td><fmt:formatDate value="${dt.getWqS().getEndDate()}" type="date" pattern="yyyy-MM-dd"/></td>
	        	</c:when>
	        	<c:otherwise>
	        		<td></td><td></td>
	        	</c:otherwise>
        	</c:choose>
        	<td>${dt.getWqS().getDataCount() }</td>
	        <td>${dt.getContent() }</td>
	        <td><a onclick="javascript:modify(${dt.getStationid()})" href="#" class="modify"> 修改</a><a onclick="javascript:del(${dt.getStationid()})" href="#" class="tablelink removeBtn"> 删除</a></td>
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


    <!--  修改弹出-->
    <div class="tip modifyShow">
    <form id="modify_form">
      <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        	<div><input type="hidden" id="modifydtID" value="" name="modifydtID"/></div>
            <div class="formTitle">修改站点信息</div>
            <div class="group">
				<label>站点名称：</label>
				<input type="text" class="dfinput"  value="" id="stName2" name="stName2"/>
			</div>
			<div class="group">
				<label>经度：</label>
				<input type="text" class="dfinput"  value="" id="lon2" name="lon2"/>
			</div>
			<div class="group">
				<label>纬度：</label>
				<input type="text" class="dfinput"  value="" id="lat2" name="lat2"/>
			</div>
			<div class="group">
				<label>站点说明：</label>
				<input type="text" class="dfinput"  value="" id="content2" name="content2"/>
			</div>
        </div>
        </div>
        <div class="tipbtn">
        <input id="modifybtn" type="button"  class="sure" value="确定" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    </form>
    </div>

    <!--  删除弹出-->
    <div class="tip cancelShow">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        <p>您确定要删除该条数据吗？</p>
        </div>
        </div>
        <div class="tipbtn">
        <input type="hidden" id="delID" value="" name="delID"/>
        <input id="delbtn" type="button"  class="sure" value="确定删除" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    </div>
    <!--  添加弹出-->
    <div class="tip uploadLoadShow">
    <form id="add_form">
      <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        	<div><input type="hidden" id="dtfatherName" value="${dtlist.get(0).getDtnamefather() }" name="dtfatherName"/></div>
        	<div><input type="hidden" id="dtfatherID" value="${dtlist.get(0).getDtfatherid() }" name="dtfatherID"/></div>
            <div class="formTitle">添加站点</div>
            <div class="group">
				<label>分类选择：</label>
				<select id="datatype" class="typeSelect" name="datatype">
				<c:forEach var="dt" items="${dtlist}">
					<option value="${dt.getDtid()}">${dt.getDtnameson()}</option>
				</c:forEach>
				</select>
			</div>
			<div class="group">
				<label>站点名称：</label>
				<input type="text" class="dfinput"  value="" name="stName"/>
			</div>
			<div class="group">
				<label>经度：</label>
				<input type="text" class="dfinput"  value="" name="lon"/>
			</div>
			<div class="group">
				<label>纬度：</label>
				<input type="text" class="dfinput"  value="" name="lat"/>
			</div>
			<div class="group">
				<label>站点说明：</label>
				<input type="text" class="dfinput"  value="" name="content"/>
			</div>
        </div>
        </div>
        <div class="tipbtn">
        <input id="addbtn" type="button"  class="sure upload" value="添加" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    </form>
    </div>
    </div>

    <script type="text/javascript">
    function pagejump(nowpage){
    	window.location.href="stationManage?pageNow="+nowpage;
    }
    function pagejump2(){
    	var a=Number($("#userpage").val());
    	if(!isNaN(a)){
    		pagejump(a);
    	}    	
    }
    
    function modify(id){	
		$.ajax({
			type:"get",
			url:"singleStation?id="+id,
			dataType:"json",
			success: function(data){
				if(data != null){
					$("#modifydtID").val(data.stationid);
					$("#lat2").val(data.latitude);
					$("#lon2").val(data.longitude);
					$("#stName2").val(data.stationname);
					$("#content2").val(data.content);
					$(".modifyShow").fadeIn(200);		//弹出修改界面
				}
			}
		});
	}
    
    function del(id){
    	$("#delID").val(id);
    }
    
	$('.tablelist tbody tr:odd').addClass('odd');
    $(document).ready(function(){
      $(".uploadLoad .btn").click(function(){
      $(".uploadLoadShow").fadeIn(200);		//弹出添加界面
      });

      $(".removeBtn").click(function(){
      $(".cancelShow").fadeIn(200);			//弹出删除界面
      });

      $(".tiptop a").click(function(){
      $(".tip").fadeOut(200);				//取消（弹出界面右上角）
    });

      $(".cancel").click(function(){
      $(".tip").fadeOut(100);				//取消，弹出界面按钮
    });

	$('.clearKeyWord').click(function(){
		$(this).prev().val('');
	});
	
	$("#modifybtn").click(function(){		//确认修改		
		$.ajax({
			type:"post",			
			url:"stationModify",
			data:$("#modify_form").serialize(),
			dataType:"json",
			success: function(data){
				OperateResult(data,"修改");
				$(".modifyShow").fadeOut(200);		//关闭修改界面
			}
		});		
	});
	
	$("#addbtn").click(function(){		//确认添加
		$.ajax({
			type:"post",			
			url:"stationAdd",
			data:$("#add_form").serialize(),
			dataType:"json",
			success: function(data){
				OperateResult(data,"添加");
				$(".uploadLoadShow").fadeOut(200);		//关闭添加界面
			}
		});
	});
	
	$("#delbtn").click(function(){		//确认删除
		$.ajax({
			type:"get",
			url:"stationDel?id="+$("#delID").val(),
			dataType:"json",
			success: function(data){
				OperateResult(data,"删除");
				$(".cancelShow").fadeOut(200);		//关闭删除界面
			}
		});
	});

    });
	</script>
</body>
</html>
