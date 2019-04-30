package com.EStudy.manager;

import com.EStudy.model.UserDetails;
import com.mongodb.BasicDBObject;

/**
 * Created by praveen on 14/4/19.
 */
public class UserDetailsManager {
    MongoPersistenceManager pm = null;

    public UserDetailsManager(){
        pm = MongoPersistenceManager.getInstance();
    }

    public int  checkExistsCount(String collectionName,BasicDBObject query){
        int count = pm.getCountOfCollection(collectionName,query);
        return count;
    }

    public Boolean checkUserDetails(String userName,String password){
        Boolean isExists = false;
        if(userName!=null && !userName.isEmpty() && password != null && !password.isEmpty()){
             BasicDBObject searchQuery = new BasicDBObject("userName",userName).append("password",password);
            System.out.println("Search query is :::::::: "+searchQuery);
            int count = checkExistsCount(UserDetails.class.getSimpleName(),searchQuery);
            System.out.println("Count ::::::::::::::"+count);
            if(count>0){
                isExists = true;
            }
        }
        return  isExists;
    }


}
