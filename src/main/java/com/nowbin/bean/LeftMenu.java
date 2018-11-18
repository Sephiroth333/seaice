package com.nowbin.bean;

public class LeftMenu {
    private Integer id;

    private Integer dtfatherid;

    private String dtnamefather;

    private String dtnameson;

    private String dturl;

    private Integer dttype;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDtfatherid() {
        return dtfatherid;
    }

    public void setDtfatherid(Integer dtfatherid) {
        this.dtfatherid = dtfatherid;
    }

    public String getDtnamefather() {
        return dtnamefather;
    }

    public void setDtnamefather(String dtnamefather) {
        this.dtnamefather = dtnamefather == null ? null : dtnamefather.trim();
    }

    public String getDtnameson() {
        return dtnameson;
    }

    public void setDtnameson(String dtnameson) {
        this.dtnameson = dtnameson == null ? null : dtnameson.trim();
    }

    public String getDturl() {
        return dturl;
    }

    public void setDturl(String dturl) {
        this.dturl = dturl == null ? null : dturl.trim();
    }

    public Integer getDttype() {
        return dttype;
    }

    public void setDttype(Integer dttype) {
        this.dttype = dttype;
    }
}