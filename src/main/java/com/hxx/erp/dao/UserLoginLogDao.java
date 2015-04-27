package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.UserLoginLog;

public interface UserLoginLogDao extends BaseDao<UserLoginLog> {
	public List<UserLoginLog> queryListByPage(Map<String,Object> params) throws Exception;

}
