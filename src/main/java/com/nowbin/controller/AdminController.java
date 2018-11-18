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
import com.nowbin.service.AdminService;
import com.nowbin.util.EmailUtil;
import com.nowbin.util.MD5Util;
import com.nowbin.util.Page;
import com.nowbin.util.RandomUtil;
import com.nowbin.util.StripXssUtil;

@Controller
@RequestMapping("/admin")
public class AdminController {
	private static Logger log = LoggerFactory.getLogger(AdminController.class);
	
	@Resource
	private AdminService adminService;
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest req){
		
		req.getSession().removeAttribute("loginUser");
		log.info("退出登陆成功");
		return "redirect:/admin/login";
	}
	
	@RequestMapping("/pwdModify")
	public String pwdModify(HttpServletRequest req){
		int code=0;	//首次进入
		try{
			Admin admin=(Admin)req.getSession().getAttribute("loginUser");
			if(admin==null) return "redirect:/admin/login";
			String newpwd=req.getParameter("newpwd");
			if(newpwd!=null && !newpwd.isEmpty()){
				newpwd=StripXssUtil.stripXSS(newpwd);
				
				//重新从数据库获取最新admin
				admin=adminService.selectByPrimaryKey(admin.getAdminId());
				String oldpwd=MD5Util.MD5(StripXssUtil.stripXSS(req.getParameter("oldpwd"))).toLowerCase();
				if(!oldpwd.equals(admin.getAdminPwd().toLowerCase())){
					code=2;	//旧密码错误
				}else{
			    	newpwd=MD5Util.MD5(newpwd);
			    	admin.setAdminPwd(newpwd);
			    	int count=adminService.updateByPrimaryKeySelective(admin);
			    	if(count == 1) {
			    		req.getSession().setAttribute("loginUser",admin);
			    		code=1;		//修改成功
			    	}else 	code=4;	//修改失败
				}
			}
		}catch(Exception ex){
			log.info(ex.toString());
			code=4;
		}
		req.setAttribute("code", code);
		return "admin/password";
	}
	
	
	@RequestMapping("/tologin")
	public String tologin(HttpServletRequest req){
		String userAdmin = StripXssUtil.stripXSS(req.getParameter("userAdmin"));
		//String userPwd = StripXssUtil.stripXSS(req.getParameter("userPwd")).toUpperCase();
		String userPwd = StripXssUtil.stripXSS(req.getParameter("userPwd"));
		userPwd=MD5Util.MD5(userPwd);
		
		String code = req.getParameter("code");
		String regcode = (String) req.getSession().getAttribute("checkcode");
		
		Admin u = new Admin();
		
		if(userAdmin.contains("@")) u.setAdminEmail(userAdmin);
		else u.setAdminName(userAdmin);
		u.setAdminPwd(userPwd);
				
		try {
			if(code.equalsIgnoreCase(regcode)){
				Admin user = new Admin();
				if(userAdmin.contains("@")) 
				{
					user = this.adminService.userLoginbyEmail(u);
				}
				else user = this.adminService.userLogin(u);
				
				if(user != null){
					if(user.getAdminStatus()==0){
						return "redirect:/admin/login?id=-4";	//待验证
					}else if(user.getAdminStatus()==2){
						return "redirect:/admin/login?id=-5";	//禁用
					}else{				
						req.getSession().setAttribute("loginUser", user);
						return "redirect:/admin/main?id=0";
					}
				}else{
					return "redirect:/admin/login?id=-2";		//用户名密码错误
				}
			}else{
				return "redirect:/admin/login?id=-3";			//验证码错误
			}
		} catch (Exception ex) {
			// TODO: handle exception
			log.info(ex.getMessage());
			return "redirect:/admin/error?code=101";
		}
	}
	
	@RequestMapping("/adminManage")
	public String adminManage(Model model, HttpServletRequest req){
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				if(code<0) return "redirect:/admin/error?code="+code;
			}
			
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			List<Admin> dtlist = null;
			int totalCount = (int) adminService.getCount();
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
				dtlist=adminService.queryAllByPage(page);
			} else {
				page = new Page(totalCount, 1);
				dtlist=adminService.queryAllByPage(page);
			}
			model.addAttribute("page", page);
			model.addAttribute("dtlist", dtlist);
			return "admin/adminManage";
			
		}catch(Exception ex){
			log.info(ex.toString());
			return "/admin/error?code=101";
		}		
	}
	
	@ResponseBody
	@RequestMapping("/singleAdmin")
	public Admin singleAdmin(@RequestParam(value="id") String sid,HttpServletRequest req){
		try{
			int id=Integer.parseInt(StripXssUtil.stripXSS(sid));		//XSS过滤
			Admin admin=adminService.selectByPrimaryKey(id);
			return admin;
			
		}catch(Exception ex){
			return null;
		}		
	}
	
	@ResponseBody
	@RequestMapping("/adminModify")
	public OperateResult adminModify(HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			
			Admin admin=new Admin();
			admin.setAdminId(Integer.parseInt(req.getParameter("userid2")));
			
			if(req.getParameter("loginname2")!=null || !req.getParameter("loginname2").isEmpty()){				
				admin.setAdminName(StripXssUtil.stripXSS(req.getParameter("loginname2")));
			}
			if(req.getParameter("loginemail2")!=null || !req.getParameter("loginemail2").isEmpty()){
				admin.setAdminEmail(StripXssUtil.stripXSS(req.getParameter("loginemail2")));
			}
			if(!adminService.checkTwo(admin)){
				result.setCode(101);
				return result;	//用户名或email已经存在
			}
			if(req.getParameter("usertype2")!=null || !req.getParameter("usertype2").isEmpty()){
				admin.setAdminRole(Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("usertype2"))));
			}
			if(req.getParameter("userstatus2")!=null || !req.getParameter("userstatus2").isEmpty()){
				admin.setAdminStatus(Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("userstatus2"))));
			}
			Integer count=adminService.updateByPrimaryKeySelective(admin);
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping("/adminAdd")
	public OperateResult adminAdd(HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			
			Admin user=new Admin();			
			if(req.getParameter("loginname")==null || req.getParameter("loginname").isEmpty()){
				result.setCode(201);
			}else if(req.getParameter("loginemail")==null || req.getParameter("loginemail").isEmpty()){
				result.setCode(202);
			}else if(req.getParameter("pwd")==null || req.getParameter("pwd").isEmpty()){
				result.setCode(203);
			}else if(req.getParameter("usertype")==null || req.getParameter("usertype").isEmpty()){
				result.setCode(205);
			}else{
				result.setSuccess(true);
			}
			if(!result.isSuccess()) return result;
			user.setAdminName(StripXssUtil.stripXSS(req.getParameter("loginname")));
			user.setAdminEmail(StripXssUtil.stripXSS(req.getParameter("loginemail")));
			if(!adminService.checkTwo(user)){
				result.setCode(206);	//用户名或email已经存在
				result.setSuccess(false);
				return result;
			}
			user.setAdminPwd(MD5Util.MD5(req.getParameter("pwd")));
			user.setAdminRole(Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("usertype"))));
			user.setAdminStatus(1);
			Integer count=adminService.insertSelective(user);
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping("/adminDel")
	public OperateResult adminDel(@RequestParam(value="id") String sid, HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			
			int id=Integer.parseInt(StripXssUtil.stripXSS(sid));		//XSS过滤
			Integer count=adminService.deleteByPrimaryKey(id);
			result.setCount(count);
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/adminReset")
	public OperateResult adminReset(@RequestParam(value="id") String sid, HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			
			int id=Integer.parseInt(StripXssUtil.stripXSS(sid));		//XSS过滤
			Admin admin=adminService.selectByPrimaryKey(id);
			if(admin==null) {
				result.setCode(101);
				return result;
			}
			
			String pwd=RandomUtil.createPassWord(8);	//生成8位随机密码
			admin.setAdminPwd(MD5Util.MD5(pwd));
			
			int count=adminService.updateByPrimaryKeySelective(admin);
			if(count > 0){
				String subject="密码重置";
				String content="尊敬的用户"+admin.getAdminName()+",您好！\t\n";
				content += "    您的密码已经重置为:"+pwd;
				log.info(content);
				EmailUtil.send_email(admin.getAdminEmail(), subject, content);
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
