package com.hxx.erp.controller.admin;

import java.util.ArrayList;
import java.util.Date;
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

import com.hxx.erp.common.Constant;
import com.hxx.erp.common.Page;
import com.hxx.erp.model.Role;
import com.hxx.erp.model.UserInfo;
import com.hxx.erp.model.UserRole;
import com.hxx.erp.service.RoleService;
import com.hxx.erp.service.UserInfoService;
import com.hxx.erp.util.MD5Util;

@Controller
@RequestMapping("/admin/user")
public class UserInfoController extends BaseController{
	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private UserInfoService service;
	
	@Autowired
	private RoleService roleService;
	
	
	@RequestMapping("/init")
	public String init(HttpServletRequest request,Model model){
		try {
			String id = request.getParameter("id");
			if(!StringUtils.isEmpty(id)){
				UserInfo user = service.get(Integer.valueOf(id));
				model.addAttribute("user", user);
			}
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/user/add";
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public int add(@ModelAttribute UserInfo userInfo,HttpServletRequest request){
		int ret = 0;
		try {
			UserInfo user = service.query(userInfo);
			if(user != null  && user.getId() != userInfo.getId()){
				ret = 2 ; //该记录已存在
			}else{
				String cusId = request.getParameter("customerId");
				int customerId;
				if(StringUtils.isEmpty(cusId)){
					customerId = getCustomer(request);
				}else{
					customerId = Integer.valueOf(cusId);
				}
				if(customerId == -1){
					userInfo.setType(1);//管理员
				}
				if(!StringUtils.isEmpty(userInfo.getPassword())){
					String passMD5 = MD5Util.getHexMD5Str(userInfo.getPassword());
					userInfo.setPassword(passMD5);
				}
				if(userInfo.getId() == 0){
					userInfo.setCreateTime(new Date());
					service.add(userInfo);
				}else{
					user = service.get(userInfo.getId());
					userInfo.setCreateTime(user.getCreateTime());
					userInfo.setType(user.getType());
					if(StringUtils.isEmpty(userInfo.getPassword())){
						userInfo.setPassword(user.getPassword());
					}
					service.update(userInfo);
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
		int customerId = getCustomer(request);
		String account = request.getParameter("account");
		String phone = request.getParameter("phone");
		String status = request.getParameter("status");
		String currentPage = request.getParameter("currentPage");
		String pageCount = request.getParameter("pageCount");
		Map<String,Object> params =  new HashMap<String,Object>();
		params.put("account", account);
		params.put("phone", phone);
		if(!StringUtils.isEmpty(status)){
			params.put("status", Integer.valueOf(status));
		}
		if(customerId!=-1 && customerId != 0){
			params.put("customerId", customerId);
		}
		try {
			Page<UserInfo> page = new Page<UserInfo>();
			if(!StringUtils.isEmpty(pageCount)){
				page.setPageCount(Integer.valueOf(pageCount));
			}
			if(!StringUtils.isEmpty(currentPage)){
				page.setCurrentPage(Integer.valueOf(currentPage));
			}
			params.put("page", page);
			List<UserInfo> users = service.queryListByPage(params);
			model.addAttribute("users", users);
			model.addAttribute("page",page);
			model.addAttribute("account",account);
			model.addAttribute("phone",phone);
			model.addAttribute("status",status);
		} catch (Exception e) {
			log.error("",e);
		}
		
		return "/admin/user/list";
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
	
	@RequestMapping("/bindRole")
	public String bindRole(@RequestParam int id,HttpServletRequest request,Model model){
		try {
			int customerId = getCustomer(request);
			UserInfo user = service.get(id);
			Map<String,Object> params = new HashMap<String,Object>();
			if(customerId!=-1){
				params.put("customerId", customerId);
			}
			params.put("userId", id);
			List<Role> roles = roleService.queryAll(params);
			model.addAttribute("user", user);
			model.addAttribute("roles", roles);
		} catch (Exception e) {
			log.error("", e);
		}
		
		return "/admin/user/bind_role";
	}
	
	@RequestMapping("/addUserRole")
	@ResponseBody
	public int updateUserRole(HttpServletRequest request,Model model){
		int ret = 0;
		try {
			String userId = request.getParameter("id");
			String[] roles = request.getParameterValues("roleIds");
			if(!StringUtils.isEmpty(userId)&&roles.length>0){
				List<UserRole> ur = new ArrayList<UserRole>();
				int uid = Integer.valueOf(userId);
				for(int i=0;i<roles.length;i++){
					UserRole role = new UserRole(uid,Integer.valueOf(roles[i]));
					ur.add(role);
				}
				roleService.deleteUserRole(uid);
				roleService.addUserRole(ur);
				ret =1;
			}
			
		} catch (Exception e) {
			log.error("", e);
		}
		return ret;
	}
	
	@RequestMapping("/editPass")
	public String editPass(){
		return "/admin/user/update_pass";
	}
	
	@RequestMapping("/updatePass")
	@ResponseBody
	public int updatePass(HttpServletRequest request){
		int ret = 0;
		String oldPass = request.getParameter("password");
		String newPass = request.getParameter("newPass");
		String rePass = request.getParameter("rePass");
		if(StringUtils.isEmpty(oldPass)||StringUtils.isEmpty(newPass)||
				StringUtils.isEmpty(rePass)||!newPass.equals(rePass)){
			return ret;
		}
		int userId = (Integer)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ID);
		if(userId != 0){
			try {
				UserInfo user = service.get(userId);
				if(user != null){
					String pass = MD5Util.getHexMD5Str(oldPass);
					if(user.getPassword().equals(pass)){
						user.setPassword(MD5Util.getHexMD5Str(newPass));
						service.update(user);
						ret = 1;
					}
				}
			} catch (Exception e) {
				log.error("",e);
			}
		}
		return ret;
	}
	
}
