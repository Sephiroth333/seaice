package com.nowbin.util;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public final class MD5Util {
	
	private static final String hexDigits[] = { "0", "1", "2", "3", "4", "5",
		"6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

	public static String MD5(String origin) {
		String resultString = MD5Encode(origin,"UTF-8");
		if(StringUtils.isNotBlank(resultString)){
			return resultString.toUpperCase();
		}		
		return resultString;
	}

	private static String byteArrayToHexString(byte b[]) {
		StringBuffer resultSb = new StringBuffer();
		for (int i = 0; i < b.length; i++)
			resultSb.append(byteToHexString(b[i]));

		return resultSb.toString();
	}

	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0)
			n += 256;
		int d1 = n / 16;
		int d2 = n % 16;
		return hexDigits[d1] + hexDigits[d2];
	}
	public static String MD5Encode(String origin, String charsetname) {
		String resultString = null;
		try {
			resultString = new String(origin);
			MessageDigest md = MessageDigest.getInstance("MD5");
			if (charsetname == null || "".equals(charsetname))
				resultString = byteArrayToHexString(md.digest(resultString
						.getBytes()));
			else
				resultString = byteArrayToHexString(md.digest(resultString
						.getBytes(charsetname)));
		} catch (Exception exception) {

		}
		return resultString;
	}

	public static String createTokenforVerification(Integer userid,String loginname,Date regtime){
    	String result="";
    	userid=userid+20171120;    	
    	String p1=MD5(loginname).substring(2, 10);				//8
    	String p2=userid.toString();		//8
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
    	String p3=MD5(sdf.format(regtime)).substring(12, 24);	//12
    	result=replace(p1+p2+p3);
    	return result;
    }
	
	private static String replace(String s){
		char[] oldchar=new char[]{'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
		char[] newchar=new char[]{'K','m','X','z','U','w','L','j','H','s','p','Q','M','Y','y','t'};
		String ss=s;
		for(int i=0;i<oldchar.length;i++){
			ss=ss.replace(oldchar[i], newchar[i]);
		}		
		return ss;
	}
	
	public static String replace2(String s){
		char[] newchar=new char[]{'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
		char[] oldchar=new char[]{'K','m','X','z','U','w','L','j','H','s','p','Q','M','Y','y','t'};
		String ss=s;
		for(int i=0;i<oldchar.length;i++){
			ss=ss.replace(oldchar[i], newchar[i]);
		}		
		return ss;
	}
}
