package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.OrderInfo;

public interface OrderInfoService extends BaseService<OrderInfo>{
	
	public Map<String,Object> queryCount();
	
	public Map<String,Object> queryCountAndAmount();
	
	public Map<String,Object> countAllNumAndAmount();
	
	public List<OrderInfo> queryListByPage(Map<String,Object> params) throws Exception;
	
	public int updateType(int id,int type) throws Exception;
	
	public Map<String,Object> totalStat(Map<String,Object> params) throws Exception;

	public String getMaxPayNo(Map<String,Object> params) throws Exception;
	
	public Map<String,Object> moneyStat(Map<String,Object> params) throws Exception;
	
	public List<OrderInfo> queryStatByPage(Map<String,Object> params) throws Exception;
}
