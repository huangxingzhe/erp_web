package com.hxx.erp.service;

import java.util.List;

import com.hxx.erp.model.OrderTime;

public interface OrderTimeService extends BaseService<OrderTime>{
	
	public List<OrderTime> getByOrderId(int id) throws Exception;
	

}
