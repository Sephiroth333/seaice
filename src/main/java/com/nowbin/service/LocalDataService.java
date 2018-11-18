package com.nowbin.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.nowbin.bean.LocalData;
import com.nowbin.util.Page;

public interface LocalDataService {
	
	int deleteByPrimaryKey(Integer localdataid);

    int insert(LocalData record);

    int insertSelective(LocalData record);

    LocalData selectByPrimaryKey(Integer localdataid);

    int updateByPrimaryKeySelective(LocalData record);

    int updateByPrimaryKey(LocalData record);
    
    List<LocalData> queryDataByDT2(Integer dtid2);
    
    List<LocalData> queryDataByDateRegion(Integer dtid2, Date timeStart, Date timeEnd);
    
    List<LocalData> queryDataByPage(Integer dtid2, Page page);
    
    List<LocalData> queryDataByPageChecked(Integer dtid2, Page page);
    
    LocalData queryDataNext(Integer dtid2, Date datacreatetime0);
    
    LocalData queryDataBefore(Integer dtid2, Date datacreatetime0);
    
    LocalData queryDataFirst(Integer dtid2);
    
    LocalData queryDataLast(Integer dtid2);
    
    long getCount(Map<String, Object> map);
    
    long getCountByDT2(int dtid2);
    
    long getCountByDT2Checked(int dtid2);

}
