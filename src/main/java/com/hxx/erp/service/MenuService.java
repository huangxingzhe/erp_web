package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Menu;

public interface MenuService extends BaseService<Menu>{
	
	public List<Menu> queryList(Map<String,Object> params) throws Exception;
	public List<Menu> queryMenuByRole(Map<String,Object> params) throws Exception;
	public List<Menu> queryMenuByUser(Map<String,Object> params) throws Exception;
	public int updatePosition(int menuId,int position) throws Exception;
	

}
