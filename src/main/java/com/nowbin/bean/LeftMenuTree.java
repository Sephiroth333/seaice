/**
 * 
 */
package com.nowbin.bean;

import java.util.ArrayList;
import java.util.List;

/**
 * @author aeolus
 *
 */
public class LeftMenuTree {

	private List<LeftMenu> menusonlist;
	private String menutitle;
	private String imgUrl;
	
	public LeftMenuTree(){
		setMenusonlist(new ArrayList<LeftMenu>());
		setMenutitle("");
		setImgUrl("");
	}

	public List<LeftMenu> getMenusonlist() {
		return menusonlist;
	}

	public void setMenusonlist(List<LeftMenu> menusonlist) {
		this.menusonlist = menusonlist;
	}

	public String getMenutitle() {
		return menutitle;
	}

	public void setMenutitle(String menutitle) {
		this.menutitle = menutitle;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
}
