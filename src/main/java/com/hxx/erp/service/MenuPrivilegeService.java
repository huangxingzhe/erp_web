package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.MenuPrivilege;

public interface MenuPrivilegeService extends BaseService<MenuPrivilege>{
	/**
	 * 给菜单分配权限
	 * 
	 */
	public void addBatch(List<MenuPrivilege> list);
	 
	/**
	 * 查询菜单权限
	 * 
	 */
	public List<MenuPrivilege> queryList(Map<String,Object> params);
	
	/**
	 * 删除菜单权限
	 */
	public void delete(Map<String,Object> params);
	
	
	public List<MenuPrivilege> getMenuPrivilegeByRole(String roleId);

}
