package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.FundsProcessDao;
import com.hxx.erp.model.FundsProcess;
import com.hxx.erp.service.FundsProcessService;

@Service
@Transactional
public class FundsProcessServiceImpl implements FundsProcessService{
	@Autowired
	private FundsProcessDao dao;

	@Override
	public int add(FundsProcess entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(FundsProcess entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public FundsProcess get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public FundsProcess query(FundsProcess entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<FundsProcess> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<FundsProcess> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}
	

}
