/**
 * 
 */
package com.nowbin.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.LeftMenu;
import com.nowbin.dao.LeftMenuMapper;
import com.nowbin.service.LeftMenuService;

/**
 * @author aeolus
 *
 */
@Service("LeftMenuService")
public class LeftMenuServiceImpl implements LeftMenuService{

	@Resource
	private LeftMenuMapper dao;
	
	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(LeftMenu record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(LeftMenu record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public LeftMenu selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(LeftMenu record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKey(LeftMenu record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public List<LeftMenu> queryAllByTabID(int tabid) {
		// TODO Auto-generated method stub
		return dao.queryAllByTabID(tabid);
	}

	@Override
	public List<String> queryFatherNameByTabID(int tabid) {
		// TODO Auto-generated method stub
		return dao.queryFatherNameByTabID(tabid);
	}

}
