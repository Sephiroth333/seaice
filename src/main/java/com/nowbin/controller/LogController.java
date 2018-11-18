/**
 * 
 */
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

import com.nowbin.bean.LocalData;
import com.nowbin.bean.Log;
import com.nowbin.service.AdminService;
import com.nowbin.service.LogService;
import com.nowbin.util.Page;
import com.nowbin.util.StripXssUtil;

/**
 * @author aeolus
 *
 */
@Controller
@RequestMapping("/admin")
public class LogController {
	
	private static Logger log = LoggerFactory.getLogger(LogController.class);
	
	@Resource
	private AdminService adminService;
	
	@Resource
	private LogService logService;
	
	@RequestMapping("/log")
	public String log(String sid,HttpServletRequest req, Model model){
		try{
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			List<Log> datalist = null;
			int totalCount = (int) logService.getCount(11);
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
				datalist=logService.queryData(11,page);
			} else {
				page = new Page(totalCount, 1);
				datalist=logService.queryData(11, page);
			}
			model.addAttribute("page", page);
			model.addAttribute("datalist", datalist);
		}catch(Exception ex){
			log.info(ex.toString());
		}	
		return "admin/log";		
	}

}
