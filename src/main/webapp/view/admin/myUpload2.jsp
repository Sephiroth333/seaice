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
<link href="css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/common_check.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="js/select-ui.min.js"></script>
<script type="text/javascript" src="js/layer/layer.js"></script>
<script type="text/javascript" src="UEditor/ueditor.config.js"></script>
<script type="text/javascript" src="UEditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="UEditor/lang/zh-cn/zh-cn.js"></script>
<style>
.uploadLoad{margin-bottom: 20px;}
.uploadLoad .btn{float: right;}
.dfinput{height: 25px;}
.tablelinkShow .group label{text-align: left;width: auto;}
.formTitle{text-align: center;}
.plusBtn{ width: 70px; height: 28px; line-height: 28px; }
.tipright .editorWrap >table{display: inline-block;vertical-align: top;}
.searchTr{height: 40px;}
.searchTr input{width: auto;}
.clearKeyWord{margin-left: 4px;    font-size: 12px; color: #999;}
</style>
</head>
<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">${dtlist.get(0).getDtnamefather() }</a></li>
    <li><a href="#">我的上传</a></li>
    </ul>
    <input id="dtfatherid" type="hidden" value="${dtlist.get(0).getDtfatherid() }" />
    </div>

    <div class="mainindex">
	<div class="uploadLoad clearfix">
        <input id="upload_btn" type="button" class="btn" value="上传数据">
    </div>

    <table class="tablelist">
    	<thead>
    	<tr>
	        <th><input name="checkall" id="checkall" type="checkbox" value="" /></th>
	        <th>序号<i class="sort"><img src="images/px.gif" /></i></th>
	        <th>数据名称</th>
	        <th>数据类型</th>
	        <th>数据介绍</th>
	        <th>缩略图</th>
	        <th>数据大小</th>
	        <th>上传人id</th>
	        <th>上传时间</th>
	        <th>审核人id</th>
	        <th>审核时间</th>
	        <th>审核状态</th>
        	<th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr class="searchTr">
			<td></td>
			<td></td>
	        <td><input type="text" class="search dfinput" placeholder="输入关键词"><a href="javascript:;" class="clearKeyWord">X</a></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
        </tr>
        <c:forEach var="data" items="${datalist }">
	        <tr>
	      	<td><input name="checkxx" type="checkbox" value="${data.getId() }" /></td>
	      	<td>${data.getId() }</td>
	        <td>${data.getDataname() }</td>
	        <td>${data.getDtid() }</td>
	        <td>${data.getDataintroduce().length()>10?data.getDataintroduce().substring(0,10):data.getDataintroduce()}</td>
	        <td><img src="${data.getDatathumbnail() }" height="50" width="50"/></td>
	        <td>${data.getDatasize() }</td>
	        <td>${data.getUpdateid() }</td>
	        <td><fmt:formatDate value="${data.getUpdatetime()}" type="date" pattern="yyyy-MM-dd"/></td>
	        <td>${data.getCheckid()!=null?data.getCheckid():"" }</td>
	        <td><c:if test="${data.getChecktime()!=null}"><fmt:formatDate value="${data.getChecktime()}" type="date" pattern="yyyy-MM-dd"/></c:if></td>
	        <td>${data.getCheckstatus()==0?"待审核":data.getCheckstatus() ==1?"已审核":"不通过" }</td>
	        <c:choose>	        
		        <c:when test="${data.getCheckstatus()==0 }">
		        	<td><a onclick="javascript:modify(${data.getId()})" href="#" class="modify"> 修改</a><a onclick="javascript:del(${data.getId()})" href="#" class="tablelink removeBtn"> 删除</a></td>
	        	</c:when>
	        	<c:otherwise>
	        		<td></td>
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
    
    <!--  修改弹出-->
    <div class="tip modifyShow"  style="width:800px; left: 50%;margin-left: -400px;">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        <form id="modify_form" enctype="multipart/form-data">
        	<input id="dataid" name="dataid" type="hidden" value="" />
            <div class="formTitle">数据修改</div>
            <div class="group">
                <label>数据名称：</label>
                <input name="dataname2" type="text" class="dfinput">
            </div>
            <div class="group">
                <label>缩略图：</label>
                <input id="imgfile2" name="imgfile2" type="file" class="">                
            </div>
            <div class="group">
            	<label>缩略图预览：</label>
            	<img id="thumbnail2" name="thumbnail2" src="" style="display:none" />
            </div>
            <div class="group editorWrap">
                <label>数据介绍：</label>
                <!-- <input type="text" class="dfinput"> -->
				<!--<textarea id="content2" name="content2" style="width:608px;height:250px;visibility:hidden;"></textarea>-->
				<!-- 加载编辑器的容器 --> 
				<script id="content2" name="content2" type="text/plain" style="margin-left:85px;">
				</script>
            </div>
        </form>
        </div>
        </div>
        <div class="tipbtn">
        <input id="modifybtn" type="button"  class="sure" value="确定" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
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
    <!--  上传弹出-->
    <div class="tip uploadLoadShow" style="width:800px; left: 50%;margin-left: -400px;">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo">
        <div class="tipright">
        <form id="upload_form" enctype="multipart/form-data">
        	<div class="formTitle">上传数据</div>
			<div class="group">
				<label>分类选择：</label>
				<select id="datatype1" class="typeSelect" name="datatype1">
				<c:forEach var="dt" items="${dtlist}">
					<option value="${dt.getDtid()}">${dt.getDtnameson()}</option>
				</c:forEach>
				</select>
			</div>
            <div class="group">
                <label>上传数据：</label>
                <input name="datafile1" type="file" class="">
            </div>
            <div class="group">
                <label>数据名称：</label>
                <input name="dataname1" type="text" class="dfinput">
            </div>
            <div class="group">
                <label>缩略图：</label>
                <input id="imgfile1" name="imgfile1" type="file" class="">                
            </div>
            <div class="group">
            	<label>缩略图预览：</label>
            	<img id="thumbnail1" name="thumbnail1" src="" style="display:none" />
            </div>
            <div class="group editorWrap">
                <label>数据介绍：</label>
                <!-- <input type="text" class="dfinput"> -->
				<!--<textarea id="content1" name="content1" style="width:608px;height:250px;visibility:hidden;"></textarea>-->				
				<!-- 加载编辑器的容器 --> 
				<script id="content1" name="content1" type="text/plain" style="margin-left:85px;">
				</script>
            </div>
        </form>
        </div>
        </div>
        <div class="tipbtn">
        <input id="upbtn" type="button"  class="sure upload" value="上传" />&nbsp;
        <input id="upcancelbtn" type="button"  class="cancel" value="取消" />
        </div>
    </div>
    </div>
    
    <script type="text/javascript">
	    function pagejump(nowpage){
	    	window.location.href="myUpload?id="+$("#dtfatherid").val()+"&pageNow="+nowpage;
	    }
	    function pagejump2(){
	    	var a=Number($("#userpage").val());
	    	if(!isNaN(a)){
	    		pagejump(a);
	    	}    	
	    }
	    function del(id){
	    	$("#delID").val(id);
	    }
	    function modify(id){
	    	$("#dataid").val(id);
	    	$.ajax({
	    		type:"post",
	  			url:"dataView2?fid="+$("#dtfatherid").val()+"&id="+id,
	  			dataType:"json",
	  			success: function(objs){
	  				if(objs.success){
	  					var obj=objs.data;
	  					$("input[name='dataname2']").val(obj.dataname);
	  					$("img[name='thumbnail2']").prop("src",obj.datathumbnail);
	  					$("img[name='thumbnail2']").show();
	  					//$("#content2").val(obj.dataintroduce);
	  					ue2.setContent(obj.dataintroduce);
	  					$(".modifyShow").fadeIn(200);			//打开修改窗口
	  				}else{
	  					layer.alert("数据不存在!",{icon:2});
	  				}
	  			}
	    	});
	    }
    </script>

    <script type="text/javascript">
    var ue = UE.getEditor('content1',{
    	initialFrameWidth:600,
    	initialFrameHeight:200,
    	scaleEnabled:true,
    	enterTag:''
    });
    var ue2 = UE.getEditor('content2',{
    	initialFrameWidth:600,
    	initialFrameHeight:200,
    	scaleEnabled:true,
    	enterTag:''
    });
    
	$('.tablelist tbody tr:odd').addClass('odd');
    $(document).ready(function(){
      $(".modify").click(function(){
        $(".modifyShow").fadeIn(200);
      });

      $("#upload_btn").click(function(){
        $(".uploadLoadShow").fadeIn(200);				//打开上传窗口
      });
      
      $("#upbtn").click(function(){			//确认上传
    	  var formData=new FormData($("#upload_form")[0]);
    	  formData.append("fid",$("#dtfatherid").val());
    	  $.ajax({
  			type:"post",
  			url:"uploadData",
  			data:formData,
  			dataType:"text",
  			processData: false,
  		    contentType: false,
  			success: function(data){
  				if(data != ""){
  					layer.confirm("上传成功!更新数据"+data+"条.",{icon:1,btn:'确定'},function(){
  						window.location.reload();
  					});
  				}else{
  					layer.alert("上传失败.");
  				}
  				$(".uploadLoadShow").fadeOut(200);		//关闭上传界面
  			}
  		});
      });
      
      $("#modifybtn").click(function(){		//确认修改
    	data1=$("#modify_form").serialize()+"&"+$.param({fid:$("#dtfatherid").val()});
  		$.ajax({
  			type:"post",			
  			url:"dataModify",
  			data:data1,
  			dataType:"json",
  			success: function(data){
  				OperateResult(data,"修改");
  				$(".modifyShow").fadeOut(200);		//关闭修改界面
  			}
  		});		
  	  });
      
      $("#delbtn").click(function(){		//确认删除
  		$.ajax({
  			type:"get",
  			url:"dataDel?fid="+$("#dtfatherid").val()+"&id="+$("#delID").val(),
  			dataType:"json",
  			success: function(data){
  				OperateResult(data,"删除");
  				$(".cancelShow").fadeOut(200);		//关闭删除界面
  			}
  		});
  	  });
      
      
      $(".removeBtn").click(function(){
        $(".cancelShow").fadeIn(200);
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
