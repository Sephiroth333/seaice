package com.nowbin.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.UserDownload;
import com.nowbin.bean.UserDownloadView;
import com.nowbin.dao.UserDownloadMapper;
import com.nowbin.service.UserDownloadService;
import com.nowbin.util.Page;

/**
 * @author aeolus
 *
 */
@Service("UserDownloadService")
public class UserDownloadServiceImpl implements UserDownloadService{
	
	@Resource
	private UserDownloadMapper dao;

	@Override
	public int deleteByPrimaryKey(Integer udid) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(udid);
	}

	@Override
	public int insert(UserDownload record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(UserDownload record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public UserDownload selectByPrimaryKey(Integer udid) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(udid);
	}

	@Override
	public int updateByPrimaryKeySelective(UserDownload record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKeyWithBLOBs(UserDownload record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeyWithBLOBs(record);
	}

	@Override
	public int updateByPrimaryKey(UserDownload record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public long getCountByUser(int userid) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("userid", userid);
		return dao.getCount(map);
	}

	@Override
	public List<UserDownload> queryDataByUser(int userid, Page page) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("userid", userid);
		map.put("page", page);
		return dao.queryData(map);
	}

	@Override
	public long getCount() {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		return dao.getCount(map);
	}

	@Override
	public List<UserDownload> queryDataByPage(Page page) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("page", page);
		return dao.queryData(map);
	}

	@Override
	public List<UserDownloadView> queryDataViewByPage(Page page) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("page", page);
		return dao.queryDataView(map);
	}

	@Override
	public List<UserDownload> queryDataByExpiredDate(Date expiredate) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("expiredate", expiredate);
		map.put("zipstatus", true);
		return dao.queryData(map);
	}

}
