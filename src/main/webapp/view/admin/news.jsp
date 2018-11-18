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
<script type="text/javascript" src="../js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="../js/layer/layer.js"></script>
<script type="text/javascript" src="../js/common_check.js"></script>
<script type="text/javascript" src="../UEditor/ueditor.config.js"></script>
<script type="text/javascript" src="../UEditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="../UEditor/lang/zh-cn/zh-cn.js"></script>
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
    <li><a href="#">栏目管理</a></li>
    <li><a href="#">News管理</a></li>
    </ul>
    </div>

    <div class="mainindex">
	<div class="uploadLoad clearfix">
		<input type="hidden" id="checkallID" value="" name="checkallID"/>
        <input id="delall_btn" type="button" class="btn" style="margin-left: 10px" value="批量删除" />
        <input id="add_btn" type="button" class="btn" value="添加" />
    </div>

    <table class="tablelist">
    	<thead>
    	<tr>
	        <th><input name="checkall" id="checkall" type="checkbox" value="" /></th>
	        <th>序号<i class="sort"><img src="../images/px.gif" /></i></th>
	        <th>新闻标题</th>
	        <th>作者</th>
	        <th>更新时间</th>
	        <th>审核状态</th>
        	<th>操作</th>
        </tr>
        </thead>
        <tbody>        
        <c:forEach var="item" items="${datalist }">
	        <tr>
	      	<td><input name="checkxx" type="checkbox" value="${item.getNewsid() }" /></td>
	      	<td>${item.getNewsid() }</td>
	        <td>${str:bSubstring(item.getNewstitle(),20) }</td>
	        <td>${item.getAuthor() }</td>
	        <td><fmt:formatDate value="${item.getUpdatetime()}" type="date" pattern="yyyy-MM-dd HH:mm"/></td>
	        <td>${item.getNewsstatus()==0?"待审核":"已审核" }</td>
	        <td><a onclick="javascript:modify(${item.getNewsid()},false)" href="#" class="modify"> 修改</a>
		        <a onclick="javascript:del(${item.getNewsid()})" href="#" class="tablelink removeBtn"> 删除</a></td>
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

    
    <!--  添加弹出-->
    <div class="tip uploadLoadShow" style="width:800px; left: 50%;margin-left: -400px;">
      <div class="tiptop"><span>提示信息</span><a></a></div>
    	<div class="tipinfo" style="height: 309px; overflow-y: scroll;">
		  	<div class="tipright">
		  		<div id="formTitle" class="formTitle">添加</div>
		  		<form id="add_form">
			  		<div class="group">
		                <label>标题：</label>
		                <input name="title" type="text" class="dfinput" />
	            	</div>
		            <div class="group">
		                <label>作者：</label>
		                <input name="author" type="text" class="dfinput" value="${loginUser.getAdminName() }"/>
		            </div>
		            <div class="group editorWrap">
		                <label>内容：</label>			
						<!-- 加载编辑器的容器 --> 
						<script id="newscontent" name="newscontent" type="text/plain" style="margin-left:85px;"></script>
		            </div>		  		
		    	</form>
		    	<div class="tipbtn">
		    	<input id="addbtn" type="button"  class="sure upload" value="确定" />&nbsp;
        		<input id="upcancelbtn" type="button"  class="cancel" value="取消" />
		        </div>
		    </div>
	    </div>
    </div>
    
    
    <!--  修改弹出-->
    <div class="tip modifyShow" style="width:800px; left: 50%;margin-left: -400px;">    
    	<div class="tiptop"><span>提示信息</span><a></a></div>
    	<div class="tipinfo" style="height: 309px; overflow-y: scroll;">
		  	<div class="tipright">
		  		<div id="modifyformTitle" class="formTitle">修改</div>
		  		<form id="modify_form">
		  			<input name="modifydtID" type="hidden" />
			  		<div class="group">
		                <label>标题：</label>
		                <input name="title2" type="text" class="dfinput" />
	            	</div>
		            <div class="group">
		                <label>作者：</label>
		                <input name="author2" type="text" class="dfinput" value="${loginUser.getAdminName() }"/>
		            </div>
		            <div class="group editorWrap">
		                <label>简介：</label>			
						<!-- 加载编辑器的容器 --> 
						<script id="newscontent2" name="newscontent2" type="text/plain" style="margin-left:85px;"></script>
		            </div>		  		
		    	</form>
		    	<div class="tipbtn">
		        <input id="modifybtn" type="button"  class="sure" value="确定" />&nbsp;
		        <input id="modifycancelbtn" type="button"  class="cancel" value="取消" />
		        </div>
		    </div>
	    </div>
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
    
    
    <!--  批量删除弹出-->
    <div class="tip cancelAllShow">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        <p>您确定要删除所有选中数据吗？</p>
        </div>
        </div>
        <div class="tipbtn">        
        <input id="delallbtn" type="button"  class="sure" value="确定删除" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    </div>
    
    </div>
   
    <script type="text/javascript">
    var ue = UE.getEditor('newscontent',{
    	initialFrameWidth:600,
    	initialFrameHeight:200,
    	scaleEnabled:true,
    	enterTag:''
    });
    var ue2 = UE.getEditor('newscontent2',{
    	initialFrameWidth:600,
    	initialFrameHeight:200,
    	scaleEnabled:true,
    	enterTag:''
    });
    
    function pagejump(nowpage){
    	window.location.href="newsManage?pageNow="+nowpage;
    }
    function pagejump2(){
    	var a=Number($("#userpage").val());
    	if(!isNaN(a)){
    		pagejump(a);
    	}    	
    }
    
    function modify(sampleid){
    	$.ajax({
    		type:"post",
  			url:"newsView?id="+sampleid,
  			dataType:"json",
  			success: function(objs){
  				if(objs.success){
  					var obj=objs.data;
  					$("input[name='modifydtID']").val(obj.newsid);
  					$("input[name='title2']").val(obj.newstitle);
  					$("input[name='author2']").val(obj.author);
  					ue2.setContent(obj.newscontent);
  					$(".modifyShow").fadeIn(200);			//打开修改窗口
  				}else{
  					layer.alert("数据不存在!",{icon:2});
  				}
  			}
    	});    	
    }
    </script>
    <script type="text/javascript">
    function del(id){
    	$("#delID").val(id);
    	$(".cancelShow").fadeIn(200);		//打开删除窗口
    }
    function del(id){
    	$("#delID").val(id);
    	$(".cancelShow").fadeIn(200);		//打开删除窗口
    }
    function delupdate(sampleid){
    	$.ajax({
			type:"get",
			url:"newsDel?id="+sampleid,
			dataType:"json",
			success: function(data){
				OperateResult(data,"删除");
				$(".cancelShow").fadeOut(200);		//关闭删除界面
			}
		});
    }
    </script>

    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	$(document).ready(function(){
   	 $("#delall_btn").click(function(){
      		$(".cancelAllShow").fadeIn(200);				//打开批量删除窗口
      	});
      
      $("#add_btn").click(function(){
          $(".uploadLoadShow").fadeIn(200);			//打开添加窗口
      	});
      
      $("#modifybtn").click(function(){		//确认修改		
    		$.ajax({
    			type:"post",			
    			url:"newsModify",
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
  			url:"newsAdd",
  			data:$("#add_form").serialize(),
  			dataType:"json",
  			success: function(data){
  				OperateResult(data,"添加");
  				$(".uploadLoadShow").fadeOut(200);		//关闭添加界面
  			}
  		});		
  	  });
        
        $("#delbtn").click(function(){
        	delupdate($("#delID").val());	//确认删除    		
    	  });
        
        $("#delallbtn").click(function(){
        	delupdate($("#checkallID").val());	//确认批量删除    		
    	  });
        
	    	
	    $(".tiptop a").click(function(){
	      $(".tip").fadeOut(200);
	    });
	
	    $(".cancel").click(function(){
	     	$(".tip").fadeOut(100);
	   	});
	
		$('.clearKeyWord').click(function(){
			$(this).prev().val('');
		});		
		
   });
	</script>
    
</body>
</html>
