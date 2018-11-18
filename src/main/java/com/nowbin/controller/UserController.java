package com.nowbin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nowbin.bean.Admin;
import com.nowbin.bean.OperateResult;
import com.nowbin.bean.User;
import com.nowbin.service.AdminService;
import com.nowbin.service.UserService;
import com.nowbin.util.EmailUtil;
import com.nowbin.util.MD5Util;
import com.nowbin.util.Page;
import com.nowbin.util.RandomUtil;
import com.nowbin.util.StripXssUtil;

@Controller
@RequestMapping("/admin")
public class UserController {
	
	private static Logger log = LoggerFactory.getLogger(UserController.class);
	
	@Resource
	private AdminService adminService;
	
	@Resource
	private UserService userService;
	
	
	@RequestMapping("/userManage")
	public String userManage(HttpServletRequest req, Model model){		
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				if(code<0) return "redirect:/admin/error?code="+code;
			}
			
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			List<User> dtlist = null;
			int totalCount = (int) userService.getCount();
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
				dtlist=userService.queryAllByPage(page);
			} else {
				page = new Page(totalCount, 1);
				dtlist=userService.queryAllByPage(page);
			}
			model.addAttribute("page", page);
			model.addAttribute("dtlist", dtlist);
			return "admin/userManage";
			
		}catch(Exception ex){
			log.info(ex.toString());
			return "redirect:/admin/error?code=101";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("/singleUser")
	public User singleUser(@RequestParam(value="id") String sid,HttpServletRequest req){
		try{
			int id=Integer.parseInt(StripXssUtil.stripXSS(sid));		//XSS过滤
			User user=userService.selectByPrimaryKey(id);
			return user;
			
		}catch(Exception ex){
			return null;
		}		
	}
	
	@ResponseBody
	@RequestMapping("/userModify")
	public OperateResult userModify(HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			
			User user=new User();
			user.setUserid(Integer.parseInt(req.getParameter("userid2")));
			
			if(req.getParameter("loginname2")!=null || !req.getParameter("loginname2").isEmpty()){				
				user.setLoginname(StripXssUtil.stripXSS(req.getParameter("loginname2")));
			}
			if(req.getParameter("loginemail2")!=null || !req.getParameter("loginemail2").isEmpty()){
				user.setLoginemail(StripXssUtil.stripXSS(req.getParameter("loginemail2")));
			}
			if(!userService.checkTwo(user)){
				result.setCode(101);
				return result;	//用户名或email已经存在
			}
			if(req.getParameter("realname2")!=null || !req.getParameter("realname2").isEmpty()){
				user.setRealname(StripXssUtil.stripXSS(req.getParameter("realname2")));
			}
			if(req.getParameter("company2")!=null || !req.getParameter("company2").isEmpty()){
				user.setCompany(StripXssUtil.stripXSS(req.getParameter("company2")));
			}
			if(req.getParameter("userstatus2")!=null || !req.getParameter("userstatus2").isEmpty()){
				user.setUserstatus(Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("userstatus2"))));
			}
			Integer count=userService.updateByPrimaryKeySelective(user);
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping("/userAdd")
	public OperateResult userAdd(HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			
			User user=new User();			
			if(req.getParameter("loginname")==null || req.getParameter("loginname").isEmpty()){
				result.setCode(201);
			}else if(req.getParameter("loginemail")==null || req.getParameter("loginemail").isEmpty()){
				result.setCode(202);
			}else if(req.getParameter("pwd")==null || req.getParameter("pwd").isEmpty()){
				result.setCode(203);
			}else if(req.getParameter("realname")==null || req.getParameter("realname").isEmpty()){
				result.setCode(204);
			}else{
				result.setSuccess(true);
			}
			if(!result.isSuccess()) return result;
			user.setLoginname(StripXssUtil.stripXSS(req.getParameter("loginname")));
			user.setLoginemail(StripXssUtil.stripXSS(req.getParameter("loginemail")));
			if(!userService.checkTwo(user)){
				result.setCode(206);	//用户名或email已经存在
				result.setSuccess(false);
				return result;
			}
			user.setRealname(StripXssUtil.stripXSS(req.getParameter("realname")));
			user.setLoginpwd(MD5Util.MD5(req.getParameter("pwd")));
			user.setUserstatus(0);
			if(req.getParameter("company")!=null && !req.getParameter("company").isEmpty()){
				user.setCompany(StripXssUtil.stripXSS(req.getParameter("company")));
			}
			Integer count=userService.insertSelective(user);
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping("/userDel")
	public OperateResult userDel(@RequestParam(value="id") String sid, HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			
			int id=Integer.parseInt(StripXssUtil.stripXSS(sid));		//XSS过滤
			Integer count=userService.deleteByPrimaryKey(id);
			result.setCount(count);
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/userReset")
	public OperateResult userReset(@RequestParam(value="id") String sid, HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			
			int id=Integer.parseInt(StripXssUtil.stripXSS(sid));		//XSS过滤
			User user=userService.selectByPrimaryKey(id);
			if(user==null) {
				result.setCode(101);
				return result;
			}
			
			String pwd=RandomUtil.createPassWord(8);	//生成8位随机密码
			user.setLoginpwd(MD5Util.MD5(pwd));
			
			int count=userService.updateByPrimaryKeySelective(user);
			if(count > 0){
				String subject="password reset";
				String content="Dear "+user.getRealname()+"!\t\n";
				content += "    your password has been reset.The new password is:"+pwd;
				EmailUtil.send_email(user.getLoginemail(), subject, content);
				result.setCount(count);
			}else{
				result.setCode(101);
			}			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;
	}
	
	/*
	 * 权限判断
	 * return code:
	 * 		>0:当前用户ID  		
	 * 		-1:未登录
	 * 		-2:用户名或密码错误
	 * 		-3:验证码错误
	 * 		-4:用户待验证
	 * 		-5:用户被禁用
	 * 		-9:权限不足
	 * 
	 */
	private Integer UserPowerCheck(Integer powerneed, HttpServletRequest req){
		Integer code=-1;
		try{
			Admin user=(Admin)req.getSession().getAttribute("loginUser");
			if(user==null) code=-1;
			else{
				if(user.getAdminStatus()==0){
					code=-4;
				}else if(user.getAdminStatus()==0){
					code=-5;
				}else if(user.getAdminRole()<powerneed){
					code=-9;
				}else{
					code=user.getAdminId();
				}
			}			
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return code;
	}

}
