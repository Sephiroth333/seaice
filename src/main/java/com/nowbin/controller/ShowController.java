/**
 * 
 */
package com.nowbin.controller;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nowbin.bean.Country;
import com.nowbin.bean.DataType;
import com.nowbin.bean.DownloadCountry;
import com.nowbin.bean.DownloadRecord;
import com.nowbin.bean.LocalData;
import com.nowbin.bean.Menu;
import com.nowbin.bean.News;
import com.nowbin.bean.NewsWithBLOBs;
import com.nowbin.bean.OperateResult;
import com.nowbin.bean.Person;
import com.nowbin.bean.User;
import com.nowbin.bean.UserDownload;
import com.nowbin.service.CountryService;
import com.nowbin.service.DataTypeService;
import com.nowbin.service.DownloadRecordService;
import com.nowbin.service.LocalDataService;
import com.nowbin.service.MenuService;
import com.nowbin.service.NewsService;
import com.nowbin.service.PersonService;
import com.nowbin.service.UserDownloadService;
import com.nowbin.service.UserService;
import com.nowbin.util.EmailUtil;
import com.nowbin.util.IPInfoUtil;
import com.nowbin.util.MD5Util;
import com.nowbin.util.NumCheckUtil;
import com.nowbin.util.Page;
import com.nowbin.util.RandomUtil;
import com.nowbin.util.StripXssUtil;
import com.nowbin.util.SubStrUtil;
import com.nowbin.util.ZipUtil;
import com.nowbin.util.downloadutil.DownloadUtil;

/**
 * @author aeolus
 *
 */

@Controller
@RequestMapping("/")
public class ShowController {

	
	private static Logger log = LoggerFactory.getLogger(ShowController.class);
	
	@Resource
	private UserService userService;
	
	@Resource
	private DataTypeService datatypeService;
	
	@Resource
	private LocalDataService localdataService;
	
	@Resource
	private MenuService menuService;
	
	@Resource
	private NewsService newsService;
	
	@Resource
	private DownloadRecordService downloadrecordService;
	
	@Resource
	private UserDownloadService userdownloadService;
	
	@Resource
	private CountryService countryService;
	
	@Resource
	private PersonService personService;
	
	
	@RequestMapping("/index")
	public String index(HttpServletRequest req, Model model){
		try{			
			int totalCount = (int) newsService.getCountChecked();
			Page page = new Page(totalCount,1,12);
			List<News> dtlist = newsService.queryCheckedByPage(page);
			model.addAttribute("newslist", dtlist);

			
			Menu goal=menuService.selectByPrimaryKey(9);	//menuid=9
			if(goal!=null){
				model.addAttribute("goal", goal.getMenucontent());
			}
			
			int totalCount2 = personService.getCount();
			page = new Page(totalCount2,1,5);
			List<Person> grouplist=personService.queryByPage(page);
			model.addAttribute("grouplist", grouplist);
						
		}catch(Exception ex){
			ex.printStackTrace();
			log.info(ex.toString());
			return "error";
		}
		
		return "show/index";
	}
	
	@ResponseBody
	@RequestMapping(value="/countByYear", method = RequestMethod.GET)
	public int[] countByYear(HttpServletRequest req){
		int year=Integer.parseInt(req.getParameter("year"));
		int[] countByYear=downloadrecordService.getDownloadCountByYear(year);
		return countByYear;
	}
	
	@ResponseBody
	@RequestMapping(value="/countByCountry", method = RequestMethod.GET)
	public List<DownloadCountry> countByCountry(HttpServletRequest req){
		List<DownloadCountry> countByCountry=downloadrecordService.getDownloadCountByCountry();
		return countByCountry;
	}
	
	@RequestMapping("/menu")
	public String menu(@RequestParam("id") String param,
			HttpServletRequest req, Model model){		
		try{			
			if(!NumCheckUtil.isInteger(param)){
				return "error";
			}
			Integer id=Integer.parseInt(param);
			Menu menu=menuService.selectByPrimaryKey(id);
			if(menu==null){
				return "error";
			}
			model.addAttribute("menu", menu);
		}catch(Exception ex){
			ex.printStackTrace();
			log.info(ex.toString());
			return "error";
		}
		return "show/menu";
	}
	
	@RequestMapping("/newslist")
	public String newslist(HttpServletRequest req, Model model){		
		try{			
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			List<News> dtlist = null;
			int totalCount = (int) newsService.getCountChecked();
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
				dtlist=newsService.queryCheckedByPage(page);
			} else {
				page = new Page(totalCount, 1);
				dtlist=newsService.queryCheckedByPage(page);
			}
			model.addAttribute("page", page);
			model.addAttribute("newslist", dtlist);
			
		}catch(Exception ex){
			ex.printStackTrace();
			log.info(ex.toString());
			return "error";
		}
		return "show/newslist";
	}
	
	@RequestMapping("/news")
	public String news(@RequestParam(value="id") String param,
			HttpServletRequest req, Model model){		
		try{			
			Integer id=Integer.parseInt(param);
			NewsWithBLOBs news=newsService.selectByPrimaryKey(id);
			
			model.addAttribute("news", news);
			
		}catch(Exception ex){
			log.info(ex.toString());
			return "error";
		}
		return "show/news";
	}
	
	@RequestMapping("/grouplist")
	public String grouplist(HttpServletRequest req, Model model){		
		try{			
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			List<Person> dtlist = null;
			int totalCount = personService.getCount();
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
				dtlist=personService.queryByPage(page);
			} else {
				page = new Page(totalCount, 1);
				dtlist=personService.queryByPage(page);
			}
			model.addAttribute("page", page);
			model.addAttribute("grouplist", dtlist);
			
		}catch(Exception ex){
			//ex.printStackTrace();
			log.info(ex.toString());
			return "error";
		}
		return "show/grouplist";
	}
	
	@RequestMapping("/member")
	public String member(@RequestParam(value="id") String param,
			HttpServletRequest req, Model model){		
		try{			
			Integer id=Integer.parseInt(param);
			Person member=personService.selectByPrimaryKey(id);
			
			model.addAttribute("member", member);
			
		}catch(Exception ex){
			log.info(ex.toString());
			return "error";
		}
		return "show/groupmember";
	}
	
	@ResponseBody
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public OperateResult login(HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			String userAdmin = StripXssUtil.stripXSS(req.getParameter("userAdmin"));
			String userPwd = StripXssUtil.stripXSS(req.getParameter("userPwd"));
			userPwd=MD5Util.MD5(userPwd);
			
			//String code = req.getParameter("code");
			//String regcode = (String) req.getSession().getAttribute("checkcode");
			String code="code";
			String regcode="code";
			
			User u = new User();
			
			if(userAdmin.contains("@")) u.setLoginemail(userAdmin);
			else u.setLoginname(userAdmin);
			u.setLoginpwd(userPwd);
			
			if(code.equalsIgnoreCase(regcode)){
				User user = new User();
				if(userAdmin.contains("@")) 
				{
					user = this.userService.userLoginbyEmail(u);
				}
				else user = this.userService.userLogin(u);
				
				if(user != null && user.getUserstatus()==1){
					req.getSession().setAttribute("user", user);
					result.setSuccess(true);
				}else{
					result.setSuccess(false);
					result.setMess("username or password error!");
				}
			}else{
				result.setSuccess(false);
				result.setMess("check code error");
			}
		
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/loginout", method = RequestMethod.GET)
	public OperateResult loginout(HttpServletRequest req){
		OperateResult result=new OperateResult();
		req.getSession().setAttribute("user", null);
		result.setSuccess(true);
		return result;
	}
	
	@RequestMapping(value="/reg", method = RequestMethod.GET)
	public String reg(HttpServletRequest req,Model model){
		User user=(User)req.getSession().getAttribute("user");
		if(user!=null){			
			return "redirect:/index";
		}else{
			List<Country> countrylist=countryService.queryData();
			model.addAttribute("countrylist",countrylist);
			return "show/reg";
		}
	}
		
	@ResponseBody
	@RequestMapping(value="/reg", method = RequestMethod.POST)
	public OperateResult reg2(HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			String loginname = StripXssUtil.stripXSS(req.getParameter("loginname"));
			String loginemail = StripXssUtil.stripXSS(req.getParameter("loginemail"));
			String loginpwd = StripXssUtil.stripXSS(req.getParameter("pwd"));
			loginpwd=MD5Util.MD5(loginpwd);			
			String realname = StripXssUtil.stripXSS(req.getParameter("realname"));
			//String country = StripXssUtil.stripXSS(req.getParameter("country"));
			int country=Integer.parseInt(req.getParameter("country"));
						
			User u = new User();
			u.setLoginname(loginname);
			u.setLoginemail(loginemail);
			u.setLoginpwd(loginpwd);
			//u.setCountry(country);
			u.setUserinsertcountry(country);
			u.setRealname(realname);
			u.setRegtime(new Date());
			u.setUserstatus(0);
			if(userService.checkTwo(u)){
				int count=userService.insertSelective(u);
				if(count>0){
					u=userService.selectByPrimaryKey(u.getUserid());
					//发送email
					try{
						String basePath =req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/";
						String token=MD5Util.createTokenforVerification(u.getUserid(), u.getLoginname(), u.getRegtime());
						String url=basePath+"verification?token="+token;
						String mess="<html><title></title><body><div>";
						mess+="<p>Hello,"+u.getRealname()+":</p>";
						mess+="<p>You need to click on the link below to activate your account.</p>";
						mess+="<p><a href='"+url+"'>"+url+"</a></p>";
						mess+="</div></body>";
						EmailUtil.send_email(u.getLoginemail(), "Verification Email", mess);
					}catch(Exception ex2){
						log.info(ex2.toString());
					}					
					//req.getSession().setAttribute("user", u);
					result.setSuccess(true);
				}
				else{
					result.setCode(202);
				}
			}else{
				result.setCode(201);
			}
			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(200);
		}
		return result;
	}

	@RequestMapping("/percenter")
	public String percenter(HttpServletRequest req){
		return "redirect:/perinfo";
	}
	
	@RequestMapping("/perinfo")
	public String perinfo(HttpServletRequest req,Model model){
		User user=(User)req.getSession().getAttribute("user");
		if(user!=null){
			model.addAttribute("user",user);
			String country=countryService.selectByPrimaryKey(user.getUserinsertcountry()).getEnname();
			model.addAttribute("country",country);
			return "show/perinfo";
		}else{
			return "redirect:/index";
		}
	}
	
	@RequestMapping(value="/changepwd", method = RequestMethod.GET)
	public String changepwd(HttpServletRequest req,Model model){
		User user=(User)req.getSession().getAttribute("user");
		if(user!=null){
			model.addAttribute("user",user);
			return "show/changepwd";
		}else{
			return "redirect:/index";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/changepwd", method = RequestMethod.POST)
	public OperateResult changepwd2(HttpServletRequest req){
		OperateResult result=new OperateResult();
		try{
			User user=(User)req.getSession().getAttribute("user");
			if(user!=null){
				user=userService.selectByPrimaryKey(user.getUserid());	//重读user
				String oldpwd=MD5Util.MD5(StripXssUtil.stripXSS(req.getParameter("pwd0")));
				if(user.getLoginpwd().toUpperCase().equals(oldpwd.toUpperCase())){
					String newpwd=MD5Util.MD5(StripXssUtil.stripXSS(req.getParameter("pwd")));
					user.setLoginpwd(newpwd);
					int count=userService.updateByPrimaryKeySelective(user);
					if(count>0) result.setSuccess(true);
					else result.setCode(301);
				}else{
					result.setCode(302);
				}
			}else{
				result.setCode(303);
			}
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(304);
		}
		return result;
	}
	
	@RequestMapping(value="/concentration", method = RequestMethod.GET)
	public String concentration(HttpServletRequest req, Model model){
		return "show/sea-ice-concentration";
	}
	
	/*
	@RequestMapping(value="/concentration", method = RequestMethod.GET)
	public String concentration(HttpServletRequest req, Model model){
		for(int dtid2=1;dtid2<=4;dtid2++){
			int totalCount = (int) localdataService.getCountByDT2(dtid2);
			Page page=new Page(totalCount,1);
			page.setPageSize(7);
			List<LocalData> datalist=localdataService.queryDataByPage(dtid2,page);
			List<ImageInfo> imglist=new ArrayList<ImageInfo>();
			for(LocalData data : datalist){
				String fileName=data.getFilepath()+data.getFilename()+"_PS.png";
				String code=RandomUtil.createPassWord(4);
				req.getSession().setAttribute(code, fileName);
				ImageInfo imginfo=new ImageInfo(data.getLocaldataid(),
						"ImageStreamServlet?code="+code,
						data.getFilename()+"_PS.png");
				imglist.add(imginfo);
			}
			model.addAttribute("imglist"+dtid2,imglist);
		}
		return "show/sea-ice-concentration2";
	}
	*/
	@RequestMapping(value="/thickness", method = RequestMethod.GET)
	public String thickness(HttpServletRequest req, Model model){
		return "show/sea-ice-thickness";
	}
	
	@RequestMapping(value="/meltponds", method = RequestMethod.GET)
	public String meltponds(HttpServletRequest req, Model model){
		return "show/melt-ponds";
	}
	
	@RequestMapping(value="/leads", method = RequestMethod.GET)
	public String leads(HttpServletRequest req, Model model){
		return "show/leads";
	}
	
	@RequestMapping(value="/drift", method = RequestMethod.GET)
	public String drift(HttpServletRequest req, Model model){
		return "show/sea-ice-drift";
	}
	
	@RequestMapping(value="/temperature", method = RequestMethod.GET)
	public String temperature(HttpServletRequest req, Model model){
		return "show/sea-surface-temperature";
	}
	
	@RequestMapping(value="/winds", method = RequestMethod.GET)
	public String winds(HttpServletRequest req, Model model){
		return "show/sea-surface-winds";
	}
	
	@RequestMapping(value="/icesheet", method = RequestMethod.GET)
	public String icesheet(HttpServletRequest req, Model model){
		return "show/ice-sheet";
	}
	
	@RequestMapping(value="/velocity", method = RequestMethod.GET)
	public String velocity(HttpServletRequest req, Model model){
		return "show/vel";
	}
	
	@RequestMapping(value="/archive", method = RequestMethod.GET)
	public String archive(HttpServletRequest req, Model model){		
		return "show/data-archive";
	}
	
	@RequestMapping(value="/archive2", method = RequestMethod.GET)
	public String archive2(@RequestParam(value="id",required=false,defaultValue="1") String param,HttpServletRequest req, Model model){
		try{
			Integer id=Integer.parseInt(param);
			List<DataType> dtlist=datatypeService.queryAll();
			DataType nowdt=datatypeService.selectByPrimaryKey(id);
			if(nowdt!=null){
				model.addAttribute("nowdt",nowdt);
				model.addAttribute("dtlist",dtlist);
				
				String pageNow = req.getParameter("pageNow");
				Page page = null;
				List<LocalData> datalist = null;
				int totalCount = (int) localdataService.getCountByDT2(id);
				if (pageNow != null) {
					page = new Page(totalCount, Integer.parseInt(pageNow),20);
					datalist=localdataService.queryDataByPage(id, page);
				} else {
					page = new Page(totalCount, 1,20);
					datalist=localdataService.queryDataByPage(id, page);
				}
				model.addAttribute("page", page);
				model.addAttribute("datalist", datalist);
			}
			
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return "show/data-archive2";
	}
	
	@RequestMapping(value="/mydownload")
	public String mydownload(HttpServletRequest req, Model model){
		try{
			User user=(User)req.getSession().getAttribute("user");
			if(user==null) return "redirect:/index";
						
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			List<UserDownload> datalist = null;
			int totalCount = (int) userdownloadService.getCountByUser(user.getUserid());
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow),10);
				datalist=userdownloadService.queryDataByUser(user.getUserid(), page);
			} else {
				page = new Page(totalCount, 1,10);
				datalist=userdownloadService.queryDataByUser(user.getUserid(), page);
			}
			model.addAttribute("page", page);
			model.addAttribute("datalist", datalist);
			
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return "show/mydownload";
	}
	/*
	@ResponseBody
	@RequestMapping(value="/querydata", method = RequestMethod.GET)
	public Map<String,Object> querydata(HttpServletRequest req){
		Map<String,Object> map=new HashMap<String,Object>();
		try{
			Integer dtid2=Integer.parseInt(req.getParameter("dtid2"));	//dtid2
			Integer opt=Integer.parseInt(req.getParameter("opt"));		//next or pre
			Integer dataid=1;
			String img="";
			String imgtitle="";
			LocalData data=null;			
			if(opt!=0){
				dataid=Integer.parseInt(req.getParameter("id"));
				LocalData data0=localdataService.selectByPrimaryKey(dataid);
				if(opt==-1){
					data=localdataService.queryDataBefore(dtid2, data0.getDatacreatetime());
					if(data==null){
						data=localdataService.queryDataLast(dtid2);	
					}
				}else if(opt==1){
					data=localdataService.queryDataNext(dtid2, data0.getDatacreatetime());
					if(data==null){
						data=localdataService.queryDataFirst(dtid2);	
					}
				}
			}else{
				data=localdataService.queryDataLast(dtid2);
			}
			if(data!=null){				
				dataid=data.getLocaldataid();
				String fileName=data.getFilepath()+data.getFilename()+"_PS.png";
				String code=RandomUtil.createPassWord(4);
				req.getSession().setAttribute(code, fileName);
				img="ImageStreamServlet?code="+code;
				imgtitle=data.getFilename()+"_PS.png";
				
				log.info("dtid2="+dtid2+",dataid="+dataid+",code="+code);
			}
			map.put("dataid", dataid);
			map.put("img", img);
			map.put("imgtitle", imgtitle);
			
		}catch(Exception ex){
			ex.printStackTrace();
			log.info(ex.toString());
		}
		return map;
	}
	*/
	
	@ResponseBody
	@RequestMapping(value="/querydata", method = RequestMethod.GET)
	public Map<String,Object> querydata(HttpServletRequest req){
		Map<String,Object> map=new HashMap<String,Object>();
		try{
			Integer dtid2=Integer.parseInt(req.getParameter("dtid2"));	//dtid2
			Integer opt=Integer.parseInt(req.getParameter("opt"));		//next or pre
			Integer dataid=0;
			String img="";
			String imgtitle="";
			LocalData data=null;
			int totalCount = (int) localdataService.getCountByDT2Checked(dtid2);
			Page page=new Page(totalCount,1,7);
			List<LocalData> datalist=localdataService.queryDataByPageChecked(dtid2,page);			
			if(opt!=0){
				dataid=Integer.parseInt(req.getParameter("id"));				
				if(opt==-1){
					dataid=(dataid+1)<datalist.size()?(dataid+1):0;					
				}else if(opt==1){
					dataid=(dataid-1)>=0?(dataid-1):(datalist.size()-1);
				}
			}
			Integer dataindex=dataid;
			//codexy  x:dtid2  y:dataindex
			String code=(String)req.getSession().getAttribute("code"+dtid2.toString()+dataindex.toString());				
			if(!datalist.isEmpty()){
				data=datalist.get(dataid);				
				if(data!=null){				
					dataid=data.getLocaldataid();
					String fileName=data.getFilepath()+data.getFilename()+"_PS.png";
					if(code==null || code.equals("")){
						code=RandomUtil.createPassWord(4);
						req.getSession().setAttribute("code"+dtid2.toString()+dataindex.toString(),code);
						req.getSession().setAttribute(code, fileName);
					}
					img="ImageStreamServlet?code="+code;
					imgtitle=data.getFilename()+"_PS.png";					
					//log.info("dtid2="+dtid2+",dataid="+dataid+",code="+code);
				}
			}			
			map.put("dataindex", dataindex);
			map.put("dataid", dataid);
			map.put("img", img);
			map.put("imgtitle", imgtitle);
			
		}catch(Exception ex){
			ex.printStackTrace();
			log.info(ex.toString());
		}
		return map;
	}
	
	//取消需要登陆才下载,2017/11/21
	@RequestMapping(value="/download", method = RequestMethod.GET)
	public void download(@RequestParam(value="id") String param,
			@RequestParam(value="iu") String param2,
			HttpServletRequest req, HttpServletResponse response){		
		try{
			User user=userService.selectByPrimaryKey(Integer.parseInt(param2));
			int countryID=0;
			if(user!=null){
				countryID=user.getUserinsertcountry();
			}else{
				String IP=IPInfoUtil.getIpAddress(req);
				String country=IPInfoUtil.getCountryByIP(IP);
				log.info("IP="+IP+",country="+country);
				countryID=countryService.getCountryIDbyCode2(country);
			}
			
			Integer id=Integer.parseInt(param);
			
			LocalData data=localdataService.selectByPrimaryKey(id);
			String fileName=data.getFilename()+".zip";
			String filePath=data.getFilepath();
			if(!filePath.substring(filePath.length()-1).equals("\\")){
				if(!filePath.substring(filePath.length()-1).equals("/")){
					filePath+="\\";
				}
			}
			filePath+=fileName;
			DownloadUtil.download( fileName, filePath, req, response);
			
			//记录
			DownloadRecord dr=new DownloadRecord();
			dr.setDataid(id);
			dr.setUserid(countryID);		//countryID
			dr.setDltime(new Date());
			downloadrecordService.insertSelective(dr);
			
		}catch(Exception ex){
			log.info(ex.toString());
		}
	}
	
	@RequestMapping(value="/download2", method = RequestMethod.GET)
	public void download2(@RequestParam(value="id") String param,
			@RequestParam(value="iu") String param2,
			@RequestParam(value="zid",required=false,defaultValue="0") Integer zid,
			HttpServletRequest req, HttpServletResponse response){		
		try{
			User user=userService.selectByPrimaryKey(Integer.parseInt(param2));
			if(user==null){
				PrintWriter out = response.getWriter();
				out.print("<script>alert('You must login before download the file!');window.history.back();</script>");
				return;
			}
			
			Integer id=Integer.parseInt(param);			
			UserDownload ud=userdownloadService.selectByPrimaryKey(id);
			if(ud==null || user.getUserid()!=ud.getUserid()){
				PrintWriter out = response.getWriter();
				out.print("<script>alert('Please login with the application account!');window.history.back();</script>");
				return;
			}
			if(!ud.getZipstatus()){
				PrintWriter out = response.getWriter();
				out.print("<script>alert(\"I 'm sorry,the data should be packed before you download!\");window.history.back();</script>");
				return;
			}
			if(ud.getDownloadendtime().getTime() < new Date().getTime()){
				PrintWriter out = response.getWriter();
				out.print("<script>alert('Please login with the application account!');window.history.back();</script>");
				return;
			}
			
			String zpaths=ud.getDownloadlinks();
			String[] zpath=zpaths.split(",");
			String filePath="";
			for(int k=0;k<zpath.length && zid >=0;k++){
				if(!zpath[k].isEmpty()){
					if(zid==0){
						filePath=zpath[k];
					}
					zid--;
				}
			}
			
			int pos=Math.max(filePath.lastIndexOf("/"),filePath.lastIndexOf("\\"));
			String fileName=filePath.substring(pos+1);
			DownloadUtil.download( fileName, filePath, req, response);
						
			//记录
			String[] ssid=ud.getDataid().split("_");
			for(String s:ssid) {
				if(!s.isEmpty()){
					int dataid=Integer.parseInt(s);
					DownloadRecord dr=new DownloadRecord();
					dr.setDataid(dataid);
					dr.setUserid(user.getUserinsertcountry());	//修改为国家ID
					dr.setDltime(new Date());
					downloadrecordService.insertSelective(dr);
				}
			}
			
		}catch(Exception ex){
			log.info(ex.toString());
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/apply", method = RequestMethod.POST)
	public OperateResult apply(HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{
			User user=(User)req.getSession().getAttribute("user");
			if(user==null){
				result.setCode(101);
				return result;
			}
			
			int dtid2=Integer.parseInt(req.getParameter("datatype"));
			dtid2 +=Integer.parseInt(req.getParameter("sensor"));
			dtid2 +=Integer.parseInt(req.getParameter("sn"));			
			//int prj=(int)req.getAttribute("prj");
			//log.info("dtid2="+dtid2);
			String st1=req.getParameter("timeStart");
			String st2=req.getParameter("timeEnd");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date timeStart=sdf.parse(st1);
			Date timeEnd=sdf.parse(st2);
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd");
			
			int totalsize=0;
			String content=sdf2.format(timeStart)+"-"+sdf2.format(timeEnd);
			DataType datatype=datatypeService.selectByPrimaryKey(dtid2);
			content=datatype.getDtname()+"  "+content;
			
			List<LocalData> datalist=localdataService.queryDataByDateRegion(dtid2,timeStart,timeEnd);
			if(datalist==null || datalist.isEmpty()){
				result.setCode(102);
				return result;
			}
			
			String sid="";
			for(LocalData data:datalist) {
				sid+="_"+data.getLocaldataid();
				totalsize+=data.getFilesize();
			}
			sid=sid.substring(1);	//去掉第一个分隔符
			
			UserDownload ud=new UserDownload();
			ud.setUserid(user.getUserid());
			ud.setDataid(sid);
			ud.setContent(content);
			ud.setDatacount(datalist.size());
			ud.setTotaldatasize(totalsize);	
			ud.setOrderdatetime(new Date());
			ud.setCheckedstatus(false);
			ud.setZipstatus(false);
			
			Integer n=userdownloadService.insertSelective(ud);
			result.setCount(n);
		}catch(Exception ex){
			result.setCode(103);
			result.setMess(ex.toString());
			log.info(ex.toString());
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/apply2", method = RequestMethod.GET)
	public String apply2(HttpServletRequest req, HttpServletResponse response){
		int totalsize=0;
		int k=0;
		String result="";
		try{
			
			int dtid2=Integer.parseInt(req.getParameter("datatype"));
			dtid2 +=Integer.parseInt(req.getParameter("sensor"));
			dtid2 +=Integer.parseInt(req.getParameter("sn"));			
			//int prj=(int)req.getAttribute("prj");			
			String st1=req.getParameter("timeStart");
			String st2=req.getParameter("timeEnd");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date timeStart=sdf.parse(st1);
			Date timeEnd=sdf.parse(st2);
			
			List<LocalData> datalist=localdataService.queryDataByDateRegion(dtid2,timeStart,timeEnd);
			for(LocalData data:datalist) {
				totalsize+=data.getFilesize();
			}
			k=datalist.size();
			result=SubStrUtil.StrSize(totalsize);
		}catch(Exception ex){
			result="0B";
			log.info(ex.toString());
		}
		result="You have selected "+k+
				" data altogether. Total size is "+result+
				".please click the button 'Apply for download' to confirm the application.";
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/downloadmulti", method = RequestMethod.GET)
	public OperateResult downloadmulti(@RequestParam(value="id") String param,
			HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{
			User user=(User)req.getSession().getAttribute("user");
			if(user==null){
				result.setCode(101);
				return result;
			}
			
			String[] ssid=param.split("_");
			int k=0;
			int totalsize=0;
			//int dtid=1;
			String content="";
			for(String s:ssid) {
				if(!s.isEmpty() &&  !s.equals("") ){
					LocalData data=localdataService.selectByPrimaryKey(Integer.parseInt(s));
					if(data!=null){
						content+=","+data.getFilename()+".zip";
						totalsize+=data.getFilesize();
						//dtid=data.getDtid2();
						k++;
					}
				}
			}
			if(k>0){
				content=content.substring(1);  //去掉第一个分隔符
				Calendar c = Calendar.getInstance();  
		        c.setTime(new Date());  
		        c.add(Calendar.DAY_OF_MONTH, 7);// 今天+expireDays天
		        Date expireDate=c.getTime();
				
				UserDownload ud=new UserDownload();
				ud.setUserid(user.getUserid());
				ud.setDataid(param);
				ud.setContent(content);
				ud.setDatacount(k);
				ud.setTotaldatasize(totalsize);	
				ud.setOrderdatetime(new Date());
				ud.setCheckedstatus(true);
				ud.setAdminid(1);
				ud.setCheckedtime(new Date());
				ud.setDownloadendtime(expireDate);
				ud.setZipstatus(false);
				
				Integer n=userdownloadService.insertSelective(ud);
				result.setCount(n);
				
				//异步打包数据
				String base=req.getSession().getServletContext().getRealPath("/");
				ZipUtil ziputil = new ZipUtil(ud.getUdid(),1,base);	//ZipUtil继承自Runnable
				Thread myThread1=new Thread(ziputil);
		        myThread1.start();
			}
		}catch(Exception ex){
			result.setCode(102);
			result.setMess(ex.toString());
			log.info(ex.toString());
		}
		return result;
	}
	
	@RequestMapping(value="/verification", method = RequestMethod.GET)
	public String verification(@RequestParam(value="token") String token,
			HttpServletRequest req, HttpServletResponse response,Model model){		
		try{
			if(token.length()!=28){
				model.addAttribute("code",0);
			}else{
				String sid=token.substring(8,16);
				Integer userid=Integer.parseInt(MD5Util.replace2(sid))-20171120;
				User user=userService.selectByPrimaryKey(userid);
				if(user==null || user.getUserstatus()!=0){
					model.addAttribute("code",0);
				}else{
					String token2=MD5Util.createTokenforVerification(user.getUserid(), user.getLoginname(), user.getRegtime());
					if(token.equals(token2)){
						model.addAttribute("code",1);
						user.setUserstatus(1);
						userService.updateByPrimaryKeySelective(user);
					}else{
						model.addAttribute("code",0);
					}
				}
			}
		}catch(Exception ex){
			log.info(ex.toString());
			model.addAttribute("code",0);
		}
		return "show/verification";
	}
}
