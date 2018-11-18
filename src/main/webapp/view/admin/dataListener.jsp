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
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery.js"></script>
<script type="text/javascript" src="js/layer/layer.js"></script>
<script type="text/javascript" src="js/common_check.js"></script>
<script type="text/javascript" src="http://api.tianditu.com/api?v=4.0"></script>
<script type="text/javascript" src="js/jedate.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/jedate.css"rel="stylesheet"  type="text/css" />
<style type="text/css">body,html{width:100%;height:100%;margin:0;font-family:"Microsoft YaHei"}
#mapDiv{width:100%;height:600px}
.applyDown{margin-top: 20px;}
.tipinfo {padding: 30px 28px 0px; margin-left: 0; }
.datainp{ width:188px; height:30px; border:1px #ccc solid; padding-left: 10px;}
.jedatebox .jedateym .next:before,.jedatebox .jedateym .prev:before{margin-top: 11px;}
.dataGroup{margin-top: 15px;}
.clearfix {zoom:1;}
.clearfix:after {content:"";display:block;height:0;clear:both;visibility:hidden;}
.lt{float:left !important;}
.ft{float:right !important;}
.mapShow{line-height: 35px; margin-right: 20px;background: #edf6fa;padding: 0 10px;}
</style>
</head>
<body>
	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
	<li><a href="#">监测数据</a></li>
	<li><a href="#">${dt.getDtnameson() }</a></li>
    </ul>
    </div>
    <div class="mainindex">
    	<div id="mapDiv" ></div>
    	<div><input type="hidden" id="dtid" name="dtid" value="${dt.getDtid()}" /></div>
		<div class="downwrap">
			<div class="applyDown clearfix"><input name="" type="button" class="btn ft" value="申请下载" />
			<div class="mapShow ft" id="mapShow">请选择需要下载的地图标注点</div>
			</div>
		</div>

	<!-- 申请下载弹出 -->
		<div class="tip">
		<form id="applydownload">
		  <div class="tiptop"><span>提示信息</span><a></a></div>
		  <div class="tipinfo">
		  	<div>
		  		<input type="hidden" name="stationid" id="stationid" value="" />
		  		<input type="hidden" name="stationname" id="stationname" value="" />
		  		<input type="hidden" name="sdate" id="sdate" value="" />
		  		<input type="hidden" name="edate" id="edate" value="" />
		  	</div>
			<div class="tipright">
			<p id="tiplabel"></p>
			<div class="help" style="margin-top: 10px;">请选择您要下载的时间段</div>
			</div>
			<div class="dataGroup">
				<input class="datainp" id="timeStart" name="timeStart" type="text" placeholder="开始时间" readonly="" /> --
				<input class="datainp" id="timeEnd" name="timeEnd" type="text" placeholder="结束时间" readonly="" />
			</div>
			</div>
			<div class="tipbtn">
			<input id="applybtn" type="button"  class="sure" value="提交申请" />&nbsp;
			<input name="" type="button"  class="cancel" value="取消" />
			</div>
		</form>
		</div>
    </div>
    
	<script  type="text/javascript">	
	var map, marker;
	var zoom = 11;
	function LoadMap(objs) {
		 //初始化地图对象
		 map = new T.Map("mapDiv");
		 //设置显示地图的中心点和级别
		 //map.centerAndZoom(new T.LngLat(116.40093, 39.90313), zoom);
		 map.centerAndZoom(new T.LngLat(120.53, 31.25), zoom);

		 var definedOverlay = T.Overlay.extend({
			 initialize: function (lnglat, text, text2, options) {
				 this.lnglat = lnglat;
				 this.setOptions(options);
				 this._text = text;
				 this._overText = text2;
			 },

			 onAdd: function (map) {
				 this.map = map;
				 var div = this._div = document.createElement("div");
				 div.style.position = "absolute";
				 div.className = "mapBzShow";
				 div.style.backgroundColor = "#EE5D5B";
				 div.style.border = "1px solid #BC3B3A";
				 div.style.color = "white";
				 div.style.height = "18px";
				 div.style.padding = "2px";
				 div.style.lineHeight = "18px";
				 div.style.whiteSpace = "nowrap";
				 div.style.MozUserSelect = "none";
				 div.style.fontSize = "12px";
				 var span = this._span = document.createElement("span");
				 div.appendChild(span);
				 span.appendChild(document.createTextNode(this._text));
				 span.className = "stitle";
				 var that = this;

				var labelShow = this._labelShow =document.createElement("div");
				div.appendChild(labelShow);
				labelShow.appendChild(document.createTextNode(this._overText));
				labelShow.style.padding = "3px";
				labelShow.style.position = "absolute";
				labelShow.style.left = "54px";
				labelShow.style.top = "-1px";
				labelShow.style.display = "none";
				labelShow.className = "labelShow";
				labelShow.style.backgroundColor = "#6BADCA";

				 var arrow = this._arrow = document.createElement("div");
				 arrow.style.background = "url(http://map.baidu.com/fwmap/upload/r/map/fwmap/static/house/images/label.png) no-repeat";
				 arrow.style.position = "absolute";
				 arrow.style.width = "11px";
				 arrow.style.height = "10px";
				 arrow.style.top = "22px";
				 arrow.style.left = "10px";
				 arrow.style.overflow = "hidden";
				 div.appendChild(arrow);

				 div.onclick = function () {
					// if(flag){
					// 	labelShow.style.display = "block";
					// 	flag = false;
					// }else{
					// 	labelShow.style.display = "none";
					// 	flag = true;
					// }
				 }

				 map.getPanes().overlayPane.appendChild(this._div);
				 this.update(this.lnglat);
			 },

			 onRemove: function () {
				 var parent = this.div.parentNode;
				 if (parent) {
					 parent.removeChild(this.div);
					 this.map = null;
					 this.div = null;
				 }
			 },

			 setLnglat: function (lnglat) {
				 this.lnglat = lnglat;
				 this.update();
			 },
			 getLnglat: function () {
				 return this.lnglat;
			 },
			 setPos: function (pos) {
				 this.lnglat = this.map.layerPointToLngLat(pos);
				 this.update();
			 },
			 /**
			  * 更新位置
			  */
			 update: function () {
				 var pos = this.map.lngLatToLayerPoint(this.lnglat);
				 this._div.style.top = ( pos.y - 26) + "px";
				 this._div.style.left = (pos.x - 10) + "px";
			 }
		 });
		 		 
		 for(var j = 0;j<objs.length;j++){
			   var point = new T.LngLat(objs[j].longitude, objs[j].latitude);
			   var ss=objs[j].stationid+";"+objs[j].wqS.startDate+";"+objs[j].wqS.endDate;
			   var pdefinedOverlay = new definedOverlay(point, objs[j].stationname, ss, {});
			   map.addOverLay(pdefinedOverlay);
			}
			
		 $('.mapBzShow').click(function(){
			 //点击相应站点时更新当前数据
			 var text = $(this).find('.labelShow').text();
			 var strs=text.split(";");
			 $("#stationname").val($(this).find('.stitle').text());
			 $("#stationid").val(strs[0]);
			 $("#sdate").val(strs[1]);
			 $("#edate").val(strs[2]);
			 $('#mapShow').text("您当前选择选择的站点有"+strs[1]+"至"+strs[2]+"的监测数据");
		 });
	}
	</script>
	<script  type="text/javascript">	
	$(document).ready(function(){
		$.ajax({
			type:"post",			
			url:"stationList?id="+$("#dtid").val(),
			dataType:"json",
			success: function(data){
				if(data != null || data != ""){
					LoadMap(data);							
				}else{
					layer.alert("加载数据失败." + data);
				}
			}
		});
		
	  $(".applyDown .btn").click(function(){
		  if($("#sdate").val()==null || $("#sdate").val()=="" || $("#sdate").val()=="null"){
			  layer.alert("该站点无数据！",{icon:5});
		  }else{
			  //更新
			  var stext = "您要申请下载的数据有：";
			  stext += $("#stationname").val();
			  stext += "站点";
			  stext += $("#sdate").val();
			  stext += "至";
			  stext += $("#edate").val();
			  stext += "的数据";
			  $("#tiplabel").html(stext);
			  
			  //日期插件
			  $('#timeStart').click(function(){
				jeDate({
				    dateCell: '#timeStart',
					isinitVal:true,
				    format: 'YYYY-MM-DD', // 分隔符可以任意定义，该例子表示只显示年月
				    minDate: $("#sdate").val(), //最小日期
				    maxDate: $("#edate").val() //最大日期
				});
			  });
			  $('#timeEnd').click(function(){
				jeDate({
					dateCell: '#timeEnd',
					isinitVal:true,
					format: 'YYYY-MM-DD', // 分隔符可以任意定义，该例子表示只显示年月
					minDate: $("#sdate").val(), //最小日期
					maxDate: $("#edate").val() //最大日期
				});
			  });			  
			  $(".tip").fadeIn(200);
		  }
	  });

	  $(".tiptop a").click(function(){
	  $(".tip").fadeOut(200);
	});

	  $("#applybtn").click(function(){
		  $.ajax({
				type:"post",
				data:$("#applydownload").serialize(),
				url:"applyDownload",
				dataType:"json",
				success: function(data){
					if(data.success){
						layer.alert("已提交申请成功!",{icon:1});
					}else{
						layer.alert("提交申请失败.",{icon:5});
					}
					$(".tip").fadeOut(100);		//关闭界面
				}
		  });		 
	});

	  $(".cancel").click(function(){
	  $(".tip").fadeOut(100);
	});

	
	});
    </script>
</body>
</html>
