<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<style>
.uploadLoad{margin-bottom: 20px;}
.uploadLoad .btn{float: right;}
.dfinput{height: 25px;}
</style>
</head>


<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
	<li><a href="#">系统管理</a></li>
    <li><a href="#">管理员管理</a></li>
    </ul>
    </div>

    <div class="mainindex">
	<div class="uploadLoad clearfix">
        <input type="button" class="btn" value="添加" />
    </div>

    <table class="tablelist">
    	<thead>
    	<tr>
    	<th>用户名</th>
        <th>邮箱</th>
        <th>用户类型</th>
        <th>用户状态</th>
        <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${dtlist }">
        <tr>
        	<td>${item.getAdminName() }</td>
        	<td>${item.getAdminEmail() }</td>
        	<td>${item.getAdminRole()==2?"超级管理员":item.getAdminRole()==1?"管理员":"普通用户" }</td>
        	<td>${item.getAdminStatus()==2?"管理员禁用":item.getAdminStatus()==1?"验证通过":"待验证邮箱" }</td>
        	<td><a onclick="javascript:modify(${item.getAdminId()})" href="#" class="modify">管理</a>
        		<a onclick="javascript:del(${item.getAdminId()})" href="#" class="tablelink removeBtn">删除</a>
        		<a onclick="javascript:reset(${item.getAdminId()})" href="#" class="reset">重置</a>
        	</td>
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
            <div class="formTitle">用户管理</div>
            <div><input id="userid" name="userid2" type="hidden" value="" /></div>
            <div class="group">
                <label>用户名：</label>
                <input id="loginname" name="loginname2" type="text" class="dfinput" placeholder="请输入邮箱" />
            </div>
            <div class="group">
                <label>邮箱：</label>
                <input id="loginemail" name="loginemail2" type="text" class="dfinput" placeholder="请输入邮箱" />
            </div>
            <div class="group">
                <label>用户类型：</label>
                <select id="usertype" class="typeSelect" name="usertype2">
                	<option value="1">管理员</option>
                	<option value="2">超级管理员</option>
                </select>
            </div>
            <div class="group">
                <label>账号状态：</label>
                <select id="userstatus" class="typeSelect" name="userstatus2">
                	<option value="0">待验证邮箱</option>
                	<option value="1">验证通过</option>
                	<option value="2">禁用</option>
                </select>
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
    <!--  重置弹出-->
    <div class="tip resetShow">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        <p>您确定要重置该用户密码吗？</p>
        </div>
		<div class="group">
        	<label>重置后密码将发送至该用户注册邮箱!</label>
        </div>
        </div>
        <div class="tipbtn">
        <input type="hidden" id="resetID" value="" name="resetID"/>
        <input id="resetbtn" type="button"  class="sure" value="确定重置" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    </div>
    <!--  添加弹出-->
    <div class="tip uploadLoadShow">
    <form id="add_form">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
            <div class="formTitle">添加用户</div>
            <div class="group">
                <label>用户名：</label>
                <input id="loginname" name="loginname" type="text" class="dfinput" placeholder="请输入邮箱" />
            </div>
            <div class="group">
                <label>邮箱：</label>
                <input id="loginemail" name="loginemail" type="text" class="dfinput" placeholder="请输入邮箱" />
            </div>
             <div class="group">
                <label>初始密码：</label>
                <input id="pwd" name="pwd" type="text" class="dfinput" placeholder="请输入初始密码" />
            </div>
            <div class="group">
                <label>用户类型：</label>
                <select id="usertype" class="typeSelect" name="usertype">
                	<option value="1">管理员</option>
                	<option value="2">超级管理员</option>
                </select>
            </div>
        </div>
        </div>
        <div class="tipbtn">
        <input id="addbtn" type="button"  class="sure" value="添加" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    </form>
    </div>
    </div>
    <script type="text/javascript">
    function pagejump(nowpage){
    	window.location.href="adminManage?&pageNow="+nowpage;
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
			url:"singleAdmin?id="+id,
			dataType:"json",
			success: function(data){
				if(data != null){
					$("#userid").val(data.adminId);
					$("#loginname").val(data.adminName);
					$("#loginemail").val(data.adminEmail);
					$("#usertype").val(data.adminRole);
					$("#userstatus").val(data.adminStatus);
					$(".modifyShow").fadeIn(200);		//弹出修改界面
				}
			}
		});
	}
    
    function del(id){
    	$("#delID").val(id);
    	$(".cancelShow").fadeIn(200);			//弹出删除界面
    }
    function reset(id){
    	$("#resetID").val(id);
    	$(".resetShow").fadeIn(200);			//弹出重置界面
    }
    </script>

    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
    $(document).ready(function(){
    	 $(".uploadLoad .btn").click(function(){
	     $(".uploadLoadShow").fadeIn(200);		//弹出添加界面
	     });
	
	     $(".tiptop a").click(function(){
	     $(".tip").fadeOut(200);				//取消（弹出界面右上角）
	   });
	
	     $(".cancel").click(function(){
	     $(".tip").fadeOut(100);				//取消，弹出界面按钮
	   });
      
      $("#modifybtn").click(function(){		//确认修改		
  		$.ajax({
  			type:"post",			
  			url:"adminModify",
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
  			url:"adminAdd",
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
  			url:"adminDel?id="+$("#delID").val(),
  			dataType:"json",
  			success: function(data){
  				OperateResult(data,"删除");
  				$(".cancelShow").fadeOut(200);		//关闭删除界面
  			}
  		});
  	});
  	
  	$("#resetbtn").click(function(){		//确认重置
  		$.ajax({
  			type:"get",
  			url:"adminReset?id="+$("#resetID").val(),
  			dataType:"json",
  			success: function(data){
  				OperateResult(data,"重置");
  				$(".cancelShow").fadeOut(200);		//关闭重置界面
  			}
  		});
  	});

    });
	</script>
</body>
</html>
