package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.MoneyStat;

public interface MoneyStatService extends BaseService<MoneyStat>{
	public List<MoneyStat> queryListByPage(Map<String, Object> params);
	
	public List<MoneyStat> queryAllForStat(Map<String, Object> params);

}
