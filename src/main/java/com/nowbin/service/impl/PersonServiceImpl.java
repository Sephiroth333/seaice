package com.nowbin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.Person;
import com.nowbin.dao.PersonMapper;
import com.nowbin.service.PersonService;
import com.nowbin.util.Page;

/**
 * @author aeolus
 *
 */
@Service("PersonService")
public class PersonServiceImpl implements PersonService{

	@Resource
	private PersonMapper dao;
	
	@Override
	public int deleteByPrimaryKey(Integer pid) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(pid);
	}

	@Override
	public int insert(Person record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(Person record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public Person selectByPrimaryKey(Integer pid) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(pid);
	}

	@Override
	public int updateByPrimaryKeySelective(Person record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Person record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeyWithBLOBs(record);
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		return (int)dao.getCount(map);
	}
	
	@Override
	public List<Person> queryByPage(Page page) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("page", page);
		return dao.queryData(map);
	}

}
