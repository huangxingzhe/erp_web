package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.UserInfo;

public interface UserInfoDao extends BaseDao<UserInfo> {
	
	public List<UserInfo> queryListByPage(Map<String,Object> params) throws Exception;

}
