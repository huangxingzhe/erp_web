package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.ProviderDao;
import com.hxx.erp.model.Provider;
import com.hxx.erp.service.ProviderService;
@Service
@Transactional
public class ProviderServiceImpl implements ProviderService{

	@Autowired
	private ProviderDao dao;
	
	@Override
	public int add(Provider entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Provider entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Provider get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Provider query(Provider entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<Provider> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<Provider> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<Provider> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}

	
}
