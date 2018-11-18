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
<script type="text/javascript">
$(document).ready(function() {
    $("#nav>ul>li").hover(function(){$(this).children("ul").show();},function(){$(this).children("ul").hide();});
    $(".loginin").hide();
    
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
});
</script>
</head>
<body>
<div class="wrapper">
    
    <!-- top include-->
	<%@ include file="top.jsp" %>
    
    <!-- 主体 -->
    <div class="container">
        <div class="main">
            <div class="downwrap">
                <div class="applyDown clearfix" style="align-content="center">
                <form id="apply_form">
                    <div>
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
                        <span class="ml20">Sensors:</span>
                        <select class="" name="sensor" id="sensor">
                            <option value="0" selected="selected">SSMIS</option>
                            <option value="2">AMSR-2</option>
                        </select>
                        <span class="ml20">region:</span>
                        <select class="" name="sn" id="sn">
                            <option value="0" selected="selected">Arctic</option>
                            <option value="1">Antarctic</option>
                        </select>
                    </div>
                    <div style="margin-top:20px;">
                        <span>Time Selection:</span>
                        <input class="datainp" id="timeStart" name="timeStart" type="text" placeholder="start time" readonly=""> --
                        <input class="datainp" id="timeEnd" name="timeEnd" type="text" placeholder="end time" readonly="">
                    </div>
                    <div style="margin-top:20px;color:red;" id="label0">
                    </div>
                    <input id="applybtn" type="button" class="btn ft" value="Download">
                 </form>
                 </div>
              </div>
        </div>
    </div>
    <!-- /主体 -->
    <!-- 底部 -->
    <div class="cl"></div>
    <div class="footer">&copy; 2017 Joint Center for Global Change and China Green Development</div>
    <!-- /底部 -->
</div>


<script>
	function datechange(){
		if($("#timeStart").val()=="" || $("#timeEnd").val()==""){			
			$("#label0").html(" ");
			return;
		  }
		$.ajax({
			type:"get",
			url:"apply2",
			data:$("#apply_form").serialize(),
			dataType:"text",
			success: function(data){
				$("#label0").html(data);
			}
		});
	}

	$(document).ready(function(){
		
	  $("#applybtn").click(function(){
		  if($("#timeStart").val()=="" || $("#timeEnd").val()==""){
			  layer.alert("please select timeStart and timeEnd.");
			  return;
		  }
		  
		  $.ajax({
				type:"post",
				url:"apply",
				data:$("#apply_form").serialize(),
				dataType:"json",
				success: function(data){
					if(data.success){
						layer.alert("Your Application is submitted successfully,please download files from your person-center!");
					}else if(data.code==101){
						layer.alert('You must login before download the file!');						
					}else{
						layer.alert("I'm sorry,your application is submitted unsuccessfully!");
					}
				}
			});
	  });
	  
		//日期插件
		var timeStart={
			    dateCell: '#timeStart',
				isinitVal:true,
				isToday:false,
			    format: 'YYYY-MM-DD', // 分隔符可以任意定义，该例子表示只显示年月
			    maxDate: jeDate.now(0),  //最大日期
			    minDate: '1900-01-01', //最小日期
			    clearfun:function(){
			    	datechange();		//日期改变事件处理函数
			    	timeEnd.minDate='1900-01-01';
			    	timeEnd.maxDate=jeDate.now(0);
			    	$('#timeEnd').click(function(){jeDate(timeEnd);});
			    },
			    choosefun:function(obj){
			    	datechange();
			    	timeEnd.minDate=obj;
			    	var aa=new Date(obj.replace("-", "/")); 
					aa.setDate(aa.getDate()+365);
					var bb=new Date(jeDate.now(0).replace("-", "/"));
					if(aa<bb){
						timeEnd.maxDate=aa.Format("yyyy-MM-dd");
					}else{
						timeEnd.maxDate=jeDate.now(0);
					}
			    	$('#timeEnd').click(function(){jeDate(timeEnd);});
			    }			    
			};
		var timeEnd={
			dateCell: '#timeEnd', 
			isinitVal:true,
			isToday:false,
			format: 'YYYY-MM-DD', // 分隔符可以任意定义，该例子表示只显示年月
			maxDate: jeDate.now(0),  //最大日期
			minDate: '1900-01-01', //最小日期
			clearfun:function(){
		    	datechange();
		    	timeStart.minDate='1900-01-01';
		    	timeStart.maxDate=jeDate.now(0);
		    	$('#timeStart').click(function(){jeDate(timeStart);});
		    },
			choosefun:function(obj){
				datechange();
				var aa=new Date(obj.replace("-", "/")); 
				aa.setDate(aa.getDate()-365);
				timeStart.minDate=aa.Format("yyyy-MM-dd");
				timeStart.maxDate=obj;
				$('#timeStart').click(function(){jeDate(timeStart);});
			}
		};
		$('#timeStart').click(function(){jeDate(timeStart);});
		$('#timeEnd').click(function(){jeDate(timeEnd);});
	  
	});
</script>
</body>
</html>