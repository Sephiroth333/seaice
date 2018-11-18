package com.nowbin.bean;

public class DataType {
    private Integer dtid;

    private String dtname;

    private String dtfather;

    private String remotepath;

    private String dtlocalpath;

    private String dtpath;

    private String dtcontent;

    private Integer dtstatus;

    private Integer issn;

    private String maskkeywords;

    private String maskkeywords1;

    private Integer remotefilescount;

    private Integer downloadfilescount;

    private Integer finishedfilescount;

    public Integer getDtid() {
        return dtid;
    }

    public void setDtid(Integer dtid) {
        this.dtid = dtid;
    }

    public String getDtname() {
        return dtname;
    }

    public void setDtname(String dtname) {
        this.dtname = dtname == null ? null : dtname.trim();
    }

    public String getDtfather() {
        return dtfather;
    }

    public void setDtfather(String dtfather) {
        this.dtfather = dtfather == null ? null : dtfather.trim();
    }

    public String getRemotepath() {
        return remotepath;
    }

    public void setRemotepath(String remotepath) {
        this.remotepath = remotepath == null ? null : remotepath.trim();
    }

    public String getDtlocalpath() {
        return dtlocalpath;
    }

    public void setDtlocalpath(String dtlocalpath) {
        this.dtlocalpath = dtlocalpath == null ? null : dtlocalpath.trim();
    }

    public String getDtpath() {
        return dtpath;
    }

    public void setDtpath(String dtpath) {
        this.dtpath = dtpath == null ? null : dtpath.trim();
    }

    public String getDtcontent() {
        return dtcontent;
    }

    public void setDtcontent(String dtcontent) {
        this.dtcontent = dtcontent == null ? null : dtcontent.trim();
    }

    public Integer getDtstatus() {
        return dtstatus;
    }

    public void setDtstatus(Integer dtstatus) {
        this.dtstatus = dtstatus;
    }

    public Integer getIssn() {
        return issn;
    }

    public void setIssn(Integer issn) {
        this.issn = issn;
    }

    public String getMaskkeywords() {
        return maskkeywords;
    }

    public void setMaskkeywords(String maskkeywords) {
        this.maskkeywords = maskkeywords == null ? null : maskkeywords.trim();
    }

    public String getMaskkeywords1() {
        return maskkeywords1;
    }

    public void setMaskkeywords1(String maskkeywords1) {
        this.maskkeywords1 = maskkeywords1 == null ? null : maskkeywords1.trim();
    }

    public Integer getRemotefilescount() {
        return remotefilescount;
    }

    public void setRemotefilescount(Integer remotefilescount) {
        this.remotefilescount = remotefilescount;
    }

    public Integer getDownloadfilescount() {
        return downloadfilescount;
    }

    public void setDownloadfilescount(Integer downloadfilescount) {
        this.downloadfilescount = downloadfilescount;
    }

    public Integer getFinishedfilescount() {
        return finishedfilescount;
    }

    public void setFinishedfilescount(Integer finishedfilescount) {
        this.finishedfilescount = finishedfilescount;
    }
}