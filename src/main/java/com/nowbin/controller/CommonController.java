package com.nowbin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nowbin.bean.Admin;

@Controller
@RequestMapping("/admin")
public class CommonController {
	
	private static Logger log = LoggerFactory.getLogger(CommonController.class);
	
	//跳转页面
	@RequestMapping("/")
	public String adminHome(HttpServletRequest req, HttpServletResponse response){
		Admin user=(Admin)req.getSession().getAttribute("loginUser");
		if(user!=null){
			return "redirect:/admin/main?id=0";
		}else{
			return "redirect:/admin/login";
		}
	}
	
	//跳转错误页面
	@RequestMapping("/error")
	public String toerror(@RequestParam(value="code",required=false,defaultValue="0") String strCode,
			HttpServletRequest req, HttpServletResponse response){
		//跳转过程：
		//框架内页面post错误时，跳转至本函数,本函数请求view/admin/error.jsp页面以跳出框架
		//view/admin/error.jsp获得errorcode,跳出框架，跳转至   admin/error2?code=xxx  (前台请求spring mvc的servlet  admin/error2?code=xxx)
		//  admin/error2执行判断，请求view/error.jsp页面
		req.setAttribute("errorcode", strCode);
		return "admin/error";
	}
	
	@RequestMapping("/error2")
	public String toerror2(@RequestParam(value="code",required=false,defaultValue="0") String strCode,
			HttpServletRequest req, HttpServletResponse response){
		try{
			String msg="";
			switch(strCode){
			case "1":
				return "redirect:login";
			case "-1": 
				return "redirect:login?id=-1";
			case "-2": 
				return "redirect:login?id=-2";
			case "-3": 
				return "redirect:login?id=-3";
			case "-4": 
				return "redirect:login?id=-4";
			case "-5": 
				return "redirect:login?id=-5";
			case "-9":
				msg="对不起，你的权限不足，不能进行该操作!";
				break;
			case "101":
				msg="加载数据失败!";
				break;
			default: 
				msg="未找到该资源!";
				
			}
			req.setAttribute("msg", msg);
		}catch(Exception ex){
			ex.toString();
		}
		return "error";		
	}
	
	//跳转登陆页面
	@RequestMapping("/login")
	public String login(@RequestParam(value="id",required=false,defaultValue="0") String param, HttpServletRequest req){
		req.setAttribute("loginCode", param);
		return "admin/login";		//跳转到 view/admin/login.jsp
	}
	
	//跳转主页面
	@RequestMapping("/main")
	public String tomain(@RequestParam(value="id",required=false,defaultValue="0") String param, HttpServletRequest req){
		//log.info("main id="+param);
		switch(param){
			case "1":
				return "admin/main1";	//跳转到 view/admin/main1.jsp
			case "2":
				return "admin/main2";	//跳转到 view/admin/main2.jsp
			default:
				return "admin/main0";	//跳转到 view/admin/main0.jsp
		}
	}
		
	//跳转index页面
	@RequestMapping("/index")
	public String toindex(@RequestParam(value="id",required=false,defaultValue="0") String param, HttpServletRequest req){
		Admin user=(Admin)req.getSession().getAttribute("loginUser");
		if(user!=null)
		{
			req.setAttribute("UserType", user.getAdminRole());
			switch(param){
			case "1":
				return "admin/index1";	//跳转到 view/admin/index1.jsp
			case "2":
				return "admin/index2";	//跳转到 view/admin/index2.jsp
			default:
				return "admin/index0";	//跳转到 view/admin/index0.jsp
			}
		}else{
			return "admin/error?code=1";		//未登录，跳出框架到登陆界面
		}	
	}
	
	//跳转top页面
	@RequestMapping("/top")
	public String totop(@RequestParam(value="id",required=false,defaultValue="0") String param, HttpServletRequest req){
		//log.info("top id="+param);
		Admin user=(Admin)req.getSession().getAttribute("loginUser");
		if(user!=null)
		{
			req.setAttribute("TagID", param);
			req.setAttribute("UseName", user.getAdminName());
			req.setAttribute("UserType", user.getAdminRole());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy年MM月dd日");
			String serverDate = simpleDateFormat.format(new Date()).toString();
			req.setAttribute("serverDate", serverDate);
			return "admin/top";		//跳转到 view/admin/top.jsp
		}else{
			return "admin/error?code=1";		//未登录，跳出框架到登陆界面
		}		
	}
}
