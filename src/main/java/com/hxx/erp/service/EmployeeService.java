package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Employee;

public interface EmployeeService extends BaseService<Employee> {
	public List<Employee> queryListByPage(Map<String,Object> params) throws Exception;

}
