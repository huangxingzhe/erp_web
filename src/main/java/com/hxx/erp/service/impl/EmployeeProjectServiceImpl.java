package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.EmployeeProjectDao;
import com.hxx.erp.model.EmployeeProject;
import com.hxx.erp.service.EmployeeProjectService;

@Service
public class EmployeeProjectServiceImpl implements EmployeeProjectService{
	@Autowired
	private EmployeeProjectDao dao;

	@Override
	public int add(EmployeeProject entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(EmployeeProject entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public EmployeeProject get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public EmployeeProject query(EmployeeProject entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<EmployeeProject> list() throws Exception {
		return null;
	}

	@Override
	public List<EmployeeProject> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<EmployeeProject> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}
	
	

}
