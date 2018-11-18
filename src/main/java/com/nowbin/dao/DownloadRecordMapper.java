package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.DownloadCountry;
import com.nowbin.bean.DownloadRecord;
import com.nowbin.bean.DownloadRecordView;

public interface DownloadRecordMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DownloadRecord record);

    int insertSelective(DownloadRecord record);

    DownloadRecord selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DownloadRecord record);

    int updateByPrimaryKey(DownloadRecord record);
    
    List<DownloadRecord> queryData(Map<String, Object> map);
    
    List<DownloadRecordView> queryDataView(Map<String, Object> map);
    
    long getCount(Map<String, Object> map);
    
    List<DownloadCountry> queryDownloadCountry(Map<String, Object> map);
}