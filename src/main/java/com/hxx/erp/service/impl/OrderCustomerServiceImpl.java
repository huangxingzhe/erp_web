package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.OrderCustomerDao;
import com.hxx.erp.model.OrderCustomer;
import com.hxx.erp.service.OrderCustomerService;

@Service
@Transactional
public class OrderCustomerServiceImpl implements OrderCustomerService{

	@Autowired
	private OrderCustomerDao dao;

	@Override
	public int add(OrderCustomer entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(OrderCustomer entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public OrderCustomer get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public OrderCustomer query(OrderCustomer entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<OrderCustomer> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<OrderCustomer> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}
	
	
	
}
