package com.nowbin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.User;
import com.nowbin.dao.UserMapper;
import com.nowbin.service.UserService;
import com.nowbin.util.Page;

/**
 * @author aeolus
 *
 */
@Service("UserService")
public class UserServiceImpl implements UserService{
	
	@Resource
	private UserMapper dao;
	
	@Override
	public int deleteByPrimaryKey(Integer adminId) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(adminId);
	}

	@Override
	public int insert(User record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(User record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public User selectByPrimaryKey(Integer adminId) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(adminId);
	}

	@Override
	public int updateByPrimaryKeySelective(User record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(User record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public List<User> queryAllByPage(Page page) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("page", page);
		return dao.queryData(map);
	}

	@Override
	public User userLogin(User user) {
		// TODO Auto-generated method stub
		return this.dao.userLogin(user);
	}

	@Override
	public User userLoginbyEmail(User user) {
		// TODO Auto-generated method stub
		return this.dao.userLoginbyEmail(user);
	}

	@Override
	public User checkName(String loginname) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("loginname", loginname);
		return this.dao.checkName(map);
	}

	@Override
	public User checkEmail(String loginemail) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("loginemail", loginemail);
		return this.dao.checkName(map);
	}

	@Override
	public Boolean checkTwo(User record) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		User user1=null;
		if(record.getUserid() != null){
			map.put("userid", record.getUserid());
		}
		if(record.getLoginname() != null){
			map.put("loginname", record.getLoginname());
			user1=this.dao.checkName(map);
		}
		if(user1==null){
			map.clear();
			if(record.getUserid() != null){
				map.put("userid", record.getUserid());
			}
			if(record.getLoginemail() != null){
				map.put("loginemail", record.getLoginemail());
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
