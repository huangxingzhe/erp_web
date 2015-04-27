package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Privilege;


/**
 * 权限借口
 */
public interface PrivilegeService extends BaseService<Privilege> {
	
	 public List<Privilege> queryList() throws Exception;
	
	 public List<Privilege> query(Map<String,Object> params);
	 
	 public List<Privilege> queryPrivilegeByRoleIdAndMenuId(Map<String,Object> params);
}
