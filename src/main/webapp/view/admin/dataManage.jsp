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
    <li><a href="#">${dtlist.get(0).getDtnamefather() }</a></li>
    <li><a href="#">数据管理</a></li>
    </ul>
    <input id="dtfatherid" type="hidden" value="${dtlist.get(0).getDtfatherid() }" />
    </div>

    <div class="mainindex">
	<div class="uploadLoad clearfix">
		<input type="hidden" id="checkallID" value="" name="checkallID"/>
        <input id="delall_btn" type="button" class="btn" style="margin-left: 10px" value="批量删除" />
        <input id="checkall_btn" type="button" class="btn" value="批量审核" />
    </div>

    <table class="tablelist">
    	<thead>
    	<tr>
	        <th><input name="checkall" id="checkall" type="checkbox" value="" /></th>
	        <th>序号<i class="sort"><img src="images/px.gif" /></i></th>
	        <th>监测站点</th>
	        <th>采样编号（样品名称）</th>
	        <th>采样时间</th>
	        <th>上传人</th>
	        <th>上传时间</th>
	        <th>审核人</th>
	        <th>审核时间</th>
	        <th>审核状态</th>
        	<th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr class="searchTr">
			<td></td>
			<td></td>
	        <td><input type="text" class="search dfinput" placeholder="输入关键词" /><a href="javascript:;" class="clearKeyWord">X</a></td>
			<td><input type="text" class="search dfinput" placeholder="输入关键词" /><a href="javascript:;" class="clearKeyWord">X</a></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
        </tr>
        <c:forEach var="wqsample" items="${wqsamplelist }">
	        <tr>
	      	<td><input name="checkxx" type="checkbox" value="${wqsample.getSampleid() }" /></td>
	      	<td>${wqsample.getSampleid() }</td>
	        <td>${wqsample.getWqStation().getStationname() }</td>
	        <td>${wqsample.getSamplekid() }</td>
	        <td><fmt:formatDate value="${wqsample.getSampletime()}" type="date" pattern="yyyy-MM-dd"/></td>
	        <td>${wqsample.getUpdateUser().getRealname() }</td>
	        <td><fmt:formatDate value="${wqsample.getUpdatetime()}" type="date" pattern="yyyy-MM-dd"/></td>
	        <td>${wqsample.getCheckUser()!=null?wqsample.getCheckUser().getRealname():"" }</td>
	        <td><c:if test="${wqsample.getChecktime()!=null}"><fmt:formatDate value="${wqsample.getChecktime()}" type="date" pattern="yyyy-MM-dd"/></c:if></td>
	        <td>${wqsample.getCheckstatus()==0?"待审核":wqsample.getCheckstatus() ==1?"已审核":"不通过" }</td>
	        <c:choose>	        
		        <c:when test="${wqsample.getCheckstatus()==0 }">
		        	<td><a onclick="javascript:check(${wqsample.getSampleid()},false)" href="#" class="check"> 审核</a>
		        		<a onclick="javascript:modify(${wqsample.getSampleid()},false)" href="#" class="modify"> 修改</a>
		        		<a onclick="javascript:del(${wqsample.getSampleid()})" href="#" class="tablelink removeBtn"> 删除</a></td>
	        	</c:when>
	        	<c:otherwise>
	        		<td><a onclick="javascript:modify(${wqsample.getSampleid()},true)" href="#" class="modify"> 查看</a></td>
	        	</c:otherwise>
        	</c:choose>
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

    
    <!--  修改/查看弹出-->
    <div class="tip modifyShow">    
    	<div class="tiptop"><span>提示信息</span><a></a></div>
    	<div class="tipinfo" style="height: 309px; overflow-y: scroll;">
		  	<div class="tipright">
		  		<div id="modifyformTitle" class="formTitle">数据修改</div>
		  		<form id="modify_form">
		    	</form>
		    	<div class="tipbtn">
		    	<input id="modifyclosebtn" type="button"  class="cancel" value="关闭" />
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
    
    <!--  审核弹出-->
    <div class="tip checkShow">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        <p>您确定要审核所有选中数据吗？</p>
        </div>
        </div>
        <div class="tipbtn">
        <input type="hidden" id="checkID" value="" name="checkID"/>        
        <input id="checkbtn" type="button"  class="sure" value="审核通过" />&nbsp;
        <input id="uncheckbtn" type="button"  class="sure" value="审核不通过" />&nbsp;
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
        </div>
        <div class="tipbtn">        
        <input id="checkallbtn" type="button"  class="sure" value="审核通过" />&nbsp;
        <input id="uncheckallbtn" type="button"  class="sure" value="审核不通过" />&nbsp;
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
    function pagejump(nowpage){
    	window.location.href="dataManage?id="+$("#dtfatherid").val()+"&pageNow="+nowpage;
    }
    function pagejump2(){
    	var a=Number($("#userpage").val());
    	if(!isNaN(a)){
    		pagejump(a);
    	}    	
    }
    
    function modify(sampleid,readonly){
    	var w0=readonly?'readonly="readonly"':'';
    	var w1=readonly?'数据查看':'数据修改';
    	if(readonly){
    		$("#modifyclosebtn").show();
    		$("#modifybtn").hide();
    		$("#modifycancelbtn").hide();
		}else{
			$("#modifyclosebtn").hide();
    		$("#modifybtn").show();
    		$("#modifycancelbtn").show();
		}    	
    	$("#modifyformTitle").html(w1);
    	$.ajax({
    		type:"post",
  			url:"dataView?id="+sampleid,
  			dataType:"json",
  			success: function(objs){
  				if(objs.success){
  				//动态生成html
  					var w2='<input type="hidden" name="sampleid" value="'+sampleid+'" />';
  					for(var j = 0;j<objs.wqdatalist.length;j++){
  						var wqindex=objs.wqdatalist[j].wqindex;
  						w2+='<div class="group">';
  						w2+='<label>'+wqindex.indexname+'('+wqindex.indexunit+'):</label>';
  						w2+='<input type="text" name="dataid_'+objs.wqdatalist[j].id+'" class="dfinput"';
  						w2+=' value="'+objs.wqdatalist[j].datavalue+'" '+w0+' />';
  						w2+='</div>';
  					}
  					$("#modify_form").html(w2);
  					
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
    function check(id){
    	$("#checkID").val(id);
    	$(".checkShow").fadeIn(200);		//打开审核窗口
    }
    function checkupdate(sampleid,checkstatus){
    	$.ajax({
			type:"get",
			url:"sampleCheck?id="+sampleid+"&checkstatus="+checkstatus,
			dataType:"json",
			success: function(data){
				OperateResult(data,"审核");
				$(".cancelShow").fadeOut(200);		//关闭审核界面
			}
		});
    }
    function delupdate(sampleid){
    	$.ajax({
			type:"get",
			url:"sampleDel?id="+sampleid,
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
      
      $("#checkall_btn").click(function(){
          $(".checkAllShow").fadeIn(200);			//打开批量审核窗口
      	});
      
      $("#modifybtn").click(function(){		//确认修改		
    		$.ajax({
    			type:"post",			
    			url:"sampleModify",
    			data:$("#modify_form").serialize(),
    			dataType:"json",
    			success: function(data){
    				OperateResult(data,"修改");
    				$(".modifyShow").fadeOut(200);		//关闭修改界面
    			}
    		});		
    	  });
        
        $("#delbtn").click(function(){
        	delupdate($("#delID").val());	//确认删除    		
    	  });
        
        $("#delallbtn").click(function(){
        	delupdate($("#checkallID").val());	//确认批量删除    		
    	  });
        
	    $("#checkbtn").click(function(){
	    	checkupdate($("#checkID").val(),1);	//审核通过
	    });
	    $("#uncheckbtn").click(function(){
	    	checkupdate($("#checkID").val(),2);	//审核不通过
	    });
	    $("#checkallbtn").click(function(){
	    	checkupdate($("#checkallID").val(),1);	//批量审核通过
	    });
	    $("#uncheckallbtn").click(function(){
	    	checkupdate($("#checkallID").val(),2);	//批量审核不通过
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
		
		$("#checkall").click(function(){
			if($("#checkall").prop('checked')){
				$("input[type='checkbox']").each(function () { 
		            if (!$(this).prop("checked")) 
		               $(this).prop("checked", true); 
		         });
			}else{
				$("input[type='checkbox']").each(function () { 
		            if ($(this).prop("checked")) 
		            	$(this).prop("checked", false);
		         });
			}
		});
		$("input[type=checkbox]").click(function (){
			$("#checkallID").val("");
			$("input:checked").each(function(){
				if($(this).val() != ""){
					$("#checkallID").val($("#checkallID").val()+"_"+$(this).val());
				}
			});
		});
   });
	</script>
    
</body>
</html>
