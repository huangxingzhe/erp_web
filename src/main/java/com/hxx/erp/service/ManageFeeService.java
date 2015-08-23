package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.ManageFee;

public interface ManageFeeService extends BaseService<ManageFee>{
	public List<ManageFee> queryListByPage(Map<String,Object> params) throws Exception;
	
	public Map<String,Object> queryStat(Map<String,Object> params) throws Exception;

}
