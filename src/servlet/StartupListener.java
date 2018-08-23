package servlet;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import dbutil.CacheHandler;

public class StartupListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		System.out.println("<<<<<<<<< APPLICATION STARTED >>>>>>>>>");
		ServletContext context = servletContextEvent.getServletContext();
		try 
		{
			String categoriesXmlFile = context.getRealPath("/data/Categories.xml");
			System.out.println("<<<<<<<<< APPLICATION STARTED1 >>>>>>>>>");
			CacheHandler.buildCacheFromDatabase(categoriesXmlFile);
		}
		catch(Exception e) {
			
			System.out.println("Can't find file:"+e.getMessage());
		}
		
		//System.out.println(CacheHandler.getCategories());
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
		System.out.println("<<<<<<<<< APPLICATION STOPPED >>>>>>>>>");
	}
}
