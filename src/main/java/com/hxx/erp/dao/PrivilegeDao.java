package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Privilege;


public interface PrivilegeDao extends BaseDao<Privilege>{
	 public List<Privilege> queryList() throws Exception;
	 
	 public List<Privilege> query(Map<String,Object> params);
	 
	 public List<Privilege> queryPrivilegeByRoleIdAndMenuId(Map<String,Object> params);
}
