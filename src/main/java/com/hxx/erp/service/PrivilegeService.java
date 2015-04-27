package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.Privilege;


/**
 * 权限借口
 */
public interface PrivilegeService extends BaseService<Privilege> {
	
	 public List<Privilege> queryList() throws Exception;
	 /**
	  * 查询权限
	  * @time 2014-7-26
	  * @author xiongmin
	  */
	 public List<Privilege> findPrivilege(Map<String,Object> params);
	 
	 /**
	  * 根据菜单id删除菜单下的所有权限
	  * @time 2014-7-26
	  * @author xiongmin
	  */
	 public void deleteMenuId(int menuId);
	 
	 /**
	  * 根据菜单id查询所有菜单菜单权限表id
	  * @time 2014-7-26
	  * @author xiongmin
	  */
	 public List<Privilege> findMenuPrivilegeMenuId(Integer menuId);
	 
	 /**
	  * 根据菜单id查询拼凑权限
	  * @time 2014-8-5
	  * @author xiongmin
	  * @return
	  */
	 public List<Privilege> pcPrivilegeMenuId(Integer menuId);
}
