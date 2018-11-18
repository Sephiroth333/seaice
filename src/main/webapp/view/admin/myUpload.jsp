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
    <li><a href="#">我的上传</a></li>
    </ul>
    <input id="dtfatherid" type="hidden" value="${dtlist.get(0).getDtfatherid() }" />
    </div>

    <div class="mainindex">
	<div class="uploadLoad clearfix">
        <input id="upload_multi_btn" type="button" class="btn" style="margin-left: 10px" value="批量上传（ excel）" />
        <input style="display:none;" id="upload_btn" type="button" class="btn" value="上传数据" />
    </div>

    <table class="tablelist">
    	<thead>
    	<tr>
	        <th><input name="checkall" id="checkall" type="checkbox" value="" checked="checked"/></th>
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
	        <td><input type="text" class="search dfinput" placeholder="输入关键词"><a href="javascript:;" class="clearKeyWord">X</a></td>
			<td><input type="text" class="search dfinput" placeholder="输入关键词"><a href="javascript:;" class="clearKeyWord">X</a></td>
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
		        	<td><a onclick="javascript:modify(${wqsample.getSampleid()},false)" href="#" class="modify"> 修改</a><a onclick="javascript:del(${wqsample.getSampleid()})" href="#" class="tablelink removeBtn"> 删除</a></td>
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
    
    <!--  上传弹出-->
    <div class="tip uploadLoadShow" id="uploadLoadShow">
        <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo" style="max-height: 476px;overflow-y: scroll;">
        <div class="tipright">
            <div class="formTitle">上传数据</div>
			<div class="group">
				<label>分类选择：</label>
				<select id="typeSelectSingle" class="typeSelect" name="typeSelectSingle">
				<c:forEach var="dt" items="${dtlist}">
					<option value="${dt.getDtid()}">${dt.getDtnameson()}</option>
				</c:forEach>
				</select>
			</div>
            <div class="group">
                <label>监测点名称：</label>
                <input type="text" class="dfinput">
            </div>
            <div class="group">
                <label>样品名称：</label>
                <input type="text" class="dfinput">
            </div>
            <div class="group">
                <label>经度：</label>
                <input type="text" class="dfinput">
            </div>
            <div class="group">
                <label>纬度：</label>
                <input type="text" class="dfinput">
            </div>
            <div class="formTitleBot">请选择您的数据与平台指标的对应关系</div>
            <table class="tablelist" id="tablelistSingle">
                <tr>
                    <th>您的数据</th>
                    <th>平台指标</th>
                </tr>
                <tr>
                    <td>XX指标</td>
                    <td>
                        <select class="modalSelect" name="">
                            <option value="0">11111</option>
                            <option value="0">11111</option>
                            <option value="0">11111</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>XX指标</td>
                    <td>
                        <select class="modalSelect" name="">
                            <option value="0">11111</option>
                            <option value="0">11111</option>
                            <option value="0">11111</option>
                        </select>
                    </td>
                </tr>
				<tr>
					<td>XX指标</td>
					<td>
						<select class="modalSelect" name="">
							<option value="0">11111</option>
							<option value="0">11111</option>
							<option value="0">11111</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>XX指标</td>
					<td>
						<select class="modalSelect" name="">
							<option value="0">11111</option>
							<option value="0">11111</option>
							<option value="0">11111</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>XX指标</td>
					<td>
						<select class="modalSelect" name="">
							<option value="0">11111</option>
							<option value="0">11111</option>
							<option value="0">11111</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>XX指标</td>
					<td>
						<select class="modalSelect" name="">
							<option value="0">11111</option>
							<option value="0">11111</option>
							<option value="0">11111</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>XX指标</td>
					<td>
						<select class="modalSelect" name="">
							<option value="0">11111</option>
							<option value="0">11111</option>
							<option value="0">11111</option>
						</select>
					</td>
				</tr>
            </table>
        </div>
        </div>
		<div style="padding: 30px 28px 0px;">
			<span class="help" style="display:inline;">请选择excel上传： </span>
			<input type="file" class="excelUpload" value="excel上传">
		</div>
        <div class="tipbtn">
        <input id="upbtn" type="button"  class="sure upload" value="上传" />&nbsp;
        <input id="upcancelbtn" type="button"  class="cancel" value="取消" />
        </div>
    </div>
    
    <!--  批量上传（excel）弹出-->
    <div class="tip uploadLoadShow" id="uploadLoadMultiShow">
      <div class="tiptop"><span>提示信息</span><a></a></div>
      <div class="tipinfo" style="max-height: 476px;overflow-y: scroll;">
        <div class="tipright" id="upmulti1">
        <form id="excelUpload_form" enctype="multipart/form-data">
            <div class="formTitle">批量上传数据（from excel）</div>
			<div class="group">
				<label>分类选择：</label>
				<select id="typeSelectMulti" class="typeSelect" name="typeSelectMulti">
				<c:forEach var="dt" items="${dtlist}">
					<option value="${dt.getDtid()}">${dt.getDtnameson()}</option>
				</c:forEach>
				</select>
			</div>
			<div style="padding: 30px 28px 0px;">
				<span class="help" style="display:inline;">请选择excel上传： </span>
				<input name="excelfile" id="excelfile" type="file" class="excelUpload" value="excel上传">
			</div>
	        <div class="tipbtn">
		        <input id="upmultibtn" type="button"  class="sure upload" value="上传" />&nbsp;
		        <input id="upmulticancelbtn" type="button"  class="cancel" value="取消" />
	        </div>
	    </form>
		</div>		
        <div class="tipright" id="upmulti2" style="display:none">
        <form id="insertExcelData_form">
        	<div class="formTitle">批量上传数据（from excel）</div>        	
            <div><input type="hidden" id="indexCount" name="indexCount" value="" /></div>
            <div class="formTitleBot">请选择您的数据与平台指标的对应关系</div>
            <table class="tablelist"  id="tablelistMulti">
            </table>
            <div class="tipbtn">
		        <input id="submitmultibtn" type="button"  class="sure upload" value="提交" />&nbsp;
		        <input id="submitmulticancelbtn" type="button"  class="cancel" value="取消" />
	        </div>
        </form>
        </div>
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
    }
    </script>

    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
    $(document).ready(function(){

      $("#upload_btn").click(function(){
      $("#uploadLoadShow").fadeIn(200);				//打开上传窗口
      });
      
      $("#upload_multi_btn").click(function(){
          $("#uploadLoadMultiShow").fadeIn(200);	//打开批量上传窗口
          $("#upmulti1").show();
		  $("#upmulti2").hide();
          });
      
      $("#upmultibtn").click(function(){
    	  //上传excel
    	  $.ajax({
  			type:"post",
  			url:"uploadExcel",
  			data:new FormData($("#excelUpload_form")[0]),
  			dataType:"text",
  			processData: false,
  		    contentType: false,
  			success: function(data){
  				if(data == "error1"){
  					layer.alert("上传失败!");
  				}else if(data == "error2"){
  					layer.alert("解析excel失败!");
  				}else if(data == "error3"){
  					layer.alert("上传的excel存在多个sheet!");
  				}else{
  					data=$.trim(data).slice(0,-3);		//去除最后3个字符,,,
  					titles=data.split(",,,");
  					$("#indexCount").val(titles.length);	//指标数
  					var objs;
  					$.ajax({
  						type:"post",
  			  			url:"indexList",
  			  			dataType:"json",
  			  			async:false,		//禁用异步
  			  			success: function(indexlist){
  			  				objs=indexlist;
  			  			}  						
  					});
  					
  					//动态生成html
  					var w2='<option value="-9"></option>';
  					w2 +=  '<option value="-1">监测站点</option>';
  					w2 +=  '<option value="-2">样品编号</option>';
  					w2 +=  '<option value="-3">采样时间</option>';
  					for(var j = 0;j<objs.length;j++){
  						w2+='<option value="'+objs[j].indexid+'">'+objs[j].indexname+'</option>';
  					}
  					
  					var w1='<tr><th>您的数据</th><th>平台指标</th></tr>';
  					for (var i=0;i<titles.length;i++)
  					{
  						w1+='<tr><td>'+titles[i]+'</td>';
  						w1+='<td><select class="modalSelect" name="indexMulti_'+i+'" id="indexMulti_'+i+'">';
  						w1+=w2;
  					}
  					$("#tablelistMulti").html(w1);
  					$("#upmulti2").show();		//表示display:block, 
  					$("#upmulti1").hide();		//表示display:none; 
  				}
  			}
  		});
      });
      
      $("#submitmultibtn").click(function(){
    	  //写入excel数据
    	  $.ajax({
  			type:"post",
  			url:"insertExcelData",
  			data:$("#insertExcelData_form").serialize(),
  			dataType:"json",
  			success: function(objs){
  				//layer.alert(objs);
  				if(objs == null || objs == ""){
  					layer.alert("写入数据库失败!",{icon:2});
  				}else{
  					var mess="共成功写入"+objs.successCount+"条数据,有"+objs.unCount+"条数据写入失败.";
  					mess +=  "站点无法匹配数据：第"+objs.errorNoStation+"行.";
  					mess +=  "缺少关键列数据：第"+objs.errorNoCol+"行.";
  					mess +=  "写入样品记录失败数据：第"+objs.errorInsertSample+"行.";
  					mess +=  "写入指标值失败数据：第"+objs.errorInsertData+"行.";
  					layer.alert(mess,{icon:2});
  				}
  				$("#uploadLoadMultiShow").fadeOut(200);
  				window.location.reload();
  			}
    	});
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
        
        $("#delbtn").click(function(){		//确认删除
    		$.ajax({
    			type:"get",
    			url:"sampleDel?id="+$("#delID").val(),
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
