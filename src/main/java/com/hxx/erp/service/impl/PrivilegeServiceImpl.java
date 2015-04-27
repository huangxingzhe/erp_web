package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.PrivilegeDao;
import com.hxx.erp.model.Privilege;
import com.hxx.erp.service.PrivilegeService;


@Service(value="privilegeService")
@Transactional
public class PrivilegeServiceImpl implements PrivilegeService{
	@Autowired
	private PrivilegeDao dao;

	@Override
	public int add(Privilege entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Privilege entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Privilege get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Privilege query(Privilege entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<Privilege> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<Privilege> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	
	@Override
	public List<Privilege> pcPrivilegeMenuId(Integer menuId) {
		return dao.pcPrivilegeMenuId(menuId);
	}

	@Override
	public List<Privilege> findPrivilege(Map<String, Object> params) {
		return dao.findPrivilege(params);
	}

	@Override
	public void deleteMenuId(int menuId) {
		dao.delete(menuId);
	}

	@Override
	public List<Privilege> findMenuPrivilegeMenuId(Integer menuId) {
		return dao.findMenuPrivilegeMenuId(menuId);
	}

	@Override
	public List<Privilege> queryList() throws Exception {
		return dao.queryList();
	}
	

	
	
	
}