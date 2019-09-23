package com.EStudy.logger;

import org.apache.log4j.AppenderSkeleton;
import org.apache.log4j.spi.LoggingEvent;
import org.apache.log4j.spi.ThrowableInformation;

/**
 * Created by naveen on 9/10/15.
 */

public class LogAppender extends AppenderSkeleton {
    @Override
    protected void append(LoggingEvent loggingEvent) {
        ThrowableInformation information = loggingEvent.getThrowableInformation();
        /*if ( information!= null && information.getThrowable() instanceof BusinessException) {
            //System.out.println("**********" + loggingEvent.getThrowableInformation().getThrowable());
            LoggerThreadPool threadPool = LoggerThreadPool.getInstance();
            ExecutorService executorService = threadPool.getExecutorService();
            MongoDbLoggerJob loggerJob = new MongoDbLoggerJob(loggingEvent.getThrowableInformation().getThrowable());
            Future<String> future = executorService.submit(loggerJob);
            try {
                future.get();
            } catch (InterruptedException e) {
                e.printStackTrace();
            } catch (ExecutionException e) {
                e.printStackTrace();
            }
        }*/
    }

    public void close() {

    }

    public boolean requiresLayout() {
        return false;
    }
}

