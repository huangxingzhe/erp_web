package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.RolePrivilege;


public interface RolePrivilegeDao extends BaseDao<RolePrivilege>{
	/**
	 * 删除角色权限
	 * @time 2014-7-28
	 * @author 
	 */
	public void deleteRolePrivilegeId(Map<String,Object> params);
	
	 /**
	  * 给角色分配权限
	  * @time 2014-7-29
	  * @author 
	  */
	 public void insterrolePrivilege(List<RolePrivilege> list);
	 
	 /**
	  * 查询角色权限表的角色id 
	  * @time 2014-8-4
	  * @author 
	  */
	 public List<RolePrivilege> findMenuRole(int menuId);
	 
	 /**
	  * 查询角色拥有的权限
	  * @time 2014-8-4
	  * @author 
	  */
	 public List<RolePrivilege> cxrolePrivilege (String roleId);
}
