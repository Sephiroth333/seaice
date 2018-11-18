package com.nowbin.bean;

import java.util.Date;

public class News {
    private Integer newsid;

    private String author;

    private Date updatetime;
    
    private String newstitle;

    private Integer newsstatus;

    public Integer getNewsid() {
        return newsid;
    }

    public void setNewsid(Integer newsid) {
        this.newsid = newsid;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }
    
    public String getNewstitle() {
        return newstitle;
    }

    public void setNewstitle(String newstitle) {
        this.newstitle = newstitle == null ? null : newstitle.trim();
    }

    public Integer getNewsstatus() {
        return newsstatus;
    }

    public void setNewsstatus(Integer newsstatus) {
        this.newsstatus = newsstatus;
    }
}