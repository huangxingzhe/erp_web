package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Menu;

public interface MenuDao extends BaseDao<Menu>{
	
	public List<Menu> queryMenuByRole(Map<String,Object> params) throws Exception;
	public List<Menu> queryMenuByUser(Map<String,Object> params) throws Exception; 
	public int updatePosition(int menuId,int position) throws Exception;

}
