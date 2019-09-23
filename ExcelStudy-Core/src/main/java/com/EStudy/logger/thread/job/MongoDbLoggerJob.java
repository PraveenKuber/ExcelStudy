package com.EStudy.logger.thread.job;

import com.EStudy.manager.MongoPersistenceManager;

import java.util.concurrent.Callable;

/**
 * Created by naveen on 9/10/15.
 */
public class MongoDbLoggerJob implements Callable<String>{
    private Throwable e;
    private MongoPersistenceManager pm;
    public MongoDbLoggerJob(Throwable e) {
        this.e = e;
        this.pm = MongoPersistenceManager.getInstance();
    }
    public String call() throws Exception {
       /* Config config = Config.getInstance();
        Alarm alarm = new Alarm();
        alarm.set_id(((BusinessException) e).getAlarmId());
        IErrorCode errorCode = ((BusinessException) e).getErrorCode();
        if(errorCode!=null) {
            alarm.setErrorCode(errorCode.getErrorCode());
        }
        alarm.setMessage(e.toString());
        alarm.setDate(((BusinessException) e).getDate().toString());
        alarm.setModule(config.getConfig("avanseus.app.name"));
        Gson gson = new Gson();
        String jsonString = gson.toJson(alarm, Alarm.class);
        Map<String, Object> auditData = gson.fromJson(jsonString,Map.class);
        pm.insertBasicDBObject("ALARM",new BasicDBObject(auditData));*/
        return "done";
    }
}
