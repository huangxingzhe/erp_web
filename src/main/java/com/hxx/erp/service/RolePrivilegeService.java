package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.RolePrivilege;

public interface RolePrivilegeService extends BaseService<RolePrivilege>{
	/**
	 * 删除角色权限
	 */
	public void deleteRolePrivilegeId(Map<String,Object> params);
	
	 /**
	  * 给角色分配权限
	  */
	 public void addBatch(List<RolePrivilege> list);
	 

}
