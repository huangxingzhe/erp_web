package com.hxx.erp.dao;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.EmpCutSetting;

public interface EmpCutSettingDao extends BaseDao<EmpCutSetting>{
	public List<EmpCutSetting> queryListByPage(Map<String,Object> params) throws Exception;

}
