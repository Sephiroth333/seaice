package com.nowbin.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ToTimestamp {

	public static Timestamp str2Timestamp(String timeStr,String pattern)
	 {
	  Timestamp result = null;
	  if (timeStr == null) {
	   throw new IllegalArgumentException("Timestamp is null");
	  }
	  if (pattern != null && !"".equals(pattern)) {
	   if (!"yyyyMMddHHmmss".equals(pattern)
	     && !"yyyy-MM-dd HH:mm:ss".equals(pattern)
	     && !"MM/dd/yyyy HH:mm:ss".equals(pattern)
	     && !"yyyy-MM-dd".equals(pattern)
	     && !"MM/dd/yyyy".equals(pattern)) {
	    throw new IllegalArgumentException("Date format ["+pattern+"] is invalid");
	   }
	  }else{
	   pattern = "yyyyMMddHHmmss";
	  }
	  
	  Date d = null;
	  SimpleDateFormat sdf = new SimpleDateFormat(pattern);
	  try {
	   d = sdf.parse(timeStr);
	   result = new Timestamp(d.getTime());
	  } catch (Exception e) {
	   e.printStackTrace();
	  }
	  return result;
	 }
}
