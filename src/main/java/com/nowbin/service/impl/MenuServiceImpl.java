package com.nowbin.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.Menu;
import com.nowbin.dao.MenuMapper;
import com.nowbin.service.MenuService;

/**
 * @author aeolus
 *
 */
@Service("MenuService")
public class MenuServiceImpl implements MenuService{
	
	@Resource
	private MenuMapper dao;

	@Override
	public int deleteByPrimaryKey(Integer menuid) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(menuid);
	}

	@Override
	public int insert(Menu record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(Menu record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public Menu selectByPrimaryKey(Integer menuid) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(menuid);
	}

	@Override
	public int updateByPrimaryKeySelective(Menu record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKeyWithBLOBs(Menu record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeyWithBLOBs(record);
	}

	@Override
	public int updateByPrimaryKey(Menu record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

}
