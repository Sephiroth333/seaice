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

import com.nowbin.bean.OperateResult;
import com.nowbin.bean.Person;
import com.nowbin.service.AdminService;
import com.nowbin.service.PersonService;
import com.nowbin.util.Page;
import com.nowbin.util.StripXssUtil;

/**
 * @author aeolus
 *
 */
@Controller
@RequestMapping("/admin")
public class PersonController {

private static Logger log = LoggerFactory.getLogger(PersonController.class);
	
	@Resource
	private AdminService adminService;
	
	@Resource
	private PersonService personService;
	
	@RequestMapping("/personManage")
	public String personManage(Model model,HttpServletRequest req){
		try{			
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			int totalCount = (int) personService.getCount();
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
			} else {
				page = new Page(totalCount, 1);
			}
			
			List<Person> datalist=personService.queryByPage(page);
			model.addAttribute("page", page);
			model.addAttribute("datalist", datalist);
			return "admin/person";
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return "/admin/error?code=101";
	}
	
	@ResponseBody
	@RequestMapping("/personView")
	public Map<String,Object> personView(HttpServletRequest req){
		Map<String,Object> map = new HashMap<String,Object>();
		try{
			int dataid=Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("id")));
			Person data=personService.selectByPrimaryKey(dataid);
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
	@RequestMapping("/personModify")
	public OperateResult personModify(HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{			
			Person item=new Person();
			item.setPid(Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("modifydtID"))));	//增加过滤XSS工具
			item.setPname(StripXssUtil.stripXSS(req.getParameter("pname2")));
			String ptitle=StripXssUtil.stripXSS(req.getParameter("ptitle2"));
			if(ptitle!=null && !ptitle.isEmpty()){
				item.setPtitle(ptitle);
			}
			item.setPcontent(req.getParameter("pcontent2"));
			item.setUpdatetime(new Date());
			Integer count=personService.updateByPrimaryKeySelective(item);
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping("/personAdd")
	public OperateResult personAdd(HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{
			Person item=new Person();
			item.setPname(StripXssUtil.stripXSS(req.getParameter("pname")));
			String ptitle=StripXssUtil.stripXSS(req.getParameter("ptitle"));
			if(ptitle!=null && !ptitle.isEmpty()){
				item.setPtitle(ptitle);
			}
			item.setPcontent(req.getParameter("pcontent"));		
			item.setUpdatetime(new Date());
			Integer count=personService.insertSelective(item);
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping("/personDel")
	public OperateResult personDel(@RequestParam(value="id") String sid,
			HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{
			int count=0;
			String[] ssid=StripXssUtil.stripXSS(sid).split("_");
			for(String s : ssid){
				if(!s.isEmpty()){
					int id=Integer.parseInt(s);
					count+=personService.deleteByPrimaryKey(id);
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
