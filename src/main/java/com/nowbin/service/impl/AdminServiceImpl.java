package com.nowbin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.Admin;
import com.nowbin.dao.AdminMapper;
import com.nowbin.service.AdminService;
import com.nowbin.util.Page;

@Service("AdminService")
public class AdminServiceImpl implements AdminService {

	@Resource
	private AdminMapper dao;
	
	@Override
	public int deleteByPrimaryKey(Integer adminId) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(adminId);
	}

	@Override
	public int insert(Admin record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(Admin record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public Admin selectByPrimaryKey(Integer adminId) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(adminId);
	}

	@Override
	public int updateByPrimaryKeySelective(Admin record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKeyWithBLOBs(Admin record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeyWithBLOBs(record);
	}

	@Override
	public int updateByPrimaryKey(Admin record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public List<Admin> queryAllByPage(Page page) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("page", page);
		return dao.queryData(map);
	}

	@Override
	public Admin userLogin(Admin user) {
		// TODO Auto-generated method stub
		return this.dao.userLogin(user);
	}

	@Override
	public Admin userLoginbyEmail(Admin user) {
		// TODO Auto-generated method stub
		return this.dao.userLoginbyEmail(user);
	}

	@Override
	public Admin checkName(String loginname) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("loginname", loginname);
		return this.dao.checkName(map);
	}

	@Override
	public Admin checkEmail(String loginemail) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("loginemail", loginemail);
		return this.dao.checkName(map);
	}

	@Override
	public Boolean checkTwo(Admin record) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		Admin user1=null;
		if(record.getAdminId() != null){
			map.put("userid", record.getAdminId());
		}
		if(record.getAdminName() != null){
			map.put("loginname", record.getAdminName());
			user1=this.dao.checkName(map);
		}
		if(user1==null){
			map.clear();
			if(record.getAdminId() != null){
				map.put("userid", record.getAdminId());
			}
			if(record.getAdminEmail() != null){
				map.put("loginemail", record.getAdminEmail());
				user1=this.dao.checkName(map);
			}
		}
		if(user1==null) return true;
		return false;
	}

	@Override
	public long getCount() {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		return dao.getCount(map);
	}

}
