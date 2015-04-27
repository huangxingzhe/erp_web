package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.UserLoginLogDao;
import com.hxx.erp.model.UserLoginLog;
import com.hxx.erp.service.UserLoginLogService;

@Service
@Transactional
public class UserLoginLogServiceImpl implements UserLoginLogService{

	@Autowired
	private UserLoginLogDao dao;

	@Override
	public int add(UserLoginLog entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(UserLoginLog entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public UserLoginLog get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public UserLoginLog query(UserLoginLog entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<UserLoginLog> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<UserLoginLog> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<UserLoginLog> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}
	
	

}
