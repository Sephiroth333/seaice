package com.nowbin.interceptor;

import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.nowbin.exception.ServiceException;

public class ExceptionInterceptor extends HandlerInterceptorAdapter {

	private static Logger log = LoggerFactory.getLogger(ExceptionInterceptor.class);
	
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		if(ex != null){
			String msg = "";
			if (ex instanceof ServiceException) {
				msg = ex.getMessage()+"ServiceException";
			}else if (ex instanceof NullPointerException) {
				msg = "空指针异常"+"NullPointerException";
			}else if (ex instanceof IOException) {
				msg = "文件读写异常"+"IOException";
			}else {
				msg = ex.toString()+",未知错误！";
			}
			logger(request, handler, ex);
			//response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
			//Map<String, Object> result = new HashMap<String, Object>();
			//result.put("success", false);
			//result.put("msg", msg);
			//HtmlUtil.writerJson(response, result);
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("/error").forward(request, response);
		}else{
			super.afterCompletion(request, response, handler, ex);
		}
	}
	
	public void logger(HttpServletRequest request,Object handler, Exception ex){
		StringBuffer msg = new StringBuffer();
		msg.append("[uri＝").append(request.getRequestURI()).append("]");
		Enumeration<String>  enumer= request.getParameterNames();
		while (enumer.hasMoreElements()) {
			String name = (String) enumer.nextElement();
			String[] values = request.getParameterValues(name);
			msg.append("异常拦截日志 [").append(name).append("=");
			if(values != null){
				int i=0;
				for(String value: values){
					i++;
					msg.append(value);
					if(i < values.length){
						msg.append("｜");
					}
				}
			}
			msg.append("]");
		}
		log.error(msg.toString(),ex);
	}

}
