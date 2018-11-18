/**
 * 
 */
package com.nowbin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.Country;
import com.nowbin.dao.CountryMapper;
import com.nowbin.service.CountryService;

/**
 * @author aeolus
 *
 */

@Service("CountryService")
public class CountryServiceImpl implements CountryService{
	@Resource
	private CountryMapper dao;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(Country record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(Country record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public Country selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(Country record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Country record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public List<Country> queryData() {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		return dao.queryData(map);
	}

	@Override
	public int getCountryIDbyCode2(String code2) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("code2",code2);
		List<Country> clist=dao.queryData(map);
		if(clist.size()>0){
			return clist.get(0).getId();
		}else return 44;	//默认CN		
	}
}
