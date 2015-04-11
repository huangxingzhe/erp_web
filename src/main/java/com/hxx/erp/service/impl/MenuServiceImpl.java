package com.hxx.erp.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hxx.erp.dao.MenuDao;
import com.hxx.erp.model.Menu;
import com.hxx.erp.service.MenuService;
 
@Service
@Transactional
public class MenuServiceImpl implements MenuService{
	
	@Autowired
	private MenuDao dao;

	@Override
	public int add(Menu entity) throws Exception {
		return dao.add(entity);
	}

	@Override
	public int update(Menu entity) throws Exception {
		return dao.update(entity);
	}

	@Override
	public int delete(int id) throws Exception {
		return dao.delete(id);
	}

	@Override
	public Menu get(int id) throws Exception {
		return dao.get(id);
	}

	@Override
	public Menu query(Menu entity) throws Exception {
		return dao.query(entity);
	}

	@Override
	public List<Menu> list() throws Exception {
		return dao.list();
	}

	@Override
	public List<Menu> queryList(Map<String, Object> params)
			throws Exception {
		return dao.queryList(params);
	}

	@Override
	public List<Menu> queryMenuByRole(Map<String, Object> params)
			throws Exception {
		return dao.queryMenuByRole(params);
	}

	@Override
	public List<Menu> queryMenuByUser(Map<String, Object> params)
			throws Exception {
		return dao.queryMenuByUser(params);
	}

	@Override
	public int updatePosition(int menuId, int position) throws Exception {
		return dao.updatePosition(menuId, position);
	}

	

	
	
}
