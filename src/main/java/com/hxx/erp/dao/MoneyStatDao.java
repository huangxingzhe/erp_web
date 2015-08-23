package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.MoneyStat;

public interface MoneyStatDao extends BaseDao<MoneyStat>{
	public List<MoneyStat> queryListByPage(Map<String, Object> params);
	
	public List<MoneyStat> queryAllForStat(Map<String, Object> params);

}
