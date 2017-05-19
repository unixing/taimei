
package org.ldd.ssm.crm.listener;

import java.io.File;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


/**
 * 服务监听类，服务启动成功后执行，application中存放上一次的版本
 * @Title:ApplicationStartListener 
 * @Description:
 * @author taimei-gds 
 * @date 2017-2-15 下午4:35:00
 */
public class ApplicationStartListener implements ServletContextListener{
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		File newFile = new File(arg0.getServletContext().getRealPath("/")+"css");
		String version = "";
		File [] files =newFile.listFiles();
		for (File file : files) {
			if(file.getName().contains("css")){
				version = file.getName().replace("css", ""); 
			}
		}
		arg0.getServletContext().setAttribute("versionn",version);
	}
	
}