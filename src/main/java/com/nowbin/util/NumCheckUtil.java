package com.nowbin.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NumCheckUtil {
	
	public static boolean isNumeric(String str){ 
	   Pattern pattern = Pattern.compile("^[0-9]+$"); 
	   Matcher isNum = pattern.matcher(str);
	   if( !isNum.matches() ){
	       return false; 
	   } 
	   return true; 
	}
	
	public static boolean isInteger(String str){ 
	   Pattern pattern = Pattern.compile("^-?[0-9]+$"); 
	   Matcher isNum = pattern.matcher(str);
	   if( !isNum.matches() ){
	       return false; 
	   } 
	   return true; 
	}
	
	public static boolean isDouble(String str){
		//sPattern pattern = Pattern.compile("^-?([1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*|0?\\.0+|0)$");
		Pattern pattern = Pattern.compile("^(\\-)?([0-9])+(.[0-9]{1,})?$");
		Matcher isNum = pattern.matcher(str);
		if( !isNum.matches() ){
			return false; 
		}
		return true;
	}
}
