package com.hxx.erp.controller.admin;

import java.util.ArrayList;
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
import com.hxx.erp.model.Menu;
import com.hxx.erp.model.Role;
import com.hxx.erp.model.RoleMenu;
import com.hxx.erp.model.RolePrivilege;
import com.hxx.erp.model.UserInfo;
import com.hxx.erp.service.MenuService;
import com.hxx.erp.service.PrivilegeService;
import com.hxx.erp.service.RolePrivilegeService;
import com.hxx.erp.service.RoleService;

@Controller
@RequestMapping("/admin/role")
public class RoleController extends BaseController{
	Log log = LogFactory.getLog(this.getClass());
	@Autowired
	private RoleService service;
	@Autowired
	private RolePrivilegeService rolePriService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private PrivilegeService priService;
	
	@RequestMapping("/init")
	public String init(@RequestParam int id,Model model){
		try {
			if(id != 0){
				Role role = service.get(id);
				model.addAttribute("role", role);
			}
			} catch (Exception e) {
				log.error("",e);
			}
		return "/admin/role/add";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Role role,HttpServletRequest request){
		int ret = 0;
		try {
			Role r = service.query(role);
			if(r != null  && r.getId() != role.getId()){
				ret = 2 ; //该记录已存在
			}else{
				if(role.getId() == 0){
					service.add(role);
				}else{
					service.update(role);
				}
				ret = 1;//操作成功
			}
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		String name = request.getParameter("name");
		String currentPage = request.getParameter("currentPage");
		String pageCount = request.getParameter("pageCount");
		Map<String,Object> params =  new HashMap<String,Object>();
		params.put("name", name);
		try {
			Page<UserInfo> page = new Page<UserInfo>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			params.put("page", page);
			List<Role> roles = service.queryListByPage(params);
			model.addAttribute("roles", roles);
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/role/list";
	}
	
	@RequestMapping("/initRoleMenu")
	public String initRoleMenu(HttpServletRequest request,Model model){
		String id = request.getParameter("id");
		try {
			Role role = service.get(Integer.valueOf(id));
			Map<String,Object> params =  new HashMap<String,Object>();
			params.put("level",1);
			params.put("roleId",role.getId());
			List<Menu> menus = null;
			menus = menuService.queryMenuByRole(params);
			for(Menu m : menus){
				params.clear();
				params.put("pid", m.getId());
				params.put("roleId",role.getId());
				List<Menu> subMenu = menuService.queryMenuByRole(params);
				for(Menu me:subMenu){
					params.clear();
					params.put("menuId", me.getId());
					params.put("roleId", role.getId());
					me.setPris(priService.queryPrivilegeByRoleIdAndMenuId(params));
				}
				m.setChilds(subMenu);
			}
			model.addAttribute("menus", menus);
			model.addAttribute("role", role);
				
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/role/role_menu";
	}
	
	
	@RequestMapping("/addRoleMenu")
	@ResponseBody
	public int addRoleMenu(HttpServletRequest request,Model model){
		String[] menuIds = request.getParameterValues("menuIds");
		String[] menuPriIds = request.getParameterValues("menuPriIds");
		String id = request.getParameter("id");
		int ret = 0 ;
		try {
			if(!StringUtils.isEmpty(id)){
				//添加角色菜单
				int roleId = Integer.valueOf(id);
				if(!StringUtils.isEmpty(menuIds)){
					List<RoleMenu> list = new ArrayList<RoleMenu>();
					for(int i=0;i<menuIds.length;i++){
						RoleMenu rm = new RoleMenu(roleId, Integer.valueOf(menuIds[i]));
						list.add(rm);
					}
					service.deleteRoleMenu(roleId);
					service.addRoleMenu(list);
				}
				//添加角色下的菜单权限
				if(!StringUtils.isEmpty(menuPriIds)){
					List<RolePrivilege> rps = new ArrayList<RolePrivilege>();
					for(int i=0;i<menuPriIds.length;i++){
						RolePrivilege rp = new RolePrivilege(roleId, Integer.valueOf(menuPriIds[i]));
						rps.add(rp);
					}
					Map<String,Object> params = new HashMap<String, Object>();
					params.put("roleId", roleId);
					rolePriService.deleteRolePrivilegeId(params);
					rolePriService.addBatch(rps);
				}
				ret = 1;
			}
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
	
	@RequestMapping("/deleteAll")
	@ResponseBody
	public String deleteAll(@RequestParam String ids){
		String ret = "0";
		try {
			if(!StringUtils.isEmpty(ids)){
				String idArr[] = ids.split(",");
				for(int i=0 ;i<idArr.length; i++){
					service.delete(Integer.valueOf(idArr[i]));
				}
				ret = "1";
				log.debug("batch delete success,ids:"+ids);
			}
		}catch (Exception e) {
			log.error("batch delete  failed",e);
		}
		return ret;
	}
}
