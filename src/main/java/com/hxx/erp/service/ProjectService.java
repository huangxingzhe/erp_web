package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Project;

public interface ProjectService extends BaseService<Project> {
	public List<Project> queryListByPage(Map<String,Object> params) throws Exception;

}
