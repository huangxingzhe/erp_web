package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.EmployeeProject;

public interface EmployeeProjectService extends BaseService<EmployeeProject> {
	public List<EmployeeProject> queryListByPage(Map<String,Object> params) throws Exception;

}
