package com.hxx.erp.common;



import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
public class AppContextUtil implements ServletContextListener{
	private Log log = LogFactory.getLog(this.getClass());
	private static WebApplicationContext springContext;
	public AppContextUtil(){
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		 springContext = WebApplicationContextUtils.getWebApplicationContext(event.getServletContext());
		 log.info("context init...");
	}
		 
	public static ApplicationContext getAppContext() {
	        return springContext;
	}
	 
	 public static Object getBean(String beanName){
		return getAppContext().getBean(beanName);
	 }
	 
 

}
