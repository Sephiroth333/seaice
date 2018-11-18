package com.nowbin.bean;

import java.util.Date;

public class LocalData {
    private Integer localdataid;

    private Integer dtid2;

    private String filename;

    private String filepath;

    private Integer filesize;

    private Date datacreatetime;

    private Date dataprocessedtime;

    private Integer ischecked;

    private Date checkedtime;

    private Integer adminid;

    public Integer getLocaldataid() {
        return localdataid;
    }

    public void setLocaldataid(Integer localdataid) {
        this.localdataid = localdataid;
    }

    public Integer getDtid2() {
        return dtid2;
    }

    public void setDtid2(Integer dtid2) {
        this.dtid2 = dtid2;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename == null ? null : filename.trim();
    }

    public String getFilepath() {
        return filepath;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath == null ? null : filepath.trim();
    }

    public Integer getFilesize() {
        return filesize;
    }

    public void setFilesize(Integer filesize) {
        this.filesize = filesize;
    }

    public Date getDatacreatetime() {
        return datacreatetime;
    }

    public void setDatacreatetime(Date datacreatetime) {
        this.datacreatetime = datacreatetime;
    }

    public Date getDataprocessedtime() {
        return dataprocessedtime;
    }

    public void setDataprocessedtime(Date dataprocessedtime) {
        this.dataprocessedtime = dataprocessedtime;
    }

    public Integer getIschecked() {
        return ischecked;
    }

    public void setIschecked(Integer ischecked) {
        this.ischecked = ischecked;
    }

    public Date getCheckedtime() {
        return checkedtime;
    }

    public void setCheckedtime(Date checkedtime) {
        this.checkedtime = checkedtime;
    }

    public Integer getAdminid() {
        return adminid;
    }

    public void setAdminid(Integer adminid) {
        this.adminid = adminid;
    }
}