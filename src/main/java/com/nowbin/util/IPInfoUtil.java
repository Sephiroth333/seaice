/**
 * 
 */
package com.nowbin.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;


/**
 * @author aeolus
 *
 */
public class IPInfoUtil {
	
	private static String requestUrl="http://ip.taobao.com/service/getIpInfo.php?ip=";
		
	public static String getCountryByIP(String ip){
		String country="CN";
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		InputStream inputStream=null;
		try{
			URL url = new URL(requestUrl+ip);  
            HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();    
            httpUrlConn.setDoOutput(true);    
            httpUrlConn.setDoInput(true);
            httpUrlConn.setUseCaches(false);  
            httpUrlConn.setRequestMethod("GET");    
            httpUrlConn.connect();
            //将返回的输入流转换成字符串    
            inputStream = httpUrlConn.getInputStream();    
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");    
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
            String str = null;    
            while ((str = bufferedReader.readLine()) != null) {    
                buffer.append(str);    
            }    
            bufferedReader.close();    
            inputStreamReader.close();
            // 释放资源    
            inputStream.close();    
            inputStream = null;    
            httpUrlConn.disconnect();            
            jsonObject =JSONObject.fromObject(buffer.toString()); 
            country=jsonObject.getJSONObject("data").getString("country_id");
            if(country.equals("")){
            	country="CN";
            }			
		}catch(Exception ex){
			ex.printStackTrace();
			country="CN";
		}finally{
			try {
                if(inputStream!=null){  
                    inputStream.close();  
                }  
            } catch (Exception e) {  
                // TODO Auto-generated catch block  
                e.printStackTrace();
            }  
		}
		return country;
	}

	//获取真实ip
	public static String getIpAddress(HttpServletRequest request) {  
        String ip = request.getHeader("x-forwarded-for");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        return ip;
    }
}
