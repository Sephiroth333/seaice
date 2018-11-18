package com.nowbin.controller;

import java.util.Date;
import java.util.List;

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
import com.nowbin.bean.LocalData;
import com.nowbin.bean.OperateResult;
import com.nowbin.service.AdminService;
import com.nowbin.service.LocalDataService;
import com.nowbin.util.Page;
import com.nowbin.util.StripXssUtil;

@Controller
@RequestMapping("/admin")
public class LocalDataController {
	
	private static Logger log = LoggerFactory.getLogger(LocalDataController.class);
	
	@Resource
	private AdminService adminService;
	
	@Resource
	private LocalDataService localdataService;
	
	
	@RequestMapping("/archive")
	public String archive(@RequestParam(value="id",required=false,defaultValue="1") String sid,HttpServletRequest req, Model model){
		try{
			int dtid2=Integer.parseInt(StripXssUtil.stripXSS(sid));		//XSS过滤
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			List<LocalData> datalist = null;
			int totalCount = (int) localdataService.getCountByDT2(dtid2);
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
				datalist=localdataService.queryDataByPage(dtid2, page);
			} else {
				page = new Page(totalCount, 1);
				datalist=localdataService.queryDataByPage(dtid2, page);
			}
			model.addAttribute("id",dtid2);
			model.addAttribute("page", page);
			model.addAttribute("datalist", datalist);
		}catch(Exception ex){
			log.info(ex.toString());
		}	
		return "admin/data-archive";		
	}
	
	
	@ResponseBody
	@RequestMapping("/checklocaldata")
	public OperateResult checklocaldata(@RequestParam(value="id") String sid,HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{
			Admin user=(Admin)req.getSession().getAttribute("loginUser");
			if(user==null){
				result.setCode(101);
				return result;
			}			
			int id=Integer.parseInt(StripXssUtil.stripXSS(sid));
			LocalData data=localdataService.selectByPrimaryKey(id);
			data.setAdminid(user.getAdminId());
			data.setIschecked(data.getIschecked()==1?0:1);
			data.setCheckedtime(new Date());
			int n=localdataService.updateByPrimaryKeySelective(data);
			if(n>0){
				result.setCount(n);
				result.setSuccess(true);
			}
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return result;
	}
}
