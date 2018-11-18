/**
 * 
 */
package com.nowbin.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nowbin.bean.DownloadCountry;
import com.nowbin.bean.DownloadRecord;
import com.nowbin.bean.DownloadRecordView;
import com.nowbin.dao.DownloadRecordMapper;
import com.nowbin.service.DownloadRecordService;

/**
 * @author aeolus
 *
 */
@Service("DownloadRecordService")
public class DownloadRecordServiceImpl implements DownloadRecordService {
	
	@Resource
	DownloadRecordMapper dao;

	@Override
	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return dao.deleteByPrimaryKey(id);
	}

	@Override
	public int insert(DownloadRecord record) {
		// TODO Auto-generated method stub
		return dao.insert(record);
	}

	@Override
	public int insertSelective(DownloadRecord record) {
		// TODO Auto-generated method stub
		return dao.insertSelective(record);
	}

	@Override
	public DownloadRecord selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return dao.selectByPrimaryKey(id);
	}

	@Override
	public int updateByPrimaryKeySelective(DownloadRecord record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(DownloadRecord record) {
		// TODO Auto-generated method stub
		return dao.updateByPrimaryKey(record);
	}

	@Override
	public int[] getDownloadCountByYear(int year) {
		// TODO Auto-generated method stub
		int[] result=new int[12];
		for(int i=0;i<12;i++){
			Calendar c1 = new GregorianCalendar(year, i, 1);
			Calendar c2=null;
			if(i==11){
				c2 = new GregorianCalendar(year+1, 0, 1);
			}else{
				c2 = new GregorianCalendar(year, i+1, 1);
			}
			Date stime=c1.getTime();
			Date etime=c2.getTime();
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("stime", stime);
			map.put("etime", etime);
			int count=(int)dao.getCount(map);
			result[i]=count;			
		}
		return result;
	}

	@Override
	public List<DownloadCountry> getDownloadCountByCountry() {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		List<DownloadCountry> dclist=dao.queryDownloadCountry(map);
		if(dclist.size()>6){
			//超过6个国家的，6~N合并展示为其它
			DownloadCountry other=new DownloadCountry();
			other.setCountryID(999);
			other.setCountryName("Other");
			int dlCount=0;
			int pos=dclist.size()-1;
			while(pos >=5 ){				
				dlCount+=dclist.get(pos).getDlCount();
				dclist.remove(pos);
				pos--;
			}
			other.setDlCount(dlCount);
			dclist.add(other);
		}
		return dclist;
	}

}
