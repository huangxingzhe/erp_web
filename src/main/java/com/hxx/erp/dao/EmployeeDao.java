package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Customer;
import com.hxx.erp.model.Employee;

public interface EmployeeDao extends BaseDao<Employee> {
	public List<Employee> queryListByPage(Map<String,Object> params) throws Exception;

}
