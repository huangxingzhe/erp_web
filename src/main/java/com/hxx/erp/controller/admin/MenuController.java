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

import com.hxx.erp.model.Menu;
import com.hxx.erp.service.MenuService;

@Controller
@RequestMapping("/admin/menu")
public class MenuController extends BaseController{
	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private MenuService service;
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				Menu menu = service.get(Integer.valueOf(id));
				model.addAttribute("menu", menu);
			}
			Map<String,Object> params =  new HashMap<String,Object>();
			params.put("level",1);
			List<Menu> menus = null;
			menus = service.queryList(params);
			model.addAttribute("menus", menus);
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/menu/add";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute Menu menu){
		int ret = 0;
		try {
			if(menu.getId() == 0){
				if(menu.getPid() == 0){
					menu.setLevel(1);
				}else{
					menu.setLevel(2);
				}
				menu.setStatus(1);
				service.add(menu);
			}else{
				service.update(menu);
			}
			ret = 1;//操作成功
		} catch (Exception e) {
			log.error("",e);
		}
		return ret;
	}
	
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,Model model){
		try {
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("level",1);
			List<Menu> menus = service.queryList(params);
			for(Menu m : menus){
				params.clear();
				params.put("pid", m.getId());
				m.setChilds(service.queryList(params));
			}
			model.addAttribute("menus", menus);
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/menu/list";
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
	public int deleteAll(@RequestParam String ids){
		int ret = 0;
		try {
			if(!StringUtils.isEmpty(ids)){
				String idArr[] = ids.split(",");
				for(int i=0 ;i<idArr.length; i++){
					service.delete(Integer.valueOf(idArr[i]));
				}
				ret = 1;
				log.debug("batch delete success,ids:"+ids);
			}
		}catch (Exception e) {
			log.error("batch delete  failed",e);
		}
		return ret;
	}
	
	@RequestMapping("/updatePosition")
	@ResponseBody
	public int updatePosition(HttpServletRequest request){
		int ret = 0;
		String[] menuIds = request.getParameterValues("menuIds");
		String[] positions = request.getParameterValues("positions");
		if(!StringUtils.isEmpty(menuIds)&&!StringUtils.isEmpty(positions)){
			if(menuIds.length == positions.length){
				try {
					for(int i=0;i<menuIds.length;i++){
						service.updatePosition(Integer.valueOf(menuIds[i]),Integer.valueOf(positions[i]));
					}
					ret = 1;
				} catch (Exception e) {
					log.error("", e);
				}
			}
		}
		return ret;
	}
	
}
