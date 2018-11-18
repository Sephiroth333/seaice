package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.Admin;

public interface AdminMapper {
    int deleteByPrimaryKey(Integer adminId);

    int insert(Admin record);

    int insertSelective(Admin record);

    Admin selectByPrimaryKey(Integer adminId);

    int updateByPrimaryKeySelective(Admin record);

    int updateByPrimaryKeyWithBLOBs(Admin record);

    int updateByPrimaryKey(Admin record);
    
    long getCount(Map<String, Object> map);

	List<Admin> queryData(Map<String, Object> map);
    
    Admin userLogin(Admin user);

	Admin checkName(Map<String, Object> map);

	Admin userLoginbyEmail(Admin user);
}