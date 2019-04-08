package com.EStudy.manager;


public class TextToSpeech
{

    public static void main(String[] args)
    {
        Double test = 0.81;
        String testString = Double.toString(test);
        System.out.println("Value is::::::::::"+testString);
        String gte = testString.substring(testString.indexOf(".")+1,testString.length()-1);
        String lte = testString.substring(testString.length()-1,testString.length());
        System.out.println("Values ::::::::::"+gte+"::::::::::"+lte+"length is ::::::"+testString.length());
    }


}
