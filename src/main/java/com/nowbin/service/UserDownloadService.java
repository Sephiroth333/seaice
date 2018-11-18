package com.nowbin.service;

import java.util.Date;
import java.util.List;

import com.nowbin.bean.UserDownload;
import com.nowbin.bean.UserDownloadView;
import com.nowbin.util.Page;

public interface UserDownloadService {
	
	int deleteByPrimaryKey(Integer udid);

    int insert(UserDownload record);

    int insertSelective(UserDownload record);

    UserDownload selectByPrimaryKey(Integer udid);

    int updateByPrimaryKeySelective(UserDownload record);

    int updateByPrimaryKeyWithBLOBs(UserDownload record);

    int updateByPrimaryKey(UserDownload record);
    
    long getCountByUser(int userid);
    
    long getCount();
    
    List<UserDownload> queryDataByUser(int userid, Page page);
    
    List<UserDownload> queryDataByPage(Page page);
    
    List<UserDownload> queryDataByExpiredDate(Date expiredate);
    
    List<UserDownloadView> queryDataViewByPage(Page page);

}
