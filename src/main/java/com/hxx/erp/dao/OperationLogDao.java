package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.OperationLog;

public interface OperationLogDao extends BaseDao<OperationLog> {
	public List<OperationLog> queryListByPage(Map<String,Object> params) throws Exception;

}
