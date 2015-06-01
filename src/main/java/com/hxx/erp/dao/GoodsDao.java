package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Customer;
import com.hxx.erp.model.Goods;

public interface GoodsDao extends BaseDao<Goods>{
	public List<Goods> queryListByPage(Map<String,Object> params) throws Exception;

}
