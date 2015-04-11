package com.hxx.erp.controller.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;

import com.hxx.erp.common.Constant;

//
public class BaseController {
	
	@Autowired
	protected MessageSource messageSource;
	
	public int getCustomer(HttpServletRequest request){
		Object obj = request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_CUSTOMERID);
		if(obj != null){
			return Integer.valueOf(String.valueOf(obj));
		}
		return 0;
	}
}
