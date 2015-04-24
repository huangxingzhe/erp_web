package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.FundsDao;
import com.hxx.erp.model.Funds;
import com.hxx.erp.service.FundsService;

@Service
@Transactional
public class FundsServiceImpl implements FundsService{

	@Autowired
	private FundsDao dao;
	
	@Override
	public int add(Funds entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Funds entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Funds get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Funds query(Funds entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<Funds> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<Funds> queryList(Map<String, Object> params) throws Exception {
		return dao.queryList(params);
	}
	
	

}
