$(function(){	
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

function OperateResult(obj,opt){
	if(obj.success){
		layer.confirm(opt+"成功!更新数据"+obj.count+"条.",{icon:1,btn:'确定'},function(){
			window.location.reload();
		});			
	}else{
		if(obj.code == 101){
			layer.alert(opt+"失败."+obj.mess);
		}else if(obj.code > 200 && obj.code <300){
			layer.alert(opt+"失败.输入信息不完整");
		}else if(obj.code == -9){
			layer.alert(opt+"失败.权限不足");
		}else if(obj.code < 0){
			window.parent.location.href="login?id="+obj.code;
		}else{
			window.parent.location.href="error?code="+obj.code;
		}
	}
}
