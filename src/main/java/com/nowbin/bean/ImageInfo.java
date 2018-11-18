/**
 * 
 */
package com.nowbin.bean;

/**
 * @author aeolus
 *
 */
public class ImageInfo {
	private int dataid;
	private String img;
	private String imgtitle;
	
	public ImageInfo(){
		
	}
	
	public ImageInfo(int dataid,String img,String imgtitle){
		this.dataid = dataid;
		this.img = img;
		this.imgtitle = imgtitle;
	}
	
	public int getDataid() {
		return dataid;
	}
	public void setDataid(int dataid) {
		this.dataid = dataid;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getImgtitle() {
		return imgtitle;
	}
	public void setImgtitle(String imgtitle) {
		this.imgtitle = imgtitle;
	}
}
