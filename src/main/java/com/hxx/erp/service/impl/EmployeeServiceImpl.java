package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.EmployeeDao;
import com.hxx.erp.model.Employee;
import com.hxx.erp.service.EmployeeService;

@Service
public class EmployeeServiceImpl implements EmployeeService{

	@Autowired
	private EmployeeDao dao;
	
	@Override
	public int add(Employee entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Employee entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Employee get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Employee query(Employee entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<Employee> list() throws Exception {
		return null;
	}

	@Override
	public List<Employee> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<Employee> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}
	
	

}
