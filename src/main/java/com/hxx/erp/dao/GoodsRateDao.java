package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.GoodsRate;

public interface GoodsRateDao extends BaseDao<GoodsRate> {
	public List<GoodsRate> queryListByPage(Map<String,Object> params) throws Exception;

}
