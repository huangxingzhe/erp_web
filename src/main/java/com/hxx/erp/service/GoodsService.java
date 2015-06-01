package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Goods;

public interface GoodsService extends BaseService<Goods>{
	public List<Goods> queryListByPage(Map<String,Object> params) throws Exception;

}
