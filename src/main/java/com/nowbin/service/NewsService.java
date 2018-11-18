package com.nowbin.service;

import java.util.List;

import com.nowbin.bean.News;
import com.nowbin.bean.NewsWithBLOBs;
import com.nowbin.util.Page;

public interface NewsService {
	
	int deleteByPrimaryKey(Integer newsid);

    int insert(NewsWithBLOBs record);

    int insertSelective(NewsWithBLOBs record);

    NewsWithBLOBs selectByPrimaryKey(Integer newsid);

    int updateByPrimaryKeySelective(NewsWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(NewsWithBLOBs record);

    int updateByPrimaryKey(News record);

	int getCount();
	
	int getCountChecked();

	List<News> queryByPage(Page page);
	
	List<News> queryCheckedByPage(Page page);

}
