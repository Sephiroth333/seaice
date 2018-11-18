package com.nowbin.bean;

import java.util.Date;

public class DownloadRecord {
    private Integer id;

    private Integer dataid;

    private Integer userid;		//为实现不登录下载用户国家判断，该字段用于表征国家代码

    private Date dltime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDataid() {
        return dataid;
    }

    public void setDataid(Integer dataid) {
        this.dataid = dataid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Date getDltime() {
        return dltime;
    }

    public void setDltime(Date dltime) {
        this.dltime = dltime;
    }
}