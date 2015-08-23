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
import com.hxx.erp.model.EmployeeProject;
import com.hxx.erp.model.Project;
import com.hxx.erp.service.EmployeeProjectService;
import com.hxx.erp.service.EmployeeService;
import com.hxx.erp.service.ProjectService;

@Controller
@RequestMapping("/admin/project")
public class ProjectController {
	Log log = LogFactory.getLog(this.getClass());

	@Autowired
	private ProjectService service;
	@Autowired
	private EmployeeProjectService epService;
	@Autowired
	private EmployeeService employeeService;

	@RequestMapping("/init")
	public String init(HttpServletRequest request, Model model) {
		try {
			String id = request.getParameter("id");
			if (!StringUtils.isEmpty(id)) {
				Project project = service.get(Integer.valueOf(id));
				model.addAttribute("project", project);
			}
		} catch (Exception e) {
			log.error("", e);
		}

		return "/admin/config/project_add";
	}

	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model) {
		try {
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			Page<Project> page = new Page<Project>();
			if (!StringUtils.isEmpty(pageCount)) {
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if (!StringUtils.isEmpty(currentPage)) {
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("page", page);
			List<Project> projects = service.queryListByPage(params);
			model.addAttribute("projects", projects);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("", e);
		}
		return "/admin/config/project_list";
	}

	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Project project) {
		int ret = 0;
		try {
			if (project.getId() == 0) {
				service.add(project);
			} else {
				service.update(project);
			}
			ret = 1;// 操作成功
		} catch (Exception e) {
			log.error("", e);
		}
		return ret;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public String delete(@RequestParam int id) {
		String ret = "0";
		try {
			int result = service.delete(id);
			if (result == 1) {
				ret = "1";
			}
		} catch (Exception e) {
			log.error("delete failed...", e);
		}
		return ret;
	}

	// 分配项目
	@RequestMapping("/distributeInit")
	public String distributeInit(EmployeeProject emppro,Model model) {
		try {
			if(emppro.getId()!=0){
				emppro = epService.get(emppro.getId());
			}
			List<Employee> employees = employeeService.queryList(null);
			List<Project> projects = service.queryList(null);
			model.addAttribute("employees", employees);
			model.addAttribute("projects", projects);
			model.addAttribute("emppro", emppro);
		} catch (Exception e) {
			log.error("", e);
		}
		return "/admin/config/distribute_add";
	}

	// 分配项目
	@RequestMapping("/distribute")
	@ResponseBody
	public String distribute(EmployeeProject emppro) {
		String ret = "0";
		try {
			if(emppro.getId()==0){
				EmployeeProject ep = epService.query(emppro);
				if (ep != null) {
					return ret = "2";
				}
			}
			if (emppro.getId() == 0) {
				epService.add(emppro);
			} else {
				epService.update(emppro);
			}
			ret = "1";
		} catch (Exception e) {
			log.error("", e);
		}
		return ret;

	}

	// 分配项目
	@RequestMapping("/distributeList")
	public String distributeList(HttpServletRequest request,Model model) {
		try {
			String currentPage = request.getParameter("currentPage");
			String pageCount = request.getParameter("pageCount");
			Page<EmployeeProject> page = new Page<EmployeeProject>();
			if (!StringUtils.isEmpty(pageCount)) {
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if (!StringUtils.isEmpty(currentPage)) {
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("page", page);
			List<Employee> employees = employeeService.queryList(null);
			List<Project> projects = service.queryList(null);
			List<EmployeeProject> emppros = epService.queryListByPage(params);
			model.addAttribute("emppros", emppros);
			model.addAttribute("employees", employees);
			model.addAttribute("projects", projects);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("", e);
		}
		return "/admin/config/distribute_list";
	}
	
	@RequestMapping("/distributeDelete")
	@ResponseBody
	public String distributeDelete(@RequestParam int id) {
		String ret = "0";
		try {
			int result = epService.delete(id);
			if (result == 1) {
				ret = "1";
			}
		} catch (Exception e) {
			log.error("delete failed...", e);
		}
		return ret;
	}

}
