package com.hxx.erp.service;

import java.util.List;
import java.util.Map;

import com.hxx.erp.model.EmpCutSetting;

public interface EmpCutSettingService extends BaseService<EmpCutSetting> {
	public List<EmpCutSetting> queryListByPage(Map<String,Object> params) throws Exception;

}
