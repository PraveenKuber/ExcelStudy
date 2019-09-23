package com.EStudy.logger.thread.job;

import com.EStudy.config.Config;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by naveen on 9/10/15.
 */
public class LoggerThreadPool {
    private static LoggerThreadPool loggerThreadPool = null;
    private static ExecutorService executorService;
    private static int poolSize;
    private LoggerThreadPool() {
        Config config = Config.getInstance();
        try {
            poolSize = Integer.parseInt(config.getConfig("excelStudy.log.thread.poolsize"));
        } catch (Exception e) {
            e.printStackTrace();
            poolSize = 10;
        }
        executorService = Executors.newFixedThreadPool(poolSize);
    }

    public static LoggerThreadPool getInstance() {
        if(loggerThreadPool==null) {
            loggerThreadPool = new LoggerThreadPool();
        }
        return loggerThreadPool;
    }

    public void destroy() {
        if(executorService!=null) {
            executorService.shutdown();
        }
    }
    public ExecutorService getExecutorService() {
        return executorService;
    }
}
