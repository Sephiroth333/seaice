package com.nowbin.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.LocalData;
import com.nowbin.dao.LocalDataMapper;
import com.nowbin.service.LocalDataService;
import com.nowbin.util.Page;

/**
 * @author aeolus
 *
 */
@Service("LocalDataService")
public class LocalDataServiceImpl implements LocalDataService{
	
	@Resource
	LocalDataMapper dao;

	@Override
	public int deleteByPrimaryKey(Integer localdataid) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(localdataid);
	}

	@Override
	public int insert(LocalData record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(LocalData record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public LocalData selectByPrimaryKey(Integer localdataid) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(localdataid);
	}

	@Override
	public int updateByPrimaryKeySelective(LocalData record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(LocalData record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}
	

	@Override
	public long getCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<LocalData> queryDataByPage(Integer dtid2, Page page) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("page", page);
		map.put("dtid2", dtid2);
		//map.put("ischecked", 1);
		return dao.queryData(map);
	}

	@Override
	public LocalData queryDataNext(Integer dtid2, Date datacreatetime0) {
		// TODO Auto-generated method stub
		LocalData data=null;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dtid2", dtid2);
		map.put("bdate", datacreatetime0);
		map.put("ischecked", 1);
		List<LocalData> datalist=dao.queryData(map);
		if(datalist!=null && !datalist.isEmpty()){
			data=datalist.get(0);
		}
		return data;
	}

	@Override
	public LocalData queryDataBefore(Integer dtid2, Date datacreatetime0) {
		// TODO Auto-generated method stub
		LocalData data=null;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dtid2", dtid2);
		map.put("ndate", datacreatetime0);
		map.put("ischecked", 1);
		List<LocalData> datalist=dao.queryData(map);
		if(datalist!=null && !datalist.isEmpty()){
			data=datalist.get(0);
		}
		return data;
	}

	@Override
	public List<LocalData> queryDataByDT2(Integer dtid2) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dtid2", dtid2);
		map.put("ischecked", 1);
		return dao.queryData(map);
	}

	@Override
	public LocalData queryDataFirst(Integer dtid2) {
		// TODO Auto-generated method stub
		LocalData data=null;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dtid2", dtid2);
		map.put("first", "first");
		map.put("ischecked", 1);
		List<LocalData> datalist=dao.queryData(map);
		if(datalist!=null && !datalist.isEmpty()){
			data=datalist.get(0);
		}
		return data;
	}

	@Override
	public LocalData queryDataLast(Integer dtid2) {
		// TODO Auto-generated method stub
		LocalData data=null;
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dtid2", dtid2);
		map.put("last", "last");
		map.put("ischecked", 1);
		List<LocalData> datalist=dao.queryData(map);
		if(datalist!=null && !datalist.isEmpty()){
			data=datalist.get(0);
		}
		return data;
	}

	@Override
	public long getCountByDT2(int dtid2) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dtid2", dtid2);
		//map.put("ischecked", 1);
		return dao.getCount(map);
	}

	@Override
	public List<LocalData> queryDataByDateRegion(Integer dtid2, Date timeStart, Date timeEnd) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		Calendar cal = Calendar.getInstance();
		cal.setTime(timeStart);
		cal.add(Calendar.DAY_OF_YEAR, -1);
		timeStart=cal.getTime();
		cal.setTime(timeEnd);
		cal.add(Calendar.DAY_OF_YEAR, 1);
		timeEnd=cal.getTime();
		
		map.put("dtid2", dtid2);
		map.put("bdate", timeStart);	//> 减去一天变成>=
		map.put("ndate", timeEnd);		//< 加上一天变成<=
		map.put("ischecked", 1);	
		return dao.queryData(map);
	}

	@Override
	public List<LocalData> queryDataByPageChecked(Integer dtid2, Page page) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("page", page);
		map.put("dtid2", dtid2);
		map.put("ischecked", 1);
		return dao.queryData(map);
	}

	@Override
	public long getCountByDT2Checked(int dtid2) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("dtid2", dtid2);
		map.put("ischecked", 1);
		return dao.getCount(map);
	}

}
