/**
 * 
 */
package com.nowbin.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.nowbin.bean.OperateResult;
import com.nowbin.bean.User;
import com.nowbin.bean.UserDownload;
import com.nowbin.bean.UserDownloadView;
import com.nowbin.service.AdminService;
import com.nowbin.service.UserDownloadService;
import com.nowbin.service.UserService;
import com.nowbin.util.EmailUtil;
import com.nowbin.util.Page;
import com.nowbin.util.StripXssUtil;
import com.nowbin.util.ZipUtil;

/**
 * @author aeolus
 *
 */
@Controller
@RequestMapping("/admin")
public class UserDownloadController {

private static Logger log = LoggerFactory.getLogger(UserDownloadController.class);
	
	@Resource
	private AdminService adminService;
	
	@Resource
	private UserDownloadService userdownloadService;
	
	@Resource
	private UserService userService;
	
	@RequestMapping("/downloadManage")
	public String downloadManage(Model model,HttpServletRequest req){
		try{			
			String pageNow = req.getParameter("pageNow");
			Page page = null;
			int totalCount = (int) userdownloadService.getCount();
			if (pageNow != null) {
				page = new Page(totalCount, Integer.parseInt(pageNow));
			} else {
				page = new Page(totalCount, 1);
			}
			
			List<UserDownloadView> datalist=userdownloadService.queryDataViewByPage(page);
			model.addAttribute("page", page);
			model.addAttribute("datalist", datalist);
			return "admin/downloadManage";
		}catch(Exception ex){
			log.info(ex.toString());
		}
		return "/admin/error?code=101";
	}
	
	@ResponseBody
	@RequestMapping("/downloadCheck")
	public OperateResult downloadCheck(HttpServletRequest req, HttpServletResponse response){
		OperateResult result=new OperateResult();
		try{
			
			Integer count=0;
			String base=req.getSession().getServletContext().getRealPath("/");
			String sids=StripXssUtil.stripXSS(req.getParameter("id"));
			Integer checkstatus= Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("checkstatus")));
			if(checkstatus!=1) {
				result.setCode(101);
				return result;
			}
			
			Integer expireDays=Integer.parseInt(StripXssUtil.stripXSS(req.getParameter("expireDays")));
			Calendar c = Calendar.getInstance();  
	        c.setTime(new Date());  
	        c.add(Calendar.DAY_OF_YEAR, expireDays);// 今天+expireDays天
	        Date expireDate=c.getTime();
			String[] sidlist=sids.split("_");
			for(String sid : sidlist){
				if( sid !=null && !sid.isEmpty()){
					int id=Integer.parseInt(sid);
					UserDownload ud=userdownloadService.selectByPrimaryKey(id);
					if(!ud.getCheckedstatus()){
						ud.setCheckedstatus(true);
						ud.setAdminid(1);
						ud.setCheckedtime(new Date());
						ud.setDownloadendtime(expireDate);
						count+=userdownloadService.updateByPrimaryKeySelective(ud);
						
						//发送email
						try{
							User u=userService.selectByPrimaryKey(ud.getUserid());
							String basePath =req.getScheme()+"://"+req.getServerName()+":"+req.getServerPort()+req.getContextPath()+"/";
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
							String strexpireDate=sdf.format(expireDate);
							String mess="<html><title></title><body><div>";
							mess+="<p>Hello,"+u.getRealname()+":</p>";
							mess+="<p>Your download application has been passed, please download it in your personal Center.</p>";
							mess+="<p>Click here to login:<a href='"+basePath+"'>"+basePath+"</a></p>";
							mess+="<p>notice:the download link will expire at "+strexpireDate+".</p>";
							mess+="</div></body>";
							EmailUtil.send_email(u.getLoginemail(), "Download application passed!", mess);
						}catch(Exception ex2){
							log.info(ex2.toString());
						}
					}
					if(!ud.getZipstatus()){
						//异步打包数据
						ZipUtil ziputil = new ZipUtil(ud.getUdid(),1,base);	//ZipUtil继承自Runnable
						Thread myThread1=new Thread(ziputil);
				        myThread1.start();
					}
				}
			}
			result.setCount(count);			
		}catch(Exception ex){
			log.info(ex.toString());
			result.setCode(101);
		}
		return result;
	}
	
}
