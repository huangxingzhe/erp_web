package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.EmpCutSettingDao;
import com.hxx.erp.model.EmpCutSetting;
import com.hxx.erp.service.EmpCutSettingService;

@Service
public class EmpCutSettingServiceImpl implements EmpCutSettingService{
	@Autowired
	private EmpCutSettingDao dao;

	@Override
	public int add(EmpCutSetting entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(EmpCutSetting entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public EmpCutSetting get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public EmpCutSetting query(EmpCutSetting entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<EmpCutSetting> list() throws Exception {
		return null;
	}

	@Override
	public List<EmpCutSetting> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<EmpCutSetting> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}
	
	

}
