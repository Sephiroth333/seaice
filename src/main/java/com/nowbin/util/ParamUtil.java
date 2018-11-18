package com.nowbin.util;

public class ParamUtil {

	
	public static String replace(String param){
		
		String str = "";
		
		if(param.equals("1")){
			str = "会议简介";
		}
		if(param.equals("2")){
			str = "会议议程";
		}
		if(param.equals("3")){
			str = "组委会";
		}
		if(param.equals("4")){
			str = "在线投稿";
		}
		if(param.equals("5")){
			str = "在线报名";
		}
		if(param.equals("6")){
			str = "会议赞助";
		}
		if(param.equals("7")){
			str = "住宿";
		}
		if(param.equals("8")){
			str = "交通";
		}
		if(param.equals("9")){
			str = "会务组联系";
		}
		if(param.equals("78")){
			str = "住宿交通";
		}
		
		return str;
	}
	
}
