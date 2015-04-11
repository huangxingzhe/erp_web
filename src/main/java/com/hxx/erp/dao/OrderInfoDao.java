package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.OrderInfo;

public interface OrderInfoDao extends BaseDao<OrderInfo>{
	
	public Map<String,Object> queryCount();
	
	public Map<String,Object> queryCountAndAmount();
	
	public List<OrderInfo> queryListByPage(Map<String,Object> params) throws Exception;
	
	public int updateType(int id,int type) throws Exception;
	
	public Map<String,Object> totalStat(Map<String,Object> params) throws Exception;

}
