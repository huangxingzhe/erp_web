package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Role;
import com.hxx.erp.model.RoleMenu;
import com.hxx.erp.model.UserRole;

public interface RoleService extends BaseService<Role>{
	
	public List<Role> queryListByPage(Map<String,Object> params) throws Exception;
	
	public List<Role> queryList(Map<String,Object> params) throws Exception;
	
	public int addRoleMenu(List<RoleMenu> rm) throws Exception;
	
	public List<RoleMenu> queryRoleMenu(int roleId) throws Exception;
	
	public int deleteRoleMenu(int roleId) throws Exception;
	
	public List<Role> queryAll(Map<String,Object> params) throws Exception;
	
	public int addUserRole(List<UserRole> ur) throws Exception;
	
	public int deleteUserRole(int userId) throws Exception;
}
