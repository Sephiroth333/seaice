package com.nowbin.util.downloadutil;

import java.sql.Timestamp;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

public class DownloadRecord {
	
	public static final int STATUS_ERROR = 0;
    public static final int STATUS_SUCCESS = 1;
    private String uid;
    private String ip;
    private int port;
    private String ua;
    private String fileName;
    private String filePath;
    private long length;		//已完成的下载的数据量
    private int status;
    private Timestamp startTime;
    private Timestamp endTime;

    public DownloadRecord() {
    }

    public DownloadRecord(String fileName, String filePath, 
    HttpServletRequest request) {
        this.setUid(UUID.randomUUID().toString().replace("-",""));
        this.setFileName(fileName);
        this.setFilePath(filePath);
        this.setIp(request.getRemoteAddr());
        this.setPort(request.getRemotePort());
        this.setUa(this.ua = request.getHeader("user-agent"));
        this.setStartTime(new Timestamp(System.currentTimeMillis()));
    }

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public long getLength() {
		return length;
	}

	public void setLength(long length) {
		this.length = length;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Timestamp getStartTime() {
		return startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public Timestamp getEndTime() {
		return endTime;
	}

	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}

	public String getUa() {
		return ua;
	}

	public String setUa(String ua) {
		this.ua = ua;
		return ua;
	}

}
