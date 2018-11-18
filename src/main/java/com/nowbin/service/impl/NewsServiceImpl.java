package com.nowbin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.News;
import com.nowbin.bean.NewsWithBLOBs;
import com.nowbin.dao.NewsMapper;
import com.nowbin.service.LeftMenuService;
import com.nowbin.service.NewsService;
import com.nowbin.service.UserService;
import com.nowbin.util.Page;

/**
 * @author aeolus
 *
 */
@Service("NewsService")
public class NewsServiceImpl implements NewsService{

	@Resource
	private NewsMapper dao;
	
	@Override
	public int deleteByPrimaryKey(Integer newsid) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(newsid);
	}

	@Override
	public int insert(NewsWithBLOBs record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public int insertSelective(NewsWithBLOBs record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public NewsWithBLOBs selectByPrimaryKey(Integer newsid) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(newsid);
	}

	@Override
	public int updateByPrimaryKeySelective(NewsWithBLOBs record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKeyWithBLOBs(NewsWithBLOBs record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeyWithBLOBs(record);
	}

	@Override
	public int updateByPrimaryKey(News record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();		
		return (int)dao.getCount(map);
	}

	@Override
	public int getCountChecked() {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("newsstatus",1);
		return (int)dao.getCount(map);
	}

	@Override
	public List<News> queryByPage(Page page) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("page", page);
		return dao.queryData(map);
	}

	@Override
	public List<News> queryCheckedByPage(Page page) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("page", page);
		map.put("newsstatus", 1);
		return dao.queryData(map);
	}

}
