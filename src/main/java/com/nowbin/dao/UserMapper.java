package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    long getCount(Map<String, Object> map);

	List<User> queryData(Map<String, Object> map);
    
	User userLogin(User user);
	
	User userLoginbyEmail(User user);
	
	User checkName(Map<String, Object> map);
	
}