package com.hxx.erp.controller.admin;

import java.util.List;

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

import com.hxx.erp.model.Privilege;
import com.hxx.erp.service.PrivilegeService;


@Controller
@RequestMapping("/admin/privilege")
public class PriviegeController{
	private static Log log = LogFactory.getLog(PriviegeController.class);
	@Autowired
	private PrivilegeService service;

	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				Privilege privilege = service.get(Integer.valueOf(id));
				model.addAttribute("privilege", privilege);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/privilege/add";
	}
	
	@RequestMapping("/list")
	public String list(Model model){
		try {
			List<Privilege> privilege = service.queryList();
			model.addAttribute("privileges", privilege);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/privilege/list";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Privilege privilege){
		int ret = 0;
		try {
			if(privilege.getId() == 0){
				service.add(privilege);
			}else{
				service.update(privilege);
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
