package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.CustomerDao;
import com.hxx.erp.model.Customer;
import com.hxx.erp.service.CustomerService;
@Service
@Transactional
public class CustomerServiceImpl implements CustomerService{

	@Autowired	
	private CustomerDao dao;
	
	@Override
	public int add(Customer entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Customer entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Customer get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Customer query(Customer entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<Customer> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<Customer> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<Customer> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}

	
	
}
