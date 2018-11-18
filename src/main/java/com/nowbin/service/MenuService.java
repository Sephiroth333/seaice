package com.nowbin.service;

import com.nowbin.bean.Menu;

public interface MenuService {

	int deleteByPrimaryKey(Integer menuid);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer menuid);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKeyWithBLOBs(Menu record);

    int updateByPrimaryKey(Menu record);
}
