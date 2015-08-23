package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hxx.erp.dao.ProjectDao;
import com.hxx.erp.model.Project;
import com.hxx.erp.service.ProjectService;

@Service
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	private ProjectDao dao;
	
	@Override
	public int add(Project entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Project entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Project get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Project query(Project entity) throws Exception {
		return null;
	}

	@Override
	public List<Project> list() throws Exception {
		return null;
	}

	@Override
	public List<Project> queryList(Map<String, Object> params) throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<Project> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}
	

}
