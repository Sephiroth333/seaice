package com.nowbin.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;

public class HtmlUtil {

	private static final String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; // 定义script的正则表达式  
    private static final String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; // 定义style的正则表达式  
    private static final String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式  
    private static final String regEx_space = "\\s*|\t|\r|\n";//定义空格回车换行符  
	
	public static void writerJson(HttpServletResponse response,String jsonStr) {
		writer(response,jsonStr);
	}

	public static void writerJson(HttpServletResponse response,Object object){
		try {
			response.setContentType("application/json");
			writer(response,JSON.toJSONString(object));
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}


	public static void writerHtml(HttpServletResponse response,String htmlStr) {
		writer(response,htmlStr);
	}

	private static void writer(HttpServletResponse response,String str){
		try {
			//设置页面不缓存
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setCharacterEncoding("UTF-8");
			PrintWriter out= null;
			out = response.getWriter();
			out.print(str);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	} 
	
	
	/** 
     * @param htmlStr 
     * @return 
     *  删除Html标签 
     */  
    public static String delHTMLTag(String htmlStr) { 

        Pattern p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);  
        Matcher m_script = p_script.matcher(htmlStr);  
        htmlStr = m_script.replaceAll(""); // 过滤script标签  
  
        Pattern p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);  
        Matcher m_style = p_style.matcher(htmlStr);  
        htmlStr = m_style.replaceAll(""); // 过滤style标签  
  
        Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);  
        Matcher m_html = p_html.matcher(htmlStr);  
        htmlStr = m_html.replaceAll(""); // 过滤html标签  
  
        Pattern p_space = Pattern.compile(regEx_space, Pattern.CASE_INSENSITIVE);  
        Matcher m_space = p_space.matcher(htmlStr);  
        htmlStr = m_space.replaceAll(""); // 过滤空格回车标签 
        
        return htmlStr.trim(); // 返回文本字符串  
    }  
      
    public static String getTextFromHtml(String htmlStr){  
    	
        htmlStr = delHTMLTag(htmlStr);  
        htmlStr = htmlStr.replaceAll(" ", "");  
        htmlStr = htmlStr.substring(0, htmlStr.indexOf("。")+1);  
        
        return htmlStr;  
    }  
      
    public static void main(String[] args) {  
    	
        String str = "<div style='text-align:center;'> 整治“四风”   清弊除垢<br/><span style='font-size:14px;'> </span><span style='font-size:18px;'>公司召开党的群众路线教育实践活动动员大会</span><br/></div>";  
        System.out.println(delHTMLTag(str));  
    }
}
