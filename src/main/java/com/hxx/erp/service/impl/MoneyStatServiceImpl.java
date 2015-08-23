package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.MoneyStatDao;
import com.hxx.erp.model.MoneyStat;
import com.hxx.erp.service.MoneyStatService;

@Service
public class MoneyStatServiceImpl implements MoneyStatService{
	@Autowired
	private MoneyStatDao dao;

	@Override
	public int add(MoneyStat entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(MoneyStat entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public MoneyStat get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public MoneyStat query(MoneyStat entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<MoneyStat> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<MoneyStat> queryList(Map<String, Object> params)
			throws Exception {
		return null;
	}

	@Override
	public List<MoneyStat> queryListByPage(Map<String, Object> params) {
		return dao.queryListByPage(params);
	}

	@Override
	public List<MoneyStat> queryAllForStat(Map<String, Object> params) {
		return dao.queryAllForStat(params);
	}
	
	
	
	
}
