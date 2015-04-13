package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.OperationLog;

public interface OperationLogService extends BaseService<OperationLog> {
	
	public List<OperationLog> queryListByPage(Map<String,Object> params) throws Exception;

}
