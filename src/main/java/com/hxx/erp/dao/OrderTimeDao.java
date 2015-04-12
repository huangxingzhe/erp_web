package com.hxx.erp.dao;

import java.util.List;

import com.hxx.erp.model.OrderTime;

public interface OrderTimeDao extends BaseDao<OrderTime> {
	
	public List<OrderTime> getByOrderId(int id) throws Exception;

}
