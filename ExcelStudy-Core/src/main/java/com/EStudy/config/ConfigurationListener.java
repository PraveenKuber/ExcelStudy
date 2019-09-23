package com.EStudy.config;

import com.EStudy.logger.thread.job.LoggerThreadPool;
import org.apache.log4j.DailyRollingFileAppender;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.io.*;
import java.util.Properties;

/**
 * Created by naveen on 8/10/15.
 */
public class ConfigurationListener implements ServletContextListener {
    private LoggerThreadPool loggerThreadPool;

    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext servletContext = servletContextEvent.getServletContext();
        try {
            Config config = initialiseConfig(servletContext);
            log4jConfiguration(config);
            initiateLogThreadPool();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Config initialiseConfig(ServletContext servletContext) {
        String catalinaBase = System.getProperty("catalina.base");
        Properties properties = new Properties();
        Config config = Config.getInstance();
        InputStream inputStream = null;
        String app = servletContext.getContextPath().substring(1);
        OutputStream out = null;
        try {
            inputStream = new FileInputStream(new File(catalinaBase+"/config.properties"));
            properties.load(inputStream);
            addMiscConfigurations(servletContext, properties, app);
            String propertyFilePath = System.getProperty("catalina.base")+"/webapps/"+servletContext.getContextPath()+"/WEB-INF/classes/application.properties";
            out = new FileOutputStream(propertyFilePath);
            properties.store(out, "");
            config.setConfig(properties);

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if(inputStream!=null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(out!=null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return config;
    }

    private void addMiscConfigurations(ServletContext servletContext, Properties properties, String appName) {
        properties.put("excelStudy.app.host",properties.get("excelStudy.app."+appName.toLowerCase()+".host"));
        properties.put("excelStudy.app.domain",properties.get("excelStudy.app."+appName.toLowerCase()+".domain"));
        properties.put("excelStudy.app.name", appName);
        String rootLocation = System.getProperty("catalina.base")+"/webapps/"+servletContext.getContextPath();
        properties.put("excelStudy.app.root",rootLocation);
    }


    private void initiateLogThreadPool() {
        loggerThreadPool = LoggerThreadPool.getInstance();
    }

    private void log4jConfiguration(Config config) throws Exception {
        Logger rootLogger = Logger.getRootLogger();
        PatternLayout layout = new PatternLayout("%d %p [%c] - %m%n");
        try {
            DailyRollingFileAppender appender = new DailyRollingFileAppender(layout,config.getConfig("excelStudy.log.path")+"/"+config.getConfig("excelStudy.app.name")+"/"+config.getConfig("excelStudy.app.name")+".log","'.' yyyy-MM-dd-HH");
            rootLogger.addAppender(appender);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        loggerThreadPool.destroy();
    }
}
