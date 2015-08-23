package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.GoodsGuiMapper;
import com.hxx.erp.model.GoodsGui;
import com.hxx.erp.service.GoodsGuiService;
@Service
public class GoodsGuiServiceImpl implements GoodsGuiService{
	@Autowired
	private GoodsGuiMapper dao;

	@Override
	public int add(GoodsGui entity) throws Exception {
		return dao.insert(entity);
	}

	@Override
	public int update(GoodsGui entity) throws Exception {
		return dao.updateByPrimaryKeySelective(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.deleteByPrimaryKey(id);
	}

	@Override
	public GoodsGui get(int id) throws Exception {
		return dao.selectByPrimaryKey(id);
	}

	@Override
	public GoodsGui query(GoodsGui entity) throws Exception {
		return null;
	}

	@Override
	public List<GoodsGui> list() throws Exception {
		return null;
	}

	@Override
	public List<GoodsGui> queryList(Map<String, Object> params)
			throws Exception {
		return null;
	}
	
	

}
