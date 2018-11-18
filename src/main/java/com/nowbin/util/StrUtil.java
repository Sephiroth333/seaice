package com.nowbin.util;

public class StrUtil {

	public static boolean IsNullOEmpty(Object o){
		
		boolean flag = false;
		
		if(o==null||o.equals("")){
			flag = true;
		}
		
		return flag;
	}
}
