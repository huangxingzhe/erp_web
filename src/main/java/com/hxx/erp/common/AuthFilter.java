package com.hxx.erp.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.hxx.erp.model.Privilege;
import com.hxx.erp.service.PrivilegeService;

public class AuthFilter implements Filter {
	Log log = LogFactory.getLog(this.getClass());

	
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
			 request.setCharacterEncoding("UTF-8");
			 String menuId = request.getParameter("menuId");
			 if(!StringUtils.isEmpty(menuId)){
				Integer roleId = (Integer)request.getSession().getAttribute(Constant.SESSION_LOGIN_ADMIN_ROLEID);
				PrivilegeService service = (PrivilegeService)AppContextUtil.getBean("privilegeService");
				Map<String,Object> params = new HashMap<String,Object>();
				params.put("roleId", roleId);
				params.put("menuId", Integer.valueOf(menuId));
				List<Privilege> pris;
				try {
					pris = service.query(params);
					for(Privilege p : pris){
						request.setAttribute(p.getValue(), p.getValue());
					}
					request.setAttribute("menuId", menuId);
				} catch (Exception e) {
					log.error("",e);
				}
				
			 }	
			 chain.doFilter(req, rsp);
	         return;
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void destroy() {
		
	}

}
