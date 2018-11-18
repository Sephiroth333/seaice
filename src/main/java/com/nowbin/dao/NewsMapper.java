package com.nowbin.dao;

import java.util.List;
import java.util.Map;

import com.nowbin.bean.News;
import com.nowbin.bean.NewsWithBLOBs;

public interface NewsMapper {
    int deleteByPrimaryKey(Integer newsid);

    int insert(NewsWithBLOBs record);

    int insertSelective(NewsWithBLOBs record);

    NewsWithBLOBs selectByPrimaryKey(Integer newsid);

    int updateByPrimaryKeySelective(NewsWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(NewsWithBLOBs record);

    int updateByPrimaryKey(News record);
    
    long getCount(Map<String, Object> map);

	List<News> queryData(Map<String, Object> map);
}