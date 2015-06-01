package com.hxx.erp.service;

import java.util.List;
import java.util.Map;


public interface BaseService<T> {

	public int add(T entity) throws Exception;
	
	public int update(T entity) throws Exception;
	
	public int delete(int id) throws Exception;
	
	public T get(int id) throws Exception;
	
	public T query(T entity) throws Exception;
	
	public List<T> list()throws Exception;
	
	public List<T> queryList(Map<String,Object> params) throws Exception;
	
	
}
