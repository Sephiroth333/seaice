package com.nowbin.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

/**
 * 
 * 发送短信工具类
 * @author Super
 *
 */
public class SMSUtil {

	private static String Url = "http://10658.cc/webservice/api?method=SendSms";

	/**
	 * 
	 * @param num 发送手机号码
	 * @param content 发送内容
	 * @throws IOException 
	 */
	public static void sendSMS(String num,String content) throws IOException {

		Properties properties = new Properties();  
		InputStream resourceAsStream = null;  
		try {  
			// 获取配置文件  
			resourceAsStream = EmailUtil.class.getClassLoader().getResourceAsStream("sms.properties");
			properties.load(resourceAsStream);

		} finally {  
			if (resourceAsStream != null) { 
				resourceAsStream.close();  
			}  
		}

		String account = properties.getProperty("account");
		String pwd = properties.getProperty("password");
		String pid = properties.getProperty("pid");
		String suffix = properties.getProperty("suffix");

		HttpClient client = new HttpClient(); 
		PostMethod method = new PostMethod(Url); 

		//client.getParams().setContentCharset("GBK");		
		client.getParams().setContentCharset("UTF-8");
		method.setRequestHeader("ContentType","application/x-www-form-urlencoded;charset=UTF-8");

		//多个手机号码请用英文,号隔开
		//彩信库ID可能通过我们的平台上创建来得到，也可以通过http://10658.cc/webservice/api?op=CreateMms来得到


		NameValuePair[] data = {//提交短信
				new NameValuePair("account", account), 
				new NameValuePair("password", pwd), 			    
				new NameValuePair("mobile", num),
				new NameValuePair("pid", pid),					
				new NameValuePair("time", ""),
				new NameValuePair("content",content+suffix)
				//new NameValuePair("mmsid", "彩信库ID"),
		};

		method.setRequestBody(data);		

		try {
			client.executeMethod(method);		
			System.out.println(method.getResponseBodyAsString());

		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		//System.out.println("短信提交成功");
	}

	public static void main(String[] args) throws IOException {
		sendSMS("15354262890","你好这里是测试信息【测试】");
	}

}
