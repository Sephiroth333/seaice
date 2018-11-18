package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.Person;

public interface PersonMapper {
    int deleteByPrimaryKey(Integer pid);

    int insert(Person record);

    int insertSelective(Person record);

    Person selectByPrimaryKey(Integer pid);

    int updateByPrimaryKeySelective(Person record);

    int updateByPrimaryKeyWithBLOBs(Person record);

    int updateByPrimaryKey(Person record);
    
    long getCount(Map<String, Object> map);

	List<Person> queryData(Map<String, Object> map);
}