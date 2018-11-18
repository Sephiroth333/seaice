package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.DataType;

public interface DataTypeMapper {
    int deleteByPrimaryKey(Integer dtid);

    int insert(DataType record);

    int insertSelective(DataType record);

    DataType selectByPrimaryKey(Integer dtid);

    int updateByPrimaryKeySelective(DataType record);

    int updateByPrimaryKey(DataType record);
    
    List<DataType> queryData(Map<String, Object> map);
    
    long getCount(Map<String, Object> map);
}