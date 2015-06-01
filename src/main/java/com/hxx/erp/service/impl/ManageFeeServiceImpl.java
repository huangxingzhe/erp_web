package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.ManageFeeDao;
import com.hxx.erp.model.ManageFee;
import com.hxx.erp.service.ManageFeeService;

@Service
public class ManageFeeServiceImpl implements ManageFeeService{
	@Autowired
	private ManageFeeDao dao;

	@Override
	public int add(ManageFee entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(ManageFee entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public ManageFee get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public ManageFee query(ManageFee entity) throws Exception {
		return null;
	}

	@Override
	public List<ManageFee> list() throws Exception {
		return null;
	}

	@Override
	public List<ManageFee> queryList(Map<String, Object> params)
			throws Exception {
		return null;
	}

	@Override
	public List<ManageFee> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}
	

}
