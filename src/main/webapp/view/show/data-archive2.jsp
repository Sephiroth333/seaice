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
<link type="text/css" rel="stylesheet" href="css/style.css"/>
<link type="text/css" rel="stylesheet" href="css2/jedate.css">
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
.lt{float:left !important;}
.ft{float:right !important;}
</style>
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="js/layer/layer.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/jedate.js"></script>
<script type="text/javascript" src="js/common_check.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    $("#nav>ul>li").hover(function(){$(this).children("ul").show();},function(){$(this).children("ul").hide();});
    $(".loginin").hide();
});
</script>
</head>
<body>
<div class="wrapper">
    
    <!-- top include-->
	<%@ include file="top.jsp" %>
    
    <!-- 主体 -->
    <div class="container">
        <!--边栏-->
        <div class="sidebar">
            <dl class="side-nav">
                <dt>Sea Ice</dt>
                <dd>
                    <ul>
                    <c:forEach var="dt" items="${dtlist}">
                    	<c:if test="${dt.getDtid()==nowdt.getDtid() }"><li class="selected"><cite></cite><a href="archive2?id=${dt.getDtid() }" title="${dt.getDtname() }">${str:bSubstring(dt.getDtname(),20) }</a></li>
                    	</c:if>
                    	<c:if test="${dt.getDtid()!=nowdt.getDtid() }"><li><cite></cite><a href="archive2?id=${dt.getDtid() }" title="${dt.getDtname() }">${str:bSubstring(dt.getDtname(),20) }</a></li>
                    	</c:if>
                    </c:forEach>
                    </ul>
                </dd>
            </dl>
        </div>
        <!--/边栏-->
        <!--主体2-->
        <div class="main">
            <div class="downwrap">            	
                <div class="applyDown clearfix">
                <input type="hidden" id="checkallID" value="" name="checkallID"/>
                <input id="checkall_btn" type="button" class="btn ft" value="Download all checked">
                </div>
              </div>
             <div class="mt20">
                <table class="tablelist">
                    <thead>
                        <tr>
                        	<th><input name="checkall" id="checkall" type="checkbox" value="" /></th>
                            <th>ID</th>
                            <th>File Name</th>
                            <th>File Size</th>
                            <th>Create Date</th>
                            <th>Opt</th>
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
                            <td><a href="download?id=${item.getLocaldataid()}&iu=${user!=null?user.getUserid():0}" class="check">download</a></td>
                        </tr>
	                    </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <!--  分页-->
          <div class="paging">
            <div class="page">
            <ul class="clearfix">
	            <li class="prev">
	           	<c:choose>
					<c:when test="${page.pageNow == 1 }">
						<a href="#">pre</a>
					</c:when>
					<c:otherwise>
						<a href='javascript:pagejump(${page.pageNow-1 });'>pre</a>
					</c:otherwise>
				</c:choose>
				</li>
			
			<c:choose>
				<c:when test="${page.totalPageCount <= 5 }">
					<c:forEach begin="1" end="${page.totalPageCount }" varStatus="obj">
						<c:choose>
							<c:when test="${obj.index == page.pageNow }">
								<li class="on"><a href="#">${obj.index}</a></li>
							</c:when>
							<c:otherwise>
								<li>
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
											<li class="on"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li>
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
											<li class="on"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li>
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
											<li class="on"><a href="#">${obj.index}</a></li>
										</c:when>
										<c:otherwise>
											<li>
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
			
			<li class="next">
           	<c:choose>
				<c:when test="${page.pageNow == page.totalPageCount }">
					<a href="#">next</a>
				</c:when>
				<c:otherwise>
					<a href='javascript:pagejump(${page.pageNow+1 });'>next</a>
				</c:otherwise>
			</c:choose>
			</li>			

            </ul>
            </div>
        </div>
        <script type="text/javascript">
        function pagejump(nowpage){
    		window.location.href="archive?id=${nowdt.getDtid()}&pageNow="+nowpage;
    	}
        </script>
        </div>
        
        <!--  批量下载弹出-->
	    <div class="tip checkAllShow">
	        <div class="tiptop"><span>Tip</span><a></a></div>
	      <div class="tipinfo">
	        <div class="tipright">
	        <p>Are you sure you want to download all the selected data?</p>
	        </div>
	        </div>
	        <div class="tipbtn">        
	        <input id="checkallbtn" type="button"  class="sure" value="I'm sure" />&nbsp;
	        <input name="" type="button"  class="cancel" value="Cancel" />
	        </div>
	    </div>

<!-- 
        <div class="tip">
            <div class="tiptop"><span>prompt</span><a></a></div>
            <div class="tipinfo">
            <div class="tipright">
            <p>The data that you try to download have data from 2011/11/11 to 2012/11/11.</p>
            <div class="help" style="margin-top: 10px;">Please select the time period you want to download</div>
            </div>
            <div class="dataGroup">
              <input class="datainp" id="timeStart" type="text" placeholder="start time" readonly=""> --
              <input class="datainp" id="timeEnd" type="text" placeholder="end time" readonly="">
            </div>
            </div>
            <div class="tipbtn">
            <input name="" type="button"  class="sure" value="submit" />&nbsp;
            <input name="" type="button"  class="cancel" value="cancel" />
            </div>
          </div>
-->
        <!--/主体2-->
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /底部 -->
</div>


<script>
	$(document).ready(function(){
	  $(".applyDown .btn").click(function(){
	  $(".checkAllShow").fadeIn(200);
	  });

	  $(".tiptop a").click(function(){
	  $(".tip").fadeOut(200);
	});

	  $(".sure").click(function(){
		  $.ajax({
				type:"get",
				url:"downloadmulti?id="+$("#checkallID").val(),
				dataType:"json",
				success: function(data){
					if(data.success){
						layer.alert("Your Application is submitted successfully,please download files from your person-center!");
					}else if(data.code==101){
						layer.alert('You must login before download the file!');						
					}else{
						layer.alert("I'm sorry,your application is submitted unsuccessfully!");
					}
					$(".tip").fadeOut(100);
				}
			});
	});

	  $(".cancel").click(function(){
	  $(".tip").fadeOut(100);
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