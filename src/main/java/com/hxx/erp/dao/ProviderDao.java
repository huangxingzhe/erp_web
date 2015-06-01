package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Provider;

public interface ProviderDao extends BaseDao<Provider>{
	public List<Provider> queryListByPage(Map<String,Object> params) throws Exception;

}
