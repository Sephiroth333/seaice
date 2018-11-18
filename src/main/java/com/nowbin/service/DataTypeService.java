/**
 * 
 */
package com.nowbin.service;

import java.util.List;

import com.nowbin.bean.DataType;

/**
 * @author aeolus
 *
 */
public interface DataTypeService {
	
	int deleteByPrimaryKey(Integer dtid);

    int insert(DataType record);

    int insertSelective(DataType record);

    DataType selectByPrimaryKey(Integer dtid);

    int updateByPrimaryKeySelective(DataType record);

    int updateByPrimaryKey(DataType record);
    
    List<DataType> queryAll();

}
