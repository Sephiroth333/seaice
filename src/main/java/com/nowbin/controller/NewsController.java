/**
 * 
 */
package com.nowbin.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.nowbin.bean.News;
import com.nowbin.bean.NewsWithBLOBs;
import com.nowbin.bean.OperateResult;
import com.nowbin.service.AdminService;
import com.nowbin.service.NewsService;
import com.nowbin.util.Page;
import com.nowbin.util.StripXssUtil;

/**
 * @author aeolus
 *
 */
@Controller
@RequestMapping("/admin")
public class NewsController {

private static Logger log = LoggerFactory.getLogger(NewsController.class);
	
	@Resource
	private AdminService adminService;
	
	@Resource
	private NewsService newsService;
	
	@RequestMapping("/newsManage")
	public String newsManage(Model model,HttpServletRequest req){
		try{			
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			int totalCount = (int) newsService.getCount();
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
			} else {
				page = new Page(totalCount, 1);
			}
			
			List<News> datalist=newsService.queryByPage(page);
			model.addAttribute("page", page);
			model.addAttribute("datalist", datalist);
			return "admin/news";
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return "/admin/error?code=101";
	}
	
	@ResponseBody
	@RequestMapping("/newsView")
	public Map<String,Object> newsView(HttpServletRequest req){
		Map<String,Object> map = new HashMap<String,Object>();
		try{
			int dataid=Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("id")));
			NewsWithBLOBs data=newsService.selectByPrimaryKey(dataid);
			if(data==null){
				map.put("success", false);
			}else{
				map.put("data", data);	
				map.put("success", true);
			}
		}catch(Exception ex){
			log.info(ex.toString());
			map.put("success", false);
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/newsModify")
	public OperateResult newsModify(HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{			
			NewsWithBLOBs item=new NewsWithBLOBs();
			item.setNewsid(Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("modifydtID"))));	//增加过滤XSS工具
			item.setNewstitle(StripXssUtil.stripXSS(req.getParameter("title2")));
			item.setAuthor(StripXssUtil.stripXSS(req.getParameter("author2")));
			item.setNewscontent(req.getParameter("newscontent2"));
			//item.setUpdatetime(new Date());
			Integer count=newsService.updateByPrimaryKeySelective(item);
			result.setCount(count);
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping("/newsAdd")
	public OperateResult newsAdd(HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{
			NewsWithBLOBs item=new NewsWithBLOBs();
			item.setNewstitle(StripXssUtil.stripXSS(req.getParameter("title")));
			item.setAuthor(StripXssUtil.stripXSS(req.getParameter("author")));
			item.setNewscontent(req.getParameter("newscontent"));
			item.setUpdatetime(new Date());
			item.setNewsstatus(1);
			Integer count=newsService.insertSelective(item);
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping("/newsDel")
	public OperateResult newsDel(@RequestParam(value="id") String sid,
			HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{
			int count=0;
			String[] ssid=StripXssUtil.stripXSS(sid).split("_");
			for(String s : ssid){
				if(!s.isEmpty()){
					int id=Integer.parseInt(s);
					count+=newsService.deleteByPrimaryKey(id);
				}
			}
			if(count > 0) {
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
	
}
