package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.GoodsRate;

public interface GoodsRateService extends BaseService<GoodsRate>{
	public List<GoodsRate> queryListByPage(Map<String,Object> params) throws Exception;

}
