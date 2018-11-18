/**
 * 
 */
package com.nowbin.service;

import java.util.List;

import com.nowbin.bean.LeftMenu;

/**
 * @author aeolus
 *
 */
public interface LeftMenuService {
	
	int deleteByPrimaryKey(Integer id);

    int insert(LeftMenu record);

    int insertSelective(LeftMenu record);

    LeftMenu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(LeftMenu record);

    int updateByPrimaryKey(LeftMenu record);

	List<LeftMenu> queryAllByTabID(int tabid);

	List<String> queryFatherNameByTabID(int tabid);

}
