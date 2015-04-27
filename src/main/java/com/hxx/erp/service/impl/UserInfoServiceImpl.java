package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.UserInfoDao;
import com.hxx.erp.model.UserInfo;
import com.hxx.erp.service.UserInfoService;

@Service
@Transactional
public class UserInfoServiceImpl implements UserInfoService{
	
	@Autowired
	private UserInfoDao dao;

	
	public int add(UserInfo entity) throws Exception {
		return dao.add(entity);
	}

	
	public int update(UserInfo entity) throws Exception {
		return dao.update(entity);
	}

	
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	
	public UserInfo get(int id) throws Exception {
		return dao.get(id);
	}

	
	public List<UserInfo> list() throws Exception {
		return dao.list();
	}


	public UserInfo query(UserInfo entity) throws Exception {
		return dao.query(entity);
	}


	@Override
	public List<UserInfo> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}


	@Override
	public List<UserInfo> queryList(Map<String, Object> params)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	

}
