package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.Log;

public interface LogMapper {
    int deleteByPrimaryKey(Integer logid);

    int insert(Log record);

    int insertSelective(Log record);

    Log selectByPrimaryKey(Integer logid);

    int updateByPrimaryKeySelective(Log record);

    int updateByPrimaryKeyWithBLOBs(Log record);

    int updateByPrimaryKey(Log record);
    
    long getCount(Map<String, Object> map);
    
    List<Log> queryData(Map<String, Object> map);
}