package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Provider;

public interface ProviderService extends BaseService<Provider>{
	
	public List<Provider> queryListByPage(Map<String,Object> params) throws Exception;

}
