package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.LocalData;

public interface LocalDataMapper {
    int deleteByPrimaryKey(Integer localdataid);

    int insert(LocalData record);

    int insertSelective(LocalData record);

    LocalData selectByPrimaryKey(Integer localdataid);

    int updateByPrimaryKeySelective(LocalData record);

    int updateByPrimaryKey(LocalData record);
    
    List<LocalData> queryData(Map<String, Object> map);
    
    long getCount(Map<String, Object> map);
}