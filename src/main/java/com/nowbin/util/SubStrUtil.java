package com.nowbin.util;

import java.text.DecimalFormat;

public class SubStrUtil {
	
	public static String bSubstring(String s, int length) throws Exception {

		if(s.length()*2<length){
			return s;
		}
		
		if(s==null||s.equals("")){
			return "";
		}
		byte[] bytes = s.getBytes("Unicode");
		if(s.indexOf(",")==0){
			s = s.substring(1);
		}
		if(s.lastIndexOf(",")==s.length()-1){
			s = s.substring(0,s.length()-1);
		}
		if(bytes.length<=length){
			return s;
		}
		
		int n = 0; // 表示当前的字节数
		int i = 2; // 要截取的字节数，从第3个字节开始
		for (; i < bytes.length && n < length; i++) {
			// 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
			if (i % 2 == 1) {
				n++; // 在UCS2第二个字节时n加1
			} else {
				// 当UCS2编码的第一个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
				if (bytes[i] != 0) {
					n++;
				}
			}
		}
		// 如果i为奇数时，处理成偶数
		if (i % 2 == 1) {
			// 该UCS2字符是汉字时，去掉这个截一半的汉字
			if (bytes[i - 1] != 0)
				i = i - 1;
			// 该UCS2字符是字母或数字，则保留该字符
			else
				i = i + 1;
		}
		return new String(bytes, 0, i, "Unicode")+"...";
	}
	
	public static String bSubstring2(String s, int length, int length2) throws Exception {

		if(s.length()*2<length+length2){
			return s;
		}
		
		if(s==null||s.equals("")){
			return "";
		}
		byte[] bytes = s.getBytes("Unicode");
		if(s.indexOf(",")==0){
			s = s.substring(1);
		}
		if(s.lastIndexOf(",")==s.length()-1){
			s = s.substring(0,s.length()-1);
		}
		if(bytes.length<=length+length2){
			return s;
		}
		
		//提取前length个字符
		int n = 0; // 表示当前的字节数
		int i = 2; // 要截取的字节数，从第3个字节开始
		for (; i < bytes.length && n < length; i++) {
			// 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
			if (i % 2 == 1) {
				n++; // 在UCS2第二个字节时n加1
			} else {
				// 当UCS2编码的第一个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
				if (bytes[i] != 0) {
					n++;
				}
			}
		}
		// 如果i为奇数时，处理成偶数
		if (i % 2 == 1) {
			// 该UCS2字符是汉字时，去掉这个截一半的汉字
			if (bytes[i - 1] != 0)
				i = i - 1;
			// 该UCS2字符是字母或数字，则保留该字符
			else
				i = i + 1;
		}
		
		//提取后length2个字符
		int m = 0; // 表示当前的字节数
		int j = bytes.length-1; // 要截取的字节起始位置
		for (; j > i && m < length2; j--) {
			// 奇数位置，如3、5、7等，为UCS2编码中两个字节的第二个字节
			if (j % 2 == 1) {
				m++; // 在UCS2第二个字节时n加1
			} else {
				// 当UCS2编码的第一个字节不等于0时，该UCS2字符为汉字，一个汉字算两个字节
				if (bytes[j] != 0) {
					m++;
				}
			}
		}
		// 如果j为奇数时，处理成偶数
		if (j % 2 == 1) {
			// 该UCS2字符是汉字时，去掉这个截一半的汉字
			if (bytes[j - 1] != 0)
				j = j + 1;
			// 该UCS2字符是字母或数字，则保留该字符
			else
				j = j - 1;
		}
		if(i==j){
			return s;
		}else{
			return new String(bytes, 0, i, "Unicode")+"..." 
					+ new String(bytes, j, bytes.length-j, "Unicode");
		}
		
	}
	
	public static String forEnglishSub(String str,int len) throws Exception{
		
		if(str.length()<len){
			return str;
		}
		
		String reg = "^[a-zA-Z]+$";
		
		if((str.substring(len, len+1)).matches(reg)){
			
			if((str.substring(len-1, len)).matches(reg)){
				for(;(str.substring(len-1, len)).matches(reg);){
					len--;
				}	
			}
			return bSubstring(str, len-1);
		}else{
			return bSubstring(str, len);
		}
	}

	public static String StrSize(long size) throws Exception{
		if(size==0) return "0B";
		
		DecimalFormat df = new DecimalFormat("#.00");
		String[] unit=new String[]{"B","KB","MB","GB","TB"};
		double size2=(double)size;
		int k=1024;
		int i=0;
		while(size2 > k && i < unit.length){
			size2=size2/k;
			i++;
		}
		return df.format(size2)+unit[i];
	}
}
