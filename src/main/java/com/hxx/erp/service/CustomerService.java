package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Customer;

public interface CustomerService extends BaseService<Customer>{
	public List<Customer> queryListByPage(Map<String,Object> params) throws Exception;

}
