package com.EStudy.config;

import java.util.Properties;

/**
 * Created by Praveen
 */

public class Config {
    private static Config config = null;
    private static Properties properties = null;

    private Config(){
        properties = new Properties();
    }

    /**
     * This method returns on instance of Config.
     * Using Config object, getConfig method can be used to fetch the config values
     * @return Config
     */
    public static Config getInstance() {
        if(config==null) {
            config = new Config();
        }
        return config;
    }

    public void setConfig(Properties property) {
        properties = property;
    }


    public void addConfig(String key, String value) {
        properties.put(key, value);
    }

    /**
     * This method helps to fetch configuration values when a key is passed.
     * @param key - String
     * @return Config value - String
     */
    public String getConfig(String key) {
        if(properties.containsKey(key)) {
            return (String) properties.get(key);
        } else {
            System.out.println("Key ::::::::::::"+key);
            return null;
        }

    }
}
