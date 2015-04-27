package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.RolePrivilegeDao;
import com.hxx.erp.model.RolePrivilege;
import com.hxx.erp.service.RolePrivilegeService;

@Service
@Transactional
public class RolePrivilegeServiceImpl implements RolePrivilegeService{
	@Autowired
	private RolePrivilegeDao dao;

	@Override
	public int add(RolePrivilege entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(RolePrivilege entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public RolePrivilege get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public RolePrivilege query(RolePrivilege entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<RolePrivilege> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<RolePrivilege> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public void deleteRolePrivilegeId(Map<String, Object> params) {
		dao.deleteRolePrivilegeId(params);
	}

	@Override
	public void addBatch(List<RolePrivilege> list) {
		dao.addBatch(list);
	}
	
	
	
	
}
