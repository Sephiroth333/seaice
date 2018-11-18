package com.nowbin.bean;

import java.util.Date;

public class UserDownload {
    private Integer udid;

    private Integer userid;

    private Integer datacount;

    private Integer totaldatasize;

    private Date orderdatetime;

    private String content;

    private Boolean checkedstatus;

    private Integer adminid;

    private Date checkedtime;

    private Boolean zipstatus;

    private Integer zipcount;

    private String zipsize;

    private String downloadlinks;

    private Date downloadendtime;

    private String dataid;

    public Integer getUdid() {
        return udid;
    }

    public void setUdid(Integer udid) {
        this.udid = udid;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getDatacount() {
        return datacount;
    }

    public void setDatacount(Integer datacount) {
        this.datacount = datacount;
    }

    public Integer getTotaldatasize() {
        return totaldatasize;
    }

    public void setTotaldatasize(Integer totaldatasize) {
        this.totaldatasize = totaldatasize;
    }

    public Date getOrderdatetime() {
        return orderdatetime;
    }

    public void setOrderdatetime(Date orderdatetime) {
        this.orderdatetime = orderdatetime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Boolean getCheckedstatus() {
        return checkedstatus;
    }

    public void setCheckedstatus(Boolean checkedstatus) {
        this.checkedstatus = checkedstatus;
    }

    public Integer getAdminid() {
        return adminid;
    }

    public void setAdminid(Integer adminid) {
        this.adminid = adminid;
    }

    public Date getCheckedtime() {
        return checkedtime;
    }

    public void setCheckedtime(Date checkedtime) {
        this.checkedtime = checkedtime;
    }

    public Boolean getZipstatus() {
        return zipstatus;
    }

    public void setZipstatus(Boolean zipstatus) {
        this.zipstatus = zipstatus;
    }

    public Integer getZipcount() {
        return zipcount;
    }

    public void setZipcount(Integer zipcount) {
        this.zipcount = zipcount;
    }

    public String getZipsize() {
        return zipsize;
    }

    public void setZipsize(String zipsize) {
        this.zipsize = zipsize == null ? null : zipsize.trim();
    }

    public String getDownloadlinks() {
        return downloadlinks;
    }

    public void setDownloadlinks(String downloadlinks) {
        this.downloadlinks = downloadlinks == null ? null : downloadlinks.trim();
    }

    public Date getDownloadendtime() {
        return downloadendtime;
    }

    public void setDownloadendtime(Date downloadendtime) {
        this.downloadendtime = downloadendtime;
    }

    public String getDataid() {
        return dataid;
    }

    public void setDataid(String dataid) {
        this.dataid = dataid == null ? null : dataid.trim();
    }
}