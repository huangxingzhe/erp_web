package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.OfferDao;
import com.hxx.erp.model.Offer;
import com.hxx.erp.service.OfferService;

@Service
public class OfferServiceImpl implements OfferService{
	@Autowired
	private OfferDao dao;

	@Override
	public int add(Offer entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Offer entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Offer get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Offer query(Offer entity) throws Exception {
		return null;
	}

	@Override
	public List<Offer> list() throws Exception {
		return null;
	}

	@Override
	public List<Offer> queryList(Map<String, Object> params) throws Exception {
		return dao.queryList(params);
	}
	

}
