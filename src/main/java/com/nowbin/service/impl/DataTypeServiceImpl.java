/**
 * 
 */
package com.nowbin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.DataType;
import com.nowbin.dao.DataTypeMapper;
import com.nowbin.service.DataTypeService;

/**
 * @author aeolus
 *
 */
@Service("DataTypeService")
public class DataTypeServiceImpl implements DataTypeService{

	@Resource
	DataTypeMapper dao;
	
	@Override
	public int deleteByPrimaryKey(Integer dtid) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(dtid);
	}

	@Override
	public int insert(DataType record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(DataType record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public DataType selectByPrimaryKey(Integer dtid) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(dtid);
	}

	@Override
	public int updateByPrimaryKeySelective(DataType record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKey(DataType record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public List<DataType> queryAll() {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		return dao.queryData(map);
	}
	
	

}
