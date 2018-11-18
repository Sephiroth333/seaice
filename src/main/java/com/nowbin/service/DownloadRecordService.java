/**
 * 
 */
package com.nowbin.service;

import java.util.List;

import com.nowbin.bean.DownloadCountry;
import com.nowbin.bean.DownloadRecord;

/**
 * @author aeolus
 *
 */
public interface DownloadRecordService {
	
	int deleteByPrimaryKey(Integer id);
	
	int insert(DownloadRecord record);

    int insertSelective(DownloadRecord record);

    DownloadRecord selectByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(DownloadRecord record);

    int updateByPrimaryKey(DownloadRecord record);
    
    int[] getDownloadCountByYear(int year);
    
    List<DownloadCountry> getDownloadCountByCountry();
    
}
