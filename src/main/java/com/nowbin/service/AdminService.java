package com.nowbin.service;

import java.util.List;
import com.nowbin.bean.Admin;
import com.nowbin.util.Page;

public interface AdminService {
	
	int deleteByPrimaryKey(Integer adminId);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer adminId);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKeyWithBLOBs(Admin record);

    int updateByPrimaryKey(Admin record);
    
    List<Admin> queryAllByPage(Page page);
    
    Admin userLogin(Admin user);

	Admin userLoginbyEmail(Admin user);
	
	Admin checkName(String loginname);
	
	Admin checkEmail(String loginemail);
	
	Boolean checkTwo(Admin record);
	
	long getCount();

}
