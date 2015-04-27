package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.MenuPrivilegeDao;
import com.hxx.erp.model.MenuPrivilege;
import com.hxx.erp.service.MenuPrivilegeService;

@Service
@Transactional
public class MenuPrivilegeServiceImpl implements MenuPrivilegeService{
	@Autowired
	private MenuPrivilegeDao dao;
	
	@Override
	public int add(MenuPrivilege entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(MenuPrivilege entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public MenuPrivilege get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public MenuPrivilege query(MenuPrivilege entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<MenuPrivilege> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<MenuPrivilege> queryList(Map<String, Object> params){
		return dao.queryList(params);
	}

	@Override
	public void addBatch(List<MenuPrivilege> list) {
		dao.addBatch(list);
	}

	@Override
	public void delete(Map<String, Object> params) {
		dao.delete(params);
	}

	@Override
	public List<MenuPrivilege> getMenuPrivilegeByRole(String roleId) {
		return dao.getMenuPrivilegeByRole(roleId);
	}
	

	
}
