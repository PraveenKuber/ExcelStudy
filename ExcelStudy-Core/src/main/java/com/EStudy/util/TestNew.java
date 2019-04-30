package com.EStudy.util;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by praveen on 29/4/19.
 */
public class TestNew {

    public static void main(String[] args) {
        String audioScript = "So , I was on a roll.  I was an executive with a ice salary, annual bonuses, and stack options, all the perks. Everything was on tracks. And on Monday, January 7th, 2008at three o’clock in the afternoon";
        List<String> incorrectWords =  new ArrayList<>();
        incorrectWords.add("roll");
        incorrectWords.add("ice");
        incorrectWords.add("stack");
        incorrectWords.add("tracks");
        List<String> correctWords =  new ArrayList<>();
        correctWords.add("role");
        correctWords.add("nice");
        correctWords.add("stock");
        correctWords.add("track");

        String[] splitedValues = audioScript.split(" ");
        for(String value:splitedValues){
            value = value.replace(",","");
            value = value.replace(".","");
            if(value!=null&& !value.isEmpty()&&value!=""){
                if(incorrectWords.contains(value)){
                    int index = incorrectWords.indexOf(value);
                    String correctAnswer = correctWords.get(index);
                    System.out.println("Contained value::::::::"+value+"::::; correct answer:::::::"+correctAnswer);
                }else{
                    System.out.println("Normal span::::::::");
                }
            }
        }

    }
}
