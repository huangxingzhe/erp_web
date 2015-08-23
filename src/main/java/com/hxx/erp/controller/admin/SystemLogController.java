package com.hxx.erp.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hxx.erp.common.Page;
import com.hxx.erp.model.OperationLog;
import com.hxx.erp.model.OrderInfo;
import com.hxx.erp.model.UserLoginLog;
import com.hxx.erp.service.OperationLogService;
import com.hxx.erp.service.UserLoginLogService;

@Controller
@RequestMapping("/admin/log")
public class SystemLogController {
	Log log = LogFactory.getLog(this.getClass());
	@Autowired
	private UserLoginLogService service;
	@Autowired
	private OperationLogService opService;
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		String account = request.getParameter("account");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String currentPage = request.getParameter("currentPage");
		String pageCount = request.getParameter("pageCount");
		Map<String,Object> params = new HashMap<String,Object>();
		Page<UserLoginLog> page = new Page<UserLoginLog>();
		if(!StringUtils.isEmpty(pageCount)){
			page.setPageCount(Integer.valueOf(pageCount));
		}
		if(!StringUtils.isEmpty(currentPage)){
			page.setCurrentPage(Integer.valueOf(currentPage));
		}
		params.put("page", page);
		params.put("account", account);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		try {
			List<UserLoginLog> logs = service.queryListByPage(params);
			model.addAttribute("logs", logs);
			model.addAttribute("account", account);
			model.addAttribute("startTime", startTime);
			model.addAttribute("endTime", endTime);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/log/login_log";
	}
	
	@RequestMapping("/opLogList")
	public String opLogList(HttpServletRequest request,Model model){
		String account = request.getParameter("account");
		String item = request.getParameter("item");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String currentPage = request.getParameter("currentPage");
		String pageCount = request.getParameter("pageCount");
		Map<String,Object> params = new HashMap<String,Object>();
		Page<OperationLog> page = new Page<OperationLog>();
		if(!StringUtils.isEmpty(pageCount)){
			page.setPageCount(Integer.valueOf(pageCount));
		}
		if(!StringUtils.isEmpty(currentPage)){
			page.setCurrentPage(Integer.valueOf(currentPage));
		}
		params.put("page", page);
		params.put("item", item);
		params.put("account", account);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		try {
			List<OperationLog> logs = opService.queryListByPage(params);
			model.addAttribute("logs", logs);
			model.addAttribute("account", account);
			model.addAttribute("item", item);
			model.addAttribute("startTime", startTime);
			model.addAttribute("endTime", endTime);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/log/operation_log";
	}
	

}
