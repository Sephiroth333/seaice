package com.nowbin.controller;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nowbin.bean.Admin;
import com.nowbin.bean.LeftMenu;
import com.nowbin.bean.LeftMenuTree;
import com.nowbin.service.LeftMenuService;
import com.nowbin.util.NumCheckUtil;

@Controller
@RequestMapping("/admin")
public class LeftmenuController {
	
	private static Logger log = LoggerFactory.getLogger(LeftmenuController.class);
	
	@Resource
	private LeftMenuService leftmenuService;
	
	//跳转left页面
	@RequestMapping("/left")
	public String toleft(@RequestParam(value="id",required=false,defaultValue="0") String param,
			HttpServletRequest req, HttpServletResponse response){
		try{
			Admin user=(Admin)req.getSession().getAttribute("loginUser");
			if(user!=null)
			{
				req.setAttribute("UserType", user.getAdminRole());
				int tabid=Integer.parseInt(param);
				
				List<LeftMenuTree> leftmenulist=new ArrayList<LeftMenuTree>();
				
				List<String> titlelist=leftmenuService.queryFatherNameByTabID(tabid);
				for(int i=0;i<titlelist.size();i++){
					LeftMenuTree menufather=new LeftMenuTree();
					menufather.setMenutitle(titlelist.get(i));
					menufather.setImgUrl("../images/data"+Integer.toString(tabid*100+i) +".png");
					leftmenulist.add(menufather);
				}
				
				//获取显示权限配置
				Properties properties = new Properties();  
				InputStream resourceAsStream = null;  
				try {
					resourceAsStream = LeftmenuController.class.getClassLoader().getResourceAsStream("menupower.properties");
					properties.load(resourceAsStream);
					
				} finally {  
					if (resourceAsStream != null) { 
						resourceAsStream.close();  
					}  
				}
				String ss="";
				if(user.getAdminRole()==0){
					ss=(String)properties.get("hidden0");
				}else if(user.getAdminRole()==1){
					ss=(String)properties.get("hidden1");
				}
				String[] ss2=ss.split(",");
				List<Integer> hiddenlist=new ArrayList<Integer>();
				for(String item:ss2){
					if(NumCheckUtil.isInteger(item)){
						hiddenlist.add(Integer.parseInt(item));
					}
				}				
				
				
				List<LeftMenu> query=leftmenuService.queryAllByTabID(tabid);
				for(LeftMenu item : query){
					//显示权限判断
					boolean isHidden=false;
					for(int i=hiddenlist.size()-1;i>=0;i--){
						if(hiddenlist.get(i)==item.getId()){
							hiddenlist.remove(i);
							isHidden=true;
							break;
						}
					}
					if(isHidden) continue;
					
					int fatherID=(item.getDtfatherid())%100;
					LeftMenu menuson=new LeftMenu();
					menuson.setId(item.getId());
					menuson.setDturl(item.getDturl());
					menuson.setDtnameson(item.getDtnameson());
					leftmenulist.get(fatherID).getMenusonlist().add(menuson);
				}
				req.setAttribute("leftmenulist", leftmenulist);
				return "admin/left";
			}else{
				req.setAttribute("errorcode", 1);
				return "admin/error";		//未登录，跳出框架到登陆界面
			}	
		}catch(Exception ex){
			req.setAttribute("errorcode", 101);
			return "admin/error";		//错误
		}			
	}

}
