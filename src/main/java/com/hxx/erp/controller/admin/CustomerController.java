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

import com.hxx.erp.model.Customer;
import com.hxx.erp.service.CustomerService;

@Controller
@RequestMapping("/admin/customer")
public class CustomerController {
	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private CustomerService service;

	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				Customer customer = service.get(Integer.valueOf(id));
				model.addAttribute("customer", customer);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/config/customer_add";
	}
	
	@RequestMapping("/list")
	public String list(Model model){
		try {
			List<Customer> customers = service.queryList(null);
			model.addAttribute("customers", customers);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/config/customer_list";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Customer customer){
		int ret = 0;
		try {
			if(customer.getId() == 0){
				service.add(customer);
			}else{
				service.update(customer);
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
