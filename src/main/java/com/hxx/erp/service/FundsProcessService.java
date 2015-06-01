package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.FundsProcess;

public interface FundsProcessService extends BaseService<FundsProcess>{
	public List<FundsProcess> queryListByPage(Map<String,Object> params) throws Exception;

}
