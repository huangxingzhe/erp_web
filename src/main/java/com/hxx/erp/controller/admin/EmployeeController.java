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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hxx.erp.common.Page;
import com.hxx.erp.model.Employee;
import com.hxx.erp.model.Provider;
import com.hxx.erp.service.EmployeeService;
import com.hxx.erp.util.DateUtil;

@Controller
@RequestMapping("/admin/employee")
public class EmployeeController {
	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private EmployeeService service;

	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				Employee employee = service.get(Integer.valueOf(id));
				model.addAttribute("employee", employee);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/user/employee_add";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			Page<Employee> page = new Page<Employee>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("page", page);
			List<Employee> employees = service.queryListByPage(params);
			model.addAttribute("employees", employees);
			model.addAttribute("page",page);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/user/employee_list";
	}
	
	@RequestMapping("/dialog")
	public String dialog(HttpServletRequest request,Model model){
		try {
			String type = request.getParameter("type");
			String keyword = request.getParameter("keyword");
			String currentPage = request.getParameter("currentPage");
			String pageCount = "5";
			Page<Provider> page = new Page<Provider>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("page", page);
			params.put("type", type);
			params.put("keyword", keyword);
			params.put("status", 1);
			List<Employee> employees = service.queryListByPage(params);
			model.addAttribute("employees", employees);
			if(page.getTotalPage()>1){
				model.addAttribute("page",page);
			}
			model.addAttribute("type",type);
			model.addAttribute("keyword",keyword);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/user/dialog_employee_list";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Employee employee,HttpServletRequest request){
		int ret = 0;
		try {
			String entryTime = request.getParameter("entryTime");
			if(!StringUtils.isEmpty(entryTime)){
				employee.setEntryDate(DateUtil.formatDayTime(entryTime));
			}
			if(employee.getId() == 0){
				service.add(employee);
			}else{
				service.update(employee);
			}
			ret = 1;//操作成功
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	
	@RequestMapping("/delete")
	@ResponseBody
	public String delete(@RequestParam int id){
		String ret = "0";
		try {
			int result = service.delete(id);
			if(result == 1){
				ret = "1";
			}
		} catch (Exception e) {
			log.error("delete failed...",e);
		}
		return ret;
	}
	
}
