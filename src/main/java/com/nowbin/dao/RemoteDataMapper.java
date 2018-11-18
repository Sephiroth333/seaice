package com.nowbin.dao;

import com.nowbin.bean.RemoteData;

public interface RemoteDataMapper {
    int deleteByPrimaryKey(Integer remoteid);

    int insert(RemoteData record);

    int insertSelective(RemoteData record);

    RemoteData selectByPrimaryKey(Integer remoteid);

    int updateByPrimaryKeySelective(RemoteData record);

    int updateByPrimaryKey(RemoteData record);
}