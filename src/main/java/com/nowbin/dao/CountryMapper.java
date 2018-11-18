package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.Country;

public interface CountryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Country record);

    int insertSelective(Country record);

    Country selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Country record);

    int updateByPrimaryKey(Country record);
    
    List<Country> queryData(Map<String, Object> map);
}