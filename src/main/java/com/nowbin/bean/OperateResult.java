package com.nowbin.bean;

/*
 * ajax操作返回结果类
 * by Aeolus 
 * 
 */
public class OperateResult {

	private boolean success;	//是否操作成功
	
	private Integer count;		//更新数据条数
	
	private Integer code;		//错误代码
	
	private String mess;		//错误信息
	
	public OperateResult(){
		this.success=false;
		this.code=400;	//默认错误代码
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
		if(count > 0){
			this.success=true;
		}else if(count<=0){
			this.success=false;
			this.code=101;
		}		
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMess() {
		return mess;
	}

	public void setMess(String mess) {
		this.mess = mess;
	}
	
}
