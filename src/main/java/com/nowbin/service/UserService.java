package com.nowbin.service;

import java.util.List;
import com.nowbin.bean.User;
import com.nowbin.util.Page;

public interface UserService {
	
	int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    List<User> queryAllByPage(Page page);
    
    User userLogin(User user);

	User userLoginbyEmail(User user);
	
	User checkName(String loginname);
	
	User checkEmail(String loginemail);
	
	Boolean checkTwo(User record);
	
	long getCount();

}
