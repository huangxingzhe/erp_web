package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.OrderInfoDao;
import com.hxx.erp.model.OrderInfo;
import com.hxx.erp.service.OrderInfoService;

@Service
@Transactional
public class OrderInfoServiceImpl implements OrderInfoService{

	@Autowired
	private OrderInfoDao dao;
	
	@Override
	public int add(OrderInfo entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(OrderInfo entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public OrderInfo get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public OrderInfo query(OrderInfo entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<OrderInfo> list() throws Exception {
		return dao.list();
	}

	@Override
	public Map<String, Object> queryCount() {
		return dao.queryCount();
	}

	@Override
	public List<OrderInfo> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<OrderInfo> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}

	@Override
	public int updateType(int id,int type) throws Exception {
		return dao.updateType(id,type);
	}

	@Override
	public Map<String, Object> queryCountAndAmount() {
		return dao.queryCountAndAmount();
	}

	@Override
	public Map<String, Object> totalStat(Map<String,Object> params) throws Exception {
		return dao.totalStat(params);
	}

	@Override
	public String getMaxPayNo(Map<String,Object> params) throws Exception {
		return dao.getMaxPayNo(params);
	}

	@Override
	public Map<String, Object> countAllNumAndAmount() {
		return dao.countAllNumAndAmount();
	}

	@Override
	public Map<String, Object> moneyStat(Map<String, Object> params)
			throws Exception {
		return dao.moneyStat(params);
	}

	@Override
	public List<OrderInfo> queryStatByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryStatByPage(params);
	}
	

	
	
}
