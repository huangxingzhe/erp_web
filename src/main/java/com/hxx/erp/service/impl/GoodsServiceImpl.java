package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.GoodsDao;
import com.hxx.erp.model.Goods;
import com.hxx.erp.service.GoodsService;

@Service
@Transactional
public class GoodsServiceImpl implements GoodsService{

	@Autowired
	private GoodsDao dao;
	
	@Override
	public int add(Goods entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Goods entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Goods get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Goods query(Goods entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<Goods> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<Goods> queryList(Map<String, Object> params) throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<Goods> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}

	
	
}
