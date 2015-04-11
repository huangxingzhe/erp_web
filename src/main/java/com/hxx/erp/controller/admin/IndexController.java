package com.hxx.erp.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.LocaleEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.hxx.erp.common.Constant;
import com.hxx.erp.model.Menu;
import com.hxx.erp.service.MenuService;
import com.hxx.erp.service.RoleService;



@Controller
@RequestMapping("/admin/")
public class IndexController {
	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private RoleService roleService;

	@RequestMapping("/index")
	public String index(){
		return "/admin/index";
	}
	
	@RequestMapping("/top")
	public String top(HttpServletRequest request,Model model){
		int userId = (Integer)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ID);
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("level",1);
		try {
			List<Menu> menus = null;
			params.put("userId",userId);
			menus = menuService.queryMenuByUser(params);
			model.addAttribute("menus", menus);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/top";
	}
	
	@RequestMapping("/menu")
	public String menu(HttpServletRequest request,Model model){
		int userId = (Integer)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ID);
		Map<String,Object> params =  new HashMap<String,Object>();
		params.put("level",1);
		try {
			List<Menu> menus = null;
			params.put("userId",userId);
			menus = menuService.queryMenuByUser(params);
			if(menus!=null && menus.size()>0){
				model.addAttribute("menu", menus.get(0));
				params.clear();
				params.put("userId",Integer.valueOf(userId));
				params.put("pid",menus.get(0).getId());
				menus = menuService.queryMenuByUser(params);
			}
			model.addAttribute("menus", menus);
			
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/menu";
	}
	
	@RequestMapping("/right")
	public String right(){
		return "/admin/right";
	}
	
	@RequestMapping("/getMenusById")
	public String getMenusById(@RequestParam int id,HttpServletRequest request,Model model){
		int userId = (Integer)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ID);
		Map<String,Object> params = new HashMap<String,Object>();
		try {
			List<Menu> menus = null;
			params.put("userId",Integer.valueOf(userId));
			params.put("pid",id);
			menus = menuService.queryMenuByUser(params);
			Menu menu = menuService.get(id);
			model.addAttribute("menus", menus);
			model.addAttribute("menu", menu);
		} catch (Exception e) {
			log.error("",e);
		}
		return "/admin/menu";
	}
	
	/**
	 * 动态修改语言配置
	 * @param lang
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/changeLang")
	@ResponseBody
	public String changeLanguage(@RequestParam String lang,HttpServletRequest request,
			HttpServletResponse response) {
		String msg = "error";
		try {
			LocaleResolver localeResolver = RequestContextUtils
					.getLocaleResolver(request);
			if (localeResolver == null) {
				throw new IllegalStateException(
						"No LocaleResolver found: not in a DispatcherServlet request?");
			}
			LocaleEditor localeEditor = new LocaleEditor();
			localeEditor.setAsText(lang);
			localeResolver.setLocale(request, response,(Locale) localeEditor.getValue());
			msg = "success";
		} catch (Exception ex) {
			msg = "error";
		}
		return msg;
	}
}
