package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Customer;
import com.hxx.erp.model.EmployeeProject;

public interface EmployeeProjectDao extends BaseDao<EmployeeProject> {
	public List<EmployeeProject> queryListByPage(Map<String,Object> params) throws Exception;

}
