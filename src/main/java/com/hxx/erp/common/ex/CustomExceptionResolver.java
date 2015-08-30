package com.hxx.erp.common.ex;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import com.hxx.erp.common.FastJsonUtil;

public class CustomExceptionResolver extends SimpleMappingExceptionResolver{
	private Log logger = LogFactory.getLog(this.getClass());

	@Override
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
		logger.error("系统错误", ex);
		String msg = "";
		if (isAjaxRequest(request)) {// ajax 请求
			try {
				ajaxError(ex,response);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return new ModelAndView();
		} else {// 表单请求、jsp请求、普通跳转
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("msg", msg);
			param.put("detailMsg", ex.getMessage());
			String viewName = this.determineViewName(ex, request);// 获取配置的错误页面
			if (null == viewName) {
				viewName = "error";
			}
			request.setAttribute("msg", msg);
			return new ModelAndView("forward:/" + viewName, param);
		}
	}

	/**
	 * 0 system error 1 success 2params error
	 * @param ex
	 * @param response
	 * @throws IOException
	 */
	public static void ajaxError(Exception ex, ServletResponse response) throws IOException {
		headerResponse(response);
		if (ex instanceof RuntimeException) {
			response.getWriter().write(FastJsonUtil.toJson("0"));
		} else {
			Throwable throwable = ex.getCause();
			if (null != throwable && throwable instanceof RuntimeException) {
				response.getWriter().write(FastJsonUtil.toJson("0"));
			} else {
				response.getWriter().write(FastJsonUtil.toJson("0"));
			}
		}
	}
	
	private static void headerResponse(ServletResponse response) {
		response.setContentType("text/plain;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
	}
	
	public boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("X-Requested-With");
		boolean isAjax = "XMLHttpRequest".equals(header) ? true : false;
		return isAjax;
	}

}
