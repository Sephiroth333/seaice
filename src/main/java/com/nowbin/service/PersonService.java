package com.nowbin.service;

import java.util.List;

import com.nowbin.bean.Person;
import com.nowbin.util.Page;

public interface PersonService {
	
	int deleteByPrimaryKey(Integer newsid);

    int insert(Person record);

    int insertSelective(Person record);

    Person selectByPrimaryKey(Integer newsid);

    int updateByPrimaryKeySelective(Person record);

    int updateByPrimaryKey(Person record);

	int getCount();

	List<Person> queryByPage(Page page);

}
