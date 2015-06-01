package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.FundsProcess;

public interface FundsProcessDao extends BaseDao<FundsProcess>{
	public List<FundsProcess> queryListByPage(Map<String,Object> params) throws Exception;
}
