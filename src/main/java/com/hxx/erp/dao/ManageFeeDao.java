package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.ManageFee;

public interface ManageFeeDao extends BaseDao<ManageFee>{
	public List<ManageFee> queryListByPage(Map<String,Object> params) throws Exception;
	
	public Map<String,Object> queryStat(Map<String,Object> params) throws Exception;

}
