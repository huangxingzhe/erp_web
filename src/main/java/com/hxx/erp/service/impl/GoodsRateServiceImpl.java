package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.GoodsRateDao;
import com.hxx.erp.model.GoodsRate;
import com.hxx.erp.service.GoodsRateService;

@Service
public class GoodsRateServiceImpl implements GoodsRateService{
	@Autowired
	private GoodsRateDao dao;

	@Override
	public int add(GoodsRate entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(GoodsRate entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public GoodsRate get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public GoodsRate query(GoodsRate entity) throws Exception {
		return null;
	}

	@Override
	public List<GoodsRate> list() throws Exception {
		return null;
	}

	@Override
	public List<GoodsRate> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<GoodsRate> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}
	

}
