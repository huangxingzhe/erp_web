package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.OrderTimeDao;
import com.hxx.erp.model.OrderTime;
import com.hxx.erp.service.OrderTimeService;

@Service
@Transactional
public class OrderTimeServiceImpl implements OrderTimeService{

	@Autowired
	private OrderTimeDao dao;
	
	@Override
	public int add(OrderTime entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(OrderTime entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public OrderTime get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public OrderTime query(OrderTime entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<OrderTime> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<OrderTime> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<OrderTime> getByOrderId(int id) throws Exception {
		return dao.getByOrderId(id);
	}
	
	
	

}
