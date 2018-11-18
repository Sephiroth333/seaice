package com.nowbin.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.nowbin.bean.Admin;
import com.nowbin.bean.User;

@Repository
public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static Logger log = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");  
		response.setCharacterEncoding("UTF-8");  
		response.setContentType("text/html;charset=UTF-8");  
		
		String[] IGNORE_URI = {"/login","/logout","/tologin"};
		
		String url = request.getRequestURL().toString();
		
        for (String s : IGNORE_URI) {
            if (url.contains(s)) {
                return true;
            }
        }
        
        Admin user = (Admin) request.getSession().getAttribute("loginUser");
        if (user != null) return true;
        
        PrintWriter out = response.getWriter();
        StringBuilder builder = new StringBuilder();
        
        builder.append("<script language='JavaScript' src='../js/jquery-1.11.1.min.js'></script>");
        builder.append("<script type='text/javascript' src='../js/layer.js'></script>");
        builder.append("<script type='text/javascript'>");
        builder.append("alert('请求非法或者已失效，请您重新登陆');");
        builder.append("window.top.location.href='");
        builder.append("/seaice");  //这里是http://ip:port/项目名
        builder.append("/admin/login';");  //这里是重新登录的页面url
        builder.append("</script>");
        out.print(builder.toString());
        out.close();
        
        log.info("登陆失效");
        
        return false;
	}
}
