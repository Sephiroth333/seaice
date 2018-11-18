package com.nowbin.bean;

public class NewsWithBLOBs extends News {
    

    private String newscontent;

    public String getNewscontent() {
        return newscontent;
    }

    public void setNewscontent(String newscontent) {
        this.newscontent = newscontent == null ? null : newscontent.trim();
    }
}