package com.EStudy.manager;

import com.EStudy.model.UserDetails;
import com.google.gson.Gson;
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


    public void insertUserDetails(UserDetails userDetails){
         Gson gson = new Gson();
         BasicDBObject insertQuery = BasicDBObject.parse(gson.toJson(userDetails));
         pm.insertBasicDBObject(UserDetails.class.getSimpleName(),insertQuery);
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

    public Boolean checkUserNameExists(String userName){
        Boolean isExists = false;
        if(userName!=null && !userName.isEmpty()){
            BasicDBObject searchQuery = new BasicDBObject("userName",new BasicDBObject("$regex",userName).
                    append("$options","i"));
            System.out.println("Search query is :::::::: "+searchQuery);
            int count = checkExistsCount(UserDetails.class.getSimpleName(),searchQuery);
            System.out.println("Count ::::::::::::::"+count);
            if(count>0){
                isExists = true;
            }
        }
        return  isExists;
    }

    public static void main(String[] args) {
        UserDetailsManager userDetailsManager = new UserDetailsManager();
        //System.out.println("test:::"+userDetailsManager.checkUserNameExists("Praveen1"));
        UserDetails test = new UserDetails();
        test.setGender("male");
        test.setPhoneNumber("010101010");
        test.setEmailId("test");
        test.setPassword("test");
        test.setUserName("test");
        userDetailsManager.insertUserDetails(test);
    }




}
