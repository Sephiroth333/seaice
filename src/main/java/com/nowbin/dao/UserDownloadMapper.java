package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.UserDownload;
import com.nowbin.bean.UserDownloadView;

public interface UserDownloadMapper {
    int deleteByPrimaryKey(Integer udid);

    int insert(UserDownload record);

    int insertSelective(UserDownload record);

    UserDownload selectByPrimaryKey(Integer udid);

    int updateByPrimaryKeySelective(UserDownload record);

    int updateByPrimaryKeyWithBLOBs(UserDownload record);

    int updateByPrimaryKey(UserDownload record);
    
    long getCount(Map<String, Object> map);
    
    List<UserDownload> queryData(Map<String, Object> map);
    
    List<UserDownloadView> queryDataView(Map<String, Object> map);
}