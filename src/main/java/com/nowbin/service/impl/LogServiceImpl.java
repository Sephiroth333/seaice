package com.nowbin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.Log;
import com.nowbin.dao.LogMapper;
import com.nowbin.service.LogService;
import com.nowbin.util.Page;

@Service("LogService")
public class LogServiceImpl implements LogService {

	@Resource
	private LogMapper dao;	

	@Override
	public Log selectByPrimaryKey(Integer logid) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(logid);
	}

	@Override
	public long getCount(int minType) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("mintype", minType);
		return dao.getCount(map);
	}

	@Override
	public List<Log> queryData(int minType,Page page) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("mintype", minType);
		map.put("page", page);
		return dao.queryData(map);
	}

}
