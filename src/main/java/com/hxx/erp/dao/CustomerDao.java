package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Customer;

public interface CustomerDao extends BaseDao<Customer> {
	public List<Customer> queryListByPage(Map<String,Object> params) throws Exception;

}
