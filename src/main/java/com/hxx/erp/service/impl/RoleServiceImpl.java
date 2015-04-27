package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.RoleDao;
import com.hxx.erp.model.Role;
import com.hxx.erp.model.RoleMenu;
import com.hxx.erp.model.UserRole;
import com.hxx.erp.service.RoleService;

@Service
@Transactional  
public class RoleServiceImpl implements RoleService{
	
	@Autowired
	private RoleDao dao;

	@Override
	public int add(Role entity) throws Exception {
		return dao.add(entity);
	}  

	@Override
	public int update(Role entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Role get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Role query(Role entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<Role> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<Role> queryListByPage(Map<String, Object> params)
			throws Exception {
		return dao.queryListByPage(params);
	}

	@Override
	public List<Role> queryList(Map<String, Object> params) throws Exception {
		return dao.queryList(params);
	}

	@Override
	public int addRoleMenu(List<RoleMenu> rm) throws Exception {
		return dao.addRoleMenu(rm);
	}

	@Override
	public List<RoleMenu> queryRoleMenu(int roleId) throws Exception {
		return dao.queryRoleMenu(roleId);
	}

	@Override
	public int deleteRoleMenu(int roleId) throws Exception {
		return dao.deleteRoleMenu(roleId);
	}

	@Override
	public List<Role> queryAll(Map<String,Object> params) throws Exception {
		return dao.queryAll(params);
	}

	@Override
	public int addUserRole(List<UserRole> ur) throws Exception {
		return dao.addUserRole(ur);
	}

	@Override
	public int deleteUserRole(int userId) throws Exception {
		return dao.deleteUserRole(userId);
	}
	

}
