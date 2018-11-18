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
<script type="text/javascript">
$(document).ready(function() {
    
    $("#datatype").change(function(){
		  var p1=$(this).children('option:selected').val();//这就是selected的值
		  if(p1=="1"){
			  $("#sensor").html('<option value="0" selected="selected">SSMIS</option>'+
                    '<option value="2">AMSR-2</option>');
		  }else if(p1=="5"){
			  $("#sensor").html('<option value="0" selected="selected">SMOS</option>');
		  }else if(p1=="11"){
			  $("#sensor").html('<option value="0" selected="selected">AVHRR</option>');
		  }else{
			  $("#sensor").html('<option value="0" selected="selected">MODIS</option>');
		  }		  
	  });
    
    $("#submitbtn").click(function(){
 	   var dtid2=parseInt($("#datatype").val())+parseInt($("#sensor").val())+parseInt($("#sn").val());
 	   window.location.href="archive?id="+dtid2;
    });
    
    var dtid2=parseInt($("#dtid2").val());
    var sn=(dtid2+1)%2;
    var sensor=0;
    if(dtid2-sn >=3 && dtid2-sn <=4){
    	sensor=2;
    }
    var datatype=dtid2-sn-sensor;
    //alert("datatype="+datatype+",sensor="+sensor+",sn="+sn);
    $("#datatype option[value='"+datatype+"']").attr("selected","selected");
    $("#datatype").trigger("change");	//触发change事件
    $("#sensor option[value='"+sensor+"']").attr("selected","selected"); 
    $("#sn option[value='"+sn+"']").attr("selected","selected");
    
});
function checklocaldata(id,obj){
	$.ajax({
		type:"get",
		url:"checklocaldata?id="+id,
		dataType:"json",
		success: function(data){
			if(data.success){
				$(obj).html($(obj).html()=="是"?"否":"是");
			}
		}
	});
}
</script>
</head>
<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
	<li><a href="#">数据管理</a></li>
    <li><a href="#">数据管理</a></li>
    </ul>
    <input id="dtid2" type="hidden" value="${id }" />
    </div>
    
    <div class="mainindex">
	   <div class="clearfix" style="margin-bottom:20px;">
	               <span>Data Type:</span>
	               <select class="" name="datatype" id="datatype">
	                   <option value="1" selected="selected">Sea Ice Concentration</option>
	                   <option value="5">Sea Ice Thickness</option>
	                   <option value="7">Melt Ponds</option>
	                   <option value="9">Sea Ice Leads</option>
	                   <option value="13">Sea Ice Drift</option>
	                   <option value="11">Sea surface temperature</option>
	                   <option value="15">Sea surface winds</option>
	               </select>
	               <span>Sensors:</span>
	               <select class="" name="sensor" id="sensor">
	                   <option value="0" selected="selected">SSMIS</option>
	                   <option value="2">AMSR-2</option>
	               </select>
	               <span>projection:</span>
	               <select class="" name="prj" id="prj">
	                   <option value="0" selected="selected">Pole Stereographic</option>
	                   <option value="1">Equal Area Scalable Earth</option>
	                   <option value="2">Geographic Coordinate</option>
	               </select>
	               <span>region:</span>
	               <select class="" name="sn" id="sn">
	                   <option value="0" selected="selected">North Polar</option>
	                   <option value="1">South Polar</option>
	               </select>
	               <input id="submitbtn" type="button" class="btn ft" value="提交">	           
	        </div>
    		<table class="tablelist">
                    <thead>
                        <tr>
                        	<th><input name="checkall" id="checkall" type="checkbox" value="" /></th>
                            <th>序号</th>
                            <th>文件名</th>
                            <th>数据大小</th>
                            <th>生成时间</th>
                            <th>是否展示</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach var="item" items="${datalist}">
	                    <tr>
	                    	<td><input name="checkxx" type="checkbox" value="${item.getLocaldataid()}" /></td>
                            <td>${item.getLocaldataid() }</td>
                            <td>${item.getFilename()}.zip</td>
                            <td>${str:StrSize(item.getFilesize())}</td>
                            <td><fmt:formatDate pattern="yyyy/MM/dd HH:mm" value="${item.getDataprocessedtime() }" /></td>
                            <td><a href="javascript:void(0);" onclick="checklocaldata(${item.getLocaldataid()},this)" class="check">${item.getIschecked()==1?"是":"否" }</a></td>
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
    	window.location.href="archive?id="+$("#dtid2").val()+"&pageNow="+nowpage;
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