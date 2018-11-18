package com.nowbin.downloadutil;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nowbin.util.NumCheckUtil;
import com.nowbin.util.downloadutil.DownloadRecord;

/**
 * 
 * 下载java通用实现工具类
 * http://blog.csdn.net/wuzuodingfeng/article/details/53489089
 * 因为是这种实现方式是基于循环写入的方式进行下载，在每次将字节块写入到输出流中的时都会进行输出流的合法性检测，
 * 在因为用户取消或者网络原因造成socket断开的时候，系统会抛出SocketWriteException，系统可以捕捉这个过程
 * 中抛出的异常，当捕捉到异常的时候我们可以记录当前已经传输的数据量，这样就可以完成下载状态和对应状态下载量
 * 和速度之类的数据记录。另外这种方式实现方式还可以实现一种断点续载的功能。
 * 
 * http://wzzcn.iteye.com/blog/889107
 *
 */
public class DownloadUtil {
	
	public static void download(String fileName, String filePath,
			HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
	    //声明本次下载状态的记录对象
	    DownloadRecord downloadRecord = new DownloadRecord(fileName, filePath, request);
	    
	    //设置响应头和客户端保存文件名	      
        String browser=downloadRecord.getUa();  //获取浏览器类型
        // 设置响应头，206支持断点续传 （断点续传有问题，禁用）
        int http_status=200;
        //int http_status=206;  
        //if(browser.contains("MSIE"))  
        //    http_status=200;//200 响应头，不支持断点续传  
        response.reset();
        response.setStatus(http_status);
	    response.setCharacterEncoding("utf-8");
	    response.setContentType("multipart/form-data");
	    //用于记录已完成的下载的数据量，单位是byte
	    long downloadedLength = 0l;
	    try {	    	
	    	File file = new File(filePath);
	    	if(!file.exists()){
	    		response.sendError(404);
                return;
	    	}
            long since=0;  //下载起始位置            
            long until=file.length()-1;	//下载结束位置
            
            //获取Range，下载范围  
            String range=request.getHeader("range");  
            if(range!=null){  
                //剖解range  
                range=range.split("=")[1];
                String[] rs=range.split("-");  
                if(NumCheckUtil.isInteger(rs[0])){
                    since=Integer.parseInt(rs[0])>0?Integer.parseInt(rs[0]):0;  
                }  
                if(rs.length>1&&NumCheckUtil.isInteger(rs[1])){  
                    until=file.length()-1<Integer.parseInt(rs[1])?file.length()-1:Integer.parseInt(rs[1]);
                }
            }
            //设置响应头  
            response.setHeader("Accept-Ranges", "bytes");  
            response.setHeader("Content-Range", "bytes "+since+"-"+ until + "/"  
                    + file.length());  
            //文件名用ISO08859_1编码
    	    //response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
            response.setHeader("Content-Disposition", "attachment; filename=\"" +  
                    new String(fileName.getBytes(),"ISO8859_1")+ "\"");  
            response.setHeader("Content-Length", "" + (until-since+1));  
            //System.out.println("download: "+fileName);
            //打开本地文件流
	        InputStream inputStream = new FileInputStream(filePath);
	        inputStream.skip(since);
	        //激活下载操作
	        OutputStream os = response.getOutputStream();
	        //循环写入输出流
	        byte[] b = new byte[2048];
	        int length;
	        boolean full=false;
	        while ((length = inputStream.read(b)) > 0) {
	        	 if(downloadedLength + length > until-since+1){
	        		 length=(int) (until-since+1-downloadedLength);
	        		 full=true;
	             }
	        	 os.write(b, 0, length);
	        	 downloadedLength += b.length;
	        	 if(full){
	        		 break;  
	        	 }	        	 
	        }
	        os.flush();
	        os.close();
	        inputStream.close();
	    } catch (Exception e){
	        downloadRecord.setStatus(DownloadRecord.STATUS_ERROR);
	        downloadRecord.setLength(downloadedLength);
	        e.printStackTrace();
	        throw e;
	    }
	    downloadRecord.setStatus(DownloadRecord.STATUS_SUCCESS);
	    downloadRecord.setEndTime(new Timestamp(System.currentTimeMillis()));
	    downloadRecord.setLength(downloadedLength);
	    //存储记录
	}

}


