package com.nowbin.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.nowbin.bean.LocalData;
import com.nowbin.bean.UserDownload;
import com.nowbin.service.LocalDataService;
import com.nowbin.service.UserDownloadService;

/**
 * 
 * Zip异步压缩工具类
 * http://www.cnblogs.com/qingergege/p/5768376.html
 *
 */
public class ZipUtil implements Runnable  {
	
	private static Logger log = LoggerFactory.getLogger(ZipUtil.class);
	
	//用于在非controller类里面调用service方法
	private ApplicationContext ac = new ClassPathXmlApplicationContext("spring-mybatis.xml");  
	//XXXService xxxService = (XXXService) ac.getBean("XXXService");
		
	private Integer id;
	private String basepath;
	private Integer fid;
	
	public ZipUtil(){
		
	}
	
	public ZipUtil(Integer id,Integer fid,String basepath){
		this.id=id;
		this.fid=fid;
		this.basepath=basepath;
	}
	
	public void setFID(Integer fid){
		this.fid=fid;
	}
	
	public void setID(Integer id){
		this.id=id;
	}
	
	public void setBasePath(String basepath){
		this.basepath=basepath;
	}
	
	public void run(){
		try{
			zipOtherData(this.id,this.basepath);		
			//log.info("zip finished.id="+this.id);
			//删除过期文件
			clearExpiredZips();
		}
		catch(Exception ex){
			log.info(ex.toString());
		}
	}
	
	private void zipOtherData(Integer id2, String basepath2) {
		// TODO Auto-generated method stub
		ZipOutputStream out=null;
		BufferedOutputStream bos=null;
		FileInputStream fos=null;
		BufferedInputStream bis=null;
		String zipFileName="";
		try{
			UserDownloadService userdownloadService=(UserDownloadService) ac.getBean("UserDownloadService");
			UserDownload ud=userdownloadService.selectByPrimaryKey(id);
			if(!ud.getCheckedstatus()) return;
			
			String[] sids=ud.getDataid().split("_");
			List<Integer> ids=new ArrayList<Integer>();
			for(String item:sids){
				if(!item.isEmpty()) ids.add(Integer.parseInt(item));
			}
			if(ids.size()>0){
				//文件压缩
				DateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmss");
				String fileName2=sdf2.format(new Date())+ud.getUdid().toString();
	  	        zipFileName=basepath2+"download\\"+fileName2+".zip";
	  	        out = new ZipOutputStream( new FileOutputStream(zipFileName));
		        bos = new BufferedOutputStream(out);
		        log.info(zipFileName);
				for(Integer dataid:ids){
					LocalDataService dataService=(LocalDataService) ac.getBean("LocalDataService");
					LocalData data=dataService.selectByPrimaryKey(dataid);
		  	        String fileName=data.getFilename()+".zip";		  	        
			        out.putNextEntry( new ZipEntry(fileName));	//压缩包内文件名
			        fos = new FileInputStream(data.getFilepath()+fileName);
			        bis = new BufferedInputStream(fos);
			        int tag;
			        byte[] b=new byte[1024];
			        //将源文件写入到zip文件中
			        while((tag=fos.read(b))!=-1)
			        {
			            bos.write(b,0,tag);			            
			        }
			        bos.flush();	//必须flush，否则可能导致部分文件
		            bis.close();
		            fos.close();
				}
		        bos.close();
		        out.close();
		        
		        //更新数据库
		        File file=new File(zipFileName);
		        Integer totaldatasize=(int)file.length();
		        ud.setZipcount(1);
		        ud.setZipstatus(true);
		        ud.setTotaldatasize(totaldatasize);
		        ud.setZipsize(totaldatasize.toString());
		        ud.setDownloadlinks(basepath2+"download\\"+fileName2+".zip");
		        userdownloadService.updateByPrimaryKeySelective(ud);
			}
		}catch(Exception ex){
			// 如果抛出异常,则删除生成的压缩文件
			if(bos!=null){
				try {
					bos.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(out!=null){
				try {
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			File file=new File(zipFileName);
            if(file.exists()){   
            	file.delete();  
            }
			log.info(ex.toString());
		}finally{
			if(bis!=null){
				try {
					bis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(fos!=null){
				try {
					fos.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(bos!=null){
				try {
					bos.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(out!=null){
				try {
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	public static void compress(ZipOutputStream out,BufferedOutputStream bos,File sourceFile,String base) throws Exception
    {
        //如果路径为目录（文件夹）
        if(sourceFile.isDirectory())
        {
        
            //取出文件夹中的文件（或子文件夹）
            File[] flist = sourceFile.listFiles();
            
            if(flist.length==0)//如果文件夹为空，则只需在目的地zip文件中写入一个目录进入点
            {
                //System.out.println(base+"/");
                out.putNextEntry(  new ZipEntry(base+"/") );
            }
            else//如果文件夹不为空，则递归调用compress，文件夹中的每一个文件（或文件夹）进行压缩
            {
                for(int i=0;i<flist.length;i++)
                {
                    compress(out,bos,flist[i],base+"/"+flist[i].getName());
                }
            }
        }
        else//如果不是目录（文件夹），即为文件，则先写入目录进入点，之后将文件写入zip文件中
        {
            out.putNextEntry( new ZipEntry(base) );
            FileInputStream fos = new FileInputStream(sourceFile);
            BufferedInputStream bis = new BufferedInputStream(fos);
            
            int tag;
            //System.out.println(base);
            //将源文件写入到zip文件中
            while((tag=bis.read())!=-1)
            {
                bos.write(tag);
            }
            bis.close();
            fos.close();
            
        }
    }
	
	public static void compress(ZipOutputStream out,BufferedOutputStream bos,BufferedInputStream bis,String base) throws Exception
	{
		out.putNextEntry( new ZipEntry(base) );        
        int tag;
        //System.out.println(base);
        //将源文件写入到zip文件中
        while((tag=bis.read())!=-1)
        {
            bos.write(tag);
        }
	}
	
	public void clearExpiredZips(){
		try{
			UserDownloadService userdownloadService=(UserDownloadService) ac.getBean("UserDownloadService");
			List<UserDownload> udlist=userdownloadService.queryDataByExpiredDate(new Date());
			for(UserDownload ud : udlist){
				if(ud.getZipstatus()){
					String[] zipfiles=ud.getDownloadlinks().split(";");
					for(String zipfile : zipfiles){
						if(!zipfile.isEmpty()){
							File file=new File(zipfile);
							if(file.exists()) file.delete();
						}
					}
					ud.setZipstatus(false);
					ud.setZipcount(0);
					ud.setZipsize("0");
					ud.setDownloadlinks("");
					userdownloadService.updateByPrimaryKeyWithBLOBs(ud);
				}
			}
		}catch(Exception ex){
			log.info(ex.toString());
		}		
	}
}
