/**
 * 
 */
package com.nowbin.service;

import java.util.List;

import com.nowbin.bean.Country;

/**
 * @author aeolus
 *
 */
public interface CountryService {
	
	int deleteByPrimaryKey(Integer id);

    int insert(Country record);

    int insertSelective(Country record);

    Country selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Country record);

    int updateByPrimaryKey(Country record);
    
    List<Country> queryData();
    
    int getCountryIDbyCode2(String code2);

}
