package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.UserInfo;

public interface UserInfoService extends BaseService<UserInfo> {
	
	public List<UserInfo> queryListByPage(Map<String,Object> params) throws Exception;

}
