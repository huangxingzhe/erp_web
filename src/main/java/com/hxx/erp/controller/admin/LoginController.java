package com.hxx.erp.controller.admin;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hxx.erp.common.Constant;
import com.hxx.erp.model.UserInfo;
import com.hxx.erp.model.UserLoginLog;
import com.hxx.erp.service.UserInfoService;
import com.hxx.erp.service.UserLoginLogService;
import com.hxx.erp.util.MD5Util;

@Controller
@RequestMapping("/login")
public class LoginController {
	Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private UserInfoService service;
	@Autowired
	private UserLoginLogService logService;
	
	@RequestMapping("/login")
	@ResponseBody
	public int login(@ModelAttribute UserInfo userInfo,HttpServletRequest request){
		int ret = 0;
		try {
			UserInfo user = service.query(userInfo);
			if(user != null){
				String pass = MD5Util.getHexMD5Str(userInfo.getPassword());
				if(user.getPassword().equals(pass)){
					HttpSession session = request.getSession();
					session.setAttribute(Constant.SESSION_LOGIN_ADMIN_ID, user.getId());
					session.setAttribute(Constant.SESSION_LOGIN_ADMIN_ACCOUNT, user.getAccount());
					session.setAttribute(Constant.SESSION_LOGIN_ADMIN_NAME, user.getName());
					ret = 1;//登录成功
					log.info("login success...");
					
					//添加日志
					UserLoginLog loginLog = new UserLoginLog();
					loginLog.setAccount(user.getAccount());
					UserLoginLog userLog = logService.query(loginLog);
					if(userLog==null){
						loginLog.setLastIp(getIpAddr(request));
						loginLog.setUpdateIp(getIpAddr(request));
						loginLog.setLastTime(new Date());
						loginLog.setUpdateTime(new Date());
						loginLog.setNum(1);
						logService.add(loginLog);
					}else{
						userLog.setLastIp(userLog.getUpdateIp());
						userLog.setUpdateIp(getIpAddr(request));
						userLog.setLastTime(userLog.getUpdateTime());
						userLog.setUpdateTime(new Date());
						userLog.setNum(userLog.getNum()+1);
						logService.update(userLog);
					}
					
				}else{
					ret = 2; //密码不对
					log.info("login failed,password is error...");
				}
			}else{
				ret = 3; //账号不对
				log.info("login failed,account is error...");
			}
			
			
		} catch (Exception e) {
			log.error("login failed...",e);
		}
		
		return ret;
	}
	
	@RequestMapping("/index")
	public String index(){
		return "/admin/login";
	}
	
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		request.getSession().invalidate();
		log.info("logout success...");
		return "/admin/logout";
	}
	
	//获得各用户的ip地址
	private String getIpAddr(HttpServletRequest request) { 
	    String ip = request.getHeader("x-forwarded-for"); 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	        ip = request.getHeader("Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	        ip = request.getHeader("WL-Proxy-Client-IP"); 
	    } 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
	        ip = request.getRemoteAddr(); 
	    } 
	    return ip; 
	}

	
}
