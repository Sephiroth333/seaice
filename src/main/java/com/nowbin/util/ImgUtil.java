/**
 * 
 */
package com.nowbin.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.zip.GZIPOutputStream;

/**
 * @author Aeolus
 *
 */
public class ImgUtil {
	
	/**
	 * 将图片转换为字符串
	 * 
	 */	
	public static String Image2String(File file){
		String finalData=null;
		try{
			byte[] data=loadImage(file);
			String dataString=byteToString(data);
			finalData=compress(dataString);
		}catch(Exception e){
	        e.printStackTrace();
	    }
		return finalData;
		
	}
	
	/**
	* 将图片转换为字节数组
	* @return
	*/
	private static byte[] loadImage(File file){
	    //用于返回的字节数组
	    byte[] data=null;
	    //打开文件输入流
	    FileInputStream fin=null;
	    //打开字节输出流
	    ByteArrayOutputStream bout=null;
	    try{
	        //文件输入流获取对应文件
	        fin=new FileInputStream(file);
	        //输出流定义缓冲区大小
	        bout=new ByteArrayOutputStream((int)file.length());
	        //定义字节数组，用于读取文件流
	        byte[] buffer=new byte[1024];
	        //用于表示读取的位置
	        int len=-1;
	        //开始读取文件
	        while((len=fin.read(buffer))!=-1){
	            //从buffer的第0位置开始，读取至第len位置，结果写入bout
	            bout.write(buffer,0,len);
	        }
	        //将输出流转为字节数组
	        data=bout.toByteArray();
	        //关闭输入输出流
	        fin.close();
	        bout.close();
	    }catch(Exception e){
	        e.printStackTrace();
	    }
	    return data;
	}
	
	/**
	* 把字节数组转化为字符串----"ISO-8859-1"
	* @param date
	* @return
	*/
	private static String byteToString(byte[] data){
	    String dataString=null;
	    try{
	        //将字节数组转为字符串，编码格式为ISO-8859-1
	        dataString=new String(data,"ISO-8859-1");
	    }catch(Exception e){
	        e.printStackTrace();
	    }
	    return dataString;
	}
	
	/**
	* 压缩字符串----"ISO-8859-1"
	* @param data
	* @return
	*/
	private static String compress(String data){
	    String finalData=null;
	    try{
	        //打开字节输出流
	        ByteArrayOutputStream bout=new ByteArrayOutputStream();
	        //打开压缩用的输出流,压缩后的结果放在bout中
	        GZIPOutputStream gout=new GZIPOutputStream(bout);
	        //写入待压缩的字节数组
	        gout.write(data.getBytes("ISO-8859-1"));
	        //完成压缩写入
	        gout.finish();
	        //关闭输出流
	        gout.close();
	        finalData=bout.toString("ISO-8859-1");
	    }catch(Exception e){
	        e.printStackTrace();
	    }
	    return finalData;
	}

}
