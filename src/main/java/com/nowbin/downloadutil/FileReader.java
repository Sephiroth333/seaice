package com.nowbin.downloadutil;

import java.io.IOException;

public class FileReader {

	/** 
     * 移动文件指针到指定位置 
     * @param pos 
     * @throws IOException 
     */  
    public void seek(long pos) throws IOException{
    	
    }  
  
    /** 
     * 获取文件指针位置 
     * @return 文件指针位置 
     * @throws IOException 
     */  
    public long tell() throws IOException{
    	return 0;
    } 
  
    /** 
     * 从文件指针开始读取一段数据到数组中，返回读取的字节数 
     * @param byte数组 
     * @return 读取的字节数 
     * @throws IOException 
     */  
    public int read(byte[] bytes) throws IOException{
    	return 0;
    }
  
    /** 
     * 从文件指针开始读取一段数据到数组指定位置中，返回读取的字节数 
     * @param byte数组 
     * @param off数组偏移量 
     * @param len读取的最大字节数 
     * @return 读取的字节数 
     * @throws IOException 
     */  
    public int read(byte[] bytes, int off, int len) throws IOException{
    	return 0;
    } 
      
    /** 
     * 关闭 
     */  
    public void close(){
    	
    } 
}
