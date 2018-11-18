package com.nowbin.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nowbin.bean.Admin;
import com.nowbin.bean.Menu;
import com.nowbin.bean.OperateResult;
import com.nowbin.service.AdminService;
import com.nowbin.service.MenuService;
import com.nowbin.util.StripXssUtil;

@Controller
@RequestMapping("/admin")
public class MenuController {
	
private static Logger log = LoggerFactory.getLogger(MenuController.class);

	@Resource
	private AdminService adminService;

	@Resource
	private MenuService menuService;
	
	
	@RequestMapping("/menu")
	public String menu(@RequestParam(value="id") String param,
			Model model,HttpServletRequest req){
		try{
			int id=Integer.parseInt(param);
			Menu menu=menuService.selectByPrimaryKey(id);
			if(menu!=null){
				model.addAttribute("menu",menu);
				return "admin/menu";
			}
			
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return "/admin/error?code=101";
	}

	@ResponseBody
	@RequestMapping("/menuModify")
	public OperateResult menuModify(HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			//权限验证
			/*
			Integer code=UserPowerCheck(2,req);
			if(code<0) {
				result.setCode(code);
				return result;
			}
			*/
			Menu menu=new Menu();
			menu.setMenuid(Integer.parseInt(req.getParameter("menuID")));
			menu.setMenucontent(req.getParameter("content"));		//不能用XSS过滤，否则html标签失效
			Integer count=menuService.updateByPrimaryKeySelective(menu);
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
}
