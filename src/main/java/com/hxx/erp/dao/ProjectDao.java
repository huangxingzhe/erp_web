package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Project;

public interface ProjectDao extends BaseDao<Project> {
	public List<Project> queryListByPage(Map<String,Object> params) throws Exception;

}
