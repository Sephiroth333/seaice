package com.nowbin.bean;

import java.util.Date;

public class RemoteData {
    private Integer remoteid;

    private String filename;

    private String filepath;

    private Integer datatypeid;

    private Date lastmodifytime;

    private Integer filesize;

    private Date downloadtime;

    private String processedpath;

    private Date processedtime;

    private Integer filestatus;

    public Integer getRemoteid() {
        return remoteid;
    }

    public void setRemoteid(Integer remoteid) {
        this.remoteid = remoteid;
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

    public Integer getDatatypeid() {
        return datatypeid;
    }

    public void setDatatypeid(Integer datatypeid) {
        this.datatypeid = datatypeid;
    }

    public Date getLastmodifytime() {
        return lastmodifytime;
    }

    public void setLastmodifytime(Date lastmodifytime) {
        this.lastmodifytime = lastmodifytime;
    }

    public Integer getFilesize() {
        return filesize;
    }

    public void setFilesize(Integer filesize) {
        this.filesize = filesize;
    }

    public Date getDownloadtime() {
        return downloadtime;
    }

    public void setDownloadtime(Date downloadtime) {
        this.downloadtime = downloadtime;
    }

    public String getProcessedpath() {
        return processedpath;
    }

    public void setProcessedpath(String processedpath) {
        this.processedpath = processedpath == null ? null : processedpath.trim();
    }

    public Date getProcessedtime() {
        return processedtime;
    }

    public void setProcessedtime(Date processedtime) {
        this.processedtime = processedtime;
    }

    public Integer getFilestatus() {
        return filestatus;
    }

    public void setFilestatus(Integer filestatus) {
        this.filestatus = filestatus;
    }
}