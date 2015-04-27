package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.OperationLogDao;
import com.hxx.erp.model.OperationLog;
import com.hxx.erp.service.OperationLogService;

@Service
@Transactional
public class OperationLogServiceImpl implements OperationLogService{

	@Autowired
	private OperationLogDao dao;
	@Override
	public int add(OperationLog entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(OperationLog entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public OperationLog get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public OperationLog query(OperationLog entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<OperationLog> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<OperationLog> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<OperationLog> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}
	

}
