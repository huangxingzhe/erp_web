package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.UserLoginLog;

public interface UserLoginLogService extends BaseService<UserLoginLog> {
	
	public List<UserLoginLog> queryListByPage(Map<String,Object> params) throws Exception;

}
