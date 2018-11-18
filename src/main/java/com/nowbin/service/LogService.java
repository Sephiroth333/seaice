/**
 * 
 */
package com.nowbin.service;

import java.util.List;
import com.nowbin.bean.Log;
import com.nowbin.util.Page;

/**
 * @author aeolus
 *
 */
public interface LogService {
	
    Log selectByPrimaryKey(Integer logid);
    
    long getCount(int minType);
    
    List<Log> queryData(int minType, Page page);

}
