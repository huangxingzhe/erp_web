package com.hxx.erp.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

public class AuthFilter implements Filter {
	Log log = LogFactory.getLog(this.getClass());

	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		
	}

	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute(Constant.SESSION_LOGIN_ADMIN_ID);
		if(obj == null){
			String uri = request.getRequestURI();
			String loginUrl = "/login/index.do";
			if(uri.contains(loginUrl)){
				return true;
			}else{
				String path = request.getContextPath()+loginUrl;
				response.sendRedirect(path);
				return true;
			}
		}
		return true;
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse rsp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)rsp;
		HttpSession session = request.getSession();
		Object obj = session.getAttribute(Constant.SESSION_LOGIN_ADMIN_ID);
		if(obj == null){
			 String loginUrl = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/login/logout.do";
			 response.sendRedirect(loginUrl);
			 return;
		}else{
			 chain.doFilter(req, rsp);
	         return;
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	
	

}
