package com.nowbin.bean;

public class Menu {
    private Integer menuid;

    private String menutitle;

    private String menucontent;

    public Integer getMenuid() {
        return menuid;
    }

    public void setMenuid(Integer menuid) {
        this.menuid = menuid;
    }

    public String getMenutitle() {
        return menutitle;
    }

    public void setMenutitle(String menutitle) {
        this.menutitle = menutitle == null ? null : menutitle.trim();
    }

    public String getMenucontent() {
        return menucontent;
    }

    public void setMenucontent(String menucontent) {
        this.menucontent = menucontent == null ? null : menucontent.trim();
    }
}